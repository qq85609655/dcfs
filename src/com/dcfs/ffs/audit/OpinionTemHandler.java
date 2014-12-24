/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午3:00:55 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

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
 * @date 2014-8-13
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
	 * 审核意见模板列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList findListTem(Connection conn, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListTem", compositor, ordertype);
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
	
    
    /**
	 * 根据类别、审核级别、审核意见获得审核意见模板内容
	 * @description 
	 * @author MaYun
	 * @date 2014-8-19
	 * @param Connection conn 
	 * @param String type 类别(文件审核：00,审核部预批：10,安置部预批：11)
	 * @param String gy_type 公约类型（0:非公约收养;1:公约收养) 
	 * @param String audit_type 审核级别(初审：0,复审：1,审批：2)
	 * @param String audit_option 审核意见(参照com.dcfs.ffs.audit.FileAuditConstant.java常量类定义)
	 * @return Data fileData
	 */
	public Data getAuditModelContent(Connection conn,String type,String gy_type,String audit_type,String audit_option) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		String sql = getSql("getAuditModelContent", type,gy_type,audit_type,audit_option);
		dataList = ide.find(sql);
		return dataList.getData(0);
	}
}
