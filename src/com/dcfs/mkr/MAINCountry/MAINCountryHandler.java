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
     * �������νṹ
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
     * ���ݹ���ID���ҹ�����Ϣ
     * @throws DBException 
     */
    public Data findCountryMessage(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findCountryMessage",ID);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    /**
     * ���ݹ���ID�����������������Ϣ
     * @throws DBException 
     */
    public DataList findGovement(Connection conn,String ID,int pageSize,int page,String compositor,String ordertype) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findGovement",ID,compositor,ordertype);
    	DataList dl = ide.find(sql, pageSize, page);
    	return dl;
    }
    
    //�޸Ĺ�����Ϣ
    public void findReviseCountry(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("MKR_COUNTRY_INFO");
    	dataedit.setPrimaryKey("COUNTRY_CODE");
    	dataedit.store();
    }
    
    /**
     * ��������ID����������Ϣ
     * @throws DBException 
     */
    public Data findGovementMessage(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findGovementMessage",ID);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    
    /**
     * ��������ID������ϵ����Ϣ
     * @throws DBException 
     */
    public DataList findContactMessage(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findContactMessage",ID);
    	DataList dl = ide.find(sql);
    	return dl;
    }
    
    //�޸�����������Ϣ
    public void findReviseGovement(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("MKR_COUNTRY_GOVMENT");
    	dataedit.setPrimaryKey("GOV_ID");
    	dataedit.store();
    }
    
    //�������������Ϣ
    public void findAddGovement(Connection conn,Data data) throws DBException{
    	Data da = new Data(data);
    	da.setConnection(conn);
    	da.setEntityName("MKR_COUNTRY_GOVMENT");
    	da.setPrimaryKey("GOV_ID");
    	da.create();
    }
    
    //������ϵ����Ϣ
    public void saveContact(Connection conn,DataList dataList) throws DBException{
    	for(int i=0;i<dataList.size();i++){
    		Data da = dataList.getData(i);
    		da.setConnection(conn);
    		da.setEntityName("MKR_COUNTRY_GOVMENT_CONTACTS");
        	da.setPrimaryKey("ID");
        	da.create();
    	}
    }
    
    //ɾ����ϵ��
    public void delContact(Connection conn,String ID) throws DBException{
    	Data data = new Data();
    	data.setConnection(conn);
		data.setEntityName("MKR_COUNTRY_GOVMENT_CONTACTS");
		data.setPrimaryKey("ID");
		data.add("ID", ID);
		data.remove();
    }
    
    //����ɾ����ϵ����Ϣ
    public void delContactList(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide=DataBaseFactory.getDataBase(conn);
        ide.remove(dataList);
    }
    
    //ɾ����ϵ��
    public void delGovement(Connection conn,String ID) throws DBException{
    	Data data = new Data();
    	data.setConnection(conn);
		data.setEntityName("MKR_COUNTRY_GOVMENT");
		data.setPrimaryKey("GOV_ID");
		data.add("GOV_ID", ID);
		data.remove();
    }
    
    //����ְ�ܼ���
    public DataList findGoveList(Connection conn) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findGoveList");
    	DataList dl = ide.find(sql);
    	return dl;
    }
}
