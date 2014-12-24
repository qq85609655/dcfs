package com.dcfs.ncm.special;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;


/**
 * 
 * @Title: SpecialMatchHandler.java
 * @Description: �����ͯƥ��
 * @Company: 21softech
 * @Created on 2014-9-6 ����10:28:13
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SpecialMatchHandler extends BaseHandler {
    
    
    /**
     * 
     * @Title: findAFSpecialMatchList
     * @Description: ����ƥ���ļ��б�
     * @author: xugy
     * @date: 2014-9-6����10:54:05
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAFSpecialMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//��ǰ���ڣ��ж��ļ���������׼���Ƿ����
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //���Ŀ�ʼ����
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //���Ľ�������
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null); //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null); //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String MATCH_RECEIVEDATE_START = data.getString("MATCH_RECEIVEDATE_START", null);   //���տ�ʼ����
        String MATCH_RECEIVEDATE_END = data.getString("MATCH_RECEIVEDATE_END", null);   //���ս�������
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //�ļ�����
        String ADOPT_REQUEST_CN = data.getString("ADOPT_REQUEST_CN", null);   //����Ҫ��
        String UNDERAGE_NUM = data.getString("UNDERAGE_NUM", null);   //��Ů����
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //ƥ�����
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //ƥ��״̬
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='0'";
        }else if("9".equals(MATCH_STATE)){
            MATCH_STATE = "(MATCH_STATE='0' or MATCH_STATE='1')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
            
        }
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAFSpecialMatchList", nowDate, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, MATCH_RECEIVEDATE_START, MATCH_RECEIVEDATE_END, FILE_TYPE, ADOPT_REQUEST_CN, UNDERAGE_NUM, MATCH_NUM, MATCH_STATE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findCISpecialMatchList
     * @Description: ѡ�������ͯ�����б�
     * @author: xugy
     * @date: 2014-9-6����11:12:33
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findCISpecialMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String CHECKUP_DATE_START = data.getString("CHECKUP_DATE_START", null);   //��쿪ʼ����
        String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END", null); //����������
        String NAME = data.getString("NAME", null); //����
        String SEX = data.getString("SEX", null);   //�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //���տ�ʼ
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //���ս���
        String CHILD_TYPE = "2";   //��ͯ����
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findCISpecialMatchList", PROVINCE_ID, WELFARE_ID, CHECKUP_DATE_START, CHECKUP_DATE_END, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
}
