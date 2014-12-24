package com.dcfs.sce.translation;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;

/**
 * 
 * @Title: TranslationAction.java
 * @Description: ����Ԥ���������action
 * @Company: 21softech
 * @Created on 2014-10-09 ����8:19:29 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class TranslationAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(TranslationAction.class);
    private Connection conn = null;
    private TranslationHandler handler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public TranslationAction() {
        this.handler=new TranslationHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /************** Ԥ�����뷭��Begin ***************/
    
    /**
     * 
     * @Title: applyTranslationList
     * @Description: Ԥ�����뷭����Ϣ�б�
     * @author: panfeng
     * @date: 2014-10-09 ����8:19:29 
     * @return
     */
    public String applyTranslationList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="RECEIVE_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME",
        			"PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        			"REQ_DATE_START","REQ_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END","TRANSLATION_STATE");
        //�з���Ů��������������ת����д
        String MALE_NAME = data.getString("MALE_NAME",null);
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.applyTranslationList(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
	 * @Title: preTranslation 
	 * @Description: Ԥ�����뷭�롢�鿴ҳ��
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
    public String preTranslation(){
		String uuid = getParameter("showuuid","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		String type = getParameter("type");
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getShowData(conn, uuid);
		       
		       setAttribute("data", showdata);
		   }  catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
		            }
		        } catch (SQLException e) {
		        	if (log.isError()) {
		                log.logError("Connection������쳣��δ�ܹر�",e);
		            }
		        }
		    }
		}		   
		if ("tran".equals(type)) {
			return "tran";
		} else if ("show".equals(type)) {
			return "show";
		} else {
			return SUCCESS;
		}		   
    }
    
    /**
     * ���淭����Ϣ
	 * @author panfeng
	 * @date 2014-10-09
     * @return
     */
    public String preTranslationSave(){
    	//��ȡ�������ͣ�����/�ύ��
    	String operationType = getParameter("type");
	    //1 ���ҳ������ݣ��������ݽ����
    	//��ȡԤ��������Ϣ
        Data preData = getRequestEntityData("R_","RI_ID","MALE_JOB_CN","MALE_JOB_EN","FEMALE_JOB_CN","FEMALE_JOB_EN",
        			"MALE_HEALTH_CONTENT_CN","MALE_HEALTH_CONTENT_EN","FEMALE_HEALTH_CONTENT_CN","FEMALE_HEALTH_CONTENT_EN",
        			"MALE_PUNISHMENT_CN","MALE_PUNISHMENT_EN","FEMALE_PUNISHMENT_CN","FEMALE_PUNISHMENT_EN",
        			"MALE_ILLEGALACT_CN","MALE_ILLEGALACT_EN","FEMALE_ILLEGALACT_CN","FEMALE_ILLEGALACT_EN",
        			"CHILD_CONDITION_CN","CHILD_CONDITION_EN","ADOPT_REQUEST_CN","ADOPT_REQUEST_EN",
        			"IS_FAMILY_OTHERS_CN","IS_FAMILY_OTHERS_EN","TENDING_CN","TENDING_EN","OPINION_CN","OPINION_EN",
        			"TRANSLATION_STATE");
        //��ȡԤ�����뷭����Ϣ
        Data tranData = getRequestEntityData("P_","AT_ID","TRANSLATION_DESC","TRANSLATION_STATE");
        //��ȡ��ǰ��¼�˵���Ϣ
  		String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
  		String curOrgan = SessionInfo.getCurUser().getCurOrgan().getCName();
        String curId = SessionInfo.getCurUser().getPerson().getPersonId();
		String curPerson = SessionInfo.getCurUser().getPerson().getCName();
		String curDate = DateUtility.getCurrentDate();
  		//�����������
		if("2".equals(tranData.getString("TRANSLATION_STATE",""))){
			tranData.add("COMPLETE_DATE", curDate);
		}else{
			tranData.add("COMPLETE_DATE", "");
		}
		//������ID
		tranData.add("TRANSLATION_USERID", curId);
		//����������		
		tranData.add("TRANSLATION_USERNAME", curPerson);
		//���뵥λID
		tranData.add("TRANSLATION_UNIT",curOrgId);
		//���뵥λ����
		tranData.add("TRANSLATION_UNITNAME",curOrgan);
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //�ύ����ʱ��ʼ��Ԥ����˼�¼
            if("submit".equals(operationType) || operationType=="submit"){
            	PublishCommonManager publishcommonmanager = new PublishCommonManager();
            	publishcommonmanager.approveAuditInit(conn, preData.getString("RI_ID"));
            	preData.add("AUD_STATE1", "0");//��˲����״̬
            	preData.add("AUD_STATE2", "0");//���ò����״̬
            }
			
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            success=handler.preTranslationSave(conn,preData,tranData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "����ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
			retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
			retValue = "error2";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
    
	
	/************** Ԥ�����뷭��End ***************/
	
	/************** Ԥ�����䷭��Begin ***************/
	
	/**
     * 
     * @Title: supplyTranslationList
     * @Description: Ԥ�����䷭����Ϣ�б�
     * @author: panfeng
     * @date: 2014-10-16 ����10:28:12 
     * @return
     */
    public String supplyTranslationList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME",
        			"PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        			"FEEDBACK_DATE_START","FEEDBACK_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END","TRANSLATION_STATE");
        //�з���Ů��������������ת����д
        String MALE_NAME = data.getString("MALE_NAME",null);
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.supplyTranslationList(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
	 * @Title: supplyTranslation 
	 * @Description: Ԥ�����䷭�롢�鿴ҳ��
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
    public String supplyTranslation(){
		String uuid = getParameter("showuuid","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		String type = getParameter("type");
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getSupplyTranData(conn, uuid);
		       
		       setAttribute("data", showdata);
		   }  catch (Exception e) {
			e.printStackTrace();
		}finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
		            }
		        } catch (SQLException e) {
		        	if (log.isError()) {
		                log.logError("Connection������쳣��δ�ܹر�",e);
		            }
		        }
		    }
		}		   
		if ("tran".equals(type)) {
			return "tran";
		} else if ("show".equals(type)) {
			return "show";
		} else {
			return SUCCESS;
		}		   
    }
    
    /**
     * ���淭����Ϣ
	 * @author panfeng
	 * @date 2014-10-16
     * @return
     */
    public String supplyTranslationSave(){
	    //1 ���ҳ������ݣ��������ݽ����
    	//��ȡԤ��������Ϣ
        Data adData = getRequestEntityData("P_","RA_ID","ADD_CONTENT_EN","ADD_CONTENT_CN","UPLOAD_IDS_CN");
        //��ȡԤ�����䷭����Ϣ
        Data tranData = getRequestEntityData("R_","AT_ID","RI_ID","TRANSLATION_DESC","TRANSLATION_STATE","AT_TYPE");
        Data preData = new Data();
        //Ԥ����������
        preData.add("RI_ID", tranData.getString("RI_ID",""));
        //����״̬
        String at_type = tranData.getString("AT_TYPE","");
        if("1".equals(at_type)){
        	preData.add("ATRANSLATION_STATE", tranData.getString("TRANSLATION_STATE",""));//��˲�
        }else if("2".equals(at_type)){
        	preData.add("ATRANSLATION_STATE2", tranData.getString("TRANSLATION_STATE",""));//���ò�
        }
        //��ȡ��ǰ��¼�˵���Ϣ
  		String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
  		String curOrgan = SessionInfo.getCurUser().getCurOrgan().getCName();
        String curId = SessionInfo.getCurUser().getPerson().getPersonId();
		String curPerson = SessionInfo.getCurUser().getPerson().getCName();
		String curDate = DateUtility.getCurrentDate();
  		//�����������
		if("2".equals(tranData.getString("TRANSLATION_STATE",""))){
			tranData.add("COMPLETE_DATE", curDate);
		}else{
			tranData.add("COMPLETE_DATE", "");
		}
		//������ID
		tranData.add("TRANSLATION_USERID", curId);
		//����������		
		tranData.add("TRANSLATION_USERNAME", curPerson);
		//���뵥λID
		tranData.add("TRANSLATION_UNIT",curOrgId);
		//���뵥λ����
		tranData.add("TRANSLATION_UNITNAME",curOrgan);
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            success=handler.supplyTranslationSave(conn,preData,tranData,adData);
            String packageId = adData.getString("UPLOAD_IDS_CN");//����
            AttHelper.publishAttsOfPackageId(packageId, "AF");//��������
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "����ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
			retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
			retValue = "error2";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
    
    /************** Ԥ�����䷭��End ***************/
    
}
