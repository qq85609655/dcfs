package com.dcfs.sce.additional;

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

/**
 * 
 * @Title: AdditionalAction.java
 * @Description: Ԥ��������Ϣ��ѯ���鿴����
 * @Company: 21softech
 * @Created on 2014-9-11 ����5:21:12 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AdditionalAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AdditionalAction.class);
    private Connection conn = null;
    private AdditionalHandler handler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public AdditionalAction() {
        this.handler=new AdditionalHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: findAddList
     * @Description: Ԥ��������Ϣ�б�
     * @author: panfeng
     * @date: 2014-9-11 ����5:21:12 
     * @return
     */
    public String findAddList(){
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
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME",
        			"PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        			"REQ_DATE_START","REQ_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FEEDBACK_DATE_START",
        			"FEEDBACK_DATE_END","AA_STATUS");
        //�з���Ů��������������ת����д
        String MALE_NAME = data.getString("MALE_NAME",null);
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		String OperType = getParameter("type","");
		if("".equals(OperType)){
			OperType = (String) getAttribute("OperFrom");
		}
		
		retValue = OperType;
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAddList(conn,data,OperType,pageSize,page,compositor,ordertype);
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
	 * @Title: additionalShow 
	 * @Description: �鿴Ԥ��������Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String additionalShow(){
		//��ȡԤ��������Ϣid
		String uuid = getParameter("showuuid");
		String ra_id = getParameter("ra_id");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//���� Ԥ��������Ϣid��ȡ��ϸ��Ϣ
			Data data = handler.getInfoData(conn,uuid);
			
			setAttribute("infodata", data);
			setAttribute("RI_ID", uuid);
			setAttribute("RA_ID", ra_id);
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡԤ�������Ҫ��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡԤ�������Ҫ��Ϣ�����쳣:" + e.getMessage(),e);
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
	 * @Title: ShowInfoDetail 
	 * @Description: ��ȡԤ��������Ϣ
	 * @author: panfeng
	 * @return String  
	 */
	public String ShowInfoDetail(){
		//��ȡԤ��������ϢID
		String uuid = getParameter("RI_ID");
		String flag = getParameter("type");
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ��������ϢID,��ȡԤ����ϸ��Ϣdata
			Data data = handler.getInfoData(conn, uuid);
			String file_type = data.getString("FILE_TYPE","");
			String family_type = data.getString("FAMILY_TYPE","");
			if(file_type.equals("33")){
				retValue = "step";
			}else{
				if(family_type.equals("1")){
					retValue = "double" + flag;
				}else if(family_type.equals("2")){
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
					retValue = "single" + flag;
				}
			}
			setAttribute("infodata", data);
			setAttribute("MALE_PHOTO",data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO",data.getString("FEMALE_PHOTO",""));
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ����ϸ��Ϣ�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[Ԥ����ϸ��Ϣ�鿴����]:" + e.getMessage(),e);
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ShowNoticeDetail 
	 * @Description: ��ȡԤ������֪ͨ��Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String ShowNoticeDetail(){
		//��ȡԤ��������Ϣid
		String uuid = getParameter("RA_ID");
		String flag = getParameter("type");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//���� Ԥ��������Ϣid��ȡ��ϸ��Ϣ
			Data data = handler.getNoticeData(conn,uuid);
			
			setAttribute("noticedata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("UPLOAD_IDS",data.getString("UPLOAD_IDS",""));
			setAttribute("UPLOAD_IDS_CN",data.getString("UPLOAD_IDS_CN",""));
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡԤ������֪ͨ��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡԤ������֪ͨ��Ϣ�����쳣:" + e.getMessage(),e);
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
		retValue = "notice" + flag;
		return retValue;
	}
	
	/**
	 * @Title: showNotice 
	 * @Description: ����֪ͨ�鿴
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String showNotice(){
		//��ȡԤ��������Ϣid
		String uuid = getParameter("showuuid");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//���� Ԥ��������Ϣid��ȡ��ϸ��Ϣ
			Data data = handler.getNoticeData(conn,uuid);
			
			setAttribute("detaildata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("UPLOAD_IDS",data.getString("UPLOAD_IDS",""));
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�鿴��Ϣ�����쳣:" + e.getMessage(),e);
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
