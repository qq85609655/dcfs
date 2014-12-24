package com.hx.cms.channel;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

/**
 * 
 * @Title: ChannelTypeHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on Dec 10, 2010 3:17:03 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelTypeHandler extends BaseHandler{
	
	private IDataExecute ide;

	/**
	 * ���
	 * @param data
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public Data add(Connection conn, Data data) throws Exception{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.create(data);
	}

	/**
	 * ��ҳ��ѯ
	 * @param conn
	 * @param pageSize
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public DataList findPage(Connection conn, int pageSize, int page,String compositor, String ordertype) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findChannelTypeSQL",compositor,ordertype), pageSize, page);
	}

	/**
	 * ����������ѯ
	 * @param conn
	 * @param data
	 * @return
	 * @throws Exception 
	 */
	public Data findDataByKey(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.findByPrimaryKey(data);
	}

	/**
	 * ɾ��
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public void delete(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(data);
	}

	/**
	 * ����ɾ��
	 * @param conn
	 * @param dataList
	 * @throws Exception 
	 */
	public void deleteBatch(Connection conn, DataList dataList) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(dataList);
	}

	/**
	 * �޸�
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public Data modify(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.store(data);
	}

	/**
	 * ��ѯ��Ŀ�����ΪCodeList
	 * @param conn
	 * @return
	 */
	public CodeList findChannelTypeToCodeList(Connection conn) {
		return UtilCode.getCodeListBySql(conn, getSql("findChannelTypeToCodeListSQL"));
	}
	public CodeList findChannelTypeToCodeListFor1nMode(Connection conn,String orgLevelCode) {
		return UtilCode.getCodeListBySql(conn, getSql("findChannelTypeToCodeListFor1nModeSQL",orgLevelCode));
	}

	public DataList findPageFor1nMode(Connection conn, String orgLevelCode,	int pageSize, int page,String compositor, String ordertype) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findChannelTypeFor1nModeSQL",orgLevelCode,compositor,ordertype), pageSize, page);
	}
}
