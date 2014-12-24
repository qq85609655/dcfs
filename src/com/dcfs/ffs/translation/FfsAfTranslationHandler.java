 /**
 * @Title: FfsAfTranslationHandler.java
 * @Package com.dcfs.ffs
 * @Description: �ļ����봦��Handler
 * @author wangzheng   
 * @project DCFS 
 * @date 2014-7-29 10:02:37
 * @version V1.0   
 */
package com.dcfs.ffs.translation;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import java.sql.Connection;
import java.util.Iterator;
import java.util.Map;
import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * @Title: FfsAfTranslationHandler.java
 * @Description:�ļ����봦����
 * @Created on 
 * @author wangzheng
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class FfsAfTranslationHandler extends BaseHandler{

	  /**
     * ���淭����Ϣ
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean save(Connection conn, Data data)
            throws DBException {
	    //***��������*****
        Data dataadd = new Data(data);
        
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_TRANSLATION");
        dataadd.setPrimaryKey("AT_ID");
        if ("".equals(dataadd.getString("AT_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }
    
    /**
     * �����ļ���Ϣ
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveFile(Connection conn, Data data)
            throws DBException {
	    //***��������*****
        Data dataadd = new Data(data);        
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID"); 
        dataadd.store(); 
        return true;
    }
    
    /**
     * ���油���¼��Ϣ
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveAdditional(Connection conn, Data data)
            throws DBException {
	    //***��������*****
        Data dataadd = new Data(data);        
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_ADDITIONAL");
        dataadd.setPrimaryKey("AA_ID"); 
        dataadd.store(); 
        return true;
    }
    
    
	  /**
     * ����
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean save(Connection conn, Map<String, Object> data)
            throws DBException {
	    //***��������*****
        Data dataadd = new Data(data);
        
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_TRANSLATION");
        dataadd.setPrimaryKey("AT_ID");
        if ("".equals(dataadd.getString("AT_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }

    /**
     * �����¼��ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList findList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String TRANSLATION_UNITNAME =  data.getString("TRANSLATION_UNITNAME", null);//���뵥λ
		String TRANSLATION_STATE = data.getString("TRANSLATION_STATE",null);//����״̬
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//�Ǽ����ڿ�ʼ
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_START",null);//�Ǽ����ڽ���
		String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START",null);//�������ڿ�ʼ
		String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END",null);//�������ڽ���
		String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START",null);//������ڿ�ʼ
		String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END",null);//������ڽ���
		String TRANSLATION_UNIT =  data.getString("TRANSLATION_UNIT", null);//���뵥λ
		
		//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findList",FILE_NO,FILE_TYPE,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,
        		TRANSLATION_UNITNAME,TRANSLATION_STATE,REGISTER_DATE_START,REGISTER_DATE_END,RECEIVE_DATE_START,
        		RECEIVE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,compositor,ordertype,TRANSLATION_UNIT);
        System.out.print(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * �ط���¼��ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList reTranslationList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String TRANSLATION_UNITNAME =  data.getString("TRANSLATION_UNITNAME", null);//���뵥λ
		String TRANSLATION_STATE = data.getString("TRANSLATION_STATE",null);//����״̬
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//�Ǽ����ڿ�ʼ
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_START",null);//�Ǽ����ڽ���
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//֪ͨ���ڿ�ʼ
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//֪ͨ���ڽ���
		String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START",null);//������ڿ�ʼ
		String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END",null);//������ڽ���
		String TRANSLATION_UNIT = data.getString("TRANSLATION_UNIT",null);//���뵥λ
		
		//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("reTranslationList",FILE_NO,FILE_TYPE,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,
        		TRANSLATION_UNITNAME,TRANSLATION_STATE,REGISTER_DATE_START,REGISTER_DATE_END,NOTICE_DATE_START,
        		NOTICE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,compositor,ordertype,TRANSLATION_UNIT);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *������¼��ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList adTranslationList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String TRANSLATION_UNITNAME =  data.getString("TRANSLATION_UNITNAME", null);//���뵥λ
		String TRANSLATION_STATE = data.getString("TRANSLATION_STATE",null);//����״̬
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//�Ǽ����ڿ�ʼ
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_START",null);//�Ǽ����ڽ���
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//֪ͨ���ڿ�ʼ
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//֪ͨ���ڽ���
		String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START",null);//������ڿ�ʼ
		String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END",null);//������ڽ���
		String TRANSLATION_UNIT = data.getString("TRANSLATION_UNIT",null);//���뵥λ
		
		//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("adTranslationList",FILE_NO,FILE_TYPE,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,
        		TRANSLATION_UNITNAME,TRANSLATION_STATE,REGISTER_DATE_START,REGISTER_DATE_END,NOTICE_DATE_START,
        		NOTICE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,compositor,ordertype,TRANSLATION_UNIT);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * �����ļ�������Ϣ����ID��ø��ļ��ķ��������Ϣ
     * @description 
     * @author MaYun
     * @date Oct 27, 2014
     * @return
     */
    public Data getFyDataByAFID(Connection conn,String afId) throws DBException{
    	 IDataExecute ide = DataBaseFactory.getDataBase(conn);
         DataList dataList = new DataList();
         dataList = ide.find(getSql("getFyDataByAFID", afId));
         if(dataList.size()!=0){
         	return dataList.getData(0);
         }else{
         	return null;
         }
    }

    /**
     * ����ļ���Ϣ
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getShowData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getData", uuid));
        if(dataList.size()!=0){
        	return dataList.getData(0);
        }else{
        	return null;
        }
    }
    
    /**
     * ����ļ�������Ϣ
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public DataList getAttData(Connection conn, String pid) throws DBException {
        
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getAtt", pid));
        return dataList;
    }
    
    /**
     * ��ò�����Ϣ
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getAdTranslationData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getAdTranslationData", uuid));
        if(dataList.size()!=0){
        	return dataList.getData(0);
        }else{
        	return null;
        }
    }

    /**
     * �ַ�
     * 
     * @param conn
     * @param atIds �����¼ID����
     * @return
     * @throws DBException
     */
    
    public boolean dispatch(Connection conn, String DistribUserId,String DistribUserName,String curDate,String TranslationUnit,String TranslationUnitName,String[] atIds) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn); 
        
        StringBuffer strSql = new StringBuffer();
        strSql.append("UPDATE FFS_AF_TRANSLATION SET DISTRIB_USERID = '");
        strSql.append(DistribUserId);
        strSql.append("' ,DISTRIB_USERNAME='");
        strSql.append(DistribUserName);
        strSql.append("',DISTRIB_DATE=TO_DATE('");
        strSql.append(curDate);
        strSql.append("','YYYY-MM-dd'),TRANSLATION_UNIT='");
        strSql.append(TranslationUnit);
        strSql.append("',TRANSLATION_UNITNAME='");
        strSql.append(TranslationUnitName);
        strSql.append("' WHERE ");
        
        StringBuffer strSqlCondition = new StringBuffer();
        for(int i=0;i<atIds.length;i++){
        	strSqlCondition.append("AT_ID = '");
        	strSqlCondition.append(atIds[i]);
        	strSqlCondition.append("'");
        	if(i<(atIds.length-1)) strSqlCondition.append(" OR ");
        }
        
        strSql.append(strSqlCondition);
        System.out.println("dispatch sql:"+strSql.toString());
        return ide.execute(strSql.toString());
        
    }
}