package com.dcfs.ffs.common;

import java.sql.Connection;
import java.util.Map;

import java_cup.internal_error;


import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 文件办理公共handler类
 * @description 
 * @author MaYun
 * @date Jul 22, 2014
 * @return
 */
public class FileCommonManagerHandler extends BaseHandler {
	
	/**
	 * 
	 * @description 得到当前最大3位流水号
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return
	 */
	public synchronized Data getMaxFileSeqNo (Connection conn,String year,String month,String day) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxFileSeqNo", year,month,day));
		return dataList.getData(0);
	}
	
	/**
	 * 向数据库插入文件流水号
	 * @description 
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return
	 */
	public synchronized void saveMaxFileSeqNo (Connection conn, Map<String, Object> data)throws DBException{
		Data dataadd = new Data(data);
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("FFS_AF_SEQNO");
	    dataadd.setPrimaryKey("SEQ_ID");
	    dataadd.create();
	}
	
	
	/**
	 * 
	 * @description 得到当前最大收文编号的5位流水号
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return
	 */
	public synchronized Data getMaxFileNo (Connection conn,String year) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxFileNo", year));
		return dataList.getData(0);
	}
	
	/**
	 * 向数据库插入收文编号
	 * @description 
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return
	 */
	public synchronized void saveMaxFileNo (Connection conn, Map<String, Object> data)throws DBException{
		Data dataadd = new Data(data);
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("FFS_AF_FILENO");
	    dataadd.setPrimaryKey("FILE_ID");
	    dataadd.create();
	}
	
	/**
	 * 
	 * @description 得到当前最大缴费编号的3位流水号
	 * @author MaYun
	 * @date 2014-8-4
	 * @return
	 */
	public synchronized Data getMaxPayNo (Connection conn,String year,String orgCode,String costType) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxPayNo", year,orgCode,costType));
		return dataList.getData(0);
	}
	
	/**
	 * 向数据库插入缴费编号
	 * @description 
	 * @author MaYun
	 * @date 2014-8-4
	 * @return
	 */
	public synchronized void saveMaxPayNo (Connection conn, Map<String, Object> data)throws DBException{
		Data dataadd = new Data(data);
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("FAM_CHEQUE_PAYNO");
	    dataadd.setPrimaryKey("PAY_ID");
	    dataadd.create();
	}
	
	/**
	 * 
	 * @description 得到当前最大移交单编号的3位流水号
	 * @author MaYun
	 * @date 2014-8-5
	 * @return
	 */
	public synchronized Data getMaxConnectNo (Connection conn,String year,String fromDeptCode,String toDeptCode) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxConnectNo", year,fromDeptCode,toDeptCode));
		return dataList.getData(0);
	}
	
	/**
	 * 向数据库插入移交单编号
	 * @description 
	 * @author MaYun
	 * @date 2014-8-5
	 * @return
	 */
	public synchronized void saveMaxConnectNo (Connection conn, Map<String, Object> data)throws DBException{
		Data dataadd = new Data(data);
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("TRANSFER_CONNECT_NO");
	    dataadd.setPrimaryKey("CONNECT_ID");
	    dataadd.create();
	}
	
	/**
	 * 
	 * @description 根据国家代码获取收养组织NameList(通过收养组织码表形式获得)
	 * @author MaYun
	 * @date Jul 24, 2014
	 * @return DataList
	 */
	public DataList getSyzzNameListByCodeTable (Connection conn, String countryCode)throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		DataList dataList2 = new DataList();
		dataList = ide.find(getSql("getSyzzNameListNew", countryCode));
		
		int num = dataList.size();
		for(int i=0;i<num;i++){
			Data data = dataList.getData(i);
			String codeLetter = data.getString("CODELETTER");
			String codeName = data.getString("CODENAME");
			String codeValue = data.getString("CODEVALUE");
			data.add("CODENAME", codeName);
			data.add("CODELETTER",codeLetter);
			dataList2.add(data);
		}
		//dataList = ide.find(getSql("getSyzzNameList", countryCode));
		//System.out.println("getSyzzNameList-->"+getSql("getSyzzNameList", countryCode));
		return dataList2;
	}
	
	/**
	 * 根据收文编号获取收养文件基本信息
	 * @description 
	 * @author MaYun
	 * @date Aug 6, 2014
	 * @param Connection conn 数据库连接池，非必填参数
	 * @param Stirng fileNO 收文编号，必填参数
	 * @return Data fileData
	 * @throws DBException 
	 */
	public Data getFileInfo(String fileNO,Connection conn) throws DBException{
		Data data = new Data();
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getFileInfo", fileNO));
		data = dataList.getData(0);
		String femaleBirthday = data.getDate("FEMALE_BIRTHDAY");
		String maileBirthday = data.getDate("MALE_BIRTHDAY");
		data.add("FEMALE_BIRTHDAY", femaleBirthday);
		data.add("MALE_BIRTHDAY", maileBirthday);
		
		return data;
	}
	
	/**
	 * 根据国家Code获得国家基本信息
	 * @description 
	 * @author MaYun
	 * @date Oct 27, 2014
	 * @return
	 */
	public Data getCountryInfo(Connection conn,String countryCode)throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		Data data = new Data();
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getCountryInfo", countryCode));
		if(dataList.size()>0){
			data = dataList.getData(0);
		}
		return data;
	}

	/**
	 * @throws DBException  
	 * @Title: getAfCost 
	 * @Description: 根据文件类型获取文件应缴费用
	 * @author: yangrt
	 * @param conn
	 * @param file_type
	 * 		"ZCWJFWF" : 800
	 * 		"TXWJFWF" : 500
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data getAfCost(Connection conn, String file_type) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAfCost", file_type);
		return ide.find(sql).getData(0);
	}

	/**
	 * @throws DBException  
	 * @Title: getAdopterNation 
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @author: yangrt;
	 * @param conn
	 * @param country_code    设定文件 
	 * @return void    返回类型 
	 * @throws 
	 */
	public Data getAdopterNation(Connection conn, String country_code) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAdopterNation", country_code);
		return ide.find(sql).getData(0);
		
	}

}
