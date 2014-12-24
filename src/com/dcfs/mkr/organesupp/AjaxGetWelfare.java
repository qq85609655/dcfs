package com.dcfs.mkr.organesupp;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public class AjaxGetWelfare extends AjaxExecute{

	private static Log log =  UtilLog.getLog(AjaxGetWelfare.class);
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn = null;
		OrganSuppHandler handler = new OrganSuppHandler();
		String province_id = (String)request.getParameter("ids");  //ʡ��ID
		DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            String code = null;
            //����ʡ��ID���Ҹ���Ժ��Ϣ
            if(province_id != null && !"".equals(province_id) && !"null".equalsIgnoreCase(province_id)){
            	code = province_id.substring(0, 2);
            }
            dataList = handler.findWelfareDataList(conn ,code);
            try {
                this.setReturnValue(dataList);
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
