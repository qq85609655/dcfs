package com.dcfs.sce.PUBRecord;

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
 * @Description: 安置部征求意见
 * @author lihf
 */
public class PUBRecordHandler extends BaseHandler {
    /**
     * @Description: 安置部点发退回列表
     * @author: lihf
     */
    public DataList findPUBRecordList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
    	String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
    	String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String SN_TYPE = data.getString("SN_TYPE", null);   //病残种类
        String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);   //特别关注
        String PUB_DATE_START = data.getString("PUB_DATE_START", null);   //开始发布日期
        String PUB_DATE_END = data.getString("PUB_DATE_END", null);   //结束发布日期
        String PUB_MODE = data.getString("PUB_MODE", null);   //点发类型
        String RETURN_TYPE = data.getString("RETURN_TYPE", null);   //退回类型
        String PUB_ORGID = data.getString("PUB_ORGID", null);   //退回组织
        String RETURN_DATE_START = data.getString("RETURN_DATE_START", null);   //开始退回日期
        String RETURN_DATE_END = data.getString("RETURN_DATE_END", null);   //结束退回日期
        String RETURN_CFM_DATE_START = data.getString("RETURN_CFM_DATE_START", null);   //开始确认日期
        String RETURN_CFM_DATE_END = data.getString("RETURN_CFM_DATE_END", null);   //结束确认日期
        String RETURN_STATE = data.getString("RETURN_STATE", null);   //退回状态
        String PUB_TYPE = data.getString("PUB_TYPE", null);   //发布类型
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findPUBRecordList", PROVINCE_ID, WELFARE_NAME_CN, NAME, SEX, BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,SPECIAL_FOCUS,PUB_DATE_START,PUB_DATE_END,PUB_MODE,RETURN_TYPE,PUB_ORGID,RETURN_DATE_START,RETURN_DATE_END,RETURN_CFM_DATE_START,RETURN_CFM_DATE_END,RETURN_STATE,PUB_TYPE,compositor, ordertype);
        System.out.println("退回确认："+sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * @Description: 安置部点发退回确认信息(查看)
     * @author: lihf
     */
    public Data findPUBCheck(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findPUBCheck",ID);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    public DataList findPUBConfirm(Connection conn,String id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findPUBConfirm",id);
    	DataList dl = ide.find(sql);
    	return dl;
    }
    
    //根据收养组织查找国家
    public Data findCountry(Connection conn,String orginId)throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findCountry",orginId);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    /**
     * @Description: 安置部确认点发退回
     * @author: lihf
     */
    public void findPUBReturn(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_PUB_RECORD");
    	dataedit.setPrimaryKey("PUB_ID");
    	dataedit.store();
    }
    
    /**
     * @Description: 收养组织点发退回查看列表
     * @author: lihf
     */
    public DataList findSYZZPUBRecordList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
    	//查询条件
    	String ORG_ID = data.getString("ORG_ID",null);   //组织机构ID
    	String PROVINCE_ID = data.getString("PROVINCE_ID",null);   //省份
    	String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String SN_TYPE = data.getString("SN_TYPE", null);   //病残种类
        String PUB_DATE_START = data.getString("PUB_DATE_START", null);   //开始发布日期
        String PUB_DATE_END = data.getString("PUB_DATE_END", null);   //结束发布日期
        String SETTLE_DATE_START = data.getString("SETTLE_DATE_START", null);   //开始安置期限
        String SETTLE_DATE_END = data.getString("SETTLE_DATE_END", null);   //结束安置期限
        String RETURN_DATE_START = data.getString("RETURN_DATE_START", null);   //开始退回日期
        String RETURN_DATE_END = data.getString("RETURN_DATE_END", null);   //结束退回日期
        String RETURN_CFM_DATE_START = data.getString("RETURN_CFM_DATE_START", null);   //开始退回确认日期
        String RETURN_CFM_DATE_END = data.getString("RETURN_CFM_DATE_END", null);   //结束退回确认日期
        String RETURN_STATE = data.getString("RETURN_STATE", null);   //退回状态
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPUBRecordList",ORG_ID,PROVINCE_ID,NAME_PINYIN, SEX, BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,PUB_DATE_START,PUB_DATE_END,SETTLE_DATE_START,SETTLE_DATE_END, RETURN_DATE_START,RETURN_DATE_END,RETURN_CFM_DATE_START,RETURN_CFM_DATE_END,RETURN_STATE,compositor, ordertype);
        System.out.println("sql--->"+sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * @Description: 收养组织根据PUB_ID查找点发退回详细信息
     * @author: lihf
     */
    public Data findSYZZPUBRecordDetail(Connection conn,Data data) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_PUB_RECORD");
    	dataedit.setPrimaryKey("PUB_ID");
    	DataList dl = ide.find(dataedit);
    	return dl.getData(0);
    	
    }
    
    /**
     * @Description: 添加退回原因
     * @author: lihf
     */
    public boolean findSYZZPUBRecordAddReason(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("SCE_PUB_RECORD");
    		dataList.getData(i).setPrimaryKey("PUB_ID");
    	}
    	int re = ide.batchStore(dataList);
    	if(re>0){
    		return true;
    	}else{
    		return false;
    	}
    	
    }
    
    public boolean updateChildMessage(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("CMS_CI_INFO");
    		dataList.getData(i).setPrimaryKey("CI_ID");
    	}
    	int re = ide.batchStore(dataList);
		if(re>0){
			return true;
		}else{
			return false;
		}
    }
    
    public DataList findCIDataList(Connection conn,String ids) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findCIDataListSQL",ids);
    	DataList dl = ide.find(sql);
    	return dl;
    	
    }
    
}
