package com.dcfs.fam.billRegistration;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import com.hx.upload.sdk.AttHelper;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: BillRegistrationHandler 
 * @Description: Ʊ�ݵǼ�handler��
 * @author panfeng
 * @date 2014-11-14
 *  
 */
public class BillRegistrationHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public BillRegistrationHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * Ʊ�ݵǼ��б�
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList billRegistrationList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String PAID_NO = data.getString("PAID_NO", null);	//�ɷѱ��
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String COST_TYPE = data.getString("COST_TYPE", null);	//��������
		String PAID_WAY = data.getString("PAID_WAY", null);	//�ɷѷ�ʽ
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//Ӧ�ɽ��
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//Ʊ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REG_DATE_START = data.getString("REG_DATE_START", null);	//��ʼ¼������
		String REG_DATE_END = data.getString("REG_DATE_END", null);	//����¼������
		String CHEQUE_TRANSFER_STATE = data.getString("CHEQUE_TRANSFER_STATE", null);	//�ƽ�״̬
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("billRegistrationList", PAID_NO, COUNTRY_CODE, ADOPT_ORG_ID, COST_TYPE, PAID_WAY, PAID_SHOULD_NUM, PAR_VALUE, FILE_NO, REG_DATE_START, REG_DATE_END, CHEQUE_TRANSFER_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
     * ѡ���ļ�����б�
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException
     */
    public DataList selectFileList(Connection conn, Data data,
            int pageSize, int page, String compositor, String ordertype, String COUNTRY_CODE, String ADOPT_ORG_ID, String PAID_NO)
            throws DBException{
    	
		//��ѯ����
    	String FILE_NO = data.getString("FILE_NO", null);//�ļ����
    	String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);//����������ʼ
    	String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);//�������ڽ�ֹ
//		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);//����
//		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);//������֯
		String FILE_TYPE = data.getString("FILE_TYPE", null);//�ļ�����
		String AF_COST = data.getString("AF_COST",null); //Ӧ�ɽ��
		String MALE_NAME = data.getString("MALE_NAME", null);//������������
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);//Ů����������
//		String AF_COST_PAID = data.getString("AF_COST_PAID",null); //�ɷ�״̬
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    String sql = getSql("selectFileList",COUNTRY_CODE,ADOPT_ORG_ID,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,FILE_TYPE,MALE_NAME,FEMALE_NAME,AF_COST,PAID_NO,compositor,ordertype);
        DataList dl = ide.find(sql, pageSize, page);
    	return dl;
    	
    }
	
    /**
	 * ����Ʊ��ID��ѯƱ����Ϣ
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getShowData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getShowData", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * ����Ʊ��ID��ѯƱ�ݵǼ���Ϣ��Ʊ�ݴ߽���Ϣ
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getBothData(Connection conn, String uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getBothData", uuid));
		return dataList.getData(0);
	}
	
	/**
	 * ����Ʊ���е��ļ����ͳ��Ӧ���ܽ��
	 *
	 * @param conn
	 * @param checkId
	 * @return
	 * @throws DBException
	 */
	public Data getSum(Connection conn, String wjbh) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getSum", wjbh));
		return dataList.getData(0);
	}
	
	/**
	 * �����ļ���Ų�ѯ�ļ��б�
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList showFileList(Connection conn, String fileno) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("showFileList", fileno);
		DataList dl = ide.find(sql);
		return dl;
	}
	
    
	/**
	 * �����ļ���Ϣ
	 * @author panfeng
	 * @param conn
	 * @param fileData
	 * @return
	 * @throws DBException
	 */
	public Data saveFile(Connection conn, Map<String, Object> fileData, boolean iscreate)
    		throws DBException {
    	//***�����ļ���Ϣ*****
    	Data dataadd = new Data(fileData);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FFS_AF_INFO");
    	dataadd.setPrimaryKey("AF_ID");
    	if (iscreate) {
    		return dataadd.create();
    	} else {
    		return dataadd.store();
    	}
    }
	
    /**
     * ����Ʊ����Ϣ
     * @author panfeng
     * @param conn
     * @param billData
     * @return Data
     * @throws DBException
     */
    public Data saveBill(Connection conn, Map<String, Object> billData)
    		throws DBException {
    	Data dataadd = new Data(billData);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FAM_CHEQUE_INFO");
    	dataadd.setPrimaryKey("CHEQUE_ID");
    	if ("".equals(dataadd.getString("CHEQUE_ID", ""))) {
    		dataadd = dataadd.create();
        } else {
        	dataadd = dataadd.store();
        }
        return dataadd;
    	
    }
    
    /**
	 * @throws DBException  
	 * @Title: billDelete 
	 * @Description: ����IDɾ��δ�ύ��Ʊ����Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param uuid
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean billDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList deleteList = new DataList();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FAM_CHEQUE_INFO");
			data.setPrimaryKey("CHEQUE_ID");
			data.add("CHEQUE_ID", uuid[i]);
			deleteList.add(data);
			
		}
		ide.remove(deleteList);
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: billDelete 
	 * @Description: �������ı�Ÿ����ļ���Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param uuid
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean fileUpdate(Connection conn, String[] fileNo) throws DBException {
		
		for (int i = 0; i < fileNo.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("FILE_NO");
			data.add("FILE_NO", fileNo[i]);
			data.add("AF_COST_PAID", "0");
			data.add("PAID_NO", "");
			data.store();
		}
		return true;
	}
	
	
	/**
	 * @throws DBException  
	 * @Title: updateData 
	 * @Description: �����ļ�ID��սɷѱ��
	 * @author: panfeng;
	 * @param conn
	 * @param uuid
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean updateData(Connection conn, String[] uuid) throws DBException {
		
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("AF_ID");
			data.add("AF_ID", uuid[i]);
			data.add("PAID_NO", "");
			data.store();
		}
		return true;
	}

	
    
	
}
