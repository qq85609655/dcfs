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
 * @Description: ��ͯ�����ƻ�AJAX������
 * @author mayun
 * @date 2014-9-17
 *  
 */
public class PublishPlanAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(PublishPlanAjax.class);
	PublishPlanHandler handler = new PublishPlanHandler();

	public boolean run(HttpServletRequest request) {
		Connection conn=null;
		
		//���ղ���ֵ
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
				log.logError("PublishPlanAjax�����쳣:" + e.getMessage(), e);
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
						log.logError("PublishPlanAjax��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return true;
	}

	/**
	 * �ж��Ƿ�����ƶ��µķ����ƻ�
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:������  true:����
	 */
	private boolean isCanMakeNewPlan(Connection conn) throws DBException {
		return handler.isCanMakeNewPlan(conn);
	}
	
	/**
	 * �ж��Ƿ����ɾ�������ƻ�
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:������  true:����
	 */
	private boolean isCanDeletePlan(Connection conn,String plan_id) throws DBException {
		return handler.isCanDeletePlan(conn,plan_id);
	}
	
	/**
	 * �ж��Ƿ���Է����üƻ�
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:������  true:����
	 */
	private boolean isCanPublishPlan(Connection conn,String plan_id) throws DBException {
		return handler.isCanPublishPlan(conn,plan_id);
	}
	
	
	
	

}
