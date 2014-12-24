package com.dcfs.ffs.transferManager;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;


/** 
 * @ClassName: TransferManagerAjax2 
 * @Description: TODO(这里用一句话描述这个类的作用) 
 * @author mayun;
 * @date 2014-9-4 上午11:16:14 
 *  
 */
public class TransferManagerAjax2 extends AjaxExecute {
	
	private static Log log = UtilLog.getLog(TransferManagerAjax2.class);

	TransferManagerHandler handler=new TransferManagerHandler();
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn = null;
		DBTransaction dt = null;
		boolean returnFlag = true;
		String method=ServletTools.getParameter("method", request, "");
		
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			DataList dl= new DataList();
			Data data = new Data();
			if(method.equals("isFilePause")){//收养文件是否暂停
				String TID_IDS=ServletTools.getParameter("TID_IDS", request, "");//交接明细IDS
				String[] tidArray = TID_IDS.split("##");
				data = this.isFilePause(conn,tidArray);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}
		} catch (Exception e) {
			returnFlag=false;
			setReturnValue("TransferManagerAjax2异常,请联系管理员");
			e.printStackTrace();
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAjax2的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		
		return returnFlag;
	}
	
	
	/**
	 * 根据交接明细ID获得对应收养文件的暂停标志
	 * @param TID_ID 交接明细主键IDS 
	 * @return Data IS_PAUSE 0：未暂停 1：已暂停   FILE_NO：收文编号
	 */
	public Data isFilePause(Connection conn,String[] tidArray){
		Data data = new Data();
		String is_pause="";
		try {
			for(int i=0;i<tidArray.length;i++){
				data= handler.getFilePauseStatusByTIDID(conn,tidArray[i]);
				is_pause = data.getString("IS_PAUSE");
				if("".equals(is_pause)||null==is_pause){
					is_pause="0";
				}else if("1".equals(is_pause)||"1"==is_pause){
					break;
				}
			}
			
			data.addString("IS_PAUSE", is_pause);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAjax2的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		return data;
	}
}
