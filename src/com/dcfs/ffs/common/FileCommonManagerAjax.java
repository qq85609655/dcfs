package com.dcfs.ffs.common;

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
 * 文件办理公共Ajax处理类
 * @author mayun
 * @date 2014-7-24
 * @version 1.0
 */
public class FileCommonManagerAjax extends AjaxExecute {

	private static Log log = UtilLog.getLog(FileCommonManagerAjax.class);
	FileCommonManagerHandler handler=new FileCommonManagerHandler();
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn = null;
		DBTransaction dt = null;
		boolean returnFlag = true;
		String method=ServletTools.getParameter("method", request, "");
		String countryCode=ServletTools.getParameter("countryCode", request, "");//国家代码
		String fileNo=ServletTools.getParameter("fileNo", request, "");//收文编号
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			DataList dl= new DataList();
			Data data = new Data();
			if(method.equals("findSyzzNameList")){//得到收养组织名称LIST
				dl = this.findSyzzNameList(conn,countryCode);
				JSONArray json = JSONArray.fromObject(dl);
				setReturnValue(json.toString());
			}else if(method.equals("getFileInfo")){//获取收养文件基本信息
				data = this.getFileInfo(fileNo, conn);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}else if(method.equals("getAfCost")){//根据文件类型获取应缴费用
				String file_type=ServletTools.getParameter("file_type", request, "");//文件类型
				data = this.getAfCost(conn, file_type);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}
			//dt.commit();
		} catch (Exception e) {
			try {
				dt.rollback();
				returnFlag=false;
				setReturnValue("FileCommonManagerAjax异常,请联系管理员");
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
                        log.logError("FileCommonManagerAjax的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		
		return returnFlag;
	}
	
	
	/**
	 * 根据国家代码得到收养组织名称List
	 * @param conn
	 * @return
	 */
	public DataList findSyzzNameList(Connection conn,String countryCode){
		DataList dl = new DataList();
		try {
			dl = handler.getSyzzNameListByCodeTable(conn,countryCode);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileCommonManagerAjax的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		return dl;
	}
	
	/**
	 * 根据收文编号获取收养文件基本信息
	 * @description 
	 * @author MaYun
	 * @date Aug 6, 2014
	 * @param Connection conn 数据库连接池，非必填参数
	 * @param Stirng fileNO 收文编号，必填参数
	 * @return Data fileData
	 */
	public Data getFileInfo(String fileNO,Connection conn){
		Data data = new Data();
		try {
			data = handler.getFileInfo(fileNO, conn);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileCommonManagerAjax的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		return data;
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: getAfCost 
	 * @Description: 根据文件类型获取文件应缴费用
	 * @author: yangrt
	 * @param conn
	 * @param file_type
	 * 		"ZCWJFWF" : 800
	 * 		"TXWJFWF" : 500
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data getAfCost(Connection conn,String file_type){
		Data data = new Data();
		try {
			data = handler.getAfCost(conn,file_type);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileCommonManagerAjax的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		return data;
	}
	



	
}



