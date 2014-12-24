/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����3:00:55 
 * @version V1.0   
 */
package com.dcfs.ffs.registration;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: RegistrationHandler 
 * @Description: �����Ǽ�handler��
 * @author Mayun
 * @date 2014-7-15
 *  
 */
public class RegistrationHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public RegistrationHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * �ļ��ֹ��Ǽ��б�
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList FileHandReg(Connection conn, String regId) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getChooseFileData", regId);
		DataList dl = ide.find(sql);
		return dl;
	}
	
	 /**
     * �����ļ���¼
     * @author MaYun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public DataList saveFlieRecord(Connection conn, Map<String, Object> fileData,Map<String, Object> billData)
            throws DBException {
    	//***�����ļ���Ϣ*****
    	DataList returnDataList = new DataList();
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        if ("".equals(dataadd.getString("AF_ID", ""))) {
        	returnDataList.add(dataadd.create());
        } else {
        	returnDataList.add(dataadd.store());
        }
        
      //***����Ʊ�ݷ�����Ϣ*****
        Data dataadd2 = new Data(billData);
        String isPj = dataadd2.getString("ISPIAOJUVALUE");//�Ƿ���дƱ����Ϣ��0����  1���� 
        dataadd2.remove("ISPIAOJUVALUE");
        if(isPj=="1"||isPj.equals("1")){//��ҳ�����Ƿ���дƱ����Ϣ�����Ϊ1����дƱ����Ϣ������Ʊ����Ϣ���ﱣ������
        	dataadd2.setConnection(conn);
            dataadd2.setEntityName("FAM_CHEQUE_INFO");
            dataadd2.setPrimaryKey("CHEQUE_ID");
            if ("".equals(dataadd2.getString("CHEQUE_ID", ""))) {
                returnDataList.add(dataadd2.create());
            } else {
                returnDataList.add(dataadd2.store());
            }
        }
        
        return returnDataList;
    }
    
    /**
     * �ļ�������¼���ļ���Ϣ��
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveBatchFlieRecord(Connection conn, Map<String, Object> fileData, boolean iscreate)
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
     * �ļ�������¼��������Ϣ��
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    
    public DataList saveBatchCostRecord(Connection conn, Map<String, Object> billData)
    		throws DBException {
    	//***�����ļ���Ϣ*****
    	DataList returnDataList = new DataList();
    	Data dataadd2 = new Data(billData);
    	String isPj = dataadd2.getString("ISPIAOJUVALUE");//�Ƿ���дƱ����Ϣ��0����  1���� 
    	dataadd2.remove("ISPIAOJUVALUE");
    	if(isPj=="1"||isPj.equals("1")){//��ҳ�����Ƿ���дƱ����Ϣ�����Ϊ1����дƱ����Ϣ������Ʊ����Ϣ���ﱣ������
    		dataadd2.setConnection(conn);
    		dataadd2.setEntityName("FAM_CHEQUE_INFO");
    		dataadd2.setPrimaryKey("CHEQUE_ID");
    		if ("".equals(dataadd2.getString("CHEQUE_ID", ""))) {
    			returnDataList.add(dataadd2.create());
    		} else {
    			returnDataList.add(dataadd2.store());
    		}
    	}
    	
    	return returnDataList;
    }
    
    /**
     * �ļ�������¼��Ԥ����Ϣ��
     * @author panfeng
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    
    public boolean saveSceReqInfo(Connection conn, String[] ri_ids)
    		throws DBException {
    	for (int i = 0; i < ri_ids.length; i++) {
    		Data dataadd = new Data();
    		dataadd.setConnection(conn);
    		dataadd.setEntityName("SCE_REQ_INFO");
    		dataadd.setPrimaryKey("RI_ID");
    		dataadd.add("RI_ID", ri_ids[i]);
    		dataadd.add("RI_STATE", "6");//Ԥ��״̬Ϊ����������
    		
    		dataadd.store();
    	}
    	return true;
    }
    
    /**
	 * �����������ӡԤ��
	 *
	 * @param conn
	 * @param printId
	 * @return
	 * @throws DBException
	 * @throws ParseException 
	 */
	public DataList getPrintData(Connection conn, String printId) throws DBException, ParseException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getChooseFileData", printId);
		DataList dl = ide.find(sql);
		return dl;
	}

	
	/**
	 * �ļ��Ǽ��б�
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String AF_SEQ_NO = data.getString("AF_SEQ_NO", null);	//��ˮ��
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String AF_COST = data.getString("AF_COST", null);	//Ӧ�ɽ��
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//�ύ��ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);	//�ύ��������
		String REG_STATE = data.getString("REG_STATE", null);	//�Ǽ�״̬
		if (REG_STATE == null){
			REG_STATE = "'1'";
		}
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findList", AF_SEQ_NO, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, AF_COST, SUBMIT_DATE_START, SUBMIT_DATE_END, REG_STATE, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * ԭ���ı���б�
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList choseFileFindList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("choseFileFindList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME,compositor, ordertype);
		System.out.println("choseFileFindListSql-->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * �鿴
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public Data getShowData(Connection conn, String uuid, String fileno) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dataList = new DataList();
		dataList = ide.find(getSql("getShowData", fileno, uuid));
		return dataList.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: getChildDataList 
	 * @Description: ���ݶ�ͯ����ID��ȡ��ͯ��ϸ��Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param ci_id
	 * @return    �趨�ļ� 
	 * @return DataList    �������� 
	 * @throws 
	 */
	public DataList getChildDataList(Connection conn, String str_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ci_id = "'";
		if(str_id.indexOf(",") > 0){
			String[] child_id = str_id.split(",");
			for(int i = 0; i < child_id.length; i++){
				ci_id += child_id[i] + "','";
			}
			ci_id = ci_id.substring(0, ci_id.lastIndexOf(","));
		}else{
			ci_id += str_id + "'";
		}
		String sql = getSql("getChildDataList",ci_id);
		dl = ide.find(sql);
		return dl;
	}
	
	/**
     * �����ļ��˻�
     * @author yangrt
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public void saveFlieReturnReason(Connection conn, Map<String, Object> fileData) throws DBException {
    	//�����ļ��˻���Ϣ
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        dataadd.store();
        
    }
}
