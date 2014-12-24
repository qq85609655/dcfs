/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����3:00:55 
 * @version V1.0   
 */
package com.dcfs.sce.overageRemind;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: OverageRemindHandler 
 * @Description: ���ò���ѯ���鿴�������������á������Զ��˲��ϲ��� 
 * @author panfeng
 * @date 2014-9-16
 *  
 */
public class OverageRemindHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public OverageRemindHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * ��ͯ���������б�
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList overageRemindList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//��ѯ����
		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		String NAME = data.getString("NAME", null);	//����
		String SEX = data.getString("SEX", null);	//�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);//�������ڿ�ʼ
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);//�������ڿ�ʼ
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);	//��ͯ����
		String SN_TYPE = data.getString("SN_TYPE", null);	//��������
		String DISEASE_CN = data.getString("DISEASE_CN", null);	//�������
		String AUD_STATE =  data.getString("AUD_STATE", null);//���״̬
		String PUB_STATE = data.getString("PUB_STATE",null);//����״̬
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("overageRemindList", PROVINCE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, SN_TYPE, DISEASE_CN, AUD_STATE, PUB_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
     * 
     * @Title: findshowCIsList
     * @Description: ��ͯ��Ϣ
     * @author: panfeng
     * @date: 2014-9-16 
     * @param conn
     * @param uuid
     * @return
     * @throws DBException
     */
    public DataList getChildrenData(Connection conn, String uuid) throws DBException {
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChildrenData", uuid);
        DataList dl = ide.find(sql);
        return dl;
    }
	
}
