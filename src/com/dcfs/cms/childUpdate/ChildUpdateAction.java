package com.dcfs.cms.childUpdate;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
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
import java.util.HashMap;
import java.util.Map;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childAdditional.ChildAdditionAction;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildStateManager;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;

public class ChildUpdateAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(ChildAdditionAction.class);

    private ChildUpdateHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    public ChildUpdateAction(){
        this.handler=new ChildUpdateHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	 /**
	 * ����Ժ��ͯ���ϸ����б�
	 * @return
	 */
    public String updateListFLY(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="UPDATE_DATE";
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ�����������������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ�����״̬����������
 		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END");
 		
 		//��ȡ����Ժ��¼�˵ĸ���ԺId
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.updateListFLY(conn,oId,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
	 * ʡ����ͯ���ϸ����б�
	 * @return
	 */
    public String updateListST(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="UPDATE_DATE";
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ��������������Ժ���������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ�����״̬����������
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END");
 		
 		//��ȡʡ����½�˵���֯��������
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.updateListST(conn,provinceId,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("provinceId",provinceId);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
	 * ���ģ���֮�ţ���ͯ���ϸ����б�
	 * @return
	 */
    public String updateListZX(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="UPDATE_DATE";
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ����������ʡ�ݡ�����Ժ���������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ�����״̬���������ڡ�������
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END","UPDATE_USERNAME");
 		
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.updateListZX(conn,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
	 * ����Ժ��ͯ���ϸ���ѡ���б� 
	 * @return
	 */
    public String updateSelectFLY(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor",null);
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype",null);
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ�����������������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ��������ڡ���ͯ״̬��������֯
 		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","SEND_DATE_START","SEND_DATE_END","CI_GLOBAL_STATE","NAME_CN");
 		
 		//��ȡ����Ժ��¼�˵ĸ���ԺId
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList 
             DataList dl=handler.updateSelectFLY(conn,oId,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
	 * ʡ����ͯ���ϸ���ѡ���б� 
	 * @return
	 */
    public String updateSelectST(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor",null);
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype",null);
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ��������������Ժ���������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ��������ڡ���ͯ״̬��������֯
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","SEND_DATE_START","SEND_DATE_END","CI_GLOBAL_STATE","NAME_CN");
 		
 		//��ȡʡ����½�˵���֯��������
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList 
             DataList dl=handler.updateSelectST(conn,provinceId,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("provinceId",provinceId);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
	 * ���Ķ�ͯ���ϸ���ѡ���б���֮�Ű�����Ӧ�˵��еĳ��ڲ�ѯ��
	 * @return
	 */
    public String updateSelectZX(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor",null);
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype",null);
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ����������ʡ�ݡ�����Ժ���������Ա𡢳������ڡ��������ࡢ������ڡ��ر��ע�����´���������״̬��Ԥ������״̬���Ǽ�״̬
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","SPECIAL_FOCUS","UPDATE_NUM","PUB_STATE","RI_STATE","ADREG_STATE");
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList 
             DataList dl=handler.updateSelectZX(conn,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
     * ��ͯ���ϸ������ҳ��
     * @return
     */
    public String toUpdateFLY(){
    	String ci_id = getParameter("CI_ID");
    	String update_type=getParameter("UPDATE_TYPE");
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               Data showdata = handler.getChildInfoById(conn, ci_id);
               UserInfo user=SessionInfo.getCurUser();
               //���ݶ�ͯ���ϵĶ�ͯ���ͺͶ�ͯ��ݻ�ȡ�����ͯ�ĸ���smalltype
               String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
               DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
               //����ȡ���ĸ���С���codeֵ����ʾ������","ƴ�ӳ��ַ���
              	String smTypeValues="";
             	String smTypeStrs="";
              	for(int i=0;i<smallTypes.size();i++){
              		Data tmp=smallTypes.getData(i);
              		if(i!=(smallTypes.size()-1)){
              			smTypeValues+=tmp.getString("CODE")+",";
              			smTypeStrs+=tmp.getString("CNAME")+",";
              		}else{
              			smTypeValues+=tmp.getString("CODE");
              			smTypeStrs+=tmp.getString("CNAME");
              		}
              	}
               setAttribute("UPDATE_TYPE", update_type);
               setAttribute("data", showdata);
               setAttribute("pakgId", pakgId);
               setAttribute("smTypeValues", smTypeValues);
               setAttribute("smTypeStrs", smTypeStrs);
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
               return SUCCESS;
           }
    
    /**
     * ��ͯ���ϸ�����Ϣ���ҳ��
     * @return
     */
    public String toUpdateAudit(){
    	String cua_id = getParameter("CUA_ID");
    	Connection conn = null;
        DataList updateList=new DataList();
        DataList attUpdateDetail=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               //���ݸ�����˼�¼������ȡ������Ϣ����ͯ����չʾ��Ϣ
               Data showdata = handler.getShowDataByCuaId(conn, cua_id);
               UserInfo curuser = SessionInfo.getCurUser();
               showdata.add("AUDIT_USERNAME", curuser.getPerson().getCName());
               showdata.add("AUDIT_DATE", DateUtility.getCurrentDate());
               String CUI_ID=showdata.getString("CUI_ID",null);
               if(CUI_ID!=null){
            	   updateList=handler.getUpdateDetail(conn,CUI_ID,"0");
               }
             //����ϸ�б���Ϣת���ɿ�չʾ������
               for(int i=0;i<updateList.size();i++){
            	   Data detail=updateList.getData(i);
            	   showdata.add("N"+detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
               }
             //��ȡ������ϸ��Ϣ�����¸�����Ϣ��
               if(CUI_ID!=null){
                   attUpdateDetail=handler.getUpdateDetail(conn, CUI_ID,"1");
               }
               UserInfo user=SessionInfo.getCurUser();
               String smTypeUsed="";
               String smTypeUsedStr="";
               String updateTypes="";//�������� 0����1׷��
               if(attUpdateDetail.size()>0){
            	 //���ݶ�ͯ���ϵĶ�ͯ���ͺͶ�ͯ��ݻ�ȡ�����ͯ�ĸ���smalltype
                   String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
                   DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
                   //����ȡ���ĸ���С���codeֵ����ʾ������","ƴ�ӳ��ַ���
                  	String smTypeValues="";
                  	for(int i=0;i<smallTypes.size();i++){
                  		Data tmp=smallTypes.getData(i);
                  		if(i!=(smallTypes.size()-1)){
                  			smTypeValues+=tmp.getString("CODE")+",";
                  		}else{
                  			smTypeValues+=tmp.getString("CODE");
                  		}
                  	}
            	   for(int i=0;i<attUpdateDetail.size();i++){
                	   Data attDetail=attUpdateDetail.getData(i);
                	   String field=attDetail.getString("UPDATE_FIELD");
                	   if(smTypeValues.indexOf(field)!=-1){
                		   for(int j=0;j<smallTypes.size();j++){
                         		Data tmp=smallTypes.getData(j);
                         		if(tmp.getString("CODE").equals(field)){
                         			field=tmp.getString("CNAME");
                         			break;
                         		}
                         	}
                		   if(i!=(attUpdateDetail.size()-1)){
                    		   smTypeUsed+=attDetail.getString("UPDATE_FIELD")+",";
                    		   updateTypes+=attDetail.getString("UPDATE_TYPE")+",";
                    		   smTypeUsedStr+=field+",";
                    	   }else{
                    		   smTypeUsed+=attDetail.getString("UPDATE_FIELD");
                    		   updateTypes+=attDetail.getString("UPDATE_TYPE");
                    		   smTypeUsedStr+=field;
                    	   }
                	   }
                	  
                   }
            	   if(smTypeUsed.indexOf(",")!=-1&&(smTypeUsed.lastIndexOf(",")==(smTypeUsed.length()-1))){
            		   smTypeUsed=smTypeUsed.substring(0,smTypeUsed.length()-1);
            		   updateTypes=updateTypes.substring(0,updateTypes.length()-1);
            		   smTypeUsedStr=smTypeUsedStr.substring(0,smTypeUsedStr.length()-1);
            	   }
               }
              
               setAttribute("data", showdata);
               setAttribute("updateList", updateList);
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
               setAttribute("smTypeUsed", smTypeUsed);
               setAttribute("updateTypes", updateTypes);
               setAttribute("smTypeUsedStr", smTypeUsedStr);
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
                return SUCCESS;
           }
    /**
     * ��ͯ���ϸ�����Ϣ�޸�ҳ��
     * @return
     */
    public String toModify(){
    	String cui_id = getParameter("CUI_ID");
    	String ci_id = getParameter("CI_ID");
    	String update_type=getParameter("UPDATE_TYPE");//���¼���1
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               //��ȡ��ͯ������Ϣԭ����
               Data showdata = handler.getChildInfoById(conn, ci_id);
               //��ȡ������ϸ��Ϣ��������Ϣ��
               DataList updateDetail=handler.getUpdateDetail(conn, cui_id,"0");
               //����ϸ�б���Ϣת���ɿ�չʾ�����ݣ���ͯ������Ϣ��
               for(int i=0;i<updateDetail.size();i++){
            	   Data detail=updateDetail.getData(i);
            	   showdata.add("N"+detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
               }
               
               UserInfo user=SessionInfo.getCurUser();
               //���ݶ�ͯ���ϵĶ�ͯ���ͺͶ�ͯ��ݻ�ȡ�����ͯ�ĸ���smalltype
               String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
               DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
               //����ȡ���ĸ���С���codeֵ����ʾ������","ƴ�ӳ��ַ���
              	String smTypeValues="";
             	String smTypeStrs="";
              	for(int i=0;i<smallTypes.size();i++){
              		Data tmp=smallTypes.getData(i);
              		if(i!=(smallTypes.size()-1)){
              			smTypeValues+=tmp.getString("CODE")+",";
              			smTypeStrs+=tmp.getString("CNAME")+",";
              		}else{
              			smTypeValues+=tmp.getString("CODE");
              			smTypeStrs+=tmp.getString("CNAME");
              		}
              	}
               //��ȡ������ϸ��Ϣ�����¸�����Ϣ��
               DataList attUpdateDetail=handler.getUpdateDetail(conn, cui_id,"1");
               String smTypeUsed="";
               String updateTypes="";//�������� 0����1׷��
               for(int i=0;i<attUpdateDetail.size();i++){
            	   Data attDetail=attUpdateDetail.getData(i);
            	   if(smTypeValues.indexOf(attDetail.getString("UPDATE_FIELD"))!=-1){
            		   if(i!=(attUpdateDetail.size()-1)){
                		   smTypeUsed+=attDetail.getString("UPDATE_FIELD")+",";
                		   updateTypes+=attDetail.getString("UPDATE_TYPE")+",";
                	   }else{
                		   smTypeUsed+=attDetail.getString("UPDATE_FIELD");
                		   updateTypes+=attDetail.getString("UPDATE_TYPE");
                	   }
            	   }
               }
               
               if(smTypeUsed.indexOf(",")!=-1&&(smTypeUsed.lastIndexOf(",")==(smTypeUsed.length()-1))){
        		   smTypeUsed=smTypeUsed.substring(0,smTypeUsed.length()-1);
        		   updateTypes=updateTypes.substring(0,updateTypes.length()-1);
        	   }
               setAttribute("updateDetail", updateDetail);
               setAttribute("CUI_ID", cui_id);
               setAttribute("UPDATE_TYPE", update_type);
               setAttribute("data", showdata);
               setAttribute("pakgId", pakgId);
               setAttribute("smTypeValues", smTypeValues);
               setAttribute("smTypeStrs", smTypeStrs);
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
               setAttribute("smTypeUsed", smTypeUsed);
               setAttribute("updateTypes", updateTypes);
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * ��ͯ���ϸ�����ϸ��Ϣҳ��ı��桢�ύʡ�����ύ���Ĳ���
     * @return
     */
    public String saveUpdateData(){
		//1 ���ҳ������ݣ��������ݽ����
		Data newData = getRequestEntityData("N_","NCHECKUP_DATE","NID_CARD","NSENDER","NSENDER_ADDR","NPICKUP_DATE","NENTER_DATE","NSEND_DATE","NIS_ANNOUNCEMENT","NANNOUNCEMENT_DATE","NNEWS_NAME","NSN_TYPE","NDISEASE_CN","NIS_PLAN","NIS_HOPE");
		String ci_id=getParameter("CI_ID");
		String cui_id=getParameter("CUI_ID");
		String updtate_state=getParameter("UPDATE_STATE");
		String update_type=getParameter("UPDATE_TYPE");
		Data updateData=new Data();
		String Signal=update_type;
		String[] smallTypes=getParameterValues("smalltype");
		String[] updatetypes=getParameterValues("updatetype");
		if(ChildInfoConstants.LEVEL_CCCWA.equals(update_type)&&cui_id!=null){//��������Ĳ����޸Ĳ������������践�������²�ѯ�б���
        	Signal="3-1";
        }
		//�����������¼������ϸ��Ϣ�������¼���Ϊ����ʱ���ڸ���ҳ�����ύ����˱��������ϸ��Ϣ�⣬����Ҫ����Ϣ��Ϣ���µ���ͯ���ϻ�����Ϣ���У�
		DataList updateDetails=new DataList();//������Ϣ������ϸ
		DataList attUpdateDetails=new DataList();//������Ϣ������ϸ
		try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            boolean attSuccess = false;
            //��ȡ��ͯ���ϻ�����Ϣԭʼ����
    	    Data orignalData= handler.getChildInfoById(conn, ci_id);
    	    //�����ͯ���ϵ����״̬Ϊ"ʡ��ͨ��"����"���Ĳ�ͨ��"���������������ļ���
    	    String aud_state=orignalData.getString("AUD_STATE");
    	    String file_code=orignalData.getString("FILE_CODE");//��ͯ������Ϣ��packageId
    	    if(ChildStateManager.CHILD_AUD_STATE_SBTG.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXBTG.equals(aud_state)){
    	    	InfoClueTo clueTo = new InfoClueTo(0, "��ͯ������˲�ͨ��������������Ч");
                setAttribute("clueTo", clueTo);
        	    return Signal;
    	    }
    	    //�ȷ�������  ������������ύ֮�󷢲���������⣺��������ĸ����ύʱ��ֱ�Ӹ��¸�����Ϣ��������packageId�ѱ�Ϊfile_code������"N"+file_code,�ᵼ�¸��µĸ����򲻻ᱻ��������ʧ
    	    AttHelper.publishAttsOfPackageId("N"+file_code, "CI"); 
    	    //������¼�¼
    	    UserInfo curuser = SessionInfo.getCurUser();
    	    updateData.add("CUI_ID", cui_id);	//��Ӹ��¼�¼����
    	    updateData.add("CI_ID", ci_id);	//��Ӷ�ͯ���ϻ�����ϢID
    	    updateData.add("UPDATE_TYPE", update_type);	//��Ӹ��¼���
    	    //if(ChildStateManager.CHILD_UPDATE_STATE_SDS.equals(updtate_state)||ChildStateManager.CHILD_UPDATE_STATE_ZXDS.equals(updtate_state)||ChildStateManager.CHILD_UPDATE_STATE_TG.equals(updtate_state)){
    	    	updateData.add("ORG_CODE",curuser.getCurOrgan().getOrgCode());	//������뵥λ��������
	    	    updateData.add("ORG_NAME",curuser.getCurOrgan().getCName());	//������뵥λ����
	    	    updateData.add("UPDATE_USERID",curuser.getPersonId() );//���������ID
	    	    updateData.add("UPDATE_USERNAME",curuser.getPerson().getCName() );	//�������������
	    	    updateData.add("UPDATE_DATE", DateUtility.getCurrentDate());	//��Ӹ�����������
    	    //}
    	    updateData.add("UPDATE_STATE", updtate_state);	//��Ӹ���״̬
    	    handler.saveUpdateData(conn, updateData);
    	    cui_id=updateData.getString("CUI_ID", null);
    	    if(cui_id==null){
    	    	Signal = "error1";
        	    return Signal;
    	    }
    	    //���������ϸ��������Ϣ��
    	    success=handler.saveUpdateDetail(conn,updateDetails,cui_id,orignalData,newData);
    	    //���������ϸ��������Ϣ��
    	    attSuccess=handler.saveAttUpdateDetail(conn,attUpdateDetails,smallTypes,updatetypes,cui_id,file_code); 
    	    if (success||attSuccess) {                
	    	      //���¶�ͯ���ϻ�����Ϣ��ĸ���״̬
	        	    Data child=new Data();
	        	    child.add("UPDATE_STATE", updtate_state);
	        	    child.add("CI_ID",ci_id );
	        	    if("3".equals(updtate_state)){//��������ĸ����ύ����ֱ�Ӹ��¶�ͯ������Ϣ������Ҫ���и������ UPDATE_NUM LAST_UPDATE_DATE
		        	       for(int i=0;i<updateDetails.size();i++){
		        	    	   Data tmpData=updateDetails.getData(i);
		        	    	   child.add(tmpData.getString("UPDATE_FIELD"), tmpData.getString("UPDATE_DATA"));
		        	       }
		        	       String numStr=orignalData.getString("UPDATE_NUM",null);
		        	       if(numStr==null){
		        	    	  child.add("UPDATE_NUM",1);
		        	       }else{
		        	    	  child.add("UPDATE_NUM",(Integer.parseInt(numStr)+1));
		        	       }
		        	       child.add("LAST_UPDATE_DATE", DateUtility.getCurrentDate());
		        	       //������Ϣ�ĸ���
		        	       if(smallTypes!=null){
		        	    	   for(int j=0;j<attUpdateDetails.size();j++){
		        	    		    Data attUpdate=attUpdateDetails.getData(j);
		        	    		    handler.updateAttachment(conn,file_code,attUpdate.getString("UPDATE_FIELD"),attUpdate.getString("UPDATE_TYPE"));
		        	    	   }
		        	       }
	        	    }
	        	    handler.saveChildUpdateState(conn,child);
	        	    //������ύʡ�����ύ������Ҫ����һ�����ϸ�����˼�¼��Ϣ
	        	    if("1".equals(updtate_state)||"2".equals(updtate_state)){
	        	    	Data audit=new Data();
	        	    	audit.add("CUI_ID", cui_id);
	        	    	audit.add("OPERATION_STATE", ChildStateManager.OPERATION_STATE_TODO);
	        	    	if("1".equals(updtate_state)){
	        	    	   audit.add("AUDIT_TYPE", ChildInfoConstants.LEVEL_PROVINCE);
	        	    	}else{
	        	    	   audit.add("AUDIT_TYPE", ChildInfoConstants.LEVEL_CCCWA);
	        	    	}
	        	    	handler.saveAuditInfo(conn,audit);
	        	    }
	        	    //���ò����ɹ������ʾ��Ϣ
	    	    	String infoStr="";
	    	    	if("0".equals(updtate_state)){
	    	    		infoStr="����ɹ�";
	    	    	}else if("1".equals(updtate_state)){
	    	    		infoStr="�ύʡ���ɹ�";
	    	    	}else if("2".equals(updtate_state)){
	    	    		 infoStr="�ύ���ĳɹ�";
	    	    		if("2".equals(update_type)){
	    	    		 infoStr="�ύ�ɹ�";
	    	    		}
	    	    	}else if("3".equals(updtate_state)){
	    	    		infoStr="�ύ�ɹ�";
	    	    	}
	                InfoClueTo clueTo = new InfoClueTo(0, infoStr);
	                setAttribute("clueTo", clueTo);
            }else if((!success)&&smallTypes==null){
            	    dt.rollback();
            	    InfoClueTo clueTo = new InfoClueTo(0, "û����д�������ݣ�������Ч");
	                setAttribute("clueTo", clueTo);
	        	    return Signal;
            }
    	   
           dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϸ��±���/�ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[��ͯ���ϸ��±���/�ύ����]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϸ��±���/�ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("��ͯ���ϸ��±���/�ύ�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }catch(Exception e){
        	//6�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϸ��±���/�ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("��ͯ���ϸ��±���/�ύ�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ChildUpdateAction��saveUpdateData.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    Signal = "error2";
                }
            }
        }
        return Signal;
	}
    /**
     * ��ͯ���ϸ�����Ϣ�鿴ҳ��
     * @return
     */
    public String getShowData(){
    	String uuid = getParameter("UUID");
        Connection conn = null;
        DataList updateList=new DataList();
        DataList attUpdateDetail=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               //��ȡ�鿴ҳ��Ķ�ͯ����չʾ��Ϣ�����¼�¼��Ϣ
               Data showdata = handler.getShowData(conn, uuid);
               String CUI_ID=showdata.getString("CUI_ID",null);
               //��ȡ������ϸ��Ϣ
               if(CUI_ID!=null){
            	   updateList=handler.getUpdateDetail(conn,CUI_ID,"0");
               }
             //��ȡ������ϸ��Ϣ�����¸�����Ϣ��
               if(CUI_ID!=null){
                   attUpdateDetail=handler.getAttUpdateDetail(conn, CUI_ID);
               }
          /*     if(attUpdateDetail.size()>0){
            	 //���ݶ�ͯ���ϵĶ�ͯ���ͺͶ�ͯ��ݻ�ȡ�����ͯ�ĸ���smalltype
                  // String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
                  // DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
        		   for(int j=0;j<attUpdateDetail.size();j++){
        			    Data dat =attUpdateDetail.getData(j);
						String updateType=dat.getString("UPDATE_TYPE","");
						String smallType=dat.getString("UPDATE_FIELD","");
						//������Ŀ
						for(int k=0;k<smallTypes.size();k++){
	                  		Data tmp=smallTypes.getData(k);
	                  		if(tmp.getString("CODE").equals(smallType)){
	                  			dat.add("UPDATE_FIELD", tmp.getString("CNAME"));
	                  			break;
	                  		}
	                  	}
						//��������
						if("0".equals(updateType)){
							dat.add("UPDATE_TYPE","����");
						  }else if("1".equals(updateType)){
							dat.add("UPDATE_TYPE","׷��");
						  }
						
        		   }
               }*/
               setAttribute("data", showdata);
               setAttribute("updateList", updateList);
               setAttribute("attUpdateDetail", attUpdateDetail);
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * ���ݶ�ͯ������Ϣ������ȡ���¼�¼��Ϣ���������ͨ���ĸ�����Ϣ��
     * @return
     */
    public String getShowDataByCIID(){
    	String CI_ID = getParameter("CI_ID");
        Connection conn = null;
        DataList updateList=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               updateList= handler.getUpdateDataByCIID(conn,CI_ID);
	           if(updateList.size()!=0){
            	   for(int i=0;i<updateList.size();i++){
            		   Data showData=updateList.getData(i);
            		   String CUI_ID=showData.getString("CUI_ID");
            		   DataList updateDetail=handler.getUpdateDetail(conn,CUI_ID,"0");
            		   DataList updateAttDetail=handler.getAttUpdateDetail(conn, CUI_ID);//getUpdateDetail(conn,CUI_ID,"1");
            		   setAttribute("DETAILLIST"+i, updateDetail);
            		   showData.add("DETAILLIST", "DETAILLIST"+i);
            		 //���ݶ�ͯ���ϵĶ�ͯ���ͺͶ�ͯ��ݻ�ȡ�����ͯ�ĸ���smalltype
                      // String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(childData.getString("CHILD_IDENTITY"), childData.getString("CHILD_TYPE"), false);
                     //  DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
            		   for(int j=0;j<updateAttDetail.size();j++){
            			    Data dat =updateAttDetail.getData(j);
							String updateType=dat.getString("UPDATE_TYPE","");
							/*String smallType=dat.getString("UPDATE_FIELD","");
							//������Ŀ
							for(int k=0;k<smallTypes.size();k++){
		                  		Data tmp=smallTypes.getData(k);
		                  		if(tmp.getString("CODE").equals(smallType)){
		                  			dat.add("UPDATE_FIELD", tmp.getString("CNAME"));
		                  			break;
		                  		}
		                  	}*/
							//��������
							if("0".equals(updateType)){
								dat.add("UPDATE_TYPE","����");
							  }else if("1".equals(updateType)){
								dat.add("UPDATE_TYPE","׷��");
							  }
							
            		   }
            		   setAttribute("ATTDETAILLIST"+i, updateAttDetail);
            		   showData.add("ATTDETAILLIST", "ATTDETAILLIST"+i);
                    }
               }
               setAttribute("updateList", updateList);
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * ���ݶ�ͯ������Ϣ������ȡ���¼�¼��Ϣ���������ͨ���ĸ�����Ϣ��
     * @return
     */
    public String getShowDataByCIIDForAdoption(){
    	String CI_ID = getParameter("CI_ID");
        Connection conn = null;
        DataList updateList=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               updateList= handler.getUpdateDataByCIID(conn,CI_ID);
	           if(updateList.size()!=0){
            	    for(int i=0;i<updateList.size();i++){
            		   Data showData=updateList.getData(i);
            		   String CUI_ID=showData.getString("CUI_ID");
            		   DataList updateDetail=handler.getUpdateDetail(conn,CUI_ID,"0");
            		   DataList updateAttDetail=handler.getAttUpdateDetailEN(conn, CUI_ID);//getUpdateDetail(conn,CUI_ID,"1");
            		   setAttribute("DETAILLIST"+i, updateDetail);
            		   showData.add("DETAILLIST", "DETAILLIST"+i);
            		 //���ݶ�ͯ���ϵĶ�ͯ���ͺͶ�ͯ��ݻ�ȡ�����ͯ�ĸ���smalltype
                      // String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(childData.getString("CHILD_IDENTITY"), childData.getString("CHILD_TYPE"), false);
                     //  DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
            		   for(int j=0;j<updateAttDetail.size();j++){
            			    Data dat =updateAttDetail.getData(j);
							String updateType=dat.getString("UPDATE_TYPE","");
							/*String smallType=dat.getString("UPDATE_FIELD","");
							//������Ŀ
							for(int k=0;k<smallTypes.size();k++){
		                  		Data tmp=smallTypes.getData(k);
		                  		if(tmp.getString("CODE").equals(smallType)){
		                  			dat.add("UPDATE_FIELD", tmp.getString("CNAME"));
		                  			break;
		                  		}
		                  	}*/
							//��������
							if("0".equals(updateType)){
								dat.add("UPDATE_TYPE","����");
							  }else if("1".equals(updateType)){
								dat.add("UPDATE_TYPE","׷��");
							  }
							
            		   }
            		   setAttribute("ATTDETAILLIST"+i, updateAttDetail);
            		   showData.add("ATTDETAILLIST", "ATTDETAILLIST"+i);
                    }
               }
               setAttribute("updateList", updateList);
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
               return SUCCESS;
           }
    /**
	 * ʡ����ͯ���ϸ�������б�
	 * @return
	 */
    public String updateAuditListSt(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ��������������Ժ���������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ�����״̬���������ڡ�����ˡ����ʱ��
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END","AUDIT_USERNAME","AUDIT_DATE_START","AUDIT_DATE_END");
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//��ȡʡ����½�˵���֯��������
 	 		UserInfo user=SessionInfo.getCurUser();
 			Organ o=user.getCurOrgan();
 			String oCode=o.getOrgCode();
 			String provinceId=new ChildCommonManager().getProviceId(oCode);
 			//5 ��ȡ����DataList
             DataList dl=handler.updateAuditListSt(conn,provinceId,ChildInfoConstants.LEVEL_PROVINCE,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("provinceId",provinceId);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
	 * ���ģ����ò�����ͯ���ϸ�������б�
	 * @return
	 */
    public String updateAuditListZX(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ��������ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ����������ʡ�ݡ�����Ժ���������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ�����״̬���������ڡ�����ˡ����ʱ��
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END","AUDIT_USERNAME","AUDIT_DATE_START","AUDIT_DATE_END");
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.updateAuditListZX(conn,ChildInfoConstants.LEVEL_CCCWA,data,pageSize,page,compositor,ordertype);
 			//6 �������д��ҳ����ձ���
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 �����쳣����
 			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 �ر����ݿ�����
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
     * ��ͯ���ϸ���������˲���
     * @return
     */
    public String saveUpdateAudit(){
		//1 ���ҳ������ݣ��������ݽ����
    	  //��ȡ���ҳ���ύ�����¸�����ϸ��Ϣ
		Data newDetail = getRequestEntityData("N_","NCHECKUP_DATE","NID_CARD","NSENDER","NSENDER_ADDR","NPICKUP_DATE","NENTER_DATE","NSEND_DATE","NIS_ANNOUNCEMENT","NANNOUNCEMENT_DATE","NNEWS_NAME","NSN_TYPE","NDISEASE_CN","NIS_PLAN","NIS_HOPE");
		 //��ȡ��˽���������������Ϣ
		Data auditInfo= getRequestEntityData("S_","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");//��˼�¼
		String ci_id=getParameter("CI_ID");
		String cui_id=getParameter("CUI_ID");
		String cua_id=getParameter("CUA_ID");
		String updateType=getParameter("AUDIT_TYPE");//��˼���
		String[] smallTypes=getParameterValues("smalltype");
		String[] updatetypes=getParameterValues("updatetype");
		String Signal=updateType;
		DataList updateDetails=new DataList();
		DataList attUpdateDetail=new DataList();
		try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            Data updateInf=new Data();//���¼�¼
            Data childUpdate=new Data();
            String resultInfo="��˳ɹ�";
           //��ȡ��ͯ���ϻ�����Ϣ
    	    Data childInfo= handler.getChildInfoById(conn, ci_id);
            String aud_state=childInfo.getString("AUD_STATE");
            //�����ͯ���ϵ��������״̬Ϊʡ��ͨ�������Ĳ�ͨ�������ͨ��������Ч
            if("1".equals(auditInfo.getString("AUDIT_OPTION"))&&(ChildStateManager.CHILD_AUD_STATE_SBTG.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXBTG.equals(aud_state))){
            	InfoClueTo clueTo = new InfoClueTo(0, "��ͯ������˲�ͨ�����������ͨ��������Ч");
                setAttribute("clueTo", clueTo);
        	    return Signal;
            }
           //�ȷ�������  ������������ύ֮�󷢲���������⣺������ͨ������¸�����Ϣ��������packageId�ѱ�Ϊfile_code������"N"+file_code,�ᵼ�¸��µĸ����򲻻ᱻ��������ʧ
    	    AttHelper.publishAttsOfPackageId("N"+childInfo.getString("FILE_CODE"), "CI");
            UserInfo curuser = SessionInfo.getCurUser();
            //���ø�����˼�¼�����¼�¼����ͯ��Ϣ
            auditInfo.add("CUA_ID", cua_id);
            auditInfo.add("OPERATION_STATE",ChildStateManager.OPERATION_STATE_DONE);//���ò���״̬Ϊ�Ѵ���
            auditInfo.add("AUDIT_USERID", curuser.getPersonId());
            auditInfo.add("AUDIT_USERNAME", curuser.getPerson().getCName());
            auditInfo.add("AUDIT_DATE", DateUtility.getCurrentDate());
            
            updateInf.add("CUI_ID", cui_id);
            if(ChildInfoConstants.LEVEL_PROVINCE.equals(updateType)){//��������
            	updateInf.add("P_AUD_OPTION",auditInfo.getString("AUDIT_OPTION"));
            	updateInf.add("P_AUD_CONTENT",auditInfo.getString("AUDIT_CONTENT") );
            	updateInf.add("P_AUD_REMARKS",auditInfo.getString("AUDIT_REMARKS") );
            	updateInf.add("P_AUD_USERID",curuser.getPersonId() );
            	updateInf.add("P_AUD_USERNAME",curuser.getPerson().getCName() );
            	updateInf.add("P_AUD_DATE",DateUtility.getCurrentDate() );
            }else if(ChildInfoConstants.LEVEL_CCCWA.equals(updateType)){//����������
            	updateInf.add("C_AUD_OPTION",auditInfo.getString("AUDIT_OPTION"));
            	updateInf.add("C_AUD_CONTENT",auditInfo.getString("AUDIT_CONTENT") );
            	updateInf.add("C_AUD_REMARKS",auditInfo.getString("AUDIT_REMARKS") );
            	updateInf.add("C_AUD_USERID",curuser.getPersonId() );
            	updateInf.add("C_AUD_USERNAME",curuser.getPerson().getCName() );
            	updateInf.add("C_AUD_DATE",DateUtility.getCurrentDate() );	
            }
            
            childUpdate.add("CI_ID",ci_id );
            
            //��ȡԭʼ������ϸ(������Ϣ)
             updateDetails=handler.getUpdateDetail(conn,cui_id,"0");
             if("0".equals(auditInfo.getString("AUDIT_OPTION"))){//��˲�ͨ��ʱ
            	 updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_BTG);
            	 childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_BTG);
            	 handler.saveAuditInfo(conn, auditInfo);
            	 handler.saveUpdateData(conn, updateInf);
            	 handler.saveChildUpdateState(conn,childUpdate );
            	 //����и��¸������򽫸��¸��������߼�ɾ��(package Nfile_code��ΪDfile_code)�����ɾ���������Ϣ�鿴ҳ����¸�����ʧ����ʾΪ�հ�
            	 attUpdateDetail=handler.getUpdateDetail(conn,cui_id,"1");
            	 if(attUpdateDetail.size()>0){
            		 for(int j=0;j<attUpdateDetail.size();j++){
       	    		    Data attUpdate=attUpdateDetail.getData(j);
       	    		    handler.changeUpdateAttPackagId(conn,childInfo.getString("FILE_CODE"),attUpdate.getString("UPDATE_FIELD"));
       	    	   }
            	 }
             }else{//���ͨ��ʱ
            	    handler.saveUpdateDetailStore(conn,updateDetails,newDetail,"N");//���������ϸ��Ϣ(������Ϣ)
            	    if(smallTypes!=null){
            	    	// handler.saveAttUpdateDetailStore(conn, attUpdateDetail, smallTypes, updatetypes, cui_id, childInfo.getString("FILE_CODE"));//���������ϸ��Ϣ(������Ϣ)
            	    	handler.saveAttUpdateDetail(conn, attUpdateDetail, smallTypes, updatetypes, cui_id, childInfo.getString("FILE_CODE"));//���������ϸ��Ϣ(������Ϣ)
            	    }
            	   //�����ʡ������Ҫ�ж��Ƿ���Ҫ�������
            	    if(ChildInfoConstants.LEVEL_PROVINCE.equals(updateType)){
            		   //��Ҫ��������򲻸��¶�ͯ���ϻ�����Ϣ,��Ҫ����һ��������˼�¼
            		   if(ChildStateManager.CHILD_AUD_STATE_YJIES.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_YJS.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXSHZ.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXTG.equals(aud_state)){
	            			  updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_ZXDS);
	            			  childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_ZXDS);
	            			  Data newAudit=new Data();
	            			  newAudit.add("CUI_ID", cui_id);
	            			  newAudit.add("OPERATION_STATE", ChildStateManager.OPERATION_STATE_TODO);
	            			  newAudit.add("AUDIT_TYPE", ChildInfoConstants.LEVEL_CCCWA);
	            			  handler.saveAuditInfo(conn, newAudit);
	            			  handler.saveAuditInfo(conn,auditInfo);
	            			  handler.saveUpdateData(conn, updateInf);
	            			  handler.saveChildUpdateState(conn, childUpdate);
	            			  resultInfo="��˳ɹ�,��Ҫ�������";
                    	 }else if(ChildStateManager.CHILD_AUD_STATE_SDS.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_SSHZ.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_STG.equals(aud_state)){
                    	//����Ҫ�����������¶�ͯ���ϻ�����Ϣ
                    		 updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
                    		//����ϸ�б���Ϣת���ɶ�ͯ���ϸ�������
                             for(int i=0;i<updateDetails.size();i++){
                          	   Data detail=updateDetails.getData(i);
                          	   childUpdate.add(detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
                             }
               			     childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
               			     childUpdate.add("LAST_UPDATE_DATE", DateUtility.getCurrentDate());//�������һ�θ�������
	               		     String numStr=childInfo.getString("UPDATE_NUM",null);//������´���
	   	        	         if(numStr==null){
	   	        	        	childUpdate.add("UPDATE_NUM",1);
	   	        	         }else{
	   	        	        	childUpdate.add("UPDATE_NUM",(Integer.parseInt(numStr)+1));
	   	        	         }
		   	        	     //������Ϣ�ĸ���
		  	        	     if(smallTypes!=null){
	  	        	    	   for(int j=0;j<attUpdateDetail.size();j++){
	  	        	    		    Data attUpdate=attUpdateDetail.getData(j);
	  	        	    		    handler.updateAttachment(conn,childInfo.getString("FILE_CODE"),attUpdate.getString("UPDATE_FIELD"),attUpdate.getString("UPDATE_TYPE"));
	  	        	    	   }
		  	        	     }
	   	        	        handler.saveAuditInfo(conn,auditInfo);
            			    handler.saveUpdateData(conn, updateInf);
            			    handler.saveChildUpdateState(conn, childUpdate);
            			    resultInfo="��˳ɹ�,��ͯ������Ϣ������Ч"; 
                    	 }
	               }else if(ChildInfoConstants.LEVEL_CCCWA.equals(updateType)){
			             //������˳ɹ���ֱ�Ӹ�������    
			        	  updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
			     		   //����ϸ�б���Ϣת���ɶ�ͯ���ϸ�������
			              for(int i=0;i<updateDetails.size();i++){
			           	   Data detail=updateDetails.getData(i);
			           	   childUpdate.add(detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
			              }
						  childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
						  childUpdate.add("LAST_UPDATE_DATE", DateUtility.getCurrentDate());//�������һ�θ�������
			    		  String numStr=childInfo.getString("UPDATE_NUM",null);//������´���
			    	      if(numStr==null){
			    	        childUpdate.add("UPDATE_NUM",1);
			    	      }else{
			    	        childUpdate.add("UPDATE_NUM",(Integer.parseInt(numStr)+1));
			    	      }
			    	     //������Ϣ�ĸ���
		  	        	  if(smallTypes!=null){
	  	        	    	   for(int j=0;j<attUpdateDetail.size();j++){
	  	        	    		    Data attUpdate=attUpdateDetail.getData(j);
	  	        	    		    handler.updateAttachment(conn,childInfo.getString("FILE_CODE"),attUpdate.getString("UPDATE_FIELD"),attUpdate.getString("UPDATE_TYPE"));
	  	        	    	   }
		  	        	   }
			    	      handler.saveAuditInfo(conn,auditInfo);
					      handler.saveUpdateData(conn, updateInf);
					      handler.saveChildUpdateState(conn, childUpdate);
					      resultInfo="��˳ɹ�,��ͯ������Ϣ������Ч";  
	             }
            	 
           }
            InfoClueTo clueTo = new InfoClueTo(0, resultInfo);
            setAttribute("clueTo", clueTo);
            dt.commit();
            
       } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϸ�����˲����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[��ͯ���ϸ�����˽�����]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϸ�����˲����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("��ͯ���ϸ�����˲����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }catch (Exception e) {
        	//6�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϸ�����˲����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("��ͯ���ϸ�����˲����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ChildUpdateAction��saveUpdateAudit.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    Signal = "error2";
                }
            }
        }
        return updateType;
	}
    /**
     * ��ͯ���ϸ��������ϴ�
     * @return
     */
    public String updateAtt(){
    	String uploadId=getParameter("uploadId"); 
    	String packageId=getParameter("packageId"); 
    	String smallType=getParameter("smallType"); 
    	String org_af_id=getParameter("org_af_id"); 
    	setAttribute("uploadId",uploadId);
        setAttribute("packageId",packageId);
        setAttribute("smallType",smallType);
        setAttribute("org_af_id",org_af_id);
        return SUCCESS;
     }
}
