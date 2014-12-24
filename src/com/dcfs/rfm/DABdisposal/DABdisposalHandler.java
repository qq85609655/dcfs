/**   
 * @Title: DABdisposalHandler.java 
 * @Package com.dcfs.rfm.DABdisposal 
 * @Description: �ɵ�������������Ϣ���в�ѯ�����á��鿴����������
 * @author panfeng;
 * @date 2014-9-25 ����7:42:16 
 * @version V1.0   
 */
package com.dcfs.rfm.DABdisposal;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.Map;


public class DABdisposalHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public DABdisposalHandler(){
		// TODO Auto-generated constructor stub
	}
	
	/**
     * @Description: ��������״̬���� 
     * Data ��װ����  ���£�
     * 1��AF_ID 
     * 2��RETURN_STATE ����״̬ ����Ϊ��2��
     * @param conn
     * @param dl
     * @return
     */
	public boolean updateReturnState(Connection conn, DataList dl) throws DBException {
		  IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    //***�����ļ���Ϣ��*****
        for(int i=0;i<dl.size();i++){
        	dl.getData(i).setConnection(conn);
    	    dl.getData(i).setEntityName("FFS_AF_INFO");
    	    dl.getData(i).setPrimaryKey("AF_ID");
        }
        ide.batchStore(dl);
        //***�������ļ�¼��*****
        for(int i=0;i<dl.size();i++){
        	dl.getData(i).setEntityName("RFM_AF_REVOCATION");
        	dl.getData(i).setPrimaryKey("AF_ID");
        	//TODO:�Ƿ����һ����������������״̬
        }
        ide.batchStore(dl);
        return true;
    }
	
	/**
	 * @throws DBException  
	 * @Title: DABdisposalList 
	 * @Description: ���Ĵ�����Ϣ�б�
	 * @author: panfeng;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return    �趨�ļ� 
	 * @return DataList    �������� 
	 * @throws 
	 */
	public DataList DABdisposalList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String APPLE_DATE_START = data.getString("APPLE_DATE_START", null);	//���뿪ʼ����
		String APPLE_DATE_END = data.getString("APPLE_DATE_END", null);	//�����������
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String RETREAT_DATE_START = data.getString("RETREAT_DATE_START", null);	//ȷ����ʼ����
		String RETREAT_DATE_END = data.getString("RETREAT_DATE_END", null);	//ȷ�Ͻ�ֹ����
		String RETURN_STATE = data.getString("RETURN_STATE", null);	//����״̬
		String HANDLE_TYPE = data.getString("HANDLE_TYPE", null);	//���Ĵ��÷�ʽ
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String DUAL_USERNAME = data.getString("DUAL_USERNAME", null);	//������
		String DUAL_DATE_START = data.getString("DUAL_DATE_START", null);	//������ʼ����
		String DUAL_DATE_END = data.getString("DUAL_DATE_END", null);	//���ý�ֹ����
		String APPLE_TYPE = data.getString("APPLE_TYPE", null);	//��������
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("DABdisposalList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, RETREAT_DATE_START, RETREAT_DATE_END, RETURN_STATE, HANDLE_TYPE, COUNTRY_CODE, ADOPT_ORG_ID, DUAL_USERNAME, DUAL_DATE_START, DUAL_DATE_END, APPLE_TYPE,compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * ����ID������������ļ�¼
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList disposalShow(Connection conn, String arIds) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("disposalShow", arIds);
		DataList dl = ide.find(sql);
		return dl;
	}
	
	/**
	 * �������ļ�¼��ID������ļ�¼
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getReturnData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getReturnData", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: BGSconfirmSave 
	 * @Description: ����������Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param data fileData
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 */
	public boolean BGSconfirmSave(Connection conn, Map<String, Object> data, Map<String, Object> fileData)
            throws DBException {
		//***�����ļ���Ϣ��*****
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        if ("".equals(dataadd.getString("AF_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
	    //***�������ļ�¼��*****
        Data dataadd2 = new Data(data);
        dataadd2.setConnection(conn);
        dataadd2.setEntityName("RFM_AF_REVOCATION");
        dataadd2.setPrimaryKey("AR_ID");
        if ("".equals(dataadd2.getString("AR_ID", ""))) {
            dataadd2.create();
        } else {
            dataadd2.store();
        }
        return true;
    }
	
	
}
