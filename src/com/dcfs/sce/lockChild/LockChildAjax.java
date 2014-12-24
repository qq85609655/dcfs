/**   
 * @Title: LockChildAjax.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: �жϸö�ͯ�Ƿ������� 
 * @author yangrt   
 * @date 2014-9-23 ����4:04:01 
 * @version V1.0   
 */
package com.dcfs.sce.lockChild;

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

import com.dcfs.sce.publishManager.PublishManagerConstant;

/** 
 * @ClassName: LockChildAjax 
 * @Description: �жϸö�ͯ�Ƿ������� 
 * @author yangrt;
 * @date 2014-9-23 ����4:04:01 
 *  
 */
public class LockChildAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(LockChildAjax.class);

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
		String ci_id = ServletTools.getParameter("ci_id", request);
		try {
			conn = ConnectionManager.getConnection();
			this.setReturnValue(isLock(conn,ci_id));
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
	 * @Title: getPubData 
	 * @Description: ���ݶ�ͯ����id,�жϸö�ͯ�Ƿ�������
	 * @author: yangrt
	 * @param conn
	 * @param ci_id
	 * @return DataList
	 * @throws DBException
	 */
	public String isLock(Connection conn, String ci_id) throws DBException{
		String retValue = "false";
		LockChildHandler handler = new LockChildHandler();
		Data data = handler.getMainChildInfo(conn, ci_id);
		if(data.getString("PUB_STATE","").equals(PublishManagerConstant.YSD)){
			retValue = "true";
		}
		
		return retValue;
		
	}

}
