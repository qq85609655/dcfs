package com.dcfs.mkr.organexp;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import java.sql.Connection;


/**
 * 
 * @Title: OrganExpHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on Dec 10, 2010 3:17:03 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class OrganExpHandler extends BaseHandler{
	
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
	
	//clob数据保存
//	public void modify_clob(Connection conn,String ID,String BRIEF_RESUME) throws SQLException{
//		String sql = "update MKR_ORG_BRANCH set INTRODUCTION_INFO=empty_clob() where id='"+ID+"'";
//		Statement stmt=conn.createStatement();
//		ResultSet rs=stmt.executeQuery(sql);
//		String updateSql = "select INTRODUCTION_INFO from MKR_ORG_BRANCH where id='"+ID+"' for update";
//		ResultSet rss = stmt.executeQuery(updateSql);
//		if(rss.next()){
//			CLOB result = ((OracleResultSet)rss).getCLOB(1);
//			result.putString(1,BRIEF_RESUME);
//			sql="update MKR_ORG_BRANCH set INTRODUCTION_INFO=? where id='"+ID+"'";
//			PreparedStatement pstmt=conn.prepareStatement(sql);
//			pstmt.setClob(1,result);
//			pstmt.executeUpdate();
//			pstmt.close();
//		}
//		rss.close();
//		rs.close();
//	}
	
	/**
     * 生成组织结构树形结构
     * @param conn
     * @return
     */
    public CodeList generateOrganTree(Connection conn){
        CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("generateOrganTreeSQL"));
        return codeList;
    }

	public Data findOrganModifyData(Connection conn, String id) throws Exception {
		Data d = new Data();
		ide = DataBaseFactory.getDataBase(conn);
		DataList dl = ide.find(getSql("findOrganModifyData",id));
		if(dl != null && dl.size() > 0){
			d = dl.getData(0);
		}
		return d;
	}
	
	public CodeList findCodesortListById(Connection conn,String codesortId){
        CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeList(codesortId, conn);
        return codeList;
    }
	
	public DataList findBranchOrganList(Connection conn, String id, int pageSize, int page, String orderString) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findBranchOrganListSQL",id,orderString), pageSize, page);
	}

	public CodeList findCountryList(Connection conn) {
		CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("findCountryListSQL"));
        return codeList;
	}
	
	public DataList isOrganList(Connection conn,String id) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("isOrganListSQL",id));
	}
}
