/**   
 * @Title: AZQconfirmHandler.java 
 * @Package com.dcfs.rfm.AZQconfirm 
 * @Description: �ɷ��빫˾��������Ϣ���в�ѯ��ȷ�ϡ��鿴��ȡ�����ġ���������
 * @author panfeng;
 * @date 2014-9-28 ����11:45:51 
 * @version V1.0   
 */
package com.dcfs.rfm.AZQconfirm;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;


public class AZQconfirmHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public AZQconfirmHandler(){
		// TODO Auto-generated constructor stub
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: AZQconfirmList 
	 * @Description: ����ȷ����Ϣ�б�
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
	public DataList AZQconfirmList(Connection conn, Data data, int pageSize,
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
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//��ǰ�û�����
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("AZQconfirmList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, RETREAT_DATE_START, RETREAT_DATE_END, RETURN_STATE, HANDLE_TYPE, COUNTRY_CODE, ADOPT_ORG_ID, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * ��ת������ȷ��ҳ��
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data confirmShow(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("confirmShow", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: AZQconfirmSave 
	 * @Description: ����������Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param data fileData
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 */
	public boolean AZQconfirmSave(Connection conn, Map<String, Object> data, Map<String, Object> fileData)
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
	
	/**
	 * @throws DBException  
	 * @Title: returnFileDelete 
	 * @Description: ����ȡ��������Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param uuid file_uuid
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean returnFileDelete(Connection conn, String[] uuid, String[] file_uuid) throws DBException {
		//�������ļ�¼������״̬
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("RFM_AF_REVOCATION");
			data.setPrimaryKey("AR_ID");
			data.add("AR_ID", uuid[i]);
			data.add("ORG_ID",SessionInfo.getCurUser().getCurOrgan().getOrgCode());//ȷ�ϲ���ID
			data.add("PERSON_ID",SessionInfo.getCurUser().getPerson().getPersonId());//ȷ����ID
			data.add("PERSON_NAME",SessionInfo.getCurUser().getPerson().getCName());//ȷ����
			data.add("RETREAT_DATE",DateUtility.getCurrentDate());//ȷ������
			data.add("RETURN_STATE", "9");//�������״̬Ϊ"ȡ������"
			data.store();
		}
		//ɾ���ļ���Ϣ������״̬������ԭ��
		for (int i = 0; i < file_uuid.length; i++) {
			Data data2 = new Data();
			data2.setConnection(conn);
			data2.setEntityName("FFS_AF_INFO");
			data2.setPrimaryKey("AF_ID");
			data2.add("AF_ID", file_uuid[i]);
			data2.add("RETURN_STATE", "");//�������״̬
			data2.add("RETURN_REASON", "");//�������ԭ��
			data2.store();
		}
		return true;
	}
	
	
}
