package com.dcfs.ncm.SYZZadvice;

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
 * @Title: SYZZAdviceHandler.java
 * @Description: 
 * @Company: 21softech
 * @Created on 2014-9-11 下午4:39:03
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SYZZAdviceHandler extends BaseHandler {
    /**
     * 
     * @Title: findSYZZAdviceList
     * @Description: 收养组织征求意见列表
     * @author: xugy
     * @date: 2014-9-11下午4:50:21
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSYZZAdviceList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //文件类型
        if("99".equals(FILE_TYPE)){
            FILE_TYPE = "FILE_TYPE IN ('20','21','22','23')";
        }else if(!"99".equals(FILE_TYPE) && FILE_TYPE != null){
            FILE_TYPE = "FILE_TYPE='"+FILE_TYPE+"'";
        }
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //开始收文日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //结束收文日期
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String ADVICE_NOTICE_DATE_START = data.getString("ADVICE_NOTICE_DATE_START", null);   //开始通知日期
        String ADVICE_NOTICE_DATE_END = data.getString("ADVICE_NOTICE_DATE_END", null);   //结束通知日期
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String ADVICE_STATE = data.getString("ADVICE_STATE", null);   //征求状态
        String ADVICE_FEEDBACK_RESULT = data.getString("ADVICE_FEEDBACK_RESULT", null);   //反馈结果
        String ADVICE_REMINDER_STATE = data.getString("ADVICE_REMINDER_STATE", null);   //催办状态
        
        String ADOPT_ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode();//当前登录人的收养组织
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZAdviceList", ADOPT_ORG_ID, FILE_NO, FILE_TYPE, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, FEMALE_NAME, ADVICE_NOTICE_DATE_START, ADVICE_NOTICE_DATE_END, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, PROVINCE_ID, WELFARE_ID, CHILD_TYPE, ADVICE_STATE, ADVICE_FEEDBACK_RESULT, ADVICE_REMINDER_STATE, compositor, ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findSYZZNoticeList
     * @Description: 收养组织来华领养通知书列表
     * @author: xugy
     * @date: 2014-11-2下午4:01:46
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList findSYZZNoticeList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //开始收文日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //结束收文日期
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //文件类型
        if("99".equals(FILE_TYPE)){
            FILE_TYPE = "FILE_TYPE IN ('20','21','22','23')";
        }else if(!"99".equals(FILE_TYPE) && FILE_TYPE != null){
            FILE_TYPE = "FILE_TYPE='"+FILE_TYPE+"'";
        }
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //开始签批日期
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //结束签批日期
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //开始寄发日期
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //结束寄发日期
        
        String ADOPT_ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode();//当前登录人的收养组织
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZNoticeList", ADOPT_ORG_ID, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, FEMALE_NAME, FILE_TYPE, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME_PINYIN, SIGN_DATE_START, SIGN_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
}
