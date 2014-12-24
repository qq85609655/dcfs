/**   
 * @Title: CurrencyConverterHandler.java 
 * @Package CurrencyConverterAction 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author yangrt   
 * @date 2014-11-3 下午1:21:21 
 * @version V1.0   
 */
package com.dcfs.ffs.common;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

/** 
 * @ClassName: CurrencyConverterHandler 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author yangrt;
 * @date 2014-11-3 下午1:21:21 
 *  
 */
public class CurrencyConverterHandler extends BaseHandler {

	/**
	 * @Title: getRateByCode 
	 * @Description: 根据货币code获取换换为美元的汇率
	 * @author: yangrt
	 * @param conn
	 * @param currency
	 * @return String 
	 * @throws DBException
	 */
	public String getRateByCode(Connection conn, String currency) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getRateByCode", currency);
		Data data = ide.find(sql).getData(0);
		return data.getString("RATE","");
	}

}
