package com.dcfs.mkr.organesupp;

import hx.code.Code;
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

import com.dcfs.common.DcfsConstants;
import com.dcfs.mkr.organexp.OrganExpAction;
import com.dcfs.mkr.organexp.OrganExpHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


public class OrganSuppAction extends BaseAction{

	private static Log log = UtilLog.getLog(OrganExpAction.class);

	private Connection conn = null;
	private OrganSuppHandler handler;
	private OrganExpHandler EXhandler;
	private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
	
	// ��ʼ��
	public OrganSuppAction(){
		handler = new OrganSuppHandler();
		EXhandler = new OrganExpHandler();
	}
	//********�ڻ���ϵ����Ϣbegin**************
	
	// ��ѯ�ڻ���ϵ����Ϣ
	public String linkManOrganList(){
		String type = getParameter("type","");
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        String id = getParameter("ID");   //������֯ID
        String linkManId = getParameter("linkManId");  //��ôӱ��淽���еõ���linkManId
        Data linkMan = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID�����ڻ���ϵ����Ϣ
            dataList = handler.findLinkManOrganList(conn ,id, pageSize, page,orderString);
            
            if(linkManId != null && !"".equals(linkManId)){
            	linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
            }
        } catch (Exception e) {
            log.logError("��ѯ�ڻ���ϵ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ�ڻ���ϵ��ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ID", id);
        setAttribute("data", linkMan);
        //��ϵ��list
        setAttribute("dataList", dataList);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//�޸��ڻ���ϵ����Ϣ
	public String linkManModify(){
		String type = getParameter("type","");
		Data linkMan = new Data();
		String linkManId = getParameter("linkManId");  //��ϵ��ID
		String ID = getParameter("ID","");   //��֯ID
		try {
			conn = ConnectionManager.getConnection();
			linkMan.add("ADOPT_ORG_ID", ID);   //��֯����ID
			if(linkManId != null && !"".equals(linkManId)){
				linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
			}
		} catch (DBException e) {
			log.logError("תȥ�޸���ϵ��ʱ����!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���ϵ��ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", linkMan);
		if(type.equals("shb")){
			return "shb";
		}else{
			return retValue;
		}
	}
	
	//�����ڻ���ϵ����Ϣ
	public String linkManModifySubmit() throws SQLException, IOException{
		Map map = getDataWithPrefix("MKR_", false);
		Data linkManData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			linkManData.setEntityName("MKR_ORG_CONTACTS");
			linkManData.setPrimaryKey("ID");   //��ϵ������ID
			String linkManId = linkManData.getString("ID","");  //��ϵ������
			String PER_RESUME = linkManData.getString("PER_RESUME");
			String COMMITMENT_ITEM = linkManData.getString("COMMITMENT_ITEM");
			if(linkManId != null && !"".equals(linkManId)){
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				handler.modify(conn,linkManData);
				handler.modify_empty(conn,linkManId,PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}else{
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				Data resultData = handler.add(conn,linkManData);
				handler.modify_empty(conn, resultData.getString("ID"),PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("תȥ�޸���ϵ��ʱ����!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���ϵ��ʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	//ɾ���ڻ���ϵ����Ϣ
	public String deleteLinkMan(){
		//1.��ȡҪɾ����Ϣ��ID
		String ID = getParameter("linkManId");
		try {
			//2.��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.ɾ������
			Data linkMan = new Data();
			linkMan.setEntityName("MKR_ORG_CONTACTS");
			linkMan.setPrimaryKey("ID");   //��ϵ������ID
			linkMan.add("ID", ID);
			handler.delete(conn,linkMan);
			dt.commit();
		} catch (Exception e) {
			//4.�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ɾ����ϵ�˲����쳣");
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
		}finally{
		//5.�ر����ݿ�����
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	//********�ڻ���ϵ����Ϣend**************
	
	//********Ԯ���;�����Ŀbegin******************
	//��ѯ������Ԯ����Ŀ��Ϣ
	public String aidProjectOrganList(){
		String type = getParameter("type","");
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        String id = getParameter("ID");   //������֯ID
        String aidProjectId = getParameter("aidProjectId");  //��ôӱ��淽���еõ�����ĿID
        Data aidProject = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID������Ԯ���������Ŀ��Ϣ
            dataList = handler.findAidProjectOrganList(conn ,id, pageSize, page,orderString);
            
            if(aidProjectId != null && !"".equals(aidProjectId)){
            	aidProject.setEntityName("MKR_ORG_AIDPROJECT");
            	aidProject.setPrimaryKey("ID");
            	aidProject.add("ID", aidProjectId);
            	aidProject = handler.findDataByKey(conn,aidProject);
            }
        } catch (Exception e) {
            log.logError("��ѯ�ڻ���ϵ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ�ڻ���ϵ��ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ID", id);
        setAttribute("data", aidProject);
        //��ϵ��list
        setAttribute("dataList", dataList);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//�޸ľ�����Ԯ����Ŀ��Ϣ
	public String aidProjectModify(){
		String type = getParameter("type","");
		Data aidProject = new Data();
		String aidProjectId = getParameter("aidProjectId");  //������Ԯ����ĿID
		String ID = getParameter("ID");   //��֯ID
		try {
			conn = ConnectionManager.getConnection();
			aidProject.add("ADOPT_ORG_ID", ID);   //��֯����ID
			if(aidProjectId != null && !"".equals(aidProjectId)){
				aidProject.setEntityName("MKR_ORG_AIDPROJECT");
				aidProject.setPrimaryKey("ID");
				aidProject.add("ID", aidProjectId);
				aidProject = handler.findDataByKey(conn,aidProject);
			}
		} catch (DBException e) {
			log.logError("תȥ�޸ľ�����Ԯ����Ŀʱ����!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ľ�����Ԯ����Ŀʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", aidProject);
		if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//����Ԯ���������Ŀ��Ϣ
	public String aidProjectModifySubmit(){
		Map map = getDataWithPrefix("MKR_", false);
		Data aidProjectData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			aidProjectData.setEntityName("MKR_ORG_AIDPROJECT");
			aidProjectData.setPrimaryKey("ID");   //Ԯ���������Ŀ����ID
			String aidProjectId = aidProjectData.getString("ID","");  //Ԯ�����������
			if(aidProjectId != null && !"".equals(aidProjectId)){
				handler.modify(conn,aidProjectData);
				//setAttribute("ID", aidProjectData.getString("ID",""));  //Ԯ���������ĿID
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,aidProjectData);
				//setAttribute("ID", "");  //����Ԯ���������ĿIDΪ��
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("תȥ�޸�Ԯ���������Ŀʱ����!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸�Ԯ���������Ŀʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	//��ת���հ�ҳ��
	public String organNull(){
		String m = (String)getAttribute("m");
		String ID = (String)getAttribute("ADOPT_ORG_ID");
		String type = (String)getAttribute("type");
		if(m!=null && m!=""){
			if(m.equals("ok") && m!=null){
				setAttribute("m","ok");
				setAttribute("ADOPT_ORG_ID",ID);
				setAttribute("type",type);
			}
		}
		return retValue;
	}
	
	//ɾ��Ԯ���������Ŀ��Ϣ
	public String deleteAidProject(){
		//1.��ȡҪɾ����Ϣ��ID
		String ID = getParameter("aidProjectId");
		try {
			//2.��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.ɾ������
			Data aidProject = new Data();
			aidProject.setEntityName("MKR_ORG_AIDPROJECT");
			aidProject.setPrimaryKey("ID");   //��ϵ������ID
			aidProject.add("ID", ID);
			handler.delete(conn,aidProject);
			dt.commit();
		} catch (Exception e) {
			//4.�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ɾ��Ԯ���������Ŀ�����쳣");
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
		}finally{
		//5.�ر����ݿ�����
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	} 
	
	//********Ԯ���������Ŀend*************
	
	//*******�ڻ����нӴ�begin*****************
	//�ڻ����нӴ�
	public String receptionOrganList(){
		String type = getParameter("type","");
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        String id = getParameter("ID");   //������֯ID
        String receptionId = getParameter("receptionId");  //�ӱ��淽���л�ȡ�ڻ����нӴ�ID
        Data reception = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID������Ԯ���������Ŀ��Ϣ
            dataList = handler.findReceptionOrganList(conn ,id, pageSize, page,orderString);
            
            if(receptionId != null && !"".equals(receptionId)){
            	reception.setEntityName("MKR_ORG_RECEPTION");   //������֯�ڻ����нӴ������Ϣ��
            	reception.setPrimaryKey("ID");
            	reception.add("ID", receptionId);
            	reception = handler.findDataByKey(conn,reception);
            }
        } catch (Exception e) {
            log.logError("��ѯ������֯�ڻ����нӴ�ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ������֯�ڻ����нӴ�ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ID", id);
        setAttribute("data", reception);
        //��ϵ��list
        setAttribute("dataList", dataList);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//�޸��ڻ����нӴ�
	public String receptionModify(){
		String type = getParameter("type","");
		Data reception = new Data();
		String receptionId = getParameter("receptionId");  //�ڻ����нӴ�ID
		String ID = getParameter("ID");   //��֯ID
		try {
			conn = ConnectionManager.getConnection();
			reception.add("ADOPT_ORG_ID", ID);   //��֯����ID
			if(receptionId != null && !"".equals(receptionId)){
				reception.setEntityName("MKR_ORG_RECEPTION");
				reception.setPrimaryKey("ID");
				reception.add("ID", receptionId);
				reception = handler.findDataByKey(conn,reception);
			}
		} catch (DBException e) {
			log.logError("תȥ�޸��ڻ����нӴ�ʱ����!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸��ڻ����нӴ�ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", reception);
		if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//�����ڻ����нӴ���Ϣ
	public String receptionModifySubmit(){
		Map map = getDataWithPrefix("MKR_", false);
		Data receptionData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			receptionData.setEntityName("MKR_ORG_RECEPTION");
			receptionData.setPrimaryKey("ID");   //�ڻ����нӴ�����ID
			String receptionId = receptionData.getString("ID","");  //�ڻ����нӴ�����
			if(receptionId != null && !"".equals(receptionId)){
				handler.modify(conn,receptionData);
				//setAttribute("ID", receptionData.getString("ID",""));  //��ϵ��ID
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,receptionData);
				//setAttribute("ID", "");  //������ϵ��IDΪ��
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("תȥ�޸��ڻ����нӴ�ʱ����!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸��ں����нӴ�ʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	//ɾ���ڻ����нӴ���Ϣ
	public String deleteReception(){
		//1.��ȡҪɾ����Ϣ��ID
		String ID = getParameter("receptionId");
		try {
			//2.��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.ɾ������
			Data reception = new Data();
			reception.setEntityName("MKR_ORG_RECEPTION");
			reception.setPrimaryKey("ID");   //��ϵ������ID
			reception.add("ID", ID);
			handler.delete(conn,reception);
			dt.commit();
		} catch (Exception e) {
			//4.�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ɾ���ڻ����нӴ���Ϣ�����쳣");
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
		}finally{
		//5.�ر����ݿ�����
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	//*****�ڻ����нӴ�end**************
	
	//**********��������begin***************
	public String organRecordStateList(){
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
        Data data = getRequestEntityData("MKR_","COUNTY_NAME","NAME_CN","NAME_EN","ORG_CODE","IS_VALID","FOUNDED_DATE_BEGIN","FOUNDED_DATE_END","RECORD_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findOrganRecordStateList(conn,data,pageSize,page,compositor,ordertype);
            //��ȡ���ҵ�DataList
            DataList countryList = handler.findCountryList(conn);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("countryList", countryList);
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
	
	//�������
	public String organRecordConfirm(){
		String ADOPT_ORG_ID = getParameter("ID");  //������֯ID
		//�����
		String RECORD_NAME = SessionInfo.getCurUser().getPerson().getCName();
		String RECORD_USERID = SessionInfo.getCurUser().getPerson().getPersonId();  //�����ID
		//����������֯ID���ұ�����Ϣ
		Data data = new Data();
		try {
			conn=ConnectionManager.getConnection();
        	data = handler.finfOrganRecordStateData(conn,ADOPT_ORG_ID);
        	data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);  //��֯ID
    		data.add("RECORD_NAME", RECORD_NAME);	//�����
    		data.add("RECORD_USERID", RECORD_USERID);  //�����ID
        	
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		setAttribute("data", data);
		return retValue;
	}
	
	//�ύ������
	public String organRecordStateSubmit(){
		Map map = getDataWithPrefix("MKR_", false);
		Data recordState = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			recordState.setEntityName("MKR_ADOPT_ORG_INFO");
			recordState.setPrimaryKey("ADOPT_ORG_ID");   //��֯ID����
			recordState.add("RECORD_STATE", "2");//�޸���֯����״̬2���ѱ���
			handler.modify(conn,recordState);
		} catch (DBException e) {
			log.logError("תȥ�ύ������ʱ����!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�ύ������ʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	//����������Ϣ�鿴
	public String organRecordStateDetail(){
			Data data = new Data();
	        String id = getParameter("ID");
	        Connection conn = null;
	        CodeList FWXMList = new CodeList();
	        CodeList GJList = new CodeList();
	        try {
	        	conn = ConnectionManager.getConnection();
	            data = EXhandler.findOrganModifyData(conn,id);
	            //��ȡ���й�����Ϣ
	            GJList = EXhandler.findCountryList(conn);
	            String codeId = "GJList";
	            GJList.setCodeSortId(codeId);
	            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
	            map.put(codeId, GJList);
	            setAttribute(Constants.CODE_LIST, map);
	            //������Ŀ ���뼯
	            FWXMList = EXhandler.findCodesortListById(conn, "FWXM");
	        } catch (Exception e) {
	            log.logError("תȥ�鿴��֯������Ϣʱ����!", e);
	        } finally {
	            try {
	                if (conn != null && !conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                log.logError("תȥ�鿴��֯������Ϣʱ�ر�Connection����!", e);
	            }
	        }
	        setAttribute("data", data);
	        setAttribute("FWXMList", FWXMList);
	        return retValue;
	}
	//********����������Ϣend************
	
	//���¼�¼�б�
	public String organUpdateList(){
		String type = getParameter("type","");
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CUI_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
		String ID = getParameter("ID");
        DataList dataList = new DataList();
        Data updateData = new Data();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID�����ڻ���ϵ����Ϣ
            dataList = handler.findOrganUpdateList(conn,ID,pageSize, page,orderString);
            if(ID != null && !"".equals(ID)){
            	updateData.add("CUI_ID", ID);
            }
        } catch (Exception e) {
            log.logError("��ѯ���¼�¼ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ���¼�¼ʱ�ر�Connection����!", e);
            }
        }
        //����list
        setAttribute("dataList", dataList);
        setAttribute("data",updateData);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	
	//**************����ά��Ӣ�İ�****************
	public String linkManOrganListEn(){
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        String id = getParameter("ID");   //������֯ID
        String linkManId = getParameter("linkManId");  //��ôӱ��淽���еõ���linkManId
        Data linkMan = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID�����ڻ���ϵ����Ϣ
            dataList = handler.findLinkManOrganList(conn ,id, pageSize, page,orderString);
            
            if(linkManId != null && !"".equals(linkManId)){
            	linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
            }
        } catch (Exception e) {
            log.logError("��ѯ�ڻ���ϵ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ�ڻ���ϵ��ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ID", id);
        setAttribute("data", linkMan);
        //��ϵ��list
        setAttribute("dataList", dataList);
        return retValue;
	}
	
	public String linkManModifyEn(){
		Data linkMan = new Data();
		String linkManId = getParameter("linkManId");  //��ϵ��ID
		String ID = getParameter("ID","");   //��֯ID
		try {
			conn = ConnectionManager.getConnection();
			linkMan.add("ADOPT_ORG_ID", ID);   //��֯����ID
			if(linkManId != null && !"".equals(linkManId)){
				linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
			}
		} catch (DBException e) {
			log.logError("תȥ�޸���ϵ��ʱ����!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���ϵ��ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", linkMan);
		return retValue;
	}
	
	public String linkManModifySubmitEn() throws SQLException, IOException{
		Map map = getDataWithPrefix("MKR_", false);
		Data linkManData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			linkManData.setEntityName("MKR_ORG_CONTACTS");
			linkManData.setPrimaryKey("ID");   //��ϵ������ID
			String linkManId = linkManData.getString("ID","");  //��ϵ������
			String PER_RESUME = linkManData.getString("PER_RESUME");
			String COMMITMENT_ITEM = linkManData.getString("COMMITMENT_ITEM");
			if(linkManId != null && !"".equals(linkManId)){
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				handler.modify(conn,linkManData);
				handler.modify_empty(conn,linkManId,PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}else{
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				Data resultData = handler.add(conn,linkManData);
				handler.modify_empty(conn, resultData.getString("ID"),PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("תȥ�޸���ϵ��ʱ����!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���ϵ��ʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	public String organNullEn(){
		String m = (String)getAttribute("m");
		String ID = (String)getAttribute("ADOPT_ORG_ID");
		String type = (String)getAttribute("type");
		if(m!=null && m!=""){
			if(m.equals("ok") && m!=null){
				setAttribute("m","ok");
				setAttribute("ADOPT_ORG_ID",ID);
				setAttribute("type",type);
			}
		}
		return retValue;
	}
	
	public String deleteLinkManEn(){
		//1.��ȡҪɾ����Ϣ��ID
		String ID = getParameter("linkManId");
		try {
			//2.��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.ɾ������
			Data linkMan = new Data();
			linkMan.setEntityName("MKR_ORG_CONTACTS");
			linkMan.setPrimaryKey("ID");   //��ϵ������ID
			linkMan.add("ID", ID);
			handler.delete(conn,linkMan);
			dt.commit();
		} catch (Exception e) {
			//4.�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ɾ����ϵ�˲����쳣");
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
		}finally{
		//5.�ر����ݿ�����
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	public String aidProjectOrganListEn(){
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        String id = getParameter("ID");   //������֯ID
        String aidProjectId = getParameter("aidProjectId");  //��ôӱ��淽���еõ�����ĿID
        Data aidProject = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID������Ԯ���������Ŀ��Ϣ
            dataList = handler.findAidProjectOrganList(conn ,id, pageSize, page,orderString);
            
            if(aidProjectId != null && !"".equals(aidProjectId)){
            	aidProject.setEntityName("MKR_ORG_AIDPROJECT");
            	aidProject.setPrimaryKey("ID");
            	aidProject.add("ID", aidProjectId);
            	aidProject = handler.findDataByKey(conn,aidProject);
            }
        } catch (Exception e) {
            log.logError("��ѯ�ڻ���ϵ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ�ڻ���ϵ��ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ID", id);
        setAttribute("data", aidProject);
        //��ϵ��list
        setAttribute("dataList", dataList);
        return retValue;
	}
	
	public String aidProjectModifyEn(){
		Data aidProject = new Data();
		String aidProjectId = getParameter("aidProjectId");  //������Ԯ����ĿID
		String ID = getParameter("ID");   //��֯ID
		try {
			conn = ConnectionManager.getConnection();
			aidProject.add("ADOPT_ORG_ID", ID);   //��֯����ID
			if(aidProjectId != null && !"".equals(aidProjectId)){
				aidProject.setEntityName("MKR_ORG_AIDPROJECT");
				aidProject.setPrimaryKey("ID");
				aidProject.add("ID", aidProjectId);
				aidProject = handler.findDataByKey(conn,aidProject);
			}
		} catch (DBException e) {
			log.logError("תȥ�޸ľ�����Ԯ����Ŀʱ����!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ľ�����Ԯ����Ŀʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", aidProject);
		return retValue;
	}
	
	public String aidProjectModifySubmitEn(){
		Map map = getDataWithPrefix("MKR_", false);
		Data aidProjectData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			aidProjectData.setEntityName("MKR_ORG_AIDPROJECT");
			aidProjectData.setPrimaryKey("ID");   //Ԯ���������Ŀ����ID
			String aidProjectId = aidProjectData.getString("ID","");  //Ԯ�����������
			if(aidProjectId != null && !"".equals(aidProjectId)){
				handler.modify(conn,aidProjectData);
				//setAttribute("ID", aidProjectData.getString("ID",""));  //Ԯ���������ĿID
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,aidProjectData);
				//setAttribute("ID", "");  //����Ԯ���������ĿIDΪ��
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("תȥ�޸�Ԯ���������Ŀʱ����!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸�Ԯ���������Ŀʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	public String deleteAidProjectEn(){
		//1.��ȡҪɾ����Ϣ��ID
		String ID = getParameter("aidProjectId");
		try {
			//2.��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.ɾ������
			Data aidProject = new Data();
			aidProject.setEntityName("MKR_ORG_AIDPROJECT");
			aidProject.setPrimaryKey("ID");   //��ϵ������ID
			aidProject.add("ID", ID);
			handler.delete(conn,aidProject);
			dt.commit();
		} catch (Exception e) {
			//4.�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ɾ��Ԯ���������Ŀ�����쳣");
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
		}finally{
		//5.�ر����ݿ�����
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	} 
	
	public String receptionOrganListEn(){
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        String id = getParameter("ID");   //������֯ID
        String receptionId = getParameter("receptionId");  //�ӱ��淽���л�ȡ�ڻ����нӴ�ID
        Data reception = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID������Ԯ���������Ŀ��Ϣ
            dataList = handler.findReceptionOrganList(conn ,id, pageSize, page,orderString);
            
            if(receptionId != null && !"".equals(receptionId)){
            	reception.setEntityName("MKR_ORG_RECEPTION");   //������֯�ڻ����нӴ������Ϣ��
            	reception.setPrimaryKey("ID");
            	reception.add("ID", receptionId);
            	reception = handler.findDataByKey(conn,reception);
            }
        } catch (Exception e) {
            log.logError("��ѯ������֯�ڻ����нӴ�ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ������֯�ڻ����нӴ�ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ID", id);
        setAttribute("data", reception);
        //��ϵ��list
        setAttribute("dataList", dataList);
        return retValue;
	}
	
	public String receptionModifyEn(){
		Data reception = new Data();
		String receptionId = getParameter("receptionId");  //�ڻ����нӴ�ID
		String ID = getParameter("ID");   //��֯ID
		try {
			conn = ConnectionManager.getConnection();
			reception.add("ADOPT_ORG_ID", ID);   //��֯����ID
			if(receptionId != null && !"".equals(receptionId)){
				reception.setEntityName("MKR_ORG_RECEPTION");
				reception.setPrimaryKey("ID");
				reception.add("ID", receptionId);
				reception = handler.findDataByKey(conn,reception);
			}
		} catch (DBException e) {
			log.logError("תȥ�޸��ڻ����нӴ�ʱ����!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸��ڻ����нӴ�ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", reception);
		return retValue;
	}
	
	public String receptionModifySubmitEn(){
		Map map = getDataWithPrefix("MKR_", false);
		Data receptionData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			receptionData.setEntityName("MKR_ORG_RECEPTION");
			receptionData.setPrimaryKey("ID");   //�ڻ����нӴ�����ID
			String receptionId = receptionData.getString("ID","");  //�ڻ����нӴ�����
			if(receptionId != null && !"".equals(receptionId)){
				handler.modify(conn,receptionData);
				//setAttribute("ID", receptionData.getString("ID",""));  //��ϵ��ID
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,receptionData);
				//setAttribute("ID", "");  //������ϵ��IDΪ��
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("תȥ�޸��ڻ����нӴ�ʱ����!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸��ں����нӴ�ʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	public String deleteReceptionEn(){
		//1.��ȡҪɾ����Ϣ��ID
		String ID = getParameter("receptionId");
		try {
			//2.��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.ɾ������
			Data reception = new Data();
			reception.setEntityName("MKR_ORG_RECEPTION");
			reception.setPrimaryKey("ID");   //��ϵ������ID
			reception.add("ID", ID);
			handler.delete(conn,reception);
			dt.commit();
		} catch (Exception e) {
			//4.�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ɾ���ڻ����нӴ���Ϣ�����쳣");
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
		}finally{
		//5.�ر����ݿ�����
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	public String organUpdateListEn(){
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CUI_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
		String ID = getParameter("ID");
        DataList dataList = new DataList();
        Data updateData = new Data();
        try {
            conn = ConnectionManager.getConnection();
            //����������֯��ϢID�����ڻ���ϵ����Ϣ
            dataList = handler.findOrganUpdateList(conn,ID,pageSize, page,orderString);
            if(ID != null && !"".equals(ID)){
            	updateData.add("CUI_ID", ID);
            }
        } catch (Exception e) {
            log.logError("��ѯ���¼�¼ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ���¼�¼ʱ�ر�Connection����!", e);
            }
        }
        //����list
        setAttribute("dataList", dataList);
        setAttribute("data",updateData);
        return retValue;
	}
	//**********����ά��Ӣ�İ�end*******************
	
	//����ʡ�����νṹ
	 public String provinceTree(){
	        Connection conn = null;
	        //ʹ��CodeList��װ��ѯ������ʡ�ݣ�����ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
	        CodeList dataList = new CodeList();
	        try {
	            conn = ConnectionManager.getConnection();
	    		//��ѯ
	    		dataList = handler.getProvinceTree(conn);
	    		if(dataList!=null&&dataList.size()>0){
	    			for(int i=0;i<dataList.size();i++){
	    				dataList.get(i).setIcon("folder");
	    			}
	    		}
	        } catch (Exception e) {
	            log.logError("������֯��ʱ����!", e);
	        } finally {
	            try {
	                if (conn != null && !conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                log.logError("������֯��ʱ�ر�Connection����!", e);
	            }
	        }
	        setAttribute("dataList", dataList);
	        if(dataList != null && dataList.size() > 0){
	        	Code d = dataList.get(0);
	        	setAttribute("CODE_ID", d.getValue());
	        }
	        return SUCCESS;
	    }
	
	//����ʡ�ݲ��Ҹ�������
	public String findWelfareList(){
		// 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        String id = getParameter("ID","");   //������֯ID
        if(id == null || "".equals(id) || "null".equalsIgnoreCase(id)){
        	id = (String)getAttribute("ID");
        }
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            String code = null;
            //����ʡ��ID���Ҹ���Ժ��Ϣ
            if(id != null && !"".equals(id) && !"null".equalsIgnoreCase(id)){
            	code = id.substring(0, 2);
            }
            dataList = handler.findWelfareList(conn ,code, pageSize, page,orderString);
        } catch (Exception e) {
            log.logError("��ѯ���ò���������ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("�ڲ�ѯ���ò���������ʱ�ر�Connection����!", e);
            }
        }
        //��������list����
        setAttribute("dataList", dataList);
        setAttribute("ID", id);
        return retValue;
	}
	
	//tabҳ��
	public String provinceListMessage(){
		String pro_code = getParameter("pro_code","");//ʡ��
		String ID = getParameter("ID","");  //��������ID
		String type = getParameter("type","");
		Data data = new Data();
		data.add("pro_code", pro_code);
		data.add("ID",ID);
		data.add("type",type);
		setAttribute("data", data);
		return retValue;
	}
	
	//��ת���޸�ҳ��
	public String toWelfareModif(){
		Data welfareData = new Data();
		Data organData = new Data();
		Data data = new Data();
		String pro_code = getParameter("pro_code","");//ʡ��
		String ID = getParameter("ID","");  //��������ID
		String type = getParameter("type","");
		Data temp = new Data();
		temp.add("ID", ID);
		temp.add("pro_code", pro_code);
		temp.add("type", type);
		try {
			conn = ConnectionManager.getConnection();
			welfareData.add("INSTIT_ID", ID);   //��������ID
			if(ID != null && !"".equals(ID)){
				//����������Ϣ���е�����
				welfareData.setEntityName("IIM_ORG_INFO");
				welfareData.setPrimaryKey("INSTIT_ID");
				welfareData.add("INSTIT_ID", ID);
				welfareData = handler.findDataByKey(conn,welfareData);
				//pub_organ���е����ݲ��丣��������
				organData.setEntityName("PUB_ORGAN");
				organData.setPrimaryKey("ID");
				organData.add("ID", ID);
				organData = handler.findDataByKey(conn, organData);
			}
			data.add("ID",organData.getString("ID"));  //����ID
			data.add("CNAME",organData.getString("CNAME"));  //��������
			data.add("ENNAME",organData.getString("ENNAME"));  //Ӣ������
			//ʡ��
			if(organData.getString("ORG_CODE").length()>3){
				String str = organData.getString("ORG_CODE").substring(0, 2);
				String province = str+"0000";
				data.add("PROVINCE_ID",province);
			}
				data.add("ID", ID);  //pub_organ�е�ID
			if(welfareData!=null){
				data.add("INSTIT_ID",ID);  //ID
				data.add("PRINCIPAL", welfareData.getString("PRINCIPAL")); //����
				data.add("CITY_ADDRESS_CN", welfareData.getString("CITY_ADDRESS_CN"));//�Ǽǵص�_����
				data.add("CITY_ADDRESS_EN", welfareData.getString("CITY_ADDRESS_EN"));//�Ǽǵص�_Ӣ��
				data.add("DEPT_ADDRESS_CN", welfareData.getString("DEPT_ADDRESS_CN"));//��ַ_����
				data.add("DEPT_ADDRESS_EN", welfareData.getString("DEPT_ADDRESS_EN"));//��ַ_Ӣ��
				data.add("DEPT_POST", welfareData.getString("DEPT_POST"));//�ʱ�
				data.add("DEPT_TEL", welfareData.getString("DEPT_TEL"));//�绰
				data.add("DEPT_FAX", welfareData.getString("DEPT_FAX"));//����
				data.add("CONTACT_NAME", welfareData.getString("CONTACT_NAME"));//������_����
				data.add("CONTACT_NAMEPY", welfareData.getString("CONTACT_NAMEPY"));	//������_����ƴ��
				data.add("CONTACT_SEX", welfareData.getString("CONTACT_SEX"));	//������_�Ա�
				data.add("CONTACT_CARD", welfareData.getString("CONTACT_CARD"));//������_���֤��
				data.add("CONTACT_JOB", welfareData.getString("CONTACT_JOB"));	//������_ְ��
				data.add("CONTACT_TEL", welfareData.getString("CONTACT_TEL"));	//������_��ϵ�绰
				data.add("CONTACT_MAIL", welfareData.getString("CONTACT_MAIL"));//������_����
				data.add("CONTACT_DESC", welfareData.getString("CONTACT_DESC"));	//������_��ע
				data.add("STATE", welfareData.getString("STATE"));//����״̬
				data.add("PAUSE_USERNAME", welfareData.getString("PAUSE_USERNAME"));		//��ͣ������
				data.add("PAUSE_DATE", welfareData.getString("PAUSE_DATE"));	//��ͣ����
				data.add("CANCLE_USERNAME", welfareData.getString("CANCLE_USERNAME"));//����������	
				data.add("CANCLE_DATE", welfareData.getString("CANCLE_DATE"));	//��������
				data.add("REG_USERNAME", welfareData.getString("REG_USERNAME"));	//�Ǽ�������	
				data.add("REG_DATE", welfareData.getString("REG_DATE"));	//�Ǽ�����
				data.add("MODIFY_USERNAME", welfareData.getString("MODIFY_USERNAME"));//����޸�������
				data.add("MODIFY_DATE", welfareData.getString("MODIFY_DATE"));//����޸�����
			}
		} catch (DBException e) {
			log.logError("תȥ�޸ĸ�������ʱ����!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ĸ�������ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data",data);
		setAttribute("temp", temp);
		if(type.equals("modif")){
			return "modif";
		}else if(type.equals("detail")){
			return "detail";
		}
		return retValue;
	}
	
	//����Ը���������Ϣ���޸�
	public String welfareModifySubmit(){
		String ID = getParameter("pro_code","");  //ʡ��
		String type=getParameter("type","");
		String IDS = getParameter("ID","");
		Map mkr = getDataWithPrefix("MKR_", false);  //���������޸���Ϣ
		Data mkrData = new Data(mkr);
		String REG_USERNAME = SessionInfo.getCurUser().getPerson().getCName();
		String REG_USERID = SessionInfo.getCurUser().getPerson().getPersonId(); 
		String curDate = DateUtility.getCurrentDate();  //ϵͳʱ��
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("IIM_ORG_INFO");
			mkrData.setPrimaryKey("INSTIT_ID");
			if(mkrData.getString("INSTIT_ID") != null && !"".equals(mkrData.getString("INSTIT_ID")) && !"null".equalsIgnoreCase(mkrData.getString("INSTIT_ID"))){
				mkrData.remove("ID");
				//����޸���Ϣ
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);  
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("INSTIT_ID", mkrData.getString("ID"));
				mkrData.remove("ID");
				mkrData.add("STATE","1");  //״̬��0������ 1����Ч 9����ͣ
				//�Ǽ�����Ϣ
				mkrData.add("REG_USERNAME", REG_USERNAME);//�Ǽ���
				mkrData.add("REG_USERID", REG_USERID);//�Ǽ�ID
				mkrData.add("REG_DATE",curDate);//�Ǽ�ʱ��
				//����޸���Ϣ
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.add(conn, mkrData);
			}
			setAttribute("pro_code", ID);
			setAttribute("type", type);
			setAttribute("ID", IDS);
			dt.commit();
		} catch (Exception e) {
			log.logError("תȥ�޸ĸ�������ʱ����!", e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("תȥ�޸ĸ�������ʱ��������ع�!", e);
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ĸ�������ʱ�ر�Connection����!", e);
			}
		}
		return retValue;
	}
	
	//ɾ������������Ϣ
	public String toWelfareDel(){
		String pro_code = getParameter("pro_code","");//ʡ��
		//1.��ȡҪɾ����Ϣ��ID
		String ID = getParameter("INSTER_ID","");
		try {
			//2.��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.ɾ������
			Data welfareData = new Data();
			welfareData.setEntityName("IIM_ORG_INFO");
			welfareData.setPrimaryKey("INSTIT_ID");   //������������ID
			welfareData.add("INSTIT_ID", ID);
			handler.delete(conn,welfareData);
			dt.commit();
		} catch (Exception e) {
			//4.�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ɾ���������������쳣");
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
		}finally{
		//5.�ر����ݿ�����
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
           }
		}
		setAttribute("pro_code", pro_code);
		return retValue;
	}
	
	//������֯�������Ҹ�������
	public String findWelfareByOrgan(){
		// 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //����������֯ID����
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        //String id = getParameter("ID","");   //������֯ID
		UserInfo userInfo = SessionInfo.getCurUser();
		String id = userInfo.getCurOrgan().getOrgCode();
        if(id == null || "".equals(id) || "null".equalsIgnoreCase(id)){
        	id = (String)getAttribute("ID");
        }
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            String code = null;
            //����ʡ��ID���Ҹ���Ժ��Ϣ
            if(id != null && !"".equals(id) && !"null".equalsIgnoreCase(id)){
            	code = id.substring(0, 2);
            }
            dataList = handler.findWelfareList(conn ,code, pageSize, page,orderString);
        } catch (Exception e) {
            log.logError("��ѯ���ò���������ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("�ڲ�ѯ���ò���������ʱ�ر�Connection����!", e);
            }
        }
        //��������list����
        setAttribute("dataList", dataList);
        setAttribute("ID", id);
        return retValue;
	}
	
	/**
	 * �û��޸���֯����  
	 * ����Ժ
	 * @return
	 */
	public String toModifWelfareById(){
		Data organData = new Data();
		UserInfo userInfo = SessionInfo.getCurUser();
		String ID = userInfo.getCurOrgan().getId();   //��֯����ID
		try {
			conn=ConnectionManager.getConnection();
			organData = handler.findWelfareById(conn, ID);
		} catch (DBException e) {
			e.printStackTrace();
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ĸ�������ʱ�ر�Connection����!", e);
			}
		}
		String org_code = organData.getString("ORG_CODE");  //��������
		String province_id = organData.getString("PROVINCE_ID");  //ʡ�ݴ���
		 if(province_id == null || "".equals(province_id) || "null".equalsIgnoreCase(province_id)){
			 organData.remove("PROVINCE_ID");
			 province_id = org_code.substring(0, 2)+"0000";
			 organData.add("PROVINCE_ID", province_id);
		 }
		setAttribute("data",organData);
		return retValue;
	}
	
	/**
	 * ����Ժ
	 * �����û��޸�����
	 * @return
	 */
	public String WelfareByIdSubmit(){
		Map mkr = getDataWithPrefix("MKR_", false);  //���������޸���Ϣ
		Data mkrData = new Data(mkr);
		String REG_USERNAME = SessionInfo.getCurUser().getPerson().getCName();
		String REG_USERID = SessionInfo.getCurUser().getPerson().getPersonId(); 
		String curDate = DateUtility.getCurrentDate();  //ϵͳʱ��
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("IIM_ORG_INFO");
			mkrData.setPrimaryKey("INSTIT_ID");
			if(mkrData.getString("INSTIT_ID") != null && !"".equals(mkrData.getString("INSTIT_ID")) && !"null".equalsIgnoreCase(mkrData.getString("INSTIT_ID"))){
				mkrData.remove("ID");
				//����޸���Ϣ
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);  
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("INSTIT_ID", mkrData.getString("ID"));
				mkrData.remove("ID");
				mkrData.add("STATE","1");  //״̬��0������ 1����Ч 9����ͣ
				//�Ǽ�����Ϣ
				mkrData.add("REG_USERNAME", REG_USERNAME);//�Ǽ���
				mkrData.add("REG_USERID", REG_USERID);//�Ǽ�ID
				mkrData.add("REG_DATE",curDate);//�Ǽ�ʱ��
				//����޸���Ϣ
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.add(conn, mkrData);
			}
			dt.commit();
		} catch (Exception e) {
			log.logError("תȥ�޸ĸ�������ʱ����!", e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("תȥ�޸ĸ�������ʱ��������ع�!", e);
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ĸ�������ʱ�ر�Connection����!", e);
			}
		}
		return SUCCESS;
	}
	
	/**
	 * �û��޸���֯����  
	 * ʡ��
	 * @return
	 */
	public String toModifProvinceById(){
		Data organData = new Data();
		UserInfo userInfo = SessionInfo.getCurUser();
		String ID = userInfo.getCurOrgan().getId();   //��֯����ID
		try {
			conn=ConnectionManager.getConnection();
			organData = handler.findWelfareById(conn, ID);
		} catch (DBException e) {
			e.printStackTrace();
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ĸ�������ʱ�ر�Connection����!", e);
			}
		}
		String org_code = organData.getString("ORG_CODE");  //��������
		String province_id = organData.getString("PROVINCE_ID");  //ʡ�ݴ���
		 if(province_id == null || "".equals(province_id) || "null".equalsIgnoreCase(province_id)){
			 organData.remove("PROVINCE_ID");
			 province_id = org_code.substring(0, 2)+"0000";
			 organData.add("PROVINCE_ID", province_id);
		 }
		setAttribute("data",organData);
		return retValue;
	}
	
	/**
	 * ʡ��
	 * �����û��޸�����
	 * @return
	 */
	public String PrivinceByIdSubmit(){
		Map mkr = getDataWithPrefix("MKR_", false);  //���������޸���Ϣ
		Data mkrData = new Data(mkr);
		String REG_USERNAME = SessionInfo.getCurUser().getPerson().getCName();
		String REG_USERID = SessionInfo.getCurUser().getPerson().getPersonId(); 
		String curDate = DateUtility.getCurrentDate();  //ϵͳʱ��
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("IIM_ORG_INFO");
			mkrData.setPrimaryKey("INSTIT_ID");
			if(mkrData.getString("INSTIT_ID") != null && !"".equals(mkrData.getString("INSTIT_ID")) && !"null".equalsIgnoreCase(mkrData.getString("INSTIT_ID"))){
				mkrData.remove("ID");
				//����޸���Ϣ
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);  
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("INSTIT_ID", mkrData.getString("ID"));
				mkrData.remove("ID");
				mkrData.add("STATE","1");  //״̬��0������ 1����Ч 9����ͣ
				//�Ǽ�����Ϣ
				mkrData.add("REG_USERNAME", REG_USERNAME);//�Ǽ���
				mkrData.add("REG_USERID", REG_USERID);//�Ǽ�ID
				mkrData.add("REG_DATE",curDate);//�Ǽ�ʱ��
				//����޸���Ϣ
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.add(conn, mkrData);
			}
			dt.commit();
		} catch (Exception e) {
			log.logError("תȥ�޸ĸ�������ʱ����!", e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("תȥ�޸ĸ�������ʱ��������ع�!", e);
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸ĸ�������ʱ�ر�Connection����!", e);
			}
		}
		return SUCCESS;
	}
	
	
	@Override
	public String execute() throws Exception {
		return null;
	}
}
