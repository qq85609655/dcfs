package com.dcfs.ncm.audit;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.dcfs.cms.childManager.ChildGlobalStatusAndPositionConstant;
import com.dcfs.ncm.MatchHandler;
/**
 * 
 * @Title: AjaxJudgeCIPosition.java
 * @Description: �жϲ���λ��
 * @Company: 21softech
 * @Created on 2014-12-17 ����5:46:55
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AjaxJudgeCIPosition extends AjaxExecute {
    
    private static Log log = UtilLog.getLog(AjaxJudgeCIPosition.class);

    @Override
    public boolean run(HttpServletRequest request) {
        Connection conn = null;
        MatchAuditHandler matchAuditHandler = new MatchAuditHandler();
        MatchHandler matchHandler = new MatchHandler();
        String CI_ID = (String) request.getParameter("CI_ID");
        try {
            conn = ConnectionManager.getConnection();
            Data data = matchHandler.getCIInfoOfCiId(conn, CI_ID);
            String MAIN_CI_ID = data.getString("MAIN_CI_ID");//��ͯ��ID
            DataList dl = matchAuditHandler.getCIPosition(conn, MAIN_CI_ID);//ͬ����ͯ��λ��
            String rv = "1";
            if(dl.size()>0){
                for(int i=0;i<dl.size();i++){
                    String CI_POSITION = dl.getData(i).getString("CI_POSITION");//��ͯ����λ��
                    if(!(ChildGlobalStatusAndPositionConstant.POS_AZB).equals(CI_POSITION)){
                        rv = "0";
                    }
                }
            }
            
            this.setReturnValue(rv);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�", e);
                    }
                }
            }
        }
        return true;
    }
}
