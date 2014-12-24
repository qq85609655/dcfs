package com.dcfs.ncm.audit;

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
import com.dcfs.far.adoptionRegis.AdoptionRegisHandler;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.transferManager.TransferManagerHandler;
import com.dcfs.ncm.MatchAction;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.AZBadvice.AZBAdviceHandler;
import com.dcfs.rfm.insteadRecord.InsteadRecordHandler;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;

/**
 * 
 * @Title: MatchAuditAction.java
 * @Description: 匹配审核
 * @Company: 21softech
 * @Created on 2014-9-6 下午3:38:05
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MatchAuditAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(MatchAuditAction.class);
    private Connection conn = null;
    private MatchAuditHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public MatchAuditAction() {
        this.handler=new MatchAuditHandler();
        this.Mhandler=new MatchHandler();
        this.AFhandler=new FileCommonManager();
        this.CIhandler=new ChildManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        return null;
    }
    
    /**
     * 
     * @Title: matchAuditList
     * @Description: 审核列表
     * @author: xugy
     * @date: 2014-9-6下午4:57:02
     * @return
     */
    public String matchAuditList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_TYPE","MATCH_NUM","CHILD_TYPE","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","OPERATION_STATE","MATCH_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findMatchAuditList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toMatchAuditAdd
     * @Description: 审核页面
     * @author: xugy
     * @date: 2014-9-9下午3:09:51
     * @return
     */
    public String toMatchAuditAdd(){
        String ids = getParameter("ids");//匹配审核ID，匹配信息ID，收养人文件ID，儿童材料ID
        String MAU_ID = ids.split(",")[0];//匹配审核ID
        //String MI_ID = ids.split(",")[1];//匹配信息ID
        String AF_ID = ids.split(",")[2];//收养人文件ID
        String CI_ID = ids.split(",")[3];//儿童材料ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            //审核信息
            String AUDIT_LEVEL = "0";//经办人审核
            Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);//经办人审核
            data.addData(MAUdata);
            data.add("AUDIT_DATE", DateUtility.getCurrentDate());//审核日期
            data.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//审核人姓名
            //收养人历次匹配信息
            DataList allAFMatchdl = handler.getAllAFMatchInfo(conn, AF_ID);
            //儿童历次匹配信息
            DataList allCIMatchdl = handler.getAllCIMatchInfo(conn, CI_ID);
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("allAFMatchdl",allAFMatchdl);
            setAttribute("allCIMatchdl",allCIMatchdl);
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
     * @Title: getTendingAndOpinion
     * @Description: 特需的抚育计划和组织意见
     * @author: xugy
     * @date: 2014-10-31下午1:37:11
     * @return
     */
    public String getTendingAndOpinion(){
        String MAIN_CI_ID = getParameter("MAIN_CI_ID");//儿童主ID
        String CI_ID = getParameter("CI_ID");//儿童ID
        String FLAG = getParameter("FLAG");//儿童ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            
            Data data = handler.getTendingAndOpinion(conn, MAIN_CI_ID, CI_ID);
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("FLAG",FLAG);
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
     * @Title: auditSubmit
     * @Description: 审核上报
     * @author: xugy
     * @date: 2014-9-9下午3:15:13
     * @return
     */
    public String auditSubmit(){
        //审核结果，审核意见，备注
        Data MAUdata = getRequestEntityData("MAU_","MAU_ID","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");
        String MI_ID = getParameter("MI_MI_ID");//匹配信息ID
        String CI_ID = getParameter("CI_CI_ID");//儿童材料ID
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //保存审核信息
            MAUdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//审核日期
            MAUdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//审核人ID
            MAUdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//审核人姓名
            MAUdata.add("OPERATION_STATE", "2");//操作状态：已处理
            Mhandler.saveNcmMatchAudit(conn, MAUdata);
            //上报审核，添加部门主任审核信息
            Data CreateMAUdata = new Data();
            CreateMAUdata.add("MAU_ID", "");//匹配审核ID
            CreateMAUdata.add("MI_ID", MI_ID);//匹配信息ID
            CreateMAUdata.add("AUDIT_LEVEL", "1");//审核级别：部门主任审核
            CreateMAUdata.add("OPERATION_STATE", "0");//操作状态：待处理
            Mhandler.saveNcmMatchAudit(conn, CreateMAUdata);
            //修改匹配信息表信息
            Data MIdata = new Data();
            MIdata.add("MI_ID", MI_ID);//匹配信息ID
            MIdata.add("MATCH_STATE", "1");//匹配状态：部门主任待审核
            Mhandler.saveNcmMatchInfo(conn, MIdata);
            
            Data CIdata = new Data();
            CIdata.add("CI_ID", CI_ID);
            //材料全局状态和位置
            ChildCommonManager childCommonManager = new ChildCommonManager();
            CIdata = childCommonManager.matchAuditBMZR(CIdata, SessionInfo.getCurUser().getCurOrgan());
            CIhandler.save(conn, CIdata);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据上报成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "数据上报失败!");//保存失败 2
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
        }
        return retValue;
    }
    /**
     * 
     * @Title: auditSave
     * @Description: 审核保存
     * @author: xugy
     * @date: 2014-9-9下午3:53:26
     * @return
     */
    public String auditSave(){
        //审核结果，审核意见，备注
        Data MAUdata = getRequestEntityData("MAU_","MAU_ID","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");
        //String MI_ID = getParameter("MI_MI_ID");//匹配信息ID
        String AF_ID = getParameter("AF_AF_ID");//收养人文件ID
        //String CI_ID = getParameter("CI_CI_ID");//儿童材料ID
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //保存审核信息
            MAUdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//审核日期
            MAUdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//审核人ID
            MAUdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//审核人姓名
            MAUdata.add("OPERATION_STATE", "1");//操作状态：处理中
            Mhandler.saveNcmMatchAudit(conn, MAUdata);
            
            //文件全局状态和位置
            FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
            Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_SH_SB);
            data.add("AF_ID", AF_ID);
            AFhandler.modifyFileInfo(conn, data);//修改文件信息
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "审核保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "审核保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "审核保存失败!");
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
     * @Title: matchAuditDetail
     * @Description: 
     * @author: xugy
     * @date: 2014-12-15下午5:48:49
     * @return
     */
    public String matchAuditDetail(){
        String ids = getParameter("ids");//匹配审核ID，匹配信息ID，收养人文件ID，儿童材料ID
        String MAU_ID = ids.split(",")[0];//匹配审核ID
        String MI_ID = ids.split(",")[1];//匹配信息ID
        //String AF_ID = ids.split(",")[2];//收养人文件ID
        //String CI_ID = ids.split(",")[3];//儿童材料ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //审核信息
            String AUDIT_LEVEL = "0";//经办人审核
            //Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);//经办人审核
            Data MAUdata=handler.getMatchAuditOnly(conn,AUDIT_LEVEL,MAU_ID);
            data.addData(MAUdata);
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
     * @Title: matchAuditAgainList
     * @Description: 复核列表
     * @author: xugy
     * @date: 2014-9-9下午7:16:47
     * @return
     */
    public String matchAuditAgainList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_TYPE","MATCH_NUM","CHILD_TYPE","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","OPERATION_STATE","MATCH_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findMatchAuditAgainList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toMatchAuditAgainAdd
     * @Description: 
     * @author: xugy
     * @date: 2014-9-9下午7:36:59
     * @return
     */
    public String toMatchAuditAgainAdd(){
        String ids = getParameter("ids");//匹配审核ID，匹配信息ID，收养人文件ID，儿童材料ID
        String MAU_ID = ids.split(",")[0];//匹配审核ID
        String MI_ID = ids.split(",")[1];//匹配信息ID
        String AF_ID = ids.split(",")[2];//收养人文件ID
        String CI_ID = ids.split(",")[3];//儿童材料ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            //复核信息
            String AUDIT_LEVEL = "1";//部门主任审核
            Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);
            data.addData(MAUdata);
            //经办人审核信息
            Data MAUdata1=handler.getMatchAuditForJBR(conn,MI_ID);
            data.addData(MAUdata1);
            data.add("AUDIT_DATE", DateUtility.getCurrentDate());
            data.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            //收养人历次匹配信息
            DataList allAFMatchdl = handler.getAllAFMatchInfo(conn, AF_ID);
            //儿童历次匹配信息
            DataList allCIMatchdl = handler.getAllCIMatchInfo(conn, CI_ID);
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("allAFMatchdl",allAFMatchdl);
            setAttribute("allCIMatchdl",allCIMatchdl);
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
                        log.logError("NormalMatchAction的showCIs.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: auditAgainSave
     * @Description: 复核信息保存
     * @author: xugy
     * @date: 2014-9-10上午10:45:10
     * @return
     */
    public String auditAgainSave(){
        //审核结果，审核意见，备注
        Data MAUdata = getRequestEntityData("MAU_","MAU_ID","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");
        String MI_ID = getParameter("MI_MI_ID");//匹配信息ID
        String AF_ID = getParameter("AF_AF_ID");//收养人文件ID
        String CI_ID = getParameter("CI_CI_ID");//儿童材料ID
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //保存复核信息
            MAUdata.add("AUDIT_DATE", DateUtility.getCurrentDate());//审核日期
            MAUdata.add("AUDIT_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//审核人ID
            MAUdata.add("AUDIT_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//审核人姓名
            MAUdata.add("OPERATION_STATE", "2");//操作状态：已处理
            Mhandler.saveNcmMatchAudit(conn, MAUdata);
            
            Data AFdata = new Data();//文件数据
            Data MIdata = new Data();//匹配数据
            
            //修改匹配信息表信息
            String AUDIT_OPTION = MAUdata.getString("AUDIT_OPTION");//审核结果
            if("0".equals(AUDIT_OPTION)){//通过
                MIdata.add("MI_ID", MI_ID);//匹配信息ID
                MIdata.add("MATCH_PASSDATE", DateUtility.getCurrentDate());//匹配通过日期
                MIdata.add("ADVICE_SIGN_DATE", DateUtility.getCurrentDate());//征求意见_最后落款日期
                MIdata.add("ADVICE_STATE", "1");//征求意见_状态
                MIdata.add("ADVICE_PRINT_NUM", "0");//征求意见_打印次数
                MIdata.add("MATCH_STATE", "3");//匹配状态：3=审核通过；4=审核不通过
                Mhandler.saveNcmMatchInfo(conn, MIdata);
                
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_FHTG_SUBMIT);
                AFdata.addData(data);
                AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                
                MatchAction matchAction = new MatchAction();
                matchAction.letterOfSeekingConfirmation(conn, MI_ID, "1");//征求意见书
            }else if("1".equals(AUDIT_OPTION)){//不通过
                MIdata.add("AF_ID", AF_ID);
                MIdata.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//解除匹配日期
                MIdata.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//解除匹配人ID
                MIdata.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//解除匹配人姓名
                MIdata.add("REVOKE_MATCH_TYPE", "3");//解除匹配类型：重新匹配
                MIdata.add("REVOKE_MATCH_REASON", "匹配审核不通过");//解除匹配原因
                MIdata.add("MATCH_STATE", "4");//匹配状态：3=审核通过；4=审核不通过
                Data AFdataInfo = Mhandler.getAFInfoOfAfId(conn, AF_ID);
                String RI_ID = AFdataInfo.getString("RI_ID", "");
                if("".equals(RI_ID)){//没有预批信息即通过手动匹配,如儿童多人则一定是同胞兄弟
                    Mhandler.storeNcmMatchInfoOne(conn, MIdata);
                    /****儿童与收养家庭解除匹配关系，修改文件和材料相关状态Begin****/
                    String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//文件匹配儿童的ID（多个为同胞）
                    if(!"".equals(AF_CI_ID)){
                        String[] array = AF_CI_ID.split(",");
                        for(int i=0;i<array.length;i++){
                            //修改材料匹配状态
                            Data CIdata = new Data();//材料数据
                            CIdata.add("CI_ID", array[i]);//材料ID
                            CIdata.add("MATCH_STATE", "0");//材料匹配状态
                            //材料全局状态和位置
                            ChildCommonManager childCommonManager = new ChildCommonManager();
                            CIdata = childCommonManager.matchAuditNotThrough(CIdata, SessionInfo.getCurUser().getCurOrgan());
                            CIhandler.save(conn, CIdata);
                        }
                    }
                    //修改文件匹配状态
                    AFdata.add("AF_ID", AF_ID);//文件ID
                    AFdata.add("MATCH_STATE", "0");//文件匹配状态
                    AFdata.add("CI_ID", "");//文件儿童材料ID置空
                    String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//文件类型
                    if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                        AFdata.add("FILE_TYPE", "10");
                    }
                    //文件全局状态和位置
                    FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                    Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_FHBTG_SUBMIT);
                    AFdata.addData(data);
                    AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                    /****儿童与收养家庭解除匹配关系，修改文件和材料相关状态End****/
                }else{//存在预批信息,
                    Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
                    String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID","");//儿童的主儿童ID
                    DataList CIdl = handler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
                    if(CIdl.size()>0){
                        for(int i=0;i<CIdl.size();i++){
                            String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                            MIdata.add("CI_ID", everyCiId);
                            Mhandler.storeNcmMatchInfoTwo(conn, MIdata);//通过文件ID材料ID修改匹配信息
                            
                            //修改材料匹配状态
                            Data CIdata = new Data();//材料数据
                            CIdata.add("CI_ID", everyCiId);//材料ID
                            CIdata.add("MATCH_STATE", "0");//材料匹配状态
                            //材料全局状态和位置
                            ChildCommonManager childCommonManager = new ChildCommonManager();
                            CIdata = childCommonManager.matchAuditNotThrough(CIdata, SessionInfo.getCurUser().getCurOrgan());
                            CIhandler.save(conn, CIdata);
                        }
                    }
                    PublishCommonManager publishCommonManager = new PublishCommonManager();
                    publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                    
                    String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//文件类型
                    if(!"23".equals(FILE_TYPE)){//文件类型不为“特双”的，有一个预批
                        //修改文件匹配状态
                        AFdata.add("AF_ID", AF_ID);//文件ID
                        AFdata.add("MATCH_STATE", "0");//文件匹配状态
                        if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                            AFdata.add("FILE_TYPE", "10");
                        }
                        //文件全局状态和位置
                        FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                        Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_FHBTG_SUBMIT);
                        AFdata.addData(data);
                        AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                    }
                }
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据提交成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error3";
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
     * @Title: matchAuditAgainDetail
     * @Description: 
     * @author: xugy
     * @date: 2014-12-15下午6:35:06
     * @return
     */
    public String matchAuditAgainDetail(){
        String ids = getParameter("ids");//匹配审核ID，匹配信息ID，收养人文件ID，儿童材料ID
        String MAU_ID = ids.split(",")[0];//匹配审核ID
        String MI_ID = ids.split(",")[1];//匹配信息ID
        //String AF_ID = ids.split(",")[2];//收养人文件ID
        //String CI_ID = ids.split(",")[3];//儿童材料ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //审核信息
            String AUDIT_LEVEL = "1";//部门主任审核
            //Data MAUdata=handler.getMatchAudit(conn,AUDIT_LEVEL,MAU_ID);//部门主任审核
            Data MAUdata=handler.getMatchAuditOnly(conn,AUDIT_LEVEL,MAU_ID);//部门主任审核
            data.addData(MAUdata);
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
     * @Title: toRelieveMatch
     * @Description: 解除匹配
     * @author: xugy
     * @date: 2014-9-28下午6:02:58
     * @return
     */
    public String toRelieveMatch(){
        String ids = getParameter("ids");//匹配审核ID，匹配信息ID，收养人文件ID，儿童材料ID
        String MI_ID = ids.split(",")[1];//匹配信息ID
        String AF_ID = ids.split(",")[2];//收养人文件ID
        String CI_ID = ids.split(",")[3];//儿童材料ID
        String FILE_TYPE = ids.split(",")[6];//文件类型
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data.add("MI_ID", MI_ID);
            data.add("AF_ID", AF_ID);
            data.add("CI_ID", CI_ID);
            data.add("FILE_TYPE", FILE_TYPE);
            data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());
            data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
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
                        log.logError("NormalMatchAction的showCIs.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: relieveMatchSave
     * @Description: 解除匹配。任何非状态或结果引起的解除匹配，状态都置为无效
     * @author: xugy
     * @date: 2014-9-29下午2:54:14
     * @return
     */
    public String relieveMatchSave(){
        Data MIdata = getRequestEntityData("MI_","MI_ID","REVOKE_MATCH_TYPE","REVOKE_MATCH_REASON");//匹配信息
        String MI_ID = MIdata.getString("MI_ID");
        String AF_ID = getParameter("AF_AF_ID");//文件ID
        String CI_ID = getParameter("CI_CI_ID");//文材料ID
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //解除匹配信息
            MIdata.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//解除匹配日期
            MIdata.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//解除匹配人ID
            MIdata.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//解除匹配人姓名
            //各个步骤状态
            Data MSdata = handler.getAllMatchState(conn, MIdata.getString("MI_ID"));
            //String MATCH_STATE = data.getString("MATCH_STATE", "");//匹配状态
            String ADVICE_STATE = MSdata.getString("ADVICE_STATE", "");//征求意见_状态
            String SIGN_STATE = MSdata.getString("SIGN_STATE", "");//签批信息_签批状态
            String NOTICE_STATE = MSdata.getString("NOTICE_STATE", "");//通知书_寄发状态
            String ADREG_STATE = MSdata.getString("ADREG_STATE", "");//收养登记_登记状态
            
            /********* 解除匹配改变状态Begin ***********/
            if(!"".equals(ADREG_STATE)){//收养登记状态
                MIdata.add("MATCH_STATE", "9");//匹配状态：无效
                MIdata.add("ADVICE_STATE", "9");//征求意见状态：无效
                MIdata.add("SIGN_STATE", "9");//签批状态：无效
                MIdata.add("NOTICE_STATE", "9");//通知书寄发状态：无效
                //儿童材料从档案部移交到安置部
                /*DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//交接明细ID
                transferData.add("APP_ID", CIdata.getString("CI_ID"));//业务记录ID
                transferData.add("TRANSFER_CODE", TransferCode.RFM_CHILDINFO_DAB_AZB);//移交类型：档案部-->安置部
                transferData.add("TRANSFER_STATE", "0");//移交状态
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);*///插入一条移交信息
                if("0".equals(ADREG_STATE) || "1".equals(ADREG_STATE)){//未登记或已登记
                    MIdata.add("ADREG_STATE", "9");//登记状态：无效
                }
            }else{
                if(!"".equals(NOTICE_STATE)){//通知书寄发状态
                    MIdata.add("MATCH_STATE", "9");//匹配状态：无效
                    MIdata.add("ADVICE_STATE", "9");//征求意见状态：无效
                    MIdata.add("SIGN_STATE", "9");//签批状态：无效
                    MIdata.add("NOTICE_STATE", "9");//通知书寄发状态：无效
                }else{
                    if(!"".equals(SIGN_STATE)){//签批信息_签批状态
                        MIdata.add("MATCH_STATE", "9");//匹配状态：无效
                        MIdata.add("ADVICE_STATE", "9");//征求意见状态：无效
                        MIdata.add("SIGN_STATE", "9");//签批状态：无效
                    }else{
                        if(!"".equals(ADVICE_STATE)){//征求意见_状态
                            MIdata.add("MATCH_STATE", "9");//匹配状态：无效
                            MIdata.add("ADVICE_STATE", "9");//征求意见状态：无效
                        }
                    }
                }
            }
            /********** 解除匹配改变状态End **********/
            String REVOKE_MATCH_TYPE = MIdata.getString("REVOKE_MATCH_TYPE","");//解除匹配类型
            Data AFdataInfo = Mhandler.getAFInfoOfAfId(conn, AF_ID);
            String RI_ID = AFdataInfo.getString("RI_ID", "");//
            String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//文件类型
            if("".equals(RI_ID)){//没有预批
                MIdata.add("AF_ID", AF_ID);
                MIdata.remove("MI_ID");
                Mhandler.storeNcmMatchInfoOne(conn, MIdata);
                /****儿童与收养家庭解除匹配关系，修改文件和材料相关状态Begin****/
                String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//文件匹配儿童的ID（多个为同胞）
                if(!"".equals(AF_CI_ID)){
                    String[] array = AF_CI_ID.split(",");
                    for(int i=0;i<array.length;i++){
                        //修改材料匹配状态
                        Data CIdata = new Data();//材料数据
                        CIdata.add("CI_ID", array[i]);//材料ID
                        CIdata.add("MATCH_STATE", "0");//材料匹配状态
                        CIhandler.save(conn, CIdata);
                    }
                }
                //修改文件匹配状态
                Data AFdata = new Data();
                AFdata.add("AF_ID", AF_ID);//文件ID
                AFdata.add("MATCH_STATE", "0");//文件匹配状态
                AFdata.add("CI_ID", "");//文件儿童材料ID置空
                if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                    AFdata.add("FILE_TYPE", "10");
                }
                /****儿童与收养家庭解除匹配关系，修改文件和材料相关状态End****/
                if("1".equals(REVOKE_MATCH_TYPE)){//退文
                    String RETURN_STATE = AFdataInfo.getString("RETURN_STATE", "");//退文状态
                    String AF_RETURN_REASON = getParameter("Ins_AF_RETURN_REASON");//退文原因
                    if("".equals(RETURN_STATE)){//没有退文
                        AFdata.add("RETURN_STATE", "0");//文件退文状态：待确认
                        AFdata.add("RETURN_REASON", AF_RETURN_REASON);//文件退文原因
                        //获取文件需要存入退文记录表中信息
                        AZBAdviceHandler AZBAH = new AZBAdviceHandler();
                        Data RFMdata = AZBAH.getRFMAFInfo(conn, AFdata.getString("AF_ID"));
                        RFMdata.add("AR_ID", "");//退文记录ID
                        RFMdata.add("RETURN_REASON", AF_RETURN_REASON);//退文原因
                        RFMdata.add("APPLE_DATE", DateUtility.getCurrentDate());//申请日期
                        RFMdata.add("APPLE_PERSON_ID", SessionInfo.getCurUser().getPerson().getPersonId());//申请人ID
                        RFMdata.add("APPLE_PERSON_NAME", SessionInfo.getCurUser().getPerson().getCName());//申请人姓名
                        RFMdata.add("APPLE_TYPE", "3");//退文类型：征求意见退文
                        RFMdata.add("RETURN_STATE", "0");//退文状态：待确认
                        InsteadRecordHandler IRH = new InsteadRecordHandler();
                        IRH.ReturnFileSave(conn, RFMdata, AFdata);
                    }else{
                        AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                    }
                }else{
                    AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                }
            }else{//存在预批
                MIdata.remove("MI_ID");
                Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
                String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID");//儿童的主儿童ID
                DataList CIdl = handler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
                if(CIdl.size()>0){
                    for(int i=0;i<CIdl.size();i++){
                        String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                        MIdata.add("CI_ID", everyCiId);
                        Mhandler.storeNcmMatchInfoTwo(conn, MIdata);//通过文件ID材料ID修改匹配信息
                        
                        //修改材料匹配状态
                        Data CIdata = new Data();//材料数据
                        CIdata.add("CI_ID", everyCiId);//材料ID
                        CIdata.add("MATCH_STATE", "0");//材料匹配状态
                        CIhandler.save(conn, CIdata);
                    }
                }
                PublishCommonManager publishCommonManager = new PublishCommonManager();
                publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                if(!"23".equals(FILE_TYPE)){//文件类型不为“特双”的，有一个预批
                    Data AFdata = new Data();
                    //修改文件匹配状态
                    AFdata.add("AF_ID", AF_ID);//文件ID
                    AFdata.add("MATCH_STATE", "0");//文件匹配状态
                    if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                        AFdata.add("FILE_TYPE", "10");
                    }
                    AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                    if("1".equals(REVOKE_MATCH_TYPE)){//退文
                        String RETURN_STATE = AFdataInfo.getString("RETURN_STATE", "");//退文状态
                        String AF_RETURN_REASON = getParameter("Ins_AF_RETURN_REASON");//退文原因
                        if("".equals(RETURN_STATE)){//没有退文
                            AFdata.add("RETURN_STATE", "0");//文件退文状态：待确认
                            AFdata.add("RETURN_REASON", AF_RETURN_REASON);//文件退文原因
                            //获取文件需要存入退文记录表中信息
                            AZBAdviceHandler AZBAH = new AZBAdviceHandler();
                            Data RFMdata = AZBAH.getRFMAFInfo(conn, AFdata.getString("AF_ID"));
                            RFMdata.add("AR_ID", "");//退文记录ID
                            RFMdata.add("RETURN_REASON", AF_RETURN_REASON);//退文原因
                            RFMdata.add("APPLE_DATE", DateUtility.getCurrentDate());//申请日期
                            RFMdata.add("APPLE_PERSON_ID", SessionInfo.getCurUser().getPerson().getPersonId());//申请人ID
                            RFMdata.add("APPLE_PERSON_NAME", SessionInfo.getCurUser().getPerson().getCName());//申请人姓名
                            RFMdata.add("APPLE_TYPE", "3");//退文类型：征求意见退文
                            RFMdata.add("RETURN_STATE", "0");//退文状态：待确认
                            InsteadRecordHandler IRH = new InsteadRecordHandler();
                            IRH.ReturnFileSave(conn, RFMdata, AFdata);
                        }
                    }else{
                        AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                    }
                }
            }
            //删除已存在且没有移交出去的移交信息
            Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
            String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID");//儿童的主儿童ID
            DataList CIdl = handler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
            TransferManagerHandler transferManagerHandler = new TransferManagerHandler();
            if(CIdl.size()>0){
                for(int i=0;i<CIdl.size();i++){
                    String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                    Data everyTIDdata = handler.getTransferInfoDetail(conn, everyCiId);
                    String TRANSFER_STATE = everyTIDdata.getString("TRANSFER_STATE", "");//交接状态
                    if(!"".equals(TRANSFER_STATE)){//有交接明细信息
                        if("1".equals(TRANSFER_STATE)){//明细信息已存在交接单中，修改交接单份数
                            String TI_ID = everyTIDdata.getString("TI_ID", "");//交接单ID
                            if(!"".equals(TI_ID)){
                                Data everyTIdata = handler.getTransferInfo(conn, TI_ID);
                                int COPIES = everyTIdata.getInt("COPIES");
                                if(COPIES > 0){
                                    COPIES = COPIES - 1;
                                }
                                everyTIdata.add("COPIES", COPIES);
                                transferManagerHandler.saveTransferInfo(conn, everyTIdata);
                            }
                        }
                        String TID_ID = everyTIDdata.getString("TID_ID", "");//交接明细ID
                        handler.deleteTransferInfoDetail(conn, TID_ID);//删除该交接明细信息
                    }
                }
            }
               
            if("1".equals(NOTICE_STATE)){//通知书寄发状态：已寄发
                Data AICreateData = new Data();
                Data AIdata = handler.getArchiveInfo(conn, MI_ID);
                AICreateData.add("ARCHIVE_ID", AIdata.getString("ARCHIVE_ID"));//
                AICreateData.add("ARCHIVE_DATE", "");//归档日期
                AICreateData.add("ARCHIVE_USERID", "");//归档人ID
                AICreateData.add("ARCHIVE_USERNAME", "");//归档人姓名
                AICreateData.add("ARCHIVE_STATE", "0");//归档状态
                AICreateData.add("ARCHIVE_VALID", "0");//是否有效
                Mhandler.saveNcmArchiveInfo(conn, AICreateData);
            }
            //登记证号回收使用
            String ADREG_NO = MSdata.getString("ADREG_NO", "");//收养登记_登记证号
            if(!"".equals(ADREG_NO)){
                Data farData = new Data();
                farData.add("FAR_SN", ADREG_NO);
                farData.add("IS_USED", "0");
                AdoptionRegisHandler adoptionRegisHandler = new AdoptionRegisHandler();
                adoptionRegisHandler.storeFarSN(conn, farData);
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "解除匹配成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "解除匹配失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "解除匹配失败!");
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
}
