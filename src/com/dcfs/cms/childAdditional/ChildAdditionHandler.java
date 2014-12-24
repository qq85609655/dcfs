package com.dcfs.cms.childAdditional;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

public class ChildAdditionHandler extends BaseHandler{
    public DataList findListFLY(Connection conn, String oId, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//查询条件
		String NAME = data.getString("NAME", null);	//姓名
		String SEX = data.getString("SEX", null);	//性别
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
		String SOURCE = data.getString("SOURCE", null);	//补充通知来源
		String CA_STATUS = data.getString("CA_STATUS", null);	//补充状态
		String FEEDBACK_DATE_START =  data.getString("FEEDBACK_DATE_START", null);//反馈日期开始
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END",null);//反馈日期结束
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//通知日期开始
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//通知日期结束
		
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findListFLY",oId,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SOURCE,CA_STATUS,FEEDBACK_DATE_START,FEEDBACK_DATE_END,NOTICE_DATE_START,NOTICE_DATE_END,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    
    public DataList findListFromSt(Connection conn, String oId, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//查询条件
    	String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院code
		String NAME = data.getString("NAME", null);	//姓名
		String SEX = data.getString("SEX", null);	//性别
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
		String CA_STATUS = data.getString("CA_STATUS", null);	//补充状态
		String FEEDBACK_DATE_START =  data.getString("FEEDBACK_DATE_START", null);//反馈日期开始
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END",null);//反馈日期结束
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//通知日期开始
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//通知日期结束
		
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findListFromSt",oId,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,CA_STATUS,FEEDBACK_DATE_START,FEEDBACK_DATE_END,NOTICE_DATE_START,NOTICE_DATE_END,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    public DataList findListFromAZB(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//查询条件
    	String PROVINCE_ID=data.getString("PROVINCE_ID", null);	//省份（代码集对应的代码值）
    	String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院中文名称
		String NAME = data.getString("NAME", null);	//姓名
		String SEX = data.getString("SEX", null);	//性别
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
		String CA_STATUS = data.getString("CA_STATUS", null);	//补充状态
		String FEEDBACK_DATE_START =  data.getString("FEEDBACK_DATE_START", null);//反馈日期开始
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END",null);//反馈日期结束
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//通知日期开始
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//通知日期结束
		
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findListFromAZB",PROVINCE_ID,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,CA_STATUS,FEEDBACK_DATE_START,FEEDBACK_DATE_END,NOTICE_DATE_START,NOTICE_DATE_END,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    public DataList findListST(Connection conn, String oId, Data data,
            int pageSize, int page, String compositor, String ordertype)
            throws DBException {

    	//查询条件
    	String WELFARE_ID = data.getString("WELFARE_ID", null);	//福利院code
		String NAME = data.getString("NAME", null);	//姓名
		String SEX = data.getString("SEX", null);	//性别
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//儿童类型
		String SOURCE = data.getString("SOURCE", null);	//补充通知来源
		String CA_STATUS = data.getString("CA_STATUS", null);	//补充状态
		String FEEDBACK_DATE_START =  data.getString("FEEDBACK_DATE_START", null);//反馈日期开始
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END",null);//反馈日期结束
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//出生日期开始
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//出生日期开始
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START",null);//通知日期开始
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END",null);//通知日期结束
		
		//查询条件
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findListST",oId,WELFARE_ID,NAME,SEX,CHILD_TYPE,BIRTHDAY_START,BIRTHDAY_END,SOURCE,CA_STATUS,FEEDBACK_DATE_START,FEEDBACK_DATE_END,NOTICE_DATE_START,NOTICE_DATE_END,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    //获取儿童材料补充信息
    public Data getModifyData(Connection conn, String uuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("getModifyData", uuid));
        Data supplyData=dataList.getData(0);
        return supplyData;
    }
    
	public boolean childSupplySave(Connection conn, Data supplydata,Data childData) throws DBException {	
    	supplydata.setConnection(conn);
    	supplydata.setEntityName("CMS_CI_ADDITIONAL");
    	supplydata.setPrimaryKey("CA_ID");
    	supplydata.store();
    	
    	childData.setConnection(conn);
    	childData.setEntityName("CMS_CI_INFO");
    	childData.setPrimaryKey("CI_ID");
    	childData.store();
		return true;
	}
	 public boolean save(Connection conn, Data data) throws DBException {
	        
    	 String CI_ID=data.getString("CI_ID",null);
    	 if(CI_ID==null){
    		 return false;
    	 }
    	 data.setConnection(conn);
    	 data.setEntityName("CMS_CI_ADDITIONAL");
    	 data.setPrimaryKey("CA_ID");
    	 String id=data.getString("CA_ID", null);
    	 if(id==null){
    		 data.create();
    	 }else{
    	     data.store();
    	 }
	    return true;
     }
	//根据儿童材料主键获取已补充的补充记录信息
	  public DataList getAdditionDataByCIID(Connection conn, String CI_ID) throws DBException {
	        IDataExecute ide = DataBaseFactory.getDataBase(conn);
	        DataList dataList = null;
	        dataList = ide.find(getSql("getAdditionDataByCIID", CI_ID));
	        return dataList;
	    }
}
