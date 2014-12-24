/**   
 * @Title: ExtensionApplyHandler.java 
 * @Package com.dcfs.sce.extensionApply 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author yangrt   
 * @date 2014-9-29 ����9:59:27 
 * @version V1.0   
 */
package com.dcfs.sce.extensionApply;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;

/** 
 * @ClassName: ExtensionApplyHandler 
 * @Description: TODO(������һ�仰��������������) 
 * @author yangrt;
 * @date 2014-9-29 ����9:59:27 
 *  
 */
public class ExtensionApplyHandler extends BaseHandler {

	/**
	 * @Title: ExtensionApplyList 
	 * @Description: �������������б�
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
	public DataList ExtensionApplyList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String MALE_NAME = data.getString("MALE_NAME",null);	//��������
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//Ů������
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);	//��ͯ����ƴ��
		String SEX = data.getString("SEX",null);	//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//��ͯ������ֹ����
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);	//ԭ�ݽ�������ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//ԭ�ݽ����޽�ֹ����
		String REQ_SUBMIT_DATE_START = data.getString("REQ_SUBMIT_DATE_START",null);	//�µݽ�������ʼ����
		String REQ_SUBMIT_DATE_END = data.getString("REQ_SUBMIT_DATE_END",null);	//�µݽ����޽�ֹ����
		String AUDIT_STATE = data.getString("AUDIT_STATE",null);	//��������״̬
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ExtensionApplyList", MALE_NAME, FEMALE_NAME, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REQ_SUBMIT_DATE_START, REQ_SUBMIT_DATE_END, AUDIT_STATE, compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: PreApproveApplySelect 
	 * @Description: Ԥ�������¼ѡ���ѯ�б�
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList PreApproveApplySelect(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String MALE_NAME = data.getString("MALE_NAME",null);	//������������
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//Ů����������
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);	//��ͯ����
		String SEX = data.getString("SEX",null);	//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//��ͯ������ֹ����
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//������ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//�����ֹ����
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//Ԥ��ͨ����ʼ����
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);	//Ԥ��ͨ����ֹ����
		String RI_STATE = data.getString("RI_STATE",null);	//Ԥ��״̬
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);	//�ݽ��ļ���ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//�ݽ��ļ���ֹ����
		String REMINDERS_STATE = data.getString("REMINDERS_STATE",null);	//�߰�״̬
		String REM_DATE_START = data.getString("REM_DATE_START",null);	//�߰���ʼ����
		String REM_DATE_END = data.getString("REM_DATE_END",null);	//�߰��ֹ����
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);	//������ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END",null);	//���Ľ�ֹ����
		String FILE_NO = data.getString("FILE_NO",null);	//���ı��
		String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);	//�ļ���������ʼ����
		String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);	//�ļ������½�ֹ����
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveApplySelect", MALE_NAME,FEMALE_NAME,NAME_PINYIN,SEX,
        		BIRTHDAY_START,BIRTHDAY_END,REQ_DATE_START,REQ_DATE_END,PASS_DATE_START,
        		PASS_DATE_END,RI_STATE,SUBMIT_DATE_START,SUBMIT_DATE_END,REMINDERS_STATE,
        		REM_DATE_START,REM_DATE_END,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,
        		UPDATE_DATE_START,UPDATE_DATE_END,compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: GetPreApproveApplyData 
	 * @Description: ����Ԥ�������¼id����ȡԤ��������Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return Data
	 * @throws DBException
	 */
	public Data GetPreApproveApplyData(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetPreApproveApplyData", ri_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: ExtensionApplySave 
	 * @Description: �����������뱣�����
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean
	 * @throws DBException
	 */
	public boolean ExtensionApplySave(Connection conn, Map<String,Object> data) throws DBException {
		Data adddata = new Data(data);
        adddata.setConnection(conn);
        adddata.setEntityName("SCE_REQ_DEFERRED");
        adddata.setPrimaryKey("DEF_ID");
        if("".equals(adddata.getString("DEF_ID",""))){
        	adddata.create();
        }else{
        	adddata.store();
        }
        
		return true;
	}

	/**
	 * @Title: GetExtensionApplyData 
	 * @Description: ���ݽ������������¼id,��ȡ��������������Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param def_id
	 * @return Data 
	 * @throws DBException 
	 */
	public Data GetExtensionApplyData(Connection conn, String def_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetExtensionApplyData", def_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: ExtensionAuditList 
	 * @Description: ����������˲�ѯ�б�
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
	public DataList ExtensionAuditList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE",null);	//����code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//������֯code
		String MALE_NAME = data.getString("MALE_NAME",null);	//��������
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//Ů������
		String NAME = data.getString("NAME",null);	//��ͯ����
		String SEX = data.getString("SEX",null);	//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//��ͯ������ֹ����
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//����������ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//���������ֹ����
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);	//�ļ��ݽ���ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//�ļ��ݽ���ֹ����
		String REQ_SUBMIT_DATE_START = data.getString("REQ_SUBMIT_DATE_START",null);	//��ʱ�ݽ���ʼ����
		String REQ_SUBMIT_DATE_END = data.getString("REQ_SUBMIT_DATE_END",null);	//��ʱ�ݽ���ֹ����
		String AUDIT_DATE_START = data.getString("AUDIT_DATE_START",null);	//�����ʼ����
		String AUDIT_DATE_END = data.getString("AUDIT_DATE_END",null);	//��˽�ֹ����
		String AUDIT_STATE = data.getString("AUDIT_STATE",null);	//����״̬
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("ExtensionAuditList", COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, REQ_DATE_START, REQ_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REQ_SUBMIT_DATE_START, REQ_SUBMIT_DATE_END, AUDIT_DATE_START, AUDIT_DATE_END, AUDIT_STATE, compositor,ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/** 
	 * @Title: UpdatePreApproveApply 
	 * @Description: ��������Ԥ��������Ϣ�Ľ������ޣ�SUBMIT_DATE��
	 * @author: yangrt
	 * @param conn
	 * @param ridata
	 * @return boolean
	 * @throws DBException
	 */
	public boolean UpdatePreApproveApply(Connection conn, Map<String,Object> data) throws DBException {
		Data updatedata = new Data(data);
        updatedata.setConnection(conn);
        updatedata.setEntityName("SCE_REQ_INFO");
        updatedata.setPrimaryKey("RI_ID");
    	updatedata.store();
		return true;
	}

}
