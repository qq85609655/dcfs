package com.dcfs.pfr.SYZZ;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: SYZZPPFeedbackHandler.java
 * @Description: 收养组织安置后报告反馈
 * @Company: 21softech
 * @Created on 2014-10-9 下午5:13:42
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SYZZPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findSYZZPPFeedbackList
     * @Description: 收养组织安置后报告反馈列表
     * @author: xugy
     * @date: 2014-10-9下午6:02:52
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZPPFeedbackList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String NUM = data.getString("NUM", null);   //次第数
        String REPORT_DATE_START = data.getString("REPORT_DATE_START", null);   //开始上报日期
        String REPORT_DATE_END = data.getString("REPORT_DATE_END", null);   //结束上报日期
        String REPORT_STATE = data.getString("REPORT_STATE", "");   //报告状态
        if("".equals(REPORT_STATE)){
            REPORT_STATE = null;
        }else if("1".equals(REPORT_STATE)){
            REPORT_STATE = "REPORT_STATE IN ('1','2','3','4','5','6')";
        }else{
            REPORT_STATE = "REPORT_STATE='"+REPORT_STATE+"'";
        }
        String REMINDERS_STATE = data.getString("REMINDERS_STATE", null);   //催交状态
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPPFeedbackList", adoptOrg, FILE_NO, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, NUM, REPORT_DATE_START, REPORT_DATE_END, REPORT_STATE, REMINDERS_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZPPFeedbackAdditonalList
     * @Description: 报告补充列表
     * @author: xugy
     * @date: 2014-10-21下午8:39:05
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZPPFeedbackAdditonalList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String NUM = data.getString("NUM", null);   //次第数
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //开始通知日期
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //结束通知日期
        String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);   //开始反馈日期
        String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);   //结束反馈日期
        String AA_STATUS = data.getString("AA_STATUS", null);   //补充状态
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPPFeedbackAdditonalList", adoptOrg, FILE_NO, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, NUM, NOTICE_DATE_START, NOTICE_DATE_END, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZPPFeedbackReminderList
     * @Description: 报告催交列表
     * @author: xugy
     * @date: 2014-10-23下午3:02:26
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZPPFeedbackReminderList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_NAME_EN = data.getString("WELFARE_NAME_EN", null);   //福利院
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String NUM = data.getString("NUM", null);   //次第数
        String LIMIT_DATE_START = data.getString("LIMIT_DATE_START", null);   //开始截止日期
        String LIMIT_DATE_END = data.getString("LIMIT_DATE_END", null);   //结束截止日期
        String REMINDERS_DATE_START = data.getString("REMINDERS_DATE_START", null);   //开始催交日期
        String REMINDERS_DATE_END = data.getString("REMINDERS_DATE_END", null);   //结束催交日期
        
        
        String adoptOrg = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPPFeedbackReminderList", adoptOrg, FILE_NO, SIGN_NO, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_NAME_EN, NAME_PINYIN, NUM, LIMIT_DATE_START, LIMIT_DATE_END, REMINDERS_DATE_START, REMINDERS_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    

}
