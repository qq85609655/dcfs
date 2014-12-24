/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午3:00:55 
 * @version V1.0   
 */
package com.dcfs.sce.setSettle;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: SetSettleHandler 
 * @Description: 期限参数列表、设置安置、交文期限参数 
 * @author panfeng
 * @date 2014-9-16
 *  
 */
public class SetSettleHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public SetSettleHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 安置期限参数列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList settleParaList(Connection conn, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("settleParaList", compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 弹出期限参数设置窗口
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getSettleData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getSettleData", uuid));
		return dataList.getData(0);
	}
	
	 /**
     * 保存安置、交文期限设置
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveSettleMonth(Connection conn, Map<String, Object> data)
            throws DBException {
	    //***保存数据*****
        Data dataadd = new Data(data);
        
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_SETTLE_SET");
        dataadd.setPrimaryKey("SETTLE_ID");
        if ("".equals(dataadd.getString("SETTLE_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }
    
}
