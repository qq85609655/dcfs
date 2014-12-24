/**   
 * @Title: CertificationBodyAction.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��˲���������Լ��֤��Ϣ���д������޸ġ�ɾ����ʧЧ����) 
 * @author panfeng   
 * @date 2014-8-20 ����5:27:31 
 * @version V1.0   
 */
package com.dcfs.mkr.USAConvention;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;
import com.hx.framework.authenticate.SessionInfo;

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


/** 
 * @ClassName: CertificationBodyAction 
 * @Description: ������Լ��֤����Action 
 * @author panfeng 
 * @date 2014-8-20
 *  
 */
public class CertificationBodyAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(CertificationBodyAction.class);

    private CertificationBodyHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public CertificationBodyAction(){
        this.handler=new CertificationBodyHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * ��ת����������ҳ��
	 * @author panfeng
	 * @date 2014-8-20
	 * @return
	 */
	public String toBodyAdd(){
		
		return SUCCESS;
	}
	
	/**
     * �����������޸ı���
	 * @author panfeng
	 * @date 2014-8-20
     * @return
     */
    public String saveCerBody(){
    	
    	//��ȡ�����˻�����Ϣ��ϵͳ����
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
    	
	    //1���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("P_","COA_ID","TYPE","NAME","ADDR","VALID_DATE","EXPIRE_DATE","STATE","REG_USERID","REG_DATE","MOD_USERID","MOD_DATE");
        
        String pageAction = this.getParameter("P_PAGEACTION");//��ȡҳ�����ͣ�����/�޸ģ�
        boolean operation_type = true;
        
        if (("create").equals(pageAction)) {//��������
        	data.add("REG_USERID",personName);
        	data.add("REG_DATE",curDate);
        	data.add("MOD_USERID",personName);
        	data.add("MOD_DATE",curDate);
        	operation_type = true;
        }else if (("update").equals(pageAction)) {//�޸�
        	data.add("MOD_USERID",personName);
        	data.add("MOD_DATE",curDate);
			operation_type = false;
		}
        
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            success=handler.saveCerBody(conn,data,operation_type);
            //TODO:��Ҫ�Ӷ�ʱ����ʱ���񣺼����֤������ʧЧ���ڣ�����ϵͳ���Զ�����ʧЧ�������
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "����ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(),e);
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
                        log.logError("CertificationBodyAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * @Title: findBodyList 
	 * @Description: ��֤�����б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String findBodyList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor=null;
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype=null;
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.findBodyList(conn,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��Ǽǲ�ѯ�����쳣");
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
						log.logError("CertificationBodyAction��findBodyList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * �޸Ĳݸ塢����Ч��¼
	 * @author panfeng
	 * @date 2014-8-20
	 * @return
	 */
	public String showCerBody(){
		//1 ��ȡ�������
		String COA_ID = getParameter("uuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ�鿴��Ϣ�����
			Data showdata = handler.showCerBody(conn, COA_ID);
			//4 ��������鿴ҳ��
			setAttribute("rzjgData", showdata);
			setAttribute("STATE", showdata.getString("STATE",""));
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
	 * @Title: bodyDelete 
	 * @Description: ����ɾ���ݸ��¼
	 * @author: panfeng;
	 * @return String    �������� 
	 * @throws
	 */
	public String bodyDelete() {
		//1 ��ȡҪɾ�����ļ�ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡɾ�����
			success = handler.bodyDelete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��¼ɾ�������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[ɾ������]:" + e.getMessage(),e);
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
                        log.logError("CertificationBodyAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: changeFail 
	 * @Description: ʧЧ���ָ���Ч��¼
	 * @author: panfeng;
	 * @return String    �������� 
	 * @throws
	 */
	public String changeFail() {
		//1 ��ȡҪ�ύ���ļ�ID
		String op_uuid = getParameter("op_uuid", "");
		String operation_type = getParameter("type");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			success = handler.changeFail(conn, op_uuid, operation_type);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "�����ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");
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
                        log.logError("CertificationBodyAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * �ָ���Чʱ���統ǰ����С��ʧЧʱ�䵯���޸�ʧЧʱ�䴰��
	 * @author Panfeng
	 * @date 2014-9-10 
	 * @return
	 */
	public String modExpireDate(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("op_uuid","");
		System.out.println(uuid);
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.showCerBody(conn, uuid);
			
			//4 ��������ҳ��
			setAttribute("modData", showdata);
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
	 * @Title: reviseExpireDate 
	 * @Description: �޸�ʧЧ����
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String reviseExpireDate() {
		 //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("P_","COA_ID","EXPIRE_DATE");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			data.add("STATE", "1");//״̬��Ϊ����Ч
			success = handler.saveCerBody(conn, data, false);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "�޸�ʧЧ���ڳɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�޸�ʧЧ���ڲ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[�޸�ʧЧ���ڲ���]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�޸�ʧЧ���ڲ���ʧ��!");
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
                        log.logError("PauseFileAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	
}
