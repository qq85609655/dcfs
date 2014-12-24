package com.dcfs.sce.REQInfo;

import java.sql.Connection;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: REQInfoHandler.java
 * @author lihf
 */
public class REQInfoHandler extends BaseHandler {
    /**
     * @Title: findREQInfoList
     * @Description: ��֯��������Ԥ���б��ѳ�����
     * @author: lihf
     * @date: 2014-9-15
     */
    public DataList findREQInfoList(Connection conn, Data data,String organCode,int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
    	String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String NAME = data.getString("NAME", null);   //����
        String SEX = data.getString("SEX", null);   //�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������������
        String REVOKE_REQ_DATE_START = data.getString("REVOKE_REQ_DATE_START", null);   //��ʼ���볷������
        String REVOKE_REQ_DATE_END = data.getString("REVOKE_REQ_DATE_END", null);   //�������볷������
        
        String REVOKE_CFM_DATE_START = data.getString("REVOKE_CFM_DATE_START", null);   //��ʼ����ȷ������
        String REVOKE_CFM_DATE_END = data.getString("REVOKE_CFM_DATE_END", null);   //��������ȷ������
        String REVOKE_STATE = data.getString("REVOKE_STATE", null);   //����״̬
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findREQInfoList", MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START,BIRTHDAY_END,REVOKE_REQ_DATE_START,REVOKE_REQ_DATE_END,REVOKE_CFM_DATE_START,REVOKE_CFM_DATE_END,REVOKE_STATE,compositor, ordertype,organCode);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
   
    /**
     * @Description: ��֯����Ԥ�������б�δ������
     * @author: lihf
     */
    public DataList findREQInfoApplicatList(Connection conn, Data data, String organCode,int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
    	String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String NAME = data.getString("NAME", null);   //����
        String SEX = data.getString("SEX", null);   //�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������������
        String REQ_DATE_START = data.getString("REQ_DATE_START", null);   //��ʼ��������
        String REQ_DATE_END = data.getString("REQ_DATE_END", null);   //������������
        String RI_STATE = data.getString("RI_STATE", null);   //Ԥ��״̬
        String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);   //��ʼ��ǰ�ļ��ݽ�����
        String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);   //������ǰ�ļ��ݽ�����
        String REMINDERS_STATE = data.getString("REMINDERS_STATE", null);   //�߰�״̬
        String REM_DATE_START = data.getString("REM_DATE_START", null);   //��ʼ�߰�����
        String REM_DATE_END = data.getString("REM_DATE_END", null);   //�����߰�����
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //��ʼ��������
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //������������
        String FILE_NO = data.getString("FILE_NO", null);   //���ı��
        String LAST_UPDATE_DATE_START = data.getString("LAST_UPDATE_DATE_START", null);   //��ʼ����������
        String LAST_UPDATE_DATE_END = data.getString("LAST_UPDATE_DATE_END", null);   //��������������
        String PASS_DATE_START = data.getString("PASS_DATE_START",null);     //��ʼ������
        String PASS_DATE_END = data.getString("PASS_DATE_END",null);     //����������
        
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findREQInfoApplicatList", MALE_NAME, FEMALE_NAME, NAME, SEX, BIRTHDAY_START,BIRTHDAY_END,REQ_DATE_START,REQ_DATE_END,RI_STATE,SUBMIT_DATE_START,SUBMIT_DATE_END,REMINDERS_STATE,REM_DATE_START,REM_DATE_END,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,LAST_UPDATE_DATE_START,LAST_UPDATE_DATE_END,PASS_DATE_START,PASS_DATE_END,compositor, ordertype,organCode);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * @Description: ����������ϸ��Ϣ
     * @author: lihf
     */
    public Data findREQInfoReason(Connection conn,String RI_ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data data = new Data();
    	data.setEntityName("SCE_REQ_INFO");
    	data.setPrimaryKey("RI_ID");
    	data.add("RI_ID", RI_ID);
    	Data d = ide.findByPrimaryKey(data);
    	return d;
    }
    
    /**
     * @Description: ��ӳ�������ԭ��
     * @author: lihf
     */
    public void findREQInfoAddReason(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_REQ_INFO");
    	dataedit.setPrimaryKey("RI_ID");
    	dataedit.store();
    }
    
    /**
     * @Description: ����RI_ID�������볷����ϸ��Ϣ
     * @author: lihf
     */
    public Data findREQInfoSearchById(Connection conn,String RI_ID) throws DBException{
    	//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findREQInfoSearchById",RI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * @Description: ���ò�Ԥ�������б�
     * @author: lihf
     */
    public DataList findAZBREQInfoList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //����
    	String ADOPT_ORG_NAME_CN = data.getString("ADOPT_ORG_NAME_CN", null);  //������֯
    	String MALE_NAME = data.getString("MALE_NAME", null);   //�з�
    	String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //Ů��
        String NAME = data.getString("NAME", null);   //����
        String REVOKE_REQ_DATE_START = data.getString("REVOKE_REQ_DATE_START", null);   //��ʼ��������
        String REVOKE_REQ_DATE_END = data.getString("REVOKE_REQ_DATE_END", null);   //������������
        String REVOKE_CFM_DATE_START = data.getString("REVOKE_CFM_DATE_START", null);   //��ʼȷ������
        String REVOKE_CFM_DATE_END = data.getString("REVOKE_CFM_DATE_END", null);   //����ȷ������
        String REVOKE_STATE = data.getString("REVOKE_STATE", null);   //����״̬
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //������֯ID
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBREQInfoList",COUNTRY_CODE,ADOPT_ORG_NAME_CN,MALE_NAME, FEMALE_NAME, NAME,REVOKE_REQ_DATE_START,REVOKE_REQ_DATE_END,REVOKE_CFM_DATE_START,REVOKE_CFM_DATE_END,REVOKE_STATE,ADOPT_ORG_ID,compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * @Description: ת�����ò�Ԥ������ȷ��ҳ��
     * @author: lihf
     */
    public Data findAZBREQInfoSearchById(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findAZBREQInfoSearchById",ID);
    	System.out.println(sql);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    /**
     * ���ݶ�ͯID,����Ԥ��data
     * @param conn
     * @param ci_id
     * @return
     * @throws DBException 
     */
    public Data findYPByCiid(Connection conn,String ci_id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findYPByCiidSql",ci_id);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    
    /**
     * @Description: ���ò�ȷ��Ԥ������
     * @author: lihf
     */
    public void findAZBReqInfoconfirm(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_REQ_INFO");
    	dataedit.setPrimaryKey("RI_ID");
    	dataedit.store();
    }
    
    /**
     * @Description: ת�����ò�Ԥ������ȷ��ҳ��
     * @author: lihf
     */
    public Data findAZBFfsAfInfo(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data data = new Data();
    	data.setEntityName("SCE_REQ_INFO");
    	data.setPrimaryKey("RI_ID");
    	data.add("RI_ID", ID);
    	Data d = ide.findByPrimaryKey(data);
    	return d;
    }
    /**
     * @Description: �����ͥ�Ѿ��ύ�ļ����޸��ļ�״̬
     * @author: lihf
     */
    public Data findAZBFfsAfInfoRevise(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data data = new Data();
    	data.setEntityName("FFS_AF_INFO");
    	data.setPrimaryKey("AF_ID");
    	data.add("AF_ID", ID);
    	Data d = ide.findByPrimaryKey(data);
    	return d;
    }
    
    /**
     * @Description: �޸ļ�ͥ�ļ�״̬
     * @author: lihf
     */
    public void findAZBFfsAfInfoSave(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("FFS_AF_INFO");
    	dataedit.setPrimaryKey("AF_ID");
    	dataedit.store();
    }
    
  //Ԥ��data
  	public  Data getRIData(Connection conn,String RI_ID) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
  		Data dataadd = new Data();
  	    dataadd.setConnection(conn);
  	    dataadd.setEntityName("SCE_REQ_INFO");
  	    dataadd.setPrimaryKey("RI_ID");
  	    dataadd.addString("RI_ID", RI_ID);
  	    DataList dl = ide.find(dataadd);
  	    return dl.getData(0);
  	}
  	
  //�ļ�data
  	public  Data getAFData(Connection conn,String AF_ID) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
  		Data dataadd = new Data();
  	    dataadd.setConnection(conn);
  	    dataadd.setEntityName("FFS_AF_INFO");
  	    dataadd.setPrimaryKey("AF_ID");
  	    dataadd.addString("AF_ID", AF_ID);
  	    DataList dl = ide.find(dataadd);
  	    return dl.getData(0);
  	}
  	
  	//����data
  	public  Data getPubData(Connection conn,String PUB_ID) throws DBException{
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
  	public  Data getCIData(Connection conn,String CI_ID) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
  		Data dataadd = new Data();
  	    dataadd.setConnection(conn);
  	    dataadd.setEntityName("CMS_CI_INFO");
  	    dataadd.setPrimaryKey("CI_ID");
  	    dataadd.addString("CI_ID", CI_ID);
  	    DataList dl = ide.find(dataadd);
  	    return dl.getData(0);
  	}
  	
  	//���ݶ�ͯ��ţ���ȡ��ͯ��Ϣ
  	public Data getCHILDNOData(Connection conn,String CHILD_NO) throws DBException{
  		IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("getCHILDNODataSQL",CHILD_NO);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
  	}
  	
  //���淢����¼��
  	public  void  savePubData(Connection conn,Data Data) throws DBException{
  		Data dataupdate = new Data(Data);
  		dataupdate.setConnection(conn);
  		dataupdate.setEntityName("SCE_PUB_RECORD");
  		dataupdate.setPrimaryKey("PUB_ID");
  		dataupdate.store();
  	}
	
    //�����ļ���
	public  void  saveFfsData(Connection conn,Data Data) throws DBException{
		Data dataupdate = new Data(Data);
		dataupdate.setConnection(conn);
		dataupdate.setEntityName("FFS_AF_INFO");
		dataupdate.setPrimaryKey("AF_ID");
		dataupdate.store();
	}
	

}


