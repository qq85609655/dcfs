package com.dcfs.ncm.BGSnotice;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: BGSNoticeHandler.java
 * @Description: 办公室通知书办理--打印寄发
 * @Company: 21softech
 * @Created on 2014-9-15 下午4:50:29
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class BGSNoticeHandler extends BaseHandler {
    /**
     * 
     * @Title: findBGSNoticePrintList
     * @Description: 办公室通知书办理打印寄发列表
     * @author: xugy
     * @date: 2014-9-15下午4:55:55
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findBGSNoticePrintList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //开始收文日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //结束收文日期
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //文件类型
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String SIGN_SUBMIT_DATE_START = data.getString("SIGN_SUBMIT_DATE_START", null);   //开始报批日期
        String SIGN_SUBMIT_DATE_END = data.getString("SIGN_SUBMIT_DATE_END", null);   //结束报批日期
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //开始签批日期
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //结束签批日期
        String NOTICE_SIGN_DATE_START = data.getString("NOTICE_SIGN_DATE_START", null);   //开始落款日期
        String NOTICE_SIGN_DATE_END = data.getString("NOTICE_SIGN_DATE_END", null);   //结束落款日期
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //开始通知日期
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //结束通知日期
        String NOTICE_STATE = data.getString("NOTICE_STATE", "");   //通知状态
        if("".equals(NOTICE_STATE)){
            NOTICE_STATE = "NOTICE_STATE='0'";
        }else if("9".equals(NOTICE_STATE)){
            NOTICE_STATE = "(NOTICE_STATE='0' or NOTICE_STATE='1')";
        }else{
            NOTICE_STATE = "NOTICE_STATE='"+NOTICE_STATE+"'";
            
        }
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findBGSNoticePrintList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END,SIGN_SUBMIT_DATE_START,SIGN_SUBMIT_DATE_END, SIGN_DATE_START, SIGN_DATE_END, NOTICE_SIGN_DATE_START, NOTICE_SIGN_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, NOTICE_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getNoticeInfo
     * @Description: 通知书摘要信息
     * @author: xugy
     * @date: 2014-9-16下午3:10:02
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getNoticeInfo(Connection conn, String MI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNoticeInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getArchiveSaveInfo
     * @Description: 获取涉外收养档案信息数据
     * @author: xugy
     * @date: 2014-9-25下午8:57:17
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getArchiveSaveInfo(Connection conn, String MI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getArchiveSaveInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getArchiveId
     * @Description: 根据匹配信息ID查找档案ID
     * @author: xugy
     * @date: 2014-11-10下午9:13:01
     * @param conn
     * @param string
     * @return 
     * @throws DBException 
     */
    public Data getArchiveId(Connection conn, String MI_ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getArchiveId", MI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
        
    }
    /**
     * 
     * @Title: getAttInfo
     * @Description: 生成附件要判断的信息
     * @author: xugy
     * @date: 2014-11-11下午1:33:38
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getAttInfo(Connection conn, String MI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAttInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getPrintInfoId
     * @Description: 获取需要打印的数据的ID
     * @author: xugy
     * @date: 2014-11-13下午1:58:18
     * @param conn
     * @return
     * @throws DBException 
     */
    public DataList getPrintInfoId(Connection conn, String order) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getPrintInfoId", order);
        DataList dl = ide.find(sql);
        return dl;
    }
    public DataList getIdInId(Connection conn, String id, String order) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getIdInId", id, order);
        DataList dl = ide.find(sql);
        return dl;
    }

}
