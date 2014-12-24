package com.dcfs.far.appointment;

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
import java.util.List;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;
/**
 * 
 * @Title: AppointmentAction.java
 * @Description: ��������ԤԼ
 * @Company: 21softech
 * @Created on 2014-9-29 ����5:28:09
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AppointmentAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AppointmentAction.class);
    private Connection conn = null;
    private AppointmentHandler handler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public AppointmentAction() {
        this.handler=new AppointmentHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: appointmentRecordList
     * @Description: ������֯ԤԼ�б�
     * @author: xugy
     * @date: 2014-9-29����5:33:30
     * @return
     */
    public String SYZZAppointmentRecordList(){
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
        Data data = getRequestEntityData("S_","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","ORDER_DATE_START","ORDER_DATE_END","SUGGEST_DATE_START","SUGGEST_DATE_END","ORDER_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSYZZAppointmentRecordList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: SYZZAppointmentSelectList
     * @Description: ������֯ԤԼѡ���б�
     * @author: xugy
     * @date: 2014-9-29����8:51:59
     * @return
     */
    public String SYZZAppointmentSelectList(){
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
        Data data = getRequestEntityData("S_","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_DATE_START","SIGN_DATE_END");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSYZZAppointmentSelectList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toSYZZAppointmentAdd
     * @Description: ������֯ԤԼ�������
     * @author: xugy
     * @date: 2014-9-30����11:07:30
     * @return
     */
    public String toSYZZAppointmentAdd(){
        String id = getParameter("id");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getAppointmentShowInfo(conn, id);
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            
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
     * @Title: SYZZAppointmentSave
     * @Description: ԤԼ���뱣��
     * @author: xugy
     * @date: 2014-9-30����2:11:42
     * @return
     */
    public String SYZZAppointmentSave(){
        Data data = getRequestEntityData("AR_","AR_ID","MI_ID","ORDER_DATE","ORDER_PHONE","ORDER_TEL","REMARKS");
        String ORDER_STATE = getParameter("ORDER_STATE");
        data.add("ORDER_STATE", ORDER_STATE);
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            String ORDER_DATE = data.getString("ORDER_DATE");
            data.put("ORDER_DATE", ORDER_DATE + ":00");
            
            data.add("ORDER_USERID", SessionInfo.getCurUser().getPersonId());
            data.add("ORDER_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            data.add("ORDER_DATE1", DateUtility.getCurrentDate());
            
            Data appData = handler.getAppointmentShowInfo(conn, data.getString("MI_ID"));
            appData.remove("MI_ID");
            data.addData(appData);
            
            handler.SYZZAppointmentSave(conn, data);
            
            dt.commit();
            if("0".equals(ORDER_STATE)){
                InfoClueTo clueTo = new InfoClueTo(0, "ԤԼ���뱣��ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }else{
                InfoClueTo clueTo = new InfoClueTo(0, "ԤԼ�����ύ�ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }
        }catch (DBException e) {
            //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //�������ҳ����ʾ
            if("0".equals(ORDER_STATE)){
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ���뱣��ʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }else{
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ�����ύʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            if("0".equals(ORDER_STATE)){
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ���뱣��ʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }else{
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ�����ύʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }
            retValue = "error2";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: toSYZZAppointmentMod
     * @Description: ԤԼ�����޸�
     * @author: xugy
     * @date: 2014-9-30����3:08:59
     * @return
     */
    public String toSYZZAppointmentMod(){
        String AR_ID = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getAppointmentInfo(conn, AR_ID);
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            
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
     * @Title: saveSYZZAppointmentMod
     * @Description: ԤԼ�����޸ı���
     * @author: xugy
     * @date: 2014-10-1����10:57:07
     * @return
     */
    public String saveSYZZAppointmentMod(){
        Data data = getRequestEntityData("AR_","AR_ID","ORDER_DATE","ORDER_PHONE","ORDER_TEL","REMARKS");
        String ORDER_STATE = getParameter("ORDER_STATE");
        data.add("ORDER_STATE", ORDER_STATE);
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            String ORDER_DATE = data.getString("ORDER_DATE");
            data.put("ORDER_DATE", ORDER_DATE + ":00");
            
            data.add("ORDER_USERID", SessionInfo.getCurUser().getPersonId());
            data.add("ORDER_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            data.add("ORDER_DATE1", DateUtility.getCurrentDate());
            
            handler.SYZZAppointmentSave(conn, data);
            
            dt.commit();
            if("0".equals(ORDER_STATE)){
                InfoClueTo clueTo = new InfoClueTo(0, "ԤԼ���뱣��ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }else{
                InfoClueTo clueTo = new InfoClueTo(0, "ԤԼ�����ύ�ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }
        }catch (DBException e) {
            //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //�������ҳ����ʾ
            if("0".equals(ORDER_STATE)){
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ���뱣��ʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }else{
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ�����ύʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            if("0".equals(ORDER_STATE)){
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ���뱣��ʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }else{
                InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ�����ύʧ��!");//����ʧ�� 2
                setAttribute("clueTo", clueTo);
            }
            retValue = "error2";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    
    
    
    
    
    /**
     * 
     * @Title: STAppointmentAcceptList
     * @Description: ʡ��ԤԼ����
     * @author: xugy
     * @date: 2014-10-2����2:58:51
     * @return
     */
    public String STAppointmentAcceptList(){
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
        Data data = getRequestEntityData("S_","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","WELFARE_NAME_CN","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","ORDER_DATE_START","ORDER_DATE_END","SUGGEST_DATE_START","SUGGEST_DATE_END","ORDER_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSTAppointmentAcceptList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toSTAppointmentAcceptAdd
     * @Description: ʡ��ԤԼ����
     * @author: xugy
     * @date: 2014-10-2����4:14:31
     * @return
     */
    public String toSTAppointmentAcceptAdd(){
        String AR_ID = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getAppointmentInfo(conn, AR_ID);
            
            data.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            
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
     * @Title: saveSTAppointmentAcceptAdd
     * @Description: ʡ��ԤԼ������
     * @author: xugy
     * @date: 2014-10-2����4:17:38
     * @return
     */
    public String saveSTAppointmentAcceptAdd(){
        Data data = getRequestEntityData("AR_","AR_ID","SUGGEST_DATE","ORDER_STATE","REMARKS1");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String SUGGEST_DATE = data.getString("SUGGEST_DATE","");
            if(!"".equals(SUGGEST_DATE)){
                data.put("SUGGEST_DATE", SUGGEST_DATE + ":00");
            }
            
            data.add("FEEDBACK_USERID", SessionInfo.getCurUser().getPersonId());
            data.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());
            
            handler.SYZZAppointmentSave(conn, data);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "ԤԼ�����ύ�ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //�������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ�����ύʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ԤԼ�����ύʧ��!");
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: STAppointmentAcceptDetail
     * @Description: ʡ��ԤԼ����鿴
     * @author: xugy
     * @date: 2014-10-2����4:28:23
     * @return
     */
    public String STAppointmentAcceptDetail(){
        String AR_ID = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getAppointmentInfo(conn, AR_ID);
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            
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
     * @Title: FLYApppointmentList
     * @Description: ����Ժ����ԤԼ�б�
     * @author: xugy
     * @date: 2014-10-9����9:28:00
     * @return
     */
    public String FLYApppointmentList(){
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
        Data data = getRequestEntityData("S_","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","ORDER_DATE_START","ORDER_DATE_END");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findFLYApppointmentList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: FLYAppointmentDetail
     * @Description: ����ԺԤԼ�鿴
     * @author: xugy
     * @date: 2014-10-9����10:00:09
     * @return
     */
    public String FLYAppointmentDetail(){
        String AR_ID = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getAppointmentInfo(conn, AR_ID);
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            
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
     * @Title: toApplicationPrint
     * @Description: �������ӡ
     * @author: xugy
     * @date: 2014-11-13����5:35:13
     * @return
     */
    public String toApplicationPrint(){
        String MI_ID = getParameter("MI_ID");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            
            List<Att> list = AttHelper.findAttListByPackageId(MI_ID, AttConstants.SYDJSQS, "AF");
            
            //�������д��ҳ����ձ���
            setAttribute("list",list); 
            setAttribute("MI_ID",MI_ID);
            
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
