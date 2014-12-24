package com.dcfs.sce.publishManager;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;


import com.dcfs.common.DateUtil;
import com.dcfs.common.DcfsConstants;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;

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
 * @ClassName: PublishManagerAction 
 * @Description: ��������Action
 * @author mayun
 * @date 2014-9-12
 *  
 */
public class PublishManagerAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(PublishManagerAction.class);
	private Connection conn = null;
	private PublishManagerHandler handler;
    private DBTransaction dt = null;//������
	private String retValue = SUCCESS;
	    

	public PublishManagerAction() {
		this.handler=new PublishManagerHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}
	
	
	
	/**
	 * ���������ѯ�б�	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-12
	 * @return
	 */
	public String findListForFBGL(){
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

		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SPECIAL_FOCUS","SN_TYPE","PUB_FIRSTDATE_START","PUB_FIRSTDATE_END","PUB_LASTDATE_START","PUB_LASTDATE_END","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_START","SETTLE_DATE_END","PUB_STATE","ADOPT_ORG_ID2","LOCK_NUM","SUBMIT_DATE_START","SUBMIT_DATE_END","RI_STATE","DISEASE_CN");
		String NAME = data.getString("NAME");
		if(null != NAME){
			data.add("NAME", NAME.toLowerCase());
		}
		
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.findListForFBGL(conn,data,pageSize,page,compositor,ordertype);
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
						log.logError("PublishManagerAction��findListForFBGL.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	
	/**
	 * �ѷ�����֯�б�	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-12
	 * @return
	 */
	public String findListForFBORG(){
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
		
		Data hData = getRequestEntityData("H_","PUB_ID");
		String pub_id = getParameter("pub_id");//������¼ID
		if(null==pub_id||"".equals(pub_id)){
			pub_id = hData.getString("PUB_ID");
		}

		Data data = getRequestEntityData("S_","COUNTRY_CODE","PUB_ORGID");
		
		data.add("PUB_ID", pub_id);
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.findListForFBORG(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ѷ�����֯�б��ѯ�����쳣");
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
						log.logError("PublishManagerAction��findListForFBORG.Connection������쳣��δ�ܹر�",e);
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
	public String toChoseETForFB(){
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
		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","SPECIAL_FOCUS","PUB_NUM","PUB_FIRSTDATE_START","PUB_FIRSTDATE_END","PUB_LASTDATE_START","PUB_LASTDATE_END");
		
		String NAME = data.getString("NAME");
		if(null != NAME){
			data.add("NAME", NAME.toLowerCase());
		}
		
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.toChoseETForFB(conn,data,pageSize,page,compositor,ordertype);
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
						log.logError("PublishManagerAction��toChoseETForFB.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	
	/**
	 * ��ת�������ύҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toAddFBTJInfo(){
		String ciids = getParameter("ciids");
		setAttribute("ciids", ciids);
		setAttribute("rtfbData", new Data());
		return retValue;
	}
	
	/**
	 * ��ת����������ҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toCancleFB(){
		String pubid = getParameter("pubid");//������¼����
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ�鿴��Ϣ�����
			Data showdata = handler.getEtAndFbInfo(conn, pubid);
			String names = handler.getETNameForTB(conn, showdata.getString("CI_ID"));//���ͬ������
			showdata.add("REVOKE_USERNAME", personName);
			showdata.add("REVOKE_USERID", personId);
			showdata.add("REVOKE_DATE", curDate);
			showdata.add("TB_NAME", names);
			//4 ��������鿴ҳ��
			setAttribute("pubid", pubid);
			setAttribute("rtfbData", showdata);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 �ر����ݿ�����
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
	 * ��ת���������ҳ��	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toUnlockFB(){
		String pubid = getParameter("pubid");//������¼����
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ�鿴��Ϣ�����
			Data showdata = handler.getYpEtAndFbInfo(conn, pubid);
			String names = handler.getETNameForTB(conn, showdata.getString("CI_ID"));//���ͬ������
			showdata.add("UNLOCKER_NAME", personName);
			showdata.add("UNLOCKER_ID", personId);
			showdata.add("UNLOCKER_DATE", curDate);
			showdata.add("UNLOCKER_TYPE", "2");//�����������Ϊ��2 ���Ľ������
			showdata.add("TB_NAME", names);//ͬ������
			//4 ��������鿴ҳ��
			setAttribute("pubid", pubid);//��������ID
			setAttribute("riid", showdata.getString("RI_ID"));//Ԥ������ID
			setAttribute("ciid", showdata.getString("CI_ID"));//��ͯ��������ID
			setAttribute("rtfbData", showdata);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 �ر����ݿ�����
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
	 * ��ͯ�����ύ
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 * @throws SQLException 
	 */
	public String saveFbInfo() throws NumberFormatException, ParseException, SQLException{
		 //1 ���ҳ������ݣ��������ݽ����
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
		Data hiddenData = getRequestEntityData("H_","CIIDS");
        Data  dfData = getRequestEntityData("P_","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");
        Data  qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");
        
        DataList saveFBDataList = new DataList();//������¼DataList
        DataList saveETDataList = new DataList();//��ͯ����DataList
        
        String pubType = dfData.getString("PUB_TYPE");//�������� 1:�㷢  2:Ⱥ��
        String ciids = hiddenData.getString("CIIDS");//��ͯ����IDS
        String[] ciidsArray = ciids.split(";");
        
        try {
        	//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 ִ�����ݿ⴦�����
            
            for(int i =0;i<ciidsArray.length;i++){
        		String[] tempArray = ciidsArray[i].split(",");
        		String ciid = tempArray[0];//��ͯ����ID
        		String isSpecial = tempArray[1];//�Ƿ��ر��ע
        		
        		Data saveFBData = new Data();//������¼DATA
        		saveFBData.add("CI_ID",ciid);//��ͯ����ID
        		saveFBData.add("PUB_TYPE", pubType);//��������
        		
        		//*********�����ͯ���������Ϣbegin**********
        		if("1".equals(pubType)||"1"==pubType){//���ҳ��ѡ����ǵ㷢
        			saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//�㷢�ķ�����֯
        			saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
        			saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
        			
        			if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
            			//saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//��������
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//��������
            		}else {//���ر��ע
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//��������
            		}
        		}else{//���ҳ��ѡ�����Ⱥ��
        			saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//Ⱥ���ķ�����֯
        			if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//��������
            		}else {//���ر��ע
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//��������
            		}
        		}
        		
        		saveFBData.add("PUBLISHER_ID",personId);//������
        		saveFBData.add("PUBLISHER_NAME",personName);//����������
        		saveFBData.add("PUB_DATE",curDate);//��������
        		saveFBData.add("PUB_STATE",PublishManagerConstant.YFB);//����״̬Ϊ"�ѷ���"
            	
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
            	
            	saveETData.add("PUB_USERID", personId);//������ID
            	saveETData.add("PUB_USERNAME", personName);//����������
            	saveETData.add("PUB_STATE", PublishManagerConstant.YFB);//����״̬Ϊ���ѷ�����
            	
            	if(this.handler.isFirstFb(conn, ciid)){//�жϸö�ͯ�Ƿ񷢲�����true:������  false:δ������
            		int num = this.handler.getFbNum(conn, ciid);//��øö�ͯ��������
            		saveETData.add("PUB_NUM", num+1);//��������
            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
            	}else{
            		saveETData.add("PUB_NUM", 1);//��������
            		saveETData.add("PUB_FIRSTDATE", curDate);//�״η�������
            		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
            	}
            	saveETDataList.add(saveETData);
            	//**********���¶�ͯ���ϱ������Ϣend**********
        	}
        	
	     
        
	        this.handler.batchSubmitForETFB(conn,saveFBDataList);//�����ͯ������¼��Ϣ
	        this.handler.batchUpdateETCL(conn, saveETDataList);//�����ͯ������Ϣ
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 �����쳣����
        	setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��˻ز����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            //6 �������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
			dt.rollback();
        } catch (SQLException e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
            try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        } catch (Exception e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
            try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PublishManagerAction��saveFbInfo��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
        return retValue;
		
	}
	
	/**
	 * ��ͯ���������ύ
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 * @throws SQLException 
	 */
	public String saveCxfbInfo() throws NumberFormatException, ParseException, SQLException{
		 //1 ���ҳ������ݣ��������ݽ����
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	Data sData = getRequestEntityData("S_","IS_FB");
		Data hiddenData = getRequestEntityData("H_","PUBID","CI_ID","SPECIAL_FOCUS");//��������data
		Data etData = new Data();//��ͯ����data
        Data  cxfbData = getRequestEntityData("P_","REVOKE_DATE","REVOKE_USERID","REVOKE_USERNAME","REVOKE_REASON");//����������¼data
        Data  dfData = getRequestEntityData("P_","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//�㷢data
        Data  qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//Ⱥ��data
        
        DataList saveFBDataList = new DataList();//������¼DataList
        DataList saveETDataList = new DataList();//��ͯ����DataList
        
        String pubType = dfData.getString("PUB_TYPE");//�������� 1:�㷢  2:Ⱥ��
        String pubid = hiddenData.getString("PUBID");//������¼ID
        String ciid = hiddenData.getString("CI_ID");//��ͯ����ID
        String isSpecial = hiddenData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע
        
        try {
        	//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 ִ�����ݿ⴦�����
            
            //***********************���������з�������begin***********************
            etData.add("CI_ID",ciid);
            etData.add("PUB_STATE", PublishManagerConstant.DFB);//��ͯ��Ϣ��ķ���״̬Ϊ����������
            cxfbData.add("PUB_ID", pubid);//������¼��ķ�������ID
            cxfbData.add("PUB_STATE", PublishManagerConstant.WX);//������¼�ķ���״̬Ϊ����Ч��
            this.handler.updateFbInfo(conn, cxfbData);//���·�����¼��Ϣ
            this.handler.updateETCL(conn, etData);//���¶�ͯ������Ϣ
            //***********************���������з�������end***********************
            
            //***********************�������з�������begin***********************
            if("1".equals(sData.getString("IS_FB"))||"1"==sData.getString("IS_FB")){//��������
             		
             		Data saveFBData = new Data();//������¼DATA
             		saveFBData.add("CI_ID",ciid);//��ͯ����ID
             		saveFBData.add("PUB_TYPE", pubType);//��������
             		
             		//*********�����ͯ���������Ϣbegin**********
             		if("1".equals(pubType)||"1"==pubType){//���ҳ��ѡ����ǵ㷢
             			saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//�㷢�ķ�����֯
             			saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
             			saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
             			if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//��������
                 		}else {//���ر��ע
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//��������
                 		}
             		}else{//���ҳ��ѡ�����Ⱥ��
             			saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//Ⱥ���ķ�����֯
             			if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//��������
                 		}else {//���ر��ע
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//��������
                 		}
             		}
             		
             		saveFBData.add("PUBLISHER_ID",personId);//������
             		saveFBData.add("PUBLISHER_NAME",personName);//����������
             		saveFBData.add("PUB_DATE",curDate);//��������
             		saveFBData.add("PUB_STATE",PublishManagerConstant.YFB);//����״̬Ϊ"�ѷ���"
                 	
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
                 	
                 	saveETData.add("PUB_USERID", personId);//������ID
                 	saveETData.add("PUB_USERNAME", personName);//����������
                 	saveETData.add("PUB_STATE", PublishManagerConstant.YFB);//����״̬Ϊ���ѷ�����
                 	
                 	if(this.handler.isFirstFb(conn, ciid)){//�жϸö�ͯ�Ƿ񷢲�����true:������  false:δ������
                 		int num = this.handler.getFbNum(conn, ciid);//��øö�ͯ��������
                 		saveETData.add("PUB_NUM", num+1);//��������
                 		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
                 	}else{
                 		saveETData.add("PUB_NUM", 1);//��������
                 		saveETData.add("PUB_FIRSTDATE", curDate);//�״η�������
                 		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
                 	}
                 	saveETDataList.add(saveETData);
                 	//**********���¶�ͯ���ϱ������Ϣend**********
                 	this.handler.batchSubmitForETFB(conn,saveFBDataList);//�����ͯ������¼��Ϣ
         	        this.handler.batchUpdateETCL(conn, saveETDataList);//�����ͯ������Ϣ
             	}
            //***********************�������з�������end***********************
            
           
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 �����쳣����
        	setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��˻ز����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            //6 �������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
            dt.rollback();
        } catch (SQLException e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (Exception e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
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
                        log.logError("PublishManagerAction��saveCxfbInfo��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
        return retValue;
		
	}
	
	
	/**
	 * ��������ύ
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 * @throws SQLException 
	 */
	public String saveUnlockFbInfo() throws NumberFormatException, ParseException, SQLException{
		 //1 ���ҳ������ݣ��������ݽ����
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
		Data hiddenData = getRequestEntityData("H_","PUB_ID","CI_ID","RI_ID");//��������data
		Data unlockData = getRequestEntityData("P_","UNLOCKER_REASON","UNLOCKER_NAME","UNLOCKER_ID","UNLOCKER_DATE");//�������data
		Data etData = new Data();//��ͯ����data
		Data ypData = new Data();//Ԥ��data
		Data fbData = new Data();//����data
		String ciid=hiddenData.getString("CI_ID");//��ͯ��������ID
		String riid=hiddenData.getString("RI_ID");//Ԥ������ID
		String pubid=hiddenData.getString("PUB_ID");//��������ID
		
		etData.add("CI_ID", ciid);
		etData.add("PUB_STATE", PublishManagerConstant.YFB);//����״̬��Ϊ�ѷ���
        
		ypData.add("RI_ID", riid);
		ypData.add("UNLOCKER_ID", personId);
		ypData.add("UNLOCKER_NAME", personName);
		ypData.add("UNLOCKER_DATE", curDate);
		ypData.add("UNLOCKER_REASON", unlockData.getString("UNLOCKER_REASON"));
		ypData.add("UNLOCKER_TYPE", "2");//��������Ϊ���Ľ���
		ypData.add("LOCK_STATE", "1");//����״̬Ϊ�ѽ���
		ypData.add("RI_STATE", "9");//Ԥ��״̬Ϊ��Ч
		ypData.add("PUB_ID", "");//��Ӧ�ķ�����¼ID�ÿ�
		
		fbData.add("PUB_ID", pubid);
		fbData.add("PUB_STATE", PublishManagerConstant.YFB);//����״̬��Ϊ�ѷ���
		fbData.add("ADOPT_ORG_ID", "");//������֯��Ϊ��
		fbData.add("LOCK_DATE", "");//����������Ϊ��
		
   
        
        try {
        	//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 ִ�����ݿ⴦�����
            
            this.handler.updateYpInfo(conn, ypData);//����Ԥ����Ϣ
            this.handler.updateFbInfo(conn, fbData	);//���·�����¼��Ϣ
            this.handler.updateETCL(conn, etData);//���¶�ͯ������Ϣ
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�ɹ��������!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 �����쳣����
        	setAttribute(Constants.ERROR_MSG_TITLE, "��������ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            //6 �������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "�������ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
            dt.rollback();
        } catch (SQLException e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�������ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (Exception e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�������ʧ��!");
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
                        log.logError("PublishManagerAction��saveUnlockFbInfo��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
        return retValue;
		
	}
	
	/**
	 * �鿴�ö�ͯ����������Ϣ
	 * @description 
	 * @author MaYun
	 * @date 2014-9-24
	 * @return
	 */
	public String showLockHistory(){
		String ciid = getParameter("ciid");//��ͯ����ID
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.showLockHistory(conn,ciid);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data","");
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴�ö�ͯ����������Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴�ö�ͯ����������Ϣ�����쳣");
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
						log.logError("PublishManagerAction��showLockHistory.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * �鿴�ö�ͯ���η�����Ϣ
	 * @description 
	 * @author MaYun
	 * @date 2014-9-24
	 * @return
	 */
	public String showFbHistory(){
		String ciid = getParameter("ciid");//��ͯ����ID
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.showFbHistory(conn,ciid);
			Data data=handler.getETInfo(conn, ciid);
			String names = handler.getETNameForTB(conn, ciid);
			data.add("TB_NAME", names);//ͬ������
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴�ö�ͯ���η�����Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ѯ�����쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴�ö�ͯ���η�����Ϣ�����쳣");
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
						log.logError("PublishManagerAction��showFbHistory.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	
	
	
	public static void main(String arg[]) throws ParseException{
		String curDate = DateUtility.getCurrentDate();
		System.out.println(curDate);
		System.out.println(UtilDate.getEndDate(curDate,2));
	}

}
