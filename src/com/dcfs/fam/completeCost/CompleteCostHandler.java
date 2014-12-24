package com.dcfs.fam.completeCost;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: CompleteCostHandler 
 * @Description: 完费维护handler类
 * @author panfeng
 * @date 2014-10-22
 *  
 */
public class CompleteCostHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public CompleteCostHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 完费维护列表
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList completeCostList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String NAME = data.getString("NAME", null);	//姓名
		String AF_COST = data.getString("AF_COST", null);	//应缴金额
		String PAID_NO = data.getString("PAID_NO", null);	//缴费编号
		String AF_COST_CLEAR = data.getString("AF_COST_CLEAR", null);	//完费状态
		String AF_COST_CLEAR_FLAG = data.getString("AF_COST_CLEAR_FLAG", null);	//维护标识
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("completeCostList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, NAME, AF_COST, PAID_NO, AF_COST_CLEAR, AF_COST_CLEAR_FLAG, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 根据文件id查询文件信息票据记录
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getCostShow(Connection conn, String uuid, String fileno) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getCostShow", fileno, uuid));
		return dataList.getData(0);
	}
	
	/**
	 * 根据缴费编号查询票据信息
	 *
	 * @param conn
	 * @param paid_no
	 * @return
	 * @throws DBException
	 */
	public Data getBillShow(Connection conn, String paid_no) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getBillShow", paid_no));
		return dataList.getData(0);
	}
	
	
    
    /**
     * 保存文件费用信息
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean completeCostSave(Connection conn, Map<String, Object> data)
    		throws DBException {
    	Data dataadd = new Data(data);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FFS_AF_INFO");
    	dataadd.setPrimaryKey("AF_ID");
    	if ("".equals(dataadd.getString("AF_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    	
    }
    
	
}
