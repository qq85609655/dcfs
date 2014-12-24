 /**
 * @Title: AttSmallTypeAction.java
 * @Package com.dcfs.cms
 * @Description: ����С��ά��
 * @author ����
 * @project DCFS 
 * @date 2014-10-27 9:28:52
 * @version V1.0   
 */
package com.dcfs.common.atttypemanager;

import java.sql.Connection;
import java.sql.SQLException;
import hx.common.Exception.DBException;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.InfoClueTo;

/**
 * @Title: AttSmallTypeAction.java
 * @Description:����С��ά��
 * @Created on 2014-10-27 9:28:52
 * @author wangzheng
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class AttSmallTypeAction extends BaseAction{

	private static Log log = UtilLog.getLog(AttSmallTypeAction.class);

    private AttSmallTypeHandler handler;
	
	private Connection conn = null;//���ݿ�����
	
	private DBTransaction dt = null;//������
	
	private String retValue = SUCCESS;

    public AttSmallTypeAction(){
        this.handler=new AttSmallTypeHandler();
    } 
    
    public String execute() throws Exception {
        return null;
    }

    /**
     * ���ҳ����ת(�������Զ���)
	 * @author ����
	 * @date 2014-10-27 9:28:52
     * @return
     */
    public String add(){
        
        return retValue;
        
    }
    
    /**
     * ���淽��
	 * @author wangzheng
	 * @date 2014-10-27 9:28:52
     * @return
     */
    public String save(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("P_","ID","CODE","CNAME","ENAME","ATT_MORE","ATT_SIZE","ATT_FORMAT","IS_NAILS","REMARKS","SEQ_NO","IS_VALID","BIG_TYPE");
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            success=handler.save(conn,data);
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
                        log.logError("AttSmallTypeAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }

    /**
     * ��ѯ����(�������Զ���)
	 * @author wangzheng
	 * @date 2014-10-27 9:28:52
     * @return
     */
    public String findList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
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
		Data data = getRequestEntityData("S_", 
				"BIG_TYPE", 
				"CNAME");
        
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
		    //7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
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
                        log.logError("AttSmallTypeAction��Connection������쳣��δ�ܹر�",e);
                    }
					retValue = "error2";
                }
            }
        }
        return retValue;
    }

     /**
     * �鿴����(�������Զ���)
	 * @author xxx
	 * @date 2014-10-27 9:28:52
     * @return
     */
    public String show(){
     String uuid = getParameter("UUID");
	 String type = getParameter("type");
        try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            setAttribute("data", showdata);
        } catch (DBException e) {
            e.printStackTrace();
        }finally {
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
        if("show".equals(type)){
            return "show";
        }else if("mod".equals(type)){
            return "mod";
        }else {
            return retValue;
        }
    }
  
    /**
     * ɾ������(�������Զ���)
	 * @author xxx
	 * @date 2014-10-27 9:28:52
     * @return
     */
    public String delete(){
        String deleteuuid=getParameter("deleteuuid", "");
        deleteuuid=deleteuuid.substring(1, deleteuuid.length());
        String[] uuid= deleteuuid.split("#");
        try{
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.delete(conn,uuid);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        }catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("ɾ�������쳣[ɾ������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ɾ��ʧ��!");
            setAttribute("clueTo", clueTo);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AttSmallTypeAction��Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
            return retValue;
    }
}