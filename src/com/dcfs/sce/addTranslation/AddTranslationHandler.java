package com.dcfs.sce.addTranslation;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;


/**
 * 
 * @Title: AddTranslationHandler.java
 * @Description: 预批补翻信息查询、查看操作
 * @Company: 21softech
 * @Created on 2014-9-19 上午9:12:01 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AddTranslationHandler extends BaseHandler {
    /**
     * 
     * @Title: findAddList
     * @Description: 预批补翻信息列表
     * @author: panfeng
     * @date: 2014-9-19 上午9:12:01 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList addTranslationList(Connection conn, Data data, String OperType, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String MALE_NAME = data.getString("MALE_NAME", null);   						//男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   					//女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   					//省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   						//福利院
        String NAME = data.getString("NAME", null);   									//儿童姓名
        String SEX = data.getString("SEX", null);   									//儿童性别
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   		//开始补翻日期
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   			//结束补翻日期
        String COMPLETE_DATE_START = data.getString("COMPLETE_DATE_START", null);  		//开始完成日期
        String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END", null);   		//结束完成日期
        String TRANSLATION_UNITNAME = data.getString("TRANSLATION_UNITNAME", null);   	//翻译单位
        String TRANSLATION_STATE = data.getString("TRANSLATION_STATE", null);   		//翻译状态
        
        String AT_TYPE = null;
        if("SHB".equals(OperType)){
        	AT_TYPE = "1";
        }else if("AZB".equals(OperType)){
        	AT_TYPE = "2";
        }
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("addTranslationList", MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, SEX, NOTICE_DATE_START, NOTICE_DATE_END, COMPLETE_DATE_START, COMPLETE_DATE_END, TRANSLATION_UNITNAME, TRANSLATION_STATE, compositor, ordertype, AT_TYPE);
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
	 * @Title: getNoticeData 
	 * @Description: 获取预批补充通知信息
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getNoticeData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getNoticeData", uuid);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
    
    
}
