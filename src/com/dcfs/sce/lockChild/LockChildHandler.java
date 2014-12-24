/**   
 * @Title: LockChildHandler.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: 锁定儿童操作
 * @author yangrt   
 * @date 2014-9-21 上午11:13:11 
 * @version V1.0   
 */
package com.dcfs.sce.lockChild;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import base.task.util.DateUtil;

import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.hx.framework.authenticate.SessionInfo;

/** 
 * @ClassName: LockChildHandler 
 * @Description: 锁定儿童操作
 * @author yangrt;
 * @date 2014-9-21 上午11:13:11 
 *  
 */
public class LockChildHandler extends BaseHandler {

	/**
	 * @Title: LockChildList 
	 * @Description: 锁定儿童查询列表
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
	public DataList LockChildList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS",null);	//特别关注
		String PROVINCE_ID = data.getString("PROVINCE_ID",null);	//省份
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);	//儿童姓名
		String SEX = data.getString("SEX",null);	//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//儿童出生截止日期
		String SN_TYPE = data.getString("REQ_DATE_START",null);	//病残种类
		String DISEASE_EN = data.getString("REQ_DATE_END",null);	//病残诊断
		String PUB_LASTDATE_START = data.getString("REQ_DATE_START",null);	//当前发布起始日期
		String PUB_LASTDATE_END = data.getString("REQ_DATE_END",null);	//当前发布截止日期
		String PUB_TYPE = data.getString("PASS_DATE_START",null);	//发布类型
		String HAVE_VIDEO = data.getString("PASS_DATE_END",null);	//有无视频
		String SETTLE_DATE_START = data.getString("RI_STATE",null);	//安置期限起始日期
		String SETTLE_DATE_END = data.getString("SUBMIT_DATE_START",null);	//安置期限截止日期
		String LAST_UPDATE_DATE_START = data.getString("SUBMIT_DATE_END",null);	//最后更新起始日期
		String LAST_UPDATE_DATE_END = data.getString("REMINDERS_STATE",null);	//最后更新截止日期
		
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		//当前收养组织code
		String organcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode(); 
		String sql = getSql("LockChildList", organcode, SPECIAL_FOCUS, PROVINCE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SN_TYPE, DISEASE_EN, PUB_LASTDATE_START, PUB_LASTDATE_END, PUB_TYPE, HAVE_VIDEO, SETTLE_DATE_START, SETTLE_DATE_END, LAST_UPDATE_DATE_START, LAST_UPDATE_DATE_END, compositor,ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: getPubData 
	 * @Description: 根据发布记录id,获取发布记录信息
	 * @author: yangrt
	 * @param conn
	 * @param pub_id
	 * @return Data 
	 * @throws DBException
	 */
	public Data getPubData(Connection conn, String pub_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPubData", pub_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: getMainChildInfo 
	 * @Description: 根据主儿童材料id,获取主儿童材料信息
	 * @author: yangrt
	 * @param conn
	 * @param ci_id
	 * @return Data
	 * @throws DBException
	 */
	public Data getMainChildInfo(Connection conn, String ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getMainChildInfo", ci_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: getAttachChildList 
	 * @Description: 根据主儿童材料id,获取附儿童材料信息
	 * @author: yangrt
	 * @param conn
	 * @param ci_id
	 * @return DataList
	 * @throws DBException
	 */
	public DataList getAttachChildList(Connection conn, String ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAttachChildList", ci_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @Title: FileInfoSelect 
	 * @Description: 根据不同的锁定类型，查询不同条件的文件信息
	 * @author: yangrt
	 * @param conn
	 * @param lock_type
	 * @return DataList
	 * @throws DBException
	 */
	public DataList FileInfoSelect(Connection conn, Data data, String lock_type, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REG_DATE_START = data.getString("REG_DATE_START", null);	//登记起始日期
		String REG_DATE_END = data.getString("REG_DATE_END", null);	//登记截止日期
		
		//锁定方式为E
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//申请起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//申请截止日期
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//预批通过起始日期
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);	//预批通过截止日期
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = null;
		String organcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		if(lock_type.equals("A")){
			sql = getSql("FileInfoSelectA",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("B")){
			sql = getSql("FileInfoSelectB",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("C")){
			sql = getSql("FileInfoSelectC",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("E")){
			sql = getSql("FileInfoSelectE",organcode,MALE_NAME,FEMALE_NAME,REQ_DATE_START,REQ_DATE_END,PASS_DATE_START,PASS_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("F")){
			String curDate = DateUtility.getCurrentDateTime();
			sql = getSql("FileInfoSelectF",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype,curDate);
		}
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: InitPreApproveApplySave 
	 * @Description: 初始化预批申请记录
	 * @author: yangrt;
	 * @param conn
	 * @param applydata
	 * @return Boolean 
	 * @throws DBException
	 */
	public Boolean InitPreApproveApplySave(Connection conn, Data applydata) throws DBException {
        applydata.setConnection(conn);
        applydata.setEntityName("SCE_REQ_INFO");
        applydata.setPrimaryKey("RI_ID");
    	applydata.create();
    	
    	if("5".equals(applydata.getString("LOCK_MODE"))){
	    	Data preapplydata = new Data();
	    	preapplydata.add("REQ_NO", applydata.getString("PRE_REQ_NO"));
	    	preapplydata.add("PRE_REQ_NO", applydata.getString("REQ_NO"));
	    	preapplydata.setConnection(conn);
	    	preapplydata.setEntityName("SCE_REQ_INFO");
	    	preapplydata.setPrimaryKey("REQ_NO");
	    	preapplydata.store();
    	}
    	
    	//更新特需儿童发布信息
    	Data pubdata = new Data();
    	pubdata.add("PUB_ID", applydata.getString("PUB_ID",""));
    	pubdata.add("ADOPT_ORG_ID", applydata.getString("ADOPT_ORG_ID",""));	//锁定组织code
    	pubdata.add("LOCK_DATE", applydata.getString("LOCK_DATE",""));	//锁定日期
    	pubdata.add("PUB_STATE", PublishManagerConstant.YSD);//发布状态为“已锁定”
    	pubdata.setConnection(conn);
    	pubdata.setEntityName("SCE_PUB_RECORD");
    	pubdata.setPrimaryKey("PUB_ID");
    	pubdata.store();
    	
    	//根据儿童id，获取儿童信息
    	Data childdata = this.getMainChildInfo(conn, applydata.getString("CI_ID",""));
    	childdata.add("PUB_STATE", PublishManagerConstant.YSD);//发布状态为“已锁定”
    	String lock_num = Integer.parseInt(childdata.getString("LOCK_NUM","0")) + 1 + "";
    	childdata.add("LOCK_NUM", lock_num);
    	childdata.setConnection(conn);
    	childdata.setEntityName("CMS_CI_INFO");
    	childdata.setPrimaryKey("CI_ID");
    	childdata.store();
    	
		if(!"".equals(applydata.getString("AF_ID",""))){
			//获取当前锁定儿童信息，判断是否是多胞胎
			Data childData = new LockChildHandler().getMainChildInfo(conn, applydata.getString("CI_ID"));
			String twins_ids = childData.getString("TWINS_IDS","");	//同胞胎id
			//更新收养文件信息表中的预批信息（RI_ID：预批记录ID，RI_STATE：预批状态）
	    	Data fileData = new Data();
			fileData.add("RI_ID", applydata.getString("RI_ID"));
			fileData.add("RI_STATE", applydata.getString("RI_STATE"));
			if(twins_ids.equals("")){
				fileData.add("CI_ID", applydata.getString("CI_ID"));
			}else{
				fileData.add("CI_ID", applydata.getString("CI_ID") + "," + twins_ids);
			}
			fileData.setConnection(conn);
			fileData.setEntityName("FFS_AF_INFO");
			fileData.setPrimaryKey("AF_ID");
			fileData.store();
		}
    	
		return true;
	}

	/**
	 * @Title: ConsignReturnSave 
	 * @Description: 保存退回原因
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean
	 * @throws DBException
	 */
	public boolean ConsignReturnSave(Connection conn, DataList datalist) throws DBException {
		for(int i = 0; i < datalist.size(); i++){
			Data data = datalist.getData(i);
			data.setConnection(conn);
			data.setEntityName("SCE_PUB_RECORD");
			data.setPrimaryKey("PUB_ID");
			data.store();
		}
		
		return true;
	}

	/**
	 * @Title: getLockRecords 
	 * @Description: 获取当前组织近七天之内锁定该儿童的记录
	 * @author: yangrt
	 * @param conn
	 * @param ci_id
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList getLockRecords(Connection conn, String ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		//获取当前日期
		String nowDate = DateUtil.getCurrentDatetime();	
		//获取十五天前的日期
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -7);
		String preDate = sdf.format(cal.getTime());	//十五天前的日期
		
		String orgcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String sql = getSql("getLockRecords", orgcode, ci_id, preDate, nowDate);
		DataList dl = ide.find(sql);
		return dl;
	}
	
}
