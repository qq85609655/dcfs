/**   
 * @Title: SuppleQueryAction.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: �����ѯ����
 * @author yangrt   
 * @date 2014-9-5 ����10:53:12 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.ModifyHistoryConfig;

/** 
 * @ClassName: SuppleQueryAction 
 * @Description: �����ѯ����
 * @author yangrt;
 * @date 2014-9-5 ����10:53:12 
 *  
 */
public class SuppleQueryAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(SuppleQueryAction.class);
	
	private SuppleQueryHandler handler = null;
	
	private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
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
	
	public SuppleQueryAction(){
		this.handler = new SuppleQueryHandler();
	}
	
	/**
	 * @Title: SuppleQueryList 
	 * @Description: ��˲������ѯ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String SuppleQueryList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AA_STATUS";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FILE_TYPE","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
		String MALE_NAME = data.getString("MALE_NAME",null);
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//������Դ����˲���OperType��SHB
			String OperType = getParameter("type",""); 
			if("".equals(OperType)){
				OperType = (String) getAttribute("type");
			}
			//5 ��ȡ����DataList
			DataList dl=handler.SuppleQueryList(conn,data,OperType,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��˲������ļ���ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��˲������ļ���ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("SuppleQueryAction��SuppleQueryList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: SuppleQueryShow 
	 * @Description: ������ϸ�鿴ҳ��
	 * @author: yangrt
	 * @return String 
	 */
	public String SuppleQueryShow(){
		String flag = getParameter("Flag","");
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AA_STATUS";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//��ȡ�ļ������¼ID
		String aa_id = getParameter("AA_ID");
		try {
			conn = ConnectionManager.getConnection();
			//�����ļ������¼ID,��ȡ�ļ�������ϢData
			Data aadata = handler.getSuppleData(conn, aa_id);
			//�ļ�id
			String af_id = aadata.getString("AF_ID");
			//�����ļ�id����ȡ�ļ��޸���ʷ��¼
			DataList reviseList = handler.getReviseList(conn,af_id,pageSize,page,compositor,ordertype);
			if(reviseList.size()>0){
	            for(int i=0;i<reviseList.size();i++){
	                Data data=reviseList.getData(i);
	                String colName=data.getString("UPDATE_FIELD");
	                data.add("UPDATE_FIELD",ModifyHistoryConfig.getShowstring(colName,"filemodifyhistory-config"));
	            }
		    }
			
			setAttribute("List", reviseList);
			setAttribute("data", aadata);
			setAttribute("AA_ID", aa_id);
			setAttribute("UPLOAD_IDS",aadata.getString("UPLOAD_IDS",aa_id));
			setAttribute("Flag", flag);
			if("suppleList".equals(flag)){
				retValue = "File";
			}else{
				retValue = "Query";
			}
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��˲�������Ϣ�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[��˲�������Ϣ�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("SuppleQueryAction��SuppleQueryShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: FileDetailShow 
	 * @Description: �ļ���ϸ��Ϣ�鿴ҳ��
	 * @author: yangrt
	 * @return String 
	 */
	public String FileDetailShow(){
		//��ȡ�ļ�ID
		String af_id = getParameter("AF_ID");
		//�����ļ�ID,��ȡ�ļ���ϢData
		Data filedata = new FileManagerAction().GetFileByID(af_id);
		setAttribute("file_type", filedata.getString("FILE_TYPE"));
		setAttribute("filedata", filedata);
		setAttribute("AF_ID", af_id);
		setAttribute("RI_ID", filedata.getString("RI_ID",""));
		setAttribute("type", getParameter("type"));
		return retValue;
	}
	
	/**
	 * @Title: GetFileDetail 
	 * @Description: ��ȡ�ļ��Ļ�����Ϣ
	 * @author: yangrt
	 * @return String  
	 */
	public String GetFileDetail(){
		//��ȡ�ļ�ID
		String af_id = getParameter("AF_ID");
		String flag = getParameter("type");
		//�����ļ�ID,��ȡ�ļ���ϢData
		Data filedata = new FileManagerAction().GetFileByID(af_id);
		String file_type = filedata.getString("FILE_TYPE","");
		String family_type = filedata.getString("FAMILY_TYPE","");
		if(file_type.equals("33")){
			retValue = "step";
		}else{
			if(family_type.equals("1")){
				retValue = "double" + flag;
			}else if(family_type.equals("2")){
				retValue = "single" + flag;
			}
		}
		setAttribute("filedata", filedata);
		setAttribute("PACKAGE_ID",filedata.getString("PACKAGE_ID", af_id));
		setAttribute("PACKAGE_ID_CN",filedata.getString("PACKAGE_ID_CN", af_id));
		setAttribute("MALE_PHOTO",filedata.getString("MALE_PHOTO",""));
		setAttribute("FEMALE_PHOTO",filedata.getString("FEMALE_PHOTO",""));
		return retValue;
	}
	
	/**
	 * @Title: GetPreApproveData 
	 * @Description: �ļ�Ԥ����˼�¼��Ϣ
	 * @author: yangrt
	 * @return String  
	 */
	public String GetPreApproveData(){
		//��ȡ�ļ�ID
		String af_id = getParameter("AF_ID");
		try {
			conn = ConnectionManager.getConnection();
			//�����ļ�ID,��ȡ�ļ���ϢData
			Data filedata = new FileManagerAction().GetFileByID(af_id);
			//��ͯ����id
			String str_ci_id = filedata.getString("CI_ID","");
			//Ԥ������ͯ��Ϣ�б�DataList
			DataList childList = handler.getChildList(conn, str_ci_id);
			
			//Ԥ�������¼id
			String ri_id = filedata.getString("RI_ID","");
			//��ȡ�ļ�Ԥ����Ϣ
			DataList preList = handler.getPreAuditList(conn, ri_id);
			setAttribute("childList", childList);
			setAttribute("preList", preList);
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��˲��ļ�Ԥ����˼�¼�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[��˲��ļ�Ԥ����˼�¼�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("SuppleQueryAction��GetPreApproveData.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
		
	}

}
