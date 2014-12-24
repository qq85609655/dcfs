package com.dcfs.sce.additional;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;


/**
 * 
 * @Title: AdditionalHandler.java
 * @Description: Ԥ��������Ϣ��ѯ���鿴����
 * @Company: 21softech
 * @Created on 2014-9-11 ����5:21:12 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AdditionalHandler extends BaseHandler {
    /**
     * 
     * @Title: findAddList
     * @Description: Ԥ�������б�
     * @author: panfeng
     * @date: 2014-9-11 ����5:21:12 
     * @param conn
     * @param data
     * @param OperType
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAddList(Connection conn, Data data, String OperType, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
        String MALE_NAME = data.getString("MALE_NAME", null);  						//��������
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   				//Ů������
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);  					//ʡ��
        String WELFARE_ID = data.getString("WELFARE_ID", null);   					//����Ժ
        String NAME = data.getString("NAME", null);   								//��ͯ����
        String SEX = data.getString("SEX", null);   								//��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   			//��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   				//������ͯ��������
        String REQ_DATE_START = data.getString("REQ_DATE_START", null);   			//��ʼ��������
        String REQ_DATE_END = data.getString("REQ_DATE_END", null);   				//������������
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   	//��ʼ����֪ͨ����
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   		//��������֪ͨ����
        String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null); 	//��ʼ��������
        String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);   	//������������
        String AA_STATUS = data.getString("AA_STATUS", null);   					//����״̬
        
        String ADD_TYPE = null;
        if("SHB".equals(OperType)){
        	ADD_TYPE = "1";
        }else if("AZB".equals(OperType)){
        	ADD_TYPE = "2";
        }
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAddList", MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, REQ_DATE_START, REQ_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, compositor, ordertype, ADD_TYPE);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
	 * @Title: getInfoData 
	 * @Description: ��ȡԤ����ϸ��Ϣ
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getInfoData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getInfoData", uuid);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}
	
	/**
	 * @Title: getNoticeData 
	 * @Description: ��ȡԤ������֪ͨ��Ϣ
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getNoticeData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getNoticeData", uuid);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @throws DBException  
	 * @Title: getPreApproveAuditInfo 
	 * @Description: ��ȡ��Ԥ����ǰ��������˻��ڵ���Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param ri_id
	 * @param audit_level
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	/*public Data getPreApproveAuditInfo(Connection conn, String ri_id, String audit_level) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreApproveAuditInfo", ri_id, audit_level);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}*/
	
	public Data getPreApproveAuditInfo(Connection conn, String ri_id, String OperType) throws DBException {
		String AUDIT_TYPE = null;	//�������
		String AUDIT_LEVEL = null;	//��˼���
		if("SHB".equals(OperType)){
			AUDIT_TYPE = "1";
			AUDIT_LEVEL = "0";
		}else if("AZB".equals(OperType)){
			AUDIT_TYPE = "2";
		}
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreApproveAuditInfo", ri_id, AUDIT_TYPE, AUDIT_LEVEL);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
    
    
}
