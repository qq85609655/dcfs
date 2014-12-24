package com.dcfs.fam.completeCost;

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
 * @ClassName: CompleteCostAction 
 * @Description: ���񲿶��ļ�����б��ѯ�����ά������ 
 * @author panfeng 
 * @date 2014-10-22
 *  
 */
public class CompleteCostAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(CompleteCostAction.class);

    private CompleteCostHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public CompleteCostAction(){
        this.handler=new CompleteCostHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
	 * @Title: completeCostList 
	 * @Description: �ļ���ѹ����б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String completeCostList(){
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
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
				"COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","NAME","AF_COST",
				"PAID_NO","AF_COST_CLEAR","AF_COST_CLEAR_FLAG");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.completeCostList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���Ѳ�ѯ�����쳣");
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
	 * ��ת�����ά��ҳ��
	 * @author Panfeng
	 * @date 2014-10-22
	 * @return
	 */
	public String completeCostShow(){
		//1 �б�ҳ��ȡ��ϢID
		String type = getParameter("type");
		String showuuid = getParameter("showuuid", "");
		String fileno = getParameter("fileno","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ�鿴��Ϣ�����
			Data showdata = handler.getCostShow(conn, showuuid, fileno);
			//��ȡ�����˻�����Ϣ��ϵͳ����
			if("maintain".equals(type)){
				String curId = SessionInfo.getCurUser().getPerson().getPersonId();
				String curPerson = SessionInfo.getCurUser().getPerson().getCName();
				String curDate = DateUtility.getCurrentDate();
				showdata.add("AF_COST_CLEAR_USERID", curId);//������id
				showdata.add("AF_COST_CLEAR_USERNAME", curPerson);//������
				showdata.add("AF_COST_CLEAR_DATE", curDate);//��������
			}
			//4 ��������鿴ҳ��
			setAttribute("data", showdata);
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
		if ("show".equals(type)) {
			return "show";
		} else if ("maintain".equals(type)) {
			return "maintain";
		} else {
			return SUCCESS;
		}
	}
	
	/**
	 * �鿴�ɷѵ�
	 * @author panfeng
	 * @date 2014-12-10
	 * @return
	 */
	public String billShow(){
		//1 ��ȡ�������
		String PAID_NO = getParameter("PAID_NO","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ�鿴��Ϣ�����
			Data showdata = handler.getBillShow(conn, PAID_NO);
			//4 ��������鿴ҳ��
			setAttribute("data", showdata);
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
	 * @Title: completeCostSave
	 * @Description:���ά���ύ
	 * @author panfeng
	 * @date 2014-10-22
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String completeCostSave(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("P_","AF_ID","AF_COST_CLEAR_REASON","AF_COST_CLEAR_USERNAME","AF_COST_CLEAR_DATE");
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            data.add("AF_COST_CLEAR", "1");//���״̬��Ϊ"�����"
            data.add("AF_COST_CLEAR_FLAG", "1");//ά����ʶ��Ϊ"��"
            success=handler.completeCostSave(conn,data);
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
                log.logError("�ύ�����쳣[�ύ����]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");//�ύʧ�� 2
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
	
	
	
}
