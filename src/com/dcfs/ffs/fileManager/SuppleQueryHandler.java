/**   
 * @Title: SuppleQueryHandler.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: 补充查询操作
 * @author yangrt   
 * @date 2014-9-5 上午10:05:05 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: SuppleQueryHandler 
 * @Description: 补充查询操作
 * @author yangrt;
 * @date 2014-9-5 上午10:05:05 
 *  
 */
public class SuppleQueryHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public SuppleQueryHandler(){
	}

	/**
	 * @Title: SuppleQueryList 
	 * @Description: 补充查询列表
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
	public DataList SuppleQueryList(Connection conn, Data data, String operType, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织code
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String NOTICE_DATE_START = data.getString("SUBMIT_DATE_START", null);	//通知开始日期
		String NOTICE_DATE_END = data.getString("SUBMIT_DATE_END", null);	//通知结束日期
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);	//补充起始日期
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);	//补充截止日期
		String AA_STATUS = data.getString("AA_STATUS", null);	//文件补充状态
		
		String orgcode = null;
		if(!operType.equals("SHB")){
			UserInfo userinfo = SessionInfo.getCurUser();
			orgcode = userinfo.getCurOrgan().getOrgCode();
		}
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("SuppleQueryList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, FILE_TYPE, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, COUNTRY_CODE, ADOPT_ORG_ID, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: getSuppleData 
	 * @Description: 根据文件补充记录ID,获取文件补充信息Data
	 * @author: yangrt
	 * @param conn
	 * @param aa_id
	 * @return Data
	 * @throws DBException
	 */
	public Data getSuppleData(Connection conn, String aa_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getSuppleData", aa_id);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}

	/** 
	 * @Title: getReviseList 
	 * @Description: 文件修改历史记录
	 * @author: yangrt
	 * @param conn
	 * @param af_id
	 * @param compositor
	 * @param ordertype
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList getReviseList(Connection conn, String af_id, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getReviseList", af_id, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}


	/** 
	 * @Title: getChildList 
	 * @Description: 根据儿童信息id,获取儿童信息
	 * @author: yangrt;
	 * @param conn
	 * @param ci_id
	 * @return DataList    返回类型 
	 * @throws DBException
	 */
	public DataList getChildList(Connection conn, String str_ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String ci_id = "'";
		if(str_ci_id.contains(",")){
			for(int i = 0; i < str_ci_id.split(",").length; i++){
				ci_id += str_ci_id.split(",")[i] + "',";
			}
			ci_id = ci_id.substring(0, ci_id.lastIndexOf(","));
		}else{
			ci_id += str_ci_id + "'";
		}
		String sql = getSql("getChildList", ci_id);
		DataList dl = ide.find(sql);
        return dl;
	}

	/**
	 * @Title: getPreAuditList
	 * @Description: 根据预批申请id,获取预批审核记录信息
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return DataList
	 * @throws DBException  
	 */
	public DataList getPreAuditList(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreAuditList", ri_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @Title: getFileAuditList 
	 * @Description: 根据文件ID,获取文件审核信息DataList
	 * @author: yangrt
	 * @param conn
	 * @param af_id
	 * @return DataList 
	 * @throws DBException  
	 */
	public DataList getFileAuditList(Connection conn, String af_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFileAuditList", af_id);
		DataList dl = ide.find(sql);
		return dl;
	}
	
}
