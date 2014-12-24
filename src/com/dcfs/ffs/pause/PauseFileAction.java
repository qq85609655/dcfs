package com.dcfs.ffs.pause;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import com.dcfs.common.DcfsConstants;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.dcfs.ffs.fileManager.FileReturnHandler;
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: PauseFileAction 
 * @Description: �ɰ칫�Ҷ��ļ���Ϣ���в�ѯ����ͣ��ȡ����ͣ�����ġ��޸���ͣ���ޡ���������
 * @author panfeng;
 * @date 2014-9-4 ����2:03:18 
 *
 */
public class PauseFileAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(PauseFileAction.class);

    private PauseFileHandler handler;
    private FileReturnHandler fr_handler;
    private FileManagerHandler fm_handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;

    public PauseFileAction(){
        this.handler=new PauseFileHandler();
        this.fr_handler=new FileReturnHandler();
        this.fm_handler=new FileManagerHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: pauseFileList 
	 * @Description: �ļ���ͣ��Ϣ�б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String pauseFileList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="PAUSE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","PAUSE_UNITNAME",
					"MALE_NAME","FEMALE_NAME","RECOVERY_STATE","PAUSE_DATE_START","PAUSE_DATE_END","RECOVERY_DATE_START","RECOVERY_DATE_END","AF_POSITION");
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
			DataList dl=handler.pauseFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���ͣ��Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�ļ���ͣ��Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("PauseFileAction��pauseFileList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: pauseSearchList 
	 * @Description: ������֯�ļ���ͣ��Ϣ��ѯ�б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String pauseSearchList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="PAUSE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","PAUSE_UNITNAME",
				"MALE_NAME","FEMALE_NAME","RECOVERY_STATE","PAUSE_DATE_START","PAUSE_DATE_END","RECOVERY_DATE_START","RECOVERY_DATE_END","AF_POSITION");
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
			DataList dl=handler.pauseSearchList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���ͣ��Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�ļ���ͣ��Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("PauseFileAction��pauseFileList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * �ļ���������ҳ��
	 * @author Panfeng
	 * @date 2014-9-4 
	 * @return
	 */
	public String remindShow(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("AP_ID","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.confirmShow(conn, uuid);
			
			//������������
      		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      		Calendar cal = Calendar.getInstance();
      		String end_date = showdata.getString("END_DATE","");
      		cal.setTime(sdf.parse(end_date));
      		cal.add(Calendar.MONTH, -1);
      		showdata.add("REMIND_DATE", sdf.format(cal.getTime()));//��������
      		
      		//����ת��yyyy��MM��dd��
      		SimpleDateFormat cn_fmt = new SimpleDateFormat("yyyy��MM��dd��");
      		Calendar cal1 = Calendar.getInstance();
      		cal1.setTime(sdf.parse(end_date));
      		String cn_end_date = cn_fmt.format(cal1.getTime()); 
      		showdata.add("CN_END_DATE",cn_end_date);//��ͣ��������
      		Calendar cal2 = Calendar.getInstance();
      		cal2.setTime(sdf.parse(showdata.getString("REMIND_DATE","")));
      		String cn_remind_date = cn_fmt.format(cal2.getTime()); 
      		showdata.add("CN_REMIND_DATE",cn_remind_date);//���ѿ�ʼ����
      		
      		//����ת��ΪӢ�ĸ�ʽ
      		Locale l = new Locale("en");
      		Calendar cal3 = Calendar.getInstance();
      		cal3.setTime(sdf.parse(end_date));
      		String day1 = String.format("%td", cal3);
      		String month1 = String.format(l,"%tb", cal3);
    		String year1 = String.format("%tY", cal3);
      		showdata.add("EN_END_DATE",month1+" "+day1+","+year1);//��ͣ��������
      		Calendar cal4 = Calendar.getInstance();
      		cal4.setTime(sdf.parse(showdata.getString("REMIND_DATE","")));
      		String day2 = String.format("%td", cal4);
      		String month2 = String.format(l,"%tb", cal4);
      		String year2 = String.format("%tY", cal4);
      		showdata.add("EN_REMIND_DATE",month2+" "+day2+","+year2);//��ͣ��������
      		
			//4 ��������ҳ��
      		setAttribute("male_name", showdata.getString("MALE_NAME",""));
			setAttribute("female_name", showdata.getString("FEMALE_NAME",""));
			setAttribute("remindData", showdata);
		} catch (DBException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
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
	 * @Title: pauseChoiceList 
	 * @Description: ��ͣ�ļ�ѡ���б�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String pauseChoiceList(){
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
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
					"COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","NAME",
					"AF_POSITION","AF_GLOBAL_STATE");
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
			DataList dl=handler.pauseChoiceList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�ļ���Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("PauseFileAction��pauseChoiceList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * ��ת���ļ���ͣȷ��ҳ��
	 * @author Panfeng
	 * @date 2014-9-4 
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
			String curUnitId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
			String curUnitName = SessionInfo.getCurUser().getCurOrgan().getCName();
			String curDate = DateUtility.getCurrentDate();
			showdata.add("PAUSE_USERID",curId);//��ͣ��ID
			showdata.add("PAUSE_USERNAME",curPerson);//��ͣ��
			showdata.add("PAUSE_UNITID", curUnitId);//��ͣ����ID
			showdata.add("PAUSE_UNITNAME",curUnitName);//��ͣ����
			showdata.add("PAUSE_DATE",curDate);//��ͣ����
			showdata.add("PAUSE_REASON","");//��ͣԭ��
			
			//������ͣ����
      		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      		Calendar cal = Calendar.getInstance();
      		cal.add(Calendar.MONTH, +6);
      		cal.add(Calendar.DATE, -1);
      		showdata.add("END_DATE", sdf.format(cal.getTime()));
      		
			//4 ��������ҳ��
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
	 * @Title: pauseFileSave 
	 * @Description: �ļ���ͣȷ���ύ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String pauseFileSave(){
	    //1 ���ҳ������ݣ��������ݽ����
		Data fileData = new Data();
        Data pauseData = getRequestEntityData("R_","AP_ID","AF_ID","PAUSE_UNITID","PAUSE_UNITNAME",
        			"PAUSE_USERID","PAUSE_USERNAME","PAUSE_DATE","END_DATE","PAUSE_REASON");
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
      		
            fileData.add("AF_ID", (String)pauseData.get("AF_ID"));
            fileData.add("IS_PAUSE", "1");//��ͣ��ʶΪ"y"
            fileData.add("PAUSE_DATE", (String)pauseData.get("PAUSE_DATE"));//��ͣʱ��
            fileData.add("PAUSE_REASON", (String)pauseData.get("PAUSE_REASON"));//��ͣԭ��
            pauseData.add("RECOVERY_STATE","1");//��ͣ״̬Ϊ"����ͣ"
            success=handler.pauseFileSave(conn,fileData,pauseData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");//�ύ�ɹ� 0
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
                        log.logError("PauseFileAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * @Title: fileInfoShow 
	 * @Description: ��ͣѡ���ļ�ʱ�鿴��ϸ��Ϣ����
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String fileInfoShow(){
		//��ȡ�ļ�id
		String file_id = getParameter("showuuid");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//�����ļ�id(file_id)��ȡ���ļ�����ϸ��Ϣ
			Data data = fm_handler.GetFileByID(conn,file_id);
			
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
				}
			}
			
			setAttribute("data", data);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
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
	 * @Title: fileRecovery 
	 * @Description: �ļ�ȡ����ͣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String fileRecovery() {
		//1 ��ȡҪȡ����ͣ���ļ�ID
		String fileuuid = getParameter("fileuuid", "");
		String recuuid = getParameter("recuuid", "");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			
			success = handler.fileRecovery(conn, fileuuid, recuuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "ȡ����ͣ�ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ȡ����ͣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[ȡ����ͣ����]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ȡ����ͣ����ʧ��!");
            setAttribute("clueTo", clueTo);
            
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
                        log.logError("PauseFileAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * ��ת������ȷ��ҳ��
	 * @author Panfeng
	 * @date 2014-9-4 
	 * @return
	 */
	public String returnFileShow(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("showuuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = fr_handler.confirmShow(conn, uuid);
			
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
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
	 * @Title: returnFileSave 
	 * @Description: ����ȷ���ύ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String returnFileSave(){
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
            data.add("APPLE_TYPE","5");//��������Ϊ"��ͣ��ʱ�˳�����"�����ļ�¼��
            success=fr_handler.ReturnFileSave(conn,data,fileData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "�����ύ�ɹ�!");//�ύ�ɹ� 0
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
	 * ���޸���ͣ����ҳ��
	 * @author Panfeng
	 * @date 2014-9-4 
	 * @return
	 */
	public String modDeadline(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("showuuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.confirmShow(conn, uuid);
			
			//4 ��������ҳ��
			setAttribute("modData", showdata);
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
	 * @Title: reviseDeadline 
	 * @Description: �޸���ͣ����
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String reviseDeadline() {
		 //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","AP_ID","END_DATE");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			
			success = handler.pauseFileSave(conn, null, data);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "�޸���ͣ���޳ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�޸���ͣ���޲����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[�޸���ͣ���޲���]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�޸���ͣ���޲���ʧ��!");
            setAttribute("clueTo", clueTo);
            
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
                        log.logError("PauseFileAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * �ļ���ͣ��Ϣ�鿴
	 * @author Panfeng
	 * @date 2014-12-4 
	 * @return
	 */
	public String pauseSearchShow(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("showuuid","");
		String type = getParameter("type","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.pauseSearchShow(conn, uuid);
			
			//4 ��������ҳ��
			setAttribute("data", showdata);
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
		if ("ZX".equals(type)) {
			return "ZX";
		} else if ("SYZZ".equals(type)) {
			return "SYZZ";
		} else {
			return SUCCESS;
		}
	}
	
}
