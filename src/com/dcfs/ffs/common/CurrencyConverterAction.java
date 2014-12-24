/**   
 * @Title: CurrencyConverterAction.java 
 * @Package com.dcfs.ffs.common 
 * @Description: ����ת��
 * @author yangrt   
 * @date 2014-11-3 ����1:20:11 
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
 * @Description: ����ת��
 * @author yangrt
 * @date 2014-11-3 ����1:20:11 
 *  
 */
public class CurrencyConverterAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(CurrencyConverterAction.class);
	private CurrencyConverterHandler handler;

	/* (�� Javadoc) 
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
	 * @Description: ����������ת��Ϊ��Ԫ
	 * @author: yangrt
	 * @param conn
	 * @param currency
	 * @param data
	 * 		��������������:MALE_YEAR_INCOME
	 * 		Ů������������:FEMALE_YEAR_INCOME
	 * 		��ͥ���ʲ�:TOTAL_ASSET
	 * 		��ͥ��ծ��:TOTAL_DEBT
	 * 		����:CURRENCY
	 * @return Data
	 * @throws DBException
	 */
	public Data OtherToUSD(Connection conn, Data data) throws DBException{
		String currency = data.getString("CURRENCY","");					//����code
		String male_income = data.getString("MALE_YEAR_INCOME","");		//��������������
		String female_income = data.getString("FEMALE_YEAR_INCOME","");	//Ů������������
		String asset = data.getString("TOTAL_ASSET","");				//��ͥ���ʲ�
		String bebt = data.getString("TOTAL_DEBT","");					//��ͥ��ծ��
		if(!"".equals(currency)){
			//���ݱ���code��ȡת����Ԫ�Ļ���
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
	 * @Description: ��Ԫת��Ϊ��������
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * 		��������������:MALE_YEAR_INCOME
	 * 		Ů������������:FEMALE_YEAR_INCOME
	 * 		��ͥ���ʲ�:TOTAL_ASSET
	 * 		��ͥ��ծ��:TOTAL_DEBT
	 * 		����:CURRENCY
	 * @return Data 
	 * @throws DBException
	 */
	public Data USDToOther(Connection conn, Data data) throws DBException{
		String currency = data.getString("CURRENCY","");					//����code
		String male_income = data.getString("MALE_YEAR_INCOME","");		//��������������
		String female_income = data.getString("FEMALE_YEAR_INCOME","");	//Ů������������
		String asset = data.getString("TOTAL_ASSET","");				//��ͥ���ʲ�
		String bebt = data.getString("TOTAL_DEBT","");					//��ͥ��ծ��
		if(!"".equals(currency)){
			//���ݱ���code��ȡת����Ԫ�Ļ���
			String rate = handler.getRateByCode(conn, currency);
			double rate_num = Double.parseDouble(rate);
			DecimalFormat decimalFormat = new DecimalFormat("#0.00");//��ʽ������  
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
