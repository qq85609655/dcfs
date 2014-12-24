package com.hx.cms.auth;

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
 * @Title: AuthHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on Dec 10, 2010 3:16:45 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AuthHandler extends BaseHandler{
	
	private IDataExecute ide;

	/**
	 * 添加
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
	 * 根据主键查询
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
	 * 删除
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public void delete(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(data);
	}

	/**
	 * 批量删除
	 * @param conn
	 * @param dataList
	 * @throws Exception 
	 */
	public void deleteBatch(Connection conn, DataList dataList) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(dataList);
	}

	/**
	 * 修改
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public Data modify(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.store(data);
	}

	/**
	 * 生成栏目树:过滤掉外部链接
	 * @param conn
	 * @return
	 */
	public CodeList generateTree(Connection conn) {
		CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("generateChannelTreeSQL"));
        return codeList;
	}
	
	/**
     * 查询已经分配给角色的栏目的ID，以字符串返回
     * @param conn
     * @param roleId
     * @return
     * @throws Exception 
     */
    public String findSavedResourceOfRole(Connection conn, String roleId) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = ide.find(getSql("findSavedResourceOfRoleSQL",roleId));
        StringBuffer res = new StringBuffer();
        if(dataList != null){
            for (int i = 0; i < dataList.size(); i++) {
                Data data = dataList.getData(i);
                if(i == (dataList.size() - 1)){
                    res.append(data.getString("VALUE"));
                }else{
                    res.append(data.getString("VALUE")).append(",");
                }
            }
        }
        return res.toString();
    }
	
	/**
	 * 根据Data查询
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public DataList findData(Connection conn, Data data) throws Exception {
	    ide = DataBaseFactory.getDataBase(conn);
	    return ide.find(data);
	}

	public String findSavedChannelsOfPerson(Connection conn, String personId, String role) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = ide.find(getSql("findSavedChannelsOfPersonSQL",personId,role));
        StringBuffer res = new StringBuffer();
        if(dataList != null){
            for (int i = 0; i < dataList.size(); i++) {
                Data data = dataList.getData(i);
                if(i == (dataList.size() - 1)){
                    res.append(data.getString("VALUE"));
                }else{
                    res.append(data.getString("VALUE")).append(",");
                }
            }
        }
        return res.toString();
	}
	
	/**
     * 查询指定的组织结构下边的人员
     * @param conn
     * @param orgId 组织机构ID
     * @param pageSize
     * @param page
     * @return
     * @throws Exception
     */
    public DataList findPersonOfOrg(Connection conn, String orgId, int pageSize, int page) throws Exception{
        ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findPersonOrOrgSQL",orgId), pageSize, page);
    }
    
    public DataList findPersonOfOrg(Connection conn, Data sdata, int pageSize, int page,String compositor,String ordertype) throws Exception{
        ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findPersonOrOrgSQL",sdata.getString("ORGAN_ID_"),sdata.getString("PERSON_NAME_"),compositor,ordertype), pageSize, page);
    }
}
