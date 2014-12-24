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
 * @Description: 档案部退回材料到安置部
 * @Company: 21softech
 * @Created on 2014-12-16 下午7:26:50
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChildInfoReturnAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(ChildInfoReturnAction.class);
    private Connection conn = null;
    private ChildInfoReturnHandler handler;
    private DBTransaction dt = null;//事务处理
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
     * @Description: 安置部申请材料退回列表
     * @author: xugy
     * @date: 2014-12-16下午8:54:38
     * @return
     */
    public String AZBApplyCIReturnList(){
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
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","APPLY_USER","APPLY_DATE_START","APPLY_DATE_END","CONFIRM_DATE_START","CONFIRM_DATE_END","APPLY_STATE","CONFIRM_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAZBApplyCIReturnList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: AZBSelectDABCIList
     * @Description: 安置部选择已移交的儿童材料列表
     * @author: xugy
     * @date: 2014-12-17上午10:48:40
     * @return
     */
    public String AZBSelectDABCIList(){
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
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","TRANSFER_DATE_START","TRANSFER_DATE_END","RECEIVER_DATE_START","RECEIVER_DATE_END");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAZBSelectDABCIList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toAZBApplyCIReturnAdd
     * @Description: 申请添加
     * @author: xugy
     * @date: 2014-12-17下午12:41:14
     * @return
     */
    public String toAZBApplyCIReturnAdd(){
        String ids = getParameter("ids");//儿童材料ID，收养人文件ID
        String CI_ID = ids.split(",")[0];//儿童材料ID
        String AF_ID = ids.split(",")[1];//收养人文件ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = new Data();
            data.add("CI_ID", CI_ID);
            data.add("AF_ID", AF_ID);
            data.add("APPLY_USER", SessionInfo.getCurUser().getPerson().getCName());//审核人姓名
            data.add("APPLY_DATE", DateUtility.getCurrentDate());//审核日期
            
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
     * @Title: saveAZBApplyCIReturnAdd
     * @Description: 保存申请数据
     * @author: xugy
     * @date: 2014-12-17下午1:19:32
     * @return
     */
    public String saveAZBApplyCIReturnAdd(){
        Data data = getRequestEntityData("F_","NAR_ID","AF_ID","CI_ID","APPLY_INFO");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            data.add("REV_TYPE", "1");//解除类型
            data.add("APPLY_DATE", DateUtility.getCurrentDate());//申请日期
            data.add("APPLY_USER", SessionInfo.getCurUser().getPerson().getCName());//申请人
            data.add("APPLY_DEPT", SessionInfo.getCurUser().getCurOrgan().getCName());//申请部门
            data.add("APPLY_STATE", "1");//确认状态
            handler.saveNcmArchRevocation(conn, data);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "申请保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "申请保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "申请保存失败!");
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
     * @Title: DABRevokeArchiveList
     * @Description: 档案部撤销档案列表
     * @author: xugy
     * @date: 2014-12-17下午1:56:42
     * @return
     */
    public String DABRevokeArchiveList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","SIGN_NO","SIGN_DATE_START","SIGN_DATE_END","PROVINCE_ID","WELFARE_ID","NAME","FILE_NO","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","ARCHIVE_STATE","CONFIRM_USER","CONFIRM_DATE_START","CONFIRM_DATE_END","APPLY_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABRevokeArchiveList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toDABRevokeArchiveAdd
     * @Description: 档案部撤销档案添加
     * @author: xugy
     * @date: 2014-12-17下午3:33:32
     * @return
     */
    public String toDABRevokeArchiveAdd(){
        String ids = getParameter("ids");//申请撤销档案ID，匹配信息ID
        String NAR_ID = ids.split(",")[0];//申请撤销档案ID
        String MI_ID = ids.split(",")[1];//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.getNcmArchRevocation(conn, NAR_ID);
            data.add("MI_ID", MI_ID);
            data.add("CONFIRM_USER", SessionInfo.getCurUser().getPerson().getCName());
            data.add("CONFIRM_DATE", DateUtility.getCurrentDate());
            
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
     * @Title: saveDABRevokeArchiveAdd
     * @Description: 档案部撤销档案添加保存
     * @author: xugy
     * @date: 2014-12-17下午4:21:14
     * @return
     */
    public String saveDABRevokeArchiveAdd(){
        Data data = getRequestEntityData("F_","NAR_ID","CONFIRM_STATE","CONFIRM_INFO");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            data.add("CONFIRM_DATE", DateUtility.getCurrentDate());//确认日期
            data.add("CONFIRM_USER", SessionInfo.getCurUser().getPerson().getCName());//确认人
            data.add("CONFIRM_DEPT", SessionInfo.getCurUser().getCurOrgan().getCName());//确认部门
            data.add("APPLY_STATE", "2");//确认状态
            String CONFIRM_STATE = data.getString("CONFIRM_STATE");
            if("1".equals(CONFIRM_STATE)){//同意
                String CI_ID = getParameter("F_CI_ID");
                String MI_ID = getParameter("F_MI_ID");
                Data ARdata = handler.getNcmArchiveInfo(conn, MI_ID);
                String ARCHIVE_STATE = ARdata.getString("ARCHIVE_STATE", "");
                if(!"".equals(ARCHIVE_STATE)){//已归档
                    ARdata.add("ARCHIVE_DATE", "");//归档日期
                    ARdata.add("ARCHIVE_USERID", "");//归档人ID
                    ARdata.add("ARCHIVE_USERNAME", "");//归档人姓名
                    ARdata.add("ARCHIVE_STATE", "0");//归档状态
                    ARdata.add("ARCHIVE_VALID", "0");//是否有效
                    MatchHandler matchHandler = new MatchHandler();
                    matchHandler.saveNcmArchiveInfo(conn, ARdata);
                }
                
                //儿童材料从档案部移交到安置部
                DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//交接明细ID
                transferData.add("APP_ID", CI_ID);//业务记录ID
                transferData.add("TRANSFER_CODE", TransferCode.RFM_CHILDINFO_DAB_AZB);//移交类型：档案部-->安置部
                transferData.add("TRANSFER_STATE", "0");//移交状态
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);//插入一条移交信息
                
                //材料全局状态和位置
                Data CIdata = new Data();
                CIdata.add("CI_ID", CI_ID);
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.returnCINotTransfer(CIdata, SessionInfo.getCurUser().getCurOrgan());
                ChildManagerHandler childManagerHandler = new ChildManagerHandler();
                childManagerHandler.save(conn, CIdata);
            }
            handler.saveNcmArchRevocation(conn, data);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "申请确认成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "申请确认失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "申请确认失败!");
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
