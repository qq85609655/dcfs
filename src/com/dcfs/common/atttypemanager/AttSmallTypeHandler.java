 /**
 * @Title: AttSmallTypeAction.java
 * @Package com.dcfs.cms
 * @Description: ����С��ά��
 * @author ����
 * @project DCFS 
 * @date 2014-10-27 9:34:46
 * @version V1.0   
 */
package com.dcfs.common.atttypemanager;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import java.sql.Connection;
import java.util.Iterator;
import java.util.Map;
import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * @Title: AttSmallTypeHandler.java
 * @Description:????
 * @Created on 
 * @author xxx
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class AttSmallTypeHandler extends BaseHandler{

	  /**
     * ����
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean save(Connection conn, Map<String, Object> data)
            throws DBException {
	    //***��������*****
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("ATT_SMALL_TYPE");
        dataadd.setPrimaryKey("ID");
        if ("".equals(dataadd.getString("ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }

    /**
     * ��ѯ�б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws DBException
     */
    public DataList findList(Connection conn, Map<String, Object> data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {
        Data searchdata = new Data(data);
		//����������ѯ����Ϊ�˴���������ʾ�������У�ʵ��ʹ�ù�����һ����д��ȷ���޸������ļ���sql��䣬���¸�������ɺÿ������
		StringBuffer buffer = new StringBuffer();
        Iterator<String> it = data.keySet().iterator();
        while (it.hasNext()) {
            String key = it.next();
            String value = searchdata.getString(key, "");
            if (!"".equals(value)) {
                buffer.append(" AND ").append(key).append(" = '").append(value)
                        .append("'");
            }
        }
		//��ѯ����
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        
        String sql = getSql("findList",buffer.toString(),compositor,ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

    /**
     * �鿴
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public Data getShowData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getShowData", uuid));
        return dataList.getData(0);
    }

    /**
     * ɾ��
     * 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public boolean delete(Connection conn, String[] uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList deleteList = new DataList();
        for (int i = 0; i < uuid.length; i++) {
            Data data = new Data();
            data.setConnection(conn);
            data.setEntityName("ATT_SMALL_TYPE");
            data.setPrimaryKey("ID");
            data.add("ID", uuid[i]);
            deleteList.add(data);
        }
        ide.remove(deleteList);
        return true;
    }
}