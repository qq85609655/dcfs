package com.dcfs.cms.childReturn;

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
import com.dcfs.cms.childAdditional.ChildAdditionAction;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.cms.childManager.ChildStateManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.person.vo.Person;
import com.hx.upload.sdk.AttHelper;

public class ChildReturnAction  extends BaseAction{
	
	private static Log log = UtilLog.getLog(ChildAdditionAction.class);

    private ChildReturnHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    public ChildReturnAction(){
        this.handler=new ChildReturnHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	

	 /**
	 * ����Ժ��ͯ�����˲����б�
	 * @return
	 */
   public String returnListFLY(){
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
			compositor="APPLE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}		
		//3 ��ȡ��ѯ��������
       //��ѯ�����������������Ա𡢳������ڡ��������ڡ���������/�˲��Ϸ��ࡢ�˲���ԭ��״̬/�˲��Ͻ��
		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","APPLE_DATE_START","APPLE_DATE_END","BACK_TYPE","RETURN_REASON","BACK_RESULT");
		
		//��ȡ����Ժ��¼�˵ĸ���ԺId
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.returnListFLY(conn,oId,data,pageSize,page,compositor,ordertype);
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
                        log.logError("ChildReturnAction��Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
        return  SUCCESS;
    }
   /**
	 * ʡ����ͯ�����˲���ȷ���б�
	 * @return
	 */
   public String returnListST(){
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
			compositor="APPLE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}		
		//3 ��ȡ��ѯ��������
       //��ѯ�����������������Ա𡢳������ڡ�����Ժ���˲���ԭ����������/�˲��Ϸ��ࡢ״̬/�˲��Ͻ������������
		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","WELFARE_ID","RETURN_REASON","BACK_TYPE","BACK_RESULT","APPLE_DATE_START","APPLE_DATE_END");
		
		//��ȡʡ����½�˵���֯��������
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.returnListST(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
	 * ���ģ����ò�����ͯ�����˲���ȷ���б�
	 * @return
	 */
   public String returnListZX(){
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
			compositor="APPLE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}		
		//3 ��ȡ��ѯ��������
		//��ѯ�����������������Ա𡢳������ڡ�ʡ�ݡ�����Ժ���˲���ԭ���˲��Ϸ���/�������͡�״̬/�˲��Ͻ������������
		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","RETURN_REASON","BACK_TYPE","BACK_RESULT","APPLE_DATE_START","APPLE_DATE_END");

        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
            DataList dl=handler.returnListZX(conn,data,pageSize,page,compositor,ordertype);
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
	 * ����Ժ��ͯ�����˲���ѡ���б� 
	 * @return
	 */
   public String returnSelectFLY(){
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
       //��ѯ�����������������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ����״̬����ͯ״̬
		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","AUD_STATE");
		
		//��ȡ����Ժ��¼�˵ĸ���ԺId
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
        try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList 
            DataList dl=handler.returnSelectFLY(conn,oId,data,pageSize,page,compositor,ordertype);
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
	 * ʡ����ͯ�����˲���ѡ���б� 
	 * @return
	 */
  public String returnSelectST(){
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
      //��ѯ��������������Ժ���������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ����״̬����ͯ״̬
		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","AUD_STATE");
		
		//��ȡʡ����½�˵���֯��������
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
       try {
		    //4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList 
           DataList dl=handler.returnSelectST(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
		 * ���Ķ�ͯ�����˲���ѡ���б� 
		 * @return
		 */
	public String returnSelectZX(){
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
	    //��ѯ����������ʡ�ݡ�����Ժ���������Ա𡢳������ڡ���ͯ���͡��������ࡢ������ڡ����״̬����ͯ״̬
			Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","AUD_STATE");
	     try {
			    //4 ��ȡ���ݿ�����
				conn = ConnectionManager.getConnection();
				//5 ��ȡ����DataList 
	         DataList dl=handler.returnSelectZX(conn,data,pageSize,page,compositor,ordertype);
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
    * ��ͯ�����˲�������ҳ��
    */
   public String toReturnAdd(){
       String CI_ID= getParameter("CI_ID");
       String RETURN_LEVEL=getParameter("RETURN_LEVEL");
       Connection conn = null;
          try {
              conn = ConnectionManager.getConnection();
              Data showdata = handler.getChildInfoById(conn, CI_ID);
              UserInfo user=SessionInfo.getCurUser();
              Person person=user.getPerson();
              String pName=person.getCName();
              if(showdata!=null){
           	   showdata.add("APPLE_PERSON_NAME", pName);//����������
           	   showdata.add("APPLE_DATE",new Date());//��������
              }
              setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
              setAttribute("RETURN_LEVEL", RETURN_LEVEL);
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
    * ��ͯ�����˲������루��¼�����ύ����
    * @return
    */
	public String saveReturnData(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","CI_ID","APPLE_TYPE","UPLOAD_IDS","RETURN_REASON");
		Data childData=new Data();
		String Signal=getParameter("RETURN_LEVEL");
		try {
       	//2 ��ȡ���ݿ�����
           conn = ConnectionManager.getConnection();
           //3��������
           dt = DBTransaction.getInstance(conn);
            childData=handler.getChildInfoById(conn, data.getString("CI_ID"));
            //��Ӷ�ͯ�����Ϣ
            data.add("PROVINCE_ID", childData.getString("PROVINCE_ID"));
            data.add("WELFARE_ID", childData.getString("WELFARE_ID"));
            data.add("NAME", childData.getString("NAME"));
            data.add("SEX", childData.getString("SEX"));
            data.add("BIRTHDAY", childData.getString("BIRTHDAY"));
            //��������ˣ���¼�ˣ������Ϣ
   			UserInfo curuser = SessionInfo.getCurUser();
   			data.add("APPLE_PERSON_ID", curuser.getPersonId());	//�������ID
   			data.add("APPLE_PERSON_NAME", curuser.getPerson().getCName());	//�������������
   			data.add("APPLE_DATE", DateUtility.getCurrentDate());	//�����������
   			//�����������������˲��Ϸ��ࣨ����Ժ���롢ʡ����¼�����Ĵ�¼��
   			if("1".equals(Signal)){
   				data.add("BACK_TYPE",ChildStateManager.CHILD_BACK_TYPE_FSQ);//�˲��Ϸ���Ϊ:����Ժ��������
   				data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_SDS);//ʡ����
   				childData.add("RETURN_TYPE", ChildStateManager.CHILD_BACK_TYPE_FSQ);//��ͯ���ϻ�����Ϣ���е��˲��Ϸ���Ϊ������Ժ��������
   			}else if("2".equals(Signal)){
   				data.add("BACK_TYPE",ChildStateManager.CHILD_BACK_TYPE_SSQ);//�˲��Ϸ���Ϊ:ʡ����������
   				data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_ZXDS);//���Ĵ���
   			    //���ʡ��ȷ����Ϣ
   				data.add("ST_CONFIRM_USERID", curuser.getPersonId());	//���ʡ��ȷ����id
   	   			data.add("ST_CONFIRM_USERNAME", curuser.getPerson().getCName());	//���ʡ��ȷ��������
   	   			data.add("ST_CONFIRM_DATE", DateUtility.getCurrentDate());	//���ʡ��ȷ������
   				childData.add("RETURN_TYPE",ChildStateManager.CHILD_BACK_TYPE_SSQ);//��ͯ���ϻ�����Ϣ���е��˲��Ϸ���Ϊ��ʡ����������
   			}else if("3".equals(Signal)){
   				data.add("BACK_TYPE",ChildStateManager.CHILD_BACK_TYPE_ZXTW);//�˲��Ϸ���Ϊ:���ò�����¼��
   				data.add("BACK_RESULT","1");//�����˲��Ͻ��Ϊ��ȷ��
   				data.add("BACK_DATE", DateUtility.getCurrentDate());//������������
   			    //�������ȷ����Ϣ
   				data.add("ZX_CONFIRM_USERID", curuser.getPersonId());	//�������ȷ����id
   	   			data.add("ZX_CONFIRM_USERNAME", curuser.getPerson().getCName());	//�������ȷ��������
   	   			data.add("ZX_CONFIRM_DATE", DateUtility.getCurrentDate());	//�������ȷ������
   				childData.add("RETURN_TYPE", ChildStateManager.CHILD_BACK_TYPE_ZXTW);//��ͯ���ϻ�����Ϣ���е��˲��Ϸ���Ϊ�����ò�����¼��
   			}
   			//���ö�ͯ���ϻ�����Ϣ�����˲��ϱ�־Ϊ���˲���
             childData.add("RETURN_STATE",ChildStateManager.CHILD_RETURN_STATE_FLAG);
            //���¶�ͯ���ϻ�����Ϣ���˲����������
            new ChildManagerHandler().save(conn, childData);
            //�����˲�����Ϣ
            handler.save(conn, data);
            InfoClueTo clueTo = new InfoClueTo(0, "�����ɹ�!");
            setAttribute("clueTo", clueTo);
            AttHelper.publishAttsOfPackageId(data.getString("UPLOAD_IDS"), "CI");
            dt.commit();
           
       } catch (DBException e) {
       	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ�����˲��������ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
           if (log.isError()) {
               log.logError("�����쳣[��ͯ�����˲��������ύ����]:" + e.getMessage(),e);
           }
           
           InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
           setAttribute("clueTo", clueTo);
           Signal = "error1";
       } catch (SQLException e) {
       	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ�����˲��������ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
           try {
               dt.rollback();
           } catch (SQLException e1) {
               e1.printStackTrace();
           }
           if (log.isError()) {
               log.logError("��ͯ�����˲��������ύ�����쳣:" + e.getMessage(),e);
           }
           InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
           setAttribute("clueTo", clueTo);
           
           Signal = "error1";
       } catch (Exception e) {
          	//6�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ�����˲��������ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
          try {
              dt.rollback();
          } catch (SQLException e1) {
              e1.printStackTrace();
          }
          if (log.isError()) {
              log.logError("��ͯ�����˲��������ύ�����쳣:" + e.getMessage(),e);
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
                       log.logError("ChildReturnAction��saveReturnData.Connection������쳣��δ�ܹر�",e);
                   }
                   e.printStackTrace();
                   
                   Signal = "error2";
               }
           }
       }
       return Signal;
	}
    /**
    * ��ͯ�����˲�������ȷ��ҳ��
    */
   public String toConfirm(){
       String AR_ID= getParameter("AR_ID");
       String CONFIRM_LEVEL=getParameter("CONFIRM_LEVEL");
       Connection conn = null;
          try {
              conn = ConnectionManager.getConnection();
              Data showdata = handler.getConfirmDataByID(conn, AR_ID);
              setAttribute("CONFIRM_LEVEL", CONFIRM_LEVEL);
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
    * ��ͯ�����˲���ȷ�ϡ�ȡ���˲��ϲ���
    * @return
    */
	public String saveConfirmResult(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","CI_ID","AR_ID","ST_CONFIRM_REMARK","ZX_CONFIRM_REMARK");
		Data childData=new Data();
		String Signal=getParameter("CONFIRM_LEVEL");
		String confirmResult=getParameter("result");
		ChildManagerHandler childHandler=new ChildManagerHandler();
		try {
	       	   //2 ��ȡ���ݿ�����
	            conn = ConnectionManager.getConnection();
	            //3��������
	            dt = DBTransaction.getInstance(conn);
	            childData=handler.getChildInfoById(conn, data.getString("CI_ID"));
	            UserInfo curuser = SessionInfo.getCurUser();
	            if("1".equals(confirmResult)){//ȷ�ϲ���
		       			if("2".equals(Signal)){//ʡ��ȷ�ϲ���
		       				    data.removeData("ZX_CONFIRM_REMARK");
			       				String aud_state=childData.getString("AUD_STATE");
			       				data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_ZXDS);//ʡ����ȷ��
			       				data.add("ST_CONFIRM_USERID", curuser.getPersonId());	//���ʡ��ȷ����Id
			       	   			data.add("ST_CONFIRM_USERNAME", curuser.getPerson().getCName());	//���ʡ��ȷ��������
			       	   			data.add("ST_CONFIRM_DATE", DateUtility.getCurrentDate());	//���ʡ��ȷ������
			       	   			//�����ͯ������ʡ���������˲��Ͻ��Ϊ��ȷ�ϡ������˲������ڣ�ȷ����Ч���ڣ�
			       				if(ChildStateManager.CHILD_AUD_STATE_SDS.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_SSHZ.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_STG.equals(aud_state)){
			       					data.add("BACK_RESULT","1");//��ȷ��
			           				data.add("BACK_DATE", DateUtility.getCurrentDate());//�˲�������
			       				}
			       			    //�����˲�����Ϣ
			                    handler.save(conn, data);
			                    InfoClueTo clueTo = new InfoClueTo(0, "�����ɹ�!");
			                    setAttribute("clueTo", clueTo);
		       			}else if("3".equals(Signal)){//����ȷ�ϲ���
		       				    data.removeData("ST_CONFIRM_REMARK");
			       				String childType=childData.getString("CHILD_TYPE");
			       				String matchState=childData.getString("MATCH_STATE");
			       				String pubState=childData.getString("PUB_STATE");
			       				//�ж϶�ͯ�Ƿ���ƥ��
			       				if(ChildStateManager.CHILD_MATCH_STATE_DONE.equals(matchState)){
			       					InfoClueTo clueTo = new InfoClueTo(0, "     ����ʧ�ܣ��ö�ͯ��ƥ��,���Ƚ��ƥ�����˲���!");
			       	                setAttribute("clueTo", clueTo);
			       				}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ�����ж��Ƿ�Ԥ��������Ƿ�����
			       					if(ChildStateManager.CHILD_PUB_STATE_REQ.equals(pubState)){
				   						InfoClueTo clueTo = new InfoClueTo(0, "     ����ʧ�ܣ��ö�ͯ�ѵݽ�Ԥ������,���ȳ���Ԥ�����˲���!");
				       	                setAttribute("clueTo", clueTo);
			       					}else if(ChildStateManager.CHILD_PUB_STATE_LOCK.equals(pubState)){
			       						InfoClueTo clueTo = new InfoClueTo(0, "     ����ʧ�ܣ��ö�ͯ������,���Ƚ���������˲���!");
				       	                setAttribute("clueTo", clueTo);
			       					}else{//�����ͯȷ��ͨ��
			       	       				data.add("ZX_CONFIRM_USERID", curuser.getPersonId());	//�������ȷ����Id
			       	       	   			data.add("ZX_CONFIRM_USERNAME", curuser.getPerson().getCName());	//�������ȷ��������
			       	       	   			data.add("ZX_CONFIRM_DATE", DateUtility.getCurrentDate());	//�������ȷ������
			       	       	        	data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_TG);//������ȷ��
			       	       	   			data.add("BACK_RESULT","1");//��ȷ��
					       				data.add("BACK_DATE", DateUtility.getCurrentDate());//�˲�������
					       				handler.save(conn, data);
					       				InfoClueTo clueTo = new InfoClueTo(0, "�����ɹ�!");
					                    setAttribute("clueTo", clueTo);
			       				   }
			       			   }else{//������ͯȷ��ͨ��
				       				data.add("ZX_CONFIRM_USERID", curuser.getPersonId());	//�������ȷ����Id
		       	       	   			data.add("ZX_CONFIRM_USERNAME", curuser.getPerson().getCName());	//�������ȷ��������
		       	       	   			data.add("ZX_CONFIRM_DATE", DateUtility.getCurrentDate());	//�������ȷ������
		       	       	        	data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_TG);//������ȷ��
		       	       	   			data.add("BACK_RESULT","1");//��ȷ��
				       				data.add("BACK_DATE", DateUtility.getCurrentDate());//�˲�������
				       				handler.save(conn, data);
				       				InfoClueTo clueTo = new InfoClueTo(0, "�����ɹ�!");
				                    setAttribute("clueTo", clueTo);
			       			 }
		       		}
	         }else if("0".equals(confirmResult)){//ȡ���˲��ϲ���
	        	//���ö�ͯ���ϻ�����Ϣ�����˲��ϱ�־Ϊ��null,�˲��Ϸ���Ϊ��null
	            childData.add("RETURN_STATE","");
	            childData.add("RETURN_TYPE","");
	           //���¶�ͯ���ϻ�����Ϣ���˲����������
	            childHandler.save(conn, childData);
	           //�����˲��ϼ�¼���е��˲���״̬RETURN_STATEΪ��ȡ���˲���
	           data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_QX);
	           //�����˲�����Ϣ
	           handler.save(conn, data);
	           InfoClueTo clueTo = new InfoClueTo(0, "�����ɹ�!");
	           setAttribute("clueTo", clueTo);
	        }
	        dt.commit();
       } catch (DBException e) {
       	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ�����˲���ȷ��/ȡ���˲��ϲ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
           if (log.isError()) {
               log.logError("�����쳣[��ͯ�����˲���ȷ��/ȡ���˲��ϲ���]:" + e.getMessage(),e);
           }
           
           InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
           setAttribute("clueTo", clueTo);
           Signal = "error1";
       } catch (SQLException e) {
       	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ�����˲���ȷ��/ȡ���˲��ϲ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
           try {
               dt.rollback();
           } catch (SQLException e1) {
               e1.printStackTrace();
           }
           if (log.isError()) {
               log.logError("��ͯ�����˲���ȷ��/ȡ���˲��ϲ����쳣:" + e.getMessage(),e);
           }
           InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
           setAttribute("clueTo", clueTo);
           
           Signal = "error1";
       } catch (Exception e) {
          	//6�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ�����˲���ȷ��/ȡ���˲��ϲ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
          try {
              dt.rollback();
          } catch (SQLException e1) {
              e1.printStackTrace();
          }
          if (log.isError()) {
              log.logError("��ͯ�����˲���ȷ��/ȡ���˲��ϲ����쳣:" + e.getMessage(),e);
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
                       log.logError("ChildReturnAction��saveConfirmResult.Connection������쳣��δ�ܹر�",e);
                   }
                   e.printStackTrace();
                   
                   Signal = "error2";
               }
           }
       }
       return Signal;
	}
}
