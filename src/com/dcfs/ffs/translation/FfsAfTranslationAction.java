 /**
 * @Title: FfsAfTranslationAction.java
 * @Package com.dcfs.ffs
 * @Description: �ļ����봦���࣬ʵ���ļ�������б��ѯ�����롢�ַ�����ӡ�������ľ��幦��ʵ�֡�
 * @author wangzheng   
 * @project DCFS 
 * @date 2014-7-29 10:02:37
 * @version V1.0   
 */
package com.dcfs.ffs.translation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.Base64Util;
import hx.util.DateUtility;
import hx.util.InfoClueTo;
import hx.util.UtilDateTime;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileGlobalStatusAndPositionConstant;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.excelexport.ExcelExporter;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;
/**
 * @Title: FfsAfTranslationAction.java
 * @Description:�ļ����봦��Action
 * @Created on 2014-7-29 10:02:37
 * @author wangzheng
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class FfsAfTranslationAction extends BaseAction{

	private static Log log = UtilLog.getLog(FfsAfTranslationAction.class);

    private FfsAfTranslationHandler handler;
	
	private Connection conn = null;//���ݿ�����
	
	private DBTransaction dt = null;//������
	
	private String retValue = SUCCESS;
	
	private String AZQ_CODE = "91";	
	private String AZQ_NAME = "��֮��";//��֮������
	
	private String TRANSLATION_STATE_TODO 		 = "0";//0:������
	private String TRANSLATION_STATE_DONING 	 = "1";//1:������
	private String TRANSLATION_STATE_DONE		 = "2";//2:�ѷ���
	
	private String TRANSLATION_TYPE_FTR		=	"0";	//�ļ�����
	private String TRANSLATION_TYPE_FAD		=	"1";	//�ļ����䷭��
	private String TRANSLATION_TYPE_FRE		=	"2";	//�ļ����·���
	
	public FfsAfTranslationAction(){
        this.handler=new FfsAfTranslationHandler();
    } 
    
    public String execute() throws Exception {
        return null;
    }

    /**
     * ���淭����Ϣ�������ļ���Ϣ�ͷ����¼
	 * @author wangzheng
	 * @date 2014-7-29 10:02:37
     * @return
     */
    public String save(){
    	//0.�������
    	String type = "0";//�ļ���������
    	String state = "";//�ļ�����״̬�������ļ����롢�������ط���
    	
    	//��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
    	
    	//1 ���ҳ������ݣ��������ݽ����
    	//1.1��������ļ�������Ϣ
        Data dataFile = getRequestEntityData("P_","AF_ID","MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_CN","MALE_JOB_EN","MALE_HEALTH",
        		"MALE_HEALTH_CONTENT_CN","MALE_HEALTH_CONTENT_EN","MEASUREMENT","MALE_HEIGHT","MALE_WEIGHT","MALE_BMI",
        		"MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_CN","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_CN",
        		"MALE_ILLEGALACT_EN","MALE_RELIGION_CN","MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY"
        		,"FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_CN","FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_CN",
        		"FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT","FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_CN","FEMALE_PUNISHMENT_EN"
        		,"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_CN","FEMALE_ILLEGALACT_EN","FEMALE_RELIGION_CN","FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES",
        		"FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME","GAY_STATEMENT","CURRENCY","TOTAL_ASSET",
        		"TOTAL_DEBT","CHILD_CONDITION_CN","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_CN","ADOPT_REQUEST_EN","FINISH_DATE"
        		,"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","IS_MEDICALRECOVERY","MEDICALRECOVERY_CN","MEDICALRECOVERY_EN","IS_FORMULATE",
        		"ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON","IS_SUBMIT_REPORT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_CN","IS_FAMILY_OTHERS_EN",
        		"ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","ACCEPTED_CARD","PARENTING","SOCIALWORKER","REMARK_CN","REMARK_EN","GOVERN_DATE","VALID_PERIOD"
        		,"APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX","CHILDREN_HEALTH_CN","CHILDREN_HEALTH_EN","PACKAGE_ID","CREATE_USERID","CREATE_DATE",
        		"SUBMIT_USERID","SUBMIT_DATE","ADOPTER_SEX"); 
        
        //1.2��÷����¼��Ϣ
        Data dataTranslation = getRequestEntityData("R_","AT_ID","TRANSLATION_DESC","TRANSLATION_STATE","TRANSLATION_TYPE");
        
        //2 ���ݻ�����ݽ��б�����ʼ��
        type = dataTranslation.getString("TRANSLATION_TYPE");
        state = dataTranslation.getString("TRANSLATION_STATE"); 
        
        //���С�Ů����������ת��Ϊ��д
        if(!("".equals(dataFile.getString("MALE_NAME"))) && dataFile.getString("MALE_NAME")!=null){
        	dataFile.put("MALE_NAME", dataFile.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(dataFile.getString("FEMALE_NAME")))&& dataFile.getString("FEMALE_NAME")!=null){
        	dataFile.put("FEMALE_NAME", dataFile.getString("FEMALE_NAME").toUpperCase());
        }
        
        //�������˵�ַת����д
        if(!("".equals(dataFile.getString("ADDRESS"))) && dataFile.getString("ADDRESS")!=null){
        	dataFile.put("ADDRESS", dataFile.getString("ADDRESS").toUpperCase());
        }
        
        //�罡��״�����ã��򽫽������������Ϊ��
        if("1".equals(dataFile.getString("MALE_HEALTH"))){
        	dataFile.put("MALE_HEALTH_CONTENT_CN", "");
        	dataFile.put("MALE_HEALTH_CONTENT_EN", "");
        }
        if("1".equals(dataFile.getString("FEMALE_HEALTH"))){
        	dataFile.put("FEMALE_HEALTH_CONTENT_CN", "");
        	dataFile.put("FEMALE_HEALTH_CONTENT_EN", "");
        }
        
      //��Υ����Ϊ�����´�����ʶΪ�ޣ���Υ����Ϊ�����´�����Ϊ��
        if("0".equals(dataFile.getString("MALE_PUNISHMENT_FLAG"))){
        	dataFile.put("MALE_PUNISHMENT_CN", "");
        	dataFile.put("MALE_PUNISHMENT_EN", "");
        }
        if("0".equals(dataFile.getString("FEMALE_PUNISHMENT_FLAG"))){
        	dataFile.put("FEMALE_PUNISHMENT_CN", "");
        	dataFile.put("FEMALE_PUNISHMENT_EN", "");
        }
        
        //�����޲����Ⱥñ�ʶΪ�ޣ������޲����Ⱥ�������Ϊ��
        if("0".equals(dataFile.getString("MALE_ILLEGALACT_FLAG"))){
        	dataFile.put("MALE_ILLEGALACT_CN", "");
        	dataFile.put("MALE_ILLEGALACT_EN", "");
        }
        if("0".equals(dataFile.getString("FEMALE_ILLEGALACT_FLAG"))){
        	dataFile.put("FEMALE_ILLEGALACT_CN", "");
        	dataFile.put("FEMALE_ILLEGALACT_EN", "");
        }
        
        dataFile.add("PACKAGE_ID", dataFile.getString("AF_ID"));
        String PACKAGE_ID_CN = "F_" + dataFile.getString("AF_ID");        
        dataFile.add("PACKAGE_ID_CN", PACKAGE_ID_CN);
        //������Ч����ֵ�������Ľ�ֹ����
		String valid_period = dataFile.getString("VALID_PERIOD","");
		if("-1".equals(valid_period)){
			dataFile.add("EXPIRE_DATE", "2999-12-31");
		}else{
			if(!("".equals(valid_period))){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.MONTH, Integer.parseInt(valid_period));
				cal.add(Calendar.DATE, -1);
				dataFile.add("EXPIRE_DATE", sdf.format(cal.getTime()));
			}
		}
		
		if(this.TRANSLATION_TYPE_FTR.equals(type)){	//����
			dataFile.add("TRANSLATION_STATE",state);
			dataFile.add("AF_POSITION", FileGlobalStatusAndPositionConstant.POS_FYGS);
			if(this.TRANSLATION_STATE_DONING.equals(state)){
				dataFile.add("AF_GLOBAL_STATE",FileGlobalStatusAndPositionConstant.STA_WJFYZ);
			}else{
				dataFile.add("AF_GLOBAL_STATE",FileGlobalStatusAndPositionConstant.STA_YFYDYJ);
			}
		}else if(this.TRANSLATION_TYPE_FAD.equals(type)){//���䷭��
			dataFile.add("ATRANSLATION_STATE",state);
		}else {//�ط�
			dataFile.add("RTRANSLATION_STATE",state);
		}
		
		//�����������
		if(this.TRANSLATION_STATE_DONE.equals(state)){
			dataTranslation.add("COMPLETE_DATE", DateUtility.getCurrentDate());
		}else{
			dataTranslation.add("COMPLETE_DATE", "");
		}
		//������ID
		dataTranslation.add("TRANSLATION_USERID", curuser.getPersonId());
		//����������		
		dataTranslation.add("TRANSLATION_USERNAME", curuser.getPerson().getCName());
		//���뵥λID
		String[] array = getTranslationUnit(organ);
		String unit = array[0];
		String unitName = array[1];
		
		dataTranslation.add("TRANSLATION_UNIT",unit);
		//���뵥λ����
		dataTranslation.add("TRANSLATION_UNITNAME",unitName);		
        
		try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            
            success=handler.saveFile(conn,dataFile);
            if(success){
            	success=handler.save(conn,dataTranslation);
            	//����Ƿ�������ύ�ҷ�������Ϊ�ļ����룬�������ƽ���ϸ��¼
            	if("2".equals(dataTranslation.getString("TRANSLATION_STATE"))  && this.TRANSLATION_TYPE_FTR.equals(type)){	
            		DataList dl = new DataList();
            		Data dataTransfer =new Data();
            		dataTransfer.put("APP_ID",dataFile.getString("AF_ID"));
            		dataTransfer.put("TRANSFER_CODE", TransferCode.FILE_FYGS_SHB);
            		dataTransfer.put("TRANSFER_STATE","0");
            		dl.add(dataTransfer);
            		FileCommonManager fm = new FileCommonManager();
            		fm.transferDetailInit(conn, dl);
            	}
            }
            
            //�жϱ�����ύ
            if (success) {
            	String s = "������Ϣ����ɹ�!";
            	if(this.TRANSLATION_STATE_DONE.equals(dataTranslation.get("TRANSLATION_STATE"))){
            		s = "������Ϣ�ύ�ɹ�!";
            		
            		if(this.TRANSLATION_TYPE_FTR.equals(type)){	//����
            			retValue = "submit";
            		}else if(this.TRANSLATION_TYPE_FAD.equals(type)){//���䷭��
            			retValue = "adTranslation";
            		}else {//�ط�
            			retValue = "reTranslation";
            		}
            		
            	}else{
            		retValue = "save";  
            	}
            	
                InfoClueTo clueTo = new InfoClueTo(0, s);//����ɹ� 
                setAttribute("UUID", dataTranslation.getString("AT_ID"));
                setAttribute("clueTo", clueTo);
            }
          //���������з���
    		AttHelper.publishAttsOfPackageId(dataFile.getString("AF_ID"),"AF");    		
    		AttHelper.publishAttsOfPackageId(PACKAGE_ID_CN,"AF");
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
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
                        log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    /**
     * ������Ϣ����
	 * @author wangzheng
	 * @date 2014-8-27
     * @return
     */
    public String adTranslationSave(){
    	//0.�������
    	//��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
    	
    	//1 ���ҳ������ݣ��������ݽ����
		// 1.1��÷����¼��Ϣ
		Data dataTranslation = getRequestEntityData("R_", 
				"AT_ID", 
				"AF_ID",
				"TRANSLATION_DESC", 
				"TRANSLATION_STATE", 
				"TRANSLATION_FILEID");
		
        //2 ���ݻ�����ݽ��б�����ʼ��
        String state = dataTranslation.getString("TRANSLATION_STATE"); 
        
        //
        String TRANSLATION_STATE = this.TRANSLATION_STATE_DONING;
        //�����������
		if("2".equals(state)){
			dataTranslation.add("COMPLETE_DATE", DateUtility.getCurrentDate());
		}else{
			dataTranslation.add("COMPLETE_DATE", "");
		}
		//������ID
		dataTranslation.add("TRANSLATION_USERID", curuser.getPersonId());
		//����������		
		dataTranslation.add("TRANSLATION_USERNAME", curuser.getPerson().getCName());
		try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
           
            success=handler.save(conn,dataTranslation);            	
       
            
            //�жϱ�����ύ
            if (success) {
            	String s = "������Ϣ����ɹ�!";
            	if("2".equals(dataTranslation.get("TRANSLATION_STATE"))){
            		TRANSLATION_STATE = this.TRANSLATION_STATE_DONE;
            		s = "������Ϣ�ύ�ɹ�!";
            		retValue = "submit";            		
            	}else{
            		retValue = "save";  
            	}
            	
            	//�����ļ�������״̬
            	FileCommonManager fileCommonManager = new FileCommonManager();
            	Data fileData = new Data();
            	fileData.put("AF_ID", dataTranslation.getString("AF_ID"));
            	fileData.put("ATRANSLATION_STATE", TRANSLATION_STATE);
            	fileCommonManager.modifyFileInfo(conn,fileData);
            	
                InfoClueTo clueTo = new InfoClueTo(0, s);//����ɹ� 
                setAttribute("UUID", dataTranslation.getString("AT_ID"));
                setAttribute("clueTo", clueTo);
            }
          //���������з���
    		AttHelper.publishAttsOfPackageId(dataTranslation.getString("TRANSLATION_FILEID"),"AF");
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
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
                        log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * �����¼��ѯ
	 * @author wangzheng
	 * @date 2014-7-29 10:02:37
     * @return
     */
    public String findList(){
    	//��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		
       //1 �趨����
    	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		
    	//2 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
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
		Data data = getRequestEntityData("S_",
				"FILE_NO",
				"FILE_TYPE",
				"COUNTRY_CODE",
				"ADOPT_ORG_ID",
				"MALE_NAME",
				"FEMALE_NAME",
				"TRANSLATION_UNITNAME",
				"TRANSLATION_STATE",
				"REGISTER_DATE_START",
				"REGISTER_DATE_END",
				"RECEIVE_DATE_START",
				"RECEIVE_DATE_END",
				"COMPLETE_DATE_START",
				"COMPLETE_DATE_END");
		
		//3.1 �趨�б�Ĭ����������
		String unit[] = getTranslationUnit(organ);	
		if(!this.AZQ_CODE.equals(unit[0])){//������뵥λ���ǰ�֮�ţ���Ϊ���빫˾
			data.put("TRANSLATION_UNIT",unit[0]);
		}
		//3.2������������
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
		    //7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
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
                        log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
					retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * �ط���¼��ѯ
	 * @author wangzheng
	 * @date 2014-8-27
     * @return
     */
    public String reTranslationList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_",
				"FILE_NO","FILE_TYPE","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME",
				"TRANSLATION_UNITNAME","TRANSLATION_STATE","REGISTER_DATE_START","REGISTER_DATE_END",
				"RECEIVE_DATE_START","RECEIVE_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END");
		
		//3.1 �趨�б�Ĭ����������
		//���ݷ��뵥λ��ȡ��Ӧ��¼�б�
		//��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String orgType = String.valueOf(organ.getOrgType());
		//���뵥λID
		String[] array = getTranslationUnit(organ);
		String unit = array[0];
		String unitName = array[1];
		
		if(ChildInfoConstants.ORGAN_TYPE_ZX.equals(orgType)){//��¼��Ϊ�����û�
			unit = null;	
			retValue = "success1";
		}
		data.put("TRANSLATION_UNIT",unit);
				
		//3.2������������
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.reTranslationList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
		    //7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
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
                        log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
					retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * ������¼��ѯ
	 * @author wangzheng
	 * @date 2014-8-27
     * @return
     */
    public String adTranslationList(){
    	// 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_",
				"FILE_NO",
				"FILE_TYPE",
				"COUNTRY_CODE",
				"ADOPT_ORG_ID",
				"ADOPT_ORG_NAME",
				"MALE_NAME",
				"FEMALE_NAME",
				"TRANSLATION_UNITNAME",
				"TRANSLATION_STATE",
				"REGISTER_DATE_START","REGISTER_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END");
		
		//3.1 �趨�б�Ĭ����������
		//���ݷ��뵥λ��ȡ��Ӧ��¼�б�
		//��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String orgType = String.valueOf(organ.getOrgType());
		//���뵥λCode
		//String[] array = getTranslationUnit(organ);
		//String unit = array[0];
		//String unitName = array[1];
		String unit = null;
		System.out.println("orgType:"+orgType);
		if(ChildInfoConstants.ORGAN_TYPE_ZX.equals(orgType)){//��¼��Ϊ�����û�
		//if("90".equals(unit)){//����û��������û������ܲ鿴���м�¼
			unit = null;
			retValue = "success1";
		}else{
			//���뵥λID
			String[] array = getTranslationUnit(organ);
			unit = array[0];
		}
			
		data.add("TRANSLATION_UNIT", unit);
				
		//3.2������������
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.adTranslationList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            setAttribute("COUNTRY_CODE",data.getString("COUNTRY_CODE"));
        } catch (DBException e) {
		    //7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
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
                        log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
					retValue = "error2";
                }
            }
        }
        return retValue;
    }

     /**
     * ������Ϣ�鿴
	 * @author wangzheng
	 * @date 2014-8-20
     * @return retValue
     * ����retValue��ת����ͬ����˫�ס����ס�����Ů��
     */
    public String show(){
     String uuid = getParameter("UUID");
	    try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            setAttribute("data", showdata);
            retValue = getFormType(showdata.getString("FAMILY_TYPE"),showdata.getString("FILE_TYPE"));		
        } catch (DBException e) {
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
        return retValue;
    }
    
    /**
     *��ʾ�ļ�������Ϣ
      * @author wangzheng
	 * @date 2014-9-4
     * @return retValue
     */
    public String showAtt(){
    	
    	return retValue;
    }
    
    /**
     * �ļ�����(���롢�ط�)(�ļ����)
	 * @author wangzheng
	 * @date 2014-7-29 10:02:37
     * @return retValue
     */
    public String translationForAudit(){
		String uuid = getParameter("UUID","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getShowData(conn, uuid);
		       BatchAttManager bm = new BatchAttManager();
		       String type = this.getFormType(showdata.getString("FAMILY_TYPE"),showdata.getString("FILE_TYPE"));
		       DataList attType = new DataList();
		       if("parents".equals(type)){
		    	   attType = bm.getAttType(conn, AttConstants.AF_PARENTS);   
		       }else if("singleparent".equals(type)){
		    	   attType = bm.getAttType(conn, AttConstants.AF_SIGNALPARENT);
		       }else{
		    	   attType = bm.getAttType(conn, AttConstants.AF_STEPCHILD);
		       }
		       String xmlstr = bm.getUploadParameter(attType);
		       
		       setAttribute("data", showdata);
		       
		       //setAttribute("MALE_PHOTO",showdata.getString("MALE_PHOTO"));
		       //setAttribute("FEMALE_PHOTO",showdata.getString("FEMALE_PHOTO"));
		       setAttribute("uploadParameter",xmlstr);
		       
		       retValue = getFormType(showdata.getString("FAMILY_TYPE"),showdata.getString("FILE_TYPE"));		       
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
		   return retValue;		   
    }
    
    
    /**
     * �ļ�����(���롢�ط�)
	 * @author wangzheng
	 * @date 2014-7-29 10:02:37
     * @return retValue
     */
    public String translation(){
		String uuid = getParameter("UUID","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getShowData(conn, uuid);		       
		       String type = this.getFormType(showdata.getString("FAMILY_TYPE"),showdata.getString("FILE_TYPE")); //setAttribute("MALE_PHOTO",showdata.getString("MALE_PHOTO"));
		       //setAttribute("FEMALE_PHOTO",showdata.getString("FEMALE_PHOTO"));
		       String xmlstr = this.getFileUploadParameter(conn,type);
		       setAttribute("uploadParameter",xmlstr);
		       setAttribute("data", showdata);
		       
		       retValue = getFormType(showdata.getString("FAMILY_TYPE"),showdata.getString("FILE_TYPE"));		       
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
		   return retValue;		   
    }
        
    /**
     * �ļ�����
	 * @author wangzheng
	 * @date 2014-8-27
     * @return retValue
     */
    public String adTranslation(){
		String uuid = getParameter("UUID","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getAdTranslationData(conn, uuid);
		       setAttribute("data", showdata);
		       //retValue = getFormType(showdata.getString("FAMILY_TYPE"),showdata.getString("FILE_TYPE"));		       
		   } catch (DBException e) {
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
		   return retValue;		   
    }
    
    /**
     * �ļ�����
	 * @author wangzheng
	 * @date 2014-9-9
     * @return retValue
     */
    public String adTranslationShow(){
		String uuid = getParameter("UUID","");
		if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
		try {
		       conn = ConnectionManager.getConnection();
		       Data showdata = handler.getAdTranslationData(conn, uuid);
		       setAttribute("data", showdata);
		       //retValue = getFormType(showdata.getString("FAMILY_TYPE"),showdata.getString("FILE_TYPE"));		       
		   } catch (DBException e) {
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
		   return retValue;		   
    }
    
    /**
     * �ļ��ַ�
	 * @author wangzheng
	 * @date 2014-7-30 10:02:37
     * @return
     */
    public String dispatch(){
    	//����ַ���ID
    	String strDistribUserId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	
    	//����ַ�������
	 	String strDistribUserName = SessionInfo.getCurUser().getPerson().getCName();
    	//����ַ�����(��ȡ��ǰ����)
		String nowDate = DateUtility.getCurrentDate();
		
    	//���뵥λID
    	String strTranslationUnit = getParameter("TRANSLATION_UNIT");
    	//���뵥λ����
    	String strTranslationUnitName = getParameter("TRANSLATION_UNITNAME");    	
    	//�����¼ID����
    	String dispatchuuid=getParameter("dispatchuuid", "");
    	dispatchuuid=dispatchuuid.substring(1, dispatchuuid.length());
        String[] uuid= dispatchuuid.split("#");
        
    	try {
            conn = ConnectionManager.getConnection();   
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success = handler.dispatch(conn, strDistribUserId,strDistribUserName,nowDate,strTranslationUnit,strTranslationUnitName,uuid);
            
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "�ַ��ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
    	}catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ַ������쳣[�ַ�����]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ַ�ʧ��!");
            setAttribute("clueTo", clueTo);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
       return retValue;
    }
    
    /**
     * ��ȡ���뵥λ
	 * @author wangzheng 
	 * @date 2014-8-18
     * @return
     */
    private String[] getTranslationUnit(Organ o){
    	String[] unit = new String[2];
    	//System.out.println(o.getOrgCode());
    	String code = o.getOrgCode().substring(0, 2);
    	
    	//�����¼���ǰ�֮��
    	if(AZQ_CODE.equals(code)){
    		unit[0] = AZQ_CODE;
    		unit[1] = AZQ_NAME;
    	}else{//���������Ӵ����FYDW���л�ȡ���뵥λ����
    		String[] s = UtilCode.getCodeLists("FYDW").get("FYDW").getName(code);    		
    		unit[0] = code;
    		unit[1] = s[0];    		
    	}
        
        return unit;
        
    }
    /**
     * �����������ͺ��ļ����ͻ��ҵ�������
	 * @author wangzheng 
	 * @date 2014-8-18
     * @return ret ҵ�������
     * parents��˫������
     * singleparent����������
     * stepchild������Ů����
     */
    public String getFormType(String familyType,String fileType){
    	String ret  = "parents";
	       //������������ǵ���
	       if("2".equals(familyType)){
	    	   ret = "singleparent";
	       }
	     //����ļ������Ǽ���Ů����
	       if("33".equals(fileType)){
	    	   ret = "stepchild";
	       }
	       return ret;
    }
    
    /**
     * �����ļ�ҵ������ͻ�������ϴ���������
     * @param type
     * @return
     * @throws Exception
     */
	public String getFileUploadParameter(Connection conn,String type) throws Exception {
		DataList attType = new DataList();
		BatchAttManager bm = new BatchAttManager();
		if ("parents".equals(type)) {
			attType = bm.getAttType(conn, AttConstants.AF_PARENTS);
		} else if ("singleparent".equals(type)) {
			attType = bm.getAttType(conn, AttConstants.AF_SIGNALPARENT);
		} else {
			attType = bm.getAttType(conn, AttConstants.AF_STEPCHILD);
		}
		String xmlstr = bm.getUploadParameter(attType);
		return xmlstr;
	}
    
       /**
     * @Title: exportTranslationInfo 
	 * @Description: ���������¼�б�
	 * @author: wangzheng
	 * @return String    �������� 
	 * @throws
     */
    public void exportTranslationInfo(){
    	String exportTag = "";
    	UserInfo curuser = SessionInfo.getCurUser();
    	Organ organ = curuser.getCurOrgan();
		String TRANSLATION_UNIT = null;
		
    	//1  ��ȡҳ�������ֶ�����
    	// ��ȡ��������		
		Data data = getRequestEntityData("S_","FILE_NO","FILE_TYPE","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","TRANSLATION_UNITNAME","TRANSLATION_STATE","REGISTER_DATE_START","REGISTER_DATE_END","RECEIVE_DATE_START","RECEIVE_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END","TRANSLATION_TYPE");		
		String TRANSLATION_TYPE = data.getString("TRANSLATION_TYPE");
		//������������
		String MALE_NAME = data.getString("MALE_NAME",null);
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		// ��ȡ�����ֶ�
		
		String compositor=(String)getParameter("compositor","");
		if("0".equals(TRANSLATION_TYPE)){//���Ƿ����¼��Ĭ���Խ��������������ǲ������ط���¼��Ĭ����֪ͨ��������
			exportTag = "translation";
			if("".equals(compositor)){
				compositor="RECEIVE_DATE";	
			}						
		}else{
			//���뵥λID
			String[] array = getTranslationUnit(organ);
			String unit = array[0];
			String unitName = array[1];
			TRANSLATION_UNIT = unit;
			exportTag = "translation1";
			if("".equals(compositor)){
				compositor="NOTICE_DATE";
			}
		}
		
		// ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}	
		
    	String FILE_NO = data.getString("FILE_NO",null);
    	String FILE_TYPE = data.getString("FILE_TYPE",null);           	
    	String COUNTRY_CODE = data.getString("COUNTRY_CODE",null);        
    	String ADOPT_ORG_NAME = data.getString("ADOPT_ORG_NAME",null);      
    	String TRANSLATION_UNITNAME = data.getString("TRANSLATION_UNITNAME",null);	
    	String TRANSLATION_STATE =data.getString("TRANSLATION_STATE",null);   
    	String REGISTER_DATE_START	= data.getString("REGISTER_DATE_START ",null);
    	String REGISTER_DATE_END	= data.getString("REGISTER_DATE_END",null);   
    	String RECEIVE_DATE_START = data.getString("RECEIVE_DATE_START",null);  
    	String RECEIVE_DATE_END = data.getString("RECEIVE_DATE_END",null);    
    	String COMPLETE_DATE_START =data.getString("COMPLETE_DATE_START",null); 
    	String COMPLETE_DATE_END = data.getString("COMPLETE_DATE_END",null); 
    	String NOTICE_DATE_START = data.getString("RECEIVE_DATE_START",null);  
    	String NOTICE_DATE_END = data.getString("RECEIVE_DATE_END",null);  
    	
    	try{
    		//2���õ����ļ�����
			this.getResponse().setHeader("Content-Disposition","attachment;filename="+ new String("�����¼.xls".getBytes(), "iso8859-1"));
			this.getResponse().setContentType("application/xls");
			
			//3��������ֶ�
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("WJLX");

    		//�ļ����ʹ���
    		CodeList cl1=codes.get("WJLX");
    		Map<String,String> fileType=new HashMap<String,String>();
    		for(int i=0;i<cl1.size();i++){
    			Code c=cl1.get(i);
    			fileType.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", fileType);
    		
    		//����״̬
    		Map<String,String> state=new HashMap<String,String>();
    		state.put("0", "������");
    		state.put("1", "������");
    		state.put("2", "�ѷ���");
    		dict.put("TRANSLATION_STATE", state);
    		
    		//4 ִ���ļ�����
			ExcelExporter.export2Stream("�����¼", exportTag, dict, this
					.getResponse().getOutputStream(),FILE_NO,FILE_TYPE,COUNTRY_CODE,ADOPT_ORG_NAME,MALE_NAME,FEMALE_NAME,TRANSLATION_UNITNAME,TRANSLATION_STATE,REGISTER_DATE_START,REGISTER_DATE_END,RECEIVE_DATE_START,RECEIVE_DATE_END,COMPLETE_DATE_START,COMPLETE_DATE_END,compositor,ordertype,NOTICE_DATE_START,NOTICE_DATE_END,TRANSLATION_TYPE,TRANSLATION_UNIT);
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  �����쳣����
			log.logError("�����Ǽ��ļ������쳣", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "�����Ǽ��ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
		}        
    }
    
    /*
     * �����ļ��ϴ���������ͥ�ļ�-˫�ף�
     * @return DataList
     */
    public DataList getAFParentsAtt(){
    	
	       DataList dlAttach = new DataList();
	       Data d1 = new Data();
	       d1.put("ATT_MORE", "true");//�Ƿ������ϴ��������
	       d1.put("ATT_FORMAT", "*.*");//������ʽ
	       d1.put("CODE",AttConstants.AF_KGSY);//��������
	       d1.put("CNAME", "�������������");//���������������
	       d1.put("ENAME","Inter-country adoption application");//�������Ӣ������
	       d1.put("ATT_SIZE", "10");//������С���ƣ���λM
	       d1.put("IS_NAILS", "0");//�Ƿ���������ͼ 0����1����
	       dlAttach.add(d1);
	       
	       Data d2 = new Data();
	       d2.put("ATT_MORE", "true");
	       d2.put("ATT_FORMAT", "*.*");
	       d2.put("CODE",AttConstants.AF_CSZM);
	       d2.put("CNAME", "����֤��");
	       d2.put("ENAME","Birth certificate");
	       d2.put("ATT_SIZE", "10");
	       d2.put("IS_NAILS", "0");
	       dlAttach.add(d2);  
	       
	       Data d3 = new Data();
	       d3.put("ATT_MORE", "true");
	       d3.put("ATT_FORMAT", "*.*");
	       d3.put("CODE",AttConstants.AF_HYZK);
	       d3.put("CNAME", "����״��֤��");
	       d3.put("ENAME","Marriage status certificate");
	       d3.put("ATT_SIZE", "10");
	       d3.put("IS_NAILS", "0");
	       dlAttach.add(d3);   
	       
	       Data d4 = new Data();
	       d4.put("ATT_MORE", "true");
	       d4.put("ATT_FORMAT", "*.*");
	       d4.put("CODE",AttConstants.AF_ZJCZM);
	       d4.put("CNAME", "ְҵ����������ͲƲ�״��֤��");
	       d4.put("ENAME","Occupation, income and financial status certificate");
	       d4.put("ATT_SIZE", "10");
	       d4.put("IS_NAILS", "0");
	       dlAttach.add(d4);   
	       
	       Data d5 = new Data();
	       d5.put("ATT_MORE", "true");
	       d5.put("ATT_FORMAT", "*.*");
	       d5.put("CODE",AttConstants.AF_STJK);
	       d5.put("CNAME", "���彡�����֤��");
	       d5.put("ENAME","Medical check-up certificate");
	       d5.put("ATT_SIZE", "10");
	       d5.put("IS_NAILS", "0");
	       dlAttach.add(d5);   
	       
	       Data d6 = new Data();
	       d6.put("ATT_MORE", "true");
	       d6.put("ATT_FORMAT", "*.*");
	       d6.put("CODE",AttConstants.AF_XSCF);
	       d6.put("CNAME", "�����ܹ����´���֤��");
	       d6.put("ENAME","Criminal/Non-criminal records");
	       d6.put("ATT_SIZE", "10");
	       d6.put("IS_NAILS", "0");
	       dlAttach.add(d6);   
	       
	       Data d7 = new Data();
	       d7.put("ATT_MORE", "true");
	       d7.put("ATT_FORMAT", "*.*");
	       d7.put("CODE",AttConstants.AF_JTQK);
	       d7.put("CNAME", "��ͥ���鱨��");
	       d7.put("ENAME","Home study report");
	       d7.put("ATT_SIZE", "10");
	       d7.put("IS_NAILS", "0");
	       dlAttach.add(d7);  
	       
	       Data d8 = new Data();
	       d8.put("ATT_MORE", "true");
	       d8.put("ATT_FORMAT", "*.*");
	       d8.put("CODE",AttConstants.AF_XLDC);
	       d8.put("CNAME", "������������");
	       d8.put("ENAME","Psychological assessment report");
	       d8.put("ATT_SIZE", "10");
	       d8.put("IS_NAILS", "0");
	       dlAttach.add(d8);  
	       
	       Data d9 = new Data();
	       d9.put("ATT_MORE", "true");
	       d9.put("ATT_FORMAT", "*.*");
	       d9.put("CODE",AttConstants.AF_KGSYZM);
	       d9.put("CNAME", "�������������ڹ����ܻ���ͬ������������Ů��֤��");
	       d9.put("ENAME","Approval letter of adoption from the competent authority of receiving country");
	       d9.put("ATT_SIZE", "10");
	       d9.put("IS_NAILS", "0");
	       dlAttach.add(d9);  
	       
	       Data d10 = new Data();
	       d10.put("ATT_MORE", "true");
	       d10.put("ATT_FORMAT", "*.*");
	       d10.put("CODE",AttConstants.AF_TJX);
	       d10.put("CNAME", "�Ƽ���");
	       d10.put("ENAME","Letters of recommendation");
	       d10.put("ATT_SIZE", "10");
	       d10.put("IS_NAILS", "0");
	       dlAttach.add(d10);  
	       
	       Data d11 = new Data();
	       d11.put("ATT_MORE", "true");
	       d11.put("ATT_FORMAT", "*.*");
	       d11.put("CODE",AttConstants.AF_SHZP);
	       d11.put("CNAME", "��ͥ������Ƭ");
	       d11.put("ENAME","Family photos");
	       d11.put("ATT_SIZE", "10");
	       d11.put("IS_NAILS", "1");
	       dlAttach.add(d11);
	       
	       Data d12 = new Data();
	       d12.put("ATT_MORE", "true");
	       d12.put("ATT_FORMAT", "*.*");
	       d12.put("CODE",AttConstants.AF_HZFY);
	       d12.put("CNAME", "���ո�ӡ��");
	       d12.put("ENAME","Passport copy");
	       d12.put("ATT_SIZE", "10");
	       d12.put("IS_NAILS", "0");
	       //dlAttach.add(d12); 
	       
	       return dlAttach;
    }
    
    /*
     * �����ļ��ϴ���������ͥ�ļ�-���ף�
     * @return DataList
     */
    public DataList getAFSingleParentAtt(){
    	
	       DataList dlAttach = new DataList();
	       Data d1 = new Data();
	       d1.put("ATT_MORE", "true");//�Ƿ������ϴ��������
	       d1.put("ATT_FORMAT", "*.*");//������ʽ
	       d1.put("CODE",AttConstants.AF_KGSY);//��������
	       d1.put("CNAME", "�������������");//���������������
	       d1.put("ENAME","Inter-country adoption application");//�������Ӣ������
	       d1.put("ATT_SIZE", "10");//������С���ƣ���λM
	       d1.put("IS_NAILS", "0");//�Ƿ���������ͼ 0����1����
	       dlAttach.add(d1);
	       
	       Data d2 = new Data();
	       d2.put("ATT_MORE", "true");
	       d2.put("ATT_FORMAT", "*.*");
	       d2.put("CODE",AttConstants.AF_CSZM);
	       d2.put("CNAME", "����֤��");
	       d2.put("ENAME","Birth certificate");
	       d2.put("ATT_SIZE", "10");
	       d2.put("IS_NAILS", "0");
	       dlAttach.add(d2);  
	       
	       Data d3 = new Data();
	       d3.put("ATT_MORE", "true");
	       d3.put("ATT_FORMAT", "*.*");
	       d3.put("CODE",AttConstants.AF_HYZK);
	       d3.put("CNAME", "����״��֤����������������ͬ����������");
	       d3.put("ENAME","Marriage status certificate");
	       d3.put("ATT_SIZE", "10");
	       d3.put("IS_NAILS", "0");
	       dlAttach.add(d3);   
	       
	       Data d4 = new Data();
	       d4.put("ATT_MORE", "true");
	       d4.put("ATT_FORMAT", "*.*");
	       d4.put("CODE",AttConstants.AF_ZJCZM);
	       d4.put("CNAME", "ְҵ����������ͲƲ�״��֤��");
	       d4.put("ENAME","Occupation, income and financial status certificate");
	       d4.put("ATT_SIZE", "10");
	       d4.put("IS_NAILS", "0");
	       dlAttach.add(d4);   
	       
	       Data d5 = new Data();
	       d5.put("ATT_MORE", "true");
	       d5.put("ATT_FORMAT", "*.*");
	       d5.put("CODE",AttConstants.AF_STJK);
	       d5.put("CNAME", "���彡�����֤��");
	       d5.put("ENAME","Medical check-up certificate");
	       d5.put("ATT_SIZE", "10");
	       d5.put("IS_NAILS", "0");
	       dlAttach.add(d5);   
	       
	       Data d6 = new Data();
	       d6.put("ATT_MORE", "true");
	       d6.put("ATT_FORMAT", "*.*");
	       d6.put("CODE",AttConstants.AF_XSCF);
	       d6.put("CNAME", "�����ܹ����´���֤��");
	       d6.put("ENAME","Criminal/Non-criminal records");
	       d6.put("ATT_SIZE", "10");
	       d6.put("IS_NAILS", "0");
	       dlAttach.add(d6);   
	       
	       Data d7 = new Data();
	       d7.put("ATT_MORE", "true");
	       d7.put("ATT_FORMAT", "*.*");
	       d7.put("CODE",AttConstants.AF_JTQK);
	       d7.put("CNAME", "��ͥ���鱨��");
	       d7.put("ENAME","Home study report");
	       d7.put("ATT_SIZE", "10");
	       d7.put("IS_NAILS", "0");
	       dlAttach.add(d7);  
	       
	       Data d8 = new Data();
	       d8.put("ATT_MORE", "true");
	       d8.put("ATT_FORMAT", "*.*");
	       d8.put("CODE",AttConstants.AF_XLDC);
	       d8.put("CNAME", "������������");
	       d8.put("ENAME","Psychological assessment report");
	       d8.put("ATT_SIZE", "10");
	       d8.put("IS_NAILS", "0");
	       dlAttach.add(d8);  
	       
	       Data d9 = new Data();
	       d9.put("ATT_MORE", "true");
	       d9.put("ATT_FORMAT", "*.*");
	       d9.put("CODE",AttConstants.AF_KGSYZM);
	       d9.put("CNAME", "�������������ڹ����ܻ���ͬ������������Ů��֤��");
	       d9.put("ENAME","Approval letter of adoption from the competent authority of receiving country");
	       d9.put("ATT_SIZE", "10");
	       d9.put("IS_NAILS", "0");
	       dlAttach.add(d9);  
	       
	       Data d10 = new Data();
	       d10.put("ATT_MORE", "true");
	       d10.put("ATT_FORMAT", "*.*");
	       d10.put("CODE",AttConstants.AF_TJX);
	       d10.put("CNAME", "�Ƽ���");
	       d10.put("ENAME","Letters of recommendation");
	       d10.put("ATT_SIZE", "10");
	       d10.put("IS_NAILS", "0");
	       dlAttach.add(d10);  
	       
	       Data d11 = new Data();
	       d11.put("ATT_MORE", "true");
	       d11.put("ATT_FORMAT", "*.*");
	       d11.put("CODE",AttConstants.AF_SHZP);
	       d11.put("CNAME", "��ͥ������Ƭ");
	       d11.put("ENAME","Family photos");
	       d11.put("ATT_SIZE", "10");
	       d11.put("IS_NAILS", "1");
	       dlAttach.add(d11);
	       
	       Data d12 = new Data();
	       d12.put("ATT_MORE", "true");
	       d12.put("ATT_FORMAT", "*.*");
	       d12.put("CODE",AttConstants.AF_HZFY);
	       d12.put("CNAME", "���ո�ӡ��");
	       d12.put("ENAME","Passport copy");
	       d12.put("ATT_SIZE", "10");
	       d12.put("IS_NAILS", "0");
	       //dlAttach.add(d12); 
	       
	       Data d13 = new Data();
	       d13.put("ATT_MORE", "true");
	       d13.put("ATT_FORMAT", "*.*");
	       d13.put("CODE",AttConstants.AF_JHRSM);
	       d13.put("CNAME", "�໤������");
	       d13.put("ENAME","Guardian Statement");
	       d13.put("ATT_SIZE", "10");
	       d13.put("IS_NAILS", "0");
	       dlAttach.add(d13);
	       return dlAttach;
    }
    /*
     * �����ļ��ϴ���������ͥ�ļ�-����Ů��
     * @return DataList
     */
    public DataList getAFSteChildAtt(){
    	
	       DataList dlAttach = new DataList();
	       Data d1 = new Data();
	       d1.put("ATT_MORE", "true");//�Ƿ������ϴ��������
	       d1.put("ATT_FORMAT", "*.*");//������ʽ
	       d1.put("CODE",AttConstants.AF_KGSY);//��������
	       d1.put("CNAME", "�������������");//���������������
	       d1.put("ENAME","Inter-country adoption application");//�������Ӣ������
	       d1.put("ATT_SIZE", "10");//������С���ƣ���λM
	       d1.put("IS_NAILS", "0");//�Ƿ���������ͼ 0����1����
	       dlAttach.add(d1);
	       
	       Data d2 = new Data();
	       d2.put("ATT_MORE", "true");
	       d2.put("ATT_FORMAT", "*.*");
	       d2.put("CODE",AttConstants.AF_CSZM);
	       d2.put("CNAME", "����֤��");
	       d2.put("ENAME","Birth certificate");
	       d2.put("ATT_SIZE", "10");
	       d2.put("IS_NAILS", "0");
	       dlAttach.add(d2);  
	       
	       Data d3 = new Data();
	       d3.put("ATT_MORE", "true");
	       d3.put("ATT_FORMAT", "*.*");
	       d3.put("CODE",AttConstants.AF_HYZK);
	       d3.put("CNAME", "����״��֤����������������ͬ����������");
	       d3.put("ENAME","Marriage status certificate");
	       d3.put("ATT_SIZE", "10");
	       d3.put("IS_NAILS", "0");
	       dlAttach.add(d3);   	       
	       
	       Data d9 = new Data();
	       d9.put("ATT_MORE", "true");
	       d9.put("ATT_FORMAT", "*.*");
	       d9.put("CODE",AttConstants.AF_KGSYZM);
	       d9.put("CNAME", "�������������ڹ����ܻ���ͬ������������Ů��֤��");
	       d9.put("ENAME","Approval letter of adoption from the competent authority of receiving country");
	       d9.put("ATT_SIZE", "10");
	       d9.put("IS_NAILS", "0");
	       dlAttach.add(d9);  
	       
	       return dlAttach;
    }
    
    /*
     * ��ȡ�ļ��ϴ���������
     * map<smalltype,datalist{}>
     * smalltype:����С�����
     * datalist:�����������
     */
    private Map<String, DataList> getAtt(DataList dl){
    	if(dl==null){
    		return null;
    	}    		
    	Map<String, DataList> mapAtt = new HashMap<String, DataList>();
	    String smalltype = "NAN";
	    DataList ddl = new DataList();
	    int count = 0;
	       
	       for(int i=0;i<dl.size();i++){
	    	   count++;
	    	   Data d = dl.getData(i);
	    	   String s = d.getString("SMALL_TYPE");

	    	   if(!(s.equals(smalltype))){
	    		   if(i!=0){
	    			   mapAtt.put(smalltype, ddl);
	    			   ddl = new DataList();
	    		   }
	    		   smalltype = s;		    		   
	    	   }
	    	   ddl.add(d);
	       }		      
	       mapAtt.put(smalltype, ddl);	
    	return mapAtt;
    }
}