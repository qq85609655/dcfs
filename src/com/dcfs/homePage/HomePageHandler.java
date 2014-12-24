package com.dcfs.homePage;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: HomePageHandler.java
 * @Description: 
 * @Company: 21softech
 * @Created on 2014-12-22 ÏÂÎç3:28:22
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class HomePageHandler extends BaseHandler {

    public DataList getNotice(Connection conn) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNotice");
        DataList dl = ide.find(sql);
        return dl;
    }

}
