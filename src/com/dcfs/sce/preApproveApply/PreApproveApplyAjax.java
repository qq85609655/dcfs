/**   
 * @Title: LockChildAjax.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: �жϸö�ͯ�Ƿ������� 
 * @author yangrt   
 * @date 2014-9-23 ����4:04:01 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveApply;

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

import com.dcfs.sce.preApproveAudit.PreApproveAuditHandler;

/** 
 * @ClassName: LockChildAjax 
 * @Description: �жϸö�ͯ�Ƿ������� 
 * @author yangrt;
 * @date 2014-9-23 ����4:04:01 
 *  
 */
public class PreApproveApplyAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(PreApproveApplyAjax.class);

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
		String type = ServletTools.getParameter("type", request);
		String req_no = ServletTools.getParameter("REQ_NO", request);
		try {
			conn = ConnectionManager.getConnection();
			this.setReturnValue(isSubmitFile(conn,req_no,type));
		} catch (Exception e){
			if (log.isError()) {
				log.logError("LockChildAjax�����쳣:" + e.getMessage(), e);
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
						log.logError("LockChildAjax��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return true;
	}
	
	/**
	 * @Title: isSubmitFile 
	 * @Description: ����Ԥ��������req_no,�ж�֮ǰԤ���Ƿ����ύ�ļ�
	 * @author: yangrt
	 * @param conn
	 * @param req_no
	 * @return String
	 * @throws DBException
	 */
	public String isSubmitFile(Connection conn, String req_no, String type) throws DBException{
		String retValue = "true";
		PreApproveAuditHandler handler = new PreApproveAuditHandler();
		Data data = handler.getPreApproveByReqNo(conn, req_no);
		if("file".equals(type)){
			if(data.getInt("RI_STATE") < 4){
				retValue = "false";
			}
		}else{
			if(!"".equals(data.getString("AF_ID",""))){
				retValue = "false";
			}
		}
		
		return retValue;
	}

}
