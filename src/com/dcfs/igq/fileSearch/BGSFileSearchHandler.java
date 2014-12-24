/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午3:00:55 
 * @version V1.0   
 */
package com.dcfs.igq.fileSearch;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: BGSFileSearchHandler 
 * @Description: 文件查询列表、查看、导出
 * @author panfeng
 * @date 2014-9-17
 *  
 */
public class BGSFileSearchHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public BGSFileSearchHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 办公室、安置部、档案部、爱之桥文件查询列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList BGSFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String NAME = data.getString("NAME", null);	//姓名
		String AF_POSITION = data.getString("AF_POSITION", null);	//文件位置
		String AF_GLOBAL_STATE = data.getString("AF_GLOBAL_STATE", null);	//文件状态
		String FAMILY_TYPE = data.getString("FAMILY_TYPE", null);	//收养类型
		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//省份
		String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("BGSFileList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, NAME, AF_POSITION, AF_GLOBAL_STATE, COUNTRY_CODE, ADOPT_ORG_ID, FAMILY_TYPE, FAMILY_TYPE, PROVINCE_ID, WELFARE_ID, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 审核部文件查询列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList SHBFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String MALE_NATION = data.getString("MALE_NATION", null);	//男方国籍
		String MALE_BIRTHDAY_START = data.getString("MALE_BIRTHDAY_START", null);	//起始男出生日期
		String MALE_BIRTHDAY_END = data.getString("MALE_BIRTHDAY_END", null);	//截止男出生日期
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FEMALE_NATION = data.getString("FEMALE_NATION", null);	//女方国籍
		String FEMALE_BIRTHDAY_START = data.getString("FEMALE_BIRTHDAY_START", null);	//起始女出生日期
		String FEMALE_BIRTHDAY_END = data.getString("FEMALE_BIRTHDAY_END", null);	//截止女出生日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String FAMILY_TYPE = data.getString("FAMILY_TYPE", null);	//收养类型
		String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", null);	//是否公约收养
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("SHBFileList", FILE_NO, FILE_TYPE, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, MALE_NATION, MALE_BIRTHDAY_START, MALE_BIRTHDAY_END, FEMALE_NAME, FEMALE_NATION, FEMALE_BIRTHDAY_START, FEMALE_BIRTHDAY_END, COUNTRY_CODE, ADOPT_ORG_ID, FAMILY_TYPE, IS_CONVENTION_ADOPT, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getFileData 
	 * @Description: 根据文件ID获取文件的详细信息
	 * @author: panfeng;
	 * @param conn
	 * @param fileID
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data getFileData(Connection conn, String fileID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFileData", fileID);
		return ide.find(sql).getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: getChildDataList 
	 * @Description: 根据儿童材料ID获取儿童详细信息
	 * @author: panfeng;
	 * @param conn
	 * @param ci_id
	 * @return    设定文件 
	 * @return DataList    返回类型 
	 * @throws 
	 */
	public DataList getChildDataList(Connection conn, String str_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ci_id = "'";
		if(str_id.indexOf(",") > 0){
			String[] child_id = str_id.split(",");
			for(int i = 0; i < child_id.length; i++){
				ci_id += child_id[i] + "','";
			}
			ci_id = ci_id.substring(0, ci_id.lastIndexOf(","));
		}else{
			ci_id += str_id + "'";
		}
		String sql = getSql("getChildDataList",ci_id);
		dl = ide.find(sql);
		return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getPreList 
	 * @Description: 根据预批信息ID获取预批基本信息
	 * @author: panfeng;
	 * @param conn
	 * @param ri_id
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public DataList getPreList(Connection conn, String riIds) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ri_id = "'";
		if(riIds.indexOf(",") > 0){
			String[] child_id = riIds.split(",");
			for(int i = 0; i < child_id.length; i++){
				ri_id += child_id[i] + "','";
			}
			ri_id = ri_id.substring(0, ri_id.lastIndexOf(","));
		}else{
			ri_id += riIds + "'";
		}
		String sql = getSql("getPreList",ri_id);
		dl = ide.find(sql);
		return dl;
	}
    
}
