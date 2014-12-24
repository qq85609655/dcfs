package com.dcfs.sce.common;

import java.sql.Connection;
import java.util.Map;


import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * ����������handler��
 * @description 
 * @author MaYun
 * @date Jul 22, 2014
 * @return
 */
public class PublishCommonManagerHandler extends BaseHandler {
	
	/**
	 * 
	 * @description �õ���ǰ���5λ��ˮ��
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return
	 */
	public synchronized Data getMaxPubPlanSeqNo (Connection conn,String year) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxPubPlanSeqNo", year));
		return dataList.getData(0);
	}
	
	/**
	 * �����ݿ���뷢���ƻ���ˮ��
	 * @description 
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return
	 */
	public synchronized void saveMaxPubPlanSeqNo (Connection conn, Map<String, Object> data)throws DBException{
		Data dataadd = new Data(data);
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("SCE_PUB_PLAN_SEQNO");
	    dataadd.setPrimaryKey("SEQ_ID");
	    dataadd.create();
	}
	
	/**
	 * @Title: getMaxPreApproveApplyNo 
	 * @Description: �õ���ǰ��������ŵ�5λ��ˮ��
	 * @author: yangrt
	 * @param conn
	 * @param year
	 * @param orgCode
	 * @return Data
	 * @throws DBException
	 */
	public synchronized Data getMaxPreApproveApplyNo(Connection conn, String year, String orgCode) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getMaxPreApproveApplyNo", year,orgCode));
		return dataList.getData(0);
	}

	/** 
	 * @Title: saveMaxPreApproveApplyNo 
	 * @Description: �����ݿ����Ԥ��������
	 * @author: yangrt
	 * @param conn
	 * @return void
	 * @throws DBException
	 */
	public synchronized void saveMaxPreApproveApplyNo(Connection conn, Map<String, Object> data)throws DBException{
		Data dataadd = new Data(data);
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("SCE_REQ_SEQNO");
	    dataadd.setPrimaryKey("SEQ_NO");
	    dataadd.create();
	}
	
	//Ԥ��data
	public synchronized Data getRIData(Connection conn,String RI_ID) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		Data dataadd = new Data();
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("SCE_REQ_INFO");
	    dataadd.setPrimaryKey("RI_ID");
	    dataadd.addString("RI_ID", RI_ID);
	    DataList dl = ide.find(dataadd);
	    return dl.getData(0);
	}
	
	//����data
	public synchronized Data getPubData(Connection conn,String PUB_ID) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		Data dataadd = new Data();
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("SCE_PUB_RECORD");
	    dataadd.setPrimaryKey("PUB_ID");
	    dataadd.addString("PUB_ID", PUB_ID);
	    DataList dl = ide.find(dataadd);
	    return dl.getData(0);
	}
	
	//��ͯ���ϱ�
	public synchronized Data getCIData(Connection conn,String CI_ID) throws DBException{
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		Data dataadd = new Data();
	    dataadd.setConnection(conn);
	    dataadd.setEntityName("CMS_CI_INFO");
	    dataadd.setPrimaryKey("CI_ID");
	    dataadd.addString("CI_ID", CI_ID);
	    DataList dl = ide.find(dataadd);
	    return dl.getData(0);
	}
	
	//���淢����¼��
	public synchronized void  savePubData(Connection conn,Data Data) throws DBException{
		Data dataupdate = new Data(Data);
		dataupdate.setConnection(conn);
		dataupdate.setEntityName("SCE_PUB_RECORD");
		dataupdate.setPrimaryKey("PUB_ID");
		dataupdate.store();
	}
	
	//�����ͯ���ϱ�
	public synchronized void  saveCIData(Connection conn,Data Data) throws DBException{
		Data dataupdate = new Data(Data);
		dataupdate.setConnection(conn);
		dataupdate.setEntityName("CMS_CI_INFO");
		dataupdate.setPrimaryKey("CI_ID");
		dataupdate.store();
	}
	
	//����Ԥ����¼
	public synchronized void  saveRIData(Connection conn,Data Data) throws DBException{
		Data dataupdate = new Data(Data);
		dataupdate.setConnection(conn);
		dataupdate.setEntityName("SCE_REQ_INFO");
		dataupdate.setPrimaryKey("RI_ID");
		dataupdate.store();
	}
}
