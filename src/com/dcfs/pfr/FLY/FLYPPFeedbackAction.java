package com.dcfs.pfr.FLY;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.pfr.feedback.PPFeedbackAction;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
/**
 * 
 * @Title: FLYPPFeedbackAction.java
 * @Description: 福利院报告查看
 * @Company: 21softech
 * @Created on 2014-10-23 上午11:28:21
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FLYPPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(FLYPPFeedbackAction.class);
    private Connection conn = null;
    private FLYPPFeedbackHandler handler;
    private PPFeedbackHandler PPhandler;
    private PPFeedbackAction PPAction;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public FLYPPFeedbackAction() {
        this.handler=new FLYPPFeedbackHandler();
        this.PPhandler=new PPFeedbackHandler();
        this.PPAction=new PPFeedbackAction();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: FLYPPFeedbackList
     * @Description: 福利院报告查看列表
     * @author: xugy
     * @date: 2014-10-23下午2:10:16
     * @return
     */
    public String FLYPPFeedbackList(){
        // 1 设置分页参数
           int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
           int page = getNowPage();
           if (page == 0) {
               page = 1;
           }
           //2.1 获取排序字段
           String compositor=(String)getParameter("compositor","");
           if("".equals(compositor)){
               compositor="COUNTRY_CN";
           }
           //2.2 获取排序类型   ASC DESC
           String ordertype=(String)getParameter("ordertype","");
           if("".equals(ordertype)){
               ordertype="ASC";
           }
           //3 获取搜索参数
           Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","NAME");
           try {
               //4 获取数据库连接
               conn = ConnectionManager.getConnection();
               //5 获取数据DataList
               DataList dl=handler.findFLYPPFeedbackList(conn,data,pageSize,page,compositor,ordertype);
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
     * 
     * @Title: PPFeedbackRecordDetail
     * @Description: 安置后报告查看（省厅、福利院）
     * @author: xugy
     * @date: 2014-11-5上午10:59:38
     * @return
     */
    public String PPFeedbackRecordDetail(){
        String FEEDBACK_ID = getParameter("ids");
        String type = getParameter("type");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            DataList dataList = handler.getFeedbackRecordInfo(conn, FEEDBACK_ID);
            Data data = new Data();
            if(dataList.size()>0){
                data=dataList.getData(0);
            }
            setAttribute("dataList",dataList);
            setAttribute("data",data);
            setAttribute("type",type);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
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
}
