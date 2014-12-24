/**   
 * @Title: LockChildHandler.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: ������ͯ����
 * @author yangrt   
 * @date 2014-9-21 ����11:13:11 
 * @version V1.0   
 */
package com.dcfs.sce.lockChild;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import base.task.util.DateUtil;

import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.hx.framework.authenticate.SessionInfo;

/** 
 * @ClassName: LockChildHandler 
 * @Description: ������ͯ����
 * @author yangrt;
 * @date 2014-9-21 ����11:13:11 
 *  
 */
public class LockChildHandler extends BaseHandler {

	/**
	 * @Title: LockChildList 
	 * @Description: ������ͯ��ѯ�б�
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
	public DataList LockChildList(Connection conn, Data data, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS",null);	//�ر��ע
		String PROVINCE_ID = data.getString("PROVINCE_ID",null);	//ʡ��
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);	//��ͯ����
		String SEX = data.getString("SEX",null);	//��ͯ�Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);	//��ͯ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);	//��ͯ������ֹ����
		String SN_TYPE = data.getString("REQ_DATE_START",null);	//��������
		String DISEASE_EN = data.getString("REQ_DATE_END",null);	//�������
		String PUB_LASTDATE_START = data.getString("REQ_DATE_START",null);	//��ǰ������ʼ����
		String PUB_LASTDATE_END = data.getString("REQ_DATE_END",null);	//��ǰ������ֹ����
		String PUB_TYPE = data.getString("PASS_DATE_START",null);	//��������
		String HAVE_VIDEO = data.getString("PASS_DATE_END",null);	//������Ƶ
		String SETTLE_DATE_START = data.getString("RI_STATE",null);	//����������ʼ����
		String SETTLE_DATE_END = data.getString("SUBMIT_DATE_START",null);	//�������޽�ֹ����
		String LAST_UPDATE_DATE_START = data.getString("SUBMIT_DATE_END",null);	//��������ʼ����
		String LAST_UPDATE_DATE_END = data.getString("REMINDERS_STATE",null);	//�����½�ֹ����
		
		//���ݿ����
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		//��ǰ������֯code
		String organcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode(); 
		String sql = getSql("LockChildList", organcode, SPECIAL_FOCUS, PROVINCE_ID, NAME_PINYIN, SEX, BIRTHDAY_START, BIRTHDAY_END, SN_TYPE, DISEASE_EN, PUB_LASTDATE_START, PUB_LASTDATE_END, PUB_TYPE, HAVE_VIDEO, SETTLE_DATE_START, SETTLE_DATE_END, LAST_UPDATE_DATE_START, LAST_UPDATE_DATE_END, compositor,ordertype);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: getPubData 
	 * @Description: ���ݷ�����¼id,��ȡ������¼��Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param pub_id
	 * @return Data 
	 * @throws DBException
	 */
	public Data getPubData(Connection conn, String pub_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPubData", pub_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: getMainChildInfo 
	 * @Description: ��������ͯ����id,��ȡ����ͯ������Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param ci_id
	 * @return Data
	 * @throws DBException
	 */
	public Data getMainChildInfo(Connection conn, String ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getMainChildInfo", ci_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: getAttachChildList 
	 * @Description: ��������ͯ����id,��ȡ����ͯ������Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param ci_id
	 * @return DataList
	 * @throws DBException
	 */
	public DataList getAttachChildList(Connection conn, String ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getAttachChildList", ci_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @Title: FileInfoSelect 
	 * @Description: ���ݲ�ͬ���������ͣ���ѯ��ͬ�������ļ���Ϣ
	 * @author: yangrt
	 * @param conn
	 * @param lock_type
	 * @return DataList
	 * @throws DBException
	 */
	public DataList FileInfoSelect(Connection conn, Data data, String lock_type, int pageSize,
			int page, String compositor, String ordertype) throws DBException {
		//��ѯ����
		String MALE_NAME = data.getString("MALE_NAME", null);	//�з�
		String FEMALE_NAME = data.getString("FEMALE_NAME", null);	//Ů��
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REG_DATE_START = data.getString("REG_DATE_START", null);	//�Ǽ���ʼ����
		String REG_DATE_END = data.getString("REG_DATE_END", null);	//�Ǽǽ�ֹ����
		
		//������ʽΪE
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);	//������ʼ����
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);	//�����ֹ����
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//Ԥ��ͨ����ʼ����
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);	//Ԥ��ͨ����ֹ����
		
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = null;
		String organcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		if(lock_type.equals("A")){
			sql = getSql("FileInfoSelectA",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("B")){
			sql = getSql("FileInfoSelectB",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("C")){
			sql = getSql("FileInfoSelectC",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("E")){
			sql = getSql("FileInfoSelectE",organcode,MALE_NAME,FEMALE_NAME,REQ_DATE_START,REQ_DATE_END,PASS_DATE_START,PASS_DATE_END,compositor,ordertype);
		}else if(lock_type.equals("F")){
			String curDate = DateUtility.getCurrentDateTime();
			sql = getSql("FileInfoSelectF",organcode,MALE_NAME,FEMALE_NAME,FILE_NO,REG_DATE_START,REG_DATE_END,compositor,ordertype,curDate);
		}
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: InitPreApproveApplySave 
	 * @Description: ��ʼ��Ԥ�������¼
	 * @author: yangrt;
	 * @param conn
	 * @param applydata
	 * @return Boolean 
	 * @throws DBException
	 */
	public Boolean InitPreApproveApplySave(Connection conn, Data applydata) throws DBException {
        applydata.setConnection(conn);
        applydata.setEntityName("SCE_REQ_INFO");
        applydata.setPrimaryKey("RI_ID");
    	applydata.create();
    	
    	if("5".equals(applydata.getString("LOCK_MODE"))){
	    	Data preapplydata = new Data();
	    	preapplydata.add("REQ_NO", applydata.getString("PRE_REQ_NO"));
	    	preapplydata.add("PRE_REQ_NO", applydata.getString("REQ_NO"));
	    	preapplydata.setConnection(conn);
	    	preapplydata.setEntityName("SCE_REQ_INFO");
	    	preapplydata.setPrimaryKey("REQ_NO");
	    	preapplydata.store();
    	}
    	
    	//���������ͯ������Ϣ
    	Data pubdata = new Data();
    	pubdata.add("PUB_ID", applydata.getString("PUB_ID",""));
    	pubdata.add("ADOPT_ORG_ID", applydata.getString("ADOPT_ORG_ID",""));	//������֯code
    	pubdata.add("LOCK_DATE", applydata.getString("LOCK_DATE",""));	//��������
    	pubdata.add("PUB_STATE", PublishManagerConstant.YSD);//����״̬Ϊ����������
    	pubdata.setConnection(conn);
    	pubdata.setEntityName("SCE_PUB_RECORD");
    	pubdata.setPrimaryKey("PUB_ID");
    	pubdata.store();
    	
    	//���ݶ�ͯid����ȡ��ͯ��Ϣ
    	Data childdata = this.getMainChildInfo(conn, applydata.getString("CI_ID",""));
    	childdata.add("PUB_STATE", PublishManagerConstant.YSD);//����״̬Ϊ����������
    	String lock_num = Integer.parseInt(childdata.getString("LOCK_NUM","0")) + 1 + "";
    	childdata.add("LOCK_NUM", lock_num);
    	childdata.setConnection(conn);
    	childdata.setEntityName("CMS_CI_INFO");
    	childdata.setPrimaryKey("CI_ID");
    	childdata.store();
    	
		if(!"".equals(applydata.getString("AF_ID",""))){
			//��ȡ��ǰ������ͯ��Ϣ���ж��Ƿ��Ƕ��̥
			Data childData = new LockChildHandler().getMainChildInfo(conn, applydata.getString("CI_ID"));
			String twins_ids = childData.getString("TWINS_IDS","");	//ͬ��̥id
			//���������ļ���Ϣ���е�Ԥ����Ϣ��RI_ID��Ԥ����¼ID��RI_STATE��Ԥ��״̬��
	    	Data fileData = new Data();
			fileData.add("RI_ID", applydata.getString("RI_ID"));
			fileData.add("RI_STATE", applydata.getString("RI_STATE"));
			if(twins_ids.equals("")){
				fileData.add("CI_ID", applydata.getString("CI_ID"));
			}else{
				fileData.add("CI_ID", applydata.getString("CI_ID") + "," + twins_ids);
			}
			fileData.setConnection(conn);
			fileData.setEntityName("FFS_AF_INFO");
			fileData.setPrimaryKey("AF_ID");
			fileData.store();
		}
    	
		return true;
	}

	/**
	 * @Title: ConsignReturnSave 
	 * @Description: �����˻�ԭ��
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean
	 * @throws DBException
	 */
	public boolean ConsignReturnSave(Connection conn, DataList datalist) throws DBException {
		for(int i = 0; i < datalist.size(); i++){
			Data data = datalist.getData(i);
			data.setConnection(conn);
			data.setEntityName("SCE_PUB_RECORD");
			data.setPrimaryKey("PUB_ID");
			data.store();
		}
		
		return true;
	}

	/**
	 * @Title: getLockRecords 
	 * @Description: ��ȡ��ǰ��֯������֮�������ö�ͯ�ļ�¼
	 * @author: yangrt
	 * @param conn
	 * @param ci_id
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList getLockRecords(Connection conn, String ci_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		//��ȡ��ǰ����
		String nowDate = DateUtil.getCurrentDatetime();	
		//��ȡʮ����ǰ������
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, -7);
		String preDate = sdf.format(cal.getTime());	//ʮ����ǰ������
		
		String orgcode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String sql = getSql("getLockRecords", orgcode, ci_id, preDate, nowDate);
		DataList dl = ide.find(sql);
		return dl;
	}
	
}
