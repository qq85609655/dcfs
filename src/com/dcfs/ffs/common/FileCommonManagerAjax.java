package com.dcfs.ffs.common;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;



import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

/**
 * �ļ�������Ajax������
 * @author mayun
 * @date 2014-7-24
 * @version 1.0
 */
public class FileCommonManagerAjax extends AjaxExecute {

	private static Log log = UtilLog.getLog(FileCommonManagerAjax.class);
	FileCommonManagerHandler handler=new FileCommonManagerHandler();
	@Override
	public boolean run(HttpServletRequest request) {
		Connection conn = null;
		DBTransaction dt = null;
		boolean returnFlag = true;
		String method=ServletTools.getParameter("method", request, "");
		String countryCode=ServletTools.getParameter("countryCode", request, "");//���Ҵ���
		String fileNo=ServletTools.getParameter("fileNo", request, "");//���ı��
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			DataList dl= new DataList();
			Data data = new Data();
			if(method.equals("findSyzzNameList")){//�õ�������֯����LIST
				dl = this.findSyzzNameList(conn,countryCode);
				JSONArray json = JSONArray.fromObject(dl);
				setReturnValue(json.toString());
			}else if(method.equals("getFileInfo")){//��ȡ�����ļ�������Ϣ
				data = this.getFileInfo(fileNo, conn);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}else if(method.equals("getAfCost")){//�����ļ����ͻ�ȡӦ�ɷ���
				String file_type=ServletTools.getParameter("file_type", request, "");//�ļ�����
				data = this.getAfCost(conn, file_type);
				JSONObject json = JSONObject.fromObject(data);
				setReturnValue(json.toString());
			}
			//dt.commit();
		} catch (Exception e) {
			try {
				dt.rollback();
				returnFlag=false;
				setReturnValue("FileCommonManagerAjax�쳣,����ϵ����Ա");
			} catch (SQLException e1) {
				e1.printStackTrace();
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
                        log.logError("FileCommonManagerAjax��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		
		return returnFlag;
	}
	
	
	/**
	 * ���ݹ��Ҵ���õ�������֯����List
	 * @param conn
	 * @return
	 */
	public DataList findSyzzNameList(Connection conn,String countryCode){
		DataList dl = new DataList();
		try {
			dl = handler.getSyzzNameListByCodeTable(conn,countryCode);
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
                        log.logError("FileCommonManagerAjax��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		return dl;
	}
	
	/**
	 * �������ı�Ż�ȡ�����ļ�������Ϣ
	 * @description 
	 * @author MaYun
	 * @date Aug 6, 2014
	 * @param Connection conn ���ݿ����ӳأ��Ǳ������
	 * @param Stirng fileNO ���ı�ţ��������
	 * @return Data fileData
	 */
	public Data getFileInfo(String fileNO,Connection conn){
		Data data = new Data();
		try {
			data = handler.getFileInfo(fileNO, conn);
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
                        log.logError("FileCommonManagerAjax��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		return data;
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: getAfCost 
	 * @Description: �����ļ����ͻ�ȡ�ļ�Ӧ�ɷ���
	 * @author: yangrt
	 * @param conn
	 * @param file_type
	 * 		"ZCWJFWF" : 800
	 * 		"TXWJFWF" : 500
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public Data getAfCost(Connection conn,String file_type){
		Data data = new Data();
		try {
			data = handler.getAfCost(conn,file_type);
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
                        log.logError("FileCommonManagerAjax��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
		return data;
	}
	



	
}



