package com.dcfs.timer;

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

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.sce.preApproveApply.PreApproveApplyHandler;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.dcfs.sce.publishPlan.PublishPlanHandler;

/** 
 * @ClassName: TimerDispatchAction 
 * @Description: �������ִ�����ҵ���ܵ�Action
 * @author mayun
 * @date 2014-12-12
 *  
 */
public class TimerDispatchAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(TimerDispatchAction.class);
	private Connection conn = null;
	private PublishPlanHandler publishHandler;
	private PublishManagerHandler publishManagerHandler;
	private PreApproveApplyHandler preApproveHandler;
    private DBTransaction dt = null;//������
	    

	public TimerDispatchAction() {
		this.publishHandler=new PublishPlanHandler();
		this.publishManagerHandler=new PublishManagerHandler();
		this.preApproveHandler = new PreApproveApplyHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}
	
	
	
	
	/**
	 * �����ƻ�����
	 * @description 
	 * @author MaYun
	 * @date Oct 8, 2014
	 * @return
	 * @throws SQLException 
	 */
	public void planPublish() throws SQLException{
		String personId = "superadmin";
	 	String personName = "superadmin";
	 	String curDate = DateUtility.getCurrentDate();
	 	

	 	DataList saveETDataList = new DataList();
	 	
	 	try {
			//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String plan_id = this.publishManagerHandler.getPlanIdForDFB(conn);
            if(!"".equals(plan_id)&&null!=plan_id){
	            this.publishHandler.updateFBStateForFBJH(conn, plan_id);//���·����ƻ���ķ���״̬Ϊ�ѷ���
	            this.publishHandler.updateFBStateForFBJL(conn, personId, personName, plan_id);//���·�����¼��ķ���״̬Ϊ�ѷ���
	            
				//***********���¶�ͯ���Ϸ���״̬Ϊ�ѷ���begin*************
				DataList etDataList = this.publishHandler.getEtInfoListForFBJH(conn, plan_id);
				for(int i =0;i<etDataList.size();i++){
	        		Data etData = (Data)etDataList.get(i);
	        		String ciid = etData.getString("CI_ID");//��ͯ����ID
	        		
	        		Data saveETData = new Data();//������¼DATA
	        		saveETData.add("CI_ID",ciid);//��ͯ����ID
	        		saveETData.add("PUB_USERID",personId);//������
	        		saveETData.add("PUB_USERNAME",personName);//����������
	        		saveETData.add("PUB_STATE",PublishManagerConstant.YFB);//����״̬Ϊ"�ѷ���"
	            	
	            	if(this.publishManagerHandler.isFirstFb(conn, ciid)){//�жϸö�ͯ�Ƿ񷢲�����true:������  false:δ������
	            		int num = this.publishManagerHandler.getFbNum(conn, ciid);//��øö�ͯ��������
	            		saveETData.add("PUB_NUM", num+1);//��������
	            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
	            	}else{
	            		saveETData.add("PUB_NUM", 1);//��������
	            		saveETData.add("PUB_FIRSTDATE", curDate);//�״η�������
	            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
	            	}
	            	saveETDataList.add(saveETData);
	        	}
	        	
				this.publishHandler.updateFBStateForETCL(conn, saveETDataList);
	        
		      //***********���¶�ͯ���Ϸ���״̬Ϊ�ѷ���end*************
				dt.commit();
            }
		}  catch (DBException e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ƻ����������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
		} catch (Exception e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ƻ����������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
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
				}
			}
		}
		
	}

	/**
	 * @Title: preApproveReminderNotice 
	 * @Description: ��ʼ��Ԥ���߰�֪ͨ
	 * @author: yangrt;
	 * @throws SQLException    �趨�ļ� 
	 * @return void    �������� 
	 */
	public void preApproveReminderNotice() throws SQLException{
	 	String curDate = DateUtility.getCurrentDateTime();

	 	DataList initNoticeList = new DataList();
	 	DataList updateRiList = new DataList();
	 	try {
			//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            DataList riList = this.preApproveHandler.getRiIdForReminderNotice(conn);
            if(!riList.isEmpty()){
            	for(int i = 0; i < riList.size(); i++){
            		Data ridata = riList.getData(i);
            		
            		//����Ԥ�������¼��Ϣ
            		Data updateRidata = new Data();
            		updateRidata.add("RI_ID", ridata.getString("RI_ID",""));				//Ԥ��id
            		updateRidata.add("REMINDERS_STATE", "1");								//�߰�״̬��1=�Ѵ߰�
            		updateRidata.add("REM_DATE", curDate);									//�߰�����
            		updateRiList.add(updateRidata);
            		
            		//��ʼ��Ԥ���߰��¼��Ϣ
            		Data initdata = new Data();
            		initdata.add("RI_ID", ridata.getString("RI_ID",""));					//Ԥ��id
            		initdata.add("ADOPT_ORG_ID", ridata.getString("ADOPT_ORG_ID",""));		//������֯code
            		initdata.add("REQ_DATE", ridata.getString("REQ_DATE",""));				//Ԥ����������
            		initdata.add("PASS_DATE", ridata.getString("PASS_DATE",""));			//Ԥ��ͨ������
            		initdata.add("SUBMIT_DATE", ridata.getString("SUBMIT_DATE",""));		//��ǰ�ļ��ݽ�����
            		initdata.add("MALE_NAME", ridata.getString("MALE_NAME",""));			//������������
            		initdata.add("FEMALE_NAME", ridata.getString("FEMALE_NAME",""));		//Ů����������
            		initdata.add("NAME", ridata.getString("NAME",""));						//��ͯ����
            		initdata.add("NAME_PINYIN", ridata.getString("NAME_PINYIN",""));		//��ͯ����ƴ��
            		initdata.add("SEX", ridata.getString("SEX",""));						//��ͯ�Ա�
            		initdata.add("BIRTHDAY", ridata.getString("BIRTHDAY",""));				//��ͯ��������	
            		initdata.add("REM_DATE", curDate);										//�߰�����
            		initNoticeList.add(initdata);
            	}
            }
            
			this.preApproveHandler.updateRiDataList(conn,updateRiList);
			this.preApproveHandler.initReminderNoticeList(conn,initNoticeList);
			
			dt.commit();
		}  catch (DBException e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ʼ��Ԥ���߰�֪ͨ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
		} catch (Exception e) {
			dt.rollback();
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ʼ��Ԥ���߰�֪ͨ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
		} finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("TimerDispatchAction��preApproveReminderNotice.Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		
	}
}
