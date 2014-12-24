package com.dcfs.fam.billRegistration;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import com.hx.upload.sdk.AttHelper;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: BillRegistrationHandler 
 * @Description: 票据登记handler类
 * @author panfeng
 * @date 2014-11-14
 *  
 */
public class BillRegistrationHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public BillRegistrationHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 票据登记列表
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList billRegistrationList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String PAID_NO = data.getString("PAID_NO", null);	//缴费编号
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String COST_TYPE = data.getString("COST_TYPE", null);	//费用类型
		String PAID_WAY = data.getString("PAID_WAY", null);	//缴费方式
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//应缴金额
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//票面金额
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REG_DATE_START = data.getString("REG_DATE_START", null);	//开始录入日期
		String REG_DATE_END = data.getString("REG_DATE_END", null);	//结束录入日期
		String CHEQUE_TRANSFER_STATE = data.getString("CHEQUE_TRANSFER_STATE", null);	//移交状态
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("billRegistrationList", PAID_NO, COUNTRY_CODE, ADOPT_ORG_ID, COST_TYPE, PAID_WAY, PAID_SHOULD_NUM, PAR_VALUE, FILE_NO, REG_DATE_START, REG_DATE_END, CHEQUE_TRANSFER_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
     * 选择文件添加列表
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList selectFileList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype, String COUNTRY_CODE, String ADOPT_ORG_ID, String PAID_NO)
            throws DBException{
    	
		//查询条件
    	String FILE_NO = data.getString("FILE_NO", null);//文件编号
    	String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);//收文日期起始
    	String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);//收文日期截止
//		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);//国家
//		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);//收养组织
		String FILE_TYPE = data.getString("FILE_TYPE", null);//文件类型
		String AF_COST = data.getString("AF_COST",null); //应缴金额
		String MALE_NAME = data.getString("MALE_NAME", null);//男收养人姓名
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);//女收养人姓名
//		String AF_COST_PAID = data.getString("AF_COST_PAID",null); //缴费状态
		//数据操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    String sql = getSql("selectFileList",COUNTRY_CODE,ADOPT_ORG_ID,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,FILE_TYPE,MALE_NAME,FEMALE_NAME,AF_COST,PAID_NO,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
    	return dl;
    	
    }
	
    /**
	 * 根据票据ID查询票据信息
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getShowData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getShowData", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * 根据票据ID查询票据登记信息和票据催缴信息
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getBothData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getBothData", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * 根据票据中的文件编号统计应缴总金额
	 *
	 * @param conn
	 * @param checkId
	 * @return
	 * @throws DBException
	 */
	public Data getSum(Connection conn, String wjbh) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getSum", wjbh));
		return dataList.getData(0);
	}
	
	/**
	 * 根据文件编号查询文件列表
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList showFileList(Connection conn, String fileno) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("showFileList", fileno);
		DataList dl = ide.find(sql);
		return dl;
	}
	
    
	/**
	 * 保存文件信息
	 * @author panfeng
	 * @param conn
	 * @param fileData
	 * @return
	 * @throws DBException
	 */
	public Data saveFile(Connection conn, Map<String, Object> fileData, boolean iscreate)
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
     * 保存票据信息
     * @author panfeng
     * @param conn
     * @param billData
     * @return Data
     * @throws DBException
     */
    public Data saveBill(Connection conn, Map<String, Object> billData)
    		throws DBException {
    	Data dataadd = new Data(billData);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FAM_CHEQUE_INFO");
    	dataadd.setPrimaryKey("CHEQUE_ID");
    	if ("".equals(dataadd.getString("CHEQUE_ID", ""))) {
    		dataadd = dataadd.create();
        } else {
        	dataadd = dataadd.store();
        }
        return dataadd;
    	
    }
    
    /**
	 * @throws DBException  
	 * @Title: billDelete 
	 * @Description: 根据ID删除未提交的票据信息
	 * @author: panfeng;
	 * @param conn
	 * @param uuid
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean billDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList deleteList = new DataList();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FAM_CHEQUE_INFO");
			data.setPrimaryKey("CHEQUE_ID");
			data.add("CHEQUE_ID", uuid[i]);
			deleteList.add(data);
			
		}
		ide.remove(deleteList);
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: billDelete 
	 * @Description: 根据收文编号更新文件信息
	 * @author: panfeng;
	 * @param conn
	 * @param uuid
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean fileUpdate(Connection conn, String[] fileNo) throws DBException {
		
		for (int i = 0; i < fileNo.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("FILE_NO");
			data.add("FILE_NO", fileNo[i]);
			data.add("AF_COST_PAID", "0");
			data.add("PAID_NO", "");
			data.store();
		}
		return true;
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: updateData 
	 * @Description: 根据文件ID清空缴费编号
	 * @author: panfeng;
	 * @param conn
	 * @param uuid
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean updateData(Connection conn, String[] uuid) throws DBException {
		
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("AF_ID");
			data.add("AF_ID", uuid[i]);
			data.add("PAID_NO", "");
			data.store();
		}
		return true;
	}

	
    
	
}
