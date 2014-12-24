package com.dcfs.ncm.CIReturn;

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

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchHandler;
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @Title: ChildInfoReturnAction.java
 * @Description: �������˻ز��ϵ����ò�
 * @Company: 21softech
 * @Created on 2014-12-16 ����7:26:50
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChildInfoReturnAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(ChildInfoReturnAction.class);
    private Connection conn = null;
    private ChildInfoReturnHandler handler;
    private DBTransaction dt = null;//������
    private String retValue = SUCCESS;
    
    public ChildInfoReturnAction() {
        this.handler=new ChildInfoReturnHandler();
    }
    
    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: AZBApplyCIReturnList
     * @Description: ���ò���������˻��б�
     * @author: xugy
     * @date: 2014-12-16����8:54:38
     * @return
     */
    public String AZBApplyCIReturnList(){
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
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","APPLY_USER","APPLY_DATE_START","APPLY_DATE_END","CONFIRM_DATE_START","CONFIRM_DATE_END","APPLY_STATE","CONFIRM_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAZBApplyCIReturnList(conn,data,pageSize,page,compositor,ordertype);
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
     * 
     * @Title: AZBSelectDABCIList
     * @Description: ���ò�ѡ�����ƽ��Ķ�ͯ�����б�
     * @author: xugy
     * @date: 2014-12-17����10:48:40
     * @return
     */
    public String AZBSelectDABCIList(){
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
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","TRANSFER_DATE_START","TRANSFER_DATE_END","RECEIVER_DATE_START","RECEIVER_DATE_END");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findAZBSelectDABCIList(conn,data,pageSize,page,compositor,ordertype);
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
     * 
     * @Title: toAZBApplyCIReturnAdd
     * @Description: �������
     * @author: xugy
     * @date: 2014-12-17����12:41:14
     * @return
     */
    public String toAZBApplyCIReturnAdd(){
        String ids = getParameter("ids");//��ͯ����ID���������ļ�ID
        String CI_ID = ids.split(",")[0];//��ͯ����ID
        String AF_ID = ids.split(",")[1];//�������ļ�ID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data.add("CI_ID", CI_ID);
            data.add("AF_ID", AF_ID);
            data.add("APPLY_USER", SessionInfo.getCurUser().getPerson().getCName());//���������
            data.add("APPLY_DATE", DateUtility.getCurrentDate());//�������
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
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
     * @Title: saveAZBApplyCIReturnAdd
     * @Description: ������������
     * @author: xugy
     * @date: 2014-12-17����1:19:32
     * @return
     */
    public String saveAZBApplyCIReturnAdd(){
        Data data = getRequestEntityData("F_","NAR_ID","AF_ID","CI_ID","APPLY_INFO");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            data.add("REV_TYPE", "1");//�������
            data.add("APPLY_DATE", DateUtility.getCurrentDate());//��������
            data.add("APPLY_USER", SessionInfo.getCurUser().getPerson().getCName());//������
            data.add("APPLY_DEPT", SessionInfo.getCurUser().getCurOrgan().getCName());//���벿��
            data.add("APPLY_STATE", "1");//ȷ��״̬
            handler.saveNcmArchRevocation(conn, data);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���뱣��ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //�������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "���뱣��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���뱣��ʧ��!");
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
        return retValue;
    }
    
    /**
     * 
     * @Title: DABRevokeArchiveList
     * @Description: ���������������б�
     * @author: xugy
     * @date: 2014-12-17����1:56:42
     * @return
     */
    public String DABRevokeArchiveList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","SIGN_NO","SIGN_DATE_START","SIGN_DATE_END","PROVINCE_ID","WELFARE_ID","NAME","FILE_NO","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","ARCHIVE_STATE","CONFIRM_USER","CONFIRM_DATE_START","CONFIRM_DATE_END","APPLY_STATE");
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findDABRevokeArchiveList(conn,data,pageSize,page,compositor,ordertype);
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
     * 
     * @Title: toDABRevokeArchiveAdd
     * @Description: �����������������
     * @author: xugy
     * @date: 2014-12-17����3:33:32
     * @return
     */
    public String toDABRevokeArchiveAdd(){
        String ids = getParameter("ids");//���볷������ID��ƥ����ϢID
        String NAR_ID = ids.split(",")[0];//���볷������ID
        String MI_ID = ids.split(",")[1];//ƥ����ϢID
        try {
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            Data data = handler.getNcmArchRevocation(conn, NAR_ID);
            data.add("MI_ID", MI_ID);
            data.add("CONFIRM_USER", SessionInfo.getCurUser().getPerson().getCName());
            data.add("CONFIRM_DATE", DateUtility.getCurrentDate());
            
            //�������д��ҳ����ձ���
            setAttribute("data",data);
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
     * @Title: saveDABRevokeArchiveAdd
     * @Description: ����������������ӱ���
     * @author: xugy
     * @date: 2014-12-17����4:21:14
     * @return
     */
    public String saveDABRevokeArchiveAdd(){
        Data data = getRequestEntityData("F_","NAR_ID","CONFIRM_STATE","CONFIRM_INFO");
        try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            data.add("CONFIRM_DATE", DateUtility.getCurrentDate());//ȷ������
            data.add("CONFIRM_USER", SessionInfo.getCurUser().getPerson().getCName());//ȷ����
            data.add("CONFIRM_DEPT", SessionInfo.getCurUser().getCurOrgan().getCName());//ȷ�ϲ���
            data.add("APPLY_STATE", "2");//ȷ��״̬
            String CONFIRM_STATE = data.getString("CONFIRM_STATE");
            if("1".equals(CONFIRM_STATE)){//ͬ��
                String CI_ID = getParameter("F_CI_ID");
                String MI_ID = getParameter("F_MI_ID");
                Data ARdata = handler.getNcmArchiveInfo(conn, MI_ID);
                String ARCHIVE_STATE = ARdata.getString("ARCHIVE_STATE", "");
                if(!"".equals(ARCHIVE_STATE)){//�ѹ鵵
                    ARdata.add("ARCHIVE_DATE", "");//�鵵����
                    ARdata.add("ARCHIVE_USERID", "");//�鵵��ID
                    ARdata.add("ARCHIVE_USERNAME", "");//�鵵������
                    ARdata.add("ARCHIVE_STATE", "0");//�鵵״̬
                    ARdata.add("ARCHIVE_VALID", "0");//�Ƿ���Ч
                    MatchHandler matchHandler = new MatchHandler();
                    matchHandler.saveNcmArchiveInfo(conn, ARdata);
                }
                
                //��ͯ���ϴӵ������ƽ������ò�
                DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//������ϸID
                transferData.add("APP_ID", CI_ID);//ҵ���¼ID
                transferData.add("TRANSFER_CODE", TransferCode.RFM_CHILDINFO_DAB_AZB);//�ƽ����ͣ�������-->���ò�
                transferData.add("TRANSFER_STATE", "0");//�ƽ�״̬
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);//����һ���ƽ���Ϣ
                
                //����ȫ��״̬��λ��
                Data CIdata = new Data();
                CIdata.add("CI_ID", CI_ID);
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.returnCINotTransfer(CIdata, SessionInfo.getCurUser().getCurOrgan());
                ChildManagerHandler childManagerHandler = new ChildManagerHandler();
                childManagerHandler.save(conn, CIdata);
            }
            handler.saveNcmArchRevocation(conn, data);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "����ȷ�ϳɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //�����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //�������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "����ȷ��ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "����ȷ��ʧ��!");
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
        return retValue;
    }

}
