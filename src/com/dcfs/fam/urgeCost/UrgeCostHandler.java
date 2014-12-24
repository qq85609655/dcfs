/**   
 * @Title: UrgeCostHandler.java 
 * @Package com.dcfs.fam.urgeCost 
 * @Description: 费用催缴操作
 * @author yangrt   
 * @date 2014-10-23 下午6:26:15 
 * @version V1.0   
 */
package com.dcfs.fam.urgeCost;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

/** 
 * @ClassName: UrgeCostHandler 
 * @Description: 费用催缴操作
 * @author yangrt;
 * @date 2014-10-23 下午6:26:15 
 *  
 */
public class UrgeCostHandler extends BaseHandler {

	/**
	 * @Title: UrgeCostList 
	 * @Description: 费用催缴查询列表
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
	public DataList UrgeCostList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String PAID_NO = data.getString("PAID_NO", null);	//缴费编号
		String CHILD_NUM = data.getString("CHILD_NUM", null);	//正常儿童数量
		String S_CHILD_NUM = data.getString("S_CHILD_NUM", null);	//特需儿童数量
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);	//通知起始日期
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);	//通知截止日期
		String COST_TYPE = data.getString("COST_TYPE", null);	//费用类型
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//缴费金额
		String PAY_DATE_START = data.getString("PAY_DATE_START", null);	//缴费起始日期
		String PAY_DATE_END = data.getString("PAY_DATE_END", null);	//缴费截止日期
		String ARRIVE_STATE = data.getString("ARRIVE_STATE", null);	//缴费状态
		String ARRIVE_VALUE = data.getString("ARRIVE_VALUE", null);	//到账金额
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//到账起始日期
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//到账截止日期
		String COLLECTION_STATE = data.getString("COLLECTION_STATE", null);	//托收状态
		String NOTICE_STATE = data.getString("NOTICE_STATE", null);	//通知状态
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("UrgeCostList",COUNTRY_CODE,ADOPT_ORG_ID,PAID_NO,CHILD_NUM,S_CHILD_NUM,NOTICE_DATE_START,NOTICE_DATE_END,COST_TYPE,PAR_VALUE,PAY_DATE_START,PAY_DATE_END,ARRIVE_STATE,ARRIVE_VALUE,ARRIVE_DATE_START,ARRIVE_DATE_END,COLLECTION_STATE,NOTICE_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: UrgeCostNoticeSave 
	 * @Description: 费用催缴通知信息保存
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean 
	 * @throws DBException
	 */
	public boolean UrgeCostNoticeSave(Connection conn, Data data) throws DBException {
		data.setConnection(conn);
		data.setEntityName("FAM_COST_REMINDER");
		data.setPrimaryKey("RM_ID");
		if(data.getString("RM_ID","").equals("")){
			data.create();
		}else{
			data.store();
		}
		
		return true;
	}

	/**
	 * @Title: getUrgeCostNoticeData 
	 * @Description: 根据催缴记录id，获取催缴通知信息
	 * @author: yangrt
	 * @param conn
	 * @param rm_id
	 * @return Data
	 * @throws DBException
	 */
	public Data getUrgeCostNoticeData(Connection conn, String rm_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getUrgeCostNoticeData",rm_id);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}

	/**
	 * @Title: UrgeCostStatisticsList 
	 * @Description: 统计列表
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList UrgeCostStatisticsList(Connection conn, Data data,
			int pageSize, int page) throws DBException {
		//查询条件
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String SEARCH_TYPE = data.getString("SEARCH_TYPE", "");	//统计依据
		String DATE_START = data.getString("DATE_START", null);	//起止日期
		String DATE_END = data.getString("DATE_END", null);	//截止日期
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = "";
		if(SEARCH_TYPE.equals("1")){
			//统计依据:征求意见反馈确认日期
			sql = getSql("UrgeCostStatisticsList1",COUNTRY_CODE,ADOPT_ORG_ID,DATE_START,DATE_END);
		}else if(SEARCH_TYPE.equals("2")){
			//统计依据:来华领养通知书签发日期
			sql = getSql("UrgeCostStatisticsList2",COUNTRY_CODE,ADOPT_ORG_ID,DATE_START,DATE_END);
		}
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: UrgeCostBatchNoticeSave 
	 * @Description: 统计录入费用催缴通知信息保存
	 * @author: yangrt
	 * @param conn
	 * @param saveList
	 * @return boolean 
	 * @throws DBException
	 */
	public boolean UrgeCostBatchNoticeSave(Connection conn, DataList saveList) throws DBException {
		int num = saveList.size();
		for(int i = 0; i < num; i++){
			Data data = saveList.getData(i);
			data.setConnection(conn);
			data.setEntityName("FAM_COST_REMINDER");
			data.setPrimaryKey("RM_ID");
			data.create();
		}
		return true;
	}
	
	/**
	 * @Title: getDataList 
	 * @Description: 查看相应的文件儿童列表信息
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return DataList
	 * @throws DBException
	 */
	public DataList getFileChildDataList(Connection conn, String countrycode, String orgcode, String SEARCH_TYPE, String DATE_START, String DATE_END) throws DBException {
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = "";
		if(SEARCH_TYPE.equals("1")){
			//统计依据:征求意见反馈确认日期
			sql = getSql("getFileChildDataList1", null, orgcode,DATE_START,DATE_END);
		}else if(SEARCH_TYPE.equals("2")){
			//统计依据:来华领养通知书签发日期
			sql = getSql("getFileChildDataList2", countrycode, orgcode,DATE_START,DATE_END);
		}
		DataList dl = ide.find(sql);
        return dl;
	}

	/** 
	 * @Title: UrgeCostNoticeBatchDelete 
	 * @Description: 费用催缴通知批量删除
	 * @author: yangrt
	 * @param conn
	 * @param deleteid
	 * @return boolean
	 * @throws DBException
	 */
	public boolean UrgeCostNoticeBatchDelete(Connection conn, String deleteid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList deleteList = new DataList();
        String[] rm_id = deleteid.split(";");
        for (int i = 0; i < rm_id.length; i++) {
            Data data = new Data();
            data.setConnection(conn);
            data.setEntityName("FAM_COST_REMINDER");
            data.setPrimaryKey("RM_ID");
            data.add("RM_ID", rm_id[i]);
            deleteList.add(data);
        }
        ide.remove(deleteList);
        return true;
	}

	/** 
	 * @Title: UrgeCostNoticeBatchSubmit 
	 * @Description: 费用催缴通知批量发送
	 * @author: yangrt
	 * @param conn
	 * @param submitid
	 * @return boolean
	 * @throws DBException
	 */
	public boolean UrgeCostNoticeBatchSubmit(Connection conn, String submitid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        String[] rm_id = submitid.split(";");
        for (int i = 0; i < rm_id.length; i++) {
            Data data = new Data();
            data.setConnection(conn);
            data.setEntityName("FAM_COST_REMINDER");
            data.setPrimaryKey("RM_ID");
            data.add("RM_ID", rm_id[i]);
            data.add("NOTICE_DATE", DateUtility.getCurrentDateTime());
            data.add("NOTICE_STATE", "1");
            dataList.add(data);
        }
        ide.batchStore(dataList);
        return true;
	}

	/** 
	 * @Title: UrgeCostFeedBackSave 
	 * @Description: 催缴通知反馈录入信息保存
	 * @author: yangrt
	 * @param conn
	 * @param pjdata	票据信息
	 * @param tzdata	费用催缴通知信息
	 * @return boolean 
	 * @throws 
	 */
	public boolean UrgeCostFeedBackSave(Connection conn, Data pjdata, Data tzdata) throws DBException {
		//创建票据信息
		pjdata.setConnection(conn);
		pjdata.setEntityName("FAM_CHEQUE_INFO");
		pjdata.setPrimaryKey("CHEQUE_ID");
		pjdata.create();
		
		//更新费用催缴通知信息（通知状态：已反馈，NOTICE_STATE：2）
		tzdata.setConnection(conn);
		tzdata.setEntityName("FAM_COST_REMINDER");
		tzdata.setPrimaryKey("RM_ID");
		tzdata.store();
		
		return true;
	}

	/** 
	 * @Title: UrgeCostReceiveSave 
	 * @Description: 到账反馈信息保存
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean 
	 */
	public boolean UrgeCostReceiveSave(Connection conn, Data data) throws DBException {
		//更新票据信息
		data.setConnection(conn);
		data.setEntityName("FAM_CHEQUE_INFO");
		data.setPrimaryKey("CHEQUE_ID");
		data.store();
		
		return true;
	}

	/** 
	 * @Title: getFileNum 
	 * @Description: 获取该缴费通知中包含的文件数量
	 * @author: yangrt
	 * @param conn
	 * @param string
	 * @param string2
	 * @param SEARCH_TYPE
	 * @param DATE_START
	 * @param DATE_END
	 * @return String
	 * @throws DBException
	 */
	public String getFileNum(Connection conn, String countrycode, String orgcode,
			String SEARCH_TYPE, String DATE_START, String DATE_END) throws DBException {
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = "";
		if(SEARCH_TYPE.equals("1")){
			//统计依据:征求意见反馈确认日期
			sql = getSql("getFileNum1", null, orgcode,DATE_START,DATE_END);
		}else if(SEARCH_TYPE.equals("2")){
			//统计依据:来华领养通知书签发日期
			sql = getSql("getFileNum2", countrycode, orgcode,DATE_START,DATE_END);
		}
		DataList dl = ide.find(sql);
        return dl.size() + "";
	}
	
}
