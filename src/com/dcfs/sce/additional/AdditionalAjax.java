/**   
 * @Title: AdditionalAjax.java 
 * @Package com.dcfs.sce.additional 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author yangrt   
 * @date 2014-11-25 ����7:11:23 
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
 * @Description: ��ȡ��Ԥ����Ϣ��ǰ��������˻��� 
 * @author yangrt;
 * @date 2014-11-25 ����7:11:23 
 *  
 */
public class AdditionalAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(AdditionalAjax.class);

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
		String OperType = ServletTools.getParameter("OperType", request);		//��˲������ͣ�SHB,AZB
		String ri_id = ServletTools.getParameter("ri_id", request);				//Ԥ�������¼id
		//String aud_state = ServletTools.getParameter("aud_state", request);	//Ԥ�������¼�е���˲�����״̬
		
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
	
	/*public Data getPreApproveAuditInfo(Connection conn, String ri_id, String audit_level) throws DBException{
		AdditionalHandler ah = new AdditionalHandler();
		return ah.getPreApproveAuditInfo(conn, ri_id, audit_level);
		
	}*/
	public Data getPreApproveAuditInfo(Connection conn, String ri_id, String OperType) throws DBException{
		AdditionalHandler ah = new AdditionalHandler();
		return ah.getPreApproveAuditInfo(conn, ri_id, OperType);
		
	}
}
