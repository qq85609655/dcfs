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
     * 添加页面跳转
     * @return
     */
    public String toAdd(){
    	/*//调用查询机构ID的方法
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan0();  
		String lc0="";  //机构Id
		String lcName="";  //机构名称
		String lcCode="";  //机构code
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
     * 保存方法
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
                InfoClueTo clueTo = new InfoClueTo(0, "保存成功!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");
            setAttribute("clueTo", clueTo);
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");
            setAttribute("clueTo", clueTo);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NoticeManageAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return SUCCESS;
    }

    /**
     * 查询列表页面
     * @return
     */
    public String findList(){
      // 设置分页
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
                log.logError("操作异常[查询操作]:" + e.getMessage(),e);
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
                        log.logError("NoticeManageAction的Connection因出现异常，未能关闭",e);
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
     * 查看
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
                        log.logError("Connection因出现异常，未能关闭",e);
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
     * 删除
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
                InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
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
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "删除失败!");
            setAttribute("clueTo", clueTo);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NoticeManageAction的Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
            return SUCCESS;
    }
    
    /**
     * 国合信息通知公告首页页面
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
                log.logError("国合信息通知公告首页页面:" + e.getMessage(),e);
            }
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NoticeManageAction的Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
    	return SUCCESS;
    }
}