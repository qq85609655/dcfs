/**   
 * @Title: CertificationBodyAjax.java 
 * @Package com.dcfs.mkr.USAConvention 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author panfeng   
 * @date 2014-9-9 下午4:21:06 
 * @version V1.0   
 */
package com.dcfs.mkr.USAConvention;

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
 * @ClassName: CertificationBodyAjax 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author panfeng;
 * @date 2014-9-9 下午4:21:06 
 *  
 */
public class CertificationBodyAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(CertificationBodyAjax.class);

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
		String name = ServletTools.getParameter("name", request);
		String type = ServletTools.getParameter("type", request);
		try {
			
			conn = ConnectionManager.getConnection();
			this.setReturnValue(getBodyNameData(conn, name, type));
		} catch (Exception e){
			if (log.isError()) {
				log.logError("CertificationBodyAjax操作异常:" + e.getMessage(), e);
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
						log.logError("CertificationBodyAjax的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return true;
	}
	
	/**
	 * @Title: getBodyNameData 
	 * @Description: 根据机构名称查询机构信息
	 * @author: panfeng;
	 * @param conn
	 * @param name
	 * @return
	 * @throws DBException    设定文件 
	 * @return    返回类型 
	 * @throws
	 */
	public Data getBodyNameData(Connection conn, String name, String type) throws DBException{
		CertificationBodyHandler handler = new CertificationBodyHandler();
		return handler.getBodyNameData(conn, name, type);
	}

}
