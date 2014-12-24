/**   
 * @Title: CertificationBodyHandler.java 
 * @Package com.dcfs.mkr.USAConvention 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author panfeng
 * @date 2014-8-20 ����5:27:31 
 * @version V1.0   
 */
package com.dcfs.mkr.USAConvention;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

/** 
 * @ClassName: CertificationBodyHandler 
 * @Description: ������Լ��֤����ά��handler��
 * @author panfeng
 * @date 2014-8-20
 *  
 */
public class CertificationBodyHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public CertificationBodyHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * ��֤�����б�
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList findBodyList(Connection conn, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findBodyList", compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getBodyNameData
	 * @Description: ���ݻ������Ʋ�ѯ������Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param name
	 * @return    �趨�ļ� 
	 * @return    �������� 
	 * @throws 
	 */
	public Data getBodyNameData(Connection conn, String name, String type) throws DBException {
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getBodyNameData", name, type);
		//��ȡ������������Ϣ
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}
	
	 /**
     * ����
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean saveCerBody(Connection conn, Map<String, Object> data, boolean iscreate)
            throws DBException {
	    //***��������*****
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("MKR_ORG_COA");
        dataadd.setPrimaryKey("COA_ID");
        if (iscreate) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    }
	
	
	/**
	 * �鿴
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data showCerBody(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getShowData", uuid));
		return dataList.getData(0);
	}
	
    /**
	 * @Title: bodyDelete 
	 * @Description: ����ID����ɾ���ݸ��¼
	 * @author: panfeng;
	 * @param conn
	 * @return 
	 * @throws 
	 */
	public boolean bodyDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList deleteList = new DataList();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("MKR_ORG_COA");
			data.setPrimaryKey("COA_ID");
			data.add("COA_ID", uuid[i]);
			deleteList.add(data);
		}
		ide.remove(deleteList);
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: changeFail 
	 * @Description: ʧЧ���ָ���Ч��¼
	 * @author: panfeng;
	 * @param conn
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean changeFail(Connection conn, String uuid, String operation_type) throws DBException {
		UserInfo curuser = SessionInfo.getCurUser();
		Data data = new Data();
		data.setConnection(conn);
		data.setEntityName("MKR_ORG_COA");
		data.setPrimaryKey("COA_ID");
		data.add("COA_ID", uuid);
		if("fail".equals(operation_type)){
			data.add("STATE", "2");//״̬��Ϊ��ʧЧ
		}else{
			data.add("STATE", "1");//״̬��Ϊ����Ч
		}
		data.add("MOD_DATE", DateUtility.getCurrentDate());//��¼�޸���
		data.add("MOD_USERID", curuser.getPersonId());//��¼�޸�����
		data.store();
		return true;
	}
	
}
