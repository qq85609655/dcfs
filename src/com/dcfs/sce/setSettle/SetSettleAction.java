/**   
 * @Title: SetSettleAction.java 
 * @Package com.dcfs.sce.setSettle 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author panfeng   
 * @date 2014-9-16 ����10:02:12 
 * @version V1.0   
 */
package com.dcfs.sce.setSettle;

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
 * @ClassName: SetSettleAction 
 * @Description: ���޲����б����ð��á��������޲��� 
 * @author panfeng 
 * @date 2014-9-16
 *  
 */
public class SetSettleAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(SetSettleAction.class);

    private SetSettleHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public SetSettleAction(){
        this.handler=new SetSettleHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * @Title: settleParaList 
	 * @Description: ���޲����б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String settleParaList(){
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.settleParaList(conn,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
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
	 * �����޸İ��á������������ô���
	 * @author Panfeng
	 * @date 2014-9-16 
	 * @return
	 */
	public String showSettleMonth(){
		//1 ��ȡҳ�������ID
		String uuid = getParameter("showuuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data showdata = handler.getSettleData(conn, uuid);
			
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
     * ���氲�á�������������
	 * @author panfeng
	 * @date 2014-9-16
     * @return
     */
    public String saveSettleMonth(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","SETTLE_ID","SETTLE_MONTHS","DEADLINE");
        System.out.println(data);
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            success=handler.saveSettleMonth(conn,data);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "����ɹ�!");//����ɹ� 0
                setAttribute("clueTo", clueTo);
            }
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	
	
	
}
