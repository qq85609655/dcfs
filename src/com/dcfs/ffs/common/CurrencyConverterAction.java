/**   
 * @Title: CurrencyConverterAction.java 
 * @Package com.dcfs.ffs.common 
 * @Description: 货币转换
 * @author yangrt   
 * @date 2014-11-3 下午1:20:11 
 * @version V1.0   
 */
package com.dcfs.ffs.common;

import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.text.DecimalFormat;

/** 
 * @ClassName: CurrencyConverterAction 
 * @Description: 货币转换
 * @author yangrt
 * @date 2014-11-3 下午1:20:11 
 *  
 */
public class CurrencyConverterAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(CurrencyConverterAction.class);
	private CurrencyConverterHandler handler;

	/* (非 Javadoc) 
	 * <p>Title: execute</p> 
	 * <p>Description: </p> 
	 * @return
	 * @throws Exception 
	 * @see hx.common.j2ee.BaseAction#execute() 
	 */
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	public CurrencyConverterAction(){
		this.handler = new CurrencyConverterHandler();
	}
	
	/**
	 * @Title: OtherToUSD 
	 * @Description: 由其他货币转换为美元
	 * @author: yangrt
	 * @param conn
	 * @param currency
	 * @param data
	 * 		男收养人年收入:MALE_YEAR_INCOME
	 * 		女收养人年收入:FEMALE_YEAR_INCOME
	 * 		家庭总资产:TOTAL_ASSET
	 * 		家庭总债务:TOTAL_DEBT
	 * 		币种:CURRENCY
	 * @return Data
	 * @throws DBException
	 */
	public Data OtherToUSD(Connection conn, Data data) throws DBException{
		String currency = data.getString("CURRENCY","");					//币种code
		String male_income = data.getString("MALE_YEAR_INCOME","");		//男收养人年收入
		String female_income = data.getString("FEMALE_YEAR_INCOME","");	//女收养人年收入
		String asset = data.getString("TOTAL_ASSET","");				//家庭总资产
		String bebt = data.getString("TOTAL_DEBT","");					//家庭总债务
		if(!"".equals(currency)){
			//根据币种code获取转换美元的汇率
			String rate = handler.getRateByCode(conn, currency);
			double rate_num = Double.parseDouble(rate);
			if(!"".equals(male_income)){
				double male_income_num = Double.parseDouble(male_income);
				double male_income_USD = male_income_num * rate_num / 100;
				data.add("MALE_YEAR_INCOME", male_income_USD + "");
			}
			if(!"".equals(female_income)){
				double female_income_num = Double.parseDouble(female_income);
				double female_income_USD = female_income_num * rate_num / 100;
				data.add("FEMALE_YEAR_INCOME", female_income_USD + "");
			}
			if(!"".equals(asset)){
				double asset_num = Double.parseDouble(asset);
				double asset_USD = asset_num * rate_num / 100;
				data.add("TOTAL_ASSET", asset_USD + "");
			}
			if(!"".equals(bebt)){
				double bebt_num = Double.parseDouble(bebt);
				double bebt_USD = bebt_num * rate_num / 100;
				data.add("TOTAL_DEBT", bebt_USD + "");
			}
		}
		
		return data;
	}
	
	/**
	 * @Title: USDToOther 
	 * @Description: 美元转换为其他货币
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * 		男收养人年收入:MALE_YEAR_INCOME
	 * 		女收养人年收入:FEMALE_YEAR_INCOME
	 * 		家庭总资产:TOTAL_ASSET
	 * 		家庭总债务:TOTAL_DEBT
	 * 		币种:CURRENCY
	 * @return Data 
	 * @throws DBException
	 */
	public Data USDToOther(Connection conn, Data data) throws DBException{
		String currency = data.getString("CURRENCY","");					//币种code
		String male_income = data.getString("MALE_YEAR_INCOME","");		//男收养人年收入
		String female_income = data.getString("FEMALE_YEAR_INCOME","");	//女收养人年收入
		String asset = data.getString("TOTAL_ASSET","");				//家庭总资产
		String bebt = data.getString("TOTAL_DEBT","");					//家庭总债务
		if(!"".equals(currency)){
			//根据币种code获取转换美元的汇率
			String rate = handler.getRateByCode(conn, currency);
			double rate_num = Double.parseDouble(rate);
			DecimalFormat decimalFormat = new DecimalFormat("#0.00");//格式化设置  
			if(!"".equals(male_income)){
				double male_income_num = Double.parseDouble(male_income);
				double male_income_Other = male_income_num * 100 / rate_num;
				data.add("MALE_YEAR_INCOME", decimalFormat.format(male_income_Other).toString());
			}
			if(!"".equals(female_income)){
				double female_income_num = Double.parseDouble(female_income);
				double female_income_Other = female_income_num * 100 / rate_num;
				data.add("FEMALE_YEAR_INCOME", decimalFormat.format(female_income_Other).toString());
			}
			if(!"".equals(asset)){
				double asset_num = Double.parseDouble(asset);
				double asset_Other = asset_num * 100 / rate_num;
				data.add("TOTAL_ASSET", decimalFormat.format(asset_Other).toString());
			}
			if(!"".equals(bebt)){
				double bebt_num = Double.parseDouble(bebt);
				double bebt_Other = bebt_num * 100 / rate_num;
				data.add("TOTAL_DEBT", decimalFormat.format(bebt_Other).toString());
			}
		}
		return data;
	}
	
}
