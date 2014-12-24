package com.dcfs.fam.checkCollection;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;

import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.hx.framework.authenticate.SessionInfo;

/** 
 * @ClassName: CheckCollectionAction 
 * @Description: ����֧Ʊ���հ��������������ѯ��֧Ʊ���ա���ӡ���յ������������յ���ѯ���� 
 * @author panfeng 
 * @date 2014-10-20
 *  
 */
public class CheckCollectionAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(CheckCollectionAction.class);

    private CheckCollectionHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public CheckCollectionAction(){
        this.handler=new CheckCollectionHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
	 * @Title: checkCollectionList 
	 * @Description: ֧Ʊ�����б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String checkCollectionList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","PAID_NO","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_WAY",
					"PAID_SHOULD_NUM","PAR_VALUE","RECEIVE_DATE_START","RECEIVE_DATE_END",
					"COLLECTION_DATE_START","COLLECTION_DATE_END","COLLECTION_USERNAME","COLLECTION_STATE");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.checkCollectionList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "֧Ʊ���ղ�ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * ��ת��֧Ʊ����ҳ��
	 * @author Panfeng
	 * @date 2014-10-20
	 * @return
	 */
	public String checkCollectionShow(){
		//1 �б�ҳ��ȡ��ϢID
		String checkuuid = getParameter("checkuuid", "");
		String num = getParameter("num", "");
		String[] uuid = checkuuid.split(",");
		String checkId = "";
		StringBuffer stringb = new StringBuffer();
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			checkId = stringb.substring(0, stringb.length() - 1);
			DataList checkList = handler.getCollectionShow(conn, checkId);
			
			//4 ��������ҳ��
			//��ȡƱ����ϼ���
			Data showdata = handler.getSum(conn, checkId);
			//��ȡ�����˻�����Ϣ��ϵͳ����
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			showdata.add("COLLECTION_USERNAME", curPerson);//������
			showdata.add("COLLECTION_DATE", curDate);//��������
			showdata.add("NUM", num);//֧Ʊ����
			
			setAttribute("data", showdata);
			setAttribute("List", checkList);
			setAttribute("CHEQUE_ID", checkuuid);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return SUCCESS;
	}
	
	
	/**
	 * @Title: checkCollectionSave
	 * @Description:֧Ʊ�����ύ
	 * @author panfeng
	 * @date 2014-10-21
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String checkCollectionSave(){
	    //1 ���ҳ������ݣ��������ݽ����
		//���յ���¼��Ϣ
        Data data = getRequestEntityData("R_","COLLECTION_USERNAME","COLLECTION_DATE","NUM","SUM");
        //Ʊ�ݵǼ���Ϣ
        String[] CHEQUE_ID = this.getParameterValues("P_CHEQUE_ID");
 		String[] COLLECTION_REMARKS = this.getParameterValues("P_COLLECTION_REMARKS");
 		
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            
            Data coldata = new Data();
            coldata.add("COL_USERNAME", (String)data.get("COLLECTION_USERNAME"));//������
            coldata.add("COL_DATE", (String)data.get("COLLECTION_DATE"));//��������
            coldata.add("NUM", (String)data.get("NUM"));//֧Ʊ����
            coldata.add("SUM", (String)data.get("SUM"));//���յ��ܽ��
            coldata=handler.checkInfoSave(conn,coldata);//�������յ���¼��
            
            for (int i = 0; i < CHEQUE_ID.length; i++) {
            	Data checkData = new Data();
            	checkData.add("CHEQUE_ID", CHEQUE_ID[i]);
            	checkData.add("CHEQUE_COL_ID", coldata.getString("CHEQUE_COL_ID"));//���յ�����
            	checkData.add("COLLECTION_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//������ID
            	checkData.add("COLLECTION_USERNAME", (String)data.get("COLLECTION_USERNAME"));//������
            	checkData.add("COLLECTION_DATE", (String)data.get("COLLECTION_DATE"));//��������
            	checkData.add("COLLECTION_REMARKS", COLLECTION_REMARKS[i]);//���ձ�ע
            	checkData.add("COLLECTION_STATE", "1");//����״̬Ϊ"������"
            	success=handler.checkCollectionSave(conn,checkData);//����Ʊ����Ϣ��
            }
            
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");//�ύ�ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ύ���������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[���ò���]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
			retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
			retValue = "error2";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * @Title: checkCollectionList 
	 * @Description: ֧Ʊ�����б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String colSearchList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="COL_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","COL_DATE_START","COL_DATE_END","COL_USERNAME","SUM_MIN","SUM_MAX","NUM");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.colSearchList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "֧Ʊ���ղ�ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * ���յ���ӡҳ��
	 * @author Panfeng
	 * @date 2014-10-22
	 * @return
	 */
	public String checkCollectionPrint(){
		//1 �б�ҳ��ȡ��ϢID
		String coluuid = getParameter("coluuid", "");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			DataList colPrintList = handler.getPrintShow(conn, coluuid);
			//��ȡ���յ���¼
			Data showdata = handler.getColShow(conn, coluuid);
			//4 ��������ҳ��
			setAttribute("data", showdata);
			setAttribute("List", colPrintList);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return SUCCESS;
	}
	
	
}
