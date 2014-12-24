/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����3:00:55 
 * @version V1.0   
 */
package com.dcfs.sce.setSettle;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: SetSettleHandler 
 * @Description: ���޲����б����ð��á��������޲��� 
 * @author panfeng
 * @date 2014-9-16
 *  
 */
public class SetSettleHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public SetSettleHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * �������޲����б�
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList settleParaList(Connection conn, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("settleParaList", compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * �������޲������ô���
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getSettleData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getSettleData", uuid));
		return dataList.getData(0);
	}
	
	 /**
     * ���氲�á�������������
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveSettleMonth(Connection conn, Map<String, Object> data)
            throws DBException {
	    //***��������*****
        Data dataadd = new Data(data);
        
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_SETTLE_SET");
        dataadd.setPrimaryKey("SETTLE_ID");
        if ("".equals(dataadd.getString("SETTLE_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }
    
}
