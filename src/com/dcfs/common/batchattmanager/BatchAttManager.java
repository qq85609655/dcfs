package com.dcfs.common.batchattmanager;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.Base64Util;
import hx.util.InfoClueTo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.ffs.translation.FfsAfTranslationHandler;

public class BatchAttManager extends BaseAction {

	private static Log log = UtilLog.getLog(BatchAttManager.class);

	private BatchAttHandler handler;

	private Connection conn = null;// ���ݿ�����

	private String retValue = SUCCESS;
	
	public BatchAttManager(){
        this.handler=new BatchAttHandler();
    } 

	/*
	 * ������������
	 */
	public String BatchAttMaintain() {

		// 1 ��������
		// ҵ����࣬���ļ�����ͯ���ϡ����ú󱨸�
		String bigType = getParameter("bigType", "");
		// ��������ID
		String packID = getParameter("packID", "");
		// ҵ����ϵĸ���packageID
		String packageID = getParameter("packageID", "");
		//ҵ����¼ID
		String IS_EN = getParameter("IS_EN", "false");
		String PATH_ARGS = getParameter("PATH_ARGS", "false");
		
		retValue = "maintain";
		
		// �жϲ����Ƿ���ȷ
		if ("".equals(bigType) || "".equals(packID) || "".equals(packageID)) {
			InfoClueTo clueTo = new InfoClueTo(0, "�����������������������");
			setAttribute("clueTo", clueTo);
			retValue = "error";
			return retValue;
		}
		String entityName = getEntityNamebyBigType(bigType);
		PATH_ARGS = getPathArgs(PATH_ARGS);

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();

			// 3 ִ�����ݿ⴦�����
			// ����С���б�
			DataList attType = this.getAttType(conn, packID);
			if (attType == null) {
				InfoClueTo clueTo = new InfoClueTo(0, "δ���������������ĸ������");
				setAttribute("clueTo", clueTo);
				retValue = "error";
				return retValue;
			}
			// ���������б�
			DataList attData = handler.getAttData(conn, packageID,entityName);
			 
			Map<String, DataList> attMap = getAttMap(attData);
			String xmlstr = this.getUploadParameter(attType);
			setAttribute("afUploadParameter",xmlstr);
			setAttribute("attType", attType);
			setAttribute("attMap", attMap);	
			setAttribute("packageID",packageID);
			setAttribute("ENTITY_NAME",entityName);
			setAttribute("bigType",bigType);
			setAttribute("IS_EN",IS_EN);
			setAttribute("PATH_ARGS",PATH_ARGS);

		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������ȡ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("������ȡ�����쳣[�������]:" + e.getMessage(), e);
			}
			retValue = "error";
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "����Base64ת����������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("����Base64ת����������쳣[������ȡ����]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"BatchAttManager��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}
	
	/*
	 * ���������鿴
	 */
	public String BatchAttView() {

		// 1 ��������
		// ҵ����࣬���ļ�����ͯ���ϡ����ú󱨸�
		String bigType = getParameter("bigType", "");
		// ��������ID
		String packID = getParameter("packID", "");
		// ҵ����ϵĸ���packageID
		String packageID = getParameter("packageID", ""); 
		//ҵ����¼ID
		String IS_EN = getParameter("IS_EN", "false");
		
		retValue = "view";
		
		// �жϲ����Ƿ���ȷ
		if ("".equals(bigType) || "".equals(packID) || "".equals(packageID)) {
			InfoClueTo clueTo = new InfoClueTo(0, "�����������������������");
			setAttribute("clueTo", clueTo);
			retValue = "error";
			return retValue;
		}
		String entityName = getEntityNamebyBigType(bigType);
		
		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();

			// 3 ִ�����ݿ⴦�����
			// ����С���б�
			DataList attType = this.getAttType(conn, packID);
			if (attType == null) {
				InfoClueTo clueTo = new InfoClueTo(0, "δ���������������ĸ������");
				setAttribute("clueTo", clueTo);
				retValue = "error";
				return retValue;
			}
			// ���������б�
			DataList attData = handler.getAttData(conn, packageID,entityName);
			 
			Map<String, DataList> attMap = getAttMap(attData);
			//String xmlstr = this.getUploadParameter(attType);
			//setAttribute("afUploadParameter",xmlstr);
			setAttribute("attType", attType);
			setAttribute("attMap", attMap);	
			setAttribute("packageID",packageID);
			setAttribute("ENTITY_NAME",entityName);
			setAttribute("bigType",bigType);
			setAttribute("IS_EN",IS_EN);

		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������ȡ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("������ȡ�����쳣[�������]:" + e.getMessage(), e);
			}
			retValue = "error";
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "����Base64ת����������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("����Base64ת����������쳣[������ȡ����]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"BatchAttManager��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
     *������С�๹�츽���б���
     * @param DataList dl �����������
     * @return map<String smalltype;,datalist:dData> 
     *  smalltype:����С�����
	 *  datalist:�����������
     */
	private Map<String, DataList> getAttMap(DataList dl) {
		if (dl == null) {
			return null;
		}
		Map<String, DataList> mapAtt = new HashMap<String, DataList>();
		String smalltype = "NAN";
		DataList ddl = new DataList();
		int count = 0;

		for (int i = 0; i < dl.size(); i++) {
			count++;
			Data d = dl.getData(i);
			String s = d.getString("SMALL_TYPE");

			if (!(s.equals(smalltype))) {
				if (i != 0) {
					mapAtt.put(smalltype, ddl);
					ddl = new DataList();
				}
				smalltype = s;
			}
			ddl.add(d);
		}
		mapAtt.put(smalltype, ddl);
		return mapAtt;
	}
	/**
	 *���ݸ��������ø���������
	 * @param bigType
	 * @return
	 */
	private String getEntityNamebyBigType(String bigType){
		String ret = "";
		if("AF".equals(bigType)){
			ret = "ATT_AF";			
		}else if("CI".equals(bigType)){
			ret = "ATT_CI";
		}else if("AR".equals(bigType)){
			ret = "ATT_AR";
		}else{
			ret = "ATT_OTHER";
		}
		return ret;
	}
	
	/**
	 * ���ݴ����ø��������ַ����
	 * @param bigType
	 * @return
	 * TODO
	 */
	private String getPathArgs(String s){
		String ret = s;
		return ret;
	}
	
	
	/**
	 * ����packID��ȡ����С�༯��
	 * @param conn
	 * @param packID
	 * @return
	 * @throws DBException
	 */
	public DataList getAttType(Connection conn, String packID) throws DBException{
			return  handler.getAttType(conn, packID);
	}
	
	/**
	 * ����attType��ø����ϴ�����
	 * @param attType
	 * @return
	 * @throws Exception
	 */
	public String getUploadParameter(DataList attType) throws Exception{
		String xmlstr = attType.toXmlString();		       
	    xmlstr =Base64Util.encryptBASE64(xmlstr.getBytes());
	    return xmlstr;
	}
	/**
	 * 
	 * @param packageId ����packageID
	 * @param attTypeCode ������CI��AF...��
	 * @return
	 * ����id����map
	 * key :smalltype
	 * value:dataList
	 */
	public Map<String,DataList>  getAttDataByPackageID(String packageId,String attTypeCode){
		Map<String,DataList> attidMap =  new HashMap<String, DataList>();
		String entityName = getEntityNamebyBigType(attTypeCode);
		try {
			conn = ConnectionManager.getConnection();
			DataList attDataList = this.handler.getAttData(conn, packageId, entityName);
			attidMap = this.getAttMap(attDataList);
			
		} catch (DBException e) {			
			e.printStackTrace();
		}
		return attidMap;
	}
	

	public String execute() throws Exception {
		return null;
	}

}
