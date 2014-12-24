package com.dcfs.fam.completeCost;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: CompleteCostHandler 
 * @Description: ���ά��handler��
 * @author panfeng
 * @date 2014-10-22
 *  
 */
public class CompleteCostHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public CompleteCostHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * ���ά���б�
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList completeCostList(Connection conn, Data data, int pageSize,
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
		String AF_COST = data.getString("AF_COST", null);	//Ӧ�ɽ��
		String PAID_NO = data.getString("PAID_NO", null);	//�ɷѱ��
		String AF_COST_CLEAR = data.getString("AF_COST_CLEAR", null);	//���״̬
		String AF_COST_CLEAR_FLAG = data.getString("AF_COST_CLEAR_FLAG", null);	//ά����ʶ
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("completeCostList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, NAME, AF_COST, PAID_NO, AF_COST_CLEAR, AF_COST_CLEAR_FLAG, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * �����ļ�id��ѯ�ļ���ϢƱ�ݼ�¼
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getCostShow(Connection conn, String uuid, String fileno) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getCostShow", fileno, uuid));
		return dataList.getData(0);
	}
	
	/**
	 * ���ݽɷѱ�Ų�ѯƱ����Ϣ
	 *
	 * @param conn
	 * @param paid_no
	 * @return
	 * @throws DBException
	 */
	public Data getBillShow(Connection conn, String paid_no) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getBillShow", paid_no));
		return dataList.getData(0);
	}
	
	
    
    /**
     * �����ļ�������Ϣ
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public boolean completeCostSave(Connection conn, Map<String, Object> data)
    		throws DBException {
    	Data dataadd = new Data(data);
    	dataadd.setConnection(conn);
    	dataadd.setEntityName("FFS_AF_INFO");
    	dataadd.setPrimaryKey("AF_ID");
    	if ("".equals(dataadd.getString("AF_ID", ""))) {
            dataadd.create();
        } else {
            dataadd.store();
        }
        return true;
    	
    }
    
	
}
