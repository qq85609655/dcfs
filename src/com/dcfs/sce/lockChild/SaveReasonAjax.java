/**   
 * @Title: SaveReasonAjax.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: �����˻�ԭ��
 * @author yangrt   
 * @date 2014-9-26 ����11:41:02 
 * @version V1.0   
 */
package com.dcfs.sce.lockChild;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: SaveReasonAjax 
 * @Description: �����˻�ԭ��
 * @author yangrt;
 * @date 2014-9-26 ����11:41:02 
 *  
 */
public class SaveReasonAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(SaveReasonAjax.class);

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
		String pub_id = ServletTools.getParameter("PUB_ID", request);
		String reason = ServletTools.getParameter("RETURN_REASON", request);
		try {
			reason = java.net.URLDecoder.decode(reason,"utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		String[] pubId = pub_id.split(";");
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String personid = userinfo.getPersonId();
		String personEName = userinfo.getPerson().getEnName();
		String personCName = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		DataList datalist = new DataList();
		for(int i = 0; i < pubId.length; i++){
			Data data = new Data();
			data.add("PUB_ID", pubId[i]);
			data.add("RETURN_REASON", reason);
			data.add("RETURN_USERID", personid);
			if(personEName.equals("") || personEName.equals("null") || personEName == null){
				data.add("RETURN_USERNAME", personEName);
			}else{
				data.add("RETURN_USERNAME", personCName);
			}
			
			data.add("RETURN_DATE", curDate);	//�˻�����
			data.add("RETURN_TYPE", "1");	//�˻�����:��֯�˻أ�RETURN_TYPE��1��
			data.add("RETURN_STATE", "0");	//�˻�״̬����ȷ�ϣ�RETURN_STATE:0��
			datalist.add(data);
		}
		
		try {
			conn = ConnectionManager.getConnection();
			this.setReturnValue(ConsignReturnSave(conn,datalist));
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
						log.logError("SaveReasonAjax��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return true;
	}
	
	public String ConsignReturnSave(Connection conn, DataList datalist) {
		String retValue = null;
		DBTransaction dt = null;
		
		try {
			LockChildHandler handler = new LockChildHandler();
			dt = DBTransaction.getInstance(conn);
			boolean flag = handler.ConsignReturnSave(conn, datalist);
			if(flag){
				retValue = "true";
			}else{
				retValue = "false";
			}
			dt.commit();
		} catch (DBException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�����˻�ԭ�����]:" + e.getMessage(),e);
            }
            
            retValue = "false";
        } catch (SQLException e) {
        	//5�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
            }
            
            retValue = "false";
		}finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("SaveReasonAjax��ConsignReturnSave.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "false";
                }
            }
        }
		return retValue;
		
	}

}
