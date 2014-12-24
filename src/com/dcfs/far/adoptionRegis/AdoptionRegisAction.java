package com.dcfs.far.adoptionRegis;

import hx.code.CodeList;
import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.config.CommonConfig;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;
import hx.word.getword.GetWord;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.BGSnotice.BGSNoticeHandler;
import com.dcfs.ncm.common.FarCommonAction;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: AdoptionRegisAction.java
 * @Description: �����Ǽǰ���
 * @Company: 21softech
 * @Created on 2014-9-22 ����7:53:51
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AdoptionRegisAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AdoptionRegisAction.class);
    private Connection conn = null;
    private AdoptionRegisHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private PPFeedbackHandler PPhandler;
    
    private FarCommonAction FCA;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public AdoptionRegisAction() {
        this.handler=new AdoptionRegisHandler();
        this.Mhandler=new MatchHandler();
        this.AFhandler=new FileCommonManager();
        this.CIhandler=new ChildManagerHandler();
        this.FCA=new FarCommonAction();
        this.PPhandler=new PPFeedbackHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: adoptionRegisList
     * @Description: �����Ǽ��б�
     * @author: xugy
     * @date: 2014-9-22����7:56:34
     * @return
     */
    public String adoptionRegisList(){
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
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","WELFARE_NAME_CN","CHILD_TYPE","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","IS_CONVENTION_ADOPT","ADREG_NO","SIGN_DATE_START","SIGN_DATE_END","ADREG_STATE","ADREG_DATE_START","ADREG_DATE_END");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAdoptionRegisList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toAdoptionRegisPrePrint
     * @Description: �Ǽ�Ԥ��ӡ
     * @author: xugy
     * @date: 2014-11-13����8:36:41
     * @return
     */
    public String toAdoptionRegisPrePrint(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            
            List<Att> list1 = AttHelper.findAttListByPackageId(MI_ID, AttConstants.SYDJZ, "AF");
            List<Att> list2 = AttHelper.findAttListByPackageId(MI_ID, AttConstants.KGSYHGZM, "AF");
            
            setAttribute("list1",list1);
            setAttribute("list2",list2);
            setAttribute("MI_ID",MI_ID);
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
     * @Title: toAdoptionRegAdd
     * @Description: �����Ǽ�ҳ��
     * @author: xugy
     * @date: 2014-9-23����2:06:02
     * @return
     */
    public String toAdoptionRegAdd(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.getAdoptionRegInfo(conn, MI_ID);
            
            data.add("ADREG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            data.add("ADREG_DATE", DateUtility.getCurrentDate());
            
            String PROVINCE_ID = data.getString("PROVINCE_ID");
            String provinceCode = PROVINCE_ID.substring(0, 2);
            //��ȡ�Ǽ�֤�žɺ�
            CodeList list = handler.findOldFarSN(conn, provinceCode);
            HashMap<String,CodeList> cmap=new HashMap<String,CodeList>();
            cmap.put("OLD_FAR_SN_LIST", list);
            //�������д��ҳ����ձ���
            setAttribute(Constants.CODE_LIST,cmap);
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
     * @Title: saveAdoptionReg
     * @Description: ���������Ǽ�
     * @author: xugy
     * @date: 2014-9-23����6:05:17
     * @return
     */
    public String saveAdoptionReg(){
        //�����Ǽ���Ϣ
        String NUMBER_TYPE = getParameter("Ins_NUMBER_TYPE");//�Ǽ�֤�ţ�1���Զ����ɣ�2��ʹ�þɺ�
        String ADREG_RESULT = getParameter("Ins_ADREG_RESULT");//�Ǽǽ����1���Ǽǳɹ���2����Ч�Ǽ�
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADREG_DEAL_TYPE","ADREG_INVALID_REASON","ADREG_REMARKS","ADREG_DATE");
        String PROVINCE_ID = getParameter("Ins_PROVINCE_ID");
        MIdata.add("ADREG_PROVINCE_ID", PROVINCE_ID);//ʡ�ݴ���
        MIdata.add("ADREG_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//�Ǽǻ���ID
        MIdata.add("ADREG_USER_ID", SessionInfo.getCurUser().getPerson().getPersonId());//�Ǽ���ID
        MIdata.add("ADREG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//�Ǽ�������
        if("1".equals(ADREG_RESULT)){
            MIdata.add("ADREG_STATE", "1");//�Ǽ�״̬���ѵǼ�
        }
        if("2".equals(ADREG_RESULT)){
            MIdata.add("ADREG_STATE", "2");//�Ǽ�״̬����Ч�Ǽ�
        }
        
        //��ͯ��Ϣ
        Data CIdata = getRequestEntityData("CI_","CI_ID","SEX","BIRTHDAY","CHILD_IDENTITY","ID_CARD","SENDER","SENDER_EN","SENDER_ADDR","NATION_DATE","CHILD_NAME_EN");
        //��������Ϣ
        Data AFdata = new Data();
        String FILE_TYPE = getParameter("Ins_FILE_TYPE");//�ļ�����
        String FAMILY_TYPE = getParameter("Ins_FAMILY_TYPE");//��������
        String ADOPTER_SEX = getParameter("Ins_ADOPTER_SEX","");//�������Ա�
        if("33".equals(FILE_TYPE)){//����Ů����
            if("1".equals(ADOPTER_SEX)){//��������
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO");
            }
            if("2".equals(ADOPTER_SEX)){//Ů������
                AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO");
            }
        }else{
            if("1".equals(FAMILY_TYPE)){//˫������
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","FEMALE_NATION","MALE_PASSPORT_NO","FEMALE_PASSPORT_NO","ADDRESS");
            }
            if("2".equals(FAMILY_TYPE)){//��������
                if("1".equals(ADOPTER_SEX)){//��������
                    AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO","ADDRESS");
                }
                if("2".equals(ADOPTER_SEX)){//Ů������
                    AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO","ADDRESS");
                }
            }
        }
        
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String COUNTRY_CODE = getParameter("Ins_COUNTRY_CODE");//����code
            String ADREG_NO = "";
            if("1".equals(ADREG_RESULT)){//�Ǽǳɹ�
                if("1".equals(NUMBER_TYPE)){//�Զ����ɵǼ�֤��
                    ADREG_NO = FCA.createFARSn(conn, COUNTRY_CODE, PROVINCE_ID);
                }
                if("2".equals(NUMBER_TYPE)){//ʹ�þɺ�
                    ADREG_NO = getParameter("Ins_ADREG_NO");
                    Data farData = new Data();
                    farData.add("FAR_SN", ADREG_NO);
                    farData.add("IS_USED", "1");
                    handler.storeFarSN(conn, farData);
                }
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.ST_SYDJ_DJCG);
                AFdata.addData(data);
                
                //����ȫ��״̬��λ��
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.adoptionIsRegistered(CIdata, SessionInfo.getCurUser().getCurOrgan());
            }else{
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.ST_SYDJ_DJWX);
                AFdata.addData(data);
            }
            MIdata.add("ADREG_NO", ADREG_NO);//�Ǽ�֤��
            Mhandler.saveNcmMatchInfo(conn, MIdata);//�����Ǽ���Ϣ����
            AFhandler.modifyFileInfo(conn, AFdata);//��������Ϣ����
            CIhandler.save(conn, CIdata);//��ͯ��Ϣ����
            
            if("1".equals(ADREG_RESULT)){//�Ǽǳɹ������氲�ú󱨸���Ϣ
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String SIGN_DATE = getParameter("Ins_SIGN_DATE");//ǩ������
                Date signDate = sdf.parse(SIGN_DATE);
                String d1 = "2014-12-31";
                Date date1 = sdf.parse(d1);
                String d2 = "2015-01-01";
                Date date2 = sdf.parse(d2);
                
                String MI_ID = MIdata.getString("MI_ID");//ƥ����ϢID
                Data PFRdata = handler.getSavePFRInfo(conn, MI_ID);
                PFRdata.add("FEEDBACK_ID", "");
                PFRdata.add("IS_FINISH", "0");
                PFRdata = PPhandler.savePfrFeedbackInfo(conn, PFRdata);
                String FEEDBACK_ID = PFRdata.getString("FEEDBACK_ID");//���ú󱨸�ID
                String ADREG_DATE = PFRdata.getString("ADREG_DATE");//�Ǽ�����
                if(signDate.before(date2)){//2015-01-01֮ǰ
                    for(int i=1;i<=6;i++){
                        Data PFRRdata = new Data();
                        PFRRdata.add("FB_REC_ID", "");//���ú󱨸��¼ID
                        PFRRdata.add("FEEDBACK_ID", FEEDBACK_ID);//���ú󱨸�ID
                        PFRRdata.add("NUM", i);//����
                        PFRRdata.add("REMINDERS_STATE", "0");//�߽�״̬
                        PFRRdata.add("REPORT_STATE", "0");//����״̬
                        String LIMIT_DATE = "";
                        if(i == 1){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 1);
                        }
                        if(i == 2){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                        }
                        if(i == 3){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                        }
                        if(i == 4){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                        }
                        if(i == 5){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                        }
                        if(i == 6){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                        }
                        PFRRdata.add("LIMIT_DATE", LIMIT_DATE);//�ύʱ��
                        PPhandler.savePfrFeedbackRecord(conn, PFRRdata);
                    }
                }
                if(date1.before(signDate)){//2014-12-31֮��
                    for(int i=1;i<=6;i++){
                        Data PFRRdata = new Data();
                        PFRRdata.add("FB_REC_ID", "");//���ú󱨸��¼ID
                        PFRRdata.add("FEEDBACK_ID", FEEDBACK_ID);//���ú󱨸�ID
                        PFRRdata.add("NUM", i);//����
                        PFRRdata.add("REMINDERS_STATE", "0");//�߽�״̬
                        PFRRdata.add("REPORT_STATE", "0");//����״̬
                        String LIMIT_DATE = "";
                        if(i == 1){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                        }
                        if(i == 2){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                        }
                        if(i == 3){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                        }
                        if(i == 4){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                        }
                        if(i == 5){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 48);
                        }
                        if(i == 6){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                        }
                        PFRRdata.add("LIMIT_DATE", LIMIT_DATE);//�ύʱ��
                        PPhandler.savePfrFeedbackRecord(conn, PFRRdata);
                    }
                }
                
                
            }
            //�޸ĵ����ĵǼ���Ϣ
            Data AIdata = new Data();
            AIdata.add("MI_ID", MIdata.getString("MI_ID"));//ƥ����ϢID
            AIdata.add("ADREG_STATE", MIdata.getString("ADREG_STATE"));//�����Ǽ�_�Ǽ�״̬
            AIdata.add("ADREG_DATE", MIdata.getString("ADREG_DATE"));//�����Ǽ�_�Ǽ�����
            handler.storeArchiveInfo(conn, AIdata);
            
            modArchiveInfo(conn, MIdata.getString("MI_ID"));//���µ�����ļ�ͥ�ļ��Ͳ�����Ϣ
            
            /*if("1".equals(ADREG_RESULT)){//�Ǽǳɹ����������ɵǼ�֤�Ϳ�������ϸ�֤��
                GetWord getWord = new GetWord();
                String path2 = CommonConfig.getProjectPath() + "/tempFile/�����Ǽ�֤.doc";
                
                //���������Ǽ�֤
                getWord.createDoc(conn, MIdata.getString("MI_ID"),"sydjz.ftl","hx.word.data.impl.GetWordSydjzImpl",path2);
                File file2 = new File(path2);
                if(file2.exists()){
                    AttHelper.delAttsOfPackageId(MIdata.getString("MI_ID"), AttConstants.SYDJZ, "AF");//ɾ��ԭ����
                    
                    AttHelper.manualUploadAtt(file2, "AF", MIdata.getString("MI_ID"), "�����Ǽ�֤.doc", AttConstants.SYDJZ, "AF", AttConstants.SYDJZ, MIdata.getString("MI_ID"));
                    file2.delete();//ɾ��ԭ�����ɵ������Ǽ�֤
                }
                String IS_CONVENTION_ADOPT = getParameter("Ins_IS_CONVENTION_ADOPT");//��Լ����
                if("1".equals(IS_CONVENTION_ADOPT)){//��Լ���������ɿ�������ϸ�֤��
                    String path3 = CommonConfig.getProjectPath() + "/tempFile/��������ϸ�֤��.doc";
                    getWord.createDoc(conn, MIdata.getString("MI_ID"),"syhgzm.ftl","hx.word.data.impl.GetWordSyhgzmImpl",path3);
                    File file3 = new File(path3);
                    if(file3.exists()){
                        AttHelper.delAttsOfPackageId(MIdata.getString("MI_ID"), AttConstants.KGSYHGZM, "AF");//ɾ��ԭ����
                        
                        AttHelper.manualUploadAtt(file3, "AF", MIdata.getString("MI_ID"), "��������ϸ�֤��.doc", AttConstants.KGSYHGZM, "AF", AttConstants.KGSYHGZM, MIdata.getString("MI_ID"));
                        file3.delete();//ɾ��ԭ�����ɵĿ�������ϸ�֤��
                    }
                }
            }*/
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ǼǱ���ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ǼǱ���ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����ǼǱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�����ǼǱ���ʧ��!");
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
        if("1".equals(ADREG_RESULT)){
            return "ok";
        }else if("2".equals(ADREG_RESULT)){
            return "invalid";
        }else{
            return retValue;
        }
    }
    
    
    public void modArchiveInfo(Connection conn, String MI_ID) throws DBException{
        BGSNoticeHandler bgsNoticeHandler = new BGSNoticeHandler();
        Data data = bgsNoticeHandler.getArchiveId(conn, MI_ID);
        String archiveId = data.getString("ARCHIVE_ID");
        Data AIdata = bgsNoticeHandler.getArchiveSaveInfo(conn, MI_ID);
        AIdata.add("ARCHIVE_ID", archiveId);
        Mhandler.saveNcmArchiveInfo(conn, AIdata);
    }
    
    /**
     * 
     * @Title: adoptionRegInfoMod
     * @Description: �����Ǽ���Ϣ�޸�
     * @author: xugy
     * @date: 2014-9-23����9:08:34
     * @return
     */
    public String adoptionRegInfoMod(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.getAdoptionRegInfo(conn, MI_ID);
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
     * @Title: saveAdoptionRegInfo
     * @Description: �����Ǽ���Ϣ�޸ı���
     * @author: xugy
     * @date: 2014-9-23����9:45:35
     * @return
     */
    public String saveAdoptionRegInfo(){
        //�����Ǽ���Ϣ
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADREG_DATE","ADREG_REMARKS");
        //��ͯ��Ϣ
        Data CIdata = getRequestEntityData("CI_","CI_ID","SEX","BIRTHDAY","CHILD_IDENTITY","ID_CARD","SENDER","SENDER_EN","SENDER_ADDR","NATION_DATE","CHILD_NAME_EN");
        //��������Ϣ
        Data AFdata = new Data();
        String FILE_TYPE = getParameter("Ins_FILE_TYPE");//�ļ�����
        String FAMILY_TYPE = getParameter("Ins_FAMILY_TYPE");//��������
        String ADOPTER_SEX = getParameter("Ins_ADOPTER_SEX","");//�������Ա�
        if("33".equals(FILE_TYPE)){//����Ů����
            if("1".equals(ADOPTER_SEX)){//��������
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO");
            }
            if("2".equals(ADOPTER_SEX)){//Ů������
                AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO");
            }
        }else{
            if("1".equals(FAMILY_TYPE)){//˫������
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","FEMALE_NATION","MALE_PASSPORT_NO","FEMALE_PASSPORT_NO","MALE_EDUCATION","FEMALE_EDUCATION","MALE_JOB_CN","FEMALE_JOB_CN","MALE_JOB_CN","FEMALE_JOB_CN","MALE_HEALTH","FEMALE_HEALTH","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","ADDRESS");
            }
            if("2".equals(FAMILY_TYPE)){//��������
                if("1".equals(ADOPTER_SEX)){//��������
                    AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_CN","MALE_HEALTH","MARRY_CONDITION","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","ADDRESS");
                }
                if("2".equals(ADOPTER_SEX)){//Ů������
                    AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_CN","FEMALE_HEALTH","MARRY_CONDITION","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","ADDRESS");
                }
            }
        }
        
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String ADREG_DATE = MIdata.getString("ADREG_DATE", "");
            if("".equals(ADREG_DATE)){
                MIdata.remove("ADREG_DATE");
            }else{
                String ADREG_STATE = getParameter("MI_ADREG_STATE");
                String MI_ID = MIdata.getString("MI_ID");//ƥ����ϢID
                Data FIdata = handler.getFeedbackInfo(conn, MI_ID);
                if("1".equals(ADREG_STATE)){
                    String SIGN_DATE = getParameter("MI_SIGN_DATE");//ǩ������
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date signDate = sdf.parse(SIGN_DATE);
                    String d1 = "2014-12-31";
                    Date date1 = sdf.parse(d1);
                    String d2 = "2015-01-01";
                    Date date2 = sdf.parse(d2);
                    
                    String FEEDBACK_ID = FIdata.getString("FEEDBACK_ID");//���ú󱨸�ID
                    Data PFRdata = new Data();
                    PFRdata.add("FEEDBACK_ID", FEEDBACK_ID);//���ú󱨸�ID
                    if(signDate.before(date2)){//2015-01-01֮ǰ
                        for(int i=1;i<=6;i++){
                            String LIMIT_DATE = "";
                            if(i == 1){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 1);
                                PFRdata.add("NUM", "1");//����
                            }
                            if(i == 2){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                                PFRdata.add("NUM", "2");//����
                            }
                            if(i == 3){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                                PFRdata.add("NUM", "3");//����
                            }
                            if(i == 4){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                                PFRdata.add("NUM", "4");//����
                            }
                            if(i == 5){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                                PFRdata.add("NUM", "5");//����
                            }
                            if(i == 6){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                                PFRdata.add("NUM", "6");//����
                            }
                            PFRdata.add("LIMIT_DATE", LIMIT_DATE);//�ύʱ��
                            handler.storeFeedbackRecord(conn, PFRdata);
                        }
                    }
                    if(date1.before(signDate)){//2014-12-31֮��
                        for(int i=1;i<=6;i++){
                            String LIMIT_DATE = "";
                            if(i == 1){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                                PFRdata.add("NUM", "1");//����
                            }
                            if(i == 2){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                                PFRdata.add("NUM", "2");//����
                            }
                            if(i == 3){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                                PFRdata.add("NUM", "3");//����
                            }
                            if(i == 4){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                                PFRdata.add("NUM", "4");//����
                            }
                            if(i == 5){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 48);
                                PFRdata.add("NUM", "5");//����
                            }
                            if(i == 6){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                                PFRdata.add("NUM", "6");//����
                            }
                            PFRdata.add("LIMIT_DATE", LIMIT_DATE);//�ύʱ��
                            handler.storeFeedbackRecord(conn, PFRdata);
                        }
                    }
                }
                FIdata.add("ADREG_DATE", ADREG_DATE);
                PPhandler.savePfrFeedbackInfo(conn, FIdata);
                Data AIdata = new Data();
                AIdata.add("MI_ID", MIdata.getString("MI_ID"));
                AIdata.add("ADREG_DATE", ADREG_DATE);
                handler.storeArchiveInfo(conn, AIdata);
            }
            
            Mhandler.saveNcmMatchInfo(conn, MIdata);//�����Ǽ���Ϣ����
            AFhandler.modifyFileInfo(conn, AFdata);//��������Ϣ����
            CIhandler.save(conn, CIdata);//��ͯ��Ϣ����
            modArchiveInfo(conn, MIdata.getString("MI_ID"));//���µ�����ļ�ͥ�ļ��Ͳ�����Ϣ
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����Ǽ���Ϣ����ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����Ǽ���Ϣ����ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "�����Ǽ���Ϣ����ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (ParseException e) {
            e.printStackTrace();
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
     * @Title: adoptionRegInfoShow
     * @Description: �����Ǽ���Ϣ�鿴
     * @author: xugy
     * @date: 2014-9-23����9:47:01
     * @return
     */
    public String adoptionRegInfoShow(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.getAdoptionRegInfo(conn, MI_ID);
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
     * @Title: adoptionRegisCancelList
     * @Description: �Ǽ�ע���б�
     * @author: xugy
     * @date: 2014-11-2����5:06:52
     * @return
     */
    public String adoptionRegisCancelList(){
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
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","WELFARE_NAME_CN","CHILD_TYPE","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","ADREG_NO","ADREG_INVALID_DATE_START","ADREG_INVALID_DATE_END","ADREG_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAdoptionRegisCancelList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toAdoptionRegisCancel
     * @Description: ע���Ǽ�
     * @author: xugy
     * @date: 2014-11-3����6:24:54
     * @return
     */
    public String toAdoptionRegisCancel(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            
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
     * @Title: saveAdoptionRegisCancel
     * @Description: �Ǽ�ע������
     * @author: xugy
     * @date: 2014-11-3����8:34:21
     * @return
     */
    public String saveAdoptionRegisCancel(){
      //�����Ǽ���Ϣ
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADREG_INVALID_REASON","ADREG_DEAL_TYPE","ADREG_REMARKS");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            MIdata.add("ADREG_STATE", "3");//�����Ǽ�_�Ǽ�״̬
            MIdata.add("ADREG_INVALID_DATE", DateUtility.getCurrentDate());//�����Ǽ�_ע������
            Mhandler.saveNcmMatchInfo(conn, MIdata);//�����Ǽ���Ϣ����
            String ADREG_NO = getParameter("MI_ADREG_NO");
            Data farData = new Data();
            farData.add("FAR_SN", ADREG_NO);
            farData.add("IS_USED", "0");
            handler.storeFarSN(conn, farData);
            
            //�ļ�ȫ��״̬��λ��
            FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
            Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.ST_SYDJ_DJWX);
            MatchHandler MHandler = new MatchHandler();
            Data _MIdata = MHandler.getNcmMatchInfo(conn, MIdata.getString("MI_ID"));
            String AF_ID = _MIdata.getString("AF_ID");
            _data.add("AF_ID", AF_ID);
            FileCommonManager AFhandler = new FileCommonManager();
            AFhandler.modifyFileInfo(conn, _data);//�޸������˵�ƥ����Ϣ
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�Ǽ�ע���ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "�Ǽ�ע��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "�Ǽ�ע��ʧ��!");
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
     * @Title: adoptionRegisCancelDetail
     * @Description: ע���鿴
     * @author: xugy
     * @date: 2014-11-3����9:00:57
     * @return
     */
    public String adoptionRegisCancelDetail(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            
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
     * @Title: FLYAdoptionRegisList
     * @Description: ����Ժ�����Ǽ��б�
     * @author: xugy
     * @date: 2014-11-8����5:36:16
     * @return
     */
    public String FLYAdoptionRegisList(){
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
        String ADOPT_ORG_NAME = (String)getParameter("N_ADOPT_ORG_NAME");
        String WELFARE_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode(); //��������ID
        //WELFARE_ID="11010611";
        //3 ��ȡ��������
        Data data = getRequestEntityData("N_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NAME","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","ADREG_NO");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findFLYAdoptionRegisList(conn,WELFARE_ID,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            setAttribute("ADOPT_ORG_NAME",ADOPT_ORG_NAME);
            
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
     * @Title: FLYAdoptionRegisDetail
     * @Description: ����Ժ�����Ǽǲ鿴
     * @author: xugy
     * @date: 2014-11-8����5:43:56
     * @return
     */
    public String FLYAdoptionRegisDetail(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
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
     * @Title: SYZZAdoptionRegisList
     * @Description: ������֯�����Ǽ��б�
     * @author: xugy
     * @date: 2014-11-8����5:53:21
     * @return
     */
    public String SYZZAdoptionRegisList(){
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
        String ADOPT_ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode(); //������֯CODE
        //3 ��ȡ��������
        Data data = getRequestEntityData("N_","FILE_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","IS_CONVENTION_ADOPT","SIGN_DATE_START","SIGN_DATE_END","SIGN_NO","ADREG_DATE_START","ADREG_DATE_END","ADREG_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSYZZAdoptionRegisList(conn,ADOPT_ORG_ID,data,pageSize,page,compositor,ordertype);
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
     * @Title: SYZZAdoptionRegisDetail
     * @Description: ������֯�����Ǽǲ鿴
     * @author: xugy
     * @date: 2014-11-8����6:01:07
     * @return
     */
    public String SYZZAdoptionRegisDetail(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
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
     * @Title: AZBAdoptionRegisList
     * @Description: ���ò������Ǽ��б�
     * @author: xugy
     * @date: 2014-11-8����6:08:25
     * @return
     */
    public String AZBAdoptionRegisList(){
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
        Data data = getRequestEntityData("N_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NAME","MALE_NAME","FEMALE_NAME","IS_CONVENTION_ADOPT","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","ADREG_ALERT","ADREG_STATE","ADREG_NO","SIGN_NO");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAZBAdoptionRegisList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: AZBAdoptionRegisDetail
     * @Description: ���ò������Ǽǲ鿴
     * @author: xugy
     * @date: 2014-11-8����6:10:30
     * @return
     */
    public String AZBAdoptionRegisDetail(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
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

}
