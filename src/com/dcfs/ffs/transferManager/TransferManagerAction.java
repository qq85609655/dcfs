/**
 * @Title: TransferManagerAction.java
 * @Package com.dcfs.ffs.transferManager
 * @Description:  
 * @author xxx   
 * @project DCFS 
 * @date 2014-7-29 10:44:21
 * @version V1.0   
 */
package com.dcfs.ffs.transferManager;

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

import javax.servlet.http.HttpSession;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.common.FarCommonHandler;
import com.dcfs.ncm.special.SpecialMatchAction;
import com.dcfs.pfr.DAB.DABPPFeedbackAction;
import com.dcfs.pfr.DAB.DABPPFeedbackHandler;
import com.dcfs.rfm.DABdisposal.DABdisposalHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;

/**
 * @Title: TransferManagerAction.java
 * @Description:????
 * @Created on 2014-7-29 10:44:21
 * @author wuty
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class TransferManagerAction extends BaseAction {

    private static Log log = UtilLog.getLog(TransferManagerAction.class);

    private TransferManagerHandler handler;
    private FileCommonManager AFhandler;

    private Connection conn = null;// ���ݿ�����

    private DBTransaction dt = null;// ������

    private String retValue = SUCCESS;

    public TransferManagerAction() {
        this.handler = new TransferManagerHandler();
        this.AFhandler=new FileCommonManager();
    }

    public String execute() throws Exception {
        return null;
    }

    /**
     * �����ƽ�ҳ��
     * 
     * @return
     */
    public String TransferAdd() {
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");//��������
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");//���Ӵ���
        DataList datalist = new DataList();
        Data data = new Data();
        
        
        
        setAttribute("Transfer_Detail_DataList", datalist);
        setAttribute("Edit_Transfer_data", data);
        setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        /*try{
            //��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
        }catch (DBException e) {
            setAttribute(Constants.ERROR_MSG_TITLE, "���ӵ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
        } catch (SQLException e) {
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
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
        }*/
        return retValue;
    }

    /**
     * 
     * @Title: TransferListSave
     * @Description: ���潻�ӵ�
     * @author: xugy
     * @date: 2014-12-8����3:47:53
     * @return
     */
    public String TransferListSave() {
        // ��װ���ӵ���Ϣ����
        Data data = new Data();
        // ���ҳ����Ի�ý��ӵ�ID�������޸ı���
        String TI_ID = getParameter("TI_ID","");
        data.add("TI_ID", TI_ID);
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String OPER_TYPE = getParameter("OPER_TYPE");
        // ���ò�������Ϊ�ƽ�
        data.add("OPER_TYPE", OPER_TYPE);
        // ���ò�������Ϊ�ļ�
        data.add("TRANSFER_TYPE", TRANSFER_TYPE);
        data.add("TRANSFER_CODE", TRANSFER_CODE);

        // ��ȡ��ǰ��½�˼���ǰ��½�˵Ĳ�����Ϣ
        UserInfo curuser = SessionInfo.getCurUser();
        // ��װ�ƽ���ID
        data.add("TRANSFER_USERID", curuser.getPersonId());
        data.add("TRANSFER_USERNAME", curuser.getPerson().getCName());
        // ��װ������Ϣ�����롢��������
        Organ organ = curuser.getCurOrgan();
        data.add("TRANSFER_DEPT_ID", organ.getOrgCode());
        data.add("TRANSFER_DEPT_NAME", organ.getCName());

        
        // ��װ������
        data.add("COPIES", getParameter("COPIES","0"));
        // ��װ�ƽ�����
        data.add("TRANSFER_DATE", UtilDateTime.nowDateString());
        // ��װ���ӵ�״̬Ϊ0���⽻�ӣ�
        data.add("AT_STATE", "0");

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            // ���ӵ�����
            if ("".equals(TI_ID)) {
                FileCommonManager fcm = new FileCommonManager();
                String bh = fcm.createConnectNO(conn, TRANSFER_CODE);
                data.add("CONNECT_NO", bh);//���ӱ��
            } else {
                data.add("CONNECT_NO", getParameter("CONNECT_NO"));
            }
            // �������ӵ�
            TI_ID = handler.TransferListSave(conn, data);
            
            String chioceuuid = getParameter("chioceuuid");
            String[] uuid = chioceuuid.split("#");
            for(int i=0;i<uuid.length;i++){
                String TID_ID = uuid[i];
                // ���½�����ϸ�� "1"�������ƽ�
                Data TIDdata = new Data();
                TIDdata.add("TID_ID", TID_ID);
                TIDdata.add("TI_ID", TI_ID);
                TIDdata.add("TRANSFER_STATE", "1");//����״̬�����ƽ�
                handler.TransferDetailSave(conn, TIDdata);
            }
            //��ͯ����ȫ��״̬          
            if(TransferConstant.TRANSFER_TYPE_CHILD.equals(TRANSFER_TYPE)){//��ͯ����
                ChildCommonManager ccm = new ChildCommonManager();
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_FYGS)){//���ò�-���빫˾
                	ccm.zxPreTranslation(conn,TI_ID, curuser.getCurOrgan());
                }
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){//���ò�-������
                	ccm.childTransferToDABSave(conn,TI_ID,curuser.getCurOrgan());
                }
                if(TRANSFER_CODE.equals(TransferCode.RFM_CHILDINFO_DAB_AZB)){//������-���ò�
                    ccm.returnCIToBeTransfered(conn,TI_ID,curuser.getCurOrgan());
                }
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "����ɹ�!");// ����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
    
    /**
     * �����ύ���ӵ�
     * 
     * @return
     */
    public String TransferSubmit() {
        
        Data data = new Data();
        String updatauuid = getParameter("chioceuuid");
        String[] uuid = updatauuid.split("#");

        String TI_ID = getParameter("TI_ID","");
        data.add("TI_ID", TI_ID);
        String CONNECT_NO = getParameter("CONNECT_NO","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        String transfer_type = getParameter("TRANSFER_TYPE");
        data.add("TRANSFER_TYPE", transfer_type);
        String OPER_TYPE = getParameter("OPER_TYPE");
        data.add("OPER_TYPE", OPER_TYPE);
        // ��װ���ӵ���Ϣ����
        
        data.add("COPIES", uuid.length);

        // ��ȡ��ǰ��½�˼���ǰ��½�˵Ĳ�����Ϣ
        UserInfo curuser = SessionInfo.getCurUser();
        // ��װ�ƽ���ID
        data.add("TRANSFER_USERID", curuser.getPersonId());
        data.add("TRANSFER_USERNAME", curuser.getPerson().getCName());
        // ��װ������Ϣ�����롢��������
        Organ organ = curuser.getCurOrgan();
        data.add("TRANSFER_DEPT_ID", organ.getOrgCode());
        data.add("TRANSFER_DEPT_NAME", organ.getCName());

        // ��װ�ƽ�����
        data.add("TRANSFER_DATE", UtilDateTime.nowDateString());

        // ��װ���ӵ�״̬Ϊ1�����ƽ���
        data.add("AT_STATE", "1");

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            if("".equals(TI_ID)){
                
                FileCommonManager fcm = new FileCommonManager();
                CONNECT_NO = fcm.createConnectNO(conn, TRANSFER_CODE);
            }
            data.add("CONNECT_NO", CONNECT_NO);//���ӱ��
            
            // �ύ���ӵ�
            Data TIdata = handler.saveTransferInfo(conn, data);
            // ���½�����ϸ�� "2"�������ƽ�
            for(int i = 0; i < uuid.length; i++){
                Data TIDdata = new Data();
                TIDdata.add("TID_ID", uuid[i]);
                TIDdata.add("TI_ID", TIdata.getString("TI_ID"));//����״̬
                TIDdata.add("TRANSFER_STATE", "2");//����״̬
                handler.saveTransferInfoDetail(conn, TIDdata);
            }
                        
            //��ͯ����ȫ��״̬
            if(TransferConstant.TRANSFER_TYPE_CHILD.equals(transfer_type)){//��ͯ����
            	ChildCommonManager ccm = new ChildCommonManager();
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_FYGS)){                    
                    ccm.zxSendTranslation(conn,TIdata.getString("TI_ID"), curuser.getCurOrgan());   
                }
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){                    
                    ccm.childTransferToDABSubmit(conn,TIdata.getString("TI_ID"), curuser.getCurOrgan());   
                }
                if(TRANSFER_CODE.equals(TransferCode.RFM_CHILDINFO_DAB_AZB)){//������-���ò�
                    ccm.returnCIIsTransfered(conn,TI_ID,curuser.getCurOrgan());
                }
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");// ����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");// ����ʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");// ����ʧ�� 2
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
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * �����ύ���ӵ�
     * 
     * @return
     */
    public String TransferListBatchSubmit() {
        // ��ȡҳ�洫�ݹ����������ύ�Ľ��ӵ�����
        String chioceuuid = getParameter("chioceuuid");
        String transfer_type = getParameter("TRANSFER_TYPE");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String[] uuid = chioceuuid.split("#");

        // ��װTRANSFER_INFO���޸�����
        DataList dl = new DataList();
        for (int i = 1; i < uuid.length; i++) {
            Data data = new Data();
            data.add("TI_ID", uuid[i]);
            // ��ȡ��ǰ��½�˼���ǰ��½�˵Ĳ�����Ϣ
            UserInfo curuser = SessionInfo.getCurUser();
            // ��װ�ƽ���ID
            data.add("TRANSFER_USERID", curuser.getPersonId());
            data.add("TRANSFER_USERNAME", curuser.getPerson().getCName());
            // ��װ������Ϣ�����롢��������
            Organ organ = curuser.getCurOrgan();
            data.add("TRANSFER_DEPT_ID", organ.getOrgCode());
            data.add("TRANSFER_DEPT_NAME", organ.getCName());

            // ��װ�ƽ�����
            data.add("TRANSFER_DATE", UtilDateTime.nowDateString());
            dl.add(data);
        }
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            // ���½��ӵ� "1"�������ύ
            handler.TransferBatchSubmit(conn, dl,TransferConstant.AT_STATE_DONE);
            // ���½�����ϸ�� "2"�������ƽ�
            for (int i = 1; i < uuid.length; i++) {
                handler.UpdateTransfer(conn, uuid[i]);
            }
            
            if(TransferConstant.TRANSFER_TYPE_CHILD.equals(transfer_type)){
                //���¶�ͯ����ȫ��״̬
                ChildCommonManager ccm = new ChildCommonManager();
                UserInfo curuser = SessionInfo.getCurUser();
                for(int t=0;t<dl.size();t++){                    
	                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_FYGS)){                    
	                    ccm.zxSendTranslation(conn,dl.getData(t).getString("TI_ID"), curuser.getCurOrgan());   
	                }
	                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){                    
	                    ccm.childTransferToDABSubmit(conn,dl.getData(t).getString("TI_ID"), curuser.getCurOrgan());   
	                }
	                if(TRANSFER_CODE.equals(TransferCode.RFM_CHILDINFO_DAB_AZB)){//������-���ò�
	                    ccm.returnCIIsTransfered(conn,dl.getData(t).getString("TI_ID"),curuser.getCurOrgan());
	                }
                }
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");// ����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");// ����ʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύʧ��!");// ����ʧ�� 2
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
                    	log.logError( "TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    e.printStackTrace();
                }
            }
        }

        return retValue;
    }

    /**
     * �鿴����(�������Զ���)
     * 
     * @author xxx
     * @date 2014-7-29 10:44:21
     * @return
     */
    public String show() {
        String uuid = getParameter("UUID");
        String type = getParameter("type");
        try {
            conn = ConnectionManager.getConnection();
            Data showdata = handler.getShowData(conn, uuid);
            setAttribute("data", showdata);
        } catch (DBException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�", e);
                    }
                }
            }
        }
        if ("show".equals(type)) {
            return "show";
        } else if ("mod".equals(type)) {
            return "mod";
        } else {
            return retValue;
        }
    }

    /**
     * ��ӽ��ӵ�ҳ���Ƴ�ѡ�е��б���Ŀ����
     * 
     * @author wty
     * @date
     * @return
     */
    public String RemoveFile() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TI_ID = getParameter("TI_ID","");

        String mannualDeluuid = getParameter("mannualDeluuid");
        String[] deluuid = mannualDeluuid.split("#");
        String chioceuuid = getParameter("chioceuuid");
        String[] uuid = chioceuuid.split("#");

        try {
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String newMannualDeluuid = "";
            if("".equals(TI_ID)){
                int num = 0;
                for(int i=0;i<deluuid.length;i++){
                    boolean b = true;
                    for(int j=0;j<uuid.length;j++){
                        if(uuid[j].equals(deluuid[i])){
                            b = false;
                        }
                    }
                    if(b){
                        if(num==0){
                            newMannualDeluuid = deluuid[i];
                        }else{
                            newMannualDeluuid = newMannualDeluuid + "#" + deluuid[i];
                        }
                        num++;
                    }
                }
            }else{
                String removeMannualDeluuid = "";
                Data TIdata = handler.TransferEdit(conn, TI_ID);
                int COPIES = TIdata.getInt("COPIES");
                int num=0;
                for(int i=0;i<uuid.length;i++){
                    String TID_ID = uuid[i];
                    Data TIDdata = handler.getTransferInfoDetail(conn, TID_ID);
                    if(TIDdata == null){
                        TIDdata = new Data();
                    }
                    String removeTI_ID = TIDdata.getString("TI_ID","");
                    if(!"".equals(removeTI_ID)){
                        TIDdata.add("TID_ID", TID_ID);
                        TIDdata.add("TI_ID", "");
                        TIDdata.add("TRANSFER_STATE", "0");
                        handler.TransferDetailSave(conn,TIDdata);
                        COPIES--;
                    }else{
                        if(num==0){
                            removeMannualDeluuid = TID_ID;
                        }else{
                            removeMannualDeluuid = removeMannualDeluuid + "#" + TID_ID;
                        }
                        num++;
                    }
                }
                TIdata.add("COPIES", COPIES);
                handler.TransferListSave(conn, TIdata);
                String[] removeMannualDeluuidArray = removeMannualDeluuid.split("#");
                int k = 0;
                if(removeMannualDeluuidArray.length>0){
                    for(int i=0;i<deluuid.length;i++){
                        boolean b = true;
                        for(int j=0;j<removeMannualDeluuidArray.length;j++){
                            if(removeMannualDeluuidArray[j].equals(deluuid[i])){
                                b = false;
                            }
                        }
                        if(b){
                            if(k==0){
                                newMannualDeluuid = deluuid[i];
                            }else{
                                newMannualDeluuid = newMannualDeluuid + "#" + deluuid[i];
                            }
                            k++;
                        }
                    }
                }else{
                    newMannualDeluuid = mannualDeluuid;
                }
                
            }
            Data data = new Data();
            DataList dataList = new DataList();
            if(!"".equals(TI_ID)){
                // ҳ��ʹ�õĽ��ӵ���Ϣ
                data = handler.TransferEdit(conn, TI_ID);
                // ҳ��ʹ�õĽ��ӵ���ϸ����
                if((TransferConstant.TRANSFER_TYPE_FILE).equals(TRANSFER_TYPE)){
                    dataList = handler.TransferEditDetailList(conn, TI_ID, TRANSFER_CODE);
                }
                if((TransferConstant.TRANSFER_TYPE_CHILD).equals(TRANSFER_TYPE)){
                    if((TransferCode.CHILDINFO_AZB_DAB).equals(TRANSFER_CODE)){
                        dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
                    }else{
                        dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
                    }
                }
                if((TransferConstant.TRANSFER_TYPE_CHEQUE).equals(TRANSFER_TYPE)){
                    dataList = handler.TransferEditDetailChequeList(conn, TI_ID);
                }
                if((TransferConstant.TRANSFER_TYPE_REPORT).equals(TRANSFER_TYPE)){
                    dataList = handler.TransferEditDetailArchiveList(conn, TI_ID);
                }
            }
            String[] arry = newMannualDeluuid.split("#");
            for(int i=0;i<arry.length;i++){
                String TID_ID = arry[i];
                DataList dl = new DataList();
                if((TransferConstant.TRANSFER_TYPE_FILE).equals(TRANSFER_TYPE)){
                    dl = handler.TransferEditDetailListOfUuid(conn, TID_ID, TRANSFER_CODE);
                }
                if((TransferConstant.TRANSFER_TYPE_CHILD).equals(TRANSFER_TYPE)){
                    if((TransferCode.CHILDINFO_AZB_DAB).equals(TRANSFER_CODE)){
                        dl = handler.TransferEditDetailChildMatchinfoListOfUuid(conn, TID_ID);
                    }else{
                        dl = handler.TransferEditDetailChildinfoListOfUuid(conn, TID_ID);
                    }
                    
                }
                if((TransferConstant.TRANSFER_TYPE_CHEQUE).equals(TRANSFER_TYPE)){
                    dl = handler.TransferEditDetailChequeListOfUuid(conn, TID_ID);
                }
                if((TransferConstant.TRANSFER_TYPE_REPORT).equals(TRANSFER_TYPE)){
                    dl = handler.TransferEditDetailArchiveListOfUuid(conn, TID_ID);
                }
                dataList.addAll(dl);
            }
            setAttribute("Edit_Transfer_data", data);
            setAttribute("Transfer_Detail_DataList",dataList);
            setAttribute("TRANSFER_CODE",TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);
            setAttribute("mannualDeluuid", newMannualDeluuid);
            dt.commit();
        } catch (DBException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ӽ��ӵ�ҳ���Ƴ�ѡ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ӽ��ӵ�ҳ���Ƴ�ѡ�����쳣[�Ƴ�����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } 
        catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ӽ��ӵ�ҳ���Ƴ�ѡʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        }
        finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     * ���ӹ�����ڷ�������Ҫ���ݲ����жϲ������ͣ�ҵ�񻷽�
     * 
     * @param String TRANSFER_CODE
     *            �ж�ҵ�񻷽ڲ���
     * @param String OPER_TYPE
     *            �жϲ������Ͳ���
     * @return
     */
    public String TransferList() {

        // ������ʼ������ TRANSFER_CODE ҵ�񻷽�
        // TRANSFER_TYPE �������� ��1:�����ļ���2����ͯ���ϣ�3��Ʊ�ݣ�4:���ú󱨸�
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        // �Ӳ˵����ã���ó�ʼ������ ����session�����ʼ������
        /*HttpSession session = getRequest().getSession();
        if (!"".equals(TRANSFER_CODE) && TRANSFER_CODE != null) {
            session
                    .setAttribute("TransferManager_TRANSFER_CODE",
                            TRANSFER_CODE);
            session.removeAttribute("Transfer_Detail_DataList");

        }
        if (!"".equals(TRANSFER_TYPE) && TRANSFER_TYPE != null) {
            session
                    .setAttribute("TransferManager_TRANSFER_TYPE",
                            TRANSFER_TYPE);
        }*/

        // �ӡ���ѯ����ť���ã��޷���ó�ʼ����������session�л�ó�ʼ������
        /*if ("".equals(TRANSFER_CODE) || TRANSFER_CODE == null) {
            TRANSFER_CODE = (String) session
                    .getAttribute("TransferManager_TRANSFER_CODE");
        }
        if ("".equals(TRANSFER_TYPE) || TRANSFER_TYPE == null) {
            TRANSFER_TYPE = (String) session
                    .getAttribute("TransferManager_TRANSFER_TYPE");
        }*/

        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = "CONNECT_NO";
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = "desc";
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", "CONNECT_NO", "COPIES",
                "TRANSFER_USERNAME", "TRANSFER_DATE_START",
                "TRANSFER_DATE_END", "RECEIVER_USERNAME",
                "RECEIVER_DATE_START", "RECEIVER_DATE_END", "AT_STATE");

        // �жϲ����еĲ�������,���ò����������Ͳ�ѯ����: 1:�����ļ���2����ͯ���ϣ�3��Ʊ�ݣ�4:���ú󱨸�
        if ("1".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "1");

        } else if ("2".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "2");
        } else if ("3".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "3");
        } else if ("4".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "4");
        }
        // ���ò�������Ϊ�ƽ�
        data.add("OPER_TYPE", "1");
        // ���ݲ����еĽ��Ӵ������ò�ѯ����

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.TransferList(conn, data, pageSize, page,
                    compositor, ordertype);
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * ���롰�ֹ���ӡ��ƽ��ļ�ѡ���б�
     * 
     * @return
     */
    public String TransferMannualFileList() {
        // ��ȡ��ǰҵ�񻷽�
        
        //String TI_ID = getParameter("TI_ID");
    	String mannualDeluuid = getParameter("mannualDeluuid","");
        String transfer_code = getParameter("TRANSFER_CODE");
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", "COUNTRY_CODE","ADOPT_ORG_ID",
                "REGISTER_DATE_START", "REGISTER_DATE_END", "FILE_NO",
                "FILE_TYPE", "MALE_NAME", "FEMALE_NAME", "HANDLE_TYPE");
        data.add("TRANSFER_CODE", transfer_code);
        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.TransferMannualFileList(conn, data, pageSize,
                    page, compositor, ordertype);
            if(!"".equals(mannualDeluuid)){
                String[] uuid = mannualDeluuid.split("#");
                if(dl.size()>0){
                    for(int i=dl.size()-1;i>=0;i--){
                        String TID_ID = dl.getData(i).getString("TID_ID");
                        for(int j=0;j<uuid.length;j++){
                            if(TID_ID.equals(uuid[j])){
                                dl.remove(i);
                            }
                        }
                    }
                }
            }

            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            //setAttribute("TI_ID", TI_ID);
            setAttribute("TRANSFER_CODE", transfer_code);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("mannualDeluuid", mannualDeluuid);

        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * ɾ�����ƽ�״̬�Ľ��ӵ�
     * 
     * @return
     */
    public String TransferDelete() {

        String chioceuuid = getRequest().getParameter("chioceuuid");
        String[] uuid = chioceuuid.split("#");
        String transfer_code = getParameter("TRANSFER_CODE");
        // ��װTRANSFER_INFO��ɾ��Data
        DataList dl = new DataList();
        for (int i = 1; i < uuid.length; i++) {
            Data data = new Data();
            data.add("TI_ID", uuid[i]);
            dl.add(data);
        }
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            // ɾ�����ӵ�
            success = handler.TransferBatchDelete(conn, dl, "1");
            // ���½�����ϸ��������ӵ�ID�뽻��״̬����
            for (int i = 1; i < uuid.length; i++) {
                success = handler.UpdateTransfer_Delete(conn, uuid[i],
                        transfer_code);
            }

            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");// ����ɹ� 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "ɾ�����������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ɾ��ʧ��!");// ����ʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ɾ��ʧ��!");// ����ʧ�� 2
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }

        return retValue;
    }

    /**
     * �����޸��ƽ�������
     * 
     * @return
     */
    public String InUpdateTransfer() {
    	 String type = getParameter("type", "");
    	 String TRANSFER_CODE = getParameter("TRANSFER_CODE");
         String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
         String TI_ID = getParameter("TI_ID","");
         
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // ��ѯ���ӵ�����
                if(!"".equals(TI_ID)){
                    data = handler.TransferEdit(conn, TI_ID);
                    dataList = handler.TransferEditDetailList(conn, TI_ID,TRANSFER_CODE);
                }
                for(int i=0;i<uuid.length;i++){
                    String TID_ID = uuid[i];
                    DataList dl = handler.TransferEditDetailListOfUuid(conn, TID_ID,TRANSFER_CODE);//�µ�handler����
                    dataList.addAll(dl);
                }
                setAttribute("mannualDeluuid", chioceuuid);
            }else{
                data = handler.TransferEdit(conn, TI_ID);
                dataList = handler.TransferEditDetailList(conn, TI_ID,TRANSFER_CODE);
            }


            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("Edit_Transfer_data", data);
        setAttribute("Transfer_Detail_DataList",dataList);
        setAttribute("TRANSFER_CODE",TRANSFER_CODE);
        setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);


        return retValue;
    }

    /**
     * ��ͯ�����޸��ƽ�������
     * @author wang
     * @return
     */
    public String InUpdateTransferChildinfo() {
    	String type = getParameter("type", "");
    	  String TRANSFER_CODE = getParameter("TRANSFER_CODE");
          String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
          String TI_ID = getParameter("TI_ID","");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // ��ѯ���ӵ�����
                if(!"".equals(TI_ID)){
                    data = handler.TransferEdit(conn, TI_ID);
                    dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
                }
                for(int i=0;i<uuid.length;i++){
                    String TID_ID = uuid[i];
                    DataList dl = handler.TransferEditDetailChildinfoListOfUuid(conn, TID_ID);//�µ�handler����
                    dataList.addAll(dl);
                }
                setAttribute("mannualDeluuid", chioceuuid);
            }else{
                data = handler.TransferEdit(conn, TI_ID);
                dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
            }

            //dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ�����
            //data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            //dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
            setAttribute("Edit_Transfer_data", data);
            setAttribute("Transfer_Detail_DataList",dataList);
            setAttribute("TRANSFER_CODE",TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);
            //dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            //try {
            //  dt.rollback();
            //} catch (SQLException e1) {
            //  e1.printStackTrace();
            //}
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    /**
     * ���ò����������Ĳ�����Ҫȡ��ƥ����Ϣ
     * @Title: InUpdateTransferChildMatchinfo
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����4:53:25
     * @return
     */
    public String InUpdateTransferChildMatchinfo() {
    	String type = getParameter("type", "");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TI_ID = getParameter("TI_ID","");
      // ҳ��ʹ�õĽ��ӵ���Ϣ
      Data data = new Data();
      // ҳ��ʹ�õĽ��ӵ���ϸ����
      DataList dataList = new DataList();
      try {
          // 2 ��ȡ���ݿ�����
          conn = ConnectionManager.getConnection();
          //dt = DBTransaction.getInstance(conn);
          if("refresh".equals(type)){
              String chioceuuid = getParameter("chioceuuid","");
              String[] uuid = chioceuuid.split("#");
              // ��ѯ���ӵ�����
              if(!"".equals(TI_ID)){
                  data = handler.TransferEdit(conn, TI_ID);
                  dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
              }
              for(int i=0;i<uuid.length;i++){
                  String TID_ID = uuid[i];
                  DataList dl = handler.TransferEditDetailChildMatchinfoListOfUuid(conn, TID_ID);//�µ�handler����
                  dataList.addAll(dl);
              }
              setAttribute("mannualDeluuid", chioceuuid);
          }else{
              data = handler.TransferEdit(conn, TI_ID);
              dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
          }

          // ��ѯ���ӵ�����
          //data = handler.TransferEdit(conn, TI_ID);
          // ��ѯ���ӵ���ϸ����
          //dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
          setAttribute("Edit_Transfer_data", data);
          setAttribute("Transfer_Detail_DataList",dataList);
          setAttribute("TRANSFER_CODE",TRANSFER_CODE);
          setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);
          //dt.commit();
      } catch (DBException e) {
          // 4 �����쳣����
          //try {
          //  dt.rollback();
          //} catch (SQLException e1) {
          //  e1.printStackTrace();
          //}
          setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
          setAttribute(Constants.ERROR_MSG, e);
          if (log.isError()) {
              log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
          }
          InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
          setAttribute("clueTo", clueTo);
          retValue = "error1";
      } finally {
          if (conn != null) {
              try {
                  if (!conn.isClosed()) {
                      conn.close();
                  }
              } catch (SQLException e) {
                  if (log.isError()) {
                      log
                              .logError(
                                      "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                      e);
                  }
                  e.printStackTrace();
              }
          }
      }
      return retValue;
  }

    /**
     * ����Ʊ���޸��ƽ�������
     * 
     * @return
     */
    public String InUpdateTransferCheque() {
        String type = getParameter("type", "");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TI_ID = getParameter("TI_ID","");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // ��ѯ���ӵ�����
                if(!"".equals(TI_ID)){
                    data = handler.TransferEdit(conn, TI_ID);
                    dataList = handler.TransferEditDetailChequeList(conn, TI_ID);
                }
                for(int i=0;i<uuid.length;i++){
                    String TID_ID = uuid[i];
                    DataList dl = handler.TransferEditDetailChequeListOfUuid(conn, TID_ID);
                    dataList.addAll(dl);
                }
                setAttribute("mannualDeluuid", chioceuuid);
            }else{
                data = handler.TransferEdit(conn, TI_ID);
                dataList = handler.TransferEditDetailChequeList(conn, TI_ID);
            }
            
            setAttribute("Edit_Transfer_data", data);
            setAttribute("Transfer_Detail_DataList",dataList);
            setAttribute("TRANSFER_CODE",TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);
        } catch (DBException e) {
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * ����Ʊ���޸��ƽ�������
     * 
     * @return
     */
    public String InUpdateTransferArchive() {
        String type = getParameter("type", "");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TI_ID = getParameter("TI_ID","");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // ��ѯ���ӵ�����
                if(!"".equals(TI_ID)){
                    data = handler.TransferEdit(conn, TI_ID);
                    dataList = handler.TransferEditDetailArchiveList(conn, TI_ID);
                }
                for(int i=0;i<uuid.length;i++){
                    String TID_ID = uuid[i];
                    DataList dl = handler.TransferEditDetailArchiveListOfUuid(conn, TID_ID);
                    dataList.addAll(dl);
                }
                setAttribute("mannualDeluuid", chioceuuid);
            }else{
                data = handler.TransferEdit(conn, TI_ID);
                dataList = handler.TransferEditDetailArchiveList(conn, TI_ID);
            }
            
            setAttribute("Edit_Transfer_data", data);
            setAttribute("Transfer_Detail_DataList",dataList);
            setAttribute("TRANSFER_CODE",TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);
        } catch (DBException e) {
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * �����ļ����ӵ���ӡҳ�淽��
     * 
     * @return
     */
    public String InTransferFilePrint() {
        String transfer_code = getParameter("TRANSFER_CODE");
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailList(conn, TI_ID,
                    transfer_code);
            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }

        getRequest().setAttribute("transferFile_print_data", data);
        getRequest().setAttribute("transferFile_print_list", dataList);

        return retValue;
    }

        /**
         * �����ļ����ӵ���ӡҳ�淽��(����)
         *
         * @return
         */
    public String InTransferFilePrintTW() {
        String transfer_code = getParameter("TRANSFER_CODE");
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailList(conn, TI_ID,
                    transfer_code);
            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        getRequest().setAttribute("transferFile_print_data", data);
        getRequest().setAttribute("transferFile_print_list", dataList);
        return retValue;
    }


    /**
     * ������Ͻ��ӵ���ӡҳ�淽��
     * @return
     */
    public String InTransferChildinfoPrint() {
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * ����ҳ���ӡ�Զ���ҳ���� ��
         *
         *
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "����"+i); testdata.add("NAME_CN",
         * "������֯"+i); testdata.add("REGISTER_DATE", ��"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "����"); testdata.add("MALE_NAME", "��������"+i);
         * testdata.add("FEMALE_NAME", "Ů������"+i); testdata.add("NAME", "��ͯ"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    /**
     * ������Ͻ��ӵ���ӡҳ�淽����ƥ����Ϣ��
     * @Title: InTransferChildMatchinfoPrint
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����5:39:22
     * @return
     */
    public String InTransferChildMatchinfoPrint() {
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
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
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * ����ҳ���ӡ�Զ���ҳ���� ��
         * 
         * 
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "����"+i); testdata.add("NAME_CN",
         * "������֯"+i); testdata.add("REGISTER_DATE", ��"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "����"); testdata.add("MALE_NAME", "��������"+i);
         * testdata.add("FEMALE_NAME", "Ů������"+i); testdata.add("NAME", "��ͯ"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    
    /**
     * �鿴���Ͻ��ӵ���Ϣ
     * @return
     */
    public String InTransferChildinfoView() {
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * ����ҳ���ӡ�Զ���ҳ���� ��
         * 
         * 
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "����"+i); testdata.add("NAME_CN",
         * "������֯"+i); testdata.add("REGISTER_DATE", ��"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "����"); testdata.add("MALE_NAME", "��������"+i);
         * testdata.add("FEMALE_NAME", "Ů������"+i); testdata.add("NAME", "��ͯ"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    
    /**
     * �鿴���Ͻ��ӵ���Ϣ��ƥ�䣩
     * @Title: InTransferChildMatchinfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����5:43:24
     * @return
     */
    public String InTransferChildMatchinfoView() {
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * ����ҳ���ӡ�Զ���ҳ���� ��
         * 
         * 
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "����"+i); testdata.add("NAME_CN",
         * "������֯"+i); testdata.add("REGISTER_DATE", ��"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "����"); testdata.add("MALE_NAME", "��������"+i);
         * testdata.add("FEMALE_NAME", "Ů������"+i); testdata.add("NAME", "��ͯ"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    
    /**
     * 
     * @Title: InTransferChequeInfoPrint
     * @Description: ����Ʊ�ݽ��ӵ���ӡҳ�淽��
     * @author: xugy
     * @date: 2014-11-24����2:13:55
     * @return
     */
    public String InTransferChequeInfoPrint() {
        String transfer_code = getParameter("TRANSFER_CODE");
        String TI_ID = getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
    
            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailChequeinfoList(conn, TI_ID,transfer_code);
            dt.commit();
            setAttribute("transferChequeinfo_print_data", data);
            setAttribute("transferChequeinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: InTransferArchiveInfoPrint
     * @Description: ���밲�ú󱨸潻�ӵ���ӡҳ�淽��
     * @author: xugy
     * @date: 2014-11-18����11:28:45
     * @return
     */
    public String InTransferArchiveInfoPrint() {
        String transfer_code = (String) getParameter("tcode");
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
    
            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailArchiveinfoList(conn, TI_ID, transfer_code);
            
            setAttribute("transferArchiveinfo_print_data", data);
            setAttribute("transferArchiveinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
    
        return retValue;
    }
    /**
     * �鿴Ʊ�ݽ��ӵ���Ϣ
     * @Title: InTransferChequeInfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-24����11:21:08
     * @return
     */
    public String InTransferChequeInfoView() {
        String transfer_code = (String) getParameter("tcode");
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailChequeinfoList(conn, TI_ID,transfer_code);
            setAttribute("transferChequeinfo_print_data", data);
            setAttribute("transferChequeinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
    
        return retValue;
    }
    
    /**
     * �鿴���ú������潻�ӵ���Ϣ
     * @Title: InTransferArchiveInfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-18����1:39:10
     * @return
     */
    public String InTransferArchiveInfoView() {
        String transfer_code = (String) getRequest().getSession().getAttribute(
                "TransferManager_TRANSFER_CODE");
        String TI_ID = (String) getParameter("UUID");
        // ҳ��ʹ�õĽ��ӵ���Ϣ
        Data data = new Data();
        // ҳ��ʹ�õĽ��ӵ���ϸ����
        DataList dataList = new DataList();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
    
            // ��ѯ���ӵ�����
            data = handler.TransferEdit(conn, TI_ID);
            // ��ѯ���ӵ���ϸ����
            dataList = handler.TransferEditDetailArchiveinfoList(conn, TI_ID,
                    transfer_code);
            setAttribute("transferArchiveinfo_print_data", data);
            setAttribute("transferArchiveinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ���������쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
    
        return retValue;
    }

        /**
     * ��ѯ�ļ�������ϸ��Ϣ
     * 
     * @return
     */
    public String InFileView() {
    	// �жϵ�ǰ����ʱ�����ĸ����� 1���ƽ���2������
    	 String OPER_TYPE = getParameter("OPER_TYPE");
         String TRANSFER_CODE = getParameter("TRANSFER_CODE");
         String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");

       

        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", "ADOPT_ORG_ID","COUNTRY_CODE",
                "REGISTER_DATE_START", "REGISTER_DATE_END", "MALE_NAME",
                "FEMALE_NAME", "TRANSFER_DATE_START", "TRANSFER_DATE_END",
                "FILE_NO", "CONNECT_NO", "RECEIVER_DATE_START",
                "RECEIVER_DATE_END", "FILE_TYPE", "TRANSFER_STATE");

        // �жϲ����еĲ�������,���ò����������Ͳ�ѯ����: 1:�����ļ���2����ͯ���ϣ�3��Ʊ�ݣ�4:���ú󱨸�
        if ("1".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "1");

        } else if ("2".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "2");
        }
        // �жϵ��õ�λ�� 1��Ϊ�ƽ���2��Ϊ���� ����ͬλ�õ������ݷ�Χ��ͬ

        if ("1".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "1");

        } else if ("2".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "2");
        }
        // ��ҳ�洫�ݵ�ǰ����λ���ж��ƽ�״̬�����б���ʾ����
        setAttribute("OPER_TYPE", OPER_TYPE);
        // ���ݲ����еĽ��Ӵ������ò�ѯ����

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.FindDetailList(conn, data, pageSize, page,
                    compositor, ordertype);
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("OPER_TYPE", OPER_TYPE);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * ��ѯ���Ͻ�����ϸ��Ϣ
     * @author wang
     * @return
     */
    public String InChildinfoView() {
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        
        //2 ��ȡ����       
        // �жϵ�ǰ����ʱ�����ĸ����� 1���ƽ���2������
        String OPER_TYPE = getParameter("OPER_TYPE");
       
        //���Ӵ���
        String TRANSFER_CODE = (String)getParameter("TRANSFER_CODE");
        //���ӵ�����
        String TRANSFER_TYPE = TransferConstant.TRANSFER_TYPE_CHILD;


        // ��ȡ��������
        Data data = getRequestEntityData("S_",
                "CHILD_NO", 
                "PROVINCE_ID",
                "WELFARE_ID",
                "NAME", 
                "SEX", 
                "BIRTHDAY_START",
                "BIRTHDAY_END",
                "CHILD_TYPE", 
                "SPECIAL_FOCUS",
                "TRANSFER_DATE_START" ,
                "TRANSFER_DATE_END" ,
                "CONNECT_NO" ,
                "TRANSFER_STATE",
                "RECEIVER_DATE_START",
                "RECEIVER_DATE_END");

        // �жϲ����еĲ�������,���ò����������Ͳ�ѯ����: 1:�����ļ���2����ͯ���ϣ�3��Ʊ�ݣ�4:���ú󱨸�
        data.add("TRANSFER_TYPE", TRANSFER_TYPE);
        //�������� ���͡�����
        data.add("OPER_TYPE", OPER_TYPE);
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.FindChildinfoDetailList(conn, data, pageSize, page, compositor, ordertype);
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
         // ��ҳ�洫�ݵ�ǰ����λ���ж��ƽ�״̬�����б���ʾ����
            setAttribute("OPER_TYPE", OPER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }
    /**
     * ��ѯ���ϣ�ƥ�䣩������ϸ��Ϣ
     * @Title: InChildMatchinfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����5:46:43
     * @return
     */
    public String InChildMatchinfoView() {
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        
        //2 ��ȡ����       
        // �жϵ�ǰ����ʱ�����ĸ����� 1���ƽ���2������
        String OPER_TYPE = getParameter("OPER_TYPE");
       
        //���Ӵ���
        String TRANSFER_CODE = (String)getParameter("TRANSFER_CODE");
        //���ӵ�����
        String TRANSFER_TYPE = TransferConstant.TRANSFER_TYPE_CHILD;


        // ��ȡ��������
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","FILE_NO","FILE_TYPE","ADOPT_ORG_NAME", 
                "CHILD_NO", 
                "PROVINCE_ID",
                "WELFARE_ID",
                "NAME", 
                "SEX", 
                "BIRTHDAY_START",
                "BIRTHDAY_END",
                "CHILD_TYPE", 
                "SPECIAL_FOCUS",
                "TRANSFER_DATE_START" ,
                "TRANSFER_DATE_END" ,
                "CONNECT_NO" ,
                "TRANSFER_STATE",
                "RECEIVER_DATE_START",
                "RECEIVER_DATE_END");

        // �жϲ����еĲ�������,���ò����������Ͳ�ѯ����: 1:�����ļ���2����ͯ���ϣ�3��Ʊ�ݣ�4:���ú󱨸�
        data.add("TRANSFER_TYPE", TRANSFER_TYPE);
        //�������� ���͡�����
        data.add("OPER_TYPE", OPER_TYPE);
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.FindChildMatchinfoDetailList(conn, data, pageSize, page, compositor, ordertype);
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
         // ��ҳ�洫�ݵ�ǰ����λ���ж��ƽ�״̬�����б���ʾ����
            setAttribute("OPER_TYPE", OPER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * ��ѯƱ�ݽ�����ϸ��Ϣ
     * 
     * @return
     */
    public String InChequeView() {
        // �жϵ�ǰ����ʱ�����ĸ����� 1���ƽ���2������
        String OPER_TYPE = getParameter("OPER_TYPE");

        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", "COUNTRY_CODE", "ADOPT_ORG_ID","PAID_WAY",
                "PAID_NO", "BILL_NO", "PAR_VALUE_START", "PAR_VALUE_END",
                "CONNECT_NO", "TRANSFER_DATE_START", "TRANSFER_DATE_END",
                "RECEIVER_DATE_START", "RECEIVER_DATE_END", "TRANSFER_STATE");

        data.add("TRANSFER_TYPE", "3");

        // �жϵ��õ�λ�� 1��Ϊ�ƽ���2��Ϊ���� ����ͬλ�õ������ݷ�Χ��ͬ

        if ("1".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "1");

        } else if ("2".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "2");
        }
        // ��ҳ�洫�ݵ�ǰ����λ���ж��ƽ�״̬�����б���ʾ����
        // ���ݲ����еĽ��Ӵ������ò�ѯ����

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.FindChequeDetailList(conn, data, pageSize,
                    page, compositor, ordertype);
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("OPER_TYPE", OPER_TYPE);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }
    /**
     * 
     * @Title: InArchiveView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-18����1:51:34
     * @return
     */
    public String InArchiveView() {
        // �жϵ�ǰ����ʱ�����ĸ����� 1���ƽ���2������
        String OPER_TYPE = getParameter("OPER_TYPE");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", "COUNTRY_CODE","ADOPT_ORG_NAME", "ADOPT_ORG_ID",
                "ARCHIVE_NO", "MALE_NAME", "FEMALE_NAME", "NAME","SIGN_DATE_START","SIGN_DATE_END","REPORT_DATE_START","REPORT_DATE_END","NUM",
                "CONNECT_NO", "TRANSFER_DATE_START", "TRANSFER_DATE_END",
                "RECEIVER_DATE_START", "RECEIVER_DATE_END", "TRANSFER_STATE");

        data.add("TRANSFER_TYPE", "4");

        // �жϵ��õ�λ�� 1��Ϊ�ƽ���2��Ϊ���� ����ͬλ�õ������ݷ�Χ��ͬ

        if ("1".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "1");

        } else if ("2".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "2");
        }
        // ��ҳ�洫�ݵ�ǰ����λ���ж��ƽ�״̬�����б���ʾ����
        // ���ݲ����еĽ��Ӵ������ò�ѯ����

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.FindArchiveDetailList(conn, data, pageSize,
                    page, compositor, ordertype);
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("OPER_TYPE", OPER_TYPE);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * �����ͯ�������ҳ��
     * 
     * @return
     */
    public String TransferAddChildinfo() {
        // ��ȡsession�е��ֹ�����б��ж��Ƿ������ʷ���ӵ���
        HttpSession session = getRequest().getSession();
        DataList dl = (DataList) session
                .getAttribute("Transfer_Detail_DataList");
        if (dl == null) {
            // ����ҳ���ʼ������
            dl = new DataList();
            setAttribute("Transfer_Detail_DataList", dl);
        }

        String isinit = getParameter("init");
        if (isinit != null && "1".equals(isinit)) {
            session.setAttribute("Transfer_Detail_DataList", new DataList());
            session.removeAttribute("Edit_Transfer_data");
        }
        return retValue;

    }
    /**
     * �ֹ�ѡ���ƽ��Ĳ���
     * @author wang
     * @return
     */
    public String TransferMannualChildinfoList() {
        // ��ȡ��ǰҵ�񻷽�
        //String transfer_code = (String) getRequest().getSession().getAttribute("TransferManager_TRANSFER_CODE");
    	//String TI_ID = getParameter("TI_ID");
    	 String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 1.2 ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 1.3 ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 1.4 ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", 
                "CHILD_NO",
                "PROVINCE_ID",
                "WELFARE_ID",
                "NAME",
                "SEX",
                "BIRTHDAY_START", 
                "BIRTHDAY_END",
                "CHILD_TYPE",
                "SPECIAL_FOCUS");
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        
        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.TransferMannualChildinfoList(conn, data,pageSize, page, compositor, ordertype);
            if(!"".equals(mannualDeluuid)){
                String[] uuid = mannualDeluuid.split("#");
                if(dl.size()>0){
                    for(int i=dl.size()-1;i>=0;i--){
                        String TID_ID = dl.getData(i).getString("TID_ID");
                        for(int j=0;j<uuid.length;j++){
                            if(TID_ID.equals(uuid[j])){
                                dl.remove(i);
                            }
                        }
                    }
                }
            }

            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            //setAttribute("TI_ID", TI_ID);
            setAttribute("mannualDeluuid", mannualDeluuid);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);

        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * ���ò������������ϴ�ƥ����Ϣ
     * @Title: TransferMannualChildMatchinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����5:18:16
     * @return
     */
    public String TransferMannualChildMatchinfoList() {
        // ��ȡ��ǰҵ�񻷽�
        //String transfer_code = (String) getRequest().getSession().getAttribute("TransferManager_TRANSFER_CODE");
        //String TI_ID = getParameter("TI_ID");
    	 String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 1.2 ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 1.3 ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 1.4 ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","FILE_NO","FILE_TYPE","ADOPT_ORG_NAME", 
                "CHILD_NO",
                "PROVINCE_ID",
                "WELFARE_ID",
                "NAME",
                "SEX",
                "BIRTHDAY_START", 
                "BIRTHDAY_END",
                "CHILD_TYPE",
                "SPECIAL_FOCUS");
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        
        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            
            // 5 ��ȡ����DataList
            DataList dl = handler.TransferMannualChildMatchinfoList(conn, data,pageSize, page, compositor, ordertype);
            if(!"".equals(mannualDeluuid)){
                String[] uuid = mannualDeluuid.split("#");
                if(dl.size()>0){
                    for(int i=dl.size()-1;i>=0;i--){
                        String TID_ID = dl.getData(i).getString("TID_ID");
                        for(int j=0;j<uuid.length;j++){
                            if(TID_ID.equals(uuid[j])){
                                dl.remove(i);
                            }
                        }
                    }
                }
            }

            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            //setAttribute("TI_ID", TI_ID);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("mannualDeluuid", mannualDeluuid);
            
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                        .logError(
                                "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * �ֹ�ѡ���ƽ���Ʊ��
     * 
     * @return
     */
    public String TransferMannualChequeList() {
        String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = "PAID_NO";
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = "desc";
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", "COUNTRY_CODE", "ADOPT_ORG_NAME","ADOPT_ORG_ID", "PAID_WAY", "PAID_NO", "BILL_NO","PAR_VALUE");
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.TransferMannualChequeList(conn, data, pageSize, page, compositor, ordertype);
            if(!"".equals(mannualDeluuid)){
                String[] uuid = mannualDeluuid.split("#");
                if(dl.size()>0){
                    for(int i=dl.size()-1;i>=0;i--){
                        String TID_ID = dl.getData(i).getString("TID_ID");
                        for(int j=0;j<uuid.length;j++){
                            if(TID_ID.equals(uuid[j])){
                                dl.remove(i);
                            }
                        }
                    }
                }
            }
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("mannualDeluuid", mannualDeluuid);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction��Connection������쳣��δ�ܹر�", e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     * 
     * @return
     */
    public String TransferMannualArchiveList() {
        // ��ȡ��ǰҵ�񻷽�
        String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", "COUNTRY_CODE","ADOPT_ORG_NAME", "ADOPT_ORG_ID", "ARCHIVE_NO", "MALE_NAME", "FEMALE_NAME", "SIGN_DATE_START", "SIGN_DATE_END", "REPORT_DATE_START","REPORT_DATE_END", "NUM");
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.transferMannualArchiveList(conn, data, pageSize, page, compositor, ordertype);
            if(!"".equals(mannualDeluuid)){
                String[] uuid = mannualDeluuid.split("#");
                if(dl.size()>0){
                    for(int i=dl.size()-1;i>=0;i--){
                        String TID_ID = dl.getData(i).getString("TID_ID");
                        for(int j=0;j<uuid.length;j++){
                            if(TID_ID.equals(uuid[j])){
                                dl.remove(i);
                            }
                        }
                    }
                }
            }
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("mannualDeluuid", mannualDeluuid);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     * ***************************************����Ϊ���շ���***************************
     * *********************
     */

    /**
     * ���ӹ���-���չ������ ��ѯĬ��״̬Ϊ���ƽ��Ľ��ӵ� ���ղ���transfer_codeȷ��ҵ�񻷽����������
     * @return
     */
    public String TransferReceiveList() {

        // ������ʼ������ TRANSFER_CODE ҵ�񻷽�
        // TRANSFER_TYPE ��������
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");

        // 1 ���÷�ҳ����
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // ��ȡ�����ֶ�
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = "CONNECT_NO";
        }
        // ��ȡ�������� ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = "asc";
        }
        // ��ȡ��������
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
        setAttribute("clueTo", clueTo);// set�����������
        Data data = getRequestEntityData("S_", 
                "CONNECT_NO", 
                "COPIES",
                "TRANSFER_USERNAME", 
                "TRANSFER_DATE_START",
                "TRANSFER_DATE_END", 
                "RECEIVER_USERNAME",
                "RECEIVER_DATE_START", 
                "RECEIVER_DATE_END", 
                "AT_STATE");
    
        data.add("TRANSFER_TYPE", TRANSFER_TYPE);
        // ���ý������� 
        data.add("OPER_TYPE",TransferConstant.OPER_TYPE_RECEIVE);
        // ���ݲ����еĽ��Ӵ������ò�ѯ����
        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // 5 ��ȡ����DataList
            DataList dl = handler.TransferReceiveList(conn, data, pageSize,  page, compositor, ordertype);
            // 6 �������д��ҳ����ձ���
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        } catch (DBException e) {
            // 7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * ���շ���������ʵ���ļ�
     * 
     * @return
     */
    public String ReceiveFileList() {
        //1 ��ȡ�����˻�����Ϣ��ϵͳ����
        String personId = SessionInfo.getCurUser().getPerson().getPersonId();
        String personName = SessionInfo.getCurUser().getPerson().getCName();
        String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        String deptName = SessionInfo.getCurUser().getCurOrgan().getCName();
        String curDate = DateUtility.getCurrentDate();
        
        
        String transfer_code = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        
        // ���ӵ���Ϣ
        Data data = new Data();
        
        // ��ϸ�ļ���Ϣ
        DataList dataList = new DataList();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", personId);//������ID
            data.add("RECEIVER_USERNAME", personName);//����������
            data.add("RECEIVER_DATE", curDate);//��������
            data.add("RECEIVER_DEPT_ID", deptId);//���յ�λID
            data.add("RECEIVER_DEPT_NAME", deptName);//���յ�λ����
            // ��ѯ�����ļ���Ϣ
            dataList = handler.TransferEditDetailList(conn, chioceuuid,transfer_code);

            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("Receive_data", data);
        setAttribute("Receive_datalist", dataList);
        setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        setAttribute("TRANSFER_CODE", transfer_code);
        
        return retValue;
    }

    /**
     * ���շ���������ʵ�����
     * @author wang
     * @return
     */
    public String ReceiveChildinfoList() {
    	
    	String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        String currentDate = DateUtility.getCurrentDate();
        UserInfo curuser = SessionInfo.getCurUser();
        String userId = curuser.getPersonId();
        String userName = curuser.getPerson().getCName();
        Organ organ = curuser.getCurOrgan();
        String deptCode = organ.getOrgCode();
        String deptName = organ.getCName();
        
        // ���ӵ���Ϣ
        Data data = new Data();
        // ��ϸ�ļ���Ϣ
        DataList dataList = new DataList();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();

            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", userId);
            data.add("RECEIVER_USERNAME", userName);
            data.add("RECEIVER_DEPT_ID", deptCode);
            data.add("RECEIVER_DEPT_NAME", deptName);
            data.add("RECEIVER_DATE", currentDate);
            // ��ѯ�����ļ���Ϣ
            dataList = handler.TransferEditDetailChildinfoList(conn,chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            
            

        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    
    /**
     * ���շ���������ʵ����ϣ�ƥ�䣩
     * @Title: ReceiveChildMatchinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����8:29:13
     * @return
     */
    public String ReceiveChildMatchinfoList() {
        
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        String currentDate = DateUtility.getCurrentDate();
        UserInfo curuser = SessionInfo.getCurUser();
        String userId = curuser.getPersonId();
        String userName = curuser.getPerson().getCName();
        Organ organ = curuser.getCurOrgan();
        String deptCode = organ.getOrgCode();
        String deptName = organ.getCName();
        
        // ���ӵ���Ϣ
        Data data = new Data();
        // ��ϸ�ļ���Ϣ
        DataList dataList = new DataList();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();

            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", userId);
            data.add("RECEIVER_USERNAME", userName);
            data.add("RECEIVER_DEPT_ID", deptCode);
            data.add("RECEIVER_DEPT_NAME", deptName);
            data.add("RECEIVER_DATE", currentDate);
            // ��ѯ�����ļ���Ϣ
            dataList = handler.TransferEditDetailChildMatchinfoList(conn,chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);

        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * ���շ���������ʵ��Ʊ��
     * 
     * @return
     */
    public String ReceiveChequeList() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        String currentDate = DateUtility.getCurrentDate();
        UserInfo curuser = SessionInfo.getCurUser();
        String userId = curuser.getPersonId();
        String userName = curuser.getPerson().getCName();
        Organ organ = curuser.getCurOrgan();
        String deptCode = organ.getOrgCode();
        String deptName = organ.getCName();

        // ���ӵ���Ϣ
        Data data = new Data();
        // ��ϸ�ļ���Ϣ
        DataList dataList = new DataList();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", userId);
            data.add("RECEIVER_USERNAME", userName);
            data.add("RECEIVER_DEPT_ID", deptCode);
            data.add("RECEIVER_DEPT_NAME", deptName);
            data.add("RECEIVER_DATE", currentDate);
            // ��ѯ�����ļ���Ϣ
            dataList = handler.TransferEditDetailChequeList(conn, chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * ���շ���������ʵ�尲�ú󱨸�
     * 
     * @return
     */
    public String ReceiveArchiveList() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        // ���ӵ���Ϣ
        Data data = new Data();
        // ��ϸ�ļ���Ϣ
        DataList dataList = new DataList();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            // ��ѯ�����ļ���Ϣ
            dataList = handler.TransferEditDetailArchiveList(conn, chioceuuid);

            dt.commit();
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }

        
        return retValue;
    }

    /**
     * �����ļ�ȷ�Ϸ���
     * 
     * @return
     */
    public String ReceiveConfirm() {
        // ��ý���ȷ�ϵĽ��ӵ���
        String TI_ID = getParameter("TI_ID");
        // ��ȡҵ�񻷽�
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");

        String currentDate = DateUtility.getCurrentDate();
        // ��ȡ��ǰ��½�˼���ǰ��½�˵Ĳ�����Ϣ
        UserInfo curuser = SessionInfo.getCurUser();
        // ����ID
        String RECEIVER_USERID = curuser.getPersonId();
        String RECEIVER_USERNAME = curuser.getPerson().getCName();
        // ������Ϣ�����롢��������
        Organ organ = curuser.getCurOrgan();
        String RECEIVER_DEPT_ID = organ.getOrgCode();
        String RECEIVER_DEPT_NAME = organ.getCName();
        // ��������-������ϸ��Ϣ
        DataList pdL = new DataList();
        // ��������-���ӵ���Ϣ
        Data pda = new Data();
        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ���½��ӵ�
            handler.ReceiveConfirm(conn, TI_ID, RECEIVER_USERID,RECEIVER_USERNAME, RECEIVER_DEPT_ID, RECEIVER_DEPT_NAME);
            // ���½����б�
            handler.ReceiveConfirmDetail(conn, TI_ID);
            // ��ѯ������ϸ��Ϣ
            pda = handler.selectTransferById(conn, TI_ID);
            pdL = handler.selectTransferDetailById(conn, TI_ID);
            // ������ʼ������
            FileCommonManager fc = new FileCommonManager();
            if (TransferCode.FILE_BGS_FYGS.equals(TRANSFER_CODE)) {
                // �����������Ϊ��11�� ����칫�ҵ����빫˾���ƽ�����������ҵ���ʼ��������ʼ���������¼
                fc.translationInit(pda, pdL, conn);
            } else if (TransferCode.FILE_FYGS_SHB.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ12 �����빫˾����˲����ļ��ƽ������������ļ�ʲô�ĳ�ʼ������
                // ��װ��˳�ʼ��data
                DataList pList = new DataList();
                for (int i = 0; i < pdL.size(); i++) {
                    Data d = new Data();
                    d.add("AF_ID", pdL.getData(i).get("APP_ID"));
                    d.add("AUDIT_LEVEL", "0");
                    pList.add(d);
                }
                fc.auditInit(conn, pList);
            } else if (TransferCode.FILE_SHB_DAB.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ13������˲������������ļ��ƽ�
                // �����ж��ļ��Ƿ����һ�������ͯ��������������ͯ�����ƥ��ģ�鷽��������һ������˵�ƥ���¼
                /*Object[] ol = findTList(conn, pdL);
                // �����ƽ��У������������ͯ���ļ�����
                DataList txFlist = (DataList) ol[0];
                if (txFlist != null && txFlist.size() > 0) {
                    for (int i = 0; i < txFlist.size(); i++) {
                        // ����ƥ��״̬Ϊ����ƥ�䡱
                        txFlist.getData(i).add("MATCH_STATE", "1");
                        txFlist.getData(i).add("AF_ID",
                                txFlist.getData(i).getString("APP_ID"));
                    }
                    SpecialMatchAction sa = new SpecialMatchAction();
                    // ������ͥƥ�����˼�¼
                    sa.saveMatchInfo(conn, txFlist);
                    // ���¼�ͥ�ļ���ƥ��״̬
                    FileCommonManager fm = new FileCommonManager();
                    fm.piPeiInit(conn, txFlist);
                }
                // �����ƽ��е���ͨ�ļ�����
                // ƥ��״̬���óɡ���ƥ�䡱
                DataList ptList = (DataList) ol[1];
                if (ptList != null && ptList.size() > 0) {
                    for (int i = 0; i < ptList.size(); i++) {
                        // ����ƥ��״̬Ϊ����ƥ�䡱
                        ptList.getData(i).add("MATCH_STATE", "0");
                        ptList.getData(i).add("AF_ID",
                                ptList.getData(i).getString("APP_ID"));
                    }
                    // ����������ҵ����,���������ļ�״̬Ϊ��ƥ��
                    FileCommonManager fm = new FileCommonManager();
                    fm.piPeiInit(conn, ptList);
                }*/
                
                
                SpecialMatchAction sa = new SpecialMatchAction();
                // ������ͥƥ�����˼�¼
                sa.saveMatchInfo(conn, pdL);
            } else if (TransferCode.CHILDINFO_AZB_FYGS.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ21 �����ò������빫˾�Ĳ����ƽ� ��ʼ����������
                // ��������
                ChildInfoConstants cic = new ChildInfoConstants();
                // ��ʼ���ӿ�
                ChildManagerHandler cmh = new ChildManagerHandler();
                for (int i = 0; i < pdL.size(); i++) {
                    pdL.getData(i).add("TRANSLATION_TYPE",ChildInfoConstants.TRANSLATION_TYPE_TR); // ��������
                    pdL.getData(i).add("CI_ID",pdL.getData(i).getString("APP_ID")); // ��ͯID
                    pdL.getData(i).add("NOTICE_DATE",UtilDateTime.nowDateString());// ����֪ͨ����
                    pdL.getData(i).add("NOTICE_USERID", RECEIVER_USERID); // ����֪ͨ��ID
                    pdL.getData(i).add("NOTICE_USERNAME", RECEIVER_USERNAME);
                    pdL.getData(i).add("RECEIVE_DATE", currentDate);// ��������
                    pdL.getData(i).add("TRANSLATION_STATE",ChildInfoConstants.TRANSLATION_STATE_TODO); // ����״̬����ʼ��ӦΪTRANSLATION_STATE_TODO="0"  ������
                    pdL.getData(i).setConnection(conn);
                    pdL.getData(i).setEntityName("CMS_CI_TRANSLATION");
                    pdL.getData(i).setPrimaryKey("CT_ID");
                    // ȥ�������ֶ�
                    pdL.getData(i).removeData("APP_ID");
                    pdL.getData(i).removeData("TRANSFER_CODE");
                    pdL.getData(i).removeData("TI_ID");
                    pdL.getData(i).removeData("TID_ID");
                    pdL.getData(i).removeData("TRANSFER_STATE");
                }
                cmh.initCITranslation(conn, pdL);
                //���¶�ͯ����ȫ��״̬
                ChildCommonManager ccm = new ChildCommonManager();                
                ccm.fygsReceiveTranslation(conn, TI_ID, curuser.getCurOrgan());
    
            } else if (TransferCode.CHILDINFO_FYGS_AZB.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ22 �����빫˾�����ò��Ĳ����ƽ�
                ChildManagerHandler cmh = new ChildManagerHandler();
                DataList dlDataList = new DataList();
                for (int i = 0; i < pdL.size(); i++) {
                    Data data = new Data();
                    data.add("CI_ID", pdL.getData(i).getString("APP_ID"));
                    dlDataList.add(data);
                }
                cmh.updateCIState(conn, dlDataList);
            } else if (TransferCode.CHILDINFO_AZB_DAB.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ23�����ò����������Ĳ����ƽ�������ҵ����ƥ�������쵼ǩ��
                // ��ƥ�����ӱ���ʱ��
                FarCommonHandler fh = new FarCommonHandler();
                fh.SignSumbit(conn, pdL);
                
                //�ļ�ȫ��״̬��λ��
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.DAB_WJJJ_AZBTODAB_CLJS);
                for (int i = 0; i < pdL.size(); i++) {
                    data.add("AF_ID", pdL.getData(i).getString("APP_ID"));
                    AFhandler.modifyFileInfo(conn, data);//�޸������˵�ƥ����Ϣ
                }
                
              //���¶�ͯ����ȫ��״̬
                ChildCommonManager ccm = new ChildCommonManager();                
                ccm.childTransferToDABReceive(conn, TI_ID, curuser.getCurOrgan());
                
            } else if (TransferCode.RFM_CHILDINFO_DAB_AZB.equals(TRANSFER_CODE)) {
              //���¶�ͯ����ȫ��״̬
                ChildCommonManager ccm = new ChildCommonManager();                
                ccm.returnCIIsReceived(conn, TI_ID, curuser.getCurOrgan());
            } else if (TransferCode.ARCHIVE_DAB_FYGS.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ41������������֮�ŵİ��ú󱨸��ƽ�������ҵ���ú󱨸淭��
                // FB_REC_ID���ú󱨸�����
                // �����������빫˾REPORT_STATE='3'
                // ������״̬��TRANSLATION_STATE='0'
                DataList pList = new DataList();
                for (int i = 0; i < pdL.size(); i++) {
                    Data d = new Data();
                    d.add("FB_REC_ID", pdL.getData(i).get("APP_ID"));
                    d.add("REPORT_STATE", "3");
                    d.add("TRANSLATION_STATE", "0");
                    pList.add(d);
                }
                DABPPFeedbackHandler pfr = new DABPPFeedbackHandler();
                pfr.PFRFeedbackrecordSave(conn, pList);
                DABPPFeedbackAction pfraAction = new DABPPFeedbackAction();
                pfraAction.createFeedbackTranslation(conn, pList);
            } else if (TransferCode.ARCHIVE_FYGS_DAB.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ42����֮�ŵ��������İ��ú󱨸��ƽ�������ҵ���ú󱨸����
                // FB_REC_ID���ú󱨸�����
                // ���빫˾��������REPORT_STATE='6'
                // �����״̬��ADUIT_STATE='0'
                DataList pList = new DataList();
                for (int i = 0; i < pdL.size(); i++) {
                    Data d = new Data();
                    d.add("FB_REC_ID", pdL.getData(i).get("APP_ID"));
                    d.add("REPORT_STATE", "6");
                    d.add("ADUIT_STATE", "0");
                    pList.add(d);
                }
                DABPPFeedbackHandler pfr = new DABPPFeedbackHandler();
                DABPPFeedbackAction pfra = new DABPPFeedbackAction();
                pfr.PFRFeedbackrecordSave(conn, pList);
                pfra.createFeedbackAudit(conn, pList);
            } else if (TransferCode.CHEQUE_BGS_CWB.equals(TRANSFER_CODE)) {
                // ���ҵ������Ϊ31����칫�ҵ����񲿵�Ʊ��
                String curDate = DateUtility.getCurrentDate();
                for (int i = 0; i < pdL.size(); i++) {
                    Data pjData = new Data();
                    pjData.add("CHEQUE_ID", pdL.getData(i).get("APP_ID")); // Ʊ�ݵǼ�ID
                    pjData.add("CHEQUE_TRANSFER_STATE", "4"); // �ƽ�״̬(4���ѽ���)
                    pjData.add("RECEIVE_DATE", curDate); // ��������
                    pjData.add("COLLECTION_STATE", "0"); // ����_����״̬(0��δ����)
                    pjData.add("ARRIVE_STATE", "0"); // ����_����״̬(0����ȷ��)
                    
                    handler.updateFamChequeInfo(conn, pjData);
                }
            } else if (TransferCode.RFM_FILE_DAB.equals(TRANSFER_CODE.substring(0, 1))) {
                // ���ҵ������Ϊ5�������ļ������������ƽ�������ҵ�����޸��ļ������ļ�¼�������״̬
                DataList pList = new DataList();
                for (int i = 0; i < pdL.size(); i++) {
                    Data d = new Data();
                    d.add("AF_ID", pdL.getData(i).get("APP_ID"));
                    d.add("RETURN_STATE", "2");
                    pList.add(d);
                }
                DABdisposalHandler da = new DABdisposalHandler();
                da.updateReturnState(conn, pList);
            }

            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "���²����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("���²����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (Exception e) {
            try {
                dt.rollback();
            } catch (Exception e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * ɸѡ��ͥ�����ļ��б��й����������ͯ���ļ�������һ��Object���� 0λ�ô洢�����˸���ͯ�������ļ���1λ�ô洢�����ļ�
     * 
     * @param conn
     * @param pdl
     * @return
     * @throws DBException
     */
    private Object[] findTList(Connection conn, DataList pdl) throws DBException {
        Object[] objlist = new Object[2];
        // �����ļ��б�
        DataList relist = new DataList();
        conn = ConnectionManager.getConnection();
        for (int i = 0; i < pdl.size(); i++) {
            Data d = pdl.getData(i);
            String fi_id = d.getString("APP_ID");
            boolean flag = handler.isTFile(conn, fi_id);
            if (flag) {
                relist.add(d);
                pdl.remove(i);
            }
        }
        // �����ļ�
        if (relist != null && relist.size() > 0) {
            objlist[0] = relist;
        } else {
            objlist[0] = null;
        }
        // �����ļ�
        if (pdl != null && pdl.size() > 0) {
            objlist[1] = pdl;
        } else {
            objlist[1] = null;
        }
        return objlist;
    }

    /**
     * �����ļ��˻ط���
     * 
     * @return
     */
    public String ReceiveReturn() {
        // ��ý���ȷ�ϵĽ��ӵ���
        String TI_ID = getRequest().getParameter("TI_ID");
        String REJECT_DESC = getRequest().getParameter("REJECT_DESC"); // ��ע-�˻�ԭ��
        // ��ȡҵ�񻷽�
        String TRANSFER_CODE = (String) getRequest().getSession().getAttribute(
                "TransferManager_Receive_TRANSFER_CODE");

        // ��ȡ��ǰ��½�˼���ǰ��½�˵Ĳ�����Ϣ
        UserInfo curuser = SessionInfo.getCurUser();
        // ����ID
        String REJECT_USERID = curuser.getPersonId();
        String REJECT_USERNAME = curuser.getPerson().getCName();
        // ������Ϣ�����롢��������
        Organ organ = curuser.getCurOrgan();
        String RECEIVER_DEPT_ID = organ.getOrgCode();
        String RECEIVER_DEPT_NAME = organ.getCName();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ���½��ӵ�
            handler.ReceiveReturn(conn, TI_ID, REJECT_USERID, REJECT_USERNAME,
                    RECEIVER_DEPT_ID, RECEIVER_DEPT_NAME, REJECT_DESC);
            // ���½����б�
            handler.ReceiveReturnDetail(conn, TI_ID);
            // ������ʼ������
            if (TransferCode.FILE_BGS_FYGS.equals(TRANSFER_CODE)) {
                // �����������Ϊ��11�� ����칫�ҵ����빫˾���ƽ�����������ҵ���ʼ��������ʼ���������¼

            } else {
                // �������͵ĳ�ʼ������
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(1, "�˻سɹ�!");
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "���²����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("���²����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ��ѯʧ�� 2
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * ��ѯ��ͯ���Ͻ��յ���ϸ��Ϣ
     * @author wang 
     * @return
     */
    public String InReceiveChildinfoView() {
    	String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // ���ӵ���Ϣ
        Data data = new Data();
        // ������ϸ��Ϣ
        DataList dataList = new DataList();

            // 2 ��ȡ���ݿ�����
            try {
                conn = ConnectionManager.getConnection();           
            //dt = DBTransaction.getInstance(conn);
            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            // ��ѯ������ϸ��Ϣ
            dataList = handler.TransferEditDetailChildinfoList(conn, chioceuuid);
            //dt.commit();  
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            }catch (DBException e) {
                // 4 �����쳣����
                setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
                setAttribute(Constants.ERROR_MSG, e);
                if (log.isError()) {
                    log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
                }
                InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
                setAttribute("clueTo", clueTo);
                retValue = "error1";
            } finally {
                if (conn != null) {
                    try {
                        if (!conn.isClosed()) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        if (log.isError()) {
                            log
                                    .logError(
                                            "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                            e);
                        }
                        e.printStackTrace();
                    }
                }
            }

        return retValue;
    }
    
    
    /**
     * ��ѯ��ͯ���ϣ�ƥ�䣩���յ���ϸ��Ϣ
     * @Title: InReceiveChildMatchinfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26����8:31:46
     * @return
     */
    public String InReceiveChildMatchinfoView() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // ���ӵ���Ϣ
        Data data = new Data();
        // ������ϸ��Ϣ
        DataList dataList = new DataList();

            // 2 ��ȡ���ݿ�����
            try {
                conn = ConnectionManager.getConnection();           
            //dt = DBTransaction.getInstance(conn);
            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            // ��ѯ������ϸ��Ϣ
            dataList = handler.TransferEditDetailChildMatchinfoList(conn, chioceuuid);
            //dt.commit();  
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            }catch (DBException e) {
                // 4 �����쳣����
                setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
                setAttribute(Constants.ERROR_MSG, e);
                if (log.isError()) {
                    log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
                }
                InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
                setAttribute("clueTo", clueTo);
                retValue = "error1";
            } finally {
                if (conn != null) {
                    try {
                        if (!conn.isClosed()) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        if (log.isError()) {
                            log
                                    .logError(
                                            "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                            e);
                        }
                        e.printStackTrace();
                    }
                }
            }

        return retValue;
    }
    
    /**
     * ��ѯ���յ���ϸ��Ϣ
     * 
     * @return
     */
    public String InReceiveFileView() {
        
        String transfer_code = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // ���ӵ���Ϣ
        Data data = new Data();
        // ��ϸ�ļ���Ϣ
        DataList dataList = new DataList();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            // ��ѯ�����ļ���Ϣ
            dataList = handler.TransferEditDetailList(conn, chioceuuid,
                    transfer_code);

            dt.commit();
        } catch (DBException e) {
            // 4 �����쳣����
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
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
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        setAttribute("TRANSFER_CODE", transfer_code);
        setAttribute("Receive_data", data);
        setAttribute("Receive_datalist", dataList);
        return retValue;
    }

    /**
     * ��ѯƱ�ݽ��յ���ϸ��Ϣ
     * 
     * @return
     */
    public String InReceiveChequeView() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // ���ӵ���Ϣ
        Data data = new Data();
        // ��ϸ�ļ���Ϣ
        DataList dataList = new DataList();

        try {
            // 2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();

            // ��ѯ���ӵ���Ϣ
            data = handler.TransferEdit(conn, chioceuuid);
            // ��ѯ�����ļ���Ϣ
            dataList = handler.TransferEditDetailChequeList(conn, chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 4 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    /**
     * ��ѯ���ú���������յ���ϸ��Ϣ
     * @Title: InReceiveArchiveView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-18����4:50:20
     * @return
     */
    public String InReceiveArchiveView() {
        //���Ӵ���
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        // ���ӵ���Ϣ
        Data data = new Data();
        // ������ϸ��Ϣ
        DataList dataList = new DataList();
            // 2 ��ȡ���ݿ�����
        try {
            conn = ConnectionManager.getConnection();           
        // ��ѯ���ӵ���Ϣ
        data = handler.TransferEdit(conn, chioceuuid);
        // ��ѯ������ϸ��Ϣ
        dataList = handler.TransferEditDetailArchiveinfoList(conn, chioceuuid,TRANSFER_CODE);
        setAttribute("Receive_data", data);
        setAttribute("Receive_datalist", dataList);
        setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        }catch (DBException e) {
            // 4 �����쳣����
        
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "��ѯʧ��!");// ��ѯʧ�� 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction��Connection������쳣��δ�ܹر�",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
}