/**   
 * @Title: FileAuditAjax.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author yangrt   
 * @date 2014-9-4 ����11:16:14 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

/** 
 * @ClassName: FileAuditAjax 
 * @Description: TODO(������һ�仰��������������)
 * @author yangrt;
 * @date 2014-9-4 ����11:16:14 
 *  
 */
public class FileAuditAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(FileAuditAjax.class);

	/* (�� Javadoc) 
	 * <p>Title: run</p> 
	 * <p>Description: </p> 
	 * @param request
	 * @return 
	 * @see hx.ajax.AjaxExecute#run(javax.servlet.http.HttpServletRequest) 
	 */
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn=null;
		
		//���ղ���ֵ
		String method = ServletTools.getParameter("method", request);
		
		try {
			conn = ConnectionManager.getConnection();
			if(method.equals("getAuditID")||method=="getAuditID"){
				String str_id_state = ServletTools.getParameter("str_id_state", request);
				String af_id = str_id_state.split(";")[0];	//�ļ�id
				String aud_state = str_id_state.split(";")[1];	//�ļ����״̬
				String audit_level  = null;
				if(aud_state.equals("0") || aud_state.equals("1") || aud_state.equals("9")){
					audit_level = "0";
				}else if(aud_state.equals("2")){
					audit_level = "1";
				}else if(aud_state.equals("3")){
					audit_level = "2";
				}
				this.setReturnValue(getAuditID(conn, af_id, audit_level));
			}else if(method.equals("isCanBF")||"isCanBF"==method){
				String af_id = ServletTools.getParameter("AF_ID", request);
				Data data = this.isCanBF(conn, af_id);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}else if(method.equals("getAuditIDForWJSH")||"getAuditIDForWJSH"==method){
				String af_id = ServletTools.getParameter("AF_ID", request);
				String audit_level = ServletTools.getParameter("AUDIT_LEVEL", request);
				String operation_state = ServletTools.getParameter("OPERATION_STATE", request);
				Data data = this.getAuditIDForWJSH(conn, af_id,audit_level,operation_state);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}
			
		} catch (Exception e){
			if (log.isError()) {
				log.logError("FileAuditAjax�����쳣:" + e.getMessage(), e);
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
						log.logError("FileAuditAjax��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return true;
	}

	/**
	 * @throws   
	 * @Title: getAuditID 
	 * @Description: �����ļ�id����˼��𣬻�ȡ����״̬Ϊ�����е���˼�¼ID
	 * @author: yangrt
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @return String    �������� 
	 * @throws DBException
	 */
	private Data getAuditID(Connection conn, String af_id, String audit_level) throws DBException {
		FileAuditHandler handler = new FileAuditHandler();
		Data data = new Data();
		data = handler.getAuditID(conn, af_id, audit_level);
		return data;
	}
	
	/**
	 * @throws   
	 * @Description: �����ļ�id����˼��𡢲���״̬�����˼�¼ID
	 * @author: mayun
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @param operation_state ,������״̬��������'a','b','c'���ַ���
	 * @return String    �������� 
	 * @throws DBException
	 */
	private Data getAuditIDForWJSH(Connection conn, String af_id, String audit_level,String operation_state) throws DBException {
		FileAuditHandler handler = new FileAuditHandler();
		Data data = new Data();
		data = handler.getAuditIDForWJSH(conn, af_id, audit_level,operation_state);
		return data;
	}
	
	/**
	 * @throws   
	 * @Title: isCanBF 
	 * @Description: �����ļ�id�жϸ��ļ��Ƿ���Խ��в�������
	 * @author: mayun
	 * @param conn
	 * @param af_id
	 * @throws DBException
	 */
	private Data isCanBF(Connection conn, String af_id) throws DBException {
		FileAuditHandler handler = new FileAuditHandler();
		Data data = new Data();
		boolean flag = handler.isCanBF(conn, af_id);
		data.add("FLAG", flag);
		return data;
	}

}
