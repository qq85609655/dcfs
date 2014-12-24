/**   
 * @Title: BalanceAccountAction.java 
 * @Package com.dcfs.fam.balanceAccount 
 * @Description: ������֯�����˻�����
 * @author yangrt   
 * @date 2014-10-23 ����3:45:22 
 * @version V1.0   
 */
package com.dcfs.fam.balanceAccount;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.hx.framework.authenticate.SessionInfo;

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

/** 
 * @ClassName: BalanceAccountAction 
 * @Description: ������֯�����˻�����
 * @author yangrt;
 * @date 2014-10-23 ����3:45:22 
 *  
 */
public class BalanceAccountAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(BalanceAccountAction.class);
	
	private BalanceAccountHandler handler;
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
	
	public BalanceAccountAction(){
		this.handler = new BalanceAccountHandler();
	}
	
	/**
	 * @Title: BalanceAccountList 
	 * @Description: ������֯�����˻���ѯ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String BalanceAccountList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="COUNTRY_CODE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NO","ACCOUNT_CURR","ACCOUNT_LMT");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.BalanceAccountList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������֯�����˻���ѯ�б�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[������֯�����˻���ѯ�б�]:" + e.getMessage(),e);
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
						log.logError("BalanceAccountAction��BalanceAccountList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: BalanceAccountAdd 
	 * @Description: ������֯�����˻�ά����Ӳ���
	 * @author: yangrt
	 * @return String  
	 */
	public String BalanceAccountAdd(){
		//��ȡ������֯code
		String ADOPT_ORG_ID = getParameter("ADOPT_ORG_ID");
		try {
			conn = ConnectionManager.getConnection();
			//����Ʊ�ݵǼ�id,��ȡƱ����ϢData
			Data data = new Data();
			//��ȡ������֯����˻���Ϣ
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, ADOPT_ORG_ID);
			data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);
			data.add("NAME_CN", syzzinfo.getSyzzCnName());
			data.add("COUNTRY_NAME", syzzinfo.getCountryCnName());
			data.add("ACCOUNT_LMT", syzzinfo.getAccountLmt());	//����˻�_�޶�
			data.add("ACCOUNT_CURR", syzzinfo.getAccountCurr());	//����˻�_��ǰ���
			data.add("MODIFYUSER_NAME", SessionInfo.getCurUser().getPerson().getCName());
			data.add("ACCOUNT_MODIFYUSER", SessionInfo.getCurUser().getPersonId());
			data.add("ACCOUNT_MODIFYDATE", DateUtility.getCurrentDateTime());
			
			setAttribute("data", data);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������֯�����˻�ά����Ӳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[������֯�����˻�ά�����]:" + e.getMessage(),e);
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
                        log.logError("BalanceAccountAction��BalanceAccountAdd.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: BalanceAccountSave 
	 * @Description: ������֯�����˻���Ϣ����
	 * @author: yangrt
	 * @return String 
	 */
	public String BalanceAccountSave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","ADOPT_ORG_ID","ACCOUNT_LMT","ACCOUNT_MODIFYUSER","ACCOUNT_MODIFYDATE");
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.BalanceAccountSave(conn,data);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������֯�����˻���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[������֯�����˻���Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������֯�����˻���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("������֯�����˻���Ϣ��������쳣:" + e.getMessage(),e);
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
                        log.logError("BalanceAccountAction��BalanceAccountSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: BalanceAccountDetailList 
	 * @Description: ������֯�����˻���ϸ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String BalanceAccountDetailList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="OPP_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}
		
		Data data = new Data();
		String type = getParameter("type","");
		if(!"false".equals(type)){
			data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NAME","OPP_DATE_START","OPP_DATE_END");
		}
		
		try {
			conn = ConnectionManager.getConnection();
			//����Ʊ�ݵǼ�id,��ȡƱ����ϢData
			DataList dl = handler.BalanceAccountDetailList(conn, data, pageSize, page, compositor, ordertype);
			setAttribute("data", data);
			setAttribute("List", dl);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������֯�����˻���ϸ�б�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[������֯�����˻���ϸ�б�]:" + e.getMessage(),e);
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
                        log.logError("BalanceAccountAction��BalanceAccountDetailList.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
}
