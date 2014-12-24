package com.dcfs.ncm.special;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;


/**
 * 
 * @Title: SpecialMatchHandler.java
 * @Description: 特需儿童匹配
 * @Company: 21softech
 * @Created on 2014-9-6 上午10:28:13
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SpecialMatchHandler extends BaseHandler {
    
    
    /**
     * 
     * @Title: findAFSpecialMatchList
     * @Description: 特需匹配文件列表
     * @author: xugy
     * @date: 2014-9-6上午10:54:05
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAFSpecialMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//当前日期，判断文件的政府批准书是否过期
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //收文开始日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //收文结束日期
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null); //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null); //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String MATCH_RECEIVEDATE_START = data.getString("MATCH_RECEIVEDATE_START", null);   //接收开始日期
        String MATCH_RECEIVEDATE_END = data.getString("MATCH_RECEIVEDATE_END", null);   //接收结束日期
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //文件类型
        String ADOPT_REQUEST_CN = data.getString("ADOPT_REQUEST_CN", null);   //收养要求
        String UNDERAGE_NUM = data.getString("UNDERAGE_NUM", null);   //子女数量
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //匹配次数
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //匹配状态
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='0'";
        }else if("9".equals(MATCH_STATE)){
            MATCH_STATE = "(MATCH_STATE='0' or MATCH_STATE='1')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
            
        }
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAFSpecialMatchList", nowDate, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, MATCH_RECEIVEDATE_START, MATCH_RECEIVEDATE_END, FILE_TYPE, ADOPT_REQUEST_CN, UNDERAGE_NUM, MATCH_NUM, MATCH_STATE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findCISpecialMatchList
     * @Description: 选择特需儿童材料列表
     * @author: xugy
     * @date: 2014-9-6上午11:12:33
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findCISpecialMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String CHECKUP_DATE_START = data.getString("CHECKUP_DATE_START", null);   //体检开始日期
        String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END", null); //体检结束日期
        String NAME = data.getString("NAME", null); //姓名
        String SEX = data.getString("SEX", null);   //性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //生日开始
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //生日结束
        String CHILD_TYPE = "2";   //儿童类型
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findCISpecialMatchList", PROVINCE_ID, WELFARE_ID, CHECKUP_DATE_START, CHECKUP_DATE_END, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
}
