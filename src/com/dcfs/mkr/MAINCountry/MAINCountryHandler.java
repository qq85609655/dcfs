package com.dcfs.mkr.MAINCountry;

import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.Map;

public class MAINCountryHandler extends BaseHandler{
	
	/**
     * 生成树形结构
     * @param conn
     * @param aPP_ID 
     * @return
     */
    public CodeList getMainCountryTree(Connection conn){
        CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("getMainCountryTree"));
        return codeList;
    }
    
    /**
     * 根据国家ID查找国家信息
     * @throws DBException 
     */
    public Data findCountryMessage(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findCountryMessage",ID);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    /**
     * 根据国家ID查找相关政府部门信息
     * @throws DBException 
     */
    public DataList findGovement(Connection conn,String ID,int pageSize,int page,String compositor,String ordertype) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findGovement",ID,compositor,ordertype);
    	DataList dl = ide.find(sql, pageSize, page);
    	return dl;
    }
    
    //修改国家信息
    public void findReviseCountry(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("MKR_COUNTRY_INFO");
    	dataedit.setPrimaryKey("COUNTRY_CODE");
    	dataedit.store();
    }
    
    /**
     * 根据政府ID查找政府信息
     * @throws DBException 
     */
    public Data findGovementMessage(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findGovementMessage",ID);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    
    /**
     * 根据政府ID查找联系人信息
     * @throws DBException 
     */
    public DataList findContactMessage(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findContactMessage",ID);
    	DataList dl = ide.find(sql);
    	return dl;
    }
    
    //修改政府部门信息
    public void findReviseGovement(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("MKR_COUNTRY_GOVMENT");
    	dataedit.setPrimaryKey("GOV_ID");
    	dataedit.store();
    }
    
    //添加政府部门信息
    public void findAddGovement(Connection conn,Data data) throws DBException{
    	Data da = new Data(data);
    	da.setConnection(conn);
    	da.setEntityName("MKR_COUNTRY_GOVMENT");
    	da.setPrimaryKey("GOV_ID");
    	da.create();
    }
    
    //保存联系人信息
    public void saveContact(Connection conn,DataList dataList) throws DBException{
    	for(int i=0;i<dataList.size();i++){
    		Data da = dataList.getData(i);
    		da.setConnection(conn);
    		da.setEntityName("MKR_COUNTRY_GOVMENT_CONTACTS");
        	da.setPrimaryKey("ID");
        	da.create();
    	}
    }
    
    //删除联系人
    public void delContact(Connection conn,String ID) throws DBException{
    	Data data = new Data();
    	data.setConnection(conn);
		data.setEntityName("MKR_COUNTRY_GOVMENT_CONTACTS");
		data.setPrimaryKey("ID");
		data.add("ID", ID);
		data.remove();
    }
    
    //批量删除联系人信息
    public void delContactList(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide=DataBaseFactory.getDataBase(conn);
        ide.remove(dataList);
    }
    
    //删除联系人
    public void delGovement(Connection conn,String ID) throws DBException{
    	Data data = new Data();
    	data.setConnection(conn);
		data.setEntityName("MKR_COUNTRY_GOVMENT");
		data.setPrimaryKey("GOV_ID");
		data.add("GOV_ID", ID);
		data.remove();
    }
    
    //政府职能集合
    public DataList findGoveList(Connection conn) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findGoveList");
    	DataList dl = ide.find(sql);
    	return dl;
    }
}
