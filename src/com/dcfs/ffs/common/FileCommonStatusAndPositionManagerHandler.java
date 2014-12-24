package com.dcfs.ffs.common;

import java.sql.Connection;
import java.util.Map;


import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;

/**
 * 文件全局状态和位置公共handler类
 * @description 
 * @author MaYun
 * @date Jul 28, 2014
 * @return
 */
public class FileCommonStatusAndPositionManagerHandler extends BaseHandler {
	
	/**
	 * 
	 * @description  向文件信息表中更新文件全局状态、文件位置
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
