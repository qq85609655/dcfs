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
	 * ��ȡָ�����ʡ�����������Ǽ���ˮ��
	 * @param conn
	 * @param year ���
	 * @param province_Code ʡ����
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
	 * �������ɵ������ǼǺ�
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
	 * ��ȡָ��������������ˮ��
	 * @param conn
	 * @param year ���
	 * @param country_Code ���Ҵ���
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
	 * ��ȡָ������������֪ͨ����ˮ��
	 * @param conn
	 * @param year ���
	 * @param country_Code ���Ҵ���
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
	 * ��д�������������ˮ��
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
	 * ��д���֪ͨ��ˮ�Ŷ�Ӧ��ǩ����
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
	 * �쵼ǩ����������
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
