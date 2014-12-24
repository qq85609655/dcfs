package com.dcfs.ncm.common;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.UtilDateTime;

public class FarCommonHandler extends BaseHandler {
	/**
	 * 获取指定年度省份最大的收养登记流水号
	 * @param conn
	 * @param year 年度
	 * @param province_Code 省份码
	 * @param province 
	 * @return
	 * @throws DBException
	 */
	public Data getMaxFARSn(Connection conn, String year,String province_Code) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxFARSN",year,province_Code));
		return dataList.getData(0);
	}
	/**
	 * 保存生成的收养登记号
	 * @param conn
	 * @param data
	 * @throws DBException
	 */
	public void saveMaxFARSN(Connection conn,Data data) throws DBException {
		data.setEntityName("FAR_REGISTRATION_SN");
		data.setPrimaryKey("PROVINCE_ID","SN","YEAR");
		data.setConnection(conn);
		data.create();
	}
	/**
	 * 获取指定国家年度最大流水号
	 * @param conn
	 * @param year 年度
	 * @param country_Code 国家代码
	 * @return
	 * @throws DBException
	 */
	public Data getMaxCountrySn(Connection conn, String year,String country_Code) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		System.out.println(getSql("getMaxCountrySN", year,country_Code));
		dataList = ide.find(getSql("getMaxCountrySN", year,country_Code));
		return dataList.getData(0);
	}
	/**
	 * 获取指定年度最大送养通知书流水号
	 * @param conn
	 * @param year 年度
	 * @param country_Code 国家代码
	 * @return
	 * @throws DBException
	 */
	public Data getMaxNoticeSn(Connection conn, String year) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxNoticeSN", year));
		return dataList.getData(0);
	}
	/**
	 * 回写国家年度领养流水号
	 * @param conn
	 * @param data
	 * @throws DBException 
	 */
	public void saveMaxCountrySN(Connection conn, Data data) throws DBException {
//		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		data.setPrimaryKey("COUNTRY_CODE","YEAR","SN");
		data.setEntityName("NCM_COUNTRY_SIGN_SN");
		data.setConnection(conn);
		data.create();
		
	}
	/**
	 * 回写年度通知流水号对应的签批号
	 * @param conn
	 * @param data
	 * @throws DBException
	 */
	public void saveMaxNoticeSN(Connection conn, Data data) throws DBException {
//		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		data.setPrimaryKey("YEAR","SN");
		data.setEntityName("NCM_NOTICE_YEAR_SN");
		data.setConnection(conn);
		data.create();
		
	}
	
	/**
	 * 领导签批报批方法
	 * @param data
	 * @throws DBException 
	 */
	public void SignSumbit(Connection conn,DataList datalist) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for(int i =0 ; i<datalist.size(); i++){
			ide.execute(getSql("updateNCM", UtilDateTime.nowDateString(),datalist.getData(i).getString("APP_ID")));
		}
	}

}
