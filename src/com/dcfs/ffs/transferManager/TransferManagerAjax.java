package com.dcfs.ffs.transferManager;


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
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

public class TransferManagerAjax extends AjaxExecute {

	private static Log log = UtilLog.getLog(TransferManagerAjax.class);
	
	private DBTransaction dt = null;//事务处理
	
	public boolean run(HttpServletRequest request) {
	    Connection conn = null;
	    TransferManagerHandler transferManagerHandler = new TransferManagerHandler();
		//获取页面选择的移交文件列表    	
	    String TI_ID = request.getParameter("TI_ID");
    	String chioceuuid = request.getParameter("uuid");
		String[] uuid = chioceuuid.split("#");
		
		try {
		    conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=0;i<uuid.length;i++){
                Data TIDdata = new Data();
                TIDdata.add("TID_ID", uuid[i]);//交接明细ID
                TIDdata.add("TI_ID", TI_ID);//交接单ID
                TIDdata.add("TRANSFER_STATE", "1");//交接状态
                transferManagerHandler.saveTransferInfoDetail(conn, TIDdata);
            }
            Data searchData = transferManagerHandler.TransferEdit(conn, TI_ID);
            int COPIES = searchData.getInt("COPIES");
            Data TIdata = new Data();
            TIdata.add("TI_ID", TI_ID);//交接单ID
            TIdata.add("COPIES", COPIES + uuid.length);//份数
            transferManagerHandler.saveTransferInfo(conn, TIdata);
            dt.commit();
            this.setReturnValue("1");
		} catch (DBException e) {
		  //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
        } catch (SQLException e) {
          //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
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
		//获取页面查询到的文件列表DataList		
		/*HttpSession session =request.getSession();
		DataList dList=(DataList)session.getAttribute("Transfer_new_Mannual_List");
		
		//对比页面查询结果集与选择结果集，获取用户选择选择的移交文件
		//结果list
		DataList resList=(DataList)session.getAttribute("Transfer_Detail_DataList");
		if(resList==null){
			resList=new DataList();
		}
		DataList addlist=new DataList();
		
		//获取页面选择的数据
		for(int i=0;i<uuid.length;i++){
			for(int j=0;j<dList.size();j++){
				Data data=dList.getData(j);
				if(uuid[i]!=null&&uuid[i].equals(data.get("TID_ID"))){
					addlist.add(data);
				}
			}
		}
		//去掉重复选择
		for(int i=0;i<addlist.size();i++){
			for(int j=0;j<resList.size();j++){
				if(addlist.size()!=0&&addlist.getData(i).getString("TID_ID").equals(resList.getData(j).getString("TID_ID"))){
					addlist.remove(i);
				}
			}
		}
		for(int i=0;i<addlist.size();i++){
			resList.add(addlist.getData(i));
		}
		session.setAttribute("Transfer_Detail_DataList", resList);
		Data data=new Data();
		data.add("flag", true);
		JSONObject json =JSONObject.fromObject(data);
		setReturnValue(json.toString());*/
        
	}
	
	

}
