package com.dcfs.mkr.organesupp;

import hx.ajax.AjaxExecute;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.hx.framework.organ.vo.Organ;
import com.hx.framework.sdk.OrganHelper;

public class AjaxInitOrgan extends AjaxExecute{

	private static Log log =  UtilLog.getLog(AjaxInitOrgan.class);
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn = null;
		OrganSuppHandler handler = new OrganSuppHandler();
        try {
            conn = ConnectionManager.getConnection();
            //{city:[{code:value,organ:[{code:value,name:value},{code2:value,name2:value2},...]},{....}]}
            StringBuffer buffer = new StringBuffer();
            DataList citys = handler.findCitys(conn);
            List<Organ> organs = OrganHelper.getOrgansAll();
            if(citys != null && citys.size() > 0){
            	//{"city":[]}
            	buffer.append("{\"city\":[");
            	for (int i = 0; i < citys.size(); i++) {
            		Data city = (Data) citys.get(i);
            		String cityCode = city.getString("CODEVALUE");
            		//{"code":"codeValue"}或{"code":"codeValue"},
            		buffer.append("{\"code\":\"").append(cityCode).append("\"");
            		if(organs != null && organs.size() > 0){
            			//,organ:[{code:value,name:value},{code2:value,name2:value2},...]
            			//,"organ":[]
            			buffer.append(",\"organ\":").append("[");
            			boolean f = false;
                		for (int j = 0; j < organs.size(); j++) {
                			Organ organ = organs.get(j);
        					if(organ.getOrgType() == 5 && organ.getOrgCode() != null && !"".equals(organ.getOrgCode()) && organ.getOrgCode().startsWith(cityCode.substring(0,2))){
        						f = true;
        						//{"code":"codeValue","name":"nameValue"},
        						buffer.append("{\"code\":\"").append(organ.getOrgCode()).append("\",\"name\":\"").append(organ.getCName()).append("\"},");
        					}
						}
                		if(f){
                			int las = buffer.lastIndexOf(",");
                    		if(las != -1){
                    			buffer.delete(las, buffer.length());
                    		}
                		}
                		buffer.append("]");
                    }
            		if(i == (citys.size() - 1)){
            			buffer.append("}");
            		}else{
            			buffer.append("},");
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

	public static void main(String[] args) {
		StringBuffer b = new StringBuffer();
		b.append("123456789");
		System.out.println(b.lastIndexOf(","));
		b.delete(b.lastIndexOf(","), b.length());
		System.out.println(b.toString());
	}
}
