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
 * @Description: ����Ժ����鿴
 * @Company: 21softech
 * @Created on 2014-10-23 ����11:28:21
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
    private DBTransaction dt = null;//������
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
     * @Description: ����Ժ����鿴�б�
     * @author: xugy
     * @date: 2014-10-23����2:10:16
     * @return
     */
    public String FLYPPFeedbackList(){
        // 1 ���÷�ҳ����
           int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
           int page = getNowPage();
           if (page == 0) {
               page = 1;
           }
           //2.1 ��ȡ�����ֶ�
           String compositor=(String)getParameter("compositor","");
           if("".equals(compositor)){
               compositor="COUNTRY_CN";
           }
           //2.2 ��ȡ��������   ASC DESC
           String ordertype=(String)getParameter("ordertype","");
           if("".equals(ordertype)){
               ordertype="ASC";
           }
           //3 ��ȡ��������
           Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","NAME");
           try {
               //4 ��ȡ���ݿ�����
               conn = ConnectionManager.getConnection();
               //5 ��ȡ����DataList
               DataList dl=handler.findFLYPPFeedbackList(conn,data,pageSize,page,compositor,ordertype);
               //6 �������д��ҳ����ձ���
               setAttribute("List",dl);
               setAttribute("data",data);
               setAttribute("compositor",compositor);
               setAttribute("ordertype",ordertype);
               
           } catch (DBException e) {
               //7 �����쳣����
               setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
               setAttribute(Constants.ERROR_MSG, e);
               
               if (log.isError()) {
                   log.logError("��ѯ�����쳣:" + e.getMessage(),e);
               }
               
               retValue = "error1";
               
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
     * @Title: PPFeedbackRecordDetail
     * @Description: ���ú󱨸�鿴��ʡ��������Ժ��
     * @author: xugy
     * @date: 2014-11-5����10:59:38
     * @return
     */
    public String PPFeedbackRecordDetail(){
        String FEEDBACK_ID = getParameter("ids");
        String type = getParameter("type");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            DataList dataList = handler.getFeedbackRecordInfo(conn, FEEDBACK_ID);
            Data data = new Data();
            if(dataList.size()>0){
                data=dataList.getData(0);
            }
            setAttribute("dataList",dataList);
            setAttribute("data",data);
            setAttribute("type",type);
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
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
