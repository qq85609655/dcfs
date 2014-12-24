/**   
 * @Title: PreApproveAuditAction.java 
 * @Package com.dcfs.sce.preApproveAudit 
 * @Description: Ԥ��������˲���
 * @author yangrt   
 * @date 2014-10-9 ����4:00:21 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveAudit;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.dcfs.sce.preApproveApply.PreApproveApplyHandler;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.util.UtilDate;

/** 
 * @ClassName: PreApproveAuditAction 
 * @Description: Ԥ����˲���
 * @author yangrt
 * @date 2014-10-9 ����4:00:21 
 *  
 */
public class PreApproveAuditAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(PreApproveAuditAction.class);
	private PreApproveAuditHandler handler;
	private Connection conn = null;
	private DBTransaction dt = null;
	private String retValue = SUCCESS;

	/* (�� Javadoc) 
	 * <p>Title: execute</p> 
	 * <p>Description: </p> 
	 * @return
	 * @throws Exception 
	 * @see hx.common.j2ee.BaseAction#execute() 
	 */
	@Override
	public String execute() throws Exception {
		return null;
	}
	
	public PreApproveAuditAction(){
		this.handler = new PreApproveAuditHandler();
	}
	
	/**
	 * @Title: PreApproveAuditListAZB 
	 * @Description: ���ò�Ԥ��������˲�ѯ�б�
	 * @author: yangrt
	 * @return String
	 */
	public String PreApproveAuditListAZB(){
		// 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="REQ_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","ADOPT_ORG_NAME_CN","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_CN","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        		"SPECIAL_FOCUS","REQ_DATE_START","REQ_DATE_END","AUD_STATE2","AUD_STATE1","LAST_STATE2","ATRANSLATION_STATE2","RI_STATE","PASS_DATE_START","PASS_DATE_END");
        //���С�Ů����������ת��Ϊ��д
        String MALE_NAME = data.getString("MALE_NAME","");
        if(!MALE_NAME.equals("")){
        	data.put("MALE_NAME", MALE_NAME.toUpperCase());
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");
        if(!FEMALE_NAME.equals("")){
        	data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
        }
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.PreApproveAuditListAZB(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "���ò�Ԥ��������˲�ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("���ò�Ԥ��������˲�ѯ�����쳣:" + e.getMessage(),e);
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
                        log.logError("PreApproveAuditAction��PreApproveAuditListAZB.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditShow
	 * @Description: Ԥ�����������ӡ��鿴����
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveAuditShow(){
		String ri_id = getParameter("RI_ID","");	//��ȡԤ�������¼id
		String rau_id = getParameter("RAU_ID","");	//��ȡԤ��������˼�¼id
		String type = getParameter("type");			//��ӡ��鿴ʶ���־����ӣ�AZBadd(���ò�)��SHBadd(��˲�)���鿴��show
		String level = getParameter("Level",""); 	//��˲���˼���:0����������ˣ�1������������ˣ�2���ֹ���������
		String flag = getParameter("Flag","");		//��ѯ�б����֮����תҳ���ʾ
		retValue = type;
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data applydata = new PreApproveApplyHandler().getPreApproveApplyData(conn, ri_id);
			if(type.equals("AZBadd") || type.equals("SHBadd")){
				UserInfo userinfo = SessionInfo.getCurUser();
				applydata.add("AUDIT_USERID", userinfo.getPersonId());
				applydata.add("AUDIT_USERNAME", userinfo.getPerson().getCName());
				applydata.add("AUDIT_DATE", DateUtility.getCurrentDateTime());
				
				applydata.add("AUDIT_LEVEL", level);
				
				String pub_id = applydata.getString("PUB_ID","");
				Data pubData = handler.getPubDataById(conn, pub_id);
				applydata.add("PUB_TYPE", pubData.getString("PUB_TYPE",""));	//��ͯ�ķ������ͣ����ڻ�ȡ��������
				applydata.add("PUB_MODE", pubData.getString("PUB_MODE",""));	//��ͯ�ĵ㷢���ͣ����ڻ�ȡ��������
				applydata.add("SPECIAL_FOCUS", getParameter("SPECIAL_FOCUS"));	//��ͯ�Ƿ��ر��ע�����ڻ�ȡ��������
				
				//�Ƿ�Լ��
				String CONVENTION = new FileCommonManager().getISGY(conn, "", applydata.getString("COUNTRY_CODE"));
				applydata.add("IS_CONVENTION_ADOPT", CONVENTION);
				setAttribute("Flag", flag);
			}else{
				applydata.add("FROM_TYPE", type);
				if("SHBshow".equals(type)){
					applydata.add("AUDIT_LEVEL", level);
				}
			}
			
			setAttribute("data", applydata);
			setAttribute("RI_ID", ri_id);
			setAttribute("RAU_ID", rau_id);
			setAttribute("AF_ID", applydata.getString("AF_ID",""));
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ò�Ԥ������������/�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[���ò�Ԥ������������/�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreApproveAuditShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditSave 
	 * @Description: Ԥ�����������Ϣ�������
	 * @author: yangrt
	 * @return String
	 */
	public String PreApproveAuditSave(){
		String type = getParameter("type");						//�жϵ�ǰ��˱����ǰ��ò�������˲��ڲ���
		String oneType = getParameter("R_PUB_TYPE");			//�������ͣ����ڻ�ȡ��������
		String secondType = getParameter("R_SPECIAL_FOCUS");	//�ر��ע�����ڻ�ȡ��������
		String threeType = getParameter("R_PUB_MODE");			//�㷢���ͣ����ڻ�ȡ��������
		String flag = getParameter("Flag","");					//��ѯ�б����֮����תҳ���ʾ
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String userid = userinfo.getPersonId();					//֪ͨ��id
		String username = userinfo.getPerson().getCName();		//֪ͨ������
		String curDate = DateUtility.getCurrentDateTime();		//֪ͨ����
		
		//1 ���ҳ������ݣ��������ݽ����
		//Ԥ�����������ϢData
		Data data = getRequestEntityData("R_","RAU_ID","RI_ID","AUDIT_LEVEL","AUDIT_OPTION","AUDIT_CONTENT_CN","AUDIT_USERID","AUDIT_USERNAME","AUDIT_DATE","OPERATION_STATE","AUDIT_REMARKS");
		//Ԥ�����벹���¼��ϢData
		Data suppledata = getRequestEntityData("P_","IS_MODIFY","NOTICE_CONTENT","ADD_TYPE");
		suppledata.add("RI_ID", data.getString("RI_ID",""));
		suppledata.add("SEND_USERID", userid);	
		suppledata.add("SEND_USERNAME", username);	
		suppledata.add("NOTICE_DATE", curDate);	
		suppledata.add("AA_STATUS", "0");	//��ʼ������״̬Ϊ�����䣨AA_STATUS��0��
		//Ԥ�����벹�䷭���¼��ϢData
		Data suppletranslationdata = getRequestEntityData("T_","AA_CONTENT");
		suppletranslationdata.add("RI_ID", data.getString("RI_ID",""));
		suppletranslationdata.add("TRANSLATION_TYPE", "1"); 		//�������ͣ�����=1
		suppletranslationdata.add("NOTICE_USERID", userid);	
		suppletranslationdata.add("NOTICE_USERNAME", username);	
		suppletranslationdata.add("NOTICE_DATE", curDate);	
		suppletranslationdata.add("TRANSLATION_STATE", "0");		//��ʼ������״̬Ϊ�����루TRANSLATION_STATE��0��
		
		retValue = type + flag;
		
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            //����ǰ����λ���ò���ˣ����ȡ��˲������״̬������ǰ����λ��˲���ˣ����ȡ���ò������״̬��
            Data applydata = new PreApproveApplyHandler().getPreApproveApplyData(conn, data.getString("RI_ID",""));
            Data applyupdate = new Data();
            applyupdate.add("RI_ID", applydata.getString("RI_ID",""));
            applyupdate.add("PUB_ID", applydata.getString("PUB_ID",""));
            applyupdate.add("CI_ID", applydata.getString("CI_ID",""));
            applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHZ);	//Ԥ��״̬Ĭ��ֵΪ�����
            
            //��ǰ��������˽��
        	String audit_option = data.getString("AUDIT_OPTION","");
            if(type.equals("AZB")){
            	applyupdate.add("AUD_STATE2", audit_option);	//���ò������״̬
            	suppledata.add("ADD_TYPE", "2");				//���ò�Ҫ�󲹳䣨ADD_TYPE��2��
            	suppletranslationdata.add("AT_TYPE", "2");		//���ò�Ҫ�󲹷���AT_TYPE��2��
            	//��˲������״̬
            	String shb_state = applydata.getString("AUD_STATE1","");
            	//�����ǰ��������˽��Ϊͨ��������˲������״̬ҲΪͨ���������Ԥ��״̬Ϊͨ����RI_STATE��4��
            	if("2".equals(audit_option)){
            		if("5".equals(shb_state)){
            			/*��ȡ��������begin*/
            			PublishManagerHandler pmHandler = new PublishManagerHandler();
            			Data tempData = new Data();
            			if(oneType.equals("1")){	//�㷢
            				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, threeType).getData(0);
            			}else{
            				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, null).getData(0);
            			}
            			String DEADLINE = tempData.getString("DEADLINE","0");	//�������ޣ����ռ�
            			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            			
            			Calendar cal = Calendar.getInstance();
            			Date submitDate = sdf.parse(curDate);
            			cal.setTime(submitDate);
            			//cal.add(Calendar.MONTH, Integer.parseInt(DEADLINE));
            			cal.add(Calendar.DATE, Integer.parseInt(DEADLINE));
            			/*��ȡ��������end*/
            			
            			applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHTG);	//���ͨ��
            			applyupdate.add("PASS_DATE", curDate);
            			applyupdate.add("SUBMIT_DATE", sdf.format(cal.getTime()));
            		}
            	}else if("3".equals(audit_option)){
            		applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHBTG);	//��˲�ͨ��
            	}else if("4".equals(audit_option)){
            		//��ʼ��Ԥ�������¼�еİ��ò�ĩ�β���״̬Ϊ�����䣨LAST_STATE2��0��
            		applyupdate.add("LAST_STATE2", "0");
            	}else if("6".equals(audit_option)){
            		//��ʼ��Ԥ�������¼�еİ��ò�����״̬Ϊ�������䣨ATRANSLATION_STATE2��0��
            		applyupdate.add("ATRANSLATION_STATE2", "0");
            		applyupdate.add("AUD_STATE2", "1");	
            	}
            	
            	setAttribute("type", "AZB");	//��˲�Ԥ�������ѯҳ�����˲����������б��ʾ
            }else{
            	suppledata.add("ADD_TYPE", "1");				//��˲�Ҫ�󲹳䣨ADD_TYPE��1��
            	suppletranslationdata.add("AT_TYPE", "1");		//��˲�Ҫ�󲹷���AT_TYPE��1��
            	//���ò������״̬
            	String azb_state = applydata.getString("AUD_STATE2","");
            	String level = data.getString("AUDIT_LEVEL","");
            	if("1".equals(audit_option)){					//�����ϱ�
            		applyupdate.add("AUD_STATE1", "2");			//��˲������״̬:2���������δ����
            	}else if("2".equals(audit_option)){				
            		if("0".equals(level)){						//����ͨ��
            			applyupdate.add("AUD_STATE1", "2");		//��˲������״̬:2���������δ����
            		}else{
            			if("2".equals(azb_state)){
            				applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHTG);
                			applyupdate.add("PASS_DATE", curDate);
                			
                			/*��ȡ��������begin*/
                			PublishManagerHandler pmHandler = new PublishManagerHandler();
                			Data tempData = new Data();
                			if(oneType.equals("1")){	//�㷢
                				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, threeType).getData(0);
                			}else{
                				tempData = pmHandler.getAZQXInfo(conn, oneType, secondType, null).getData(0);
                			}
                			String DEADLINE = tempData.getString("DEADLINE","0");	//�������ޣ����ռ�
                			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                			
                			Calendar cal = Calendar.getInstance();
                			Date submitDate = sdf.parse(curDate);
                			cal.setTime(submitDate);
                			//cal.add(Calendar.MONTH, Integer.parseInt(DEADLINE));
                			cal.add(Calendar.DATE, Integer.parseInt(DEADLINE));
                			/*��ȡ��������end*/
                			applyupdate.add("SUBMIT_DATE", sdf.format(cal.getTime()));
                		}
            			applyupdate.add("AUD_STATE1", "5");		//��˲������״̬:5�����ͨ��
            		}
            	}else if("3".equals(audit_option)){				//��˲���˽������ͨ��
            		applyupdate.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_SHBTG);	//Ԥ����Ԥ��״̬����˲�ͨ����RI_STATE��3��
            		applyupdate.add("AUD_STATE1", "4");			//��˲������״̬:4����˲�ͨ��
            	}else if("4".equals(audit_option)){
            		applyupdate.add("LAST_STATE", "0");			//��ʼ��Ԥ�������¼�е���˲�ĩ�β���״̬Ϊ�����䣨LAST_STATE��0��
            		applyupdate.add("AUD_STATE1", "1");			//��˲������״̬:1�������������
            	}else if("7".equals(audit_option)){
            		applyupdate.add("AUD_STATE1", "9");			//��˲������״̬:9���˻ؾ�����
            	}else if("8".equals(audit_option)){
            		applyupdate.add("AUD_STATE1", "3");			//��˲������״̬:3���ֹ����δ����
            	}else if("6".equals(audit_option)){
            		//��ʼ��Ԥ�������¼�еİ��ò�����״̬Ϊ�������䣨ATRANSLATION_STATE2��0��
            		applyupdate.add("ATRANSLATION_STATE", "0");
            		applyupdate.add("AUD_STATE1", "1");	
            	}
            	
            	if("0".equals(level)){
            		level = "one";
            	}else if("1".equals(level)){
            		level = "two";
            	}else{
            		level = "three";
            	}
            	setAttribute("Level", level);
            	setAttribute("type", "SHB");	//��˲�Ԥ�������ѯҳ�����˲����������б��ʾ
            }
    		
            boolean success = handler.PreApproveAuditSave(conn,data,applyupdate,suppledata,suppletranslationdata,type);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "�����ύ�ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�����������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[Ԥ�����������Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�����������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("Ԥ��������˱�������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (ParseException e) {
        	setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�����������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("Ԥ��������˱�������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreApproveAuditSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveSuppleRecordsList 
	 * @Description: Ԥ�����벹���¼
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveSuppleRecordsList(){
		String ri_id = getParameter("RI_ID","");	//��ȡԤ�������¼id
		//String type = getParameter("type");	
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������˼�¼��ϢDataList
			//DataList datalist = handler.PreApproveSuppleRecordsList(conn,ri_id,type);
			DataList datalist = handler.PreApproveSuppleRecordsList(conn,ri_id);
			setAttribute("List", datalist);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡԤ�������¼�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[��ȡԤ�������¼/�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreApproveSuppleRecordsList.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		//retValue = type;
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditRecordsList 
	 * @Description: Ԥ��������˼�¼
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveAuditRecordsList(){
		String ri_id = getParameter("RI_ID","");	//��ȡԤ�������¼id
		//String type = getParameter("type");	
		//retValue = type;
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������˼�¼��ϢDataList
			DataList datalist = handler.PreApproveAuditRecordsList(conn,ri_id);
			setAttribute("List", datalist);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡԤ����˼�¼�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[��ȡԤ����˼�¼/�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreApproveAuditRecordsList.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveCancelApplyAdd 
	 * @Description: Ԥ��������Ӳ���
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveCancelApplyAdd(){
		String ri_id = getParameter("RI_ID","");	//��ȡԤ�������¼id
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ�������¼��ϢData
			Data data = new PreApproveApplyHandler().getPreApproveApplyData(conn, ri_id);
			//��ȡ����ͯ��Ϣ
			Data childdata = new LockChildHandler().getMainChildInfo(conn, data.getString("CI_ID",""));
			//��ȡ����ͯ��Ϣ
			DataList childList = new LockChildHandler().getAttachChildList(conn, data.getString("CI_ID",""));
			
			data.add("PROVINCE_ID", childdata.getString("PROVINCE_ID",""));
			data.add("WELFARE_NAME_CN", childdata.getString("WELFARE_NAME_CN",""));
			data.add("NAME", childdata.getString("NAME",""));
			data.add("SEX", childdata.getString("SEX",""));
			data.add("BIRTHDAY", childdata.getString("BIRTHDAY",""));
			data.add("SPECIAL_FOCUS", childdata.getString("SPECIAL_FOCUS",""));
			
			setAttribute("data", data);
			setAttribute("ChildList", childList);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ��������Ӳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[Ԥ��������Ӳ���]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreApproveCancelApplyAdd.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreApproveCancelApplySave 
	 * @Description: ���ò�Ԥ�������������
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveCancelApplySave(){
		//1 ���ҳ������ݣ��������ݽ����
		//Ԥ��������ϢData
		Data data = getRequestEntityData("R_","RI_ID","PUB_ID","AF_ID","REVOKE_REASON","REVOKE_STATE","REVOKE_TYPE","FILE_TYPE");
		Data cdata = getRequestEntityData("C_","CI_ID","SPECIAL_FOCUS","IS_PUBLISH");
		Data  dfData = getRequestEntityData("P_","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");
        Data  qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");
        
		UserInfo userinfo = SessionInfo.getCurUser();
		String personId = userinfo.getPersonId();
		String personCName = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		data.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX);	//Ԥ��״̬����Ч��RI_STATE��9��
		data.add("REVOKE_REQ_USERID", personId);	//����������id
		data.add("REVOKE_REQ_USERNAME", personCName);	//��������������
		data.add("REVOKE_REQ_DATE", curDate);	//������������
		
		data.add("REVOKE_CFM_USERID", personId);	//��������ȷ����id
		data.add("REVOKE_CFM_USERNAME", personCName);	//��������ȷ��������
		data.add("REVOKE_CFM_DATE", curDate);	//��������ȷ������
		data.add("UNLOCKER_ID", personId);	//���������id
		data.add("UNLOCKER_NAME", personCName);	//�������������
		data.add("UNLOCKER_DATE", curDate);	//�����������
		data.add("UNLOCKER_TYPE", "2");	//����������ͣ����Ľ����UNLOCKER_TYPE��0��
		data.add("LOCK_STATE", "1");	//����״̬(1���ѽ��)
		
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            
            PublishManagerHandler  pmHandler = new PublishManagerHandler();
            
            String ci_id = cdata.getString("CI_ID","");
            String isPublish = cdata.getString("IS_PUBLISH","");	//�Ƿ����������ʾ��1���ǣ�0����
    		String isSpecial = cdata.getString("SPECIAL_FOCUS","");	//�Ƿ��ر��ע��0����1���ǣ�
    		String pubType = dfData.getString("PUB_TYPE","");		//�������ͣ�1���㷢��2��Ⱥ����
    		
    		Data fbData = new Data();								//������¼��Ϣ
    		if(isPublish.equals("1")){								//������·������򴴽���Ϣ�ķ�����¼
    			fbData.add("PUBLISHER_ID",personId);				//������
        		fbData.add("PUBLISHER_NAME",personCName);			//����������
        		fbData.add("PUB_DATE",curDate);						//��������
        		fbData.add("PUB_STATE",PublishManagerConstant.YFB);	//����״̬Ϊ"�ѷ���"
    			fbData.add("CI_ID", ci_id);
    			fbData.add("PUB_TYPE", pubType);
    			
    			if(pubType.equals("1")){									//���ҳ��ѡ����ǵ㷢
    				fbData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));	//�㷢�ķ�����֯
        			fbData.add("PUB_MODE",dfData.getString("PUB_MODE"));
        			fbData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
        			if("1".equals(isSpecial)||"1"==isSpecial){				//�ر��ע
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//��������
            		}else {													//���ر��ע
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//��������
            		}
        		}else{														//���ҳ��ѡ�����Ⱥ��
        			fbData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));	//Ⱥ���ķ�����֯
        			if("1".equals(isSpecial)||"1"==isSpecial){				//�ر��ע
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//��������
            		}else {													//���ر��ע
            			fbData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//��������
            		}
    			}
    			
    			
    			//**********���¶�ͯ���ϱ������Ϣbegin**********
    			cdata.add("PUB_USERID", personId);							//������ID
            	cdata.add("PUB_USERNAME", personCName);						//����������
            	cdata.add("PUB_STATE", PublishManagerConstant.YFB);			//����״̬Ϊ���ѷ�����
            	cdata.add("PUB_TYPE", pubType);								//��������
            	cdata.add("PUB_LASTDATE", curDate);							//ĩ�η�������
            	
            	int num = pmHandler.getFbNum(conn, ci_id);					//��øö�ͯ��������
        		cdata.add("PUB_NUM", num+1);								//��������
        		
            	if("1".equals(pubType)||"1"==pubType){						//���ҳ��ѡ����ǵ㷢
            		cdata.add("PUB_ORGID", dfData.getString("PUB_ORGID"));	//�㷢������֯
            	}else{
            		cdata.add("PUB_ORGID", qfData.getString("PUB_ORGID"));	//Ⱥ��������֯
            	}
            	//**********���¶�ͯ���ϱ������Ϣend**********
    			
    		}else{	//��������·����������ԭ�еķ�����¼
    			fbData.add("PUB_ID", data.getString("PUB_ID",""));
    			fbData.add("PUB_STATE", PublishManagerConstant.YFB);		//����״̬Ϊ���ѷ�����
    			fbData.add("ADOPT_ORG_ID", "");								//���������֯id
    			fbData.add("LOCK_DATE", "");								//�����������
    			
    			cdata.add("PUB_STATE", PublishManagerConstant.YFB);			//����״̬Ϊ���ѷ�����
    		}
    		cdata.remove("IS_PUBLISH");
    		
            boolean success = handler.PreApproveCancelApplySave(conn,data,fbData,cdata);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�����������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[Ԥ�����������Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�����������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("Ԥ��������˱�������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (NumberFormatException e) {
        	setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�����������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("Ԥ��������˱�������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} catch (ParseException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�����������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("Ԥ��������˱�������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreApproveAuditSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditListSHB 
	 * @Description: ��˲�Ԥ����������б�
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveAuditListSHB(){
		//��˼���,one:����,two:����,three:����
		String level = getParameter("Level","");	
		if(level.equals("")){
			level = (String)getAttribute("Level");
		}
		// 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="REQ_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","ADOPT_ORG_NAME_CN","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_CN","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        		"SPECIAL_FOCUS","REQ_DATE_START","REQ_DATE_END","AUD_STATE2","AUD_STATE1","LAST_STATE","ATRANSLATION_STATE","RI_STATE","PASS_DATE_START","PASS_DATE_END");
        //���С�Ů����������ת��Ϊ��д
        String MALE_NAME = data.getString("MALE_NAME","");
        if(!MALE_NAME.equals("")){
        	data.put("MALE_NAME", MALE_NAME.toUpperCase());
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");
        if(!FEMALE_NAME.equals("")){
        	data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
        }
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.PreApproveAuditListSHB(conn,data,level,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "���ò�Ԥ��������˲�ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("���ò�Ԥ��������˲�ѯ�����쳣:" + e.getMessage(),e);
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
                        log.logError("PreApproveAuditAction��PreApproveAuditListAZB.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        retValue = level;
		return retValue;
	}
	
	/**
	 * @Title: PreApproveShow 
	 * @Description: �鿴֮ǰԤ����Ϣ
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveShow(){
		String req_no = getParameter("REQ_NO");
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data applydata = handler.getPreApproveByReqNo(conn, req_no);
			setAttribute("data", applydata);
			setAttribute("RI_ID", applydata.getString("RI_ID",""));
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴֮ǰԤ����Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[�鿴֮ǰԤ����Ϣ]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreApproveShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: PreFileShow 
	 * @Description: �鿴��ǰ�ļ���Ϣ��ת����
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String PreFileShow(){
		String file_no = getParameter("FILE_NO");
		String flag = getParameter("Flag","");
		try {
			conn = ConnectionManager.getConnection();
			//�����ļ����file_no,��ȡ�ļ���ϢData
			Data data = new FileManagerHandler().getSpecialFileData(conn, file_no);
			String af_id = data.getString("AF_ID","");
			if(!"".equals(flag)){
				String family_type = data.getString("FAMILY_TYPE","");
				if("1".equals(family_type)){
					retValue = "double" + flag;
				}else if("2".equals(family_type)){
					retValue = "single" + flag;
				} 
			}
			
			setAttribute("data", data);
			setAttribute("AF_ID", af_id);
			setAttribute("FILE_NO", file_no);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",af_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",af_id));
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴֮ǰ�ļ���Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[�鿴֮ǰԤ����Ϣ]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveAuditAction��PreFileShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
}
