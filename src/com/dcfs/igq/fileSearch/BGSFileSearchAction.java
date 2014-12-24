/**   
 * @Title: BGSFileSearchAction.java 
 * @Package com.dcfs.igq.fileSearch 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author panfeng   
 * @date 2014-9-17 ����10:59:29 
 * @version V1.0   
 */
package com.dcfs.igq.fileSearch;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;

import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;


/** 
 * @ClassName: BGSFileSearchAction 
 * @Description: �ļ���ѯ�б��鿴������
 * @author panfeng 
 * @date 2014-9-17
 *  
 */
public class BGSFileSearchAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(BGSFileSearchAction.class);

    private BGSFileSearchHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private String retValue = SUCCESS;
    
    public BGSFileSearchAction(){
        this.handler=new BGSFileSearchHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * @Title: BGSFileList 
	 * @Description: �칫�ҡ����ò�������������֮���ļ���ѯ�б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String BGSFileList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="FILE_NO";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
				"COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","NAME",
				"AF_POSITION","AF_GLOBAL_STATE","FAMILY_TYPE","PROVINCE_ID","WELFARE_ID");
		String MALE_NAME = data.getString("MALE_NAME");
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
			//5 ��ȡ����DataList
			DataList dl=handler.BGSFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���ѯ�����쳣");
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
	 * @Title: SHBFileList 
	 * @Description: ��˲��ļ���ѯ�б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String SHBFileList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="FAI.REG_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","FILE_NO","FILE_TYPE","REGISTER_DATE_START","REGISTER_DATE_END",
					"MALE_NAME","MALE_NATION","MALE_BIRTHDAY_START","MALE_BIRTHDAY_END","FEMALE_NAME","FEMALE_NATION",
					"FEMALE_BIRTHDAY_START","FEMALE_BIRTHDAY_END","COUNTRY_CODE","ADOPT_ORG_ID","FAMILY_TYPE","IS_CONVENTION_ADOPT");
		String MALE_NAME = data.getString("MALE_NAME");
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
			//5 ��ȡ����DataList
			DataList dl=handler.SHBFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���ѯ�����쳣");
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
	 * @Title: showFileData 
	 * @Description: �鿴�ļ���ϸ��Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String showFileData(){
		//��ȡ�ļ�id
		String file_id = getParameter("showuuid");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//�����ļ�id(file_id)��ȡ���ļ�����ϸ��Ϣ
			Data data = handler.getFileData(conn,file_id);
			
			//���ݶ�ͯ����id��ȡ��ͯ��Ϣ
			String ci_id = data.getString("CI_ID","");
			if(!"".equals(ci_id)){
				DataList dataList = handler.getChildDataList(conn, ci_id);
				setAttribute("List", dataList);
			}
			
			String file_type = data.getString("FILE_TYPE");	//�ļ�����
			String family_type = data.getString("FAMILY_TYPE");	//��������
			//�����ļ�����(file_type)����������(family_type)ȷ�����ص�ҳ��
			if("33".equals(file_type)){
				retValue = "step";	//���ؼ���Ů�����鿴ҳ��
			}else{
				if("1".equals(family_type)){
					retValue = "double";	//����˫�������鿴ҳ��
				}else{
					retValue = "single";	//���ص��������鿴ҳ��
					String male_name = data.getString("MALE_NAME","");
					String female_name = data.getString("FEMALE_NAME","");
					if(male_name.equals("")){
						setAttribute("maleFlag", "false");
					}else{
						setAttribute("maleFlag", "true");
					}
					if(female_name.equals("")){
						setAttribute("femaleFlag", "false");
					}else{
						setAttribute("femaleFlag", "true");
					}
				}
			}
			
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID",""));
			setAttribute("CI_ID", ci_id);
			setAttribute("data", data);
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡ�ļ���ϸ��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡ�ļ���ϸ��Ϣ�����쳣:" + e.getMessage(),e);
			}
		}finally {
			// �ر����ݿ�����
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
	 * @Title: showSHBData 
	 * @Description: �鿴�ļ���ϸ��Ϣ����˲���
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String showSHBData(){
		//��ȡ�ļ�id
		String file_id = getParameter("showuuid");
		String ri_id = getParameter("ri_id");
		if("null".equals(ri_id)){
			ri_id = "";
		}
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//�����ļ�id(file_id)��ȡ���ļ�����ϸ��Ϣ
			Data data = handler.getFileData(conn,file_id);
			if(!"".equals(ri_id)){
				//����Ԥ��id(ri_id)��ȡ���ļ���Ԥ��������Ϣ
				DataList riList = handler.getPreList(conn, ri_id);
				setAttribute("riList", riList);
			}
			
			//���ݶ�ͯ����id��ȡ��ͯ��Ϣ
			String ci_id = data.getString("CI_ID","");
			if(!"".equals(ci_id)){
				DataList dataList = handler.getChildDataList(conn, ci_id);
				setAttribute("List", dataList);
			}
			
			String file_type = data.getString("FILE_TYPE");	//�ļ�����
			String family_type = data.getString("FAMILY_TYPE");	//��������
			//�����ļ�����(file_type)����������(family_type)ȷ�����ص�ҳ��
			if("33".equals(file_type)){
				retValue = "step";	//���ؼ���Ů�����鿴ҳ��
			}else{
				if("1".equals(family_type)){
					retValue = "double";	//����˫�������鿴ҳ��
				}else{
					retValue = "single";	//���ص��������鿴ҳ��
					String male_name = data.getString("MALE_NAME","");
					String female_name = data.getString("FEMALE_NAME","");
					if(male_name.equals("")){
						setAttribute("maleFlag", "false");
					}else{
						setAttribute("maleFlag", "true");
					}
					if(female_name.equals("")){
						setAttribute("femaleFlag", "false");
					}else{
						setAttribute("femaleFlag", "true");
					}
				}
			}
			
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID",""));
			setAttribute("CI_ID", ci_id);
			setAttribute("RI_ID", ri_id);
			setAttribute("data", data);
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡ�ļ���ϸ��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡ�ļ���ϸ��Ϣ�����쳣:" + e.getMessage(),e);
			}
		}finally {
			// �ر����ݿ�����
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
	
	
}
