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
 * @Description: ���ú󱨸淴��
 * @Company: 21softech
 * @Created on 2014-10-24 ����4:57:59
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: savePfrFeedbackInfo
     * @Description: ���ú󱨸���Ϣ����
     * @author: xugy
     * @date: 2014-10-24����5:12:47
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
     * @Description: ���ú󱨸��¼����
     * @author: xugy
     * @date: 2014-10-24����5:12:29
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
     * @Description: ���ú󱨸油����Ϣ����
     * @author: xugy
     * @date: 2014-10-24����5:23:42
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
     * @Description: ���ú󱨸���˼�¼����
     * @author: xugy
     * @date: 2014-10-24����5:28:51
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
     * @Description: ���ú󱨸淭���¼����
     * @author: xugy
     * @date: 2014-10-24����5:32:25
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
     * @Description: �԰��ú󱨸��¼��PFR_FEEDBACK_RECORD��Ϊ������ȡ������Ϣ
     * @author: xugy
     * @date: 2014-10-24����5:47:45
     * @param conn
     * @param FB_REC_ID
     * @return data
     * @throws DBException
     */
    public Data getFeedbackInfo(Connection conn, String FB_REC_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getCIInfo
     * @Description: ��ͯ��Ϣ
     * @author: xugy
     * @date: 2014-10-26����11:02:58
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException
     */
    public Data getCIInfo(Connection conn, String CI_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIInfo", CI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getAFInfo
     * @Description: ��������Ϣ
     * @author: xugy
     * @date: 2014-10-26����11:42:54
     * @param conn
     * @param AF_ID
     * @return
     * @throws DBException 
     */
    public Data getAFInfo(Connection conn, String AF_ID) throws DBException {
      //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAFInfo", AF_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackRecordInfo
     * @Description: ���ú󱨸��¼��Ϣ
     * @author: xugy
     * @date: 2014-10-26����5:24:57
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackRecordInfo(Connection conn, String FB_REC_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackRecordInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: getFeedbackTransferInfo
     * @Description: ���ú󱨸��ƽ���Ϣ
     * @author: xugy
     * @date: 2014-11-27����10:22:55
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackTransferInfo(Connection conn, String FB_REC_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackTransferInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: getFeedbackAuditInfo
     * @Description: �԰��ú󱨸���˼�¼��PFR_FEEDBACK_AUDIT��Ϊ������ȡ������Ϣ
     * @author: xugy
     * @date: 2014-10-26����5:29:51
     * @param conn
     * @param FB_A_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackAuditInfo(Connection conn, String FB_A_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackAuditInfo", FB_A_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackTranslationInfo
     * @Description: �԰��ú󱨸淭���¼��PFR_FEEDBACK_TRANSLATION��Ϊ������ȡ������Ϣ
     * @author: xugy
     * @date: 2014-10-27����9:44:39
     * @param conn
     * @param FB_T_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackTranslationInfo(Connection conn, String FB_T_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackTranslationInfo", FB_T_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackAdditonalInfo
     * @Description: �԰��ú󱨸油����Ϣ��PFR_FEEDBACK_ADDITONAL��Ϊ������ȡ������Ϣ
     * @author: xugy
     * @date: 2014-10-27����8:16:05
     * @param conn
     * @param FB_ADD_ID
     * @return
     * @throws DBException
     */
    public Data getFeedbackAdditonalInfo(Connection conn, String FB_ADD_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackAdditonalInfo", FB_ADD_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getLastReportDate
     * @Description: �ϴΰ��÷�������
     * @author: xugy
     * @date: 2014-10-27����8:57:59
     * @param conn
     * @param FEEDBACK_ID
     * @param NUM
     * @return
     * @throws DBException
     */
    public String getLastReportDate(Connection conn, String FEEDBACK_ID, String NUM) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getLastReportDate", FEEDBACK_ID, NUM);
        DataList dl = ide.find(sql);
        return dl.getData(0).getString("REPORT_DATE", "");
    }
    
    public Data getfeedbackAdditonaShowlInfo(Connection conn, String FB_ADD_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getfeedbackAdditonaShowlInfo", FB_ADD_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getFeedbackHomePageInfo
     * @Description: ���ú󱨸���ҳ��Ϣ
     * @author: xugy
     * @date: 2014-11-5����1:38:07
     * @param conn
     * @param FB_REC_ID
     * @return
     * @throws DBException 
     */
    public Data getFeedbackHomePageInfo(Connection conn, String FB_REC_ID) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackHomePageInfo", FB_REC_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
}
