package com.dcfs.sce.fileRemind;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;


/**
 * 
 * @Title: FileRemindHandler.java
 * @Description: �ݽ��ļ��߰��ѯ���鿴����
 * @Company: 21softech
 * @Created on 2014-9-15 ����5:01:29 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FileRemindHandler extends BaseHandler {
    /**
     * 
     * @Title: findRemindList
     * @Description: �ݽ��ļ��߰��ѯ�б�
     * @author: panfeng
     * @date: 2014-9-15 ����5:01:29 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findRemindList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
    	String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String REQ_DATE_START = data.getString("REQ_DATE_START", null);   //��ʼ��������
        String REQ_DATE_END = data.getString("REQ_DATE_END", null);   //������������
        String PASS_DATE_START = data.getString("PASS_DATE_START", null);   //��ʼ������
        String PASS_DATE_END = data.getString("PASS_DATE_END", null);   //����������
        String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);   //��ʼ�ݽ��ļ�����
        String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);   //�����ݽ��ļ�����
        String REM_DATE_START = data.getString("REM_DATE_START", null);   //��ʼ�߰�����
        String REM_DATE_END = data.getString("REM_DATE_END", null);   //�����߰�����
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findRemindList", MALE_NAME, FEMALE_NAME, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, REQ_DATE_START, REQ_DATE_END, PASS_DATE_START, PASS_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REM_DATE_START, REM_DATE_END, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
	 * �����߰�֪ͨ�鿴ҳ��
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getRemindShow(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getRemindShow", uuid));
		return dataList.getData(0);
	}
	
}
