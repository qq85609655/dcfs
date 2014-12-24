/**   
 * @Title: FileManagerHandler.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: 由收养组织对文件信息进行查询、录入、修改、删除、提交、流水号打印、导出操作
 * @author yangrt
 * @date 2014-7-21 下午5:15:55 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.dcfs.ffs.common.FileCommonConstant;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;

public class FileManagerHandler extends BaseHandler {
	
	/***************	递交普通文件处理Begin	***************/

	/**
	 * @throws DBException  
	 * @Title: NormalFileList 
	 * @Description: 按条件对数据库进行查询，得到符合条件的结果集
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList 结果集
	 * @throws 
	 */
	public DataList NormalFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String AF_COST = data.getString("AF_COST", null);	//应缴金额
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//提交开始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);	//提交结束日期
		String REG_STATE = data.getString("REG_STATE", null);	//文件状态
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("NormalFileList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, AF_COST, FILE_TYPE, REG_STATE, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws ParseException 
	 * @throws DBException  
	 * @Title: getNormalFileData
	 * @Description: 根据男收养人、女收养人姓名查询该组织的收养文件
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return Data 
	 */
	public Data getNormalFileData(Connection conn, Data data) throws DBException, ParseException {
		//查询条件
		//String COUNTRY_CODE = data.getString("COUNTRY_CODE");	//国家code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//收养组织code
		String FILE_TYPE = data.getString("FILE_TYPE",null);	//文件类型code
		String MALE_NAME = data.getString("MALE_NAME",null);	//男收养人姓名
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//女收养人姓名
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetNormalFileDataList", ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE);
		//获取符合条件的文件信息
		DataList dl = ide.find(sql);
		
		//定义最新的文件数据，默认为null
		Data reData = new Data();
		//判断是否有符合条件的文件信息
		if(dl.size() > 0){
			//设定日期格式
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			int reIndex = 0;
			//遍历结果集（dl）,确定最新文件的位置
			for(int i = 0; i < dl.size(); i++){
				for(int j = i+1; j < dl.size(); j++){
					//获取文件的创建日期
					String istrdate = dl.getData(i).getString("CREATE_DATE");
					String jstrdate = dl.getData(j).getString("CREATE_DATE");
					Date idate = formatter.parse(istrdate);
					Date jdate = formatter.parse(jstrdate);
					if(idate.getTime() >= jdate.getTime()){
						reIndex = i;
					}else{
						reIndex = j;
					}
				}
			}
			//获取最新文件
			reData = dl.getData(reIndex);
		}
		
		return reData;
	}

	
	/**
	 * @Title: NormalFileSaveFirst 
	 * @Description: 正常文件第一步保存操作
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return String 
	 * @throws DBException
	 */
	public String NormalFileSaveFirst(Connection conn, Map<String, Object> data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        dataadd.create();
		return dataadd.getString("AF_ID","");
	}

	/**
	 * @Title: NormalFileSave 
	 * @Description: 保存信息
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @return
	 * @throws DBException    设定文件 
	 * @return boolean    返回类型 
	 * @throws
	 */
	public boolean NormalFileSave(Connection conn, Map<String, Object> data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        dataadd.store();
		return true;
	}
	
	
	
	/***************	递交普通文件处理Begin	***************/
	
	/***************	递交特需文件处理Begin	***************/
	
	/**
	 * @throws DBException  
	 * @Title: SpecialFileList 
	 * @Description: 按条件对数据库进行查询，得到符合条件的结果集
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList 结果集
	 * @throws 
	 */
	public DataList SpecialFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String AF_COST = data.getString("AF_COST", null);	//应缴金额
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//提交开始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);	//提交结束日期
		String REG_STATE = data.getString("REG_STATE", null);	//文登记状态
		
		/*String NAME = data.getString("NAME",null);	//儿童姓名
		String BIRTHDAY_START = data.getString("",null);	//出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//出生截止日期
		String SEX = data.getString("SEX",null);	//儿童性别
*/		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String filesql = getSql("SpecialFileList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, AF_COST, FILE_TYPE, REG_STATE, compositor, ordertype, orgcode);
		//根据查询条件获取符合条件的文件信息结果集
		DataList dl = ide.find(filesql, pageSize, page);
		/*//遍历该结果集，并根据儿童姓名、出生日期、性别查询符合条件的文件信息
		for(int i = 0; i < dl.size(); i++){
			Data filedata = dl.getData(i);
			//获取儿童材料ID拼接串
			String str_ci_id = filedata.getString("CI_ID","");
			if(str_ci_id.indexOf(",") > 0){
				//如果儿童材料ID拼接串（str_ci_id）不为空，且包含多个儿童材料id，则拆分该拼接串获取相应的儿童材料id
				String[] ci_id = str_ci_id.split(",");
				for(int j = 0; j < ci_id.length; j++){
					//并根据儿童姓名、出生日期、性别查询符合条件的文件信息
					String cisql = getSql("GetChildData", NAME, BIRTHDAY_START, BIRTHDAY_END, SEX, ci_id[j]);
					DataList ciDataList = ide.find(cisql);
					if(ciDataList.size() > 0){
						Data ciData = ciDataList.getData(0);
						if(ci_id.length > 1){
							//如果该家庭锁定了多个儿童，这对该家庭文件进行标识
							filedata.add("NAME", "Mulity");
							filedata.add("BIRTHDAY", "");
							filedata.add("SEX", "");
						}else{
							filedata.add("NAME", ciData.getString("NAME"));
							filedata.add("BIRTHDAY", ciData.getString("BIRTHDAY"));
							filedata.add("SEX", ciData.getString("SEX"));
						}
						
						break;
					}
				}
				
			}else{
				if(!"".equals(str_ci_id)){
					//根据儿童材料id获取该儿童的姓名、性别、出生日期
					String cisql = getSql("GetChildData", NAME, BIRTHDAY_START, BIRTHDAY_END, SEX, str_ci_id);
					Data ciData = ide.find(cisql).getData(0);
					filedata.add("NAME", ciData.getString("NAME"));
					filedata.add("BIRTHDAY", ciData.getString("BIRTHDAY"));
					filedata.add("SEX", ciData.getString("SEX"));
				}
			}
			dl.set(i, filedata);
		}*/
		
        return dl;
	}
	
	/**
	 * @Title: SpecialFileSelectList 
	 * @Description: 获取预批通过的特需文件信息
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 * @throws DBException    设定文件 
	 * @return DataList    返回类型 
	 * @throws
	 */
	public DataList SpecialFileSelectList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		String REQ_NO = data.getString("REQ_NO",null);						//申请编号
		String MALE_NAME = data.getString("MALE_NAME", null);				//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);			//女方
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);			//儿童姓名
		String SEX = data.getString("SEX",null);							//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);		//出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);			//出生截止日期
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);		//申请起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);			//申请截止日期
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//预批通过起始日期
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);		//预批通过截止日期
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);//交文期限起始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//交文期限截止日期
		String REMINDERS_STATE = data.getString("REMINDERS_STATE",null);	//催办状态
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		UserInfo userinfo = SessionInfo.getCurUser();
		String organcode = userinfo.getCurOrgan().getOrgCode();
		String sql = getSql("SpecialFileSelectList", organcode, REQ_NO, MALE_NAME, FEMALE_NAME, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, REQ_DATE_START, REQ_DATE_END, PASS_DATE_START, PASS_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REMINDERS_STATE, compositor, ordertype);
		dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: GetReqInfoByID 
	 * @Description: 根据预批申请信息ID，获取申请信息
	 * @author: yangrt;
	 * @param conn
	 * @param ri_id
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data GetReqInfoByID(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetReqInfoByID",ri_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: GetReqInfoByReqNo 
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @author: yangrt;
	 * @param conn
	 * @param pRE_REQ_NO
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data GetReqInfoByReqNo(Connection conn, String req_no) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetReqInfoByReqNo",req_no);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: getChildDataList 
	 * @Description: 根据儿童材料id获取儿童详细信息
	 * @author: yangrt;
	 * @param conn
	 * @param ci_id
	 * @return    设定文件 
	 * @return DataList    返回类型 
	 * @throws 
	 */
	public DataList getChildDataList(Connection conn, String str_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ci_id = "'";
		if(str_id.indexOf(",") > 0){
			String[] child_id = str_id.split(",");
			for(int i = 0; i < child_id.length; i++){
				ci_id += child_id[i] + "','";
			}
			ci_id = ci_id.substring(0, ci_id.lastIndexOf(","));
		}else{
			ci_id += str_id + "'";
		}
		String sql = getSql("GetChildDataList",ci_id);
		dl = ide.find(sql);
		return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getSpecialFileData 
	 * @Description: 获取系统关联该家庭已提交的文件信息
	 * @author: yangrt;
	 * @param string
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data getSpecialFileData(Connection conn, String file_no) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		dl = ide.find(getSql("GetSpecialFileData",file_no));
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: SpecialFileSave 
	 * @Description: 特需文件递交保存
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean SpecialFileSave(Connection conn, Map<String, Object> data, String flag) throws DBException {
		Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        if("add".equals(flag)){
        	dataadd.create();
        }else if("mod".equals(flag)){
        	dataadd.store();
        }
        
        String ri_id = dataadd.getString("RI_ID","");
        String af_id = dataadd.getString("AF_ID","");
        String ri_state = dataadd.getString("RI_STATE");
        if(ri_id.contains(",")){
        	//更新预批申请信息表中的文件id
        	String[] riId = ri_id.split(",");
        	for(int i = 0; i < riId.length; i++){
	            Data ridata = new Data();
	            ridata.add("RI_ID", riId[i]);
	            ridata.add("AF_ID", af_id);
	            ridata.add("RI_STATE", ri_state);
	            ridata.setConnection(conn);
	            ridata.setEntityName("SCE_REQ_INFO");
	            ridata.setPrimaryKey("RI_ID");
	            ridata.store();
        	}
        }else{
        	Data ridata = new Data();
            ridata.add("RI_ID", ri_id);
            ridata.add("AF_ID", af_id);
            ridata.add("RI_STATE", ri_state);
            ridata.setConnection(conn);
            ridata.setEntityName("SCE_REQ_INFO");
            ridata.setPrimaryKey("RI_ID");
            ridata.store();
        }
        
        
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: forUpdateSceReqInfo 
	 * @Description: 锁定预批记录
	 * @author: yangrt;
	 * @param conn
	 * @param str_ri_id
	 * @return DataList 
	 * @throws 
	 */
	public DataList forUpdateSceReqInfo(Connection conn, String str_ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ri_id = "('";
		if(str_ri_id.contains(",")){
			String[] tempRiId = str_ri_id.split(",");
			for(int i = 0; i < tempRiId.length; i++){
				ri_id += tempRiId[i] + "','";
			}
			ri_id = ri_id.substring(0, ri_id.lastIndexOf(",")) + ")";
		}else{
			ri_id += str_ri_id + "')";
		}
		dl = ide.find(getSql("forUpdateSceReqInfo",ri_id));
		return dl;
	}
	
	/***************	
	 * 递交特需文件处理End	***************/
	
	/***************	补充文件处理Start	***************/
	
	/**
	 * @throws DBException  
	 * @Title: SuppleFileList 
	 * @Description: 补充文件列表
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return    设定文件 
	 * @return DataList    返回类型 
	 * @throws 
	 */
	public DataList SuppleFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
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
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("SuppleFileList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, FILE_TYPE, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getSuppleFileData 
	 * @Description: 根据补充文件id，获取文件信息及补充信息
	 * @author: yangrt;
	 * @param conn
	 * @param aa_id
	 * @return    设定文件 
	 * @return Data    返回类型 
	 */
	public Data getSuppleFileData(Connection conn, String aa_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetSuppleFileData",aa_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: SuppleFileSave 
	 * @Description: 保存补充文件信息
	 * @author: yangrt;
	 * @param conn
	 * @param aadata
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 */
	public boolean SuppleFileSave(Connection conn, Data aadata, Data filedata) throws DBException {
		aadata.setConnection(conn);
        aadata.setEntityName("FFS_AF_ADDITIONAL");
        aadata.setPrimaryKey("AA_ID");
    	aadata.store();
    	
    	filedata.setConnection(conn);
        filedata.setEntityName("FFS_AF_INFO");
        filedata.setPrimaryKey("AF_ID");
    	filedata.store();
    	
    	
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: SuppleBatchSubmit 
	 * @Description: 补充文件批量提交
	 * @author: yangrt
	 * @param conn
	 * @param aa_id
	 * @return boolean 
	 */
	public boolean SuppleBatchSubmit(Connection conn, String[] aa_id) throws DBException {
		UserInfo curuser = SessionInfo.getCurUser();
		for (int i = 0; i < aa_id.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_ADDITIONAL");
			data.setPrimaryKey("AA_ID");
			data.add("AA_ID", aa_id[i]);
			data.add("FEEDBACK_USERID", curuser.getPersonId());	//反馈人ID
			data.add("FEEDBACK_USERNAME", curuser.getPerson().getCName());	//反馈人姓名
			data.add("FEEDBACK_ORGID", curuser.getCurOrgan().getOrgCode());	//反馈人组织code
			data.add("FEEDBACK_DATE", DateUtility.getCurrentDateTime());	//反馈日期
			data.add("AA_STATUS", "2");	//文件补充状态
			data.store();
			
			String af_id = this.getSuppleFileData(conn, aa_id[i]).getString("AF_ID");
			Data filedata = new Data();
	        filedata.add("AF_ID", af_id);
	        filedata.add("SUPPLY_STATE", "2");
			filedata.setConnection(conn);
	        filedata.setEntityName("FFS_AF_INFO");
	        filedata.setPrimaryKey("AF_ID");
	    	filedata.store();
		}
		return true;
	}
	
	/**
	 * @Title: FileProgressList 
	 * @Description: 文件进度及费用查询列表
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
	public DataList FileProgressList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);								//收文编号
		String MALE_NAME = data.getString("MALE_NAME", null);							//男收养人
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);						//女收养人
		String FILE_TYPE = data.getString("FILE_TYPE", null);							//文件类型
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);							//收养类型
		String PAID_NO = data.getString("PAID_NO", null);								//缴费编号
		String AF_COST_PAID = data.getString("AF_COST_PAID", null);						//缴费状态
		String AF_COST = data.getString("AF_COST", null);								//应缴金额
		String FEEDBACK_NUM = data.getString("FEEDBACK_NUM", null);						//反馈报告次数
		String IS_PAUSE = data.getString("IS_PAUSE", null);								//暂停状态
		String AF_GLOBAL_STATE = data.getString("AF_GLOBAL_STATE", null);				//办理状态
		String IS_FINISH = data.getString("IS_FINISH", null);							//办结状态
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);		//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);			//收文结束日期
		String ADVICE_NOTICE_DATE_START = data.getString("ADVICE_NOTICE_DATE_START", null);		//征求意见起始日期
		String ADVICE_NOTICE_DATE_END = data.getString("ADVICE_NOTICE_DATE_END", null);		//征求意见截止日期
		String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);				//签批起始日期
		String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);					//签批截止日期
		String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);				//收养登记起始日期
		String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);					//收养登记截止日期
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("FileProgressList", orgCode, FILE_NO, MALE_NAME, FEMALE_NAME, FILE_TYPE, CHILD_TYPE, PAID_NO, AF_COST_PAID, AF_COST, FEEDBACK_NUM, IS_PAUSE, AF_GLOBAL_STATE, IS_FINISH, REGISTER_DATE_START, REGISTER_DATE_END, ADVICE_NOTICE_DATE_START, ADVICE_NOTICE_DATE_END, SIGN_DATE_START, SIGN_DATE_END, ADREG_DATE_START, ADREG_DATE_END, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @Title: getReqDataList 
	 * @Description: 根据预批信息ID,获取预批信息列表
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return DataList
	 * @throws DBException
	 */
	public DataList getReqDataList(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetReqDataList", ri_id);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	/***************	补充文件处理End	***************/
	
	
	/***************	缴费信息处理Start	***************/
	
	/**
	 * @Title: PaymentList 
	 * @Description: 缴费信息查询列表
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
	public DataList PaymentList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String PAID_NO = data.getString("PAID_NO", null);	//缴费编号
		String COST_TYPE = data.getString("COST_TYPE", null);	//缴费类型
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//应缴金额
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//票面金额
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//到账起始日期
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//到账截止日期
		String ARRIVE_VALUE = data.getString("SUBMIT_DATE_END", null);	//到账金额
		String ARRIVE_STATE = data.getString("FILE_TYPE", null);	//到账状态
		String ARRIVE_ACCOUNT_VALUE = data.getString("FEEDBACK_DATE_START", null);	//结余账号使用金额
		String FILE_NO = data.getString("FEEDBACK_DATE_END", null);	//收文编号
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PaymentList",PAID_NO,COST_TYPE,PAID_SHOULD_NUM,PAR_VALUE,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_VALUE,ARRIVE_STATE,ARRIVE_ACCOUNT_VALUE,FILE_NO,compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @Title: getPaymentData 
	 * @Description: 根据缴费信息ID，获取缴费信息
	 * @author: yangrt
	 * @param conn
	 * @param cheque_id
	 * @return Data
	 * @throws DBException  
	 */
	public Data getPaymentData(Connection conn, String cheque_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetPaymentData",cheque_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @Title: PaymentNoticeList 
	 * @Description: 缴费通知信息查询列表
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
	public DataList PaymentNoticeList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String PAID_NO = data.getString("PAID_NO", null);	//催缴编号
		String COST_TYPE = data.getString("COST_TYPE", null);	//缴费类型
		String CHILD_NUM = data.getString("CHILD_NUM", null);	//正常儿童数量
		String S_CHILD_NUM = data.getString("S_CHILD_NUM", null);	//特需儿童数量
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//应缴金额
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);	//通知起始日期
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);	//通知截止日期
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//到账起始日期
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//到账截止日期
		String ARRIVE_VALUE = data.getString("ARRIVE_VALUE", null);	//到账金额
		//数据操作
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PaymentNoticeList",PAID_NO,COST_TYPE,CHILD_NUM,S_CHILD_NUM,PAID_SHOULD_NUM,NOTICE_DATE_START,NOTICE_DATE_END,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_VALUE,compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @Title: getPaymentNoticeData 
	 * @Description: 根据催缴记录ID，获取催缴通知信息
	 * @author: yangrt
	 * @param conn
	 * @param rm_id
	 * @return Data    返回类型 
	 * @throws DBException
	 */
	public Data getPaymentNoticeData(Connection conn, String rm_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetPaymentNoticeData",rm_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @Title: AccountBalanceList 
	 * @Description: 结余账户使用记录列表
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList    返回类型 
	 * @throws DBException  
	 */
	public DataList AccountBalanceList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String PAID_NO = data.getString("PAID_NO", null);				//缴费编号
		String OPP_TYPE = data.getString("OPP_TYPE", null);				//操作类型
		String SUM = data.getString("SUM", null);						//账单金额
		String OPP_USERNAME = data.getString("OPP_USERNAME", null);		//操作人姓名
		String OPP_DATE_START = data.getString("OPP_DATE_START", null);	//操作起始日期
		String OPP_DATE_END = data.getString("OPP_DATE_END", null);		//操作截止日期
		
		String orgcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("AccountBalanceList",PAID_NO,OPP_TYPE,SUM,OPP_USERNAME,OPP_DATE_START,OPP_DATE_END,compositor,ordertype,orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	
	/**
	 * @Title: getAccountBalanceData 
	 * @Description: 根据结余账户使用记录id，获取详细信息
	 * @author: yangrt
	 * @param conn
	 * @param account_log_id
	 * @return Data
	 * @throws DBException 
	 */
	public Data getAccountBalanceData(Connection conn, String account_log_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetAccountBalanceData",account_log_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/***************	缴费信息处理End	***************/
	
	
	
	/***************	文件办理公共方法类Strat	***************/
	
	/**
	 * @throws DBException  
	 * @Title: GetNormalFileByID 
	 * @Description: 根据文件id获取文件的详细信息
	 * @author: yangrt;
	 * @param conn
	 * @param fileID
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data GetFileByID(Connection conn, String fileID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetFileData", fileID);
		Data d = ide.find(sql).getData(0);
		return d;
		
	}
	
	/**
	 * @throws DBException  
	 * @Title: FileDelete 
	 * @Description: 根据文件ID删除未登记的文件信息
	 * @author: panfeng;
	 * @param conn
	 * @param deleteAFID
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean FileDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList deleteList = new DataList();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("AF_ID");
			data.add("AF_ID", uuid[i]);
			deleteList.add(data);
			
			//删除附件
			Data delData = this.GetFileByID(conn, uuid[i]);
			String male_photo = delData.getString("MALE_PHOTO","");	//男收养人照片附件
			String female_photo = delData.getString("FEMALE_PHOTO","");	//女收养人照片附件
			String packageId = delData.getString("PACKAGE_ID","");	//附件
			if(!"".equals(male_photo)){
				AttHelper.delAttById(male_photo, "AF");
			}
			if(!"".equals(female_photo)){
				AttHelper.delAttById(female_photo, "AF");
			}
			if(!"".equals(packageId)){
				AttHelper.delAttById(packageId, "AF");
			}
		}
		ide.remove(deleteList);
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: FileBatchSubmit 
	 * @Description: 批量提交文件信息
	 * @author: panfeng;
	 * @param conn
	 * @param deleteAFID
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean FileBatchSubmit(Connection conn, String[] uuid) throws DBException {
		UserInfo curuser = SessionInfo.getCurUser();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("AF_ID");
			data.add("AF_ID", uuid[i]);
			data.add("REG_STATE", FileCommonConstant.DJZT_DDJ);
			data.add("SUBMIT_DATE", DateUtility.getCurrentDateTime());
			data.add("SUBMIT_USERID", curuser.getPersonId());
			data.store();
		}
		return true;
	}
	
	/**
	 * 流水号打印预览
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 * @throws ParseException 
	 */
	public DataList getShowData(Connection conn, String printId, String type) throws DBException, ParseException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetFileSeqData", printId);
		DataList dl = ide.find(sql);
		if("special".equals(type)){
			for(int i = 0; i < dl.size(); i++){
				Data data = dl.getData(i);
				String str_ci_id = data.getString("CI_ID");
				
				String cisql = null;
				Data cadata = null;
				
				if(str_ci_id.indexOf(",") > 0){
					String[] ci_id = str_ci_id.split(",");
					
					cisql = getSql("GetChildApplicationData",ci_id[0]);
					cadata = ide.find(cisql).getData(0);
					
					String childname = cadata.getString("NAME");
					String pass_date = cadata.getString("PASS_DATE");
					//设定日期格式
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					for(int j = 1; j < ci_id.length; j++){
						cisql = getSql("GetChildApplicationData",ci_id[j]);
						cadata = ide.find(cisql).getData(0);
						childname += " " + cadata.getString("NAME");
						String pdate = cadata.getString("PASS_DATE");
						if(formatter.parse(pdate).getTime() > formatter.parse(pass_date).getTime()){
							pass_date = pdate;
						}
					}
					data.add("NAME", childname);
					data.add("PASS_DATE", pass_date);
				}else{
					cisql = getSql("GetChildApplicationData",str_ci_id);
					cadata = ide.find(cisql).getData(0);
					
					data.add("NAME", cadata.getString("NAME"));
					data.add("PASS_DATE", cadata.getString("PASS_DATE"));
				}
				dl.set(i, data);
			}
		}
		return dl;
	}

	/**
	 * @throws DBException  
	 * @Title: GetMKRORGCOAList 
	 * @Description: 获取美国公约认证机构名称信息
	 * @author: yangrt;
	 * @param conn
	 * @return    设定文件 
	 * @return DataList    返回类型 
	 * @throws 
	 */
	public DataList getMKRORGCOAList(Connection conn) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		dl = ide.find(getSql("GetMKRORGCOAList"));
		return dl;
	}

	/**
	 * @throws DBException  
	 * @Title: getAdoptOrgInfo 
	 * @Description: 根据收养组织id，获取收养组织信息
	 * @author: yangrt;
	 * @param conn
	 * @param orgid
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws 
	 */
	public Data getAdoptOrgInfo(Connection conn, String orgid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("getAdoptOrgInfo", orgid);
		dl = ide.find(sql);
		return dl.getData(0);
	}

	/***************	文件办理公共方法类End	***************/

}
