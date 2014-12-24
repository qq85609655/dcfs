package com.dcfs.ncm.BGSnotice;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: BGSNoticeHandler.java
 * @Description: �칫��֪ͨ�����--��ӡ�ķ�
 * @Company: 21softech
 * @Created on 2014-9-15 ����4:50:29
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class BGSNoticeHandler extends BaseHandler {
    /**
     * 
     * @Title: findBGSNoticePrintList
     * @Description: �칫��֪ͨ������ӡ�ķ��б�
     * @author: xugy
     * @date: 2014-9-15����4:55:55
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findBGSNoticePrintList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //��ʼ��������
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //������������
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //�ļ�����
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //��ͯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String SIGN_SUBMIT_DATE_START = data.getString("SIGN_SUBMIT_DATE_START", null);   //��ʼ��������
        String SIGN_SUBMIT_DATE_END = data.getString("SIGN_SUBMIT_DATE_END", null);   //������������
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //��ʼǩ������
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //����ǩ������
        String NOTICE_SIGN_DATE_START = data.getString("NOTICE_SIGN_DATE_START", null);   //��ʼ�������
        String NOTICE_SIGN_DATE_END = data.getString("NOTICE_SIGN_DATE_END", null);   //�����������
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //��ʼ֪ͨ����
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //����֪ͨ����
        String NOTICE_STATE = data.getString("NOTICE_STATE", "");   //֪ͨ״̬
        if("".equals(NOTICE_STATE)){
            NOTICE_STATE = "NOTICE_STATE='0'";
        }else if("9".equals(NOTICE_STATE)){
            NOTICE_STATE = "(NOTICE_STATE='0' or NOTICE_STATE='1')";
        }else{
            NOTICE_STATE = "NOTICE_STATE='"+NOTICE_STATE+"'";
            
        }
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findBGSNoticePrintList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END,SIGN_SUBMIT_DATE_START,SIGN_SUBMIT_DATE_END, SIGN_DATE_START, SIGN_DATE_END, NOTICE_SIGN_DATE_START, NOTICE_SIGN_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, NOTICE_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getNoticeInfo
     * @Description: ֪ͨ��ժҪ��Ϣ
     * @author: xugy
     * @date: 2014-9-16����3:10:02
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getNoticeInfo(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNoticeInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getArchiveSaveInfo
     * @Description: ��ȡ��������������Ϣ����
     * @author: xugy
     * @date: 2014-9-25����8:57:17
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getArchiveSaveInfo(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getArchiveSaveInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getArchiveId
     * @Description: ����ƥ����ϢID���ҵ���ID
     * @author: xugy
     * @date: 2014-11-10����9:13:01
     * @param conn
     * @param string
     * @return 
     * @throws DBException 
     */
    public Data getArchiveId(Connection conn, String MI_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getArchiveId", MI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
        
    }
    /**
     * 
     * @Title: getAttInfo
     * @Description: ���ɸ���Ҫ�жϵ���Ϣ
     * @author: xugy
     * @date: 2014-11-11����1:33:38
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getAttInfo(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAttInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getPrintInfoId
     * @Description: ��ȡ��Ҫ��ӡ�����ݵ�ID
     * @author: xugy
     * @date: 2014-11-13����1:58:18
     * @param conn
     * @return
     * @throws DBException 
     */
    public DataList getPrintInfoId(Connection conn, String order) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getPrintInfoId", order);
        DataList dl = ide.find(sql);
        return dl;
    }
    public DataList getIdInId(Connection conn, String id, String order) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getIdInId", id, order);
        DataList dl = ide.find(sql);
        return dl;
    }

}
