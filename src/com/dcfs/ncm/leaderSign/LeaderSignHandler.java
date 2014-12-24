package com.dcfs.ncm.leaderSign;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

public class LeaderSignHandler extends BaseHandler {

	public DataList findLeaderSignList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
		// TODO Auto-generated method stub
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT T.MI_ID AS MI_ID,T.SIGN_DATE AS SIGN_DATE,T.AF_ID AS AF_ID,T.FILE_NO AS FILE_NO,T.REGISTER_DATE AS REGISTER_DATE,T.COUNTRY_CODE AS COUNTRY_CODE,T.COUNTRY_CN AS COUNTRY_CN,T.ADOPT_ORG_ID AS ADOPT_ORG_ID,T.NAME_CN AS NAME_CN,T.MALE_NAME AS MALE_NAME,T.FEMALE_NAME AS FEMALE_NAME,T.FILE_TYPE AS FILE_TYPE,T.CI_ID AS CI_ID,T.CHILD_TYPE AS CHILD_TYPE,T.PROVINCE_ID AS PROVINCE_ID,T.WELFARE_ID AS WELFARE_ID,T.WELFARE_NAME_CN AS WELFARE_NAME_CN,T.NAME AS NAME,T.SEX AS SEX,T.BIRTHDAY AS BIRTHDAY ,T.SIGN_STATE AS SIGN_STATE,T.SIGN_SUBMIT_DATE AS SIGN_SUBMIT_DATE FROM (");
		sql.append("select mi.MI_ID,mi.SIGN_DATE,mi.SIGN_SUBMIT_DATE,mi.NOTICE_DATE,mi.NOTICE_STATE,af.AF_ID,af.FILE_NO,af.REGISTER_DATE,af.COUNTRY_CODE,af.COUNTRY_CN,af.ADOPT_ORG_ID,af.NAME_CN,af.MALE_NAME,af.FEMALE_NAME,af.FILE_TYPE,ci.CI_ID,ci.CHILD_TYPE,ci.PROVINCE_ID,ci.WELFARE_ID,ci.WELFARE_NAME_CN,ci.NAME,ci.SEX,ci.BIRTHDAY,SIGN_STATE ");
		sql.append("from NCM_MATCH_INFO mi left join FFS_AF_INFO af on af.AF_ID=mi.AF_ID left join CMS_CI_INFO ci on ci.CI_ID=mi.CI_ID where mi.MATCH_STATE <> '9') T ");
		sql.append("where 1=1 ");
		if(data.getString("FILE_NO")!=null&&!"".equals(data.getString("FILE_NO"))){ //收文编号
			sql.append("AND FILE_NO LIKE '%"+data.getString("FILE_NO")+"%' ");
		}
		if(data.getString("FILE_TYPE")!=null&&!"".equals(data.getString("FILE_TYPE"))){ //文件类型
			sql.append("AND FILE_TYPE = '"+data.getString("FILE_TYPE")+"' ");
		}
		if(data.getString("REGISTER_DATE_START")!=null&&!"".equals(data.getString("REGISTER_DATE_START"))){ //收文时间开始
			sql.append("AND REGISTER_DATE >= to_date('"+data.getString("REGISTER_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("REGISTER_DATE_END")!=null&&!"".equals(data.getString("REGISTER_DATE_END"))){ //收文时间截止
			sql.append("AND REGISTER_DATE <= to_date('"+data.getString("REGISTER_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("COUNTRY_CODE")!=null&&!"".equals(data.getString("COUNTRY_CODE"))){ //国家编码
			sql.append("AND COUNTRY_CODE = '"+data.getString("COUNTRY_CODE")+"' ");
		}
		if(data.getString("ADOPT_ORG_ID")!=null&&!"".equals(data.getString("ADOPT_ORG_ID"))){ //收养组织编码
			sql.append("AND ADOPT_ORG_ID = '"+data.getString("ADOPT_ORG_ID")+"' ");
		}
		if(data.getString("SIGN_SUBMIT_DATE_START")!=null&&!"".equals(data.getString("SIGN_SUBMIT_DATE_START"))){ //报批时间开始
			sql.append("AND SIGN_SUBMIT_DATE >= to_date('"+data.getString("SIGN_SUBMIT_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("SIGN_SUBMIT_DATE_END")!=null&&!"".equals(data.getString("SIGN_SUBMIT_DATE_END"))){ //报批时间截止
			sql.append("AND SIGN_SUBMIT_DATE <= to_date('"+data.getString("SIGN_SUBMIT_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("MALE_NAME")!=null&&!"".equals(data.getString("MALE_NAME"))){ //男方姓名
			sql.append("AND MALE_NAME LIKE '%"+data.getString("MALE_NAME")+"%' ");
		}
		if(data.getString("FEMALE_NAME")!=null&&!"".equals(data.getString("FEMALE_NAME"))){ //女方姓名
			sql.append("AND FEMALE_NAME LIKE '%"+data.getString("FEMALE_NAME")+"%' ");
		}
		if(data.getString("SIGN_DATE_START")!=null&&!"".equals(data.getString("SIGN_DATE_START"))){ //签批时间开始
			sql.append("AND SIGN_DATE >= to_date('"+data.getString("SIGN_DATE_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("SIGN_DATE_END")!=null&&!"".equals(data.getString("SIGN_DATE_END"))){ //签批时间截止
			sql.append("AND SIGN_DATE <= to_date('"+data.getString("SIGN_DATE_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("NAME")!=null&&!"".equals(data.getString("NAME"))){ //儿童姓名
			sql.append("AND NAME LIKE '%"+data.getString("NAME")+"%' ");
		}
		if(data.getString("SEX")!=null&&!"".equals(data.getString("SEX"))){ //性别
			sql.append("AND SEX = '"+data.getString("SEX")+"' ");
		}
		if(data.getString("BIRTHDAY_START")!=null&&!"".equals(data.getString("BIRTHDAY_START"))){ //出生时间开始
			sql.append("AND BIRTHDAY >= to_date('"+data.getString("BIRTHDAY_START")+"','yyyy-MM-DD') ");
		}
		if(data.getString("BIRTHDAY_END")!=null&&!"".equals(data.getString("BIRTHDAY_END"))){ //出生时间截止
			sql.append("AND BIRTHDAY <= to_date('"+data.getString("BIRTHDAY_END")+"','yyyy-MM-DD') ");
		}
		if(data.getString("PROVINCE_ID")!=null&&!"".equals(data.getString("PROVINCE_ID"))){ //省份
			sql.append("AND PROVINCE_ID = '"+data.getString("PROVINCE_ID")+"' ");
		}
		if(data.getString("WELFARE_ID")!=null&&!"".equals(data.getString("WELFARE_ID"))){ //福利院
			sql.append("AND WELFARE_ID = '"+data.getString("WELFARE_ID")+"' ");
		}
		/*if(data.getString("CHILD_TYPE")!=null&&!"".equals(data.getString("CHILD_TYPE"))){ //儿童类型
			sql.append(" AND CHILD_TYPE = '"+data.getString("CHILD_TYPE")+"' ");
		}*/
		if(data.getString("SIGN_STATE")==null||"".equals(data.getString("SIGN_STATE"))){ //儿童类型
		    sql.append("AND SIGN_STATE = '0' ");
		}else if("9".equals(data.getString("SIGN_STATE"))){
		    sql.append("AND SIGN_STATE IN ('0','1','2') ");
		}else{
		    sql.append("AND SIGN_STATE = '"+data.getString("SIGN_STATE")+"' ");
		}
		if(compositor!=null&&!"".equals(compositor)){ //排序字段
            sql.append("ORDER BY ");
            sql.append(compositor);
        }
        if(ordertype!=null&&!"".equals(ordertype)){ //排序方向
            sql.append(" ");
            sql.append(ordertype);
        }
		System.out.println(sql.toString());
		return ide.find(sql.toString(),pageSize,page);
	}
	/**
	 * 签批确认
	 * @param conn
	 * @param data
	 * @throws DBException 
	 */
	public void saveSignDate(Connection conn, Data data) throws DBException {
		data.setPrimaryKey("MI_ID");
		data.setEntityName("NCM_MATCH_INFO");
		data.setConnection(conn);
		data.store();
		
	}
	

}
