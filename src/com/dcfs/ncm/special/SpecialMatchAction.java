package com.dcfs.ncm.special;

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
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.common.PublishCommonManagerHandler;
import com.hx.framework.authenticate.SessionInfo;

/**
 * 
 * @Title: SpecialMatchAction.java
 * @Description: �����ͯƥ��
 * @Company: 21softech
 * @Created on 2014-9-6 ����10:27:32
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SpecialMatchAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(SpecialMatchAction.class);
    private Connection conn = null;
    private SpecialMatchHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public SpecialMatchAction() {
        this.handler=new SpecialMatchHandler();
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
     * @Title: AFSpecialMatchList
     * @Description: �����ļ�����ƥ���б�
     * @author: xugy
     * @date: 2014-9-6����10:17:59
     * @return
     */
    public String AFSpecialMatchList(){
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
        String result = getParameter("result","");
        if("0".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(0, "ƥ��ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);//set�����������
        }
        if("2".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(2, "ƥ��ʧ�ܻ��������ƥ�䣬������ƥ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);//set�����������
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","MATCH_RECEIVEDATE_START","MATCH_RECEIVEDATE_END","FILE_TYPE","ADOPT_REQUEST_CN","UNDERAGE_NUM","MATCH_NUM","MATCH_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAFSpecialMatchList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: CISpecialMatchList
     * @Description: ѡ�������ͯ�б�
     * @author: xugy
     * @date: 2014-9-6����11:10:08
     * @return
     */
    public String CISpecialMatchList(){
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
        InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
        setAttribute("clueTo", clueTo);//set�����������
        String AFid = getParameter("AFid");//ѡ����������ļ���ID
        
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","CHECKUP_DATE_START","CHECKUP_DATE_END","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END");//��ѯ����
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data AFdata=Mhandler.getAFInfoOfAfId(conn, AFid);//��ȡѡ����������ļ���Ϣ
            String nowYear = DateUtility.getCurrentYear();
            //������������
            if(!"".equals(AFdata.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = AFdata.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                AFdata.add("MALE_AGE", maleAge);
            }
            //Ů����������
            if(!"".equals(AFdata.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = AFdata.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                AFdata.add("FEMALE_AGE", femaleAge);
            }
            data.addData(AFdata);
            //5 ��ȡ����DataList
            DataList CIdl=handler.findCISpecialMatchList(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("CIdl",CIdl);
            setAttribute("AFid",AFid);
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
     * @Title: specialMatchPreview
     * @Description: 
     * @author: xugy
     * @date: 2014-9-6����12:03:19
     * @return
     */
    public String specialMatchPreview(){
        String CIid = getParameter("CIid");//ƥ���ͯID
        String AFid = getParameter("AFid");//ƥ��������ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //��ѯ��������Ϣ
            Data data = Mhandler.getAFInfoOfAfId(conn, AFid);
            
            //�������д��ҳ����ձ���
            setAttribute("AFid",AFid);
            setAttribute("CIid",CIid);
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
     * @Title: saveSpecialMatchResult
     * @Description: ��������ƥ����
     * @author: xugy
     * @date: 2014-9-6����2:00:06
     * @return
     */
    public String saveSpecialMatchResult(){
        String AFid = getParameter("AFid");//�������ļ�ID
        String Ins_ADOPT_ORG_ID = getParameter("Ins_ADOPT_ORG_ID");//������֯ID
        String CIid = getParameter("CIid");//��ͯ����ID
        String CIids = CIid;
        String MATCH_SEASON = getParameter("Ins_MATCH_SEASON");//ƥ��ԭ��
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data FUdata = Mhandler.selectMatchStateForUpdate(conn, AFid, CIid);
            String AF_MATCH_STATE = FUdata.getString("AF_MATCH_STATE", "");
            String CI_MATCH_STATE = FUdata.getString("CI_MATCH_STATE", "");
            if(!"1".equals(AF_MATCH_STATE) && !"1".equals(CI_MATCH_STATE)){
                //ͬ����ͯ����
                String TWINS_IDS = Mhandler.getCIInfoOfCiId(conn, CIid).getString("TWINS_IDS", "");
                if(!"".equals(TWINS_IDS)){
                    String[] childNoArry = TWINS_IDS.split(",");
                    for(int i=0;i<childNoArry.length;i++){
                        String childNo = childNoArry[i];
                        String CI_ID = Mhandler.getCiIdOfChildNo(conn, childNo);
                        CIids = CIids + "," + CI_ID;
                    }
                }
                String[] ciIdArry = CIids.split(",");
                
                for(int i=0;i<ciIdArry.length;i++){
                    Data data = new Data();
                    data.add("MI_ID", "");//ƥ����ϢID
                    data.add("ADOPT_ORG_ID", Ins_ADOPT_ORG_ID);//������֯ID
                    data.add("AF_ID", AFid);//�����ļ�ID
                    data.add("CI_ID", ciIdArry[i]);//��ͯ����ID
                    data.add("CHILD_TYPE", "2");//��ͯ����
                    data.add("MATCH_SEASON", MATCH_SEASON);//ƥ��ԭ��
                    data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//ƥ����ID
                    data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//ƥ��������
                    data.add("MATCH_DATE", DateUtility.getCurrentDate());//ƥ������
                    data.add("MATCH_STATE", "0");//ƥ��״̬
                    //����ƥ����
                    Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                    String MI_ID = MIdata.getString("MI_ID");//ƥ����ϢID
                    //����һ��ƥ����˼�¼��Ϣ
                    Data MAdata = new Data();//ƥ����˼�¼����
                    MAdata.add("MAU_ID", "");//ƥ����˼�¼ID
                    MAdata.add("MI_ID", MI_ID);//ƥ����ϢID
                    MAdata.add("AUDIT_LEVEL", "0");//��˼��𣺾��������
                    MAdata.add("OPERATION_STATE", "0");//����״̬��������
                    Mhandler.saveNcmMatchAudit(conn, MAdata);
                    
                    //��ѯ��ͯ��Ϣ���Ա���ƥ��������޸Ķ�ͯ��ƥ����Ϣ
                    Data CIdata = Mhandler.getCIInfoOfCiId(conn, ciIdArry[i]);
                    String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                    int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//��ͯƥ�������һ
                    Data CIStateData = new Data();//��ͯƥ������
                    CIStateData.add("CI_ID", ciIdArry[i]);//��ͯ����ID
                    CIStateData.add("MATCH_NUM", ci_num);//��ͯ����ƥ�����
                    CIStateData.add("MATCH_STATE", "1");//��ͯ����ƥ��״̬
                    //����ȫ��״̬��λ��
                    ChildCommonManager childCommonManager = new ChildCommonManager();
                    CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                    CIhandler.save(conn, CIStateData);
                }
                //��ѯ��������Ϣ���Ա���ƥ��������޸������˵�ƥ����Ϣ
                Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
                String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
                int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//������ƥ�������һ
                Data AFStateData = new Data();//������ƥ������
                AFStateData.add("AF_ID", AFid);//�������ļ�ID
                AFStateData.add("MATCH_NUM", af_num);//������ƥ�����
                AFStateData.add("MATCH_STATE", "1");//������ƥ��״̬
                AFStateData.add("CI_ID", CIid);//��ͯ����ID
                
                if(ciIdArry.length>1){//���ƥ���ͯ���ˣ��޸��������ļ���Ӧ�ɽ������״̬
                    int num = ciIdArry.length;
                    FileCommonManager fileCommonManager = new FileCommonManager();
                    int cost = fileCommonManager.getAfCost(conn, "TXWJFWF");
                    int AF_COST = cost * num;
                    if(AF_COST > AFdata.getInt("AF_COST")){
                        AFStateData.add("AF_COST", AF_COST);//������Ӧ�ɽ��
                        AFStateData.add("AF_COST_CLEAR", "0");//���������״̬
                    }
                    
                }
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_TXYW_PP_SUBMIT);
                AFStateData.addData(data);
                
                AFhandler.modifyFileInfo(conn, AFStateData);//�޸��ļ���Ϣ
                String result = "0";
                setAttribute("result", result);
            }else{
                String result = "2";
                setAttribute("result", result);
            }
            dt.commit();
        }catch (DBException e) {
            //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��Ǽǲ�ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //�������ҳ����ʾ
            //InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
            String result = "2";
            setAttribute("result", result);
            //retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            //InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            //setAttribute("clueTo", clueTo);
            String result = "2";
            setAttribute("result", result);
            //retValue = "error2";
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
        return SUCCESS;
    }
    
    /**
     * ����ƥ�䱣��ӿ�
     * @Title: saveMatchInfo
     * @Description: ����ƥ����Ϣ
     * @author: xugy
     * @date: 2014-9-22����3:23:07
     * @param AFid �������ļ�ID
     * @return
     * @throws DBException 
     */
    public String saveMatchInfo(Connection conn, DataList AFidList) throws DBException{
        
        //��ȡ��������Ϣ
        for(int i=0;i<AFidList.size();i++){
            Data AFStateData = new Data();//������ƥ������
            String AFid = AFidList.getData(i).getString("APP_ID");
            Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
            //�ж��ļ���Ԥ����Ϣ_Ԥ����¼ID�Ƿ���ֵ
            String RI_ID = AFdata.getString("RI_ID", "");
            if(!"".equals(RI_ID)){//����Ԥ���������ƥ����Ϣ
                String ADOPT_ORG_ID = AFdata.getString("ADOPT_ORG_ID");
                String CI_ID = AFdata.getString("CI_ID");
                String[] CIids = CI_ID.split(",");
                
                for(int j=0;j<CIids.length;j++){
                    Data data = new Data();
                    data.add("MI_ID", "");//ƥ����ϢID
                    data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);//������֯ID
                    data.add("AF_ID", AFid);//�����ļ�ID
                    data.add("CI_ID", CIids[j]);//��ͯ����ID
                    data.add("CHILD_TYPE", "2");//��ͯ����
                    data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//ƥ����ID
                    data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//ƥ��������
                    data.add("MATCH_DATE", DateUtility.getCurrentDate());//ƥ������
                    data.add("MATCH_STATE", "0");//ƥ��״̬
                    //����ƥ����
                    Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                    String MI_ID = MIdata.getString("MI_ID");//ƥ����ϢID
                    //����һ��ƥ����˼�¼��Ϣ
                    Data MAdata = new Data();//ƥ����˼�¼����
                    MAdata.add("MAU_ID", "");//ƥ����˼�¼ID
                    MAdata.add("MI_ID", MI_ID);//ƥ����ϢID
                    MAdata.add("AUDIT_LEVEL", "0");//��˼��𣺾��������
                    MAdata.add("OPERATION_STATE", "0");//����״̬��������
                    Mhandler.saveNcmMatchAudit(conn, MAdata);
                    
                    //��ѯ��ͯ��Ϣ���Ա���ƥ��������޸Ķ�ͯ��ƥ����Ϣ
                    Data CIdata = Mhandler.getCIInfoOfCiId(conn, CIids[j]);
                    String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                    int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//��ͯƥ�������һ
                    Data CIStateData = new Data();//��ͯƥ������
                    CIStateData.add("CI_ID", CIids[j]);//��ͯ����ID
                    CIStateData.add("MATCH_NUM", ci_num);//��ͯ����ƥ�����
                    CIStateData.add("MATCH_STATE", "1");//��ͯ����ƥ��״̬
                    CIStateData.add("PUB_STATE", "4");//��ͯ���Ϸ���״̬
                    //����ȫ��״̬��λ��
                    ChildCommonManager childCommonManager = new ChildCommonManager();
                    CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                    CIhandler.save(conn, CIStateData);
                }
                //��ѯ��������Ϣ���Ա���ƥ��������޸������˵�ƥ����Ϣ
                String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
                int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//������ƥ�������һ
                AFStateData.add("AF_ID", AFid);//�������ļ�ID
                AFStateData.add("MATCH_NUM", af_num);//������ƥ�����
                AFStateData.add("MATCH_STATE", "1");//������ƥ��״̬
                AFStateData.add("MATCH_RECEIVEDATE", DateUtility.getCurrentDate());//�����������ļ�����
                AFStateData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);//Ԥ����Ϣ_Ԥ��״̬
                
                //�޸�Ԥ����¼��Ԥ��״̬
                String[] arry = RI_ID.split(",");
                for(int j=0;j<arry.length;j++){
                    Data RIStateData = new Data();//Ԥ����¼
                    RIStateData.add("RI_ID", arry[j]);//Ԥ��������ϢID
                    RIStateData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);//Ԥ��״̬
                    PublishCommonManagerHandler publishCommonManagerHandler = new PublishCommonManagerHandler();
                    publishCommonManagerHandler.saveRIData(conn, RIStateData);
                }
                
                if(CIids.length>1){//���ƥ���ͯ���ˣ��޸��������ļ���Ӧ�ɽ������״̬
                    int num = CIids.length;
                    FileCommonManager fileCommonManager = new FileCommonManager();
                    int cost = fileCommonManager.getAfCost(conn, "TXWJFWF");
                    int AF_COST = cost * num;
                    if(AF_COST > AFdata.getInt("AF_COST")){
                        AFStateData.add("AF_COST", AF_COST);//������Ӧ�ɽ��
                        AFStateData.add("AF_COST_CLEAR", "0");//���������״̬
                    }
                }
                
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_TXYW_PP_SUBMIT);
                AFStateData.addData(data);
                
            }else{
                AFStateData.add("AF_ID", AFid);//�������ļ�ID
                AFStateData.add("MATCH_STATE", "0");//������ƥ��״̬
                AFStateData.add("MATCH_NUM", "0");//ƥ����Ϣ_ƥ�����
                AFStateData.add("MATCH_RECEIVEDATE", DateUtility.getCurrentDate());//�����������ļ�����
            }
            AFhandler.modifyFileInfo(conn, AFStateData);//�޸������˵�ƥ����Ϣ
        }
        return retValue;
    }
    /**
     * �ӿ�
     * @Title: saveMatchInfoForSYZZ
     * @Description: ������֯�ύԤ������ƥ����Ϣ
     * @author: xugy
     * @date: 2014-11-17����2:01:08
     * @param conn
     * @param AFidList
     * @return
     * @throws DBException
     */
    public String saveMatchInfoForSYZZ(Connection conn, DataList AFidList) throws DBException{
        //��ȡ��������Ϣ
        for(int i=0;i<AFidList.size();i++){
            String AFid = AFidList.getData(i).getString("AF_ID");
            Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
            
            String ADOPT_ORG_ID = AFdata.getString("ADOPT_ORG_ID");
            String CI_ID = AFidList.getData(i).getString("CI_ID");
            String CIids = CI_ID;
            //ͬ����ͯ����
            String TWINS_IDS = Mhandler.getCIInfoOfCiId(conn, CI_ID).getString("TWINS_IDS", "");
            if(!"".equals(TWINS_IDS)){
                String[] childNoArry = TWINS_IDS.split(",");
                for(int k=0;k<childNoArry.length;k++){
                    String childNo = childNoArry[k];
                    String CIID = Mhandler.getCiIdOfChildNo(conn, childNo);
                    CIids = CIids + "," + CIID;
                }
            }
            String[] ciIdArry = CIids.split(",");
            
            for(int j=0;j<ciIdArry.length;j++){
                Data data = new Data();
                data.add("MI_ID", "");//ƥ����ϢID
                data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);//������֯ID
                data.add("AF_ID", AFid);//�����ļ�ID
                data.add("CI_ID", ciIdArry[j]);//��ͯ����ID
                data.add("CHILD_TYPE", "2");//��ͯ����
                data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//ƥ����ID
                data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//ƥ��������
                data.add("MATCH_DATE", DateUtility.getCurrentDate());//ƥ������
                data.add("MATCH_STATE", "0");//ƥ��״̬
                //����ƥ����
                Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                String MI_ID = MIdata.getString("MI_ID");//ƥ����ϢID
                //����һ��ƥ����˼�¼��Ϣ
                Data MAdata = new Data();//ƥ����˼�¼����
                MAdata.add("MAU_ID", "");//ƥ����˼�¼ID
                MAdata.add("MI_ID", MI_ID);//ƥ����ϢID
                MAdata.add("AUDIT_LEVEL", "0");//��˼��𣺾��������
                MAdata.add("OPERATION_STATE", "0");//����״̬��������
                Mhandler.saveNcmMatchAudit(conn, MAdata);
                
                //��ѯ��ͯ��Ϣ���Ա���ƥ��������޸Ķ�ͯ��ƥ����Ϣ
                Data CIdata = Mhandler.getCIInfoOfCiId(conn, ciIdArry[j]);
                String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//��ͯƥ�������һ
                Data CIStateData = new Data();//��ͯƥ������
                CIStateData.add("CI_ID", ciIdArry[j]);//��ͯ����ID
                CIStateData.add("MATCH_NUM", ci_num);//��ͯ����ƥ�����
                CIStateData.add("MATCH_STATE", "1");//��ͯ����ƥ��״̬
                CIStateData.add("PUB_STATE", "4");//��ͯ���Ϸ���״̬
                //����ȫ��״̬��λ��
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                CIhandler.save(conn, CIStateData);
            }
            //��ѯ��������Ϣ���Ա���ƥ��������޸������˵�ƥ����Ϣ
            Data AFStateData = new Data();//������ƥ������
            String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
            int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//������ƥ�������һ
            AFStateData.add("AF_ID", AFid);//�������ļ�ID
            AFStateData.add("MATCH_NUM", af_num);//������ƥ�����
            AFStateData.add("MATCH_STATE", "1");//������ƥ��״̬
            
            if(ciIdArry.length>1){//���ƥ���ͯ���ˣ��޸��������ļ���Ӧ�ɽ������״̬
                int num = ciIdArry.length;
                FileCommonManager fileCommonManager = new FileCommonManager();
                int cost = fileCommonManager.getAfCost(conn, "TXWJFWF");
                int AF_COST = cost * num;
                if(AF_COST > AFdata.getInt("AF_COST")){
                    AFStateData.add("AF_COST", AF_COST);//������Ӧ�ɽ��
                    AFStateData.add("AF_COST_CLEAR", "0");//���������״̬
                }
            }
            //�ļ�ȫ��״̬��λ��
            FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
            Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_TXYW_PP_SUBMIT);
            AFStateData.addData(data);
            
            AFhandler.modifyFileInfo(conn, AFStateData);//�޸������˵�ƥ����Ϣ
        }
        return retValue;
        
    }

}
