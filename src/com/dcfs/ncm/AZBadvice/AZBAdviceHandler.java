package com.dcfs.ncm.AZBadvice;

import java.sql.Connection;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: AZBAdviceHandler.java
 * @Description: ���ò��������
 * @Company: 21softech
 * @Created on 2014-9-11 ����9:50:40
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AZBAdviceHandler extends BaseHandler {
    /**
     * 
     * @Title: findAZBAdviceList
     * @Description: ���ò���������б�
     * @author: xugy
     * @date: 2014-9-11����10:43:58
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAZBAdviceList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String MATCH_PASSDATE_START = data.getString("MATCH_PASSDATE_START", null);   //��ʼͨ������
        String MATCH_PASSDATE_END = data.getString("MATCH_PASSDATE_END", null);   //����ͨ������
        String ADVICE_NOTICE_DATE_START = data.getString("ADVICE_NOTICE_DATE_START", null);   //��ʼ֪ͨ����
        String ADVICE_NOTICE_DATE_END = data.getString("ADVICE_NOTICE_DATE_END", null);   //����֪ͨ����
        String ADVICE_PRINT_NUM = data.getString("ADVICE_PRINT_NUM", null);   //��ӡ����
        String ADVICE_STATE = data.getString("ADVICE_STATE", null);   //����״̬
        String ADVICE_REMINDER_STATE = data.getString("ADVICE_REMINDER_STATE", null);   //�߰�״̬
        String AF_COST_CLEAR = data.getString("AF_COST_CLEAR", null);   //���״̬
        String ADVICE_FEEDBACK_RESULT = data.getString("ADVICE_FEEDBACK_RESULT", null);   //�������
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBAdviceList", FILE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, MATCH_PASSDATE_START, MATCH_PASSDATE_END, ADVICE_NOTICE_DATE_START, ADVICE_NOTICE_DATE_END, ADVICE_PRINT_NUM, ADVICE_STATE, ADVICE_REMINDER_STATE, AF_COST_CLEAR, ADVICE_FEEDBACK_RESULT, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getPrintData
     * @Description: ��ȡ��ӡ����
     * @author: xugy
     * @date: 2014-9-21����3:24:20
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException
     */
    public Data getPrintData(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getPrintData", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getCode
     * @Description: ���뼯����
     * @author: xugy
     * @date: 2014-9-21����5:01:33
     * @param conn
     * @param CODESORTID
     * @param CODEVALUE 
     * @return
     * @throws DBException 
     */
    public Data getCode(Connection conn, String CODESORTID, String CODEVALUE) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCode", CODESORTID, CODEVALUE);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: matchSave
     * @Description: ƥ����Ϣ����
     * @author: xugy
     * @date: 2014-9-11����4:04:03
     * @param conn
     * @param data
     * @throws DBException
     */
    public void matchSave(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_MATCH_INFO");
        dataadd.setPrimaryKey("MI_ID");
        dataadd.store();
    }
    /**
     * 
     * @Title: findCountryGovment
     * @Description: ��ȡ�������������
     * @author: xugy
     * @date: 2014-9-12����2:52:25
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public CodeList findCountryGovment(Connection conn, String MI_ID) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findCountryGovment", MI_ID);
        DataList dataList = ide.find(sql);
        CodeList list=new CodeList();
        for(int i=0;i<dataList.size();i++){
            Code c=new Code();
            c.setValue(dataList.getData(i).getString("VALUE"));
            c.setName(dataList.getData(i).getString("NAME"));
            c.setRem(dataList.getData(i).getString("NAME"));
            list.add(c);
        }
        return list;
    }


    /**
     * 
     * @Title: getRFMAFInfo
     * @Description: ��ȡ�ļ���Ҫ�������ļ�¼�����Ϣ
     * @author: xugy
     * @date: 2014-9-12����6:12:52
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getRFMAFInfo(Connection conn, String AF_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getRFMAFInfo", AF_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }


    /**
     * 
     * @Title: getMatchReminderInfo
     * @Description: ��ȡ�߰�鿴��Ϣ
     * @author: xugy
     * @date: 2014-9-14����3:32:22
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getMatchReminderInfo(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchReminderInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getAdviceSignDate
     * @Description: ��ȡ�������_����������
     * @author: xugy
     * @date: 2014-11-12����5:20:38
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getAdviceSignDate(Connection conn, String MI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAdviceSignDate", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getMainCIIDS
     * @Description: ��ȡ����ͯ��ID
     * @author: xugy
     * @date: 2014-12-16����5:54:21
     * @param conn
     * @param inCI_ID
     * @return
     * @throws DBException 
     */
    public DataList getMainCIIDS(Connection conn, String inCI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMainCIIDS", inCI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getMatchInfo
     * @Description: 
     * @author: xugy
     * @date: 2014-12-21����11:15:26
     * @param conn
     * @return
     * @throws DBException 
     */
    public DataList getMatchInfo(Connection conn) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchInfo");
        DataList dl = ide.find(sql);
        return dl;
    }
}
