package com.dcfs.pfr.SYZZ;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.pfr.PPFeebbackAttAction;
import com.dcfs.pfr.DAB.DABPPFeedbackHandler;
import com.dcfs.pfr.feedback.PPFeedbackAction;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
/**
 * 
 * @Title: SYZZPPFeedbackAction.java
 * @Description: 收养组织安置后报告反馈
 * @Company: 21softech
 * @Created on 2014-10-9 下午5:13:37
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SYZZPPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(SYZZPPFeedbackAction.class);
    private Connection conn = null;
    private SYZZPPFeedbackHandler handler;
    private DABPPFeedbackHandler DABhandler;
    private PPFeedbackHandler PPhandler;
    private PPFeedbackAction PPAction;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public SYZZPPFeedbackAction() {
        this.handler=new SYZZPPFeedbackHandler();
        this.DABhandler=new DABPPFeedbackHandler();
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
     * @Title: SYZZPPFeedbackList
     * @Description: 收养组织安置后报告反馈列表
     * @author: xugy
     * @date: 2014-10-9下午5:25:56
     * @return
     */
    public String SYZZPPFeedbackList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","NUM","REPORT_DATE_START","REPORT_DATE_END","REPORT_STATE","REMINDERS_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findSYZZPPFeedbackList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toSYZZPPFeedbackAdd
     * @Description: 收养组织安置后报告反馈录入
     * @author: xugy
     * @date: 2014-10-10下午2:04:31
     * @return
     */
    public String toSYZZPPFeedbackInto(){
        String ids = getParameter("ids");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String SIGN_DATE = (String)data.getDate("SIGN_DATE");
            Date signDate = sdf.parse(SIGN_DATE);
            String d = "2013-01-01";
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
            //安置后报告-一般
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //中文附件去掉照片
            if(flag){
                DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN1 = bm.getUploadParameter(attTypeCN1);
                setAttribute("uploadParameterCN1",xmlstrCN1);
            }
            
            
            //安置后报告-更换家庭
            DataList attType2 = ppfb.attTypeChangeFamily(conn);
            String xmlstr2 = bm.getUploadParameter(attType2);
            
            //安置后报告-死亡
            DataList attType3 = ppfb.attTypeDead(conn);
            String xmlstr3 = bm.getUploadParameter(attType3);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("isCN",isCN);
            
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
            
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (Exception e) {
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
     * @Title: saveSYZZPPFeedbackInto
     * @Description: 录入保存
     * @author: xugy
     * @date: 2014-10-11上午10:48:37
     * @return
     */
    public String saveSYZZPPFeedbackInto(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "0");//代录标识
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//录入人ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//录入人姓名
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//录入日期
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //将附件进行发布            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告反馈保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告反馈保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告反馈保存失败!");
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
     * @Title: submitSYZZPPFeedbackInto
     * @Description: 录入提交
     * @author: xugy
     * @date: 2014-10-11上午10:59:19
     * @return
     */
    public String submitSYZZPPFeedbackInto(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("IS_DAILU", "0");//代录标识
            FRdata.add("REG_USERID", SessionInfo.getCurUser().getPersonId());//录入人ID
            FRdata.add("REG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//录入人姓名
            FRdata.add("REG_DATE", DateUtility.getCurrentDate());//录入日期
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//提交人ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//提交人姓名
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//上报日期
            FRdata.add("RECEIVE_STATE", "0");//接收状态
            FRdata.add("REPORT_STATE", "1");//报告状态
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //将附件进行发布            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告反馈成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告反馈提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告反馈提交失败!");
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
     * @Title: listSubmitSYZZPPFeedback
     * @Description: 列表提交
     * @author: xugy
     * @date: 2014-10-15下午3:22:22
     * @return
     */
    public String listSubmitSYZZPPFeedback(){
        String ids = getParameter("ids");
        Data FRdata = new Data();
        FRdata.add("FB_REC_ID", ids);
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("SUBMIT_USREID", SessionInfo.getCurUser().getPersonId());//提交人ID
            FRdata.add("SUBMIT_USRENAME", SessionInfo.getCurUser().getPerson().getCName());//提交人姓名
            FRdata.add("REPORT_DATE", DateUtility.getCurrentDate());//上报日期
            FRdata.add("RECEIVE_STATE", "0");//接收状态
            FRdata.add("REPORT_STATE", "1");//报告状态
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告反馈提交成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告反馈提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告反馈提交失败!");
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
     * @Title: PPFeedbackHomePage
     * @Description: 安置后报告首页
     * @author: xugy
     * @date: 2014-11-5下午1:36:34
     * @return
     */
    public String PPFeedbackHomePage(){
        String FB_REC_ID = getParameter("FB_REC_ID");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackHomePageInfo(conn, FB_REC_ID);
            
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
     * @Title: SYZZPPFeedbackDetail
     * @Description: 反馈报告查看
     * @author: xugy
     * @date: 2014-12-4下午6:29:51
     * @return
     */
    public String SYZZPPFeedbackDetail(){
        String ids = getParameter("ids");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackInfo(conn, ids);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
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
                String IS_SHOW_TRAN = data.getString("IS_SHOW_TRAN", "");
                if("1".equals(IS_SHOW_TRAN)){
                    isCN = "1";
                }
                if("0".equals(IS_SHOW_TRAN)){
                    isCN = "0";
                }
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
            
            String FB_ADD_ID = data.getString("FB_ADD_ID");
            if("".equals(data.getString("UPLOAD_IDS",""))){
                data.put("UPLOAD_IDS", FB_ADD_ID);
            }
            if("".equals(data.getString("UPLOAD_IDS_CN",""))){
                data.put("UPLOAD_IDS_CN", "F_" + FB_ADD_ID);
            }
            
            
            
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
     * @Title: SYZZPPFeedbackAdditonalList
     * @Description: 报告补充列表
     * @author: xugy
     * @date: 2014-10-21下午8:38:30
     * @return
     */
    public String SYZZPPFeedbackAdditonalList(){
     // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="ASC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","FILE_NO","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","NUM","NOTICE_DATE_START","NOTICE_DATE_END","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findSYZZPPFeedbackAdditonalList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toSYZZPPFeedbackAdditonal
     * @Description: 报告补充
     * @author: xugy
     * @date: 2014-10-22下午3:21:53
     * @return
     */
    public String toSYZZPPFeedbackAdditonal(){
        String ids = getParameter("ids");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackAdditonalInfo(conn, ids);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
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
                String IS_SHOW_TRAN = data.getString("IS_SHOW_TRAN", "");
                if("1".equals(IS_SHOW_TRAN)){
                    isCN = "1";
                }
                if("0".equals(IS_SHOW_TRAN)){
                    isCN = "0";
                }
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
            
            String FB_ADD_ID = data.getString("FB_ADD_ID");
            if("".equals(data.getString("UPLOAD_IDS",""))){
                data.put("UPLOAD_IDS", FB_ADD_ID);
            }
            if("".equals(data.getString("UPLOAD_IDS_CN",""))){
                data.put("UPLOAD_IDS_CN", "F_" + FB_ADD_ID);
            }
            
            
            
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
     * @Title: saveSYZZPPFeedbackAdditonal
     * @Description: 补充保存
     * @author: xugy
     * @date: 2014-10-22下午6:08:53
     * @return
     */
    public String saveSYZZPPFeedbackAdditonal(){
        Data FADDdata = getRequestEntityData("FADD_","FB_ADD_ID","UPLOAD_IDS","UPLOAD_IDS_CN","ADD_CONTENT_EN");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FADDdata.add("AA_STATUS", "1");//补充状态
            AttHelper.publishAttsOfPackageId(FADDdata.getString("UPLOAD_IDS"), "AR");
            AttHelper.publishAttsOfPackageId(FADDdata.getString("UPLOAD_IDS_CN"), "AR");
            PPhandler.savePfrFeedbackAdditonal(conn, FADDdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告补充保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告补充保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告补充保存失败!");
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
     * @Title: submitSYZZPPFeedbackAdditonal
     * @Description: 报告提交
     * @author: xugy
     * @date: 2014-10-22下午6:09:23
     * @return
     */
    public String submitSYZZPPFeedbackAdditonal(){
        Data FADDdata = getRequestEntityData("FADD_","FB_ADD_ID","ADD_CONTENT_EN");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FADDdata.add("FEEDBACK_ORGID", SessionInfo.getCurUser().getCurOrgan().getId());//反馈人组织ID
            FADDdata.add("FEEDBACK_USERID", SessionInfo.getCurUser().getPersonId());//反馈人ID
            FADDdata.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//反馈人姓名
            FADDdata.add("FEEDBACK_DATE", DateUtility.getCurrentDate());//反馈日期
            FADDdata.add("AA_STATUS", "2");//补充状态
            PPhandler.savePfrFeedbackAdditonal(conn, FADDdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告补充提交成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告补充提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告补充提交失败!");
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
     * @Title: toSYZZPPFeedbackAdditonalMod
     * @Description: 报告补充修改
     * @author: xugy
     * @date: 2014-10-24上午11:30:45
     * @return
     */
    public String toSYZZPPFeedbackAdditonalMod(){
        String FB_REC_ID = getParameter("FB_REC_ID");
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackInfo(conn, FB_REC_ID);
            int num = data.getInt("NUM");
            if(num > 1){
                String FEEDBACK_ID = data.getString("FEEDBACK_ID");
                String REPORT_DATE = PPAction.getLastReportDate(conn, FEEDBACK_ID, num);
                data.add("LAST_REPORT_DATE", REPORT_DATE);
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
            //安置后报告-一般
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //中文附件去掉照片
            if(flag){
                DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);;
                String xmlstrCN1 = bm.getUploadParameter(attTypeCN1);
                setAttribute("uploadParameterCN1",xmlstrCN1);
            }
            
            
            //安置后报告-更换家庭
            DataList attType2 = ppfb.attTypeChangeFamily(conn);
            String xmlstr2 = bm.getUploadParameter(attType2);
            
            //安置后报告-死亡
            DataList attType3 = ppfb.attTypeDead(conn);
            String xmlstr3 = bm.getUploadParameter(attType3);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("isCN",isCN);
            
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
     * @Title: saveSYZZPPFeedbackAdditonalMod
     * @Description: 保存报告修改
     * @author: xugy
     * @date: 2014-10-24下午3:37:54
     * @return
     */
    public void saveSYZZPPFeedbackAdditonalMod(){
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC","FEELING_CN","FUSION_CN","HEALTHY_CN","EVALUATION_CN");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //将附件进行发布            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告补充保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告补充保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告补充保存失败!");
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
    }
    /**
     * 
     * @Title: SYZZPPFeedbackReminderList
     * @Description: 报告催交列表
     * @author: xugy
     * @date: 2014-10-23下午3:01:58
     * @return
     */
    public String SYZZPPFeedbackReminderList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","SIGN_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_NAME_EN","NAME_PINYIN","NUM","LIMIT_DATE_START","LIMIT_DATE_END","REMINDERS_DATE_START","REMINDERS_DATE_END");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findSYZZPPFeedbackReminderList(conn,data,pageSize,page,compositor,ordertype);
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
}