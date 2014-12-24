/**   
 * @Title: ReceiveConfirmHandler.java 
 * @Package com.dcfs.fam.receiveConfirm 
 * @Description: 费用管理-到账确认
 * @author yangrt   
 * @date 2014-10-21 下午9:02:15 
 * @version V1.0   
 */
package com.dcfs.fam.receiveConfirm;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: ReceiveConfirmHandler 
 * @Description: 费用管理-到账确认
 * @author yangrt
 * @date 2014-10-21 下午9:02:15 
 *  
 */
public class ReceiveConfirmHandler extends BaseHandler {

	/**
	 * @throws DBException  
	 * @Title: ReceiveConfirmList 
	 * @Description: 到账确认查询列表
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 */
	public DataList ReceiveConfirmList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String PAID_NO = data.getString("PAID_NO", null);	//缴费编号
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//国家
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//收养组织
		String COST_TYPE = data.getString("COST_TYPE", null);	//费用类型
		String PAID_WAY = data.getString("PAID_WAY", null);	//缴费方式
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//应缴金额
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//票面金额
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START", null);	//开始接收日期
		String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END", null);	//结束接收日期
		String ARRIVE_STATE = data.getString("ARRIVE_STATE", null);	//到账状态
		String ARRIVE_VALUE = data.getString("ARRIVE_VALUE", null);	//到账金额
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//到账起始日期
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//到账截止日期
		String ARRIVE_ACCOUNT_VALUE = data.getString("ARRIVE_ACCOUNT_VALUE", null);	//结余账户使用金额
		String ACCOUNT_CURR = data.getString("ACCOUNT_CURR", null);	//结余账户总金额
		
		//数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ReceiveConfirmList",PAID_NO,COUNTRY_CODE,ADOPT_ORG_ID,COST_TYPE,PAID_WAY,PAID_SHOULD_NUM,PAR_VALUE,FILE_NO,RECEIVE_DATE_START,RECEIVE_DATE_END,ARRIVE_STATE,ARRIVE_VALUE,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_ACCOUNT_VALUE,ACCOUNT_CURR, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: getFamChequeInfoById 
	 * @Description: 根据票据登记id,获取票据信息
	 * @author: yangrt
	 * @param conn
	 * @param CHEQUE_ID
	 * @return Data 
	 * @throws DBException
	 */
	public Data getFamChequeInfoById(Connection conn, String CHEQUE_ID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFamChequeInfoById", CHEQUE_ID);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}

	/**
	 * @throws DBException  
	 * @Title: ReceiveConfirmSave 
	 * @Description: 到账确认信息保存
	 * @author: yangrt
	 * @param conn
	 * @param pjdata
	 * @param zhdata
	 * @param sydata
	 * @param isUsed
	 * @return    设定文件 
	 * @return boolean    返回类型 
	 * @throws 
	 */
	public boolean ReceiveConfirmSave(Connection conn, Data pjdata,	Data zhdata, Data sydata) throws DBException {
		//更新票据登记信息表
		pjdata.setConnection(conn);
		pjdata.setEntityName("FAM_CHEQUE_INFO");
		pjdata.setPrimaryKey("CHEQUE_ID");
		pjdata.store();
		
		//更新收养组织余额信息
		zhdata.setConnection(conn);
		zhdata.setEntityName("MKR_ADOPT_ORG_INFO");
		zhdata.setPrimaryKey("ADOPT_ORG_ID");
		zhdata.store();
		
		if(!"".equals(sydata.getString("OPP_TYPE",""))){
			//创建余额账户使用记录
			sydata.setConnection(conn);
			sydata.setEntityName("FAM_ACCOUNT_LOG");
			sydata.setPrimaryKey("ACCOUNT_LOG_ID");
			sydata.create();
		}
		
		String state = pjdata.getString("ARRIVE_STATE");	//到账状态（1：足额；2：不足）
		if(state.equals("1")){
			DataList dl = new DataList();
			Map<String, Object>  m = new HashMap<String, Object> ();
			m.put("AF_COST_CLEAR", "1");	//费用信息_完费状态(1：已完费)
			m.put("AF_COST_PAID", state);		//费用信息_缴费状态
			
			String file_no = pjdata.getString("FILE_NO");
			if(file_no.contains(",")){
				String[] fileNo = file_no.split(",");
				for(int i = 0; i < fileNo.length; i++){
					m.put("FILE_NO", fileNo[i]);
					Data data = new Data();
					data.setEntityName("FFS_AF_INFO");
					data.setPrimaryKey("FILE_NO");
					data.setData(m);
					dl.add(data);
				}
			}else{
				m.put("FILE_NO", file_no);
				m.put("AF_COST_PAID", state);
				Data data = new Data();
				data.setEntityName("FFS_AF_INFO");
				data.setPrimaryKey("FILE_NO");
				data.setData(m);
				dl.add(data);
			}
			IDataExecute ide = DataBaseFactory.getDataBase(conn);
			ide.batchStore(dl);
	   	}
		return true;
	}
}
