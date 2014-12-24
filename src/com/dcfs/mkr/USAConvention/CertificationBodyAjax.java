/**   
 * @Title: CertificationBodyAjax.java 
 * @Package com.dcfs.mkr.USAConvention 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author panfeng   
 * @date 2014-9-9 ����4:21:06 
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
 * @Description: TODO(������һ�仰��������������) 
 * @author panfeng;
 * @date 2014-9-9 ����4:21:06 
 *  
 */
public class CertificationBodyAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(CertificationBodyAjax.class);

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
		String name = ServletTools.getParameter("name", request);
		String type = ServletTools.getParameter("type", request);
		try {
			
			conn = ConnectionManager.getConnection();
			this.setReturnValue(getBodyNameData(conn, name, type));
		} catch (Exception e){
			if (log.isError()) {
				log.logError("CertificationBodyAjax�����쳣:" + e.getMessage(), e);
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
						log.logError("CertificationBodyAjax��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return true;
	}
	
	/**
	 * @Title: getBodyNameData 
	 * @Description: ���ݻ������Ʋ�ѯ������Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param name
	 * @return
	 * @throws DBException    �趨�ļ� 
	 * @return    �������� 
	 * @throws
	 */
	public Data getBodyNameData(Connection conn, String name, String type) throws DBException{
		CertificationBodyHandler handler = new CertificationBodyHandler();
		return handler.getBodyNameData(conn, name, type);
	}

}
