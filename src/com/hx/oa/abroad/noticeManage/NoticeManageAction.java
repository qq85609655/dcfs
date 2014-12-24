/**
 * $Id$
 *
 * Copyright (c) 2011 21softech. All rights reserved
 * XXXXX Project
 *
 */
package com.hx.oa.abroad.noticeManage;

import hx.common.j2ee.BaseAction;
import hx.log.Log;
import hx.log.UtilLog;
import java.sql.Connection;
import hx.database.transaction.DBTransaction;
import hx.database.manager.ConnectionManager;
import hx.common.Exception.DBException;
import hx.database.databean.DataList;
import hx.util.InfoClueTo;

import java.sql.SQLException;
import hx.common.Constants;
import hx.database.databean.Data;



/**
 * @Title: AbroadPlanAction.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-12-20 ????09:47:14
 * @author xxx
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class NoticeManageAction extends BaseAction{

	private static Log log = UtilLog.getLog(NoticeManageAction.class);

    private NoticeManageHandler handler;

    public NoticeManageAction(){
        this.handler=new NoticeManageHandler();
    } 
    
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * ���ҳ����ת
     * @return
     */
    public String toAdd(){
    	/*//���ò�ѯ����ID�ķ���
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan0();  
		String lc0="";  //����Id
		String lcName="";  //��������
		String lcCode="";  //����code
		Data data = new Data();
		if(o!=null){
			lc0=o.getId();
			lcCode=o.getOrgCode();
			lcName=o.getCName();
		}
		data.add("lc0", lc0);
		data.add("lcName", lcName);
		data.add("lcCode", lcCode);
		setAttribute("data", data);*/
    	this.setAttribute("data",new Data());
        return SUCCESS;
        
    }
    
    /**
     * ���淽��
     * @return
     */
    public String save(){
        Connection conn = null;
        DBTransaction dt = null;
        Data data = getRequestEntityData("R_","ID_UUID","TITLE","NOTICE_CONTENT","CREATE_PERSON_ID","CREATE_DATA");
        try {
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.save(conn,data);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "����ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NoticeManageAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return SUCCESS;
    }

    /**
     * ��ѯ�б�ҳ��
     * @return
     */
    public String findList(){
      // ���÷�ҳ
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        Connection conn = null;
        String compositor=(String)getParameter("compositor","");
          if("".equals(compositor)){
              compositor=null;
          }
          String ordertype=(String)getParameter("ordertype","");
          if("".equals(ordertype)){
              ordertype=null;
          }
          setAttribute("hidedata",getParameter("hidedata", ""));
        Data data = getRequestEntityData("r_","TITLE");
     //   String type = getParameter("type"); 
        try {
            conn = ConnectionManager.getConnection();
            DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣[��ѯ����]:" + e.getMessage(),e);
            }
            // TODO Auto-generated catch block
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NoticeManageAction��Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
 /*       if("weifu".equals(type)){
            return "weifu";
        }else if("select".equals(type)){
            return "select";
        }else {*/
            return SUCCESS;
        
    }
    

    /**
     * �鿴
     * @return
     */
    public String show(){
     String uuid = getParameter("UUID");
     String type = getParameter("type");
     Connection conn = null;
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
            return SUCCESS;
        }
    }
  
    /**
     * ɾ��
     * @return
     */
    public String delete(){
     String deleteuuid=getParameter("deleteuuid", "");
     deleteuuid=deleteuuid.substring(1, deleteuuid.length());
     String[] uuid= deleteuuid.split("#");
     Connection conn = null;
     DBTransaction dbt = null;
        try{
            conn = ConnectionManager.getConnection();
            dbt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.delete(conn,uuid);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            dbt.commit();
        }catch (Exception e) {
            try {
                dbt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[ɾ������]:" + e.getMessage(),e);
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
                        log.logError("NoticeManageAction��Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
            return SUCCESS;
    }
    
    /**
     * ������Ϣ֪ͨ������ҳҳ��
     * @return
     */
    public String showFirstPage () {
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            DataList dl=handler.findFirstPage(conn);
            setAttribute("List",dl);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("������Ϣ֪ͨ������ҳҳ��:" + e.getMessage(),e);
            }
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NoticeManageAction��Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
    	return SUCCESS;
    }
}