package com.dcfs.pfr.AZQ;

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
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.pfr.PPFeebbackAttAction;
import com.dcfs.pfr.DAB.DABPPFeedbackHandler;
import com.dcfs.pfr.SYZZ.SYZZPPFeedbackHandler;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
/**
 * 
 * @Title: AZQPPFeedbackAction.java
 * @Description: ��֮�ű��淭��
 * @Company: 21softech
 * @Created on 2014-10-13 ����5:07:51
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AZQPPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AZQPPFeedbackAction.class);
    private Connection conn = null;
    private AZQPPFeedbackHandler handler;
    private SYZZPPFeedbackHandler SYZZhandler;
    private DABPPFeedbackHandler DABhandler;
    private PPFeedbackHandler PPhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public AZQPPFeedbackAction() {
        this.handler=new AZQPPFeedbackHandler();
        this.SYZZhandler=new SYZZPPFeedbackHandler();
        this.DABhandler=new DABPPFeedbackHandler();
        this.PPhandler=new PPFeedbackHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: AZQPPFeedbackTransList
     * @Description: ��֮�ŷ����б�
     * @author: xugy
     * @date: 2014-10-13����5:09:53
     * @return
     */
    public String AZQPPFeedbackTransList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","NAME","SIGN_DATE_START","SIGN_DATE_END","REPORT_DATE_START","REPORT_DATE_END","RECEIVER_DATE_START","RECEIVER_DATE_END","DISTRIB_DATE_START","DISTRIB_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END","TRANSLATION_UNITNAME","TRANSLATION_STATE","NUM");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAZQPPFeedbackTransList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: dispatch
     * @Description: ����ַ�
     * @author: xugy
     * @date: 2014-10-23����6:03:34
     * @return
     */
    public String dispatch(){
        String ids = getParameter("ids");
        String[] array = ids.split("#");
        //���뵥λID
        String strTranslationUnit = getParameter("TRANSLATION_UNIT");
        //���뵥λ����
        String strTranslationUnitName = getParameter("TRANSLATION_UNITNAME");   
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String FB_T_ID = array[i];
                String FB_REC_ID = handler.getFBREDID(conn, FB_T_ID);
                Data FTdata = new Data();
                FTdata.add("FB_T_ID", FB_T_ID);
                FTdata.add("DISTRIB_USERID", SessionInfo.getCurUser().getPersonId());//����ַ���ID2
                FTdata.add("DISTRIB_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//����ַ�������
                FTdata.add("DISTRIB_DATE", DateUtility.getCurrentDate());//����ַ�����
                FTdata.add("TRANSLATION_UNIT", strTranslationUnit);//���뵥λID
                FTdata.add("TRANSLATION_UNITNAME", strTranslationUnitName);//���뵥λ����
                PPhandler.savePfrFeedbackTranslation(conn, FTdata);
                
                Data FRdata = new Data();
                FRdata.add("FB_REC_ID", FB_REC_ID);
                FRdata.add("TRANSLATION_COMPANY", strTranslationUnitName);//���淭�뵥λ
                PPhandler.savePfrFeedbackRecord(conn, FRdata);
            }
            
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���淭��ַ��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淭��ַ�ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淭��ַ�ʧ��!");
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
     * @Title: toAZQPPFeedbackTranslation
     * @Description: ��֮�ŷ���
     * @author: xugy
     * @date: 2014-10-14����9:49:58
     * @return
     */
    public String toAZQPPFeedbackTranslation(){
        String ids = getParameter("ids");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackTranslationInfo(conn, ids);
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            //���ú󱨸�-һ��
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //���ĸ���ȥ����Ƭ
            DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);
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
     * @Title: saveAZQPPFeedbackTranslation
     * @Description: ���뱣��
     * @author: xugy
     * @date: 2014-10-14����10:18:39
     * @return
     */
    public String saveAZQPPFeedbackTranslation(){
        
        Data FTdata = getRequestEntityData("FT_","FB_T_ID","TRANSLATION_DESC");
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("TRANSLATION_COMPANY", SessionInfo.getCurUser().getCurOrgan().getCName());//���淭�뵥λ
            FRdata.add("TRANSLATION_STATE", "1");//����״̬
            FRdata.add("REPORT_STATE", "4");//����״̬
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            FTdata.add("TRANSLATION_UNIT", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//���뵥λID
            FTdata.add("TRANSLATION_UNITNAME", SessionInfo.getCurUser().getCurOrgan().getCName());//���뵥λ����
            FTdata.add("TRANSLATION_STATE", "1");//����״̬
            PPhandler.savePfrFeedbackTranslation(conn, FTdata);
            
            //���������з���            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���淭�뱣��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淭�뱣��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淭�뱣��ʧ��!");
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
     * @Title: submitAZQPPFeedbackTranslation
     * @Description: �����ύ
     * @author: xugy
     * @date: 2014-10-14����10:30:02
     * @return
     */
    public String submitAZQPPFeedbackTranslation(){
        
        Data FTdata = getRequestEntityData("FT_","FB_T_ID","TRANSLATION_DESC");
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("TRANSLATION_COMPANY", SessionInfo.getCurUser().getCurOrgan().getCName());//���淭�뵥λ
            FRdata.add("TRANSLATION_DATE", DateUtility.getCurrentDate());//��������
            FRdata.add("TRANSLATION_STATE", "2");//����״̬
            FRdata.add("REPORT_STATE", "5");//����״̬
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //���������з���            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            FTdata.add("COMPLETE_DATE", DateUtility.getCurrentDate());//�����������
            FTdata.add("TRANSLATION_UNIT", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//���뵥λID
            FTdata.add("TRANSLATION_UNITNAME", SessionInfo.getCurUser().getCurOrgan().getCName());//���뵥λ����
            FTdata.add("TRANSLATION_USERID", SessionInfo.getCurUser().getPersonId());//������ID
            FTdata.add("TRANSLATION_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//����������
            FTdata.add("TRANSLATION_STATE", "2");//����״̬
            PPhandler.savePfrFeedbackTranslation(conn, FTdata);
            
            DataList transferList = new DataList();
            Data transferData = new Data();
            transferData.add("TID_ID", "");//������ϸID
            transferData.add("APP_ID", FRdata.getString("FB_REC_ID"));//ҵ���¼ID
            transferData.add("TRANSFER_CODE", TransferCode.ARCHIVE_FYGS_DAB);//�ƽ�����
            transferData.add("TRANSFER_STATE", "0");//�ƽ�״̬
            transferList.add(transferData);
            FileCommonManager FC = new FileCommonManager();
            FC.transferDetailInit(conn, transferList);//����һ���ƽ���Ϣ
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���淭���ύ�ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淭���ύʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���淭���ύʧ��!");
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
     * @Title: AZQPPFeedbackTranslationDetail
     * @Description: ����鿴
     * @author: xugy
     * @date: 2014-10-15����8:24:55
     * @return
     */
    public String AZQPPFeedbackTranslationDetail(){
        String ids = getParameter("ids");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����Data
            Data data = PPhandler.getFeedbackTranslationInfo(conn, ids);
            
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
