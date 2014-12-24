package com.dcfs.far.appointment;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @Title: AppointmentHandler.java
 * @Description: 来华领养预约
 * @Company: 21softech
 * @Created on 2014-9-29 下午5:28:14
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AppointmentHandler extends BaseHandler {
    /**
     * 
     * @Title: findAppointmentRecordList
     * @Description: 收养组织预约列表
     * @author: xugy
     * @date: 2014-9-29下午5:33:23
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZAppointmentRecordList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String SIGN_NO = data.getString("SIGN_NO", null);   //通知书号
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String ORDER_DATE_START = data.getString("ORDER_DATE_START", null);   //开始预约时间
        String ORDER_DATE_END = data.getString("ORDER_DATE_END", null);   //结束预约时间
        String SUGGEST_DATE_START = data.getString("SUGGEST_DATE_START", null);   //开始建议时间
        String SUGGEST_DATE_END = data.getString("SUGGEST_DATE_END", null);   //结束建议时间
        String ORDER_STATE = data.getString("ORDER_STATE", null);   //预约状态
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZAppointmentRecordList", adoptOrg, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, ORDER_DATE_START, ORDER_DATE_END, SUGGEST_DATE_START, SUGGEST_DATE_END, ORDER_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZAppointmentSelectList
     * @Description: 收养组织预约选择列表
     * @author: xugy
     * @date: 2014-9-29下午8:52:51
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZAppointmentSelectList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String SIGN_NO = data.getString("SIGN_NO", null);   //通知书号
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //开始签批日期
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //结束签批日期
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZAppointmentSelectList", adoptOrg, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SIGN_DATE_START, SIGN_DATE_END, compositor, ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getAppointmentShowInfo
     * @Description: 获取预约添加显示信息
     * @author: xugy
     * @date: 2014-9-30下午1:34:31
     * @param conn
     * @param id
     * @return
     * @throws DBException 
     */
    public Data getAppointmentShowInfo(Connection conn, String id) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAppointmentShowInfo", id);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: SYZZAppointmentSave
     * @Description: 预约申请保存
     * @author: xugy
     * @date: 2014-9-30下午2:16:00
     * @param conn
     * @param data
     * @throws DBException 
     */
    public void SYZZAppointmentSave(Connection conn, Data data) throws DBException {
     // ***保存数据*****
        Data dataadd = new Data(data);

        dataadd.setConnection(conn);
        dataadd.setEntityName("FAR_APPOINTMENT_RECORD");
        dataadd.setPrimaryKey("AR_ID");
        if ("".equals(dataadd.getString("AR_ID", ""))) {
            dataadd.create();         
        } else {
            dataadd.store();
        }
        
    }
    /**
     * 
     * @Title: getAppointmentInfo
     * @Description: 预约申请修改页面信息
     * @author: xugy
     * @date: 2014-9-30下午3:57:47
     * @param conn
     * @param AR_ID
     * @return
     * @throws DBException 
     */
    public Data getAppointmentInfo(Connection conn, String AR_ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAppointmentInfo", AR_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    
    
    
    
    
    
    /**
     * 
     * @Title: findSTAppointmentAcceptList
     * @Description: 省厅预约受理
     * @author: xugy
     * @date: 2014-10-2下午2:59:44
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSTAppointmentAcceptList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String SIGN_NO = data.getString("SIGN_NO", null);   //通知书号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String ORDER_DATE_START = data.getString("ORDER_DATE_START", null);   //开始预约时间
        String ORDER_DATE_END = data.getString("ORDER_DATE_END", null);   //结束预约时间
        String SUGGEST_DATE_START = data.getString("SUGGEST_DATE_START", null);   //开始建议时间
        String SUGGEST_DATE_END = data.getString("SUGGEST_DATE_END", null);   //结束建议时间
        String ORDER_STATE = data.getString("ORDER_STATE", null);   //预约状态
        
        
        String provinceCode = SessionInfo.getCurUser().getCurOrgan().getParentOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSTAppointmentAcceptList", provinceCode, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, WELFARE_NAME_CN, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, ORDER_DATE_START, ORDER_DATE_END, SUGGEST_DATE_START, SUGGEST_DATE_END, ORDER_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findFLYApppointmentList
     * @Description: 福利院来华预约列表
     * @author: xugy
     * @date: 2014-10-9上午9:29:05
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findFLYApppointmentList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String SIGN_NO = data.getString("SIGN_NO", null);   //通知书号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String ORDER_DATE_START = data.getString("ORDER_DATE_START", null);   //开始预约时间
        String ORDER_DATE_END = data.getString("ORDER_DATE_END", null);   //结束预约时间
        
        
        String WelfareCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findFLYApppointmentList", WelfareCode, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, ORDER_DATE_START, ORDER_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
