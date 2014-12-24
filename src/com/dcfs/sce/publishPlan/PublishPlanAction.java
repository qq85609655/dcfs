package com.dcfs.sce.publishPlan;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Vector;

import java_cup.internal_error;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.StringUtil;
import com.dcfs.sce.common.PublishCommonManager;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hp.hpl.sparta.xpath.ThisNodeTest;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;
import com.lowagie.text.List;

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
 * @ClassName: PublishPlanAction 
 * @Description: 发布计划Action
 * @author mayun
 * @date 2014-9-12
 *  
 */
public class PublishPlanAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(PublishPlanAction.class);
	private Connection conn = null;
	private PublishPlanHandler handler;
	private PublishManagerHandler managerHandler;
    private DBTransaction dt = null;//事务处理
	private String retValue = SUCCESS;
	    

	public PublishPlanAction() {
		this.handler=new PublishPlanHandler();
		this.managerHandler=new PublishManagerHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}
	
	
	
	/**
	 * 发布计划查询列表	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-12
	 * @return
	 */
	public String findListForFBJH(){
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
			ordertype=null;
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒

		Data data = getRequestEntityData("S_","PLAN_NO","NOTE_DATE_START","NOTE_DATE_END","PUB_DATE_START","PUB_DATE_END","PLAN_USERNAME","PLAN_DATE_START","PLAN_DATE_END","NOTICE_STATE","PLAN_STATE");
		String PLAN_USERNAME = data.getString("PLAN_USERNAME");
		if(null != PLAN_USERNAME){
			data.add("PLAN_USERNAME", PLAN_USERNAME.toLowerCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findListForFBJH(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布计划查询操作异常");
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
						log.logError("PublishPlanAction的findListForFBJH.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * 跳转到新增计划基本信息页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toPlanBaseInfoAdd(){
		Data hxData = new Data();//用了回显的data
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		hxData.add("PLAN_USERNAME", personName);
		hxData.add("PLAN_DATE", curDate);
		setAttribute("data", hxData);
		return retValue;
	}
	
	/**
	 * 跳转到修改计划基本信息页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toPlanBaseInfoRevise(){
		Data hxData = new Data();//用了回显的data
		Data hiddenData = getRequestEntityData("H_","PLAN_ID");//隐藏区域data
		String plan_id = hiddenData.getString("PLAN_ID");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到修改计划基本信息页面操作异常");
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
						log.logError("PublishPlanAction的toPlanBaseInfoRevise.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", hxData);
		return retValue;
	}
	
	/**
	 * 跳转到计划制定详细页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toPlanInfoAdd(){
		Data hxData = new Data();//用了回显的data
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	DataList list = new DataList();
	 	hxData.add("PUB_TYPE", "");
	 	hxData.add("PUB_MODE", "");
	 	hxData.add("COUNTRY_CODE", "");
	 	hxData.add("PUB_ORGID", "");
	 	hxData.add("ADOPT_ORG_NAME", "");
	 	hxData.add("TMP_TMP_PUB_ORGID_NAME", "");
	 	hxData.add("PUB_REMARKS", "");
		hxData.add("PLAN_USERNAME", personName);
		hxData.add("PLAN_DATE", curDate);
		setAttribute("data", hxData);
		setAttribute("List", list);
		return retValue;
	}
	
	/**
	 * 跳转选择发布类型	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toFBLXChose(){
		Data hiddenData = getRequestEntityData("H_","CIIDS","PLAN_ID");//隐藏区域data
		setAttribute("data", hiddenData);
		return retValue;
	}
	
	/**
	 * 删除制定中或待发布的发布计划
	 * @description 
	 * @author MaYun
	 * @date Oct 10, 2014
	 * @return
	 */
	public String deletePlan(){
		Data hiddenData = getRequestEntityData("H_","PLAN_ID");//隐藏区域data
	 	String plan_id = hiddenData.getString("PLAN_ID");//发布计划主键ID
		
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			this.handler.deletePlan(conn, plan_id);//删除发布计划
			
			DataList fbjlDataList = this.handler.getFBJLListForPlan(conn, plan_id);//发布记录List
			this.handler.deleteFBJL(conn, fbjlDataList);//删除发布记录
			
			DataList etDataList = new DataList();//儿童材料List
			for(int i = 0;i<fbjlDataList.size();i++){
				Data fbjlData = fbjlDataList.getData(i);
				Data etData = new Data();
				etData.add("CI_ID", fbjlData.getString("CI_ID"));
				etData.add("PUB_STATE", "0");//儿童发布状态置为待发布
				etDataList.add(etData);
			}
			this.handler.updateFBStateForETCL(conn, etDataList);//批量更新儿童材料的发布状态为待发布
			dt.commit();
			
			InfoClueTo clueTo = new InfoClueTo(0, "计划删除成功!");//保存成功 0
	        setAttribute("clueTo", clueTo);
			
		} catch (DBException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, " 删除制定中或待发布的发布计划操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		}catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, " 删除制定中或待发布的发布计划操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, " 删除制定中或待发布的发布计划操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}  finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("PublishPlanAction的deletePlan.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		
		return retValue;
	}
	
	/**
	 * 选择添加儿童	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String addET(){
		Data hxData = new Data();//用了回显的data
		String tmp_tmp_pub_orgid_name = (String)getParameter("TMP_TMP_PUB_ORGID_NAME");
		Data hiddenData = getRequestEntityData("H_","TOTAL_CIIDS","ADD_CIIDS","REMOVE_CIIDS");//隐藏区域data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//发布计划data
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//点发data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//群发data

		String pub_type = dfData.getString("PUB_TYPE");
		String totalCiids=hiddenData.getString("TOTAL_CIIDS");//获取总的儿童材料IDS
		String addCiids=hiddenData.getString("ADD_CIIDS");//获取本次选择的儿童材料IDS
		totalCiids= StringUtil.convertSqlString(totalCiids);
		addCiids= StringUtil.convertSqlString(addCiids);
		
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	DataList totalETList = new DataList();
	 	int pub_num=0;//总儿童数量
	 	int pub_num_tb=0;//特别关注儿童数量
	 	int pub_num_ftb=0;//非特别关注儿童数量
	 	
	 	try {
	 		//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//this.handler.updatePubStateForET(conn, addCiids, "1");//儿童发布状态更新为“计划中”
			
			//5 获取数据DataList
			if(!"".equals(totalCiids)&&null!=totalCiids){
				totalETList = this.handler.findSelectedET(conn, totalCiids);
			}
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//是否特别关注  0：否  1：是
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
	 		pub_num=totalETList.size();
	 		
	 		//6 将结果集写入页面接收变量
	 		hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			hxData.add("PLAN_USERNAME", personName);
			hxData.add("PLAN_DATE", curDate);
			hxData.addData(hiddenData);
			hxData.addData(jhData);
			if("1".equals(pub_type)||"1"==pub_type){//点发回显
				hxData.addData(dfData);
			}else{//群发回显
				hxData.addData(dfData);
				hxData.addData(qfData);
				hxData.add("TMP_TMP_PUB_ORGID_NAME", tmp_tmp_pub_orgid_name);
			}
		 	
			setAttribute("data", hxData);
			setAttribute("List", totalETList);
			dt.commit();
		} catch (DBException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
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
						log.logError("PublishPlanAction的toPlanInfoAdd.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	
	/**
	 * 选择移除儿童	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 * @throws SQLException 
	 */
	public String removeET() throws SQLException{
		Data hxData = new Data();//用了回显的data
		String tmp_tmp_pub_orgid_name = (String)getParameter("TMP_TMP_PUB_ORGID_NAME");
		Data hiddenData = getRequestEntityData("H_","TOTAL_CIIDS","ADD_CIIDS","REMOVE_CIIDS");//隐藏区域data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//发布计划data
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//点发data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//群发data

		String pub_type = dfData.getString("PUB_TYPE");
		String totalCiids=hiddenData.getString("TOTAL_CIIDS");//获取总的儿童材料IDS
		String remove_ciids=hiddenData.getString("REMOVE_CIIDS");//获取本次选择的儿童材料IDS
		String newTotalCiids = StringUtil.filterSameString(totalCiids, remove_ciids);
		String totalCiidsForSql= StringUtil.convertSqlString(newTotalCiids);
		String remove_ciidsForSql= StringUtil.convertSqlString(remove_ciids);
		
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	DataList totalETList = new DataList();
		int pub_num=0;//总儿童数量
	 	int pub_num_tb=0;//特别关注儿童数量
	 	int pub_num_ftb=0;//非特别关注儿童数量
	 	try {
	 		//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			
			this.handler.updatePubStateForET(conn, remove_ciidsForSql, "0");//儿童发布状态更新为“待发布”
			
			//5 获取数据DataList
			if(!"".equals(totalCiidsForSql)&&null!=totalCiidsForSql){
				totalETList = this.handler.findSelectedET(conn, totalCiidsForSql);
			}
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//是否特别关注  0：否  1：是
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
	 		pub_num=totalETList.size();
	 		
	 		//6 将结果集写入页面接收变量
	 		hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			hxData.add("PLAN_USERNAME", personName);
			hxData.add("PLAN_DATE", curDate);
			hxData.addData(hiddenData);
			hxData.addData(jhData);
			hxData.add("TOTAL_CIIDS", newTotalCiids);
			
			if("1".equals(pub_type)||"1"==pub_type){//点发回显
				hxData.addData(dfData);
			}else{//群发回显
				hxData.addData(dfData);
				hxData.addData(qfData);
				hxData.add("TMP_TMP_PUB_ORGID_NAME", tmp_tmp_pub_orgid_name);
			}
		 	
			setAttribute("data", hxData);
			setAttribute("List", totalETList);
			dt.commit();
		} catch (DBException e) {
			dt.rollback();
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
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
						log.logError("PublishPlanAction的removeET.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	
	
	
	/**
	 * 跳转到待发布儿童选择列表	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toChoseETForJH(){
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
			ordertype=null;
		}
		
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//隐藏区域data
	 	String plan_id = hiddenData.getString("PLAN_ID");
	 	if("".equals(plan_id)||null==plan_id){
	 		plan_id = getParameter("PLAN_ID");
	 	}
		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","SPECIAL_FOCUS","PUB_NUM","PUB_FIRSTDATE_START","PUB_FIRSTDATE_END","PUB_LASTDATE_START","PUB_LASTDATE_END");
		
		String NAME = data.getString("NAME");
		if(null != NAME){
			data.add("NAME", NAME.toLowerCase());
		}
		
		data.add("PLAN_ID", plan_id);
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.toChoseETForJH(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布管理查询操作异常");
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
						log.logError("PublishPlanAction的toChoseETForJH.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * 发布计划基本信息保存或提交
	 * @description 
	 * @author MaYun
	 * @date Sep 30, 2014
	 * @return
	 * @throws SQLException 
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 */
	public String saveFBJHBaseInfo() throws SQLException, NumberFormatException, ParseException{
		//1 获得页面表单数据，构造数据结果集
		String method = getParameter("method");//判断是保存还是提交  0：保存  1：提交
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//隐藏区域data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//发布计划data
		
		try {
			//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //**********保存发布计划基本信息begin***********
            String plan_id = hiddenData.getString("PLAN_ID");
    		jhData.add("PLAN_ID", plan_id);//计划主键ID
    		jhData.add("PLAN_USERID", personId);//制定人ID
    		jhData.add("PLAN_USERNAME", personName);//制定人姓名
    		jhData.add("PLAN_DATE", curDate);//制定日期
    		
    		if("0".equals(method)||"0"==method){//保存方法
    			jhData.add("PLAN_STATE", "0");//发布状态为制定中
    		}else{//提交方法
    			jhData.add("PLAN_STATE", "1");//发布状态为待发布
    		}
    		
            PublishCommonManager manager = new PublishCommonManager();
            if("".equals(plan_id)||null==plan_id||"null".equals(plan_id)){
            	String plan_no = manager.createPubPlanSeqNO(conn);//生成计划批号
            	jhData.add("PLAN_NO", plan_no);
            	jhData.add("NOTICE_STATE", "0");//预告状态为未预告
            	jhData.add("PUB_NUM", 0);//儿童总数为0
            }
            
			jhData = this.handler.saveFbJhInfo(conn, jhData);//保存发布计划基本信息
			//**********保存发布计划基本信息end***********
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//保存成功 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布计划保存或提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布计划保存或提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}  finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("PublishPlanAction的saveFBJHBaseInfo.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", jhData);
		return retValue;
	}
	
	
	
	/**
	 * 发布维护提交
	 * @description 
	 * @author MaYun
	 * @date Sep 30, 2014
	 * @return
	 * @throws SQLException 
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 */
	public String saveFBJHInfo() throws SQLException, NumberFormatException, ParseException{
		//1 获得页面表单数据，构造数据结果集
	 	String curDate = DateUtility.getCurrentDate();
		
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID","CIIDS");//隐藏区域data
		Data jhData = new Data();
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//点发data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//群发data
		
		DataList saveFBDataList = new DataList();//发布记录DataList
        DataList saveETDataList = new DataList();//儿童材料DataList
        
        String pubType = dfData.getString("PUB_TYPE");//发布类型 1:点发  2:群发
        String plan_id = hiddenData.getString("PLAN_ID");
        String ciids = hiddenData.getString("CIIDS");//儿童材料IDS
        ciids = StringUtil.convertSqlString(ciids);
		
		try {
			//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //**********保存发布计划基本信息begin***********
            DataList selectedETDataList = this.handler.getFBJLListForPlan(conn, plan_id);
            int pub_num = selectedETDataList.size();
            int tempNum = ciids.split(",").length;
            pub_num = pub_num+tempNum;
            
    		jhData.add("PLAN_ID", plan_id);//计划主键ID
    		jhData.add("PUB_NUM",pub_num);//儿童数量
    		
			jhData = this.handler.saveFbJhInfo(conn, jhData);//保存发布计划基本信息
			//**********保存发布计划基本信息end***********
			
			//***********保存发布记录begin*************
			DataList etDataList = this.handler.findSelectedET(conn, ciids);
			for(int i =0;i<etDataList.size();i++){
        		Data etData = (Data)etDataList.get(i);
        		String ciid = etData.getString("CI_ID");//儿童材料ID
        		String isSpecial = etData.getString("SPECIAL_FOCUS");//是否特别关注
        		
        		Data saveFBData = new Data();//发布记录DATA
        		saveFBData.add("PLAN_ID",plan_id);//发布计划ID
        		saveFBData.add("CI_ID",ciid);//儿童材料ID
        		saveFBData.add("PUB_TYPE", pubType);//发布类型
        		
        		//*********保存儿童发布相关信息begin**********
        		if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
        			saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//点发的发布组织
        			saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
        			saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
        			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
            		}else {//非特别关注
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
            		}
        		}else{//如果页面选择的是群发
        			saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//群发的发布组织
        			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
            		}else {//非特别关注
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
            		}
        		}
        		
        		//saveFBData.add("PUBLISHER_ID",personId);//发布人
        		//saveFBData.add("PUBLISHER_NAME",personName);//发布人姓名
        		//saveFBData.add("PUB_DATE",curDate);//发布日期
        		saveFBData.add("PUB_STATE",PublishManagerConstant.JHZ);//发布状态为"计划中"
            	
            	saveFBDataList.add(saveFBData);
            	//*********保存儿童发布相关信息end**********
            	
            	//**********更新儿童材料表相关信息begin**********
            	Data saveETData = new Data();//儿童材料更新DATA
            	saveETData.add("CI_ID", ciid);//儿童材料ID
            	saveETData.add("PUB_TYPE", pubType);//发布类型
            	
            	if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
            		saveETData.add("PUB_ORGID", dfData.getString("PUB_ORGID"));//点发发布组织
            	}else{
            		saveETData.add("PUB_ORGID", qfData.getString("PUB_ORGID"));//群发发布组织
            	}
            	
            	//saveETData.add("PUB_USERID", personId);//发布人ID
            	//saveETData.add("PUB_USERNAME", personName);//发布人名称
            	saveETData.add("PUB_STATE", PublishManagerConstant.JHZ);//发布状态为“计划中”
            	
            	/**
            	if(this.managerHandler.isFirstFb(conn, ciid)){//判断该儿童是否发布过，true:发布过  false:未发布过
            		int num = this.managerHandler.getFbNum(conn, ciid);//获得该儿童发布次数
            		saveETData.add("PUB_NUM", num+1);//发布次数
            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
            	}else{
            		saveETData.add("PUB_NUM", 1);//发布次数
            		saveETData.add("PUB_FIRSTDATE", curDate);//首次发布日期
            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
            	}
            	*/
            	saveETDataList.add(saveETData);
            	//**********更新儿童材料表相关信息end**********
        	}
        	
	     
        
	        this.managerHandler.batchSubmitForETFB(conn,saveFBDataList);//保存儿童发布记录信息
	        this.managerHandler.batchUpdateETCL(conn, saveETDataList);//保存儿童材料信息
			//***********保存发布记录end***************
			setAttribute("data",hiddenData );
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//保存成功 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布维护提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布维护提交操作异常");
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
						log.logError("PublishPlanAction的saveFBJHInfo.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", new Data());
		return retValue;
	}
	
	/**
	 * 计划发布
	 * @description 
	 * @author MaYun
	 * @date Oct 8, 2014
	 * @return
	 * @throws SQLException 
	 */
	public String planPublish() throws SQLException{
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//隐藏区域data
	 	String plan_id = hiddenData.getString("PLAN_ID");//发布计划主键ID

	 	DataList saveETDataList = new DataList();
	 	
	 	try {
			//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            this.handler.updateFBStateForFBJH(conn, plan_id);//更新发布计划表的发布状态为已发布
            this.handler.updateFBStateForFBJL(conn, personId, personName, plan_id);//更新发布记录表的发布状态为已发布
            
			//***********更新儿童材料发布状态为已发布begin*************
			DataList etDataList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			for(int i =0;i<etDataList.size();i++){
        		Data etData = (Data)etDataList.get(i);
        		String ciid = etData.getString("CI_ID");//儿童材料ID
        		
        		Data saveETData = new Data();//发布记录DATA
        		saveETData.add("CI_ID",ciid);//儿童材料ID
        		saveETData.add("PUB_USERID",personId);//发布人
        		saveETData.add("PUB_USERNAME",personName);//发布人姓名
        		saveETData.add("PUB_STATE",PublishManagerConstant.YFB);//发布状态为"已发布"
            	
            	if(this.managerHandler.isFirstFb(conn, ciid)){//判断该儿童是否发布过，true:发布过  false:未发布过
            		int num = this.managerHandler.getFbNum(conn, ciid);//获得该儿童发布次数
            		saveETData.add("PUB_NUM", num+1);//发布次数
            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
            	}else{
            		saveETData.add("PUB_NUM", 1);//发布次数
            		saveETData.add("PUB_FIRSTDATE", curDate);//首次发布日期
            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
            	}
            	saveETDataList.add(saveETData);
        	}
        	
			this.handler.updateFBStateForETCL(conn, saveETDataList);
        
	      //***********更新儿童材料发布状态为已发布end*************
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "计划发布成功!");//保存成功 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "计划发布操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} catch (Exception e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "计划发布操作异常");
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
						log.logError("PublishPlanAction的planPublish.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", new Data());
		return retValue;
	 	
	}

	/**
	 * 跳转到计划维护页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-10-8
	 * @return
	 */
	public String toModifyPlan(){
		Data hxData = new Data();//用了回显的data
		int pub_num=0;//总儿童数量
	 	int pub_num_tb=0;//特别关注儿童数量
	 	int pub_num_ftb=0;//非特别关注儿童数量
	 	
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//隐藏区域data
	 	String plan_id = hiddenData.getString("PLAN_ID");
	 	if("".equals(plan_id)||null==plan_id){
	 		Data data = (Data)getAttribute("data");
	 		plan_id = data.getString("PLAN_ID");
	 	}

	 	DataList totalETList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			pub_num = totalETList.size();
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//是否特别关注  0：否  1：是
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
			
			hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			
		} catch (DBException e) {
			e.printStackTrace();
		}
	 	
		setAttribute("data", hxData);
		setAttribute("List", totalETList);
		return retValue;
	}
	
	/**
	 * 跳转到查看计划详细页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-10-8
	 * @return
	 */
	public String toViewPlan(){
		Data hxData = new Data();//用了回显的data
		int pub_num=0;//总儿童数量
	 	int pub_num_tb=0;//特别关注儿童数量
	 	int pub_num_ftb=0;//非特别关注儿童数量
	 	
	 	String plan_id = getParameter("PLAN_ID");
	 	DataList totalETList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			pub_num = totalETList.size();
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//是否特别关注  0：否  1：是
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
			
			hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			
		} catch (DBException e) {
			e.printStackTrace();
		}
	 	
		setAttribute("data", hxData);
		setAttribute("List", totalETList);
		return retValue;
	}
	
	/**
	 * 跳转到发布计划打印页面	
	 * @description 
	 * @author panfeng
	 * @date 2014-10-26
	 * @return
	 */
	public String printShow(){
		Data hxData = new Data();
	 	
	 	String plan_id = getParameter("showuuid");
	 	DataList totalETList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
		} catch (DBException e) {
			e.printStackTrace();
		}
	 	
		setAttribute("printData", hxData);
		setAttribute("List", totalETList);
		return retValue;
	}
	
	/**
	 * 选择添加儿童(维护页面)	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String addETForRevise(){
		Data hxData = new Data();//用了回显的data
		String tmp_tmp_pub_orgid_name = (String)getParameter("TMP_TMP_PUB_ORGID_NAME");
		Data hiddenData = getRequestEntityData("H_","TOTAL_CIIDS","ADD_CIIDS","REMOVE_CIIDS","PLAN_ID");//隐藏区域data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//发布计划data
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//点发data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//群发data

		String plan_id = hiddenData.getString("plan_id");
		String pub_type = dfData.getString("PUB_TYPE");
		String totalCiids=hiddenData.getString("TOTAL_CIIDS");//获取总的儿童材料IDS
		String addCiids=hiddenData.getString("ADD_CIIDS");//获取本次选择的儿童材料IDS
		totalCiids= StringUtil.convertSqlString(totalCiids);
		addCiids= StringUtil.convertSqlString(addCiids);
		
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	DataList totalETList = new DataList();
	 	int pub_num=0;//总儿童数量
	 	int pub_num_tb=0;//特别关注儿童数量
	 	int pub_num_ftb=0;//非特别关注儿童数量
	 	
	 	try {
	 		//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//this.handler.updatePubStateForET(conn, addCiids, "1");//儿童发布状态更新为“计划中”
			
			//5 获取数据DataList
			if(!"".equals(totalCiids)&&null!=totalCiids){
				totalETList = this.handler.findSelectedET(conn, totalCiids);
			}
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//是否特别关注  0：否  1：是
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
	 		pub_num=totalETList.size();
	 		
	 		//6 将结果集写入页面接收变量
	 		hxData.add("PLAN_ID", plan_id);
	 		hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			hxData.add("PLAN_USERNAME", personName);
			hxData.add("PLAN_DATE", curDate);
			hxData.addData(hiddenData);
			hxData.addData(jhData);
			if("1".equals(pub_type)||"1"==pub_type){//点发回显
				hxData.addData(dfData);
			}else{//群发回显
				hxData.addData(dfData);
				hxData.addData(qfData);
				hxData.add("TMP_TMP_PUB_ORGID_NAME", tmp_tmp_pub_orgid_name);
			}
		 	
			setAttribute("data", hxData);
			setAttribute("List", totalETList);
			dt.commit();
		} catch (DBException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转到计划制定详细页面操作异常");
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
						log.logError("PublishPlanAction的toPlanInfoAdd.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	
	/**
	 * 选择移除儿童（维护页面）	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 * @throws SQLException 
	 */
	public String removeETForRevise() throws SQLException{
		Data jhData = new Data();
		Data hiddenData = getRequestEntityData("H_","REMOVE_CIIDS","PLAN_ID","PUB_NUM");//隐藏区域data

		String plan_id = hiddenData.getString("PLAN_ID");
		String remove_ciids=hiddenData.getString("REMOVE_CIIDS");//获取本次选择的儿童材料IDS
		String remove_ciidsForSql= StringUtil.convertSqlString(remove_ciids);
		
	 	DataList totalETList = new DataList();
	 	try {
	 		//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			
			this.handler.updatePubStateForET(conn, remove_ciidsForSql, "0");//儿童发布状态更新为“待发布”
			this.handler.deleteFBJLForCIIDS(conn, plan_id, remove_ciidsForSql);//删除相关儿童对应的发布记录
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);//获取该计划下待发布的儿童list
			
	 		int pub_num=totalETList.size();
	 		jhData.add("PLAN_ID", plan_id);
	 		jhData.add("PUB_NUM", pub_num);
	 		this.handler.updateFBJH(conn, jhData);//更新发布计划的儿童数量
	 		
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "移除儿童成功!");//保存成功 0
	        setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			dt.rollback();
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "选择移除儿童操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "选择移除儿童操作异常");
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
						log.logError("PublishPlanAction的removeETForRevise.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	/**
	 * 得到最新一次已预告的发布计划相关信息
	 * @description 
	 * @author MaYun
	 * @date Dec 9, 2014
	 * @return
	 */
	public String getFBJHForYYG(){
		try {
	 		//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			
			Data data = this.handler.getFBJHForYYG(conn);//得到最新一次已预告的发布计划相关信息
			setAttribute("data", data);
		} catch (DBException e) {
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, " 得到最新一次已预告的发布计划相关信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			//设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, " 得到最新一次已预告的发布计划相关信息操作异常");
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
						log.logError("PublishPlanAction的getFBJHForYYG.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	/**
	 * 手动预告发布计划
	 * @description 
	 * @author MaYun
	 * @date Oct 8, 2014
	 * @return
	 * @throws SQLException 
	 */
	public String sdyg() throws SQLException{
	 	String curDate = DateUtility.getCurrentDateTime();
	 	
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//隐藏区域data
	 	hiddenData.add("NOTICE_STATE", "1");//预告状态为“已预告”
	 	hiddenData.add("NOTE_DATE", curDate);//预告日期

	 	
	 	try {
			//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            this.handler.updateFBJH(conn, hiddenData);
            
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "手动预告发布计划成功!");//保存成功 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "手动预告发布计划操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} catch (Exception e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "手动预告发布计划操作异常");
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
						log.logError("PublishPlanAction的sdyg.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", new Data());
		return retValue;
	}
	
	public static void main(String arg[]) throws ParseException{
		String curDate = DateUtility.getCurrentDate();
		System.out.println(curDate);
		System.out.println(UtilDate.getEndDate(curDate,2));
	}

}
