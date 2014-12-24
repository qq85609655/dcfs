 /**
 * @Title: AttSmallTypeAction.java
 * @Package com.dcfs.cms
 * @Description: 附件小类维护
 * @author 王征
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
     * 保存
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean save(Connection conn, Map<String, Object> data)
            throws DBException {
	    //***保存数据*****
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
     * 查询列表
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
		//次数遍历查询条件为了代码生成器示例可运行，实际使用过程中一定书写正确，修改配置文件中sql语句，以下给大家生成好可用语句
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
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        
        String sql = getSql("findList",buffer.toString(),compositor,ordertype);
        System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

    /**
     * 查看
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
     * 删除
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