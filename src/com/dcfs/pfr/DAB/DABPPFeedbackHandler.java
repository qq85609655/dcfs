package com.dcfs.pfr.DAB;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
/**
 * 
 * @Title: DABPPFeedbackHandler.java
 * @Description: ���������ú󱨸淴��
 * @Company: 21softech
 * @Created on 2014-10-10 ����5:24:19
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class DABPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findDABPPFeedbackReceiveList
     * @Description: ��������
     * @author: xugy
     * @date: 2014-10-11����1:45:42
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackReceiveList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //������
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //����ƴ��
        String CHILD_NAME_EN = data.getString("CHILD_NAME_EN", null);   //�뼮����
        String NUM = data.getString("NUM", null);   //�ε���
        String REPORT_DATE_START = data.getString("REPORT_DATE_START", null);   //��ʼ�ϱ�����
        String REPORT_DATE_END = data.getString("REPORT_DATE_END", null);   //�����ϱ�����
        String RECEIVE_STATE = data.getString("RECEIVE_STATE", null);   //����״̬
        String RECEIVE_USERNAME = data.getString("RECEIVE_USERNAME", null);   //������
        String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START", null);   //��ʼ��������
        String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END", null);   //������������
        String REPORT_STATE = data.getString("REPORT_STATE", "");   //����״̬
        if("".equals(REPORT_STATE)){
            REPORT_STATE = "REPORT_STATE<>'0'";
        }else{
            REPORT_STATE = "REPORT_STATE='"+REPORT_STATE+"'";
        }
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackReceiveList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, NAME_PINYIN, CHILD_NAME_EN, NUM, REPORT_DATE_START, REPORT_DATE_END, RECEIVE_STATE, RECEIVE_USERNAME, RECEIVE_DATE_START, RECEIVE_DATE_END, REPORT_STATE, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * �ļ��ƽ��ṩ�ӿ�
     * @Title: PFRFeedbackrecordSave
     * @Description: �����޸�����
     * @author: xugy
     * @date: 2014-10-11����3:40:37
     * @param conn
     * @param datalist 
     * @param FB_REC_ID��������    �����������빫˾ ������״̬��REPORT_STATE='3' ������״̬��TRANSLATION_STATE='0'  ���빫˾�������� ������״̬��REPORT_STATE='6' �����״̬��ADUIT_STATE='0'
     * @throws DBException
     */
    public void PFRFeedbackrecordSave(Connection conn, DataList datalist) throws DBException {
        for(int i=0;i<datalist.size();i++){
            datalist.getData(i).setConnection(conn);
            datalist.getData(i).setEntityName("PFR_FEEDBACK_RECORD");
            datalist.getData(i).setPrimaryKey("FB_REC_ID");
        }
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.batchStore(datalist);
    }
    /**
     * 
     * @Title: findDABPPFeedbackReplaceList
     * @Description: ��¼�б�
     * @author: xugy
     * @date: 2014-10-14����6:14:38
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackReplaceList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //������
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //����ƴ��
        String CHILD_NAME_EN = data.getString("CHILD_NAME_EN", null);   //�뼮����
        String NUM = data.getString("NUM", null);   //�ε���
        String REG_USERNAME = data.getString("REG_USERNAME", null);   //¼����
        String REG_DATE_START = data.getString("REG_DATE_START", null);   //��ʼ¼������
        String REG_DATE_END = data.getString("REG_DATE_END", null);   //����¼������
        String REPORT_STATE = data.getString("REPORT_STATE", null);   //����״̬
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackReplaceList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, NAME_PINYIN, CHILD_NAME_EN, NUM, REG_USERNAME, REG_DATE_START, REG_DATE_END, REPORT_STATE, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findDABPPFeedbackAuditList
     * @Description: ��������б�
     * @author: xugy
     * @date: 2014-10-14����2:48:36
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackAuditList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //������
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String NUM = data.getString("NUM", null);   //�ε���
        String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START", null);   //��ʼ��������
        String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END", null);   //��������������
        String AUDIT_USERNAME = data.getString("AUDIT_USERNAME", null);   //�����
        String AUDIT_DATE_START = data.getString("AUDIT_DATE_START", null);   //��ʼ�������
        String AUDIT_DATE_END = data.getString("AUDIT_DATE_END", null);   //�����������
        String ADUIT_STATE = data.getString("ADUIT_STATE", null);   //���״̬
        
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackAuditList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, NUM, RECEIVE_DATE_START, RECEIVE_DATE_END, AUDIT_USERNAME, AUDIT_DATE_START, AUDIT_DATE_END, ADUIT_STATE, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 
     * @Title: getFeedbackAdditonalInfo
     * @Description: ��ȡ�����ļ���Ϣ
     * @author: xugy
     * @date: 2014-10-21����8:12:29
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException 
     */
    public Data getFeedbackAdditonalInfo(Connection conn, String FB_REC_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackAdditonalInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getFeedbackShowInfo
     * @Description: ���ú󱨸�鿴��Ϣ
     * @author: xugy
     * @date: 2014-11-4����4:53:35
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackShowInfo(Connection conn, String FEEDBACK_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackShowInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    public Data getFeedbackRecordInfo(Connection conn, String FEEDBACK_ID, String NUM) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackRecordInfo", FEEDBACK_ID, NUM);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: getDABCatalogInfo
     * @Description: ������������������Ŀ¼������
     * @author: xugy
     * @date: 2014-11-4����10:28:22
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public Data getDABCatalogInfo(Connection conn, String FEEDBACK_ID) throws DBException{
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getDABCatalogInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findDABPPFeedbackReminderList
     * @Description: ����߽�
     * @author: xugy
     * @date: 2014-10-23����4:17:51
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackReminderList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //������
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String NUM = data.getString("NUM", null);   //�ε���
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);   //��ʼ�Ǽ�����
        String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);   //�����Ǽ�����
        String LIMIT_DATE_START = data.getString("LIMIT_DATE_START", null);   //��ʼ�ݽ�����
        String LIMIT_DATE_END = data.getString("LIMIT_DATE_END", null);   //�����ݽ�����
        String REMINDERS_DATE_START = data.getString("REMINDERS_DATE_START", null);   //��ʼ�߽�����
        String REMINDERS_DATE_END = data.getString("REMINDERS_DATE_END", null);   //�����߽�����
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackReminderList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_NAME_CN, NAME, NUM, SIGN_DATE_START, SIGN_DATE_END, ADREG_DATE_START, ADREG_DATE_END, LIMIT_DATE_START, LIMIT_DATE_END, REMINDERS_DATE_START, REMINDERS_DATE_END, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * ���ú�������߽�
     * @Title: getFeedbackReminderInfoData
     * @Description: 
     * @author: xugy
     * @date: 2014-12-5����11:25:47
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException 
     */
    public Data getFeedbackReminderInfo(Connection conn, String FB_REC_ID) throws DBException{
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackReminderInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: findDABPPFeedbackSearchList
     * @Description: ���������ú󱨸淴����ѯ�б�
     * @author: xugy
     * @date: 2014-10-10����5:26:50
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackSearchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //������
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String CHILD_NAME_EN = data.getString("CHILD_NAME_EN", null);   //�뼮����
        String SEX = data.getString("SEX", null);   //�Ա�
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������������
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackSearchList", ARCHIVE_NO, SIGN_NO, SIGN_DATE_START, SIGN_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, CHILD_NAME_EN, SEX, CHILD_TYPE, BIRTHDAY_START, BIRTHDAY_END, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getFeedbackRecordInfo
     * @Description: �������鿴���ú�������
     * @author: xugy
     * @date: 2014-12-1����4:23:13
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public DataList getFeedbackInfo(Connection conn, String FEEDBACK_ID) throws DBException{
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getFeedbackRecordStateInfo
     * @Description: ���ú�������״̬
     * @author: xugy
     * @date: 2014-12-7����4:53:37
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public DataList getFeedbackRecordStateInfo(Connection conn, String FEEDBACK_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackRecordStateInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
}
