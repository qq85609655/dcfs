package com.dcfs.ncm.SYZZadvice;

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
import java.util.List;
import java.util.Locale;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.AZBadvice.AZBAdviceHandler;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: SYZZAdviceAction.java
 * @Description: 收养组织征求意见
 * @Company: 21softech
 * @Created on 2014-9-11 下午4:38:03
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SYZZAdviceAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(SYZZAdviceAction.class);
    private Connection conn = null;
    private SYZZAdviceHandler handler;
    private MatchHandler Mhandler;
    private AZBAdviceHandler AZBhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public SYZZAdviceAction() {
        this.handler=new SYZZAdviceHandler();
        this.Mhandler=new MatchHandler();
        this.AZBhandler=new AZBAdviceHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: SYZZAdviceList
     * @Description: 收养组织征求意见列表
     * @author: xugy
     * @date: 2014-9-11下午4:50:16
     * @return
     */
    public String SYZZAdviceList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","FILE_TYPE","REGISTER_DATE_START","REGISTER_DATE_END","MALE_NAME","FEMALE_NAME","ADVICE_NOTICE_DATE_START","ADVICE_NOTICE_DATE_END","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","PROVINCE_ID","WELFARE_ID","CHILD_TYPE","ADVICE_STATE","ADVICE_FEEDBACK_RESULT","ADVICE_REMINDER_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findSYZZAdviceList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: adviceDetail
     * @Description: 征求意见书明细查看
     * @author: xugy
     * @date: 2014-9-11下午7:32:53
     * @return
     */
    public String adviceDetail(){
        
        return retValue;
    }
    /**
     * 
     * @Title: reminderDetail
     * @Description: 催办明细查看
     * @author: xugy
     * @date: 2014-9-11下午7:33:38
     * @return
     */
    public String reminderDetail(){
        String MI_ID = getParameter("ids");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据
            Data data = AZBhandler.getMatchReminderInfo(conn, MI_ID);
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy年MM月dd日");
            SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
            
            String ADVICE_NOTICE_DATE = data.getDate("ADVICE_NOTICE_DATE");
            Date advice_notice_date = sdf.parse(ADVICE_NOTICE_DATE);
            String ADVICE_NOTICE_DATE_CN = sdfCN.format(advice_notice_date);
            data.add("ADVICE_NOTICE_DATE_CN", ADVICE_NOTICE_DATE_CN);
            String ADVICE_NOTICE_DATE_EN = sdfEN.format(advice_notice_date);
            data.add("ADVICE_NOTICE_DATE_EN", ADVICE_NOTICE_DATE_EN);
            
            String BIRTHDAY = data.getDate("BIRTHDAY");
            Date birthday_date = sdf.parse(BIRTHDAY);
            String BIRTHDAY_CN = sdfCN.format(birthday_date);
            data.add("BIRTHDAY_CN", BIRTHDAY_CN);
            String BIRTHDAY_EN = sdfEN.format(birthday_date);
            data.add("BIRTHDAY_EN", BIRTHDAY_EN);
            
            String ADVICE_CLOSE_DATE = data.getDate("ADVICE_CLOSE_DATE");
            Date advice_close_date = sdf.parse(ADVICE_CLOSE_DATE);
            String ADVICE_CLOSE_DATE_CN = sdfCN.format(advice_close_date);
            data.add("ADVICE_CLOSE_DATE_CN", ADVICE_CLOSE_DATE_CN);
            String ADVICE_CLOSE_DATE_EN = sdfEN.format(advice_close_date);
            data.add("ADVICE_CLOSE_DATE_EN", ADVICE_CLOSE_DATE_EN);
            
            String ADVICE_REMINDER_DATE = data.getDate("ADVICE_REMINDER_DATE");
            Date advice_reminder_date = sdf.parse(ADVICE_REMINDER_DATE);
            String ADVICE_REMINDER_DATE_CN = sdfCN.format(advice_reminder_date);
            data.add("ADVICE_REMINDER_DATE_CN", ADVICE_REMINDER_DATE_CN);
            String ADVICE_REMINDER_DATE_EN = sdfEN.format(advice_reminder_date);
            data.add("ADVICE_REMINDER_DATE_EN", ADVICE_REMINDER_DATE_EN);
            //将结果集写入页面接收变量
            setAttribute("data",data);
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
     * @Title: adviceFeedbackAdd
     * @Description: 收养组织征求意见反馈
     * @author: xugy
     * @date: 2014-9-11下午7:31:16
     * @return
     */
    public String adviceFeedbackAdd(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //将结果集写入页面接收变量
            setAttribute("data",data);
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
     * @Title: adviceFeedbackSave
     * @Description: 反馈保存
     * @author: xugy
     * @date: 2014-9-12下午2:01:30
     * @return
     */
    public String adviceFeedbackSave(){
        String MI_ID = getParameter("Ins_MI_ID");//匹配信息ID
        String IS_CONVENTION_ADOPT = getParameter("Ins_IS_CONVENTION_ADOPT");//公约收养
        Data data = getRequestEntityData("F_","ADVICE_GOV_ID","ADVICE_FEEDBACK_OPINION");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            if("0".equals(IS_CONVENTION_ADOPT)){//若果不是公约收养，去除收养国中央机关
                data.remove("ADVICE_GOV_ID");
            }
            data.add("MI_ID", MI_ID);//匹配信息ID
            data.add("ADVICE_STATE", "2");//征求意见_状态：待确认
            data.add("ADVICE_FEEDBACK_DATE", DateUtility.getCurrentDate());//征求意见_反馈日期
            Mhandler.saveNcmMatchInfo(conn, data);
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "Feedback submitted successfully!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "Feedback submitted fail!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "Feedback submitted fail!");
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
     * @Title: CFMDetail
     * @Description: 收养组组查看安置部确认情况
     * @author: xugy
     * @date: 2014-9-12下午6:45:20
     * @return
     */
    public String CFMDetail(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //将结果集写入页面接收变量
            setAttribute("data",data);
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
     * @Title: SYZZNoticeList
     * @Description: 收养组织来华领养通知书列表
     * @author: xugy
     * @date: 2014-11-2下午3:57:17
     * @return
     */
    public String SYZZNoticeList(){
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
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","MALE_NAME","FEMALE_NAME","FILE_TYPE","CHILD_TYPE","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","SIGN_DATE_START","SIGN_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findSYZZNoticeList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: SYZZNoticeAttDetail
     * @Description: 收养组织通知书查看
     * @author: xugy
     * @date: 2014-11-19下午4:37:18
     * @return
     */
    public String SYZZNoticeAttDetail(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            List<Att> list = AttHelper.findAttListByPackageId(MI_ID, AttConstants.LHSYZNTZSSY, "AF");
            //将结果集写入页面接收变量
            setAttribute("list",list);
            setAttribute("MI_ID",MI_ID);
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
