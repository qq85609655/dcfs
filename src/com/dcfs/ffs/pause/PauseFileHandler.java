/**   
 * @Title: PauseFileHandler.java 
 * @Package com.dcfs.ffs.pause 
 * @Description: 由办公室对文件信息进行查询、暂停、取消暂停、退文、修改暂停期限、导出操作
 * @author panfeng;
 * @date 2014-9-2 下午3:01:44 
 * @version V1.0   
 */
package com.dcfs.ffs.pause;

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

public class PauseFileHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public PauseFileHandler(){
		// TODO Auto-generated constructor stub
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: pauseFileList 
	 * @Description: 文件暂停信息列表
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
	public DataList pauseFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String PAUSE_UNITNAME = data.getString("PAUSE_UNITNAME", null);	//暂停部门
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String RECOVERY_STATE = data.getString("RECOVERY_STATE", null);	//暂停状态
		String PAUSE_DATE_START = data.getString("PAUSE_DATE_START", null);	//起始取消日期
		String PAUSE_DATE_END = data.getString("PAUSE_DATE_END", null);	//截止取消日期
		String RECOVERY_DATE_START = data.getString("RECOVERY_DATE_START", null);	//起始取消暂停日期
		String RECOVERY_DATE_END = data.getString("RECOVERY_DATE_END", null);	//截止取消暂停日期
		String AF_POSITION = data.getString("AF_POSITION", null);	//文件位置
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("pauseFileList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, PAUSE_UNITNAME, MALE_NAME, FEMALE_NAME, RECOVERY_STATE, PAUSE_DATE_START, PAUSE_DATE_END, RECOVERY_DATE_START, RECOVERY_DATE_END, AF_POSITION, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: pauseSearchList 
	 * @Description: 收养组织文件暂停信息列表
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
	public DataList pauseSearchList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String PAUSE_UNITNAME = data.getString("PAUSE_UNITNAME", null);	//暂停部门
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String RECOVERY_STATE = data.getString("RECOVERY_STATE", null);	//暂停状态
		String PAUSE_DATE_START = data.getString("PAUSE_DATE_START", null);	//起始取消日期
		String PAUSE_DATE_END = data.getString("PAUSE_DATE_END", null);	//截止取消日期
		String RECOVERY_DATE_START = data.getString("RECOVERY_DATE_START", null);	//起始取消暂停日期
		String RECOVERY_DATE_END = data.getString("RECOVERY_DATE_END", null);	//截止取消暂停日期
		String AF_POSITION = data.getString("AF_POSITION", null);	//文件位置
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//当前用户所在组织
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("pauseSearchList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, orgcode, PAUSE_UNITNAME, MALE_NAME, FEMALE_NAME, RECOVERY_STATE, PAUSE_DATE_START, PAUSE_DATE_END, RECOVERY_DATE_START, RECOVERY_DATE_END, AF_POSITION, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: pauseChoiceList 
	 * @Description: 暂停文件选择列表
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
	public DataList pauseChoiceList(Connection conn, Data data, int pageSize,
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
		String AF_POSITION = data.getString("AF_POSITION", null);	//文件位置
		String AF_GLOBAL_STATE = data.getString("AF_GLOBAL_STATE", null);	//文件状态
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("pauseChoiceList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, NAME, AF_POSITION, AF_GLOBAL_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 根据文件ID查询该文件暂停信息
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
	 * 根据暂停记录ID查询该文件暂停信息
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data pauseSearchShow(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("pauseSearchShow", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: pauseFileSave 
	 * @Description: 保存文件暂停确认信息
	 * @author: panfeng;
	 * @param conn
	 * @param fileData; pauseData 
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 */
	public boolean pauseFileSave(Connection conn, Map<String, Object> fileData, Map<String, Object> pauseData)
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
        
        //***保存暂停记录表*****
        Data dataadd2 = new Data(pauseData);
        dataadd2.setConnection(conn);
        dataadd2.setEntityName("FFS_AF_PAUSE");
        dataadd2.setPrimaryKey("AP_ID");
        if ("".equals(dataadd2.getString("AP_ID", ""))) {
        	dataadd2.create();
        } else {
        	dataadd2.store();
        }
        
        return true;
    }
	
	/**
	 * @throws DBException  
	 * @Title: fileRecovery 
	 * @Description: 文件取消暂停操作
	 * @author: panfeng;
	 * @param conn
	 * @param recuuid
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean fileRecovery(Connection conn, String fileuuid, String recuuid) throws DBException {
		
		//***更新文件信息表*****
        Data filedata = new Data();
        filedata.setConnection(conn);
        filedata.setEntityName("FFS_AF_INFO");
        filedata.setPrimaryKey("AF_ID");
        filedata.add("AF_ID", fileuuid);
        filedata.add("IS_PAUSE", "0");//暂停标识变为"n"
        filedata.add("PAUSE_DATE", "");//清空暂停日期
        filedata.add("PAUSE_REASON", "");//清空暂停原因
        filedata.store();
        
        //***更新暂停记录表*****
		UserInfo curuser = SessionInfo.getCurUser();
		Data data = new Data();
		data.setConnection(conn);
		data.setEntityName("FFS_AF_PAUSE");
		data.setPrimaryKey("AP_ID");
		data.add("AP_ID", recuuid);
		data.add("RECOVERY_STATE", "9");//暂停状态变为"取消暂停"
		data.add("RECOVERY_DATE", DateUtility.getCurrentDate());//取消暂停时间
		data.add("RECOVERY_USERID", curuser.getPersonId());//取消暂停人ID
		data.add("RECOVERY_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//取消暂停人
		data.store();
		return true;
	}
	
}
