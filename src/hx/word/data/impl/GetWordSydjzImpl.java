/**
 * 
 */
package hx.word.data.impl;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.word.data.BaseData;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.ncm.MatchAction;

/**
 * @author wang
 *
 */
public class GetWordSydjzImpl  extends BaseData{

	@Override  
	public Map<String, Object> getData(Connection conn, String id) throws DBException {
		  Map<String,Object> dataMap=new HashMap<String,Object>();
		  //获取收养登记证的数据
		  Data d = setData(conn, id);
		  
		  //将数据赋值到模板中		  
		  String ADREG_NO = d.getString("ADREG_NO","");
		  if(!"".equals(ADREG_NO) && ADREG_NO.length()==12){
			  dataMap.put("NO1",ADREG_NO.substring(0, 2));					//收养登记_登记证号
			  dataMap.put("NO2",ADREG_NO.substring(2, 4));					//收养登记_登记证号
			  dataMap.put("NO3",ADREG_NO.substring(4, 8));					//收养登记_登记证号
			  dataMap.put("NO4",ADREG_NO.substring(8, 12));					//收养登记_登记证号
		  }else{
			  dataMap.put("NO1","X1X2");					//收养登记_登记证号
			  dataMap.put("NO2","X3X4");					//收养登记_登记证号
			  dataMap.put("NO3","X5X6X7X8");					//收养登记_登记证号
			  dataMap.put("NO4","X9X10X11X12");					//收养登记_登记证号
		  }
		  dataMap.put("NAME",d.getString("NAME",""));					//儿童姓名
		  dataMap.put("CHILD_NAME_EN",d.getString("CHILD_NAME_EN",""));					//儿童入籍姓名
		  dataMap.put("SENDER", d.getString("SENDER",""));	//送养人姓名
	     dataMap.put("SENDER_ADDR", d.getString("SENDER_ADDR",""));	//送养人/福利机构地址
	     dataMap.put("SEX", d.getString("SEX_NAME",""));	//被送养人性别
	     dataMap.put("BIRTHDAY", d.getDate("BIRTHDAY"));	//被送养人出生日期
	     dataMap.put("CHILD_IDENTITY_NAME", d.getString("CHILD_IDENTITY_NAME",""));	//儿童身份
	     dataMap.put("ID_CARD", d.getString("ID_CARD",""));	//儿童身份证件号
	     
	      dataMap.put("MALE_NAME", d.getString("MALE_NAME",""));	//收养人姓名_男方
	      dataMap.put("FEMALE_NAME", d.getString("FEMALE_NAME",""));	//收养人姓名_女方
	      dataMap.put("MALE_BIRTHDAY", d.getDate("MALE_BIRTHDAY"));	//收养人出生日期_男方
	      dataMap.put("FEMALE_BIRTHDAY", d.getDate("FEMALE_BIRTHDAY"));	//收养人出生日期_女方
	      dataMap.put("MALE_PASSPORT_NO", d.getString("MALE_PASSPORT_NO",""));	//收养人护照号码_男方
	      dataMap.put("FEMALE_PASSPORT_NO", d.getString("FEMALE_PASSPORT_NO",""));	//收养人护照号码_女方
	      dataMap.put("MALE_NATION", d.getString("MALE_NATION_NAME",""));	//收养人国籍_男方
	      dataMap.put("FEMALE_NATION", d.getString("FEMALE_NATION_NAME",""));	//收养人国籍_女方	      
	     dataMap.put("ADDRESS", d.getString("ADDRESS",""));	//收养人_家庭住址
	    
	   return dataMap;
	}
	
	private Data setData(Connection conn, String id) throws DBException{
		Data ret = new Data();
		//获取收养申请书数据
		MatchAction matchAction = new MatchAction();
		
		ret =  matchAction.getNcmMatchInfoForAdregCard(conn, id);
		
		return ret;
	}
	
	

}
