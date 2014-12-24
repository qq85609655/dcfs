package com.dcfs.ncm.BGSnotice;

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
import java.util.ArrayList;
import java.util.List;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchAction;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.DABnotice.common.CreateArchiveNoAction;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: BGSNoticeAction.java
 * @Description: �칫��֪ͨ�����--��ӡ�ķ�
 * @Company: 21softech
 * @Created on 2014-9-15 ����4:49:13
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class BGSNoticeAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(BGSNoticeAction.class);
    private Connection conn = null;
    private BGSNoticeHandler handler;
    private MatchHandler Mhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public BGSNoticeAction() {
        this.handler=new BGSNoticeHandler();
        this.Mhandler=new MatchHandler();
    }

    @Override
    public String execute() throws Exception {
        return null;
    }
    /**
     * 
     * @Title: BGSNoticePrintList
     * @Description: �칫��֪ͨ������ӡ�ķ��б�
     * @author: xugy
     * @date: 2014-9-15����4:54:23
     * @return
     */
    public String BGSNoticePrintList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="SIGN_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_TYPE","CHILD_TYPE","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_SUBMIT_DATE_START","SIGN_SUBMIT_DATE_END","SIGN_DATE_START","SIGN_DATE_END","NOTICE_SIGN_DATE_START","NOTICE_SIGN_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","NOTICE_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findBGSNoticePrintList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: BGSNoticePrintMod
     * @Description: �޸Ĵ�ӡ
     * @author: xugy
     * @date: 2014-9-16����2:52:53
     * @return
     */
    public String BGSNoticePrintMod(){
        String MI_ID = getParameter("ids");//ƥ����ϢID
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
     * @Title: saveAndPrint
     * @Description: ��ӡ�޸ı��沢��ӡ
     * @author: xugy
     * @date: 2014-9-25����5:36:16
     * @return
     */
    public String saveAndPrint(){
        
        Data data = getRequestEntityData("MI_","MI_ID","NOTICE_SIGN_DATE");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data AIdata = handler.getArchiveId(conn, data.getString("MI_ID"));
            if(!"".equals(AIdata.getString("ARCHIVE_ID", ""))){//����ID��Ϊ�գ����ڵ�����Ϣ����֪ͨ���������´�ӡ
                data.add("NOTICECOPY_REPRINT", "1");//֪ͨ�鸱��_�Ƿ��ش�
            }
            data.add("NOTICECOPY_SIGN_DATE", data.getString("NOTICE_SIGN_DATE"));//֪ͨ�鸱��_����������
            Mhandler.saveNcmMatchInfo(conn, data);
            
            //�������ɸ���
            MatchAction matchAction = new MatchAction();
            matchAction.noticeOfTravellingToChinaForAdoption(conn, data.getString("MI_ID"), "0", "1");//����������Ů֪ͨ��
            matchAction.noticeForAdoption(conn, data.getString("MI_ID"), "0");//��������֪ͨ
            if(!"".equals(AIdata.getString("ARCHIVE_ID", ""))){//����ID��Ϊ�գ����ڵ�����Ϣ�����޸�֪ͨ�鸱��
                matchAction.noticeOfTravellingToChinaForAdoption(conn, data.getString("MI_ID"), "1", "0");//����������Ů֪ͨ��
                matchAction.noticeForAdoption(conn, data.getString("MI_ID"), "1");//��������֪ͨ
            }
            ArrayList<Att> arraylist = new ArrayList<Att>();
            List<Att> list1 = AttHelper.findAttListByPackageId(data.getString("MI_ID"), AttConstants.LHSYZNTZS, "AF");
            arraylist.addAll(list1);
            List<Att> list2 = AttHelper.findAttListByPackageId(data.getString("MI_ID"), AttConstants.SWSYTZ, "AF");
            arraylist.addAll(list2);
            
            dt.commit();
            setAttribute("list", arraylist);
            setAttribute("MI_ID", data.getString("MI_ID"));
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
            // TODO Auto-generated catch block
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
     * @Title: toPrint
     * @Description: �б�ҳ���ӡ��ť
     * @author: xugy
     * @date: 2014-11-13����1:49:58
     * @return
     */
    public String toPrint(){
        String type = getParameter("type");
        String MI_ID = getParameter("ids","");//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            DataList MIIDdl = new DataList();
            if("".equals(MI_ID)){
                if("0".equals(type)){
                    MIIDdl = handler.getPrintInfoId(conn, "af.ADOPT_ORG_ID ASC");
                }
                if("1".equals(type)){
                    MIIDdl = handler.getPrintInfoId(conn, "ci.PROVINCE_ID ASC");
                }
            }else{
                String ids = "";
                String[] arry = MI_ID.split("#");
                for(int i=1;i<arry.length;i++){
                    if(i == 1){
                        ids = "'"+arry[i]+"'";
                    }else{
                        ids = ids+",'"+arry[i]+"'";
                    }
                }
                if("0".equals(type)){
                    MIIDdl = handler.getIdInId(conn, ids, "af.ADOPT_ORG_ID ASC");
                }
                if("1".equals(type)){
                    MIIDdl = handler.getIdInId(conn, ids, "ci.PROVINCE_ID ASC");
                }
            }
            ArrayList<Att> arraylist = new ArrayList<Att>();
            String ids = "";
            if(MIIDdl.size()>0){
                for(int i=0;i<MIIDdl.size();i++){
                    String packageId = MIIDdl.getData(i).getString("MI_ID");
                    List<Att> list = new ArrayList<Att>();
                    if("0".equals(type)){
                        list = AttHelper.findAttListByPackageId(packageId, AttConstants.LHSYZNTZS, "AF");
                    }
                    if("1".equals(type)){
                        list = AttHelper.findAttListByPackageId(packageId, AttConstants.SWSYTZ, "AF");
                    }
                    if(list != null){
                        arraylist.addAll(list);
                    }
                    if(i == 0){
                        ids = packageId;
                    }else{
                        ids = ids + "," + packageId;
                    }
                    
                }
            }
            //�������д��ҳ����ձ���
            setAttribute("list",arraylist);
            setAttribute("MI_ID",ids);
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
     * @Title: BGSNoticeSend
     * @Description: �칫�Ҽķ�֪ͨ��
     * @author: xugy
     * @date: 2014-9-16����3:36:50
     * @return
     */
    public String BGSNoticeSend(){
        String ids = getParameter("ids");//ƥ����ϢID
        String[] array = ids.split("#");
        
        String NOTICE_DATE = getParameter("NOTICE_DATE");//�ķ�����
        
        
        /*GetWord getWord = new GetWord();
        String path1 = CommonConfig.getProjectPath() + "/tempFile/�����Ǽ�������.doc";
        String path2 = CommonConfig.getProjectPath() + "/tempFile/�����Ǽ�֤.doc";
        String path3 = CommonConfig.getProjectPath() + "/tempFile/��������ϸ�֤��.doc";*/
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String MI_ID = array[i];
                Data MIdata = new Data();//ƥ����Ϣ����
                MIdata.add("MI_ID", MI_ID);//ƥ����ϢID
                MIdata.add("NOTICE_DATE", NOTICE_DATE);//֪ͨ��_�ķ�����
                MIdata.add("NOTICE_STATE", "1");//֪ͨ��_֪ͨ״̬
                MIdata.add("NOTICE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//֪ͨ��_֪ͨ��ID
                MIdata.add("NOTICE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//֪ͨ��_֪ͨ������
                MIdata.add("NOTICECOPY_PRINT_NUM", "0");//֪ͨ�鸱����ӡ����
                MIdata.add("NOTICECOPY_REPRINT", "0");//֪ͨ�鸱���Ƿ��ش򣺷�
                MIdata.add("ADREG_STATE", "0");//�����Ǽ�_�Ǽ�״̬
                Mhandler.saveNcmMatchInfo(conn, MIdata);
                
                MatchHandler MHandler = new MatchHandler();
                Data _MIdata = MHandler.getNcmMatchInfo(conn, MI_ID);
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.BGS_TZS_JF);
                String AF_ID = _MIdata.getString("AF_ID");
                _data.add("AF_ID", AF_ID);
                FileCommonManager AFhandler = new FileCommonManager();
                AFhandler.modifyFileInfo(conn, _data);//�޸������˵�ƥ����Ϣ
                
                //����ȫ��״̬��λ��
                Data CIdata = new Data();
                String CI_ID = _MIdata.getString("CI_ID");
                CIdata.add("CI_ID", CI_ID);
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.noticeIsSent(CIdata, SessionInfo.getCurUser().getCurOrgan());
                ChildManagerHandler childManagerHandler = new ChildManagerHandler();
                childManagerHandler.save(conn, CIdata);
                //���ɸ���Ҫ�жϵ���Ϣ
                //Data attData = handler.getAttInfo(conn, MI_ID);
                //���������Ǽ�������
                /*getWord.createDoc(conn, MI_ID,"sydjsqs.ftl","hx.word.data.impl.GetWordSydjsqsImpl",path1);
                File file1 = new File(path1);
                if(file1.exists()){
                    AttHelper.delAttsOfPackageId(MI_ID, AttConstants.SYDJSQS, "AF");//ɾ��ԭ����
                    
                    AttHelper.manualUploadAtt(file1, "AF", MI_ID, "�����Ǽ�������.doc", AttConstants.SYDJSQS, "AF", AttConstants.SYDJSQS, MI_ID);
                    file1.delete();//ɾ��ԭ�����ɵ������Ǽ�������
                }
                //���������Ǽ�֤
                getWord.createDoc(conn, MI_ID,"sydjz.ftl","hx.word.data.impl.GetWordSydjzImpl",path2);
                File file2 = new File(path2);
                if(file2.exists()){
                    AttHelper.delAttsOfPackageId(MI_ID, AttConstants.SYDJZ, "AF");//ɾ��ԭ����
                    
                    AttHelper.manualUploadAtt(file2, "AF", MI_ID, "�����Ǽ�֤.doc", AttConstants.SYDJZ, "AF", AttConstants.SYDJZ, MI_ID);
                    file2.delete();//ɾ��ԭ�����ɵ������Ǽ�֤
                }
                String IS_CONVENTION_ADOPT = attData.getString("IS_CONVENTION_ADOPT", "");//��Լ����
                if("1".equals(IS_CONVENTION_ADOPT)){//��Լ���������ɿ�������ϸ�֤��
                    getWord.createDoc(conn, MI_ID,"syhgzm.ftl","hx.word.data.impl.GetWordSyhgzmImpl",path3);
                    File file3 = new File(path3);
                    if(file3.exists()){
                        AttHelper.delAttsOfPackageId(MI_ID, AttConstants.KGSYHGZM, "AF");//ɾ��ԭ����
                        
                        AttHelper.manualUploadAtt(file3, "AF", MI_ID, "��������ϸ�֤��.doc", AttConstants.KGSYHGZM, "AF", AttConstants.KGSYHGZM, MI_ID);
                        file3.delete();//ɾ��ԭ�����ɵĿ�������ϸ�֤��
                    }
                }*/
                
                Data data = handler.getArchiveSaveInfo(conn, MI_ID);
                CreateArchiveNoAction CAN = new CreateArchiveNoAction();
                String ARCHIVE_NO = CAN.createArchiveNo(conn);
                data.add("ARCHIVE_ID", "");//������ϢID
                data.add("ARCHIVE_NO", ARCHIVE_NO);//������
                data.add("ARCHIVE_NO_DATE", DateUtility.getCurrentDate());//��������������
                data.add("ARCHIVE_STATE", "0");//�鵵״̬:δ�鵵
                data.add("ARCHIVE_VALID", "1");//�Ƿ���Ч:��
                Mhandler.saveNcmArchiveInfo(conn, data);
                
                MatchAction matchAction = new MatchAction();
                //����������Ů֪ͨ�鸱��
                matchAction.noticeOfTravellingToChinaForAdoption(conn, MI_ID, "1", "0");
                //��������֪ͨ����
                matchAction.noticeForAdoption(conn, MI_ID, "1");
                
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "֪ͨ��ķ��ɹ�!");//����ɹ� 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "֪ͨ��ķ�ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "֪ͨ��ķ�ʧ��!");
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
            InfoClueTo clueTo = new InfoClueTo(2, "֪ͨ��ķ�ʧ��!");
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
    
}
