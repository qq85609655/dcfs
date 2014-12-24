package com.dcfs.pfr.SYZZ;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: SYZZPPFeedbackHandler.java
 * @Description: ������֯���ú󱨸淴��
 * @Company: 21softech
 * @Created on 2014-10-9 ����5:13:42
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SYZZPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findSYZZPPFeedbackList
     * @Description: ������֯���ú󱨸淴���б�
     * @author: xugy
     * @date: 2014-10-9����6:02:52
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZPPFeedbackList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String NUM = data.getString("NUM", null);   //�ε���
        String REPORT_DATE_START = data.getString("REPORT_DATE_START", null);   //��ʼ�ϱ�����
        String REPORT_DATE_END = data.getString("REPORT_DATE_END", null);   //�����ϱ�����
        String REPORT_STATE = data.getString("REPORT_STATE", "");   //����״̬
        if("".equals(REPORT_STATE)){
            REPORT_STATE = null;
        }else if("1".equals(REPORT_STATE)){
            REPORT_STATE = "REPORT_STATE IN ('1','2','3','4','5','6')";
        }else{
            REPORT_STATE = "REPORT_STATE='"+REPORT_STATE+"'";
        }
        String REMINDERS_STATE = data.getString("REMINDERS_STATE", null);   //�߽�״̬
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPPFeedbackList", adoptOrg, FILE_NO, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, NUM, REPORT_DATE_START, REPORT_DATE_END, REPORT_STATE, REMINDERS_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZPPFeedbackAdditonalList
     * @Description: ���油���б�
     * @author: xugy
     * @date: 2014-10-21����8:39:05
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZPPFeedbackAdditonalList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String NUM = data.getString("NUM", null);   //�ε���
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //��ʼ֪ͨ����
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //����֪ͨ����
        String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);   //��ʼ��������
        String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);   //������������
        String AA_STATUS = data.getString("AA_STATUS", null);   //����״̬
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPPFeedbackAdditonalList", adoptOrg, FILE_NO, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, NUM, NOTICE_DATE_START, NOTICE_DATE_END, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZPPFeedbackReminderList
     * @Description: ����߽��б�
     * @author: xugy
     * @date: 2014-10-23����3:02:26
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZPPFeedbackReminderList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String SIGN_NO = data.getString("SIGN_NO", null);   //ǩ����
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_NAME_EN = data.getString("WELFARE_NAME_EN", null);   //����Ժ
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String NUM = data.getString("NUM", null);   //�ε���
        String LIMIT_DATE_START = data.getString("LIMIT_DATE_START", null);   //��ʼ��ֹ����
        String LIMIT_DATE_END = data.getString("LIMIT_DATE_END", null);   //������ֹ����
        String REMINDERS_DATE_START = data.getString("REMINDERS_DATE_START", null);   //��ʼ�߽�����
        String REMINDERS_DATE_END = data.getString("REMINDERS_DATE_END", null);   //�����߽�����
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPPFeedbackReminderList", adoptOrg, FILE_NO, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_NAME_EN, NAME_PINYIN, NUM, LIMIT_DATE_START, LIMIT_DATE_END, REMINDERS_DATE_START, REMINDERS_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    

}
