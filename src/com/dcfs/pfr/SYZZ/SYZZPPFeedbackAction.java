package com.dcfs.pfr.SYZZ;

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
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.pfr.PPFeebbackAttAction;
import com.dcfs.pfr.DAB.DABPPFeedbackHandler;
import com.dcfs.pfr.feedback.PPFeedbackAction;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
/**
 * 
 * @Title: SYZZPPFeedbackAction.java
 * @Description: ������֯���ú󱨸淴��
 * @Company: 21softech
 * @Created on 2014-10-9 ����5:13:37
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SYZZPPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(SYZZPPFeedbackAction.class);
    private Connection conn = null;
    private SYZZPPFeedbackHandler handler;
    private DABPPFeedbackHandler DABhandler;
    private PPFeedbackHandler PPhandler;
    private PPFeedbackAction PPAction;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public SYZZPPFeedbackAction() {
        this.handler=new SYZZPPFeedbackHandler();
        this.DABhandler=new DABPPFeedbackHandler();
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
     * @Title: SYZZPPFeedbackList
     * @Description: ������֯���ú󱨸淴���б�
     * @author: xugy
     * @date: 2014-10-9����5:25:56
     * @return
     */
    public String SYZZPPFeedbackList(){
     // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NUM";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="ASC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","FILE_NO","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","NUM","REPORT_DATE_START","REPORT_DATE_END","REPORT_STATE","REMINDERS_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSYZZPPFeedbackList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toSYZZPPFeedbackAdd
     * @Description: ������֯���ú󱨸淴��¼��
     * @author: xugy
     * @date: 2014-10-10����2:04:31
     * @return
     */
    public String toSYZZPPFeedbackInto(){
        String ids = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String SIGN_DATE = (String)data.getDate("SIGN_DATE");
            Date signDate = sdf.parse(SIGN_DATE);
            String d = "2013-01-01";
            Date date = sdf.parse(d);
            boolean flag = signDate.before(date);
            String isCN = "";
            if(flag){
                isCN = "1";
            }else{
                isCN = "0";
            }
            
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            //���ú󱨸�-һ��
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //���ĸ���ȥ����Ƭ
            if(flag){
                DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN1 = bm.getUploadParameter(attTypeCN1);
                setAttribute("uploadParameterCN1",xmlstrCN1);
            }
            
            
            //���ú󱨸�-������ͥ
            DataList attType2 = ppfb.attTypeChangeFamily(conn);
            String xmlstr2 = bm.getUploadParameter(attType2);
            
            //���ú󱨸�-����
            DataList attType3 = ppfb.attTypeDead(conn);
            String xmlstr3 = bm.getUploadParameter(attType3);
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("isCN",isCN);
            
            setAttribute("uploadParameter1",xmlstr1);
            setAttribute("uploadParameter2",xmlstr2);
            setAttribute("uploadParameter3",xmlstr3);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (ParseException e) {
            e.printStackTrace();
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
     * @Title: saveSYZZPPFeedbackInto
     * @Description: ¼�뱣��
     * @author: xugy
     * @date: 2014-10-11����10:48:37
     * @return
     */
    public String saveSYZZPPFeedbackInto(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "0");//��¼��ʶ
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//¼����ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//¼��������
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//¼������
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //���������з���            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���淴������ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淴������ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淴������ʧ��!");
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
     * @Title: submitSYZZPPFeedbackInto
     * @Description: ¼���ύ
     * @author: xugy
     * @date: 2014-10-11����10:59:19
     * @return
     */
    public String submitSYZZPPFeedbackInto(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "0");//��¼��ʶ
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//¼����ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//¼��������
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//¼������
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//�ύ��ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//�ύ������
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//�ϱ�����
            FRdata.add("RECEIVE_STATE", "0");//����״̬
            FRdata.add("REPORT_STATE", "1");//����״̬
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //���������з���            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���淴���ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淴���ύʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淴���ύʧ��!");
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
     * @Title: listSubmitSYZZPPFeedback
     * @Description: �б��ύ
     * @author: xugy
     * @date: 2014-10-15����3:22:22
     * @return
     */
    public String listSubmitSYZZPPFeedback(){
        String ids = getParameter("ids");
        Data FRdata = new Data();
        FRdata.add("FB_REC_ID", ids);
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//�ύ��ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//�ύ������
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//�ϱ�����
            FRdata.add("RECEIVE_STATE", "0");//����״̬
            FRdata.add("REPORT_STATE", "1");//����״̬
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���淴���ύ�ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淴���ύʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淴���ύʧ��!");
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
     * @Title: PPFeedbackHomePage
     * @Description: ���ú󱨸���ҳ
     * @author: xugy
     * @date: 2014-11-5����1:36:34
     * @return
     */
    public String PPFeedbackHomePage(){
        String FB_REC_ID = getParameter("FB_REC_ID");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackHomePageInfo(conn, FB_REC_ID);
            
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
    
    /**
     * 
     * @Title: SYZZPPFeedbackDetail
     * @Description: ��������鿴
     * @author: xugy
     * @date: 2014-12-4����6:29:51
     * @return
     */
    public String SYZZPPFeedbackDetail(){
        String ids = getParameter("ids");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
            }
            
            String SIGN_DATE = (String)data.getDate("SIGN_DATE");
            String d = "2013-01-01";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date signDate = sdf.parse(SIGN_DATE);
            Date date = sdf.parse(d);
            boolean flag = signDate.before(date);
            String isCN = "";
            if(flag){
                isCN = "1";
            }else{
                String IS_SHOW_TRAN = data.getString("IS_SHOW_TRAN", "");
                if("1".equals(IS_SHOW_TRAN)){
                    isCN = "1";
                }
                if("0".equals(IS_SHOW_TRAN)){
                    isCN = "0";
                }
            }
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            
            String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG");
            DataList attType = new DataList();
            if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
                //���ú󱨸�-һ��
                String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
                String NUM = data.getString("NUM");
                attType = ppfb.attTypeNormal(conn, birthdayYear, NUM);
                
                //���ĸ���ȥ����Ƭ
                DataList attTypeCN = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN = bm.getUploadParameter(attTypeCN);
                setAttribute("uploadParameterCN",xmlstrCN);
            }
            if("2".equals(ACCIDENT_FLAG)){
                //���ú󱨸�-������ͥ
                attType = ppfb.attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                //���ú󱨸�-����
                attType = ppfb.attTypeDead(conn);
            }
            String xmlstr = bm.getUploadParameter(attType);
            
            String FB_ADD_ID = data.getString("FB_ADD_ID");
            if("".equals(data.getString("UPLOAD_IDS",""))){
                data.put("UPLOAD_IDS", FB_ADD_ID);
            }
            if("".equals(data.getString("UPLOAD_IDS_CN",""))){
                data.put("UPLOAD_IDS_CN", "F_" + FB_ADD_ID);
            }
            
            
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("isCN",isCN);
            
            setAttribute("uploadParameter",xmlstr);
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
     * @Title: SYZZPPFeedbackAdditonalList
     * @Description: ���油���б�
     * @author: xugy
     * @date: 2014-10-21����8:38:30
     * @return
     */
    public String SYZZPPFeedbackAdditonalList(){
     // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="ASC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","FILE_NO","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","NUM","NOTICE_DATE_START","NOTICE_DATE_END","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSYZZPPFeedbackAdditonalList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toSYZZPPFeedbackAdditonal
     * @Description: ���油��
     * @author: xugy
     * @date: 2014-10-22����3:21:53
     * @return
     */
    public String toSYZZPPFeedbackAdditonal(){
        String ids = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackAdditonalInfo(conn, ids);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
            }
            
            String SIGN_DATE = (String)data.getDate("SIGN_DATE");
            String d = "2013-01-01";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date signDate = sdf.parse(SIGN_DATE);
            Date date = sdf.parse(d);
            boolean flag = signDate.before(date);
            String isCN = "";
            if(flag){
                isCN = "1";
            }else{
                String IS_SHOW_TRAN = data.getString("IS_SHOW_TRAN", "");
                if("1".equals(IS_SHOW_TRAN)){
                    isCN = "1";
                }
                if("0".equals(IS_SHOW_TRAN)){
                    isCN = "0";
                }
            }
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            
            String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG");
            DataList attType = new DataList();
            if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
                //���ú󱨸�-һ��
                String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
                String NUM = data.getString("NUM");
                attType = ppfb.attTypeNormal(conn, birthdayYear, NUM);
                
                //���ĸ���ȥ����Ƭ
                DataList attTypeCN = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN = bm.getUploadParameter(attTypeCN);
                setAttribute("uploadParameterCN",xmlstrCN);
            }
            if("2".equals(ACCIDENT_FLAG)){
                //���ú󱨸�-������ͥ
                attType = ppfb.attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                //���ú󱨸�-����
                attType = ppfb.attTypeDead(conn);
            }
            String xmlstr = bm.getUploadParameter(attType);
            
            String FB_ADD_ID = data.getString("FB_ADD_ID");
            if("".equals(data.getString("UPLOAD_IDS",""))){
                data.put("UPLOAD_IDS", FB_ADD_ID);
            }
            if("".equals(data.getString("UPLOAD_IDS_CN",""))){
                data.put("UPLOAD_IDS_CN", "F_" + FB_ADD_ID);
            }
            
            
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("isCN",isCN);
            
            setAttribute("uploadParameter",xmlstr);
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
     * @Title: saveSYZZPPFeedbackAdditonal
     * @Description: ���䱣��
     * @author: xugy
     * @date: 2014-10-22����6:08:53
     * @return
     */
    public String saveSYZZPPFeedbackAdditonal(){
        Data FADDdata = getRequestEntityData("FADD_","FB_ADD_ID","UPLOAD_IDS","UPLOAD_IDS_CN","ADD_CONTENT_EN");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FADDdata.add("AA_STATUS", "1");//����״̬
            AttHelper.publishAttsOfPackageId(FADDdata.getString("UPLOAD_IDS"), "AR");
            AttHelper.publishAttsOfPackageId(FADDdata.getString("UPLOAD_IDS_CN"), "AR");
            PPhandler.savePfrFeedbackAdditonal(conn, FADDdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���油�䱣��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���油�䱣��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���油�䱣��ʧ��!");
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
     * @Title: submitSYZZPPFeedbackAdditonal
     * @Description: �����ύ
     * @author: xugy
     * @date: 2014-10-22����6:09:23
     * @return
     */
    public String submitSYZZPPFeedbackAdditonal(){
        Data FADDdata = getRequestEntityData("FADD_","FB_ADD_ID","ADD_CONTENT_EN");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FADDdata.add("FEEDBACK_ORGID", SessionInfo.getCurUser().getCurOrgan().getId());//��������֯ID
            FADDdata.add("FEEDBACK_USERID", SessionInfo.getCurUser().getPersonId());//������ID
            FADDdata.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//����������
            FADDdata.add("FEEDBACK_DATE", DateUtility.getCurrentDate());//��������
            FADDdata.add("AA_STATUS", "2");//����״̬
            PPhandler.savePfrFeedbackAdditonal(conn, FADDdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���油���ύ�ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���油���ύʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���油���ύʧ��!");
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
     * @Title: toSYZZPPFeedbackAdditonalMod
     * @Description: ���油���޸�
     * @author: xugy
     * @date: 2014-10-24����11:30:45
     * @return
     */
    public String toSYZZPPFeedbackAdditonalMod(){
        String FB_REC_ID = getParameter("FB_REC_ID");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackInfo(conn, FB_REC_ID);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
            }
            
            String SIGN_DATE = (String)data.getDate("SIGN_DATE");
            String d = "2013-01-01";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date signDate = sdf.parse(SIGN_DATE);
            Date date = sdf.parse(d);
            boolean flag = signDate.before(date);
            String isCN = "";
            if(flag){
                isCN = "1";
            }else{
                isCN = "0";
            }
            
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            //���ú󱨸�-һ��
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //���ĸ���ȥ����Ƭ
            if(flag){
                DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN1 = bm.getUploadParameter(attTypeCN1);
                setAttribute("uploadParameterCN1",xmlstrCN1);
            }
            
            
            //���ú󱨸�-������ͥ
            DataList attType2 = ppfb.attTypeChangeFamily(conn);
            String xmlstr2 = bm.getUploadParameter(attType2);
            
            //���ú󱨸�-����
            DataList attType3 = ppfb.attTypeDead(conn);
            String xmlstr3 = bm.getUploadParameter(attType3);
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("isCN",isCN);
            
            setAttribute("uploadParameter1",xmlstr1);
            setAttribute("uploadParameter2",xmlstr2);
            setAttribute("uploadParameter3",xmlstr3);
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
     * @Title: saveSYZZPPFeedbackAdditonalMod
     * @Description: ���汨���޸�
     * @author: xugy
     * @date: 2014-10-24����3:37:54
     * @return
     */
    public void saveSYZZPPFeedbackAdditonalMod(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC","FEELING_CN","FUSION_CN","HEALTHY_CN","EVALUATION_CN");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //���������з���            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���油�䱣��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���油�䱣��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���油�䱣��ʧ��!");
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
    }
    /**
     * 
     * @Title: SYZZPPFeedbackReminderList
     * @Description: ����߽��б�
     * @author: xugy
     * @date: 2014-10-23����3:01:58
     * @return
     */
    public String SYZZPPFeedbackReminderList(){
     // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NUM";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="ASC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","FILE_NO","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_EN","NAME_PINYIN","NUM","LIMIT_DATE_START","LIMIT_DATE_END","REMINDERS_DATE_START","REMINDERS_DATE_END");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSYZZPPFeedbackReminderList(conn,data,pageSize,page,compositor,ordertype);
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