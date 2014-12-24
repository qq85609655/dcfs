package com.dcfs.ncm.AZBadvice;

import hx.code.CodeList;
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
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.pause.PauseFileHandler;
import com.dcfs.ncm.MatchAction;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.audit.MatchAuditHandler;
import com.dcfs.rfm.insteadRecord.InsteadRecordHandler;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: AZBAdviceAction.java
 * @Description: ���ò��������
 * @Company: 21softech
 * @Created on 2014-9-11 ����9:49:21
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AZBAdviceAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AZBAdviceAction.class);
    private Connection conn = null;
    private AZBAdviceHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public AZBAdviceAction() {
        this.handler=new AZBAdviceHandler();
        this.Mhandler=new MatchHandler();
        this.AFhandler=new FileCommonManager();
        this.CIhandler=new ChildManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: AZBAdviceList
     * @Description: ���ò���������б�
     * @author: xugy
     * @date: 2014-9-11����10:40:58
     * @return
     */
    public String AZBAdviceList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="MATCH_PASSDATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","FILE_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","MATCH_PASSDATE_START","MATCH_PASSDATE_END","ADVICE_NOTICE_DATE_START","ADVICE_NOTICE_DATE_END","ADVICE_PRINT_NUM","ADVICE_STATE","ADVICE_REMINDER_STATE","AF_COST_CLEAR","ADVICE_FEEDBACK_RESULT");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAZBAdviceList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toAZBPrintPreview
     * @Description: ֪ͨ���ӡԤ��ҳ��
     * @author: xugy
     * @date: 2014-11-11����2:48:49
     * @return
     */
    public String toAZBPrintPreview(){
        String MI_IDs = getParameter("ids");
        String MI_ID = MI_IDs.split("#")[1];
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����
            Data data = handler.getAdviceSignDate(conn, MI_ID);
            List<Att> list = AttHelper.findAttListByPackageId(MI_ID, AttConstants.ZQYJS, "AF");
            String ID = list.get(0).getId();
            String ATT_NAME = list.get(0).getAttName();
            String ATT_TYPE = list.get(0).getAttType();
            data.add("ID", ID);
            data.add("ATT_NAME", ATT_NAME);
            data.add("ATT_TYPE", ATT_TYPE);
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
     * @Title: AZBprint
     * @Description: ���ò����������ӡ
     * @author: xugy
     * @date: 2014-9-11����1:03:29
     * @return
     */
    public String AZBprint(){
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADVICE_SIGN_DATE");
        /*String MI_ID = getParameter("MI_ID");
        String ADVICE_SIGN_DATE = getParameter("ADVICE_SIGN_DATE");*/
        String MI_ID = MIdata.getString("MI_ID");
        String ADVICE_SIGN_DATE = MIdata.getDate("ADVICE_SIGN_DATE");
        try{
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data data = handler.getAdviceSignDate(conn, MI_ID);
            if(!(data.getDate("ADVICE_SIGN_DATE")).equals(ADVICE_SIGN_DATE)){
                /*Data MIdata = new Data();
                MIdata.add("MI_ID", MI_ID);
                MIdata.add("ADVICE_SIGN_DATE", ADVICE_SIGN_DATE);*/
                Mhandler.saveNcmMatchInfo(conn, MIdata);
                //�����������������
                MatchAction matchAction = new MatchAction();
                matchAction.letterOfSeekingConfirmation(conn, MI_ID, "1");//���������
            }
            List<Att> list = AttHelper.findAttListByPackageId(MI_ID, AttConstants.ZQYJS, "AF");
            String ID = list.get(0).getId();
            String ATT_NAME = list.get(0).getAttName();
            String ATT_TYPE = list.get(0).getAttType();
            data.add("ID", ID);
            data.add("ATT_NAME", ATT_NAME);
            data.add("ATT_TYPE", ATT_TYPE);
            
            dt.commit();
            setAttribute("data",data);
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
     * @Title: AZBnotice
     * @Description: ���ò�֪ͨ������֯
     * @author: xugy
     * @date: 2014-9-11����2:13:44
     * @return
     */
    public String AZBnotice(){
        String ids = getParameter("ids");//ƥ����ϢID
        String[] array = ids.split("#");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String MI_ID = array[i];
                String nowDate = DateUtility.getCurrentDate();
                String ADVICE_CLOSE_DATE = DateAddMonth(nowDate,3);//����õ���ֹ����
                Data MIdata = new Data();//ƥ����Ϣ����
                MIdata.add("MI_ID", MI_ID);//ƥ����ϢID
                MIdata.add("ADVICE_NOTICE_DATE", nowDate);//�������_֪ͨ����
                MIdata.add("ADVICE_CLOSE_DATE", ADVICE_CLOSE_DATE);//�������_��ֹ����
                MIdata.add("ADVICE_STATE", "2");//�������_״̬
                MIdata.add("ADVICE_REMINDER_STATE", "0");//�������_�߰�״̬
                MIdata.add("ADVICE_NOTICE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//�������_֪ͨ��ID
                MIdata.add("ADVICE_NOTICE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//�������_֪ͨ������
                handler.matchSave(conn, MIdata);
                
                Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
                String AF_ID = data.getString("AF_ID");
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data AFdata = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_TZ);
                AFdata.add("AF_ID", AF_ID);
                AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "֪ͨ������֯�ɹ�!");//����ɹ� 
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
            InfoClueTo clueTo = new InfoClueTo(2, "֪ͨ������֯ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "֪ͨ������֯ʧ��!");
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
     * @Title: DateAddMonth
     * @Description: ��ȡ��ǰ���ڵļ����º������
     * @author: xugy
     * @date: 2014-9-11����2:20:44
     * @param nowDate
     * @param months
     * @return
     */
    public String DateAddMonth(String nowDate,int months){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Date date;
        Calendar calendar = Calendar.getInstance();
        try {
            date = sdf.parse(nowDate);
            calendar.setTime(date);
            calendar.add(Calendar.MONTH, months);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return sdf.format(calendar.getTime());
    }
    /**
     * 
     * @Title: feedbackConfirm
     * @Description: ���ò�����ȷ��
     * @author: xugy
     * @date: 2014-9-12����10:51:30
     * @return
     */
    public String feedbackConfirm(){
        String MI_ID = getParameter("ids");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //��ȡ�������������
            CodeList list = handler.findCountryGovment(conn, MI_ID);
            HashMap<String,CodeList> cmap=new HashMap<String,CodeList>();
            cmap.put("COUNTRY_GOVMENT_LIST", list);
            //�������д��ҳ����ձ���
            setAttribute(Constants.CODE_LIST,cmap);
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
     * @Title: feedbackConfirmSave
     * @Description: ���ò�����ȷ�ϱ���
     * @author: xugy
     * @date: 2014-9-12����3:57:25
     * @return
     */
    public String feedbackConfirmSave(){
        String MI_ID = getParameter("Ins_MI_ID");//ƥ����ϢID
        
        Data data = getRequestEntityData("F_","ADVICE_GOV_ID","ADVICE_FEEDBACK_DATE","ADVICE_FEEDBACK_OPINION","ADVICE_FEEDBACK_RESULT","ADVICE_FEEDBACK_REMARKS");
        String ADVICE_FEEDBACK_RESULT = data.getString("ADVICE_FEEDBACK_RESULT");//�������
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data MIdata = Mhandler.getNcmMatchInfo(conn, MI_ID);
            String CI_ID = MIdata.getString("CI_ID");//��ͯ����ID
            String AF_ID = MIdata.getString("AF_ID");//�ļ�ID
            Data AFdata = new Data();//�ļ�����
            AFdata.add("AF_ID", AF_ID);
            Data CIdata = new Data();//��������
            CIdata.add("CI_ID", CI_ID);
            data.add("ADVICE_STATE", "3");//�������_״̬
            data.add("ADVICE_REMINDER_STATE", "");//�������_�߰�״̬
            data.add("ADVICE_CFM_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//�������_ȷ����ID
            data.add("ADVICE_CFM_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//�������_ȷ��������
            data.add("ADVICE_CFM_DATE", DateUtility.getCurrentDate());//�������_ȷ��������
            if("1".equals(ADVICE_FEEDBACK_RESULT)){//���ͬ�⣬�ƽ���ͯ������������
                DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//������ϸID
                transferData.add("APP_ID", CI_ID);//ҵ���¼ID
                transferData.add("TRANSFER_CODE", TransferCode.CHILDINFO_AZB_DAB);//�ƽ�����
                transferData.add("TRANSFER_STATE", "0");//�ƽ�״̬
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);//����һ���ƽ���Ϣ
                
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_AGREE);
                AFdata.addData(_data);
                
                //����ȫ��״̬��λ��
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.adviceFeedBackAgree(CIdata, SessionInfo.getCurUser().getCurOrgan());
                
                data.add("MI_ID", MI_ID);//ƥ����ϢID
                handler.matchSave(conn, data);//����ƥ������
                CIhandler.save(conn, CIdata);
                AFhandler.modifyFileInfo(conn, AFdata);//�޸������˵�ƥ����Ϣ
            }
            Data AFdataInfo = Mhandler.getAFInfoOfAfId(conn, AF_ID);
            String RI_ID = AFdataInfo.getString("RI_ID", "");//
            String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//�ļ�����
            if("2".equals(ADVICE_FEEDBACK_RESULT)){//����ļ���ͣ
                data.add("AF_ID", AF_ID);
                data.add("MATCH_STATE", "9");//ƥ��״̬����Ч
                data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//���ƥ������
                data.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//���ƥ����ID
                data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���ƥ��������
                data.add("REVOKE_MATCH_TYPE", "3");//���ƥ�����ͣ�����ƥ��
                data.add("REVOKE_MATCH_REASON", "������֯��������ļ���ͣ");//���ƥ��ԭ��
                //�޸Ĳ���ƥ��״̬
                String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//�����Ķ�ͯ����ID
                String inCI_ID = "";
                if(!"".equals(AF_CI_ID)){
                    String[] array = AF_CI_ID.split(",");
                    for(int i=0;i<array.length;i++){
                        Data everyCIdata = new Data();
                        everyCIdata.add("CI_ID", array[i]);//����ID
                        everyCIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                        CIhandler.save(conn, everyCIdata);
                        if(i==0){
                            inCI_ID = "'"+array[i]+"'";
                        }else{
                            inCI_ID = inCI_ID+",'"+array[i]+"'";                        
                        }
                    }
                }
                if("".equals(RI_ID)){//û��Ԥ��
                    AFdata.add("CI_ID", "");//�ļ���ͯ����ID
                }else{//����Ԥ��
                    DataList MCIdl = handler.getMainCIIDS(conn, inCI_ID);
                    if(MCIdl.size()>0){
                        for(int i=0;i<MCIdl.size();i++){
                            String MAIN_CI_ID = MCIdl.getData(i).getString("MAIN_CI_ID", "");
                            PublishCommonManager publishCommonManager = new PublishCommonManager();
                            publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                        }
                    }
                }
                //�޸��ļ�ƥ��״̬
                AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                    AFdata.add("FILE_TYPE", "10");
                }
                //�ļ���ͣ��Ϣ
                String PAUSE_REASON = getParameter("R_PAUSE_REASON");//��ͣԭ��
                String END_DATE = getParameter("R_END_DATE");//��ͣ����
                AFdata.add("IS_PAUSE", "1");//��ͣ��ʶ
                AFdata.add("PAUSE_DATE", DateUtility.getCurrentDate());//��ͣ����
                AFdata.add("PAUSE_REASON", PAUSE_REASON);//��ͣԭ��
                //�ļ���ͣ��¼
                Data PFdata = new Data();//�ļ���ͣ����
                PFdata.add("AP_ID", "");//�ļ���ͣ��¼ID
                PFdata.add("AF_ID", AF_ID);//�ļ�ID
                PFdata.add("PAUSE_REASON", PAUSE_REASON);//��ͣԭ��
                PFdata.add("PAUSE_DATE", DateUtility.getCurrentDate());//��ͣ����
                PFdata.add("END_DATE", END_DATE);//��ͣ����
                PFdata.add("PAUSE_UNITID", SessionInfo.getCurUser().getCurOrgan().getId());//��ͣ����ID
                PFdata.add("PAUSE_UNITNAME", SessionInfo.getCurUser().getCurOrgan().getCName());//��ͣ��������
                PFdata.add("PAUSE_USERID", SessionInfo.getCurUser().getPersonId());//��ͣ��ID
                PFdata.add("PAUSE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//��ͣ������
                PFdata.add("RECOVERY_STATE", "1");//��ͣ״̬
                PauseFileHandler pauseFileHandler = new PauseFileHandler();
                pauseFileHandler.pauseFileSave(conn, AFdata, PFdata);
                
                Mhandler.storeNcmMatchInfoOne(conn, data);
            }
            if("3".equals(ADVICE_FEEDBACK_RESULT)){//�������ƥ��
                data.add("AF_ID", AF_ID);
                data.add("MATCH_STATE", "9");//ƥ��״̬����Ч
                data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//���ƥ������
                data.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//���ƥ����ID
                data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���ƥ��������
                data.add("REVOKE_MATCH_TYPE", "3");//���ƥ�����ͣ�����ƥ��
                data.add("REVOKE_MATCH_REASON", "������֯�����������ƥ��");//���ƥ��ԭ��
                if("".equals(RI_ID)){//û��Ԥ����Ϣ��ͨ���ֶ�ƥ��,���ͯ������һ����ͬ���ֵ�
                    Mhandler.storeNcmMatchInfoOne(conn, data);
                    /****��ͯ��������ͥ���ƥ���ϵ���޸��ļ��Ͳ������״̬Begin****/
                    String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//�ļ�ƥ���ͯ��ID�����Ϊͬ����
                    if(!"".equals(AF_CI_ID)){
                        String[] array = AF_CI_ID.split(",");
                        for(int i=0;i<array.length;i++){
                            //�޸Ĳ���ƥ��״̬
                            Data everyCIdata = new Data();//��������
                            everyCIdata.add("CI_ID", array[i]);//����ID
                            everyCIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                            CIhandler.save(conn, everyCIdata);
                        }
                    }
                    //�޸��ļ�ƥ��״̬
                    AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                    AFdata.add("CI_ID", "");//�ļ���ͯ����ID�ÿ�
                    if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                        AFdata.add("FILE_TYPE", "10");
                    }
                    //�ļ�ȫ��״̬��λ��
                    FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                    Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP);
                    AFdata.addData(_data);
                    AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                    /****��ͯ��������ͥ���ƥ���ϵ���޸��ļ��Ͳ������״̬End****/
                }else{//����Ԥ����Ϣ,
                    Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
                    String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID","");//��ͯ������ͯID
                    MatchAuditHandler matchAuditHandler = new MatchAuditHandler();
                    DataList CIdl = matchAuditHandler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
                    if(CIdl.size()>0){
                        for(int i=0;i<CIdl.size();i++){
                            String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                            data.add("CI_ID", everyCiId);
                            Mhandler.storeNcmMatchInfoTwo(conn, data);//ͨ���ļ�ID����ID�޸�ƥ����Ϣ
                            
                            //�޸Ĳ���ƥ��״̬
                            Data everyCIdata = new Data();//��������
                            everyCIdata.add("CI_ID", everyCiId);//����ID
                            everyCIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                            CIhandler.save(conn, everyCIdata);
                        }
                    }
                    PublishCommonManager publishCommonManager = new PublishCommonManager();
                    publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                    
                    if(!"23".equals(FILE_TYPE)){//�ļ����Ͳ�Ϊ����˫���ģ���һ��Ԥ��
                        //�޸��ļ�ƥ��״̬
                        AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                        if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                            AFdata.add("FILE_TYPE", "10");
                        }
                        //�ļ�ȫ��״̬��λ��
                        FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                        Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP);
                        AFdata.addData(_data);
                        AFhandler.modifyFileInfo(conn, AFdata);//�޸��ļ���Ϣ
                    }
                }
            }
            if("4".equals(ADVICE_FEEDBACK_RESULT)){//������ģ����������Ϣ
                data.add("AF_ID", AF_ID);
                data.add("MATCH_STATE", "9");//ƥ��״̬����Ч
                data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//���ƥ������
                data.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//���ƥ����ID
                data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//���ƥ��������
                data.add("REVOKE_MATCH_TYPE", "1");//���ƥ�����ͣ�����
                data.add("REVOKE_MATCH_REASON", "������֯�����������");//���ƥ��ԭ��
                //�޸Ĳ���ƥ��״̬
                String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//�����Ķ�ͯ����ID
                String inCI_ID = "";
                if(!"".equals(AF_CI_ID)){
                    String[] array = AF_CI_ID.split(",");
                    for(int i=0;i<array.length;i++){
                        Data everyCIdata = new Data();
                        everyCIdata.add("CI_ID", array[i]);//����ID
                        everyCIdata.add("MATCH_STATE", "0");//����ƥ��״̬
                        CIhandler.save(conn, everyCIdata);
                        if(i==0){
                            inCI_ID = "'"+array[i]+"'";
                        }else{
                            inCI_ID = inCI_ID+",'"+array[i]+"'";                        
                        }
                    }
                }
                if("".equals(RI_ID)){//û��Ԥ��
                    AFdata.add("CI_ID", "");//�ļ���ͯ����ID
                }else{//����Ԥ��
                    DataList MCIdl = handler.getMainCIIDS(conn, inCI_ID);
                    if(MCIdl.size()>0){
                        for(int i=0;i<MCIdl.size();i++){
                            String MAIN_CI_ID = MCIdl.getData(i).getString("MAIN_CI_ID", "");
                            PublishCommonManager publishCommonManager = new PublishCommonManager();
                            publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                        }
                    }
                }
                //�޸��ļ�ƥ��״̬
                AFdata.add("MATCH_STATE", "0");//�ļ�ƥ��״̬
                if("21".equals(FILE_TYPE)){//����ļ�Ϊ��ת����Ϊ�����ļ�
                    AFdata.add("FILE_TYPE", "10");
                }
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_TW);
                AFdata.addData(_data);
                
                String RETURN_STATE = AFdataInfo.getString("RETURN_STATE", "");//����״̬
                String RETURN_REASON = getParameter("R_RETURN_REASON");//����ԭ��
                if("".equals(RETURN_STATE)){//û������
                    AFdata.add("RETURN_STATE", "0");//�ļ�����״̬����ȷ��
                    AFdata.add("RETURN_REASON", RETURN_REASON);//�ļ�����ԭ��
                    if("".equals(RETURN_STATE)){//û������
                        AFdata.add("RETURN_STATE", "0");//�ļ�����״̬����ȷ��
                        AFdata.add("RETURN_REASON", RETURN_REASON);//�ļ�����ԭ��
                        //��ȡ�ļ���Ҫ�������ļ�¼������Ϣ
                        AZBAdviceHandler AZBAH = new AZBAdviceHandler();
                        Data RFMdata = AZBAH.getRFMAFInfo(conn, AFdata.getString("AF_ID"));
                        RFMdata.add("AR_ID", "");//���ļ�¼ID
                        RFMdata.add("RETURN_REASON", RETURN_REASON);//����ԭ��
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
                
                Mhandler.storeNcmMatchInfoOne(conn, data);
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "����ȷ�ϱ���ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "����ȷ�ϱ���ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "����ȷ�ϱ���ʧ��!");
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
     * @Title: feedbackDetail
     * @Description: ����鿴
     * @author: xugy
     * @date: 2014-11-2����11:13:30
     * @return
     */
    public String feedbackDetail(){
        String MI_ID = getParameter("ids");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
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
     * @Title: reminderDetail
     * @Description: ���ò��鿴�߰�鿴
     * @author: xugy
     * @date: 2014-9-14����3:27:26
     * @return
     */
    public String reminderDetail(){
        String MI_ID = getParameter("MI_ID");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ȡ����
            Data data = handler.getMatchReminderInfo(conn, MI_ID);
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy��MM��dd��");
            SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
            
            String ADVICE_NOTICE_DATE = data.getDate("ADVICE_NOTICE_DATE");
            Date advice_notice_date = sdf.parse(ADVICE_NOTICE_DATE);
            String ADVICE_NOTICE_DATE_CN = sdfCN.format(advice_notice_date);
            data.add("ADVICE_NOTICE_DATE_CN", ADVICE_NOTICE_DATE_CN);
            String ADVICE_NOTICE_DATE_EN = sdfEN.format(advice_notice_date);
            data.add("ADVICE_NOTICE_DATE_EN", ADVICE_NOTICE_DATE_EN);
            
            String BIRTHDAY = data.getDate("BIRTHDAY");
            Date birthday_date = sdf.parse(BIRTHDAY);
            String BIRTHDAY_CN = sdfCN.format(birthday_date);
            data.add("BIRTHDAY_CN", BIRTHDAY_CN);
            String BIRTHDAY_EN = sdfEN.format(birthday_date);
            data.add("BIRTHDAY_EN", BIRTHDAY_EN);
            
            String ADVICE_CLOSE_DATE = data.getDate("ADVICE_CLOSE_DATE");
            Date advice_close_date = sdf.parse(ADVICE_CLOSE_DATE);
            String ADVICE_CLOSE_DATE_CN = sdfCN.format(advice_close_date);
            data.add("ADVICE_CLOSE_DATE_CN", ADVICE_CLOSE_DATE_CN);
            String ADVICE_CLOSE_DATE_EN = sdfEN.format(advice_close_date);
            data.add("ADVICE_CLOSE_DATE_EN", ADVICE_CLOSE_DATE_EN);
            
            String ADVICE_REMINDER_DATE = data.getDate("ADVICE_REMINDER_DATE");
            Date advice_reminder_date = sdf.parse(ADVICE_REMINDER_DATE);
            String ADVICE_REMINDER_DATE_CN = sdfCN.format(advice_reminder_date);
            data.add("ADVICE_REMINDER_DATE_CN", ADVICE_REMINDER_DATE_CN);
            String ADVICE_REMINDER_DATE_EN = sdfEN.format(advice_reminder_date);
            data.add("ADVICE_REMINDER_DATE_EN", ADVICE_REMINDER_DATE_EN);
            
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
            
        } catch (ParseException e) {
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
     * ��ʷ����������������顢��������֪ͨ�顢����֪ͨ��
     * @Title: createPDF
     * @Description: 
     * @author: xugy
     * @date: 2014-12-21����11:13:43
     * @return
     */
    public String createPDF(){
        MatchAction matchAction = new MatchAction();
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            DataList dl = handler.getMatchInfo(conn);
            if(dl.size()>0){
                for(int i=0;i<dl.size();i++){
                    String MI_ID = dl.getData(i).getString("MI_ID");
                    System.out.println(MI_ID);
                    String MATCH_STATE = dl.getData(i).getString("MATCH_STATE");
                    String SIGN_STATE = dl.getData(i).getString("SIGN_STATE");
                    String NOTICE_STATE = dl.getData(i).getString("NOTICE_STATE");
                    if("3".equals(MATCH_STATE)){
                        matchAction.letterOfSeekingConfirmation(conn, MI_ID, "0");
                        matchAction.letterOfSeekingConfirmation(conn, MI_ID, "1");
                        if("1".equals(SIGN_STATE)){
                            matchAction.noticeOfTravellingToChinaForAdoption(conn, MI_ID, "0", "1");
                            matchAction.noticeForAdoption(conn, MI_ID, "0");
                            if("1".equals(NOTICE_STATE)){
                                matchAction.noticeOfTravellingToChinaForAdoption(conn, MI_ID, "1", "0");
                                matchAction.noticeForAdoption(conn, MI_ID, "1");
                            }
                        }
                    }
                }
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "����PDF�ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "����PDFʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "����PDFʧ��!");
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
            InfoClueTo clueTo = new InfoClueTo(2, "����PDFʧ��!");
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
        return null;
    }
}
