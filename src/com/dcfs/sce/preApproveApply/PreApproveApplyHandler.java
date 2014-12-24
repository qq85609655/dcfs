/**   
 * @Title: PreApproveApplyHandler.java 
 * @Package PreApproveApplyHandler 
 * @Description: Ԥ���������
 * @author yangrt   
 * @date 2014-9-12 ����3:19:45 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveApply;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.util.Map;

import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileGlobalStatusAndPositionConstant;
import com.dcfs.ffs.fileManager.FileManagerAction;
import com.dcfs.ncm.special.SpecialMatchAction;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.common.PublishCommonManager;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: PreApproveApplyHandler 
 * @Description: Ԥ���������
 * @author yangrt;
 * @date 2014-9-12 ����3:19:45 
 *  
 */
public class PreApproveApplyHandler extends BaseHandler {

	/**
	 * @Title: PreApproveApplyList 
	 * @Description: Ԥ��������Ϣ��ѯ�б�
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
	public DataList PreApproveApplyList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String MALE_NAME = data.getString("MALE_NAME",null);				//������������
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);			//Ů����������
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);			//��ͯ����
		String SEX = data.getString("SEX",null);							//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);		//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);			//��ͯ������ֹ����
		String LOCK_DATE_START = data.getString("REQ_DATE_START",null);		//������ʼ����
		String LOCK_DATE_END = data.getString("REQ_DATE_END",null);			//������ֹ����
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);		//������ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);			//�����ֹ����
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//Ԥ��ͨ����ʼ����
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);		//Ԥ��ͨ����ֹ����
		String RI_STATE = data.getString("RI_STATE",null);					//Ԥ��״̬
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);//�ݽ��ļ���ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//�ݽ��ļ���ֹ����
		String REMINDERS_STATE = data.getString("REMINDERS_STATE",null);	//�߰�״̬
		String REM_DATE_START = data.getString("REM_DATE_START",null);		//�߰���ʼ����
		String REM_DATE_END = data.getString("REM_DATE_END",null);			//�߰��ֹ����
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//������ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END",null);//���Ľ�ֹ����
		String FILE_NO = data.getString("FILE_NO",null);					//���ı��
		String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//�ļ���������ʼ����
		String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);	//�ļ������½�ֹ����
		String LAST_STATE = data.getString("LAST_STATE",null);				//��˲�����״̬
		String LAST_STATE2 = data.getString("LAST_STATE2",null);			//���ò�����״̬
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveApplyList", MALE_NAME,FEMALE_NAME,NAME_PINYIN,SEX,
        		BIRTHDAY_START,BIRTHDAY_END,REQ_DATE_START,REQ_DATE_END,PASS_DATE_START,
        		PASS_DATE_END,RI_STATE,SUBMIT_DATE_START,SUBMIT_DATE_END,REMINDERS_STATE,
        		REM_DATE_START,REM_DATE_END,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,
        		UPDATE_DATE_START,UPDATE_DATE_END,LAST_STATE,LOCK_DATE_START,LOCK_DATE_END,compositor,ordertype,orgcode,LAST_STATE2);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: getPreApproveApplyData 
	 * @Description: ����Ԥ�������¼ID,��ȡԤ��������ϢData
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return Data
	 * @throws DBException  
	 */
	public Data getPreApproveApplyData(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreApproveApplyData", ri_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: PreApproveApplySubmit 
	 * @Description: Ԥ�������ύ����
	 * @author: yangrt
	 * @param conn
	 * @param submit_id
	 * @return boolean
	 * @throws DBException 
	 */
	public boolean PreApproveApplySubmit(Connection conn, String[] submit_id) throws DBException {
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgid = userinfo.getCurOrgan().getId();
		//��ȡ������֯��Ϣ
		SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
		String TRANS_FLAG = syzzinfo.getTransFlag();	//Ԥ���Ƿ��룺1=�ǣ�0=��
		
		for (int i = 0; i < submit_id.length; i++) {
			Data applyData = this.getPreApproveApplyData(conn, submit_id[i]);
			applyData.add("REQ_DATE", DateUtility.getCurrentDateTime());	//Ԥ����������
			applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YTJ);									//Ԥ��״̬:���ύ
			
			String af_id = applyData.getString("AF_ID","");
			String file_type = applyData.getString("FILE_TYPE");		//�ļ�����
			
			boolean flag = af_id.equals("");								//�Ƿ���ѡ���ļ�����������flag=true:δѡ���ļ���
			
			Data fileData = new Data();
			if(!flag){
				//�����ļ�id,��ȡ�ļ���Ϣ
				fileData = new FileManagerAction().GetFileByID(af_id);
				fileData.removeData("XMLSTR");
			}
			
			if("21".equals(file_type)){
				
				DataList afList = new DataList();
				Data afData = new Data();
				
	        	fileData.add("FILE_TYPE", applyData.getString("FILE_TYPE"));	//�ļ����ͣ���ת��FILE_TYPE:21��
				String af_position = fileData.getString("AF_POSITION","");		//�ļ��ĵ�ǰλ��
				String match_state = fileData.getString("MATCH_STATE","");		//�ļ���ƥ��״̬
	        	if(af_position.equals(FileGlobalStatusAndPositionConstant.POS_DAB) || match_state.equals("0")){
	        		applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);								//Ԥ��״̬��Ϊ��ƥ�䣨RI_STATE:7��
	        		afData.add("AF_ID", af_id);
	        		afData.add("CI_ID", applyData.getString("CI_ID"));
	        		afData.add("ADOPT_ORG_ID", fileData.getString("ADOPT_ORG_ID",""));
	            	afList.add(afData);
	        	}else{
	        		applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YQD);	//Ԥ��״̬��Ϊ��������RI_STATE:6��
	        	}
		        if(afList.size() > 0){
		        	new SpecialMatchAction().saveMatchInfoForSYZZ(conn, afList);
		        }
    			
			}else{
				if("1".equals(TRANS_FLAG)){
					//��ʼ��Ԥ�������¼
					Data initData = new Data();
					initData.add("RI_ID", submit_id[i]);
					initData.add("TRANSLATION_TYPE", "0");		//�������ͣ�����=0
	    			PublishCommonManager pcm = new PublishCommonManager();
	    			pcm.translationInit(conn, initData);
	    			//���Ԥ����¼�еķ���״̬:������(TRANSLATION_STATE��0)
	    			applyData.add("TRANSLATION_STATE", "0");
				}else{
					//��ʼ�����ò�Ԥ����˼�¼��Ϣ(AUDIT_TYPE:2)
					Data azbdata = new Data();
					azbdata.add("RI_ID", applyData.getString("RI_ID",""));
					azbdata.add("AUDIT_TYPE", "2");
					azbdata.add("OPERATION_STATE", "0");	//������
					azbdata.setConnection(conn);
		            azbdata.setEntityName("SCE_REQ_ADUIT");
		            azbdata.setPrimaryKey("RAU_ID");
		            azbdata.create();
					
					//��ʼ����˲�Ԥ����˼�¼��Ϣ(AUDIT_TYPE:1)
					Data shbdata = new Data();
					shbdata.add("RI_ID", applyData.getString("RI_ID",""));
					shbdata.add("AUDIT_TYPE", "1");
					shbdata.add("AUDIT_LEVEL", "0");		//���������
					shbdata.add("OPERATION_STATE", "0");	//������
					shbdata.setConnection(conn);
					shbdata.setEntityName("SCE_REQ_ADUIT");
					shbdata.setPrimaryKey("RAU_ID");
					shbdata.create();
					
					//��ʼ��Ԥ�������¼�еİ��ò�״̬��AUD_STATE2������˲�״̬��AUD_STATE1��
					applyData.add("AUD_STATE2", "0");
					applyData.add("AUD_STATE1", "0");
				}
			}
			
			applyData.setConnection(conn);
			applyData.setEntityName("SCE_REQ_INFO");
			applyData.setPrimaryKey("RI_ID");
			applyData.store();
			
			//���ѡ���ļ���������������Ҫ���������ļ���Ϣ���е�Ԥ����Ϣ
			if(!flag){
				
				String ci_id = applyData.getString("CI_ID","");
				LockChildHandler lch = new LockChildHandler();
				Data mainData = lch.getMainChildInfo(conn, ci_id);
				DataList dl = new DataList();
				String ciIdstr = ci_id;
				String is_twins = mainData.getString("IS_TWINS","");
				if("1".equals(is_twins)){
					dl = lch.getAttachChildList(conn, ci_id);
					for(int j = 0; j < dl.size(); j++){
						ciIdstr += "," + dl.getData(j).getString("CI_ID");
					}
				}
				
				//���������ļ���Ϣ���е�Ԥ����Ϣ��RI_ID��Ԥ����¼ID��RI_STATE��Ԥ��״̬��
				fileData.add("RI_ID", applyData.getString("RI_ID"));
				fileData.add("RI_STATE", applyData.getString("RI_STATE"));
				
				fileData.add("CI_ID", ciIdstr);
				fileData.setConnection(conn);
				fileData.setEntityName("FFS_AF_INFO");
				fileData.setPrimaryKey("AF_ID");
				fileData.store();
			}
		}
		
		return true;
	}

	/**
	 * @Title: PreApproveApplyDelete 
	 * @Description: Ԥ������ɾ������
	 * @author: yangrt
	 * @param conn
	 * @param uuid
	 * @return boolean
	 * @throws DBException
	 */
	public boolean PreApproveApplyDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for (int i = 0; i < uuid.length; i++) {
			//��ȡԤ��������Ϣ
			String sql = getSql("getPreApproveApplyData", uuid[i]);
			Data applydata = ide.find(sql).getData(0);
			//����Ԥ��������Ϣ����ȡ������ͯ��Ϣid
			String ci_id = applydata.getString("CI_ID");
			Data childdata = ide.find(getSql("getChildDataById",ci_id)).getData(0);
			//���ݶ�ͯ��Ϣ����ȡ�����ͯĩ�η�������
			String pub_lastdate = childdata.getString("PUB_LASTDATE");
			Data pubdata = ide.find(getSql("getPubRecodeData", ci_id, pub_lastdate)).getData(0);
			
			UserInfo userinfo = SessionInfo.getCurUser();
			
			//�޸�Ԥ�������¼���е�Ԥ��״̬����Ϊ��Ч��RI_STATE��9��
			Data applyData = new Data();
			applyData.setConnection(conn);
			applyData.setEntityName("SCE_REQ_INFO");
			applyData.setPrimaryKey("RI_ID");
			applyData.add("RI_ID", uuid[i]);
			applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX);
			applyData.add("PUB_ID", "");										//����״̬�ƿ�
			applyData.add("AF_ID", "");											//�ļ�id
			applyData.add("LOCK_STATE", "1");									//�������
			applyData.add("UNLOCKER_ID", userinfo.getPersonId());				//���������id
			applyData.add("UNLOCKER_NAME", userinfo.getPerson().getEnName());	//�������������
			applyData.add("UNLOCKER_DATE", DateUtility.getCurrentDateTime());	//�����������
			applyData.add("UNLOCKER_TYPE", "1");								//����������ͣ���֯�����UNLOCKER_TYPE��1��
			applyData.add("REVOKE_TYPE", "0");									//Ԥ���������ͣ���֯������REVOKE_TYPE��0��
			ide.store(applyData);
			
			//�޸������ͯ������¼���еķ���״̬����Ϊ�ѷ�����PUB_STATE��2��
			Data pubData = new Data();
			pubData.setConnection(conn);
			pubData.setEntityName("SCE_PUB_RECORD");
			pubData.setPrimaryKey("PUB_ID");
			pubData.add("PUB_ID", pubdata.getString("PUB_ID"));
			pubData.add("PUB_STATE", "2");
			pubData.add("LOCK_DATE", "");
			pubData.add("ADOPT_ORG_ID", "");
			ide.store(pubData);
			
			//�޸Ķ�ͯ������Ϣ���еķ���״̬����Ϊ�ѷ�����PUB_STATE��2��
			Data childData = new Data();
			childData.setConnection(conn);
			childData.setEntityName("CMS_CI_INFO");
			childData.setPrimaryKey("CI_ID");
			childData.add("CI_ID", ci_id);
			childData.add("PUB_STATE", "2");
			ide.store(childData);
			
			/*//����ļ���Ϣ���е�Ԥ����¼id��Ԥ��״̬
			Data fileData = new Data();
			fileData.setConnection(conn);
			fileData.setEntityName("FFS_AF_INFO");
			fileData.setPrimaryKey("AF_ID");
			fileData.add("AF_ID", applydata.getString("AF_ID"));
			fileData.add("RI_ID", "");
			fileData.add("RI_STATE", "");
			//��������ʽΪ1�ģ��ļ������ɡ���ת����Ϊ��������
			if(lock_mode.equals("1")){
				if(applydata.getString("FILE_TYPE").equals("21")){
					fileData.add("FILE_TYPE", "10");
				}
				fileData.add("CI_ID", "");
			}
			ide.store(fileData);*/
		}
		return true;
	}

	/**
	 * @Title: PreApproveApplySave 
	 * @Description: Ԥ��������Ϣ�������
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param TRANS_FLAG
	 * @return boolean    �������� 
	 * @throws DBException
	 */
	public boolean PreApproveApplySave(Connection conn, Map<String, Object> data, String TRANS_FLAG) throws DBException {
		Data ridata = new Data(data);
		
		String af_id = ridata.getString("AF_ID","");
		String ri_state = ridata.getString("RI_STATE","");		//Ԥ��״̬
		String file_type = ridata.getString("FILE_TYPE");		//�ļ�����
		String lock_mode = ridata.getString("LOCK_MODE");		//������ʽ
		String preReqNo = ridata.getString("PRE_REQ_NO");		//֮ǰԤ�����
		
		char mode = lock_mode.toCharArray()[0];
		Data fileData = new Data();
		switch(mode){
			case '1':
				fileData = new FileManagerAction().GetFileByID(af_id);
				fileData.removeData("XMLSTR");
				if(PreApproveConstant.PRE_APPROVAL_YTJ.equals(ri_state)){
					//�ύʱ�������ļ����ļ����͸�Ϊ��ת��FILE_TYPE:21��
					if("21".equals(file_type)){
						fileData.put("FILE_TYPE", ridata.getString("FILE_TYPE"));
						ridata.add("PASS_DATE", DateUtility.getCurrentDateTime());
						ridata.add("SUBMIT_DATE", "2999-12-31");
					}
					//��ʼ��ƥ���¼��Ϣ
			        DataList afList = new DataList();
			        Data afData = new Data();
			        
					String match_state = fileData.getString("MATCH_STATE","");			//�ļ���ƥ��״̬
		        	if("0".equals(match_state)){
		        		ridata.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);	//Ԥ��״̬��Ϊ��ƥ�䣨RI_STATE:7��
		        		afData.add("AF_ID", af_id);
		        		afData.add("CI_ID", ridata.getString("CI_ID"));
		        		afData.add("ADOPT_ORG_ID", fileData.getString("ADOPT_ORG_ID",""));
		            	afList.add(afData);
		            	new SpecialMatchAction().saveMatchInfoForSYZZ(conn, afList);
		        	}else{
		        		ridata.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YQD);	//Ԥ��״̬��Ϊ��������RI_STATE:6��
		        	}
		        
		        	String ci_id = ridata.getString("CI_ID","");
					LockChildHandler lch = new LockChildHandler();
					Data mainData = lch.getMainChildInfo(conn, ci_id);
					DataList dl = new DataList();
					String ciIdstr = ci_id;
					String is_twins = mainData.getString("IS_TWINS","");
					if("1".equals(is_twins)){
						dl = lch.getAttachChildList(conn, ci_id);
						for(int j = 0; j < dl.size(); j++){
							ciIdstr += "," + dl.getData(j).getString("CI_ID");
						}
					}
					
					//���������ļ���Ϣ���е�Ԥ����Ϣ��RI_ID��Ԥ����¼ID��RI_STATE��Ԥ��״̬��
					int cost = new FileCommonManager().getAfCost(conn, "TXWJFWF");
					int childnum = ciIdstr.split(",").length;
					int pre_af_cost = fileData.getInt("AF_COST");
					int new_af_cost = cost * childnum;
					fileData.add("AF_COST", new_af_cost); 
					if(new_af_cost > pre_af_cost){
						fileData.add("AF_COST_CLEAR", "0");			//�ļ������״̬Ϊδ��ѣ�AF_COST_CLEAR��0��
					}
					fileData.add("RI_ID", ridata.getString("RI_ID"));
					fileData.add("RI_STATE", ridata.getString("RI_STATE"));
					fileData.add("CI_ID", ciIdstr);
					fileData.setConnection(conn);
					fileData.setEntityName("FFS_AF_INFO");
					fileData.setPrimaryKey("AF_ID");
					fileData.store();
				}
				break;
			case '2':
				break;
			case '3':
				break;
			case '4':
				break;
			case '5':
				//����֮ǰԤ�������¼�е��ļ�����Ϊ��˫
				Data preRiData = new Data();
				preRiData.add("REQ_NO", preReqNo);		//Ԥ�����
				preRiData.add("PRE_REQ_NO", ridata.getString("REQ_NO"));		//Ԥ�����
				preRiData.add("FILE_TYPE", "23");		//����Ԥ�������е��ļ�����Ϊ��˫��23
				preRiData.setConnection(conn);
				preRiData.setEntityName("SCE_REQ_INFO");
				preRiData.setPrimaryKey("REQ_NO");
				preRiData.store();
				break;
			case '6':
				break;
		}
		
		//��ʼ��Ԥ�������¼
		if(ri_state.equals(PreApproveConstant.PRE_APPROVAL_YTJ)){
			if(!"1".equals(lock_mode)){
				if("1".equals(TRANS_FLAG)){
					//��ʼ��Ԥ�������¼
					Data initData = new Data();
					initData.add("RI_ID", ridata.getString("RI_ID"));
					initData.add("TRANSLATION_TYPE", "0");		//�������ͣ�����=0
	    			PublishCommonManager pcm = new PublishCommonManager();
	    			pcm.translationInit(conn, initData);
	    			//���Ԥ����¼�еķ���״̬:������(TRANSLATION_STATE��0)
	    			ridata.add("TRANSLATION_STATE", "0");
				}else{
					//��ʼ�����ò�Ԥ����˼�¼��Ϣ(AUDIT_TYPE:2)
					Data azbdata = new Data();
					azbdata.add("RI_ID", ridata.getString("RI_ID",""));
					azbdata.add("AUDIT_TYPE", "2");
					azbdata.add("OPERATION_STATE", "0");	//������
					azbdata.setConnection(conn);
		            azbdata.setEntityName("SCE_REQ_ADUIT");
		            azbdata.setPrimaryKey("RAU_ID");
		            azbdata.create();
					
					//��ʼ����˲�Ԥ����˼�¼��Ϣ(AUDIT_TYPE:1)
					Data shbdata = new Data();
					shbdata.add("RI_ID", ridata.getString("RI_ID",""));
					shbdata.add("AUDIT_TYPE", "1");
					shbdata.add("AUDIT_LEVEL", "0");		//���������
					shbdata.add("OPERATION_STATE", "0");	//������
					shbdata.setConnection(conn);
					shbdata.setEntityName("SCE_REQ_ADUIT");
					shbdata.setPrimaryKey("RAU_ID");
					shbdata.create();
					
					//��ʼ��Ԥ�������¼�еİ��ò�״̬��AUD_STATE2������˲�״̬��AUD_STATE1��
					ridata.add("AUD_STATE2", "0");
					ridata.add("AUD_STATE1", "0");
				}
			}
		}

		//����Ԥ�������¼
		ridata.setConnection(conn);
        ridata.setEntityName("SCE_REQ_INFO");
        ridata.setPrimaryKey("RI_ID");
		ridata.store();
		
		//���·�����¼���еķ���״̬Ϊ�����루PUB_STATE:4��
		Data pubData = new Data();
		pubData.add("PUB_ID", ridata.getString("PUB_ID"));
		pubData.add("PUB_STATE", "4");
		pubData.setConnection(conn);
		pubData.setEntityName("SCE_PUB_RECORD");
		pubData.setPrimaryKey("PUB_ID");
		pubData.store();
		
		//���¶�ͯ���ϱ��еķ���״̬Ϊ�����루PUB_STATE:4��
		Data ciData = new Data();
		ciData.add("CI_ID", ridata.getString("CI_ID"));
		ciData.add("PUB_STATE", "4");
		ciData.setConnection(conn);
		ciData.setEntityName("CMS_CI_INFO");
		ciData.setPrimaryKey("CI_ID");
		ciData.store();
    	
		return true;
	}

	/**
	 * @throws DBException  
	 * @Title: getRiIdForReminderNotice 
	 * @Description: ��ȡ��ʼ��Ԥ���߰�֪ͨ�����Ԥ����Ϣ
	 * @author: yangrt
	 * @param conn
	 * @return DataList 
	 */
	public DataList getRiIdForReminderNotice(Connection conn) throws DBException {
		String curDate = DateUtility.getCurrentDateTime();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getRiIdForReminderNotice", curDate);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @throws DBException  
	 * @Title: updateRiDataList 
	 * @Description: ����Ԥ�������¼�Ĵ߰���Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param updateRiList 
	 * @return void 
	 */
	public void updateRiDataList(Connection conn, DataList updateRiList) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for(int i=0;i<updateRiList.size();i++){
			updateRiList.getData(i).setEntityName("SCE_REQ_INFO");
			updateRiList.getData(i).setPrimaryKey("RI_ID");
    	}
    	ide.batchStore(updateRiList);
		
	}

	/**
	 * @throws DBException  
	 * @Title: initReminderNoticeList 
	 * @Description: ��ʼ��Ԥ���߰�֪ͨ
	 * @author: yangrt
	 * @param conn
	 * @param initNoticeList 
	 * @return void
	 */
	public void initReminderNoticeList(Connection conn, DataList initNoticeList) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for(int i=0;i<initNoticeList.size();i++){
			initNoticeList.getData(i).setEntityName("SCE_REQ_REMINDER");
			initNoticeList.getData(i).setPrimaryKey("REM_ID");
    	}
    	ide.batchCreate(initNoticeList);
		
	}

}
