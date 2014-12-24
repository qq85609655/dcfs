package com.dcfs.ncm.FLYnotice;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: STNoticeHandler.java
 * @Description: ʡ������֪ͨ��
 * @Company: 21softech
 * @Created on 2014-11-8 ����5:01:20
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FLYNoticeHandler extends BaseHandler {
    /**
     * 
     * @Title: findFLYNoticeList
     * @Description: ����Ժ����֪ͨ���б�
     * @author: xugy
     * @date: 2014-11-8����5:24:11
     * @param conn
     * @param wELFARE_ID
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findFLYNoticeList(Connection conn, String WELFARE_ID, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String SIGN_NO = data.getString("SIGN_NO",null);   //֪ͨ����
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //��ʼ֪ͨ����
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //����֪ͨ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů������
        String CHILD_TYPE = data.getString("CHILD_TYPE",null);   //��ͯ����
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql =  getSql("findFLYNoticeList",WELFARE_ID,SIGN_NO,SIGN_DATE_START,SIGN_DATE_END,NOTICE_DATE_START,NOTICE_DATE_END,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,CHILD_TYPE,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
