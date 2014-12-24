package com.dcfs.fam.billRegistration;


import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;
import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

public class BillRegistrationAjax2 extends AjaxExecute {

	private static Log log = UtilLog.getLog(BillRegistrationAjax2.class);
	public boolean run(HttpServletRequest request) {
		Connection conn=null;
		BillRegistrationHandler handler = new BillRegistrationHandler();
		HttpSession session =request.getSession();
		
		//获取页面选择的文件列表    	
    	String choiceuuid = request.getParameter("uuid");
		String[] uuid = choiceuuid.split("#");
		
		//结果list
		DataList resList=(DataList)session.getAttribute("fileList");
		if(resList==null){
			resList=new DataList();
		}
		DataList addlist=new DataList();
		
		//获取页面选择的数据
		for(int i=0;i<uuid.length;i++){
			for(int j=0;j<resList.size();j++){
				Data data=resList.getData(j);
				if(uuid[i]!=null&&uuid[i].equals(data.get("AF_ID"))){
					addlist.add(data);
				}
			}
		}
		
		//移除原列表中选择的数据
		for(int i=0;i<resList.size();i++){
			for(int j=0;j<addlist.size();j++){
				if(addlist.size()!=0&&addlist.getData(j).getString("AF_ID").equals(resList.getData(i).getString("AF_ID"))){
					resList.remove(i);
				}
			}
		}
		
		session.setAttribute("fileList", resList);
		Data data=new Data();
		data.add("flag", true);
		JSONObject json =JSONObject.fromObject(data);
		setReturnValue(json.toString());
		
		//清空选中文件表里的缴费编号
		try {
			conn = ConnectionManager.getConnection();
			handler.updateData(conn, uuid);
		} catch (Exception e){
			if (log.isError()) {
				log.logError("BillRegistrationAjax2操作异常:" + e.getMessage(), e);
			}
			e.printStackTrace();
		}finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("BillRegistrationAjax2的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return true;
	}
	
	

}
