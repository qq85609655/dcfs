package com.dcfs.common.batchattmanager;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.Base64Util;
import hx.util.InfoClueTo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.ffs.translation.FfsAfTranslationHandler;

public class BatchAttManager extends BaseAction {

	private static Log log = UtilLog.getLog(BatchAttManager.class);

	private BatchAttHandler handler;

	private Connection conn = null;// 数据库连接

	private String retValue = SUCCESS;
	
	public BatchAttManager(){
        this.handler=new BatchAttHandler();
    } 

	/*
	 * 批量附件管理
	 */
	public String BatchAttMaintain() {

		// 1 参数设置
		// 业务大类，如文件、儿童材料、安置后报告
		String bigType = getParameter("bigType", "");
		// 附件集合ID
		String packID = getParameter("packID", "");
		// 业务表上的附件packageID
		String packageID = getParameter("packageID", "");
		//业务表记录ID
		String IS_EN = getParameter("IS_EN", "false");
		String PATH_ARGS = getParameter("PATH_ARGS", "false");
		
		retValue = "maintain";
		
		// 判断参数是否正确
		if ("".equals(bigType) || "".equals(packID) || "".equals(packageID)) {
			InfoClueTo clueTo = new InfoClueTo(0, "批量附件管理输入参数错误！");
			setAttribute("clueTo", clueTo);
			retValue = "error";
			return retValue;
		}
		String entityName = getEntityNamebyBigType(bigType);
		PATH_ARGS = getPathArgs(PATH_ARGS);

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();

			// 3 执行数据库处理操作
			// 附件小类列表
			DataList attType = this.getAttType(conn, packID);
			if (attType == null) {
				InfoClueTo clueTo = new InfoClueTo(0, "未检索到符合条件的附件类别！");
				setAttribute("clueTo", clueTo);
				retValue = "error";
				return retValue;
			}
			// 附件数据列表
			DataList attData = handler.getAttData(conn, packageID,entityName);
			 
			Map<String, DataList> attMap = getAttMap(attData);
			String xmlstr = this.getUploadParameter(attType);
			setAttribute("afUploadParameter",xmlstr);
			setAttribute("attType", attType);
			setAttribute("attMap", attMap);	
			setAttribute("packageID",packageID);
			setAttribute("ENTITY_NAME",entityName);
			setAttribute("bigType",bigType);
			setAttribute("IS_EN",IS_EN);
			setAttribute("PATH_ARGS",PATH_ARGS);

		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "附件读取操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("附件读取操作异常[保存操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "参数Base64转码操作出现异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("参数Base64转码操作出现异常[附件读取操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"BatchAttManager的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}
	
	/*
	 * 批量附件查看
	 */
	public String BatchAttView() {

		// 1 参数设置
		// 业务大类，如文件、儿童材料、安置后报告
		String bigType = getParameter("bigType", "");
		// 附件集合ID
		String packID = getParameter("packID", "");
		// 业务表上的附件packageID
		String packageID = getParameter("packageID", ""); 
		//业务表记录ID
		String IS_EN = getParameter("IS_EN", "false");
		
		retValue = "view";
		
		// 判断参数是否正确
		if ("".equals(bigType) || "".equals(packID) || "".equals(packageID)) {
			InfoClueTo clueTo = new InfoClueTo(0, "批量附件管理输入参数错误！");
			setAttribute("clueTo", clueTo);
			retValue = "error";
			return retValue;
		}
		String entityName = getEntityNamebyBigType(bigType);
		
		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();

			// 3 执行数据库处理操作
			// 附件小类列表
			DataList attType = this.getAttType(conn, packID);
			if (attType == null) {
				InfoClueTo clueTo = new InfoClueTo(0, "未检索到符合条件的附件类别！");
				setAttribute("clueTo", clueTo);
				retValue = "error";
				return retValue;
			}
			// 附件数据列表
			DataList attData = handler.getAttData(conn, packageID,entityName);
			 
			Map<String, DataList> attMap = getAttMap(attData);
			//String xmlstr = this.getUploadParameter(attType);
			//setAttribute("afUploadParameter",xmlstr);
			setAttribute("attType", attType);
			setAttribute("attMap", attMap);	
			setAttribute("packageID",packageID);
			setAttribute("ENTITY_NAME",entityName);
			setAttribute("bigType",bigType);
			setAttribute("IS_EN",IS_EN);

		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "附件读取操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("附件读取操作异常[保存操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "参数Base64转码操作出现异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("参数Base64转码操作出现异常[附件读取操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"BatchAttManager的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
     *按附件小类构造附件列表集合
     * @param DataList dl 附件结果集合
     * @return map<String smalltype;,datalist:dData> 
     *  smalltype:附件小类代码
	 *  datalist:附件结果集合
     */
	private Map<String, DataList> getAttMap(DataList dl) {
		if (dl == null) {
			return null;
		}
		Map<String, DataList> mapAtt = new HashMap<String, DataList>();
		String smalltype = "NAN";
		DataList ddl = new DataList();
		int count = 0;

		for (int i = 0; i < dl.size(); i++) {
			count++;
			Data d = dl.getData(i);
			String s = d.getString("SMALL_TYPE");

			if (!(s.equals(smalltype))) {
				if (i != 0) {
					mapAtt.put(smalltype, ddl);
					ddl = new DataList();
				}
				smalltype = s;
			}
			ddl.add(d);
		}
		mapAtt.put(smalltype, ddl);
		return mapAtt;
	}
	/**
	 *根据附件大类获得附件表名称
	 * @param bigType
	 * @return
	 */
	private String getEntityNamebyBigType(String bigType){
		String ret = "";
		if("AF".equals(bigType)){
			ret = "ATT_AF";			
		}else if("CI".equals(bigType)){
			ret = "ATT_CI";
		}else if("AR".equals(bigType)){
			ret = "ATT_AR";
		}else{
			ret = "ATT_OTHER";
		}
		return ret;
	}
	
	/**
	 * 根据大类获得附件保存地址参数
	 * @param bigType
	 * @return
	 * TODO
	 */
	private String getPathArgs(String s){
		String ret = s;
		return ret;
	}
	
	
	/**
	 * 根据packID获取附件小类集合
	 * @param conn
	 * @param packID
	 * @return
	 * @throws DBException
	 */
	public DataList getAttType(Connection conn, String packID) throws DBException{
			return  handler.getAttType(conn, packID);
	}
	
	/**
	 * 根据attType获得附件上传参数
	 * @param attType
	 * @return
	 * @throws Exception
	 */
	public String getUploadParameter(DataList attType) throws Exception{
		String xmlstr = attType.toXmlString();		       
	    xmlstr =Base64Util.encryptBASE64(xmlstr.getBytes());
	    return xmlstr;
	}
	/**
	 * 
	 * @param packageId 附件packageID
	 * @param attTypeCode 附件表（CI，AF...）
	 * @return
	 * 附件id集合map
	 * key :smalltype
	 * value:dataList
	 */
	public Map<String,DataList>  getAttDataByPackageID(String packageId,String attTypeCode){
		Map<String,DataList> attidMap =  new HashMap<String, DataList>();
		String entityName = getEntityNamebyBigType(attTypeCode);
		try {
			conn = ConnectionManager.getConnection();
			DataList attDataList = this.handler.getAttData(conn, packageId, entityName);
			attidMap = this.getAttMap(attDataList);
			
		} catch (DBException e) {			
			e.printStackTrace();
		}
		return attidMap;
	}
	

	public String execute() throws Exception {
		return null;
	}

}
