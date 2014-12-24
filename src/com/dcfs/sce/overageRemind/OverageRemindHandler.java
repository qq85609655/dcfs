/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午3:00:55 
 * @version V1.0   
 */
package com.dcfs.sce.overageRemind;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: OverageRemindHandler 
 * @Description: 安置部查询、查看、超龄提醒设置、超龄自动退材料操作 
 * @author panfeng
 * @date 2014-9-16
 *  
 */
public class OverageRemindHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public OverageRemindHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 儿童超期提醒列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList overageRemindList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//查询条件
		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//省份
		String NAME = data.getString("NAME", null);	//姓名
		String SEX = data.getString("SEX", null);	//性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
		String SN_TYPE = data.getString("SN_TYPE", null);	//病残种类
		String DISEASE_CN = data.getString("DISEASE_CN", null);	//病残诊断
		String AUD_STATE =  data.getString("AUD_STATE", null);//审核状态
		String PUB_STATE = data.getString("PUB_STATE",null);//发布状态
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("overageRemindList", PROVINCE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, SN_TYPE, DISEASE_CN, AUD_STATE, PUB_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
     * 
     * @Title: findshowCIsList
     * @Description: 儿童信息
     * @author: panfeng
     * @date: 2014-9-16 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public DataList getChildrenData(Connection conn, String uuid) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildrenData", uuid);
        DataList dl = ide.find(sql);
        return dl;
    }
	
}
