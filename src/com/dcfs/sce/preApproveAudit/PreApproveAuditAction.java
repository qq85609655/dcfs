/**   
 * @Title: PreApproveAuditAction.java 
 * @Package com.dcfs.sce.preApproveAudit 
 * @Description: 预批申请审核操作
 * @author yangrt   
 * @date 2014-10-9 下午4:00:21 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveAudit;

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
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.dcfs.sce.preApproveApply.PreApproveApplyHandler;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.util.UtilDate;

/** 
 * @ClassName: PreApproveAuditAction 
 * @Description: 预批审核操作
 * @author yangrt
 * @date 2014-10-9 下午4:00:21 
 *  
 */
public class PreApproveAuditAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(PreApproveAuditAction.class);
	private PreApproveAuditHandler handler;
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
		return null;
	}
	
	public PreApproveAuditAction(){
		this.handler = new PreApproveAuditHandler();
	}
	
	/**
	 * @Title: PreApproveAuditListAZB 
	 * @Description: 安置部预批申请审核查询列表
	 * @author: yangrt
	 * @return String
	 */
	public String PreApproveAuditListAZB(){
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
        Data data = getRequestEntityData("S_","ADOPT_ORG_NAME_CN","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_CN","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        		"SPECIAL_FOCUS","REQ_DATE_START","REQ_DATE_END","AUD_STATE2","AUD_STATE1","LAST_STATE2","ATRANSLATION_STATE2","RI_STATE","PASS_DATE_START","PASS_DATE_END");
        //将男、女收养人姓名转化为大写
        String MALE_NAME = data.getString("MALE_NAME","");
        if(!MALE_NAME.equals("")){
        	data.put("MALE_NAME", MALE_NAME.toUpperCase());
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");
        if(!FEMALE_NAME.equals("")){
        	data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
        }
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.PreApproveAuditListAZB(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "安置部预批申请审核查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("安置部预批申请审核查询操作异常:" + e.getMessage(),e);
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
                        log.logError("PreApproveAuditAction的PreApproveAuditListAZB.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditShow
	 * @Description: 预批申请审核添加、查看操作
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveAuditShow(){
		String ri_id = getParameter("RI_ID","");	//获取预批申请记录id
		String rau_id = getParameter("RAU_ID","");	//获取预批申请审核记录id
		String type = getParameter("type");			//添加、查看识别标志，添加：AZBadd(安置部)、SHBadd(审核部)，查看：show
		String level = getParameter("Level",""); 	//审核部审核级别，:0：经办人审核，1：部门主任审核，2：分管主任审批
		String flag = getParameter("Flag","");		//查询列表审核之后，跳转页面标示
		retValue = type;
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data applydata = new PreApproveApplyHandler().getPreApproveApplyData(conn, ri_id);
			if(type.equals("AZBadd") || type.equals("SHBadd")){
				UserInfo userinfo = SessionInfo.getCurUser();
				applydata.add("AUDIT_USERID", userinfo.getPersonId());
				applydata.add("AUDIT_USERNAME", userinfo.getPerson().getCName());
				applydata.add("AUDIT_DATE", DateUtility.getCurrentDateTime());
				
				applydata.add("AUDIT_LEVEL", level);
				
				String pub_id = applydata.getString("PUB_ID","");
				Data pubData = handler.getPubDataById(conn, pub_id);
				applydata.add("PUB_TYPE", pubData.getString("PUB_TYPE",""));	//儿童的发布类型，用于获取交文期限
				applydata.add("PUB_MODE", pubData.getString("PUB_MODE",""));	//儿童的点发类型，用于获取交文期限
				applydata.add("SPECIAL_FOCUS", getParameter("SPECIAL_FOCUS"));	//儿童是否特别关注，用于获取交文期限
				
				//是否公约国
				String CONVENTION = new FileCommonManager().getISGY(conn, "", applydata.getString("COUNTRY_CODE"));
				applydata.add("IS_CONVENTION_ADOPT", CONVENTION);
				setAttribute("Flag", flag);
			}else{
				applydata.add("FROM_TYPE", type);
				if("SHBshow".equals(type)){
					applydata.add("AUDIT_LEVEL", level);
				}
			}
			
			setAttribute("data", applydata);
			setAttribute("RI_ID", ri_id);
			setAttribute("RAU_ID", rau_id);
			setAttribute("AF_ID", applydata.getString("AF_ID",""));
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "安置部预批申请审核添加/查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[安置部预批申请审核添加/查看操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction的PreApproveAuditShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditSave 
	 * @Description: 预批申请审核信息保存操作
	 * @author: yangrt
	 * @return String
	 */
	public String PreApproveAuditSave(){
		String type = getParameter("type");						//判断当前审核保存是安置部还是审核部在操作
		String oneType = getParameter("R_PUB_TYPE");			//发布类型，用于获取交文期限
		String secondType = getParameter("R_SPECIAL_FOCUS");	//特别关注，用于获取交文期限
		String threeType = getParameter("R_PUB_MODE");			//点发类型，用于获取交文期限
		String flag = getParameter("Flag","");					//查询列表审核之后，跳转页面标示
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String userid = userinfo.getPersonId();					//通知人id
		String username = userinfo.getPerson().getCName();		//通知人姓名
		String curDate = DateUtility.getCurrentDateTime();		//通知日期
		
		//1 获得页面表单数据，构造数据结果集
		//预批申请审核信息Data
		Data data = getRequestEntityData("R_","RAU_ID","RI_ID","AUDIT_LEVEL","AUDIT_OPTION","AUDIT_CONTENT_CN","AUDIT_USERID","AUDIT_USERNAME","AUDIT_DATE","OPERATION_STATE","AUDIT_REMARKS");
		//预批申请补充记录信息Data
		Data suppledata = getRequestEntityData("P_","IS_MODIFY","NOTICE_CONTENT","ADD_TYPE");
		suppledata.add("RI_ID", data.getString("RI_ID",""));
		suppledata.add("SEND_USERID", userid);	
		suppledata.add("SEND_USERNAME", username);	
		suppledata.add("NOTICE_DATE", curDate);	
		suppledata.add("AA_STATUS", "0");	//初始化补充状态为待补充（AA_STATUS：0）
		//预批申请补充翻译记录信息Data
		Data suppletranslationdata = getRequestEntityData("T_","AA_CONTENT");
		suppletranslationdata.add("RI_ID", data.getString("RI_ID",""));
		suppletranslationdata.add("TRANSLATION_TYPE", "1"); 		//翻译类型：补翻=1
		suppletranslationdata.add("NOTICE_USERID", userid);	
		suppletranslationdata.add("NOTICE_USERNAME", username);	
		suppletranslationdata.add("NOTICE_DATE", curDate);	
		suppletranslationdata.add("TRANSLATION_STATE", "0");		//初始化补翻状态为待翻译（TRANSLATION_STATE：0）
		
		retValue = type + flag;
		
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            //若当前操作位安置部审核，则获取审核部的审核状态；若当前操作位审核部审核，则获取安置部的审核状态；
            Data applydata = new PreApproveApplyHandler().getPreApproveApplyData(conn, data.getString("RI_ID",""));
            Data applyupdate = new Data();
            applyupdate.add("RI_ID", applydata.getString("RI_ID",""));
            applyupdate.add("PUB_ID", applydata.getString("PUB_ID",""));
            applyupdate.add("CI_ID", applydata.getString("CI_ID",""));
            applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHZ);	//预批状态默认值为审核中
            
            //当前操作的审核结果
        	String audit_option = data.getString("AUDIT_OPTION","");
            if(type.equals("AZB")){
            	applyupdate.add("AUD_STATE2", audit_option);	//安置部的审核状态
            	suppledata.add("ADD_TYPE", "2");				//安置部要求补充（ADD_TYPE：2）
            	suppletranslationdata.add("AT_TYPE", "2");		//安置部要求补翻（AT_TYPE：2）
            	//审核部的审核状态
            	String shb_state = applydata.getString("AUD_STATE1","");
            	//如果当前操作的审核结果为通过，且审核部的审核状态也为通过，这更新预批状态为通过（RI_STATE：4）
            	if("2".equals(audit_option)){
            		if("5".equals(shb_state)){
            			/*获取交文期限begin*/
            			PublishManagerHandler pmHandler = new PublishManagerHandler();
            			Data tempData = new Data();
            			if(oneType.equals("1")){	//点发
            				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, threeType).getData(0);
            			}else{
            				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, null).getData(0);
            			}
            			String DEADLINE = tempData.getString("DEADLINE","0");	//交文期限，以日计
            			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            			
            			Calendar cal = Calendar.getInstance();
            			Date submitDate = sdf.parse(curDate);
            			cal.setTime(submitDate);
            			//cal.add(Calendar.MONTH, Integer.parseInt(DEADLINE));
            			cal.add(Calendar.DATE, Integer.parseInt(DEADLINE));
            			/*获取交文期限end*/
            			
            			applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHTG);	//审核通过
            			applyupdate.add("PASS_DATE", curDate);
            			applyupdate.add("SUBMIT_DATE", sdf.format(cal.getTime()));
            		}
            	}else if("3".equals(audit_option)){
            		applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHBTG);	//审核不通过
            	}else if("4".equals(audit_option)){
            		//初始化预批申请记录中的安置部末次补充状态为待补充（LAST_STATE2：0）
            		applyupdate.add("LAST_STATE2", "0");
            	}else if("6".equals(audit_option)){
            		//初始化预批申请记录中的安置部补翻状态为待待补充（ATRANSLATION_STATE2：0）
            		applyupdate.add("ATRANSLATION_STATE2", "0");
            		applyupdate.add("AUD_STATE2", "1");	
            	}
            	
            	setAttribute("type", "AZB");	//审核部预批补充查询页面的审核操作，返回列表标示
            }else{
            	suppledata.add("ADD_TYPE", "1");				//审核部要求补充（ADD_TYPE：1）
            	suppletranslationdata.add("AT_TYPE", "1");		//审核部要求补翻（AT_TYPE：1）
            	//安置部的审核状态
            	String azb_state = applydata.getString("AUD_STATE2","");
            	String level = data.getString("AUDIT_LEVEL","");
            	if("1".equals(audit_option)){					//初审上报
            		applyupdate.add("AUD_STATE1", "2");			//审核部的审核状态:2：部门主任待审核
            	}else if("2".equals(audit_option)){				
            		if("0".equals(level)){						//初审通过
            			applyupdate.add("AUD_STATE1", "2");		//审核部的审核状态:2：部门主任待审核
            		}else{
            			if("2".equals(azb_state)){
            				applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHTG);
                			applyupdate.add("PASS_DATE", curDate);
                			
                			/*获取交文期限begin*/
                			PublishManagerHandler pmHandler = new PublishManagerHandler();
                			Data tempData = new Data();
                			if(oneType.equals("1")){	//点发
                				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, threeType).getData(0);
                			}else{
                				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, null).getData(0);
                			}
                			String DEADLINE = tempData.getString("DEADLINE","0");	//交文期限，以日计
                			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                			
                			Calendar cal = Calendar.getInstance();
                			Date submitDate = sdf.parse(curDate);
                			cal.setTime(submitDate);
                			//cal.add(Calendar.MONTH, Integer.parseInt(DEADLINE));
                			cal.add(Calendar.DATE, Integer.parseInt(DEADLINE));
                			/*获取交文期限end*/
                			applyupdate.add("SUBMIT_DATE", sdf.format(cal.getTime()));
                		}
            			applyupdate.add("AUD_STATE1", "5");		//审核部的审核状态:5：审核通过
            		}
            	}else if("3".equals(audit_option)){				//审核部审核结果：不通过
            		applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHBTG);	//预批的预批状态：审核不通过（RI_STATE：3）
            		applyupdate.add("AUD_STATE1", "4");			//审核部的审核状态:4：审核不通过
            	}else if("4".equals(audit_option)){
            		applyupdate.add("LAST_STATE", "0");			//初始化预批申请记录中的审核部末次补充状态为待补充（LAST_STATE：0）
            		applyupdate.add("AUD_STATE1", "1");			//审核部的审核状态:1：经办人审核中
            	}else if("7".equals(audit_option)){
            		applyupdate.add("AUD_STATE1", "9");			//审核部的审核状态:9：退回经办人
            	}else if("8".equals(audit_option)){
            		applyupdate.add("AUD_STATE1", "3");			//审核部的审核状态:3：分管主任待审核
            	}else if("6".equals(audit_option)){
            		//初始化预批申请记录中的安置部补翻状态为待待补充（ATRANSLATION_STATE2：0）
            		applyupdate.add("ATRANSLATION_STATE", "0");
            		applyupdate.add("AUD_STATE1", "1");	
            	}
            	
            	if("0".equals(level)){
            		level = "one";
            	}else if("1".equals(level)){
            		level = "two";
            	}else{
            		level = "three";
            	}
            	setAttribute("Level", level);
            	setAttribute("type", "SHB");	//审核部预批补充查询页面的审核操作，返回列表标示
            }
    		
            boolean success = handler.PreApproveAuditSave(conn,data,applyupdate,suppledata,suppletranslationdata,type);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据提交成功!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请审核信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[预批申请审核信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请审核信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("预批申请审核保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (ParseException e) {
        	setAttribute(Constants.ERROR_MSG_TITLE, "预批申请审核信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("预批申请审核保存操作异常:" + e.getMessage(),e);
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
                        log.logError("PreApproveAuditAction的PreApproveAuditSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveSuppleRecordsList 
	 * @Description: 预批申请补充记录
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveSuppleRecordsList(){
		String ri_id = getParameter("RI_ID","");	//获取预批申请记录id
		//String type = getParameter("type");	
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请审核记录信息DataList
			//DataList datalist = handler.PreApproveSuppleRecordsList(conn,ri_id,type);
			DataList datalist = handler.PreApproveSuppleRecordsList(conn,ri_id);
			setAttribute("List", datalist);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取预批补充记录操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[获取预批补充记录/查看操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction的PreApproveSuppleRecordsList.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		//retValue = type;
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditRecordsList 
	 * @Description: 预批申请审核记录
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveAuditRecordsList(){
		String ri_id = getParameter("RI_ID","");	//获取预批申请记录id
		//String type = getParameter("type");	
		//retValue = type;
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请审核记录信息DataList
			DataList datalist = handler.PreApproveAuditRecordsList(conn,ri_id);
			setAttribute("List", datalist);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取预批审核记录操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[获取预批审核记录/查看操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction的PreApproveAuditRecordsList.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveCancelApplyAdd 
	 * @Description: 预批撤销添加操作
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveCancelApplyAdd(){
		String ri_id = getParameter("RI_ID","");	//获取预批申请记录id
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请记录信息Data
			Data data = new PreApproveApplyHandler().getPreApproveApplyData(conn, ri_id);
			//获取主儿童信息
			Data childdata = new LockChildHandler().getMainChildInfo(conn, data.getString("CI_ID",""));
			//获取附儿童信息
			DataList childList = new LockChildHandler().getAttachChildList(conn, data.getString("CI_ID",""));
			
			data.add("PROVINCE_ID", childdata.getString("PROVINCE_ID",""));
			data.add("WELFARE_NAME_CN", childdata.getString("WELFARE_NAME_CN",""));
			data.add("NAME", childdata.getString("NAME",""));
			data.add("SEX", childdata.getString("SEX",""));
			data.add("BIRTHDAY", childdata.getString("BIRTHDAY",""));
			data.add("SPECIAL_FOCUS", childdata.getString("SPECIAL_FOCUS",""));
			
			setAttribute("data", data);
			setAttribute("ChildList", childList);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批撤销添加操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[预批撤销添加操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction的PreApproveCancelApplyAdd.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveCancelApplySave 
	 * @Description: 安置部预批撤销保存操作
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveCancelApplySave(){
		//1 获得页面表单数据，构造数据结果集
		//预批申请信息Data
		Data data = getRequestEntityData("R_","RI_ID","PUB_ID","AF_ID","REVOKE_REASON","REVOKE_STATE","REVOKE_TYPE","FILE_TYPE");
		Data cdata = getRequestEntityData("C_","CI_ID","SPECIAL_FOCUS","IS_PUBLISH");
		Data  dfData = getRequestEntityData("P_","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");
        Data  qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");
        
		UserInfo userinfo = SessionInfo.getCurUser();
		String personId = userinfo.getPersonId();
		String personCName = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		data.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX);	//预批状态：无效（RI_STATE：9）
		data.add("REVOKE_REQ_USERID", personId);	//撤销申请人id
		data.add("REVOKE_REQ_USERNAME", personCName);	//撤销申请人姓名
		data.add("REVOKE_REQ_DATE", curDate);	//撤销申请日期
		
		data.add("REVOKE_CFM_USERID", personId);	//撤销申请确认人id
		data.add("REVOKE_CFM_USERNAME", personCName);	//撤销申请确认人姓名
		data.add("REVOKE_CFM_DATE", curDate);	//撤销申请确认日期
		data.add("UNLOCKER_ID", personId);	//解除锁定人id
		data.add("UNLOCKER_NAME", personCName);	//解除锁定人姓名
		data.add("UNLOCKER_DATE", curDate);	//解除锁定日期
		data.add("UNLOCKER_TYPE", "2");	//解除锁定类型：中心解除（UNLOCKER_TYPE：0）
		data.add("LOCK_STATE", "1");	//锁定状态(1：已解除)
		
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            
            PublishManagerHandler  pmHandler = new PublishManagerHandler();
            
            String ci_id = cdata.getString("CI_ID","");
            String isPublish = cdata.getString("IS_PUBLISH","");	//是否继续发布标示（1：是；0：否）
    		String isSpecial = cdata.getString("SPECIAL_FOCUS","");	//是否特别关注（0：否；1：是）
    		String pubType = dfData.getString("PUB_TYPE","");		//发布类型（1：点发；2：群发）
    		
    		Data fbData = new Data();								//发布记录信息
    		if(isPublish.equals("1")){								//如果重新发布，则创建信息的发布记录
    			fbData.add("PUBLISHER_ID",personId);				//发布人
        		fbData.add("PUBLISHER_NAME",personCName);			//发布人姓名
        		fbData.add("PUB_DATE",curDate);						//发布日期
        		fbData.add("PUB_STATE",PublishManagerConstant.YFB);	//发布状态为"已发布"
    			fbData.add("CI_ID", ci_id);
    			fbData.add("PUB_TYPE", pubType);
    			
    			if(pubType.equals("1")){									//如果页面选择的是点发
    				fbData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));	//点发的发布组织
        			fbData.add("PUB_MODE",dfData.getString("PUB_MODE"));
        			fbData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
        			if("1".equals(isSpecial)||"1"==isSpecial){				//特别关注
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
            		}else {													//非特别关注
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
            		}
        		}else{														//如果页面选择的是群发
        			fbData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));	//群发的发布组织
        			if("1".equals(isSpecial)||"1"==isSpecial){				//特别关注
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
            		}else {													//非特别关注
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
            		}
    			}
    			
    			
    			//**********更新儿童材料表相关信息begin**********
    			cdata.add("PUB_USERID", personId);							//发布人ID
            	cdata.add("PUB_USERNAME", personCName);						//发布人名称
            	cdata.add("PUB_STATE", PublishManagerConstant.YFB);			//发布状态为“已发布”
            	cdata.add("PUB_TYPE", pubType);								//发布类型
            	cdata.add("PUB_LASTDATE", curDate);							//末次发布日期
            	
            	int num = pmHandler.getFbNum(conn, ci_id);					//获得该儿童发布次数
        		cdata.add("PUB_NUM", num+1);								//发布次数
        		
            	if("1".equals(pubType)||"1"==pubType){						//如果页面选择的是点发
            		cdata.add("PUB_ORGID", dfData.getString("PUB_ORGID"));	//点发发布组织
            	}else{
            		cdata.add("PUB_ORGID", qfData.getString("PUB_ORGID"));	//群发发布组织
            	}
            	//**********更新儿童材料表相关信息end**********
    			
    		}else{	//如果不重新发布，则更新原有的发布记录
    			fbData.add("PUB_ID", data.getString("PUB_ID",""));
    			fbData.add("PUB_STATE", PublishManagerConstant.YFB);		//发布状态为“已发布”
    			fbData.add("ADOPT_ORG_ID", "");								//清空锁定组织id
    			fbData.add("LOCK_DATE", "");								//清空锁定日期
    			
    			cdata.add("PUB_STATE", PublishManagerConstant.YFB);			//发布状态为“已发布”
    		}
    		cdata.remove("IS_PUBLISH");
    		
            boolean success = handler.PreApproveCancelApplySave(conn,data,fbData,cdata);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请审核信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[预批申请审核信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请审核信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("预批申请审核保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (NumberFormatException e) {
        	setAttribute(Constants.ERROR_MSG_TITLE, "预批申请审核信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("预批申请审核保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} catch (ParseException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请审核信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("预批申请审核保存操作异常:" + e.getMessage(),e);
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
                        log.logError("PreApproveAuditAction的PreApproveAuditSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditListSHB 
	 * @Description: 审核部预批申请审核列表
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveAuditListSHB(){
		//审核级别,one:初审,two:复审,three:审批
		String level = getParameter("Level","");	
		if(level.equals("")){
			level = (String)getAttribute("Level");
		}
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
        Data data = getRequestEntityData("S_","ADOPT_ORG_NAME_CN","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_CN","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        		"SPECIAL_FOCUS","REQ_DATE_START","REQ_DATE_END","AUD_STATE2","AUD_STATE1","LAST_STATE","ATRANSLATION_STATE","RI_STATE","PASS_DATE_START","PASS_DATE_END");
        //将男、女收养人姓名转化为大写
        String MALE_NAME = data.getString("MALE_NAME","");
        if(!MALE_NAME.equals("")){
        	data.put("MALE_NAME", MALE_NAME.toUpperCase());
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");
        if(!FEMALE_NAME.equals("")){
        	data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
        }
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.PreApproveAuditListSHB(conn,data,level,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "安置部预批申请审核查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("安置部预批申请审核查询操作异常:" + e.getMessage(),e);
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
                        log.logError("PreApproveAuditAction的PreApproveAuditListAZB.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        retValue = level;
		return retValue;
	}
	
	/**
	 * @Title: PreApproveShow 
	 * @Description: 查看之前预批信息
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveShow(){
		String req_no = getParameter("REQ_NO");
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data applydata = handler.getPreApproveByReqNo(conn, req_no);
			setAttribute("data", applydata);
			setAttribute("RI_ID", applydata.getString("RI_ID",""));
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看之前预批信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[查看之前预批信息]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction的PreApproveShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreFileShow 
	 * @Description: 查看先前文件信息跳转操作
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String PreFileShow(){
		String file_no = getParameter("FILE_NO");
		String flag = getParameter("Flag","");
		try {
			conn = ConnectionManager.getConnection();
			//根据文件编号file_no,获取文件信息Data
			Data data = new FileManagerHandler().getSpecialFileData(conn, file_no);
			String af_id = data.getString("AF_ID","");
			if(!"".equals(flag)){
				String family_type = data.getString("FAMILY_TYPE","");
				if("1".equals(family_type)){
					retValue = "double" + flag;
				}else if("2".equals(family_type)){
					retValue = "single" + flag;
				} 
			}
			
			setAttribute("data", data);
			setAttribute("AF_ID", af_id);
			setAttribute("FILE_NO", file_no);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",af_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",af_id));
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看之前文件信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[查看之前预批信息]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction的PreFileShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
}
