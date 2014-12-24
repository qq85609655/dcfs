package com.dcfs.pfr.DAB;

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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.pfr.PPFeebbackAttAction;
import com.dcfs.pfr.PPFeebbackAttHandler;
import com.dcfs.pfr.SYZZ.SYZZPPFeedbackHandler;
import com.dcfs.pfr.feedback.PPFeedbackAction;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
/**
 * 
 * @Title: DABPPFeedbackAction.java
 * @Description: ���������ú󱨸淴��
 * @Company: 21softech
 * @Created on 2014-10-10 ����5:23:34
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class DABPPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(DABPPFeedbackAction.class);
    private Connection conn = null;
    private DABPPFeedbackHandler handler;
    private SYZZPPFeedbackHandler SYZZhandler;
    private PPFeedbackHandler PPhandler;
    private PPFeedbackAction PPAction;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public DABPPFeedbackAction() {
        this.handler=new DABPPFeedbackHandler();
        this.SYZZhandler=new SYZZPPFeedbackHandler();
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
     * @Title: DABPPFeedbackReceiveList
     * @Description: ��������
     * @author: xugy
     * @date: 2014-10-11����1:45:55
     * @return
     */
    public String DABPPFeedbackReceiveList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","NAME_PINYIN","CHILD_NAME_EN","NUM","REPORT_DATE_START","REPORT_DATE_END","RECEIVE_STATE","RECEIVE_USERNAME","RECEIVE_DATE_START","RECEIVE_DATE_END","REPORT_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findDABPPFeedbackReceiveList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: DABSendTranslation
     * @Description: �ͷ�
     * @author: xugy
     * @date: 2014-10-11����3:06:23
     * @return
     */
    public String DABSendTranslation(){
        String ids = getParameter("ids");//
        String[] array = ids.split("#");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String FB_REC_ID = array[i];
                String nowDate = DateUtility.getCurrentDate();
                Data data = new Data();//
                data.add("FB_REC_ID", FB_REC_ID);//
                data.add("REMINDERS_STATE", "");//�߽�״̬
                data.add("RECEIVE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//������ID
                data.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//����������
                data.add("RECEIVE_DATE", nowDate);//��������
                data.add("RECEIVE_STATE", "1");//����״̬
                data.add("REPORT_STATE", "2");//����״̬
                data.add("IS_SF", "1");//�ͷ������ʶ
                PPhandler.savePfrFeedbackRecord(conn, data);
                
                DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//������ϸID
                transferData.add("APP_ID", FB_REC_ID);//ҵ���¼ID
                transferData.add("TRANSFER_CODE", TransferCode.ARCHIVE_DAB_FYGS);//�ƽ�����
                transferData.add("TRANSFER_STATE", "0");//�ƽ�״̬
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);//����һ���ƽ���Ϣ
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ͷ��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ͷ�ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ͷ�ʧ��!");
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
     * �ṩ�ӿ�
     * @Title: createFeedbackTranslation
     * @Description: ���������¼
     * @author: xugy
     * @date: 2014-10-13����1:27:40
     * @param conn
     * @param dl
     * @param FB_REC_ID ҵ������ID
     * @return
     * @throws DBException 
     * @throws Exception
     */
    public String createFeedbackTranslation(Connection conn, DataList dl) throws DBException {
        for(int i=0;i<dl.size();i++){
            String FB_REC_ID = dl.getData(i).getString("FB_REC_ID");
            Data data = PPhandler.getFeedbackTransferInfo(conn, FB_REC_ID);
            Data transData = new Data();
            transData.add("FB_T_ID", "");//���淭���¼ID
            transData.add("FEEDBACK_ID", data.getString("FEEDBACK_ID"));//FEEDBACK_ID
            transData.add("NUM", data.getString("NUM"));//����
            transData.add("FB_REC_ID", FB_REC_ID);//���ú󱨸��¼ID
            transData.add("TRANSLATION_TYPE", "0");//��������
            transData.add("NOTICE_DATE", DateUtility.getCurrentDate());//����֪ͨ����
            transData.add("NOTICE_USERID", data.getString("TRANSFER_USERID"));//����֪ͨ��ID
            transData.add("NOTICE_USERNAME", data.getString("TRANSFER_USERNAME"));//����֪ͨ������
            transData.add("TRANSLATION_STATE", "0");//����״̬
            PPhandler.savePfrFeedbackTranslation(conn, transData);
        }
        return retValue;
    }
    /**
     * 
     * @Title: DABSendAudit
     * @Description: ����
     * @author: xugy
     * @date: 2014-10-11����5:35:01
     * @return
     */
    public String DABSendAudit(){
        String ids = getParameter("ids");//
        String[] array = ids.split("#");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            DataList dl = new DataList();
            for(int i=1;i<array.length;i++){
                String FB_REC_ID = array[i];
                String nowDate = DateUtility.getCurrentDate();
                Data data = new Data();//
                data.add("FB_REC_ID", FB_REC_ID);//
                data.add("REMINDERS_STATE", "");//�߽�״̬
                data.add("RECEIVE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//������ID
                data.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//����������
                data.add("RECEIVE_DATE", nowDate);//��������
                data.add("RECEIVE_STATE", "1");//����״̬
                data.add("ADUIT_STATE", "0");//���״̬
                data.add("REPORT_STATE", "6");//����״̬
                data.add("IS_SF", "2");//�ͷ������ʶ
                PPhandler.savePfrFeedbackRecord(conn, data);
                
                dl.add(data);
            }
            createFeedbackAudit(conn, dl);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "��������ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "��������ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "��������ʧ��!");
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
     * �ṩ�ӿ�
     * @Title: createFeedbackAudit
     * @Description: �������
     * @author: xugy
     * @date: 2014-10-14����11:17:29
     * @param conn
     * @param dl
     * @param FB_REC_ID ҵ������ID
     * @return
     * @throws DBException
     */
    public String createFeedbackAudit(Connection conn, DataList dl) throws DBException {
        for(int i=0;i<dl.size();i++){
            String FB_REC_ID = dl.getData(i).getString("FB_REC_ID");
            Data data = PPhandler.getFeedbackRecordInfo(conn, FB_REC_ID);
            Data auditData = new Data();
            auditData.add("FB_A_ID", "");//���ú󱨸���˼�¼ID
            auditData.add("FB_REC_ID", FB_REC_ID);//���ú󱨸��¼ID
            auditData.add("NUM", data.getString("NUM"));//����
            auditData.add("AUDIT_LEVEL", "0");//��˼���
            auditData.add("OPERATION_STATE", "0");//����״̬
            PPhandler.savePfrFeedbackAudit(conn, auditData);
        }
        return retValue;
    }
    /**
     * 
     * @Title: toDABPPFeedbackReturn
     * @Description: �����˻�
     * @author: xugy
     * @date: 2014-10-15����6:06:31
     * @return
     */
    public String toDABPPFeedbackReturn(){
        String ids = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            
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
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
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
    
    /**
     * 
     * @Title: saveDABPPFeedbackReturn
     * @Description: �˻ر���
     * @author: xugy
     * @date: 2014-10-21����10:51:16
     * @return
     */
    public String saveDABPPFeedbackReturn(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","RETURN_REASON");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("RECEIVE_STATE", "2");//����״̬
            FRdata.add("REPORT_STATE", "9");//����״̬
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����˻سɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����˻�ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����˻�ʧ��!");
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
     * @Title: DABPPFeedbackReplaceList
     * @Description: ��¼�б�
     * @author: xugy
     * @date: 2014-10-14����6:13:07
     * @return
     */
    public String DABPPFeedbackReplaceList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","NAME_PINYIN","CHILD_NAME_EN","NUM","REG_USERNAME","REG_DATE_START","REG_DATE_END","REPORT_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findDABPPFeedbackReplaceList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toDABPPFeedbackReplaceInto
     * @Description: �����¼
     * @author: xugy
     * @date: 2014-10-14����6:47:38
     * @return
     */
    public String toDABPPFeedbackReplaceInto(){
        String ids = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            //���ú󱨸�-һ��
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //���ĸ���ȥ����Ƭ
            DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
            String xmlstrCN1 = bm.getUploadParameter(attTypeCN1);

            //���ú󱨸�-������ͥ
            DataList attType2 = ppfb.attTypeChangeFamily(conn);
            String xmlstr2 = bm.getUploadParameter(attType2);
            
            //���ú󱨸�-����
            DataList attType3 = ppfb.attTypeDead(conn);
            String xmlstr3 = bm.getUploadParameter(attType3);
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            
            setAttribute("uploadParameterCN1",xmlstrCN1);
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
    /**
     * 
     * @Title: DABSaveAndSendTrans
     * @Description: ��¼���沢�ͷ�
     * @author: xugy
     * @date: 2014-10-14����7:08:11
     * @return
     */
    public String DABSaveAndSendTrans(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "1");//��¼��ʶ
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//¼����ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//¼��������
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//¼������
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//�ύ��ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//�ύ������
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//�ϱ�����
            FRdata.add("RECEIVE_USERID", SessionInfo.getCurUser().getPersonId());//������ID
            FRdata.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//����������
            FRdata.add("RECEIVE_DATE", DateUtility.getCurrentDate());//��������
            FRdata.add("RECEIVE_STATE", "1");//����״̬
            FRdata.add("REPORT_STATE", "2");//����״̬
            FRdata.add("IS_SF", "1");//�ͷ������ʶ
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //���������з���            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            DataList transferList = new DataList();
            Data transferData = new Data();
            transferData.add("TID_ID", "");//������ϸID
            transferData.add("APP_ID", FRdata.getString("FB_REC_ID"));//ҵ���¼ID
            transferData.add("TRANSFER_CODE", TransferCode.ARCHIVE_DAB_FYGS);//�ƽ�����
            transferData.add("TRANSFER_STATE", "0");//�ƽ�״̬
            transferList.add(transferData);
            FileCommonManager FC = new FileCommonManager();
            FC.transferDetailInit(conn, transferList);//����һ���ƽ���Ϣ
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ͷ��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ͷ�ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ͷ�ʧ��!");
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
     * @Title: DABSaveAndSendAudit
     * @Description: ��¼���沢����
     * @author: xugy
     * @date: 2014-10-14����8:28:34
     * @return
     */
    public String DABSaveAndSendAudit(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "1");//��¼��ʶ
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//¼����ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//¼��������
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//¼������
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//�ύ��ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//�ύ������
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//�ϱ�����
            FRdata.add("RECEIVE_USERID", SessionInfo.getCurUser().getPersonId());//������ID
            FRdata.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//����������
            FRdata.add("RECEIVE_DATE", DateUtility.getCurrentDate());//��������
            FRdata.add("RECEIVE_STATE", "1");//����״̬
            FRdata.add("ADUIT_STATE", "0");//���״̬
            FRdata.add("REPORT_STATE", "6");//����״̬
            FRdata.add("IS_SF", "2");//�ͷ������ʶ
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //���������з���            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            DataList dl = new DataList();
            dl.add(FRdata);
            createFeedbackAudit(conn, dl);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "��������ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "��������ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "��������ʧ��!");
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
     * @Title: DABPPFeedbackAuditList
     * @Description: ��������б�
     * @author: xugy
     * @date: 2014-10-14����2:46:42
     * @return
     */
    public String DABPPFeedbackAuditList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","NUM","RECEIVE_DATE_START","RECEIVE_DATE_END","AUDIT_USERNAME","AUDIT_DATE_START","AUDIT_DATE_END","ADUIT_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findDABPPFeedbackAuditList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toDABPPFeedbackAudit
     * @Description: �������
     * @author: xugy
     * @date: 2014-10-16����10:21:51
     * @return
     */
    public String toDABPPFeedbackAudit(){
        String ids = getParameter("ids");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackAuditInfo(conn, ids);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
            }
            Data FADDdata = handler.getFeedbackAdditonalInfo(conn, data.getString("FB_REC_ID"));
            if(!FADDdata.isEmpty()){
                data.addData(FADDdata);
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
    /**
     * 
     * @Title: getAllFeedbackDetail
     * @Description: ���α���
     * @author: xugy
     * @date: 2014-11-4����4:36:18
     * @return
     */
    public String getAllFeedbackDetail(){
        String FEEDBACK_ID = getParameter("FEEDBACK_ID");
        
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getFeedbackShowInfo(conn, FEEDBACK_ID);
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
    /**
     * 
     * @Title: getFeedbackRecordDetail
     * @Description: ÿ�α����¼��Ϣ
     * @author: xugy
     * @date: 2014-11-4����5:50:12
     * @return
     */
    public String getFeedbackRecordDetail(){
        String FEEDBACK_ID = getParameter("FEEDBACK_ID");
        String NUM = getParameter("NUM");
        String BIRTHDAY = getParameter("BIRTHDAY");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getFeedbackRecordInfo(conn, FEEDBACK_ID, NUM);
            if(Integer.parseInt(NUM) > 1){
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, Integer.parseInt(NUM));
                data.add("LAST_REPORT_DATE", REPORT_DATE);
            }
            String FB_REC_ID = data.getString("FB_REC_ID");
            String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG","");
            
            PPFeebbackAttAction PPFeebbackAttAction = new PPFeebbackAttAction();
            PPFeebbackAttHandler PPFeebbackAttHandler = new PPFeebbackAttHandler();
            
            //��ȡ��ͬ������ϵ�����ش��ʵĸ���С��
            DataList dl = new DataList();
            if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
                String birthdayYear = BIRTHDAY.substring(0, 4);
                dl = PPFeebbackAttAction.attTypeNormal(conn, birthdayYear, NUM);
            }
            if("2".equals(ACCIDENT_FLAG)){
                dl = PPFeebbackAttAction.attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                dl = PPFeebbackAttAction.attTypeDead(conn);
            }
            
            //ͨ������С���ȡ����ԭ��
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                DataList Attdl = PPFeebbackAttHandler.findPPFdeedbackAtt(conn, FB_REC_ID, CODE);
                dl.getData(i).add("ATTDL", Attdl);
            }
            //�����ó���Ƭ������ҳ����ʾ
            Data photoData = new Data();
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                if((AttConstants.AR_IMAGE).equals(CODE)){
                    photoData = dl.getData(i);
                    dl.remove(photoData);
                }
            }
            //ͨ������С���ȡ��������
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                String F_FB_REC_ID = "F_" + FB_REC_ID;
                DataList AttCNdl = PPFeebbackAttHandler.findPPFdeedbackAtt(conn, F_FB_REC_ID, CODE);
                dl.getData(i).add("ATTCNDL", AttCNdl);
            }
            
            setAttribute("data",data);
            setAttribute("dl",dl);
            setAttribute("photoData",photoData);
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
    
    /**
     * 
     * @Title: submitDABPPFeedbackAudit
     * @Description: ����ύ
     * @author: xugy
     * @date: 2014-10-21����6:18:20
     * @return
     */
    public String submitDABPPFeedbackAudit(){
        Data FAdata = getRequestEntityData("FA_","FB_A_ID","AUDIT_OPTION","AUDIT_CONTENT_CN","AUDIT_CONTENT_EN","AUDIT_REMARKS");//�������
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","IS_PUBLIC","FEELING_CN","FUSION_CN","HEALTHY_CN","EVALUATION_CN","IS_SHOW","IS_SHOW_TRAN");//�����¼����
        Data FIdata = getRequestEntityData("FI_","FEEDBACK_ID");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //������ݱ���
            FAdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPersonId());//�����ID
            FAdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���������
            FAdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//�������
            if("3".equals(FAdata.getString("AUDIT_OPTION"))){//�����ļ�
                FAdata.add("OPERATION_STATE", "1");//����״̬
                
                FRdata.add("ADUIT_STATE", "1");//���״̬
                FRdata.add("REPORT_STATE", "7");//����״̬
                
                Data FADDdata = getRequestEntityData("FADD_","FB_ADD_ID","IS_MODIFY","NOTICE_CONTENT","NUM");//�����ļ�����
                FADDdata.add("FB_REC_ID", FRdata.getString("FB_REC_ID"));//���ú󱨸�ID
                FADDdata.add("UPLOAD_IDS", "S_" + FRdata.getString("FB_REC_ID"));//���丽��
                FADDdata.add("UPLOAD_IDS_CN", "F_S_" + FRdata.getString("FB_REC_ID"));//���丽��_����
                FADDdata.add("SEND_USERID", SessionInfo.getCurUser().getPersonId());//֪ͨ��ID
                FADDdata.add("SEND_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//֪ͨ������
                FADDdata.add("NOTICE_DATE", DateUtility.getCurrentDate());//֪ͨ����
                FADDdata.add("AA_STATUS", "0");//����״̬
                PPhandler.savePfrFeedbackAdditonal(conn, FADDdata);
            }else{
                FAdata.add("OPERATION_STATE", "2");//����״̬
                FRdata.add("ADUIT_STATE", "2");//���״̬
                FRdata.add("REPORT_STATE", "8");//����״̬
            }
            PPhandler.savePfrFeedbackAudit(conn, FAdata);
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            DataList dl = handler.getFeedbackRecordStateInfo(conn, FIdata.getString("FEEDBACK_ID"));
            boolean finish = false;
            if("8".equals(dl.getData(0).getString("REPORT_STATE")) && "8".equals(dl.getData(1).getString("REPORT_STATE")) && "8".equals(dl.getData(2).getString("REPORT_STATE")) && "8".equals(dl.getData(3).getString("REPORT_STATE")) && "8".equals(dl.getData(4).getString("REPORT_STATE")) && "8".equals(dl.getData(5).getString("REPORT_STATE"))){
                finish = true;
            }
            
            if("2".equals(FAdata.getString("AUDIT_OPTION")) || finish){//��������
                String AF_ID = getParameter("AF_AF_ID");
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.DAB_AZH_SHJG_JSGZ);
                data.add("AF_ID", AF_ID);
                data.add("IS_FINISH", "1");//������ʾ
                FileCommonManager AFhandler = new FileCommonManager();
                AFhandler.modifyFileInfo(conn, data);//�޸������˵�ƥ����Ϣ
                
                FIdata.add("IS_FINISH", "1");//������ʾ
                PPhandler.savePfrFeedbackInfo(conn, FIdata);
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "��������ύ�ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "��������ύʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "��������ύʧ��!");
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
     * @Title: saveDABPPFeedbackAudit
     * @Description: ��˱���
     * @author: xugy
     * @date: 2014-11-30����3:43:28
     * @return
     */
    public String saveDABPPFeedbackAudit(){
        Data FAdata = getRequestEntityData("FA_","FB_A_ID","AUDIT_OPTION","AUDIT_CONTENT_CN","AUDIT_CONTENT_EN","AUDIT_REMARKS");//�������
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","IS_PUBLIC","FEELING_CN","FUSION_CN","HEALTHY_CN","EVALUATION_CN","IS_SHOW","IS_SHOW_TRAN");//�����¼����
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //������ݱ���
            FAdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPersonId());//�����ID
            FAdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���������
            FAdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//�������
            
            PPhandler.savePfrFeedbackAudit(conn, FAdata);
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "������˱���ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "������˱���ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "������˱���ʧ��!");
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
     * @Title: toDABPPFeedbackCatalog
     * @Description: ������������������Ŀ¼������
     * @author: xugy
     * @date: 2014-11-4����10:26:14
     * @return
     */
    public String toDABPPFeedbackCatalog(){
        String FEEDBACK_ID = getParameter("ids");//ƥ��������ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ѯ��������Ϣ
            Data data = handler.getDABCatalogInfo(conn, FEEDBACK_ID);
            //�������д��ҳ����ձ���
            setAttribute("data",data);
        }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
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
     * @Title: saveDABPPFeedbackCatalog
     * @Description: ������������������Ŀ¼����������
     * @author: xugy
     * @date: 2014-11-4����10:53:10
     * @return
     */
    public String saveDABPPFeedbackCatalog(){
        Data FIdata = getRequestEntityData("FI_","FEEDBACK_ID","CATALOGUE2_FILE1_NUM","CATALOGUE2_FILE2_NUM","CATALOGUE2_FILE3_NUM","FILING_DATE1","FILING_USERNAME1","CATALOGUE2_FILE4_NUM","CATALOGUE2_FILE5_NUM","CATALOGUE2_FILE6_NUM","FILING_DATE2","FILING_USERNAME2","CATALOGUE2_FILE7_NUM","CATALOGUE2_FILE8_NUM","CATALOGUE2_FILE9_NUM","CATALOGUE2_FILE10_NUM","FILING_DATE3","FILING_USERNAME3","CATALOGUE2_FILE11_NUM","CATALOGUE2_FILE12_NUM","CATALOGUE2_FILE13_NUM","FILING_DATE4","FILING_USERNAME4","CATALOGUE2_FILE14_NUM","CATALOGUE2_FILE15_NUM","CATALOGUE2_FILE16_NUM","FILING_DATE5","FILING_USERNAME5","CATALOGUE2_FILE17_NUM","CATALOGUE2_FILE18_NUM","FILING_DATE6","FILING_USERNAME6");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            PPhandler.savePfrFeedbackInfo(conn, FIdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "Ŀ¼����������ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "Ŀ¼����������ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "Ŀ¼����������ʧ��!");
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
     * @Title: DABPPFeedbackReminderList
     * @Description: ����߽�
     * @author: xugy
     * @date: 2014-10-23����4:17:19
     * @return
     */
    public String DABPPFeedbackReminderList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_CN","NAME","NUM","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","LIMIT_DATE_START","LIMIT_DATE_END","REMINDERS_DATE_START","REMINDERS_DATE_END");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findDABPPFeedbackReminderList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: DABPPFeedbackReminderDetail
     * @Description: ���ú�������߽�
     * @author: xugy
     * @date: 2014-12-5����11:23:40
     * @return
     */
    public String DABPPFeedbackReminderDetail(){
        String FB_REC_ID = getParameter("ids");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = handler.getFeedbackReminderInfo(conn, FB_REC_ID);
            
            String REMINDERS_DATE = data.getDate("REMINDERS_DATE");//�߽�����
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(REMINDERS_DATE);
            SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy��MM��dd��");
            String REMINDERS_DATE_CN = sdfCN.format(date);
            data.add("REMINDERS_DATE_CN", REMINDERS_DATE_CN);
            
            SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
            String REMINDERS_DATE_EN = sdfEN.format(date);
            data.add("REMINDERS_DATE_EN", REMINDERS_DATE_EN);
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
    
    /**
     * 
     * @Title: DABPPFeedbackSearchList
     * @Description: ���������ú󱨸淴����ѯ�б�
     * @author: xugy
     * @date: 2014-10-10����5:25:41
     * @return
     */
    public String DABPPFeedbackSearchList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","SIGN_NO","SIGN_DATE_START","SIGN_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","CHILD_NAME_EN","SEX","CHILD_TYPE","BIRTHDAY_START","BIRTHDAY_END");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findDABPPFeedbackSearchList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: DABPPFeedbackSearchDetail
     * @Description: �������鿴���ú�������
     * @author: xugy
     * @date: 2014-12-1����4:21:30
     * @return
     */
    public String DABPPFeedbackSearchDetail(){
        String FEEDBACK_ID = getParameter("ids");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            DataList dataList = handler.getFeedbackInfo(conn, FEEDBACK_ID);
            Data data = new Data();
            if(dataList.size()>0){
                data=dataList.getData(0);
            }
            setAttribute("dataList",dataList);
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
