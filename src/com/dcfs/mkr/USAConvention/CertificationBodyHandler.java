/**   
 * @Title: CertificationBodyHandler.java 
 * @Package com.dcfs.mkr.USAConvention 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author panfeng
 * @date 2014-8-20 下午5:27:31 
 * @version V1.0   
 */
package com.dcfs.mkr.USAConvention;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

/** 
 * @ClassName: CertificationBodyHandler 
 * @Description: 美国公约认证机构维护handler类
 * @author panfeng
 * @date 2014-8-20
 *  
 */
public class CertificationBodyHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public CertificationBodyHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 认证机构列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList findBodyList(Connection conn, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findBodyList", compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getBodyNameData
	 * @Description: 根据机构名称查询机构信息
	 * @author: panfeng;
	 * @param conn
	 * @param name
	 * @return    设定文件 
	 * @return    返回类型 
	 * @throws 
	 */
	public Data getBodyNameData(Connection conn, String name, String type) throws DBException {
		
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getBodyNameData", name, type);
		//获取符合条件的信息
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
	
	 /**
     * 保存
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveCerBody(Connection conn, Map<String, Object> data, boolean iscreate)
            throws DBException {
	    //***保存数据*****
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("MKR_ORG_COA");
        dataadd.setPrimaryKey("COA_ID");
        if (iscreate) {
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
	public Data showCerBody(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getShowData", uuid));
		return dataList.getData(0);
	}
	
    /**
	 * @Title: bodyDelete 
	 * @Description: 根据ID批量删除草稿记录
	 * @author: panfeng;
	 * @param conn
	 * @return 
	 * @throws 
	 */
	public boolean bodyDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList deleteList = new DataList();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("MKR_ORG_COA");
			data.setPrimaryKey("COA_ID");
			data.add("COA_ID", uuid[i]);
			deleteList.add(data);
		}
		ide.remove(deleteList);
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: changeFail 
	 * @Description: 失效、恢复生效记录
	 * @author: panfeng;
	 * @param conn
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean changeFail(Connection conn, String uuid, String operation_type) throws DBException {
		UserInfo curuser = SessionInfo.getCurUser();
		Data data = new Data();
		data.setConnection(conn);
		data.setEntityName("MKR_ORG_COA");
		data.setPrimaryKey("COA_ID");
		data.add("COA_ID", uuid);
		if("fail".equals(operation_type)){
			data.add("STATE", "2");//状态变为已失效
		}else{
			data.add("STATE", "1");//状态变为已生效
		}
		data.add("MOD_DATE", DateUtility.getCurrentDate());//记录修改人
		data.add("MOD_USERID", curuser.getPersonId());//记录修改日期
		data.store();
		return true;
	}
	
}
