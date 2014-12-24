/**   
 * @Title: DABdisposalHandler.java 
 * @Package com.dcfs.rfm.DABdisposal 
 * @Description: 由档案部对退文信息进行查询、处置、查看、导出操作
 * @author panfeng;
 * @date 2014-9-25 下午7:42:16 
 * @version V1.0   
 */
package com.dcfs.rfm.DABdisposal;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.Map;


public class DABdisposalHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public DABdisposalHandler(){
		// TODO Auto-generated constructor stub
	}
	
	/**
     * @Description: 更新退文状态方法 
     * Data 封装内容  如下：
     * 1、AF_ID 
     * 2、RETURN_STATE 退文状态 设置为“2”
     * @param conn
     * @param dl
     * @return
     */
	public boolean updateReturnState(Connection conn, DataList dl) throws DBException {
		  IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    //***保存文件信息表*****
        for(int i=0;i<dl.size();i++){
        	dl.getData(i).setConnection(conn);
    	    dl.getData(i).setEntityName("FFS_AF_INFO");
    	    dl.getData(i).setPrimaryKey("AF_ID");
        }
        ide.batchStore(dl);
        //***保存退文记录表*****
        for(int i=0;i<dl.size();i++){
        	dl.getData(i).setEntityName("RFM_AF_REVOCATION");
        	dl.getData(i).setPrimaryKey("AF_ID");
        	//TODO:是否添加一个更新条件：退文状态
        }
        ide.batchStore(dl);
        return true;
    }
	
	/**
	 * @throws DBException  
	 * @Title: DABdisposalList 
	 * @Description: 退文处置信息列表
	 * @author: panfeng;
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
	public DataList DABdisposalList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String APPLE_DATE_START = data.getString("APPLE_DATE_START", null);	//申请开始日期
		String APPLE_DATE_END = data.getString("APPLE_DATE_END", null);	//申请结束日期
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String RETREAT_DATE_START = data.getString("RETREAT_DATE_START", null);	//确认起始日期
		String RETREAT_DATE_END = data.getString("RETREAT_DATE_END", null);	//确认截止日期
		String RETURN_STATE = data.getString("RETURN_STATE", null);	//退文状态
		String HANDLE_TYPE = data.getString("HANDLE_TYPE", null);	//退文处置方式
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String DUAL_USERNAME = data.getString("DUAL_USERNAME", null);	//处置人
		String DUAL_DATE_START = data.getString("DUAL_DATE_START", null);	//处置起始日期
		String DUAL_DATE_END = data.getString("DUAL_DATE_END", null);	//处置截止日期
		String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//退文类型
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("DABdisposalList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, RETREAT_DATE_START, RETREAT_DATE_END, RETURN_STATE, HANDLE_TYPE, COUNTRY_CODE, ADOPT_ORG_ID, DUAL_USERNAME, DUAL_DATE_START, DUAL_DATE_END, APPLE_TYPE,compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 根据ID集批量查出退文记录
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList disposalShow(Connection conn, String arIds) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("disposalShow", arIds);
		DataList dl = ide.find(sql);
		return dl;
	}
	
	/**
	 * 根据退文记录表ID查出退文记录
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getReturnData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getReturnData", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: BGSconfirmSave 
	 * @Description: 保存退文信息
	 * @author: panfeng;
	 * @param conn
	 * @param data fileData
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 */
	public boolean BGSconfirmSave(Connection conn, Map<String, Object> data, Map<String, Object> fileData)
            throws DBException {
		//***保存文件信息表*****
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        if ("".equals(dataadd.getString("AF_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
	    //***保存退文记录表*****
        Data dataadd2 = new Data(data);
        dataadd2.setConnection(conn);
        dataadd2.setEntityName("RFM_AF_REVOCATION");
        dataadd2.setPrimaryKey("AR_ID");
        if ("".equals(dataadd2.getString("AR_ID", ""))) {
            dataadd2.create();
        } else {
            dataadd2.store();
        }
        return true;
    }
	
	
}
