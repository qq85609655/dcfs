package com.dcfs.rfm.SHBconfirm;

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
 * @ClassName: SHBconfirmAction 
 * @Description: ����˲���������Ϣ���в�ѯ��ȷ�ϡ��鿴��ȡ�����ġ���������
 * @author panfeng;
 * @date 2014-9-28 ����11:01:09 
 *
 */
public class SHBconfirmAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(SHBconfirmAction.class);

    private SHBconfirmHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;

    public SHBconfirmAction(){
        this.handler=new SHBconfirmHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: SHBconfirmList 
	 * @Description: ����ȷ���б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SHBconfirmList(){
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
					"APPLE_DATE_END","HANDLE_TYPE","RETREAT_DATE_START","RETREAT_DATE_END","RETURN_STATE");
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
			DataList dl=handler.SHBconfirmList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ȷ����Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("����ȷ����Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("SHBconfirmAction��SHBconfirmList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * ��ת������ȷ��ҳ��
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
	 * @Title: SHBconfirmSave 
	 * @Description: ����ȷ�ϲ���
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SHBconfirmSave(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","AR_ID","AF_ID");
        Data fileData = new Data();
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
            String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			data.add("ORG_ID",curOrgId);//ȷ�ϲ���ID
			data.add("PERSON_ID",curId);//ȷ����ID
			data.add("PERSON_NAME",curPerson);//ȷ����
			data.add("RETREAT_DATE",curDate);//ȷ������
            fileData.add("AF_ID", (String)data.get("AF_ID"));
        	fileData.add("RETURN_STATE", "1");//����״̬Ϊ"��ȷ��"(�ļ���Ϣ��)
        	data.add("RETURN_STATE","1");//����״̬Ϊ"��ȷ��"�����ļ�¼��
        	
        	//��ʼ�������ƽ���¼����˲�-��������
        	FileCommonManager fileCommonManager = new FileCommonManager();
        	DataList tranferDataList = new DataList();
        	Data tranferData = new Data();
        	tranferData.add("APP_ID", (String)data.get("AF_ID"));
        	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_SHB_DAB);
        	tranferData.add("TRANSFER_STATE", "0");
        	tranferDataList.add(tranferData);
        	fileCommonManager.transferDetailInit(conn, tranferDataList);//��ʼ�������ƽ���¼
            
            success=handler.SHBconfirmSave(conn,data,fileData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "ȷ�ϳɹ�!");//�ύ�ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ȷ�ϲ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[ȷ�ϲ���]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ȷ��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "ȷ��ʧ��!");//����ʧ�� 2
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
                        log.logError("SHBconfirmAction��Connection������쳣��δ�ܹر�",e);
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
	
	/**
	 * @Title: returnFileDelete 
	 * @Description: ����ȡ��������Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String returnFileDelete() {
		//1 ��ȡҪȡ�������ļ�¼ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		String fileuuid = getParameter("fileuuid", "");
		String[] file_uuid = fileuuid.split("#");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡɾ�����
			success = handler.returnFileDelete(conn, uuid, file_uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "����ȡ���ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ȡ�������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[����ȡ������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ɾ��ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 �ر����ݿ�
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("InsteadRecordAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}

	
	
}
