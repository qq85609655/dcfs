 /**
 * @Title: CmsCiTranslationAction.java
 * @Package com.dcfs.cms
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author xxx   
 * @project DCFS 
 * @date 2014-10-16 16:20:27
 * @version V1.0   
 */
package com.dcfs.cms.childTranslation;

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
 * @Title: CmsCiTranslationHandler.java
 * @Description:????
 * @Created on 
 * @author xxx
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class CmsCiTranslationHandler extends BaseHandler{

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
        dataadd.setEntityName("CMS_CI_TRANSLATION");
        dataadd.setPrimaryKey("CT_ID");
        if ("".equals(dataadd.getString("CT_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }

    /**
     * ��ͯ�����ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList findList(Connection conn,Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//��ѯ����
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); 	//ʡ��id
    	String WELFARE_ID					= data.getString("WELFARE_ID", null);		//����Ժid
    	String CHILD_NO						= data.getString("CHILD_NO", null);    		//��ͯ���
    	String NAME							= data.getString("NAME", null);               	//��ͯ����
    	String SEX								= data.getString("SEX", null);          			//�Ա�      
    	String CHILD_TYPE					= data.getString("CHILD_TYPE", null);      //��ͯ����   
    	String SPECIAL_FOCUS			= data.getString("SPECIAL_FOCUS", null); //�Ƿ��ر��ע           
    	String NOTICE_DATE_START		= data.getString("NOTICE_DATE_START", null);  //֪ͨ���ڡ���ʼ����      
    	String NOTICE_DATE_END		= data.getString("NOTICE_DATE_END", null);   //֪ͨ����_��������       
    	String COMPLETE_DATE_START= data.getString("COMPLETE_DATE_START", null); //�����������_��ʼ����       
    	String COMPLETE_DATE_END	= data.getString("COMPLETE_DATE_END", null);  //�����������_��������         
    	String TRANSLATION_STATE	= data.getString("TRANSLATION_STATE", null); //����״̬  
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findList",PROVINCE_ID,WELFARE_ID,CHILD_NO,NAME,SEX,CHILD_TYPE,SPECIAL_FOCUS,NOTICE_DATE_START,NOTICE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,TRANSLATION_STATE,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

    /**
     * ��ͯ���Ϸ����¼
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getShowData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        //System.out.println(getSql("CHILD_TRANSLATION", uuid));
        dataList = ide.find(getSql("CHILD_TRANSLATION", uuid));
        
        return dataList.getData(0);
    }

    /**
     * ɾ��
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public boolean delete(Connection conn, String[] uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList deleteList = new DataList();
        for (int i = 0; i < uuid.length; i++) {
            Data data = new Data();
            data.setConnection(conn);
            data.setEntityName("CMS_CI_TRANSLATION");
            data.setPrimaryKey("CT_ID");
            data.add("CT_ID", uuid[i]);
            deleteList.add(data);
        }
        ide.remove(deleteList);
        return true;
    }
}