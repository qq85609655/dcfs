/**   
 * @Title: PauseFileHandler.java 
 * @Package com.dcfs.ffs.pause 
 * @Description: �ɰ칫�Ҷ��ļ���Ϣ���в�ѯ����ͣ��ȡ����ͣ�����ġ��޸���ͣ���ޡ���������
 * @author panfeng;
 * @date 2014-9-2 ����3:01:44 
 * @version V1.0   
 */
package com.dcfs.ffs.pause;

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

public class PauseFileHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public PauseFileHandler(){
		// TODO Auto-generated constructor stub
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: pauseFileList 
	 * @Description: �ļ���ͣ��Ϣ�б�
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
	public DataList pauseFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String PAUSE_UNITNAME = data.getString("PAUSE_UNITNAME", null);	//��ͣ����
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String RECOVERY_STATE = data.getString("RECOVERY_STATE", null);	//��ͣ״̬
		String PAUSE_DATE_START = data.getString("PAUSE_DATE_START", null);	//��ʼȡ������
		String PAUSE_DATE_END = data.getString("PAUSE_DATE_END", null);	//��ֹȡ������
		String RECOVERY_DATE_START = data.getString("RECOVERY_DATE_START", null);	//��ʼȡ����ͣ����
		String RECOVERY_DATE_END = data.getString("RECOVERY_DATE_END", null);	//��ֹȡ����ͣ����
		String AF_POSITION = data.getString("AF_POSITION", null);	//�ļ�λ��
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("pauseFileList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, PAUSE_UNITNAME, MALE_NAME, FEMALE_NAME, RECOVERY_STATE, PAUSE_DATE_START, PAUSE_DATE_END, RECOVERY_DATE_START, RECOVERY_DATE_END, AF_POSITION, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: pauseSearchList 
	 * @Description: ������֯�ļ���ͣ��Ϣ�б�
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
	public DataList pauseSearchList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String PAUSE_UNITNAME = data.getString("PAUSE_UNITNAME", null);	//��ͣ����
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String RECOVERY_STATE = data.getString("RECOVERY_STATE", null);	//��ͣ״̬
		String PAUSE_DATE_START = data.getString("PAUSE_DATE_START", null);	//��ʼȡ������
		String PAUSE_DATE_END = data.getString("PAUSE_DATE_END", null);	//��ֹȡ������
		String RECOVERY_DATE_START = data.getString("RECOVERY_DATE_START", null);	//��ʼȡ����ͣ����
		String RECOVERY_DATE_END = data.getString("RECOVERY_DATE_END", null);	//��ֹȡ����ͣ����
		String AF_POSITION = data.getString("AF_POSITION", null);	//�ļ�λ��
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//��ǰ�û�������֯
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("pauseSearchList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, orgcode, PAUSE_UNITNAME, MALE_NAME, FEMALE_NAME, RECOVERY_STATE, PAUSE_DATE_START, PAUSE_DATE_END, RECOVERY_DATE_START, RECOVERY_DATE_END, AF_POSITION, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: pauseChoiceList 
	 * @Description: ��ͣ�ļ�ѡ���б�
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
	public DataList pauseChoiceList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String NAME = data.getString("NAME", null);	//����
		String AF_POSITION = data.getString("AF_POSITION", null);	//�ļ�λ��
		String AF_GLOBAL_STATE = data.getString("AF_GLOBAL_STATE", null);	//�ļ�״̬
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("pauseChoiceList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, NAME, AF_POSITION, AF_GLOBAL_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * �����ļ�ID��ѯ���ļ���ͣ��Ϣ
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
	 * ������ͣ��¼ID��ѯ���ļ���ͣ��Ϣ
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data pauseSearchShow(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("pauseSearchShow", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: pauseFileSave 
	 * @Description: �����ļ���ͣȷ����Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param fileData; pauseData 
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 */
	public boolean pauseFileSave(Connection conn, Map<String, Object> fileData, Map<String, Object> pauseData)
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
        
        //***������ͣ��¼��*****
        Data dataadd2 = new Data(pauseData);
        dataadd2.setConnection(conn);
        dataadd2.setEntityName("FFS_AF_PAUSE");
        dataadd2.setPrimaryKey("AP_ID");
        if ("".equals(dataadd2.getString("AP_ID", ""))) {
        	dataadd2.create();
        } else {
        	dataadd2.store();
        }
        
        return true;
    }
	
	/**
	 * @throws DBException  
	 * @Title: fileRecovery 
	 * @Description: �ļ�ȡ����ͣ����
	 * @author: panfeng;
	 * @param conn
	 * @param recuuid
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean fileRecovery(Connection conn, String fileuuid, String recuuid) throws DBException {
		
		//***�����ļ���Ϣ��*****
        Data filedata = new Data();
        filedata.setConnection(conn);
        filedata.setEntityName("FFS_AF_INFO");
        filedata.setPrimaryKey("AF_ID");
        filedata.add("AF_ID", fileuuid);
        filedata.add("IS_PAUSE", "0");//��ͣ��ʶ��Ϊ"n"
        filedata.add("PAUSE_DATE", "");//�����ͣ����
        filedata.add("PAUSE_REASON", "");//�����ͣԭ��
        filedata.store();
        
        //***������ͣ��¼��*****
		UserInfo curuser = SessionInfo.getCurUser();
		Data data = new Data();
		data.setConnection(conn);
		data.setEntityName("FFS_AF_PAUSE");
		data.setPrimaryKey("AP_ID");
		data.add("AP_ID", recuuid);
		data.add("RECOVERY_STATE", "9");//��ͣ״̬��Ϊ"ȡ����ͣ"
		data.add("RECOVERY_DATE", DateUtility.getCurrentDate());//ȡ����ͣʱ��
		data.add("RECOVERY_USERID", curuser.getPersonId());//ȡ����ͣ��ID
		data.add("RECOVERY_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//ȡ����ͣ��
		data.store();
		return true;
	}
	
}
