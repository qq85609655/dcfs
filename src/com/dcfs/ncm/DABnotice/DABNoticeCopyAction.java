package com.dcfs.ncm.DABnotice;

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
import java.util.ArrayList;
import java.util.List;

import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ncm.MatchHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: DABNoticeCopyAction.java
 * @Description: 档案部通知书副本打印
 * @Company: 21softech
 * @Created on 2014-9-16 上午9:42:15
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class DABNoticeCopyAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(DABNoticeCopyAction.class);
    private Connection conn = null;
    private DABNoticeCopyHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public DABNoticeCopyAction() {
        this.handler=new DABNoticeCopyHandler();
        this.Mhandler=new MatchHandler();
        this.AFhandler=new FileCommonManager();
        this.CIhandler=new ChildManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: DABNoticePrintList
     * @Description: 档案部通知书打印列表
     * @author: xugy
     * @date: 2014-9-16上午9:45:58
     * @return
     */
    public String DABNoticePrintList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","FILE_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","NAME","NOTICECOPY_PRINT_NUM","NOTICECOPY_REPRINT");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABNoticePrintList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: DABNoticePrintPreview
     * @Description: 档案部通知书副本打印预览
     * @author: xugy
     * @date: 2014-11-13下午3:44:34
     * @return
     */
    public String DABNoticePrintPreview(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            ArrayList<Att> arraylist = new ArrayList<Att>();
            List<Att> list1 = AttHelper.findAttListByPackageId(MI_ID, AttConstants.LHSYZNTZSFB, "AF");
            arraylist.addAll(list1);
            List<Att> list2 = AttHelper.findAttListByPackageId(MI_ID, AttConstants.SWSYTZFB, "AF");
            arraylist.addAll(list2);
            //将结果集写入页面接收变量
            setAttribute("list",arraylist);
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
    
    /**
     * 
     * @Title: DABNoticePrint
     * @Description: 批量打印
     * @author: xugy
     * @date: 2014-11-13下午5:10:59
     * @return
     */
    public String DABNoticePrint(){
        String MI_ID = getParameter("ids");//匹配信息ID
        String[] arry = MI_ID.split("#");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            ArrayList<Att> arraylist = new ArrayList<Att>();
            String ids = "";
            for(int i=1;i<arry.length;i++){
                List<Att> list = AttHelper.findAttListByPackageId(arry[i], AttConstants.LHSYZNTZSFB, "AF");
                arraylist.addAll(list);
                if(i == 1){
                    ids = arry[i];
                }else{
                    ids = ids + "," + arry[i];
                }
            }
            for(int i=1;i<arry.length;i++){
                List<Att> list = AttHelper.findAttListByPackageId(arry[i], AttConstants.SWSYTZFB, "AF");
                arraylist.addAll(list);
            }
            //将结果集写入页面接收变量
            setAttribute("list",arraylist);
            setAttribute("MI_ID",ids);
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
     * @Title: DABArchiveFilingList
     * @Description: 档案部归档立卷
     * @author: xugy
     * @date: 2014-11-2下午5:47:31
     * @return
     */
    public String DABArchiveFilingList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO_START","ARCHIVE_NO_END","FILE_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","NAME","ARCHIVE_USERNAME","ARCHIVE_DATE_START","ARCHIVE_DATE_END","ARCHIVE_STATE","FILING_REMARKS","ARCHIVE_VALID");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findDABArchiveFilingList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toDABArchiveFiling
     * @Description: 归档立卷
     * @author: xugy
     * @date: 2014-11-2下午6:34:43
     * @return
     */
    public String toDABArchiveFiling(){
        String ARCHIVE_ID = getParameter("ids");//匹配收养人ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //查询收养人信息
            Data data = handler.getDABArchiveInfo(conn, ARCHIVE_ID);
            data.put("FILING_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            data.put("FILING_DATE", DateUtility.getCurrentDate());
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
     * @Title: saveDABArchiveFiling
     * @Description: 归档保存
     * @author: xugy
     * @date: 2014-11-3下午1:25:32
     * @return
     */
    public String saveDABArchiveFiling(){
        Data data = getRequestEntityData("AI_","ARCHIVE_ID","FILING_USERNAME","FILING_DATE","FILING_REMARKS");
        Data AFdata = getRequestEntityData("AF_","AF_ID");
        Data CIdata = getRequestEntityData("CI_","CI_ID");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            data.add("ARCHIVE_DATE", DateUtility.getCurrentDate());//归档日期
            data.add("ARCHIVE_USERID", SessionInfo.getCurUser().getPersonId());//归档人ID
            data.add("ARCHIVE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//归档人姓名
            data.add("ARCHIVE_STATE", "1");//归档状态
            Mhandler.saveNcmArchiveInfo(conn, data);
            
            AFdata.add("ARCHIVE_STATE", "1");
            AFhandler.modifyFileInfo(conn, AFdata);
            
            CIdata.add("ARCHIVE_STATE", "1");
            CIhandler.save(conn, CIdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "归档成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "归档失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "归档失败!");
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
     * @Title: toDABReleaseFiling
     * @Description: 解档
     * @author: xugy
     * @date: 2014-11-2下午6:36:30
     * @return
     */
    public String toDABReleaseFiling(){
        String ARCHIVE_ID = getParameter("ids");//匹配收养人ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //查询收养人信息
            Data data = handler.getDABArchiveInfo(conn, ARCHIVE_ID);
            data.put("CANCLE_DATE", DateUtility.getCurrentDate());//解档日期
            data.put("CANCLE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//解档人姓名
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
     * @Title: saveDABReleaseFiling
     * @Description: 解档保存
     * @author: xugy
     * @date: 2014-11-3下午4:33:02
     * @return
     */
    public String saveDABReleaseFiling(){
        Data data = getRequestEntityData("AI_","ARCHIVE_ID","CANCLE_REASON");
        Data AFdata = getRequestEntityData("AF_","AF_ID");
        Data CIdata = getRequestEntityData("CI_","CI_ID");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            data.add("CANCLE_DATE", DateUtility.getCurrentDate());//解档日期
            data.add("CANCLE_USERID", SessionInfo.getCurUser().getPersonId());//解档人ID
            data.add("CANCLE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//解档人姓名
            data.add("ARCHIVE_STATE", "3");//归档状态
            data.add("ARCHIVE_VALID", "0");//是否有效
            Mhandler.saveNcmArchiveInfo(conn, data);
            
            AFdata.add("ARCHIVE_STATE", "");
            AFhandler.modifyFileInfo(conn, AFdata);
            
            CIdata.add("ARCHIVE_STATE", "");
            CIhandler.save(conn, CIdata);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "解档成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "解档失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "解档失败!");
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
     * @Title: DABCatalog
     * @Description: 目录
     * @author: xugy
     * @date: 2014-11-2下午6:41:54
     * @return
     */
    public String DABCatalog(){
        String ARCHIVE_ID = getParameter("ids");//匹配收养人ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //查询收养人信息
            Data data = handler.getDABArchiveInfo(conn, ARCHIVE_ID);
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
     * @Title: saveDABCatalog
     * @Description: 目录保存
     * @author: xugy
     * @date: 2014-11-3上午11:00:55
     * @return
     */
    public String saveDABCatalog(){
        Data data = getRequestEntityData("AI_","ARCHIVE_ID","CATALOGUE1_FILE1_NUM","CATALOGUE1_FILE2_NUM","CATALOGUE1_FILE3_NUM","CATALOGUE1_FILE4_NUM","CATALOGUE1_FILE5_NUM","CATALOGUE1_FILE6_NUM","CATALOGUE1_FILE7_NUM","CATALOGUE1_FILE8_NUM","CATALOGUE1_FILE9_NUM","CATALOGUE1_FILE10_NUM","CATALOGUE1_FILE11_NUM","CATALOGUE1_FILE12_NUM","CATALOGUE1_FILE13_NUM","CATALOGUE1_FILE14_NUM","CATALOGUE1_FILE15_NUM","CATALOGUE1_FILE16_NUM","CATALOGUE1_FILE17_NUM","CATALOGUE1_FILE18_NUM","CATALOGUE1_FILE19_NUM","CATALOGUE1_FILE20_NUM","CATALOGUE1_FILE21_NUM","CATALOGUE1_FILE22_NUM","CATALOGUE1_FILE23_NUM","CATALOGUE1_FILE24_NUM","CATALOGUE1_FILE25_NUM","CATALOGUE1_FILE26_NUM","CATALOGUE1_FILE27_NUM","CATALOGUE1_FILE28_NUM","CATALOGUE1_FILE29_NUM","CATALOGUE1_FILE30_NUM","FILING_DATE","FILING_USERNAME");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Mhandler.saveNcmArchiveInfo(conn, data);
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "目录保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "目录保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "目录保存失败!");
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
     * @Title: getDABCatalogInfo
     * @Description: 批量打印目录获取打印信息
     * @author: xugy
     * @date: 2014-11-5下午2:56:14
     * @return
     */
    public String getDABCatalogInfo(){
        String ids = getParameter("ids");//
        String[] arry = ids.split("#");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            String ARCHIVE_IDs = "";
            for(int i=1;i<arry.length;i++){
                String ARCHIVE_ID = arry[i];
                if(i == 1){
                    ARCHIVE_IDs = "'" + ARCHIVE_ID + "'";
                }else{
                    ARCHIVE_IDs = ARCHIVE_IDs + "," + "'" + ARCHIVE_ID + "'";
                }
            }
            //查询收养人信息
            DataList dl = handler.getDABCatalogInfo(conn, ARCHIVE_IDs);
            for(int i=0;i<dl.size();i++){
                int CATALOGUE1_FILE1_NUM = dl.getData(i).getInt("CATALOGUE1_FILE1_NUM");
                int CATALOGUE1_FILE2_NUM = dl.getData(i).getInt("CATALOGUE1_FILE2_NUM");
                int CATALOGUE1_FILE3_NUM = dl.getData(i).getInt("CATALOGUE1_FILE3_NUM");
                int CATALOGUE1_FILE4_NUM = dl.getData(i).getInt("CATALOGUE1_FILE4_NUM");
                int CATALOGUE1_FILE5_NUM = dl.getData(i).getInt("CATALOGUE1_FILE5_NUM");
                int CATALOGUE1_FILE6_NUM = dl.getData(i).getInt("CATALOGUE1_FILE6_NUM");
                int CATALOGUE1_FILE7_NUM = dl.getData(i).getInt("CATALOGUE1_FILE7_NUM");
                int CATALOGUE1_FILE8_NUM = dl.getData(i).getInt("CATALOGUE1_FILE8_NUM");
                int CATALOGUE1_FILE9_NUM = dl.getData(i).getInt("CATALOGUE1_FILE9_NUM");
                int CATALOGUE1_FILE10_NUM = dl.getData(i).getInt("CATALOGUE1_FILE10_NUM");
                int CATALOGUE1_FILE11_NUM = dl.getData(i).getInt("CATALOGUE1_FILE11_NUM");
                int CATALOGUE1_FILE12_NUM = dl.getData(i).getInt("CATALOGUE1_FILE12_NUM");
                int CATALOGUE1_FILE13_NUM = dl.getData(i).getInt("CATALOGUE1_FILE13_NUM");
                int CATALOGUE1_FILE14_NUM = dl.getData(i).getInt("CATALOGUE1_FILE14_NUM");
                int CATALOGUE1_FILE15_NUM = dl.getData(i).getInt("CATALOGUE1_FILE15_NUM");
                int CATALOGUE1_FILE16_NUM = dl.getData(i).getInt("CATALOGUE1_FILE16_NUM");
                int CATALOGUE1_FILE17_NUM = dl.getData(i).getInt("CATALOGUE1_FILE17_NUM");
                int CATALOGUE1_FILE18_NUM = dl.getData(i).getInt("CATALOGUE1_FILE18_NUM");
                int CATALOGUE1_FILE19_NUM = dl.getData(i).getInt("CATALOGUE1_FILE19_NUM");
                int CATALOGUE1_FILE20_NUM = dl.getData(i).getInt("CATALOGUE1_FILE20_NUM");
                int CATALOGUE1_FILE21_NUM = dl.getData(i).getInt("CATALOGUE1_FILE21_NUM");
                int CATALOGUE1_FILE22_NUM = dl.getData(i).getInt("CATALOGUE1_FILE22_NUM");
                int CATALOGUE1_FILE23_NUM = dl.getData(i).getInt("CATALOGUE1_FILE23_NUM");
                int CATALOGUE1_FILE24_NUM = dl.getData(i).getInt("CATALOGUE1_FILE24_NUM");
                int CATALOGUE1_FILE25_NUM = dl.getData(i).getInt("CATALOGUE1_FILE25_NUM");
                int CATALOGUE1_FILE26_NUM = dl.getData(i).getInt("CATALOGUE1_FILE26_NUM");
                int CATALOGUE1_FILE27_NUM = dl.getData(i).getInt("CATALOGUE1_FILE27_NUM");
                int CATALOGUE1_FILE28_NUM = dl.getData(i).getInt("CATALOGUE1_FILE28_NUM");
                String CHILD_IDENTITY = dl.getData(i).getString("CHILD_IDENTITY", "");
                int TOTAL = 0;
                if("10".equals(CHILD_IDENTITY)){
                    TOTAL = CATALOGUE1_FILE1_NUM + CATALOGUE1_FILE2_NUM + CATALOGUE1_FILE3_NUM + CATALOGUE1_FILE4_NUM + CATALOGUE1_FILE5_NUM + CATALOGUE1_FILE6_NUM + CATALOGUE1_FILE7_NUM + CATALOGUE1_FILE8_NUM + CATALOGUE1_FILE9_NUM + CATALOGUE1_FILE10_NUM + CATALOGUE1_FILE11_NUM + CATALOGUE1_FILE12_NUM + CATALOGUE1_FILE13_NUM + CATALOGUE1_FILE14_NUM + CATALOGUE1_FILE15_NUM + CATALOGUE1_FILE16_NUM + CATALOGUE1_FILE17_NUM + CATALOGUE1_FILE18_NUM + CATALOGUE1_FILE19_NUM + CATALOGUE1_FILE20_NUM + CATALOGUE1_FILE21_NUM + CATALOGUE1_FILE22_NUM + CATALOGUE1_FILE23_NUM + CATALOGUE1_FILE24_NUM + CATALOGUE1_FILE25_NUM +  CATALOGUE1_FILE27_NUM;
                    if(TOTAL == 0){
                        TOTAL = 29;
                    }
                }
                if("201".equals(CHILD_IDENTITY) || "202".equals(CHILD_IDENTITY)){
                    TOTAL = CATALOGUE1_FILE1_NUM + CATALOGUE1_FILE2_NUM + CATALOGUE1_FILE3_NUM + CATALOGUE1_FILE4_NUM + CATALOGUE1_FILE5_NUM + CATALOGUE1_FILE6_NUM + CATALOGUE1_FILE7_NUM + CATALOGUE1_FILE8_NUM + CATALOGUE1_FILE9_NUM + CATALOGUE1_FILE10_NUM + CATALOGUE1_FILE11_NUM + CATALOGUE1_FILE12_NUM + CATALOGUE1_FILE13_NUM + CATALOGUE1_FILE14_NUM + CATALOGUE1_FILE15_NUM + CATALOGUE1_FILE16_NUM + CATALOGUE1_FILE17_NUM + CATALOGUE1_FILE18_NUM + CATALOGUE1_FILE19_NUM + CATALOGUE1_FILE20_NUM + CATALOGUE1_FILE21_NUM + CATALOGUE1_FILE22_NUM + CATALOGUE1_FILE23_NUM + CATALOGUE1_FILE24_NUM + CATALOGUE1_FILE25_NUM + CATALOGUE1_FILE26_NUM + CATALOGUE1_FILE27_NUM;
                    if(TOTAL == 0){
                        TOTAL = 30;
                    }
                }
                if("301".equals(CHILD_IDENTITY) || "302".equals(CHILD_IDENTITY)){
                    TOTAL = CATALOGUE1_FILE1_NUM + CATALOGUE1_FILE2_NUM + CATALOGUE1_FILE3_NUM + CATALOGUE1_FILE4_NUM + CATALOGUE1_FILE5_NUM + CATALOGUE1_FILE6_NUM + CATALOGUE1_FILE7_NUM + CATALOGUE1_FILE8_NUM + CATALOGUE1_FILE9_NUM + CATALOGUE1_FILE10_NUM + CATALOGUE1_FILE11_NUM + CATALOGUE1_FILE12_NUM + CATALOGUE1_FILE13_NUM + CATALOGUE1_FILE14_NUM + CATALOGUE1_FILE15_NUM + CATALOGUE1_FILE16_NUM + CATALOGUE1_FILE17_NUM + CATALOGUE1_FILE18_NUM + CATALOGUE1_FILE19_NUM + CATALOGUE1_FILE20_NUM + CATALOGUE1_FILE21_NUM + CATALOGUE1_FILE22_NUM + CATALOGUE1_FILE23_NUM + CATALOGUE1_FILE24_NUM + CATALOGUE1_FILE25_NUM + CATALOGUE1_FILE26_NUM + CATALOGUE1_FILE27_NUM + CATALOGUE1_FILE28_NUM;
                    if(TOTAL == 0){
                        TOTAL = 20;
                    }
                }
                if("40".equals(CHILD_IDENTITY) || "50".equals(CHILD_IDENTITY)){
                    TOTAL = CATALOGUE1_FILE1_NUM + CATALOGUE1_FILE2_NUM + CATALOGUE1_FILE3_NUM + CATALOGUE1_FILE4_NUM + CATALOGUE1_FILE5_NUM + CATALOGUE1_FILE6_NUM + CATALOGUE1_FILE7_NUM + CATALOGUE1_FILE8_NUM + CATALOGUE1_FILE9_NUM + CATALOGUE1_FILE10_NUM + CATALOGUE1_FILE11_NUM + CATALOGUE1_FILE12_NUM + CATALOGUE1_FILE13_NUM + CATALOGUE1_FILE14_NUM + CATALOGUE1_FILE15_NUM + CATALOGUE1_FILE16_NUM + CATALOGUE1_FILE17_NUM + CATALOGUE1_FILE18_NUM + CATALOGUE1_FILE19_NUM + CATALOGUE1_FILE20_NUM + CATALOGUE1_FILE21_NUM + CATALOGUE1_FILE22_NUM + CATALOGUE1_FILE23_NUM + CATALOGUE1_FILE24_NUM + CATALOGUE1_FILE25_NUM + CATALOGUE1_FILE26_NUM + CATALOGUE1_FILE27_NUM + CATALOGUE1_FILE28_NUM;
                    if(TOTAL == 0){
                        TOTAL = 18;
                    }
                }
                if("60".equals(CHILD_IDENTITY)){
                    TOTAL = CATALOGUE1_FILE1_NUM + CATALOGUE1_FILE2_NUM + CATALOGUE1_FILE3_NUM + CATALOGUE1_FILE4_NUM + CATALOGUE1_FILE5_NUM + CATALOGUE1_FILE6_NUM + CATALOGUE1_FILE7_NUM + CATALOGUE1_FILE8_NUM + CATALOGUE1_FILE9_NUM + CATALOGUE1_FILE10_NUM + CATALOGUE1_FILE11_NUM + CATALOGUE1_FILE12_NUM + CATALOGUE1_FILE13_NUM + CATALOGUE1_FILE14_NUM + CATALOGUE1_FILE15_NUM + CATALOGUE1_FILE16_NUM + CATALOGUE1_FILE17_NUM + CATALOGUE1_FILE18_NUM + CATALOGUE1_FILE19_NUM + CATALOGUE1_FILE20_NUM + CATALOGUE1_FILE21_NUM + CATALOGUE1_FILE22_NUM + CATALOGUE1_FILE23_NUM + CATALOGUE1_FILE24_NUM + CATALOGUE1_FILE25_NUM + CATALOGUE1_FILE26_NUM;
                    if(TOTAL == 0){
                        TOTAL = 28;
                    }
                }
                dl.getData(i).add("TOTAL", TOTAL);
            }
            //将结果集写入页面接收变量
            setAttribute("dl",dl);
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

}
