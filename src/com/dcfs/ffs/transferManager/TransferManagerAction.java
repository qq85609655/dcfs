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

    private Connection conn = null;// 数据库连接

    private DBTransaction dt = null;// 事务处理

    private String retValue = SUCCESS;

    public TransferManagerAction() {
        this.handler = new TransferManagerHandler();
        this.AFhandler=new FileCommonManager();
    }

    public String execute() throws Exception {
        return null;
    }

    /**
     * 进入移交页面
     * 
     * @return
     */
    public String TransferAdd() {
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");//交接类型
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");//交接代码
        DataList datalist = new DataList();
        Data data = new Data();
        
        
        
        setAttribute("Transfer_Detail_DataList", datalist);
        setAttribute("Edit_Transfer_data", data);
        setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        /*try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
        }catch (DBException e) {
            setAttribute(Constants.ERROR_MSG_TITLE, "交接单添加异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
        } catch (SQLException e) {
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
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
                        log.logError("Connection因出现异常，未能关闭",e);
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
     * @Description: 保存交接单
     * @author: xugy
     * @date: 2014-12-8下午3:47:53
     * @return
     */
    public String TransferListSave() {
        // 封装交接单信息数据
        Data data = new Data();
        // 如果页面可以获得交接单ID，择是修改保存
        String TI_ID = getParameter("TI_ID","");
        data.add("TI_ID", TI_ID);
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String OPER_TYPE = getParameter("OPER_TYPE");
        // 设置操作类型为移交
        data.add("OPER_TYPE", OPER_TYPE);
        // 设置操作对象为文件
        data.add("TRANSFER_TYPE", TRANSFER_TYPE);
        data.add("TRANSFER_CODE", TRANSFER_CODE);

        // 获取当前登陆人及当前登陆人的部门信息
        UserInfo curuser = SessionInfo.getCurUser();
        // 封装移交人ID
        data.add("TRANSFER_USERID", curuser.getPersonId());
        data.add("TRANSFER_USERNAME", curuser.getPerson().getCName());
        // 封装部门信息：代码、中文名称
        Organ organ = curuser.getCurOrgan();
        data.add("TRANSFER_DEPT_ID", organ.getOrgCode());
        data.add("TRANSFER_DEPT_NAME", organ.getCName());

        
        // 封装分数；
        data.add("COPIES", getParameter("COPIES","0"));
        // 封装移交日期
        data.add("TRANSFER_DATE", UtilDateTime.nowDateString());
        // 封装交接单状态为0（拟交接）
        data.add("AT_STATE", "0");

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            // 交接单代码
            if ("".equals(TI_ID)) {
                FileCommonManager fcm = new FileCommonManager();
                String bh = fcm.createConnectNO(conn, TRANSFER_CODE);
                data.add("CONNECT_NO", bh);//交接编号
            } else {
                data.add("CONNECT_NO", getParameter("CONNECT_NO"));
            }
            // 创建交接单
            TI_ID = handler.TransferListSave(conn, data);
            
            String chioceuuid = getParameter("chioceuuid");
            String[] uuid = chioceuuid.split("#");
            for(int i=0;i<uuid.length;i++){
                String TID_ID = uuid[i];
                // 更新交接明细表 "1"代表拟移交
                Data TIDdata = new Data();
                TIDdata.add("TID_ID", TID_ID);
                TIDdata.add("TI_ID", TI_ID);
                TIDdata.add("TRANSFER_STATE", "1");//交接状态：拟移交
                handler.TransferDetailSave(conn, TIDdata);
            }
            //儿童材料全局状态          
            if(TransferConstant.TRANSFER_TYPE_CHILD.equals(TRANSFER_TYPE)){//儿童材料
                ChildCommonManager ccm = new ChildCommonManager();
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_FYGS)){//安置部-翻译公司
                	ccm.zxPreTranslation(conn,TI_ID, curuser.getCurOrgan());
                }
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){//安置部-档案部
                	ccm.childTransferToDABSave(conn,TI_ID,curuser.getCurOrgan());
                }
                if(TRANSFER_CODE.equals(TransferCode.RFM_CHILDINFO_DAB_AZB)){//档案部-安置部
                    ccm.returnCIToBeTransfered(conn,TI_ID,curuser.getCurOrgan());
                }
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "保存成功!");// 保存成功 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
     * 单条提交交接单
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
        // 封装交接单信息数据
        
        data.add("COPIES", uuid.length);

        // 获取当前登陆人及当前登陆人的部门信息
        UserInfo curuser = SessionInfo.getCurUser();
        // 封装移交人ID
        data.add("TRANSFER_USERID", curuser.getPersonId());
        data.add("TRANSFER_USERNAME", curuser.getPerson().getCName());
        // 封装部门信息：代码、中文名称
        Organ organ = curuser.getCurOrgan();
        data.add("TRANSFER_DEPT_ID", organ.getOrgCode());
        data.add("TRANSFER_DEPT_NAME", organ.getCName());

        // 封装移交日期
        data.add("TRANSFER_DATE", UtilDateTime.nowDateString());

        // 封装交接单状态为1（已移交）
        data.add("AT_STATE", "1");

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            if("".equals(TI_ID)){
                
                FileCommonManager fcm = new FileCommonManager();
                CONNECT_NO = fcm.createConnectNO(conn, TRANSFER_CODE);
            }
            data.add("CONNECT_NO", CONNECT_NO);//交接编号
            
            // 提交交接单
            Data TIdata = handler.saveTransferInfo(conn, data);
            // 更新交接明细表 "2"代表已移交
            for(int i = 0; i < uuid.length; i++){
                Data TIDdata = new Data();
                TIDdata.add("TID_ID", uuid[i]);
                TIDdata.add("TI_ID", TIdata.getString("TI_ID"));//交接状态
                TIDdata.add("TRANSFER_STATE", "2");//交接状态
                handler.saveTransferInfoDetail(conn, TIDdata);
            }
                        
            //儿童材料全局状态
            if(TransferConstant.TRANSFER_TYPE_CHILD.equals(transfer_type)){//儿童材料
            	ChildCommonManager ccm = new ChildCommonManager();
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_FYGS)){                    
                    ccm.zxSendTranslation(conn,TIdata.getString("TI_ID"), curuser.getCurOrgan());   
                }
                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){                    
                    ccm.childTransferToDABSubmit(conn,TIdata.getString("TI_ID"), curuser.getCurOrgan());   
                }
                if(TRANSFER_CODE.equals(TransferCode.RFM_CHILDINFO_DAB_AZB)){//档案部-安置部
                    ccm.returnCIIsTransfered(conn,TI_ID,curuser.getCurOrgan());
                }
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");// 保存成功 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");// 保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");// 保存失败 2
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * 批量提交交接单
     * 
     * @return
     */
    public String TransferListBatchSubmit() {
        // 获取页面传递过来的批量提交的交接单编码
        String chioceuuid = getParameter("chioceuuid");
        String transfer_type = getParameter("TRANSFER_TYPE");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String[] uuid = chioceuuid.split("#");

        // 封装TRANSFER_INFO表修改数据
        DataList dl = new DataList();
        for (int i = 1; i < uuid.length; i++) {
            Data data = new Data();
            data.add("TI_ID", uuid[i]);
            // 获取当前登陆人及当前登陆人的部门信息
            UserInfo curuser = SessionInfo.getCurUser();
            // 封装移交人ID
            data.add("TRANSFER_USERID", curuser.getPersonId());
            data.add("TRANSFER_USERNAME", curuser.getPerson().getCName());
            // 封装部门信息：代码、中文名称
            Organ organ = curuser.getCurOrgan();
            data.add("TRANSFER_DEPT_ID", organ.getOrgCode());
            data.add("TRANSFER_DEPT_NAME", organ.getCName());

            // 封装移交日期
            data.add("TRANSFER_DATE", UtilDateTime.nowDateString());
            dl.add(data);
        }
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            // 更新交接单 "1"代表已提交
            handler.TransferBatchSubmit(conn, dl,TransferConstant.AT_STATE_DONE);
            // 更新交接明细表 "2"代表已移交
            for (int i = 1; i < uuid.length; i++) {
                handler.UpdateTransfer(conn, uuid[i]);
            }
            
            if(TransferConstant.TRANSFER_TYPE_CHILD.equals(transfer_type)){
                //更新儿童材料全局状态
                ChildCommonManager ccm = new ChildCommonManager();
                UserInfo curuser = SessionInfo.getCurUser();
                for(int t=0;t<dl.size();t++){                    
	                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_FYGS)){                    
	                    ccm.zxSendTranslation(conn,dl.getData(t).getString("TI_ID"), curuser.getCurOrgan());   
	                }
	                if(TRANSFER_CODE.equals(TransferCode.CHILDINFO_AZB_DAB)){                    
	                    ccm.childTransferToDABSubmit(conn,dl.getData(t).getString("TI_ID"), curuser.getCurOrgan());   
	                }
	                if(TRANSFER_CODE.equals(TransferCode.RFM_CHILDINFO_DAB_AZB)){//档案部-安置部
	                    ccm.returnCIIsTransfered(conn,dl.getData(t).getString("TI_ID"),curuser.getCurOrgan());
	                }
                }
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");// 保存成功 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");// 保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");// 保存失败 2
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
                    	log.logError( "TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    e.printStackTrace();
                }
            }
        }

        return retValue;
    }

    /**
     * 查看方法(描述可自定义)
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
                        log.logError("Connection因出现异常，未能关闭", e);
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
     * 添加交接单页面移除选中的列表项目方法
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
                // 页面使用的交接单信息
                data = handler.TransferEdit(conn, TI_ID);
                // 页面使用的交接单详细内容
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
                log.logError("操作异常:" + e.getMessage(), e);
            }
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "添加交接单页面移除选操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("添加交接单页面移除选操作异常[移除操作]:" + e.getMessage(), e);
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
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "添加交接单页面移除选失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        }
        finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     * 交接功能入口方法，需要根据参数判断操作类型，业务环节
     * 
     * @param String TRANSFER_CODE
     *            判断业务环节参数
     * @param String OPER_TYPE
     *            判断操作类型参数
     * @return
     */
    public String TransferList() {

        // 声明初始化参数 TRANSFER_CODE 业务环节
        // TRANSFER_TYPE 操作类型 ：1:收养文件；2：儿童材料；3：票据；4:安置后报告
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        // 从菜单调用，获得初始化参数 创建session保存初始化配置
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

        // 从“查询”按钮调用，无法获得初始化参数，从session中获得初始化参数
        /*if ("".equals(TRANSFER_CODE) || TRANSFER_CODE == null) {
            TRANSFER_CODE = (String) session
                    .getAttribute("TransferManager_TRANSFER_CODE");
        }
        if ("".equals(TRANSFER_TYPE) || TRANSFER_TYPE == null) {
            TRANSFER_TYPE = (String) session
                    .getAttribute("TransferManager_TRANSFER_TYPE");
        }*/

        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = "CONNECT_NO";
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = "desc";
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
        Data data = getRequestEntityData("S_", "CONNECT_NO", "COPIES",
                "TRANSFER_USERNAME", "TRANSFER_DATE_START",
                "TRANSFER_DATE_END", "RECEIVER_USERNAME",
                "RECEIVER_DATE_START", "RECEIVER_DATE_END", "AT_STATE");

        // 判断参数中的操作类型,设置操作对象类型查询条件: 1:收养文件；2：儿童材料；3：票据；4:安置后报告
        if ("1".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "1");

        } else if ("2".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "2");
        } else if ("3".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "3");
        } else if ("4".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "4");
        }
        // 设置操作类型为移交
        data.add("OPER_TYPE", "1");
        // 根据参数中的交接代码设置查询条件

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
            DataList dl = handler.TransferList(conn, data, pageSize, page,
                    compositor, ordertype);
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * 进入“手工添加”移交文件选择列表
     * 
     * @return
     */
    public String TransferMannualFileList() {
        // 获取当前业务环节
        
        //String TI_ID = getParameter("TI_ID");
    	String mannualDeluuid = getParameter("mannualDeluuid","");
        String transfer_code = getParameter("TRANSFER_CODE");
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
        Data data = getRequestEntityData("S_", "COUNTRY_CODE","ADOPT_ORG_ID",
                "REGISTER_DATE_START", "REGISTER_DATE_END", "FILE_NO",
                "FILE_TYPE", "MALE_NAME", "FEMALE_NAME", "HANDLE_TYPE");
        data.add("TRANSFER_CODE", transfer_code);
        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
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

            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            //setAttribute("TI_ID", TI_ID);
            setAttribute("TRANSFER_CODE", transfer_code);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("mannualDeluuid", mannualDeluuid);

        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * 删除拟移交状态的交接单
     * 
     * @return
     */
    public String TransferDelete() {

        String chioceuuid = getRequest().getParameter("chioceuuid");
        String[] uuid = chioceuuid.split("#");
        String transfer_code = getParameter("TRANSFER_CODE");
        // 封装TRANSFER_INFO表删除Data
        DataList dl = new DataList();
        for (int i = 1; i < uuid.length; i++) {
            Data data = new Data();
            data.add("TI_ID", uuid[i]);
            dl.add(data);
        }
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            // 删除交接单
            success = handler.TransferBatchDelete(conn, dl, "1");
            // 更新交接明细表，清除交接单ID与交接状态代码
            for (int i = 1; i < uuid.length; i++) {
                success = handler.UpdateTransfer_Delete(conn, uuid[i],
                        transfer_code);
            }

            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");// 保存成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "删除操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "删除失败!");// 保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "删除失败!");// 保存失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }

        return retValue;
    }

    /**
     * 进入修改移交单界面
     * 
     * @return
     */
    public String InUpdateTransfer() {
    	 String type = getParameter("type", "");
    	 String TRANSFER_CODE = getParameter("TRANSFER_CODE");
         String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
         String TI_ID = getParameter("TI_ID","");
         
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // 查询交接单数据
                if(!"".equals(TI_ID)){
                    data = handler.TransferEdit(conn, TI_ID);
                    dataList = handler.TransferEditDetailList(conn, TI_ID,TRANSFER_CODE);
                }
                for(int i=0;i<uuid.length;i++){
                    String TID_ID = uuid[i];
                    DataList dl = handler.TransferEditDetailListOfUuid(conn, TID_ID,TRANSFER_CODE);//新的handler方法
                    dataList.addAll(dl);
                }
                setAttribute("mannualDeluuid", chioceuuid);
            }else{
                data = handler.TransferEdit(conn, TI_ID);
                dataList = handler.TransferEditDetailList(conn, TI_ID,TRANSFER_CODE);
            }


            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
     * 儿童材料修改移交单界面
     * @author wang
     * @return
     */
    public String InUpdateTransferChildinfo() {
    	String type = getParameter("type", "");
    	  String TRANSFER_CODE = getParameter("TRANSFER_CODE");
          String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
          String TI_ID = getParameter("TI_ID","");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // 查询交接单数据
                if(!"".equals(TI_ID)){
                    data = handler.TransferEdit(conn, TI_ID);
                    dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
                }
                for(int i=0;i<uuid.length;i++){
                    String TID_ID = uuid[i];
                    DataList dl = handler.TransferEditDetailChildinfoListOfUuid(conn, TID_ID);//新的handler方法
                    dataList.addAll(dl);
                }
                setAttribute("mannualDeluuid", chioceuuid);
            }else{
                data = handler.TransferEdit(conn, TI_ID);
                dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
            }

            //dt = DBTransaction.getInstance(conn);

            // 查询交接单数据
            //data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            //dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
            setAttribute("Edit_Transfer_data", data);
            setAttribute("Transfer_Detail_DataList",dataList);
            setAttribute("TRANSFER_CODE",TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);
            //dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            //try {
            //  dt.rollback();
            //} catch (SQLException e1) {
            //  e1.printStackTrace();
            //}
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    /**
     * 安置部到档案部的材料需要取得匹配信息
     * @Title: InUpdateTransferChildMatchinfo
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午4:53:25
     * @return
     */
    public String InUpdateTransferChildMatchinfo() {
    	String type = getParameter("type", "");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TI_ID = getParameter("TI_ID","");
      // 页面使用的交接单信息
      Data data = new Data();
      // 页面使用的交接单详细内容
      DataList dataList = new DataList();
      try {
          // 2 获取数据库连接
          conn = ConnectionManager.getConnection();
          //dt = DBTransaction.getInstance(conn);
          if("refresh".equals(type)){
              String chioceuuid = getParameter("chioceuuid","");
              String[] uuid = chioceuuid.split("#");
              // 查询交接单数据
              if(!"".equals(TI_ID)){
                  data = handler.TransferEdit(conn, TI_ID);
                  dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
              }
              for(int i=0;i<uuid.length;i++){
                  String TID_ID = uuid[i];
                  DataList dl = handler.TransferEditDetailChildMatchinfoListOfUuid(conn, TID_ID);//新的handler方法
                  dataList.addAll(dl);
              }
              setAttribute("mannualDeluuid", chioceuuid);
          }else{
              data = handler.TransferEdit(conn, TI_ID);
              dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
          }

          // 查询交接单数据
          //data = handler.TransferEdit(conn, TI_ID);
          // 查询交接单详细内容
          //dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
          setAttribute("Edit_Transfer_data", data);
          setAttribute("Transfer_Detail_DataList",dataList);
          setAttribute("TRANSFER_CODE",TRANSFER_CODE);
          setAttribute("TRANSFER_TYPE",TRANSFER_TYPE);
          //dt.commit();
      } catch (DBException e) {
          // 4 设置异常处理
          //try {
          //  dt.rollback();
          //} catch (SQLException e1) {
          //  e1.printStackTrace();
          //}
          setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
          setAttribute(Constants.ERROR_MSG, e);
          if (log.isError()) {
              log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
          }
          InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                      "TransferManagerAction的Connection因出现异常，未能关闭",
                                      e);
                  }
                  e.printStackTrace();
              }
          }
      }
      return retValue;
  }

    /**
     * 进入票据修改移交单界面
     * 
     * @return
     */
    public String InUpdateTransferCheque() {
        String type = getParameter("type", "");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TI_ID = getParameter("TI_ID","");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // 查询交接单数据
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
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * 进入票据修改移交单界面
     * 
     * @return
     */
    public String InUpdateTransferArchive() {
        String type = getParameter("type", "");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String TI_ID = getParameter("TI_ID","");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            if("refresh".equals(type)){
                String chioceuuid = getParameter("chioceuuid","");
                String[] uuid = chioceuuid.split("#");
                // 查询交接单数据
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
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * 进入文件交接单打印页面方法
     * 
     * @return
     */
    public String InTransferFilePrint() {
        String transfer_code = getParameter("TRANSFER_CODE");
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailList(conn, TI_ID,
                    transfer_code);
            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
         * 进入文件交接单打印页面方法(退文)
         *
         * @return
         */
    public String InTransferFilePrintTW() {
        String transfer_code = getParameter("TRANSFER_CODE");
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailList(conn, TI_ID,
                    transfer_code);
            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
     * 进入材料交接单打印页面方法
     * @return
     */
    public String InTransferChildinfoPrint() {
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * 测试页面打印自动分页代码 ·
         *
         *
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "国家"+i); testdata.add("NAME_CN",
         * "收养组织"+i); testdata.add("REGISTER_DATE", ·"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "正常"); testdata.add("MALE_NAME", "男收养人"+i);
         * testdata.add("FEMALE_NAME", "女收养人"+i); testdata.add("NAME", "儿童"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    /**
     * 进入材料交接单打印页面方法（匹配信息）
     * @Title: InTransferChildMatchinfoPrint
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午5:39:22
     * @return
     */
    public String InTransferChildMatchinfoPrint() {
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * 测试页面打印自动分页代码 ·
         * 
         * 
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "国家"+i); testdata.add("NAME_CN",
         * "收养组织"+i); testdata.add("REGISTER_DATE", ·"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "正常"); testdata.add("MALE_NAME", "男收养人"+i);
         * testdata.add("FEMALE_NAME", "女收养人"+i); testdata.add("NAME", "儿童"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    
    /**
     * 查看材料交接单信息
     * @return
     */
    public String InTransferChildinfoView() {
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailChildinfoList(conn, TI_ID);
        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * 测试页面打印自动分页代码 ·
         * 
         * 
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "国家"+i); testdata.add("NAME_CN",
         * "收养组织"+i); testdata.add("REGISTER_DATE", ·"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "正常"); testdata.add("MALE_NAME", "男收养人"+i);
         * testdata.add("FEMALE_NAME", "女收养人"+i); testdata.add("NAME", "儿童"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    
    /**
     * 查看材料交接单信息（匹配）
     * @Title: InTransferChildMatchinfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午5:43:24
     * @return
     */
    public String InTransferChildMatchinfoView() {
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailChildMatchinfoList(conn, TI_ID);
        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        /**
         * 测试页面打印自动分页代码 ·
         * 
         * 
         * for(int i=0;i<200;i++){ Data testdata = new Data();
         * testdata.add("COUNTRY_CN", "国家"+i); testdata.add("NAME_CN",
         * "收养组织"+i); testdata.add("REGISTER_DATE", ·"2014-07-01");
         * testdata.add("FILE_NO", "201409010"+i); testdata.add("FILE_TYPE",
         * "正常"); testdata.add("MALE_NAME", "男收养人"+i);
         * testdata.add("FEMALE_NAME", "女收养人"+i); testdata.add("NAME", "儿童"+i);
         * dataList.add(testdata); }
         **/
        getRequest().setAttribute("transferChildinfo_print_data", data);
        getRequest().setAttribute("transferChildinfo_print_list", dataList);

        return retValue;
    }
    
    /**
     * 
     * @Title: InTransferChequeInfoPrint
     * @Description: 进入票据交接单打印页面方法
     * @author: xugy
     * @date: 2014-11-24下午2:13:55
     * @return
     */
    public String InTransferChequeInfoPrint() {
        String transfer_code = getParameter("TRANSFER_CODE");
        String TI_ID = getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
    
            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailChequeinfoList(conn, TI_ID,transfer_code);
            dt.commit();
            setAttribute("transferChequeinfo_print_data", data);
            setAttribute("transferChequeinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
     * @Description: 进入安置后报告交接单打印页面方法
     * @author: xugy
     * @date: 2014-11-18上午11:28:45
     * @return
     */
    public String InTransferArchiveInfoPrint() {
        String transfer_code = (String) getParameter("tcode");
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
    
            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailArchiveinfoList(conn, TI_ID, transfer_code);
            
            setAttribute("transferArchiveinfo_print_data", data);
            setAttribute("transferArchiveinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
    
        return retValue;
    }
    /**
     * 查看票据交接单信息
     * @Title: InTransferChequeInfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-24上午11:21:08
     * @return
     */
    public String InTransferChequeInfoView() {
        String transfer_code = (String) getParameter("tcode");
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailChequeinfoList(conn, TI_ID,transfer_code);
            setAttribute("transferChequeinfo_print_data", data);
            setAttribute("transferChequeinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
    
        return retValue;
    }
    
    /**
     * 查看安置后反馈报告交接单信息
     * @Title: InTransferArchiveInfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-18下午1:39:10
     * @return
     */
    public String InTransferArchiveInfoView() {
        String transfer_code = (String) getRequest().getSession().getAttribute(
                "TransferManager_TRANSFER_CODE");
        String TI_ID = (String) getParameter("UUID");
        // 页面使用的交接单信息
        Data data = new Data();
        // 页面使用的交接单详细内容
        DataList dataList = new DataList();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
    
            // 查询交接单数据
            data = handler.TransferEdit(conn, TI_ID);
            // 查询交接单详细内容
            dataList = handler.TransferEditDetailArchiveinfoList(conn, TI_ID,
                    transfer_code);
            setAttribute("transferArchiveinfo_print_data", data);
            setAttribute("transferArchiveinfo_print_list", dataList);
        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");
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
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
    
        return retValue;
    }

        /**
     * 查询文件交接详细信息
     * 
     * @return
     */
    public String InFileView() {
    	// 判断当前调用时处于哪个环节 1、移交；2、接收
    	 String OPER_TYPE = getParameter("OPER_TYPE");
         String TRANSFER_CODE = getParameter("TRANSFER_CODE");
         String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");

       

        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
        Data data = getRequestEntityData("S_", "ADOPT_ORG_ID","COUNTRY_CODE",
                "REGISTER_DATE_START", "REGISTER_DATE_END", "MALE_NAME",
                "FEMALE_NAME", "TRANSFER_DATE_START", "TRANSFER_DATE_END",
                "FILE_NO", "CONNECT_NO", "RECEIVER_DATE_START",
                "RECEIVER_DATE_END", "FILE_TYPE", "TRANSFER_STATE");

        // 判断参数中的操作类型,设置操作对象类型查询条件: 1:收养文件；2：儿童材料；3：票据；4:安置后报告
        if ("1".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "1");

        } else if ("2".equals(TRANSFER_TYPE)) {

            data.add("TRANSFER_TYPE", "2");
        }
        // 判断调用的位置 1、为移交；2：为接受 ；不同位置调用数据范围不同

        if ("1".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "1");

        } else if ("2".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "2");
        }
        // 向页面传递当前调用位置判断移交状态下拉列表显示内容
        setAttribute("OPER_TYPE", OPER_TYPE);
        // 根据参数中的交接代码设置查询条件

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
            DataList dl = handler.FindDetailList(conn, data, pageSize, page,
                    compositor, ordertype);
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("OPER_TYPE", OPER_TYPE);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * 查询材料交接详细信息
     * @author wang
     * @return
     */
    public String InChildinfoView() {
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        
        //2 获取变量       
        // 判断当前调用时处于哪个环节 1、移交；2、接收
        String OPER_TYPE = getParameter("OPER_TYPE");
       
        //交接代码
        String TRANSFER_CODE = (String)getParameter("TRANSFER_CODE");
        //交接单类型
        String TRANSFER_TYPE = TransferConstant.TRANSFER_TYPE_CHILD;


        // 获取搜索参数
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

        // 判断参数中的操作类型,设置操作对象类型查询条件: 1:收养文件；2：儿童材料；3：票据；4:安置后报告
        data.add("TRANSFER_TYPE", TRANSFER_TYPE);
        //操作类型 发送、接收
        data.add("OPER_TYPE", OPER_TYPE);
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
            DataList dl = handler.FindChildinfoDetailList(conn, data, pageSize, page, compositor, ordertype);
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
         // 向页面传递当前调用位置判断移交状态下拉列表显示内容
            setAttribute("OPER_TYPE", OPER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }
    /**
     * 查询材料（匹配）交接详细信息
     * @Title: InChildMatchinfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午5:46:43
     * @return
     */
    public String InChildMatchinfoView() {
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        
        //2 获取变量       
        // 判断当前调用时处于哪个环节 1、移交；2、接收
        String OPER_TYPE = getParameter("OPER_TYPE");
       
        //交接代码
        String TRANSFER_CODE = (String)getParameter("TRANSFER_CODE");
        //交接单类型
        String TRANSFER_TYPE = TransferConstant.TRANSFER_TYPE_CHILD;


        // 获取搜索参数
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

        // 判断参数中的操作类型,设置操作对象类型查询条件: 1:收养文件；2：儿童材料；3：票据；4:安置后报告
        data.add("TRANSFER_TYPE", TRANSFER_TYPE);
        //操作类型 发送、接收
        data.add("OPER_TYPE", OPER_TYPE);
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
            DataList dl = handler.FindChildMatchinfoDetailList(conn, data, pageSize, page, compositor, ordertype);
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
         // 向页面传递当前调用位置判断移交状态下拉列表显示内容
            setAttribute("OPER_TYPE", OPER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * 查询票据交接详细信息
     * 
     * @return
     */
    public String InChequeView() {
        // 判断当前调用时处于哪个环节 1、移交；2、接收
        String OPER_TYPE = getParameter("OPER_TYPE");

        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
        Data data = getRequestEntityData("S_", "COUNTRY_CODE", "ADOPT_ORG_ID","PAID_WAY",
                "PAID_NO", "BILL_NO", "PAR_VALUE_START", "PAR_VALUE_END",
                "CONNECT_NO", "TRANSFER_DATE_START", "TRANSFER_DATE_END",
                "RECEIVER_DATE_START", "RECEIVER_DATE_END", "TRANSFER_STATE");

        data.add("TRANSFER_TYPE", "3");

        // 判断调用的位置 1、为移交；2：为接受 ；不同位置调用数据范围不同

        if ("1".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "1");

        } else if ("2".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "2");
        }
        // 向页面传递当前调用位置判断移交状态下拉列表显示内容
        // 根据参数中的交接代码设置查询条件

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
            DataList dl = handler.FindChequeDetailList(conn, data, pageSize,
                    page, compositor, ordertype);
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("OPER_TYPE", OPER_TYPE);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
     * @date: 2014-11-18下午1:51:34
     * @return
     */
    public String InArchiveView() {
        // 判断当前调用时处于哪个环节 1、移交；2、接收
        String OPER_TYPE = getParameter("OPER_TYPE");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
        Data data = getRequestEntityData("S_", "COUNTRY_CODE","ADOPT_ORG_NAME", "ADOPT_ORG_ID",
                "ARCHIVE_NO", "MALE_NAME", "FEMALE_NAME", "NAME","SIGN_DATE_START","SIGN_DATE_END","REPORT_DATE_START","REPORT_DATE_END","NUM",
                "CONNECT_NO", "TRANSFER_DATE_START", "TRANSFER_DATE_END",
                "RECEIVER_DATE_START", "RECEIVER_DATE_END", "TRANSFER_STATE");

        data.add("TRANSFER_TYPE", "4");

        // 判断调用的位置 1、为移交；2：为接受 ；不同位置调用数据范围不同

        if ("1".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "1");

        } else if ("2".equals(OPER_TYPE)) {
            data.add("OPER_TYPE", "2");
        }
        // 向页面传递当前调用位置判断移交状态下拉列表显示内容
        // 根据参数中的交接代码设置查询条件

        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
            DataList dl = handler.FindArchiveDetailList(conn, data, pageSize,
                    page, compositor, ordertype);
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("OPER_TYPE", OPER_TYPE);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * 进入儿童材料添加页面
     * 
     * @return
     */
    public String TransferAddChildinfo() {
        // 获取session中的手工添加列表，判断是否存在历史交接单据
        HttpSession session = getRequest().getSession();
        DataList dl = (DataList) session
                .getAttribute("Transfer_Detail_DataList");
        if (dl == null) {
            // 创建页面初始化数据
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
     * 手工选择移交的材料
     * @author wang
     * @return
     */
    public String TransferMannualChildinfoList() {
        // 获取当前业务环节
        //String transfer_code = (String) getRequest().getSession().getAttribute("TransferManager_TRANSFER_CODE");
    	//String TI_ID = getParameter("TI_ID");
    	 String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 1.2 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 1.3 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 1.4 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
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
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
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

            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            //setAttribute("TI_ID", TI_ID);
            setAttribute("mannualDeluuid", mannualDeluuid);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);

        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 安置部到档案部材料带匹配信息
     * @Title: TransferMannualChildMatchinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午5:18:16
     * @return
     */
    public String TransferMannualChildMatchinfoList() {
        // 获取当前业务环节
        //String transfer_code = (String) getRequest().getSession().getAttribute("TransferManager_TRANSFER_CODE");
        //String TI_ID = getParameter("TI_ID");
    	 String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 1.2 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 1.3 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 1.4 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
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
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            
            // 5 获取数据DataList
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

            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            //setAttribute("TI_ID", TI_ID);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("mannualDeluuid", mannualDeluuid);
            
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                        .logError(
                                "TransferManagerAction的Connection因出现异常，未能关闭",
                                e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 手工选择移交的票据
     * 
     * @return
     */
    public String TransferMannualChequeList() {
        String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = "PAID_NO";
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = "desc";
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
        Data data = getRequestEntityData("S_", "COUNTRY_CODE", "ADOPT_ORG_NAME","ADOPT_ORG_ID", "PAID_WAY", "PAID_NO", "BILL_NO","PAR_VALUE");
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
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
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("mannualDeluuid", mannualDeluuid);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("TransferManagerAction的Connection因出现异常，未能关闭", e);
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
        // 获取当前业务环节
        String mannualDeluuid = getParameter("mannualDeluuid","");
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = null;
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = null;
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
        Data data = getRequestEntityData("S_", "COUNTRY_CODE","ADOPT_ORG_NAME", "ADOPT_ORG_ID", "ARCHIVE_NO", "MALE_NAME", "FEMALE_NAME", "SIGN_DATE_START", "SIGN_DATE_END", "REPORT_DATE_START","REPORT_DATE_END", "NUM");
        data.add("TRANSFER_CODE", TRANSFER_CODE);
        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
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
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("mannualDeluuid", mannualDeluuid);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     * ***************************************以下为接收方法***************************
     * *********************
     */

    /**
     * 交接管理-接收功能入口 查询默认状态为已移交的交接单 按照参数transfer_code确定业务环节与操作类型
     * @return
     */
    public String TransferReceiveList() {

        // 声明初始化参数 TRANSFER_CODE 业务环节
        // TRANSFER_TYPE 交接类型
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");

        // 1 设置分页参数
        int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        // 获取排序字段
        String compositor = (String) getParameter("compositor", "");
        if ("".equals(compositor)) {
            compositor = "CONNECT_NO";
        }
        // 获取排序类型 ASC DESC
        String ordertype = (String) getParameter("ordertype", "");
        if ("".equals(ordertype)) {
            ordertype = "asc";
        }
        // 获取搜索参数
        InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
        setAttribute("clueTo", clueTo);// set操作结果提醒
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
        // 设置交接类型 
        data.add("OPER_TYPE",TransferConstant.OPER_TYPE_RECEIVE);
        // 根据参数中的交接代码设置查询条件
        data.add("TRANSFER_CODE", TRANSFER_CODE);

        try {
            // 4 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 5 获取数据DataList
            DataList dl = handler.TransferReceiveList(conn, data, pageSize,  page, compositor, ordertype);
            // 6 将结果集写入页面接收变量
            setAttribute("List", dl);
            setAttribute("data", data);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        } catch (DBException e) {
            // 7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            retValue = "error1";
        } finally {
            // 8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log
                                .logError(
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    retValue = "error2";
                }
            }
        }

        return retValue;
    }

    /**
     * 接收方法，操作实体文件
     * 
     * @return
     */
    public String ReceiveFileList() {
        //1 获取操作人基本信息及系统日期
        String personId = SessionInfo.getCurUser().getPerson().getPersonId();
        String personName = SessionInfo.getCurUser().getPerson().getCName();
        String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        String deptName = SessionInfo.getCurUser().getCurOrgan().getCName();
        String curDate = DateUtility.getCurrentDate();
        
        
        String transfer_code = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        
        // 交接单信息
        Data data = new Data();
        
        // 明细文件信息
        DataList dataList = new DataList();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", personId);//接收人ID
            data.add("RECEIVER_USERNAME", personName);//接收人姓名
            data.add("RECEIVER_DATE", curDate);//接收日期
            data.add("RECEIVER_DEPT_ID", deptId);//接收单位ID
            data.add("RECEIVER_DEPT_NAME", deptName);//接收单位名称
            // 查询交接文件信息
            dataList = handler.TransferEditDetailList(conn, chioceuuid,transfer_code);

            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
     * 接收方法，操作实体材料
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
        
        // 交接单信息
        Data data = new Data();
        // 明细文件信息
        DataList dataList = new DataList();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();

            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", userId);
            data.add("RECEIVER_USERNAME", userName);
            data.add("RECEIVER_DEPT_ID", deptCode);
            data.add("RECEIVER_DEPT_NAME", deptName);
            data.add("RECEIVER_DATE", currentDate);
            // 查询交接文件信息
            dataList = handler.TransferEditDetailChildinfoList(conn,chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            
            

        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    
    /**
     * 接收方法，操作实体材料（匹配）
     * @Title: ReceiveChildMatchinfoList
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午8:29:13
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
        
        // 交接单信息
        Data data = new Data();
        // 明细文件信息
        DataList dataList = new DataList();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();

            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", userId);
            data.add("RECEIVER_USERNAME", userName);
            data.add("RECEIVER_DEPT_ID", deptCode);
            data.add("RECEIVER_DEPT_NAME", deptName);
            data.add("RECEIVER_DATE", currentDate);
            // 查询交接文件信息
            dataList = handler.TransferEditDetailChildMatchinfoList(conn,chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);

        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * 接收方法，操作实体票据
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

        // 交接单信息
        Data data = new Data();
        // 明细文件信息
        DataList dataList = new DataList();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            data.add("RECEIVER_USERID", userId);
            data.add("RECEIVER_USERNAME", userName);
            data.add("RECEIVER_DEPT_ID", deptCode);
            data.add("RECEIVER_DEPT_NAME", deptName);
            data.add("RECEIVER_DATE", currentDate);
            // 查询交接文件信息
            dataList = handler.TransferEditDetailChequeList(conn, chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * 接收方法，操作实体安置后报告
     * 
     * @return
     */
    public String ReceiveArchiveList() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        // 交接单信息
        Data data = new Data();
        // 明细文件信息
        DataList dataList = new DataList();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            // 查询交接文件信息
            dataList = handler.TransferEditDetailArchiveList(conn, chioceuuid);

            dt.commit();
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }

        
        return retValue;
    }

    /**
     * 接收文件确认方法
     * 
     * @return
     */
    public String ReceiveConfirm() {
        // 获得接收确认的交接单号
        String TI_ID = getParameter("TI_ID");
        // 获取业务环节
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");

        String currentDate = DateUtility.getCurrentDate();
        // 获取当前登陆人及当前登陆人的部门信息
        UserInfo curuser = SessionInfo.getCurUser();
        // 接收ID
        String RECEIVER_USERID = curuser.getPersonId();
        String RECEIVER_USERNAME = curuser.getPerson().getCName();
        // 部门信息：代码、中文名称
        Organ organ = curuser.getCurOrgan();
        String RECEIVER_DEPT_ID = organ.getOrgCode();
        String RECEIVER_DEPT_NAME = organ.getCName();
        // 参数传递-交接详细信息
        DataList pdL = new DataList();
        // 参数传递-交接单信息
        Data pda = new Data();
        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 更新交接单
            handler.ReceiveConfirm(conn, TI_ID, RECEIVER_USERID,RECEIVER_USERNAME, RECEIVER_DEPT_ID, RECEIVER_DEPT_NAME);
            // 更新交接列表
            handler.ReceiveConfirmDetail(conn, TI_ID);
            // 查询交接详细信息
            pda = handler.selectTransferById(conn, TI_ID);
            pdL = handler.selectTransferDetailById(conn, TI_ID);
            // 后续初始化操作
            FileCommonManager fc = new FileCommonManager();
            if (TransferCode.FILE_BGS_FYGS.equals(TRANSFER_CODE)) {
                // 如果操作类型为“11” 代表办公室到翻译公司的移交，后续调用业务初始化方法初始化带翻译记录
                fc.translationInit(pda, pdL, conn);
            } else if (TransferCode.FILE_FYGS_SHB.equals(TRANSFER_CODE)) {
                // 如果业务类型为12 代表翻译公司到审核部的文件移交，后续调用文件什么的初始化功能
                // 封装审核初始化data
                DataList pList = new DataList();
                for (int i = 0; i < pdL.size(); i++) {
                    Data d = new Data();
                    d.add("AF_ID", pdL.getData(i).get("APP_ID"));
                    d.add("AUDIT_LEVEL", "0");
                    pList.add(d);
                }
                fc.auditInit(conn, pList);
            } else if (TransferCode.FILE_SHB_DAB.equals(TRANSFER_CODE)) {
                // 如果业务类型为13代表审核部到档案部的文件移交
                // 首先判断文件是否关联一个特需儿童，如果关联特需儿童则调用匹配模块方法，创建一个待审核的匹配记录
                /*Object[] ol = findTList(conn, pdL);
                // 本次移交中，关联了特需儿童的文件处理
                DataList txFlist = (DataList) ol[0];
                if (txFlist != null && txFlist.size() > 0) {
                    for (int i = 0; i < txFlist.size(); i++) {
                        // 设置匹配状态为“已匹配”
                        txFlist.getData(i).add("MATCH_STATE", "1");
                        txFlist.getData(i).add("AF_ID",
                                txFlist.getData(i).getString("APP_ID"));
                    }
                    SpecialMatchAction sa = new SpecialMatchAction();
                    // 创建家庭匹配待审核记录
                    sa.saveMatchInfo(conn, txFlist);
                    // 更新家庭文件表匹配状态
                    FileCommonManager fm = new FileCommonManager();
                    fm.piPeiInit(conn, txFlist);
                }
                // 本次移交中的普通文件处理
                // 匹配状态设置成“待匹配”
                DataList ptList = (DataList) ol[1];
                if (ptList != null && ptList.size() > 0) {
                    for (int i = 0; i < ptList.size(); i++) {
                        // 设置匹配状态为“待匹配”
                        ptList.getData(i).add("MATCH_STATE", "0");
                        ptList.getData(i).add("AF_ID",
                                ptList.getData(i).getString("APP_ID"));
                    }
                    // 档案部后续业务处理,更新正常文件状态为待匹配
                    FileCommonManager fm = new FileCommonManager();
                    fm.piPeiInit(conn, ptList);
                }*/
                
                
                SpecialMatchAction sa = new SpecialMatchAction();
                // 创建家庭匹配待审核记录
                sa.saveMatchInfo(conn, pdL);
            } else if (TransferCode.CHILDINFO_AZB_FYGS.equals(TRANSFER_CODE)) {
                // 如果业务类型为21 代表安置部到翻译公司的材料移交 初始化翻译数据
                // 翻译类型
                ChildInfoConstants cic = new ChildInfoConstants();
                // 初始化接口
                ChildManagerHandler cmh = new ChildManagerHandler();
                for (int i = 0; i < pdL.size(); i++) {
                    pdL.getData(i).add("TRANSLATION_TYPE",ChildInfoConstants.TRANSLATION_TYPE_TR); // 翻译类型
                    pdL.getData(i).add("CI_ID",pdL.getData(i).getString("APP_ID")); // 儿童ID
                    pdL.getData(i).add("NOTICE_DATE",UtilDateTime.nowDateString());// 翻译通知日期
                    pdL.getData(i).add("NOTICE_USERID", RECEIVER_USERID); // 翻译通知人ID
                    pdL.getData(i).add("NOTICE_USERNAME", RECEIVER_USERNAME);
                    pdL.getData(i).add("RECEIVE_DATE", currentDate);// 接收日期
                    pdL.getData(i).add("TRANSLATION_STATE",ChildInfoConstants.TRANSLATION_STATE_TODO); // 翻译状态（初始化应为TRANSLATION_STATE_TODO="0"  待翻译
                    pdL.getData(i).setConnection(conn);
                    pdL.getData(i).setEntityName("CMS_CI_TRANSLATION");
                    pdL.getData(i).setPrimaryKey("CT_ID");
                    // 去除无用字段
                    pdL.getData(i).removeData("APP_ID");
                    pdL.getData(i).removeData("TRANSFER_CODE");
                    pdL.getData(i).removeData("TI_ID");
                    pdL.getData(i).removeData("TID_ID");
                    pdL.getData(i).removeData("TRANSFER_STATE");
                }
                cmh.initCITranslation(conn, pdL);
                //更新儿童材料全局状态
                ChildCommonManager ccm = new ChildCommonManager();                
                ccm.fygsReceiveTranslation(conn, TI_ID, curuser.getCurOrgan());
    
            } else if (TransferCode.CHILDINFO_FYGS_AZB.equals(TRANSFER_CODE)) {
                // 如果业务类型为22 代表翻译公司到安置部的材料移交
                ChildManagerHandler cmh = new ChildManagerHandler();
                DataList dlDataList = new DataList();
                for (int i = 0; i < pdL.size(); i++) {
                    Data data = new Data();
                    data.add("CI_ID", pdL.getData(i).getString("APP_ID"));
                    dlDataList.add(data);
                }
                cmh.updateCIState(conn, dlDataList);
            } else if (TransferCode.CHILDINFO_AZB_DAB.equals(TRANSFER_CODE)) {
                // 如果业务类型为23代表安置部到档案部的材料移交，后续业务是匹配结果的领导签批
                // 向匹配表添加报批时间
                FarCommonHandler fh = new FarCommonHandler();
                fh.SignSumbit(conn, pdL);
                
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.DAB_WJJJ_AZBTODAB_CLJS);
                for (int i = 0; i < pdL.size(); i++) {
                    data.add("AF_ID", pdL.getData(i).getString("APP_ID"));
                    AFhandler.modifyFileInfo(conn, data);//修改收养人的匹配信息
                }
                
              //更新儿童材料全局状态
                ChildCommonManager ccm = new ChildCommonManager();                
                ccm.childTransferToDABReceive(conn, TI_ID, curuser.getCurOrgan());
                
            } else if (TransferCode.RFM_CHILDINFO_DAB_AZB.equals(TRANSFER_CODE)) {
              //更新儿童材料全局状态
                ChildCommonManager ccm = new ChildCommonManager();                
                ccm.returnCIIsReceived(conn, TI_ID, curuser.getCurOrgan());
            } else if (TransferCode.ARCHIVE_DAB_FYGS.equals(TRANSFER_CODE)) {
                // 如果业务类型为41代表档案部到爱之桥的安置后报告移交，后续业务安置后报告翻译
                // FB_REC_ID安置后报告主键
                // 档案部到翻译公司REPORT_STATE='3'
                // （翻译状态）TRANSLATION_STATE='0'
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
                // 如果业务类型为42代表爱之桥到档案部的安置后报告移交，后续业务安置后报告审核
                // FB_REC_ID安置后报告主键
                // 翻译公司到档案部REPORT_STATE='6'
                // （审核状态）ADUIT_STATE='0'
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
                // 如果业务类型为31代表办公室到财务部的票据
                String curDate = DateUtility.getCurrentDate();
                for (int i = 0; i < pdL.size(); i++) {
                    Data pjData = new Data();
                    pjData.add("CHEQUE_ID", pdL.getData(i).get("APP_ID")); // 票据登记ID
                    pjData.add("CHEQUE_TRANSFER_STATE", "4"); // 移交状态(4：已接收)
                    pjData.add("RECEIVE_DATE", curDate); // 接收日期
                    pjData.add("COLLECTION_STATE", "0"); // 托收_托收状态(0：未托收)
                    pjData.add("ARRIVE_STATE", "0"); // 到账_到账状态(0：待确认)
                    
                    handler.updateFamChequeInfo(conn, pjData);
                }
            } else if (TransferCode.RFM_FILE_DAB.equals(TRANSFER_CODE.substring(0, 1))) {
                // 如果业务类型为5代表推文件到档案部的移交，后续业务是修改文件表、退文记录表的退文状态
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
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "更新操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("更新操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "更新失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "更新失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * 筛选家庭收养文件列表中关联了特需儿童的文件，返回一个Object【】 0位置存储关联了个儿童的特需文件；1位置存储正常文件
     * 
     * @param conn
     * @param pdl
     * @return
     * @throws DBException
     */
    private Object[] findTList(Connection conn, DataList pdl) throws DBException {
        Object[] objlist = new Object[2];
        // 特需文件列表
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
        // 特需文件
        if (relist != null && relist.size() > 0) {
            objlist[0] = relist;
        } else {
            objlist[0] = null;
        }
        // 正常文件
        if (pdl != null && pdl.size() > 0) {
            objlist[1] = pdl;
        } else {
            objlist[1] = null;
        }
        return objlist;
    }

    /**
     * 接收文件退回方法
     * 
     * @return
     */
    public String ReceiveReturn() {
        // 获得接收确认的交接单号
        String TI_ID = getRequest().getParameter("TI_ID");
        String REJECT_DESC = getRequest().getParameter("REJECT_DESC"); // 备注-退回原因
        // 获取业务环节
        String TRANSFER_CODE = (String) getRequest().getSession().getAttribute(
                "TransferManager_Receive_TRANSFER_CODE");

        // 获取当前登陆人及当前登陆人的部门信息
        UserInfo curuser = SessionInfo.getCurUser();
        // 接收ID
        String REJECT_USERID = curuser.getPersonId();
        String REJECT_USERNAME = curuser.getPerson().getCName();
        // 部门信息：代码、中文名称
        Organ organ = curuser.getCurOrgan();
        String RECEIVER_DEPT_ID = organ.getOrgCode();
        String RECEIVER_DEPT_NAME = organ.getCName();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 更新交接单
            handler.ReceiveReturn(conn, TI_ID, REJECT_USERID, REJECT_USERNAME,
                    RECEIVER_DEPT_ID, RECEIVER_DEPT_NAME, REJECT_DESC);
            // 更新交接列表
            handler.ReceiveReturnDetail(conn, TI_ID);
            // 后续初始化操作
            if (TransferCode.FILE_BGS_FYGS.equals(TRANSFER_CODE)) {
                // 如果操作类型为“11” 代表办公室到翻译公司的移交，后续调用业务初始化方法初始化带翻译记录

            } else {
                // 其他类型的初始化操作
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(1, "退回成功!");
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "更新操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("更新操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "更新失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "更新失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }

    /**
     * 查询儿童材料接收单详细信息
     * @author wang 
     * @return
     */
    public String InReceiveChildinfoView() {
    	String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // 交接单信息
        Data data = new Data();
        // 交接明细信息
        DataList dataList = new DataList();

            // 2 获取数据库连接
            try {
                conn = ConnectionManager.getConnection();           
            //dt = DBTransaction.getInstance(conn);
            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            // 查询交接明细信息
            dataList = handler.TransferEditDetailChildinfoList(conn, chioceuuid);
            //dt.commit();  
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            }catch (DBException e) {
                // 4 设置异常处理
                setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
                setAttribute(Constants.ERROR_MSG, e);
                if (log.isError()) {
                    log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
                }
                InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                            "TransferManagerAction的Connection因出现异常，未能关闭",
                                            e);
                        }
                        e.printStackTrace();
                    }
                }
            }

        return retValue;
    }
    
    
    /**
     * 查询儿童材料（匹配）接收单详细信息
     * @Title: InReceiveChildMatchinfoView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-26下午8:31:46
     * @return
     */
    public String InReceiveChildMatchinfoView() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // 交接单信息
        Data data = new Data();
        // 交接明细信息
        DataList dataList = new DataList();

            // 2 获取数据库连接
            try {
                conn = ConnectionManager.getConnection();           
            //dt = DBTransaction.getInstance(conn);
            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            // 查询交接明细信息
            dataList = handler.TransferEditDetailChildMatchinfoList(conn, chioceuuid);
            //dt.commit();  
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
            }catch (DBException e) {
                // 4 设置异常处理
                setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
                setAttribute(Constants.ERROR_MSG, e);
                if (log.isError()) {
                    log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
                }
                InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                            "TransferManagerAction的Connection因出现异常，未能关闭",
                                            e);
                        }
                        e.printStackTrace();
                    }
                }
            }

        return retValue;
    }
    
    /**
     * 查询接收单详细信息
     * 
     * @return
     */
    public String InReceiveFileView() {
        
        String transfer_code = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // 交接单信息
        Data data = new Data();
        // 明细文件信息
        DataList dataList = new DataList();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);

            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            // 查询交接文件信息
            dataList = handler.TransferEditDetailList(conn, chioceuuid,
                    transfer_code);

            dt.commit();
        } catch (DBException e) {
            // 4 设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
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
     * 查询票据接收单详细信息
     * 
     * @return
     */
    public String InReceiveChequeView() {
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getRequest().getParameter("uuid");
        // 交接单信息
        Data data = new Data();
        // 明细文件信息
        DataList dataList = new DataList();

        try {
            // 2 获取数据库连接
            conn = ConnectionManager.getConnection();

            // 查询交接单信息
            data = handler.TransferEdit(conn, chioceuuid);
            // 查询交接文件信息
            dataList = handler.TransferEditDetailChequeList(conn, chioceuuid);
            setAttribute("Receive_data", data);
            setAttribute("Receive_datalist", dataList);
            setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
            setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        } catch (DBException e) {
            // 4 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
    /**
     * 查询安置后反馈报告接收单详细信息
     * @Title: InReceiveArchiveView
     * @Description: 
     * @author: xugy
     * @date: 2014-11-18下午4:50:20
     * @return
     */
    public String InReceiveArchiveView() {
        //交接代码
        String TRANSFER_CODE = getParameter("TRANSFER_CODE");
        String TRANSFER_TYPE = getParameter("TRANSFER_TYPE");
        String chioceuuid = getParameter("uuid");
        // 交接单信息
        Data data = new Data();
        // 交接明细信息
        DataList dataList = new DataList();
            // 2 获取数据库连接
        try {
            conn = ConnectionManager.getConnection();           
        // 查询交接单信息
        data = handler.TransferEdit(conn, chioceuuid);
        // 查询交接明细信息
        dataList = handler.TransferEditDetailArchiveinfoList(conn, chioceuuid,TRANSFER_CODE);
        setAttribute("Receive_data", data);
        setAttribute("Receive_datalist", dataList);
        setAttribute("TRANSFER_TYPE", TRANSFER_TYPE);
        setAttribute("TRANSFER_CODE", TRANSFER_CODE);
        }catch (DBException e) {
            // 4 设置异常处理
        
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "查询失败!");// 查询失败 2
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
                                        "TransferManagerAction的Connection因出现异常，未能关闭",
                                        e);
                    }
                    e.printStackTrace();
                }
            }
        }
        return retValue;
    }
    
}