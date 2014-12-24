/**   
 * @Title: ReceiveConfirmHandler.java 
 * @Package com.dcfs.fam.receiveConfirm 
 * @Description: ���ù���-����ȷ��
 * @author yangrt   
 * @date 2014-10-21 ����9:02:15 
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
 * @Description: ���ù���-����ȷ��
 * @author yangrt
 * @date 2014-10-21 ����9:02:15 
 *  
 */
public class ReceiveConfirmHandler extends BaseHandler {

	/**
	 * @throws DBException  
	 * @Title: ReceiveConfirmList 
	 * @Description: ����ȷ�ϲ�ѯ�б�
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
		//��ѯ����
		String PAID_NO = data.getString("PAID_NO", null);	//�ɷѱ��
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String COST_TYPE = data.getString("COST_TYPE", null);	//��������
		String PAID_WAY = data.getString("PAID_WAY", null);	//�ɷѷ�ʽ
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//Ӧ�ɽ��
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//Ʊ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START", null);	//��ʼ��������
		String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END", null);	//������������
		String ARRIVE_STATE = data.getString("ARRIVE_STATE", null);	//����״̬
		String ARRIVE_VALUE = data.getString("ARRIVE_VALUE", null);	//���˽��
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//������ʼ����
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//���˽�ֹ����
		String ARRIVE_ACCOUNT_VALUE = data.getString("ARRIVE_ACCOUNT_VALUE", null);	//�����˻�ʹ�ý��
		String ACCOUNT_CURR = data.getString("ACCOUNT_CURR", null);	//�����˻��ܽ��
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ReceiveConfirmList",PAID_NO,COUNTRY_CODE,ADOPT_ORG_ID,COST_TYPE,PAID_WAY,PAID_SHOULD_NUM,PAR_VALUE,FILE_NO,RECEIVE_DATE_START,RECEIVE_DATE_END,ARRIVE_STATE,ARRIVE_VALUE,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_ACCOUNT_VALUE,ACCOUNT_CURR, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: getFamChequeInfoById 
	 * @Description: ����Ʊ�ݵǼ�id,��ȡƱ����Ϣ
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
	 * @Description: ����ȷ����Ϣ����
	 * @author: yangrt
	 * @param conn
	 * @param pjdata
	 * @param zhdata
	 * @param sydata
	 * @param isUsed
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean ReceiveConfirmSave(Connection conn, Data pjdata,	Data zhdata, Data sydata) throws DBException {
		//����Ʊ�ݵǼ���Ϣ��
		pjdata.setConnection(conn);
		pjdata.setEntityName("FAM_CHEQUE_INFO");
		pjdata.setPrimaryKey("CHEQUE_ID");
		pjdata.store();
		
		//����������֯�����Ϣ
		zhdata.setConnection(conn);
		zhdata.setEntityName("MKR_ADOPT_ORG_INFO");
		zhdata.setPrimaryKey("ADOPT_ORG_ID");
		zhdata.store();
		
		if(!"".equals(sydata.getString("OPP_TYPE",""))){
			//��������˻�ʹ�ü�¼
			sydata.setConnection(conn);
			sydata.setEntityName("FAM_ACCOUNT_LOG");
			sydata.setPrimaryKey("ACCOUNT_LOG_ID");
			sydata.create();
		}
		
		String state = pjdata.getString("ARRIVE_STATE");	//����״̬��1����2�����㣩
		if(state.equals("1")){
			DataList dl = new DataList();
			Map<String, Object>  m = new HashMap<String, Object> ();
			m.put("AF_COST_CLEAR", "1");	//������Ϣ_���״̬(1�������)
			m.put("AF_COST_PAID", state);		//������Ϣ_�ɷ�״̬
			
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
