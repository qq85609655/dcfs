/**   
 * @Title: ExtensionApplyHandler.java 
 * @Package com.dcfs.sce.extensionApply 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author yangrt   
 * @date 2014-9-29 上午9:59:27 
 * @version V1.0   
 */
package com.dcfs.sce.extensionApply;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;

/** 
 * @ClassName: ExtensionApplyHandler 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author yangrt;
 * @date 2014-9-29 上午9:59:27 
 *  
 */
public class ExtensionApplyHandler extends BaseHandler {

	/**
	 * @Title: ExtensionApplyList 
	 * @Description: 交文延期申请列表
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
	public DataList ExtensionApplyList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String MALE_NAME = data.getString("MALE_NAME",null);	//男收养人
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//女收养人
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);	//儿童姓名拼音
		String SEX = data.getString("SEX",null);	//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//儿童出生截止日期
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);	//原递交期限起始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//原递交期限截止日期
		String REQ_SUBMIT_DATE_START = data.getString("REQ_SUBMIT_DATE_START",null);	//新递交期限起始日期
		String REQ_SUBMIT_DATE_END = data.getString("REQ_SUBMIT_DATE_END",null);	//新递交期限截止日期
		String AUDIT_STATE = data.getString("AUDIT_STATE",null);	//延期申请状态
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ExtensionApplyList", MALE_NAME, FEMALE_NAME, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REQ_SUBMIT_DATE_START, REQ_SUBMIT_DATE_END, AUDIT_STATE, compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: PreApproveApplySelect 
	 * @Description: 预批申请记录选择查询列表
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList PreApproveApplySelect(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String MALE_NAME = data.getString("MALE_NAME",null);	//男收养人姓名
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//女收养人姓名
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);	//儿童姓名
		String SEX = data.getString("SEX",null);	//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//儿童出生截止日期
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//申请起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//申请截止日期
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//预批通过起始日期
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);	//预批通过截止日期
		String RI_STATE = data.getString("RI_STATE",null);	//预批状态
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);	//递交文件起始期限
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//递交文件截止期限
		String REMINDERS_STATE = data.getString("REMINDERS_STATE",null);	//催办状态
		String REM_DATE_START = data.getString("REM_DATE_START",null);	//催办起始日期
		String REM_DATE_END = data.getString("REM_DATE_END",null);	//催办截止日期
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);	//收文起始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END",null);	//收文截止日期
		String FILE_NO = data.getString("FILE_NO",null);	//收文编号
		String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);	//文件最后更新起始日期
		String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);	//文件最后更新截止日期
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveApplySelect", MALE_NAME,FEMALE_NAME,NAME_PINYIN,SEX,
        		BIRTHDAY_START,BIRTHDAY_END,REQ_DATE_START,REQ_DATE_END,PASS_DATE_START,
        		PASS_DATE_END,RI_STATE,SUBMIT_DATE_START,SUBMIT_DATE_END,REMINDERS_STATE,
        		REM_DATE_START,REM_DATE_END,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,
        		UPDATE_DATE_START,UPDATE_DATE_END,compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: GetPreApproveApplyData 
	 * @Description: 根据预批申请记录id，获取预批申请信息
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return Data
	 * @throws DBException
	 */
	public Data GetPreApproveApplyData(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetPreApproveApplyData", ri_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: ExtensionApplySave 
	 * @Description: 交文延期申请保存操作
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean
	 * @throws DBException
	 */
	public boolean ExtensionApplySave(Connection conn, Map<String,Object> data) throws DBException {
		Data adddata = new Data(data);
        adddata.setConnection(conn);
        adddata.setEntityName("SCE_REQ_DEFERRED");
        adddata.setPrimaryKey("DEF_ID");
        if("".equals(adddata.getString("DEF_ID",""))){
        	adddata.create();
        }else{
        	adddata.store();
        }
        
		return true;
	}

	/**
	 * @Title: GetExtensionApplyData 
	 * @Description: 根据交文延期申请记录id,获取交文延期申请信息
	 * @author: yangrt
	 * @param conn
	 * @param def_id
	 * @return Data 
	 * @throws DBException 
	 */
	public Data GetExtensionApplyData(Connection conn, String def_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetExtensionApplyData", def_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: ExtensionAuditList 
	 * @Description: 交文延期审核查询列表
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
	public DataList ExtensionAuditList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String COUNTRY_CODE = data.getString("COUNTRY_CODE",null);	//国家code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//收养组织code
		String MALE_NAME = data.getString("MALE_NAME",null);	//男收养人
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//女收养人
		String NAME = data.getString("NAME",null);	//儿童姓名
		String SEX = data.getString("SEX",null);	//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//儿童出生截止日期
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//延期申请起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//延期申请截止日期
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);	//文件递交起始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//文件递交截止日期
		String REQ_SUBMIT_DATE_START = data.getString("REQ_SUBMIT_DATE_START",null);	//延时递交起始日期
		String REQ_SUBMIT_DATE_END = data.getString("REQ_SUBMIT_DATE_END",null);	//延时递交截止日期
		String AUDIT_DATE_START = data.getString("AUDIT_DATE_START",null);	//审核起始日期
		String AUDIT_DATE_END = data.getString("AUDIT_DATE_END",null);	//审核截止日期
		String AUDIT_STATE = data.getString("AUDIT_STATE",null);	//申请状态
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ExtensionAuditList", COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, REQ_DATE_START, REQ_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REQ_SUBMIT_DATE_START, REQ_SUBMIT_DATE_END, AUDIT_DATE_START, AUDIT_DATE_END, AUDIT_STATE, compositor,ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/** 
	 * @Title: UpdatePreApproveApply 
	 * @Description: 更新特需预批申请信息的交文期限（SUBMIT_DATE）
	 * @author: yangrt
	 * @param conn
	 * @param ridata
	 * @return boolean
	 * @throws DBException
	 */
	public boolean UpdatePreApproveApply(Connection conn, Map<String,Object> data) throws DBException {
		Data updatedata = new Data(data);
        updatedata.setConnection(conn);
        updatedata.setEntityName("SCE_REQ_INFO");
        updatedata.setPrimaryKey("RI_ID");
    	updatedata.store();
		return true;
	}

}
