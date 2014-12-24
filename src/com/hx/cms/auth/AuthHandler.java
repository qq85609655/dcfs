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
	 * ������Ŀ��:���˵��ⲿ����
	 * @param conn
	 * @return
	 */
	public CodeList generateTree(Connection conn) {
		CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("generateChannelTreeSQL"));
        return codeList;
	}
	
	/**
     * ��ѯ�Ѿ��������ɫ����Ŀ��ID�����ַ�������
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
	 * ����Data��ѯ
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
     * ��ѯָ������֯�ṹ�±ߵ���Ա
     * @param conn
     * @param orgId ��֯����ID
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
