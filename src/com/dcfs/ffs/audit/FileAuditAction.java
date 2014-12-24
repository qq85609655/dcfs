/**   
 * @Title: FileAuditAction.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午5:09:50 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;


import com.dcfs.common.DcfsConstants;
import com.dcfs.common.PropertiesUtil;
import com.dcfs.common.ModifyHistoryConfig;
import com.dcfs.common.ModifyHistoryHandler;
import com.dcfs.common.StringUtil;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.translation.FfsAfTranslationHandler;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.excelexport.ExcelExporter;
import com.hx.framework.util.UtilDate;
import com.hx.upload.sdk.AttHelper;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

/**
 * @ClassName: FileAuditAction
 * @Description: 家庭文件审核
 * @author mayun
 * @date 2014-8-14
 *
 */
public class FileAuditAction extends BaseAction {

	private static Log log=UtilLog.getLog(FileAuditAction.class);
	private Connection conn = null;
	private FileAuditHandler handler;
	private FfsAfTranslationHandler ffsAfTranslationHandler;
	private ModifyHistoryHandler modifyHistoryHandler;
    private DBTransaction dt = null;//事务处理
	private String retValue = SUCCESS;


	public FileAuditAction() {
		this.handler=new FileAuditHandler();
		this.ffsAfTranslationHandler=new FfsAfTranslationHandler();
		this.modifyHistoryHandler=new ModifyHistoryHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}



	/**
	 * 经办人审核列表	
	 * @description 
	 * @author MaYun
	 * @date Aug 7, 2014
	 * @return
	 */
	public String findListForOneLevel(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			//compositor="FILE_NO,AUD_STATE";
			compositor=null;
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			//ordertype="asc";
			ordertype=null;
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","FILE_NO","RECEIVER_DATE_START","RECEIVER_DATE_END","COUNTRY_CODE","FILE_TYPE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","TRANSLATION_QUALITY","AUD_STATE","AA_STATUS","RTRANSLATION_STATE","ATRANSLATION_STATE");
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findListForOneLevel(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件经办人审核查询操作异常");
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
						log.logError("FileAuditAction的findListForOneLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * 跳转到经办人审核详细页面
	 * @author Mayun
	 * @date 2014-8-12
	 * @return
	 */
	public String toAuditForOneLevel(){
		String flag = getParameter("FLAG");	//判断是否是补翻查询、重翻查询中的审核
		String af_id = getParameter("AF_ID","");//文件主键ID
		String au_id = getParameter("AU_ID","");//审核记录主键ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		
		
		Connection conn = null;
		Data fileData = new Data();//文件基本信息
		Data auditData = new Data();//审核基本信息
		Data fyData = new Data();//翻译基本信息
		Data bcData = new Data();//文件补充信息
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			bcData = handler.getBCFileInfoById(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//文件补充次数
			
			fyData = this.ffsAfTranslationHandler.getFyDataByAFID(conn, af_id);
			
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件经办人审核详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的toAuditForOneLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("fyData", fyData);
		setAttribute("bcData", bcData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		returnData.addData(bcData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * 跳转到经办人审核详细页面（查看页面）
	 * @author Mayun
	 * @date 2014-8-12
	 * @return
	 */
	public String toAuditForOneLevelView(){
		String flag = getParameter("FLAG");	//判断是否是补番查询、重返查询中的审核
		String af_id = getParameter("AF_ID","");//文件主键ID
		String au_id = getParameter("AU_ID","");//审核记录主键ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		
		
		Connection conn = null;
		Data fileData = new Data();//文件基本信息
		Data auditData = new Data();//审核基本信息
		Data fyData = new Data();//翻译基本信息
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			//auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//文件补充次数
			
			fyData = this.ffsAfTranslationHandler.getFyDataByAFID(conn, af_id);
			
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件经办人审核详细页面查看异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的toAuditForOneLevelView.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("fyData", fyData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * 部门主任复核列表	
	 * @description 
	 * @author MaYun
	 * @date 2014-8-27
	 * @return
	 */
	public String findListForTwoLevel(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			//compositor="FILE_NO,AUD_STATE";
			compositor=null;
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			//ordertype="asc";
			ordertype=null;
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","FILE_NO","RECEIVER_DATE_START","RECEIVER_DATE_END","COUNTRY_CODE","FILE_TYPE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","TRANSLATION_QUALITY","AUD_STATE","AA_STATUS","RTRANSLATION_STATE");
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findListForTwoLevel(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "部门主任复核查询操作异常");
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
						log.logError("FileAuditAction的findListForTwoLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * 跳转到部门主任审核详细页面
	 * @author Mayun
	 * @date 2014-8-27
	 * @return
	 */
	public String toAuditForTwoLevel(){
		String flag = getParameter("FLAG");	//判断是否是补番查询、重返查询中的审核
		String af_id = getParameter("AF_ID","");//文件主键ID
		String au_id = getParameter("AU_ID","");//审核记录主键ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//文件基本信息
		Data auditData = new Data();//部门主任复基本信息
		Data jbrData = new Data();//经办人审核基本信息
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//文件补充次数
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "0");//获得经办人最终的审核信息
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件部门主任审核详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的toAuditForTwoLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * 跳转到部门主任审核详细页面(查看页面)
	 * @author Mayun
	 * @date 2014-8-27
	 * @return
	 */
	public String toAuditForTwoLevelView(){
		String flag = getParameter("FLAG");	//判断是否是补番查询、重返查询中的审核
		String af_id = getParameter("AF_ID","");//文件主键ID
		String au_id = getParameter("AU_ID","");//审核记录主键ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//文件基本信息
		Data auditData = new Data();//部门主任复基本信息
		Data jbrData = new Data();//经办人审核基本信息
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			//auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//文件补充次数
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "0");//获得经办人最终的审核信息
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件部门主任审核详细页面查看异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的toAuditForTwoLevelView.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * 分管主任审批列表	
	 * @description 
	 * @author MaYun
	 * @date 2014-8-29
	 * @return
	 */
	public String findListForThreeLevel(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			//compositor="FILE_NO,AUD_STATE";
			compositor=null;
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			//ordertype="asc";
			ordertype=null;
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","FILE_NO","RECEIVER_DATE_START","RECEIVER_DATE_END","COUNTRY_CODE","FILE_TYPE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","TRANSLATION_QUALITY","AUD_STATE","AA_STATUS","RTRANSLATION_STATE");
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findListForThreeLevel(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "部门主任复核查询操作异常");
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
						log.logError("FileAuditAction的findListForThreeLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * 跳转到分管主任审批详细页面
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String toAuditForThreeLevel(){
		String flag = getParameter("FLAG");	//判断是否是补番查询、重返查询中的审核
		String af_id = getParameter("AF_ID","");//文件主键ID
		String au_id = getParameter("AU_ID","");//审核记录主键ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//文件基本信息
		Data auditData = new Data();//分管主任审批基本信息
		Data jbrData = new Data();//部门主任审核基本信息
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//文件补充次数
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "1");//获得部门主任最终的审核信息
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件分管主任审批详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的toAuditForThreeLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * 跳转到分管主任审批详细页面（查看页面）
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String toAuditForThreeLevelView(){
		String flag = getParameter("FLAG");	//判断是否是补番查询、重返查询中的审核
		String af_id = getParameter("AF_ID","");//文件主键ID
		String au_id = getParameter("AU_ID","");//审核记录主键ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//文件基本信息
		Data auditData = new Data();//分管主任审批基本信息
		Data jbrData = new Data();//部门主任审核基本信息
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			//auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//文件补充次数
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "1");//获得部门主任最终的审核信息
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件分管主任审批详细页面查看异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的toAuditForThreeLevelView.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * 获得审核记录List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findAuditList(){
		String af_id = getParameter("AF_ID","");//文件主键ID
		Connection conn = null;
		DataList auditList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			auditList = handler.findAuditList(conn, af_id);
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审核记录列表查询异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的findAuditList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("List", auditList);
		return retValue;
	}
	
	/**
	 * 文件补充记录List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findBcRecordList(){
		String af_id = getParameter("AF_ID","");//文件主键ID
		Connection conn = null;
		DataList list = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			list = handler.findBcRecordList(conn, af_id);
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件补充记录列表查询异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的findBcRecordList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("bcFileList", list);
		return retValue;
	}
	
	/**
	 * 文件修改记录List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findReviseList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor=null;
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype=" order by UPDATE_DATE desc ,REVISE_USERNAME asc,UPDATE_FIELD asc";
		}
		
		String af_id = getParameter("AF_ID","");//文件主键ID
		Connection conn = null;
		PropertiesUtil propertiesUtil = new PropertiesUtil();
		DataList list = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			list = handler.findReviseList(conn, af_id,pageSize,page,compositor,ordertype);
			if(list.size()>0){
	            for(int i=0;i<list.size();i++){
	                Data data=list.getData(i);
	                String colName=data.getString("UPDATE_FIELD");
	                //历史流程修改字段显示中文名称
	                data.add("UPDATE_FIELD",ModifyHistoryConfig.getShowstring(colName,"filemodifyhistory-config"));
	                
	                //******历史留痕处理码表显示begin******
	                String oldTempValue = data.getString("ORIGINAL_DATA");
	                String newTempValue = data.getString("UPDATE_DATA");
	                String codeName = propertiesUtil.readValue("filemodifyhistorycodename-config.properties",colName);
	                if(!"".equals(codeName)&&null!=codeName){
	                	String oldCodeValue = UtilCode.getCodeName(codeName, oldTempValue);
		                String newCodeValue = UtilCode.getCodeName(codeName, newTempValue);
		                data.add("ORIGINAL_DATA", oldCodeValue);
		                data.add("UPDATE_DATA", newCodeValue);
	                }
	              //******历史留痕处理码表显示end******
	                
	            }
		    }

		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件修改记录列表查询异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的findReviseList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("List", list);
		setAttribute("AF_ID", af_id);
		setAttribute("compositor",compositor);
		setAttribute("ordertype",ordertype);
		return retValue;
	}
	
	/**
	 * 预批审核信息以及锁定儿童基本信息List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findYpshAndEtInfoList(){
		
		String af_id = getParameter("AF_ID","");//文件主键ID
		Connection conn = null;
		DataList etlist = new DataList();//儿童DataList
		DataList ypshlist = new DataList();//预批审核DataList
		try {
			conn = ConnectionManager.getConnection();
			Data fileInfoData = handler.getFileInfoByID(conn, af_id);
			String ciId = fileInfoData.getString("CI_ID");//儿童材料ID
			String riId = fileInfoData.getString("RI_ID");//预批记录ID
			
			ciId = StringUtil.convertSqlString(ciId);
			riId = StringUtil.convertSqlString(riId);
			if(!"".equals(ciId)&&null!=ciId){
				etlist = handler.findETInfoList(conn, ciId);
			}
			if(!"".equals(riId)&&null!=riId){
				ypshlist = handler.findYPSHInfoList(conn, riId);
			}

		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批审核信息以及锁定儿童基本信息");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的findYpshAndEtInfoList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("etList", etlist);
		setAttribute("ypshList", ypshlist);
		setAttribute("AF_ID", af_id);
		return retValue;
	}
	
	/**
	 * 文件翻译记录List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findTranslationList(){
		String af_id = getParameter("AF_ID","");//文件主键ID
		Connection conn = null;
		DataList list = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			list = handler.findTranslationList(conn, af_id);
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件翻译记录列表查询异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的findTranslationList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("List", list);
		return retValue;
	}
	
	/**
	 * 保存文件基本信息
	 * @description 
	 * @author MaYun
	 * @date Oct 28, 2014
	 * @return
	 * @throws DBException 
	 */
	public void saveFileInfo(Connection conn) throws DBException{
		
	 	Data newFileData = new Data();//新数据
	 	
	 	newFileData = getRequestEntityData("FE_","AF_ID","ADOPTER_SEX","MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO",
		"MALE_EDUCATION","MALE_JOB_CN","MALE_JOB_EN","MALE_HEALTH","MALE_HEALTH_CONTENT_CN","MALE_HEALTH_CONTENT_EN","MEASUREMENT","MALE_HEIGHT",
	 	"MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_CN","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_CN","MALE_ILLEGALACT_EN","MALE_RELIGION_CN",
	 	"MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_CN",
	 	"FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_CN","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT","FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_CN","FEMALE_PUNISHMENT_EN",
	 	"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_CN","FEMALE_ILLEGALACT_EN","FEMALE_RELIGION_CN","FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
	 	"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_CN","ADOPT_REQUEST_EN","FINISH_DATE",
	 	"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","IS_MEDICALRECOVERY","MEDICALRECOVERY_CN","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON","IS_SUBMIT_REPORT",
	 	"IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_CN","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","PARENTING","SOCIALWORKER","REMARK_CN","REMARK_EN","GOVERN_DATE","VALID_PERIOD","EXPIRE_DATE",
	 	"APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX","CHILDREN_HEALTH_CN","CHILDREN_HEALTH_EN","PACKAGE_ID","PACKAGE_ID_CN","IS_CONVENTION_ADOPT");
	 	
	 	String af_id = newFileData.getString("AF_ID");//文件主键ID
	 	
	 	newFileData = formatFileData(newFileData);
	 	
	 	 //将收养人地址转化大写
        if(!("".equals(newFileData.getString("ADDRESS"))) && newFileData.getString("ADDRESS")!=null){
        	newFileData.put("ADDRESS", newFileData.getString("ADDRESS").toUpperCase());
        }
        
        //将男、女收养人姓名转化为大写
        if(!("".equals(newFileData.getString("MALE_NAME"))) && newFileData.getString("MALE_NAME")!=null){
        	newFileData.put("MALE_NAME", newFileData.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(newFileData.getString("FEMALE_NAME")))&& newFileData.getString("FEMALE_NAME")!=null){
        	newFileData.put("FEMALE_NAME", newFileData.getString("FEMALE_NAME").toUpperCase());
        }
        
      //根据有效期限值计算具体的截止日期
		String valid_period = newFileData.getString("VALID_PERIOD","");
		if("-1".equals(valid_period)){
			newFileData.add("EXPIRE_DATE", "2999-12-31");
		}else{
			if(!("".equals(valid_period))){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.MONTH, Integer.parseInt(valid_period));
				cal.add(Calendar.DATE, -1);
				newFileData.add("EXPIRE_DATE", sdf.format(cal.getTime()));
			}
		}



	 	//保存文件基本信息
	 	this.handler.saveFileInfo(conn, newFileData);
	 	//发布附件
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID"),"AF");  
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID_CN"),"AF");  
		
		
	}
	
	/**
	 * 保存文件基本信息，并进行历史留痕
	 * @description 
	 * @author MaYun
	 * @date Oct 28, 2014
	 * @return
	 * @throws DBException 
	 */
	public void saveFileInfoAndHistroyInfo(Connection conn) throws DBException{
		
	 	Data newFileData = new Data();//新数据
	 	Data oldFileData = new Data();//老数据
	 	
	 	newFileData = getRequestEntityData("FE_","AF_ID","ADOPTER_SEX","MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO",
		"MALE_EDUCATION","MALE_JOB_CN","MALE_JOB_EN","MALE_HEALTH","MALE_HEALTH_CONTENT_CN","MALE_HEALTH_CONTENT_EN","MEASUREMENT","MALE_HEIGHT",
	 	"MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_CN","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_CN","MALE_ILLEGALACT_EN","MALE_RELIGION_CN",
	 	"MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_CN",
	 	"FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_CN","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT","FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_CN","FEMALE_PUNISHMENT_EN",
	 	"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_CN","FEMALE_ILLEGALACT_EN","FEMALE_RELIGION_CN","FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
	 	"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_CN","ADOPT_REQUEST_EN","FINISH_DATE",
	 	"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","IS_MEDICALRECOVERY","MEDICALRECOVERY_CN","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON","IS_SUBMIT_REPORT",
	 	"IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_CN","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","PARENTING","SOCIALWORKER","REMARK_CN","REMARK_EN","GOVERN_DATE","VALID_PERIOD","EXPIRE_DATE",
	 	"APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX","CHILDREN_HEALTH_CN","CHILDREN_HEALTH_EN","PACKAGE_ID","PACKAGE_ID_CN","IS_CONVENTION_ADOPT");
	 	
	 	String af_id = newFileData.getString("AF_ID");//文件主键ID
	 	
	 	//*****获得原始数据，并对新数据进行历史留痕保存操作begin**********
	 	oldFileData = this.modifyHistoryHandler.getOriginalData(conn, "FFS_AF_INFO", "AF_ID", af_id);
	 	newFileData = formatFileData(newFileData);
	 	this.modifyHistoryHandler.savehistory(conn, oldFileData, newFileData, "FFS_AF_REVISE", "AR_ID", "AF_ID", af_id, "2");
	 	//*****获得原始数据，并对新数据进行历史留痕保存操作end************
	 	//保存文件基本信息
	 	this.handler.saveFileInfo(conn, newFileData);
	 	//发布附件
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID"),"AF");  
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID_CN"),"AF");  
		
		
	}
	
	/**
	 * 格式化数据类型，如日期型字段有值则补齐时分秒
	 * @param fileData
	 * @return
	 */
	private Data formatFileData(Data fileData){
		String formatDateField = ",MALE_BIRTHDAY," +//收养人出生日期
				"FEMALE_BIRTHDAY," +//收养人出生日期
				"MARRY_DATE," +		//结婚日期
				"FINISH_DATE," +		//家庭调查报告完成日期
				"GOVERN_DATE,";		//政府批准日期
		String dateFormatStr = " 00:00:00";
		
		Set keysSet = fileData.keySet();
	    Iterator iterator = keysSet.iterator();
	    while(iterator.hasNext()) {
	    	 Object key = iterator.next();//key
	    	 String strKey = ","+key.toString()+",";
	    	 if(formatDateField.indexOf(strKey)>-1){
	    		 String newValue = fileData.getString(key);
	    		 if(newValue!=null && newValue.length()==10){
	    			 newValue += dateFormatStr;
	    		 }
	    		 fileData.put(key.toString(), newValue);	    		 
	    	 }
	    	 
	    }
		return fileData;
	}

	
	/**
	 * 文件审核保存
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String saveForOneLevel(){
		String curDate = DateUtility.getCurrentDateTime();//获得当前日期
		//文件信息
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON");
		//审核信息
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		fileData.add("AUD_STATE", "1");//经办人审核中
		auditData.add("AUDIT_DATE", curDate);
		auditData.add("OPERATION_STATE", "1");//操作状态为：处理中
		
		Connection conn = null;
		try {
			
			//根据操作类型获得下一环节文件的全局状态和文件位置
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_SB_SAVE);
			
			fileData.addData(globalData);
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//保存文件基本信息（中文、外文）
            //saveFileInfoAndHistroyInfo(conn);//保存文件基本信息（中文、外文），并进行历史留痕
            handler.saveAuditInfo(conn, auditData);
            handler.saveFileInfo(conn, fileData);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//提交成功 0
            setAttribute("clueTo", clueTo);
            
		} catch (DBException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审核保存或提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审核保存或提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (Exception e ){
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审核保存或提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的saveForOneLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("AF_ID", fileData.getString("AF_ID"));
		setAttribute("AU_ID", auditData.getString("AU_ID"));
		if(!"".equals(getParameter("FLAG"))){
			setAttribute("FLAG", getParameter("FLAG"));
		}
		return retValue;
	}
	
	
	/**
	 * 经办人文件审核提交
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String submitForOneLevel(){
		retValue += getParameter("FLAG","");	//判断是否是补番查询、重返查询中的审核
		String curDate = DateUtility.getCurrentDateTime();//获得当前日期
		//文件信息
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON","AA_ID");
		//审核信息
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		//文件补充信息
		Data addData = getRequestEntityData("ADD_", "SEND_USERID","NOTICE_CONTENT","IS_MODIFY","IS_ADDATTACH","SEND_USERNAME","NOTICE_DATE");
		//文件补充翻译信息
		Data aaData = getRequestEntityData("TRA_", "NOTICE_USERID","TRANSLATION_TYPE","AA_CONTENT","SEND_USERNAME","NOTICE_DATE","NOTICE_FILEID");
		//文件重翻信息
		Data cfData = getRequestEntityData("TRAN_", "NOTICE_USERID","TRANSLATION_TYPE","AA_CONTENT","SEND_USERNAME","NOTICE_DATE");
		
		
		auditData.add("AUDIT_DATE", curDate);//审核日期
		String auditOption = auditData.getString("AUDIT_OPTION");//审核结果
		
		String afId = fileData.getString("AF_ID");//收养文件主键
		String aaId = fileData.getString("AA_ID");//补充文件记录主键
		addData.add("AF_ID", afId);
		FileCommonManager fileCommonManager = new FileCommonManager();
		
		DataList paramDataList = new DataList();
		Data paramData = new Data();
		paramData.add("AF_ID", afId);
    	paramData.add("AUDIT_LEVEL","1");
    	paramDataList.add(paramData);
		
		
		Connection conn = null;
		try {
			
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//保存文件基本信息（中文、外文）
            //saveFileInfoAndHistroyInfo(conn);//保存文件基本信息（中文、外文），并进行历史留痕

            
            if(auditOption.equals(FileAuditConstant.SB)||auditOption==FileAuditConstant.SB||auditOption.equals(FileAuditConstant.TG)||auditOption==FileAuditConstant.TG||auditOption.equals(FileAuditConstant.BTG)||auditOption==FileAuditConstant.BTG){//审核意见为上报、通过、不通过
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_SB_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "2");//部门主任待复核
            	auditData.add("OPERATION_STATE", "2");//操作状态为：已处理
            	fileCommonManager.auditInit(conn, paramDataList);//初始化部门主任复核记录
            }else if(auditOption.equals(FileAuditConstant.BCWJ)||auditOption==FileAuditConstant.BCWJ){//审核意见为补充文件
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_BCWJ_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "1");//经办人审核中
            	fileData.add("SUPPLY_STATE", "0");//文件末次补充状态为待补充
            	auditData.add("OPERATION_STATE", "1");//操作状态为：处理中
            	Data bcData = fileCommonManager.suppleInit(conn, addData);// 向补充文件表FFS_AF_ADDITIONAL初始化补充记录
            	fileData.add("AA_ID", bcData.getString("AA_ID"));//文件末次补充记录主键ID
            }else if(auditOption.equals(FileAuditConstant.BCWJFY)||auditOption==FileAuditConstant.BCWJFY){//审核意见为补充文件翻译
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_BCFY_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "1");//经办人审核中
            	fileData.add("ATRANSLATION_STATE", "0");//补翻状态为待翻译
            	auditData.add("OPERATION_STATE", "1");//操作状态为：处理中
            	//向翻译记录表FFS_AF_TRANSLATION初始化翻译记录
            	fileCommonManager.translationInit(afId, aaId,aaData.getString("TRANSLATION_TYPE"), curDate, aaData.getString("AA_CONTENT"),aaData.getString("SEND_USERID"), aaData.getString("SEND_USERNAME"),aaData.getString("NOTICE_FILEID"), conn);
            }else if(auditOption.equals(FileAuditConstant.CXFY)||auditOption==FileAuditConstant.CXFY){//审核意见为重新翻译
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_CXFY_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "1");//经办人审核中
            	fileData.add("RTRANSLATION_STATE", "0");//重翻状态为待翻译	
            	auditData.add("OPERATION_STATE", "1");//操作状态为：处理中
            	//向翻译记录表FFS_AF_TRANSLATION初始化翻译记录
            	fileCommonManager.translationInit(afId, aaId,cfData.getString("TRANSLATION_TYPE"), curDate, cfData.getString("AA_CONTENT"),cfData.getString("SEND_USERID"), cfData.getString("SEND_USERNAME"),"", conn);
            }
            
            handler.saveAuditInfo(conn, auditData);//向审核信息表里保存审核信息
            handler.saveFileInfo(conn, fileData);//向文件信息表里保存文件信息
            
            String packageId = aaData.getString("NOTICE_FILEID");//补翻附件ID
            AttHelper.publishAttsOfPackageId(packageId, "AF");//补翻附件发布
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据提交成功!");//提交成功 0
            setAttribute("clueTo", clueTo);
            setAttribute("type", "SHB");//为了补充查询审核提交后返回页面而设的值
            
		} catch (DBException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "经办人文件审核提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "经办人文件审核提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (Exception e ){
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            
			setAttribute(Constants.ERROR_MSG_TITLE, "经办人文件审核提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的submitForOneLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: NormalFileExport 
	 * @Description: 导出初审文件列表
	 * @author: mayun
	 * @throws
	 */
	public String fileExportForOneLevel(){
		String curDate = DateUtility.getCurrentDate();
		String fileName = "初审文件列表_"+curDate+".xls";
		//1  获取页面搜索字段数据
		Data data = getRequestEntityData("S_", "FILE_NO", "FILE_TYPE",
				"COUNTRY_CODE", "ADOPT_ORG_ID", "MALE_NAME", 
				"FEMALE_NAME", "TRANSLATION_QUALITY", "AUD_STATE", "AA_STATUS", 
				"RTRANSLATION_STATE", "RECEIVER_DATE_START","RECEIVER_DATE_END");
		String FILE_NO = data.getString("FILE_NO", null); // 收文编号
		String FILE_TYPE = data.getString("FILE_TYPE", null); //文件类型
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null); // 国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null); // 收养组织
		String MALE_NAME = data.getString("MALE_NAME", null); // 男方
		if(null != MALE_NAME){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME", null); // 女方
		if(null != FEMALE_NAME){
			FEMALE_NAME = FEMALE_NAME.toUpperCase();
		}
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null); // 翻译质量
		String AUD_STATE = data.getString("AUD_STATE", null); // 审核状态
		String AA_STATUS = data.getString("AA_STATUS", null); // 补充状态
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null); // 重翻状态
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null); // 接收日期begin
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null); // 接收日期end

		try {
			//2设置导出文件参数
			this.getResponse().setHeader(
					"Content-Disposition",
					"attachment;filename="
							+ new String(fileName.getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3处理代码字段 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("GJSY","WJLX","SYZZ","WJFYZL","SYJBRSH","SYWJBC","SYWJCF");
    		//文件类型代码
    		CodeList wjlxList=codes.get("WJLX");
    		Map<String,String> wjlxMap=new HashMap<String,String>();
    		for(int i=0;i<wjlxList.size();i++){
    			Code c=wjlxList.get(i);
    			wjlxMap.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", wjlxMap);
    		
    		//国家代码
    		CodeList gjList=codes.get("GJSY");
    		Map<String,String> gjMap=new HashMap<String,String>();
    		for(int i=0;i<gjList.size();i++){
    			Code c=gjList.get(i);
    			gjMap.put(c.getValue(),c.getName());
    		}
    		dict.put("COUNTRY_CODE", gjMap);
    		
    		//收养组织代码
    		CodeList syzzList=codes.get("SYZZ");
    		Map<String,String> syzzMap=new HashMap<String,String>();
    		for(int i=0;i<syzzList.size();i++){
    			Code c=syzzList.get(i);
    			syzzMap.put(c.getValue(),c.getName());
    		}
    		dict.put("ADOPT_ORG_ID", syzzMap);
    		
    		//文件翻译质量代码
    		CodeList fyzlList=codes.get("WJFYZL");
    		Map<String,String> fyzlMap=new HashMap<String,String>();
    		for(int i=0;i<fyzlList.size();i++){
    			Code c=fyzlList.get(i);
    			fyzlMap.put(c.getValue(),c.getName());
    		}
    		dict.put("TRANSLATION_QUALITY", fyzlMap);
    		
    		//审核状态代码
    		CodeList shztList=codes.get("SYJBRSH");
    		Map<String,String> shztMap=new HashMap<String,String>();
    		for(int i=0;i<shztList.size();i++){
    			Code c=shztList.get(i);
    			shztMap.put(c.getValue(),c.getName());
    		}
    		dict.put("AUD_STATE", shztMap);
    		
    		//补充状态代码
    		CodeList bcztList=codes.get("SYWJBC");
    		Map<String,String> bcztMap=new HashMap<String,String>();
    		for(int i=0;i<bcztList.size();i++){
    			Code c=bcztList.get(i);
    			bcztMap.put(c.getValue(),c.getName());
    		}
    		dict.put("AA_STATUS", bcztMap);
    		
    		//重翻状态代码
    		CodeList cfztList=codes.get("SYWJBC");
    		Map<String,String> cfztMap=new HashMap<String,String>();
    		for(int i=0;i<cfztList.size();i++){
    			Code c=cfztList.get(i);
    			cfztMap.put(c.getValue(),c.getName());
    		}
    		dict.put("RTRANSLATION_STATE", cfztMap);
    		
    		//4 执行文件导出
			ExcelExporter.export2Stream("初审文件列表", "fileForOneLevel", dict, this
					.getResponse().getOutputStream(),FILE_NO,RECEIVER_DATE_START,RECEIVER_DATE_END,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,FILE_TYPE,TRANSLATION_QUALITY,AUD_STATE,AA_STATUS,RTRANSLATION_STATE);
			
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  设置异常处理
			log.logError("导出初审文件列表出现异常", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "导出初审文件列表出现异常");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 页面不进行跳转，返回NULL 如需跳转，返回其他值
		return null;
	}
	
	/**
	 * 文件复核保存
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String saveForTwoLevel(){
		String curDate = DateUtility.getCurrentDateTime();//获得当前日期
		//文件信息
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","RETURN_REASON");
		//审核信息
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);
		auditData.add("OPERATION_STATE", "1");//操作状态为：处理中
		
		Connection conn = null;
		try {
			//根据操作类型获得下一环节文件的全局状态和文件位置
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_TG_SAVE);
			fileData.addData(globalData);
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//保存文件基本信息（中文、外文）
            //saveFileInfoAndHistroyInfo(conn);//保存文件基本信息（中文、外文），并进行历史留痕
            handler.saveAuditInfo(conn, auditData);
            handler.saveFileInfo(conn, fileData);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//提交成功 0
            setAttribute("clueTo", clueTo);
            
		} catch (DBException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件复核保存异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审核保存或提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch(Exception e){
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审核保存或提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的saveForTwoLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("AF_ID", fileData.getString("AF_ID"));
		setAttribute("AU_ID", auditData.getString("AU_ID"));
		if(!"".equals(getParameter("FLAG"))){
			setAttribute("FLAG", getParameter("FLAG"));
		}
		return retValue;
	}
	
	
	/**
	 * 部门主任复核提交
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String submitForTwoLevel(){
		retValue += getParameter("FLAG","");	//判断是否是补番查询、重返查询中的审核
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDateTime();//获得当前日期
		//文件信息
		Data fileData = getRequestEntityData("P_","RI_ID","AF_ID","FILE_NO","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON","RETURN_REASON");
		//审核信息
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);//审核日期
		String auditOption = auditData.getString("AUDIT_OPTION");//审核结果
		
		String afId = fileData.getString("AF_ID");//收养文件主键
		String fileNo = fileData.getString("FILE_NO");//收养编号
		String riId = fileData.getString("RI_ID");//预批ID
		FileCommonManager fileCommonManager = new FileCommonManager();
		PublishCommonManager publishCommonManager = new PublishCommonManager();
		
		
		
		Connection conn = null;
		try {
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//保存文件基本信息（中文、外文）
            //saveFileInfoAndHistroyInfo(conn);//保存文件基本信息（中文、外文），并进行历史留痕

			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();

    		
            auditData.add("OPERATION_STATE", "2");//操作状态为：已处理
            if(auditOption.equals(FileAuditConstant.TG)||auditOption==FileAuditConstant.TG){//通过
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_TG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "5");//复核审核通过
            	
            	/*******初始化移交记录begin**********/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//初始化文件移交记录
            	/*******初始化移交记录ends**********/
            }else if(auditOption.equals(FileAuditConstant.BTG)||auditOption==FileAuditConstant.BTG){//不通过
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_BTG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "4");//复核审核不通过
            	fileData.add("RETURN_STATE", "1");//退文状态为已确认

				/*************撤销预批begin********************/
				if(!"".equals(riId)&&null!=riId){
					publishCommonManager.RemoveByRIID(conn,riId);
				}
				/*************撤销预批end********************/
            	
            	/*************初始化退文记录信息begin************/
        		Data retData = getRequestEntityData("RET_","HANDLE_TYPE");//退文信息
        		Data fileDataForTable = fileCommonManager.getCommonFileInfo(fileNo,conn);//从后台获取文件基本信息
        		retData.add("RETURN_REASON", fileData.getString("RETURN_REASON"));//退文原因
        		retData.add("AF_ID", fileData.getString("AF_ID"));//收养文件ID
        		retData.add("ORG_ID", deptId);//退文确认部门ID
        		retData.add("PERSON_ID", personId);//退文确认人ID
        		retData.add("PERSON_NAME", personName);//退文确认人名称
        		retData.add("RETREAT_DATE", curDate);//退文确认日期
        		retData.add("APPLE_TYPE", "2");//退文类型
        		retData.add("RETURN_STATE", "1");//退文状态
        		retData.add("ADOPT_ORG_ID", fileDataForTable.getString("ADOPT_ORG_ID"));//向退文信息Data里封装收养组织ID
        		retData.add("COUNTRY_CODE", fileDataForTable.getString("COUNTRY_CODE"));//向退文信息Data里封装收养组织ID
        		retData.add("REGISTER_DATE", fileDataForTable.getString("REGISTER_DATE"));//向退文信息Data里封装收养组织ID
        		retData.add("FILE_NO", fileDataForTable.getString("FILE_NO"));//向退文信息Data里封装收养组织ID
        		retData.add("FILE_TYPE", fileDataForTable.getString("FILE_TYPE"));//向退文信息Data里封装收养组织ID
        		retData.add("FAMILY_TYPE", fileDataForTable.getString("FAMILY_TYPE"));//向退文信息Data里封装收养组织ID
        		retData.add("MALE_NAME", fileDataForTable.getString("MALE_NAME"));//向退文信息Data里封装收养组织ID
        		retData.add("FEMALE_NAME", fileDataForTable.getString("FEMALE_NAME"));//向退文信息Data里封装收养组织ID
            	fileCommonManager.revocationInit(conn, retData);//初始化退文记录信息
            	/*************初始化退文记录信息end************/
            	
            	/*************初始化退文移交记录信息begin************/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//初始化退文移交记录
            	/*************初始化退文移交记录信息end************/
            }else if(auditOption.equals(FileAuditConstant.THJBR)||auditOption==FileAuditConstant.THJBR){//退回经办人
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_THJBR_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "9");//退回重审
            	
            	/************初始化经办人审批记录begin********/
            	DataList paramDataList = new DataList();
        		Data paramData = new Data();
        		paramData.add("AF_ID", afId);
            	paramData.add("AUDIT_LEVEL","0");
            	paramDataList.add(paramData);
            	fileCommonManager.auditInit(conn, paramDataList);//初始化经办人审批记录
            	/************初始化经办人审批记录end********/
            }else if(auditOption.equals(FileAuditConstant.SBFGZR)||auditOption==FileAuditConstant.SBFGZR){//上报分管主任
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_SBFGZR_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "3");//分管主任待审核
            	
            	/************初始化分管主任审批记录begin********/
            	DataList paramDataList = new DataList();
        		Data paramData = new Data();
        		paramData.add("AF_ID", afId);
            	paramData.add("AUDIT_LEVEL","2");
            	paramDataList.add(paramData);
            	fileCommonManager.auditInit(conn, paramDataList);//初始化分管主任审批记录
            	/************初始化分管主任审批记录end********/
            }
            
            handler.saveAuditInfo(conn, auditData);//向审核信息表里保存审核信息
            handler.saveFileInfo(conn, fileData);//向文件信息表里保存文件信息
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据提交成功!");//提交成功 0
            setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "部门主任复核提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "部门主任复核提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}catch(Exception e){
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "部门主任复核提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的submitForTwoLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	
	/**
	 * 文件审批保存
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String saveForThreeLevel(){
		String curDate = DateUtility.getCurrentDateTime();//获得当前日期
		//文件信息
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","RETURN_REASON");
		//审核信息
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);
		auditData.add("OPERATION_STATE", "1");//操作状态为：处理中
		
		Connection conn = null;
		try {
			//根据操作类型获得下一环节文件的全局状态和文件位置
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_TG_SAVE);
			fileData.addData(globalData);
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//保存文件基本信息（中文、外文）
           // saveFileInfoAndHistroyInfo(conn);//保存文件基本信息（中文、外文），并进行历史留痕
            handler.saveAuditInfo(conn, auditData);
            handler.saveFileInfo(conn, fileData);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//提交成功 0
            setAttribute("clueTo", clueTo);
            
		} catch (DBException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审批保存异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审批保存或提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}catch(Exception e){
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件审批保存或提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的saveForThreeLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("AF_ID", fileData.getString("AF_ID"));
		setAttribute("AU_ID", auditData.getString("AU_ID"));
		if(!"".equals(getParameter("FLAG"))){
			setAttribute("FLAG", getParameter("FLAG"));
		}
		return retValue;
	}
	
	
	/**
	 * 分管主任审批提交
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String submitForThreeLevel(){
		retValue += getParameter("FLAG","");	//判断是否是补番查询、重返查询中的审核
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDateTime();//获得当前日期
		//文件信息
		Data fileData = getRequestEntityData("P_","RI_ID","AF_ID","FILE_NO","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON","RETURN_REASON");
		//审核信息
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);//审核日期
		String auditOption = auditData.getString("AUDIT_OPTION");//审核结果
		
		String afId = fileData.getString("AF_ID");//收养文件主键
		String fileNo = fileData.getString("FILE_NO");//收养编号
		FileCommonManager fileCommonManager = new FileCommonManager();
		String riId = fileData.getString("RI_ID");//预批ID
		PublishCommonManager publishCommonManager = new PublishCommonManager();
		
		
		
		Connection conn = null;
		try {
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//保存文件基本信息（中文、外文）
            //saveFileInfoAndHistroyInfo(conn);//保存文件基本信息（中文、外文），并进行历史留痕

			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();

            
            auditData.add("OPERATION_STATE", "2");//操作状态为：已处理
            if(auditOption.equals(FileAuditConstant.TG)||auditOption==FileAuditConstant.TG){//通过
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_TG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "5");//审核通过
            	
            	/*******初始化移交记录begin**********/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//初始化文件移交记录
            	/*******初始化移交记录ends**********/
            }else if(auditOption.equals(FileAuditConstant.BTG)||auditOption==FileAuditConstant.BTG){//不通过
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_BTG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "4");//审核不通过
            	fileData.add("RETURN_STATE", "1");//退文状态为已确认

				/*************撤销预批begin********************/
				if(!"".equals(riId)&&null!=riId){
					publishCommonManager.RemoveByRIID(conn,riId);
				}
				/*************撤销预批end********************/
            	
            	/*************初始化退文记录信息begin************/
        		Data retData = getRequestEntityData("RET_","HANDLE_TYPE");//退文信息
        		Data fileDataForTable = fileCommonManager.getCommonFileInfo(fileNo,conn);//从后台获取文件基本信息
        		retData.add("RETURN_REASON", fileData.getString("RETURN_REASON"));//退文原因
        		retData.add("AF_ID", fileData.getString("AF_ID"));//收养文件ID
        		retData.add("ORG_ID", deptId);//退文确认部门ID
        		retData.add("PERSON_ID", personId);//退文确认人ID
        		retData.add("PERSON_NAME", personName);//退文确认人名称
        		retData.add("RETREAT_DATE", curDate);//退文确认日期
        		retData.add("APPLE_TYPE", "2");//退文类型
        		retData.add("RETURN_STATE", "1");//退文状态
        		retData.add("ADOPT_ORG_ID", fileDataForTable.getString("ADOPT_ORG_ID"));//向退文信息Data里封装收养组织ID
        		retData.add("COUNTRY_CODE", fileDataForTable.getString("COUNTRY_CODE"));//向退文信息Data里封装收养组织ID
        		retData.add("REGISTER_DATE", fileDataForTable.getString("REGISTER_DATE"));//向退文信息Data里封装收养组织ID
        		retData.add("FILE_NO", fileDataForTable.getString("FILE_NO"));//向退文信息Data里封装收养组织ID
        		retData.add("FILE_TYPE", fileDataForTable.getString("FILE_TYPE"));//向退文信息Data里封装收养组织ID
        		retData.add("FAMILY_TYPE", fileDataForTable.getString("FAMILY_TYPE"));//向退文信息Data里封装收养组织ID
        		retData.add("MALE_NAME", fileDataForTable.getString("MALE_NAME"));//向退文信息Data里封装收养组织ID
        		retData.add("FEMALE_NAME", fileDataForTable.getString("FEMALE_NAME"));//向退文信息Data里封装收养组织ID
            	fileCommonManager.revocationInit(conn, retData);//初始化退文记录信息
            	/*************初始化退文记录信息end************/
            	
            	/*************初始化退文移交记录信息begin************/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//初始化退文移交记录
            	/*************初始化退文移交记录信息end************/
            }else if(auditOption.equals(FileAuditConstant.THJBR)||auditOption==FileAuditConstant.THJBR){//退回经办人
            	//根据操作类型获得下一环节文件的全局状态和文件位置
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_THJBR_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "9");//退回重审
            	
            	/************初始化经办人审批记录begin********/
            	DataList paramDataList = new DataList();
        		Data paramData = new Data();
        		paramData.add("AF_ID", afId);
            	paramData.add("AUDIT_LEVEL","0");
            	paramDataList.add(paramData);
            	fileCommonManager.auditInit(conn, paramDataList);//初始化经办人审批记录
            	/************初始化经办人审批记录end********/
            }
            
            handler.saveAuditInfo(conn, auditData);//向审核信息表里保存审核信息
            handler.saveFileInfo(conn, fileData);//向文件信息表里保存文件信息
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据提交成功!");//提交成功 0
            setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "审批提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "审批提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch(Exception e){
			// 设置异常处理
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "审批提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction的submitForThreeLevel.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

}
