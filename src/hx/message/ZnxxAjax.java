package hx.message;

import hx.ajax.AjaxExecute;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

public class ZnxxAjax extends AjaxExecute {
	private static Log log = UtilLog.getLog(ZnxxAjax.class);
	@Override
	public boolean run(HttpServletRequest request) {
		UserInfo userInfo = SessionInfo.getCurUser();
		String PERSON_ID =userInfo.getPerson().getPersonId();
		MessageHandler handler = new MessageHandler();
		Connection conn=null;
		try {
			conn = ConnectionManager.getConnection();
			DataList list = handler.znxxAjaxList(conn,PERSON_ID);
			if(list==null||list.size()==0){
				setReturnValue("");
			}else{
				setReturnValue(list);
			}
			return true;
		} catch (Exception e) {
			log.logError("ZnxxAjax.run()出错:" + e);
			return false;
		}finally{
			if (conn != null) {
	            try {
	                if (!conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                if (log.isError()) {
	                    log.logError("ZnxxAjax.run()的Connection因出现异常，未能关闭"+e.getMessage());
	                }
	            }
	        }
		}
	}
}
