package com.dcfs.fam.checkCollection;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: CheckCollectionHandler 
 * @Description: 支票托收handler类
 * @author panfeng
 * @date 2014-10-20
 *  
 */
public class CheckCollectionHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public CheckCollectionHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 支票托收列表
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList checkCollectionList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String PAID_NO = data.getString("PAID_NO", null);	//缴费编号
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String COST_TYPE = data.getString("COST_TYPE", null);	//费用类型
		String PAID_WAY = data.getString("PAID_WAY", null);	//缴费方式
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//应缴金额
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//票面金额
		String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START", null);	//开始接收日期
		String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END", null);	//结束接收日期
		String COLLECTION_DATE_START = data.getString("COLLECTION_DATE_START", null);	//开始托收日期
		String COLLECTION_DATE_END = data.getString("COLLECTION_DATE_END", null);	//结束托收日期
		String COLLECTION_USERNAME = data.getString("COLLECTION_USERNAME", null);	//托收人
		String COLLECTION_STATE = data.getString("COLLECTION_STATE", null);	//托收状态
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("checkCollectionList", PAID_NO, COUNTRY_CODE, ADOPT_ORG_ID, COST_TYPE, PAID_WAY, PAID_SHOULD_NUM, PAR_VALUE, RECEIVE_DATE_START, RECEIVE_DATE_END, COLLECTION_DATE_START, COLLECTION_DATE_END, COLLECTION_USERNAME, COLLECTION_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 支票托收页面
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList getCollectionShow(Connection conn, String checkId) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getCollectionShow", checkId);
		DataList dl = ide.find(sql);
		return dl;
	}
	
	/**
	 * 根据页面选择的id统计托收单总金额
	 *
	 * @param conn
	 * @param checkId
	 * @return
	 * @throws DBException
	 */
	public Data getSum(Connection conn, String checkId) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getSum", checkId));
		return dataList.getData(0);
	}
	
    
    /**
     * 保存票据信息
     * @author panfeng
     * @param conn
     * @param checkData
     * @return
     * @throws DBException
     */
    public boolean checkCollectionSave(Connection conn, Map<String, Object> checkData)
    		throws DBException {
    	Data dataadd = new Data(checkData);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FAM_CHEQUE_INFO");
    	dataadd.setPrimaryKey("CHEQUE_ID");
    	if ("".equals(dataadd.getString("CHEQUE_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    	
    }
    
    /**
     * 保存托收单记录信息
     * @author panfeng
     * @param conn
     * @param colData
     * @return
     * @throws DBException
     */
    
    public Data checkInfoSave(Connection conn, Map<String, Object> colData)
    		throws DBException {
    	Data dataadd = new Data(colData);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FAM_CHEQUE_COLLECTION");
    	dataadd.setPrimaryKey("CHEQUE_COL_ID");
    	if ("".equals(dataadd.getString("CHEQUE_COL_ID", ""))) {
            return dataadd.create();
        } else {
            return dataadd.store();
        }
    }

	
    
    /**
	 * 托收单查询列表
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList colSearchList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String COL_DATE_START = data.getString("COL_DATE_START", null);	//起始托收日期
		String COL_DATE_END = data.getString("COL_DATE_END", null);	//截止托收日期
		String COL_USERNAME = data.getString("COL_USERNAME", null);	//托收人
		String SUM_MIN = data.getString("SUM_MIN", null);	//最小托收单总金额
		String SUM_MAX = data.getString("SUM_MAX", null);	//最大托收单总金额
		String NUM = data.getString("NUM", null);	//支票数量
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("colSearchList", COL_DATE_START, COL_DATE_END, COL_USERNAME, SUM_MIN, SUM_MAX, NUM, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 支票托收页面
	 *
	 * @param conn
	 * @param coluuid
	 * @return
	 * @throws DBException
	 */
	public DataList getPrintShow(Connection conn, String coluuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPrintShow", coluuid);
		DataList dl = ide.find(sql);
		return dl;
	}
	
	/**
	 * 根据id查询票据托收单记录
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getColShow(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getColShow", uuid));
		return dataList.getData(0);
	}
	
}
