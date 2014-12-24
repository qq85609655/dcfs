 /**
 * @Title: FfsAfTranslationHandler.java
 * @Package com.dcfs.ffs
 * @Description: 文件翻译处理Handler
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
 * @Description:文件翻译处理类
 * @Created on 
 * @author wangzheng
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class FfsAfTranslationHandler extends BaseHandler{

	  /**
     * 保存翻译信息
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean save(Connection conn, Data data)
            throws DBException {
	    //***保存数据*****
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
     * 保存文件信息
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveFile(Connection conn, Data data)
            throws DBException {
	    //***保存数据*****
        Data dataadd = new Data(data);        
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID"); 
        dataadd.store(); 
        return true;
    }
    
    /**
     * 保存补充记录信息
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveAdditional(Connection conn, Data data)
            throws DBException {
	    //***保存数据*****
        Data dataadd = new Data(data);        
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_ADDITIONAL");
        dataadd.setPrimaryKey("AA_ID"); 
        dataadd.store(); 
        return true;
    }
    
    
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
     * 翻译记录查询列表
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

    	//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String TRANSLATION_UNITNAME =  data.getString("TRANSLATION_UNITNAME", null);//翻译单位
		String TRANSLATION_STATE = data.getString("TRANSLATION_STATE",null);//翻译状态
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//登记日期开始
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_START",null);//登记日期结束
		String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START",null);//接收日期开始
		String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END",null);//接收日期结束
		String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START",null);//完成日期开始
		String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END",null);//完成日期结束
		String TRANSLATION_UNIT =  data.getString("TRANSLATION_UNIT", null);//翻译单位
		
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findList",FILE_NO,FILE_TYPE,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,
        		TRANSLATION_UNITNAME,TRANSLATION_STATE,REGISTER_DATE_START,REGISTER_DATE_END,RECEIVE_DATE_START,
        		RECEIVE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,compositor,ordertype,TRANSLATION_UNIT);
        System.out.print(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 重翻记录查询列表
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

    	//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String TRANSLATION_UNITNAME =  data.getString("TRANSLATION_UNITNAME", null);//翻译单位
		String TRANSLATION_STATE = data.getString("TRANSLATION_STATE",null);//翻译状态
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//登记日期开始
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_START",null);//登记日期结束
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//通知日期开始
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//通知日期结束
		String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START",null);//完成日期开始
		String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END",null);//完成日期结束
		String TRANSLATION_UNIT = data.getString("TRANSLATION_UNIT",null);//翻译单位
		
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("reTranslationList",FILE_NO,FILE_TYPE,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,
        		TRANSLATION_UNITNAME,TRANSLATION_STATE,REGISTER_DATE_START,REGISTER_DATE_END,NOTICE_DATE_START,
        		NOTICE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,compositor,ordertype,TRANSLATION_UNIT);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     *补翻记录查询列表
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

    	//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String TRANSLATION_UNITNAME =  data.getString("TRANSLATION_UNITNAME", null);//翻译单位
		String TRANSLATION_STATE = data.getString("TRANSLATION_STATE",null);//翻译状态
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//登记日期开始
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_START",null);//登记日期结束
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//通知日期开始
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//通知日期结束
		String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START",null);//完成日期开始
		String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END",null);//完成日期结束
		String TRANSLATION_UNIT = data.getString("TRANSLATION_UNIT",null);//翻译单位
		
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("adTranslationList",FILE_NO,FILE_TYPE,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,
        		TRANSLATION_UNITNAME,TRANSLATION_STATE,REGISTER_DATE_START,REGISTER_DATE_END,NOTICE_DATE_START,
        		NOTICE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,compositor,ordertype,TRANSLATION_UNIT);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 根据文件基本信息主键ID获得该文件的翻译基本信息
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
     * 获得文件信息
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
     * 获得文件附件信息
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
     * 获得补翻信息
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
     * 分发
     * 
     * @param conn
     * @param atIds 翻译记录ID集合
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