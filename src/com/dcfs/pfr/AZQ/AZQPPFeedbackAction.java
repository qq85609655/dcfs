package com.dcfs.pfr.AZQ;

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

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.pfr.PPFeebbackAttAction;
import com.dcfs.pfr.DAB.DABPPFeedbackHandler;
import com.dcfs.pfr.SYZZ.SYZZPPFeedbackHandler;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
/**
 * 
 * @Title: AZQPPFeedbackAction.java
 * @Description: 爱之桥报告翻译
 * @Company: 21softech
 * @Created on 2014-10-13 下午5:07:51
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AZQPPFeedbackAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AZQPPFeedbackAction.class);
    private Connection conn = null;
    private AZQPPFeedbackHandler handler;
    private SYZZPPFeedbackHandler SYZZhandler;
    private DABPPFeedbackHandler DABhandler;
    private PPFeedbackHandler PPhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public AZQPPFeedbackAction() {
        this.handler=new AZQPPFeedbackHandler();
        this.SYZZhandler=new SYZZPPFeedbackHandler();
        this.DABhandler=new DABPPFeedbackHandler();
        this.PPhandler=new PPFeedbackHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: AZQPPFeedbackTransList
     * @Description: 爱之桥翻译列表
     * @author: xugy
     * @date: 2014-10-13下午5:09:53
     * @return
     */
    public String AZQPPFeedbackTransList(){
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
        Data data = getRequestEntityData("S_","ARCHIVE_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","NAME","SIGN_DATE_START","SIGN_DATE_END","REPORT_DATE_START","REPORT_DATE_END","RECEIVER_DATE_START","RECEIVER_DATE_END","DISTRIB_DATE_START","DISTRIB_DATE_END","COMPLETE_DATE_START","COMPLETE_DATE_END","TRANSLATION_UNITNAME","TRANSLATION_STATE","NUM");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAZQPPFeedbackTransList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: dispatch
     * @Description: 翻译分发
     * @author: xugy
     * @date: 2014-10-23下午6:03:34
     * @return
     */
    public String dispatch(){
        String ids = getParameter("ids");
        String[] array = ids.split("#");
        //翻译单位ID
        String strTranslationUnit = getParameter("TRANSLATION_UNIT");
        //翻译单位名称
        String strTranslationUnitName = getParameter("TRANSLATION_UNITNAME");   
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String FB_T_ID = array[i];
                String FB_REC_ID = handler.getFBREDID(conn, FB_T_ID);
                Data FTdata = new Data();
                FTdata.add("FB_T_ID", FB_T_ID);
                FTdata.add("DISTRIB_USERID", SessionInfo.getCurUser().getPersonId());//翻译分发人ID2
                FTdata.add("DISTRIB_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//翻译分发人姓名
                FTdata.add("DISTRIB_DATE", DateUtility.getCurrentDate());//翻译分发日期
                FTdata.add("TRANSLATION_UNIT", strTranslationUnit);//翻译单位ID
                FTdata.add("TRANSLATION_UNITNAME", strTranslationUnitName);//翻译单位名称
                PPhandler.savePfrFeedbackTranslation(conn, FTdata);
                
                Data FRdata = new Data();
                FRdata.add("FB_REC_ID", FB_REC_ID);
                FRdata.add("TRANSLATION_COMPANY", strTranslationUnitName);//报告翻译单位
                PPhandler.savePfrFeedbackRecord(conn, FRdata);
            }
            
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告翻译分发成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告翻译分发失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告翻译分发失败!");
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
     * @Title: toAZQPPFeedbackTranslation
     * @Description: 爱之桥翻译
     * @author: xugy
     * @date: 2014-10-14上午9:49:58
     * @return
     */
    public String toAZQPPFeedbackTranslation(){
        String ids = getParameter("ids");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackTranslationInfo(conn, ids);
            
            BatchAttManager bm = new BatchAttManager();
            PPFeebbackAttAction ppfb = new PPFeebbackAttAction();
            //安置后报告-一般
            String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
            String NUM = data.getString("NUM");
            DataList attType1 = ppfb.attTypeNormal(conn, birthdayYear, NUM);
            
            //System.out.println(attType1);
            String xmlstr1 = bm.getUploadParameter(attType1);
            
            //中文附件去掉照片
            DataList attTypeCN1 = ppfb.attTypeNormalCN(conn, birthdayYear, NUM);
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
     * @Title: saveAZQPPFeedbackTranslation
     * @Description: 翻译保存
     * @author: xugy
     * @date: 2014-10-14上午10:18:39
     * @return
     */
    public String saveAZQPPFeedbackTranslation(){
        
        Data FTdata = getRequestEntityData("FT_","FB_T_ID","TRANSLATION_DESC");
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("TRANSLATION_COMPANY", SessionInfo.getCurUser().getCurOrgan().getCName());//报告翻译单位
            FRdata.add("TRANSLATION_STATE", "1");//翻译状态
            FRdata.add("REPORT_STATE", "4");//报告状态
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            FTdata.add("TRANSLATION_UNIT", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//翻译单位ID
            FTdata.add("TRANSLATION_UNITNAME", SessionInfo.getCurUser().getCurOrgan().getCName());//翻译单位名称
            FTdata.add("TRANSLATION_STATE", "1");//翻译状态
            PPhandler.savePfrFeedbackTranslation(conn, FTdata);
            
            //将附件进行发布            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");         
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告翻译保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告翻译保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告翻译保存失败!");
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
     * @Title: submitAZQPPFeedbackTranslation
     * @Description: 翻译提交
     * @author: xugy
     * @date: 2014-10-14上午10:30:02
     * @return
     */
    public String submitAZQPPFeedbackTranslation(){
        
        Data FTdata = getRequestEntityData("FT_","FB_T_ID","TRANSLATION_DESC");
        Data FRdata = getRequestEntityData("FR_","FB_REC_ID","ORG_NAME","VISIT_DATE","ACCIDENT_FLAG","FINISH_DATE","IS_PUBLIC");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            FRdata.add("TRANSLATION_COMPANY", SessionInfo.getCurUser().getCurOrgan().getCName());//报告翻译单位
            FRdata.add("TRANSLATION_DATE", DateUtility.getCurrentDate());//翻译日期
            FRdata.add("TRANSLATION_STATE", "2");//翻译状态
            FRdata.add("REPORT_STATE", "5");//报告状态
            PPhandler.savePfrFeedbackRecord(conn, FRdata);
            
            //将附件进行发布            
            AttHelper.publishAttsOfPackageId(FRdata.getString("FB_REC_ID"),"AR");
            AttHelper.publishAttsOfPackageId("F_"+FRdata.getString("FB_REC_ID"),"AR");
            
            FTdata.add("COMPLETE_DATE", DateUtility.getCurrentDate());//翻译完成日期
            FTdata.add("TRANSLATION_UNIT", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//翻译单位ID
            FTdata.add("TRANSLATION_UNITNAME", SessionInfo.getCurUser().getCurOrgan().getCName());//翻译单位名称
            FTdata.add("TRANSLATION_USERID", SessionInfo.getCurUser().getPersonId());//翻译人ID
            FTdata.add("TRANSLATION_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//翻译人姓名
            FTdata.add("TRANSLATION_STATE", "2");//翻译状态
            PPhandler.savePfrFeedbackTranslation(conn, FTdata);
            
            DataList transferList = new DataList();
            Data transferData = new Data();
            transferData.add("TID_ID", "");//交接明细ID
            transferData.add("APP_ID", FRdata.getString("FB_REC_ID"));//业务记录ID
            transferData.add("TRANSFER_CODE", TransferCode.ARCHIVE_FYGS_DAB);//移交类型
            transferData.add("TRANSFER_STATE", "0");//移交状态
            transferList.add(transferData);
            FileCommonManager FC = new FileCommonManager();
            FC.transferDetailInit(conn, transferList);//插入一条移交信息
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "报告翻译提交成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告翻译提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "报告翻译提交失败!");
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
     * @Title: AZQPPFeedbackTranslationDetail
     * @Description: 报告查看
     * @author: xugy
     * @date: 2014-10-15下午8:24:55
     * @return
     */
    public String AZQPPFeedbackTranslationDetail(){
        String ids = getParameter("ids");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data = PPhandler.getFeedbackTranslationInfo(conn, ids);
            
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
