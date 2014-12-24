package com.dcfs.timer;

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

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.sce.preApproveApply.PreApproveApplyHandler;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.dcfs.sce.publishPlan.PublishPlanHandler;

/** 
 * @ClassName: TimerDispatchAction 
 * @Description: 任务调度执行相关业务功能的Action
 * @author mayun
 * @date 2014-12-12
 *  
 */
public class TimerDispatchAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(TimerDispatchAction.class);
	private Connection conn = null;
	private PublishPlanHandler publishHandler;
	private PublishManagerHandler publishManagerHandler;
	private PreApproveApplyHandler preApproveHandler;
    private DBTransaction dt = null;//事务处理
	    

	public TimerDispatchAction() {
		this.publishHandler=new PublishPlanHandler();
		this.publishManagerHandler=new PublishManagerHandler();
		this.preApproveHandler = new PreApproveApplyHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}
	
	
	
	
	/**
	 * 发布计划发布
	 * @description 
	 * @author MaYun
	 * @date Oct 8, 2014
	 * @return
	 * @throws SQLException 
	 */
	public void planPublish() throws SQLException{
		String personId = "superadmin";
	 	String personName = "superadmin";
	 	String curDate = DateUtility.getCurrentDate();
	 	

	 	DataList saveETDataList = new DataList();
	 	
	 	try {
			//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String plan_id = this.publishManagerHandler.getPlanIdForDFB(conn);
            if(!"".equals(plan_id)&&null!=plan_id){
	            this.publishHandler.updateFBStateForFBJH(conn, plan_id);//更新发布计划表的发布状态为已发布
	            this.publishHandler.updateFBStateForFBJL(conn, personId, personName, plan_id);//更新发布记录表的发布状态为已发布
	            
				//***********更新儿童材料发布状态为已发布begin*************
				DataList etDataList = this.publishHandler.getEtInfoListForFBJH(conn, plan_id);
				for(int i =0;i<etDataList.size();i++){
	        		Data etData = (Data)etDataList.get(i);
	        		String ciid = etData.getString("CI_ID");//儿童材料ID
	        		
	        		Data saveETData = new Data();//发布记录DATA
	        		saveETData.add("CI_ID",ciid);//儿童材料ID
	        		saveETData.add("PUB_USERID",personId);//发布人
	        		saveETData.add("PUB_USERNAME",personName);//发布人姓名
	        		saveETData.add("PUB_STATE",PublishManagerConstant.YFB);//发布状态为"已发布"
	            	
	            	if(this.publishManagerHandler.isFirstFb(conn, ciid)){//判断该儿童是否发布过，true:发布过  false:未发布过
	            		int num = this.publishManagerHandler.getFbNum(conn, ciid);//获得该儿童发布次数
	            		saveETData.add("PUB_NUM", num+1);//发布次数
	            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
	            	}else{
	            		saveETData.add("PUB_NUM", 1);//发布次数
	            		saveETData.add("PUB_FIRSTDATE", curDate);//首次发布日期
	            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
	            	}
	            	saveETDataList.add(saveETData);
	        	}
	        	
				this.publishHandler.updateFBStateForETCL(conn, saveETDataList);
	        
		      //***********更新儿童材料发布状态为已发布end*************
				dt.commit();
            }
		}  catch (DBException e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "计划发布操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
		} catch (Exception e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "计划发布操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
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
				}
			}
		}
		
	}

	/**
	 * @Title: preApproveReminderNotice 
	 * @Description: 初始化预批催办通知
	 * @author: yangrt;
	 * @throws SQLException    设定文件 
	 * @return void    返回类型 
	 */
	public void preApproveReminderNotice() throws SQLException{
	 	String curDate = DateUtility.getCurrentDateTime();

	 	DataList initNoticeList = new DataList();
	 	DataList updateRiList = new DataList();
	 	try {
			//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            DataList riList = this.preApproveHandler.getRiIdForReminderNotice(conn);
            if(!riList.isEmpty()){
            	for(int i = 0; i < riList.size(); i++){
            		Data ridata = riList.getData(i);
            		
            		//更新预批申请记录信息
            		Data updateRidata = new Data();
            		updateRidata.add("RI_ID", ridata.getString("RI_ID",""));				//预批id
            		updateRidata.add("REMINDERS_STATE", "1");								//催办状态：1=已催办
            		updateRidata.add("REM_DATE", curDate);									//催办日期
            		updateRiList.add(updateRidata);
            		
            		//初始化预批催办记录信息
            		Data initdata = new Data();
            		initdata.add("RI_ID", ridata.getString("RI_ID",""));					//预批id
            		initdata.add("ADOPT_ORG_ID", ridata.getString("ADOPT_ORG_ID",""));		//收养组织code
            		initdata.add("REQ_DATE", ridata.getString("REQ_DATE",""));				//预批申请日期
            		initdata.add("PASS_DATE", ridata.getString("PASS_DATE",""));			//预批通过日期
            		initdata.add("SUBMIT_DATE", ridata.getString("SUBMIT_DATE",""));		//当前文件递交期限
            		initdata.add("MALE_NAME", ridata.getString("MALE_NAME",""));			//男收养人姓名
            		initdata.add("FEMALE_NAME", ridata.getString("FEMALE_NAME",""));		//女收养人姓名
            		initdata.add("NAME", ridata.getString("NAME",""));						//儿童姓名
            		initdata.add("NAME_PINYIN", ridata.getString("NAME_PINYIN",""));		//儿童姓名拼音
            		initdata.add("SEX", ridata.getString("SEX",""));						//儿童性别
            		initdata.add("BIRTHDAY", ridata.getString("BIRTHDAY",""));				//儿童出生日期	
            		initdata.add("REM_DATE", curDate);										//催办日期
            		initNoticeList.add(initdata);
            	}
            }
            
			this.preApproveHandler.updateRiDataList(conn,updateRiList);
			this.preApproveHandler.initReminderNoticeList(conn,initNoticeList);
			
			dt.commit();
		}  catch (DBException e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "初始化预批催办通知操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
		} catch (Exception e) {
			dt.rollback();
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "初始化预批催办通知操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("TimerDispatchAction的preApproveReminderNotice.Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		
	}
}
