package com.dcfs.sce.addTranslation;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;

/**
 * 
 * @Title: AddTranslationAction.java
 * @Description: Ԥ��������Ϣ��ѯ���鿴����
 * @Company: 21softech
 * @Created on 2014-9-19 ����9:12:01 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AddTranslationAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AddTranslationAction.class);
    private Connection conn = null;
    private AddTranslationHandler handler;
    private String retValue = SUCCESS;
    
    public AddTranslationAction() {
        this.handler=new AddTranslationHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: addTranslationList
     * @Description: Ԥ��������Ϣ�б�
     * @author: panfeng
     * @date: 2014-9-19 ����9:12:01 
     * @return
     */
    public String addTranslationList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID",
        			"NAME","SEX","NOTICE_DATE_START","NOTICE_DATE_END","COMPLETE_DATE_START",
        			"COMPLETE_DATE_END","TRANSLATION_UNITNAME","TRANSLATION_STATE");
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
            DataList dl=handler.addTranslationList(conn,data,OperType,pageSize,page,compositor,ordertype);
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
	 * @Title: addTranslationShow 
	 * @Description: �鿴Ԥ��������Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String addTranslationShow(){
		//��ȡԤ��������Ϣid
		String uuid = getParameter("showuuid");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//���� Ԥ��������Ϣid��ȡ��ϸ��Ϣ
			Data showdata = handler.getShowData(conn,uuid);
			
			setAttribute("data", showdata);
			setAttribute("RI_ID", uuid);
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡԤ��������Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡԤ��������Ϣ�����쳣:" + e.getMessage(),e);
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
