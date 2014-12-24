package com.dcfs.mkr.organesupp;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import oracle.jdbc.driver.OracleResultSet;
import oracle.sql.CLOB;

public class OrganSuppHandler extends BaseHandler{

	private IDataExecute ide;
	
	//**********在华联系人信息begin****************
	//根据组织机构ID查找在华联系人信息
	public DataList findLinkManOrganList(Connection conn,String id,int pageSize,int page,String orderString) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = ide.find(getSql("findLinkManOrganListSQL",id,orderString), pageSize, page);
		return dataList;
	}
	
	//根据主键查询联系人信息
	public Data findDataByKey(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.findByPrimaryKey(data);
	}
	
	//修改
	public Data modify(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.store(data);
	}
	
	//clob数据保存
	public void modify_empty(Connection conn,String ID,String PER_RESUME,String COMMITMENT_ITEM) throws SQLException{
		String sql = "update MKR_ORG_CONTACTS set PER_RESUME=empty_clob(),COMMITMENT_ITEM=empty_clob() where id='"+ID+"'";
		Statement stmt=conn.createStatement();
		ResultSet rs=stmt.executeQuery(sql);
		String updateSql = "select PER_RESUME,COMMITMENT_ITEM from MKR_ORG_CONTACTS where id='"+ID+"' for update";
		ResultSet rss = stmt.executeQuery(updateSql);
		if(rss.next()){
			CLOB result = ((OracleResultSet)rss).getCLOB(1);
			CLOB item = ((OracleResultSet)rss).getCLOB(2);
			result.putString(1,PER_RESUME);
			item.putString(2,COMMITMENT_ITEM);
			sql="update MKR_ORG_CONTACTS set PER_RESUME=?,COMMITMENT_ITEM=? where id='"+ID+"'";
			PreparedStatement pstmt=conn.prepareStatement(sql);
			pstmt.setClob(1,result);
			pstmt.setClob(2,item);
			pstmt.executeUpdate();
			pstmt.close();
		}
		rss.close();
		rs.close();
	}
	
	//添加
	public Data add(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.create(data);
	}
	
	//删除
	public int delete(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		int result = ide.remove(data);
		return result;
	}
	//**************在华联系人信息end*************
	
	//根据组织机构ID查找捐助或援助项目
	public DataList findAidProjectOrganList(Connection conn,String id,int pageSize,int page,String orderString) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = ide.find(getSql("findAidProjectOrganListSQL",id,orderString), pageSize, page);
		return dataList;
	}
	
	//根据组织机构ID查找在华旅行接待信息
	public DataList findReceptionOrganList(Connection conn,String id,int pageSize,int page,String orderString) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = ide.find(getSql("findReceptionOrganListSQL", id,orderString), pageSize, page);
		return dataList;
	}
	
	//查询机构备案信息
	public DataList findOrganRecordStateList(Connection conn,Data data,int pageSize,int page,String compositor, String ordertype) throws DBException{
		//查询条件
		String COUNTY_NAME = data.getString("COUNTY_NAME",null);   //国家
		String CNAME = data.getString("CNAME",null);  //组织中文名称
		String ENNAME = data.getString("ENNAME",null); //组织英文名称
		String ORG_CODE = data.getString("ORG_CODE",null);  //机构代码
		String RECORD_STATE = data.getString("RECORD_STATE",null);   //备案状态
		String FOUNDED_DATE_BEGIN = data.getString("FOUNDED_DATE_BEGIN",null);  //成立时间开始
		String FOUNDED_DATE_END = data.getString("FOUNDED_DATE_END",null);   //成立时间结束
		String IS_VALID = data.getString("IS_VALID",null);  //是否有效  0:无效；1：有效
		if(IS_VALID!=null){
			if(IS_VALID.equals("0")){
				IS_VALID = "3";
			}else{
				IS_VALID = "0,1,2,4";
			}
		}
		ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findOrganRecordStateListSQL",COUNTY_NAME,CNAME,ENNAME,ORG_CODE,RECORD_STATE,FOUNDED_DATE_BEGIN,FOUNDED_DATE_END,IS_VALID,compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	//根据组织id查找组织国家等的信息
	public Data finfOrganRecordStateData(Connection conn,String ID) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("finfOrganRecordStateDataSQL",ID);
		DataList data = ide.find(sql);
		return data.getData(0);
	}
	
	//查找国家集合
	public DataList findCountryList(Connection conn) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findCountryListSQL");
		DataList dl = ide.find(sql);
		return dl;
	}
	
	//查找更新纪录
	public DataList findOrganUpdateList(Connection conn,String ID,int pageSize,int page,String orderString) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = ide.find(getSql("findOrganUpdateListSQL",ID,orderString), pageSize, page);
		return dataList;
	}
	
	 public CodeList getProvinceTree(Connection conn){
        CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("getProvinceTreeSQL"));
        return codeList;
    }
	 
	 //根据省份查找福利机构
	 public DataList findWelfareList(Connection conn,String ID,int pageSize,int page,String orderString) throws DBException{
		 ide = DataBaseFactory.getDataBase(conn);
		 DataList dataList = ide.find(getSql("findWelfareListSQL",ID,orderString), pageSize, page);
		 return dataList;
	 }
	 
	 //根据省份ID查找福利机构信息
	 public DataList findWelfareDataList(Connection conn,String ID) throws DBException{
		 ide = DataBaseFactory.getDataBase(conn);
		 DataList dataList = ide.find(getSql("findWelfareListSQL",ID));
		 return dataList;
	 }
	 
	 //根据省份ID查找福利机构信息
	 public DataList findWelfareDataListAll(Connection conn) throws DBException{
		 ide = DataBaseFactory.getDataBase(conn);
		 DataList dataList = ide.find(getSql("findWelfareListAllSQL"));
		 return dataList;
	 }
	 
	 //根据组织ID查找相关福利机构信息
	 public Data findWelfareById(Connection conn,String ID) throws DBException{
		 ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findWelfareByIdSQL", ID);
		 DataList dataList = ide.find(sql);
		 return dataList.getData(0);
	 }

	public DataList findCitys(Connection conn) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findCitysSQL");
		 return ide.find(sql);
	}
}
