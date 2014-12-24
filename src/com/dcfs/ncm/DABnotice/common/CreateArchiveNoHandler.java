package com.dcfs.ncm.DABnotice.common;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: CreateArchiveNoHandler.java
 * @Description: 生成涉外收养档案号流水号
 * @Company: 21softech
 * @Created on 2014-9-26 上午11:30:05
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class CreateArchiveNoHandler extends BaseHandler {
    /**
     * 
     * @Title: getMaxSN
     * @Description: 获取本年度的最大流水号
     * @author: xugy
     * @date: 2014-9-26下午2:37:20
     * @param conn
     * @param year
     * @return
     * @throws DBException 
     */
    public Data getMaxSN(Connection conn, String year) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getMaxSN",year));
        return dataList.getData(0);
    }
    /**
     * 
     * @Title: save
     * @Description: 保存生成的档案号
     * @author: xugy
     * @date: 2014-9-26下午2:48:10
     * @param conn
     * @param adddata
     * @throws DBException 
     */
    public void save(Connection conn, Data data) throws DBException {
        data.setEntityName("NCM_ARCHIVE_NO");
        data.setPrimaryKey("YEAR","SN");
        data.setConnection(conn);
        data.create();
    }

}
