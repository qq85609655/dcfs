/**   
 * @Title: BalanceAccountHandler.java 
 * @Package com.dcfs.fam.balanceAccount 
 * @Description: 收养组织结余账户管理
 * @author yangrt   
 * @date 2014-10-23 下午3:46:39 
 * @version V1.0   
 */
package com.dcfs.fam.balanceAccount;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: BalanceAccountHandler 
 * @Description: 收养组织结余账户管理
 * @author yangrt;
 * @date 2014-10-23 下午3:46:39 
 *  
 */
public class BalanceAccountHandler extends BaseHandler {

	/**
	 * @Title: BalanceAccountList 
	 * @Description: 收养组织结余账户查询列表
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException  
	 */
	public DataList BalanceAccountList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String ADOPT_ORG_NO = data.getString("ADOPT_ORG_NO", null);	//收养组织编号
		String ACCOUNT_CURR = data.getString("ACCOUNT_CURR", null);	//当前金额
		String ACCOUNT_LMT = data.getString("ACCOUNT_LMT", null);	//透支额度
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("BalanceAccountList",COUNTRY_CODE,ADOPT_ORG_ID,ADOPT_ORG_NO,ACCOUNT_CURR,ACCOUNT_LMT, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: BalanceAccountSave 
	 * @Description: 收养组织结余账户信息保存
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean 
	 * @throws DBException 
	 */
	public boolean BalanceAccountSave(Connection conn, Data data) throws DBException {
		data.setConnection(conn);
		data.setEntityName("MKR_ADOPT_ORG_INFO");
		data.setPrimaryKey("ADOPT_ORG_ID");
		data.store();
		return true;
	}

	/**
	 * @Title: BalanceAccountDetailList 
	 * @Description: 收养组织结余账户明细列表
	 * @author: yangrt
	 * @param conn
	 * @param ADOPT_ORG_ID
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList BalanceAccountDetailList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);			//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);			//收养组织CODE
		String OPP_DATE_START = data.getString("OPP_DATE_START", null);		//账单起始日期
		String OPP_DATE_END = data.getString("OPP_DATE_END", null);			//账单截止日期
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("BalanceAccountDetailList", COUNTRY_CODE, ADOPT_ORG_ID, OPP_DATE_START, OPP_DATE_END, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
}
