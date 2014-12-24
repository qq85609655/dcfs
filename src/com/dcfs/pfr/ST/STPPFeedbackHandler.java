package com.dcfs.pfr.ST;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

public class STPPFeedbackHandler extends BaseHandler {
    /**
     * 
     * @Title: findSTPPFeedbackList
     * @Description: ʡ���鿴�б�
     * @author: xugy
     * @date: 2014-10-23����10:20:50
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findSTPPFeedbackList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //��ѯ����
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯
        String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ
        
        String provinceCode = SessionInfo.getCurUser().getCurOrgan().getParentOrgan().getOrgCode();
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSTPPFeedbackList", provinceCode, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, WELFARE_NAME_CN, NAME, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
