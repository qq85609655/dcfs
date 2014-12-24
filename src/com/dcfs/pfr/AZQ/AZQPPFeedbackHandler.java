package com.dcfs.pfr.AZQ;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: AZQPPFeedbackHandler.java
 * @Description: ��֮�ű��淭��
 * @Company: 21softech
 * @Created on 2014-10-13 ����5:07:56
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AZQPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findAZQPPFeedbackTransList
     * @Description: ��֮�ŷ����б�
     * @author: xugy
     * @date: 2014-10-13����5:10:52
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAZQPPFeedbackTransList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //������
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String REPORT_DATE_START = data.getString("REPORT_DATE_START", null);   //��ʼ��������
        String REPORT_DATE_END = data.getString("REPORT_DATE_END", null);   //������������
        String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);   //��ʼ��������
        String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);   //������������
        String DISTRIB_DATE_START = data.getString("DISTRIB_DATE_START", null);   //��ʼ�ַ�����
        String DISTRIB_DATE_END = data.getString("DISTRIB_DATE_END", null);   //�����ַ�����
        String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START", null);   //��ʼ�������
        String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END", null);   //�����������
        String TRANSLATION_UNITNAME = data.getString("TRANSLATION_UNITNAME", null);   //���뵥λ
        String TRANSLATION_STATE = data.getString("TRANSLATION_STATE", null);   //����״̬
        String NUM = data.getString("NUM", null);   //�ε���
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZQPPFeedbackTransList", ARCHIVE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SIGN_DATE_START, SIGN_DATE_END, REPORT_DATE_START, REPORT_DATE_END, RECEIVER_DATE_START, RECEIVER_DATE_END, DISTRIB_DATE_START, DISTRIB_DATE_END, COMPLETE_DATE_START, COMPLETE_DATE_END, TRANSLATION_UNITNAME, TRANSLATION_STATE, NUM, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getFBREDID
     * @Description: �������ݶ�Ӧ�ı����¼
     * @author: xugy
     * @date: 2014-10-23����6:12:10
     * @param conn
     * @param fB_T_ID
     * @return
     * @throws DBException 
     */
    public String getFBREDID(Connection conn, String FB_T_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFBREDID", FB_T_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0).getString("FB_REC_ID");
    }
    
}
