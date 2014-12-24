/**   
 * @Title: ExtensionApplyAction.java 
 * @Package com.dcfs.sce.extensionApply 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author yangrt   
 * @date 2014-9-29 上午9:58:23 
 * @version V1.0   
 */
package com.dcfs.sce.extensionApply;


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

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: ExtensionApplyAction 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author yangrt;
 * @date 2014-9-29 上午9:58:23 
 *  
 */
public class ExtensionApplyAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(ExtensionApplyAction.class);
	private ExtensionApplyHandler handler;
	private LockChildHandler lcHandler;
	private Connection conn = null;
	private DBTransaction dt = null;
	private String retValue = SUCCESS;

	/* (非 Javadoc) 
	 * <p>Title: execute</p> 
	 * <p>Description: </p> 
	 * @return
	 * @throws Exception 
	 * @see hx.common.j2ee.BaseAction#execute() 
	 */
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * <p>Title: 构造函数</p> 
	 * <p>Description:初始化handler </p>
	 */
	public ExtensionApplyAction(){
		this.handler = new ExtensionApplyHandler();
		this.lcHandler = new LockChildHandler();
	}
	
	/**
	 * @Title: ExtensionApplyList 
	 * @Description: 交文延期申请列表
	 * @author: yangrt
	 * @return String 
	 */
	public String ExtensionApplyList(){
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="REQ_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","SUBMIT_DATE_START","SUBMIT_DATE_END","REQ_SUBMIT_DATE_START","REQ_SUBMIT_DATE_END","AUDIT_STATE");
        String male_name = data.getString("MALE_NAME","");
        if(!male_name.equals("")){
        	data.put("MALE_NAME", male_name.toUpperCase());
        }
        String female_name = data.getString("FEMALE_NAME","");
        if(!female_name.equals("")){
        	data.put("FEMALE_NAME", female_name.toUpperCase());
        }
        String name_pinyin = data.getString("NAME_YINPIN","");
        if(name_pinyin.equals("")){
        	data.put("NAME_YINPIN", name_pinyin.toUpperCase());
        }
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.ExtensionApplyList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "交文延期申请查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("交文延期申请查询操作异常:" + e.getMessage(),e);
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
                        log.logError("ExtensionApplyAction的ExtensionApplyList.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplySelect 
	 * @Description: 预批申请记录选择列表
	 * @author: yangrt
	 * @return String
	 */
	public String PreApproveApplySelect(){
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="PASS_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","FILE_NO","MALE_NAME","FEMALE_NAME","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","RI_STATE","PASS_DATE_START","PASS_DATE_END","REQ_DATE_START","REQ_DATE_END","REMINDERS_STATE","REM_DATE_START","REM_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","REGISTER_DATE_START","REGISTER_DATE_END","UPDATE_DATE_START","UPDATE_DATE_END");
        String male_name = data.getString("MALE_NAME","");
        if(!male_name.equals("")){
        	data.put("MALE_NAME", male_name.toUpperCase());
        }
        String female_name = data.getString("FEMALE_NAME","");
        if(!female_name.equals("")){
        	data.put("FEMALE_NAME", female_name.toUpperCase());
        }
        String name_pinyin = data.getString("NAME_YINPIN","");
        if(!name_pinyin.equals("")){
        	data.put("NAME_YINPIN", name_pinyin.toUpperCase());
        }
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.PreApproveApplySelect(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "预批申请记录选择查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("预批申请记录选择查询操作异常:" + e.getMessage(),e);
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
	                    log.logError("ExtensionApplyAction的PreApproveApplySelect.Connection因出现异常，未能关闭",e);
	                }
	                retValue = "error2";
	            }
	        }
	    }
		return retValue;
	}

	/**
	 * @Title: ExtensionApplyAdd 
	 * @Description: 交文延期申请添加跳转操作
	 * @author: yangrt
	 * @return String 
	 */
	public String ExtensionApplyAdd(){
		//获取预批申请记录id
		String ri_id = getParameter("RI_ID","");
		try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //根据预批申请记录id,获取预批申请信息
            Data data = handler.GetPreApproveApplyData(conn, ri_id);
            //锁定儿童id
            String ci_id = data.getString("CI_ID","");
            //获取附儿童信息
            DataList childList = lcHandler.getAttachChildList(conn, ci_id);
            UserInfo userinfo = SessionInfo.getCurUser();
            String CnName = userinfo.getPerson().getCName();
            String EnName = userinfo.getPerson().getEnName();
            if(EnName == null || EnName.equals("null") || EnName.equals("") ){
            	data.add("REQ_USERNAME", CnName);
            }else{
            	data.add("REQ_USERNAME", EnName);
            }
            data.add("REQ_USERID", userinfo.getPersonId());
            data.add("REQ_DATE", DateUtility.getCurrentDateTime());
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("childList",childList);
            
        } catch (DBException e) {
            // 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "交文延期申请添加操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("交文延期申请添加操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
	        //关闭数据库连接
	        if (conn != null) {
	            try {
	                if (!conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                if (log.isError()) {
	                    log.logError("ExtensionApplyAction的ExtensionApplyAdd.Connection因出现异常，未能关闭",e);
	                }
	                retValue = "error2";
	            }
	        }
	    }
		return retValue;
	}
	
	/**
	 * @Title: ExtensionApplySave 
	 * @Description: 交文延期申请保存
	 * @author: yangrt
	 * @return String
	 */
	public String ExtensionApplySave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","RI_ID","REQ_USERID","REQ_USERNAME","REQ_DATE","SUBMIT_DATE","AUDIT_STATE","DEF_REASON");
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.ExtensionApplySave(conn,data);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "交文延期申请保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[交文延期申请保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "交文延期申请保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("交文延期申请保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ExtensionApplyAction的ExtensionApplySave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ExtensionApplyShow 
	 * @Description: 交文延期申请查看
	 * @author: yangrt
	 * @return String
	 */
	public String ExtensionApplyShow(){
		retValue = getParameter("type","");
		//获取交文延期申请记录id
		String def_id = getParameter("DEF_ID","");
		try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //根据预批申请记录id,获取预批申请信息
            Data data = handler.GetExtensionApplyData(conn, def_id);
            //锁定儿童id
            String ci_id = data.getString("CI_ID","");
            //获取附儿童信息
            DataList childList = lcHandler.getAttachChildList(conn, ci_id);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("childList",childList);
            
        } catch (DBException e) {
            // 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "交文延期申请查看操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("交文延期申请查看操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
	        //关闭数据库连接
	        if (conn != null) {
	            try {
	                if (!conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                if (log.isError()) {
	                    log.logError("ExtensionApplyAction的ExtensionApplyShow.Connection因出现异常，未能关闭",e);
	                }
	                retValue = "error2";
	            }
	        }
	    }
		return retValue;
	}
	
	/**
	 * @Title: ExtensionAuditList 
	 * @Description: 交文延期审核查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String ExtensionAuditList(){
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="REQ_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NAME","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","REQ_DATE_START","REQ_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","REQ_SUBMIT_DATE_START","REQ_SUBMIT_DATE_END","AUDIT_DATE_START","AUDIT_DATE_END","AUDIT_STATE");
        String male_name = data.getString("MALE_NAME","");
        if(!male_name.equals("")){
        	data.put("MALE_NAME", male_name.toUpperCase());
        }
        String female_name = data.getString("FEMALE_NAME","");
        if(!female_name.equals("")){
        	data.put("FEMALE_NAME", female_name.toUpperCase());
        }
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.ExtensionAuditList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "交文延期审核查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("交文延期审核查询操作异常:" + e.getMessage(),e);
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
                        log.logError("ExtensionApplyAction的ExtensionAuditList.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	public String ExtensionAuditAdd(){
		//获取交文延期申请记录id
		String def_id = getParameter("DEF_ID","");
		try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //根据交文延期申请记录id,获取交文延期申请信息
            Data data = handler.GetExtensionApplyData(conn, def_id);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            
        } catch (DBException e) {
            // 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "交文延期审核添加操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("交文延期审核添加操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
	        //关闭数据库连接
	        if (conn != null) {
	            try {
	                if (!conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                if (log.isError()) {
	                    log.logError("ExtensionApplyAction的ExtensionAuditAdd.Connection因出现异常，未能关闭",e);
	                }
	                retValue = "error2";
	            }
	        }
	    }
		return retValue;
	}
	
	/**
	 * @Title: ExtensionAuditSave 
	 * @Description: 交文延期审核保存
	 * @author: yangrt
	 * @return String
	 */
	public String ExtensionAuditSave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","DEF_ID","RI_ID","SUBMIT_DATE","AUDIT_STATE","RESULT_NUM","AUDIT_CONTENT");
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            
            UserInfo userinfo = SessionInfo.getCurUser();
            data.add("AUDIT_USERID", userinfo.getPersonId());
            data.add("AUDIT_USERNAME", userinfo.getPerson().getCName());
            data.add("AUDIT_DATE", DateUtility.getCurrentDateTime());
            
            Data ridata = new Data();
            ridata.add("RI_ID", data.getString("RI_ID",""));
            String audit_state = data.getString("AUDIT_STATE","");
            if("1".equals(audit_state)){
            	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    			Calendar cal = Calendar.getInstance();
    			String submit_date = data.getString("SUBMIT_DATE","");
    			Date submitDate = sdf.parse(submit_date);
    			cal.setTime(submitDate);
    			cal.add(Calendar.MONTH, Integer.parseInt(data.getString("RESULT_NUM","0")));
    			cal.add(Calendar.DATE, -1);
    			data.add("REQ_SUBMIT_DATE", sdf.format(cal.getTime()));
    			
    			ridata.add("SUBMIT_DATE", data.getString("REQ_SUBMIT_DATE",""));
    			ridata.add("REMINDERS_STATE", "0");
    			ridata.add("REM_DATE", "");
            }
			data.remove("RESULT_NUM");
			
            boolean success1 = handler.ExtensionApplySave(conn,data);
            boolean success2 = handler.UpdatePreApproveApply(conn,ridata);
            if(success1 && success2){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "交文延期申请保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[交文延期审核保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "交文延期审核保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("交文延期审核保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (ParseException e) {
        	setAttribute(Constants.ERROR_MSG_TITLE, "交文延期审核保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("交文延期审核保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ExtensionApplyAction的ExtensionAuditSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}

}
