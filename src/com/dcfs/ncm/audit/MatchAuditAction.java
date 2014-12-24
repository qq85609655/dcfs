package com.dcfs.ncm.audit;

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

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.far.adoptionRegis.AdoptionRegisHandler;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.transferManager.TransferManagerHandler;
import com.dcfs.ncm.MatchAction;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.AZBadvice.AZBAdviceHandler;
import com.dcfs.rfm.insteadRecord.InsteadRecordHandler;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;

/**
 * 
 * @Title: MatchAuditAction.java
 * @Description: ƥ�����
 * @Company: 21softech
 * @Created on 2014-9-6 ����3:38:05
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MatchAuditAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(MatchAuditAction.class);
    private Connection conn = null;
    private MatchAuditHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public MatchAuditAction() {
        this.handler=new MatchAuditHandler();
        this.Mhandler=new MatchHandler();
        this.AFhandler=new FileCommonManager();
        this.CIhandler=new ChildManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        return null;
    }
    
    /**
     * 
     * @Title: matchAuditList
     * @Description: ����б�
     * @author: xugy
     * @date: 2014-9-6����4:57:02
     * @return
     */
    public String matchAuditList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_TYPE","MATCH_NUM","CHILD_TYPE","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","OPERATION_STATE","MATCH_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findMatchAuditList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toMatchAuditAdd
     * @Description: ���ҳ��
     * @author: xugy
     * @date: 2014-9-9����3:09:51
     * @return
     */
    public String toMatchAuditAdd(){
        String ids = getParameter("ids");//ƥ�����ID��ƥ����ϢID���������ļ�ID����ͯ����ID
        String MAU_ID = ids.split(",")[0];//ƥ�����ID
        //String MI_ID = ids.split(",")[1];//ƥ����ϢID
        String AF_ID = ids.split(",")[2];//�������ļ�ID
        String CI_ID = ids.split(",")[3];//��ͯ����ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            //�����Ϣ
            String AUDIT_LEVEL = "0";//���������
            Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);//���������
            data.addData(MAUdata);
            data.add("AUDIT_DATE", DateUtility.getCurrentDate());//�������
            data.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���������
            //����������ƥ����Ϣ
            DataList allAFMatchdl = handler.getAllAFMatchInfo(conn, AF_ID);
            //��ͯ����ƥ����Ϣ
            DataList allCIMatchdl = handler.getAllCIMatchInfo(conn, CI_ID);
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("allAFMatchdl",allAFMatchdl);
            setAttribute("allCIMatchdl",allCIMatchdl);
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
     * @Title: getTendingAndOpinion
     * @Description: ����ĸ����ƻ�����֯���
     * @author: xugy
     * @date: 2014-10-31����1:37:11
     * @return
     */
    public String getTendingAndOpinion(){
        String MAIN_CI_ID = getParameter("MAIN_CI_ID");//��ͯ��ID
        String CI_ID = getParameter("CI_ID");//��ͯID
        String FLAG = getParameter("FLAG");//��ͯID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            
            Data data = handler.getTendingAndOpinion(conn, MAIN_CI_ID, CI_ID);
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("FLAG",FLAG);
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
     * @Title: auditSubmit
     * @Description: ����ϱ�
     * @author: xugy
     * @date: 2014-9-9����3:15:13
     * @return
     */
    public String auditSubmit(){
        //��˽��������������ע
        Data MAUdata = getRequestEntityData("MAU_","MAU_ID","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");
        String MI_ID = getParameter("MI_MI_ID");//ƥ����ϢID
        String CI_ID = getParameter("CI_CI_ID");//��ͯ����ID
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //���������Ϣ
            MAUdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//�������
            MAUdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//�����ID
            MAUdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���������
            MAUdata.add("OPERATION_STATE", "2");//����״̬���Ѵ���
            Mhandler.saveNcmMatchAudit(conn, MAUdata);
            //�ϱ���ˣ���Ӳ������������Ϣ
            Data CreateMAUdata = new Data();
            CreateMAUdata.add("MAU_ID", "");//ƥ�����ID
            CreateMAUdata.add("MI_ID", MI_ID);//ƥ����ϢID
            CreateMAUdata.add("AUDIT_LEVEL", "1");//��˼��𣺲����������
            CreateMAUdata.add("OPERATION_STATE", "0");//����״̬��������
            Mhandler.saveNcmMatchAudit(conn, CreateMAUdata);
            //�޸�ƥ����Ϣ����Ϣ
            Data MIdata = new Data();
            MIdata.add("MI_ID", MI_ID);//ƥ����ϢID
            MIdata.add("MATCH_STATE", "1");//ƥ��״̬���������δ����
            Mhandler.saveNcmMatchInfo(conn, MIdata);
            
            Data CIdata = new Data();
            CIdata.add("CI_ID", CI_ID);
            //����ȫ��״̬��λ��
            ChildCommonManager childCommonManager = new ChildCommonManager();
            CIdata = childCommonManager.matchAuditBMZR(CIdata, SessionInfo.getCurUser().getCurOrgan());
            CIhandler.save(conn, CIdata);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ϱ��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ϱ�ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
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
     * @Title: auditSave
     * @Description: ��˱���
     * @author: xugy
     * @date: 2014-9-9����3:53:26
     * @return
     */
    public String auditSave(){
        //��˽��������������ע
        Data MAUdata = getRequestEntityData("MAU_","MAU_ID","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");
        //String MI_ID = getParameter("MI_MI_ID");//ƥ����ϢID
        String AF_ID = getParameter("AF_AF_ID");//�������ļ�ID
        //String CI_ID = getParameter("CI_CI_ID");//��ͯ����ID
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //���������Ϣ
            MAUdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//�������
            MAUdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//�����ID
            MAUdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���������
            MAUdata.add("OPERATION_STATE", "1");//����״̬��������
            Mhandler.saveNcmMatchAudit(conn, MAUdata);
            
            //�ļ�ȫ��״̬��λ��
            FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
            Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_SH_SB);
            data.add("AF_ID", AF_ID);
            AFhandler.modifyFileInfo(conn, data);//�޸��ļ���Ϣ
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "��˱���ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "��˱���ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "��˱���ʧ��!");
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
     * @Title: matchAuditDetail
     * @Description: 
     * @author: xugy
     * @date: 2014-12-15����5:48:49
     * @return
     */
    public String matchAuditDetail(){
        String ids = getParameter("ids");//ƥ�����ID��ƥ����ϢID���������ļ�ID����ͯ����ID
        String MAU_ID = ids.split(",")[0];//ƥ�����ID
        String MI_ID = ids.split(",")[1];//ƥ����ϢID
        //String AF_ID = ids.split(",")[2];//�������ļ�ID
        //String CI_ID = ids.split(",")[3];//��ͯ����ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //�����Ϣ
            String AUDIT_LEVEL = "0";//���������
            //Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);//���������
            Data MAUdata=handler.getMatchAuditOnly(conn,AUDIT_LEVEL,MAU_ID);
            data.addData(MAUdata);
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
     * @Title: matchAuditAgainList
     * @Description: �����б�
     * @author: xugy
     * @date: 2014-9-9����7:16:47
     * @return
     */
    public String matchAuditAgainList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_TYPE","MATCH_NUM","CHILD_TYPE","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","OPERATION_STATE","MATCH_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findMatchAuditAgainList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toMatchAuditAgainAdd
     * @Description: 
     * @author: xugy
     * @date: 2014-9-9����7:36:59
     * @return
     */
    public String toMatchAuditAgainAdd(){
        String ids = getParameter("ids");//ƥ�����ID��ƥ����ϢID���������ļ�ID����ͯ����ID
        String MAU_ID = ids.split(",")[0];//ƥ�����ID
        String MI_ID = ids.split(",")[1];//ƥ����ϢID
        String AF_ID = ids.split(",")[2];//�������ļ�ID
        String CI_ID = ids.split(",")[3];//��ͯ����ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            //������Ϣ
            String AUDIT_LEVEL = "1";//�����������
            Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);
            data.addData(MAUdata);
            //�����������Ϣ
            Data MAUdata1=handler.getMatchAuditForJBR(conn,MI_ID);
            data.addData(MAUdata1);
            data.add("AUDIT_DATE", DateUtility.getCurrentDate());
            data.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            //����������ƥ����Ϣ
            DataList allAFMatchdl = handler.getAllAFMatchInfo(conn, AF_ID);
            //��ͯ����ƥ����Ϣ
            DataList allCIMatchdl = handler.getAllCIMatchInfo(conn, CI_ID);
            //�������д��ҳ����ձ���
            setAttribute("data",data);
            setAttribute("allAFMatchdl",allAFMatchdl);
            setAttribute("allCIMatchdl",allCIMatchdl);
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
                        log.logError("NormalMatchAction��showCIs.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: auditAgainSave
     * @Description: ������Ϣ����
     * @author: xugy
     * @date: 2014-9-10����10:45:10
     * @return
     */
    public String auditAgainSave(){
        //��˽��������������ע
        Data MAUdata = getRequestEntityData("MAU_","MAU_ID","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");
        String MI_ID = getParameter("MI_MI_ID");//ƥ����ϢID
        String AF_ID = getParameter("AF_AF_ID");//�������ļ�ID
        String CI_ID = getParameter("CI_CI_ID");//��ͯ����ID
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //���渴����Ϣ
            MAUdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//�������
            MAUdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//�����ID
            MAUdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���������
            MAUdata.add("OPERATION_STATE", "2");//����״̬���Ѵ���
            Mhandler.saveNcmMatchAudit(conn, MAUdata);
            
            Data AFdata = new Data();//�ļ�����
            Data MIdata = new Data();//ƥ������
            
            //�޸�ƥ����Ϣ����Ϣ
            String AUDIT_OPTION = MAUdata.getString("AUDIT_OPTION");//��˽��
            if("0".equals(AUDIT_OPTION)){//ͨ��
                MIdata.add("MI_ID", MI_ID);//ƥ����ϢID
                MIdata.add("MATCH_PASSDATE", DateUtility.getCurrentDate());//ƥ��ͨ������
                MIdata.add("ADVICE_SIGN_DATE", DateUtility.getCurrentDate());//�������_����������
                MIdata.add("ADVICE_STATE", "1");//�������_״̬
                MIdata.add("ADVICE_PRINT_NUM", "0");//�������_��ӡ����
                MIdata.add("MATCH_STATE", "3");//ƥ��״̬��3=���ͨ����4=��˲�ͨ��
                Mhandler.saveNcmMatchInfo(conn, MIdata);
                
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_FHTG_SUBMIT);
                AFdata.addData(data);
                AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                
                MatchAction matchAction = new MatchAction();
                matchAction.letterOfSeekingConfirmation(conn, MI_ID, "1");//���������
            }else if("1".equals(AUDIT_OPTION)){//��ͨ��
                MIdata.add("AF_ID", AF_ID);
                MIdata.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//���ƥ������
                MIdata.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//���ƥ����ID
                MIdata.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���ƥ��������
                MIdata.add("REVOKE_MATCH_TYPE", "3");//���ƥ�����ͣ�����ƥ��
                MIdata.add("REVOKE_MATCH_REASON", "ƥ����˲�ͨ��");//���ƥ��ԭ��
                MIdata.add("MATCH_STATE", "4");//ƥ��״̬��3=���ͨ����4=��˲�ͨ��
                Data AFdataInfo = Mhandler.getAFInfoOfAfId(conn, AF_ID);
                String RI_ID = AFdataInfo.getString("RI_ID", "");
                if("".equals(RI_ID)){//û��Ԥ����Ϣ��ͨ���ֶ�ƥ��,���ͯ������һ����ͬ���ֵ�
                    Mhandler.storeNcmMatchInfoOne(conn, MIdata);
                    /****��ͯ��������ͥ���ƥ���ϵ���޸��ļ��Ͳ������״̬Begin****/
                    String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//�ļ�ƥ���ͯ��ID�����Ϊͬ����
                    if(!"".equals(AF_CI_ID)){
                        String[] array = AF_CI_ID.split(",");
                        for(int i=0;i<array.length;i++){
                            //�޸Ĳ���ƥ��״̬
                            Data CIdata = new Data();//��������
                            CIdata.add("CI_ID", array[i]);//����ID
                            CIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                            //����ȫ��״̬��λ��
                            ChildCommonManager childCommonManager = new ChildCommonManager();
                            CIdata = childCommonManager.matchAuditNotThrough(CIdata, SessionInfo.getCurUser().getCurOrgan());
                            CIhandler.save(conn, CIdata);
                        }
                    }
                    //�޸��ļ�ƥ��״̬
                    AFdata.add("AF_ID", AF_ID);//�ļ�ID
                    AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                    AFdata.add("CI_ID", "");//�ļ���ͯ����ID�ÿ�
                    String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//�ļ�����
                    if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                        AFdata.add("FILE_TYPE", "10");
                    }
                    //�ļ�ȫ��״̬��λ��
                    FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                    Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_FHBTG_SUBMIT);
                    AFdata.addData(data);
                    AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                    /****��ͯ��������ͥ���ƥ���ϵ���޸��ļ��Ͳ������״̬End****/
                }else{//����Ԥ����Ϣ,
                    Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
                    String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID","");//��ͯ������ͯID
                    DataList CIdl = handler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
                    if(CIdl.size()>0){
                        for(int i=0;i<CIdl.size();i++){
                            String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                            MIdata.add("CI_ID", everyCiId);
                            Mhandler.storeNcmMatchInfoTwo(conn, MIdata);//ͨ���ļ�ID����ID�޸�ƥ����Ϣ
                            
                            //�޸Ĳ���ƥ��״̬
                            Data CIdata = new Data();//��������
                            CIdata.add("CI_ID", everyCiId);//����ID
                            CIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                            //����ȫ��״̬��λ��
                            ChildCommonManager childCommonManager = new ChildCommonManager();
                            CIdata = childCommonManager.matchAuditNotThrough(CIdata, SessionInfo.getCurUser().getCurOrgan());
                            CIhandler.save(conn, CIdata);
                        }
                    }
                    PublishCommonManager publishCommonManager = new PublishCommonManager();
                    publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                    
                    String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//�ļ�����
                    if(!"23".equals(FILE_TYPE)){//�ļ����Ͳ�Ϊ����˫���ģ���һ��Ԥ��
                        //�޸��ļ�ƥ��״̬
                        AFdata.add("AF_ID", AF_ID);//�ļ�ID
                        AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                        if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                            AFdata.add("FILE_TYPE", "10");
                        }
                        //�ļ�ȫ��״̬��λ��
                        FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                        Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_FHBTG_SUBMIT);
                        AFdata.addData(data);
                        AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                    }
                }
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ύ�ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error3";
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
     * @Title: matchAuditAgainDetail
     * @Description: 
     * @author: xugy
     * @date: 2014-12-15����6:35:06
     * @return
     */
    public String matchAuditAgainDetail(){
        String ids = getParameter("ids");//ƥ�����ID��ƥ����ϢID���������ļ�ID����ͯ����ID
        String MAU_ID = ids.split(",")[0];//ƥ�����ID
        String MI_ID = ids.split(",")[1];//ƥ����ϢID
        //String AF_ID = ids.split(",")[2];//�������ļ�ID
        //String CI_ID = ids.split(",")[3];//��ͯ����ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //�����Ϣ
            String AUDIT_LEVEL = "1";//�����������
            //Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);//�����������
            Data MAUdata=handler.getMatchAuditOnly(conn,AUDIT_LEVEL,MAU_ID);//�����������
            data.addData(MAUdata);
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
     * @Title: toRelieveMatch
     * @Description: ���ƥ��
     * @author: xugy
     * @date: 2014-9-28����6:02:58
     * @return
     */
    public String toRelieveMatch(){
        String ids = getParameter("ids");//ƥ�����ID��ƥ����ϢID���������ļ�ID����ͯ����ID
        String MI_ID = ids.split(",")[1];//ƥ����ϢID
        String AF_ID = ids.split(",")[2];//�������ļ�ID
        String CI_ID = ids.split(",")[3];//��ͯ����ID
        String FILE_TYPE = ids.split(",")[6];//�ļ�����
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data.add("MI_ID", MI_ID);
            data.add("AF_ID", AF_ID);
            data.add("CI_ID", CI_ID);
            data.add("FILE_TYPE", FILE_TYPE);
            data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());
            data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
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
                        log.logError("NormalMatchAction��showCIs.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: relieveMatchSave
     * @Description: ���ƥ�䡣�κη�״̬��������Ľ��ƥ�䣬״̬����Ϊ��Ч
     * @author: xugy
     * @date: 2014-9-29����2:54:14
     * @return
     */
    public String relieveMatchSave(){
        Data MIdata = getRequestEntityData("MI_","MI_ID","REVOKE_MATCH_TYPE","REVOKE_MATCH_REASON");//ƥ����Ϣ
        String MI_ID = MIdata.getString("MI_ID");
        String AF_ID = getParameter("AF_AF_ID");//�ļ�ID
        String CI_ID = getParameter("CI_CI_ID");//�Ĳ���ID
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //���ƥ����Ϣ
            MIdata.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//���ƥ������
            MIdata.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//���ƥ����ID
            MIdata.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���ƥ��������
            //��������״̬
            Data MSdata = handler.getAllMatchState(conn, MIdata.getString("MI_ID"));
            //String MATCH_STATE = data.getString("MATCH_STATE", "");//ƥ��״̬
            String ADVICE_STATE = MSdata.getString("ADVICE_STATE", "");//�������_״̬
            String SIGN_STATE = MSdata.getString("SIGN_STATE", "");//ǩ����Ϣ_ǩ��״̬
            String NOTICE_STATE = MSdata.getString("NOTICE_STATE", "");//֪ͨ��_�ķ�״̬
            String ADREG_STATE = MSdata.getString("ADREG_STATE", "");//�����Ǽ�_�Ǽ�״̬
            
            /********* ���ƥ��ı�״̬Begin ***********/
            if(!"".equals(ADREG_STATE)){//�����Ǽ�״̬
                MIdata.add("MATCH_STATE", "9");//ƥ��״̬����Ч
                MIdata.add("ADVICE_STATE", "9");//�������״̬����Ч
                MIdata.add("SIGN_STATE", "9");//ǩ��״̬����Ч
                MIdata.add("NOTICE_STATE", "9");//֪ͨ��ķ�״̬����Ч
                //��ͯ���ϴӵ������ƽ������ò�
                /*DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//������ϸID
                transferData.add("APP_ID", CIdata.getString("CI_ID"));//ҵ���¼ID
                transferData.add("TRANSFER_CODE", TransferCode.RFM_CHILDINFO_DAB_AZB);//�ƽ����ͣ�������-->���ò�
                transferData.add("TRANSFER_STATE", "0");//�ƽ�״̬
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);*///����һ���ƽ���Ϣ
                if("0".equals(ADREG_STATE) || "1".equals(ADREG_STATE)){//δ�Ǽǻ��ѵǼ�
                    MIdata.add("ADREG_STATE", "9");//�Ǽ�״̬����Ч
                }
            }else{
                if(!"".equals(NOTICE_STATE)){//֪ͨ��ķ�״̬
                    MIdata.add("MATCH_STATE", "9");//ƥ��״̬����Ч
                    MIdata.add("ADVICE_STATE", "9");//�������״̬����Ч
                    MIdata.add("SIGN_STATE", "9");//ǩ��״̬����Ч
                    MIdata.add("NOTICE_STATE", "9");//֪ͨ��ķ�״̬����Ч
                }else{
                    if(!"".equals(SIGN_STATE)){//ǩ����Ϣ_ǩ��״̬
                        MIdata.add("MATCH_STATE", "9");//ƥ��״̬����Ч
                        MIdata.add("ADVICE_STATE", "9");//�������״̬����Ч
                        MIdata.add("SIGN_STATE", "9");//ǩ��״̬����Ч
                    }else{
                        if(!"".equals(ADVICE_STATE)){//�������_״̬
                            MIdata.add("MATCH_STATE", "9");//ƥ��״̬����Ч
                            MIdata.add("ADVICE_STATE", "9");//�������״̬����Ч
                        }
                    }
                }
            }
            /********** ���ƥ��ı�״̬End **********/
            String REVOKE_MATCH_TYPE = MIdata.getString("REVOKE_MATCH_TYPE","");//���ƥ������
            Data AFdataInfo = Mhandler.getAFInfoOfAfId(conn, AF_ID);
            String RI_ID = AFdataInfo.getString("RI_ID", "");//
            String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//�ļ�����
            if("".equals(RI_ID)){//û��Ԥ��
                MIdata.add("AF_ID", AF_ID);
                MIdata.remove("MI_ID");
                Mhandler.storeNcmMatchInfoOne(conn, MIdata);
                /****��ͯ��������ͥ���ƥ���ϵ���޸��ļ��Ͳ������״̬Begin****/
                String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//�ļ�ƥ���ͯ��ID�����Ϊͬ����
                if(!"".equals(AF_CI_ID)){
                    String[] array = AF_CI_ID.split(",");
                    for(int i=0;i<array.length;i++){
                        //�޸Ĳ���ƥ��״̬
                        Data CIdata = new Data();//��������
                        CIdata.add("CI_ID", array[i]);//����ID
                        CIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                        CIhandler.save(conn, CIdata);
                    }
                }
                //�޸��ļ�ƥ��״̬
                Data AFdata = new Data();
                AFdata.add("AF_ID", AF_ID);//�ļ�ID
                AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                AFdata.add("CI_ID", "");//�ļ���ͯ����ID�ÿ�
                if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                    AFdata.add("FILE_TYPE", "10");
                }
                /****��ͯ��������ͥ���ƥ���ϵ���޸��ļ��Ͳ������״̬End****/
                if("1".equals(REVOKE_MATCH_TYPE)){//����
                    String RETURN_STATE = AFdataInfo.getString("RETURN_STATE", "");//����״̬
                    String AF_RETURN_REASON = getParameter("Ins_AF_RETURN_REASON");//����ԭ��
                    if("".equals(RETURN_STATE)){//û������
                        AFdata.add("RETURN_STATE", "0");//�ļ�����״̬����ȷ��
                        AFdata.add("RETURN_REASON", AF_RETURN_REASON);//�ļ�����ԭ��
                        //��ȡ�ļ���Ҫ�������ļ�¼������Ϣ
                        AZBAdviceHandler AZBAH = new AZBAdviceHandler();
                        Data RFMdata = AZBAH.getRFMAFInfo(conn, AFdata.getString("AF_ID"));
                        RFMdata.add("AR_ID", "");//���ļ�¼ID
                        RFMdata.add("RETURN_REASON", AF_RETURN_REASON);//����ԭ��
                        RFMdata.add("APPLE_DATE", DateUtility.getCurrentDate());//��������
                        RFMdata.add("APPLE_PERSON_ID", SessionInfo.getCurUser().getPerson().getPersonId());//������ID
                        RFMdata.add("APPLE_PERSON_NAME", SessionInfo.getCurUser().getPerson().getCName());//����������
                        RFMdata.add("APPLE_TYPE", "3");//�������ͣ������������
                        RFMdata.add("RETURN_STATE", "0");//����״̬����ȷ��
                        InsteadRecordHandler IRH = new InsteadRecordHandler();
                        IRH.ReturnFileSave(conn, RFMdata, AFdata);
                    }else{
                        AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                    }
                }else{
                    AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                }
            }else{//����Ԥ��
                MIdata.remove("MI_ID");
                Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
                String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID");//��ͯ������ͯID
                DataList CIdl = handler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
                if(CIdl.size()>0){
                    for(int i=0;i<CIdl.size();i++){
                        String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                        MIdata.add("CI_ID", everyCiId);
                        Mhandler.storeNcmMatchInfoTwo(conn, MIdata);//ͨ���ļ�ID����ID�޸�ƥ����Ϣ
                        
                        //�޸Ĳ���ƥ��״̬
                        Data CIdata = new Data();//��������
                        CIdata.add("CI_ID", everyCiId);//����ID
                        CIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                        CIhandler.save(conn, CIdata);
                    }
                }
                PublishCommonManager publishCommonManager = new PublishCommonManager();
                publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                if(!"23".equals(FILE_TYPE)){//�ļ����Ͳ�Ϊ����˫���ģ���һ��Ԥ��
                    Data AFdata = new Data();
                    //�޸��ļ�ƥ��״̬
                    AFdata.add("AF_ID", AF_ID);//�ļ�ID
                    AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                    if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                        AFdata.add("FILE_TYPE", "10");
                    }
                    AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                    if("1".equals(REVOKE_MATCH_TYPE)){//����
                        String RETURN_STATE = AFdataInfo.getString("RETURN_STATE", "");//����״̬
                        String AF_RETURN_REASON = getParameter("Ins_AF_RETURN_REASON");//����ԭ��
                        if("".equals(RETURN_STATE)){//û������
                            AFdata.add("RETURN_STATE", "0");//�ļ�����״̬����ȷ��
                            AFdata.add("RETURN_REASON", AF_RETURN_REASON);//�ļ�����ԭ��
                            //��ȡ�ļ���Ҫ�������ļ�¼������Ϣ
                            AZBAdviceHandler AZBAH = new AZBAdviceHandler();
                            Data RFMdata = AZBAH.getRFMAFInfo(conn, AFdata.getString("AF_ID"));
                            RFMdata.add("AR_ID", "");//���ļ�¼ID
                            RFMdata.add("RETURN_REASON", AF_RETURN_REASON);//����ԭ��
                            RFMdata.add("APPLE_DATE", DateUtility.getCurrentDate());//��������
                            RFMdata.add("APPLE_PERSON_ID", SessionInfo.getCurUser().getPerson().getPersonId());//������ID
                            RFMdata.add("APPLE_PERSON_NAME", SessionInfo.getCurUser().getPerson().getCName());//����������
                            RFMdata.add("APPLE_TYPE", "3");//�������ͣ������������
                            RFMdata.add("RETURN_STATE", "0");//����״̬����ȷ��
                            InsteadRecordHandler IRH = new InsteadRecordHandler();
                            IRH.ReturnFileSave(conn, RFMdata, AFdata);
                        }
                    }else{
                        AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                    }
                }
            }
            //ɾ���Ѵ�����û���ƽ���ȥ���ƽ���Ϣ
            Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
            String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID");//��ͯ������ͯID
            DataList CIdl = handler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
            TransferManagerHandler transferManagerHandler = new TransferManagerHandler();
            if(CIdl.size()>0){
                for(int i=0;i<CIdl.size();i++){
                    String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                    Data everyTIDdata = handler.getTransferInfoDetail(conn, everyCiId);
                    String TRANSFER_STATE = everyTIDdata.getString("TRANSFER_STATE", "");//����״̬
                    if(!"".equals(TRANSFER_STATE)){//�н�����ϸ��Ϣ
                        if("1".equals(TRANSFER_STATE)){//��ϸ��Ϣ�Ѵ��ڽ��ӵ��У��޸Ľ��ӵ�����
                            String TI_ID = everyTIDdata.getString("TI_ID", "");//���ӵ�ID
                            if(!"".equals(TI_ID)){
                                Data everyTIdata = handler.getTransferInfo(conn, TI_ID);
                                int COPIES = everyTIdata.getInt("COPIES");
                                if(COPIES > 0){
                                    COPIES = COPIES - 1;
                                }
                                everyTIdata.add("COPIES", COPIES);
                                transferManagerHandler.saveTransferInfo(conn, everyTIdata);
                            }
                        }
                        String TID_ID = everyTIDdata.getString("TID_ID", "");//������ϸID
                        handler.deleteTransferInfoDetail(conn, TID_ID);//ɾ���ý�����ϸ��Ϣ
                    }
                }
            }
               
            if("1".equals(NOTICE_STATE)){//֪ͨ��ķ�״̬���Ѽķ�
                Data AICreateData = new Data();
                Data AIdata = handler.getArchiveInfo(conn, MI_ID);
                AICreateData.add("ARCHIVE_ID", AIdata.getString("ARCHIVE_ID"));//
                AICreateData.add("ARCHIVE_DATE", "");//�鵵����
                AICreateData.add("ARCHIVE_USERID", "");//�鵵��ID
                AICreateData.add("ARCHIVE_USERNAME", "");//�鵵������
                AICreateData.add("ARCHIVE_STATE", "0");//�鵵״̬
                AICreateData.add("ARCHIVE_VALID", "0");//�Ƿ���Ч
                Mhandler.saveNcmArchiveInfo(conn, AICreateData);
            }
            //�Ǽ�֤�Ż���ʹ��
            String ADREG_NO = MSdata.getString("ADREG_NO", "");//�����Ǽ�_�Ǽ�֤��
            if(!"".equals(ADREG_NO)){
                Data farData = new Data();
                farData.add("FAR_SN", ADREG_NO);
                farData.add("IS_USED", "0");
                AdoptionRegisHandler adoptionRegisHandler = new AdoptionRegisHandler();
                adoptionRegisHandler.storeFarSN(conn, farData);
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���ƥ��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "���ƥ��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���ƥ��ʧ��!");
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
}
