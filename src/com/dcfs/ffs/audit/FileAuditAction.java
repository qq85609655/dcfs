/**   
 * @Title: FileAuditAction.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-14 ����5:09:50 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;


import com.dcfs.common.DcfsConstants;
import com.dcfs.common.PropertiesUtil;
import com.dcfs.common.ModifyHistoryConfig;
import com.dcfs.common.ModifyHistoryHandler;
import com.dcfs.common.StringUtil;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.translation.FfsAfTranslationHandler;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.excelexport.ExcelExporter;
import com.hx.framework.util.UtilDate;
import com.hx.upload.sdk.AttHelper;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
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

/**
 * @ClassName: FileAuditAction
 * @Description: ��ͥ�ļ����
 * @author mayun
 * @date 2014-8-14
 *
 */
public class FileAuditAction extends BaseAction {

	private static Log log=UtilLog.getLog(FileAuditAction.class);
	private Connection conn = null;
	private FileAuditHandler handler;
	private FfsAfTranslationHandler ffsAfTranslationHandler;
	private ModifyHistoryHandler modifyHistoryHandler;
    private DBTransaction dt = null;//������
	private String retValue = SUCCESS;


	public FileAuditAction() {
		this.handler=new FileAuditHandler();
		this.ffsAfTranslationHandler=new FfsAfTranslationHandler();
		this.modifyHistoryHandler=new ModifyHistoryHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}



	/**
	 * ����������б�	
	 * @description 
	 * @author MaYun
	 * @date Aug 7, 2014
	 * @return
	 */
	public String findListForOneLevel(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			//compositor="FILE_NO,AUD_STATE";
			compositor=null;
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			//ordertype="asc";
			ordertype=null;
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","FILE_NO","RECEIVER_DATE_START","RECEIVER_DATE_END","COUNTRY_CODE","FILE_TYPE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","TRANSLATION_QUALITY","AUD_STATE","AA_STATUS","RTRANSLATION_STATE","ATRANSLATION_STATE");
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
			DataList dl=handler.findListForOneLevel(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���������˲�ѯ�����쳣");
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
						log.logError("FileAuditAction��findListForOneLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * ��ת�������������ϸҳ��
	 * @author Mayun
	 * @date 2014-8-12
	 * @return
	 */
	public String toAuditForOneLevel(){
		String flag = getParameter("FLAG");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		String au_id = getParameter("AU_ID","");//��˼�¼����ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		
		
		Connection conn = null;
		Data fileData = new Data();//�ļ�������Ϣ
		Data auditData = new Data();//��˻�����Ϣ
		Data fyData = new Data();//���������Ϣ
		Data bcData = new Data();//�ļ�������Ϣ
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			bcData = handler.getBCFileInfoById(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//�ļ��������
			
			fyData = this.ffsAfTranslationHandler.getFyDataByAFID(conn, af_id);
			
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ������������ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��toAuditForOneLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("fyData", fyData);
		setAttribute("bcData", bcData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		returnData.addData(bcData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * ��ת�������������ϸҳ�棨�鿴ҳ�棩
	 * @author Mayun
	 * @date 2014-8-12
	 * @return
	 */
	public String toAuditForOneLevelView(){
		String flag = getParameter("FLAG");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		String au_id = getParameter("AU_ID","");//��˼�¼����ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		
		
		Connection conn = null;
		Data fileData = new Data();//�ļ�������Ϣ
		Data auditData = new Data();//��˻�����Ϣ
		Data fyData = new Data();//���������Ϣ
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			//auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//�ļ��������
			
			fyData = this.ffsAfTranslationHandler.getFyDataByAFID(conn, af_id);
			
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ������������ϸҳ��鿴�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��toAuditForOneLevelView.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("fyData", fyData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * �������θ����б�	
	 * @description 
	 * @author MaYun
	 * @date 2014-8-27
	 * @return
	 */
	public String findListForTwoLevel(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			//compositor="FILE_NO,AUD_STATE";
			compositor=null;
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			//ordertype="asc";
			ordertype=null;
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","FILE_NO","RECEIVER_DATE_START","RECEIVER_DATE_END","COUNTRY_CODE","FILE_TYPE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","TRANSLATION_QUALITY","AUD_STATE","AA_STATUS","RTRANSLATION_STATE");
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
			DataList dl=handler.findListForTwoLevel(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�������θ��˲�ѯ�����쳣");
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
						log.logError("FileAuditAction��findListForTwoLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * ��ת���������������ϸҳ��
	 * @author Mayun
	 * @date 2014-8-27
	 * @return
	 */
	public String toAuditForTwoLevel(){
		String flag = getParameter("FLAG");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		String au_id = getParameter("AU_ID","");//��˼�¼����ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//�ļ�������Ϣ
		Data auditData = new Data();//�������θ�������Ϣ
		Data jbrData = new Data();//��������˻�����Ϣ
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//�ļ��������
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "0");//��þ��������յ������Ϣ
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��������������ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��toAuditForTwoLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * ��ת���������������ϸҳ��(�鿴ҳ��)
	 * @author Mayun
	 * @date 2014-8-27
	 * @return
	 */
	public String toAuditForTwoLevelView(){
		String flag = getParameter("FLAG");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		String au_id = getParameter("AU_ID","");//��˼�¼����ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//�ļ�������Ϣ
		Data auditData = new Data();//�������θ�������Ϣ
		Data jbrData = new Data();//��������˻�����Ϣ
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			//auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//�ļ��������
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "0");//��þ��������յ������Ϣ
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��������������ϸҳ��鿴�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��toAuditForTwoLevelView.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * �ֹ����������б�	
	 * @description 
	 * @author MaYun
	 * @date 2014-8-29
	 * @return
	 */
	public String findListForThreeLevel(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			//compositor="FILE_NO,AUD_STATE";
			compositor=null;
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			//ordertype="asc";
			ordertype=null;
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","FILE_NO","RECEIVER_DATE_START","RECEIVER_DATE_END","COUNTRY_CODE","FILE_TYPE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","TRANSLATION_QUALITY","AUD_STATE","AA_STATUS","RTRANSLATION_STATE");
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
			DataList dl=handler.findListForThreeLevel(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�������θ��˲�ѯ�����쳣");
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
						log.logError("FileAuditAction��findListForThreeLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * ��ת���ֹ�����������ϸҳ��
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String toAuditForThreeLevel(){
		String flag = getParameter("FLAG");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		String au_id = getParameter("AU_ID","");//��˼�¼����ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//�ļ�������Ϣ
		Data auditData = new Data();//�ֹ���������������Ϣ
		Data jbrData = new Data();//����������˻�����Ϣ
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//�ļ��������
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "1");//��ò����������յ������Ϣ
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��ֹ�����������ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��toAuditForThreeLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * ��ת���ֹ�����������ϸҳ�棨�鿴ҳ�棩
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String toAuditForThreeLevelView(){
		String flag = getParameter("FLAG");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		String au_id = getParameter("AU_ID","");//��˼�¼����ID
		if("".equals(flag)||null==flag){
			flag=(String)getAttribute("FLAG");
		}
		
		if("".equals(af_id)||null==af_id){
			af_id=(String)getAttribute("AF_ID");
		}
		
		if("".equals(au_id)||null==au_id){
			au_id=(String)getAttribute("AU_ID");
		}
		
		Connection conn = null;
		Data fileData = new Data();//�ļ�������Ϣ
		Data auditData = new Data();//�ֹ���������������Ϣ
		Data jbrData = new Data();//����������˻�����Ϣ
		auditData.add("AU_ID", au_id);
		int num=0;
		try {
			conn = ConnectionManager.getConnection();
			fileData = handler.getFileInfoByID(conn, af_id);
			//auditData = handler.getAuditInfoByID(conn, au_id);
			num = handler.getFileBuChongNum(conn, af_id);
			fileData.add("SUPPLY_NUM", num);//�ļ��������
			jbrData = handler.getLastAuditInfoByAfID(conn, af_id, "1");//��ò����������յ������Ϣ
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��ֹ�����������ϸҳ��鿴�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��toAuditForThreeLevelView.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		setAttribute("jbrdata", jbrData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("FLAG", flag);
		return retValue;
	}
	
	/**
	 * �����˼�¼List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findAuditList(){
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		Connection conn = null;
		DataList auditList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			auditList = handler.findAuditList(conn, af_id);
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���˼�¼�б��ѯ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��findAuditList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("List", auditList);
		return retValue;
	}
	
	/**
	 * �ļ������¼List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findBcRecordList(){
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		Connection conn = null;
		DataList list = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			list = handler.findBcRecordList(conn, af_id);
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ������¼�б��ѯ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��findBcRecordList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("bcFileList", list);
		return retValue;
	}
	
	/**
	 * �ļ��޸ļ�¼List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findReviseList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor=null;
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype=" order by UPDATE_DATE desc ,REVISE_USERNAME asc,UPDATE_FIELD asc";
		}
		
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		Connection conn = null;
		PropertiesUtil propertiesUtil = new PropertiesUtil();
		DataList list = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			list = handler.findReviseList(conn, af_id,pageSize,page,compositor,ordertype);
			if(list.size()>0){
	            for(int i=0;i<list.size();i++){
	                Data data=list.getData(i);
	                String colName=data.getString("UPDATE_FIELD");
	                //��ʷ�����޸��ֶ���ʾ��������
	                data.add("UPDATE_FIELD",ModifyHistoryConfig.getShowstring(colName,"filemodifyhistory-config"));
	                
	                //******��ʷ���۴��������ʾbegin******
	                String oldTempValue = data.getString("ORIGINAL_DATA");
	                String newTempValue = data.getString("UPDATE_DATA");
	                String codeName = propertiesUtil.readValue("filemodifyhistorycodename-config.properties",colName);
	                if(!"".equals(codeName)&&null!=codeName){
	                	String oldCodeValue = UtilCode.getCodeName(codeName, oldTempValue);
		                String newCodeValue = UtilCode.getCodeName(codeName, newTempValue);
		                data.add("ORIGINAL_DATA", oldCodeValue);
		                data.add("UPDATE_DATA", newCodeValue);
	                }
	              //******��ʷ���۴��������ʾend******
	                
	            }
		    }

		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��޸ļ�¼�б��ѯ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��findReviseList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("List", list);
		setAttribute("AF_ID", af_id);
		setAttribute("compositor",compositor);
		setAttribute("ordertype",ordertype);
		return retValue;
	}
	
	/**
	 * Ԥ�������Ϣ�Լ�������ͯ������ϢList
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findYpshAndEtInfoList(){
		
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		Connection conn = null;
		DataList etlist = new DataList();//��ͯDataList
		DataList ypshlist = new DataList();//Ԥ�����DataList
		try {
			conn = ConnectionManager.getConnection();
			Data fileInfoData = handler.getFileInfoByID(conn, af_id);
			String ciId = fileInfoData.getString("CI_ID");//��ͯ����ID
			String riId = fileInfoData.getString("RI_ID");//Ԥ����¼ID
			
			ciId = StringUtil.convertSqlString(ciId);
			riId = StringUtil.convertSqlString(riId);
			if(!"".equals(ciId)&&null!=ciId){
				etlist = handler.findETInfoList(conn, ciId);
			}
			if(!"".equals(riId)&&null!=riId){
				ypshlist = handler.findYPSHInfoList(conn, riId);
			}

		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�������Ϣ�Լ�������ͯ������Ϣ");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��findYpshAndEtInfoList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("etList", etlist);
		setAttribute("ypshList", ypshlist);
		setAttribute("AF_ID", af_id);
		return retValue;
	}
	
	/**
	 * �ļ������¼List
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String findTranslationList(){
		String af_id = getParameter("AF_ID","");//�ļ�����ID
		Connection conn = null;
		DataList list = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			list = handler.findTranslationList(conn, af_id);
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ������¼�б��ѯ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			retValue = "error1";
		}finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��findTranslationList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("List", list);
		return retValue;
	}
	
	/**
	 * �����ļ�������Ϣ
	 * @description 
	 * @author MaYun
	 * @date Oct 28, 2014
	 * @return
	 * @throws DBException 
	 */
	public void saveFileInfo(Connection conn) throws DBException{
		
	 	Data newFileData = new Data();//������
	 	
	 	newFileData = getRequestEntityData("FE_","AF_ID","ADOPTER_SEX","MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO",
		"MALE_EDUCATION","MALE_JOB_CN","MALE_JOB_EN","MALE_HEALTH","MALE_HEALTH_CONTENT_CN","MALE_HEALTH_CONTENT_EN","MEASUREMENT","MALE_HEIGHT",
	 	"MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_CN","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_CN","MALE_ILLEGALACT_EN","MALE_RELIGION_CN",
	 	"MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_CN",
	 	"FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_CN","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT","FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_CN","FEMALE_PUNISHMENT_EN",
	 	"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_CN","FEMALE_ILLEGALACT_EN","FEMALE_RELIGION_CN","FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
	 	"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_CN","ADOPT_REQUEST_EN","FINISH_DATE",
	 	"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","IS_MEDICALRECOVERY","MEDICALRECOVERY_CN","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON","IS_SUBMIT_REPORT",
	 	"IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_CN","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","PARENTING","SOCIALWORKER","REMARK_CN","REMARK_EN","GOVERN_DATE","VALID_PERIOD","EXPIRE_DATE",
	 	"APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX","CHILDREN_HEALTH_CN","CHILDREN_HEALTH_EN","PACKAGE_ID","PACKAGE_ID_CN","IS_CONVENTION_ADOPT");
	 	
	 	String af_id = newFileData.getString("AF_ID");//�ļ�����ID
	 	
	 	newFileData = formatFileData(newFileData);
	 	
	 	 //�������˵�ַת����д
        if(!("".equals(newFileData.getString("ADDRESS"))) && newFileData.getString("ADDRESS")!=null){
        	newFileData.put("ADDRESS", newFileData.getString("ADDRESS").toUpperCase());
        }
        
        //���С�Ů����������ת��Ϊ��д
        if(!("".equals(newFileData.getString("MALE_NAME"))) && newFileData.getString("MALE_NAME")!=null){
        	newFileData.put("MALE_NAME", newFileData.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(newFileData.getString("FEMALE_NAME")))&& newFileData.getString("FEMALE_NAME")!=null){
        	newFileData.put("FEMALE_NAME", newFileData.getString("FEMALE_NAME").toUpperCase());
        }
        
      //������Ч����ֵ�������Ľ�ֹ����
		String valid_period = newFileData.getString("VALID_PERIOD","");
		if("-1".equals(valid_period)){
			newFileData.add("EXPIRE_DATE", "2999-12-31");
		}else{
			if(!("".equals(valid_period))){
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Calendar cal = Calendar.getInstance();
				cal.add(Calendar.MONTH, Integer.parseInt(valid_period));
				cal.add(Calendar.DATE, -1);
				newFileData.add("EXPIRE_DATE", sdf.format(cal.getTime()));
			}
		}



	 	//�����ļ�������Ϣ
	 	this.handler.saveFileInfo(conn, newFileData);
	 	//��������
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID"),"AF");  
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID_CN"),"AF");  
		
		
	}
	
	/**
	 * �����ļ�������Ϣ����������ʷ����
	 * @description 
	 * @author MaYun
	 * @date Oct 28, 2014
	 * @return
	 * @throws DBException 
	 */
	public void saveFileInfoAndHistroyInfo(Connection conn) throws DBException{
		
	 	Data newFileData = new Data();//������
	 	Data oldFileData = new Data();//������
	 	
	 	newFileData = getRequestEntityData("FE_","AF_ID","ADOPTER_SEX","MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO",
		"MALE_EDUCATION","MALE_JOB_CN","MALE_JOB_EN","MALE_HEALTH","MALE_HEALTH_CONTENT_CN","MALE_HEALTH_CONTENT_EN","MEASUREMENT","MALE_HEIGHT",
	 	"MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_CN","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_CN","MALE_ILLEGALACT_EN","MALE_RELIGION_CN",
	 	"MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_CN",
	 	"FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_CN","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT","FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_CN","FEMALE_PUNISHMENT_EN",
	 	"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_CN","FEMALE_ILLEGALACT_EN","FEMALE_RELIGION_CN","FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
	 	"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_CN","ADOPT_REQUEST_EN","FINISH_DATE",
	 	"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","IS_MEDICALRECOVERY","MEDICALRECOVERY_CN","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON","IS_SUBMIT_REPORT",
	 	"IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_CN","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","PARENTING","SOCIALWORKER","REMARK_CN","REMARK_EN","GOVERN_DATE","VALID_PERIOD","EXPIRE_DATE",
	 	"APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX","CHILDREN_HEALTH_CN","CHILDREN_HEALTH_EN","PACKAGE_ID","PACKAGE_ID_CN","IS_CONVENTION_ADOPT");
	 	
	 	String af_id = newFileData.getString("AF_ID");//�ļ�����ID
	 	
	 	//*****���ԭʼ���ݣ����������ݽ�����ʷ���۱������begin**********
	 	oldFileData = this.modifyHistoryHandler.getOriginalData(conn, "FFS_AF_INFO", "AF_ID", af_id);
	 	newFileData = formatFileData(newFileData);
	 	this.modifyHistoryHandler.savehistory(conn, oldFileData, newFileData, "FFS_AF_REVISE", "AR_ID", "AF_ID", af_id, "2");
	 	//*****���ԭʼ���ݣ����������ݽ�����ʷ���۱������end************
	 	//�����ļ�������Ϣ
	 	this.handler.saveFileInfo(conn, newFileData);
	 	//��������
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID"),"AF");  
	 	AttHelper.publishAttsOfPackageId(newFileData.getString("PACKAGE_ID_CN"),"AF");  
		
		
	}
	
	/**
	 * ��ʽ���������ͣ����������ֶ���ֵ����ʱ����
	 * @param fileData
	 * @return
	 */
	private Data formatFileData(Data fileData){
		String formatDateField = ",MALE_BIRTHDAY," +//�����˳�������
				"FEMALE_BIRTHDAY," +//�����˳�������
				"MARRY_DATE," +		//�������
				"FINISH_DATE," +		//��ͥ���鱨���������
				"GOVERN_DATE,";		//������׼����
		String dateFormatStr = " 00:00:00";
		
		Set keysSet = fileData.keySet();
	    Iterator iterator = keysSet.iterator();
	    while(iterator.hasNext()) {
	    	 Object key = iterator.next();//key
	    	 String strKey = ","+key.toString()+",";
	    	 if(formatDateField.indexOf(strKey)>-1){
	    		 String newValue = fileData.getString(key);
	    		 if(newValue!=null && newValue.length()==10){
	    			 newValue += dateFormatStr;
	    		 }
	    		 fileData.put(key.toString(), newValue);	    		 
	    	 }
	    	 
	    }
		return fileData;
	}

	
	/**
	 * �ļ���˱���
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String saveForOneLevel(){
		String curDate = DateUtility.getCurrentDateTime();//��õ�ǰ����
		//�ļ���Ϣ
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON");
		//�����Ϣ
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		fileData.add("AUD_STATE", "1");//�����������
		auditData.add("AUDIT_DATE", curDate);
		auditData.add("OPERATION_STATE", "1");//����״̬Ϊ��������
		
		Connection conn = null;
		try {
			
			//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_SB_SAVE);
			
			fileData.addData(globalData);
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�
            //saveFileInfoAndHistroyInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�����������ʷ����
            handler.saveAuditInfo(conn, auditData);
            handler.saveFileInfo(conn, fileData);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//�ύ�ɹ� 0
            setAttribute("clueTo", clueTo);
            
		} catch (DBException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���˱�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���˱�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (Exception e ){
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���˱�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��saveForOneLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("AF_ID", fileData.getString("AF_ID"));
		setAttribute("AU_ID", auditData.getString("AU_ID"));
		if(!"".equals(getParameter("FLAG"))){
			setAttribute("FLAG", getParameter("FLAG"));
		}
		return retValue;
	}
	
	
	/**
	 * �������ļ�����ύ
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String submitForOneLevel(){
		retValue += getParameter("FLAG","");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String curDate = DateUtility.getCurrentDateTime();//��õ�ǰ����
		//�ļ���Ϣ
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON","AA_ID");
		//�����Ϣ
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		//�ļ�������Ϣ
		Data addData = getRequestEntityData("ADD_", "SEND_USERID","NOTICE_CONTENT","IS_MODIFY","IS_ADDATTACH","SEND_USERNAME","NOTICE_DATE");
		//�ļ����䷭����Ϣ
		Data aaData = getRequestEntityData("TRA_", "NOTICE_USERID","TRANSLATION_TYPE","AA_CONTENT","SEND_USERNAME","NOTICE_DATE","NOTICE_FILEID");
		//�ļ��ط���Ϣ
		Data cfData = getRequestEntityData("TRAN_", "NOTICE_USERID","TRANSLATION_TYPE","AA_CONTENT","SEND_USERNAME","NOTICE_DATE");
		
		
		auditData.add("AUDIT_DATE", curDate);//�������
		String auditOption = auditData.getString("AUDIT_OPTION");//��˽��
		
		String afId = fileData.getString("AF_ID");//�����ļ�����
		String aaId = fileData.getString("AA_ID");//�����ļ���¼����
		addData.add("AF_ID", afId);
		FileCommonManager fileCommonManager = new FileCommonManager();
		
		DataList paramDataList = new DataList();
		Data paramData = new Data();
		paramData.add("AF_ID", afId);
    	paramData.add("AUDIT_LEVEL","1");
    	paramDataList.add(paramData);
		
		
		Connection conn = null;
		try {
			
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�
            //saveFileInfoAndHistroyInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�����������ʷ����

            
            if(auditOption.equals(FileAuditConstant.SB)||auditOption==FileAuditConstant.SB||auditOption.equals(FileAuditConstant.TG)||auditOption==FileAuditConstant.TG||auditOption.equals(FileAuditConstant.BTG)||auditOption==FileAuditConstant.BTG){//������Ϊ�ϱ���ͨ������ͨ��
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_SB_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "2");//�������δ�����
            	auditData.add("OPERATION_STATE", "2");//����״̬Ϊ���Ѵ���
            	fileCommonManager.auditInit(conn, paramDataList);//��ʼ���������θ��˼�¼
            }else if(auditOption.equals(FileAuditConstant.BCWJ)||auditOption==FileAuditConstant.BCWJ){//������Ϊ�����ļ�
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_BCWJ_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "1");//�����������
            	fileData.add("SUPPLY_STATE", "0");//�ļ�ĩ�β���״̬Ϊ������
            	auditData.add("OPERATION_STATE", "1");//����״̬Ϊ��������
            	Data bcData = fileCommonManager.suppleInit(conn, addData);// �򲹳��ļ���FFS_AF_ADDITIONAL��ʼ�������¼
            	fileData.add("AA_ID", bcData.getString("AA_ID"));//�ļ�ĩ�β����¼����ID
            }else if(auditOption.equals(FileAuditConstant.BCWJFY)||auditOption==FileAuditConstant.BCWJFY){//������Ϊ�����ļ�����
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_BCFY_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "1");//�����������
            	fileData.add("ATRANSLATION_STATE", "0");//����״̬Ϊ������
            	auditData.add("OPERATION_STATE", "1");//����״̬Ϊ��������
            	//�����¼��FFS_AF_TRANSLATION��ʼ�������¼
            	fileCommonManager.translationInit(afId, aaId,aaData.getString("TRANSLATION_TYPE"), curDate, aaData.getString("AA_CONTENT"),aaData.getString("SEND_USERID"), aaData.getString("SEND_USERNAME"),aaData.getString("NOTICE_FILEID"), conn);
            }else if(auditOption.equals(FileAuditConstant.CXFY)||auditOption==FileAuditConstant.CXFY){//������Ϊ���·���
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJCS_CXFY_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "1");//�����������
            	fileData.add("RTRANSLATION_STATE", "0");//�ط�״̬Ϊ������	
            	auditData.add("OPERATION_STATE", "1");//����״̬Ϊ��������
            	//�����¼��FFS_AF_TRANSLATION��ʼ�������¼
            	fileCommonManager.translationInit(afId, aaId,cfData.getString("TRANSLATION_TYPE"), curDate, cfData.getString("AA_CONTENT"),cfData.getString("SEND_USERID"), cfData.getString("SEND_USERNAME"),"", conn);
            }
            
            handler.saveAuditInfo(conn, auditData);//�������Ϣ���ﱣ�������Ϣ
            handler.saveFileInfo(conn, fileData);//���ļ���Ϣ���ﱣ���ļ���Ϣ
            
            String packageId = aaData.getString("NOTICE_FILEID");//��������ID
            AttHelper.publishAttsOfPackageId(packageId, "AF");//������������
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ύ�ɹ�!");//�ύ�ɹ� 0
            setAttribute("clueTo", clueTo);
            setAttribute("type", "SHB");//Ϊ�˲����ѯ����ύ�󷵻�ҳ������ֵ
            
		} catch (DBException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�������ļ�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�������ļ�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (Exception e ){
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            
			setAttribute(Constants.ERROR_MSG_TITLE, "�������ļ�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��submitForOneLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: NormalFileExport 
	 * @Description: ���������ļ��б�
	 * @author: mayun
	 * @throws
	 */
	public String fileExportForOneLevel(){
		String curDate = DateUtility.getCurrentDate();
		String fileName = "�����ļ��б�_"+curDate+".xls";
		//1  ��ȡҳ�������ֶ�����
		Data data = getRequestEntityData("S_", "FILE_NO", "FILE_TYPE",
				"COUNTRY_CODE", "ADOPT_ORG_ID", "MALE_NAME", 
				"FEMALE_NAME", "TRANSLATION_QUALITY", "AUD_STATE", "AA_STATUS", 
				"RTRANSLATION_STATE", "RECEIVER_DATE_START","RECEIVER_DATE_END");
		String FILE_NO = data.getString("FILE_NO", null); // ���ı��
		String FILE_TYPE = data.getString("FILE_TYPE", null); //�ļ�����
		String COUNTRY_CODE = data.getString("COUNTRY_CODE", null); // ����
		String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null); // ������֯
		String MALE_NAME = data.getString("MALE_NAME", null); // �з�
		if(null != MALE_NAME){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME", null); // Ů��
		if(null != FEMALE_NAME){
			FEMALE_NAME = FEMALE_NAME.toUpperCase();
		}
		String TRANSLATION_QUALITY = data.getString("TRANSLATION_QUALITY", null); // ��������
		String AUD_STATE = data.getString("AUD_STATE", null); // ���״̬
		String AA_STATUS = data.getString("AA_STATUS", null); // ����״̬
		String RTRANSLATION_STATE = data.getString("RTRANSLATION_STATE", null); // �ط�״̬
		String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null); // ��������begin
		String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null); // ��������end

		try {
			//2���õ����ļ�����
			this.getResponse().setHeader(
					"Content-Disposition",
					"attachment;filename="
							+ new String(fileName.getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3��������ֶ� 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("GJSY","WJLX","SYZZ","WJFYZL","SYJBRSH","SYWJBC","SYWJCF");
    		//�ļ����ʹ���
    		CodeList wjlxList=codes.get("WJLX");
    		Map<String,String> wjlxMap=new HashMap<String,String>();
    		for(int i=0;i<wjlxList.size();i++){
    			Code c=wjlxList.get(i);
    			wjlxMap.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", wjlxMap);
    		
    		//���Ҵ���
    		CodeList gjList=codes.get("GJSY");
    		Map<String,String> gjMap=new HashMap<String,String>();
    		for(int i=0;i<gjList.size();i++){
    			Code c=gjList.get(i);
    			gjMap.put(c.getValue(),c.getName());
    		}
    		dict.put("COUNTRY_CODE", gjMap);
    		
    		//������֯����
    		CodeList syzzList=codes.get("SYZZ");
    		Map<String,String> syzzMap=new HashMap<String,String>();
    		for(int i=0;i<syzzList.size();i++){
    			Code c=syzzList.get(i);
    			syzzMap.put(c.getValue(),c.getName());
    		}
    		dict.put("ADOPT_ORG_ID", syzzMap);
    		
    		//�ļ�������������
    		CodeList fyzlList=codes.get("WJFYZL");
    		Map<String,String> fyzlMap=new HashMap<String,String>();
    		for(int i=0;i<fyzlList.size();i++){
    			Code c=fyzlList.get(i);
    			fyzlMap.put(c.getValue(),c.getName());
    		}
    		dict.put("TRANSLATION_QUALITY", fyzlMap);
    		
    		//���״̬����
    		CodeList shztList=codes.get("SYJBRSH");
    		Map<String,String> shztMap=new HashMap<String,String>();
    		for(int i=0;i<shztList.size();i++){
    			Code c=shztList.get(i);
    			shztMap.put(c.getValue(),c.getName());
    		}
    		dict.put("AUD_STATE", shztMap);
    		
    		//����״̬����
    		CodeList bcztList=codes.get("SYWJBC");
    		Map<String,String> bcztMap=new HashMap<String,String>();
    		for(int i=0;i<bcztList.size();i++){
    			Code c=bcztList.get(i);
    			bcztMap.put(c.getValue(),c.getName());
    		}
    		dict.put("AA_STATUS", bcztMap);
    		
    		//�ط�״̬����
    		CodeList cfztList=codes.get("SYWJBC");
    		Map<String,String> cfztMap=new HashMap<String,String>();
    		for(int i=0;i<cfztList.size();i++){
    			Code c=cfztList.get(i);
    			cfztMap.put(c.getValue(),c.getName());
    		}
    		dict.put("RTRANSLATION_STATE", cfztMap);
    		
    		//4 ִ���ļ�����
			ExcelExporter.export2Stream("�����ļ��б�", "fileForOneLevel", dict, this
					.getResponse().getOutputStream(),FILE_NO,RECEIVER_DATE_START,RECEIVER_DATE_END,COUNTRY_CODE,ADOPT_ORG_ID,MALE_NAME,FEMALE_NAME,FILE_TYPE,TRANSLATION_QUALITY,AUD_STATE,AA_STATUS,RTRANSLATION_STATE);
			
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  �����쳣����
			log.logError("���������ļ��б�����쳣", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "���������ļ��б�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 ҳ�治������ת������NULL ������ת����������ֵ
		return null;
	}
	
	/**
	 * �ļ����˱���
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String saveForTwoLevel(){
		String curDate = DateUtility.getCurrentDateTime();//��õ�ǰ����
		//�ļ���Ϣ
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","RETURN_REASON");
		//�����Ϣ
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);
		auditData.add("OPERATION_STATE", "1");//����״̬Ϊ��������
		
		Connection conn = null;
		try {
			//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_TG_SAVE);
			fileData.addData(globalData);
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�
            //saveFileInfoAndHistroyInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�����������ʷ����
            handler.saveAuditInfo(conn, auditData);
            handler.saveFileInfo(conn, fileData);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//�ύ�ɹ� 0
            setAttribute("clueTo", clueTo);
            
		} catch (DBException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ����˱����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���˱�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch(Exception e){
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���˱�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��saveForTwoLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("AF_ID", fileData.getString("AF_ID"));
		setAttribute("AU_ID", auditData.getString("AU_ID"));
		if(!"".equals(getParameter("FLAG"))){
			setAttribute("FLAG", getParameter("FLAG"));
		}
		return retValue;
	}
	
	
	/**
	 * �������θ����ύ
	 * @author Mayun
	 * @date 2014-8-14
	 * @return
	 */
	public String submitForTwoLevel(){
		retValue += getParameter("FLAG","");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDateTime();//��õ�ǰ����
		//�ļ���Ϣ
		Data fileData = getRequestEntityData("P_","RI_ID","AF_ID","FILE_NO","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON","RETURN_REASON");
		//�����Ϣ
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);//�������
		String auditOption = auditData.getString("AUDIT_OPTION");//��˽��
		
		String afId = fileData.getString("AF_ID");//�����ļ�����
		String fileNo = fileData.getString("FILE_NO");//�������
		String riId = fileData.getString("RI_ID");//Ԥ��ID
		FileCommonManager fileCommonManager = new FileCommonManager();
		PublishCommonManager publishCommonManager = new PublishCommonManager();
		
		
		
		Connection conn = null;
		try {
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�
            //saveFileInfoAndHistroyInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�����������ʷ����

			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();

    		
            auditData.add("OPERATION_STATE", "2");//����״̬Ϊ���Ѵ���
            if(auditOption.equals(FileAuditConstant.TG)||auditOption==FileAuditConstant.TG){//ͨ��
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_TG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "5");//�������ͨ��
            	
            	/*******��ʼ���ƽ���¼begin**********/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//��ʼ���ļ��ƽ���¼
            	/*******��ʼ���ƽ���¼ends**********/
            }else if(auditOption.equals(FileAuditConstant.BTG)||auditOption==FileAuditConstant.BTG){//��ͨ��
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_BTG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "4");//������˲�ͨ��
            	fileData.add("RETURN_STATE", "1");//����״̬Ϊ��ȷ��

				/*************����Ԥ��begin********************/
				if(!"".equals(riId)&&null!=riId){
					publishCommonManager.RemoveByRIID(conn,riId);
				}
				/*************����Ԥ��end********************/
            	
            	/*************��ʼ�����ļ�¼��Ϣbegin************/
        		Data retData = getRequestEntityData("RET_","HANDLE_TYPE");//������Ϣ
        		Data fileDataForTable = fileCommonManager.getCommonFileInfo(fileNo,conn);//�Ӻ�̨��ȡ�ļ�������Ϣ
        		retData.add("RETURN_REASON", fileData.getString("RETURN_REASON"));//����ԭ��
        		retData.add("AF_ID", fileData.getString("AF_ID"));//�����ļ�ID
        		retData.add("ORG_ID", deptId);//����ȷ�ϲ���ID
        		retData.add("PERSON_ID", personId);//����ȷ����ID
        		retData.add("PERSON_NAME", personName);//����ȷ��������
        		retData.add("RETREAT_DATE", curDate);//����ȷ������
        		retData.add("APPLE_TYPE", "2");//��������
        		retData.add("RETURN_STATE", "1");//����״̬
        		retData.add("ADOPT_ORG_ID", fileDataForTable.getString("ADOPT_ORG_ID"));//��������ϢData���װ������֯ID
        		retData.add("COUNTRY_CODE", fileDataForTable.getString("COUNTRY_CODE"));//��������ϢData���װ������֯ID
        		retData.add("REGISTER_DATE", fileDataForTable.getString("REGISTER_DATE"));//��������ϢData���װ������֯ID
        		retData.add("FILE_NO", fileDataForTable.getString("FILE_NO"));//��������ϢData���װ������֯ID
        		retData.add("FILE_TYPE", fileDataForTable.getString("FILE_TYPE"));//��������ϢData���װ������֯ID
        		retData.add("FAMILY_TYPE", fileDataForTable.getString("FAMILY_TYPE"));//��������ϢData���װ������֯ID
        		retData.add("MALE_NAME", fileDataForTable.getString("MALE_NAME"));//��������ϢData���װ������֯ID
        		retData.add("FEMALE_NAME", fileDataForTable.getString("FEMALE_NAME"));//��������ϢData���װ������֯ID
            	fileCommonManager.revocationInit(conn, retData);//��ʼ�����ļ�¼��Ϣ
            	/*************��ʼ�����ļ�¼��Ϣend************/
            	
            	/*************��ʼ�������ƽ���¼��Ϣbegin************/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//��ʼ�������ƽ���¼
            	/*************��ʼ�������ƽ���¼��Ϣend************/
            }else if(auditOption.equals(FileAuditConstant.THJBR)||auditOption==FileAuditConstant.THJBR){//�˻ؾ�����
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_THJBR_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "9");//�˻�����
            	
            	/************��ʼ��������������¼begin********/
            	DataList paramDataList = new DataList();
        		Data paramData = new Data();
        		paramData.add("AF_ID", afId);
            	paramData.add("AUDIT_LEVEL","0");
            	paramDataList.add(paramData);
            	fileCommonManager.auditInit(conn, paramDataList);//��ʼ��������������¼
            	/************��ʼ��������������¼end********/
            }else if(auditOption.equals(FileAuditConstant.SBFGZR)||auditOption==FileAuditConstant.SBFGZR){//�ϱ��ֹ�����
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJFH_SBFGZR_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "3");//�ֹ����δ����
            	
            	/************��ʼ���ֹ�����������¼begin********/
            	DataList paramDataList = new DataList();
        		Data paramData = new Data();
        		paramData.add("AF_ID", afId);
            	paramData.add("AUDIT_LEVEL","2");
            	paramDataList.add(paramData);
            	fileCommonManager.auditInit(conn, paramDataList);//��ʼ���ֹ�����������¼
            	/************��ʼ���ֹ�����������¼end********/
            }
            
            handler.saveAuditInfo(conn, auditData);//�������Ϣ���ﱣ�������Ϣ
            handler.saveFileInfo(conn, fileData);//���ļ���Ϣ���ﱣ���ļ���Ϣ
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ύ�ɹ�!");//�ύ�ɹ� 0
            setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�������θ����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�������θ����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}catch(Exception e){
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�������θ����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��submitForTwoLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	
	/**
	 * �ļ���������
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String saveForThreeLevel(){
		String curDate = DateUtility.getCurrentDateTime();//��õ�ǰ����
		//�ļ���Ϣ
		Data fileData = getRequestEntityData("P_","AF_ID","ACCEPTED_CARD","RETURN_REASON");
		//�����Ϣ
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);
		auditData.add("OPERATION_STATE", "1");//����״̬Ϊ��������
		
		Connection conn = null;
		try {
			//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
			Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_TG_SAVE);
			fileData.addData(globalData);
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�
           // saveFileInfoAndHistroyInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�����������ʷ����
            handler.saveAuditInfo(conn, auditData);
            handler.saveFileInfo(conn, fileData);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//�ύ�ɹ� 0
            setAttribute("clueTo", clueTo);
            
		} catch (DBException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ����������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�����������ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}catch(Exception e){
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�����������ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��saveForThreeLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		setAttribute("filedata", fileData);
		setAttribute("auditdata", auditData);
		Data returnData = new Data();
		returnData.addData(fileData);
		returnData.addData(auditData);
		setAttribute("returnData", returnData);
		setAttribute("AF_ID", fileData.getString("AF_ID"));
		setAttribute("AU_ID", auditData.getString("AU_ID"));
		if(!"".equals(getParameter("FLAG"))){
			setAttribute("FLAG", getParameter("FLAG"));
		}
		return retValue;
	}
	
	
	/**
	 * �ֹ����������ύ
	 * @author Mayun
	 * @date 2014-8-29
	 * @return
	 */
	public String submitForThreeLevel(){
		retValue += getParameter("FLAG","");	//�ж��Ƿ��ǲ�����ѯ���ط���ѯ�е����
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDateTime();//��õ�ǰ����
		//�ļ���Ϣ
		Data fileData = getRequestEntityData("P_","RI_ID","AF_ID","FILE_NO","ACCEPTED_CARD","TRANSLATION_COMPANY","TRANSLATION_QUALITY","UNQUALITIED_REASON","RETURN_REASON");
		//�����Ϣ
		Data auditData = getRequestEntityData("AUD_","AU_ID","AUDIT_OPTION","AUDIT_USERNAME","AUDIT_USERID","AUDIT_CONTENT_CN","AUDIT_REMARKS");
		
		
		auditData.add("AUDIT_DATE", curDate);//�������
		String auditOption = auditData.getString("AUDIT_OPTION");//��˽��
		
		String afId = fileData.getString("AF_ID");//�����ļ�����
		String fileNo = fileData.getString("FILE_NO");//�������
		FileCommonManager fileCommonManager = new FileCommonManager();
		String riId = fileData.getString("RI_ID");//Ԥ��ID
		PublishCommonManager publishCommonManager = new PublishCommonManager();
		
		
		
		Connection conn = null;
		try {
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            saveFileInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�
            //saveFileInfoAndHistroyInfo(conn);//�����ļ�������Ϣ�����ġ����ģ�����������ʷ����

			FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();

            
            auditData.add("OPERATION_STATE", "2");//����״̬Ϊ���Ѵ���
            if(auditOption.equals(FileAuditConstant.TG)||auditOption==FileAuditConstant.TG){//ͨ��
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_TG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "5");//���ͨ��
            	
            	/*******��ʼ���ƽ���¼begin**********/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//��ʼ���ļ��ƽ���¼
            	/*******��ʼ���ƽ���¼ends**********/
            }else if(auditOption.equals(FileAuditConstant.BTG)||auditOption==FileAuditConstant.BTG){//��ͨ��
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_BTG_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "4");//��˲�ͨ��
            	fileData.add("RETURN_STATE", "1");//����״̬Ϊ��ȷ��

				/*************����Ԥ��begin********************/
				if(!"".equals(riId)&&null!=riId){
					publishCommonManager.RemoveByRIID(conn,riId);
				}
				/*************����Ԥ��end********************/
            	
            	/*************��ʼ�����ļ�¼��Ϣbegin************/
        		Data retData = getRequestEntityData("RET_","HANDLE_TYPE");//������Ϣ
        		Data fileDataForTable = fileCommonManager.getCommonFileInfo(fileNo,conn);//�Ӻ�̨��ȡ�ļ�������Ϣ
        		retData.add("RETURN_REASON", fileData.getString("RETURN_REASON"));//����ԭ��
        		retData.add("AF_ID", fileData.getString("AF_ID"));//�����ļ�ID
        		retData.add("ORG_ID", deptId);//����ȷ�ϲ���ID
        		retData.add("PERSON_ID", personId);//����ȷ����ID
        		retData.add("PERSON_NAME", personName);//����ȷ��������
        		retData.add("RETREAT_DATE", curDate);//����ȷ������
        		retData.add("APPLE_TYPE", "2");//��������
        		retData.add("RETURN_STATE", "1");//����״̬
        		retData.add("ADOPT_ORG_ID", fileDataForTable.getString("ADOPT_ORG_ID"));//��������ϢData���װ������֯ID
        		retData.add("COUNTRY_CODE", fileDataForTable.getString("COUNTRY_CODE"));//��������ϢData���װ������֯ID
        		retData.add("REGISTER_DATE", fileDataForTable.getString("REGISTER_DATE"));//��������ϢData���װ������֯ID
        		retData.add("FILE_NO", fileDataForTable.getString("FILE_NO"));//��������ϢData���װ������֯ID
        		retData.add("FILE_TYPE", fileDataForTable.getString("FILE_TYPE"));//��������ϢData���װ������֯ID
        		retData.add("FAMILY_TYPE", fileDataForTable.getString("FAMILY_TYPE"));//��������ϢData���װ������֯ID
        		retData.add("MALE_NAME", fileDataForTable.getString("MALE_NAME"));//��������ϢData���װ������֯ID
        		retData.add("FEMALE_NAME", fileDataForTable.getString("FEMALE_NAME"));//��������ϢData���װ������֯ID
            	fileCommonManager.revocationInit(conn, retData);//��ʼ�����ļ�¼��Ϣ
            	/*************��ʼ�����ļ�¼��Ϣend************/
            	
            	/*************��ʼ�������ƽ���¼��Ϣbegin************/
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", afId);
            	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_SHB_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//��ʼ�������ƽ���¼
            	/*************��ʼ�������ƽ���¼��Ϣend************/
            }else if(auditOption.equals(FileAuditConstant.THJBR)||auditOption==FileAuditConstant.THJBR){//�˻ؾ�����
            	//���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
            	Data globalData = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.SHB_WJSP_THJBR_SUBMIT);
            	fileData.addData(globalData);
            	fileData.add("AUD_STATE", "9");//�˻�����
            	
            	/************��ʼ��������������¼begin********/
            	DataList paramDataList = new DataList();
        		Data paramData = new Data();
        		paramData.add("AF_ID", afId);
            	paramData.add("AUDIT_LEVEL","0");
            	paramDataList.add(paramData);
            	fileCommonManager.auditInit(conn, paramDataList);//��ʼ��������������¼
            	/************��ʼ��������������¼end********/
            }
            
            handler.saveAuditInfo(conn, auditData);//�������Ϣ���ﱣ�������Ϣ
            handler.saveFileInfo(conn, fileData);//���ļ���Ϣ���ﱣ���ļ���Ϣ
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�����ύ�ɹ�!");//�ύ�ɹ� 0
            setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch(Exception e){
			// �����쳣����
			try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");//����ʧ�� 2
	        setAttribute("clueTo", clueTo);
			retValue = "error1";
		}finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileAuditAction��submitForThreeLevel.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

}
