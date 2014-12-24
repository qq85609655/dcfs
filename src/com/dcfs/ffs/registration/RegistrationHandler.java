/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 下午3:00:55 
 * @version V1.0   
 */
package com.dcfs.ffs.registration;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: RegistrationHandler 
 * @Description: 收养登记handler类
 * @author Mayun
 * @date 2014-7-15
 *  
 */
public class RegistrationHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public RegistrationHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 文件手工登记列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList FileHandReg(Connection conn, String regId) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getChooseFileData", regId);
		DataList dl = ide.find(sql);
		return dl;
	}
	
	 /**
     * 新增文件代录
     * @author MaYun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList saveFlieRecord(Connection conn, Map<String, Object> fileData,Map<String, Object> billData)
            throws DBException {
    	//***保存文件信息*****
    	DataList returnDataList = new DataList();
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        if ("".equals(dataadd.getString("AF_ID", ""))) {
        	returnDataList.add(dataadd.create());
        } else {
        	returnDataList.add(dataadd.store());
        }
        
      //***保存票据费用信息*****
        Data dataadd2 = new Data(billData);
        String isPj = dataadd2.getString("ISPIAOJUVALUE");//是否填写票据信息，0：否  1：是 
        dataadd2.remove("ISPIAOJUVALUE");
        if(isPj=="1"||isPj.equals("1")){//从页面获得是否填写票据信息，如果为1即填写票据信息，则向票据信息表里保存数据
        	dataadd2.setConnection(conn);
            dataadd2.setEntityName("FAM_CHEQUE_INFO");
            dataadd2.setPrimaryKey("CHEQUE_ID");
            if ("".equals(dataadd2.getString("CHEQUE_ID", ""))) {
                returnDataList.add(dataadd2.create());
            } else {
                returnDataList.add(dataadd2.store());
            }
        }
        
        return returnDataList;
    }
    
    /**
     * 文件批量代录（文件信息）
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveBatchFlieRecord(Connection conn, Map<String, Object> fileData, boolean iscreate)
    		throws DBException {
    	//***保存文件信息*****
    	Data dataadd = new Data(fileData);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FFS_AF_INFO");
    	dataadd.setPrimaryKey("AF_ID");
    	if (iscreate) {
    		return dataadd.create();
    	} else {
    		return dataadd.store();
    	}
    	
    }
    
    /**
     * 文件批量代录（费用信息）
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    
    public DataList saveBatchCostRecord(Connection conn, Map<String, Object> billData)
    		throws DBException {
    	//***保存文件信息*****
    	DataList returnDataList = new DataList();
    	Data dataadd2 = new Data(billData);
    	String isPj = dataadd2.getString("ISPIAOJUVALUE");//是否填写票据信息，0：否  1：是 
    	dataadd2.remove("ISPIAOJUVALUE");
    	if(isPj=="1"||isPj.equals("1")){//从页面获得是否填写票据信息，如果为1即填写票据信息，则向票据信息表里保存数据
    		dataadd2.setConnection(conn);
    		dataadd2.setEntityName("FAM_CHEQUE_INFO");
    		dataadd2.setPrimaryKey("CHEQUE_ID");
    		if ("".equals(dataadd2.getString("CHEQUE_ID", ""))) {
    			returnDataList.add(dataadd2.create());
    		} else {
    			returnDataList.add(dataadd2.store());
    		}
    	}
    	
    	return returnDataList;
    }
    
    /**
     * 文件批量代录（预批信息）
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    
    public boolean saveSceReqInfo(Connection conn, String[] ri_ids)
    		throws DBException {
    	for (int i = 0; i < ri_ids.length; i++) {
    		Data dataadd = new Data();
    		dataadd.setConnection(conn);
    		dataadd.setEntityName("SCE_REQ_INFO");
    		dataadd.setPrimaryKey("RI_ID");
    		dataadd.add("RI_ID", ri_ids[i]);
    		dataadd.add("RI_STATE", "6");//预批状态为“已启动”
    		
    		dataadd.store();
    	}
    	return true;
    }
    
    /**
	 * 批量条形码打印预览
	 *
	 * @param conn
	 * @param printId
	 * @return
	 * @throws DBException
	 * @throws ParseException 
	 */
	public DataList getPrintData(Connection conn, String printId) throws DBException, ParseException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getChooseFileData", printId);
		DataList dl = ide.find(sql);
		return dl;
	}

	
	/**
	 * 文件登记列表
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String AF_SEQ_NO = data.getString("AF_SEQ_NO", null);	//流水号
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String AF_COST = data.getString("AF_COST", null);	//应缴金额
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//提交开始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);	//提交结束日期
		String REG_STATE = data.getString("REG_STATE", null);	//登记状态
		if (REG_STATE == null){
			REG_STATE = "'1'";
		}
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findList", AF_SEQ_NO, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, AF_COST, SUBMIT_DATE_START, SUBMIT_DATE_END, REG_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 原收文编号列表
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList choseFileFindList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME", null);	//男方
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//女方
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("choseFileFindList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME,compositor, ordertype);
		System.out.println("choseFileFindListSql-->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * 查看
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getShowData(Connection conn, String uuid, String fileno) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getShowData", fileno, uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: getChildDataList 
	 * @Description: 根据儿童材料ID获取儿童详细信息
	 * @author: panfeng;
	 * @param conn
	 * @param ci_id
	 * @return    设定文件 
	 * @return DataList    返回类型 
	 * @throws 
	 */
	public DataList getChildDataList(Connection conn, String str_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ci_id = "'";
		if(str_id.indexOf(",") > 0){
			String[] child_id = str_id.split(",");
			for(int i = 0; i < child_id.length; i++){
				ci_id += child_id[i] + "','";
			}
			ci_id = ci_id.substring(0, ci_id.lastIndexOf(","));
		}else{
			ci_id += str_id + "'";
		}
		String sql = getSql("getChildDataList",ci_id);
		dl = ide.find(sql);
		return dl;
	}
	
	/**
     * 新增文件退回
     * @author yangrt
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public void saveFlieReturnReason(Connection conn, Map<String, Object> fileData) throws DBException {
    	//保存文件退回信息
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        dataadd.store();
        
    }
}
