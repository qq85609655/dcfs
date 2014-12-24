/**   
 * @Title: SaveReasonAjax.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: 保存退回原因
 * @author yangrt   
 * @date 2014-9-26 上午11:41:02 
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
 * @Description: 保存退回原因
 * @author yangrt;
 * @date 2014-9-26 上午11:41:02 
 *  
 */
public class SaveReasonAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(SaveReasonAjax.class);

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
			
			data.add("RETURN_DATE", curDate);	//退回日期
			data.add("RETURN_TYPE", "1");	//退回类型:组织退回（RETURN_TYPE：1）
			data.add("RETURN_STATE", "0");	//退回状态：待确认（RETURN_STATE:0）
			datalist.add(data);
		}
		
		try {
			conn = ConnectionManager.getConnection();
			this.setReturnValue(ConsignReturnSave(conn,datalist));
		} catch (Exception e){
			if (log.isError()) {
				log.logError("LockChildAjax操作异常:" + e.getMessage(), e);
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
						log.logError("SaveReasonAjax的Connection因出现异常，未能关闭",e);
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
                log.logError("操作异常[保存退回原因操作]:" + e.getMessage(),e);
            }
            
            retValue = "false";
        } catch (SQLException e) {
        	//5设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            
            retValue = "false";
		}finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("SaveReasonAjax的ConsignReturnSave.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "false";
                }
            }
        }
		return retValue;
		
	}

}
