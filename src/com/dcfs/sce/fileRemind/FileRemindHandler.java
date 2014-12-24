package com.dcfs.sce.fileRemind;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;


/**
 * 
 * @Title: FileRemindHandler.java
 * @Description: 递交文件催办查询、查看操作
 * @Company: 21softech
 * @Created on 2014-9-15 下午5:01:29 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FileRemindHandler extends BaseHandler {
    /**
     * 
     * @Title: findRemindList
     * @Description: 递交文件催办查询列表
     * @author: panfeng
     * @date: 2014-9-15 下午5:01:29 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findRemindList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
    	String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String REQ_DATE_START = data.getString("REQ_DATE_START", null);   //开始申请日期
        String REQ_DATE_END = data.getString("REQ_DATE_END", null);   //结束申请日期
        String PASS_DATE_START = data.getString("PASS_DATE_START", null);   //开始答复日期
        String PASS_DATE_END = data.getString("PASS_DATE_END", null);   //结束答复日期
        String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);   //开始递交文件期限
        String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);   //结束递交文件期限
        String REM_DATE_START = data.getString("REM_DATE_START", null);   //开始催办日期
        String REM_DATE_END = data.getString("REM_DATE_END", null);   //结束催办日期
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findRemindList", MALE_NAME, FEMALE_NAME, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, REQ_DATE_START, REQ_DATE_END, PASS_DATE_START, PASS_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REM_DATE_START, REM_DATE_END, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
	 * 弹出催办通知查看页面
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getRemindShow(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getRemindShow", uuid));
		return dataList.getData(0);
	}
	
}
