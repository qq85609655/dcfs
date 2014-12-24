package com.dcfs.sce.overageRemind;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;

import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;


/** 
 * @ClassName: OverageRemindAction 
 * @Description: ���ò���ѯ���鿴�������������á������Զ��˲��ϲ��� 
 * @author panfeng 
 * @date 2014-9-16
 *  
 */
public class OverageRemindAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(OverageRemindAction.class);

    private OverageRemindHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public OverageRemindAction(){
        this.handler=new OverageRemindHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * @Title: overageRemindList 
	 * @Description: ��ͯ���������б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String overageRemindList(){
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		//3 ��ȡ��ѯ��������
		Data data = getRequestEntityData("S_","PROVINCE_ID","NAME","SEX","BIRTHDAY_START",
					"BIRTHDAY_END","CHILD_TYPE","SN_TYPE","DISEASE_CN","AUD_STATE","PUB_STATE");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.overageRemindList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
            setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��Ǽǲ�ѯ�����쳣");
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
	 * 
	 * @Title: showChildInfo
	 * @Description: ��ʾ��ͯ��Ϣ
	 * @author: panfeng
	 * @date: 2014-9-16
	 * @return
	 */
	public String showChildInfo(){
	    String CIids = getParameter("CIids");//��ͯID����ͬ���Ķ��ID
	    String[] CIidArry = CIids.split(",");
	    try {
	        //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            String ids = "";
            for(int i=0;i<CIidArry.length;i++){
                String CIid = CIidArry[i];
                if(i==0){
                    ids = "'" + CIid + "'";
                }else{
                    ids = ids + ",'" + CIid + "'";
                }
            }
            //��ȡ����DataList
            DataList CIdls=handler.getChildrenData(conn,ids);
            //�������д��ҳ����ձ���
            setAttribute("CIdls",CIdls);
	    }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
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
	 * 
	 * @Title: showTwinsInfo
	 * @Description: �鿴��ͯͬ����Ϣ
	 * @author: panfeng
	 * @date: 2014-9-16
	 * @return
	 */
	public String showTwinsInfo(){
	    String CIids = getParameter("CIids");//��ͯͬ��ID������ID
        String[] CIidArry = CIids.split(",");
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            String ids = "";
            for(int i=0;i<CIidArry.length;i++){
                String CIid = CIidArry[i];
                if(i==0){
                    ids = "'" + CIid + "'";
                }else{
                    ids = ids + ",'" + CIid + "'";
                }
            }
            //��ȡ����DataList
            DataList CIdls=handler.getChildrenData(conn,ids);
            //�������д��ҳ����ձ���
            setAttribute("CIdls",CIdls);
        }catch (DBException e) {
            //�����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //�ر����ݿ�����
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
	 * @Title: changeRemindMark 
	 * @Description: ���ݶ�ʱ���Զ�ɨ�裬�����㳬���������ƣ���ǰ1�꣩�Ķ�ͯ���ı䳬�����ѱ�ʶΪ"1"���������ѣ�
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String changeRemindMark(){
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// ��ȡ�ύ��������ݽ��
			
			//TODO:ͳһ���ö�ʱ������
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	// �ر����ݿ�
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
	 * @Title: changeOverageMark 
	 * @Description: ���ݶ�ʱ���Զ�ɨ�裬�����㳬�����ƵĶ�ͯ���ı䳬�����ѱ�ʶΪ"2"���ѳ��䣩
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String changeOverageMark(){
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// ��ȡ�ύ��������ݽ��
			
			//TODO:ͳһ���ö�ʱ������
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	// �ر����ݿ�
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
	
}
