package com.dcfs.sce.PUBRecord;

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
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;


public class PUBRecordAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(PUBRecordAction.class);
    private Connection conn = null;
    private PUBRecordHandler handler;
    private PublishManagerHandler PMhandler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public PUBRecordAction() {
        this.handler=new PUBRecordHandler();
        this.PMhandler=new PublishManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * @Description: ���ò��㷢�˻��б�
     * @author: lihf
     */
    public String PUBRecordList(){
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
        Data data = getRequestEntityData("C_","PROVINCE_ID","WELFARE_NAME_CN","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","SPECIAL_FOCUS","PUB_DATE_START","PUB_DATE_END","PUB_MODE","RETURN_TYPE","PUB_ORGID","RETURN_DATE_START","RETURN_DATE_END","RETURN_CFM_DATE_START","RETURN_CFM_DATE_END","RETURN_STATE","PUB_TYPE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findPUBRecordList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Description: ���ò��㷢�˻أ��鿴��
     * @author: lihf
     */
    public String PUBCheck(){
    	String id = getParameter("id");//ȷ����ϢID pub_id
    	try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.findPUBCheck(conn, id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
    	 	data.add("PUB_TYPE", "");
    	 	data.add("PUB_MODE", "");
    	 	Data datacountry = handler.findCountry(conn,data.getString("PUB_ORGI"));
    	 	data.add("COUNTRY_COD", datacountry.getString("COUNTRY_CODE"));  //����
    	 	data.add("COUNTRY_CODE", "");
    	 	data.add("PUB_ORGID", "");
    	 	data.add("ADOPT_ORG_NAME", "");
    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
    	 	data.add("PUB_REMARKS", "");
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
                        log.logError("AZBAdviceAction��AZBConfirm.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    //���ò��㷢�˻���Ϣ�鿴
    public String returnTypeCheck(){
    	String id = getParameter("id");//ȷ����ϢID pub_id
    	String type=getParameter("type");  //�鿴����
    	try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.findPUBCheck(conn, id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
    	 	data.add("PUB_TYPE", "");
    	 	data.add("PUB_MODE", "");
    	 	Data datacountry = handler.findCountry(conn,data.getString("PUB_ORGI"));
    	 	data.add("COUNTRY_COD", datacountry.getString("COUNTRY_CODE"));  //����
    	 	data.add("COUNTRY_CODE", "");
    	 	data.add("PUB_ORGID", "");
    	 	data.add("ADOPT_ORG_NAME", "");
    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
    	 	data.add("PUB_REMARKS", "");
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
                        log.logError("AZBAdviceAction��AZBConfirm.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
    	if(type.equals("child")){
    		return "child";
    	}else{
    		return "returnShow";
    	}
    }
    
    /**
     * @Description: ���ò��㷢�˻أ�ȷ�ϣ�
     * @author: lihf
     */
    public String PUBConfirm(){
    	String ids = getParameter("id");//ȷ����ϢIDS pub_ids
    	String id="";
    	String newStr ="";
    	try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            if(ids!=null){
    	 		id = ids.substring(0, ids.length()-1);
    	 	    newStr = id.replaceAll(",", "','");
    	 		
    	 	}
            DataList dataList = handler.findPUBConfirm(conn, newStr);
            setAttribute("newStr", id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
    	 	setAttribute("List", dataList);
    	 	Data data = dataList.getData(0);
    	 	data.add("PUB_TYPE", "");
    	 	data.add("PUB_MODE", "");
    	 	Data datacountry = handler.findCountry(conn,data.getString("PUB_ORGI"));
    	 	data.add("COUNTRY_COD", datacountry.getString("COUNTRY_CODE"));  //����
    	 	data.add("COUNTRY_CODE", "");
    	 	data.add("PUB_ORGID", "");
    	 	data.add("ADOPT_ORG_NAME", "");
    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
    	 	data.add("PUB_REMARKS", "");
    		data.add("PLAN_USERNAME", personName);
    		data.add("PLAN_DATE", curDate);
    	 	setAttribute("Data",dataList.getData(0));
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
                        log.logError("AZBAdviceAction��AZBConfirm.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * @Description: ���ò��㷢�˻���Ϣȷ���˻�
     * @author: lihf
     * @throws ParseException 
     * @throws NumberFormatException 
     * @throws SQLException 
     */
    public String PUBReturn() throws NumberFormatException, ParseException, SQLException{
    	//1 ���ҳ������ݣ��������ݽ����
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
    	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	String ids = getParameter("id");   //��ȡ�����ύ����ID(PUB_ID)
	 	String newStr = ids.replace(",", "','");
	 	DataList dataList = new DataList();
	 	
    	Data dfData = getRequestEntityData("c_","isPublish","PUB_ID","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE","PUB_REMARKS","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL"); //�㷢��Ϣ
    	Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//Ⱥ��data
    	DataList saveFBDataList = new DataList();//������¼DataList
        DataList saveETDataList = new DataList();//��ͯ����DataList
        
    	try {
    		//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            dataList = handler.findCIDataList(conn,newStr);
            //4 ִ�����ݿ⴦�����
            String isPublish = dfData.getString("isPublish");  //�Ƿ��������
			String pubType = dfData.getString("PUB_TYPE");//�������� 1:�㷢  2:Ⱥ��
			if(isPublish.equals("1")){
		    	for(int i=0;i<dataList.size();i++){
		    		String ciid = dataList.getData(i).getString("CI_ID");   //��ͯ����ID
		    		String isSpecial = dataList.getData(i).getString("SPECIAL_FOCUS");  //�Ƿ��ر��ע
		    		Data saveFBData = new Data();//������¼DATA
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
		    		saveFBData.add("PUBLISHER_ID",personId);//������
		    		saveFBData.add("PUBLISHER_NAME",personName);//����������
		    		saveFBData.add("PUB_DATE",curDate);//��������
		    		saveFBData.add("PUB_STATE",PublishManagerConstant.YFB);//����״̬Ϊ"�ѷ���"
		    		saveFBDataList.add(saveFBData);
		    		
		    		Data saveETData = new Data();    //��ͯ���ϸ���DATA
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
		        	if(PMhandler.isFirstFb(conn, ciid)){//�жϸö�ͯ�Ƿ񷢲�����true:������  false:δ������
		        		int num = PMhandler.getFbNum(conn, ciid);//��øö�ͯ��������
		        		saveETData.add("PUB_NUM", num+1);//��������
		        		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
		        	}else{
		        		saveETData.add("PUB_NUM", 1);//��������
		        		saveETData.add("PUB_FIRSTDATE", curDate);//�״η�������
		        		saveETData.add("PUB_LASTDATE", curDate);//ĩ�η�������
		        	}
		        	saveETDataList.add(saveETData);
		    	}
		    	PMhandler.batchSubmitForETFB(conn,saveFBDataList);//���ɶ�ͯ������¼��Ϣ
		        PMhandler.batchUpdateETCL(conn, saveETDataList);//���¶�ͯ������Ϣ
			}
	    	//���������˻���Ϣ
			DataList pubList = new DataList();
			DataList childList = new DataList();
			String[] str = ids.split(",");
			for(int i=0;i<str.length;i++){
				Data data = new Data();
				data.add("RETURN_STATE", "1");//�޸��˻�״̬Ϊ��ȷ��
				String pub_id = str[i];   //pub_id
				data.add("PUB_ID",pub_id);   //����
	        	String RETURN_CFM_USERID = SessionInfo.getCurUser().getPerson().getPersonId();  //�˻�ȷ����ID	
	        	String RETURN_CFM_USERNAME =SessionInfo.getCurUser().getPerson().getCName();   //�˻�ȷ��������	
	        	String RETURN_CFM_DATE = curDate;   //�˻�ȷ������		
	        	data.add("RETURN_CFM_USERID",RETURN_CFM_USERID);
	        	data.add("RETURN_CFM_USERNAME",RETURN_CFM_USERNAME);
	        	data.add("RETURN_CFM_DATE",RETURN_CFM_DATE);
	        	pubList.add(data);
	        	Data childData = new Data();
	        	String ci_id = dataList.getData(i).getString("CI_ID");
	        	childData.add("CI_ID", ci_id);
	        	if(isPublish.equals("1")){	   //����Ǽ�����������ͯ����״̬��Ϊ�ѷ�����2     		
	        		childData.add("PUB_STATE","2");   //��ͯ���ϱ��еķ���״̬��Ϊ�ѷ�����
	        	}else{
	        		childData.add("PUB_STATE","0");   //��ͯ���ϱ��еķ���״̬��Ϊ��������
	        	}
	        	childList.add(childData);
	        	
			}
			handler.findSYZZPUBRecordAddReason(conn, pubList);
        	handler.updateChildMessage(conn, childList);
			dt.commit();
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
        }  finally{
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
     * @Description: ������֯�㷢�˻ز鿴�б�
     * @author: lihf
     */
    public String SYZZPUBRecordList(){
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
        Data data = getRequestEntityData("C_","PROVINCE_ID","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","PUB_DATE_START","PUB_DATE_END","SETTLE_DATE_START","SETTLE_DATE_END","RETURN_DATE_START","RETURN_DATE_END","RETURN_CFM_DATE_START","RETURN_CFM_DATE_END","RETURN_STATE");
        //��ȡ�û�������֯ID
        String ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        data.add("ORG_ID", ORG_ID);
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findSYZZPUBRecordList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Description: ������֯�㷢�˻�type=show�鿴type=revise��ӵ㷢�˻�ԭ��
     * @author: lihf
     */
    public String SYZZPUBRecordDetail(){
    	String id = getParameter("PUB_ID");//ȷ����ϢID
    	String type = getParameter("type"); 
    	//��ȡ��ǰʱ��
    	Date now = new Date();  
    	//��DateFormat.getDateInstance()��ʽ��ʱ���Ϊ��2012-1-29  
    	DateFormat d1 = DateFormat.getDateInstance();       
    	String str1 = d1.format(now); 
    	try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data d = new Data();
            d.add("PUB_ID", id);
            Data data = handler.findSYZZPUBRecordDetail(conn, d);
            if(type.equals("revise")){
            	data.add("RETURN_DATE", str1);
            	data.add("RETURN_TYPE", "1");
            }
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
                        log.logError("AZBAdviceAction��AZBConfirm.Connection������쳣��δ�ܹر�",e);
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
     * @Description: ������֯�㷢�˻�ԭ�򱣴�
     * @author: lihf
     */
    public String SYZZPUBRecordAddReason(){
    	Data data = getRequestEntityData("S_","PUB_ID","RETURN_REASON","RETURN_DATE","RETURN_TYPE");
    	DataList dl = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			String person = SessionInfo.getCurUser().getPerson().getCName();
			String personId = SessionInfo.getCurUser().getPerson().getPersonId();
			data.add("RETURN_STATE", "0");//�㷢�˻�״̬Ϊ��0 ��ȷ��
			data.add("RETURN_USERID", personId);  //�˻���ԱID
			data.add("RETURN_USERNAME", person);   //�˻���Ա����
			dl.add(data);
			handler.findSYZZPUBRecordAddReason(conn, dl);
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
    
}
