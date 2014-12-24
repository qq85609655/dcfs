/**   
 * @Title: FileAuditHandler.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午5:10:43 
 * @version V1.0   
 */
package com.dcfs.sce.publishManager;

import java.sql.Connection;
import java.util.Map;

import com.dcfs.common.StringUtil;

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
public class PublishManagerHandler extends BaseHandler {

	public PublishManagerHandler() {
	}

	public PublishManagerHandler(String propFileName) {
		super(propFileName);
	}
	


	
	
	
	
	
	/**
	 * 发布管理列表	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForFBGL(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件

		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//省份
		String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院
		String NAME = data.getString("NAME", null);	//姓名
		String SEX = data.getString("SEX", null);	//性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);	//出生日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);	//出生日期
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);	//特别关注
		String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
		String PUB_FIRSTDATE_START = data.getString("PUB_FIRSTDATE_START", null);	//首次发布日期
		String PUB_FIRSTDATE_END = data.getString("PUB_FIRSTDATE_END", null);	//首次发布日期
		String PUB_LASTDATE_START = data.getString("PUB_LASTDATE_START", null);	//末次发布日期
		String PUB_LASTDATE_END = data.getString("PUB_LASTDATE_END", null);	//末次发布日期
		String PUB_TYPE = data.getString("PUB_TYPE", null);	//发布类型
		String PUB_ORGID = data.getString("PUB_ORGID", null);	//发布组织
		String PUB_MODE = data.getString("PUB_MODE", null);	//点发类型
		String SETTLE_DATE_START = data.getString("SETTLE_DATE_START", null);	//安置期限
		String SETTLE_DATE_END = data.getString("SETTLE_DATE_END", null);	//安置期限
		String PUB_STATE = data.getString("PUB_STATE", null);	//发布状态
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID2", null);	//锁定组织
		String LOCK_NUM = data.getString("LOCK_NUM", null);	//锁定次数
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//交文期限
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_START_END", null);	//交文期限
		String RI_STATE = data.getString("RI_STATE", null);	//预批状态
		String DISEASE_CN = data.getString("DISEASE_CN", null);	//病残诊断
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForFBGL",PROVINCE_ID, WELFARE_ID, NAME, SEX,BIRTHDAY_START,BIRTHDAY_END, SPECIAL_FOCUS, SN_TYPE, PUB_FIRSTDATE_START, PUB_FIRSTDATE_END,PUB_LASTDATE_START,PUB_LASTDATE_END, PUB_TYPE, PUB_ORGID, PUB_MODE,SETTLE_DATE_START,SETTLE_DATE_END,PUB_STATE,ADOPT_ORG_ID,LOCK_NUM,SUBMIT_DATE_START,SUBMIT_DATE_END,RI_STATE,DISEASE_CN, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	
	/**
	 * 已发布组织列表	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForFBORG(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件

		String PUB_ID = data.getString("PUB_ID", null);	//发布记录ID
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String PUB_ORGID = data.getString("PUB_ORGID", null);	//发布组织
		
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sqlOrgIDs=getSql("getFbOrgIdsForFBGL",PUB_ID);
		String orgIds = ide.find(sqlOrgIDs).getData(0).getString("PUB_ORGID");
		orgIds = StringUtil.convertSqlString(orgIds);
		
		
		String sql = getSql("findListForFBORG",orgIds, COUNTRY_CODE, PUB_ORGID, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	
	
	/**
	 * 待发布儿童选择列表	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList toChoseETForFB(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件

		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//省份
		String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院
		String NAME = data.getString("NAME", null);	//姓名
		String SEX = data.getString("SEX", null);	//性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);	//出生日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);	//出生日期
		String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);	//特别关注
		String PUB_NUM = data.getString("PUB_NUM", null);	//发布次数
		String PUB_FIRSTDATE_START = data.getString("PUB_FIRSTDATE_START", null);	//首次发布日期
		String PUB_FIRSTDATE_END = data.getString("PUB_FIRSTDATE_END", null);	//首次发布日期
		String PUB_LASTDATE_START = data.getString("PUB_LASTDATE_START", null);	//末次发布日期
		String PUB_LASTDATE_END = data.getString("PUB_LASTDATE_END", null);	//末次发布日期
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("toChoseETForFB",PROVINCE_ID, WELFARE_ID, NAME, SEX,BIRTHDAY_START,BIRTHDAY_END, SN_TYPE, SPECIAL_FOCUS, PUB_NUM, PUB_FIRSTDATE_START, PUB_FIRSTDATE_END, PUB_LASTDATE_START, PUB_LASTDATE_END, compositor, ordertype);
		//System.out.println("toChoseETForFBSql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 根据是否群发、是否特别关注、点发类型获得安置期限
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public DataList getAZQXInfo(Connection conn,String oneType,String secondType,String threeType) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAZQXInfo",oneType,secondType,threeType);
		//System.out.println("sql000000-->"+sql);
		return ide.find(sql);
	}
	
	
	/**
	 * 根据发布记录主键ID判断改发布状态是否为已发布
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public Boolean isFB(Connection conn,String pub_id) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isFB",pub_id);
		String state = ide.find(sql).getData(0).getString("PUB_STATE");
		if("2".equals(state)||"2"==state){
			return true;
		}else{
			return false;
		}
	}
	
	/**
	 * 根据发布记录主键ID判断改退回状态是否为已申请退回或退回确认
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public Boolean isTH(Connection conn,String pub_id) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isTH",pub_id);
		String state = ide.find(sql).getData(0).getString("RETURN_STATE");
		if("".equals(state)||""==state||null==state){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 根据发布记录主键ID判断改锁定状态是否为已锁定,并且预批申请尚未递交
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 */
	public Boolean isSD(Connection conn,String pub_id) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isSD",pub_id);
		DataList dataList = ide.find(sql);
		
		if(dataList.size()>0){
			Data data = dataList.getData(0);
			String LOCK_STATE= data.getString("LOCK_STATE");//锁定状态  0:已锁定
			String RI_STATE= data.getString("RI_STATE");//预批状态 0:未递交
			if("0".equals(LOCK_STATE)||"0"==LOCK_STATE){
				if("0".equals(RI_STATE)||"0"==RI_STATE){
					return true;
				}else{
					return false;
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
		
	}
	
	/**
     * 儿童发布批量提交方法
     * @param conn
     * @param datalist
     * @return
     * @throws DBException
     */
    public boolean batchSubmitForETFB(Connection conn, DataList datalist)throws DBException {
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<datalist.size();i++){
    		datalist.getData(i).setEntityName("SCE_PUB_RECORD");
    		datalist.getData(i).setPrimaryKey("PUB_ID");
    	}
    	int re =ide.batchCreate(datalist);
    	if(re>0){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    /**
     * 根据儿童材料ID,判断是否进行过发布操作
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @param Connection conn
     * @param String ciid 儿童材料ID
     * @return true:进行过  false:没有
     * @throws DBException 
     */
    public boolean isFirstFb(Connection conn,String ciid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("isFirstFb",ciid);
    	DataList dataList = ide.find(sql);
    	if(dataList.size()>0){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    /**
     * 根据儿童材料ID获得该儿童的发布次数
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public int getFbNum(Connection conn,String ciid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getFbNum",ciid);
    	//System.out.println("sql:"+sql);
    	return ide.find(sql).getData(0).getInt("PUB_NUM");
    }
    
    /**
     * 批量更新儿童材料表信息
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public boolean batchUpdateETCL(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("CMS_CI_INFO");
    		dataList.getData(i).setPrimaryKey("CI_ID");
    	}
    	int re =ide.batchStore(dataList);
    	if(re>0){
    		return true;
    	}else{
    		return false;
    	}
    }
    
    
    /**
     * 更新儿童材料表信息
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public void updateETCL(Connection conn,Data data) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		data.setEntityName("CMS_CI_INFO");
		data.setPrimaryKey("CI_ID");
	    ide.store(data);
    }
    
    
    /**
     * 根据发布记录ID获得发布记录和儿童信息
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public Data getEtAndFbInfo(Connection conn,String pubid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getEtAndFbInfo",pubid);
    	return ide.find(sql).getData(0);
    }
    
    /**
     * 根据发布记录ID获得预批、发布记录和儿童信息
     * @description 
     * @author MaYun
     * @date Sep 18, 2014
     * @return
     * @throws DBException 
     */
    public Data getYpEtAndFbInfo(Connection conn,String pubid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getYpEtAndFbInfo",pubid);
    	return ide.find(sql).getData(0);
    }
    
    /**
     * 根据儿童材料ID获得儿童基本信息
     * @description 
     * @author MaYun
     * @date Sep 22, 2014
     * @return
     */
    public Data getETInfo(Connection conn,String ciid)throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getETInfo",ciid);
    	return ide.find(sql).getData(0);
    }
    
    
    /**
     * 更新发布记录信息
     * @author mayun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public void updateFbInfo(Connection conn, Map<String, Object> fbData) throws DBException {
        Data dataadd = new Data(fbData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_PUB_RECORD");
        dataadd.setPrimaryKey("PUB_ID");
        dataadd.store();
        
    }
    
    /**
     * 更新预批信息
     * @author mayun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public void updateYpInfo(Connection conn, Map<String, Object> fbData) throws DBException {
        Data dataadd = new Data(fbData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
        dataadd.store();
    }
    
    /**
     * 根据儿童材料id获得此同胞兄弟的名称
     * @description 
     * @author MaYun
     * @date Sep 23, 2014
     * @return String names
     */
    public String getETNameForTB(Connection conn,String ciid) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getETNamesForTB",ciid);
    	DataList dataList = ide.find(sql);
    	String  NAMES="";
    	
    	if(dataList.size()>0){
    		for(int i=0;i<dataList.size();i++){
        		if(i==0){
        			NAMES=dataList.getData(i).getString("NAME");
        		}else{
        			NAMES+=","+dataList.getData(i).getString("NAME");
        		}
        	}
    	}
    	return NAMES;
    }
    
    
    /**
	 * 儿童历次锁定信息	
	 * @param conn
	 * @param String ciid 儿童材料ID
	 * @return DataList
	 * @throws DBException
	 */
	public DataList showLockHistory(Connection conn, String ciid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("showLockHistory",ciid);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	/**
	 * 儿童历次发布信息	
	 * @param conn
	 * @param String ciid 儿童材料ID
	 * @return DataList
	 * @throws DBException
	 */
	public DataList showFbHistory(Connection conn, String ciid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("showFbHistory",ciid);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	/**
	 * 得到满足计划发布条件的计划ID(主要用于任务调度)
	 * @param conn
	 * @return DataList
	 * @throws DBException
	 */
	public String getPlanIdForDFB(Connection conn) throws DBException {
		String plan_id = "";
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPlanIdForDFB");
		DataList dl = ide.find(sql);
		
		if(dl.size()>0){
			plan_id = dl.getData(0).getString("PLAN_ID");
		}
        return plan_id;
	}
	
	
    
}
