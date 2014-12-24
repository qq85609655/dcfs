package com.dcfs.ncm.STnotice;

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
 * @Title: STNoticeHandler.java
 * @Description: 省厅送养通知书
 * @Company: 21softech
 * @Created on 2014-11-8 下午5:01:20
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class STNoticeHandler extends BaseHandler {
    /**
     * 
     * @Title: findSTNoticeList
     * @Description: 省厅送养通知书列表
     * @author: xugy
     * @date: 2014-11-8下午5:05:31
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSTNoticeList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String SIGN_NO = data.getString("SIGN_NO",null);   //通知书编号
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //开始签批日期
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //结束签批日期
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //开始通知日期
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //结束通知日期
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男收养人
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女收养人
        String CHILD_TYPE = data.getString("CHILD_TYPE",null);   //儿童类型
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        
        String provinceCode = SessionInfo.getCurUser().getCurOrgan().getParentOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSTNoticeList",provinceCode,SIGN_NO,SIGN_DATE_START,SIGN_DATE_END,NOTICE_DATE_START,NOTICE_DATE_END,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,CHILD_TYPE,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
