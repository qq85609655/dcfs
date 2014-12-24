package com.dcfs.rfm.insteadRecord;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: InsteadRecordAction 
 * @Description: �ɰ칫�Ҷ����Ĵ�¼��Ϣ���в�ѯ�����Ĵ�¼���鿴����������
 * @author panfeng;
 * @date 2014-9-23 ����9:03:08 
 *
 */
public class InsteadRecordAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(InsteadRecordAction.class);

    private InsteadRecordHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;

    public InsteadRecordAction(){
        this.handler=new InsteadRecordHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: insteadRecordList 
	 * @Description: ���Ĵ�¼�б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String insteadRecordList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="APPLE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START",
					"REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","FILE_TYPE","AF_POSITION","APPLE_DATE_START",
					"APPLE_DATE_END","HANDLE_TYPE","DUAL_DATE_START","DUAL_DATE_END","RETURN_STATE");
		String MALE_NAME = data.getString("MALE_NAME",null);
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.insteadRecordList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���Ĵ�¼��Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("���Ĵ�¼��Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("InsteadRecordAction��insteadRecordList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: returnChoiceList 
	 * @Description: ���Ĵ�¼ѡ���ļ��б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String returnChoiceList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
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
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
					"FILE_TYPE","AF_POSITION","AF_GLOBAL_STATE","MATCH_STATE","COUNTRY_CODE","ADOPT_ORG_ID");
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.returnChoiceList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���Ĵ�¼ѡ���ļ���ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("���Ĵ�¼ѡ���ļ���ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("InsteadRecordAction��returnChoiceList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * ��ת�����Ĵ�¼ȷ��ҳ��
	 * @author Panfeng
	 * @date 2014-9-23 
	 * @return
	 */
	public String confirmShow(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("showuuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.confirmShow(conn, uuid);
			
			//��ȡ������֯����
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, showdata.getString("ADOPT_ORG_ID",""));
            String  syzzCnName = syzzDept.getSyzzCnName();//������֯��������
            showdata.add("NAME_CN", syzzCnName);
			
            //��ȡ��ǰ������Ϣ
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			showdata.add("APPLE_TYPE","");//��������
			showdata.add("HANDLE_TYPE","");//���Ĵ��÷�ʽ
			showdata.add("RETURN_REASON","");//����ԭ��
			showdata.add("APPLE_PERSON_ID",curId);//���루��¼����ID
			showdata.add("APPLE_PERSON_NAME",curPerson);//���루��¼����
			showdata.add("APPLE_DATE",curDate);//���루��¼������
			//4 ��������鿴ҳ��
			setAttribute("confirmData", showdata);
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
	 * @Title: insteadRecordSave 
	 * @Description: ���Ĵ�¼ȷ���ύ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String insteadRecordSave(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","AR_ID","AF_ID","FILE_NO","REGISTER_DATE","FILE_TYPE",
        			"COUNTRY_CODE","ADOPT_ORG_ID","FAMILY_TYPE","MALE_NAME","FEMALE_NAME",
        			"APPLE_PERSON_ID","APPLE_PERSON_NAME","APPLE_DATE","APPLE_TYPE","HANDLE_TYPE","RETURN_REASON");
        Data fileData = getRequestEntityData("P_","AF_POSITION");
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            fileData.add("AF_ID", (String)data.get("AF_ID"));
            fileData.add("RETURN_REASON", (String)data.get("RETURN_REASON"));//����ԭ��
            //�����ļ�λ���Ƿ��ڰ칫�Ҿ�������״̬
            String af_position = (String)fileData.get("AF_POSITION");
            if("0020".equals(af_position)){
            	fileData.add("RETURN_STATE", "1");//����״̬Ϊ"��ȷ��"(�ļ���Ϣ��)
            	data.add("RETURN_STATE","1");//����״̬Ϊ"��ȷ��"�����ļ�¼��
            	String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();//��ȡ��ǰ����
            	data.add("ORG_ID", curOrgId);//ȷ�ϲ���ID
            	data.add("PERSON_ID", (String)data.get("APPLE_PERSON_ID"));//ȷ����ID
            	data.add("PERSON_NAME", (String)data.get("APPLE_PERSON_NAME"));//ȷ����
            	data.add("RETREAT_DATE", (String)data.get("APPLE_DATE"));//ȷ��ʱ��
            	//��ʼ�������ƽ���¼���칫��-��������
            	FileCommonManager fileCommonManager = new FileCommonManager();
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", (String)data.get("AF_ID"));
            	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_BGS_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//��ʼ�������ƽ���¼
            }else{
            	fileData.add("RETURN_STATE", "0");//����״̬Ϊ"��ȷ��"(�ļ���Ϣ��)
            	data.add("RETURN_STATE","0");//����״̬Ϊ"��ȷ��"�����ļ�¼��
            }
            
            success=handler.ReturnFileSave(conn,data,fileData);
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
                        log.logError("InsteadRecordAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * �鿴������ϸ��Ϣ
	 * @author Panfeng
	 * @date 2014-9-23 
	 * @return
	 */
	public String showReturnFile(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("showuuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.confirmShow(conn, uuid);
			//��ȡ������֯����
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, showdata.getString("ADOPT_ORG_ID",""));
            String  syzzCnName = syzzDept.getSyzzCnName();//������֯��������
            showdata.add("NAME_CN", syzzCnName);
			
			//4 ��������鿴ҳ��
			setAttribute("showdata", showdata);
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
