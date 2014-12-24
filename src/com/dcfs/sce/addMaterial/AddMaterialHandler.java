package com.dcfs.sce.addMaterial;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;


/**
 * 
 * @Title: AddMaterialHandler.java
 * @Description: ����Ԥ�����ϲ�ѯ���鿴����֪ͨ���������
 * @Company: 21softech
 * @Created on 2014-9-14 ����3:43:13 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AddMaterialHandler extends BaseHandler {
    /**
     * 
     * @Title: findMaterialList
     * @Description: Ԥ�������б�
     * @author: panfeng
     * @date: 2014-9-11 ����5:21:12 
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMaterialList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
    	String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
        String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);   //�ر��ע
        String ADD_TYPE = data.getString("ADD_TYPE", null);   //�������ͣ����ţ�
        String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);   //��ʼ����֪ͨ����
        String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);   //��������֪ͨ����
        String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);   //��ʼ��������
        String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);   //������������
        String AA_STATUS = data.getString("AA_STATUS", null);   //����״̬
        
        UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();//��ȡ��ǰ������֯��λ
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findMaterialList", MALE_NAME, FEMALE_NAME, PROVINCE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SPECIAL_FOCUS, ADD_TYPE, NOTICE_DATE_START, NOTICE_DATE_END, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, compositor, ordertype, orgcode);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
	 * @Title: getSupData 
	 * @Description: ��ȡԤ��������Ϣ
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getSupData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getSupData", uuid);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}
	
	/**
     * ����Ԥ�����ϱ���/�ύ
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean addMaterialSave(Connection conn, Map<String, Object> data)
            throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_ADDITIONAL");
        dataadd.setPrimaryKey("RA_ID");
        if ("".equals(dataadd.getString("RA_ID", ""))) {
        	dataadd.create();
        } else {
        	dataadd.store();
        }
        return true;
    }
	
	/**
	 * @Title: getDetailData 
	 * @Description: ��ȡ����֪ͨ��ϸ�鿴��Ϣ
	 * @author: panfeng
	 * @param conn
	 * @param uuid
	 * @return Data
	 * @throws DBException
	 */
	public Data getDetailData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getDetailData", uuid);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @Title: getInfoData 
	 * @Description: ����id��ȡԤ��������Ϣ
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
	 * @Title: modInfoSave 
	 * @Description: Ԥ��������Ϣ����/���²���
	 * @author: panfeng
	 * @param conn
	 * @param data
	 * @return boolean    �������� 
	 * @throws DBException
	 */
	public boolean modInfoSave(Connection conn, Map<String, Object> data) throws DBException {
		Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("SCE_REQ_INFO");
        dataadd.setPrimaryKey("RI_ID");
    	dataadd.store();
        return true;
	}
    
    
}
