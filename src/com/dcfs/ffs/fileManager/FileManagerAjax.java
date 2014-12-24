/**   
 * @Title: FileManagerAjax.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: 根据收养组织id、男收养人姓名、女收养人姓名查询文件信息
 * @author yangrt   
 * @date 2014-7-30 下午4:33:03 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

import com.dcfs.sce.preApproveApply.PreApproveApplyHandler;

/** 
 * @ClassName: FileManagerAjax 
 * @Description: 根据收养组织id、男收养人姓名、女收养人姓名查询文件信息
 * @author yangrt;
 * @date 2014-7-30 下午4:33:03 
 *  
 */
public class FileManagerAjax extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(FileManagerAjax.class);

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
		String method = ServletTools.getParameter("method", request, "");
		String name = ServletTools.getParameter("name", request, "");
		String ri_id = ServletTools.getParameter("ri_id", request, "");
		try {
			conn = ConnectionManager.getConnection();
			if("getFileData".equals(method)){
				//对参数进行两次解码
				name = java.net.URLDecoder.decode(java.net.URLDecoder.decode(name, "utf-8"),"utf-8");
				
				String adopt_org = name.split("#")[0];	//收养组织code
				String file_type = name.split("#")[3];	//文件类型code
				String malename = null;	//男收养人姓名
				String femalename = null;	//女收养人姓名
				if(!"".equals(name.split("#")[1])){
					malename = name.split("#")[1].toUpperCase();	//将男收养人转化为大写
				}
				if(!"".equals(name.split("#")[2])){
					femalename = name.split("#")[2].toUpperCase();	//将女收养人转化为大写
				}
				this.setReturnValue(getFileData(conn, adopt_org, file_type, malename, femalename));
			}else if("getSceReqRiState".equals(method)){
				this.setReturnValue(getSceReqRiState(conn, ri_id));
			}
			
		} catch (Exception e){
			if (log.isError()) {
				log.logError("FileManagerAjax操作异常:" + e.getMessage(), e);
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
						log.logError("FileManagerAjax的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return true;
	}
	
	/**
	 * @Title: getFileData 
	 * @Description: 根据收养组织id、男收养人姓名、女收养人姓名查询文件信息
	 * @author: yangrt
	 * @param conn
	 * @param adopt_org
	 * @param malename
	 * @param femalename
	 * @return Data
	 * @throws DBException 
	 * @throws ParseException 
	 */
	public Data getFileData(Connection conn, String adopt_org, String file_type, String malename, String femalename) throws DBException, ParseException{
		FileManagerHandler handler = new FileManagerHandler();
		Data data = new Data();
		data.add("ADOPT_ORG_ID", adopt_org);
		data.add("FILE_TYPE", file_type);
		data.add("MALE_NAME", malename);
		data.add("FEMALE_NAME", femalename);
		return handler.getNormalFileData(conn, data);
	}
	
	/**
	 * @Title: getFileRiState 
	 * @Description: 获取文件信息表中的预批状态
	 * @author: yangrt;
	 * @param conn
	 * @param af_id
	 * @return
	 * @throws DBException    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String getSceReqRiState(Connection conn, String ri_id) throws DBException{
		String retValue = "false";
		PreApproveApplyHandler handler = new PreApproveApplyHandler();
		Data data = handler.getPreApproveApplyData(conn, ri_id);
		int ri_state = data.getInt("RI_STATE");
		String af_id = data.getString("AF_ID","");
		if(ri_state == 4 && "".equals(af_id)){
			retValue = "true";
		}
		return retValue;
	}

}
