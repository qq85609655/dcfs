/**   
 * @Title: FileAuditAjax.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author yangrt   
 * @date 2014-9-4 ����11:16:14 
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
 * @Description: ��ͯ����AJAX������
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
		
		//���ղ���ֵ
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
				log.logError("PublishManagerAjax�����쳣:" + e.getMessage(), e);
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
						log.logError("PublishManagerAjax��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return true;
	}

	/**
	 * @Description: �����ļ��㷢����,�Ƿ��ر��ע��ð�������
	 * @author: mayun
	 * @param conn
	 * @param String is_df �Ƿ�㷢 0:�㷢 1:Ⱥ��
	 * @param String pub_mode �㷢���� 1���Կڰ��;2��ϣ��֮��;3���쵼����;4������Ӫ����Ӫ
	 * @param String is_special �Ƿ��ر��ע 0:�ر��ע  1:���ر��ע
	 * @return DataList    
	 * @throws DBException
	 */
	private DataList getAZQXInfo(Connection conn,String is_df, String is_special,String pub_mode) throws DBException {
		return handler.getAZQXInfo(conn,is_df, is_special,pub_mode);
	}
	
	/**
	 * @Description: ���ݷ�����¼����ID���жϴ˷���״̬�Ƿ�Ϊ�ѷ���
	 * @author: mayun
	 * @param conn
	 * @param String pub_id ��������ID
	 * @return boolean true:����״̬Ϊ���ѷ�������false:����״̬�����ѷ���  
	 * @throws DBException
	 */
	private boolean isFB(Connection conn,String pub_id) throws DBException {
		return handler.isFB(conn,pub_id);
	}
	
	/**
	 * @Description: ���ݷ�����¼����ID���жϴ��˻�״̬�Ƿ�Ϊ��ȷ�ϻ���ȷ��
	 * @author: mayun
	 * @param conn
	 * @param String pub_id ��������ID
	 * @return boolean true:�˻�״̬���Ǵ�ȷ�ϻ���ȷ�ϣ�false:�������˻����� 
	 * @throws DBException
	 */
	private boolean isTH(Connection conn,String pub_id) throws DBException {
		return handler.isTH(conn,pub_id);
	}
	
	/**
	 * @Description: ���ݷ�����¼����ID���жϴ�����״̬�Ƿ�Ϊ������
	 * @author: mayun
	 * @param conn
	 * @param String pub_id ��������ID
	 * @return boolean true:����״̬��������  false:δ����
	 * @throws DBException
	 */
	private boolean isSD(Connection conn,String pub_id) throws DBException {
		return handler.isSD(conn,pub_id);
	}
	
	/**
	 * ���ݷ�����¼����ID��÷�����Ϣ�Ͷ�ͯ��Ϣ
	 * @description 
	 * @author MaYun
	 * @date Oct 20, 2014
	 * @return
	 */
	private Data getFbjlAndEtInfo(Connection conn,String pub_id)throws DBException{
		return handler.getEtAndFbInfo(conn, pub_id);
	}

}
