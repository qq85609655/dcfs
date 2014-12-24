 /**
 * @Title: CmsCiTranslationAction.java
 * @Package com.dcfs.cms
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author xxx   
 * @project DCFS 
 * @date 2014-10-16 16:20:27
 * @version V1.0   
 */
package com.dcfs.cms.childTranslation;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;

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

/**
 * @Title: CmsCiTranslationAction.java
 * @Description:儿童材料翻译
 * @Created on 2014-10-16 16:20:27
 * @author wangzheng
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class CmsCiTranslationAction extends BaseAction{

	private static Log log = UtilLog.getLog(CmsCiTranslationAction.class);

    private CmsCiTranslationHandler handler;
	
	private Connection conn = null;//数据库连接
	
	private DBTransaction dt = null;//事务处理
	
	private String retValue = SUCCESS;

    public CmsCiTranslationAction(){
        this.handler=new CmsCiTranslationHandler();
    } 
    
    public String execute() throws Exception {
        return null;
    }

    /**
     * 保存翻译记录
	 * @author wangzheng
	 * @date 2014-10-16 16:20:27
     * @return
     */
    public String save(){
	    //1 获得页面表单数据，构造数据结果集
    	//1.1获得儿童材料信息
        Data cdata = getRequestEntityData("P_",
        		"CI_ID",
        		"PROVINCE_ID",
        		"WELFARE_ID",
        		"NAME",
        		"NAME_PINYIN",
        		"SEX",
        		"BIRTHDAY",
        		"CHECKUP_DATE",
        		"ID_CARD",
        		"CHILD_IDENTITY",
        		"SENDER",
        		"SENDER_ADDR",
        		"PICKUP_DATE",
        		"ENTER_DATE",
        		"SEND_DATE",
        		"IS_ANNOUNCEMENT",
        		"ANNOUNCEMENT_DATE",
        		"NEWS_NAME",
        		"SN_TYPE",
        		"IS_HOPE",
        		"IS_PLAN",
        		"DISEASE_CN",
        		"DISEASE_EN",
        		"REMARKS",
        		"FILE_CODE",
        		"FILE_CODE_EN",
        		"CHILD_TYPE"); 
        
        //1.2获得材料翻译记录        
        Data tdata = getRequestEntityData("T_","CT_ID","TRANSLATION_DESC","TRANSLATION_STATE");
        
      //获取当前登录人的信息
		UserInfo curuser = SessionInfo.getCurUser();		
		Organ organ = curuser.getCurOrgan();
		//设置保存后返回页面参数
		retValue="CHILD_TRANSLATION_SAVE";
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //3 执行数据库处理操作
            //3.1儿童材料保存
            ChildManagerHandler chandler = new ChildManagerHandler();    
            //更新儿童材料信息主表的翻译状态
            cdata.put("TRANSLATION_STATE", tdata.getString("TRANSLATION_STATE"));
            chandler.save(conn, cdata);
           
           //3.2翻译记录保存
           //判断翻译提交
            //翻译单位ID
            tdata.add("TRANSLATION_UNIT", organ.getId());
            //翻译单位名称
            tdata.add("TRANSLATION_UNITNAME", organ.getCName());
           //翻译人ID
       		tdata.add("TRANSLATION_USERID", curuser.getPersonId());
       		//翻译人姓名		
       		tdata.add("TRANSLATION_USERNAME", curuser.getPerson().getCName());
       		//翻译状态
       		tdata.add("TRANSLATION_STATE", tdata.getString("TRANSLATION_STATE"));
            //翻译完成日期
       		if(ChildInfoConstants.TRANSLATION_STATE_DONE.equals(tdata.getString("TRANSLATION_STATE"))){//翻译完成，提交
       			tdata.add("COMPLETE_DATE", DateUtility.getCurrentDate());
       			retValue="CHILD_TRANSLATION_SUBMIT";
       		}
       		//翻译记录保存
            handler.save(conn, tdata);
                    
            //3.3创建材料交接记录
		 	DataList dl = new DataList();
		 	Data dataTransfer =new Data();
     		dataTransfer.put("APP_ID",cdata.getString("CI_ID"));
     		dataTransfer.put("TRANSFER_CODE", TransferCode.CHILDINFO_FYGS_AZB);
     		dataTransfer.put("TRANSFER_STATE","0");
     		dl.add(dataTransfer);
     		FileCommonManager fm = new FileCommonManager();
     		fm.transferDetailInit(conn, dl);
		           
	        InfoClueTo clueTo = new InfoClueTo(0, "翻译记录提交成功!");//保存成功 0
	        setAttribute("clueTo", clueTo);
	        //保存翻译记录主键，如保存则返回翻译操作页面
	        setAttribute("UUID",tdata.getString("CT_ID"));	        
	       //附件发布
    		AttHelper.publishAttsOfPackageId(cdata.getString("FILE_CODE"),"CI");    		
    		AttHelper.publishAttsOfPackageId(cdata.getString("FILE_CODE_EN"),"CI");
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
                        log.logError("CmsCiTranslationAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }        
        return retValue;
    }

    /**
     * 儿童材料翻译列表
	 * @author wangzheng
	 * @date 2014-10-16 16:20:27
     * @return
     */
    public String findList(){
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="TRANSLATION_STATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}	
        //3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒		 
		  
        Data data = getRequestEntityData("S_",
        		"PROVINCE_ID",
        		"WELFARE_ID",
        		"CHILD_NO",
        		"NAME",
        		"SEX",
        		"CHILD_TYPE",
        		"SPECIAL_FOCUS",
        		"NOTICE_DATE_START",
        		"NOTICE_DATE_END",
        		"COMPLETE_DATE_START",
        		"COMPLETE_DATE_END",
        		"TRANSLATION_STATE");
        try {
		    //4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
            DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
		    //7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童翻译列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("儿童翻译查询操作异常[查询操作]:" + e.getMessage(),e);
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
                        log.logError("CmsCiTranslationAction的Connection因出现异常，未能关闭",e);
                    }
					retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     *材料翻译记录
	 * @author wangzheng
	 * @date 2014-10-16 16:20:27
     * @return
     */
    public String translation(){
     String uuid = getParameter("UUID","");
     if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
      try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            setAttribute("data", showdata);
            
            DataList attType = new DataList();
            ChildCommonManager ccm = new ChildCommonManager();
            BatchAttManager bm = new BatchAttManager();
            attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false));
		    String xmlstr = bm.getUploadParameter(attType);
            setAttribute("uploadParameter",xmlstr);  
      
        } catch (Exception e) {
			e.printStackTrace();
			retValue = "error";
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
        return retValue;        
    }  
    
    /**
     *材料翻译查看
	 * @author wangzheng
	 * @date 2014-10-20
     * @return
     */
    public String show(){
     String uuid = getParameter("UUID");
     if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
      try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            setAttribute("data", showdata);
        } catch (DBException e) {
            e.printStackTrace();
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                    	retValue="error";
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }        
        return retValue;        
    }  
   
}