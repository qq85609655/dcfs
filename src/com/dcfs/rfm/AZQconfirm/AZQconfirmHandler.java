/**   
 * @Title: AZQconfirmHandler.java 
 * @Package com.dcfs.rfm.AZQconfirm 
 * @Description: 由翻译公司对退文信息进行查询、确认、查看、取消退文、导出操作
 * @author panfeng;
 * @date 2014-9-28 上午11:45:51 
 * @version V1.0   
 */
package com.dcfs.rfm.AZQconfirm;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;


public class AZQconfirmHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public AZQconfirmHandler(){
		// TODO Auto-generated constructor stub
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: AZQconfirmList 
	 * @Description: 退文确认信息列表
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
	public DataList AZQconfirmList(Connection conn, Data data, int pageSize,
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
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//当前用户部门
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("AZQconfirmList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, RETREAT_DATE_START, RETREAT_DATE_END, RETURN_STATE, HANDLE_TYPE, COUNTRY_CODE, ADOPT_ORG_ID, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 跳转到退文确认页面
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
	 * @Title: AZQconfirmSave 
	 * @Description: 保存退文信息
	 * @author: panfeng;
	 * @param conn
	 * @param data fileData
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 */
	public boolean AZQconfirmSave(Connection conn, Map<String, Object> data, Map<String, Object> fileData)
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
	
	/**
	 * @throws DBException  
	 * @Title: returnFileDelete 
	 * @Description: 批量取消退文信息
	 * @author: panfeng;
	 * @param conn
	 * @param uuid file_uuid
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean returnFileDelete(Connection conn, String[] uuid, String[] file_uuid) throws DBException {
		//更新退文记录中退文状态
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("RFM_AF_REVOCATION");
			data.setPrimaryKey("AR_ID");
			data.add("AR_ID", uuid[i]);
			data.add("ORG_ID",SessionInfo.getCurUser().getCurOrgan().getOrgCode());//确认部门ID
			data.add("PERSON_ID",SessionInfo.getCurUser().getPerson().getPersonId());//确认人ID
			data.add("PERSON_NAME",SessionInfo.getCurUser().getPerson().getCName());//确认人
			data.add("RETREAT_DATE",DateUtility.getCurrentDate());//确认日期
			data.add("RETURN_STATE", "9");//变更退文状态为"取消退文"
			data.store();
		}
		//删除文件信息中退文状态、退文原因
		for (int i = 0; i < file_uuid.length; i++) {
			Data data2 = new Data();
			data2.setConnection(conn);
			data2.setEntityName("FFS_AF_INFO");
			data2.setPrimaryKey("AF_ID");
			data2.add("AF_ID", file_uuid[i]);
			data2.add("RETURN_STATE", "");//清空退文状态
			data2.add("RETURN_REASON", "");//清空退文原因
			data2.store();
		}
		return true;
	}
	
	
}
