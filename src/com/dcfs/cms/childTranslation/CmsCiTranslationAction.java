 /**
 * @Title: CmsCiTranslationAction.java
 * @Package com.dcfs.cms
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author xxx   
 * @project DCFS 
 * @date 2014-10-16 16:20:27
 * @version V1.0   
 */
package com.dcfs.cms.childTranslation;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;

import hx.common.Exception.DBException;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

/**
 * @Title: CmsCiTranslationAction.java
 * @Description:��ͯ���Ϸ���
 * @Created on 2014-10-16 16:20:27
 * @author wangzheng
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class CmsCiTranslationAction extends BaseAction{

	private static Log log = UtilLog.getLog(CmsCiTranslationAction.class);

    private CmsCiTranslationHandler handler;
	
	private Connection conn = null;//���ݿ�����
	
	private DBTransaction dt = null;//������
	
	private String retValue = SUCCESS;

    public CmsCiTranslationAction(){
        this.handler=new CmsCiTranslationHandler();
    } 
    
    public String execute() throws Exception {
        return null;
    }

    /**
     * ���淭���¼
	 * @author wangzheng
	 * @date 2014-10-16 16:20:27
     * @return
     */
    public String save(){
	    //1 ���ҳ������ݣ��������ݽ����
    	//1.1��ö�ͯ������Ϣ
        Data cdata = getRequestEntityData("P_",
        		"CI_ID",
        		"PROVINCE_ID",
        		"WELFARE_ID",
        		"NAME",
        		"NAME_PINYIN",
        		"SEX",
        		"BIRTHDAY",
        		"CHECKUP_DATE",
        		"ID_CARD",
        		"CHILD_IDENTITY",
        		"SENDER",
        		"SENDER_ADDR",
        		"PICKUP_DATE",
        		"ENTER_DATE",
        		"SEND_DATE",
        		"IS_ANNOUNCEMENT",
        		"ANNOUNCEMENT_DATE",
        		"NEWS_NAME",
        		"SN_TYPE",
        		"IS_HOPE",
        		"IS_PLAN",
        		"DISEASE_CN",
        		"DISEASE_EN",
        		"REMARKS",
        		"FILE_CODE",
        		"FILE_CODE_EN",
        		"CHILD_TYPE"); 
        
        //1.2��ò��Ϸ����¼        
        Data tdata = getRequestEntityData("T_","CT_ID","TRANSLATION_DESC","TRANSLATION_STATE");
        
      //��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();		
		Organ organ = curuser.getCurOrgan();
		//���ñ���󷵻�ҳ�����
		retValue="CHILD_TRANSLATION_SAVE";
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //3 ִ�����ݿ⴦�����
            //3.1��ͯ���ϱ���
            ChildManagerHandler chandler = new ChildManagerHandler();    
            //���¶�ͯ������Ϣ����ķ���״̬
            cdata.put("TRANSLATION_STATE", tdata.getString("TRANSLATION_STATE"));
            chandler.save(conn, cdata);
           
           //3.2�����¼����
           //�жϷ����ύ
            //���뵥λID
            tdata.add("TRANSLATION_UNIT", organ.getId());
            //���뵥λ����
            tdata.add("TRANSLATION_UNITNAME", organ.getCName());
           //������ID
       		tdata.add("TRANSLATION_USERID", curuser.getPersonId());
       		//����������		
       		tdata.add("TRANSLATION_USERNAME", curuser.getPerson().getCName());
       		//����״̬
       		tdata.add("TRANSLATION_STATE", tdata.getString("TRANSLATION_STATE"));
            //�����������
       		if(ChildInfoConstants.TRANSLATION_STATE_DONE.equals(tdata.getString("TRANSLATION_STATE"))){//������ɣ��ύ
       			tdata.add("COMPLETE_DATE", DateUtility.getCurrentDate());
       			retValue="CHILD_TRANSLATION_SUBMIT";
       		}
       		//�����¼����
            handler.save(conn, tdata);
                    
            //3.3�������Ͻ��Ӽ�¼
		 	DataList dl = new DataList();
		 	Data dataTransfer =new Data();
     		dataTransfer.put("APP_ID",cdata.getString("CI_ID"));
     		dataTransfer.put("TRANSFER_CODE", TransferCode.CHILDINFO_FYGS_AZB);
     		dataTransfer.put("TRANSFER_STATE","0");
     		dl.add(dataTransfer);
     		FileCommonManager fm = new FileCommonManager();
     		fm.transferDetailInit(conn, dl);
		           
	        InfoClueTo clueTo = new InfoClueTo(0, "�����¼�ύ�ɹ�!");//����ɹ� 0
	        setAttribute("clueTo", clueTo);
	        //���淭���¼�������籣���򷵻ط������ҳ��
	        setAttribute("UUID",tdata.getString("CT_ID"));	        
	       //��������
    		AttHelper.publishAttsOfPackageId(cdata.getString("FILE_CODE"),"CI");    		
    		AttHelper.publishAttsOfPackageId(cdata.getString("FILE_CODE_EN"),"CI");
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
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
                        log.logError("CmsCiTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }        
        return retValue;
    }

    /**
     * ��ͯ���Ϸ����б�
	 * @author wangzheng
	 * @date 2014-10-16 16:20:27
     * @return
     */
    public String findList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="TRANSLATION_STATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}	
        //3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������		 
		  
        Data data = getRequestEntityData("S_",
        		"PROVINCE_ID",
        		"WELFARE_ID",
        		"CHILD_NO",
        		"NAME",
        		"SEX",
        		"CHILD_TYPE",
        		"SPECIAL_FOCUS",
        		"NOTICE_DATE_START",
        		"NOTICE_DATE_END",
        		"COMPLETE_DATE_START",
        		"COMPLETE_DATE_END",
        		"TRANSLATION_STATE");
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
		    //7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ�����б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ͯ�����ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
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
                        log.logError("CmsCiTranslationAction��Connection������쳣��δ�ܹر�",e);
                    }
					retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     *���Ϸ����¼
	 * @author wangzheng
	 * @date 2014-10-16 16:20:27
     * @return
     */
    public String translation(){
     String uuid = getParameter("UUID","");
     if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
      try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            setAttribute("data", showdata);
            
            DataList attType = new DataList();
            ChildCommonManager ccm = new ChildCommonManager();
            BatchAttManager bm = new BatchAttManager();
            attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false));
		    String xmlstr = bm.getUploadParameter(attType);
            setAttribute("uploadParameter",xmlstr);  
      
        } catch (Exception e) {
			e.printStackTrace();
			retValue = "error";
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
                }
            }
        }        
        return retValue;        
    }  
    
    /**
     *���Ϸ���鿴
	 * @author wangzheng
	 * @date 2014-10-20
     * @return
     */
    public String show(){
     String uuid = getParameter("UUID");
     if("".equals(uuid)){
			uuid = (String)getAttribute("UUID");
		}
      try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            setAttribute("data", showdata);
        } catch (DBException e) {
            e.printStackTrace();
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                    	retValue="error";
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }        
        return retValue;        
    }  
   
}