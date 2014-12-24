/**   
 * @Title: FileAuditAjax.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author yangrt   
 * @date 2014-9-4 上午11:16:14 
 * @version V1.0   
 */
package com.dcfs.sce.publishManager;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/** 
 * @ClassName: PublishManagerAjax 
 * @Description: 儿童发布AJAX处理类
 * @author mayun
 * @date 2014-9-17
 *  
 */
public class PublishManagerAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(PublishManagerAjax.class);
	PublishManagerHandler handler = new PublishManagerHandler();

	public boolean run(HttpServletRequest request) {
		Connection conn=null;
		DataList returnDataList = new DataList();
		
		//接收参数值
		String method = ServletTools.getParameter("method", request);
		try {
			conn = ConnectionManager.getConnection();
			if("getAZQXInfo".equals(method)||"getAZQXInfo"==method){
				String is_df = ServletTools.getParameter("IS_DF", request,null);
				String pub_mode = ServletTools.getParameter("PUB_MODE", request,null);
				if("null".equals(pub_mode)||"null"==pub_mode){
					pub_mode=null;
				}
				returnDataList = this.getAZQXInfo(conn, is_df, null, pub_mode);
				JSONArray json = JSONArray.fromObject(returnDataList);
				this.setReturnValue(json.toString());
				
			}else if("isFB".equals(method)||"isFB"==method){
				String pub_id = ServletTools.getParameter("PUB_ID", request,null);
				boolean flag = this.isFB(conn, pub_id);
				Data data = new Data();
				data.add("FLAG", flag);
				JSONObject json = JSONObject.fromObject(data);
				this.setReturnValue(json.toString());
			}else if("isTH".equals(method)||"isTH"==method){
				String pub_id = ServletTools.getParameter("PUB_ID", request,null);
				boolean flag = this.isTH(conn, pub_id);
				Data data = new Data();
				data.add("FLAG", flag);
				JSONObject json = JSONObject.fromObject(data);
				this.setReturnValue(json.toString());
			}else if("isSD".equals(method)||"isSD"==method){
				String pub_id = ServletTools.getParameter("PUB_ID", request,null);
				boolean flag = this.isSD(conn, pub_id);
				Data data = new Data();
				data.add("FLAG", flag);
				JSONObject json = JSONObject.fromObject(data);
				this.setReturnValue(json.toString());
			}else if("getFbjlAndEtInfo".equals(method)||"getFbjlAndEtInfo"==method){
				String pub_id = ServletTools.getParameter("PUB_ID", request,null);
				Data data = this.getFbjlAndEtInfo(conn, pub_id);
				JSONObject json = JSONObject.fromObject(data);
				this.setReturnValue(json.toString());
			}
			
			
		} catch (Exception e){
			if (log.isError()) {
				log.logError("PublishManagerAjax操作异常:" + e.getMessage(), e);
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
						log.logError("PublishManagerAjax的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return true;
	}

	/**
	 * @Description: 根据文件点发类型,是否特别关注获得安置期限
	 * @author: mayun
	 * @param conn
	 * @param String is_df 是否点发 0:点发 1:群发
	 * @param String pub_mode 点发类型 1：对口帮扶;2：希望之旅;3：领导特批;4：夏令营冬令营
	 * @param String is_special 是否特别关注 0:特别关注  1:非特别关注
	 * @return DataList    
	 * @throws DBException
	 */
	private DataList getAZQXInfo(Connection conn,String is_df, String is_special,String pub_mode) throws DBException {
		return handler.getAZQXInfo(conn,is_df, is_special,pub_mode);
	}
	
	/**
	 * @Description: 根据发布记录主键ID，判断此发布状态是否为已发布
	 * @author: mayun
	 * @param conn
	 * @param String pub_id 发布主键ID
	 * @return boolean true:发布状态为“已发布”；false:发布状态不是已发布  
	 * @throws DBException
	 */
	private boolean isFB(Connection conn,String pub_id) throws DBException {
		return handler.isFB(conn,pub_id);
	}
	
	/**
	 * @Description: 根据发布记录主键ID，判断此退回状态是否为待确认或已确认
	 * @author: mayun
	 * @param conn
	 * @param String pub_id 发布主键ID
	 * @return boolean true:退回状态已是待确认或已确认；false:不存在退回申请 
	 * @throws DBException
	 */
	private boolean isTH(Connection conn,String pub_id) throws DBException {
		return handler.isTH(conn,pub_id);
	}
	
	/**
	 * @Description: 根据发布记录主键ID，判断此锁定状态是否为已锁定
	 * @author: mayun
	 * @param conn
	 * @param String pub_id 发布主键ID
	 * @return boolean true:锁定状态已是锁定  false:未锁定
	 * @throws DBException
	 */
	private boolean isSD(Connection conn,String pub_id) throws DBException {
		return handler.isSD(conn,pub_id);
	}
	
	/**
	 * 根据发布记录主键ID获得发布信息和儿童信息
	 * @description 
	 * @author MaYun
	 * @date Oct 20, 2014
	 * @return
	 */
	private Data getFbjlAndEtInfo(Connection conn,String pub_id)throws DBException{
		return handler.getEtAndFbInfo(conn, pub_id);
	}

}
