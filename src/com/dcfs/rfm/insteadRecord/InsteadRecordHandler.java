/**   
 * @Title: InsteadRecordHandler.java 
 * @Package com.dcfs.rfm.insteadRecord 
 * @Description: 由办公室对退文代录信息进行查询、退文代录、查看、导出操作
 * @author panfeng;
 * @date 2014-9-23 上午9:03:08 
 * @version V1.0   
 */
package com.dcfs.rfm.insteadRecord;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.Map;


public class InsteadRecordHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public InsteadRecordHandler(){
		// TODO Auto-generated constructor stub
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: insteadRecordList 
	 * @Description: 退文代录信息列表
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
	public DataList insteadRecordList(Connection conn, Data data, int pageSize,
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
		String DUAL_DATE_START = data.getString("DUAL_DATE_START", null);	//处置起始日期
		String DUAL_DATE_END = data.getString("DUAL_DATE_END", null);	//处置截止日期
		String RETURN_STATE = data.getString("RETURN_STATE", null);	//退文状态
		String HANDLE_TYPE = data.getString("HANDLE_TYPE", null);	//退文处置方式
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String AF_POSITION = data.getString("AF_POSITION", null);	//所在部门
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("insteadRecordList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, DUAL_DATE_START, DUAL_DATE_END, RETURN_STATE, HANDLE_TYPE, COUNTRY_CODE, ADOPT_ORG_ID, AF_POSITION, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: returnChoiceList 
	 * @Description: 退文代录选择文件列表
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
	public DataList returnChoiceList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String AF_POSITION = data.getString("AF_POSITION", null);	//文件位置
		String AF_GLOBAL_STATE = data.getString("AF_GLOBAL_STATE", null);	//登记状态
		String MATCH_STATE = data.getString("MATCH_STATE", null);	//选配状态
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("returnChoiceList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, FILE_TYPE, AF_POSITION, AF_GLOBAL_STATE, MATCH_STATE, COUNTRY_CODE, ADOPT_ORG_ID, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	/**
	 * 跳转到退文代录确认页面
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data confirmShow(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("confirmShow", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: ReturnFileSave 
	 * @Description: 保存退文申请确认信息
	 * @author: panfeng;
	 * @param conn
	 * @param data fileData
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 */
	public boolean ReturnFileSave(Connection conn, Map<String, Object> data, Map<String, Object> fileData)
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
