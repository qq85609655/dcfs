package com.dcfs.pfr.DAB;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
/**
 * 
 * @Title: DABPPFeedbackHandler.java
 * @Description: 档案部安置后报告反馈
 * @Company: 21softech
 * @Created on 2014-10-10 下午5:24:19
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class DABPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findDABPPFeedbackReceiveList
     * @Description: 反馈接受
     * @author: xugy
     * @date: 2014-10-11下午1:45:42
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackReceiveList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //档案号
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //姓名拼音
        String CHILD_NAME_EN = data.getString("CHILD_NAME_EN", null);   //入籍姓名
        String NUM = data.getString("NUM", null);   //次第数
        String REPORT_DATE_START = data.getString("REPORT_DATE_START", null);   //开始上报日期
        String REPORT_DATE_END = data.getString("REPORT_DATE_END", null);   //结束上报日期
        String RECEIVE_STATE = data.getString("RECEIVE_STATE", null);   //接收状态
        String RECEIVE_USERNAME = data.getString("RECEIVE_USERNAME", null);   //接收人
        String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START", null);   //开始接收日期
        String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END", null);   //结束接收日期
        String REPORT_STATE = data.getString("REPORT_STATE", "");   //报告状态
        if("".equals(REPORT_STATE)){
            REPORT_STATE = "REPORT_STATE<>'0'";
        }else{
            REPORT_STATE = "REPORT_STATE='"+REPORT_STATE+"'";
        }
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackReceiveList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, NAME_PINYIN, CHILD_NAME_EN, NUM, REPORT_DATE_START, REPORT_DATE_END, RECEIVE_STATE, RECEIVE_USERNAME, RECEIVE_DATE_START, RECEIVE_DATE_END, REPORT_STATE, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 文件移交提供接口
     * @Title: PFRFeedbackrecordSave
     * @Description: 批量修改数据
     * @author: xugy
     * @date: 2014-10-11下午3:40:37
     * @param conn
     * @param datalist 
     * @param FB_REC_ID数据主键    档案部到翻译公司 （报告状态）REPORT_STATE='3' （翻译状态）TRANSLATION_STATE='0'  翻译公司到档案部 （报告状态）REPORT_STATE='6' （审核状态）ADUIT_STATE='0'
     * @throws DBException
     */
    public void PFRFeedbackrecordSave(Connection conn, DataList datalist) throws DBException {
        for(int i=0;i<datalist.size();i++){
            datalist.getData(i).setConnection(conn);
            datalist.getData(i).setEntityName("PFR_FEEDBACK_RECORD");
            datalist.getData(i).setPrimaryKey("FB_REC_ID");
        }
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.batchStore(datalist);
    }
    /**
     * 
     * @Title: findDABPPFeedbackReplaceList
     * @Description: 代录列表
     * @author: xugy
     * @date: 2014-10-14下午6:14:38
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackReplaceList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //档案号
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //姓名拼音
        String CHILD_NAME_EN = data.getString("CHILD_NAME_EN", null);   //入籍姓名
        String NUM = data.getString("NUM", null);   //次第数
        String REG_USERNAME = data.getString("REG_USERNAME", null);   //录入人
        String REG_DATE_START = data.getString("REG_DATE_START", null);   //开始录入日期
        String REG_DATE_END = data.getString("REG_DATE_END", null);   //结束录入日期
        String REPORT_STATE = data.getString("REPORT_STATE", null);   //报告状态
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackReplaceList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, NAME_PINYIN, CHILD_NAME_EN, NUM, REG_USERNAME, REG_DATE_START, REG_DATE_END, REPORT_STATE, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findDABPPFeedbackAuditList
     * @Description: 报告审核列表
     * @author: xugy
     * @date: 2014-10-14下午2:48:36
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackAuditList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //档案号
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String NUM = data.getString("NUM", null);   //次第数
        String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START", null);   //开始接收日期
        String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END", null);   //儿结束接收日期
        String AUDIT_USERNAME = data.getString("AUDIT_USERNAME", null);   //审核人
        String AUDIT_DATE_START = data.getString("AUDIT_DATE_START", null);   //开始审核日期
        String AUDIT_DATE_END = data.getString("AUDIT_DATE_END", null);   //结束审核日期
        String ADUIT_STATE = data.getString("ADUIT_STATE", null);   //审核状态
        
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackAuditList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, NUM, RECEIVE_DATE_START, RECEIVE_DATE_END, AUDIT_USERNAME, AUDIT_DATE_START, AUDIT_DATE_END, ADUIT_STATE, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * 
     * @Title: getFeedbackAdditonalInfo
     * @Description: 获取补充文件信息
     * @author: xugy
     * @date: 2014-10-21下午8:12:29
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException 
     */
    public Data getFeedbackAdditonalInfo(Connection conn, String FB_REC_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackAdditonalInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getFeedbackShowInfo
     * @Description: 安置后报告查看信息
     * @author: xugy
     * @date: 2014-11-4下午4:53:35
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackShowInfo(Connection conn, String FEEDBACK_ID) throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackShowInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    public Data getFeedbackRecordInfo(Connection conn, String FEEDBACK_ID, String NUM) throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackRecordInfo", FEEDBACK_ID, NUM);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: getDABCatalogInfo
     * @Description: 涉外收养档案案卷内目录（二）
     * @author: xugy
     * @date: 2014-11-4上午10:28:22
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public Data getDABCatalogInfo(Connection conn, String FEEDBACK_ID) throws DBException{
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getDABCatalogInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findDABPPFeedbackReminderList
     * @Description: 报告催交
     * @author: xugy
     * @date: 2014-10-23下午4:17:51
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackReminderList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //档案号
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String NUM = data.getString("NUM", null);   //次第数
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //开始签批日期
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //结束签批日期
        String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);   //开始登记日期
        String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);   //结束登记日期
        String LIMIT_DATE_START = data.getString("LIMIT_DATE_START", null);   //开始递交期限
        String LIMIT_DATE_END = data.getString("LIMIT_DATE_END", null);   //结束递交期限
        String REMINDERS_DATE_START = data.getString("REMINDERS_DATE_START", null);   //开始催交日期
        String REMINDERS_DATE_END = data.getString("REMINDERS_DATE_END", null);   //结束催交日期
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackReminderList", ARCHIVE_NO, FILE_NO, SIGN_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_NAME_CN, NAME, NUM, SIGN_DATE_START, SIGN_DATE_END, ADREG_DATE_START, ADREG_DATE_END, LIMIT_DATE_START, LIMIT_DATE_END, REMINDERS_DATE_START, REMINDERS_DATE_END, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 安置后反馈报告催缴
     * @Title: getFeedbackReminderInfoData
     * @Description: 
     * @author: xugy
     * @date: 2014-12-5上午11:25:47
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException 
     */
    public Data getFeedbackReminderInfo(Connection conn, String FB_REC_ID) throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackReminderInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: findDABPPFeedbackSearchList
     * @Description: 档案部安置后报告反馈查询列表
     * @author: xugy
     * @date: 2014-10-10下午5:26:50
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABPPFeedbackSearchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //档案号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //开始签批日期
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //结束签批日期
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String CHILD_NAME_EN = data.getString("CHILD_NAME_EN", null);   //入籍姓名
        String SEX = data.getString("SEX", null);   //性别
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束出生日期
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABPPFeedbackSearchList", ARCHIVE_NO, SIGN_NO, SIGN_DATE_START, SIGN_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, CHILD_NAME_EN, SEX, CHILD_TYPE, BIRTHDAY_START, BIRTHDAY_END, compositor, ordertype);
        
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getFeedbackRecordInfo
     * @Description: 档案部查看安置后反馈报告
     * @author: xugy
     * @date: 2014-12-1下午4:23:13
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public DataList getFeedbackInfo(Connection conn, String FEEDBACK_ID) throws DBException{
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getFeedbackRecordStateInfo
     * @Description: 安置后反馈报告状态
     * @author: xugy
     * @date: 2014-12-7下午4:53:37
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException
     */
    public DataList getFeedbackRecordStateInfo(Connection conn, String FEEDBACK_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackRecordStateInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
}
