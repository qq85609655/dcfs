package com.dcfs.pfr.FLY;

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
 * @Title: FLYPPFeedbackHandler.java
 * @Description: 福利院报告查看
 * @Company: 21softech
 * @Created on 2014-10-23 上午11:28:39
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FLYPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findFLYPPFeedbackList
     * @Description: 福利院报告查看列表
     * @author: xugy
     * @date: 2014-10-23下午2:10:22
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findFLYPPFeedbackList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //儿童
        
        String organCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findFLYPPFeedbackList", organCode, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getFeedbackRecordInfo
     * @Description: 安置后报告信息
     * @author: xugy
     * @date: 2014-11-5上午11:00:42
     * @param conn
     * @param FEEDBACK_ID
     * @return
     * @throws DBException 
     */
    public DataList getFeedbackRecordInfo(Connection conn, String FEEDBACK_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getFeedbackRecordInfo", FEEDBACK_ID);
        DataList dl = ide.find(sql);
        return dl;
    }

}
