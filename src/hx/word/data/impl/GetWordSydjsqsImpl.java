/**
 * 
 */
package hx.word.data.impl;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.ncm.MatchAction;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.word.data.BaseData;

/**
 * @author wang
 *
 */
public class GetWordSydjsqsImpl  extends BaseData{
    
	public Map<String, Object> getData(Connection conn, String id) throws DBException {
		  Map<String,Object> dataMap=new HashMap<String,Object>();
		  //获取收养登记申请书的数据
		  Data d = setData(conn, id);
		  
		  //将数据赋值到模板中		  
	      dataMap.put("ci_name", d.getString("NAME",""));					//儿童姓名
	      String FAMILY_TYPE = d.getString("FAMILY_TYPE");	//收养类型
	      String ADOPTER_SEX = d.getString("ADOPTER_SEX"); //收养人性别
	      dataMap.put("MALE_NAME", d.getString("MALE_NAME",""));	//收养人姓名_男方
	      dataMap.put("FEMALE_NAME", d.getString("FEMALE_NAME",""));	//收养人姓名_女方
	      dataMap.put("MALE_BIRTHDAY", d.getDate("MALE_BIRTHDAY"));	//收养人出生日期_男方
	      dataMap.put("FEMALE_BIRTHDAY", d.getDate("FEMALE_BIRTHDAY"));	//收养人出生日期_女方
	      dataMap.put("MALE_PASSPORT_NO", d.getString("MALE_PASSPORT_NO",""));	//收养人护照号码_男方
	      dataMap.put("FEMALE_PASSPORT_NO", d.getString("FEMALE_PASSPORT_NO",""));	//收养人护照号码_女方
	      dataMap.put("MALE_NATION", d.getString("MALE_NATION_NAME",""));	//收养人国籍_男方
	      dataMap.put("FEMALE_NATION", d.getString("FEMALE_NATION_NAME",""));	//收养人国籍_女方
	      dataMap.put("MALE_JOB_CN", d.getString("MALE_JOB_CN",""));	//收养人职业_男方
	      dataMap.put("FEMALE_JOB_CN", d.getString("FEMALE_JOB_CN",""));	//收养人职业_女方
	      dataMap.put("MALE_EDUCATION", d.getString("MALE_EDUCATION_NAME",""));	//收养人文化程度_男方
	      dataMap.put("FEMALE_EDUCATION", d.getString("FEMALE_EDUCATION_NAME",""));	//收养人文化程度_女方
	      dataMap.put("MALE_HEALTH", d.getString("MALE_HEALTH_NAME",""));	//收养人健康状况_男方
	      dataMap.put("FEMALE_HEALTH", d.getString("FEMALE_HEALTH_NAME",""));	//收养人健康状况_女方
	      if("1".endsWith(FAMILY_TYPE)){//双亲收养
	    	  dataMap.put("MALE_MARRY_CONDITION", "已婚");	//收养人_婚姻状况
	    	  dataMap.put("FEMALE_MARRY_CONDITION", "已婚");	//收养人_婚姻状况
	      }else{
	    	  if("1".equals(ADOPTER_SEX)){//收养人性别为男
	    		  dataMap.put("MALE_MARRY_CONDITION", d.getString("MARRY_CONDITION_NAME"));	//收养人_婚姻状况
	    		  dataMap.put("FEMALE_MARRY_CONDITION", "");	//收养人_婚姻状况
	    	  }else{
	    		  dataMap.put("FEMALE_MARRY_CONDITION", d.getString("MARRY_CONDITION_NAME"));	//收养人_婚姻状况
	    		  dataMap.put("MALE_MARRY_CONDITION", "");	//收养人_婚姻状况
	    	  }	    	  
	      }
	      dataMap.put("CHILD_CONDITION_CN", d.getString("CHILD_CONDITION_CN",""));	//收养人_子女情况
	      dataMap.put("TOTAL_ASSET", d.getInt("TOTAL_ASSET"));	//收养人_总资产
	      dataMap.put("TOTAL_DEBT", d.getInt("TOTAL_DEBT"));	//收养人_总债务
	      Integer  TOTAL_RESULT = d.getInt("TOTAL_ASSET") - d.getInt("TOTAL_DEBT");
	     dataMap.put("TOTAL_RESULT", TOTAL_RESULT.toString());	//收养人_净资产
	     dataMap.put("ADDRESS", d.getString("ADDRESS",""));	//收养人_家庭住址
	     dataMap.put("NAME_CN", d.getString("NAME_CN",""));	//联 系 收 养 的  收 养 组 织 名 称
	     dataMap.put("SENDER", d.getString("SENDER",""));	//送养人姓名
	     dataMap.put("SENDER_ADDR", d.getString("SENDER_ADDR",""));	//送养人/福利机构地址
	     dataMap.put("SEX", d.getString("SEX_NAME",""));	//被送养人性 别
	     dataMap.put("BIRTHDAY", d.getDate("BIRTHDAY"));	//被送养人出生日期
	     if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(d.getString("CHILD_TYPE"))){//正常儿童
	    	 dataMap.put("SN_TYPE", "健康");	 //身 体 状 况
	     }else{
	    	 dataMap.put("SN_TYPE", d.getString("SN_TYPE_NAME",""));	 //身 体 状 况
	     }
	    dataMap.put("CHILD_IDENTITY", d.getString("CHILD_IDENTITY",""));	//儿童身份
	    //System.out.println( d.getString	("CHILD_IDENTITY",""));
	    //Map<String, CodeList> codes = UtilCode.getCodeLists("ETSFLX"); 
	    //CodeList codeList = UtilCode.getCodeLists("ETSFLX").get("ETSFLX");
	    	
	     dataMap.put("CONTACT_NAME", d.getString("CONTACT_NAME",""));	//经办人姓名
	     dataMap.put("CONTACT_JOB", d.getString("CONTACT_JOB",""));	//经办人职务
	     dataMap.put("CONTACT_CARD", d.getString("CONTACT_CARD",""));	//经办人     身份证件号
	     dataMap.put("CONTACT_TEL", d.getString("CONTACT_TEL",""));	 //经办人联系  电   话
	   return dataMap;
	}
	
	private Data setData(Connection conn, String id) throws DBException{
		Data ret = new Data();
		//获取收养申请书数据
		MatchAction matchAction = new MatchAction();
		ret =  matchAction.getNcmMatchInfoForAdreg(conn, id);		
		return ret;
	}

}
