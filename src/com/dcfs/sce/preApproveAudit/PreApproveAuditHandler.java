/**   
 * @Title: PreApproveAuditHandler.java 
 * @Package com.dcfs.sce.preApproveAudit 
 * @Description: Ԥ��������˲���
 * @author yangrt   
 * @date 2014-10-9 ����4:01:45 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveAudit;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.util.Map;

import com.dcfs.sce.common.PreApproveConstant;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: PreApproveAuditHandler 
 * @Description: Ԥ��������ݲ���
 * @author yangrt
 * @date 2014-10-9 ����4:01:45 
 *  
 */
public class PreApproveAuditHandler extends BaseHandler {

	/**
	 * @Title: PreApproveAuditListAZB
	 * @Description: ���ò�Ԥ��������˲�ѯ�б�
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
	public DataList PreApproveAuditListAZB(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String ADOPT_ORG_NAME_CN = data.getString("ADOPT_ORG_NAME_CN",null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME",null);					//������������
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);				//Ů����������
		String PROVINCE_ID = data.getString("PROVINCE_ID",null);				//ʡ��
		String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN",null);		//����Ժ
		String NAME = data.getString("NAME",null);								//��ͯ����
		String SEX = data.getString("SEX",null);								//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);			//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);				//��ͯ������ֹ����
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS",null);			//�ر��ע
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);			//������ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);				//�����ֹ����
		String AUD_STATE2 = data.getString("AUD_STATE2",null);					//���ò�״̬
		String AUD_STATE1 = data.getString("AUD_STATE1",null);					//��˲�״̬
		String LAST_STATE2 = data.getString("LAST_STATE2",null);				//�ļ�ĩ�β���״̬
		String ATRANSLATION_STATE2 = data.getString("ATRANSLATION_STATE2",null);//�ļ�����״̬
		String RI_STATE = data.getString("RI_STATE",null);						//Ԥ��״̬
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);		//Ԥ��ͨ����ʼ����
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);			//Ԥ��ͨ����ֹ����
		
		if(RI_STATE == null || "".equals(RI_STATE)){
			RI_STATE = "('1','2')";
			if(AUD_STATE2 == null || "".equals(AUD_STATE2)){
				AUD_STATE2 = "('0','4')";
			}else{
				String str = AUD_STATE2;
				AUD_STATE2 = "('" + str + "')";
			}
		}else{
			RI_STATE = "('" + RI_STATE + "')";
			if(AUD_STATE2 != null && !"".equals(AUD_STATE2)){
				String str = AUD_STATE2;
				AUD_STATE2 = "('" + str + "')";
			}
		}
		
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveAuditList",ADOPT_ORG_NAME_CN,MALE_NAME,FEMALE_NAME,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,SPECIAL_FOCUS,REQ_DATE_START,REQ_DATE_END,AUD_STATE1,LAST_STATE2,ATRANSLATION_STATE2,RI_STATE,PASS_DATE_START,PASS_DATE_END,compositor,ordertype,AUD_STATE2);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: PreApproveAuditSave 
	 * @Description: Ԥ�����������Ϣ�������
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param applydata
	 * @return boolean 
	 * @throws DBException
	 */
	public boolean PreApproveAuditSave(Connection conn, Map<String, Object> data,Map<String, Object> applydata,Map<String, Object> suppledata, Map<String, Object> suppletranslationdata, String type) throws DBException {
		//���������Ϣ
		Data auditdata = new Data(data);
		auditdata.setConnection(conn);
        auditdata.setEntityName("SCE_REQ_ADUIT");
        auditdata.setPrimaryKey("RAU_ID");
        auditdata.store();
        
        //��˲�ͨ��ʱ������Ԥ�����������
        Data updatedata = new Data(applydata);
        String ri_state = updatedata.getString("RI_STATE");
        if(PreApproveConstant.PRE_APPROVAL_SHBTG.equals(ri_state)){
        	UserInfo userinfo = SessionInfo.getCurUser();
        	updatedata.add("PUB_ID", "");										//����״̬�ƿ�
        	updatedata.add("LOCK_STATE", "1");									//�������
        	updatedata.add("UNLOCKER_ID", userinfo.getPersonId());				//���������id
        	updatedata.add("UNLOCKER_NAME", userinfo.getPerson().getEnName());	//�������������
        	updatedata.add("UNLOCKER_DATE", DateUtility.getCurrentDateTime());	//�����������
			updatedata.add("UNLOCKER_TYPE", "2");								//����������ͣ����Ľ����UNLOCKER_TYPE��2��
			
			//�޸������ͯ������¼���еķ���״̬����Ϊ�ѷ�����PUB_STATE��2��
			Data pubData = new Data();
			pubData.setConnection(conn);
			pubData.setEntityName("SCE_PUB_RECORD");
			pubData.setPrimaryKey("PUB_ID");
			pubData.add("PUB_ID", updatedata.getString("PUB_ID"));
			pubData.add("PUB_STATE", "2");
			pubData.add("LOCK_DATE", "");
			pubData.add("ADOPT_ORG_ID", "");
			pubData.store();
			
			//�޸Ķ�ͯ������Ϣ���еķ���״̬����Ϊ�ѷ�����PUB_STATE��2��
			Data childData = new Data();
			childData.setConnection(conn);
			childData.setEntityName("CMS_CI_INFO");
			childData.setPrimaryKey("CI_ID");
			childData.add("CI_ID", updatedata.getString("CI_ID"));
			childData.add("PUB_STATE", "2");
			childData.store();
        }
    			
		//����������Ϣ
        updatedata.setConnection(conn);
        updatedata.setEntityName("SCE_REQ_INFO");
        updatedata.setPrimaryKey("RI_ID");
		updatedata.store();
		
		//��ǰ��������˽��
    	String audit_option = auditdata.getString("AUDIT_OPTION","");
    	if("4".equals(audit_option)){
    		//�����˽��Ϊ������ϣ����ʼ��Ԥ�����벹���¼
    		Data initdata = new Data(suppledata);
    		initdata.setConnection(conn);
    		initdata.setEntityName("SCE_REQ_ADDITIONAL");
    		initdata.setPrimaryKey("RA_ID");
    		initdata.create();
    	}else if("6".equals(audit_option)){
    		//��ʼ��������¼
    		Data initdata = new Data(suppletranslationdata);
    		initdata.setConnection(conn);
    		initdata.setEntityName("SCE_REQ_TRANSLATION");
    		initdata.setPrimaryKey("AT_ID");
    		initdata.create();
    	}
    	
    	//��ʼ����һ��˼������˼�¼
    	if("SHB".equals(type)){
    		String level = auditdata.getString("AUDIT_LEVEL","");
    		if("0".equals(level)){
    			if("1".equals(audit_option) || "2".equals(audit_option)){
        			Data auditData = new Data();
        			auditData.add("RI_ID", updatedata.getString("RI_ID"));
        			auditData.add("AUDIT_TYPE", "1");		//������ͣ���˲����
        			auditData.add("AUDIT_LEVEL", "1");		//��˼���:1�������������
        			auditData.add("OPERATION_STATE", "0");	//����״̬��������
            		auditData.setConnection(conn);
        			auditData.setEntityName("SCE_REQ_ADUIT");
        			auditData.setPrimaryKey("RAU_ID");
        			auditData.create();
        		}
    		}else{
    			if("7".equals(audit_option) || "8".equals(audit_option)){
        			Data auditData = new Data();
        			auditData.add("RI_ID", updatedata.getString("RI_ID"));
        			auditData.add("AUDIT_TYPE", "1");		//������ͣ���˲����
        			auditData.add("OPERATION_STATE", "0");	//����״̬��������
            		if("8".equals(audit_option)){			//�����ϱ�
            			auditData.add("AUDIT_LEVEL", "2");	//��˼��𣺷ֹ���������
            		}else if("7".equals(audit_option)){		//�˻ؾ�����
            			auditData.add("AUDIT_LEVEL", "0");	//��˼��𣺾��������
            		}
            		auditData.setConnection(conn);
        			auditData.setEntityName("SCE_REQ_ADUIT");
        			auditData.setPrimaryKey("RAU_ID");
        			auditData.create();
        		}
    		}
    	}
        
		return true;
	}
	
	/**
	 * @Title: PreApproveAuditRecordsList 
	 * @Description: ����Ԥ�������¼id,��ȡԤ�����벹���¼��Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @param type
	 * @return DataList
	 * @throws DBException
	 */
	public DataList PreApproveSuppleRecordsList(Connection conn, String ri_id) throws DBException {
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveSuppleRecordsList",ri_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @Title: PreApproveAuditRecordsList 
	 * @Description: ����Ԥ�������¼id,��ȡԤ��������˼�¼��Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @param type
	 * @return DataList
	 * @throws DBException
	 */
	public DataList PreApproveAuditRecordsList(Connection conn, String ri_id) throws DBException {
		/*String AUDIT_TYPE = null;
		if(type.equals("AZB")){
			AUDIT_TYPE = "2";	//���ò����
		}else{
			AUDIT_TYPE = "1";	//��˲����
		}*/
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveAuditRecordsList",ri_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/** 
	 * @Title: PreApproveCancelApplySave 
	 * @Description: ����Ԥ������Ԥ��������Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean 
	 * @throws DBException 
	 */
	public boolean PreApproveCancelApplySave(Connection conn, Map<String,Object> data, Map<String,Object> fbdata, Map<String,Object> cdata) throws DBException {
		Data ridata = new Data(data);
		ridata.setConnection(conn);
		ridata.setEntityName("SCE_REQ_INFO");
		ridata.setPrimaryKey("RI_ID");
		ridata.store();
		
		//����/����������¼
		Data pubData = new Data(fbdata);
		pubData.setConnection(conn);
		pubData.setEntityName("SCE_PUB_RECORD");
		pubData.setPrimaryKey("PUB_ID");
		if("".equals(pubData.getString("PUB_ID",""))){
			pubData.create();
		}else{
			pubData.store();
		}
		
		//���¶�ͯ������Ϣ��ķ���״̬
		Data childData = new Data(cdata);
		childData.setConnection(conn);
		childData.setEntityName("CMS_CI_INFO");
		childData.setPrimaryKey("CI_ID");
		childData.store();
		
		//��������ļ���������ļ����е�Ԥ����Ϣ
		String af_id = ridata.getString("AF_ID","");
		String file_type = ridata.getString("FILE_TYPE","");
		if(!af_id.equals("")){						//��������ļ���������ļ��е�Ԥ����Ϣ
			Data filedata = new Data();
			filedata.add("AF_ID", af_id);
			filedata.add("RI_ID", "");
			filedata.add("RI_STATE", "");
			filedata.add("CI_ID", "");
			if(file_type.equals("21")){				//����ļ�����Ϊ��ת��file_type:21��
				filedata.add("FILE_TYPE", "10");	//�ļ����͸�Ϊ������FILE_TYPE:10��
			}/*else if(file_type.equals("23")){		//����ļ�����Ϊ��˫��file_type:23��
				filedata.add("FILE_TYPE", "20");	//�ļ����͸�Ϊ���գ�FILE_TYPE:20��
			}*/
			filedata.setConnection(conn);
			filedata.setEntityName("FFS_AF_INFO");
			filedata.setPrimaryKey("AF_ID");
			filedata.store();
		}
		
		return false;
	}

	/**
	 * ���ò�Ԥ������ȷ��
	 * @param conn
	 * @param data
	 * @param fbdata
	 * @param cdata
	 * @return
	 * @throws DBException
	 */
	public boolean PreApproveCancelApplySaveForAZB(Connection conn, Map<String,Object> data, Map<String,Object> fbdata, Map<String,Object> cdata) throws DBException {
		Data ridata = new Data(data);
		ridata.setConnection(conn);
		ridata.setEntityName("SCE_REQ_INFO");
		ridata.setPrimaryKey("RI_ID");
		ridata.store();
		
		//����/����������¼
		Data pubData = new Data(fbdata);
		pubData.setConnection(conn);
		pubData.setEntityName("SCE_PUB_RECORD");
		pubData.setPrimaryKey("PUB_ID");
		if("".equals(pubData.getString("PUB_ID",""))){
			pubData.create();
		}else{
			pubData.store();
		}
		
		//���¶�ͯ������Ϣ��ķ���״̬
		Data childData = new Data(cdata);
		childData.setConnection(conn);
		childData.setEntityName("CMS_CI_INFO");
		childData.setPrimaryKey("CI_ID");
		childData.store();
		return false;
	}
	/** 
	 * @Title: PreApproveAuditListSHB 
	 * @Description: ��˲�Ԥ����������б�
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
	public DataList PreApproveAuditListSHB(Connection conn, Data data,String level,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String ADOPT_ORG_NAME_CN = data.getString("ADOPT_ORG_NAME_CN",null);	//������֯
		String MALE_NAME = data.getString("MALE_NAME",null);					//������������
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);				//Ů����������
		String PROVINCE_ID = data.getString("PROVINCE_ID",null);				//ʡ��
		String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN",null);		//����Ժ
		String NAME = data.getString("NAME",null);								//��ͯ����
		String SEX = data.getString("SEX",null);								//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);			//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);				//��ͯ������ֹ����
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS",null);			//�ر��ע
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);			//������ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);				//�����ֹ����
		String AUD_STATE2 = data.getString("AUD_STATE2",null);					//���ò�״̬
		String AUD_STATE1 = data.getString("AUD_STATE1",null);					//��˲�״̬
		String LAST_STATE = data.getString("LAST_STATE",null);				//�ļ�ĩ�β���״̬
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE",null);//�ļ�����״̬
		String RI_STATE = data.getString("RI_STATE",null);						//Ԥ��״̬
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);		//Ԥ��ͨ����ʼ����
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);			//Ԥ��ͨ����ֹ����
		
		if(RI_STATE == null || "".equals(RI_STATE)){
			RI_STATE = "('1','2')";
			if(AUD_STATE1 == null || "".equals(AUD_STATE1)){
				if(level.equals("one")){
					AUD_STATE1 = "('0','1','9')";
				}else if(level.equals("two")){
					AUD_STATE1 = "('2')";
				}else if(level.equals("three")){
					AUD_STATE1 = "('3')";
				}
			}else{
				String str = AUD_STATE1;
				AUD_STATE1 = "('" + str + "')";
			}
		}else{
			RI_STATE = "('" + RI_STATE + "')";
			if(AUD_STATE1 != null && !"".equals(AUD_STATE1)){
				String str = AUD_STATE1;
				AUD_STATE1 = "('" + str + "')";
			}
		}
			
//		if(AUD_STATE1 == null || "".equals(AUD_STATE1)){
//			if(level.equals("one")){
//				AUD_STATE1 = "('0','1','9')";
//			}else if(level.equals("two")){
//				AUD_STATE1 = "('2')";
//			}else if(level.equals("three")){
//				AUD_STATE1 = "('3')";
//			}
//		}else{
//			String str = AUD_STATE1;
//			AUD_STATE1 = "('" + str + "')";
//		}
		
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveAuditListSHB",ADOPT_ORG_NAME_CN,MALE_NAME,FEMALE_NAME,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,SPECIAL_FOCUS,REQ_DATE_START,REQ_DATE_END,AUD_STATE2,LAST_STATE,ATRANSLATION_STATE,RI_STATE,PASS_DATE_START,PASS_DATE_END,compositor,ordertype,AUD_STATE1);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/** 
	 * @Title: getPreApproveByReqNo 
	 * @Description: ����Ԥ�������ţ���ȡԤ��������Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param pre_reqNo
	 * @return Data 
	 * @throws DBException 
	 */
	public Data getPreApproveByReqNo(Connection conn, String reqNo) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreApproveByReqNo", reqNo);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @throws DBException  
	 * @Title: getPubDataById 
	 * @Description: ���ݷ�����¼id����ȡ������¼��Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param pub_id
	 * @return Data 
	 */
	public Data getPubDataById(Connection conn, String pub_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPubDataById", pub_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @throws DBException  
	 * @Title: getPreAuditId 
	 * @Description: TODO(������һ�仰�����������������)
	 * @author: yangrt;
	 * @param conn
	 * @param ri_id    �趨�ļ� 
	 * @return void    �������� 
	 * @throws 
	 */
	public Data getPreAuditId(Connection conn, String ri_id, String audit_type, String audit_level) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreAuditId", ri_id, audit_type, audit_level);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

}
