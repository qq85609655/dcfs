package com.dcfs.homePage;

import java.sql.Connection;
import java.sql.SQLException;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
/**
 * 
 * @Title: AjaxNotice.java
 * @Description: 
 * @Company: 21softech
 * @Created on 2014-12-22 下午3:30:55
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AjaxNotice extends AjaxExecute {
    
    private static Log log = UtilLog.getLog(AjaxNotice.class);
    HomePageHandler handler=new HomePageHandler();
    
    @Override
    public boolean run(HttpServletRequest request) {
        Connection conn = null;
        boolean returnFlag = true;
        try{
            conn = ConnectionManager.getConnection();
            DataList dl = handler.getNotice(conn);
            JSONArray json = JSONArray.fromObject(dl);
            setReturnValue(json.toString());
        }catch(DBException e){
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            returnFlag=false;
            setReturnValue("AjaxNotice异常,请联系管理员");
        }finally{
            //8 关闭数据库连接
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
        return returnFlag;
    }

}
