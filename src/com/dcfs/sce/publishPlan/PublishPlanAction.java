package com.dcfs.sce.publishPlan;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Vector;

import java_cup.internal_error;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.StringUtil;
import com.dcfs.sce.common.PublishCommonManager;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hp.hpl.sparta.xpath.ThisNodeTest;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;
import com.lowagie.text.List;

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
 * @ClassName: PublishPlanAction 
 * @Description: �����ƻ�Action
 * @author mayun
 * @date 2014-9-12
 *  
 */
public class PublishPlanAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(PublishPlanAction.class);
	private Connection conn = null;
	private PublishPlanHandler handler;
	private PublishManagerHandler managerHandler;
    private DBTransaction dt = null;//������
	private String retValue = SUCCESS;
	    

	public PublishPlanAction() {
		this.handler=new PublishPlanHandler();
		this.managerHandler=new PublishManagerHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}
	
	
	
	/**
	 * �����ƻ���ѯ�б�	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-12
	 * @return
	 */
	public String findListForFBJH(){
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
			ordertype=null;
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������

		Data data = getRequestEntityData("S_","PLAN_NO","NOTE_DATE_START","NOTE_DATE_END","PUB_DATE_START","PUB_DATE_END","PLAN_USERNAME","PLAN_DATE_START","PLAN_DATE_END","NOTICE_STATE","PLAN_STATE");
		String PLAN_USERNAME = data.getString("PLAN_USERNAME");
		if(null != PLAN_USERNAME){
			data.add("PLAN_USERNAME", PLAN_USERNAME.toLowerCase());
		}
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.findListForFBJH(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ƻ���ѯ�����쳣");
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
						log.logError("PublishPlanAction��findListForFBJH.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * ��ת�������ƻ�������Ϣҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toPlanBaseInfoAdd(){
		Data hxData = new Data();//���˻��Ե�data
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		hxData.add("PLAN_USERNAME", personName);
		hxData.add("PLAN_DATE", curDate);
		setAttribute("data", hxData);
		return retValue;
	}
	
	/**
	 * ��ת���޸ļƻ�������Ϣҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toPlanBaseInfoRevise(){
		Data hxData = new Data();//���˻��Ե�data
		Data hiddenData = getRequestEntityData("H_","PLAN_ID");//��������data
		String plan_id = hiddenData.getString("PLAN_ID");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���޸ļƻ�������Ϣҳ������쳣");
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
						log.logError("PublishPlanAction��toPlanBaseInfoRevise.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", hxData);
		return retValue;
	}
	
	/**
	 * ��ת���ƻ��ƶ���ϸҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toPlanInfoAdd(){
		Data hxData = new Data();//���˻��Ե�data
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	DataList list = new DataList();
	 	hxData.add("PUB_TYPE", "");
	 	hxData.add("PUB_MODE", "");
	 	hxData.add("COUNTRY_CODE", "");
	 	hxData.add("PUB_ORGID", "");
	 	hxData.add("ADOPT_ORG_NAME", "");
	 	hxData.add("TMP_TMP_PUB_ORGID_NAME", "");
	 	hxData.add("PUB_REMARKS", "");
		hxData.add("PLAN_USERNAME", personName);
		hxData.add("PLAN_DATE", curDate);
		setAttribute("data", hxData);
		setAttribute("List", list);
		return retValue;
	}
	
	/**
	 * ��תѡ�񷢲�����	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toFBLXChose(){
		Data hiddenData = getRequestEntityData("H_","CIIDS","PLAN_ID");//��������data
		setAttribute("data", hiddenData);
		return retValue;
	}
	
	/**
	 * ɾ���ƶ��л�������ķ����ƻ�
	 * @description 
	 * @author MaYun
	 * @date Oct 10, 2014
	 * @return
	 */
	public String deletePlan(){
		Data hiddenData = getRequestEntityData("H_","PLAN_ID");//��������data
	 	String plan_id = hiddenData.getString("PLAN_ID");//�����ƻ�����ID
		
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			this.handler.deletePlan(conn, plan_id);//ɾ�������ƻ�
			
			DataList fbjlDataList = this.handler.getFBJLListForPlan(conn, plan_id);//������¼List
			this.handler.deleteFBJL(conn, fbjlDataList);//ɾ��������¼
			
			DataList etDataList = new DataList();//��ͯ����List
			for(int i = 0;i<fbjlDataList.size();i++){
				Data fbjlData = fbjlDataList.getData(i);
				Data etData = new Data();
				etData.add("CI_ID", fbjlData.getString("CI_ID"));
				etData.add("PUB_STATE", "0");//��ͯ����״̬��Ϊ������
				etDataList.add(etData);
			}
			this.handler.updateFBStateForETCL(conn, etDataList);//�������¶�ͯ���ϵķ���״̬Ϊ������
			dt.commit();
			
			InfoClueTo clueTo = new InfoClueTo(0, "�ƻ�ɾ���ɹ�!");//����ɹ� 0
	        setAttribute("clueTo", clueTo);
			
		} catch (DBException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, " ɾ���ƶ��л�������ķ����ƻ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		}catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, " ɾ���ƶ��л�������ķ����ƻ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, " ɾ���ƶ��л�������ķ����ƻ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}  finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("PublishPlanAction��deletePlan.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		
		return retValue;
	}
	
	/**
	 * ѡ����Ӷ�ͯ	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String addET(){
		Data hxData = new Data();//���˻��Ե�data
		String tmp_tmp_pub_orgid_name = (String)getParameter("TMP_TMP_PUB_ORGID_NAME");
		Data hiddenData = getRequestEntityData("H_","TOTAL_CIIDS","ADD_CIIDS","REMOVE_CIIDS");//��������data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//�����ƻ�data
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//�㷢data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//Ⱥ��data

		String pub_type = dfData.getString("PUB_TYPE");
		String totalCiids=hiddenData.getString("TOTAL_CIIDS");//��ȡ�ܵĶ�ͯ����IDS
		String addCiids=hiddenData.getString("ADD_CIIDS");//��ȡ����ѡ��Ķ�ͯ����IDS
		totalCiids= StringUtil.convertSqlString(totalCiids);
		addCiids= StringUtil.convertSqlString(addCiids);
		
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	DataList totalETList = new DataList();
	 	int pub_num=0;//�ܶ�ͯ����
	 	int pub_num_tb=0;//�ر��ע��ͯ����
	 	int pub_num_ftb=0;//���ر��ע��ͯ����
	 	
	 	try {
	 		//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//this.handler.updatePubStateForET(conn, addCiids, "1");//��ͯ����״̬����Ϊ���ƻ��С�
			
			//5 ��ȡ����DataList
			if(!"".equals(totalCiids)&&null!=totalCiids){
				totalETList = this.handler.findSelectedET(conn, totalCiids);
			}
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע  0����  1����
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
	 		pub_num=totalETList.size();
	 		
	 		//6 �������д��ҳ����ձ���
	 		hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			hxData.add("PLAN_USERNAME", personName);
			hxData.add("PLAN_DATE", curDate);
			hxData.addData(hiddenData);
			hxData.addData(jhData);
			if("1".equals(pub_type)||"1"==pub_type){//�㷢����
				hxData.addData(dfData);
			}else{//Ⱥ������
				hxData.addData(dfData);
				hxData.addData(qfData);
				hxData.add("TMP_TMP_PUB_ORGID_NAME", tmp_tmp_pub_orgid_name);
			}
		 	
			setAttribute("data", hxData);
			setAttribute("List", totalETList);
			dt.commit();
		} catch (DBException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
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
						log.logError("PublishPlanAction��toPlanInfoAdd.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	
	/**
	 * ѡ���Ƴ���ͯ	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 * @throws SQLException 
	 */
	public String removeET() throws SQLException{
		Data hxData = new Data();//���˻��Ե�data
		String tmp_tmp_pub_orgid_name = (String)getParameter("TMP_TMP_PUB_ORGID_NAME");
		Data hiddenData = getRequestEntityData("H_","TOTAL_CIIDS","ADD_CIIDS","REMOVE_CIIDS");//��������data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//�����ƻ�data
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//�㷢data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//Ⱥ��data

		String pub_type = dfData.getString("PUB_TYPE");
		String totalCiids=hiddenData.getString("TOTAL_CIIDS");//��ȡ�ܵĶ�ͯ����IDS
		String remove_ciids=hiddenData.getString("REMOVE_CIIDS");//��ȡ����ѡ��Ķ�ͯ����IDS
		String newTotalCiids = StringUtil.filterSameString(totalCiids, remove_ciids);
		String totalCiidsForSql= StringUtil.convertSqlString(newTotalCiids);
		String remove_ciidsForSql= StringUtil.convertSqlString(remove_ciids);
		
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	DataList totalETList = new DataList();
		int pub_num=0;//�ܶ�ͯ����
	 	int pub_num_tb=0;//�ر��ע��ͯ����
	 	int pub_num_ftb=0;//���ر��ע��ͯ����
	 	try {
	 		//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			
			this.handler.updatePubStateForET(conn, remove_ciidsForSql, "0");//��ͯ����״̬����Ϊ����������
			
			//5 ��ȡ����DataList
			if(!"".equals(totalCiidsForSql)&&null!=totalCiidsForSql){
				totalETList = this.handler.findSelectedET(conn, totalCiidsForSql);
			}
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע  0����  1����
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
	 		pub_num=totalETList.size();
	 		
	 		//6 �������д��ҳ����ձ���
	 		hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			hxData.add("PLAN_USERNAME", personName);
			hxData.add("PLAN_DATE", curDate);
			hxData.addData(hiddenData);
			hxData.addData(jhData);
			hxData.add("TOTAL_CIIDS", newTotalCiids);
			
			if("1".equals(pub_type)||"1"==pub_type){//�㷢����
				hxData.addData(dfData);
			}else{//Ⱥ������
				hxData.addData(dfData);
				hxData.addData(qfData);
				hxData.add("TMP_TMP_PUB_ORGID_NAME", tmp_tmp_pub_orgid_name);
			}
		 	
			setAttribute("data", hxData);
			setAttribute("List", totalETList);
			dt.commit();
		} catch (DBException e) {
			dt.rollback();
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
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
						log.logError("PublishPlanAction��removeET.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	
	
	
	/**
	 * ��ת����������ͯѡ���б�	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toChoseETForJH(){
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
			ordertype=null;
		}
		
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//��������data
	 	String plan_id = hiddenData.getString("PLAN_ID");
	 	if("".equals(plan_id)||null==plan_id){
	 		plan_id = getParameter("PLAN_ID");
	 	}
		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","SPECIAL_FOCUS","PUB_NUM","PUB_FIRSTDATE_START","PUB_FIRSTDATE_END","PUB_LASTDATE_START","PUB_LASTDATE_END");
		
		String NAME = data.getString("NAME");
		if(null != NAME){
			data.add("NAME", NAME.toLowerCase());
		}
		
		data.add("PLAN_ID", plan_id);
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.toChoseETForJH(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���������ѯ�����쳣");
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
						log.logError("PublishPlanAction��toChoseETForJH.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * �����ƻ�������Ϣ������ύ
	 * @description 
	 * @author MaYun
	 * @date Sep 30, 2014
	 * @return
	 * @throws SQLException 
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 */
	public String saveFBJHBaseInfo() throws SQLException, NumberFormatException, ParseException{
		//1 ���ҳ������ݣ��������ݽ����
		String method = getParameter("method");//�ж��Ǳ��滹���ύ  0������  1���ύ
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//��������data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//�����ƻ�data
		
		try {
			//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //**********���淢���ƻ�������Ϣbegin***********
            String plan_id = hiddenData.getString("PLAN_ID");
    		jhData.add("PLAN_ID", plan_id);//�ƻ�����ID
    		jhData.add("PLAN_USERID", personId);//�ƶ���ID
    		jhData.add("PLAN_USERNAME", personName);//�ƶ�������
    		jhData.add("PLAN_DATE", curDate);//�ƶ�����
    		
    		if("0".equals(method)||"0"==method){//���淽��
    			jhData.add("PLAN_STATE", "0");//����״̬Ϊ�ƶ���
    		}else{//�ύ����
    			jhData.add("PLAN_STATE", "1");//����״̬Ϊ������
    		}
    		
            PublishCommonManager manager = new PublishCommonManager();
            if("".equals(plan_id)||null==plan_id||"null".equals(plan_id)){
            	String plan_no = manager.createPubPlanSeqNO(conn);//���ɼƻ�����
            	jhData.add("PLAN_NO", plan_no);
            	jhData.add("NOTICE_STATE", "0");//Ԥ��״̬ΪδԤ��
            	jhData.add("PUB_NUM", 0);//��ͯ����Ϊ0
            }
            
			jhData = this.handler.saveFbJhInfo(conn, jhData);//���淢���ƻ�������Ϣ
			//**********���淢���ƻ�������Ϣend***********
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//����ɹ� 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ƻ�������ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ƻ�������ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}  finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("PublishPlanAction��saveFBJHBaseInfo.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", jhData);
		return retValue;
	}
	
	
	
	/**
	 * ����ά���ύ
	 * @description 
	 * @author MaYun
	 * @date Sep 30, 2014
	 * @return
	 * @throws SQLException 
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 */
	public String saveFBJHInfo() throws SQLException, NumberFormatException, ParseException{
		//1 ���ҳ������ݣ��������ݽ����
	 	String curDate = DateUtility.getCurrentDate();
		
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID","CIIDS");//��������data
		Data jhData = new Data();
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//�㷢data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//Ⱥ��data
		
		DataList saveFBDataList = new DataList();//������¼DataList
        DataList saveETDataList = new DataList();//��ͯ����DataList
        
        String pubType = dfData.getString("PUB_TYPE");//�������� 1:�㷢  2:Ⱥ��
        String plan_id = hiddenData.getString("PLAN_ID");
        String ciids = hiddenData.getString("CIIDS");//��ͯ����IDS
        ciids = StringUtil.convertSqlString(ciids);
		
		try {
			//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //**********���淢���ƻ�������Ϣbegin***********
            DataList selectedETDataList = this.handler.getFBJLListForPlan(conn, plan_id);
            int pub_num = selectedETDataList.size();
            int tempNum = ciids.split(",").length;
            pub_num = pub_num+tempNum;
            
    		jhData.add("PLAN_ID", plan_id);//�ƻ�����ID
    		jhData.add("PUB_NUM",pub_num);//��ͯ����
    		
			jhData = this.handler.saveFbJhInfo(conn, jhData);//���淢���ƻ�������Ϣ
			//**********���淢���ƻ�������Ϣend***********
			
			//***********���淢����¼begin*************
			DataList etDataList = this.handler.findSelectedET(conn, ciids);
			for(int i =0;i<etDataList.size();i++){
        		Data etData = (Data)etDataList.get(i);
        		String ciid = etData.getString("CI_ID");//��ͯ����ID
        		String isSpecial = etData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע
        		
        		Data saveFBData = new Data();//������¼DATA
        		saveFBData.add("PLAN_ID",plan_id);//�����ƻ�ID
        		saveFBData.add("CI_ID",ciid);//��ͯ����ID
        		saveFBData.add("PUB_TYPE", pubType);//��������
        		
        		//*********�����ͯ���������Ϣbegin**********
        		if("1".equals(pubType)||"1"==pubType){//���ҳ��ѡ����ǵ㷢
        			saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//�㷢�ķ�����֯
        			saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
        			saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
        			if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//��������
            		}else {//���ر��ע
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//��������
            		}
        		}else{//���ҳ��ѡ�����Ⱥ��
        			saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//Ⱥ���ķ�����֯
        			if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//��������
            		}else {//���ر��ע
            			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//��������
            		}
        		}
        		
        		//saveFBData.add("PUBLISHER_ID",personId);//������
        		//saveFBData.add("PUBLISHER_NAME",personName);//����������
        		//saveFBData.add("PUB_DATE",curDate);//��������
        		saveFBData.add("PUB_STATE",PublishManagerConstant.JHZ);//����״̬Ϊ"�ƻ���"
            	
            	saveFBDataList.add(saveFBData);
            	//*********�����ͯ���������Ϣend**********
            	
            	//**********���¶�ͯ���ϱ������Ϣbegin**********
            	Data saveETData = new Data();//��ͯ���ϸ���DATA
            	saveETData.add("CI_ID", ciid);//��ͯ����ID
            	saveETData.add("PUB_TYPE", pubType);//��������
            	
            	if("1".equals(pubType)||"1"==pubType){//���ҳ��ѡ����ǵ㷢
            		saveETData.add("PUB_ORGID", dfData.getString("PUB_ORGID"));//�㷢������֯
            	}else{
            		saveETData.add("PUB_ORGID", qfData.getString("PUB_ORGID"));//Ⱥ��������֯
            	}
            	
            	//saveETData.add("PUB_USERID", personId);//������ID
            	//saveETData.add("PUB_USERNAME", personName);//����������
            	saveETData.add("PUB_STATE", PublishManagerConstant.JHZ);//����״̬Ϊ���ƻ��С�
            	
            	/**
            	if(this.managerHandler.isFirstFb(conn, ciid)){//�жϸö�ͯ�Ƿ񷢲�����true:������  false:δ������
            		int num = this.managerHandler.getFbNum(conn, ciid);//��øö�ͯ��������
            		saveETData.add("PUB_NUM", num+1);//��������
            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
            	}else{
            		saveETData.add("PUB_NUM", 1);//��������
            		saveETData.add("PUB_FIRSTDATE", curDate);//�״η�������
            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
            	}
            	*/
            	saveETDataList.add(saveETData);
            	//**********���¶�ͯ���ϱ������Ϣend**********
        	}
        	
	     
        
	        this.managerHandler.batchSubmitForETFB(conn,saveFBDataList);//�����ͯ������¼��Ϣ
	        this.managerHandler.batchUpdateETCL(conn, saveETDataList);//�����ͯ������Ϣ
			//***********���淢����¼end***************
			setAttribute("data",hiddenData );
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//����ɹ� 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ά���ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ά���ύ�����쳣");
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
						log.logError("PublishPlanAction��saveFBJHInfo.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", new Data());
		return retValue;
	}
	
	/**
	 * �ƻ�����
	 * @description 
	 * @author MaYun
	 * @date Oct 8, 2014
	 * @return
	 * @throws SQLException 
	 */
	public String planPublish() throws SQLException{
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//��������data
	 	String plan_id = hiddenData.getString("PLAN_ID");//�����ƻ�����ID

	 	DataList saveETDataList = new DataList();
	 	
	 	try {
			//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            this.handler.updateFBStateForFBJH(conn, plan_id);//���·����ƻ���ķ���״̬Ϊ�ѷ���
            this.handler.updateFBStateForFBJL(conn, personId, personName, plan_id);//���·�����¼��ķ���״̬Ϊ�ѷ���
            
			//***********���¶�ͯ���Ϸ���״̬Ϊ�ѷ���begin*************
			DataList etDataList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			for(int i =0;i<etDataList.size();i++){
        		Data etData = (Data)etDataList.get(i);
        		String ciid = etData.getString("CI_ID");//��ͯ����ID
        		
        		Data saveETData = new Data();//������¼DATA
        		saveETData.add("CI_ID",ciid);//��ͯ����ID
        		saveETData.add("PUB_USERID",personId);//������
        		saveETData.add("PUB_USERNAME",personName);//����������
        		saveETData.add("PUB_STATE",PublishManagerConstant.YFB);//����״̬Ϊ"�ѷ���"
            	
            	if(this.managerHandler.isFirstFb(conn, ciid)){//�жϸö�ͯ�Ƿ񷢲�����true:������  false:δ������
            		int num = this.managerHandler.getFbNum(conn, ciid);//��øö�ͯ��������
            		saveETData.add("PUB_NUM", num+1);//��������
            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
            	}else{
            		saveETData.add("PUB_NUM", 1);//��������
            		saveETData.add("PUB_FIRSTDATE", curDate);//�״η�������
            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
            	}
            	saveETDataList.add(saveETData);
        	}
        	
			this.handler.updateFBStateForETCL(conn, saveETDataList);
        
	      //***********���¶�ͯ���Ϸ���״̬Ϊ�ѷ���end*************
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "�ƻ������ɹ�!");//����ɹ� 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ƻ����������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} catch (Exception e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ƻ����������쳣");
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
						log.logError("PublishPlanAction��planPublish.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", new Data());
		return retValue;
	 	
	}

	/**
	 * ��ת���ƻ�ά��ҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-10-8
	 * @return
	 */
	public String toModifyPlan(){
		Data hxData = new Data();//���˻��Ե�data
		int pub_num=0;//�ܶ�ͯ����
	 	int pub_num_tb=0;//�ر��ע��ͯ����
	 	int pub_num_ftb=0;//���ر��ע��ͯ����
	 	
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//��������data
	 	String plan_id = hiddenData.getString("PLAN_ID");
	 	if("".equals(plan_id)||null==plan_id){
	 		Data data = (Data)getAttribute("data");
	 		plan_id = data.getString("PLAN_ID");
	 	}

	 	DataList totalETList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			pub_num = totalETList.size();
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע  0����  1����
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
			
			hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			
		} catch (DBException e) {
			e.printStackTrace();
		}
	 	
		setAttribute("data", hxData);
		setAttribute("List", totalETList);
		return retValue;
	}
	
	/**
	 * ��ת���鿴�ƻ���ϸҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-10-8
	 * @return
	 */
	public String toViewPlan(){
		Data hxData = new Data();//���˻��Ե�data
		int pub_num=0;//�ܶ�ͯ����
	 	int pub_num_tb=0;//�ر��ע��ͯ����
	 	int pub_num_ftb=0;//���ر��ע��ͯ����
	 	
	 	String plan_id = getParameter("PLAN_ID");
	 	DataList totalETList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			pub_num = totalETList.size();
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע  0����  1����
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
			
			hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			
		} catch (DBException e) {
			e.printStackTrace();
		}
	 	
		setAttribute("data", hxData);
		setAttribute("List", totalETList);
		return retValue;
	}
	
	/**
	 * ��ת�������ƻ���ӡҳ��	
	 * @description 
	 * @author panfeng
	 * @date 2014-10-26
	 * @return
	 */
	public String printShow(){
		Data hxData = new Data();
	 	
	 	String plan_id = getParameter("showuuid");
	 	DataList totalETList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);
			hxData = this.handler.getFbDataForFBJH(conn, plan_id);
			
		} catch (DBException e) {
			e.printStackTrace();
		}
	 	
		setAttribute("printData", hxData);
		setAttribute("List", totalETList);
		return retValue;
	}
	
	/**
	 * ѡ����Ӷ�ͯ(ά��ҳ��)	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String addETForRevise(){
		Data hxData = new Data();//���˻��Ե�data
		String tmp_tmp_pub_orgid_name = (String)getParameter("TMP_TMP_PUB_ORGID_NAME");
		Data hiddenData = getRequestEntityData("H_","TOTAL_CIIDS","ADD_CIIDS","REMOVE_CIIDS","PLAN_ID");//��������data
		Data jhData = getRequestEntityData("J_","NOTE_DATE","PUB_DATE");//�����ƻ�data
		Data dfData = getRequestEntityData("P_","PUB_TYPE","ADOPT_ORG_NAME","COUNTRY_CODE","ADOPT_ORG_NAME","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//�㷢data
		Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//Ⱥ��data

		String plan_id = hiddenData.getString("plan_id");
		String pub_type = dfData.getString("PUB_TYPE");
		String totalCiids=hiddenData.getString("TOTAL_CIIDS");//��ȡ�ܵĶ�ͯ����IDS
		String addCiids=hiddenData.getString("ADD_CIIDS");//��ȡ����ѡ��Ķ�ͯ����IDS
		totalCiids= StringUtil.convertSqlString(totalCiids);
		addCiids= StringUtil.convertSqlString(addCiids);
		
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	DataList totalETList = new DataList();
	 	int pub_num=0;//�ܶ�ͯ����
	 	int pub_num_tb=0;//�ر��ע��ͯ����
	 	int pub_num_ftb=0;//���ر��ע��ͯ����
	 	
	 	try {
	 		//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//this.handler.updatePubStateForET(conn, addCiids, "1");//��ͯ����״̬����Ϊ���ƻ��С�
			
			//5 ��ȡ����DataList
			if(!"".equals(totalCiids)&&null!=totalCiids){
				totalETList = this.handler.findSelectedET(conn, totalCiids);
			}
			
			for(int i=0;i<totalETList.size();i++){
				Data etData = (Data)totalETList.get(i);
				String special_focus = etData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע  0����  1����
				if("0".equals(special_focus)||"0"==special_focus){
					pub_num_ftb=pub_num_ftb+1;
				}else{
					pub_num_tb=pub_num_tb+1;
				}
			}
	 		pub_num=totalETList.size();
	 		
	 		//6 �������д��ҳ����ձ���
	 		hxData.add("PLAN_ID", plan_id);
	 		hxData.add("PUB_NUM", pub_num);
	 		hxData.add("PUB_NUM_TB", pub_num_tb);
	 		hxData.add("PUB_NUM_FTB", pub_num_ftb);
			hxData.add("PLAN_USERNAME", personName);
			hxData.add("PLAN_DATE", curDate);
			hxData.addData(hiddenData);
			hxData.addData(jhData);
			if("1".equals(pub_type)||"1"==pub_type){//�㷢����
				hxData.addData(dfData);
			}else{//Ⱥ������
				hxData.addData(dfData);
				hxData.addData(qfData);
				hxData.add("TMP_TMP_PUB_ORGID_NAME", tmp_tmp_pub_orgid_name);
			}
		 	
			setAttribute("data", hxData);
			setAttribute("List", totalETList);
			dt.commit();
		} catch (DBException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת���ƻ��ƶ���ϸҳ������쳣");
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
						log.logError("PublishPlanAction��toPlanInfoAdd.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	
	/**
	 * ѡ���Ƴ���ͯ��ά��ҳ�棩	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 * @throws SQLException 
	 */
	public String removeETForRevise() throws SQLException{
		Data jhData = new Data();
		Data hiddenData = getRequestEntityData("H_","REMOVE_CIIDS","PLAN_ID","PUB_NUM");//��������data

		String plan_id = hiddenData.getString("PLAN_ID");
		String remove_ciids=hiddenData.getString("REMOVE_CIIDS");//��ȡ����ѡ��Ķ�ͯ����IDS
		String remove_ciidsForSql= StringUtil.convertSqlString(remove_ciids);
		
	 	DataList totalETList = new DataList();
	 	try {
	 		//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			
			this.handler.updatePubStateForET(conn, remove_ciidsForSql, "0");//��ͯ����״̬����Ϊ����������
			this.handler.deleteFBJLForCIIDS(conn, plan_id, remove_ciidsForSql);//ɾ����ض�ͯ��Ӧ�ķ�����¼
			totalETList = this.handler.getEtInfoListForFBJH(conn, plan_id);//��ȡ�üƻ��´������Ķ�ͯlist
			
	 		int pub_num=totalETList.size();
	 		jhData.add("PLAN_ID", plan_id);
	 		jhData.add("PUB_NUM", pub_num);
	 		this.handler.updateFBJH(conn, jhData);//���·����ƻ��Ķ�ͯ����
	 		
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "�Ƴ���ͯ�ɹ�!");//����ɹ� 0
	        setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			dt.rollback();
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ѡ���Ƴ���ͯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			dt.rollback();
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ѡ���Ƴ���ͯ�����쳣");
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
						log.logError("PublishPlanAction��removeETForRevise.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	/**
	 * �õ�����һ����Ԥ��ķ����ƻ������Ϣ
	 * @description 
	 * @author MaYun
	 * @date Dec 9, 2014
	 * @return
	 */
	public String getFBJHForYYG(){
		try {
	 		//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			
			Data data = this.handler.getFBJHForYYG(conn);//�õ�����һ����Ԥ��ķ����ƻ������Ϣ
			setAttribute("data", data);
		} catch (DBException e) {
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, " �õ�����һ����Ԥ��ķ����ƻ������Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}catch (Exception e) {
			//�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, " �õ�����һ����Ԥ��ķ����ƻ������Ϣ�����쳣");
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
						log.logError("PublishPlanAction��getFBJHForYYG.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
	 	
	 	
		return retValue;
	}
	
	/**
	 * �ֶ�Ԥ�淢���ƻ�
	 * @description 
	 * @author MaYun
	 * @date Oct 8, 2014
	 * @return
	 * @throws SQLException 
	 */
	public String sdyg() throws SQLException{
	 	String curDate = DateUtility.getCurrentDateTime();
	 	
	 	Data hiddenData = getRequestEntityData("H_","PLAN_ID");//��������data
	 	hiddenData.add("NOTICE_STATE", "1");//Ԥ��״̬Ϊ����Ԥ�桱
	 	hiddenData.add("NOTE_DATE", curDate);//Ԥ������

	 	
	 	try {
			//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            this.handler.updateFBJH(conn, hiddenData);
            
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "�ֶ�Ԥ�淢���ƻ��ɹ�!");//����ɹ� 0
	        setAttribute("clueTo", clueTo);
		}  catch (DBException e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ֶ�Ԥ�淢���ƻ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} catch (Exception e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ֶ�Ԥ�淢���ƻ������쳣");
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
						log.logError("PublishPlanAction��sdyg.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		setAttribute("data", new Data());
		return retValue;
	}
	
	public static void main(String arg[]) throws ParseException{
		String curDate = DateUtility.getCurrentDate();
		System.out.println(curDate);
		System.out.println(UtilDate.getEndDate(curDate,2));
	}

}
