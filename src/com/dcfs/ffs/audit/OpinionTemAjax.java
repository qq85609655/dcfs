package com.dcfs.ffs.audit;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;



import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

/**
 * ������ģ��Ajax������
 * @author mayun
 * @date 2014-8-19
 * @version 1.0
 */
public class OpinionTemAjax extends AjaxExecute {

	private static Log log = UtilLog.getLog(OpinionTemAjax.class);
	OpinionTemHandler handler=new OpinionTemHandler();
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn = null;
		DBTransaction dt = null;
		boolean returnFlag = true;
		String method=ServletTools.getParameter("method", request, "");
		String type=ServletTools.getParameter("TYPE", request, "");//���
		String gy_type=ServletTools.getParameter("GY_TYPE", request, "");//��Լ����
		String audit_type=ServletTools.getParameter("AUDIT_TYPE", request, "");//��˼���
		if("null".equals(gy_type)||"".equals(gy_type)){
			gy_type=null;
		}
		if("null".equals(audit_type)||"".equals(audit_type)){
			audit_type=null;
		}
		String audit_option=ServletTools.getParameter("AUDIT_OPTION", request, "");//������
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			DataList dl= new DataList();
			Data data = new Data();
			if(method.equals("getAuditModelContent")){//������𡢹�Լ���͡���˼������������������ģ������
				data = this.getAuditModelContent(conn, type, gy_type,audit_type, audit_option);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}
			dt.commit();
		} catch (Exception e) {
			try {
				dt.rollback();
				returnFlag=false;
				setReturnValue("OpinionTemAjax�쳣,����ϵ����Ա");
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OpinionTemAjax��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		
		return returnFlag;
	}
	
	
	
	
	/**
	 * ���������˼������������������ģ������
	 * @description 
	 * @author MaYun
	 * @date 2014-8-19
	 * @param Connection conn 
	 * @param String type ���(�ļ���ˣ�00,��˲�Ԥ����10,���ò�Ԥ����11)
	 * @param String gy_type ��Լ����(0���ǹ�Լ;1:��Լ)
	 * @param String audit_type ��˼���(����0,����1,������2)
	 * @param String audit_option ������(����com.dcfs.ffs.audit.FileAuditConstant.java�����ඨ��)
	 * @return Data fileData
	 * @throws DBException 
	 */
	public Data getAuditModelContent(Connection conn,String type,String gy_type,String audit_type,String audit_option) throws DBException{
		Data data = new Data();
		data = handler.getAuditModelContent(conn,type,gy_type,audit_type,audit_option);
		return data;
	}
	



	
}



