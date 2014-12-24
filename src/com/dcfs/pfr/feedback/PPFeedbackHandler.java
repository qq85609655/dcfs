package com.dcfs.pfr.feedback;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: PPFeedbackHandler.java
 * @Description: 安置后报告反馈
 * @Company: 21softech
 * @Created on 2014-10-24 下午4:57:59
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: savePfrFeedbackInfo
     * @Description: 安置后报告信息保存
     * @author: xugy
     * @date: 2014-10-24下午5:12:47
     * @param conn
     * @param data
     * @return data
     * @throws DBException
     */
    public Data savePfrFeedbackInfo(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("PFR_FEEDBACK_INFO");
        dataadd.setPrimaryKey("FEEDBACK_ID");
        if("".equals(dataadd.getString("FEEDBACK_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * 
     * @Title: savePfrFeedbackRecord
     * @Description: 安置后报告记录保存
     * @author: xugy
     * @date: 2014-10-24下午5:12:29
     * @param conn
     * @param data
     * @return data
     * @throws DBException
     */
    public Data savePfrFeedbackRecord(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("PFR_FEEDBACK_RECORD");
        dataadd.setPrimaryKey("FB_REC_ID");
        if("".equals(dataadd.getString("FB_REC_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * 
     * @Title: savePfrFeedbackAdditonal
     * @Description: 安置后报告补充信息保存
     * @author: xugy
     * @date: 2014-10-24下午5:23:42
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data savePfrFeedbackAdditonal(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("PFR_FEEDBACK_ADDITONAL");
        dataadd.setPrimaryKey("FB_ADD_ID");
        if("".equals(dataadd.getString("FB_ADD_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * 
     * @Title: savePfrFeedbackAudit
     * @Description: 安置后报告审核记录保存
     * @author: xugy
     * @date: 2014-10-24下午5:28:51
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data savePfrFeedbackAudit(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("PFR_FEEDBACK_AUDIT");
        dataadd.setPrimaryKey("FB_A_ID");
        if("".equals(dataadd.getString("FB_A_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * 
     * @Title: savePfrFeedbackTranslation
     * @Description: 安置后报告翻译记录保存
     * @author: xugy
     * @date: 2014-10-24下午5:32:25
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data savePfrFeedbackTranslation(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("PFR_FEEDBACK_TRANSLATION");
        dataadd.setPrimaryKey("FB_T_ID");
        if("".equals(dataadd.getString("FB_T_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
    }
    /**
     * 
     * @Title: getFeedbackShowInfo
     * @Description: 以安置后报告记录表（PFR_FEEDBACK_RECORD）为主表，获取报告信息
     * @author: xugy
     * @date: 2014-10-24下午5:47:45
     * @param conn
     * @param FB_REC_ID
     * @return data
     * @throws DBException
     */
    public Data getFeedbackInfo(Connection conn, String FB_REC_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getCIInfo
     * @Description: 儿童信息
     * @author: xugy
     * @date: 2014-10-26上午11:02:58
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException
     */
    public Data getCIInfo(Connection conn, String CI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIInfo", CI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getAFInfo
     * @Description: 收养人信息
     * @author: xugy
     * @date: 2014-10-26上午11:42:54
     * @param conn
     * @param AF_ID
     * @return
     * @throws DBException 
     */
    public Data getAFInfo(Connection conn, String AF_ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAFInfo", AF_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackRecordInfo
     * @Description: 安置后报告记录信息
     * @author: xugy
     * @date: 2014-10-26下午5:24:57
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackRecordInfo(Connection conn, String FB_REC_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackRecordInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: getFeedbackTransferInfo
     * @Description: 安置后报告移交信息
     * @author: xugy
     * @date: 2014-11-27上午10:22:55
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackTransferInfo(Connection conn, String FB_REC_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackTransferInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: getFeedbackAuditInfo
     * @Description: 以安置后报告审核记录表（PFR_FEEDBACK_AUDIT）为主表，获取报告信息
     * @author: xugy
     * @date: 2014-10-26下午5:29:51
     * @param conn
     * @param FB_A_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackAuditInfo(Connection conn, String FB_A_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackAuditInfo", FB_A_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackTranslationInfo
     * @Description: 以安置后报告翻译记录表（PFR_FEEDBACK_TRANSLATION）为主表，获取报告信息
     * @author: xugy
     * @date: 2014-10-27上午9:44:39
     * @param conn
     * @param FB_T_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackTranslationInfo(Connection conn, String FB_T_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackTranslationInfo", FB_T_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackAdditonalInfo
     * @Description: 以安置后报告补充信息表（PFR_FEEDBACK_ADDITONAL）为主表，获取报告信息
     * @author: xugy
     * @date: 2014-10-27下午8:16:05
     * @param conn
     * @param FB_ADD_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackAdditonalInfo(Connection conn, String FB_ADD_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackAdditonalInfo", FB_ADD_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getLastReportDate
     * @Description: 上次安置反馈日期
     * @author: xugy
     * @date: 2014-10-27下午8:57:59
     * @param conn
     * @param FEEDBACK_ID
     * @param NUM
     * @return
     * @throws DBException
     */
    public String getLastReportDate(Connection conn, String FEEDBACK_ID, String NUM) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getLastReportDate", FEEDBACK_ID, NUM);
        DataList dl = ide.find(sql);
        return dl.getData(0).getString("REPORT_DATE", "");
    }
    
    public Data getfeedbackAdditonaShowlInfo(Connection conn, String FB_ADD_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getfeedbackAdditonaShowlInfo", FB_ADD_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackHomePageInfo
     * @Description: 安置后报告首页信息
     * @author: xugy
     * @date: 2014-11-5下午1:38:07
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException 
     */
    public Data getFeedbackHomePageInfo(Connection conn, String FB_REC_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackHomePageInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
}
