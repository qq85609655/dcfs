package com.dcfs.sce.REQInfo;

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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.dcfs.sce.preApproveAudit.PreApproveAuditHandler;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.util.UtilDate;


public class REQInfoAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(REQInfoAction.class);
    private Connection conn = null;
    private REQInfoHandler handler;
    private PublishManagerHandler PMhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public REQInfoAction() {
        this.handler=new REQInfoHandler();
        this.PMhandler=new PublishManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * @Description: ������֯����Ԥ���б�
     * @author: lihf
     */
    public String SYZZREQInfoList(){
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
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","REVOKE_REQ_DATE_START","REVOKE_REQ_DATE_END","REVOKE_CFM_DATE_START","REVOKE_CFM_DATE_END","REVOKE_STATE");
        if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
        	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
        	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
        }

        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            UserInfo user = SessionInfo.getCurUser();
            String organCode = user.getCurOrgan().getOrgCode();
            //5 ��ȡ����DataList
            DataList dl=handler.findREQInfoList(conn,data,organCode,pageSize,page,compositor,ordertype);
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
     * @Description: ������֯Ԥ�������б�
     * @author: lihf
     */
    public String SYZZREQInfoApplicatList(){
    	String type = getParameter("type","");
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
       Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","REQ_DATE_START","REQ_DATE_END","RI_STATE","SUBMIT_DATE_START","SUBMIT_DATE_END","REMINDERS_STATE","REM_DATE_START","REM_DATE_END","REGISTER_DATE_START","REGISTER_DATE_END","FILE_NO","LAST_UPDATE_DATE_START","LAST_UPDATE_DATE_END","PASS_DATE_START","PASS_DATE_END");
       if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
       	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
       }
       if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
       	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
       }
       if(type.equals("one")){
    	   data = new Data();
       }
       try {
           //4 ��ȡ���ݿ�����
           conn = ConnectionManager.getConnection();
           UserInfo user = SessionInfo.getCurUser();
           String organCode = user.getCurOrgan().getOrgCode();
           //5 ��ȡ����DataList
           DataList dl=handler.findREQInfoApplicatList(conn,data,organCode,pageSize,page,compositor,ordertype);
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
     * @Description: ��ת����д������֯���볷��ԭ��ҳ��
     * @author: lihf
     */
    public String SYZZREQInfoReason(){
    	String id = getParameter("id");//���볷����RI_ID
    	//��ȡ��ǰʱ��
    	Date now = new Date();  
    	//��DateFormat.getDateInstance()��ʽ��ʱ���Ϊ��2012-1-29  
    	DateFormat d1 = DateFormat.getDateInstance();       
    	String str1 = d1.format(now); 
    	try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.findREQInfoReason(conn, id);
            data.add("REVOKE_REQ_DATE",str1);  //ϵͳʱ��
            //ϵͳ��ǰ��¼�û�
            UserInfo user = SessionInfo.getCurUser();
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            String personName = user!=null?(user.getPerson()!=null?user.getPerson().getCName():""):"";
            data.add("REVOKE_REQ_USERNAME",personName);
            data.add("REVOKE_REQ_USERID",personId);
            setAttribute("data", data);
        }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("REQInfoAction��REQInfoReason.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
   }
    
    /**
     * @Description: ������֯������볷��ԭ��
     * @author: lihf
     */
    public String SYZZREQInfoAddReason(){
    	Data data = getRequestEntityData("S_","RI_ID","REVOKE_REASON","REVOKE_REQ_DATE","REVOKE_REQ_USERID","REVOKE_REQ_USERNAME");
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			data.add("REVOKE_STATE", "0");//����״̬�޸�Ϊ��ȷ��
			handler.findREQInfoAddReason(conn, data);
			dt.commit();
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//�ر����ݿ�����
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
    /**
     * @Description: ������֯���볷���鿴
     * @author: lihf
     */
    public String SYZZREQInfoSearchById(){
    	String id = getParameter("id");//���볷����RI_ID
    	try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.findREQInfoSearchById(conn, id);
            setAttribute("data", data);
        }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("REQInfoAction��REQInfoSearchById.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     * @Description: ���ò�Ԥ�������б�
     * @author: lihf
     */
    public String AZBREQInfoList(){
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
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME_CN","MALE_NAME","FEMALE_NAME","NAME","REVOKE_REQ_DATE_START","REVOKE_REQ_DATE_END","REVOKE_CFM_DATE_START","REVOKE_CFM_DATE_END","REVOKE_STATE","ADOPT_ORG_ID");
        //���С�Ů����������ת��Ϊ��д
        if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
        	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
        	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
        }

        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAZBREQInfoList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Description: ת�����ò�Ԥ������ȷ��ҳ��
     * @author: lihf
     */
    public String AZBREQInfoSearchById(){
    	String ids = getParameter("id");//ȷ����ϢID
    	String id=ids.split(",")[0];
    	String type=getParameter("type");//�鿴�������޸�
    	try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.findAZBREQInfoSearchById(conn, id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
//    	 	data.add("PUB_TYPE", "");
//    	 	data.add("PUB_MODE", "");
    	 	data.add("COUNTRY_CODE_NAME",data.getString("COUNTRY_CODE"));
    	 	data.add("COUNTRY_CODE", "");
//    	 	data.add("PUB_ORGID", "");
//    	 	data.add("ADOPT_ORG_NAME", "");
//    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
//    	 	data.add("PUB_REMARKS", "");
    		data.add("PLAN_USERNAME", personName);
    		data.add("PLAN_DATE", curDate);
            setAttribute("data", data);
        }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("REQInfoAction��AZBREQInfoSearchById������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        if(type.equals("show")){
        	return "show";
        }else {        	
        	return retValue;
        }
    }
    
    /**
     * @Description: ���ò���������ȷ��
     * @author: lihf
     * @throws ParseException
     * @throws NumberFormatException
     * @throws SQLException
     */
    public String AZBReqInfoconfirm() throws NumberFormatException, ParseException, SQLException{
    	//1 ���ҳ������ݣ��������ݽ����
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
    	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
    	String RI_ID = getParameter("RI_ID");
    	Data hiddenData = getRequestEntityData("H_","CI_ID","SPECIAL_FOCUS","AF_ID");  //��ͯdata
    	Data dfData = getRequestEntityData("c_","isPublish","PUB_ID","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE","PUB_REMARKS","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL"); //�㷢data
    	Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//Ⱥ��data
    	try {
    		//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //4ִ�����ݿ⴦�����
            String pubType = dfData.getString("PUB_TYPE");//�������� 1:�㷢  2:Ⱥ��
	    	String ciid = hiddenData.getString("CI_ID"); //��ͯ����ID;
	    	String isSpecial = hiddenData.getString("SPECIAL_FOCUS");//�Ƿ��ر��ע
	    	//������¼����Ϣ����
			Data saveFBData = new Data();//������¼DATA
    		Data saveETData = new Data();    //��ͯ���ϸ���DATA
    		Data ypData = new Data();  //Ԥ��data
    		if(dfData.getString("isPublish").equals("1")){
    			//*****���·���֮��ԭ���ķ���������Ϊ��Чbegin********
    			Data RIData = handler.getRIData(conn, RI_ID);  //Ԥ��data
    			//������¼��
    			String PUB_ID = RIData.getString("PUB_ID");
    			Data fabuData = handler.getPubData(conn, PUB_ID);
    			fabuData.add("PUB_STATE", "9");   //����״̬��Ϊ��Ч��
    			fabuData.add("ADOPT_ORG_ID", "");	//���������֯id
    			fabuData.add("LOCK_DATE", "");	//�����������
    			handler.savePubData(conn,fabuData);
    			//*****���·���֮��ԭ���ķ���������Ϊ��Чend********
	    		//*********���淢�������Ϣbegin**********
	    		if("1".equals(pubType)||"1"==pubType){
					try {
							saveFBData.add("CI_ID",ciid);//��ͯ����ID
				    		saveFBData.add("PUB_TYPE", pubType);//��������
							//���ҳ��ѡ����ǵ㷢
							saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//�㷢�ķ�����֯
							saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
							saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
							if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
								saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//��������
							}else {//���ر��ע
								saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//��������
							}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	    		}else{//���ҳ��ѡ�����Ⱥ��
					saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//Ⱥ���ķ�����֯
					if("1".equals(isSpecial)||"1"==isSpecial){//�ر��ע
	        			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//��������
	        		}else {//���ر��ע
	        			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//��������
	        		}
	    		}
	    		saveFBData.add("PUBLISHER_ID",personId);//������
	    		saveFBData.add("PUBLISHER_NAME",personName);//����������
	    		saveFBData.add("PUB_DATE",curDate);//��������
	    		saveFBData.add("PUB_STATE",PublishManagerConstant.YFB);//����״̬Ϊ"�ѷ���"
	    		//*********���淢�������Ϣend**********
	    		
	    		//**********���¶�ͯ���ϱ������Ϣbegin**********
	    		saveETData.add("CI_ID", ciid);   //��ͯ����ID
	    		saveETData.add("PUB_TYPE", pubType);//��������
	    		
	    		if("1".equals(pubType)||"1"==pubType){//���ҳ��ѡ����ǵ㷢
	        		saveETData.add("PUB_ORGID", dfData.getString("PUB_ORGID"));//�㷢������֯
	        	}else{
	        		saveETData.add("PUB_ORGID", qfData.getString("PUB_ORGID"));//Ⱥ��������֯
	        	}
	    		saveETData.add("PUB_USERID", personId);//������ID
	        	saveETData.add("PUB_USERNAME", personName);//����������
	        	saveETData.add("PUB_STATE", PublishManagerConstant.YFB);//����״̬Ϊ���ѷ�����
        		int num = PMhandler.getFbNum(conn, ciid);//��øö�ͯ��������
        		saveETData.add("PUB_NUM", num+1);//��������
        		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
        		//**********���¶�ͯ���ϱ������Ϣbegin**********
    		}else{
    			saveFBData.add("PUB_ID", dfData.getString("PUB_ID",""));
    			//Ԥ����
    			Data RIData = handler.getRIData(conn, RI_ID);
    			//������¼��
    			String PUB_ID = RIData.getString("PUB_ID");
    			saveFBData = handler.getPubData(conn, PUB_ID);
    			//��ͯ���ϱ�
    			String CI_ID = saveFBData.getString("CI_ID");
    			saveETData = handler.getCIData(conn, CI_ID);
    			saveFBData.add("ADOPT_ORG_ID", "");	//���������֯id
    			saveFBData.add("LOCK_DATE", "");	//�����������
    			//��ȡ��������
    			String SETTLE_DATE = saveFBData.getString("SETTLE_DATE");
    			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    			Date SETTLE_DATE1 =  sdf.parse(SETTLE_DATE);
    			Date curDate1 = sdf.parse(curDate);
    			if(SETTLE_DATE1.getTime()>=curDate1.getTime()){
    				saveFBData.add("PUB_STATE","2");  //������¼������״̬��Ϊ�ѷ���
    				saveETData.add("PUB_STATE", "2");  //��ͯ���ϱ�����״̬��Ϊ�ѷ���
    			}else if(SETTLE_DATE1.getTime()<curDate1.getTime()){
    				saveFBData.add("PUB_STATE","9");  //������¼������״̬��Ϊ������
    				saveETData.add("PUB_STATE", "0");  //��ͯ���ϱ�����״̬��Ϊ������
    			}
    		}
        	//**********���¶�ͯ���ϱ������Ϣend**********
	    	//**************����Ԥ��������Ϣ����begin************
    		//��ȡԤ��Data
    		Data ypwjData = handler.getRIData(conn, RI_ID);
    		String AF_ID = ypwjData.getString("AF_ID");
    		//����Ԥ������״̬��Ԥ��״̬�ж�Ԥ��
    		String REVOKESTATE = ypwjData.getString("REVOKE_STATE","");
    		String RIState = ypwjData.getString("RI_STATE","");
    		if(REVOKESTATE.equals("0")&&RIState.equals("9")){
    			ypData.add("REVOKE_STATE", "1");  //����״̬��Ϊ��ȷ��1
    		}else{
    			if(AF_ID!=null){
    	    		//��ȡ�ļ�data
    	    		Data wjData = handler.getAFData(conn,AF_ID);
    	    		//�����ļ������ж�
    	    		String FILE_TYPE = wjData.getString("FILE_TYPE");
    	    		if(FILE_TYPE.equals("20")||FILE_TYPE.equals("22")){  //���պ��ؼ�
    	    			
    	    			wjData.add("RI_ID", null);   //Ԥ����¼Ϊnull
    	    			wjData.add("RI_STATE", null);  //Ԥ��״̬null
    	    			wjData.add("CI_ID", null);   //��ͯ����null
    	    			
    	    		}else if(FILE_TYPE.equals("21")){   //��ת
    	    			
    	    			wjData.add("RI_ID", null);   //Ԥ����¼Ϊnull
    	    			wjData.add("RI_STATE", null);  //Ԥ��״̬null
    	    			wjData.add("CI_ID", null);   //��ͯ����null
    	    			wjData.add("FILE_TYPE", "10");  //�ļ����͸�Ϊ����
    	    			
    	    		}else if(FILE_TYPE.equals("23")){  //��˫
    	    			
    	    			wjData.add("FILE_TYPE", "20");   //�ļ����͸�Ϊ����
    	    			String yp_id = wjData.getString("RI_ID");   //����Ԥ��ID
    	    			String id1=yp_id.split(",")[0];
    	    			String id2=yp_id.split(",")[1];
    	    			if(RI_ID.equals(id1)){
    	    				wjData.add("RI_ID",id2);   //Ԥ����¼����Ԥ��������ID
    	    			}else if(RI_ID.equals(id2)){
    	    				wjData.add("RI_ID",id1);   //Ԥ����¼����Ԥ��������ID
    	    			}
    	    			//����CI_ID�ж��Ƿ��Ƕ��̥��ͯ
    	    			Data isTwinsData =  handler.getCIData(conn, ciid);
    	    			String IS_TWINS = isTwinsData.getString("IS_TWINS");
    	    			String[] et_id = wjData.getString("CI_ID").split(",");  //CI_ID
        				String str="";
    	    			if(IS_TWINS.equals("1")){  //1��yes��ͬ��̥�ֵ�
    	    				//��ȡ����ͬ����ͯ���
    	    				String[] TWINS_IDS = isTwinsData.getString("TWINS_IDS").split(",");
    	    				//����ͬ����ͯ�ı�ţ�����������ͯCI_ID��������Ϣ
    	    				DataList twinsList = new DataList();
    	    				for(int i=0;i<TWINS_IDS.length;i++){
    	    					Data d = new Data();
    	    					String CHILD_NO = TWINS_IDS[i];
    	    					d=handler.getCHILDNOData(conn, CHILD_NO);
    	    					twinsList.add(d);
    	    				}
    	    				Data erData = new Data();
    	    				erData.add("CI_ID",ciid);
    	    				twinsList.add(erData);
    	    				for(int i=0;i<et_id.length;i++){
    	    					boolean flag = true;
    	    					for(int j=0;j<twinsList.size();j++){
    	    						String temp=twinsList.getData(j).getString("CI_ID");
    	    						if(et_id[i].equals(temp)){
    	    							flag = false;
    	    							continue;
    	    						}
    	    					}
    	    					if(flag){
    	    						str+=et_id[i]+",";
    	    					}
    	    				}
    	    			}else{
    	    				for(int i=0;i<et_id.length;i++){
    	    					if(!et_id[i].equals(ciid)){
    	    						str+=et_id[i]+",";
    	    					}
    	    				}
    	    			}
    	    			str=str.substring(0, str.length()-1);
        				wjData.add("CI_ID", str);
    	    		}
    	    		//�����ļ���
    	    		handler.saveFfsData(conn, wjData);
    	    	}
    			ypData.add("RI_ID",RI_ID );
    			ypData.add("AF_ID",hiddenData.getString("AF_ID"));   //�ļ�ID
    			ypData.add("REVOKE_STATE", "1");  //����״̬��Ϊ��ȷ��1
    			ypData.add("RI_STATE",PreApproveConstant.PRE_APPROVAL_WX); //Ԥ������״̬��Ϊ��Ч9
    			ypData.add("PUB_ID","");   //pubIDֵΪ��
    			ypData.add("REVOKE_TYPE", "0");//��������Ϊ"��֯����"
    			ypData.add("REVOKE_CFM_USERID", personId);	//��������ȷ����id
    			ypData.add("REVOKE_CFM_USERNAME", personName);	//��������ȷ��������
    			ypData.add("REVOKE_CFM_DATE", curDate);	//��������ȷ������
    			ypData.add("UNLOCKER_ID", personId);	//���������id
    			ypData.add("UNLOCKER_NAME", personName);	//�������������
    			ypData.add("UNLOCKER_DATE", curDate);	//�����������
    			ypData.add("UNLOCKER_TYPE", "2");	//����������ͣ����Ľ����UNLOCKER_TYPE��0��
    		}
    		//************����Ԥ��������Ϣ����end************
			new PreApproveAuditHandler().PreApproveCancelApplySaveForAZB(conn,ypData,saveFBData,saveETData);
			dt.commit();
		}catch (DBException e) {
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
		}catch (SQLException e) {
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
        } finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//�ر����ݿ�����
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
    
    
}
