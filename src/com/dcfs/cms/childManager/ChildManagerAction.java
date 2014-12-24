/**
 * @Title: ChildManagerAction.java
 * @Package com.dcfs.cms.childManager
 * @Description: 儿童材料信息处理类，负责儿童材料的录入、报送。
 * @author wangzheng   
 * @project DCFS 
 * @date 2014-9-3
 * @version V1.0   
 */
package com.dcfs.cms.childManager;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import hx.common.Exception.DBException;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childAdditional.ChildAdditionHandler;
import com.dcfs.cms.childReturn.ChildReturnHandler;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;

public class ChildManagerAction extends BaseAction {

	private static Log log = UtilLog.getLog(ChildManagerAction.class);

	private ChildManagerHandler handler;

	private ChildCommonManager manager;

	private Connection conn = null;// 数据库连接

	private DBTransaction dt = null;// 事务处理

	private String retValue = SUCCESS;

	public ChildManagerAction() {
		this.handler = new ChildManagerHandler();
		this.manager = new ChildCommonManager();
	}

	public String execute() throws Exception {
		return null;
	}

	/**
	 * 儿童材料记录查询
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return
	 */
	public String findList() {
		// 1 设定参数
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
		setAttribute("clueTo", clueTo);// set操作结果提醒

		// 2 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 2.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}
		// 2.3 获取列表类别
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");

		// 如果没有传递listType则直接返回错误
		if ("".equals(listType)) {
			String s = "参数错误！";
			clueTo = new InfoClueTo(0, s);
			setAttribute("clueTo", clueTo); // set操作结果提醒
			retValue = "error";
			return retValue;
		} else {
			retValue = listType;
		}

		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String orgCode = organ.getOrgCode();

		// 3 获取搜索参数
		Data data = getRequestEntityData("S_", "PROVINCE_ID", // 省份
				"WELFARE_ID", // 福利院id
				"WELFARE_NAME_CN", // 福利院名称
				"NAME", // 姓名
				"SEX", // 性别
				"CHILD_TYPE", // 儿童类型
				"SN_TYPE", // 病残种类
				"CHILD_STATE", // 查询状态
				"PUB_STATE", // 发布状态
				"MATCH_STATE", // 匹配状态
				"BIRTHDAY_START", // 出生日期_开始日期
				"BIRTHDAY_END", // 出生日期
				"CHECKUP_DATE_START", // 体检日期_开始日期
				"CHECKUP_DATE_END", // 体检日期_结束日期
				"IS_PLAN", // 明天计划
				"IS_HOPE", // 希望之旅
				"REG_USERNAME", // 登记人
				"REG_DATE_START", // 登记日期_开始日期
				"REG_DATE_END", // 登记日期_结束日期
				"POST_DATE_START", // 寄送日期_开始日期
				"POST_DATE_END", // 寄送日期_结束日期
				"RECEIVE_DATE_START", // 接收日期_开始日期
				"RECEIVE_DATE_END", // 接收日期_结束日期
				"UPDATE_NUM_START", // 更新次数_开始日期
				"UPDATE_NUM_END", // 更新次数_结束日期
				"SEND_DATE_START", // 报送日期_开始日期
				"SEND_DATE_END"); // 报送日期_结束日期
		// 如果提交状态为空则设置默认的提交状态为“未提交”；如果提交状态为“-1”则表明是查询全部，则将查询条件中的提交状态置为null
		String CHILD_STATE = data.getString("CHILD_STATE", null);
		if (CHILD_STATE == null) {
			data.add("CHILD_STATE", "0");
		} else if ("-1".equals(CHILD_STATE)) {
			data.add("CHILD_STATE", null);
		}
		// 儿童审核状态转换
		String childState = this.getChildAudState(
				data.getString("CHILD_STATE"), listType);
		data.put("AUD_STATE", childState);

		String orgType = String.valueOf(organ.getOrgType());
		// 登录人为福利院用户
		if (ChildInfoConstants.ORGAN_TYPE_FLY.equals(orgType)) {
			data.put("WELFARE_ID", orgCode);
		}

		// 判断是否代录
		if ("CMS_AZB_DL_LIST".equals(listType)) {
			// 安置部代录
			data.put("IS_DAILU", ChildInfoConstants.LEVEL_CCCWA);
		}

		// 3.1 设定列表默认搜索参数

		// 3.2搜索参数后处理

		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.findList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 将结果集写入页面接收变量
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			setAttribute("listType", listType);

		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			// 8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料综合查询
	 * 
	 * @author wangzheng
	 * @date 2014-11-12
	 * @return
	 */
	public String azbChildInfoSynQuery() {
		// 1 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 1.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "REG_DATE";
		}
		// 1.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}

		// 3 获取搜索参数
		Data data = getRequestEntityData("S_", "PROVINCE_ID", // 省份
				"WELFARE_ID", // 福利院id
				"WELFARE_NAME_CN", // 福利院名称
				"NAME", // 姓名
				"SEX", // 性别
				"CHILD_TYPE", // 儿童类型
				"SN_TYPE", // 病残种类
				"MATCH_STATE", // 匹配状态
				"BIRTHDAY_START", // 出生日期_开始日期
				"BIRTHDAY_END", // 出生日期
				"CHECKUP_DATE_START", // 体检日期_开始日期
				"CHECKUP_DATE_END", // 体检日期_结束日期
				"IS_OVERAGE", // 超龄标识
				"CI_GLOBAL_STATE"); // 儿童材料全局状态

		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.ChildInfoSynQuery(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 将结果集写入页面接收变量
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);

		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			// 8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * 省厅儿童材料代录查询列表
	 * 
	 * @author wangzheng
	 * @date 2014-9-21
	 * @return
	 */
	public String stDailuList() {
		// 1 设定参数
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
		setAttribute("clueTo", clueTo);// set操作结果提醒

		// 2 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "REG_DATE";
		}
		// 2.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}
		// 2.3 获取列表类别
		String listType = "CMS_ST_DL_LIST";
		retValue = listType;

		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String PROVINCE_ID = organ.getOrgCode();

		// 3 获取搜索参数
		Data data = getRequestEntityData("S_", "WELFARE_NAME_CN", "NAME",
				"SEX", "CHILD_TYPE", "SN_TYPE", "CHILD_STATE",
				"BIRTHDAY_START", "BIRTHDAY_END", "CHECKUP_DATE_START",
				"CHECKUP_DATE_END", "REG_USERNAME", "REG_DATE_START",
				"REG_DATE_END");
		String childState = this.getChildAudState(
				data.getString("CHILD_STATE"), listType);
		data.put("AUD_STATE", childState);
		data.put("PROVINCE_ID", PROVINCE_ID);
		data.put("IS_DAILU", ChildStateManager.CHILD_DAILU_FLAG_PROVINCE);
		// 3.1 设定列表默认搜索参数

		// 3.2搜索参数后处理

		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.findList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 将结果集写入页面接收变量
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			// setAttribute("listType",listType);
		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					retValue = "error";
				}
			}
		}
		return retValue;
	}

	/**
	 * 省厅审核寄送查询列表
	 * 
	 * @return
	 */
	public String STAuditList() {

		// 1 设定参数
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
		setAttribute("clueTo", clueTo);// set操作结果提醒

		// 2 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 2.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}

		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String orgCode = organ.getOrgCode();
		ChildCommonManager ccm = new ChildCommonManager();
		String proviceId = ccm.getProviceId(orgCode);

		// 3 获取搜索参数
		Data data = getRequestEntityData("S_", "WELFARE_ID", "NAME", "SEX",
				"CHILD_TYPE", "SN_TYPE", "CHILD_STATE", "BIRTHDAY_START",
				"BIRTHDAY_END", "CHECKUP_DATE_START", "CHECKUP_DATE_END",
				"IS_PLAN", "IS_HOPE", "SEND_DATE_START", "SEND_DATE_END",
				"POST_DATE_START", "POST_DATE_END", "RECEIVE_DATE_START",
				"RECEIVE_DATE_END", "AUDIT_DATE_START", "AUDIT_DATE_END");
		String childState = this.getChildAudState(
				data.getString("CHILD_STATE"), "CMS_ST_SHJS_LIST");
		data.put("AUD_STATE", childState);
		data.put("PROVINCE_ID", proviceId);

		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.STAuditList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 将结果集写入页面接收变量
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			retValue = "CMS_ST_SHJS_LIST";

		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					retValue = "error";
				}
			}
		}
		return retValue;
	}

	/**
	 * 安置部接收列表
	 * 
	 * @author wangzheng
	 * @date 2014-9-19
	 * @return
	 */
	public String azbReceiveList() {
		// 1 设定参数
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
		setAttribute("clueTo", clueTo);// set操作结果提醒

		// 2 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "POST_DATE";
		}
		// 2.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}

		// 3 获取搜索参数
		Data data = getRequestEntityData("S_", "PROVINCE_ID", "WELFARE_ID",
				"POST_DATE_START", "POST_DATE_END", "NAME", "SEX",
				"BIRTHDAY_START", "BIRTHDAY_END", "CHILD_TYPE", "SN_TYPE",
				"CHECKUP_DATE_START", "CHECKUP_DATE_END", "IS_PLAN", "IS_HOPE",
				"RECEIVE_STATE", "RECEIVE_DATE_START", "RECEIVE_DATE_END");

		// 3.1 设定列表默认搜索参数

		// 3.2搜索参数后处理

		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.childReceiveList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 将结果集写入页面接收变量
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);

		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			// 8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * 安置部审核查询列表
	 * 
	 * @return
	 */
	public String azbAuditList() {

		// 1 设定参数
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
		setAttribute("clueTo", clueTo);// set操作结果提醒

		// 2 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 2.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}
		// 2.3 获得儿童类别
		String CHILD_TYPE = (String) getParameter("CHILD_TYPE", "");
		if ("".equals(CHILD_TYPE)) {
			CHILD_TYPE = (String) getAttribute("CHILD_TYPE");
		}
		// 3 获取搜索参数
		Data data = getRequestEntityData("S_", "PROVINCE_ID", "WELFARE_ID",
				"NAME", "SEX", "BIRTHDAY_START", "BIRTHDAY_END",
				"CHECKUP_DATE_START", "CHECKUP_DATE_END", "SN_TYPE",
				"DISEASE_CN", "HAVE_VIDEO", "SPECIAL_FOCUS", "IS_HOPE",
				"IS_PLAN", "RECEIVE_DATE_START", "RECEIVE_DATE_END",
				"PUB_STATE", "AUD_STATE", "MATCH_STATE", "TRANSLATION_STATE");
		data.put("CHILD_TYPE", CHILD_TYPE);
		if (ChildInfoConstants.CHILD_TYPE_NORMAL.equals(CHILD_TYPE)) {// 正常儿童
			retValue = "CMS_AZB_ZCSH_LIST";
		} else if (ChildInfoConstants.CHILD_TYPE_SPECAL.equals(CHILD_TYPE)) {// 特需儿童
			retValue = "CMS_AZB_TXSH_LIST";
		} else {// 参数错误
			retValue = "error";
			return retValue;
		}

		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.AZBAuditList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 将结果集写入页面接收变量
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					retValue = "error";
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料翻译列表
	 * 
	 * @author wangzheng
	 * @date 2014-10-16
	 * @return
	 */
	public String childTranslationList() {
		return retValue;
	}

	/**
	 * 儿童材料审核
	 * 
	 * @author wangzheng
	 * @date 2014-9-16
	 * @return
	 */
	public String childInfoAudit() {
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		String level = getParameter("level", "");
		if ("".equals(uuid)) {
			level = (String) this.getAttribute("level");
		}
		if (ChildInfoConstants.LEVEL_CCCWA.equals(level)) {
			retValue = "CMS_ZX_CLSH_AUDIT";
		} else if (ChildInfoConstants.LEVEL_PROVINCE.equals(level)) {
			retValue = "CMS_ST_SHJS_AUDIT";
		}

		try {
			conn = ConnectionManager.getConnection();
			Data data = handler.getChildInfoAuditData(conn, uuid);
			setAttribute("data", data);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							data.getString("CHILD_IDENTITY"),
							data.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			setAttribute("uploadParameter", xmlstr);

		} catch (DBException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;

	}

	/**
	 * 儿童材料审核保存提交
	 * 
	 * @author wangzheng
	 * @date 2014-9-16
	 * @return
	 * 
	 */
	public String childInfoAuditSave() {

		// 1 获得页面表单数据，构造数据结果集
		// 1.1获得儿童材料信息
		Data cdata = getRequestEntityData("P_", "CI_ID", "PROVINCE_ID",
				"WELFARE_ID", "NAME", "SEX", "BIRTHDAY", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_EN",
				"SENDER_ADDR", "PICKUP_DATE", "ENTER_DATE", "SEND_DATE",
				"IS_ANNOUNCEMENT", "ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE",
				"IS_HOPE", "IS_PLAN", "DISEASE_CN", "REMARKS", "AUD_STATE",
				"FILE_CODE", "FILE_CODE_EN", "CHILD_TYPE", "SPECIAL_FOCUS",
				"SN_DEGREE", "NAME_PINYIN");

		// 1.2获得材料审核信息
		Data adata = getRequestEntityData("A_", "CA_ID", "AUDIT_LEVEL",
				"AUDIT_OPTION", "AUDIT_CONTENT", "AUDIT_DATE", "AUDIT_REMARKS");
		// 1.3获得表单操作标识
		String OPERATION_STATE = this.getParameter("state");
		adata.put("OPERATION_STATE", OPERATION_STATE);// 处理结果
		// 1.4根据操作标识、审核级别获得材料审核状态
		ChildStateManager csm = new ChildStateManager();
		String AUD_STATE = csm.getChildAudState(cdata.getString("AUD_STATE"),
				adata.getString("AUDIT_LEVEL"),
				adata.getString("AUDIT_OPTION"), OPERATION_STATE);
		cdata.put("AUD_STATE", AUD_STATE);

		// 1.5 审核人员信息
		UserInfo curuser = SessionInfo.getCurUser();
		adata.put("AUDIT_USERID", curuser.getPerson().getPersonId());
		adata.put("AUDIT_USERNAME", curuser.getPerson().getCName());

		// 1.6 获得材料补充信息
		Data adddata = getRequestEntityData("ADD_", "NOTICE_CONTENT",
				"IS_MODIFY", "IS_FLY", "IS_ST");
		// 1.7设置操作处理结果信息
		/*
		 * if(ChildStateManager.OPERATION_STATE_DOING.equals(OPERATION_STATE)){
		 * retValue = "save"; strRet = "儿童材料审核保存成功"; }else
		 * if(ChildStateManager.OPERATION_STATE_DONE.equals(OPERATION_STATE)){
		 * retValue = "submit"; strRet = "儿童材料审核提交成功"; }
		 */
		String result = this.getParameter("result", "");

		// 1.8 审核级别判断
		String SOURCE = "";
		if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
				.getString("AUDIT_LEVEL"))) {// 省审核
			retValue = "CMS_ST_SHJS_LIST";
			SOURCE = ChildInfoConstants.LEVEL_PROVINCE;
		} else if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
				.getString("AUDIT_LEVEL"))) {// 中心审核
			if (ChildInfoConstants.CHILD_TYPE_NORMAL.equals(cdata
					.getString("CHILD_TYPE"))) {// 正常儿童
				retValue = "CMS_ZX_ZCCLSH_LIST";
			} else {
				retValue = "CMS_ZX_TXCLSH_LIST";
			}
			SOURCE = ChildInfoConstants.LEVEL_CCCWA;
		}

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean ret = true;
			// 3 执行数据库处理操作
			// 3.1根据审核意见分别处理
			if (ChildStateManager.CHILD_AUD_OPTION_FAILURE.equals(adata
					.getString("AUDIT_OPTION"))) {// 不通过
				// adata.put("OPERATION_STATE",
				// ChildStateManager.OPERATION_STATE_DONE);//处理完成
				// 3.1.1 更新材料主表退文状态
				cdata.put("RETURN_STATE",
						ChildStateManager.CHILD_RETURN_STATE_FLAG);
				// 3.1.2 创建退材料记录
				Data ciRevocationData = new Data();
				// 儿童材料ID
				ciRevocationData.put("CI_ID", cdata.getString("CI_ID"));
				// 省厅ID
				ciRevocationData.put("PROVINCE_ID",
						cdata.getString("PROVINCE_ID"));
				// 福利院ID
				ciRevocationData.put("WELFARE_ID",
						cdata.getString("WELFARE_ID"));
				// 姓名
				ciRevocationData.put("NAME", cdata.getString("NAME"));
				// 性别
				ciRevocationData.put("SEX", cdata.getString("SEX"));
				// 出生日期
				ciRevocationData.put("BIRTHDAY", cdata.getString("BIRTHDAY"));
				// 退材料结果
				ciRevocationData.put("BACK_RESULT",
						ChildStateManager.CHILD_RETURN_STATE_FLAG);
				// 退文日期
				ciRevocationData.put("BACK_DATE", DateUtility.getCurrentDate());

				// 根据审核级别设置退材料分类
				if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
						.getString("AUDIT_LEVEL"))) {// 中心审核
					cdata.put("RETURN_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_ZXBG);
					// 退材料分类
					ciRevocationData.put("BACK_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_ZXBG);
					// 退材料原因
					ciRevocationData.put("RETURN_REASON",
							ChildStateManager.CHILD_RETURN_REASON_ZXBG);
					// 材料全局状态
					manager.zxAuditNoPass(cdata, curuser.getCurOrgan());
				}
				if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
						.getString("AUDIT_LEVEL"))) {// 省厅审核
					cdata.put("RETURN_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_SBG);
					// 退材料分类
					ciRevocationData.put("BACK_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_SBG);
					// 退材料原因
					ciRevocationData.put("RETURN_REASON",
							ChildStateManager.CHILD_RETURN_REASON_SBG);

					// 材料全局状态
					manager.stAuditNoPass(cdata, curuser.getCurOrgan());
				}
				ChildReturnHandler crHandler = new ChildReturnHandler();
				crHandler.save(conn, ciRevocationData);

			} else if (ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL
					.equals(adata.getString("AUDIT_OPTION"))) {// 补充
				// adata.put("OPERATION_STATE",
				// ChildStateManager.OPERATION_STATE_DOING);//处理中
				ChildAdditionHandler caHandler = new ChildAdditionHandler();
				// 创建补充记录
				// 1儿童材料ID
				adddata.put("CI_ID", cdata.getString("CI_ID"));
				// 2省份ID
				adddata.put("PROVINCE_ID", cdata.getString("PROVINCE_ID"));
				// 3福利院ID
				adddata.put("WELFARE_ID", cdata.getString("WELFARE_ID"));
				// 4补充状态
				adddata.put("CA_STATUS", ChildStateManager.CHILD_ADD_STATE_TODO);
				// 5通知来源
				adddata.put("SOURCE", SOURCE);
				// 6通知日期
				adddata.put("NOTICE_DATE", DateUtility.getCurrentDate());
				// 7通知人ID
				adddata.put("SEND_USERID", curuser.getPerson().getPersonId());
				// 8通知人姓名
				adddata.put("SEND_USERNAME", curuser.getPerson().getCName());
				// 9材料末次补充状态
				cdata.put("SUPPLY_STATE",
						ChildStateManager.CHILD_ADD_STATE_TODO);

				ret = caHandler.save(conn, adddata);
				if (!ret) {
					InfoClueTo clueTo = new InfoClueTo(2, "补充记录保存失败!");// 保存失败 2
					setAttribute("clueTo", clueTo);
					retValue = "error";
					return retValue;
				}

				if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
						.getString("AUDIT_LEVEL"))) {// 中心审核
					// 材料全局状态
					manager.zxAuditSupply(cdata, curuser.getCurOrgan());
					// 设置儿童审核状态为中心审核中20141211furx
					cdata.add("AUD_STATE",
							ChildStateManager.CHILD_AUD_STATE_ZXSHZ);
				}
				if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
						.getString("AUDIT_LEVEL"))) {// 省厅审核
					// 材料全局状态
					manager.stAuditSupply(cdata, curuser.getCurOrgan());
					// 设置儿童审核状态为省厅审核中20141211furx
					cdata.add("AUD_STATE",
							ChildStateManager.CHILD_AUD_STATE_SSHZ);
				}

			} else if (ChildStateManager.CHILD_AUD_OPTION_SUCCESS.equals(adata
					.getString("AUDIT_OPTION"))) {// 通过
				// adata.put("OPERATION_STATE",
				// ChildStateManager.OPERATION_STATE_DONE);//处理完成
				if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
						.getString("AUDIT_LEVEL"))) {// 中心审核
					if (ChildStateManager.CHILD_AUD_RESULT_TRAN.equals(result)) {// 送翻
						// 创建材料交接记录
						DataList dl = new DataList();
						Data dataTransfer = new Data();
						dataTransfer.put("APP_ID", cdata.getString("CI_ID"));
						dataTransfer.put("TRANSFER_CODE",
								TransferCode.CHILDINFO_AZB_FYGS);
						dataTransfer.put("TRANSFER_STATE", "0");
						dl.add(dataTransfer);
						FileCommonManager fm = new FileCommonManager();
						fm.transferDetailInit(conn, dl);
						// 材料全局状态
						manager.zxToTranslation(cdata, curuser.getCurOrgan());
					}
					if (ChildStateManager.CHILD_AUD_RESULT_MATCH.equals(result)) {// 直接匹配
						cdata.put("MATCH_STATE",
								ChildStateManager.CHILD_MATCH_STATE_TODO);
					}
					if (ChildStateManager.CHILD_AUD_RESULT_PUB.equals(result)) {// 直接发布
						cdata.put("PUB_STATE",
								ChildStateManager.CHILD_PUB_STATE_TODO);
					}
				}
				if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
						.getString("AUDIT_LEVEL"))) {// 省厅审核
					// 材料全局状态
					manager.stAuditPass(cdata, curuser.getCurOrgan());
				}
			}
			ret = handler.childInfoAudit(conn, cdata, adata);
			if (ret) {
				InfoClueTo clueTo = new InfoClueTo(0, "审核记录提交成功");// 保存成功
				setAttribute("clueTo", clueTo);

				// 将附件进行发布
				AttHelper.publishAttsOfPackageId(cdata.getString("FILE_CODE"),
						"CI");
				AttHelper.publishAttsOfPackageId(
						cdata.getString("FILE_CODE_EN"), "CI");

				dt.commit();
			} else {
				InfoClueTo clueTo = new InfoClueTo(2, "审核记录提交失败!");// 保存失败 2
				setAttribute("clueTo", clueTo);
				retValue = "error";
				return retValue;
			}
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
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
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}

		return retValue;
	}

	/**
	 * 保存儿童材料详细信息
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return
	 */
	public String save() {
		// 1 获得页面表单数据，构造数据结果集
		// 1.1获得儿童材料信息
		Data data = getRequestEntityData("P_", "CI_ID", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_ADDR",
				"PICKUP_DATE", "ENTER_DATE", "SEND_DATE", "IS_ANNOUNCEMENT",
				"ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE", "IS_HOPE",
				"IS_PLAN", "DISEASE_CN", "REMARKS", "SN_DEGREE",
				"SPECIAL_FOCUS", "NAME_PINYIN", "SENDER_EN");

		// 1.2设置附件原件及翻译件的packid
		data.add("FILE_CODE", data.getString("CI_ID"));
		String FILE_CODE_EN = "F_" + data.getString("CI_ID");
		data.add("FILE_CODE_EN", FILE_CODE_EN);
		// 1.3 状态处理
		String state = getParameter("state");
		retValue = "save";
		String strRet = "儿童材料保存成功";

		// 1.4 中心代录处理方式
		String result = getParameter("result",
				ChildStateManager.CHILD_AUD_RESULT_TRAN);

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);

			// 获取当前登录人的信息
			UserInfo curuser = SessionInfo.getCurUser();
			Organ organ = curuser.getCurOrgan();
			String orgType = String.valueOf(organ.getOrgType());

			if (ChildInfoConstants.ORGAN_TYPE_FLY.equals(orgType)) { // 登录人为福利院用户
				// 设置儿童材料审核状态
				data.add("AUD_STATE", state);
				if (ChildStateManager.CHILD_AUD_STATE_SDS.equals(state)) {// 如果儿童信息保存成功，且提交，创建材料审核记录

					// 设置全局状态
					this.manager.flySubmitChildInfo(data, organ);
					// 材料审核级别，省审核
					String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",
							ChildInfoConstants.LEVEL_PROVINCE);
					Data dataAduit = new Data();
					dataAduit.put("CI_ID", data.getString("CI_ID"));
					dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
					dataAduit.put("OPERATION_STATE",
							ChildStateManager.OPERATION_STATE_TODO);
					// 创建审核记录
					handler.saveCIAduit(conn, dataAduit);
					strRet = "儿童材料提交成功";
					retValue = "CMS_FLY_CLBS_LIST";
				}
			} else if (ChildInfoConstants.ORGAN_TYPE_ST.equals(orgType)) {// 登录人为省厅用户

			} else if (ChildInfoConstants.ORGAN_TYPE_ZX.equals(orgType)) {// 登录人为中心用户

				if ("1".equals(state)) {// 如果儿童信息提交
					// 设置儿童材料审核状态，状态为“中心通过”
					state = ChildStateManager.CHILD_AUD_STATE_ZXTG;
					if (ChildStateManager.CHILD_AUD_RESULT_TRAN.equals(result)) {// 送翻
						// 创建材料交接记录
						DataList dl = new DataList();
						Data dataTransfer = new Data();
						dataTransfer.put("APP_ID", data.getString("CI_ID"));
						dataTransfer.put("TRANSFER_CODE",
								TransferCode.CHILDINFO_AZB_FYGS);
						dataTransfer.put("TRANSFER_STATE", "0");
						dl.add(dataTransfer);
						FileCommonManager fm = new FileCommonManager();
						fm.transferDetailInit(conn, dl);
						// 材料全局状态
						manager.zxToTranslation(data, curuser.getCurOrgan());
					}

					if (ChildStateManager.CHILD_AUD_RESULT_MATCH.equals(result)) {// 直接匹配
						data.put("MATCH_STATE",
								ChildStateManager.CHILD_MATCH_STATE_TODO);
					}
					if (ChildStateManager.CHILD_AUD_RESULT_PUB.equals(result)) {// 直接发布
						data.put("PUB_STATE",
								ChildStateManager.CHILD_PUB_STATE_TODO);
					}

					strRet = "儿童材料提交成功";
					retValue = "CMS_AZB_DL_LIST";
				}
				data.add("AUD_STATE", state);
			}
			// 保存儿童材料记录
			handler.save(conn, data);

			// 将附件进行发布
			AttHelper.publishAttsOfPackageId(data.getString("FILE_CODE"), "CI");
			AttHelper.publishAttsOfPackageId(FILE_CODE_EN, "CI");

			if ("save".equals(retValue)) {// 如果是保存，不是提交
				setAttribute("UUID", data.getString("CI_ID"));
				setAttribute("type", "mod");
				DataList attType = new DataList();
				ChildCommonManager ccm = new ChildCommonManager();
				BatchAttManager bm = new BatchAttManager();
				attType = bm.getAttType(
						conn,
						ccm.getChildPackIdByChildIdentity(
								data.getString("CHILD_IDENTITY"),
								data.getString("CHILD_TYPE"), false));
				String xmlstr = bm.getUploadParameter(attType);
				setAttribute("uploadParameter", xmlstr);
			}
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, strRet);
			setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
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
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		System.out.println(retValue);
		return retValue;
	}

	/**
	 * 儿童材料补充页面的“修改儿童基本信息”按钮对应的修改页面
	 * 
	 * @author furx
	 * @date 2014-10-24
	 * @return
	 */
	public String toChildInfoModify() {
		String ci_id = getParameter("CI_ID", "");
		retValue = SUCCESS;
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.getShowData(conn, ci_id);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);

			setAttribute("data", showdata);
			setAttribute("uploadParameter", xmlstr);

		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}

		return retValue;
	}

	/**
	 * 保存儿童材料详细信息(儿童材料补充页面“修改材料信息”按钮对应儿童材料修改页面的保存操作)
	 * 
	 * @author furx
	 * @date 2014-10-24
	 * @return
	 */
	public String saveChildInfo() {
		// 1 获得页面表单数据，构造数据结果集
		// 1.1获得儿童材料信息
		Data data = getRequestEntityData("P_", "CI_ID", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_ADDR",
				"PICKUP_DATE", "ENTER_DATE", "SEND_DATE", "IS_ANNOUNCEMENT",
				"ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE", "IS_HOPE",
				"IS_PLAN", "DISEASE_CN", "REMARKS", "SN_DEGREE",
				"SPECIAL_FOCUS", "NAME_PINYIN", "SENDER_EN");

		// 1.2设置附件原件及翻译件的packid
		data.add("FILE_CODE", data.getString("CI_ID"));
		String FILE_CODE_EN = "F_" + data.getString("CI_ID");
		data.add("FILE_CODE_EN", FILE_CODE_EN);
		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			// 保存儿童材料记录
			handler.save(conn, data);
			// 将附件进行发布
			AttHelper.publishAttsOfPackageId(data.getString("FILE_CODE"), "CI");
			AttHelper.publishAttsOfPackageId(FILE_CODE_EN, "CI");
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return SUCCESS;
	}

	/**
	 * 福利院批量提交儿童材料信息
	 * 
	 * @author wangzheng
	 * @date 2014-9-15
	 * @return
	 * 
	 */
	public String flyBatchSubmit() {
		// 0 获得用户基本信息
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();

		// 1 获得批量提交的材料id集合
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		// 材料记录list
		DataList dataList = new DataList();
		// 材料审核记录list
		DataList aduitDataList = new DataList();
		try {
			for (int i = 0; i < uuid.length; i++) {
				// 更新儿童材料状态
				Data data = new Data();
				data.setConnection(conn);
				data.setEntityName("CMS_CI_INFO");
				data.setPrimaryKey("CI_ID");
				data.add("CI_ID", uuid[i]);
				data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_SDS);

				// 设置全局状态
				this.manager.flySubmitChildInfo(data, organ);
				dataList.add(data);

				// 创建儿童材料审核记录
				Data aduitData = new Data();
				aduitData.setConnection(conn);
				aduitData.setEntityName("CMS_CI_ADUIT");
				aduitData.setPrimaryKey("CA_ID");
				aduitData.put("CI_ID", uuid[i]);
				aduitData.put("AUDIT_LEVEL", ChildInfoConstants.LEVEL_PROVINCE);
				aduitData.put("OPERATION_STATE",
						ChildStateManager.OPERATION_STATE_TODO);
				aduitDataList.add(aduitData);
			}

			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 执行数据库处理操作
			success = handler.flyBatchSubmit(conn, dataList, aduitDataList);

			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "材料提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("材料提交异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 省厅批量寄送儿童材料信息
	 * 
	 * @author wangzheng
	 * @date 2014-9-18
	 * @return
	 * 
	 */
	public String stBatchPost() {

		// 1 获得批量提交的材料id集合
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 执行数据库处理操作
			success = handler.stBatchPost(conn, uuid);

			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "寄送成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "材料寄送异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("材料寄送异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料寄送失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料寄送失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料寄送失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 寄送儿童材料打印
	 * 
	 * @author wangzheng
	 * @date 2014-9-18
	 * @return
	 * 
	 */
	public String postPrint() {

		// 1 获得批量提交的材料id集合
		String uuids = (String) getParameter("printid", "");
		System.out.println("uuid:" + uuids);
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 3 执行数据库处理操作
			DataList list = handler.getChildListByCIID(conn, uuid);
			// 获取正常儿童数目
			DataList normalList = handler.getChildListByCIIDAndChildType(conn,
					uuid, ChildInfoConstants.CHILD_TYPE_NORMAL);
			// 获取特需儿童数目
			DataList specialList = handler.getChildListByCIIDAndChildType(conn,
					uuid, ChildInfoConstants.CHILD_TYPE_SPECAL);
			UserInfo curuser = SessionInfo.getCurUser();
			String postPerson = curuser.getPerson().getCName();
			Calendar postCalendar = GregorianCalendar.getInstance();
			String dateStr = postCalendar.get(Calendar.YEAR) + "年"
					+ (postCalendar.get(Calendar.MONTH) + 1) + "月"
					+ postCalendar.get(Calendar.DAY_OF_MONTH) + "日";
			setAttribute("normalSize", normalList.size() + "");
			setAttribute("specialSize", specialList.size() + "");
			setAttribute("allSize", list.size() + "");
			setAttribute("postDate", dateStr);
			setAttribute("postPerson", postPerson);
			setAttribute("list", list);
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "材料寄送打印单异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("材料寄送打印单异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料寄送打印失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 安置部批量接收儿童材料信息
	 * 
	 * @author wangzheng
	 * @date 2014-9-18
	 * @return
	 * 
	 */
	public String azbBatchReceive() {

		// 1 获得批量提交的材料id集合
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 执行数据库处理操作
			success = handler.azbBatchReceive(conn, uuid);

			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "接收成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "材料接收异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("材料接收异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料接收失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料接收失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料接收失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 安置部代录批量提交儿童材料信息 state=1 批量送翻 state=2 批量送审
	 * 
	 * @author wangzheng
	 * @date 2014-10-24
	 * @return
	 * 
	 */
	public String azbBatchSubmit() {

		// 1 获得批量提交的材料id集合
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		// 1.2 获得送翻送审标识
		String state = getParameter("state", "1");

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 执行数据库处理操作
			success = handler.azbBatchSubmit(conn, uuid, state);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "材料提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("材料提交异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料查看、修改
	 * 
	 * @author wangzheng
	 * @date 2014-9-15
	 * @return
	 */
	public String show() {
		// 获取参数来标志儿童材料基本信息查看页面是否作为单独页面出现
		String onlyOne = getParameter("onlyOne", "");
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		String type = getParameter("type", "");
		if ("".equals(type)) {
			type = (String) this.getAttribute("type");
		}
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.getShowData(conn, uuid);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			// 获得该儿童的同胞信息
			DataList twinsList = handler.getTwinsByChildNO(conn,
					showdata.getString("CHILD_NO"));
			setAttribute("twinsList", twinsList);
			setAttribute("data", showdata);
			setAttribute("uploadParameter", xmlstr);
			setAttribute("onlyOne", onlyOne);

		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		if ("show".equals(type)) {
			return "show";
		} else if ("mod".equals(type)) {
			return "mod";
		} else {
			return retValue;
		}
	}

	/**
	 * 儿童材料查看(儿童信息收养组织统一查看页面)
	 * 
	 * @author furx
	 * @date 2014-11-18
	 * @return
	 */
	public String showForAdoption() {
		String ri_state = getParameter("RI_STATE","");
		String uuid = getParameter("UUID", "");
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.showForAdoption(conn, uuid, ri_state);
			DataList attType = new DataList();

			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			setAttribute("uploadParameter", xmlstr);
			setAttribute("data", showdata);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 
	 * 儿童材料查看 儿童信息+更新记录(儿童信息收养组织统一查看页面)
	 * 
	 * @author furx
	 * @date 2014-11-30
	 * @return retValue
	 */
	public String childInfoForAdoption() {
		// 获取参数
		String CI_ID = (String) getParameter("UUID");
		String ri_state = (String) getParameter("RI_STATE");
		String onlyPage = (String) getParameter("onlyPage");
		setAttribute("CI_ID", CI_ID);
		setAttribute("RI_STATE", ri_state);
		setAttribute("onlyPage", onlyPage);
		return retValue;
	}

	/**
	 * 儿童材料附件信息查看(附件查看页面包括中英文)
	 * 
	 * @author furx
	 * @date 2014-11-30
	 * @return
	 */
	public String childAttShowList() {
		String CI_ID = getParameter("CI_ID");// 儿童材料ID/中文附件packageId
		String CHILD_TYPE = getParameter("CHILD_TYPE");// 儿童类型
		String CHILD_IDENTITY = getParameter("CHILD_IDENTITY");// 儿童身份
		String FILE_CODE_EN = "F_" + CI_ID;// 英文附件packageId
		try {
			conn = ConnectionManager.getConnection();
			// 附件小类
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(
					CHILD_IDENTITY, CHILD_TYPE, true));
			// 遍历附件小类，获取相应的中英文附件内容
			for (int i = 0; i < attType.size(); i++) {
				String CODE = attType.getData(i).getString("CODE");
				DataList Attdl = handler.childAttShowList(conn, CI_ID, CODE);// 中文附件
				DataList Attdl1 = handler.childAttShowList(conn, FILE_CODE_EN,
						CODE);// 英文附件
				attType.getData(i).add("ATTCNLIST", Attdl);
				attType.getData(i).add("ATTENLIST", Attdl1);
			}
			setAttribute("attType", attType);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}
	public String childAttShowListCN() {
		String CI_ID = getParameter("CI_ID");// 儿童材料ID/中文附件packageId
		String CHILD_TYPE = getParameter("CHILD_TYPE");// 儿童类型
		String CHILD_IDENTITY = getParameter("CHILD_IDENTITY");// 儿童身份
		String FILE_CODE_EN = "F_" + CI_ID;// 英文附件packageId
		try {
			conn = ConnectionManager.getConnection();
			// 附件小类
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(
					CHILD_IDENTITY, CHILD_TYPE, true));
			// 遍历附件小类，获取相应的中英文附件内容
			for (int i = 0; i < attType.size(); i++) {
				String CODE = attType.getData(i).getString("CODE");
				DataList Attdl = handler.childAttShowList(conn, CI_ID, CODE);// 中文附件
				DataList Attdl1 = handler.childAttShowList(conn, FILE_CODE_EN,
						CODE);// 英文附件
				attType.getData(i).add("ATTCNLIST", Attdl);
				attType.getData(i).add("ATTENLIST", Attdl1);
			}
			setAttribute("attType", attType);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}
	/**
	 * 儿童材料及更新记录查看页面（爱之桥/翻译公司 材料更新-特需材料更新 对应列表中的查看页面）
	 * 
	 * @author wangzheng
	 * @date 2014-9-15
	 * @return
	 */
	public String showForAZQ() {
		String uuid = getParameter("UUID", "");
		setAttribute("CI_ID", uuid);
		return retValue;
	}

	/**
	 * 儿童材料接收条码打印
	 * 
	 * @author panfeng
	 * @date 2014-10-26
	 * @return
	 * 
	 */
	public String receivePrint() {

		// 1 获得批量提交的材料id集合
		String printuuid = getParameter("printuuid", "");
		String[] uuid = printuuid.split(",");
		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 3 执行数据库处理操作
			DataList list = handler.getChildListByCIID(conn, uuid);
			setAttribute("list", list);
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "条码预览打印单异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("条码预览打印单异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "条码预览打印失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 根据CIID获得儿童审核记录列表
	 * 
	 * @author wangzheng
	 * @date 2014-9-19
	 * @return
	 */
	public String getChildAuditRecorderByCIID() {
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		try {
			conn = ConnectionManager.getConnection();
			DataList auditList = handler.getAuditListByCIID(conn, uuid);
			setAttribute("List", auditList);
		} catch (DBException e) {
			e.printStackTrace();
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						retValue = "error";
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料信息删除
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return retValue
	 */
	public String delete() {
		String deleteuuid = getParameter("uuid", "");
		String listType = getParameter("listType", "CMS_FLY_CLBS_LIST");
		retValue = listType;

		deleteuuid = deleteuuid.substring(1, deleteuuid.length());
		String[] uuid = deleteuuid.split("#");
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			success = handler.delete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
			retValue = "error";
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("删除操作异常[删除操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "删除失败!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError(
								"CmsCiAdditionalAction的Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料基本信息录入
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return retValue
	 */
	public String basicadd() {
		// 根据用户身份，判断儿童材料的省份和福利院
		// 获取当前登录人的信息
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();

		Data data = new Data();
		DataList welfareList = new DataList();
		// String orgType = String.valueOf(organ.getOrgType());

		// 获取列表类别
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		try {
			conn = ConnectionManager.getConnection();
			if ("CMS_FLY_CLBS_LIST".equals(listType)) {
				// 登录人为福利院用户
				String WELFARE_ID = organ.getOrgCode();
				String WELFARE_NAME_CN = organ.getCName();
				String WELFARE_NAME_EN = organ.getEnName();
				// 省份ID
				String PROVINCE_ID = manager.getProviceId(WELFARE_ID);
				data.put("WELFARE_ID", WELFARE_ID);
				data.put("WELFARE_NAME_CN", WELFARE_NAME_CN);
				data.put("WELFARE_NAME_EN", WELFARE_NAME_EN);
				data.put("PROVINCE_ID", PROVINCE_ID);

			} else if ("CMS_AZB_DL_LIST".equals(listType)) {
				// 登录人为中心用户
				// 获取所有福利院信息
				welfareList = this.manager.getAllWelfareList(conn);
			}
			setAttribute("data", data);
			setAttribute("listType", listType);
			setAttribute("welfareList", welfareList);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
						System.out.println("basicaddConnection");
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料详细信息录入
	 * 
	 * @author wangzheng
	 * @date 2014-9-10
	 * @return retValue
	 */
	public String infoadd() {
		// 0 获得用户基本信息
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		// 1 参数初始化
		Data data = getRequestEntityData("P_", "PROVINCE_ID", "WELFARE_ID",
				"WELFARE_NAME_CN", "WELFARE_NAME_EN", "CHILD_TYPE", "NAME",
				"SEX", "BIRTHDAY", "CHILD_IDENTITY", "IS_DAILU");
		// 1.1 设置儿童材料的登记人、登记部门信息
		data.put("REG_ORGID", organ.getOrgCode());
		data.put("REG_USERID", curuser.getPersonId());
		data.put("REG_USERNAME", curuser.getPerson().getCName());
		data.put("REG_DATE", DateUtility.getCurrentDate());

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 创建事务
			dt = DBTransaction.getInstance(conn);

			// 2.1 判断该福利院是否存在儿童名称+性别+出生日期相同的儿童信息
			DataList dlist = handler.getChildInfoList(conn, data);
			if (dlist.size() != 0) {// 如果存在
				retValue = "bizerror";
				StringBuffer sb = new StringBuffer();
				sb.append("系统中已存在相同儿童信息！");
				setAttribute("error", sb.toString());
				String url = "/cms/childManager/basicadd.action?listType="
						+ listType;
				setAttribute("url", url);
				return retValue;
			}

			// 2.2 判断福利信息系统是否存在福利院+儿童名称+性别+出生日期相同的儿童信息，如存在则取出儿童信息
			Data flxtData = this.getChildDataFromFlxt(data);
			if (flxtData != null) {// 如果福利信息系统存在该儿童的信息
				// TODO
			}

			// 2.3 生成儿童编号
			String CHILD_NO = this.manager.createChildNO(data, conn);
			data.put("CHILD_NO", CHILD_NO);

			// 2.4 儿童姓名拼音处理
			String NAME = data.getString("NAME");
			String NAME_PINYIN = this.manager.getPinyin(NAME);
			data.put("NAME_PINYIN", NAME_PINYIN);

			// 2.5 儿童审核状态
			data.put("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_WTJ);

			// 2.6同胞标识，默认为否
			String IS_TWINS = "0";
			String TWINS_IDS = "";
			data.put("IS_TWINS", IS_TWINS);
			data.put("TWINS_IDS", TWINS_IDS);
			data.put("IS_MAIN", "1");

			// 2.9 设置全局状态
			this.manager.createChildInfo(data, organ);
			// 如果是非福利机构需要设置儿童默认的送养人、送养人英文名称、送养人地址
			String welfearName = data.getString("WELFARE_NAME_CN", null);
			if (welfearName != null && (welfearName.indexOf("非福利机构") < 0)) {
				// 2.10设置儿童默认的送养人、送养人地址、送养人英文名称
				data.add("SENDER", data.getString("WELFARE_NAME_CN"));// 送养人
				data.add("SENDER_EN", data.getString("WELFARE_NAME_EN"));// 送养人英文名称
				// 根据福利院ID获取福利院地址
				DataList orgDetails = handler.getOrgDeitail(conn,
						data.getString("WELFARE_ID"));
				if (orgDetails.size() > 0) {
					Data orgInfo = orgDetails.getData(0);
					data.add("SENDER_ADDR",
							orgInfo.getString("DEPT_ADDRESS_CN"));// 送养人地址
				}
			}
			// 3 生成儿童记录
			data.add("CI_ID", "");// 如果没有改代码，则下面3.1获取的CI_ID值为空
			Data d = handler.save(conn, data);

			// 3.1更新儿童记录信息
			data.put("CI_ID", d.getString("CI_ID"));
			data.put("FILE_CODE", d.getString("CI_ID")); // 附件ID
			data.put("FILE_CODE_EN", "F_" + d.getString("CI_ID"));// 附件ID_EN
			data.put("MAIN_CI_ID", d.getString("CI_ID"));// 主ID
			data.add("PHOTO_CARD", d.getString("CI_ID"));// 设置头像的packageId
			handler.save(conn, data);

			// 3.2根据儿童身份获取附加列表
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							data.getString("CHILD_IDENTITY"),
							data.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);

			setAttribute("data", data);
			setAttribute("uploadParameter", xmlstr);
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "姓名拼音转换异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("姓名拼音转换异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			retValue = "error1";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
						System.out.println("infoaddConnection");
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 同胞设置列表
	 * 
	 * @author wangzheng
	 * @date 2014-9-12
	 * @param childNO
	 *            儿童编号
	 * @return Data
	 */
	public String twinsList() {

		// 1 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		// int pageSize = 5;
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "REG_DATE";
		}
		// 2.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}

		String CHILD_NO = (String) getParameter("CHILD_NO", "");
		String CI_ID = (String) getParameter("CI_ID", "");
		String WELFARE_ID = (String) getParameter("WELFARE_ID", "");

		// UserInfo curuser = SessionInfo.getCurUser();
		// Organ organ = curuser.getCurOrgan();
		// String WELFARE_ID = organ.getOrgCode();

		Data data = getRequestEntityData("S_", "NAME", "SEX", "BIRTHDAY_START",
				"BIRTHDAY_END");
		data.put("WELFARE_ID", WELFARE_ID);
		data.put("CI_ID", CI_ID);
		data.add("CHILD_NO", CHILD_NO);

		try {
			// 3 获取数据库连接
			conn = ConnectionManager.getConnection();

			// 获得该儿童的同胞信息
			DataList twinsList = handler.getTwinsByChildNO(conn, CHILD_NO);
			// 获得本福利院所有儿童信息列表
			DataList dataList = handler.getValidChildList(conn, data, pageSize,
					page, compositor, ordertype);
			setAttribute("twinsList", twinsList);
			setAttribute("dataList", dataList);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			setAttribute("CHILD_NO", CHILD_NO);
			setAttribute("CI_ID", CI_ID);
			setAttribute("WELFARE_ID", WELFARE_ID);

		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					retValue = "error";
				}
			}
		}

		return retValue;
	}

	/**
	 * 增加同胞记录 最后设置的儿童为主标识儿童
	 * 
	 * @return
	 */
	public String twinsadd() {

		String cids = getParameter("cid", "");
		// String cnos=getParameter("cno", "");

		String CHILD_NO = getParameter("CHILD_NO", "");
		String CI_ID = getParameter("CI_ID", "");

		// cids=cids.substring(1, cids.length());
		// cnos=cnos.substring(1,cnos.length());
		cids = cids.substring(1, cids.length());
		String[] cid = cids.split("#");
		// String[] cno=cnos.split("#");

		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			StringBuffer sbMainCIID = new StringBuffer();
			sbMainCIID.append("(");
			for (int i = 0; i < cid.length; i++) {
				sbMainCIID.append("'");
				sbMainCIID.append(cid[i]);
				sbMainCIID.append("'");
				if (i != cid.length - 1) {
					sbMainCIID.append(",");
				}
			}
			sbMainCIID.append(")");
			// 获取新添加的同胞儿童信息
			DataList newChildList = handler.getChildListByMainCIIDS(conn,
					sbMainCIID.toString());

			// 获得原有的同胞儿童的信息
			DataList oldChilddata = handler.getTwinListByCIID(conn, CI_ID);
			newChildList.addAll(oldChilddata);

			// 构造同胞儿童编号
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < newChildList.size(); i++) {
				sb.append(newChildList.getData(i).getString("CHILD_NO", ""));
				if (i != newChildList.size() - 1) {
					sb.append(",");
				}
			}

			String TWINS_IDS = sb.toString();
			System.out.println("TWINS_IDS:" + TWINS_IDS);

			// 设置儿童信息同胞属性
			for (int j = 0; j < newChildList.size(); j++) {
				newChildList.getData(j).setEntityName("CMS_CI_INFO");
				newChildList.getData(j).setPrimaryKey("CI_ID");
				newChildList.getData(j).put("IS_TWINS", "1");
				newChildList.getData(j).put("MAIN_CI_ID", CI_ID);
				newChildList.getData(j).put(
						"TWINS_IDS",
						handler.getTWINS_IDS(TWINS_IDS, newChildList.getData(j)
								.getString("CHILD_NO")));
				if (CI_ID.equals(newChildList.getData(j).getString("CI_ID"))) {// 将设置同胞的儿童置为主标识儿童
					newChildList.getData(j).put("IS_MAIN", "1");
				} else {
					newChildList.getData(j).put("IS_MAIN", "0");
				}
			}
			handler.setTwins(conn, newChildList);
			InfoClueTo clueTo = new InfoClueTo(0, "同胞设置成功!");
			setAttribute("clueTo", clueTo);
			dt.commit();
			setAttribute("CHILD_NO", CHILD_NO);
			setAttribute("CI_ID", CI_ID);
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("同胞设置操作异常[同胞设置操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "同胞设置失败!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 删除同胞记录
	 * 
	 * @return
	 */
	public String twinsdelete() {
		String cid = getParameter("cid", "");
		String cno = getParameter("cno", "");
		String CHILD_NO = getParameter("CHILD_NO", "");
		String CI_ID = getParameter("CI_ID", "");

		// 1 更新同胞删除的儿童属性，将同胞标识置为否
		Data twinsdeleteData = new Data();
		twinsdeleteData.put("CI_ID", cid);
		twinsdeleteData.put("IS_TWINS", "0");
		twinsdeleteData.put("TWINS_IDS", "");
		twinsdeleteData.put("IS_MAIN", "1");
		twinsdeleteData.put("MAIN_CI_ID", cid);

		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			// 获取该儿童的所有同胞记录
			DataList dl = handler.getTwinListByCIID(conn, CI_ID);
			if (dl.size() <= 2) {// 如果只有一个同胞，则删除这条同胞记录后，另一个儿童也不存在同胞
				Data d = new Data();
				d.add("CI_ID", CI_ID);
				d.add("IS_TWINS", "0");
				d.add("TWINS_IDS", "");
				d.add("IS_MAIN", "1");
				d.add("MAIN_CI_ID", CI_ID);
				this.handler.save(conn, d);
			} else {
				for (int i = 0; i < dl.size(); i++) {
					Data d = dl.getData(i);
					if (CI_ID.equals(d.getString("CI_ID"))) {// 设置主标识儿童
						d.put("IS_TWINS", "1");
						d.put("TWINS_IDS", handler.getTWINS_IDS(
								d.getString("TWINS_IDS"), cno));
						d.put("IS_MAIN", "1");
						d.put("MAIN_CI_ID", CI_ID);
						this.handler.save(conn, d);
					} else if (!cid.equals(d.getString("CI_ID"))) {// 不是删除的同胞儿童
						d.put("IS_TWINS", "1");
						d.put("TWINS_IDS", handler.getTWINS_IDS(
								d.getString("TWINS_IDS"), cno));
						d.put("IS_MAIN", "0");
						d.put("MAIN_CI_ID", CI_ID);
						this.handler.save(conn, d);
					}
				}
			}
			handler.save(conn, twinsdeleteData);
			dt.commit();
			setAttribute("CHILD_NO", CHILD_NO);
			setAttribute("CI_ID", CI_ID);
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("同胞设置操作异常[同胞设置操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "同胞设置失败!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",
								e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 根据条件检索福利信息系统儿童数据，如果有数据则返回Data，如果没有符合条件的数据则返回null
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return Data TODO
	 */
	private Data getChildDataFromFlxt(Data d) {
		return null;
	}

	/**
	 * 根据查询状态和列表类型获得实际儿童审核状态 儿童审核状态包括： 0：未提交 1：省待审 2：省审核中 3：省不通过 4：省通过 5、已寄送
	 * 6、已接收 7：中心审核中 8：中心不通过 9：中心通过
	 * 
	 * @param childState
	 *            儿童查询状态条件
	 * @param listType
	 *            listType 儿童信息列表 (1)CMS_FLY_CLBS_LIST 0：未提交 -> 0：未提交 1：已提交 ->
	 *            1,2,3,4,5,6,7,8,9
	 * 
	 * @return AUD_STATE
	 */
	private String getChildAudState(String childState, String listType) {
		String audState = childState;
		if ("CMS_FLY_CLBS_LIST".equals(listType)
				|| "CMS_ST_DL_LIST".equals(listType)
				|| "CMS_AZB_DL_LIST".equals(listType)) {
			if ("0".equals(childState)) {
				audState = ",0,"; // 儿童材料未提交
			} else if ("1".equals(childState)) {
				audState = ",1,2,3,4,5,6,7,8,9,";// 儿童材料已提交
			}
		}

		if ("CMS_ST_SHJS_LIST".equals(listType)) {
			audState = childState;
		}
		return audState;
	}

	/**
	 * 儿童材料基本信息修改
	 * 
	 * @author furx
	 * @date 2014-11-17
	 * @return retValue
	 */
	public String toBasicInfoMod() {
		// 获取儿童材料主键
		String uuid = getParameter("UUID", "");
		// 获取列表类别
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		try {
			Data showdata = new Data();
			DataList welfareList = new DataList();
			conn = ConnectionManager.getConnection();
			showdata = handler.getShowData(conn, uuid);
			// 获取所有福利院信息
			welfareList = this.manager.getAllWelfareList(conn);

			setAttribute("data", showdata);
			setAttribute("listType", listType);
			setAttribute("welfareList", welfareList);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 保存儿童材料基本信息
	 * 
	 * @author furx
	 * @date 2014-11-17
	 * @return retValue
	 */
	public String saveBasicInfo() {
		// 0 获取参数
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		String oprovince = (String) getParameter("OPROVINCE_ID", "");
		String owelfareId = (String) getParameter("OWELFARE_ID", "");
		String owelfareCn = (String) getParameter("OWELFARE_NAME_CN", "");
		// 1 获取页面数据
		Data data = getRequestEntityData("P_", "PROVINCE_ID", "WELFARE_ID",
				"WELFARE_NAME_CN", "WELFARE_NAME_EN", "CHILD_TYPE", "NAME",
				"SEX", "BIRTHDAY", "CHILD_IDENTITY", "CI_ID");
		String ci_id = data.getString("CI_ID");
		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 创建事务
			dt = DBTransaction.getInstance(conn);

			// 2.1 判断该福利院是否存在儿童名称+性别+出生日期相同的儿童信息
			DataList dlist = handler.getRepeatChildList(conn, data);
			if (dlist.size() != 0) {// 如果存在
				retValue = "bizerror";
				StringBuffer sb = new StringBuffer();
				sb.append("系统中已存在相同儿童信息！");
				setAttribute("error", sb.toString());
				String url = "/cms/childManager/toBasicInfoMod.action?listType="
						+ listType + "&UUID=" + ci_id;
				setAttribute("url", url);
				return retValue;
			}

			// 2.2 判断福利信息系统是否存在福利院+儿童名称+性别+出生日期相同的儿童信息，如存在则取出儿童信息
			Data flxtData = this.getChildDataFromFlxt(data);
			if (flxtData != null) {// 如果福利信息系统存在该儿童的信息
				// TODO
			}

			// 2.3 如果儿童所在省份发生变化则需要重新设置儿童的编号
			if (!oprovince.equals(data.getString("PROVINCE_ID"))) {
				String CHILD_NO = this.manager.createChildNO(data, conn);
				data.add("CHILD_NO", CHILD_NO);
			}
			// 20141212如果儿童所在福利院发生变化则需要重新设置儿童默认的送养人中文、送养人英文、送养人地址
			if (!owelfareId.equals(data.getString("WELFARE_ID", ""))) {
				// 如果是非福利机构需要设置儿童默认的送养人、送养人英文名称、送养人地址
				String welfearName = data.getString("WELFARE_NAME_CN", null);
				if (welfearName != null && (welfearName.indexOf("非福利机构") < 0)) {// 福利机构设置默认的送养人信息
					// 2.10设置儿童默认的送养人、送养人地址、送养人英文名称
					data.add("SENDER", data.getString("WELFARE_NAME_CN"));// 送养人
					data.add("SENDER_EN", data.getString("WELFARE_NAME_EN"));// 送养人英文名称
					// 根据福利院ID获取福利院地址
					DataList orgDetails = handler.getOrgDeitail(conn,
							data.getString("WELFARE_ID"));
					if (orgDetails.size() > 0) {
						Data orgInfo = orgDetails.getData(0);
						data.add("SENDER_ADDR",
								orgInfo.getString("DEPT_ADDRESS_CN"));// 送养人地址
					}
				} else if (welfearName != null
						&& (welfearName.indexOf("非福利机构") > 0)
						&& (owelfareCn.indexOf("非福利机构") < 0)) {// 福利机构=》非福利机构则默认的送养人信息为空
					data.add("SENDER", null);// 送养人
					data.add("SENDER_EN", null);// 送养人英文名称
					data.add("SENDER_ADDR", null);// 送养人地址
				}
			}
			// 2.4 儿童姓名拼音处理
			String NAME = data.getString("NAME");
			String NAME_PINYIN = this.manager.getPinyin(NAME);
			data.put("NAME_PINYIN", NAME_PINYIN);

			// 3 更新儿童记录
			handler.save(conn, data);

			setAttribute("listType", listType);
			setAttribute("UUID", ci_id);
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
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
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料统一修改页面修改
	 * 
	 * @author furx
	 * @date 2014-10-17
	 * @return
	 */
	public String toDetailInfoMod() {
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		String listType = getParameter("listType", "");
		if ("".equals(listType)) {
			listType = (String) this.getAttribute("listType");
		}
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.getShowData(conn, uuid);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			setAttribute("listType", listType);
			setAttribute("data", showdata);
			setAttribute("uploadParameter", xmlstr);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 保存儿童材料详细信息
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return
	 */
	public String saveDetailInfo() {
		// 1 获得页面表单数据，构造数据结果集
		// 1.1获得儿童材料信息
		Data data = getRequestEntityData("P_", "CI_ID", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_ADDR",
				"PICKUP_DATE", "ENTER_DATE", "SEND_DATE", "IS_ANNOUNCEMENT",
				"ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE", "IS_HOPE",
				"IS_PLAN", "DISEASE_CN", "REMARKS", "SN_DEGREE",
				"SPECIAL_FOCUS", "NAME_PINYIN", "SENDER_EN");

		// 1.2设置附件原件及翻译件的packid
		data.add("FILE_CODE", data.getString("CI_ID"));
		String FILE_CODE_EN = "F_" + data.getString("CI_ID");
		data.add("FILE_CODE_EN", FILE_CODE_EN);
		// 1.3 状态处理
		String state = getParameter("state");
		retValue = "save";
		String strRet = "儿童材料保存成功";

		// 1.4 中心代录处理方式
		String result = getParameter("result",
				ChildStateManager.CHILD_AUD_RESULT_TRAN);
		// 获取列表类型
		String listType = getParameter("listType");
		String uuid = getParameter("UUID");

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);

			// 获取当前登录人的信息
			UserInfo curuser = SessionInfo.getCurUser();
			Organ organ = curuser.getCurOrgan();
			String orgType = String.valueOf(organ.getOrgType());
			if ("1".equals(state)) {// 如果是提交，根据修改列表的来源进行相应的处理
				if ("CMS_FLY_CLBS_LIST".equals(listType)) {// 福利院提交，需要创建材料审核记录
					// 设置儿童材料审核状态为省待审
					data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_SDS);
					// 设置全局状态
					this.manager.flySubmitChildInfo(data, organ);
					// 材料审核级别，省审核
					String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",
							ChildInfoConstants.LEVEL_PROVINCE);
					Data dataAduit = new Data();
					dataAduit.put("CI_ID", data.getString("CI_ID"));
					dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
					dataAduit.put("OPERATION_STATE",
							ChildStateManager.OPERATION_STATE_TODO);
					// 创建审核记录
					handler.saveCIAduit(conn, dataAduit);
					strRet = "儿童材料提交成功";
					retValue = "CMS_FLY_CLBS_LIST";
				} else if ("CMS_ST_DL_LIST".equals(listType)) {// 省厅提交，需要创建材料审核记录
					// 设置儿童材料审核状态为省通过
					data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_STG);
					// 设置全局状态
					this.manager.stAuditPass(data, organ);
					// 材料审核级别，缺省为省通过
					String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",
							ChildStateManager.CHILD_AUD_STATE_STG);
					Data dataAduit = new Data();
					dataAduit.put("CI_ID", data.getString("CI_ID"));
					dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
					// 创建审核记录
					handler.saveCIAduit(conn, dataAduit);
					strRet = "儿童材料提交成功";
					retValue = "CMS_ST_DL_LIST";
				} else if ("CMS_AZB_DL_LIST".equals(listType)) {// 安置部提交
					// 设置儿童材料审核状态，状态为“中心通过”
					data.add("AUD_STATE",
							ChildStateManager.CHILD_AUD_STATE_ZXTG);
					if (ChildStateManager.CHILD_AUD_RESULT_TRAN.equals(result)) {// 送翻
						// 创建材料交接记录
						DataList dl = new DataList();
						Data dataTransfer = new Data();
						dataTransfer.put("APP_ID", data.getString("CI_ID"));
						dataTransfer.put("TRANSFER_CODE",
								TransferCode.CHILDINFO_AZB_FYGS);
						dataTransfer.put("TRANSFER_STATE", "0");
						dl.add(dataTransfer);
						FileCommonManager fm = new FileCommonManager();
						fm.transferDetailInit(conn, dl);
						// 材料全局状态
						manager.zxToTranslation(data, curuser.getCurOrgan());
					}

					if (ChildStateManager.CHILD_AUD_RESULT_MATCH.equals(result)) {// 直接匹配
						data.put("MATCH_STATE",
								ChildStateManager.CHILD_MATCH_STATE_TODO);
					}
					if (ChildStateManager.CHILD_AUD_RESULT_PUB.equals(result)) {// 直接发布
						data.put("PUB_STATE",
								ChildStateManager.CHILD_PUB_STATE_TODO);
					}
					strRet = "儿童材料提交成功";
					retValue = "CMS_AZB_DL_LIST";
				}
			}

			// 保存儿童材料记录
			handler.save(conn, data);

			// 将附件进行发布
			AttHelper.publishAttsOfPackageId(data.getString("FILE_CODE"), "CI");
			AttHelper.publishAttsOfPackageId(FILE_CODE_EN, "CI");

			if ("save".equals(retValue)) {// 如果是保存，不是提交
				setAttribute("UUID", uuid);
				setAttribute("listType", listType);
				DataList attType = new DataList();
				ChildCommonManager ccm = new ChildCommonManager();
				BatchAttManager bm = new BatchAttManager();
				attType = bm.getAttType(
						conn,
						ccm.getChildPackIdByChildIdentity(
								data.getString("CHILD_IDENTITY"),
								data.getString("CHILD_TYPE"), false));
				String xmlstr = bm.getUploadParameter(attType);
				setAttribute("uploadParameter", xmlstr);
			}
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, strRet);
			setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
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
								"FfsAfTranslationAction的Connection因出现异常，未能关闭",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		System.out.println("retValue:" + retValue);
		return retValue;
	}

}
