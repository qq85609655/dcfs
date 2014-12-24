 /**
 * @Title: CmsCiTranslationAction.java
 * @Package com.dcfs.cms
 * @Description: TODO(用一句话描述该文件做什么) 
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
     * 保存
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean save(Connection conn, Map<String, Object> data)
            throws DBException {
	    //***保存数据*****
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
     * 儿童翻译查询列表
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

    	//查询条件
    	String PROVINCE_ID				= data.getString("PROVINCE_ID", null); 	//省份id
    	String WELFARE_ID					= data.getString("WELFARE_ID", null);		//福利院id
    	String CHILD_NO						= data.getString("CHILD_NO", null);    		//儿童编号
    	String NAME							= data.getString("NAME", null);               	//儿童姓名
    	String SEX								= data.getString("SEX", null);          			//性别      
    	String CHILD_TYPE					= data.getString("CHILD_TYPE", null);      //儿童类型   
    	String SPECIAL_FOCUS			= data.getString("SPECIAL_FOCUS", null); //是否特别关注           
    	String NOTICE_DATE_START		= data.getString("NOTICE_DATE_START", null);  //通知日期—开始日期      
    	String NOTICE_DATE_END		= data.getString("NOTICE_DATE_END", null);   //通知日期_结束日期       
    	String COMPLETE_DATE_START= data.getString("COMPLETE_DATE_START", null); //翻译完成日期_开始日期       
    	String COMPLETE_DATE_END	= data.getString("COMPLETE_DATE_END", null);  //翻译完成日期_结束日期         
    	String TRANSLATION_STATE	= data.getString("TRANSLATION_STATE", null); //翻译状态  
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findList",PROVINCE_ID,WELFARE_ID,CHILD_NO,NAME,SEX,CHILD_TYPE,SPECIAL_FOCUS,NOTICE_DATE_START,NOTICE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,TRANSLATION_STATE,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

    /**
     * 儿童材料翻译记录
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
     * 删除
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