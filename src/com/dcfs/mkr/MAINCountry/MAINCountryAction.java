package com.dcfs.mkr.MAINCountry;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import base.task.token.Request;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.sce.PUBRecord.PUBRecordAction;
import com.dcfs.sce.PUBRecord.PUBRecordHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;

import hx.code.CodeList;
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

public class MAINCountryAction extends BaseAction{

	
	private static Log log=UtilLog.getLog(MAINCountryAction.class);
    private Connection conn = null;
    private MAINCountryHandler handler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public MAINCountryAction() {
        this.handler=new MAINCountryHandler();
    }
	
    @Override
	public String execute() throws Exception {
		return null;
	}
    
	// ���ɹ������νṹ
    public String mainCountryTree(){
        //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            String COUNTRY_CODE = getParameter("COUNTRY_CODE",null);
            if(COUNTRY_CODE==null){
            	//��ѯ
                dataList = handler.getMainCountryTree(conn);
                COUNTRY_CODE = dataList.get(0).getValue();
                setAttribute("COUNTRY_CODE", COUNTRY_CODE);
            }
        } catch (Exception e) {
            log.logError("������ʱ����!", e);
            retValue = "error1";
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������֯��ʱ�ر�Connection����!", e);
            }
        }
        //������
        setAttribute("dataList", dataList);
        return retValue;
    }
    
    //���ҹ�����Ϣ
    public String findCountry(){
    	String m = getParameter("m");
    		try {
    			String COUNTRY_CODE = (String) getAttribute("COUNTRY_CODE"); //getParameter("COUNTRY_CODE");
    			if(COUNTRY_CODE==null){
    				COUNTRY_CODE=getParameter("COUNTRY_CODE");
    			}
    			conn = ConnectionManager.getConnection();
    			String ID="";
    			if(COUNTRY_CODE==null||COUNTRY_CODE.equals("0")){
    				CodeList dataList = handler.getMainCountryTree(conn);
            		ID = dataList.get(0).getValue();
    			}else{
    				ID=COUNTRY_CODE;
    			}
    			//���ݹ���ID���ҹ��ҵĻ�����Ϣ
				Data countryData = handler.findCountryMessage(conn, ID);
				setAttribute("data", countryData);
				setAttribute("m", m);
			} catch (DBException e) {
				e.printStackTrace();
				retValue = "error1";
			}finally {
	            try {
	                if (conn != null && !conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                log.logError("��ѯ������Ϣʱ�ر�Connection����!", e);
	            }
	        }
			return retValue;
    }
    
    //���ݹ���ID���Ҷ�Ӧ����������
    public String findGovement(){
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
		String ID = (String)getParameter("ID","");
		if(ID==null||ID==""){
			ID=(String)getAttribute("ID");
		}
		try {
			conn = ConnectionManager.getConnection();
			//���ݹ��ҵ�ID��������������ŵ���Ϣ
    		DataList govementList = handler.findGovement(conn,ID,pageSize,page,compositor,ordertype);
    		String GOV_ID = (String)getParameter("GOV_ID");
    		setAttribute("List", govementList);
    		setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            setAttribute("COUNTRY_CODE", ID);
            setAttribute("GOV_ID", GOV_ID);
		} catch (DBException e) {
			//7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
    }
    
    //���ݹ���ID���ƣ��޸Ĺ�����Ϣ
    public String reviseCountry(){
    	Data data = getRequestEntityData("C_","COUNTRY_CODE","CURRENCY","CONVENTION","SOLICIT_SUBMISSIONS","SEQ_NO");
    	try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			handler.findReviseCountry(conn, data);
			String COUNTRY_CODE=data.getString("COUNTRY_CODE");
			setAttribute("COUNTRY_CODE",COUNTRY_CODE);
			dt.commit();
		} catch (DBException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//�ر����ݿ�����
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
    //��������ID����������ϸ��Ϣ����ϵ����Ϣ
    public String findGovementAndContact(){
    	//����ID
    	String COUNTRY_CODE = getParameter("COUNTRY_CODE","");
    	if(""==COUNTRY_CODE){
    		COUNTRY_CODE = (String)getAttribute("COUNTRY_CODE");
    	}
    	setAttribute("COUNTRY_CODE", COUNTRY_CODE);
    	//��������ID����������Ϣ
    	try {
			String GOV_ID = getParameter("GOV_ID",null);
			if(GOV_ID==null){
				GOV_ID = (String) getAttribute("GOV_ID");
			}
			setAttribute("GOV_ID", GOV_ID);
			conn = ConnectionManager.getConnection();
			setAttribute("data", new Data());
			//����ְ��list
			DataList goveList = handler.findGoveList(conn);
			setAttribute("goveList", goveList);
			if(GOV_ID==null){
				//���������ϢΪ��Ĭ����ʾ���ҳ��
				retValue="govementAdd";
			}else{
				String ID = GOV_ID;
				//��������ID���������Ļ�����Ϣ
				Data govementData = handler.findGovementMessage(conn, ID);
				String GOVER_FUNCTIONS = govementData.getString("GOVER_FUNCTIONS","");
				if(""!=GOVER_FUNCTIONS&&GOVER_FUNCTIONS.contains(",")){
					String [] str = GOVER_FUNCTIONS.split(",");
					String GOVER_FUNCTIONS0="";
					String GOVER_FUNCTIONS1="";
					String GOVER_FUNCTIONS2="";
					String GOVER_FUNCTIONS3="";
					for(int i=0;i<str.length;i++){
						if(str[i].equals("0")){
							GOVER_FUNCTIONS0="0";
						}
						if(str[i].equals("1")){
							GOVER_FUNCTIONS1="1";
						}
						if(str[i].equals("2")){
							GOVER_FUNCTIONS2="2";
						}
						if(str[i].equals("3")){
							GOVER_FUNCTIONS3="3";
						}
					}
					if(""!=GOVER_FUNCTIONS0){
						govementData.add("GOVER_FUNCTIONS0", GOVER_FUNCTIONS0);
					}
					if(""!=GOVER_FUNCTIONS1){
						govementData.add("GOVER_FUNCTIONS1", GOVER_FUNCTIONS1);
					}
					if(""!=GOVER_FUNCTIONS2){
						govementData.add("GOVER_FUNCTIONS2", GOVER_FUNCTIONS2);
					}
					if(""!=GOVER_FUNCTIONS3){
						govementData.add("GOVER_FUNCTIONS3", GOVER_FUNCTIONS3);
					}
				}
				setAttribute("govementData", govementData);
				//��������ID������ϵ�˵Ļ�����Ϣ
				DataList  contactList = handler.findContactMessage(conn,ID);
				setAttribute("contactList",contactList);
			}
		} catch (DBException e) {
			e.printStackTrace();
			retValue = "error1";
		}finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ��������ϵ����Ϣʱ�ر�Connection����!", e);
            }
        }
		return retValue;
    }

    //�޸�����������Ϣ
    public String reviseGovement(){
    	//Data data = getRequestEntityData("G_","GOV_ID","NAME_CN","NAME_EN","NATURE","GOVER_FUNCTIONS0","GOVER_FUNCTIONS1","GOVER_FUNCTIONS2","GOVER_FUNCTIONS3","HEAD_NAME","HEAD_PHONE","HEAD_EMAIL","WEBSITE","ADDRESS","REG_DATE","SEQ_NO");
    	Map map = getDataWithPrefix("G_", false);
    	Data data = new Data(map);
    	try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//��������ְ����Ϣ
			DataList dl = handler.findGoveList(conn);
			//�ж��������ݣ��ͻ�ö�������Ϣ
			Data da = new Data();
			StringBuffer GOVER_FUNCTION = new StringBuffer();
			for(int i=0;i<dl.size();i++){
				String a = data.getString("GOVER_FUNCTIONS"+i,"");
				String s = String.valueOf(i);
				if(!"".equals(a)){
					da.add(s, a);
				}
			}
			//ƴװ����
			StringBuffer GOVER_FUNCTIONS = new StringBuffer();
			for(int j=0;j<dl.size();j++){
				String  v = da.getString((String.valueOf(j)));
				if(!"".equals(v)&&v!=null){
					GOVER_FUNCTIONS.append(v+",");
				}
			}
			String gf = GOVER_FUNCTIONS.toString();
			String gfs="";
			if(gf.length()>=2){
				gfs = gf.substring(0, gf.length()-1);
			}
			data.add("GOVER_FUNCTIONS", gfs);
			for(int i=0;i<dl.size();i++){
				data.remove("GOVER_FUNCTIONS"+i);
			}
			//����޸�����ȥ��ǰϵͳʱ��
			data.add("MOD_DATE", time());
			handler.findReviseGovement(conn, data);
			String GOV_ID=data.getString("GOV_ID");
			String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
			setAttribute("COUNTRY_CODE", COUNTRY_CODE);
			setAttribute("GOV_ID",GOV_ID);
			dt.commit();
		} catch (DBException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//�ر����ݿ�����
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
    //�������������Ϣ
    public String addGovement(){
    	String COUNTRY_CODE =getParameter("COUNTRY_CODE");
    	Map map = getDataWithPrefix("G_", true);
    	Data data = new Data(map);
    	try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//��������ְ����Ϣ
			DataList dl = handler.findGoveList(conn);
			//�ж��������ݣ��ͻ�ö�������Ϣ
			Data da = new Data();
			StringBuffer GOVER_FUNCTION = new StringBuffer();
			for(int i=0;i<dl.size();i++){
				String a = data.getString("GOVER_FUNCTIONS"+i,"");
				String s = String.valueOf(i);
				if(!"".equals(a)){
					da.add(s, a);
				}
			}
			//ƴװ����
			StringBuffer GOVER_FUNCTIONS = new StringBuffer();
			for(int j=0;j<dl.size();j++){
				String  v = da.getString((String.valueOf(j)));
				if(!"".equals(v)&&v!=null){
					GOVER_FUNCTIONS.append(v+",");
				}
			}
			String gf = GOVER_FUNCTIONS.toString();
			String gfs="";
			if(gf.length()>=2){
				gfs = gf.substring(0, gf.length()-1);
			}
			
			data.add("GOVER_FUNCTIONS", gfs);
			data.add("COUNTRY_CODE", COUNTRY_CODE);
			for(int i=0;i<dl.size();i++){
				data.remove("GOVER_FUNCTIONS"+i);
			}
			handler.findAddGovement(conn, data);
			String GOV_ID=data.getString("GOV_ID");
			setAttribute("ID", COUNTRY_CODE);
			setAttribute("GOV_ID",GOV_ID);
			dt.commit();
		} catch (DBException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//�ر����ݿ�����
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
            }
		}
    	return "";
    }
    
    //������ϵ����Ϣ
    public String addContact() throws IOException{
		try {
			//3 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			String rowNum = this.getParameter("rowNum");
			DataList dataList = new DataList();
			for (int i = 1; i <= Integer.parseInt(rowNum); i++) {
				String CONTACT_NAME = this.getParameter("C_CONTACT_NAME"+i,"");      //��ϵ������
				String CONTACT_POSITION = this.getParameter("C_CONTACT_POSITION"+i,"");    //��ϵ��ְλ
				String CONTACT_TEL = this.getParameter("C_CONTACT_TEL"+i,"");      //��ϵ�˵绰
				String CONTACT_EMAIL = this.getParameter("C_CONTACT_EMAIL"+i,"");     //��ϵ������
				String GOV_ID = this.getParameter("C_GOV_ID","");   //����ID
				Data contactData = new Data();
				contactData.put("CONTACT_NAME",CONTACT_NAME );	//��ϵ������
				contactData.put("CONTACT_POSITION",CONTACT_POSITION );	//��ϵ��ְλ
				contactData.put("CONTACT_TEL",CONTACT_TEL );	//��ϵ�˵绰
				contactData.put("CONTACT_EMAIL",CONTACT_EMAIL );	 //��ϵ������
				contactData.put("GOV_ID", GOV_ID);	//����ID
				dataList.add(contactData);
			}
			String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
			String GOV_ID = (String)getParameter("GOV_ID");
			setAttribute("COUNTRY_CODE", COUNTRY_CODE);
			setAttribute("GOV_ID",GOV_ID);
			handler.saveContact(conn, dataList);  //������ϵ����Ϣ
			dt.commit();
		} catch (DBException e) {
			//5 �����쳣����
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣[�������]:" + e.getMessage(),e);
			}
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
			retValue = "error2";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction��Connection������쳣��δ�ܹر�",e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}
    
    //ɾ����ϵ����Ϣ
    public String delContact(){
    	//1 ��ȡҪɾ�����ļ�ID
		String ID = getParameter("ID", "");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3 ��ȡɾ�����
		    handler.delContact(conn, ID);
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��¼ɾ�������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[ɾ������]:" + e.getMessage(),e);
            }
            retValue = "error1";
        } finally {
        	//5 �ر����ݿ�
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("MAINCountryAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
		String GOV_ID = (String)getParameter("GOV_ID");
		setAttribute("COUNTRY_CODE", COUNTRY_CODE);
		setAttribute("GOV_ID",GOV_ID);
		return retValue;
    }

    //ɾ��������Ϣ
    public String delGovement(){
    	//1 ��ȡҪɾ�����ļ�ID
		String ID = getParameter("ID", "");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//��������ID������ϵ����Ϣ��ɾ��
			DataList dataList = handler.findContactMessage(conn, ID);
			DataList delData = new DataList();
			for(int i=0;i<dataList.size();i++){
				Data data = dataList.getData(i);
				data.setEntityName("MKR_COUNTRY_GOVMENT_CONTACTS");
				data.setPrimaryKey("ID");
				delData.add(data);
			}
			handler.delContactList(conn, delData);
		    handler.delGovement(conn, ID);
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��¼ɾ�������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[ɾ������]:" + e.getMessage(),e);
            }
            retValue = "error1";
        } finally {
        	//5 �ر����ݿ�
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("MAINCountryAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
		setAttribute("ID", COUNTRY_CODE);
		String m = (String)getParameter("m");
		setAttribute("m", m);
		return retValue;
    }
 
    //��ȡϵͳ��ǰʱ��
    public String time(){
		  Date date=new Date();
		  DateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		  String time=format.format(date);
		  return time;
	 }
}
