/**   
 * @Title: PreApproveAuditAjax.java 
 * @Package com.dcfs.sce.preApproveAudit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author yangrt   
 * @date 2014-12-1 ����5:24:52 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveAudit;

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

/** 
 * @ClassName: PreApproveAuditAjax 
 * @Description: TODO(������һ�仰��������������) 
 * @author yangrt;
 * @date 2014-12-1 ����5:24:52 
 *  
 */
public class PreApproveAuditAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(PreApproveAuditAjax.class);

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
		String ri_id = ServletTools.getParameter("RI_ID", request);
		String audit_type = ServletTools.getParameter("AUDIT_TYPE", request);
		String audit_level = null;
		if("1".equals(audit_type)){
			audit_level = ServletTools.getParameter("AUDIT_LEVEL", request);
		}
		try {
			conn = ConnectionManager.getConnection();
			String rau_id = this.getPreAuditId(conn, ri_id, audit_type, audit_level);
			this.setReturnValue(rau_id);
		} catch (Exception e){
			if (log.isError()) {
				log.logError("PreApproveAuditAjax�����쳣:" + e.getMessage(), e);
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
						log.logError("PreApproveAuditAjax��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return true;
	}
	
	private String getPreAuditId(Connection conn, String ri_id, String audit_type, String audit_level) throws DBException{
		PreApproveAuditHandler pah = new PreApproveAuditHandler();
		Data data = pah.getPreAuditId(conn, ri_id, audit_type, audit_level);
		String rau_id = data.getString("RAU_ID","");
		return rau_id;
	}

}
