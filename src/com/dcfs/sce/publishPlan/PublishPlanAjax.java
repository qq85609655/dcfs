package com.dcfs.sce.publishPlan;

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
 * @ClassName: PublishPlanManagerAjax 
 * @Description: 儿童发布计划AJAX处理类
 * @author mayun
 * @date 2014-9-17
 *  
 */
public class PublishPlanAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(PublishPlanAjax.class);
	PublishPlanHandler handler = new PublishPlanHandler();

	public boolean run(HttpServletRequest request) {
		Connection conn=null;
		
		//接收参数值
		String method = ServletTools.getParameter("method", request);
		try {
			conn = ConnectionManager.getConnection();
			if("isCanMakeNewPlan".equals(method)||"isCanMakeNewPlan"==method){
				
				boolean flag = this.isCanMakeNewPlan(conn);
				Data returnData =  new Data();
				returnData.add("FLAG", flag);
				JSONObject json = JSONObject.fromObject(returnData);
				this.setReturnValue(json.toString());
				
			}else if("isCanDeletePlan".equals(method)||"isCanDeletePlan"==method){
				String plan_id = getParameter("PLAN_ID", request);
				boolean flag = this.isCanDeletePlan(conn,plan_id);
				Data returnData =  new Data();
				returnData.add("FLAG", flag);
				JSONObject json = JSONObject.fromObject(returnData);
				this.setReturnValue(json.toString());
				
			}else if("isCanPublishPlan".equals(method)||"isCanPublishPlan"==method){
				String plan_id = getParameter("PLAN_ID", request);
				boolean flag = this.isCanPublishPlan(conn,plan_id);
				Data returnData =  new Data();
				returnData.add("FLAG", flag);
				JSONObject json = JSONObject.fromObject(returnData);
				this.setReturnValue(json.toString());
				
			}
			
			
		} catch (Exception e){
			if (log.isError()) {
				log.logError("PublishPlanAjax操作异常:" + e.getMessage(), e);
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
						log.logError("PublishPlanAjax的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return true;
	}

	/**
	 * 判断是否可以制定新的发布计划
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:不可以  true:可以
	 */
	private boolean isCanMakeNewPlan(Connection conn) throws DBException {
		return handler.isCanMakeNewPlan(conn);
	}
	
	/**
	 * 判断是否可以删除发布计划
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:不可以  true:可以
	 */
	private boolean isCanDeletePlan(Connection conn,String plan_id) throws DBException {
		return handler.isCanDeletePlan(conn,plan_id);
	}
	
	/**
	 * 判断是否可以发布该计划
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:不可以  true:可以
	 */
	private boolean isCanPublishPlan(Connection conn,String plan_id) throws DBException {
		return handler.isCanPublishPlan(conn,plan_id);
	}
	
	
	
	

}
