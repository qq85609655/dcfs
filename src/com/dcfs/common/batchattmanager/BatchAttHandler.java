package com.dcfs.common.batchattmanager;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

public class BatchAttHandler extends BaseHandler{
	 /**
     * 获得附件类型信息
     * 
     * @param conn
     * @param packID
     * @return DataList
     * @throws DBException
     */
    public DataList getAttType(Connection conn, String packID) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	DataList dataList = new DataList();
        dataList = ide.find(getSql("getAttType", packID));       
        return dataList;
    }
    
	 /**
     * 获得附件数据信息
     * 
     * @param conn
     * @param packageID
     * @return
     * @throws DBException
     */
    public DataList getAttData(Connection conn, String packageID,String entityName) throws DBException {
        
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getAttData", packageID,entityName));
        return dataList;
    }

}
