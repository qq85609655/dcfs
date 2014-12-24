package com.dcfs.sce.REQInfo;

import java.sql.Connection;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: REQInfoHandler.java
 * @author lihf
 */
public class REQInfoHandler extends BaseHandler {
    /**
     * @Title: findREQInfoList
     * @Description: 组织收养撤销预批列表（已撤销）
     * @author: lihf
     * @date: 2014-9-15
     */
    public DataList findREQInfoList(Connection conn, Data data,String organCode,int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
    	String MALE_NAME = data.getString("MALE_NAME", null);   //男方
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //姓名
        String SEX = data.getString("SEX", null);   //性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束出生日期
        String REVOKE_REQ_DATE_START = data.getString("REVOKE_REQ_DATE_START", null);   //开始申请撤销日期
        String REVOKE_REQ_DATE_END = data.getString("REVOKE_REQ_DATE_END", null);   //结束申请撤销日期
        
        String REVOKE_CFM_DATE_START = data.getString("REVOKE_CFM_DATE_START", null);   //开始撤销确认日期
        String REVOKE_CFM_DATE_END = data.getString("REVOKE_CFM_DATE_END", null);   //结束撤销确认日期
        String REVOKE_STATE = data.getString("REVOKE_STATE", null);   //撤销状态
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findREQInfoList", MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START,BIRTHDAY_END,REVOKE_REQ_DATE_START,REVOKE_REQ_DATE_END,REVOKE_CFM_DATE_START,REVOKE_CFM_DATE_END,REVOKE_STATE,compositor, ordertype,organCode);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
   
    /**
     * @Description: 组织收养预批申请列表（未撤销）
     * @author: lihf
     */
    public DataList findREQInfoApplicatList(Connection conn, Data data, String organCode,int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
    	String MALE_NAME = data.getString("MALE_NAME", null);   //男方
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //姓名
        String SEX = data.getString("SEX", null);   //性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束出生日期
        String REQ_DATE_START = data.getString("REQ_DATE_START", null);   //开始申请日期
        String REQ_DATE_END = data.getString("REQ_DATE_END", null);   //结束申请日期
        String RI_STATE = data.getString("RI_STATE", null);   //预批状态
        String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);   //开始当前文件递交日期
        String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);   //结束当前文件递交日期
        String REMINDERS_STATE = data.getString("REMINDERS_STATE", null);   //催办状态
        String REM_DATE_START = data.getString("REM_DATE_START", null);   //开始催办日期
        String REM_DATE_END = data.getString("REM_DATE_END", null);   //结束催办日期
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //开始收文日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //结束收文日期
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String LAST_UPDATE_DATE_START = data.getString("LAST_UPDATE_DATE_START", null);   //开始最后更新日期
        String LAST_UPDATE_DATE_END = data.getString("LAST_UPDATE_DATE_END", null);   //结束最后更新日期
        String PASS_DATE_START = data.getString("PASS_DATE_START",null);     //开始答复日期
        String PASS_DATE_END = data.getString("PASS_DATE_END",null);     //结束答复日期
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findREQInfoApplicatList", MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START,BIRTHDAY_END,REQ_DATE_START,REQ_DATE_END,RI_STATE,SUBMIT_DATE_START,SUBMIT_DATE_END,REMINDERS_STATE,REM_DATE_START,REM_DATE_END,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,LAST_UPDATE_DATE_START,LAST_UPDATE_DATE_END,PASS_DATE_START,PASS_DATE_END,compositor, ordertype,organCode);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * @Description: 撤销申请详细信息
     * @author: lihf
     */
    public Data findREQInfoReason(Connection conn,String RI_ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data data = new Data();
    	data.setEntityName("SCE_REQ_INFO");
    	data.setPrimaryKey("RI_ID");
    	data.add("RI_ID", RI_ID);
    	Data d = ide.findByPrimaryKey(data);
    	return d;
    }
    
    /**
     * @Description: 添加撤销申请原因
     * @author: lihf
     */
    public void findREQInfoAddReason(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_REQ_INFO");
    	dataedit.setPrimaryKey("RI_ID");
    	dataedit.store();
    }
    
    /**
     * @Description: 根据RI_ID查找申请撤销详细信息
     * @author: lihf
     */
    public Data findREQInfoSearchById(Connection conn,String RI_ID) throws DBException{
    	//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findREQInfoSearchById",RI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * @Description: 安置部预批撤销列表
     * @author: lihf
     */
    public DataList findAZBREQInfoList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
    	String ADOPT_ORG_NAME_CN = data.getString("ADOPT_ORG_NAME_CN", null);  //收养组织
    	String MALE_NAME = data.getString("MALE_NAME", null);   //男方
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //姓名
        String REVOKE_REQ_DATE_START = data.getString("REVOKE_REQ_DATE_START", null);   //开始申请日期
        String REVOKE_REQ_DATE_END = data.getString("REVOKE_REQ_DATE_END", null);   //结束申请日期
        String REVOKE_CFM_DATE_START = data.getString("REVOKE_CFM_DATE_START", null);   //开始确认日期
        String REVOKE_CFM_DATE_END = data.getString("REVOKE_CFM_DATE_END", null);   //结束确认日期
        String REVOKE_STATE = data.getString("REVOKE_STATE", null);   //撤销状态
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织ID
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBREQInfoList",COUNTRY_CODE,ADOPT_ORG_NAME_CN,MALE_NAME, FEMALE_NAME, NAME,REVOKE_REQ_DATE_START,REVOKE_REQ_DATE_END,REVOKE_CFM_DATE_START,REVOKE_CFM_DATE_END,REVOKE_STATE,ADOPT_ORG_ID,compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * @Description: 转到安置部预批撤销确认页面
     * @author: lihf
     */
    public Data findAZBREQInfoSearchById(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findAZBREQInfoSearchById",ID);
    	System.out.println(sql);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    /**
     * 根据儿童ID,查找预批data
     * @param conn
     * @param ci_id
     * @return
     * @throws DBException 
     */
    public Data findYPByCiid(Connection conn,String ci_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findYPByCiidSql",ci_id);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    
    /**
     * @Description: 安置部确认预批撤销
     * @author: lihf
     */
    public void findAZBReqInfoconfirm(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_REQ_INFO");
    	dataedit.setPrimaryKey("RI_ID");
    	dataedit.store();
    }
    
    /**
     * @Description: 转到安置部预批撤销确认页面
     * @author: lihf
     */
    public Data findAZBFfsAfInfo(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data data = new Data();
    	data.setEntityName("SCE_REQ_INFO");
    	data.setPrimaryKey("RI_ID");
    	data.add("RI_ID", ID);
    	Data d = ide.findByPrimaryKey(data);
    	return d;
    }
    /**
     * @Description: 如果家庭已经提交文件，修改文件状态
     * @author: lihf
     */
    public Data findAZBFfsAfInfoRevise(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data data = new Data();
    	data.setEntityName("FFS_AF_INFO");
    	data.setPrimaryKey("AF_ID");
    	data.add("AF_ID", ID);
    	Data d = ide.findByPrimaryKey(data);
    	return d;
    }
    
    /**
     * @Description: 修改家庭文件状态
     * @author: lihf
     */
    public void findAZBFfsAfInfoSave(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("FFS_AF_INFO");
    	dataedit.setPrimaryKey("AF_ID");
    	dataedit.store();
    }
    
  //预批data
  	public  Data getRIData(Connection conn,String RI_ID) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
  		Data dataadd = new Data();
  	    dataadd.setConnection(conn);
  	    dataadd.setEntityName("SCE_REQ_INFO");
  	    dataadd.setPrimaryKey("RI_ID");
  	    dataadd.addString("RI_ID", RI_ID);
  	    DataList dl = ide.find(dataadd);
  	    return dl.getData(0);
  	}
  	
  //文件data
  	public  Data getAFData(Connection conn,String AF_ID) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
  		Data dataadd = new Data();
  	    dataadd.setConnection(conn);
  	    dataadd.setEntityName("FFS_AF_INFO");
  	    dataadd.setPrimaryKey("AF_ID");
  	    dataadd.addString("AF_ID", AF_ID);
  	    DataList dl = ide.find(dataadd);
  	    return dl.getData(0);
  	}
  	
  	//发布data
  	public  Data getPubData(Connection conn,String PUB_ID) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
  		Data dataadd = new Data();
  	    dataadd.setConnection(conn);
  	    dataadd.setEntityName("SCE_PUB_RECORD");
  	    dataadd.setPrimaryKey("PUB_ID");
  	    dataadd.addString("PUB_ID", PUB_ID);
  	    DataList dl = ide.find(dataadd);
  	    return dl.getData(0);
  	}
  	
  	//儿童材料表
  	public  Data getCIData(Connection conn,String CI_ID) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
  		Data dataadd = new Data();
  	    dataadd.setConnection(conn);
  	    dataadd.setEntityName("CMS_CI_INFO");
  	    dataadd.setPrimaryKey("CI_ID");
  	    dataadd.addString("CI_ID", CI_ID);
  	    DataList dl = ide.find(dataadd);
  	    return dl.getData(0);
  	}
  	
  	//根据儿童编号，获取儿童信息
  	public Data getCHILDNOData(Connection conn,String CHILD_NO) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getCHILDNODataSQL",CHILD_NO);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
  	}
  	
  //保存发布记录表
  	public  void  savePubData(Connection conn,Data Data) throws DBException{
  		Data dataupdate = new Data(Data);
  		dataupdate.setConnection(conn);
  		dataupdate.setEntityName("SCE_PUB_RECORD");
  		dataupdate.setPrimaryKey("PUB_ID");
  		dataupdate.store();
  	}
	
    //保存文件表
	public  void  saveFfsData(Connection conn,Data Data) throws DBException{
		Data dataupdate = new Data(Data);
		dataupdate.setConnection(conn);
		dataupdate.setEntityName("FFS_AF_INFO");
		dataupdate.setPrimaryKey("AF_ID");
		dataupdate.store();
	}
	

}


