/**   
 * @Title: BGSFileSearchAction.java 
 * @Package com.dcfs.igq.fileSearch 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author panfeng   
 * @date 2014-9-17 上午10:59:29 
 * @version V1.0   
 */
package com.dcfs.igq.fileSearch;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;

import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;


/** 
 * @ClassName: BGSFileSearchAction 
 * @Description: 文件查询列表、查看、导出
 * @author panfeng 
 * @date 2014-9-17
 *  
 */
public class BGSFileSearchAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(BGSFileSearchAction.class);

    private BGSFileSearchHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private String retValue = SUCCESS;
    
    public BGSFileSearchAction(){
        this.handler=new BGSFileSearchHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * @Title: BGSFileList 
	 * @Description: 办公室、安置部、档案部、爱之桥文件查询列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String BGSFileList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="FILE_NO";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
				"COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","NAME",
				"AF_POSITION","AF_GLOBAL_STATE","FAMILY_TYPE","PROVINCE_ID","WELFARE_ID");
		String MALE_NAME = data.getString("MALE_NAME");
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.BGSFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: SHBFileList 
	 * @Description: 审核部文件查询列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String SHBFileList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="FAI.REG_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","FILE_NO","FILE_TYPE","REGISTER_DATE_START","REGISTER_DATE_END",
					"MALE_NAME","MALE_NATION","MALE_BIRTHDAY_START","MALE_BIRTHDAY_END","FEMALE_NAME","FEMALE_NATION",
					"FEMALE_BIRTHDAY_START","FEMALE_BIRTHDAY_END","COUNTRY_CODE","ADOPT_ORG_ID","FAMILY_TYPE","IS_CONVENTION_ADOPT");
		String MALE_NAME = data.getString("MALE_NAME");
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.SHBFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: showFileData 
	 * @Description: 查看文件详细信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String showFileData(){
		//获取文件id
		String file_id = getParameter("showuuid");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据文件id(file_id)获取该文件的详细信息
			Data data = handler.getFileData(conn,file_id);
			
			//根据儿童材料id获取儿童信息
			String ci_id = data.getString("CI_ID","");
			if(!"".equals(ci_id)){
				DataList dataList = handler.getChildDataList(conn, ci_id);
				setAttribute("List", dataList);
			}
			
			String file_type = data.getString("FILE_TYPE");	//文件类型
			String family_type = data.getString("FAMILY_TYPE");	//收养类型
			//根据文件类型(file_type)、收养类型(family_type)确定返回的页面
			if("33".equals(file_type)){
				retValue = "step";	//返回继子女收养查看页面
			}else{
				if("1".equals(family_type)){
					retValue = "double";	//返回双亲收养查看页面
				}else{
					retValue = "single";	//返回单亲收养查看页面
					String male_name = data.getString("MALE_NAME","");
					String female_name = data.getString("FEMALE_NAME","");
					if(male_name.equals("")){
						setAttribute("maleFlag", "false");
					}else{
						setAttribute("maleFlag", "true");
					}
					if(female_name.equals("")){
						setAttribute("femaleFlag", "false");
					}else{
						setAttribute("femaleFlag", "true");
					}
				}
			}
			
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID",""));
			setAttribute("CI_ID", ci_id);
			setAttribute("data", data);
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件详细信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取文件详细信息操作异常:" + e.getMessage(),e);
			}
		}finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: showSHBData 
	 * @Description: 查看文件详细信息（审核部）
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String showSHBData(){
		//获取文件id
		String file_id = getParameter("showuuid");
		String ri_id = getParameter("ri_id");
		if("null".equals(ri_id)){
			ri_id = "";
		}
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据文件id(file_id)获取该文件的详细信息
			Data data = handler.getFileData(conn,file_id);
			if(!"".equals(ri_id)){
				//根据预批id(ri_id)获取该文件的预批基本信息
				DataList riList = handler.getPreList(conn, ri_id);
				setAttribute("riList", riList);
			}
			
			//根据儿童材料id获取儿童信息
			String ci_id = data.getString("CI_ID","");
			if(!"".equals(ci_id)){
				DataList dataList = handler.getChildDataList(conn, ci_id);
				setAttribute("List", dataList);
			}
			
			String file_type = data.getString("FILE_TYPE");	//文件类型
			String family_type = data.getString("FAMILY_TYPE");	//收养类型
			//根据文件类型(file_type)、收养类型(family_type)确定返回的页面
			if("33".equals(file_type)){
				retValue = "step";	//返回继子女收养查看页面
			}else{
				if("1".equals(family_type)){
					retValue = "double";	//返回双亲收养查看页面
				}else{
					retValue = "single";	//返回单亲收养查看页面
					String male_name = data.getString("MALE_NAME","");
					String female_name = data.getString("FEMALE_NAME","");
					if(male_name.equals("")){
						setAttribute("maleFlag", "false");
					}else{
						setAttribute("maleFlag", "true");
					}
					if(female_name.equals("")){
						setAttribute("femaleFlag", "false");
					}else{
						setAttribute("femaleFlag", "true");
					}
				}
			}
			
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID",""));
			setAttribute("CI_ID", ci_id);
			setAttribute("RI_ID", ri_id);
			setAttribute("data", data);
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件详细信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取文件详细信息操作异常:" + e.getMessage(),e);
			}
		}finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return retValue;
	}
	
	
}
