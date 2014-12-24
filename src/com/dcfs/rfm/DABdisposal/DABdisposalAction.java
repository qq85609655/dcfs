package com.dcfs.rfm.DABdisposal;

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
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: DABdisposalAction 
 * @Description: �ɵ�������������Ϣ���в�ѯ�����á��鿴����������
 * @author panfeng;
 * @date 2014-9-25 ����7:42:16 
 *
 */
public class DABdisposalAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(DABdisposalAction.class);

    private DABdisposalHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;

    public DABdisposalAction(){
        this.handler=new DABdisposalHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	/**
	 * @Title: DABdisposalList 
	 * @Description: ���Ĵ����б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String DABdisposalList(){
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
					"REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","FILE_TYPE","APPLE_DATE_START",
					"APPLE_DATE_END","HANDLE_TYPE","RETREAT_DATE_START","RETREAT_DATE_END","RETURN_STATE",
					"DUAL_USERNAME","DUAL_DATE_START","DUAL_DATE_END","APPLE_TYPE");
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
			DataList dl=handler.DABdisposalList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���Ĵ�����Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("���Ĵ�����Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("DABdisposalAction��DABdisposalList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * ��ת�����Ĵ���ҳ��
	 * @author Panfeng
	 * @date 2014-9-25 
	 * @return
	 */
	public String disposalShow(){
		//1 �б�ҳ��ȡ��ϢID
		String aruuid = getParameter("aruuid", "");
		System.out.println(aruuid);
		String[] uuid = aruuid.split(",");
		String arIds = "";
		StringBuffer stringb = new StringBuffer();
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			arIds = stringb.substring(0, stringb.length() - 1);
			DataList HandRegList = handler.disposalShow(conn, arIds);
			Data disposalData = new Data();
			//4 ��������ҳ��
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			disposalData.add("DUAL_USERID",curId);//������ID
			disposalData.add("DUAL_USERNAME",curPerson);//������
			disposalData.add("DUAL_DATE",curDate);//��������
			
			setAttribute("disposalData", disposalData);
			setAttribute("List", HandRegList);
			setAttribute("AR_ID", aruuid);
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
	 * @Title: DABdisposalSave 
	 * @Description: �����������ò���
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String DABdisposalSave(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","DUAL_USERID","DUAL_USERNAME","DUAL_DATE");
        
        // Start---------��ȡ�������ļ�¼��Ϣ------------
        String[] AR_ID = this.getParameterValues("P_AR_ID");
 		String[] AF_ID = this.getParameterValues("P_AF_ID");
 		// End---------��ȡ�������ļ�¼��Ϣ------------
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            for (int i = 0; i < AR_ID.length; i++) {
            	Data batchData = new Data();
            	Data fileData = new Data();
            	batchData.add("AR_ID", AR_ID[i]);
            	batchData.add("DUAL_USERID", (String)data.get("DUAL_USERID"));//������ID
            	batchData.add("DUAL_USERNAME", (String)data.get("DUAL_USERNAME"));//������
            	batchData.add("DUAL_DATE", (String)data.get("DUAL_DATE"));//����ʱ��
            	batchData.add("RETURN_STATE","3");//����״̬Ϊ"�Ѵ���"�����ļ�¼��
            	fileData.add("AF_ID", AF_ID[i]);
            	fileData.add("RETURN_STATE", "3");//����״̬Ϊ"�Ѵ���"(�ļ���Ϣ��)
            	success=handler.BGSconfirmSave(conn,batchData,fileData);
            }
            
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "���óɹ�!");//�ύ�ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ò��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[���ò���]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
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
                        log.logError("DABdisposalAction��Connection������쳣��δ�ܹر�",e);
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
			Data showdata = handler.getReturnData(conn, uuid);
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
