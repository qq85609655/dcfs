/**   
 * @Title: XXXHandler.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����3:00:55 
 * @version V1.0   
 */
package com.dcfs.igq.fileSearch;

import hx.common.Exception.DBException;
import hx.database.databean.Data;

import java.sql.Connection;

import hx.common.handler.BaseHandler;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: BGSFileSearchHandler 
 * @Description: �ļ���ѯ�б��鿴������
 * @author panfeng
 * @date 2014-9-17
 *  
 */
public class BGSFileSearchHandler extends BaseHandler{

	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public BGSFileSearchHandler() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * �칫�ҡ����ò�������������֮���ļ���ѯ�б�
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList BGSFileList(Connection conn, Data data, int pageSize,
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
		String AF_POSITION = data.getString("AF_POSITION", null);	//�ļ�λ��
		String AF_GLOBAL_STATE = data.getString("AF_GLOBAL_STATE", null);	//�ļ�״̬
		String FAMILY_TYPE = data.getString("FAMILY_TYPE", null);	//��������
		String PROVINCE_ID = data.getString("PROVINCE_ID", null);	//ʡ��
		String WELFARE_ID = data.getString("WELFARE_ID", null);	//����Ժ
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("BGSFileList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, NAME, AF_POSITION, AF_GLOBAL_STATE, COUNTRY_CODE, ADOPT_ORG_ID, FAMILY_TYPE, FAMILY_TYPE, PROVINCE_ID, WELFARE_ID, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * ��˲��ļ���ѯ�б�
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 */
	public DataList SHBFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String MALE_NATION = data.getString("MALE_NATION", null);	//�з�����
		String MALE_BIRTHDAY_START = data.getString("MALE_BIRTHDAY_START", null);	//��ʼ�г�������
		String MALE_BIRTHDAY_END = data.getString("MALE_BIRTHDAY_END", null);	//��ֹ�г�������
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FEMALE_NATION = data.getString("FEMALE_NATION", null);	//Ů������
		String FEMALE_BIRTHDAY_START = data.getString("FEMALE_BIRTHDAY_START", null);	//��ʼŮ��������
		String FEMALE_BIRTHDAY_END = data.getString("FEMALE_BIRTHDAY_END", null);	//��ֹŮ��������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String FAMILY_TYPE = data.getString("FAMILY_TYPE", null);	//��������
		String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", null);	//�Ƿ�Լ����
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("SHBFileList", FILE_NO, FILE_TYPE, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, MALE_NATION, MALE_BIRTHDAY_START, MALE_BIRTHDAY_END, FEMALE_NAME, FEMALE_NATION, FEMALE_BIRTHDAY_START, FEMALE_BIRTHDAY_END, COUNTRY_CODE, ADOPT_ORG_ID, FAMILY_TYPE, IS_CONVENTION_ADOPT, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getFileData 
	 * @Description: �����ļ�ID��ȡ�ļ�����ϸ��Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param fileID
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public Data getFileData(Connection conn, String fileID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFileData", fileID);
		return ide.find(sql).getData(0);
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
	 * @throws DBException  
	 * @Title: getPreList 
	 * @Description: ����Ԥ����ϢID��ȡԤ��������Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param ri_id
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public DataList getPreList(Connection conn, String riIds) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ri_id = "'";
		if(riIds.indexOf(",") > 0){
			String[] child_id = riIds.split(",");
			for(int i = 0; i < child_id.length; i++){
				ri_id += child_id[i] + "','";
			}
			ri_id = ri_id.substring(0, ri_id.lastIndexOf(","));
		}else{
			ri_id += riIds + "'";
		}
		String sql = getSql("getPreList",ri_id);
		dl = ide.find(sql);
		return dl;
	}
    
}
