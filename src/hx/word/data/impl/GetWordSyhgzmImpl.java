/**
 * 
 */
package hx.word.data.impl;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.word.data.BaseData;

import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import com.dcfs.ncm.MatchAction;

/**
 * @author wang
 *
 */
public class GetWordSyhgzmImpl  extends BaseData{

	@Override  
	public Map<String, Object> getData(Connection conn, String id) throws DBException {
        
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);        
			
		  Map<String,Object> dataMap=new HashMap<String,Object>();
		  //获取收养合格证明的数据
		  Data d = setData(conn, id);
		  //将数据赋值到模板中		  
		  String ADREG_NO = d.getString("ADREG_NO","");		  
		  dataMap.put("ADREG_NO",ADREG_NO);												//收养登记_登记证号
		  dataMap.put("NAME",d.getString("NAME",""));										//儿童姓名
		  dataMap.put("NAME_PINYIN",d.getString("NAME_PINYIN",""));			//儿童姓名拼音
		  dataMap.put("MALE_NAME",d.getString("MALE_NAME",""));					//男方
		  dataMap.put("FEMALE_NAME",d.getString("FEMALE_NAME",""));			//女方
		  
		  String ADVICE_NOTICE_DATE = d.getDate("ADVICE_NOTICE_DATE");	//征求意见_通知日期
		  Date d_ADVICE_NOTICE_DATE = null;
		  String NYEAR = "    ";
		  String NM = "  ";
		  String ND = "  ";
		  if(!"".equals(ADVICE_NOTICE_DATE) && ADVICE_NOTICE_DATE.length()>=10 ){
			  
			  NYEAR = ADVICE_NOTICE_DATE.substring(0,4);
			  NM = ADVICE_NOTICE_DATE.substring(5,7);
			  ND = ADVICE_NOTICE_DATE.substring(8, 10);
			  try {
					d_ADVICE_NOTICE_DATE = simpleDateFormat.parse(ADVICE_NOTICE_DATE);
					ADVICE_NOTICE_DATE = sdfEN.format(d_ADVICE_NOTICE_DATE);
				} catch (ParseException e) {
					e.printStackTrace();
				}
		  }
		  dataMap.put("NYEAR", NYEAR);	
		  dataMap.put("NM", NM);	
		  dataMap.put("ND", ND);			  
		  dataMap.put("ADVICE_NOTICE_DATE", ADVICE_NOTICE_DATE);	
		  
		  String ADVICE_CFM_DATE = d.getDate("ADVICE_CFM_DATE");	//征求意见确认日期
		  String AYEAR = "";
		  String AM = "";
		  String AD = "";
		  if(!"".equals(ADVICE_CFM_DATE) && ADVICE_CFM_DATE.length()>=10 ){
			  AYEAR = ADVICE_CFM_DATE.substring(0,4);
			  AM = ADVICE_CFM_DATE.substring(5,7);
			  AD = ADVICE_CFM_DATE.substring(8, 10);
			  try {
					Date d_ADVICE_CFM_DATE = simpleDateFormat.parse(ADVICE_CFM_DATE);
					ADVICE_CFM_DATE = sdfEN.format(d_ADVICE_CFM_DATE);
				} catch (ParseException e) {
					e.printStackTrace();
				}
		  }
		  dataMap.put("AYEAR", AYEAR);	
		  dataMap.put("AM", AM);	
		  dataMap.put("AD", AD);
		  dataMap.put("ADVICE_CFM_DATE", ADVICE_CFM_DATE);	
		  
		  dataMap.put("ADVICE_GOV_CN", d.getString("ADVICE_GOV_CN",""));	//征求意见确认机关
		  dataMap.put("ADVICE_GOV_EN", d.getString("ADVICE_GOV_EN",""));	//征求意见确认机关
		  
		  String NOTICE_SIGN_DATE = d.getDate("NOTICE_SIGN_DATE");	//签发日期
		  String SYEAR = "";
		  String SM = "";
		  String SD = "";
		  if(!"".equals(NOTICE_SIGN_DATE) && NOTICE_SIGN_DATE.length()>=10 ){
			  SYEAR = NOTICE_SIGN_DATE.substring(0,4);
			  SM = NOTICE_SIGN_DATE.substring(5,7);
			  SD = NOTICE_SIGN_DATE.substring(8, 10);
			  try {
					Date d_NOTICE_SIGN_DATE = simpleDateFormat.parse(NOTICE_SIGN_DATE);
					NOTICE_SIGN_DATE = sdfEN.format(d_NOTICE_SIGN_DATE);
				} catch (ParseException e) {
					e.printStackTrace();
				}
		  }
		  
		  dataMap.put("SYEAR", SYEAR);	
		  dataMap.put("SM", SM);	
		  dataMap.put("SD", SD);
		  dataMap.put("SIGN_DATE", NOTICE_SIGN_DATE);	
		  
		  dataMap.put("ADREG_ORG_CN",  d.getString("ADREG_ORG_CN"));	
		  dataMap.put("ADREG_ORG_EN",  d.getString("ADREG_ORG_EN"));	
		  
		  String ADREG_DATE = d.getDate("ADREG_DATE");
		  String RYEAR = "";
		  String RM = "";
		  String RD = "";
		  if(!"".equals(ADREG_DATE) && ADREG_DATE.length()>=10 ){
			  RYEAR = ADREG_DATE.substring(0,4);
			  RM = ADREG_DATE.substring(5,7);
			  RD = ADREG_DATE.substring(8, 10);
			  try {
					Date d_ADREG_DATE = simpleDateFormat.parse(ADREG_DATE);
					ADREG_DATE = sdfEN.format(d_ADREG_DATE);
				} catch (ParseException e) {
					e.printStackTrace();
				}
		  }
		  dataMap.put("RYEAR", RYEAR);	
		  dataMap.put("RM", RM);	
		  dataMap.put("RD", RD);
		  dataMap.put("ADREG_DATE", ADREG_DATE);	
		  
		  dataMap.put("PROVINCE_CN", d.getString("CITY_ADDRESS_CN",""));	
		  dataMap.put("PROVINCE_EN", d.getString("CITY_ADDRESS_EN",""));	
	   return dataMap;
	}
	
	private Data setData(Connection conn, String id) throws DBException{
		Data ret = new Data();
		//获取收养合格证数据
		//MatchHandler matchHandler = new MatchHandler();
		MatchAction matchAction = new MatchAction();
		ret =  matchAction.getIntercountryAdoptionInfo(conn, id);
		
		return ret;
	}
	
	

}
