package com.dcfs.pfr.FYGS;

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
 * @Title: FYGSPPFeedbackHandler.java
 * @Description: ���빫˾�����б�
 * @Company: 21softech
 * @Created on 2014-10-23 ����6:43:29
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FYGSPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findFYGSPPFeedbackTransList
     * @Description: ���빫˾�����б�
     * @author: xugy
     * @date: 2014-10-23����6:57:08
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findFYGSPPFeedbackTransList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
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
        String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START", null);   //��ʼ�������
        String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END", null);   //�����������
        String TRANSLATION_STATE = data.getString("TRANSLATION_STATE", null);   //����״̬
        String NUM = data.getString("NUM", null);   //�ε���
        
        String organCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findFYGSPPFeedbackTransList", organCode, ARCHIVE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SIGN_DATE_START, SIGN_DATE_END, REPORT_DATE_START, REPORT_DATE_END, RECEIVER_DATE_START, RECEIVER_DATE_END, COMPLETE_DATE_START, COMPLETE_DATE_END, TRANSLATION_STATE, NUM, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
