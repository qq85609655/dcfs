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
	
	//**********�ڻ���ϵ����Ϣbegin****************
	//������֯����ID�����ڻ���ϵ����Ϣ
	public DataList findLinkManOrganList(Connection conn,String id,int pageSize,int page,String orderString) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = ide.find(getSql("findLinkManOrganListSQL",id,orderString), pageSize, page);
		return dataList;
	}
	
	//����������ѯ��ϵ����Ϣ
	public Data findDataByKey(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.findByPrimaryKey(data);
	}
	
	//�޸�
	public Data modify(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.store(data);
	}
	
	//clob���ݱ���
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
	
	//���
	public Data add(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.create(data);
	}
	
	//ɾ��
	public int delete(Connection conn,Data data) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		int result = ide.remove(data);
		return result;
	}
	//**************�ڻ���ϵ����Ϣend*************
	
	//������֯����ID���Ҿ�����Ԯ����Ŀ
	public DataList findAidProjectOrganList(Connection conn,String id,int pageSize,int page,String orderString) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = ide.find(getSql("findAidProjectOrganListSQL",id,orderString), pageSize, page);
		return dataList;
	}
	
	//������֯����ID�����ڻ����нӴ���Ϣ
	public DataList findReceptionOrganList(Connection conn,String id,int pageSize,int page,String orderString) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = ide.find(getSql("findReceptionOrganListSQL", id,orderString), pageSize, page);
		return dataList;
	}
	
	//��ѯ����������Ϣ
	public DataList findOrganRecordStateList(Connection conn,Data data,int pageSize,int page,String compositor, String ordertype) throws DBException{
		//��ѯ����
		String COUNTY_NAME = data.getString("COUNTY_NAME",null);   //����
		String CNAME = data.getString("CNAME",null);  //��֯��������
		String ENNAME = data.getString("ENNAME",null); //��֯Ӣ������
		String ORG_CODE = data.getString("ORG_CODE",null);  //��������
		String RECORD_STATE = data.getString("RECORD_STATE",null);   //����״̬
		String FOUNDED_DATE_BEGIN = data.getString("FOUNDED_DATE_BEGIN",null);  //����ʱ�俪ʼ
		String FOUNDED_DATE_END = data.getString("FOUNDED_DATE_END",null);   //����ʱ�����
		String IS_VALID = data.getString("IS_VALID",null);  //�Ƿ���Ч  0:��Ч��1����Ч
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
	
	//������֯id������֯���ҵȵ���Ϣ
	public Data finfOrganRecordStateData(Connection conn,String ID) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("finfOrganRecordStateDataSQL",ID);
		DataList data = ide.find(sql);
		return data.getData(0);
	}
	
	//���ҹ��Ҽ���
	public DataList findCountryList(Connection conn) throws DBException{
		ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findCountryListSQL");
		DataList dl = ide.find(sql);
		return dl;
	}
	
	//���Ҹ��¼�¼
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
	 
	 //����ʡ�ݲ��Ҹ�������
	 public DataList findWelfareList(Connection conn,String ID,int pageSize,int page,String orderString) throws DBException{
		 ide = DataBaseFactory.getDataBase(conn);
		 DataList dataList = ide.find(getSql("findWelfareListSQL",ID,orderString), pageSize, page);
		 return dataList;
	 }
	 
	 //����ʡ��ID���Ҹ���������Ϣ
	 public DataList findWelfareDataList(Connection conn,String ID) throws DBException{
		 ide = DataBaseFactory.getDataBase(conn);
		 DataList dataList = ide.find(getSql("findWelfareListSQL",ID));
		 return dataList;
	 }
	 
	 //����ʡ��ID���Ҹ���������Ϣ
	 public DataList findWelfareDataListAll(Connection conn) throws DBException{
		 ide = DataBaseFactory.getDataBase(conn);
		 DataList dataList = ide.find(getSql("findWelfareListAllSQL"));
		 return dataList;
	 }
	 
	 //������֯ID������ظ���������Ϣ
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
