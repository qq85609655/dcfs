/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午3:00:55 
 * @version V1.0   
 */
package com.dcfs.sce.opinionTem;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: RegistrationHandler 
 * @Description: 审核意见模板handler类
 * @author panfeng
 * @date 2014-10-09 
 *  
 */
public class OpinionTemHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public OpinionTemHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 审核部预批审核意见模板列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList SHBfindListTem(Connection conn, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("SHBfindListTem", compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 安置部预批审核意见模板列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList AZBfindListTem(Connection conn, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("AZBfindListTem", compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	 /**
     * 保存
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveOpinionTem(Connection conn, Map<String, Object> data)
            throws DBException {
	    //***保存数据*****
        Data dataadd = new Data(data);
        
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_AUDITOPTION_MODEL");
        dataadd.setPrimaryKey("AAM_ID");
        if ("".equals(dataadd.getString("AAM_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }
	
	
	/**
	 * 查看
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data showOpinionTem(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getShowData", uuid));
		return dataList.getData(0);
	}
    
}
