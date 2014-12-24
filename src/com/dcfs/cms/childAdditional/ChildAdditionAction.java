package com.dcfs.cms.childAdditional;

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
import java.util.Date;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildStateManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.person.vo.Person;
import com.hx.upload.sdk.AttHelper;

public class ChildAdditionAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(ChildAdditionAction.class);

    private ChildAdditionHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    public ChildAdditionAction(){
        this.handler=new ChildAdditionHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	/**
	 * ʡ�� ҵ���ѯ-�����ѯ����ѯ��ʡ������Ķ�ͯ���ϲ���֪ͨ��
	 * @return
	 */
    public String findListFromSt(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ�֪ͨ���ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ��������������Ժ���ơ��������Ա𡢶�ͯ���͡�����֪ͨ��Դ������״̬���������ڡ��������ڡ�����֪ͨ����  
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","CHILD_TYPE","SOURCE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
 		
		//��ȡʡ����¼�˵�ʡ��Id(���ڷ�����δʵ�֣���ʱʹ�ù̶�ֵ)
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
		System.out.println("ʡ��Id:"+provinceId);
 	  //  String provinceId="110000";
 	//	System.out.println("ʡ��Id:"+provinceId);
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.findListFromSt(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
	 * ���ò� ҵ���ѯ-�����ѯ����ѯ�����ķ���Ķ�ͯ���ϲ���֪ͨ��
	 * @return
	 */
    public String findListFromAZB(){
    	 //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ�֪ͨ���ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ����������ʡ�ݡ�����Ժ���ơ��������Ա𡢶�ͯ���͡�����֪ͨ��Դ������״̬���������ڡ��������ڡ�����֪ͨ����  
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","CHILD_TYPE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.findListFromAZB(conn,data,pageSize,page,compositor,ordertype);
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
	 * ����Ժ��ͯ���ϲ����ѯ/����Ժ��ͯ���ϲ����б�
	 * @return
	 */
    public String findListFLY(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ�֪ͨ���ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ�����������������Ա𡢶�ͯ���͡�����֪ͨ��Դ������״̬���������ڡ��������ڡ�����֪ͨ����  
 		Data data = getRequestEntityData("S_","NAME","SEX","CHILD_TYPE","SOURCE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
 		
 		//��ȡ����Ժ��¼�˵ĸ���ԺId
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
		System.out.println("��֯����:"+oId);
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.findListFLY(conn,oId,data,pageSize,page,compositor,ordertype);
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
  * ʡ����ͯ���ϲ����ѯ/ʡ����ͯ���ϲ����б�
  * @return
  */
    public String findListST(){
        //1 �趨����
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
 		setAttribute("clueTo", clueTo);//set�����������
 		
     	//2 ���÷�ҳ����
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 ��ȡ�����ֶΣ�Ĭ�ϰ�֪ͨ���ڽ������У�
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 ��ȡ��������   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 ��ȡ��ѯ��������
        //��ѯ��������������Ժ���ơ��������Ա𡢶�ͯ���͡�����֪ͨ��Դ������״̬���������ڡ��������ڡ�����֪ͨ����  
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","CHILD_TYPE","SOURCE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
 		
		//��ȡʡ����¼�˵�ʡ��Id
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
         try {
 		    //4 ��ȡ���ݿ�����
 			conn = ConnectionManager.getConnection();
 			//5 ��ȡ����DataList
             DataList dl=handler.findListST(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
     * ��ͯ���ϲ���ҳ��
	 * @author furx
	 * @date 2014-9-6
     */
    public String getModifyData(){
    	String uuid = getParameter("UUID");
    	//���ݲ���ȷ���Ǹ���Ժ���仹��ʡ��������ʵ�ֲ���ɹ�������ת�Ĳ����б�ҳ��1Ϊ��ת������Ժ2Ϊ��ת��ʡ��
        String signal=getParameter("signal");
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               Data showdata = handler.getModifyData(conn, uuid);
               UserInfo user=SessionInfo.getCurUser();
               Person person=user.getPerson();
               String pName=person.getCName();
               if(showdata!=null){
            	   showdata.add("FEEDBACK_ORGNAME", user.getCurOrgan().getCName());
            	   showdata.add("FEEDBACK_USERNAME", pName);
            	   showdata.add("FEEDBACK_DATE",new Date());
               }
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
               setAttribute("signal", signal);
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * ��ͯ���ϲ�����Ϣ�鿴ҳ��
     * @return
     */
    public String getShowData(){
    	String uuid = getParameter("UUID");
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               Data showdata = handler.getModifyData(conn, uuid);
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
                           log.logError("Connection������쳣��δ�ܹر�",e);
                       }
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * ��ͯ���ϲ���ҳ��ı����ύ����
     * @return
     */
	public String childSupplySave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","CA_ID","CI_ID","CA_STATUS","UPLOAD_IDS","ADD_CONTENT","SOURCE");
		Data childData=new Data();
 		String Signal=getParameter("signal");
 		String source=data.getString("SOURCE","");
		try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
    			UserInfo curuser = SessionInfo.getCurUser();
    			data.add("FEEDBACK_USERID", curuser.getPersonId());	//��ӷ�����ID
    			data.add("FEEDBACK_USERNAME", curuser.getPerson().getCName());	//��ӷ���������
    			data.add("FEEDBACK_ORGID", curuser.getCurOrgan().getOrgCode());//��ӷ�������֯Id(������֯��������)
    			data.add("FEEDBACK_ORGNAME", curuser.getCurOrgan().getCName());	//��ӷ�������֯����
    			data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());	//��ӷ�������
                childData.add("CI_ID", data.getString("CI_ID"));
                childData.add("SUPPLY_STATE", data.getString("CA_STATUS"));
                if(ChildStateManager.CHILD_ADD_STATE_DOING.equals(data.getString("CA_STATUS"))){//������
                	if(ChildInfoConstants.LEVEL_PROVINCE.equals(source)){//ʡ�����Ҫ����Ժ������
                		new ChildCommonManager().stAuditSupplySave(childData, null);
                	}else if(ChildInfoConstants.LEVEL_CCCWA.equals(source)){//�������Ҫ����ϲ�����
                		new ChildCommonManager().zxAuditSupplySave(childData, null);
                	}
                }else if(ChildStateManager.CHILD_ADD_STATE_DONE.equals(data.getString("CA_STATUS"))){//�Ѳ���
					if(ChildInfoConstants.LEVEL_PROVINCE.equals(source)){//ʡ�����Ҫ����Ժ�Ѳ���
						new ChildCommonManager().stAuditSupplySubmit(childData, null);            		
                	}else if(ChildInfoConstants.LEVEL_CCCWA.equals(source)){//�������Ҫ�󲹳���ϣ��Ѳ���
                		new ChildCommonManager().zxAuditSupplySubimit(childData, null);
                	}
                }
    		//ִ�ж�ͯ���ϲ��䱣�������������ϲ�����еĲ������� ���²�����ϵĲ���״̬�Ͷ�ͯ������Ϣ���е�ĩ�β���״̬Ϊ��1:������
            boolean success = false;
            success=handler.childSupplySave(conn,data,childData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "�����ɹ�!");
                setAttribute("clueTo", clueTo);
                AttHelper.publishAttsOfPackageId(data.getString("UPLOAD_IDS"), "CI");
            }
            
            dt.commit();
            
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϲ��䱣��/�ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[��ͯ���ϲ��䱣��/�ύ����]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϲ��䱣��/�ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("��ͯ���ϲ��䱣��/�ύ�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }catch(Exception e){
        	//6�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ���ϲ��䱣��/�ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("��ͯ���ϲ��䱣��/�ύ�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ChildAdditionAction��childSupplySave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    Signal = "error2";
                }
            }
        }
        return Signal;
	}
	 /**
     * ���ݶ�ͯ������Ϣ������ȡ�����¼���Ѳ���Ĳ�����Ϣ��
     * @return
     */
    public String getShowDataByCIID(){
    	String CI_ID = getParameter("CI_ID");
        Connection conn = null;
        DataList additionList=new DataList();
        try {
            conn = ConnectionManager.getConnection();
            additionList= handler.getAdditionDataByCIID(conn,CI_ID);
            setAttribute("additionList", additionList);
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
}
