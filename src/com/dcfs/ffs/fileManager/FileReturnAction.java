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
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: FileReturnAction 
 * @Description: ��������֯���ļ���Ϣ���в�ѯ���������롢��������
 * @author panfeng;
 * @date 2014-9-2 ����3:01:44 
 *
 */
public class FileReturnAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(FileReturnAction.class);

    private FileReturnHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;

    public FileReturnAction(){
        this.handler=new FileReturnHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: ReturnFileList 
	 * @Description: ������Ϣ�б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String ReturnFileList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="APPLE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","APPLE_DATE_START","APPLE_DATE_END","FILE_TYPE","DUAL_USERNAME","DUAL_DATE_START","DUAL_DATE_END","RETURN_STATE","HANDLE_TYPE");
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
			//5 ��ȡ����DataList
			DataList dl=handler.ReturnFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("������Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("FileReturnAction��ReturnFileList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: ReturnApplyList 
	 * @Description: ���������б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String ReturnApplyList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","MALE_NAME","FEMALE_NAME","FILE_TYPE","PAUSE_DATE_START","PAUSE_DATE_END","RECOVERY_STATE");
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
			//5 ��ȡ����DataList
			DataList dl=handler.ReturnApplyList(conn,data,pageSize,page,compositor,ordertype);
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
				log.logError("���������ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("FileReturnAction��ReturnApplyList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * ��ת����������ȷ��ҳ��
	 * @author Panfeng
	 * @date 2014-9-2 
	 * @return
	 */
	public String confirmShow(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("showuuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.confirmShow(conn, uuid);
			
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDateTime();
			showdata.add("HANDLE_TYPE","");
			showdata.add("RETURN_REASON","");
			showdata.add("APPLE_PERSON_ID",curId);//������ID
			showdata.add("APPLE_PERSON_NAME",curPerson);//������
			showdata.add("APPLE_DATE",curDate);//��������
			//4 ��������鿴ҳ��
			setAttribute("confirmData", showdata);
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
		return SUCCESS;
	}
	
	
	/**
	 * @Title: ReturnFileSave 
	 * @Description: ��������ȷ���ύ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String ReturnFileSave(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","AR_ID","AF_ID","FILE_NO","REGISTER_DATE","FILE_TYPE",
        			"COUNTRY_CODE","ADOPT_ORG_ID","FAMILY_TYPE","MALE_NAME","FEMALE_NAME",
        			"APPLE_PERSON_ID","APPLE_PERSON_NAME","APPLE_DATE","HANDLE_TYPE","RETURN_REASON");
        Data fileData = new Data();
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            fileData.add("AF_ID", (String)data.get("AF_ID"));
            fileData.add("RETURN_REASON", (String)data.get("RETURN_REASON"));//����ԭ��
            fileData.add("RETURN_STATE", "0");//����״̬Ϊ"��ȷ��"(�ļ���Ϣ��)
            data.add("RETURN_STATE","0");//����״̬Ϊ"��ȷ��"�����ļ�¼��
            data.add("APPLE_TYPE","1");//��������Ϊ"���������˳�����"�����ļ�¼��
            success=handler.ReturnFileSave(conn,data,fileData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");//�ύ�ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ύ���������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�ύ�����쳣[�ύ����]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
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
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");//����ʧ�� 2
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
                        log.logError("FileReturnAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	
	/**
	 * @Title: ReturnFileExport 
	 * @Description: ������Ϣ��������
	 * @author: panfeng
	 * @return String null
	 * @throws
	 */
//	public String ReturnFileExport(){
//		//1  ��ȡҳ�������ֶ�����
//		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","APPLE_DATE_START","APPLE_DATE_END","FILE_TYPE","DUAL_USERNAME","DUAL_DATE_START","DUAL_DATE_END","RETURN_STATE","HANDLE_TYPE");
//		String MALE_NAME = data.getString("MALE_NAME",null);	//��������
//		if(MALE_NAME != null){
//			MALE_NAME = MALE_NAME.toUpperCase();
//		}
//		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//Ů������
//		if(FEMALE_NAME != null){
//			FEMALE_NAME = FEMALE_NAME.toUpperCase();
//		}
//		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
//		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
//		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
//		String APPLE_DATE_START = data.getString("APPLE_DATE_START", null);	//���뿪ʼ����
//		String APPLE_DATE_END = data.getString("APPLE_DATE_END", null);	//�����������
//		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
//		String DUAL_USERNAME = data.getString("DUAL_USERNAME", null);	//������
//		String DUAL_DATE_START = data.getString("DUAL_DATE_START", null);	//������ʼ����
//		String DUAL_DATE_END = data.getString("DUAL_DATE_END", null);	//���ý�ֹ����
//		String RETURN_STATE = data.getString("RETURN_STATE", null);	//����״̬
//		String HANDLE_TYPE = data.getString("HANDLE_TYPE", null);	//���Ĵ��÷�ʽ
//		
//		try {
//			//2���õ����ļ�����
//			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("������Ϣ.xls".getBytes(), "iso8859-1"));
//    		this.getResponse().setContentType("application/xls");
//    		//3��������ֶ� 
//    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
//			Map<String, CodeList> codes = UtilCode.getCodeLists("WJLX","TWCZFS_SYZZ");
//    		//�ļ����ʹ���
//			CodeList scList=codes.get("WJLX");
//    		Map<String,String> filetype=new HashMap<String,String>();
//    		for(int i=0;i<scList.size();i++){
//    			Code c=scList.get(i);
//    			filetype.put(c.getValue(),c.getName());
//    		}
//    		dict.put("FILE_TYPE", filetype);
//    		//���Ĵ��÷�ʽ����
//    		CodeList czList=codes.get("TWCZFS_SYZZ");
//    		Map<String,String> handletype=new HashMap<String,String>();
//    		for(int i=0;i<czList.size();i++){
//    			Code c=czList.get(i);
//    			handletype.put(c.getValue(),c.getName());
//    		}
//    		dict.put("HANDLE_TYPE", handletype);
//    		//����״̬����
//			Map<String,String> state = new HashMap<String,String>();
//			state.put("0", "��ȷ��");
//			state.put("1", "��ȷ��");
//    		//4 ִ���ļ�����
//			ExcelExporter.export2Stream("������Ϣ", "SuppleFile", dict, this.getResponse().getOutputStream(),
//					MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, DUAL_USERNAME, DUAL_DATE_START, DUAL_DATE_END, RETURN_STATE, HANDLE_TYPE);
//			this.getResponse().getOutputStream().flush();
//		} catch (Exception e) {
//			//5  �����쳣����
//			log.logError("����������Ϣ�����쳣", e);
//			setAttribute(Constants.ERROR_MSG_TITLE, "����������Ϣ�����쳣");
//			setAttribute(Constants.ERROR_MSG, e);
//		}
//		//6 ҳ�治������ת������NULL ������ת����������ֵ
//		return null;
//	}
	
}
