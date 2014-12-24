package com.dcfs.sce.translation;

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

import com.dcfs.common.DcfsConstants;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;

/**
 * 
 * @Title: TranslationAction.java
 * @Description: 特需预批翻译办理action
 * @Company: 21softech
 * @Created on 2014-10-09 下午8:19:29 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class TranslationAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(TranslationAction.class);
    private Connection conn = null;
    private TranslationHandler handler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public TranslationAction() {
        this.handler=new TranslationHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /************** 预批申请翻译Begin ***************/
    
    /**
     * 
     * @Title: applyTranslationList
     * @Description: 预批申请翻译信息列表
     * @author: panfeng
     * @date: 2014-10-09 下午8:19:29 
     * @return
     */
    public String applyTranslationList(){
        // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="RECEIVE_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME",
        			"PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        			"REQ_DATE_START","REQ_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END","TRANSLATION_STATE");
        //男方、女方搜索输入条件转换大写
        String MALE_NAME = data.getString("MALE_NAME",null);
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
            DataList dl=handler.applyTranslationList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
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
	 * @Title: preTranslation 
	 * @Description: 预批申请翻译、查看页面
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
    public String preTranslation(){
		String uuid = getParameter("showuuid","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		String type = getParameter("type");
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getShowData(conn, uuid);
		       
		       setAttribute("data", showdata);
		   }  catch (Exception e) {
			e.printStackTrace();
		}finally {
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
		if ("tran".equals(type)) {
			return "tran";
		} else if ("show".equals(type)) {
			return "show";
		} else {
			return SUCCESS;
		}		   
    }
    
    /**
     * 保存翻译信息
	 * @author panfeng
	 * @date 2014-10-09
     * @return
     */
    public String preTranslationSave(){
    	//获取操作类型（保存/提交）
    	String operationType = getParameter("type");
	    //1 获得页面表单数据，构造数据结果集
    	//获取预批申请信息
        Data preData = getRequestEntityData("R_","RI_ID","MALE_JOB_CN","MALE_JOB_EN","FEMALE_JOB_CN","FEMALE_JOB_EN",
        			"MALE_HEALTH_CONTENT_CN","MALE_HEALTH_CONTENT_EN","FEMALE_HEALTH_CONTENT_CN","FEMALE_HEALTH_CONTENT_EN",
        			"MALE_PUNISHMENT_CN","MALE_PUNISHMENT_EN","FEMALE_PUNISHMENT_CN","FEMALE_PUNISHMENT_EN",
        			"MALE_ILLEGALACT_CN","MALE_ILLEGALACT_EN","FEMALE_ILLEGALACT_CN","FEMALE_ILLEGALACT_EN",
        			"CHILD_CONDITION_CN","CHILD_CONDITION_EN","ADOPT_REQUEST_CN","ADOPT_REQUEST_EN",
        			"IS_FAMILY_OTHERS_CN","IS_FAMILY_OTHERS_EN","TENDING_CN","TENDING_EN","OPINION_CN","OPINION_EN",
        			"TRANSLATION_STATE");
        //获取预批申请翻译信息
        Data tranData = getRequestEntityData("P_","AT_ID","TRANSLATION_DESC","TRANSLATION_STATE");
        //获取当前登录人的信息
  		String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
  		String curOrgan = SessionInfo.getCurUser().getCurOrgan().getCName();
        String curId = SessionInfo.getCurUser().getPerson().getPersonId();
		String curPerson = SessionInfo.getCurUser().getPerson().getCName();
		String curDate = DateUtility.getCurrentDate();
  		//翻译完成日期
		if("2".equals(tranData.getString("TRANSLATION_STATE",""))){
			tranData.add("COMPLETE_DATE", curDate);
		}else{
			tranData.add("COMPLETE_DATE", "");
		}
		//翻译人ID
		tranData.add("TRANSLATION_USERID", curId);
		//翻译人姓名		
		tranData.add("TRANSLATION_USERNAME", curPerson);
		//翻译单位ID
		tranData.add("TRANSLATION_UNIT",curOrgId);
		//翻译单位名称
		tranData.add("TRANSLATION_UNITNAME",curOrgan);
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //提交操作时初始化预批审核记录
            if("submit".equals(operationType) || operationType=="submit"){
            	PublishCommonManager publishcommonmanager = new PublishCommonManager();
            	publishcommonmanager.approveAuditInit(conn, preData.getString("RI_ID"));
            	preData.add("AUD_STATE1", "0");//审核部审核状态
            	preData.add("AUD_STATE2", "0");//安置部审核状态
            }
			
            boolean success = false;
			//3 执行数据库处理操作
            success=handler.preTranslationSave(conn,preData,tranData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "保存成功!");//保存成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
			retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
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
                        log.logError("TranslationAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
    
	
	/************** 预批申请翻译End ***************/
	
	/************** 预批补充翻译Begin ***************/
	
	/**
     * 
     * @Title: supplyTranslationList
     * @Description: 预批补充翻译信息列表
     * @author: panfeng
     * @date: 2014-10-16 上午10:28:12 
     * @return
     */
    public String supplyTranslationList(){
        // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME",
        			"PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        			"FEEDBACK_DATE_START","FEEDBACK_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END","TRANSLATION_STATE");
        //男方、女方搜索输入条件转换大写
        String MALE_NAME = data.getString("MALE_NAME",null);
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
            DataList dl=handler.supplyTranslationList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
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
	 * @Title: supplyTranslation 
	 * @Description: 预批补充翻译、查看页面
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
    public String supplyTranslation(){
		String uuid = getParameter("showuuid","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		String type = getParameter("type");
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getSupplyTranData(conn, uuid);
		       
		       setAttribute("data", showdata);
		   }  catch (Exception e) {
			e.printStackTrace();
		}finally {
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
		if ("tran".equals(type)) {
			return "tran";
		} else if ("show".equals(type)) {
			return "show";
		} else {
			return SUCCESS;
		}		   
    }
    
    /**
     * 保存翻译信息
	 * @author panfeng
	 * @date 2014-10-16
     * @return
     */
    public String supplyTranslationSave(){
	    //1 获得页面表单数据，构造数据结果集
    	//获取预批补充信息
        Data adData = getRequestEntityData("P_","RA_ID","ADD_CONTENT_EN","ADD_CONTENT_CN","UPLOAD_IDS_CN");
        //获取预批补充翻译信息
        Data tranData = getRequestEntityData("R_","AT_ID","RI_ID","TRANSLATION_DESC","TRANSLATION_STATE","AT_TYPE");
        Data preData = new Data();
        //预批申请主键
        preData.add("RI_ID", tranData.getString("RI_ID",""));
        //补翻状态
        String at_type = tranData.getString("AT_TYPE","");
        if("1".equals(at_type)){
        	preData.add("ATRANSLATION_STATE", tranData.getString("TRANSLATION_STATE",""));//审核部
        }else if("2".equals(at_type)){
        	preData.add("ATRANSLATION_STATE2", tranData.getString("TRANSLATION_STATE",""));//安置部
        }
        //获取当前登录人的信息
  		String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
  		String curOrgan = SessionInfo.getCurUser().getCurOrgan().getCName();
        String curId = SessionInfo.getCurUser().getPerson().getPersonId();
		String curPerson = SessionInfo.getCurUser().getPerson().getCName();
		String curDate = DateUtility.getCurrentDate();
  		//翻译完成日期
		if("2".equals(tranData.getString("TRANSLATION_STATE",""))){
			tranData.add("COMPLETE_DATE", curDate);
		}else{
			tranData.add("COMPLETE_DATE", "");
		}
		//翻译人ID
		tranData.add("TRANSLATION_USERID", curId);
		//翻译人姓名		
		tranData.add("TRANSLATION_USERNAME", curPerson);
		//翻译单位ID
		tranData.add("TRANSLATION_UNIT",curOrgId);
		//翻译单位名称
		tranData.add("TRANSLATION_UNITNAME",curOrgan);
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            success=handler.supplyTranslationSave(conn,preData,tranData,adData);
            String packageId = adData.getString("UPLOAD_IDS_CN");//附件
            AttHelper.publishAttsOfPackageId(packageId, "AF");//附件发布
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "保存成功!");//保存成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
			retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
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
                        log.logError("TranslationAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
    
    /************** 预批补充翻译End ***************/
    
}
