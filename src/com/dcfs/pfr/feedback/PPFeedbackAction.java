package com.dcfs.pfr.feedback;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;
/**
 * 
 * @Title: PPFeedbackAction.java
 * @Description: 安置后报告反馈
 * @Company: 21softech
 * @Created on 2014-10-24 下午4:57:19
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(PPFeedbackAction.class);
    private Connection conn = null;
    private PPFeedbackHandler handler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public PPFeedbackAction() {
        this.handler=new PPFeedbackHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: CIInfoShow
     * @Description:儿童信息 
     * @author: xugy
     * @date: 2014-10-26上午11:08:31
     * @return
     */
    public String CIInfoShow(){
        String CI_ID = getParameter("CI_ID");
        String LANG = getParameter("LANG");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = handler.getCIInfo(conn, CI_ID);
            
            setAttribute("data",data);
            setAttribute("LANG",LANG);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
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
    /**
     * 
     * @Title: AFInfoShow
     * @Description: 收养人信息
     * @author: xugy
     * @date: 2014-10-26上午11:42:35
     * @return
     */
    public String AFInfoShow(){
        String AF_ID = getParameter("AF_ID");
        String LANG = getParameter("LANG");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = handler.getAFInfo(conn, AF_ID);
            
            setAttribute("data",data);
            setAttribute("LANG",LANG);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
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
    /**
     * 
     * @Title: getLastReportDate
     * @Description: 上次安置反馈日期
     * @author: xugy
     * @date: 2014-10-27下午9:00:11
     * @param conn
     * @param FEEDBACK_ID
     * @param num
     * @return
     * @throws DBException 
     */
    public String getLastReportDate(Connection conn, String FEEDBACK_ID, int num) throws DBException{
        num = num - 1;
        String NUM = ""+num;
        String REPORT_DATE = handler.getLastReportDate(conn, FEEDBACK_ID, NUM);
        return REPORT_DATE;
    }
    
    /**
     * 
     * @Title: feedbackAdditonalShow
     * @Description: 安置后报告补充信息
     * @author: xugy
     * @date: 2014-11-4下午3:41:35
     * @return
     */
    public String feedbackAdditonalShow(){
        String FB_ADD_ID = getParameter("FB_ADD_ID");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = handler.getfeedbackAdditonaShowlInfo(conn, FB_ADD_ID);
            
            setAttribute("data",data);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
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
