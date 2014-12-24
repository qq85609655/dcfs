package com.dcfs.sce.addMaterial;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;


/**
 * 
 * @Title: AddMaterialHandler.java
 * @Description: 补充预批资料查询、查看补充通知、补充操作
 * @Company: 21softech
 * @Created on 2014-9-14 下午3:43:13 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AddMaterialHandler extends BaseHandler {
    /**
     * 
     * @Title: findMaterialList
     * @Description: 预批补充列表
     * @author: panfeng
     * @date: 2014-9-11 下午5:21:12 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMaterialList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
    	String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);   //特别关注
        String ADD_TYPE = data.getString("ADD_TYPE", null);   //补充类型（部门）
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //开始补充通知日期
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //结束补充通知日期
        String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);   //开始反馈日期
        String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);   //结束反馈日期
        String AA_STATUS = data.getString("AA_STATUS", null);   //补充状态
        
        UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//获取当前收养组织单位
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findMaterialList", MALE_NAME, FEMALE_NAME, PROVINCE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SPECIAL_FOCUS, ADD_TYPE, NOTICE_DATE_START, NOTICE_DATE_END, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, compositor, ordertype, orgcode);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
	 * @Title: getSupData 
	 * @Description: 获取预批补充信息
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getSupData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getSupData", uuid);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}
	
	/**
     * 补充预批材料保存/提交
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean addMaterialSave(Connection conn, Map<String, Object> data)
            throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_ADDITIONAL");
        dataadd.setPrimaryKey("RA_ID");
        if ("".equals(dataadd.getString("RA_ID", ""))) {
        	dataadd.create();
        } else {
        	dataadd.store();
        }
        return true;
    }
	
	/**
	 * @Title: getDetailData 
	 * @Description: 获取补充通知详细查看信息
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getDetailData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getDetailData", uuid);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @Title: getInfoData 
	 * @Description: 根据id获取预批基本信息
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getInfoData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getInfoData", uuid);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @Title: modInfoSave 
	 * @Description: 预批基本信息保存/更新操作
	 * @author: panfeng
	 * @param conn
	 * @param data
	 * @return boolean    返回类型 
	 * @throws DBException
	 */
	public boolean modInfoSave(Connection conn, Map<String, Object> data) throws DBException {
		Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
    	dataadd.store();
        return true;
	}
    
    
}
