package com.dcfs.mkr.organesupp;

import hx.ajax.AjaxExecute;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public class AjaxInitCity extends AjaxExecute{

	private static Log log =  UtilLog.getLog(AjaxInitCity.class);
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn = null;
		OrganSuppHandler handler = new OrganSuppHandler();
        try {
            conn = ConnectionManager.getConnection();
            //{name:value,name1:value1,...}
            StringBuffer buffer = new StringBuffer();
            DataList citys = handler.findCitys(conn);
            if(citys != null && citys.size() > 0){
            	buffer.append("{\"city\":[");
            	for (int i = 0; i < citys.size(); i++) {
					Data city = (Data) citys.get(i);
					if(i == (citys.size() - 1)){
						buffer.append("{\"code\":\"").append(city.getString("CODEVALUE")).append("\",\"name\":\"").append(city.getString("CODENAME")).append("\"}");
					}else{
						buffer.append("{\"code\":\"").append(city.getString("CODEVALUE")).append("\",\"name\":\"").append(city.getString("CODENAME")).append("\"}").append(",");	
					}
				}
            	buffer.append("]}");
            }
            //System.out.println(buffer.toString());
            setReturnValue(buffer.toString());
        } catch (Exception e) {
            log.logError("获取数据出现异常:" + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭", e);
                    }
                }
            }
        }
		return true;
	}

}
