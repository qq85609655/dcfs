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
 * @Description: 预批补翻信息查询、查看操作
 * @Company: 21softech
 * @Created on 2014-9-19 上午9:12:01 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class TranslationHandler extends BaseHandler {
    /**
     * 
     * @Title: applyTranslationList
     * @Description: 预批申请翻译信息列表
     * @author: panfeng
     * @date: 2014-10-09 下午8:19:29 
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
        //查询条件
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE",null);	//国家code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//收养组织code
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//儿童出生截止日期
		String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
		String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//预批提交起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//预批提交截止日期
        String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START", null);   //开始完成日期
        String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END", null);   //结束完成日期
        String TRANSLATION_STATE = data.getString("TRANSLATION_STATE", null);   //翻译状态
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("applyTranslationList", COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, PROVINCE_ID, WELFARE_ID, REQ_DATE_START, REQ_DATE_END, COMPLETE_DATE_START, COMPLETE_DATE_END, TRANSLATION_STATE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 
     * @Title: supplyTranslationList
     * @Description: 预批补充翻译信息列表
     * @author: panfeng
     * @date: 2014-10-16 上午10:28:12 
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
    	//查询条件
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE",null);	//国家code
    	String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//收养组织code
    	String MALE_NAME = data.getString("MALE_NAME", null);   //男方
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
    	String NAME = data.getString("NAME", null);   //儿童姓名
    	String SEX = data.getString("SEX", null);   //儿童性别
    	String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//儿童出生起始日期
    	String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//儿童出生截止日期
    	String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
    	String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
    	String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START",null);	//反馈起始日期
    	String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END",null);	//反馈截止日期
    	String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START", null);   //开始完成日期
    	String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END", null);   //结束完成日期
    	String TRANSLATION_STATE = data.getString("TRANSLATION_STATE", null);   //翻译状态
    	
    	//数据操作
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("supplyTranslationList", COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, PROVINCE_ID, WELFARE_ID, FEEDBACK_DATE_START, FEEDBACK_DATE_END, COMPLETE_DATE_START, COMPLETE_DATE_END, TRANSLATION_STATE, compositor, ordertype);
    	DataList dl = ide.find(sql, pageSize, page);
    	return dl;
    }
    
    /**
	 * @Title: getShowData 
	 * @Description: 获取预批详细信息
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
     * 保存
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean preTranslationSave(Connection conn, Map<String, Object> preData, Map<String, Object> tranData)
            throws DBException {
    	
    	//***保存预批申请信息表*****
        Data dataadd = new Data(preData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
        if ("".equals(dataadd.getString("RI_ID", ""))) {
        	dataadd.create();
        } else {
        	dataadd.store();
        }
        
        //***保存预批申请翻译信息表*****
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
     * 保存
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean supplyTranslationSave(Connection conn, Map<String, Object> preData, Map<String, Object> tranData, Map<String, Object> adData)
    		throws DBException {
    	
    	//***保存预批申请信息表*****
        Data dataadd = new Data(preData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
        if ("".equals(dataadd.getString("RI_ID", ""))) {
        	dataadd.create();
        } else {
        	dataadd.store();
        }
    	
    	//***保存预批申请翻译信息表*****
    	Data dataadd2 = new Data(tranData);
    	dataadd2.setConnection(conn);
    	dataadd2.setEntityName("SCE_REQ_TRANSLATION");
    	dataadd2.setPrimaryKey("AT_ID");
    	if ("".equals(dataadd2.getString("AT_ID", ""))) {
    		dataadd2.create();
    	} else {
    		dataadd2.store();
    	}
    	
    	//***保存预批补充信息表*****
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
	 * @Description: 获取预批补充翻译信息
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
