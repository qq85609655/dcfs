/**   
 * @Title: ReceiveConfirmAction.java 
 * @Package com.dcfs.fam.receiveConfirm 
 * @Description: ���ù���-����ȷ��
 * @author yangrt   
 * @date 2014-10-21 ����9:00:37 
 * @version V1.0   
 */
package com.dcfs.fam.receiveConfirm;

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
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: ReceiveConfirmAction 
 * @Description: ���ù���-����ȷ��
 * @author yangrt
 * @date 2014-10-21 ����9:00:37 
 *  
 */
public class ReceiveConfirmAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(ReceiveConfirmAction.class);

    private ReceiveConfirmHandler handler;
    private Connection conn = null;//���ݿ�����
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;

	/* (�� Javadoc) 
	 * <p>Title: execute</p> 
	 * <p>Description: </p> 
	 * @return
	 * @throws Exception 
	 * @see hx.common.j2ee.BaseAction#execute() 
	 */
	@Override
	public String execute() throws Exception {
		return null;
	}
	
	public ReceiveConfirmAction(){
		this.handler = new ReceiveConfirmHandler();
	}
	
	/**
	 * @Title: ReceiveConfirmList 
	 * @Description: ����ȷ�ϲ�ѯ�б�
	 * @author: yangrt
	 * @return String  
	 */
	public String ReceiveConfirmList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="ARRIVE_STATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","PAID_NO","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_WAY",
					"PAID_SHOULD_NUM","PAR_VALUE","FILE_NO","RECEIVE_DATE_START","RECEIVE_DATE_END",
					"ARRIVE_STATE","ARRIVE_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_ACCOUNT_VALUE","ACCOUNT_CURR");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.ReceiveConfirmList(conn,data,pageSize,page,compositor,ordertype);
			for(int i = 0; i < dl.size(); i++){
				Data tempdata = dl.getData(i);
				String file_no = tempdata.getString("FILE_NO","");
				if(file_no.contains(",")){
					tempdata.add("FILE_NO", "Multiple");
				}
			}
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ȷ�ϲ�ѯ�б�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[����ȷ�ϲ�ѯ�б�]:" + e.getMessage(),e);
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
						log.logError("ReceiveConfirmAction��ReceiveConfirmList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: ReceiveConfirmShow 
	 * @Description: ����ȷ�����/�鿴����
	 * @author: yangrt
	 * @return String 
	 */
	public String ReceiveConfirmShow(){
		String type = getParameter("type");		//�жϵ�ǰ��������ӻ��ǲ鿴���鿴��show,��ӣ�add
		retValue = type;
		//��ȡƱ�ݵǼ�id
		String CHEQUE_ID = getParameter("CHEQUE_ID");
		String orgId = getParameter("ORG_ID");
		try {
			conn = ConnectionManager.getConnection();
			//����Ʊ�ݵǼ�id,��ȡƱ����ϢData
			Data data = handler.getFamChequeInfoById(conn, CHEQUE_ID);
			//��ȡ������֯����˻���Ϣ
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgId);
			data.add("ACCOUNT_LMT", syzzinfo.getAccountLmt());	//����˻�_�޶�
			data.add("ACCOUNT_CURR", syzzinfo.getAccountCurr());	//����˻�_��ǰ���
			data.add("ORG_ID", orgId);
			
			String file_no = data.getString("FILE_NO","");	//�ļ����
			DataList fileList = new DataList();
			Data filedata = new Data();
			if(file_no.contains(",")){
				String[] fileNo = file_no.split(",");
				for(int i=0; i<fileNo.length; i++){
					filedata = new FileCommonManager().getCommonFileInfo(fileNo[i], conn);
					String ci_id = filedata.getString("CI_ID","");
					//��ȡ�ļ������Ķ�ͯ��Ϣ
					DataList cdataList = new FileManagerHandler().getChildDataList(conn, ci_id);
					for(int j=0; j<cdataList.size(); j++){
						Data cdata = cdataList.getData(j);
						if(cdata.getString("IS_MAIN").equals("1")){
							filedata.add("NAME", cdata.getString("NAME"));
						}
					}
					fileList.add(filedata);
				}
			}else{
				filedata = new FileCommonManager().getCommonFileInfo(file_no, conn);
				String ci_id = filedata.getString("CI_ID","");
				//��ȡ�ļ������Ķ�ͯ��Ϣ
				DataList cdataList = new FileManagerHandler().getChildDataList(conn, ci_id);
				for(int j=0; j<cdataList.size(); j++){
					Data cdata = cdataList.getData(j);
					if(cdata.getString("IS_MAIN").equals("1")){
						filedata.add("NAME", cdata.getString("NAME"));
					}
				}
				fileList.add(filedata);
			}
			setAttribute("data", data);
			setAttribute("List", fileList);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ȷ�����/�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[����ȷ�����/�鿴]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ReceiveConfirmAction��ReceiveConfirmAdd.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
		
	}
	
	public String ReceiveConfirmSave(){
		//1 ���ҳ������ݣ��������ݽ����
		//Ʊ����Ϣ
		Data pjdata = getRequestEntityData("R_","CHEQUE_ID","ADOPT_ORG_ID","FILE_NO","ARRIVE_STATE","ARRIVE_DATE","ARRIVE_VALUE","ARRIVE_REMARKS","ARRIVE_ACCOUNT_VALUE");
		//������֯����˻���Ϣ
		Data zhdata = getRequestEntityData("P_","ORG_ID","ACCOUNT_CURR");
		zhdata.add("ADOPT_ORG_ID", zhdata.getString("ORG_ID"));
		zhdata.remove("ORG_ID");
		
		//��ǰ��¼����Ϣ
		UserInfo userinfo = SessionInfo.getCurUser();
		String personId = userinfo.getPersonId();
		String personName = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		//����˻�ʹ�ü�¼
		Data sydata = getRequestEntityData("L_","COUNTRY_CODE","PAID_NO","BILL_NO","OPP_TYPE","SUM","REMARKS");
		sydata.add("ADOPT_ORG_ID", pjdata.getString("ADOPT_ORG_ID"));
		sydata.add("CHEQUE_ID", pjdata.getString("CHEQUE_ID"));
		sydata.add("OPP_USERID", personId);
		sydata.add("OPP_USERNAME", personName);
		sydata.add("OPP_DATE", curDate);

		try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.ReceiveConfirmSave(conn,pjdata,zhdata,sydata);
            dt.commit();
            if(success){
                InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ȷ����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[����ȷ����Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ȷ����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("����ȷ�ϱ�������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ReceiveConfirmAction��ReceiveConfirmSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
		
	}
	
	/**
	 * @Title: ReviseAccountAdd 
	 * @Description: ������Ӳ���
	 * @author: yangrt
	 * @return String 
	 */
	public String ReviseAccountAdd(){
		//��ȡƱ�ݵǼ�id
		String CHEQUE_ID = getParameter("CHEQUE_ID");
		try {
			conn = ConnectionManager.getConnection();
			//����Ʊ�ݵǼ�id,��ȡƱ����ϢData
			Data data = handler.getFamChequeInfoById(conn, CHEQUE_ID);
			double arrive_value = Double.parseDouble(data.getString("ARRIVE_VALUE"));	//���˽��
			double should_value = Double.parseDouble(data.getString("PAID_SHOULD_NUM"));	//Ӧ�ɽ��
			String arrive_account = data.getString("ARRIVE_ACCOUNT_VALUE","");	//�����˻�ʹ�ý��
			double used_value =	0;
			if(!"".equals(arrive_account)){
				used_value = Double.parseDouble(arrive_account);
			}
			data.add("BALANCE_VALUE", should_value - arrive_value - used_value);	//��Ѳ��
			//��ȡ������֯����˻���Ϣ
			String orgid = data.getString("ADOPT_ORG_ID");		//������֯code		
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			data.add("ACCOUNT_LMT", syzzinfo.getAccountLmt());	//����˻�_�޶�
			data.add("ACCOUNT_CURR", syzzinfo.getAccountCurr());	//����˻�_��ǰ���
			
			data.remove("REMARKS");
			
			setAttribute("data", data);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������Ӳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ReceiveConfirmAction��ReviseAccountAdd.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ReviseAccountSave 
	 * @Description: ������Ϣ�������
	 * @author: yangrt
	 * @return String 
	 */
	public String ReviseAccountSave(){
		//1 ���ҳ������ݣ��������ݽ����
		//Ʊ����Ϣ
		Data pjdata = getRequestEntityData("R_","CHEQUE_ID","ADOPT_ORG_ID","FILE_NO","ARRIVE_STATE","ARRIVE_ACCOUNT_VALUE");
		//������֯����˻���Ϣ
		Data zhdata = getRequestEntityData("P_","ACCOUNT_CURR");
		zhdata.add("ADOPT_ORG_ID", pjdata.getString("ADOPT_ORG_ID"));
		
		//��ǰ��¼����Ϣ
		UserInfo userinfo = SessionInfo.getCurUser();
		String personId = userinfo.getPersonId();
		String personName = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		//����˻�ʹ�ü�¼
		Data sydata = getRequestEntityData("L_","COUNTRY_CODE","PAID_NO","BILL_NO","OPP_TYPE","SUM","REMARKS");
		sydata.add("ADOPT_ORG_ID", pjdata.getString("ADOPT_ORG_ID"));
		sydata.add("CHEQUE_ID", pjdata.getString("CHEQUE_ID"));
		sydata.add("OPP_USERID", personId);
		sydata.add("OPP_USERNAME", personName);
		sydata.add("OPP_DATE", curDate);
		
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.ReceiveConfirmSave(conn,pjdata,zhdata,sydata);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[������Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("���˱�������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ReceiveConfirmAction��ReviseAccountSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}

}
