package com.dcfs.pfr;

import hx.ajax.AjaxExecute;
import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
/**
 * 
 * @Title: AjaxSavePPFeedbackAttDES.java
 * @Description: ����ͼƬ����
 * @Company: 21softech
 * @Created on 2014-10-19 ����5:15:56
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AjaxSavePPFeedbackAttDES extends AjaxExecute {
    
    private static Log log = UtilLog.getLog(AjaxSavePPFeedbackAttDES.class);
    
    private DBTransaction dt = null;//������
    
    @Override
    public boolean run(HttpServletRequest request) {
        Connection conn = null;
        PPFeebbackAttHandler h = new PPFeebbackAttHandler();
        String type = (String) request.getParameter("type");
        String id = (String) request.getParameter("id");
        String des = (String) request.getParameter("des");
        try {
            des = java.net.URLDecoder.decode(des,"UTF-8");
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data data = new Data();
            data.add("ID", id);
            if("EN".equals(type)){
                data.add("DES_EN", des);
            }
            if("CN".equals(type)){
                data.add("DES_CN", des);
            }
            h.saveARDES(conn, data);
            dt.commit();
            this.setReturnValue(data);
        } catch (DBException e) {
          //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
        } catch (IOException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
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
