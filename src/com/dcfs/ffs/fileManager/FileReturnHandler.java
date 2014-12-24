/**   
 * @Title: FileReturnHandler.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: ��������֯���ļ���Ϣ���в�ѯ���������롢��������
 * @author panfeng;
 * @date 2014-9-2 ����3:01:44 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

public class FileReturnHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public FileReturnHandler(){
		// TODO Auto-generated constructor stub
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: ReturnFileList 
	 * @Description: ������Ϣ�б�
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
	public DataList ReturnFileList(Connection conn, Data data, int pageSize,
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
		String DUAL_USERNAME = data.getString("DUAL_USERNAME", null);	//������
		String DUAL_DATE_START = data.getString("DUAL_DATE_START", null);	//������ʼ����
		String DUAL_DATE_END = data.getString("DUAL_DATE_END", null);	//���ý�ֹ����
		String RETURN_STATE = data.getString("RETURN_STATE", null);	//����״̬
		String HANDLE_TYPE = data.getString("HANDLE_TYPE", null);	//���Ĵ��÷�ʽ
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//��ǰ�û�������֯
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ReturnFileList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, DUAL_USERNAME, DUAL_DATE_START, DUAL_DATE_END, RETURN_STATE, HANDLE_TYPE, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: ReturnApplyList 
	 * @Description: ���������б�
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
	public DataList ReturnApplyList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String PAUSE_DATE_START = data.getString("PAUSE_DATE_START", null);	//��ͣ��ʼ����
		String PAUSE_DATE_END = data.getString("PAUSE_DATE_END", null);	//��ͣ��������
		String RECOVERY_STATE = data.getString("RECOVERY_STATE", null);	//��ͣ״̬
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//��ǰ�û�������֯
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ReturnApplyList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, FEMALE_NAME, FILE_TYPE, PAUSE_DATE_START, PAUSE_DATE_END, RECOVERY_STATE, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	/**
	 * ��ת����������ȷ��ҳ��
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
	 * @Title: ReturnFileSave 
	 * @Description: ������������ȷ����Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param aadata
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 */
	public boolean ReturnFileSave(Connection conn, Map<String, Object> data, Map<String, Object> fileData)
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
