/**   
 * @Title: LockRecordsAjax.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: �жϵ�ǰ������֯�ڽ�ʮ����֮��ʱ���й������ö�ͯ�ļ�¼
 * @author yangrt   
 * @date 2014-10-16 ����5:54:45 
 * @version V1.0   
 */
package com.dcfs.sce.lockChild;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

/** 
 * @ClassName: LockRecordsAjax 
 * @Description: �жϵ�ǰ������֯�ڽ�ʮ����֮��ʱ���й������ö�ͯ�ļ�¼
 * @author yangrt;
 * @date 2014-10-16 ����5:54:45 
 *  
 */
public class LockRecordsAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(LockRecordsAjax.class);

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
		String ci_id = ServletTools.getParameter("CI_ID", request);	//��ͯ����id
		try {
			conn = ConnectionManager.getConnection();
			String retValue = getLockRecords(conn,ci_id);
			this.setReturnValue(retValue);
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
	
	public String getLockRecords(Connection conn, String ci_id) throws DBException{
		LockChildHandler handler = new LockChildHandler();
		DataList dl = handler.getLockRecords(conn,ci_id);
		String retValue = "false";
		if(dl.size() > 0){
			retValue = "true";
		}
		return retValue;
	}

}
