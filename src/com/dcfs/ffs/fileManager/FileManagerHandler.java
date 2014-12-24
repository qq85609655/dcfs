/**   
 * @Title: FileManagerHandler.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: ��������֯���ļ���Ϣ���в�ѯ��¼�롢�޸ġ�ɾ�����ύ����ˮ�Ŵ�ӡ����������
 * @author yangrt
 * @date 2014-7-21 ����5:15:55 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import com.dcfs.ffs.common.FileCommonConstant;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;

public class FileManagerHandler extends BaseHandler {
	
	/***************	�ݽ���ͨ�ļ�����Begin	***************/

	/**
	 * @throws DBException  
	 * @Title: NormalFileList 
	 * @Description: �����������ݿ���в�ѯ���õ����������Ľ����
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList �����
	 * @throws 
	 */
	public DataList NormalFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String AF_COST = data.getString("AF_COST", null);	//Ӧ�ɽ��
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//�ύ��ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);	//�ύ��������
		String REG_STATE = data.getString("REG_STATE", null);	//�ļ�״̬
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("NormalFileList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, AF_COST, FILE_TYPE, REG_STATE, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws ParseException 
	 * @throws DBException  
	 * @Title: getNormalFileData
	 * @Description: �����������ˡ�Ů������������ѯ����֯�������ļ�
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return Data 
	 */
	public Data getNormalFileData(Connection conn, Data data) throws DBException, ParseException {
		//��ѯ����
		//String COUNTRY_CODE = data.getString("COUNTRY_CODE");	//����code
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID",null);	//������֯code
		String FILE_TYPE = data.getString("FILE_TYPE",null);	//�ļ�����code
		String MALE_NAME = data.getString("MALE_NAME",null);	//������������
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//Ů����������
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetNormalFileDataList", ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE);
		//��ȡ�����������ļ���Ϣ
		DataList dl = ide.find(sql);
		
		//�������µ��ļ����ݣ�Ĭ��Ϊnull
		Data reData = new Data();
		//�ж��Ƿ��з����������ļ���Ϣ
		if(dl.size() > 0){
			//�趨���ڸ�ʽ
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			int reIndex = 0;
			//�����������dl��,ȷ�������ļ���λ��
			for(int i = 0; i < dl.size(); i++){
				for(int j = i+1; j < dl.size(); j++){
					//��ȡ�ļ��Ĵ�������
					String istrdate = dl.getData(i).getString("CREATE_DATE");
					String jstrdate = dl.getData(j).getString("CREATE_DATE");
					Date idate = formatter.parse(istrdate);
					Date jdate = formatter.parse(jstrdate);
					if(idate.getTime() >= jdate.getTime()){
						reIndex = i;
					}else{
						reIndex = j;
					}
				}
			}
			//��ȡ�����ļ�
			reData = dl.getData(reIndex);
		}
		
		return reData;
	}

	
	/**
	 * @Title: NormalFileSaveFirst 
	 * @Description: �����ļ���һ���������
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return String 
	 * @throws DBException
	 */
	public String NormalFileSaveFirst(Connection conn, Map<String, Object> data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        dataadd.create();
		return dataadd.getString("AF_ID","");
	}

	/**
	 * @Title: NormalFileSave 
	 * @Description: ������Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @return
	 * @throws DBException    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws
	 */
	public boolean NormalFileSave(Connection conn, Map<String, Object> data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        dataadd.store();
		return true;
	}
	
	
	
	/***************	�ݽ���ͨ�ļ�����Begin	***************/
	
	/***************	�ݽ������ļ�����Begin	***************/
	
	/**
	 * @throws DBException  
	 * @Title: SpecialFileList 
	 * @Description: �����������ݿ���в�ѯ���õ����������Ľ����
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList �����
	 * @throws 
	 */
	public DataList SpecialFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String AF_COST = data.getString("AF_COST", null);	//Ӧ�ɽ��
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null);	//�ύ��ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null);	//�ύ��������
		String REG_STATE = data.getString("REG_STATE", null);	//�ĵǼ�״̬
		
		/*String NAME = data.getString("NAME",null);	//��ͯ����
		String BIRTHDAY_START = data.getString("",null);	//������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//������ֹ����
		String SEX = data.getString("SEX",null);	//��ͯ�Ա�
*/		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String filesql = getSql("SpecialFileList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, AF_COST, FILE_TYPE, REG_STATE, compositor, ordertype, orgcode);
		//���ݲ�ѯ������ȡ�����������ļ���Ϣ�����
		DataList dl = ide.find(filesql, pageSize, page);
		/*//�����ý�����������ݶ�ͯ�������������ڡ��Ա��ѯ�����������ļ���Ϣ
		for(int i = 0; i < dl.size(); i++){
			Data filedata = dl.getData(i);
			//��ȡ��ͯ����IDƴ�Ӵ�
			String str_ci_id = filedata.getString("CI_ID","");
			if(str_ci_id.indexOf(",") > 0){
				//�����ͯ����IDƴ�Ӵ���str_ci_id����Ϊ�գ��Ұ��������ͯ����id�����ָ�ƴ�Ӵ���ȡ��Ӧ�Ķ�ͯ����id
				String[] ci_id = str_ci_id.split(",");
				for(int j = 0; j < ci_id.length; j++){
					//�����ݶ�ͯ�������������ڡ��Ա��ѯ�����������ļ���Ϣ
					String cisql = getSql("GetChildData", NAME, BIRTHDAY_START, BIRTHDAY_END, SEX, ci_id[j]);
					DataList ciDataList = ide.find(cisql);
					if(ciDataList.size() > 0){
						Data ciData = ciDataList.getData(0);
						if(ci_id.length > 1){
							//����ü�ͥ�����˶����ͯ����Ըü�ͥ�ļ����б�ʶ
							filedata.add("NAME", "Mulity");
							filedata.add("BIRTHDAY", "");
							filedata.add("SEX", "");
						}else{
							filedata.add("NAME", ciData.getString("NAME"));
							filedata.add("BIRTHDAY", ciData.getString("BIRTHDAY"));
							filedata.add("SEX", ciData.getString("SEX"));
						}
						
						break;
					}
				}
				
			}else{
				if(!"".equals(str_ci_id)){
					//���ݶ�ͯ����id��ȡ�ö�ͯ���������Ա𡢳�������
					String cisql = getSql("GetChildData", NAME, BIRTHDAY_START, BIRTHDAY_END, SEX, str_ci_id);
					Data ciData = ide.find(cisql).getData(0);
					filedata.add("NAME", ciData.getString("NAME"));
					filedata.add("BIRTHDAY", ciData.getString("BIRTHDAY"));
					filedata.add("SEX", ciData.getString("SEX"));
				}
			}
			dl.set(i, filedata);
		}*/
		
        return dl;
	}
	
	/**
	 * @Title: SpecialFileSelectList 
	 * @Description: ��ȡԤ��ͨ���������ļ���Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return
	 * @throws DBException    �趨�ļ� 
	 * @return DataList    �������� 
	 * @throws
	 */
	public DataList SpecialFileSelectList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		String REQ_NO = data.getString("REQ_NO",null);						//������
		String MALE_NAME = data.getString("MALE_NAME", null);				//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);			//Ů��
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);			//��ͯ����
		String SEX = data.getString("SEX",null);							//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);		//������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);			//������ֹ����
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);		//������ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);			//�����ֹ����
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//Ԥ��ͨ����ʼ����
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);		//Ԥ��ͨ����ֹ����
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);//����������ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//�������޽�ֹ����
		String REMINDERS_STATE = data.getString("REMINDERS_STATE",null);	//�߰�״̬
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		UserInfo userinfo = SessionInfo.getCurUser();
		String organcode = userinfo.getCurOrgan().getOrgCode();
		String sql = getSql("SpecialFileSelectList", organcode, REQ_NO, MALE_NAME, FEMALE_NAME, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, REQ_DATE_START, REQ_DATE_END, PASS_DATE_START, PASS_DATE_END, SUBMIT_DATE_START, SUBMIT_DATE_END, REMINDERS_STATE, compositor, ordertype);
		dl = ide.find(sql, pageSize, page);
		return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: GetReqInfoByID 
	 * @Description: ����Ԥ��������ϢID����ȡ������Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param ri_id
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public Data GetReqInfoByID(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetReqInfoByID",ri_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: GetReqInfoByReqNo 
	 * @Description: TODO(������һ�仰�����������������)
	 * @author: yangrt;
	 * @param conn
	 * @param pRE_REQ_NO
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public Data GetReqInfoByReqNo(Connection conn, String req_no) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetReqInfoByReqNo",req_no);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: getChildDataList 
	 * @Description: ���ݶ�ͯ����id��ȡ��ͯ��ϸ��Ϣ
	 * @author: yangrt;
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
		String sql = getSql("GetChildDataList",ci_id);
		dl = ide.find(sql);
		return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getSpecialFileData 
	 * @Description: ��ȡϵͳ�����ü�ͥ���ύ���ļ���Ϣ
	 * @author: yangrt;
	 * @param string
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public Data getSpecialFileData(Connection conn, String file_no) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		dl = ide.find(getSql("GetSpecialFileData",file_no));
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: SpecialFileSave 
	 * @Description: �����ļ��ݽ�����
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean SpecialFileSave(Connection conn, Map<String, Object> data, String flag) throws DBException {
		Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        if("add".equals(flag)){
        	dataadd.create();
        }else if("mod".equals(flag)){
        	dataadd.store();
        }
        
        String ri_id = dataadd.getString("RI_ID","");
        String af_id = dataadd.getString("AF_ID","");
        String ri_state = dataadd.getString("RI_STATE");
        if(ri_id.contains(",")){
        	//����Ԥ��������Ϣ���е��ļ�id
        	String[] riId = ri_id.split(",");
        	for(int i = 0; i < riId.length; i++){
	            Data ridata = new Data();
	            ridata.add("RI_ID", riId[i]);
	            ridata.add("AF_ID", af_id);
	            ridata.add("RI_STATE", ri_state);
	            ridata.setConnection(conn);
	            ridata.setEntityName("SCE_REQ_INFO");
	            ridata.setPrimaryKey("RI_ID");
	            ridata.store();
        	}
        }else{
        	Data ridata = new Data();
            ridata.add("RI_ID", ri_id);
            ridata.add("AF_ID", af_id);
            ridata.add("RI_STATE", ri_state);
            ridata.setConnection(conn);
            ridata.setEntityName("SCE_REQ_INFO");
            ridata.setPrimaryKey("RI_ID");
            ridata.store();
        }
        
        
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: forUpdateSceReqInfo 
	 * @Description: ����Ԥ����¼
	 * @author: yangrt;
	 * @param conn
	 * @param str_ri_id
	 * @return DataList 
	 * @throws 
	 */
	public DataList forUpdateSceReqInfo(Connection conn, String str_ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String ri_id = "('";
		if(str_ri_id.contains(",")){
			String[] tempRiId = str_ri_id.split(",");
			for(int i = 0; i < tempRiId.length; i++){
				ri_id += tempRiId[i] + "','";
			}
			ri_id = ri_id.substring(0, ri_id.lastIndexOf(",")) + ")";
		}else{
			ri_id += str_ri_id + "')";
		}
		dl = ide.find(getSql("forUpdateSceReqInfo",ri_id));
		return dl;
	}
	
	/***************	
	 * �ݽ������ļ�����End	***************/
	
	/***************	�����ļ�����Start	***************/
	
	/**
	 * @throws DBException  
	 * @Title: SuppleFileList 
	 * @Description: �����ļ��б�
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return    �趨�ļ� 
	 * @return DataList    �������� 
	 * @throws 
	 */
	public DataList SuppleFileList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
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
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("SuppleFileList", MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, FILE_TYPE, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS, compositor, ordertype, orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @throws DBException  
	 * @Title: getSuppleFileData 
	 * @Description: ���ݲ����ļ�id����ȡ�ļ���Ϣ��������Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param aa_id
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 */
	public Data getSuppleFileData(Connection conn, String aa_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetSuppleFileData",aa_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @throws DBException  
	 * @Title: SuppleFileSave 
	 * @Description: ���油���ļ���Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param aadata
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 */
	public boolean SuppleFileSave(Connection conn, Data aadata, Data filedata) throws DBException {
		aadata.setConnection(conn);
        aadata.setEntityName("FFS_AF_ADDITIONAL");
        aadata.setPrimaryKey("AA_ID");
    	aadata.store();
    	
    	filedata.setConnection(conn);
        filedata.setEntityName("FFS_AF_INFO");
        filedata.setPrimaryKey("AF_ID");
    	filedata.store();
    	
    	
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: SuppleBatchSubmit 
	 * @Description: �����ļ������ύ
	 * @author: yangrt
	 * @param conn
	 * @param aa_id
	 * @return boolean 
	 */
	public boolean SuppleBatchSubmit(Connection conn, String[] aa_id) throws DBException {
		UserInfo curuser = SessionInfo.getCurUser();
		for (int i = 0; i < aa_id.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_ADDITIONAL");
			data.setPrimaryKey("AA_ID");
			data.add("AA_ID", aa_id[i]);
			data.add("FEEDBACK_USERID", curuser.getPersonId());	//������ID
			data.add("FEEDBACK_USERNAME", curuser.getPerson().getCName());	//����������
			data.add("FEEDBACK_ORGID", curuser.getCurOrgan().getOrgCode());	//��������֯code
			data.add("FEEDBACK_DATE", DateUtility.getCurrentDateTime());	//��������
			data.add("AA_STATUS", "2");	//�ļ�����״̬
			data.store();
			
			String af_id = this.getSuppleFileData(conn, aa_id[i]).getString("AF_ID");
			Data filedata = new Data();
	        filedata.add("AF_ID", af_id);
	        filedata.add("SUPPLY_STATE", "2");
			filedata.setConnection(conn);
	        filedata.setEntityName("FFS_AF_INFO");
	        filedata.setPrimaryKey("AF_ID");
	    	filedata.store();
		}
		return true;
	}
	
	/**
	 * @Title: FileProgressList 
	 * @Description: �ļ����ȼ����ò�ѯ�б�
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList FileProgressList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);								//���ı��
		String MALE_NAME = data.getString("MALE_NAME", null);							//��������
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);						//Ů������
		String FILE_TYPE = data.getString("FILE_TYPE", null);							//�ļ�����
		String CHILD_TYPE = data.getString("CHILD_TYPE", null);							//��������
		String PAID_NO = data.getString("PAID_NO", null);								//�ɷѱ��
		String AF_COST_PAID = data.getString("AF_COST_PAID", null);						//�ɷ�״̬
		String AF_COST = data.getString("AF_COST", null);								//Ӧ�ɽ��
		String FEEDBACK_NUM = data.getString("FEEDBACK_NUM", null);						//�����������
		String IS_PAUSE = data.getString("IS_PAUSE", null);								//��ͣ״̬
		String AF_GLOBAL_STATE = data.getString("AF_GLOBAL_STATE", null);				//����״̬
		String IS_FINISH = data.getString("IS_FINISH", null);							//���״̬
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);		//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);			//���Ľ�������
		String ADVICE_NOTICE_DATE_START = data.getString("ADVICE_NOTICE_DATE_START", null);		//���������ʼ����
		String ADVICE_NOTICE_DATE_END = data.getString("ADVICE_NOTICE_DATE_END", null);		//���������ֹ����
		String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);				//ǩ����ʼ����
		String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);					//ǩ����ֹ����
		String ADREG_DATE_START = data.getString("ADREG_DATE_START", null);				//�����Ǽ���ʼ����
		String ADREG_DATE_END = data.getString("ADREG_DATE_END", null);					//�����Ǽǽ�ֹ����
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("FileProgressList", orgCode, FILE_NO, MALE_NAME, FEMALE_NAME, FILE_TYPE, CHILD_TYPE, PAID_NO, AF_COST_PAID, AF_COST, FEEDBACK_NUM, IS_PAUSE, AF_GLOBAL_STATE, IS_FINISH, REGISTER_DATE_START, REGISTER_DATE_END, ADVICE_NOTICE_DATE_START, ADVICE_NOTICE_DATE_END, SIGN_DATE_START, SIGN_DATE_END, ADREG_DATE_START, ADREG_DATE_END, compositor, ordertype);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @Title: getReqDataList 
	 * @Description: ����Ԥ����ϢID,��ȡԤ����Ϣ�б�
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return DataList
	 * @throws DBException
	 */
	public DataList getReqDataList(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetReqDataList", ri_id);
		DataList dl = ide.find(sql);
        return dl;
	}
	
	/***************	�����ļ�����End	***************/
	
	
	/***************	�ɷ���Ϣ����Start	***************/
	
	/**
	 * @Title: PaymentList 
	 * @Description: �ɷ���Ϣ��ѯ�б�
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
	public DataList PaymentList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String PAID_NO = data.getString("PAID_NO", null);	//�ɷѱ��
		String COST_TYPE = data.getString("COST_TYPE", null);	//�ɷ�����
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//Ӧ�ɽ��
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//Ʊ����
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//������ʼ����
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//���˽�ֹ����
		String ARRIVE_VALUE = data.getString("SUBMIT_DATE_END", null);	//���˽��
		String ARRIVE_STATE = data.getString("FILE_TYPE", null);	//����״̬
		String ARRIVE_ACCOUNT_VALUE = data.getString("FEEDBACK_DATE_START", null);	//�����˺�ʹ�ý��
		String FILE_NO = data.getString("FEEDBACK_DATE_END", null);	//���ı��
		
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PaymentList",PAID_NO,COST_TYPE,PAID_SHOULD_NUM,PAR_VALUE,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_VALUE,ARRIVE_STATE,ARRIVE_ACCOUNT_VALUE,FILE_NO,compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @Title: getPaymentData 
	 * @Description: ���ݽɷ���ϢID����ȡ�ɷ���Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param cheque_id
	 * @return Data
	 * @throws DBException  
	 */
	public Data getPaymentData(Connection conn, String cheque_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetPaymentData",cheque_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @Title: PaymentNoticeList 
	 * @Description: �ɷ�֪ͨ��Ϣ��ѯ�б�
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
	public DataList PaymentNoticeList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String PAID_NO = data.getString("PAID_NO", null);	//�߽ɱ��
		String COST_TYPE = data.getString("COST_TYPE", null);	//�ɷ�����
		String CHILD_NUM = data.getString("CHILD_NUM", null);	//������ͯ����
		String S_CHILD_NUM = data.getString("S_CHILD_NUM", null);	//�����ͯ����
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//Ӧ�ɽ��
		String NOTICE_DATE_START = data.getString("NOTICE_DATE_START", null);	//֪ͨ��ʼ����
		String NOTICE_DATE_END = data.getString("NOTICE_DATE_END", null);	//֪ͨ��ֹ����
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//������ʼ����
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//���˽�ֹ����
		String ARRIVE_VALUE = data.getString("ARRIVE_VALUE", null);	//���˽��
		//���ݲ���
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PaymentNoticeList",PAID_NO,COST_TYPE,CHILD_NUM,S_CHILD_NUM,PAID_SHOULD_NUM,NOTICE_DATE_START,NOTICE_DATE_END,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_VALUE,compositor,ordertype,orgCode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * @Title: getPaymentNoticeData 
	 * @Description: ���ݴ߽ɼ�¼ID����ȡ�߽�֪ͨ��Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param rm_id
	 * @return Data    �������� 
	 * @throws DBException
	 */
	public Data getPaymentNoticeData(Connection conn, String rm_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetPaymentNoticeData",rm_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/**
	 * @Title: AccountBalanceList 
	 * @Description: �����˻�ʹ�ü�¼�б�
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList    �������� 
	 * @throws DBException  
	 */
	public DataList AccountBalanceList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String PAID_NO = data.getString("PAID_NO", null);				//�ɷѱ��
		String OPP_TYPE = data.getString("OPP_TYPE", null);				//��������
		String SUM = data.getString("SUM", null);						//�˵����
		String OPP_USERNAME = data.getString("OPP_USERNAME", null);		//����������
		String OPP_DATE_START = data.getString("OPP_DATE_START", null);	//������ʼ����
		String OPP_DATE_END = data.getString("OPP_DATE_END", null);		//������ֹ����
		
		String orgcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		//���ݲ���
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("AccountBalanceList",PAID_NO,OPP_TYPE,SUM,OPP_USERNAME,OPP_DATE_START,OPP_DATE_END,compositor,ordertype,orgcode);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	
	/**
	 * @Title: getAccountBalanceData 
	 * @Description: ���ݽ����˻�ʹ�ü�¼id����ȡ��ϸ��Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param account_log_id
	 * @return Data
	 * @throws DBException 
	 */
	public Data getAccountBalanceData(Connection conn, String account_log_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("GetAccountBalanceData",account_log_id);
		dl = ide.find(sql);
		return dl.getData(0);
	}
	
	/***************	�ɷ���Ϣ����End	***************/
	
	
	
	/***************	�ļ�������������Strat	***************/
	
	/**
	 * @throws DBException  
	 * @Title: GetNormalFileByID 
	 * @Description: �����ļ�id��ȡ�ļ�����ϸ��Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param fileID
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public Data GetFileByID(Connection conn, String fileID) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetFileData", fileID);
		Data d = ide.find(sql).getData(0);
		return d;
		
	}
	
	/**
	 * @throws DBException  
	 * @Title: FileDelete 
	 * @Description: �����ļ�IDɾ��δ�Ǽǵ��ļ���Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param deleteAFID
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean FileDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList deleteList = new DataList();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("AF_ID");
			data.add("AF_ID", uuid[i]);
			deleteList.add(data);
			
			//ɾ������
			Data delData = this.GetFileByID(conn, uuid[i]);
			String male_photo = delData.getString("MALE_PHOTO","");	//����������Ƭ����
			String female_photo = delData.getString("FEMALE_PHOTO","");	//Ů��������Ƭ����
			String packageId = delData.getString("PACKAGE_ID","");	//����
			if(!"".equals(male_photo)){
				AttHelper.delAttById(male_photo, "AF");
			}
			if(!"".equals(female_photo)){
				AttHelper.delAttById(female_photo, "AF");
			}
			if(!"".equals(packageId)){
				AttHelper.delAttById(packageId, "AF");
			}
		}
		ide.remove(deleteList);
		return true;
	}
	
	/**
	 * @throws DBException  
	 * @Title: FileBatchSubmit 
	 * @Description: �����ύ�ļ���Ϣ
	 * @author: panfeng;
	 * @param conn
	 * @param deleteAFID
	 * @return    �趨�ļ� 
	 * @return boolean    �������� 
	 * @throws 
	 */
	public boolean FileBatchSubmit(Connection conn, String[] uuid) throws DBException {
		UserInfo curuser = SessionInfo.getCurUser();
		for (int i = 0; i < uuid.length; i++) {
			Data data = new Data();
			data.setConnection(conn);
			data.setEntityName("FFS_AF_INFO");
			data.setPrimaryKey("AF_ID");
			data.add("AF_ID", uuid[i]);
			data.add("REG_STATE", FileCommonConstant.DJZT_DDJ);
			data.add("SUBMIT_DATE", DateUtility.getCurrentDateTime());
			data.add("SUBMIT_USERID", curuser.getPersonId());
			data.store();
		}
		return true;
	}
	
	/**
	 * ��ˮ�Ŵ�ӡԤ��
	 *
	 * @param conn
	 * @param uuid
	 * @return
	 * @throws DBException
	 * @throws ParseException 
	 */
	public DataList getShowData(Connection conn, String printId, String type) throws DBException, ParseException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("GetFileSeqData", printId);
		DataList dl = ide.find(sql);
		if("special".equals(type)){
			for(int i = 0; i < dl.size(); i++){
				Data data = dl.getData(i);
				String str_ci_id = data.getString("CI_ID");
				
				String cisql = null;
				Data cadata = null;
				
				if(str_ci_id.indexOf(",") > 0){
					String[] ci_id = str_ci_id.split(",");
					
					cisql = getSql("GetChildApplicationData",ci_id[0]);
					cadata = ide.find(cisql).getData(0);
					
					String childname = cadata.getString("NAME");
					String pass_date = cadata.getString("PASS_DATE");
					//�趨���ڸ�ʽ
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
					for(int j = 1; j < ci_id.length; j++){
						cisql = getSql("GetChildApplicationData",ci_id[j]);
						cadata = ide.find(cisql).getData(0);
						childname += " " + cadata.getString("NAME");
						String pdate = cadata.getString("PASS_DATE");
						if(formatter.parse(pdate).getTime() > formatter.parse(pass_date).getTime()){
							pass_date = pdate;
						}
					}
					data.add("NAME", childname);
					data.add("PASS_DATE", pass_date);
				}else{
					cisql = getSql("GetChildApplicationData",str_ci_id);
					cadata = ide.find(cisql).getData(0);
					
					data.add("NAME", cadata.getString("NAME"));
					data.add("PASS_DATE", cadata.getString("PASS_DATE"));
				}
				dl.set(i, data);
			}
		}
		return dl;
	}

	/**
	 * @throws DBException  
	 * @Title: GetMKRORGCOAList 
	 * @Description: ��ȡ������Լ��֤����������Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @return    �趨�ļ� 
	 * @return DataList    �������� 
	 * @throws 
	 */
	public DataList getMKRORGCOAList(Connection conn) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		dl = ide.find(getSql("GetMKRORGCOAList"));
		return dl;
	}

	/**
	 * @throws DBException  
	 * @Title: getAdoptOrgInfo 
	 * @Description: ����������֯id����ȡ������֯��Ϣ
	 * @author: yangrt;
	 * @param conn
	 * @param orgid
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws 
	 */
	public Data getAdoptOrgInfo(Connection conn, String orgid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		DataList dl = new DataList();
		String sql = getSql("getAdoptOrgInfo", orgid);
		dl = ide.find(sql);
		return dl.getData(0);
	}

	/***************	�ļ�������������End	***************/

}
