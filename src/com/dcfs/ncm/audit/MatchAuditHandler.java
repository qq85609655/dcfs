package com.dcfs.ncm.audit;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

import com.dcfs.ncm.MatchHandler;


/**
 * 
 * @Title: MatchAuditHandler.java
 * @Description: ƥ�����
 * @Company: 21softech
 * @Created on 2014-9-6 ����3:38:44
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MatchAuditHandler extends BaseHandler {
    
    private MatchHandler Mhandler;
    public MatchAuditHandler() {
        this.Mhandler=new MatchHandler();
    }
    
    /**
     * 
     * @Title: findMatchAuditList
     * @Description: ƥ������б�
     * @author: xugy
     * @date: 2014-9-6����5:01:24
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMatchAuditList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //��ʼ��������
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //������������
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //�ļ�����
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //ƥ�����
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String OPERATION_STATE = data.getString("OPERATION_STATE", null);   //����״̬
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //ƥ��״̬
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='0'";
        }else if("99".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE IN ('0','1','3','4','9')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
        }
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findMatchAuditList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, MATCH_NUM, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, OPERATION_STATE, MATCH_STATE,compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getMatchAudit
     * @Description: �����Ϣ
     * @author: xugy
     * @date: 2014-9-9����4:31:39
     * @param conn
     * @param MAU_ID
     * @return
     * @throws DBException 
     */
    public Data getMatchAudit(Connection conn, String AUDIT_LEVEL, String MAU_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchAudit", AUDIT_LEVEL, MAU_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getJBRAuditInfo
     * @Description: �����������Ϣ
     * @author: xugy
     * @date: 2014-9-10����3:41:59
     * @param conn
     * @param MIid
     * @return
     * @throws DBException
     */
    public Data getJBRAuditInfo(Connection conn, String MIid) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getJBRAuditInfo", MIid);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getBMZRAuditInfo
     * @Description: �������������Ϣ
     * @author: xugy
     * @date: 2014-9-10����3:43:24
     * @param conn
     * @param MIid
     * @return
     * @throws DBException
     */
    public Data getBMZRAuditInfo(Connection conn, String MIid) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getBMZRAuditInfo", MIid);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    
    /**
     * 
     * @Title: getMatchAuditOnly
     * @Description: 
     * @author: xugy
     * @date: 2014-12-21����9:28:52
     * @param conn
     * @param AUDIT_LEVEL
     * @param MAU_ID
     * @return
     * @throws DBException
     */
    public Data getMatchAuditOnly(Connection conn, String AUDIT_LEVEL, String MAU_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchAuditOnly", AUDIT_LEVEL, MAU_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getAllAFMatchInfo
     * @Description: ����������ƥ����Ϣ
     * @author: xugy
     * @date: 2014-9-10����2:19:50
     * @param conn
     * @param AF_ID
     * @return
     * @throws DBException 
     */
    public DataList getAllAFMatchInfo(Connection conn, String AF_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAllAFMatchInfo", AF_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            for(int i=0;i<dl.size();i++){
                String CIid = dl.getData(i).getString("CI_ID");//��ͯID
                Data CIdata = Mhandler.getCIInfoOfCiId(conn, CIid);//��ͯ��Ϣ
                dl.getData(i).addData(CIdata);
                //�����������Ϣ
                String MIid = dl.getData(i).getString("MI_ID");//ƥ����ϢID
                Data JBRdata = getJBRAuditInfo(conn, MIid);
                dl.getData(i).addData(JBRdata);
                //�������������Ϣ
                Data BMZRdata = getBMZRAuditInfo(conn, MIid);
                dl.getData(i).addData(BMZRdata);
            }
        }
        return dl;
    }
    /**
     * 
     * @Title: getAllCIMatchInfo
     * @Description: ��ͯ����ƥ����Ϣ
     * @author: xugy
     * @date: 2014-9-10����3:50:46
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException 
     */
    public DataList getAllCIMatchInfo(Connection conn, String CI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAllCIMatchInfo", CI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            for(int i=0;i<dl.size();i++){
                String AFid = dl.getData(i).getString("AF_ID");//������ID
                Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);//��������Ϣ
                dl.getData(i).addData(AFdata);
                //�����������Ϣ
                String MIid = dl.getData(i).getString("MI_ID");//ƥ����ϢID
                Data JBRdata = getJBRAuditInfo(conn, MIid);
                dl.getData(i).addData(JBRdata);
                //�������������Ϣ
                Data BMZRdata = getBMZRAuditInfo(conn, MIid);
                dl.getData(i).addData(BMZRdata);
            }
        }
        return dl;
    }
    /**
     * 
     * @Title: getTendingAndOpinion
     * @Description: ����ĸ����ƻ�����֯���
     * @author: xugy
     * @date: 2014-10-31����1:40:20
     * @param conn
     * @param MAIN_CI_ID
     * @return
     * @throws DBException 
     */
    public Data getTendingAndOpinion(Connection conn, String MAIN_CI_ID, String CI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTendingAndOpinion", MAIN_CI_ID);
        //System.out.println(sql);
        DataList dl = ide.find(sql);
        Data data = new Data();
        if(dl.size()>0){
            data = dl.getData(0);
        }
        String CIsql = getSql("getTendingAndOpinionCI", CI_ID);
        DataList CIdl = ide.find(CIsql);
        Data CIdata = new Data();
        if(CIdl.size()>0){
            CIdata = CIdl.getData(0);
        }
        data.addData(CIdata);
        return data;
    }
    
    /**
     * 
     * @Title: findMatchAuditAgainList
     * @Description: �����б�
     * @author: xugy
     * @date: 2014-9-9����7:17:54
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMatchAuditAgainList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //��ʼ��������
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //������������
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //�ļ�����
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //ƥ�����
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String OPERATION_STATE = data.getString("OPERATION_STATE", null);   //����״̬
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //ƥ��״̬
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='1'";
        }else if("99".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE IN ('0','1','3','4','9')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
        }
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findMatchAuditAgainList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, MATCH_NUM, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, OPERATION_STATE, MATCH_STATE,compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getMatchAudit1
     * @Description: �����������Ϣ
     * @author: xugy
     * @date: 2014-9-9����7:40:46
     * @param conn
     * @param mAU_ID
     * @return
     * @throws DBException 
     */
    public Data getMatchAuditForJBR(Connection conn, String MAU_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchAuditForJBR" , MAU_ID);
        System.out.println(sql);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
            
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getAllMatchState
     * @Description: ��ȡƥ����Ϣ�ĸ���״̬
     * @author: xugy
     * @date: 2014-9-29����10:19:36
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getAllMatchState(Connection conn, String MI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAllMatchState" , MI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getArchiveId
     * @Description: ��ȡ������������ID
     * @author: xugy
     * @date: 2014-9-29����2:41:46
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getArchiveInfo(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getArchiveInfo" , MI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getCIInfoOfMainCiId
     * @Description: ���ݶ�ͯ����ID��ȡ��Ϣ
     * @author: xugy
     * @date: 2014-12-16����11:49:02
     * @param conn
     * @param MAIN_CI_ID
     * @return
     * @throws DBException 
     */
    public DataList getCIInfoOfMainCiId(Connection conn, String MAIN_CI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIInfoOfMainCiId" , MAIN_CI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getCIPosition
     * @Description: ����λ��
     * @author: xugy
     * @date: 2014-12-17����5:49:50
     * @param conn
     * @param MAIN_CI_ID
     * @return
     * @throws DBException 
     */
    public DataList getCIPosition(Connection conn, String MAIN_CI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIPosition" , MAIN_CI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getTransferInfoDetail
     * @Description: 
     * @author: xugy
     * @date: 2014-12-17����6:47:53
     * @param conn
     * @param everyCiId
     * @return
     * @throws DBException
     */
    public Data getTransferInfoDetail(Connection conn, String everyCiId) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTransferInfoDetail" , everyCiId);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getTransferInfo
     * @Description: 
     * @author: xugy
     * @date: 2014-12-17����7:05:20
     * @param conn
     * @param TI_ID
     * @return
     * @throws DBException
     */
    public Data getTransferInfo(Connection conn, String TI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTransferInfo" , TI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: deleteTransferInfoDetail
     * @Description: ɾ��
     * @author: xugy
     * @date: 2014-12-17����7:05:30
     * @param conn
     * @param TID_ID
     * @throws DBException 
     */
    public void deleteTransferInfoDetail(Connection conn, String TID_ID) throws DBException {
        IDataExecute ide=DataBaseFactory.getDataBase(conn);
        Data data=new Data();
        data.setConnection(conn);
        data.setEntityName("TRANSFER_INFO_DETAIL");
        data.setPrimaryKey("TID_ID");
        data.add("TID_ID", TID_ID);
        ide.remove(data);
    }
}
