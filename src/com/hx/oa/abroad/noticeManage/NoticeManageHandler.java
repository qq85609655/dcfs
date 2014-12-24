/**
 * $Id$
 *
 * Copyright (c) 2011 21softech. All rights reserved
 * XXXXX Project
 *
 */
package com.hx.oa.abroad.noticeManage;

import hx.database.databean.Data;
import java.util.Map;
import java.sql.Connection;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.database.databean.DataBaseFactory;
import hx.util.UtilDateTime;

/**
 * @Title: AbroadPlanHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-12-20 ????09:47:14
 * @author xxx
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class NoticeManageHandler extends BaseHandler{

	  /**
     * 保存
     * 
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean save(Connection conn, Map<String, Object> data)
            throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NOTICE_MANAGE");
        dataadd.setPrimaryKey("ID_UUID");
        if ("".equals(dataadd.getString("ID_UUID", ""))) {
            dataadd.create();
        } else {
        	String nowTime = UtilDateTime.nowDateTimeString();
        	dataadd.add("CREATE_DATA", nowTime);
            dataadd.store();
        }

        return true;
    }

    /**
     * 查询列表
     * 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList findList(Connection conn, Data data,int pageSize, int page, String compositor, String ordertype)
            throws DBException {
    	
    	String sql="";
		if("".equals(compositor)||compositor==null){
			compositor="CREATE_DATA";
		}
		if("".equals(ordertype)||ordertype==null){
			ordertype="DESC";
		}
    	if(data!=null){
    		String COUNTRY_NAME = data.getString("TITLE");
    		if ("".equals(COUNTRY_NAME)) {
    			COUNTRY_NAME = null;
			}
    		sql = getSql("findList", COUNTRY_NAME, compositor,ordertype);
    	}
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
  
    /**
     * 查询首页
     * 
   
     * @throws DBException
     */
    public DataList  findFirstPage(Connection conn) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findFirstPage"));
    }
    /**
     * 查看
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getShowData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getShowData", uuid));
        return dataList.getData(0);
    }

    /**
     * 删除
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public boolean delete(Connection conn, String[] uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList deleteList = new DataList();
        for (int i = 0; i < uuid.length; i++) {
            Data data = new Data();
            data.setConnection(conn);
            data.setEntityName("NOTICE_MANAGE");
            data.setPrimaryKey("ID_UUID");
            data.add("ID_UUID", uuid[i]);
            deleteList.add(data);
        }
        ide.remove(deleteList);
        return true;
    }
}