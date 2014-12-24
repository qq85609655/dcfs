package com.dcfs.ncm;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public class AjaxPlusPrintNum extends AjaxExecute {
    
    private static Log log =  UtilLog.getLog(AjaxPlusPrintNum.class);

    @Override
    public boolean run(HttpServletRequest request) {
        Connection conn = null;
        String MI_ID = (String)request.getParameter("MI_ID");  //ƥ��ID
        String BIZ_TYPE = (String)request.getParameter("BIZ_TYPE");  //
        try {
            conn = ConnectionManager.getConnection();
            MatchAction matchAction = new MatchAction();
            String rValue = matchAction.plusPrintNum(MI_ID, BIZ_TYPE);
            this.setReturnValue(rValue);
        } catch (DBException e) {
            log.logError("��ȡ���ݳ����쳣:" + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�", e);
                    }
                }
            }
        }
        return true;
    }

}
