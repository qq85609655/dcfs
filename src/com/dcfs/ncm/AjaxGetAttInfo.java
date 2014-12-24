package com.dcfs.ncm;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;
/**
 * 
 * @Title: AjaxGetAttInfo.java
 * @Description: ��ȡ������Ϣ
 * @Company: 21softech
 * @Created on 2014-11-12 ����9:32:06
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AjaxGetAttInfo extends AjaxExecute {
    
    private static Log log =  UtilLog.getLog(AjaxGetAttInfo.class);

    @Override
    public boolean run(HttpServletRequest request) {
        Connection conn = null;
        String MI_ID = (String)request.getParameter("MI_ID");  //ƥ��ID
        String smallType = (String)request.getParameter("smallType");  //����С��
        try {
            conn = ConnectionManager.getConnection();
            
            Data data = new Data();
            List<Att> list = AttHelper.findAttListByPackageId(MI_ID, smallType, "AF");
            String ID = list.get(0).getId();
            String ATT_NAME = list.get(0).getAttName();
            String ATT_TYPE = list.get(0).getAttType();
            data.add("ID", ID);
            data.add("ATT_NAME", ATT_NAME);
            data.add("ATT_TYPE", ATT_TYPE);
            
            try {
                this.setReturnValue(data);
            } catch (IOException e) {
                log.logError("��ȡ���ݳ����쳣:" + e.getMessage(), e);
            } catch (SQLException e) {
                log.logError("��ȡSQL���ʧ��:" + e.getMessage(), e);
            }
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
