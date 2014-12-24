/**   
 * @Title: FileAuditHandler.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����5:10:43 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/** 
 * @ClassName: FileAuditHandler 
 * @Description: TODO(������һ�仰��������������) 
 * @author songhn@21softech.com 
 * @date 2014-7-14 ����5:10:43 
 *  
 */
public class FileAuditHandler extends BaseHandler {

	public FileAuditHandler() {
	}

	public FileAuditHandler(String propFileName) {
		super(propFileName);
	}
	


	
	
	
	
	
	/**
	 * ����������б�	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForOneLevel(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);	//���տ�ʼ����
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);	//���ս�������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null);	//��������
		String AUD_STATE = data.getString("AUD_STATE", null);	//���״̬
		String AA_STATUS = data.getString("AA_STATUS", null);	//����״̬
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null);	//�ط�״̬
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE", null);	//����״̬
		
		if(null==compositor||"".equals(compositor)){
			compositor="t.RECEIVER_DATE";
		}
		
		if(null==ordertype||"".equals(ordertype)){
			ordertype="asc";
		}
		
		if("".equals(AUD_STATE)||null==AUD_STATE){
			AUD_STATE="0,1,9";
		}
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForOneLevel",FILE_NO, RECEIVER_DATE_START, RECEIVER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, TRANSLATION_QUALITY, AUD_STATE, AA_STATUS, RTRANSLATION_STATE,ATRANSLATION_STATE, compositor, ordertype);
		System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * �������θ����б�	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForTwoLevel(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);	//���տ�ʼ����
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);	//���ս�������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null);	//��������
		String AUD_STATE = data.getString("AUD_STATE", null);	//���״̬
		String AA_STATUS = data.getString("AA_STATUS", null);	//����״̬
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null);	//�ط�״̬
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE", null);	//����״̬
		
		if(null==compositor||"".equals(compositor)){
			compositor="t.RECEIVER_DATE";
		}
		
		if(null==ordertype||"".equals(ordertype)){
			ordertype="asc";
		}
		
		if("".equals(AUD_STATE)||null==AUD_STATE){
			AUD_STATE="2";
		}
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForTwoLevel",FILE_NO, RECEIVER_DATE_START, RECEIVER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, TRANSLATION_QUALITY, AUD_STATE, AA_STATUS, RTRANSLATION_STATE,ATRANSLATION_STATE, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}
	
	/**
	 * �ֹ����������б�	
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList findListForThreeLevel(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);	//���տ�ʼ����
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);	//���ս�������
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);	//����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null);	//��������
		String AUD_STATE = data.getString("AUD_STATE", null);	//���״̬
		String AA_STATUS = data.getString("AA_STATUS", null);	//����״̬
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null);	//�ط�״̬
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE", null);	//����״̬
		
		if(null==compositor||"".equals(compositor)){
			compositor="t.RECEIVER_DATE";
		}
		
		if(null==ordertype||"".equals(ordertype)){
			ordertype="asc";
		}
		
		if("".equals(AUD_STATE)||null==AUD_STATE){
			AUD_STATE="3";
		}
		
		//���ݲ���
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findListForThreeLevel",FILE_NO, RECEIVER_DATE_START, RECEIVER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, TRANSLATION_QUALITY, AUD_STATE, AA_STATUS, RTRANSLATION_STATE,ATRANSLATION_STATE, compositor, ordertype);
		//System.out.println("sql---->"+sql);
		DataList dl = ide.find(sql, pageSize, page);
        return dl;
	}


	/**
	 * ��ȡ��˼�¼��Ϣ
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findAuditList(Connection conn, String fileid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findAuditList", fileid);
		return ide.find(sql);
	}
	
	/**
	 * ��ȡ�����¼��Ϣ
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findBcRecordList(Connection conn, String fileid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findBcRecordList", fileid);
		return ide.find(sql);
	}
	
	/**
	 * ��ȡ�ļ��޸ļ�¼��Ϣ
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findReviseList(Connection conn, String fileid, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findReviseList", fileid,compositor, ordertype);
		//System.out.println("sql-->"+sql);
		return ide.find(sql, pageSize, page);
	}
	
	/**
	 * ��ȡ�ļ������¼��Ϣ
	 * @param conn
	 * @param fileid
	 * @return
	 * @throws DBException
	 */
	public DataList findTranslationList(Connection conn, String fileid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findTranslationList", fileid);
		return ide.find(sql);
	}
	
	/**
	 * �����ļ���������ļ�������Ϣ
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @return
	 */
	public Data getFileInfoByID(Connection conn,String afId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findFileInfoByID",afId);
		 return ide.find(sql).getData(0);
		
	}
	
	/**
	 * ���ݶ�ͯids��ö�ͯ������Ϣ
	 * @description 
	 * @author MaYun
	 * @date Dec 7, 2014
	 * @return
	 */
	public DataList findETInfoList(Connection conn,String etids) throws DBException{
		DataList dataList = new DataList();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findETInfoList",etids);
		dataList = ide.find(sql);
		return dataList;
	}
	
	/**
	 * ����Ԥ��ids���Ԥ����˻�����Ϣ
	 * @description 
	 * @author MaYun
	 * @date Dec 7, 2014
	 * @return
	 */
	public DataList findYPSHInfoList(Connection conn,String ypids) throws DBException{
		DataList dataList = new DataList();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("findYPSHInfoList",ypids);
		dataList = ide.find(sql);
		return dataList;
	}
	
	/**
	 * ����������������˻�����Ϣ
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @return
	 */
	public Data getAuditInfoByID(Connection conn,String auId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findAuditInfoByID",auId);
		 return ide.find(sql).getData(0);
		
	}
	
	/**
	 * �����ļ���������˼��������������Ϣ
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @param String afId �����ļ�����ID
	 * @param level ��˼��� 0:���������;1:�������θ���;2:�ֹ���������
	 * @return
	 */
	public Data getLastAuditInfoByAfID(Connection conn,String afId,String level) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findLastAuditInfoByAfID",afId,level);
		 DataList resultList = ide.find(sql);
		 Data data = new Data();
		 data.add("AUDIT_LEVEL", "");
		 data.add("AUDIT_OPTION", "");
		 data.add("AUDIT_CONTENT_CN", "");
		 data.add("AUDIT_USERID", "");
		 data.add("AUDIT_USERNAME", "");
		 data.add("AUDIT_DATE", "");
		 data.add("OPERATION_STATE", "");
		 data.add("AUDIT_REMARKS", "");
		 
		 if(resultList.size()>0){
			 data = ide.find(sql).getData(0);
		 }
		 return data;
		
	}
	
	/**
	 * �����ļ���������ļ������¼
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @return
	 */
	public DataList getBCFileListByID(Connection conn,String afId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("findBCFileListByID",afId);
		 return ide.find(sql);
		
	}
	
	/**
	 * �����ļ���������ļ��������
	 * @description 
	 * @author MaYun
	 * @date Aug 14, 2014
	 * @param afId �ļ�����
	 * @return int num �ļ��������
	 */
	public int getFileBuChongNum(Connection conn,String afId) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		 String sql = getSql("getFileBuChongNum",afId);
		 return ide.find(sql).getData(0).getInt("NUM");
		
	}

	/**
	 * ��������ID��ñ��ļ�����һ���ļ�������Ϣ
	 * @param afId
	 * @return
	 * @throws DBException
	 */
	public Data getBCFileInfoById(Connection conn,String afId)throws DBException{
		Data data = new Data();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getBCFileInfoById",afId);
		DataList list = ide.find(sql);
		if(list.size()>0){
			data = list.getData(0);
		}
		return  data;
	}
	
	 /**
     * �������Ϣ���ﱣ�������Ϣ
     * @author MaYun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveAuditInfo(Connection conn,Map<String, Object> auditData)
            throws DBException {
    	//***���������Ϣ*****
        Data dataadd = new Data(auditData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_AUDIT");
        dataadd.setPrimaryKey("AU_ID");
        Data returnData = dataadd.store();
        return returnData;
    }
    
    /**
     * ���ļ�������Ϣ���ﱣ���ļ���Ϣ
     * @author MaYun
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveFileInfo(Connection conn,Map<String, Object> fileData)
            throws DBException {
    	//***�����ļ�������Ϣ*****
        Data dataadd = new Data(fileData);
        dataadd.setConnection(conn);
        dataadd.setEntityName("FFS_AF_INFO");
        dataadd.setPrimaryKey("AF_ID");
        Data returnData = dataadd.store();
        return returnData;
    }

	/**
	 * @Title: getAuditID 
	 * @Description: �����ļ�id����˼��𣬻�ȡ����״̬Ϊ�����е���˼�¼ID
	 * @author: yangrt
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @return Data    �������� 
	 * @throws DBException
	 */
	public Data getAuditID(Connection conn, String af_id, String audit_level) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAuditID",af_id,audit_level);
		return ide.find(sql).getData(0);
	}
	
	/**
	 * @Description: �����ļ�id����˼��𣬻�ȡ����״̬Ϊ�����е���˼�¼ID
	 * @author: mayun
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @param operation_state ,������״̬��������'a','b','c'���ַ���
	 * @return Data    �������� 
	 * @throws DBException
	 */
	public Data getAuditIDForWJSH(Connection conn, String af_id, String audit_level,String operation_state) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAuditIDForWJSH",af_id,audit_level,operation_state);
		List resultList = ide.find(sql);
		if(resultList.size()>0){
			return ide.find(sql).getData(0);
		}else{
			Data data = new Data();
			data.add("AU_ID", "");
			return data;
		}
		
	}
	
	/**
	 * @Title: isCanBF 
	 * @Description: �����ļ�id�жϸ��ļ��Ƿ�ɽ��в�������
	 * @author: mayun
	 * @param conn
	 * @param af_id
	 * @param audit_level
	 * @return boolean true:���Բ���  false�������Բ���
	 * @throws DBException
	 */
	public boolean isCanBF(Connection conn, String af_id) throws DBException {
		Data fileData = this.getFileInfoByID(conn, af_id);
		String aa_id = fileData.getString("AA_ID");//�����¼ID
		String supply_state = fileData.getString("SUPPLY_STATE");//ĩ�β����ļ�״̬
		String bfzt = fileData.getString("ATRANSLATION_STATE");//����״̬
		boolean flag = true;
		
		if(aa_id==null||"".equals(aa_id)){
			flag = false;
		//}else if(supply_state=="0"||"0".equals(supply_state)||supply_state=="1"||"1".equals(supply_state)){
			//flag = false;
		}else if(null!=bfzt&&!"".equals(bfzt)){
			if("1".equals(bfzt)||"1"==bfzt||"0".equals(bfzt)||"0"==bfzt){
				flag = false;
			}else{
				flag = true;
			}
		}
		return flag;
	}
    
    

}
