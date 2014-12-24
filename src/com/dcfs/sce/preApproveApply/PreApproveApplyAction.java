/**   
 * @Title: PreApproveApplyAction.java 
 * @Package com.dcfs.sce.preApproveApply 
 * @Description: 预批申请操作 
 * @author yangrt   
 * @date 2014-9-12 下午3:11:13 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveApply;

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
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.common.PublishCommonManager;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;

/** 
 * @ClassName: PreApproveApplyAction 
 * @Description: 预批申请操作 
 * @author yangrt;
 * @date 2014-9-12 下午3:11:13 
 *  
 */
public class PreApproveApplyAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(PreApproveApplyAction.class);
	private PreApproveApplyHandler handler;
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
	
	public PreApproveApplyAction(){
		this.handler = new PreApproveApplyHandler();
	}
	
	public String PreApproveApplyList(){
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="LOCK_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END",
        		"LOCK_DATE_START","LOCK_DATE_END","REQ_DATE_START","REQ_DATE_END","PASS_DATE_START",
        		"PASS_DATE_END","RI_STATE","SUBMIT_DATE_START","SUBMIT_DATE_END","REMINDERS_STATE",
        		"REM_DATE_START","REM_DATE_END","REGISTER_DATE_START","REGISTER_DATE_END","FILE_NO",
        		"UPDATE_DATE_START","UPDATE_DATE_END","LAST_STATE","LAST_STATE2");
        //将男、女收养人姓名转化为大写
        String MALE_NAME = data.getString("MALE_NAME","");
        if(!MALE_NAME.equals("")){
        	data.put("MALE_NAME", MALE_NAME.toUpperCase());
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");
        if(!FEMALE_NAME.equals("")){
        	data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
        }
        String NAME_PINYIN = data.getString("NAME_PINYIN","");
        if(!NAME_PINYIN.equals("")){
        	data.put("NAME_PINYIN", NAME_PINYIN.toUpperCase());
        }
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.PreApproveApplyList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "预批申请查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("预批申请查询操作异常:" + e.getMessage(),e);
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
                        log.logError("PreApproveApplyAction的PreApproveApplyList.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplyShow 
	 * @Description: 预批申请修改/查看跳转操作
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveApplyShow(){
		String type = getParameter("type","");	//操作类型标示
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		retValue = type;
		//获取文件ID
		String ri_id = getParameter("RI_ID","");
		if(ri_id.equals("")){
			ri_id = (String)getAttribute("RI_ID");
		}
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//儿童材料id
			String ci_id = applydata.getString("CI_ID","");
			Data childData = new LockChildHandler().getMainChildInfo(conn, ci_id);
			//根据儿童材料id,获取儿童信息DataList
			DataList childList = new LockChildHandler().getAttachChildList(conn, ci_id);
			
			String planEN = applydata.getString("TENDING_EN","");
			String planCN = applydata.getString("TENDING_CN","");
			String opipionEN = applydata.getString("OPINION_EN","");
			String opinionCN = applydata.getString("OPINION_CN","");
			if(!"".equals(planEN)){
				applydata.put("TENDING_EN", planEN.replace("\n\r","<br>"));
			}
			if(!"".equals(planCN)){
				applydata.put("TENDING_CN", planCN.replace("\n\r","<br>"));
			}
			if(!"".equals(opipionEN)){
				applydata.put("OPINION_EN", opipionEN.replace("\n\r","<br>"));
			}
			if(!"".equals(opinionCN)){
				applydata.put("OPINION_CN", opinionCN.replace("\n\r","<br>"));
			}
			
			
			/***	倒计时设置begin		***/
			//锁定日期
			String lockDate = applydata.getString("LOCK_DATE");
			//当前日期
			String nowDate = DateUtility.getCurrentDateTime();
			//计算当前日期与锁定日期的时间差
			SimpleDateFormat dsf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar rightNow = Calendar.getInstance(); 
			
			Date lock = dsf.parse(lockDate);
			rightNow.setTime(lock);
			rightNow.add(Calendar.DATE,3);	//锁定日期三天后的日期（交文截止日期）
			Date limtDate = rightNow.getTime();
			Date now = dsf.parse(nowDate);
			long between=(limtDate.getTime()-now.getTime())/1000;//除以1000是为了转换成秒
			//倒计时
			setAttribute("day", between/(24*3600));
			setAttribute("hour", between%(24*3600)/3600);
			setAttribute("minute", between%3600/60);
			setAttribute("second", between%60);
			/***	倒计时设置end	***/
			
			setAttribute("applydata", applydata);
			setAttribute("childData", childData);
			setAttribute("childList", childList);
			setAttribute("RI_ID", ri_id);
			setAttribute("ADOPT_ORG_ID", applydata.getString("ADOPT_ORG_ID",""));
			setAttribute("NALE_PHOTO", applydata.getString("NALE_PHOTO",""));
			setAttribute("FENALE_PHOTO", applydata.getString("FENALE_PHOTO",""));
			setAttribute("MALE_PUNISHMENT_FLAG", applydata.getString("MALE_PUNISHMENT_FLAG",""));
			setAttribute("MALE_ILLEGALACT_FLAG", applydata.getString("MALE_ILLEGALACT_FLAG",""));
			setAttribute("FEMALE_PUNISHMENT_FLAG", applydata.getString("FEMALE_PUNISHMENT_FLAG",""));
			setAttribute("FEMALE_ILLEGALACT_FLAG", applydata.getString("FEMALE_ILLEGALACT_FLAG",""));
			setAttribute("IS_FAMILY_OTHERS_FLAG", applydata.getString("IS_FAMILY_OTHERS_FLAG",""));
			setAttribute("CONABITA_PARTNERS", applydata.getString("CONABITA_PARTNERS",""));
			setAttribute("isPrint", getParameter("isPrint"));
			
			if("mod".equals(type)){
				String family_type = applydata.getString("FAMILY_TYPE");
				String file_type = applydata.getString("FILE_TYPE");
				if(!"21".equals(file_type)){
					if("1".equals(family_type)){
						retValue += "double";
					}else if("2".equals(family_type)){
						retValue += "single";
					} 
				}
			}
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请修改/查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[预批申请修改/查看操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} catch (ParseException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请修改/查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[预批申请修改/查看操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction的PreApproveApplyShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplyShowForFBGL 
	 * @Description: 预批申请修改/查看跳转操作(发布管理入口进行的查看)
	 * @author: mayun
	 * @return String 
	 */
	public String PreApproveApplyShowForFBGL(){
		
		String type = getParameter("type","");
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		retValue = type;
		//获取文件ID
		String ri_id = getParameter("RI_ID","");
		if(ri_id.equals("")){
			ri_id = (String)getAttribute("RI_ID");
		}
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//儿童材料id
			String ci_id = applydata.getString("CI_ID","");
			Data childData = new LockChildHandler().getMainChildInfo(conn, ci_id);
			//根据儿童材料id,获取儿童信息DataList
			DataList childList = new LockChildHandler().getAttachChildList(conn, ci_id);
			
			String lock_type = applydata.getString("LOCK_MODE","");
			Data filedata = new Data();
			if("1".equals(lock_type) || "3".equals(lock_type) || "4".equals(lock_type) || "6".equals(lock_type)){
				filedata = new FileManagerHandler().GetFileByID(conn, applydata.getString("AF_ID",""));
			}else{
				
			}

			//锁定日期
			String lockDate = applydata.getString("LOCK_DATE");
			//当前日期
			String nowDate = DateUtility.getCurrentDateTime();
			//计算当前日期与锁定日期的时间差
			SimpleDateFormat dsf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar rightNow = Calendar.getInstance(); 
			
			Date lock = dsf.parse(lockDate);
			rightNow.setTime(lock);
			rightNow.add(Calendar.DATE,3);	//锁定日期三天后的日期（交文截止日期）
			Date limtDate = rightNow.getTime();
			Date now = dsf.parse(nowDate);
			long between=(limtDate.getTime()-now.getTime())/1000;//除以1000是为了转换成秒
			//倒计时
			setAttribute("day", between/(24*3600));
			setAttribute("hour", between%(24*3600)/3600);
			setAttribute("minute", between%3600/60);
			setAttribute("second", between%60/60);
			
			setAttribute("applydata", applydata);
			setAttribute("childData", childData);
			setAttribute("childList", childList);
			setAttribute("FILE_TYPE",applydata.getString("FILE_TYPE",""));
			setAttribute("filedata", filedata);
			setAttribute("AF_ID", applydata.getString("AF_ID",""));
			setAttribute("RI_ID", applydata.getString("RI_ID",""));
			setAttribute("NALE_PHOTO", applydata.getString("NALE_PHOTO",""));
			setAttribute("FENALE_PHOTO", applydata.getString("FENALE_PHOTO",""));
			setAttribute("MALE_PUNISHMENT_FLAG", applydata.getString("MALE_PUNISHMENT_FLAG",""));
			setAttribute("MALE_ILLEGALACT_FLAG", applydata.getString("MALE_ILLEGALACT_FLAG",""));
			setAttribute("FEMALE_PUNISHMENT_FLAG", applydata.getString("FEMALE_PUNISHMENT_FLAG",""));
			setAttribute("FEMALE_ILLEGALACT_FLAG", applydata.getString("FEMALE_ILLEGALACT_FLAG",""));
			setAttribute("CONABITA_PARTNERS", applydata.getString("CONABITA_PARTNERS",""));
			
			if("mod".equals(type)){
				String family_type = applydata.getString("FAMILY_TYPE");
				if("2".equals(lock_type) || "5".equals(lock_type)){
					if("1".equals(family_type)){
						retValue += "double";
					}else if("2".equals(family_type)){
						retValue += "single";
					} 
				}
			}
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请修改/查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[预批申请修改/查看操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} catch (ParseException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请修改/查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[预批申请修改/查看操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction的PreApproveApplyShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplySave 
	 * @Description: 预批申请保存/提交操作
	 * @author: yangrt
	 * @return String
	 */
	public String PreApproveApplySave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","AF_ID","RI_ID","PRE_REQ_NO","CI_ID","RI_STATE","LOCK_MODE","FILE_TYPE","PUB_ID",
				"MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN",
				"MALE_HEALTH","MALE_HEALTH_CONTENT_EN","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_EN",
				"MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME",
				"FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN",
				"FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN",
				"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME",
				"CURRENCY","MARRY_CONDITION","MARRY_DATE","TOTAL_ASSET","TOTAL_DEBT","UNDERAGE_NUM","CHILD_CONDITION_EN","ADDRESS","ADOPT_REQUEST_EN",
				"ADOPTER_SEX","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME","GAY_STATEMENT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_EN",
				"TENDING_EN","OPINION_EN","TENDING_CN","OPINION_CN");
		//将男、女收养人姓名转化为大写
		if(!"".equals(data.getString("MALE_NAME",""))){
			data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
		}
		if(!"".equals(data.getString("FEMALE_NAME",""))){
			data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
		}
		if(!"".equals(data.getString("ADDRESS",""))){
			data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
		}
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            
            UserInfo userinfo = SessionInfo.getCurUser();
			String orgid = userinfo.getCurOrgan().getOrgCode();
			//获取收养组织信息
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			String TRANS_FLAG = syzzinfo.getTransFlag();	//预批是否翻译：1=是；0=否
            
			String clueMes = "";
            //当数据为提交时（预批状态值：1），添加申请日期
    		String ri_state = data.getString("RI_STATE");
    		if(PreApproveConstant.PRE_APPROVAL_YTJ.equals(ri_state)){
    			data.put("REQ_NO", new PublishCommonManager().createPreApproveApplyNo(conn, userinfo.getCurOrgan().getOrgCode()));
    			data.add("REQ_DATE", DateUtility.getCurrentDateTime());
    			clueMes = "Submitted successfully!";
    			retValue = "submit";
    		}else{
    			setAttribute("RI_ID", data.getString("RI_ID"));
    			setAttribute("type", "mod");
    			setAttribute("act", getParameter("act",""));
    			clueMes = "Saved successfully!";
    			retValue = "save";
    		}
    		
            boolean success = handler.PreApproveApplySave(conn,data,TRANS_FLAG);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, clueMes);
                setAttribute("clueTo", clueTo);
                
                //附件发布
            	AttHelper.publishAttsOfPackageId(data.getString("MALE_PHOTO"), "AF"); //发布男收养人照片
            	AttHelper.publishAttsOfPackageId(data.getString("FEMALE_PHOTO"), "AF"); //发布女收养人照片
            }
            
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[预批申请信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("预批申请保存操作异常:" + e.getMessage(),e);
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
                        log.logError("PreApproveApplyAction的PreApproveApplySave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplySubmit 
	 * @Description: 预批申请提交操作
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveApplySubmit(){
		//1 获取要提交的文件ID
		String submitid = getParameter("submitid");
		String[] submit_id = submitid.split(";");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			success = handler.PreApproveApplySubmit(conn, submit_id);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "提交预批申请操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[预批申请提交操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction的PreApproveApplySubmit.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplyDelete 
	 * @Description: 预批申请删除操作
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveApplyDelete(){
		//1 获取要删除的文件ID
		String deleteuuid = getParameter("deleteid", "");
		String[] uuid = deleteuuid.split(";");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取删除结果
			success = handler.PreApproveApplyDelete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Deleted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批申请删除操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[预批申请删除操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据删除失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction的PreApproveApplyDelete.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PlanOpinionShow 
	 * @Description: 抚育计划和组织意见添加查看操作
	 * @author: yangrt
	 * @return String 
	 */
	public String PlanOpinionShow(){
		//获取预批申请id
		String ri_id = getParameter("RI_ID");
		String type = getParameter("type");
		String flag = getParameter("Flag");
		String isPrint = getParameter("isPrint","");
		retValue = type + flag;
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//儿童材料id
			String ci_id = applydata.getString("CI_ID","");
			Data childData = new LockChildHandler().getMainChildInfo(conn, ci_id);
			String planEN = applydata.getString("TENDING_EN","");
			String planCN = applydata.getString("TENDING_CN","");
			String opipionEN = applydata.getString("OPINION_EN","");
			String opinionCN = applydata.getString("OPINION_CN","");
			if(!"".equals(planEN)){
				childData.add("TENDING_EN", planEN.replace("\r\n","<br>"));
			}
			if(!"".equals(planCN)){
				childData.add("TENDING_CN", planCN.replace("\r\n","<br>"));
			}
			if(!"".equals(opipionEN)){
				childData.add("OPINION_EN", opipionEN.replace("\r\n","<br>"));
			}
			if(!"".equals(opinionCN)){
				childData.add("OPINION_CN", opinionCN.replace("\r\n","<br>"));
			}
			//根据儿童材料id,获取儿童信息DataList
			DataList childList = new LockChildHandler().getAttachChildList(conn, ci_id);
			setAttribute("applydata", applydata);
			setAttribute("childList", childList);
			setAttribute("childdata", childData);
			setAttribute("RI_ID", ri_id);
			setAttribute("MALE_PHOTO",applydata.getString("MALE_PHOTO", ri_id));
			setAttribute("FEMALE_PHOTO",applydata.getString("FEMALE_PHOTO", ri_id));
			setAttribute("MAIN_PHOTO",childData.getString("PHOTO_CARD", ci_id));
			setAttribute("ADOPTER_SEX",applydata.getString("ADOPTER_SEX",""));
			setAttribute("isPrint", isPrint);
			
			if(flag.equals("infoEN") || flag.equals("infoCN")){
				retValue += applydata.getString("FAMILY_TYPE","");
			}
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "抚育计划和组织意见修改/查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[抚育计划和组织意见修改/查看操作]:" + e.getMessage(),e);
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
                        log.logError("PreApproveApplyAction的PlanOpinionShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditResult 
	 * @Description: 预批
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String PreApproveAuditResult(){
		//获取预批申请id
		String ri_id = getParameter("RI_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//儿童材料id
			String ci_id = applydata.getString("CI_ID","");
			//根据儿童材料id,获取主儿童信息Data
			Data childdata = new LockChildHandler().getMainChildInfo(conn, ci_id);
			
			//添加儿童信息
			applydata.add("PROVINCE_ID", childdata.getString("PROVINCE_ID",""));
			applydata.add("WELFARE_NAME_CN", childdata.getString("WELFARE_NAME_CN",""));
			applydata.add("WELFARE_NAME_EN", childdata.getString("WELFARE_NAME_EN",""));
			applydata.add("NAME", childdata.getString("NAME",""));
			applydata.add("NAME_PINYIN", childdata.getString("NAME_PINYIN",""));
			
			String passdate = applydata.getString("PASS_DATE");
			String year = passdate.substring(0, 4);
			String month = passdate.substring(5, 7);
			String day = passdate.substring(8, 10);
			
			setAttribute("year", year);
			setAttribute("month", month);
			setAttribute("day", day);
			
			int monthnum;
			if(month.contains("0")){
				monthnum = Integer.parseInt(month.substring(1, month.length()));
			}else{
				monthnum = Integer.parseInt(month);
			}
			
			switch(monthnum){
				case 1:	setAttribute("monthEN", "January");
					break;
				case 2:	setAttribute("monthEN", "February");
					break;
				case 3:	setAttribute("monthEN", "March");
					break;
				case 4:	setAttribute("monthEN", "April");
					break;
				case 5:	setAttribute("monthEN", "May");
					break;
				case 6:	setAttribute("monthEN", "June");
					break;
				case 7:	setAttribute("monthEN", "July");
					break;
				case 8:	setAttribute("monthEN", "August");
					break;
				case 9:	setAttribute("monthEN", "September");
					break;
				case 10:	setAttribute("monthEN", "October");
					break;
				case 11:	setAttribute("monthEN", "November");
					break;
				case 12:	setAttribute("monthEN", "December");
					break;
			}	
			
			String birth = childdata.getString("BIRTHDAY");
			String birthyear = birth.substring(0, 4);
			String birthmonth = birth.substring(5, 7);
			String birthday = birth.substring(8, 10);
			
			setAttribute("birthyear", birthyear);
			setAttribute("birthmonth", birthmonth);
			setAttribute("birthday", birthday);
			
			int birthmonthnum;
			if(birthmonth.contains("0")){
				birthmonthnum = Integer.parseInt(birthmonth.substring(1, month.length()));
			}else{
				birthmonthnum = Integer.parseInt(birthmonth);
			}
			
			switch(birthmonthnum){
				case 1:	setAttribute("birthmonthEN", "January");
					break;
				case 2:	setAttribute("birthmonthEN", "February");
					break;
				case 3:	setAttribute("birthmonthEN", "March");
					break;
				case 4:	setAttribute("birthmonthEN", "April");
					break;
				case 5:	setAttribute("birthmonthEN", "May");
					break;
				case 6:	setAttribute("birthmonthEN", "June");
					break;
				case 7:	setAttribute("birthmonthEN", "July");
					break;
				case 8:	setAttribute("birthmonthEN", "August");
					break;
				case 9:	setAttribute("birthmonthEN", "September");
					break;
				case 10:	setAttribute("birthmonthEN", "October");
					break;
				case 11:	setAttribute("birthmonthEN", "November");
					break;
				case 12:	setAttribute("birthmonthEN", "December");
					break;
			}	
			
			String submitdate = applydata.getString("SUBMIT_DATE");
			String submityear = submitdate.substring(0, 4);
			String submitmonth = submitdate.substring(5, 7);
			String submitday = submitdate.substring(8, 10);
			
			setAttribute("submityear", submityear);
			setAttribute("submitmonth", submitmonth);
			setAttribute("submitday", submitday);
			
			int submitmonthnum;
			if(birthmonth.contains("0")){
				submitmonthnum = Integer.parseInt(birthmonth.substring(1, month.length()));
			}else{
				submitmonthnum = Integer.parseInt(birthmonth);
			}
			
			switch(submitmonthnum){
				case 1:	setAttribute("submitmonthEN", "January");
					break;
				case 2:	setAttribute("submitmonthEN", "February");
					break;
				case 3:	setAttribute("submitmonthEN", "March");
					break;
				case 4:	setAttribute("submitmonthEN", "April");
					break;
				case 5:	setAttribute("submitmonthEN", "May");
					break;
				case 6:	setAttribute("submitmonthEN", "June");
					break;
				case 7:	setAttribute("submitmonthEN", "July");
					break;
				case 8:	setAttribute("submitmonthEN", "August");
					break;
				case 9:	setAttribute("submitmonthEN", "September");
					break;
				case 10:	setAttribute("submitmonthEN", "October");
					break;
				case 11:	setAttribute("submitmonthEN", "November");
					break;
				case 12:	setAttribute("submitmonthEN", "December");
					break;
			}	
			
			setAttribute("data", applydata);
			setAttribute("childdata", childdata);
			setAttribute("ADOPTER_SEX", applydata.getString("ADOPTER_SEX",""));
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "审核结果通知查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[审核结果通知查看操作]:" + e.getMessage(),e);
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
                        log.logError("PreApproveApplyAction的PreApproveAuditResult.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveRevokeReason 
	 * @Description: 预批无效原因查看
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String PreApproveRevokeReason(){
		String ri_id = getParameter("RI_ID","");
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			setAttribute("applydata", applydata);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批无效原因查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[预批无效原因查看操作]:" + e.getMessage(),e);
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
                        log.logError("PreApproveApplyAction的PreApproveRevokeReason.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}

}
