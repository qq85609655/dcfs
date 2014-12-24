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
 * 审核意见模板Ajax处理类
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
		String type=ServletTools.getParameter("TYPE", request, "");//类别
		String gy_type=ServletTools.getParameter("GY_TYPE", request, "");//公约类型
		String audit_type=ServletTools.getParameter("AUDIT_TYPE", request, "");//审核级别
		if("null".equals(gy_type)||"".equals(gy_type)){
			gy_type=null;
		}
		if("null".equals(audit_type)||"".equals(audit_type)){
			audit_type=null;
		}
		String audit_option=ServletTools.getParameter("AUDIT_OPTION", request, "");//审核意见
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			DataList dl= new DataList();
			Data data = new Data();
			if(method.equals("getAuditModelContent")){//根据类别、公约类型、审核级别、审核意见获得审核意见模板内容
				data = this.getAuditModelContent(conn, type, gy_type,audit_type, audit_option);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}
			dt.commit();
		} catch (Exception e) {
			try {
				dt.rollback();
				returnFlag=false;
				setReturnValue("OpinionTemAjax异常,请联系管理员");
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
                        log.logError("OpinionTemAjax的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		
		return returnFlag;
	}
	
	
	
	
	/**
	 * 根据类别、审核级别、审核意见获得审核意见模板内容
	 * @description 
	 * @author MaYun
	 * @date 2014-8-19
	 * @param Connection conn 
	 * @param String type 类别(文件审核：00,审核部预批：10,安置部预批：11)
	 * @param String gy_type 公约类型(0：非公约;1:公约)
	 * @param String audit_type 审核级别(初审：0,复审：1,审批：2)
	 * @param String audit_option 审核意见(参照com.dcfs.ffs.audit.FileAuditConstant.java常量类定义)
	 * @return Data fileData
	 * @throws DBException 
	 */
	public Data getAuditModelContent(Connection conn,String type,String gy_type,String audit_type,String audit_option) throws DBException{
		Data data = new Data();
		data = handler.getAuditModelContent(conn,type,gy_type,audit_type,audit_option);
		return data;
	}
	



	
}



