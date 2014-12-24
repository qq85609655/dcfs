/**   
 * @Title: BalanceAccountHandler.java 
 * @Package com.dcfs.fam.balanceAccount 
 * @Description: ������֯�����˻�����
 * @author yangrt   
 * @date 2014-10-23 ����3:46:39 
 * @version V1.0   
 */
package com.dcfs.fam.balanceAccount;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: BalanceAccountHandler 
 * @Description: ������֯�����˻�����
 * @author yangrt;
 * @date 2014-10-23 ����3:46:39 
 *  
 */
public class BalanceAccountHandler extends BaseHandler {

	/**
	 * @Title: BalanceAccountList 
	 * @Description: ������֯�����˻���ѯ�б�
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException  
	 */
	public DataList BalanceAccountList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String ADOPT_ORG_NO = data.getString("ADOPT_ORG_NO", null);	//������֯���
		String ACCOUNT_CURR = data.getString("ACCOUNT_CURR", null);	//��ǰ���
		String ACCOUNT_LMT = data.getString("ACCOUNT_LMT", null);	//͸֧���
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("BalanceAccountList",COUNTRY_CODE,ADOPT_ORG_ID,ADOPT_ORG_NO,ACCOUNT_CURR,ACCOUNT_LMT, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: BalanceAccountSave 
	 * @Description: ������֯�����˻���Ϣ����
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean 
	 * @throws DBException 
	 */
	public boolean BalanceAccountSave(Connection conn, Data data) throws DBException {
		data.setConnection(conn);
		data.setEntityName("MKR_ADOPT_ORG_INFO");
		data.setPrimaryKey("ADOPT_ORG_ID");
		data.store();
		return true;
	}

	/**
	 * @Title: BalanceAccountDetailList 
	 * @Description: ������֯�����˻���ϸ�б�
	 * @author: yangrt
	 * @param conn
	 * @param ADOPT_ORG_ID
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList BalanceAccountDetailList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);			//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);			//������֯CODE
		String OPP_DATE_START = data.getString("OPP_DATE_START", null);		//�˵���ʼ����
		String OPP_DATE_END = data.getString("OPP_DATE_END", null);			//�˵���ֹ����
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("BalanceAccountDetailList", COUNTRY_CODE, ADOPT_ORG_ID, OPP_DATE_START, OPP_DATE_END, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
}
