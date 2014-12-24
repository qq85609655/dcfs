/**   
 * @Title: SuppleQueryHandler.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: �����ѯ����
 * @author yangrt   
 * @date 2014-9-5 ����10:05:05 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import java.sql.Connection;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: SuppleQueryHandler 
 * @Description: �����ѯ����
 * @author yangrt;
 * @date 2014-9-5 ����10:05:05 
 *  
 */
public class SuppleQueryHandler extends BaseHandler {
	
	/**
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public SuppleQueryHandler(){
	}

	/**
	 * @Title: SuppleQueryList 
	 * @Description: �����ѯ�б�
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList SuppleQueryList(Connection conn, Data data, String operType, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯code
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String NOTICE_DATE_START = data.getString("SUBMIT_DATE_START", null);	//֪ͨ��ʼ����
		String NOTICE_DATE_END = data.getString("SUBMIT_DATE_END", null);	//֪ͨ��������
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);	//������ʼ����
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);	//�����ֹ����
		String AA_STATUS = data.getString("AA_STATUS", null);	//�ļ�����״̬
		
		String orgcode = null;
		if(!operType.equals("SHB")){
			UserInfo userinfo = SessionInfo.getCurUser();
			orgcode = userinfo.getCurOrgan().getOrgCode();
		}
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("SuppleQueryList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, FILE_TYPE, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, COUNTRY_CODE, ADOPT_ORG_ID, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}

	/**
	 * @Title: getSuppleData 
	 * @Description: �����ļ������¼ID,��ȡ�ļ�������ϢData
	 * @author: yangrt
	 * @param conn
	 * @param aa_id
	 * @return Data
	 * @throws DBException
	 */
	public Data getSuppleData(Connection conn, String aa_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getSuppleData", aa_id);
		DataList dl = ide.find(sql);
        return dl.getData(0);
	}

	/** 
	 * @Title: getReviseList 
	 * @Description: �ļ��޸���ʷ��¼
	 * @author: yangrt
	 * @param conn
	 * @param af_id
	 * @param compositor
	 * @param ordertype
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList getReviseList(Connection conn, String af_id, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getReviseList", af_id, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}


	/** 
	 * @Title: getChildList 
	 * @Description: ���ݶ�ͯ��Ϣid,��ȡ��ͯ��Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param ci_id
	 * @return DataList    �������� 
	 * @throws DBException
	 */
	public DataList getChildList(Connection conn, String str_ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String ci_id = "'";
		if(str_ci_id.contains(",")){
			for(int i = 0; i < str_ci_id.split(",").length; i++){
				ci_id += str_ci_id.split(",")[i] + "',";
			}
			ci_id = ci_id.substring(0, ci_id.lastIndexOf(","));
		}else{
			ci_id += str_ci_id + "'";
		}
		String sql = getSql("getChildList", ci_id);
		DataList dl = ide.find(sql);
        return dl;
	}

	/**
	 * @Title: getPreAuditList
	 * @Description: ����Ԥ������id,��ȡԤ����˼�¼��Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return DataList
	 * @throws DBException  
	 */
	public DataList getPreAuditList(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreAuditList", ri_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @Title: getFileAuditList 
	 * @Description: �����ļ�ID,��ȡ�ļ������ϢDataList
	 * @author: yangrt
	 * @param conn
	 * @param af_id
	 * @return DataList 
	 * @throws DBException  
	 */
	public DataList getFileAuditList(Connection conn, String af_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getFileAuditList", af_id);
		DataList dl = ide.find(sql);
		return dl;
	}
	
}
