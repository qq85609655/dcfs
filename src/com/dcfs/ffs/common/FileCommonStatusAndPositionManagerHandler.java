package com.dcfs.ffs.common;

import java.sql.Connection;
import java.util.Map;


import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;

/**
 * �ļ�ȫ��״̬��λ�ù���handler��
 * @description 
 * @author MaYun
 * @date Jul 28, 2014
 * @return
 */
public class FileCommonStatusAndPositionManagerHandler extends BaseHandler {
	
	/**
	 * 
	 * @description  ���ļ���Ϣ���и����ļ�ȫ��״̬���ļ�λ��
	 * @author MaYun
	 * @date Jul 29, 2014
	 * @return
	 */
	public void updateNextGlobalStatusAndPositon(Connection conn, Map<String, Object> data)throws DBException{
		Data dataadd = new Data(data);
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("FFS_AF_INFO");
	    dataadd.setPrimaryKey("AF_ID");
	    dataadd.store();
	}
}
