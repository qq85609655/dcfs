package com.dcfs.ncm.SYZZadvice;

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
 * @Title: SYZZAdviceHandler.java
 * @Description: 
 * @Company: 21softech
 * @Created on 2014-9-11 ����4:39:03
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SYZZAdviceHandler extends BaseHandler {
    /**
     * 
     * @Title: findSYZZAdviceList
     * @Description: ������֯��������б�
     * @author: xugy
     * @date: 2014-9-11����4:50:21
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZAdviceList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //�ļ�����
        if("99".equals(FILE_TYPE)){
            FILE_TYPE = "FILE_TYPE IN ('20','21','22','23')";
        }else if(!"99".equals(FILE_TYPE) && FILE_TYPE != null){
            FILE_TYPE = "FILE_TYPE='"+FILE_TYPE+"'";
        }
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //��ʼ��������
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //������������
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String ADVICE_NOTICE_DATE_START = data.getString("ADVICE_NOTICE_DATE_START", null);   //��ʼ֪ͨ����
        String ADVICE_NOTICE_DATE_END = data.getString("ADVICE_NOTICE_DATE_END", null);   //����֪ͨ����
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String ADVICE_STATE = data.getString("ADVICE_STATE", null);   //����״̬
        String ADVICE_FEEDBACK_RESULT = data.getString("ADVICE_FEEDBACK_RESULT", null);   //�������
        String ADVICE_REMINDER_STATE = data.getString("ADVICE_REMINDER_STATE", null);   //�߰�״̬
        
        String ADOPT_ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode();//��ǰ��¼�˵�������֯
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZAdviceList", ADOPT_ORG_ID, FILE_NO, FILE_TYPE, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, FEMALE_NAME, ADVICE_NOTICE_DATE_START, ADVICE_NOTICE_DATE_END, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, PROVINCE_ID, WELFARE_ID, CHILD_TYPE, ADVICE_STATE, ADVICE_FEEDBACK_RESULT, ADVICE_REMINDER_STATE, compositor, ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZNoticeList
     * @Description: ������֯��������֪ͨ���б�
     * @author: xugy
     * @date: 2014-11-2����4:01:46
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList findSYZZNoticeList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //��ʼ��������
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //������������
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //�ļ�����
        if("99".equals(FILE_TYPE)){
            FILE_TYPE = "FILE_TYPE IN ('20','21','22','23')";
        }else if(!"99".equals(FILE_TYPE) && FILE_TYPE != null){
            FILE_TYPE = "FILE_TYPE='"+FILE_TYPE+"'";
        }
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //��ʼ�ķ�����
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //�����ķ�����
        
        String ADOPT_ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode();//��ǰ��¼�˵�������֯
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZNoticeList", ADOPT_ORG_ID, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, FEMALE_NAME, FILE_TYPE, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, SIGN_DATE_START, SIGN_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
}
