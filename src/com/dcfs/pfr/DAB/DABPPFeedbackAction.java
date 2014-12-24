package com.dcfs.pfr.DAB;

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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.pfr.PPFeebbackAttAction;
import com.dcfs.pfr.PPFeebbackAttHandler;
import com.dcfs.pfr.SYZZ.SYZZPPFeedbackHandler;
import com.dcfs.pfr.feedback.PPFeedbackAction;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
/**
 * 
 * @Title: DABPPFeedbackAction.java
 * @Description: 档案部安置后报告反馈
 * @Company: 21softech
 * @Created on 2014-10-10 下午5:23:34
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class DABPPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(DABPPFeedbackAction.class);
    private Connection conn = null;
    private DABPPFeedbackHandler handler;
    private SYZZPPFeedbackHandler SYZZhandler;
    private PPFeedbackHandler PPhandler;
    private PPFeedbackAction PPAction;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public DABPPFeedbackAction() {
        this.handler=new DABPPFeedbackHandler();
        this.SYZZhandler=new SYZZPPFeedbackHandler();
        this.PPhandler=new PPFeedbackHandler();
        this.PPAction=new PPFeedbackAction();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: DABPPFeedbackReceiveList
     * @Description: 反馈接收
     * @author: xugy
     * @date: 2014-10-11下午1:45:55
     * @return
     */
    public String DABPPFeedbackReceiveList(){
     // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","NAME_PINYIN","CHILD_NAME_EN","NUM","REPORT_DATE_START","REPORT_DATE_END","RECEIVE_STATE","RECEIVE_USERNAME","RECEIVE_DATE_START","RECEIVE_DATE_END","REPORT_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABPPFeedbackReceiveList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: DABSendTranslation
     * @Description: 送翻
     * @author: xugy
     * @date: 2014-10-11下午3:06:23
     * @return
     */
    public String DABSendTranslation(){
        String ids = getParameter("ids");//
        String[] array = ids.split("#");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String FB_REC_ID = array[i];
                String nowDate = DateUtility.getCurrentDate();
                Data data = new Data();//
                data.add("FB_REC_ID", FB_REC_ID);//
                data.add("REMINDERS_STATE", "");//催交状态
                data.add("RECEIVE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//接收人ID
                data.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//接收人姓名
                data.add("RECEIVE_DATE", nowDate);//接收日期
                data.add("RECEIVE_STATE", "1");//接收状态
                data.add("REPORT_STATE", "2");//报告状态
                data.add("IS_SF", "1");//送翻送审标识
                PPhandler.savePfrFeedbackRecord(conn, data);
                
                DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//交接明细ID
                transferData.add("APP_ID", FB_REC_ID);//业务记录ID
                transferData.add("TRANSFER_CODE", TransferCode.ARCHIVE_DAB_FYGS);//移交类型
                transferData.add("TRANSFER_STATE", "0");//移交状态
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);//插入一条移交信息
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告送翻成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "报告送翻失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "报告送翻失败!");
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
        }
        return retValue;
    }
    
    /**
     * 提供接口
     * @Title: createFeedbackTranslation
     * @Description: 产生翻译记录
     * @author: xugy
     * @date: 2014-10-13下午1:27:40
     * @param conn
     * @param dl
     * @param FB_REC_ID 业务数据ID
     * @return
     * @throws DBException 
     * @throws Exception
     */
    public String createFeedbackTranslation(Connection conn, DataList dl) throws DBException {
        for(int i=0;i<dl.size();i++){
            String FB_REC_ID = dl.getData(i).getString("FB_REC_ID");
            Data data = PPhandler.getFeedbackTransferInfo(conn, FB_REC_ID);
            Data transData = new Data();
            transData.add("FB_T_ID", "");//报告翻译记录ID
            transData.add("FEEDBACK_ID", data.getString("FEEDBACK_ID"));//FEEDBACK_ID
            transData.add("NUM", data.getString("NUM"));//次数
            transData.add("FB_REC_ID", FB_REC_ID);//安置后报告记录ID
            transData.add("TRANSLATION_TYPE", "0");//翻译类型
            transData.add("NOTICE_DATE", DateUtility.getCurrentDate());//翻译通知日期
            transData.add("NOTICE_USERID", data.getString("TRANSFER_USERID"));//翻译通知人ID
            transData.add("NOTICE_USERNAME", data.getString("TRANSFER_USERNAME"));//翻译通知人姓名
            transData.add("TRANSLATION_STATE", "0");//翻译状态
            PPhandler.savePfrFeedbackTranslation(conn, transData);
        }
        return retValue;
    }
    /**
     * 
     * @Title: DABSendAudit
     * @Description: 送审
     * @author: xugy
     * @date: 2014-10-11下午5:35:01
     * @return
     */
    public String DABSendAudit(){
        String ids = getParameter("ids");//
        String[] array = ids.split("#");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            DataList dl = new DataList();
            for(int i=1;i<array.length;i++){
                String FB_REC_ID = array[i];
                String nowDate = DateUtility.getCurrentDate();
                Data data = new Data();//
                data.add("FB_REC_ID", FB_REC_ID);//
                data.add("REMINDERS_STATE", "");//催交状态
                data.add("RECEIVE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//接收人ID
                data.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//接收人姓名
                data.add("RECEIVE_DATE", nowDate);//接收日期
                data.add("RECEIVE_STATE", "1");//接收状态
                data.add("ADUIT_STATE", "0");//审核状态
                data.add("REPORT_STATE", "6");//报告状态
                data.add("IS_SF", "2");//送翻送审标识
                PPhandler.savePfrFeedbackRecord(conn, data);
                
                dl.add(data);
            }
            createFeedbackAudit(conn, dl);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告送审成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "报告送审失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "报告送审失败!");
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
        }
        return retValue;
    }
    
    /**
     * 提供接口
     * @Title: createFeedbackAudit
     * @Description: 报告审核
     * @author: xugy
     * @date: 2014-10-14上午11:17:29
     * @param conn
     * @param dl
     * @param FB_REC_ID 业务数据ID
     * @return
     * @throws DBException
     */
    public String createFeedbackAudit(Connection conn, DataList dl) throws DBException {
        for(int i=0;i<dl.size();i++){
            String FB_REC_ID = dl.getData(i).getString("FB_REC_ID");
            Data data = PPhandler.getFeedbackRecordInfo(conn, FB_REC_ID);
            Data auditData = new Data();
            auditData.add("FB_A_ID", "");//安置后报告审核记录ID
            auditData.add("FB_REC_ID", FB_REC_ID);//安置后报告记录ID
            auditData.add("NUM", data.getString("NUM"));//次数
            auditData.add("AUDIT_LEVEL", "0");//审核级别
            auditData.add("OPERATION_STATE", "0");//操作状态
            PPhandler.savePfrFeedbackAudit(conn, auditData);
        }
        return retValue;
    }
    /**
     * 
     * @Title: toDABPPFeedbackReturn
     * @Description: 报告退回
     * @author: xugy
     * @date: 2014-10-15下午6:06:31
     * @return
     */
    public String toDABPPFeedbackReturn(){
        String ids = getParameter("ids");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            
            String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG");
            DataList attType = new DataList();
            if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
                //安置后报告-一般
                String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
                String NUM = data.getString("NUM");
                attType = ppfb.attTypeNormal(conn, birthdayYear, NUM);
                
                //中文附件去掉照片
                DataList attTypeCN = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN = bm.getUploadParameter(attTypeCN);
                setAttribute("uploadParameterCN",xmlstrCN);
            }
            if("2".equals(ACCIDENT_FLAG)){
                //安置后报告-更换家庭
                attType = ppfb.attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                //安置后报告-死亡
                attType = ppfb.attTypeDead(conn);
            }
            String xmlstr = bm.getUploadParameter(attType);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("uploadParameter",xmlstr);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: saveDABPPFeedbackReturn
     * @Description: 退回保存
     * @author: xugy
     * @date: 2014-10-21上午10:51:16
     * @return
     */
    public String saveDABPPFeedbackReturn(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","RETURN_REASON");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("RECEIVE_STATE", "2");//接收状态
            FRdata.add("REPORT_STATE", "9");//报告状态
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告退回成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "报告退回失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "报告退回失败!");
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
        }
        return retValue;
    }
    
    
    /**
     * 
     * @Title: DABPPFeedbackReplaceList
     * @Description: 代录列表
     * @author: xugy
     * @date: 2014-10-14下午6:13:07
     * @return
     */
    public String DABPPFeedbackReplaceList(){
     // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NUM";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="ASC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","NAME_PINYIN","CHILD_NAME_EN","NUM","REG_USERNAME","REG_DATE_START","REG_DATE_END","REPORT_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABPPFeedbackReplaceList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: toDABPPFeedbackReplaceInto
     * @Description: 报告代录
     * @author: xugy
     * @date: 2014-10-14下午6:47:38
     * @return
     */
    public String toDABPPFeedbackReplaceInto(){
        String ids = getParameter("ids");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            //安置后报告-一般
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //中文附件去掉照片
            DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
            String xmlstrCN1 = bm.getUploadParameter(attTypeCN1);

            //安置后报告-更换家庭
            DataList attType2 = ppfb.attTypeChangeFamily(conn);
            String xmlstr2 = bm.getUploadParameter(attType2);
            
            //安置后报告-死亡
            DataList attType3 = ppfb.attTypeDead(conn);
            String xmlstr3 = bm.getUploadParameter(attType3);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            
            setAttribute("uploadParameterCN1",xmlstrCN1);
            setAttribute("uploadParameter1",xmlstr1);
            setAttribute("uploadParameter2",xmlstr2);
            setAttribute("uploadParameter3",xmlstr3);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: DABSaveAndSendTrans
     * @Description: 代录保存并送翻
     * @author: xugy
     * @date: 2014-10-14下午7:08:11
     * @return
     */
    public String DABSaveAndSendTrans(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "1");//代录标识
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//录入人ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//录入人姓名
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//录入日期
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//提交人ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//提交人姓名
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//上报日期
            FRdata.add("RECEIVE_USERID", SessionInfo.getCurUser().getPersonId());//接收人ID
            FRdata.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//接收人姓名
            FRdata.add("RECEIVE_DATE", DateUtility.getCurrentDate());//接收日期
            FRdata.add("RECEIVE_STATE", "1");//接收状态
            FRdata.add("REPORT_STATE", "2");//报告状态
            FRdata.add("IS_SF", "1");//送翻送审标识
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //将附件进行发布            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            DataList transferList = new DataList();
            Data transferData = new Data();
            transferData.add("TID_ID", "");//交接明细ID
            transferData.add("APP_ID", FRdata.getString("FB_REC_ID"));//业务记录ID
            transferData.add("TRANSFER_CODE", TransferCode.ARCHIVE_DAB_FYGS);//移交类型
            transferData.add("TRANSFER_STATE", "0");//移交状态
            transferList.add(transferData);
            FileCommonManager FC = new FileCommonManager();
            FC.transferDetailInit(conn, transferList);//插入一条移交信息
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告送翻成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "报告送翻失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "报告送翻失败!");
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
        }
        return retValue;
    }
    /**
     * 
     * @Title: DABSaveAndSendAudit
     * @Description: 代录保存并送审
     * @author: xugy
     * @date: 2014-10-14下午8:28:34
     * @return
     */
    public String DABSaveAndSendAudit(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "1");//代录标识
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//录入人ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//录入人姓名
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//录入日期
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//提交人ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//提交人姓名
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//上报日期
            FRdata.add("RECEIVE_USERID", SessionInfo.getCurUser().getPersonId());//接收人ID
            FRdata.add("RECEIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//接收人姓名
            FRdata.add("RECEIVE_DATE", DateUtility.getCurrentDate());//接收日期
            FRdata.add("RECEIVE_STATE", "1");//接收状态
            FRdata.add("ADUIT_STATE", "0");//审核状态
            FRdata.add("REPORT_STATE", "6");//报告状态
            FRdata.add("IS_SF", "2");//送翻送审标识
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //将附件进行发布            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            DataList dl = new DataList();
            dl.add(FRdata);
            createFeedbackAudit(conn, dl);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告送审成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "报告送审失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "报告送审失败!");
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
        }
        return retValue;
    }
    
    
    /**
     * 
     * @Title: DABPPFeedbackAuditList
     * @Description: 报告审核列表
     * @author: xugy
     * @date: 2014-10-14下午2:46:42
     * @return
     */
    public String DABPPFeedbackAuditList(){
     // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","NUM","RECEIVE_DATE_START","RECEIVE_DATE_END","AUDIT_USERNAME","AUDIT_DATE_START","AUDIT_DATE_END","ADUIT_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABPPFeedbackAuditList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: toDABPPFeedbackAudit
     * @Description: 报告审核
     * @author: xugy
     * @date: 2014-10-16上午10:21:51
     * @return
     */
    public String toDABPPFeedbackAudit(){
        String ids = getParameter("ids");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackAuditInfo(conn, ids);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
            }
            Data FADDdata = handler.getFeedbackAdditonalInfo(conn, data.getString("FB_REC_ID"));
            if(!FADDdata.isEmpty()){
                data.addData(FADDdata);
            }
            
            String SIGN_DATE = (String)data.getDate("SIGN_DATE");
            String d = "2013-01-01";
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date signDate = sdf.parse(SIGN_DATE);
            Date date = sdf.parse(d);
            boolean flag = signDate.before(date);
            String isCN = "";
            if(flag){
                isCN = "1";
            }else{
                isCN = "0";
            }
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            
            String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG");
            DataList attType = new DataList();
            if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
                //安置后报告-一般
                String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
                String NUM = data.getString("NUM");
                attType = ppfb.attTypeNormal(conn, birthdayYear, NUM);
                
                //中文附件去掉照片
                DataList attTypeCN = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN = bm.getUploadParameter(attTypeCN);
                setAttribute("uploadParameterCN",xmlstrCN);
            }
            if("2".equals(ACCIDENT_FLAG)){
                //安置后报告-更换家庭
                attType = ppfb.attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                //安置后报告-死亡
                attType = ppfb.attTypeDead(conn);
            }
            String xmlstr = bm.getUploadParameter(attType);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("isCN",isCN);
            setAttribute("uploadParameter",xmlstr);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: getAllFeedbackDetail
     * @Description: 历次报告
     * @author: xugy
     * @date: 2014-11-4下午4:36:18
     * @return
     */
    public String getAllFeedbackDetail(){
        String FEEDBACK_ID = getParameter("FEEDBACK_ID");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = handler.getFeedbackShowInfo(conn, FEEDBACK_ID);
            setAttribute("data",data);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: getFeedbackRecordDetail
     * @Description: 每次报告记录信息
     * @author: xugy
     * @date: 2014-11-4下午5:50:12
     * @return
     */
    public String getFeedbackRecordDetail(){
        String FEEDBACK_ID = getParameter("FEEDBACK_ID");
        String NUM = getParameter("NUM");
        String BIRTHDAY = getParameter("BIRTHDAY");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = handler.getFeedbackRecordInfo(conn, FEEDBACK_ID, NUM);
            if(Integer.parseInt(NUM) > 1){
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, Integer.parseInt(NUM));
                data.add("LAST_REPORT_DATE", REPORT_DATE);
            }
            String FB_REC_ID = data.getString("FB_REC_ID");
            String ACCIDENT_FLAG = data.getString("ACCIDENT_FLAG","");
            
            PPFeebbackAttAction PPFeebbackAttAction = new PPFeebbackAttAction();
            PPFeebbackAttHandler PPFeebbackAttHandler = new PPFeebbackAttHandler();
            
            //获取不同收养关系有无重大变故的附件小类
            DataList dl = new DataList();
            if("0".equals(ACCIDENT_FLAG) || "1".equals(ACCIDENT_FLAG) || "9".equals(ACCIDENT_FLAG)){
                String birthdayYear = BIRTHDAY.substring(0, 4);
                dl = PPFeebbackAttAction.attTypeNormal(conn, birthdayYear, NUM);
            }
            if("2".equals(ACCIDENT_FLAG)){
                dl = PPFeebbackAttAction.attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                dl = PPFeebbackAttAction.attTypeDead(conn);
            }
            
            //通过附件小类获取附件原文
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                DataList Attdl = PPFeebbackAttHandler.findPPFdeedbackAtt(conn, FB_REC_ID, CODE);
                dl.getData(i).add("ATTDL", Attdl);
            }
            //单独拿出照片，便于页面显示
            Data photoData = new Data();
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                if((AttConstants.AR_IMAGE).equals(CODE)){
                    photoData = dl.getData(i);
                    dl.remove(photoData);
                }
            }
            //通过附件小类获取附件中文
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                String F_FB_REC_ID = "F_" + FB_REC_ID;
                DataList AttCNdl = PPFeebbackAttHandler.findPPFdeedbackAtt(conn, F_FB_REC_ID, CODE);
                dl.getData(i).add("ATTCNDL", AttCNdl);
            }
            
            setAttribute("data",data);
            setAttribute("dl",dl);
            setAttribute("photoData",photoData);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: submitDABPPFeedbackAudit
     * @Description: 审核提交
     * @author: xugy
     * @date: 2014-10-21下午6:18:20
     * @return
     */
    public String submitDABPPFeedbackAudit(){
        Data FAdata = getRequestEntityData("FA_","FB_A_ID","AUDIT_OPTION","AUDIT_CONTENT_CN","AUDIT_CONTENT_EN","AUDIT_REMARKS");//审核数据
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","IS_PUBLIC","FEELING_CN","FUSION_CN","HEALTHY_CN","EVALUATION_CN","IS_SHOW","IS_SHOW_TRAN");//报告记录数据
        Data FIdata = getRequestEntityData("FI_","FEEDBACK_ID");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //审核数据保存
            FAdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPersonId());//审核人ID
            FAdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//审核人姓名
            FAdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//审核日期
            if("3".equals(FAdata.getString("AUDIT_OPTION"))){//补充文件
                FAdata.add("OPERATION_STATE", "1");//操作状态
                
                FRdata.add("ADUIT_STATE", "1");//审核状态
                FRdata.add("REPORT_STATE", "7");//报告状态
                
                Data FADDdata = getRequestEntityData("FADD_","FB_ADD_ID","IS_MODIFY","NOTICE_CONTENT","NUM");//补充文件数据
                FADDdata.add("FB_REC_ID", FRdata.getString("FB_REC_ID"));//安置后报告ID
                FADDdata.add("UPLOAD_IDS", "S_" + FRdata.getString("FB_REC_ID"));//补充附件
                FADDdata.add("UPLOAD_IDS_CN", "F_S_" + FRdata.getString("FB_REC_ID"));//补充附件_翻译
                FADDdata.add("SEND_USERID", SessionInfo.getCurUser().getPersonId());//通知人ID
                FADDdata.add("SEND_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//通知人姓名
                FADDdata.add("NOTICE_DATE", DateUtility.getCurrentDate());//通知日期
                FADDdata.add("AA_STATUS", "0");//补充状态
                PPhandler.savePfrFeedbackAdditonal(conn, FADDdata);
            }else{
                FAdata.add("OPERATION_STATE", "2");//操作状态
                FRdata.add("ADUIT_STATE", "2");//审核状态
                FRdata.add("REPORT_STATE", "8");//报告状态
            }
            PPhandler.savePfrFeedbackAudit(conn, FAdata);
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            DataList dl = handler.getFeedbackRecordStateInfo(conn, FIdata.getString("FEEDBACK_ID"));
            boolean finish = false;
            if("8".equals(dl.getData(0).getString("REPORT_STATE")) && "8".equals(dl.getData(1).getString("REPORT_STATE")) && "8".equals(dl.getData(2).getString("REPORT_STATE")) && "8".equals(dl.getData(3).getString("REPORT_STATE")) && "8".equals(dl.getData(4).getString("REPORT_STATE")) && "8".equals(dl.getData(5).getString("REPORT_STATE"))){
                finish = true;
            }
            
            if("2".equals(FAdata.getString("AUDIT_OPTION")) || finish){//结束跟踪
                String AF_ID = getParameter("AF_AF_ID");
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.DAB_AZH_SHJG_JSGZ);
                data.add("AF_ID", AF_ID);
                data.add("IS_FINISH", "1");//结束标示
                FileCommonManager AFhandler = new FileCommonManager();
                AFhandler.modifyFileInfo(conn, data);//修改收养人的匹配信息
                
                FIdata.add("IS_FINISH", "1");//结束标示
                PPhandler.savePfrFeedbackInfo(conn, FIdata);
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告审核提交成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "报告审核提交失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "报告审核提交失败!");
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
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: saveDABPPFeedbackAudit
     * @Description: 审核保存
     * @author: xugy
     * @date: 2014-11-30下午3:43:28
     * @return
     */
    public String saveDABPPFeedbackAudit(){
        Data FAdata = getRequestEntityData("FA_","FB_A_ID","AUDIT_OPTION","AUDIT_CONTENT_CN","AUDIT_CONTENT_EN","AUDIT_REMARKS");//审核数据
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","IS_PUBLIC","FEELING_CN","FUSION_CN","HEALTHY_CN","EVALUATION_CN","IS_SHOW","IS_SHOW_TRAN");//报告记录数据
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //审核数据保存
            FAdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPersonId());//审核人ID
            FAdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//审核人姓名
            FAdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//审核日期
            
            PPhandler.savePfrFeedbackAudit(conn, FAdata);
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告审核保存成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "报告审核保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "报告审核保存失败!");
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
        }
        return retValue;
    }
    
    
    /**
     * 
     * @Title: toDABPPFeedbackCatalog
     * @Description: 涉外收养档案案卷内目录（二）
     * @author: xugy
     * @date: 2014-11-4上午10:26:14
     * @return
     */
    public String toDABPPFeedbackCatalog(){
        String FEEDBACK_ID = getParameter("ids");//匹配收养人ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //查询收养人信息
            Data data = handler.getDABCatalogInfo(conn, FEEDBACK_ID);
            //将结果集写入页面接收变量
            setAttribute("data",data);
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: saveDABPPFeedbackCatalog
     * @Description: 涉外收养档案案卷内目录（二）保存
     * @author: xugy
     * @date: 2014-11-4上午10:53:10
     * @return
     */
    public String saveDABPPFeedbackCatalog(){
        Data FIdata = getRequestEntityData("FI_","FEEDBACK_ID","CATALOGUE2_FILE1_NUM","CATALOGUE2_FILE2_NUM","CATALOGUE2_FILE3_NUM","FILING_DATE1","FILING_USERNAME1","CATALOGUE2_FILE4_NUM","CATALOGUE2_FILE5_NUM","CATALOGUE2_FILE6_NUM","FILING_DATE2","FILING_USERNAME2","CATALOGUE2_FILE7_NUM","CATALOGUE2_FILE8_NUM","CATALOGUE2_FILE9_NUM","CATALOGUE2_FILE10_NUM","FILING_DATE3","FILING_USERNAME3","CATALOGUE2_FILE11_NUM","CATALOGUE2_FILE12_NUM","CATALOGUE2_FILE13_NUM","FILING_DATE4","FILING_USERNAME4","CATALOGUE2_FILE14_NUM","CATALOGUE2_FILE15_NUM","CATALOGUE2_FILE16_NUM","FILING_DATE5","FILING_USERNAME5","CATALOGUE2_FILE17_NUM","CATALOGUE2_FILE18_NUM","FILING_DATE6","FILING_USERNAME6");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            PPhandler.savePfrFeedbackInfo(conn, FIdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "目录（二）保存成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "目录（二）保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "目录（二）保存失败!");
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
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: DABPPFeedbackReminderList
     * @Description: 报告催交
     * @author: xugy
     * @date: 2014-10-23下午4:17:19
     * @return
     */
    public String DABPPFeedbackReminderList(){
     // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","SIGN_NO","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_CN","NAME","NUM","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","LIMIT_DATE_START","LIMIT_DATE_END","REMINDERS_DATE_START","REMINDERS_DATE_END");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABPPFeedbackReminderList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: DABPPFeedbackReminderDetail
     * @Description: 安置后反馈报告催缴
     * @author: xugy
     * @date: 2014-12-5上午11:23:40
     * @return
     */
    public String DABPPFeedbackReminderDetail(){
        String FB_REC_ID = getParameter("ids");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = handler.getFeedbackReminderInfo(conn, FB_REC_ID);
            
            String REMINDERS_DATE = data.getDate("REMINDERS_DATE");//催交日期
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(REMINDERS_DATE);
            SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy年MM月dd日");
            String REMINDERS_DATE_CN = sdfCN.format(date);
            data.add("REMINDERS_DATE_CN", REMINDERS_DATE_CN);
            
            SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
            String REMINDERS_DATE_EN = sdfEN.format(date);
            data.add("REMINDERS_DATE_EN", REMINDERS_DATE_EN);
            setAttribute("data",data);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: DABPPFeedbackSearchList
     * @Description: 档案部安置后报告反馈查询列表
     * @author: xugy
     * @date: 2014-10-10下午5:25:41
     * @return
     */
    public String DABPPFeedbackSearchList(){
     // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","ARCHIVE_NO","SIGN_NO","SIGN_DATE_START","SIGN_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","CHILD_NAME_EN","SEX","CHILD_TYPE","BIRTHDAY_START","BIRTHDAY_END");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABPPFeedbackSearchList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: DABPPFeedbackSearchDetail
     * @Description: 档案部查看安置后反馈报告
     * @author: xugy
     * @date: 2014-12-1下午4:21:30
     * @return
     */
    public String DABPPFeedbackSearchDetail(){
        String FEEDBACK_ID = getParameter("ids");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            DataList dataList = handler.getFeedbackInfo(conn, FEEDBACK_ID);
            Data data = new Data();
            if(dataList.size()>0){
                data=dataList.getData(0);
            }
            setAttribute("dataList",dataList);
            setAttribute("data",data);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } finally {
            //8 关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

}
