/**   
 * @Title: FileAuditHandler.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午5:10:43 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: FileAuditHandler 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author songhn@21softech.com 
 * @date 2014-7-14 下午5:10:43 
 *  
 */
public class FileAuditHandler extends BaseHandler {

	public FileAuditHandler() {
	}

	public FileAuditHandler(String propFileName) {
		super(propFileName);
	}
	


	
	
	
	
	
	/**
	 * 经办人审核列表	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForOneLevel(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);	//接收开始日期
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);	//接收结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null);	//翻译质量
		String AUD_STATE = data.getString("AUD_STATE", null);	//审核状态
		String AA_STATUS = data.getString("AA_STATUS", null);	//补充状态
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null);	//重翻状态
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE", null);	//补翻状态
		
		if(null==compositor||"".equals(compositor)){
			compositor="t.RECEIVER_DATE";
		}
		
		if(null==ordertype||"".equals(ordertype)){
			ordertype="asc";
		}
		
		if("".equals(AUD_STATE)||null==AUD_STATE){
			AUD_STATE="0,1,9";
		}
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForOneLevel",FILE_NO, RECEIVER_DATE_START, RECEIVER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, TRANSLATION_QUALITY, AUD_STATE, AA_STATUS, RTRANSLATION_STATE,ATRANSLATION_STATE, compositor, ordertype);
		System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 部门主任复核列表	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForTwoLevel(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);	//接收开始日期
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);	//接收结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null);	//翻译质量
		String AUD_STATE = data.getString("AUD_STATE", null);	//审核状态
		String AA_STATUS = data.getString("AA_STATUS", null);	//补充状态
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null);	//重翻状态
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE", null);	//补翻状态
		
		if(null==compositor||"".equals(compositor)){
			compositor="t.RECEIVER_DATE";
		}
		
		if(null==ordertype||"".equals(ordertype)){
			ordertype="asc";
		}
		
		if("".equals(AUD_STATE)||null==AUD_STATE){
			AUD_STATE="2";
		}
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForTwoLevel",FILE_NO, RECEIVER_DATE_START, RECEIVER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, TRANSLATION_QUALITY, AUD_STATE, AA_STATUS, RTRANSLATION_STATE,ATRANSLATION_STATE, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 分管主任审批列表	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForThreeLevel(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);	//接收开始日期
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);	//接收结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null);	//翻译质量
		String AUD_STATE = data.getString("AUD_STATE", null);	//审核状态
		String AA_STATUS = data.getString("AA_STATUS", null);	//补充状态
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null);	//重翻状态
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE", null);	//补翻状态
		
		if(null==compositor||"".equals(compositor)){
			compositor="t.RECEIVER_DATE";
		}
		
		if(null==ordertype||"".equals(ordertype)){
			ordertype="asc";
		}
		
		if("".equals(AUD_STATE)||null==AUD_STATE){
			AUD_STATE="3";
		}
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForThreeLevel",FILE_NO, RECEIVER_DATE_START, RECEIVER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, TRANSLATION_QUALITY, AUD_STATE, AA_STATUS, RTRANSLATION_STATE,ATRANSLATION_STATE, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}


	/**
	 * 获取审核记录信息
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findAuditList(Connection conn, String fileid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findAuditList", fileid);
		return ide.find(sql);
	}
	
	/**
	 * 获取补充记录信息
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findBcRecordList(Connection conn, String fileid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findBcRecordList", fileid);
		return ide.find(sql);
	}
	
	/**
	 * 获取文件修改记录信息
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findReviseList(Connection conn, String fileid, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findReviseList", fileid,compositor, ordertype);
		//System.out.println("sql-->"+sql);
		return ide.find(sql, pageSize, page);
	}
	
	/**
	 * 获取文件翻译记录信息
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findTranslationList(Connection conn, String fileid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findTranslationList", fileid);
		return ide.find(sql);
	}
	
	/**
	 * 根据文件主键获得文件基本信息
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @return
	 */
	public Data getFileInfoByID(Connection conn,String afId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findFileInfoByID",afId);
		 return ide.find(sql).getData(0);
		
	}
	
	/**
	 * 根据儿童ids获得儿童基本信息
	 * @description 
	 * @author MaYun
	 * @date Dec 7, 2014
	 * @return
	 */
	public DataList findETInfoList(Connection conn,String etids) throws DBException{
		DataList dataList = new DataList();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findETInfoList",etids);
		dataList = ide.find(sql);
		return dataList;
	}
	
	/**
	 * 根据预批ids获得预批审核基本信息
	 * @description 
	 * @author MaYun
	 * @date Dec 7, 2014
	 * @return
	 */
	public DataList findYPSHInfoList(Connection conn,String ypids) throws DBException{
		DataList dataList = new DataList();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findYPSHInfoList",ypids);
		dataList = ide.find(sql);
		return dataList;
	}
	
	/**
	 * 根据审核主键获得审核基本信息
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @return
	 */
	public Data getAuditInfoByID(Connection conn,String auId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findAuditInfoByID",auId);
		 return ide.find(sql).getData(0);
		
	}
	
	/**
	 * 根据文件主键和审核级别获得最新审核信息
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @param String afId 收养文件主键ID
	 * @param level 审核级别 0:经办人审核;1:部门主任复核;2:分管主任审批
	 * @return
	 */
	public Data getLastAuditInfoByAfID(Connection conn,String afId,String level) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findLastAuditInfoByAfID",afId,level);
		 DataList resultList = ide.find(sql);
		 Data data = new Data();
		 data.add("AUDIT_LEVEL", "");
		 data.add("AUDIT_OPTION", "");
		 data.add("AUDIT_CONTENT_CN", "");
		 data.add("AUDIT_USERID", "");
		 data.add("AUDIT_USERNAME", "");
		 data.add("AUDIT_DATE", "");
		 data.add("OPERATION_STATE", "");
		 data.add("AUDIT_REMARKS", "");
		 
		 if(resultList.size()>0){
			 data = ide.find(sql).getData(0);
		 }
		 return data;
		
	}
	
	/**
	 * 根据文件主键获得文件补充记录
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @return
	 */
	public DataList getBCFileListByID(Connection conn,String afId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findBCFileListByID",afId);
		 return ide.find(sql);
		
	}
	
	/**
	 * 根据文件主键获得文件补充次数
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @param afId 文件主键
	 * @return int num 文件补充次数
	 */
	public int getFileBuChongNum(Connection conn,String afId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("getFileBuChongNum",afId);
		 return ide.find(sql).getData(0).getInt("NUM");
		
	}

	/**
	 * 根据收文ID获得本文件最新一次文件补充信息
	 * @param afId
	 * @return
	 * @throws DBException
	 */
	public Data getBCFileInfoById(Connection conn,String afId)throws DBException{
		Data data = new Data();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getBCFileInfoById",afId);
		DataList list = ide.find(sql);
		if(list.size()>0){
			data = list.getData(0);
		}
		return  data;
	}
	
	 /**
     * 向审核信息表里保存审核信息
     * @author MaYun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveAuditInfo(Connection conn,Map<String, Object> auditData)
            throws DBException {
    	//***保存审核信息*****
        Data dataadd = new Data(auditData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_AUDIT");
        dataadd.setPrimaryKey("AU_ID");
        Data returnData = dataadd.store();
        return returnData;
    }
    
    /**
     * 向文件基本信息表里保存文件信息
     * @author MaYun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveFileInfo(Connection conn,Map<String, Object> fileData)
            throws DBException {
    	//***保存文件基本信息*****
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        Data returnData = dataadd.store();
        return returnData;
    }

	/**
	 * @Title: getAuditID 
	 * @Description: 根据文件id、审核级别，获取操作状态为操作中的审核记录ID
	 * @author: yangrt
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @return Data    返回类型 
	 * @throws DBException
	 */
	public Data getAuditID(Connection conn, String af_id, String audit_level) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAuditID",af_id,audit_level);
		return ide.find(sql).getData(0);
	}
	
	/**
	 * @Description: 根据文件id、审核级别，获取操作状态为操作中的审核记录ID
	 * @author: mayun
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @param operation_state ,如果多个状态采用类似'a','b','c'的字符串
	 * @return Data    返回类型 
	 * @throws DBException
	 */
	public Data getAuditIDForWJSH(Connection conn, String af_id, String audit_level,String operation_state) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAuditIDForWJSH",af_id,audit_level,operation_state);
		List resultList = ide.find(sql);
		if(resultList.size()>0){
			return ide.find(sql).getData(0);
		}else{
			Data data = new Data();
			data.add("AU_ID", "");
			return data;
		}
		
	}
	
	/**
	 * @Title: isCanBF 
	 * @Description: 根据文件id判断改文件是否可进行补翻操作
	 * @author: mayun
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @return boolean true:可以补翻  false：不可以补翻
	 * @throws DBException
	 */
	public boolean isCanBF(Connection conn, String af_id) throws DBException {
		Data fileData = this.getFileInfoByID(conn, af_id);
		String aa_id = fileData.getString("AA_ID");//补充记录ID
		String supply_state = fileData.getString("SUPPLY_STATE");//末次补充文件状态
		String bfzt = fileData.getString("ATRANSLATION_STATE");//补翻状态
		boolean flag = true;
		
		if(aa_id==null||"".equals(aa_id)){
			flag = false;
		//}else if(supply_state=="0"||"0".equals(supply_state)||supply_state=="1"||"1".equals(supply_state)){
			//flag = false;
		}else if(null!=bfzt&&!"".equals(bfzt)){
			if("1".equals(bfzt)||"1"==bfzt||"0".equals(bfzt)||"0"==bfzt){
				flag = false;
			}else{
				flag = true;
			}
		}
		return flag;
	}
    
    

}
