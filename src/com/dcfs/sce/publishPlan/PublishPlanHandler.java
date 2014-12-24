/**   
 * @Title: FileAuditHandler.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午5:10:43 
 * @version V1.0   
 */
package com.dcfs.sce.publishPlan;

import java.sql.Connection;
import java.util.Map;

import com.sun.corba.se.spi.ior.Identifiable;

import java_cup.internal_error;

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
public class PublishPlanHandler extends BaseHandler {

	public PublishPlanHandler() {
	}

	public PublishPlanHandler(String propFileName) {
		super(propFileName);
	}
	
	
	/**
	 * 发布计划列表	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForFBJH(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件

		String PLAN_NO = data.getString("PLAN_NO", null);	//计划批号
		String NOTE_DATE_START = data.getString("NOTE_DATE_START", null);	//预告日期
		String NOTE_DATE_END = data.getString("NOTE_DATE_END", null);	//预告日期
		String PUB_DATE_START = data.getString("PUB_DATE_START", null);	//发布日期
		String PUB_DATE_END = data.getString("PUB_DATE_END", null);	//发布日期
		String PLAN_USERNAME = data.getString("PLAN_USERNAME", null);	//制定人姓名
		String PLAN_DATE_START = data.getString("PLAN_DATE_START", null);	//制定日期
		String PLAN_DATE_END = data.getString("PLAN_DATE_END", null);	//制定日期
		String NOTICE_STATE = data.getString("NOTICE_STATE", null);	//预告状态
		String PLAN_STATE = data.getString("PLAN_STATE", null);	//计划状态
		
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForFBJH",PLAN_NO, NOTE_DATE_START, NOTE_DATE_END, PUB_DATE_START,PUB_DATE_END,PLAN_USERNAME, PLAN_DATE_START, PLAN_DATE_END, NOTICE_STATE, PLAN_STATE, compositor, ordertype);
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
	public DataList toChoseETForJH(Connection conn, Data data, int pageSize,
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
		String sql = getSql("toChoseETForJH",PROVINCE_ID, WELFARE_ID, NAME, SEX,BIRTHDAY_START,BIRTHDAY_END, SN_TYPE, SPECIAL_FOCUS, PUB_NUM, PUB_FIRSTDATE_START, PUB_FIRSTDATE_END, PUB_LASTDATE_START, PUB_LASTDATE_END, compositor, ordertype);
		//System.out.println("toChoseETForFBSql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 查询发布计划中已选择的儿童列表
	 * @description 
	 * @author MaYun
	 * @date Sep 28, 2014
	 * @return
	 */
	public DataList findSelectedET(Connection conn,String ciids) throws DBException{
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findSelectedET",ciids);
		//System.out.println("toChoseETForFBSql---->"+sql);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	
	/**
	 * 根据儿童材料IDS和发布状态，批量更新儿童信息表的发布状态
	 * @description 
	 * @author MaYun
	 * @date Sep 28, 2014
	 * @param String ciids 格式为'a','b','c'
	 * @param String pub_state 0:待发布  1：计划中  2:已发布  3:已锁定  4:已申请
	 * @return
	 * @throws DBException 
	 */
	public void updatePubStateForET(Connection conn,String ciids,String pub_state) throws DBException{
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("updatePubStateForET",ciids,pub_state);
		ide.execute(sql);
	}
	
	
	/**
     * 保存发布计划信息
     * @author mayun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveFbJhInfo(Connection conn, Map<String, Object> fbjhData) throws DBException {
        Data dataadd = new Data(fbjhData);
        String plan_id = dataadd.getString("PLAN_ID");
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_PUB_PLAN");
        dataadd.setPrimaryKey("PLAN_ID");
        if("".equals(plan_id)||null==plan_id||"null".equals(plan_id)){
        	return dataadd.create();
        }else{
        	return dataadd.store();
        }
    }
    
    /**
     * 判断是否可以制定新的发布计划
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:不可以  true:可以
     */
    public boolean isCanMakeNewPlan(Connection conn)throws DBException{
    	boolean flag = false;
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isCanMakeNewPlan");
		Data data = ide.find(sql).getData(0);
		int num = data.getInt("COUNT");
    	if(num>=1){
    		flag = false;
    	}else{
    		flag = true;
    	}
    	return flag;
    }
    
    /**
     * 判断是否可以删除发布计划
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:不可以  true:可以
     */
    public boolean isCanDeletePlan(Connection conn,String plan_id)throws DBException{
    	boolean flag = false;
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isCanDeletePlan",plan_id);
		Data data = ide.find(sql).getData(0);
		String plan_state = data.getString("PLAN_STATE");
    	if("2".equals(plan_state)||"2"==plan_state){
    		flag = false;
    	}else{
    		flag = true;
    	}
    	return flag;
    }
    
    /**
     * 判断是否可以发布该计划
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return  false:不可以  true:可以
     */
    public boolean isCanPublishPlan(Connection conn,String plan_id)throws DBException{
    	boolean flag = false;
    	
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("isCanPublishPlan",plan_id);
		Data data = ide.find(sql).getData(0);
		int num = data.getInt("COUNT");
    	if(num==0){
    		flag = false;
    	}else{
    		flag = true;
    	}
    	return flag;
    }
    
    
    
    /**
     * 更新发布计划表的发布状态为已发布
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return
     * @throws DBException 
     */
    public void updateFBStateForFBJH(Connection conn,String plan_id) throws DBException{
    	//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("updateFBStateForFBJH",plan_id);
		ide.execute(sql);
    }
    
    /**
     * 更新发布记录表的发布状态为已发布
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @param String userId
     * @param String userName
     * @param String plan_id
     * @return
     * @throws DBException 
     */
    public void updateFBStateForFBJL(Connection conn,String userId,String userName,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("updateFBStateForFBJL",userId,userName,plan_id);
		ide.execute(sql);
    }
    
    /**
     * 更新儿童材料的发布状态为已发布
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @return
     * @throws DBException 
     */
    public void updateFBStateForETCL(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		
		for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("CMS_CI_INFO");
    		dataList.getData(i).setPrimaryKey("CI_ID");
    	}
    	ide.batchStore(dataList);
    	
    }
    
    /**
     * 根据发布计划主键ID得到本次待发布的儿童集合
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @param String plan_id  发布计划主键ID
     * @return DataList 儿童集合
     */
    public DataList getEtInfoListForFBJH(Connection conn,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getEtInfoListForFBJH",plan_id);
		return ide.find(sql);
    }
    
    /**
     * 根据发布计划主键ID得到发布计划详细信息
     * @description 
     * @author MaYun
     * @date Oct 8, 2014
     * @param String plan_id  发布计划主键ID
     * @return Data 发布计划详细信息
     */
    public Data getFbDataForFBJH(Connection conn,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFbDataForFBJH",plan_id);
		return ide.find(sql).getData(0);
    }
    
    /**
     * 删除发布计划
     * @description 
     * @author MaYun
     * @date Oct 10, 2014
     * @return
     * @throws DBException 
     */
    public void deletePlan(Connection conn,String plan_id) throws DBException {
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("deletePlan",plan_id);
		ide.execute(sql);
    }
    
    /**
     * 删除发布记录
     * @description 
     * @author MaYun
     * @date Oct 10, 2014
     * @return
     * @throws DBException 
     */
    public void deleteFBJL(Connection conn,DataList dataList) throws DBException {
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("SCE_PUB_RECORD");
    		dataList.getData(i).setPrimaryKey("PUB_ID");
    	}
		ide.remove(dataList);
    }
    
    
    /**
     * 更加发布计划主键ID和儿童材料ID，删除发布记录表相关发布记录信息
     * @description 
     * @author MaYun
     * @date Oct 15, 2014
     * @return
     */
    public void deleteFBJLForCIIDS(Connection conn,String plan_id,String ciids) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("deleteFBJLForCIIDS",plan_id,ciids);
		ide.execute(sql);
    }
   
    
    /**
     * 根据发布计划主键ID得到本次待发布记录
     * @description 
     * @author MaYun
     * @date Oct 10, 2014
     * @return
     * @throws DBException 
     */
    public DataList getFBJLListForPlan(Connection conn,String plan_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFBJLListForPlan",plan_id);
		return  ide.find(sql);
    }
	
    /**
     * 更新发布计划信息
     * @description 
     * @author MaYun
     * @date Oct 15, 2014
     * @return
     */
    public void updateFBJH(Connection conn,Data data) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	data.setEntityName("SCE_PUB_PLAN");
    	data.setPrimaryKey("PLAN_ID");
		ide.store(data);
    }
    
    /**
	 * 得到最新一次已预告的发布计划相关信息
	 * @description 
	 * @author MaYun
	 * @date Dec 9, 2014
	 * @return
	 */
	public Data getFBJHForYYG(Connection conn)throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getFBJHForYYG");
    	Data data = new Data();
    	DataList dataList = ide.find(sql);
    	if(dataList.size()>0){
    		data = (Data)dataList.get(0);
    	}
    	return data;
    }
    
}
