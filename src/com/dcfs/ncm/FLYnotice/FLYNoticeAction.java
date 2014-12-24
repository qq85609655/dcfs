package com.dcfs.ncm.FLYnotice;

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
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @Title: FLYNoticeAction.java
 * @Description: ����Ժ����֪ͨ��
 * @Company: 21softech
 * @Created on 2014-11-8 ����5:23:28
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FLYNoticeAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(FLYNoticeAction.class);
    private Connection conn = null;
    private FLYNoticeHandler handler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public FLYNoticeAction() {
        this.handler=new FLYNoticeHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    
    /**
     * 
     * @Title: FLYNoticeList
     * @Description: ����Ժ����֪ͨ���б�
     * @author: xugy
     * @date: 2014-11-8����5:23:35
     * @return
     */
    public String FLYNoticeList(){
     // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("N_","SIGN_NO","SIGN_DATE_START","SIGN_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","CHILD_TYPE","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END");
        String WELFARE_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode(); //��������ID
        //WELFARE_ID="11010611";
        try {
            //����ԺID
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findFLYNoticeList(conn,WELFARE_ID,data,pageSize,page,compositor,ordertype);
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

}
