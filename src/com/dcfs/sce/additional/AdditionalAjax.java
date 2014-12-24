/**   
 * @Title: AdditionalAjax.java 
 * @Package com.dcfs.sce.additional 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author yangrt   
 * @date 2014-11-25 下午7:11:23 
 * @version V1.0   
 */
package com.dcfs.sce.additional;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

/** 
 * @ClassName: AdditionalAjax 
 * @Description: 获取该预批信息当前所处的审核环节 
 * @author yangrt;
 * @date 2014-11-25 下午7:11:23 
 *  
 */
public class AdditionalAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(AdditionalAjax.class);

	/* (非 Javadoc) 
	 * <p>Title: run</p> 
	 * <p>Description: </p> 
	 * @param request
	 * @return 
	 * @see hx.ajax.AjaxExecute#run(javax.servlet.http.HttpServletRequest) 
	 */
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn=null;
		//接收参数值
		String OperType = ServletTools.getParameter("OperType", request);		//审核操作类型：SHB,AZB
		String ri_id = ServletTools.getParameter("ri_id", request);				//预批申请记录id
		//String aud_state = ServletTools.getParameter("aud_state", request);	//预批申请记录中的审核部补充状态
		
		try {
			conn = ConnectionManager.getConnection();
			/*String audit_level  = null;
			if(aud_state.equals("0") || aud_state.equals("1") || aud_state.equals("9")){
				audit_level = "0";
			}else if(aud_state.equals("2")){
				audit_level = "1";
			}else if(aud_state.equals("3")){
				audit_level = "2";
			}
			this.setReturnValue(getPreApproveAuditInfo(conn, ri_id, audit_level));*/
			this.setReturnValue(getPreApproveAuditInfo(conn, ri_id, OperType));
			
		} catch (Exception e){
			if (log.isError()) {
				log.logError("FileAuditAjax操作异常:" + e.getMessage(), e);
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
						log.logError("FileAuditAjax的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return true;
	}
	
	/*public Data getPreApproveAuditInfo(Connection conn, String ri_id, String audit_level) throws DBException{
		AdditionalHandler ah = new AdditionalHandler();
		return ah.getPreApproveAuditInfo(conn, ri_id, audit_level);
		
	}*/
	public Data getPreApproveAuditInfo(Connection conn, String ri_id, String OperType) throws DBException{
		AdditionalHandler ah = new AdditionalHandler();
		return ah.getPreApproveAuditInfo(conn, ri_id, OperType);
		
	}
}
