/**   
 * @Title: OpinionTemAction.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author panfeng   
 * @date 2014-8-13 ����2:47:21 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

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
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;


/** 
 * @ClassName: OpinionTemAction 
 * @Description: ������ģ��Action 
 * @author panfeng 
 * @date 2014-8-13
 *  
 */
public class OpinionTemAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(OpinionTemAction.class);

    private OpinionTemHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public OpinionTemAction(){
        this.handler=new OpinionTemHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
     * ����������ģ��
	 * @author panfeng
	 * @date 2014-8-13
     * @return
     */
    public String saveOpinionTem(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("P_","AAM_ID","AUDIT_MODEL_CONTENT");
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            success=handler.saveOpinionTem(conn,data);
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
                        log.logError("OpinionTemAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * @Title: findList 
	 * @Description: ������ģ���б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String findListTem(){
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
			DataList dl=handler.findListTem(conn,pageSize,page,compositor,ordertype);
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
						log.logError("OpinionTemAction��findList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * �鿴
	 * @author panfeng
	 * @date 2014-8-13
	 * @return
	 */
	public String showOpinionTem(){
		//1 ��ȡ�������
		String AAM_ID = getParameter("AAM_ID","");
		String type = getParameter("type");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ�鿴��Ϣ�����
			Data showdata = handler.showOpinionTem(conn, AAM_ID);
			//4 ��������鿴ҳ��
			setAttribute("shmbData", showdata);
			setAttribute("audit_type", showdata.getString("AUDIT_TYPE", ""));
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
		} else if ("mod".equals(type)) {
			return "mod";
		} else {
			return SUCCESS;
		}
	}
	
	
}
