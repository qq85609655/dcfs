package com.dcfs.ncm.common;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.ncm.leaderSign.LeaderSignAction;
import com.dcfs.ncm.leaderSign.LeaderSignHandler;

import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

public class FarCommonAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(LeaderSignAction.class);
	
	private Connection conn = null;
    
	private FarCommonHandler handler;
    
	private DBTransaction dt = null;//事务处理
    
	private String retValue = SUCCESS;
	
	public FarCommonAction(){
        this.handler=new FarCommonHandler();
    }
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 
	 * @description 生成收养登记号(编码规则：X1X2为国家数字编码，X3X4为省份区划编码，X5X6X7X8为年度，X9X10X11X12为该省收养登记流水号。。)
	 * @author 
	 * @date 2014-8-5
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createFARSn(Connection conn,String Country_Code,String province_Code) throws SQLException, DBException{
		String FAR_SN="";//最终收养登记号
		String year = DateUtility.getCurrentYear();//年份
		String province="";//省份缩写
		String pr_ye_sn = "" ;//省份流水号
		
		province=province_Code.substring(0,2);//取省份的前两位
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			//获取省份年度收养登记流水号
			Data datan = this.handler.getMaxFARSn(conn,year,province);
			String maxNoStr = (String)datan.get("SN");//得到最大4位流水号
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				pr_ye_sn="000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				pr_ye_sn="00"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				pr_ye_sn="0"+maxNo;
			}else{
				pr_ye_sn=""+maxNo;
			}
			//拼接签批号
			FAR_SN=Country_Code+province+year+pr_ye_sn;//生成收养登记编号
			Data data4 = new Data();
			data4.add("YEAR",year);
			data4.add("COUNTRY_CODE",Country_Code);
			data4.add("SN",pr_ye_sn);
			data4.add("FAR_SN",FAR_SN);
			data4.add("PROVINCE_ID", province);
			data4.add("IS_USED", "1");
			this.handler.saveMaxFARSN(conn, data4);
		}
		return FAR_SN;
	}
    /**
	 * 
	 * @description 生成领导签批编号(编码规则：X1X2X3X4为年度，X5X6X7为国家字母编码，X8X9X10X11为该国家本年度领养的流水号，X12X13为省份区划编码，X14X15X16X17X18为该年度的通知书流水号。)
	 * @author 
	 * @date 2014-8-5
	 * @return String connectNo 15位移交单编号
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createSignSN(Connection conn,String Country_Code,String province_Code) throws SQLException, DBException{
		String SignSn="";//最终签批号
		String year = DateUtility.getCurrentYear();//年份
		String Country_Name = "";//国家缩写
		String country_Sn = "" ; //国家领养流水号
		String province="";//身份缩写
		String Notice_sn = "" ;//年度通知书流水号
		
		Country_Name=(UtilCode.getCodeLists("GJDM_EN").get("GJDM_EN").getName(Country_Code))[0];
		province=province_Code.substring(0,2);//取省份的前两位
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			//查询领养国家年度流水号
			Data data = this.handler.getMaxCountrySn(conn,year,Country_Code);
			String maxNoStr = (String)data.get("SN");//得到最大4位流水号
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				country_Sn="000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				country_Sn="00"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				country_Sn="0"+maxNo;
			}else{
				country_Sn=""+maxNo;
			}
			//获取年度通知书流水号
			Data datan = this.handler.getMaxNoticeSn(conn,year);
			String max5NoStr = (String)datan.get("SN");//得到最大5位流水号
			if("".equals(max5NoStr)||null==max5NoStr){
				max5NoStr="0";
			}
			int max5No=Integer.parseInt(max5NoStr);
			max5No=max5No+1;
			if(max5No<10){
				Notice_sn="0000"+max5No;
			}else if(max5No>9&&max5No<100){
				Notice_sn="000"+max5No;
			}else if(max5No>99&&max5No<1000){
				Notice_sn="00"+max5No;
			}else if(max5No>999&&max5No<10000){
				Notice_sn="0"+max5No;
			}else{
				Notice_sn=""+max5No;
			}
			//拼接签批号
			SignSn="("+year+")"+Country_Name+"-"+country_Sn+"-"+province+"-"+Notice_sn;//生成移交单编号
			Data data4 = new Data();
			data4.add("YEAR",year);
			data4.add("COUNTRY_CODE",Country_Code);
			data4.add("SN",country_Sn);
			data4.add("SIGN_NO",SignSn);
			this.handler.saveMaxCountrySN(conn, data4);
			Data data5 = new Data();
			data5.add("YEAR",year);
			data5.add("SN",Notice_sn);
			data5.add("SIGN_NO",SignSn);
			this.handler.saveMaxNoticeSN(conn, data5);
		}
		
		return SignSn;
	}
	

}
