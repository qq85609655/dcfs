package com.dcfs.sce.translation;

import java.sql.Connection;
import java.util.Map;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;


/**
 * 
 * @Title: TranslationHandler.java
 * @Description: Ԥ��������Ϣ��ѯ���鿴����
 * @Company: 21softech
 * @Created on 2014-9-19 ����9:12:01 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class TranslationHandler extends BaseHandler {
    /**
     * 
     * @Title: applyTranslationList
     * @Description: Ԥ�����뷭����Ϣ�б�
     * @author: panfeng
     * @date: 2014-10-09 ����8:19:29 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList applyTranslationList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE",null);	//����code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//������֯code
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//��ͯ������ֹ����
		String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
		String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//Ԥ���ύ��ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//Ԥ���ύ��ֹ����
        String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START", null);   //��ʼ�������
        String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END", null);   //�����������
        String TRANSLATION_STATE = data.getString("TRANSLATION_STATE", null);   //����״̬
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("applyTranslationList", COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, PROVINCE_ID, WELFARE_ID, REQ_DATE_START, REQ_DATE_END, COMPLETE_DATE_START, COMPLETE_DATE_END, TRANSLATION_STATE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 
     * @Title: supplyTranslationList
     * @Description: Ԥ�����䷭����Ϣ�б�
     * @author: panfeng
     * @date: 2014-10-16 ����10:28:12 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList supplyTranslationList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
    	//��ѯ����
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE",null);	//����code
    	String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//������֯code
    	String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
    	String NAME = data.getString("NAME", null);   //��ͯ����
    	String SEX = data.getString("SEX", null);   //��ͯ�Ա�
    	String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//��ͯ������ʼ����
    	String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//��ͯ������ֹ����
    	String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
    	String WELFARE_ID = data.getString("WELFARE_ID", null);   //����Ժ
    	String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START",null);	//������ʼ����
    	String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END",null);	//������ֹ����
    	String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START", null);   //��ʼ�������
    	String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END", null);   //�����������
    	String TRANSLATION_STATE = data.getString("TRANSLATION_STATE", null);   //����״̬
    	
    	//���ݲ���
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("supplyTranslationList", COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, PROVINCE_ID, WELFARE_ID, FEEDBACK_DATE_START, FEEDBACK_DATE_END, COMPLETE_DATE_START, COMPLETE_DATE_END, TRANSLATION_STATE, compositor, ordertype);
    	DataList dl = ide.find(sql, pageSize, page);
    	return dl;
    }
    
    /**
	 * @Title: getShowData 
	 * @Description: ��ȡԤ����ϸ��Ϣ
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getShowData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getShowData", uuid);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}
	
	/**
     * ����
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean preTranslationSave(Connection conn, Map<String, Object> preData, Map<String, Object> tranData)
            throws DBException {
    	
    	//***����Ԥ��������Ϣ��*****
        Data dataadd = new Data(preData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
        if ("".equals(dataadd.getString("RI_ID", ""))) {
        	dataadd.create();
        } else {
        	dataadd.store();
        }
        
        //***����Ԥ�����뷭����Ϣ��*****
        Data dataadd2 = new Data(tranData);
        dataadd2.setConnection(conn);
        dataadd2.setEntityName("SCE_REQ_TRANSLATION");
        dataadd2.setPrimaryKey("AT_ID");
        if ("".equals(dataadd2.getString("AT_ID", ""))) {
        	dataadd2.create();
        } else {
        	dataadd2.store();
        }
        return true;
    }
    
    /**
     * ����
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean supplyTranslationSave(Connection conn, Map<String, Object> preData, Map<String, Object> tranData, Map<String, Object> adData)
    		throws DBException {
    	
    	//***����Ԥ��������Ϣ��*****
        Data dataadd = new Data(preData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
        if ("".equals(dataadd.getString("RI_ID", ""))) {
        	dataadd.create();
        } else {
        	dataadd.store();
        }
    	
    	//***����Ԥ�����뷭����Ϣ��*****
    	Data dataadd2 = new Data(tranData);
    	dataadd2.setConnection(conn);
    	dataadd2.setEntityName("SCE_REQ_TRANSLATION");
    	dataadd2.setPrimaryKey("AT_ID");
    	if ("".equals(dataadd2.getString("AT_ID", ""))) {
    		dataadd2.create();
    	} else {
    		dataadd2.store();
    	}
    	
    	//***����Ԥ��������Ϣ��*****
		Data dataadd3 = new Data(adData);
		dataadd3.setConnection(conn);
		dataadd3.setEntityName("SCE_REQ_ADDITIONAL");
		dataadd3.setPrimaryKey("RA_ID");
		if ("".equals(dataadd3.getString("RA_ID", ""))) {
			dataadd3.create();
		} else {
			dataadd3.store();
		}
		
    	return true;
    }
	
	/**
	 * @Title: getSupplyTranData 
	 * @Description: ��ȡԤ�����䷭����Ϣ
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getSupplyTranData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getSupplyTranData", uuid);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
    
    
}
