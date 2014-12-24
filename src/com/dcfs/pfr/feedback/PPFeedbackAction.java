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
 * @Description: ���ú󱨸淴��
 * @Company: 21softech
 * @Created on 2014-10-24 ����4:57:19
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(PPFeedbackAction.class);
    private Connection conn = null;
    private PPFeedbackHandler handler;
    private DBTransaction dt = null;//������
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
     * @Description:��ͯ��Ϣ 
     * @author: xugy
     * @date: 2014-10-26����11:08:31
     * @return
     */
    public String CIInfoShow(){
        String CI_ID = getParameter("CI_ID");
        String LANG = getParameter("LANG");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getCIInfo(conn, CI_ID);
            
            setAttribute("data",data);
            setAttribute("LANG",LANG);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
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
     * @Description: ��������Ϣ
     * @author: xugy
     * @date: 2014-10-26����11:42:35
     * @return
     */
    public String AFInfoShow(){
        String AF_ID = getParameter("AF_ID");
        String LANG = getParameter("LANG");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getAFInfo(conn, AF_ID);
            
            setAttribute("data",data);
            setAttribute("LANG",LANG);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
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
     * @Description: �ϴΰ��÷�������
     * @author: xugy
     * @date: 2014-10-27����9:00:11
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
     * @Description: ���ú󱨸油����Ϣ
     * @author: xugy
     * @date: 2014-11-4����3:41:35
     * @return
     */
    public String feedbackAdditonalShow(){
        String FB_ADD_ID = getParameter("FB_ADD_ID");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getfeedbackAdditonaShowlInfo(conn, FB_ADD_ID);
            
            setAttribute("data",data);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

}
