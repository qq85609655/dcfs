package com.dcfs.ncm.leaderSign;

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
import hx.util.UtilDateTime;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchAction;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.common.FarCommonAction;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

public class LeaderSignAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(LeaderSignAction.class);
	
	private Connection conn = null;
    
	private LeaderSignHandler handler;
    
	private DBTransaction dt = null;//������
    
	private String retValue = SUCCESS;
	
	public LeaderSignAction(){
        this.handler=new LeaderSignHandler();
    }
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	/**
     * 
     * @Title: FindLeaderSignList
     * @Description: ��ѯ�쵼ǩ�������б�
     * @author: 
     * @date:
     * @return
     */
    public String FindLeaderSignList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","FILE_TYPE","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","SIGN_SUBMIT_DATE_START","SIGN_SUBMIT_DATE_END","MALE_NAME","FEMALE_NAME","SIGN_DATE_START","SIGN_DATE_END","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","PROVINCE_ID","WELFARE_ID","SIGN_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findLeaderSignList(conn,data,pageSize,page,compositor,ordertype);
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
     * ����ǩ����ҳ�淽��
     */
    public String InSignfrom(){
    	
    	String chioceuuid = getParameter("ids");
    	String MI_ID = chioceuuid.split("#")[1];
    	try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            MatchHandler matchHandler = new MatchHandler();
            Data data=matchHandler.getNcmMatchInfo(conn,MI_ID);
            data.add("SIGN_DATE", DateUtility.getCurrentDate());//ǩ����Ϣ_ǩ������
            //6 �������д��ҳ����ձ���
            setAttribute("LeaderSign_form_data", data);
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
     * ǩ��ȷ�Ϸ���
     */
    public String SignConfirm(){
    	//ƥ��ID
    	String mi_id = getRequest().getParameter("MI_ID");
    	//�������
    	String sign_date = getRequest().getParameter("F_SIGN_DATE");
    	String sign_state = getRequest().getParameter("F_SIGN_STATE");
    	//����code
    	String Country_Code = getRequest().getParameter("PROVINCE_ID");
    	//ʡ��code
    	String province_Code = getRequest().getParameter("COUNTRY_CODE");
    	//�������ݸ��¶���
    	Data data = new Data();
    	data.add("MI_ID", mi_id);
    	data.add("SIGN_STATE", sign_state);
    	//��ȡ��ǰǩ������Ϣ
      	UserInfo curuser = SessionInfo.getCurUser();
      	data.add("SIGN_USERID", curuser.getPersonId());
      	data.add("SIGN_USERNAME", curuser.getPerson().getCName());
      	data.add("SIGN_DATE", sign_date);
      	
      	FarCommonAction ca = new FarCommonAction();
      	try {
      		
            conn = ConnectionManager.getConnection();
            dt=DBTransaction.getInstance(conn);
            if("1".equals(sign_state)){
                data.add("NOTICE_SIGN_DATE", sign_date);
                data.add("NOTICECOPY_SIGN_DATE", sign_date);
                data.add("NOTICE_STATE", "0");
                //���ǩ����
                String sign_sn = ca.createSignSN(conn,province_Code,Country_Code);
                data.add("SIGN_NO", sign_sn);
            }
            handler.saveSignDate(conn,data);
            if("1".equals(sign_state)){
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.ZXLD_TZS_QPTG);
                MatchHandler MHandler = new MatchHandler();
                Data MIdata = MHandler.getNcmMatchInfo(conn, mi_id);
                String AF_ID = MIdata.getString("AF_ID");
                _data.add("AF_ID", AF_ID);
                FileCommonManager AFhandler = new FileCommonManager();
                AFhandler.modifyFileInfo(conn, _data);//�޸������˵�ƥ����Ϣ
                
                //����ȫ��״̬��λ��
                Data CIdata = new Data();
                String CI_ID = MIdata.getString("CI_ID");
                CIdata.add("CI_ID", CI_ID);
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.noticeToBeSent(CIdata, SessionInfo.getCurUser().getCurOrgan());
                ChildManagerHandler childManagerHandler = new ChildManagerHandler();
                childManagerHandler.save(conn, CIdata);
                
                MatchAction matchAction = new MatchAction();
                matchAction.noticeOfTravellingToChinaForAdoption(conn, mi_id, "0", "1");//����������Ů֪ͨ��
                matchAction.noticeForAdoption(conn, mi_id, "0");//��������֪ͨ
            }
            
            dt.commit();
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "���ݲ����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("���ݲ����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (SQLException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "���ݲ����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            try {
				dt.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("���ݲ����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally {
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
	 * @Title: signConfirmAll
	 * @Description: ����ǩ��
	 * @author: xugy
	 * @date: 2014-11-27����3:48:59
	 * @return
	 */
    public String signConfirmAll(){
        //ƥ��ID
        String ids = getParameter("ids");
        String[] IDarry = ids.split("#");
        //�������
        String SIGN_DATE = getParameter("SIGN_DATE");
        String SIGN_STATE = getParameter("SIGN_STATE");
        try {
            
            conn = ConnectionManager.getConnection();
            dt=DBTransaction.getInstance(conn);
            //�������ݸ��¶���
            for(int i=1;i<IDarry.length;i++){
                MatchHandler matchHandler = new MatchHandler();
                Data MIdata=matchHandler.getNcmMatchInfo(conn,IDarry[i]);
                String PROVINCE_ID = MIdata.getString("PROVINCE_ID");
                String COUNTRY_CODE = MIdata.getString("COUNTRY_CODE");
                
                Data data = new Data();
                data.add("MI_ID", IDarry[i]);
                data.add("SIGN_STATE", SIGN_STATE);
                //��ȡ��ǰǩ������Ϣ
                UserInfo curuser = SessionInfo.getCurUser();
                data.add("SIGN_USERID", curuser.getPersonId());
                data.add("SIGN_USERNAME", curuser.getPerson().getCName());
                data.add("SIGN_DATE", SIGN_DATE);
                data.add("NOTICE_SIGN_DATE", SIGN_DATE);
                data.add("NOTICECOPY_SIGN_DATE", SIGN_DATE);
                data.add("NOTICE_STATE", "0");
                FarCommonAction ca = new FarCommonAction();
                //���ǩ����
                String sign_sn = ca.createSignSN(conn,PROVINCE_ID,COUNTRY_CODE);
                data.add("SIGN_NO", sign_sn);
                handler.saveSignDate(conn,data);
                
                MatchAction matchAction = new MatchAction();
                matchAction.noticeOfTravellingToChinaForAdoption(conn, IDarry[i], "0", "1");//����������Ů֪ͨ��
                matchAction.noticeForAdoption(conn, IDarry[i], "0");//��������֪ͨ
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "ǩ���ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "���ݲ����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("���ݲ����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ǩ��ʧ��!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
            retValue = "error1";
            
        } catch (SQLException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "���ݲ����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("���ݲ����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ǩ��ʧ��!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
            retValue = "error2";
            
        } catch (Exception e) {
            setAttribute(Constants.ERROR_MSG_TITLE, "���ݲ����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                // TODO Auto-generated catch block
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("���ݲ����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ǩ��ʧ��!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
            retValue = "error3";
        }finally {
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
	


}
