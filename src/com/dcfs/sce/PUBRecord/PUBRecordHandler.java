package com.dcfs.sce.PUBRecord;

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
 * @Description: ���ò��������
 * @author lihf
 */
public class PUBRecordHandler extends BaseHandler {
    /**
     * @Description: ���ò��㷢�˻��б�
     * @author: lihf
     */
    public DataList findPUBRecordList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //��ѯ����
    	String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //ʡ��
    	String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN", null);   //����Ժ
        String NAME = data.getString("NAME", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String SN_TYPE = data.getString("SN_TYPE", null);   //��������
        String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS", null);   //�ر��ע
        String PUB_DATE_START = data.getString("PUB_DATE_START", null);   //��ʼ��������
        String PUB_DATE_END = data.getString("PUB_DATE_END", null);   //������������
        String PUB_MODE = data.getString("PUB_MODE", null);   //�㷢����
        String RETURN_TYPE = data.getString("RETURN_TYPE", null);   //�˻�����
        String PUB_ORGID = data.getString("PUB_ORGID", null);   //�˻���֯
        String RETURN_DATE_START = data.getString("RETURN_DATE_START", null);   //��ʼ�˻�����
        String RETURN_DATE_END = data.getString("RETURN_DATE_END", null);   //�����˻�����
        String RETURN_CFM_DATE_START = data.getString("RETURN_CFM_DATE_START", null);   //��ʼȷ������
        String RETURN_CFM_DATE_END = data.getString("RETURN_CFM_DATE_END", null);   //����ȷ������
        String RETURN_STATE = data.getString("RETURN_STATE", null);   //�˻�״̬
        String PUB_TYPE = data.getString("PUB_TYPE", null);   //��������
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findPUBRecordList", PROVINCE_ID, WELFARE_NAME_CN, NAME, SEX, BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,SPECIAL_FOCUS,PUB_DATE_START,PUB_DATE_END,PUB_MODE,RETURN_TYPE,PUB_ORGID,RETURN_DATE_START,RETURN_DATE_END,RETURN_CFM_DATE_START,RETURN_CFM_DATE_END,RETURN_STATE,PUB_TYPE,compositor, ordertype);
        System.out.println("�˻�ȷ�ϣ�"+sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * @Description: ���ò��㷢�˻�ȷ����Ϣ(�鿴)
     * @author: lihf
     */
    public Data findPUBCheck(Connection conn,String ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findPUBCheck",ID);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    public DataList findPUBConfirm(Connection conn,String id) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findPUBConfirm",id);
    	DataList dl = ide.find(sql);
    	return dl;
    }
    
    //����������֯���ҹ���
    public Data findCountry(Connection conn,String orginId)throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findCountry",orginId);
    	DataList dl = ide.find(sql);
    	return dl.getData(0);
    }
    
    /**
     * @Description: ���ò�ȷ�ϵ㷢�˻�
     * @author: lihf
     */
    public void findPUBReturn(Connection conn,Data data) throws DBException{
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_PUB_RECORD");
    	dataedit.setPrimaryKey("PUB_ID");
    	dataedit.store();
    }
    
    /**
     * @Description: ������֯�㷢�˻ز鿴�б�
     * @author: lihf
     */
    public DataList findSYZZPUBRecordList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
    	//��ѯ����
    	String ORG_ID = data.getString("ORG_ID",null);   //��֯����ID
    	String PROVINCE_ID = data.getString("PROVINCE_ID",null);   //ʡ��
    	String NAME_PINYIN = data.getString("NAME_PINYIN", null);   //��ͯ����
        String SEX = data.getString("SEX", null);   //��ͯ�Ա�
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //��ʼ��ͯ��������
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //������ͯ��������
        String SN_TYPE = data.getString("SN_TYPE", null);   //��������
        String PUB_DATE_START = data.getString("PUB_DATE_START", null);   //��ʼ��������
        String PUB_DATE_END = data.getString("PUB_DATE_END", null);   //������������
        String SETTLE_DATE_START = data.getString("SETTLE_DATE_START", null);   //��ʼ��������
        String SETTLE_DATE_END = data.getString("SETTLE_DATE_END", null);   //������������
        String RETURN_DATE_START = data.getString("RETURN_DATE_START", null);   //��ʼ�˻�����
        String RETURN_DATE_END = data.getString("RETURN_DATE_END", null);   //�����˻�����
        String RETURN_CFM_DATE_START = data.getString("RETURN_CFM_DATE_START", null);   //��ʼ�˻�ȷ������
        String RETURN_CFM_DATE_END = data.getString("RETURN_CFM_DATE_END", null);   //�����˻�ȷ������
        String RETURN_STATE = data.getString("RETURN_STATE", null);   //�˻�״̬
        //���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findSYZZPUBRecordList",ORG_ID,PROVINCE_ID,NAME_PINYIN, SEX, BIRTHDAY_START,BIRTHDAY_END,SN_TYPE,PUB_DATE_START,PUB_DATE_END,SETTLE_DATE_START,SETTLE_DATE_END, RETURN_DATE_START,RETURN_DATE_END,RETURN_CFM_DATE_START,RETURN_CFM_DATE_END,RETURN_STATE,compositor, ordertype);
        System.out.println("sql--->"+sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    
    /**
     * @Description: ������֯����PUB_ID���ҵ㷢�˻���ϸ��Ϣ
     * @author: lihf
     */
    public Data findSYZZPUBRecordDetail(Connection conn,Data data) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	Data dataedit = new Data(data);
    	dataedit.setConnection(conn);
    	dataedit.setEntityName("SCE_PUB_RECORD");
    	dataedit.setPrimaryKey("PUB_ID");
    	DataList dl = ide.find(dataedit);
    	return dl.getData(0);
    	
    }
    
    /**
     * @Description: ����˻�ԭ��
     * @author: lihf
     */
    public boolean findSYZZPUBRecordAddReason(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("SCE_PUB_RECORD");
    		dataList.getData(i).setPrimaryKey("PUB_ID");
    	}
    	int re = ide.batchStore(dataList);
    	if(re>0){
    		return true;
    	}else{
    		return false;
    	}
    	
    }
    
    public boolean updateChildMessage(Connection conn,DataList dataList) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	for(int i=0;i<dataList.size();i++){
    		dataList.getData(i).setEntityName("CMS_CI_INFO");
    		dataList.getData(i).setPrimaryKey("CI_ID");
    	}
    	int re = ide.batchStore(dataList);
		if(re>0){
			return true;
		}else{
			return false;
		}
    }
    
    public DataList findCIDataList(Connection conn,String ids) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
    	String sql = getSql("findCIDataListSQL",ids);
    	DataList dl = ide.find(sql);
    	return dl;
    	
    }
    
}
