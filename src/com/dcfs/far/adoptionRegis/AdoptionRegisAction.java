package com.dcfs.far.adoptionRegis;

import hx.code.CodeList;
import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.config.CommonConfig;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;
import hx.word.getword.GetWord;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.BGSnotice.BGSNoticeHandler;
import com.dcfs.ncm.common.FarCommonAction;
import com.dcfs.pfr.feedback.PPFeedbackHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: AdoptionRegisAction.java
 * @Description: 收养登记办理
 * @Company: 21softech
 * @Created on 2014-9-22 下午7:53:51
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AdoptionRegisAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AdoptionRegisAction.class);
    private Connection conn = null;
    private AdoptionRegisHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private PPFeedbackHandler PPhandler;
    
    private FarCommonAction FCA;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public AdoptionRegisAction() {
        this.handler=new AdoptionRegisHandler();
        this.Mhandler=new MatchHandler();
        this.AFhandler=new FileCommonManager();
        this.CIhandler=new ChildManagerHandler();
        this.FCA=new FarCommonAction();
        this.PPhandler=new PPFeedbackHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: adoptionRegisList
     * @Description: 收养登记列表
     * @author: xugy
     * @date: 2014-9-22下午7:56:34
     * @return
     */
    public String adoptionRegisList(){
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
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","WELFARE_NAME_CN","CHILD_TYPE","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","IS_CONVENTION_ADOPT","ADREG_NO","SIGN_DATE_START","SIGN_DATE_END","ADREG_STATE","ADREG_DATE_START","ADREG_DATE_END");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAdoptionRegisList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toAdoptionRegisPrePrint
     * @Description: 登记预打印
     * @author: xugy
     * @date: 2014-11-13下午8:36:41
     * @return
     */
    public String toAdoptionRegisPrePrint(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            
            List<Att> list1 = AttHelper.findAttListByPackageId(MI_ID, AttConstants.SYDJZ, "AF");
            List<Att> list2 = AttHelper.findAttListByPackageId(MI_ID, AttConstants.KGSYHGZM, "AF");
            
            setAttribute("list1",list1);
            setAttribute("list2",list2);
            setAttribute("MI_ID",MI_ID);
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
     * @Title: toAdoptionRegAdd
     * @Description: 收养登记页面
     * @author: xugy
     * @date: 2014-9-23下午2:06:02
     * @return
     */
    public String toAdoptionRegAdd(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.getAdoptionRegInfo(conn, MI_ID);
            
            data.add("ADREG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
            data.add("ADREG_DATE", DateUtility.getCurrentDate());
            
            String PROVINCE_ID = data.getString("PROVINCE_ID");
            String provinceCode = PROVINCE_ID.substring(0, 2);
            //获取登记证号旧号
            CodeList list = handler.findOldFarSN(conn, provinceCode);
            HashMap<String,CodeList> cmap=new HashMap<String,CodeList>();
            cmap.put("OLD_FAR_SN_LIST", list);
            //将结果集写入页面接收变量
            setAttribute(Constants.CODE_LIST,cmap);
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
     * @Title: saveAdoptionReg
     * @Description: 保存收养登记
     * @author: xugy
     * @date: 2014-9-23下午6:05:17
     * @return
     */
    public String saveAdoptionReg(){
        //收养登记信息
        String NUMBER_TYPE = getParameter("Ins_NUMBER_TYPE");//登记证号：1、自动生成；2、使用旧号
        String ADREG_RESULT = getParameter("Ins_ADREG_RESULT");//登记结果：1、登记成功；2、无效登记
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADREG_DEAL_TYPE","ADREG_INVALID_REASON","ADREG_REMARKS","ADREG_DATE");
        String PROVINCE_ID = getParameter("Ins_PROVINCE_ID");
        MIdata.add("ADREG_PROVINCE_ID", PROVINCE_ID);//省份代码
        MIdata.add("ADREG_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//登记机构ID
        MIdata.add("ADREG_USER_ID", SessionInfo.getCurUser().getPerson().getPersonId());//登记人ID
        MIdata.add("ADREG_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//登记人姓名
        if("1".equals(ADREG_RESULT)){
            MIdata.add("ADREG_STATE", "1");//登记状态：已登记
        }
        if("2".equals(ADREG_RESULT)){
            MIdata.add("ADREG_STATE", "2");//登记状态：无效登记
        }
        
        //儿童信息
        Data CIdata = getRequestEntityData("CI_","CI_ID","SEX","BIRTHDAY","CHILD_IDENTITY","ID_CARD","SENDER","SENDER_EN","SENDER_ADDR","NATION_DATE","CHILD_NAME_EN");
        //收养人信息
        Data AFdata = new Data();
        String FILE_TYPE = getParameter("Ins_FILE_TYPE");//文件类型
        String FAMILY_TYPE = getParameter("Ins_FAMILY_TYPE");//收养类型
        String ADOPTER_SEX = getParameter("Ins_ADOPTER_SEX","");//收养人性别
        if("33".equals(FILE_TYPE)){//继子女收养
            if("1".equals(ADOPTER_SEX)){//男收养人
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO");
            }
            if("2".equals(ADOPTER_SEX)){//女收养人
                AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO");
            }
        }else{
            if("1".equals(FAMILY_TYPE)){//双亲收养
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","FEMALE_NATION","MALE_PASSPORT_NO","FEMALE_PASSPORT_NO","ADDRESS");
            }
            if("2".equals(FAMILY_TYPE)){//单亲收养
                if("1".equals(ADOPTER_SEX)){//男收养人
                    AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO","ADDRESS");
                }
                if("2".equals(ADOPTER_SEX)){//女收养人
                    AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO","ADDRESS");
                }
            }
        }
        
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String COUNTRY_CODE = getParameter("Ins_COUNTRY_CODE");//国家code
            String ADREG_NO = "";
            if("1".equals(ADREG_RESULT)){//登记成功
                if("1".equals(NUMBER_TYPE)){//自动生成登记证号
                    ADREG_NO = FCA.createFARSn(conn, COUNTRY_CODE, PROVINCE_ID);
                }
                if("2".equals(NUMBER_TYPE)){//使用旧号
                    ADREG_NO = getParameter("Ins_ADREG_NO");
                    Data farData = new Data();
                    farData.add("FAR_SN", ADREG_NO);
                    farData.add("IS_USED", "1");
                    handler.storeFarSN(conn, farData);
                }
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.ST_SYDJ_DJCG);
                AFdata.addData(data);
                
                //材料全局状态和位置
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.adoptionIsRegistered(CIdata, SessionInfo.getCurUser().getCurOrgan());
            }else{
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.ST_SYDJ_DJWX);
                AFdata.addData(data);
            }
            MIdata.add("ADREG_NO", ADREG_NO);//登记证号
            Mhandler.saveNcmMatchInfo(conn, MIdata);//收养登记信息保存
            AFhandler.modifyFileInfo(conn, AFdata);//收养人信息保存
            CIhandler.save(conn, CIdata);//儿童信息保存
            
            if("1".equals(ADREG_RESULT)){//登记成功，保存安置后报告信息
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                String SIGN_DATE = getParameter("Ins_SIGN_DATE");//签批日期
                Date signDate = sdf.parse(SIGN_DATE);
                String d1 = "2014-12-31";
                Date date1 = sdf.parse(d1);
                String d2 = "2015-01-01";
                Date date2 = sdf.parse(d2);
                
                String MI_ID = MIdata.getString("MI_ID");//匹配信息ID
                Data PFRdata = handler.getSavePFRInfo(conn, MI_ID);
                PFRdata.add("FEEDBACK_ID", "");
                PFRdata.add("IS_FINISH", "0");
                PFRdata = PPhandler.savePfrFeedbackInfo(conn, PFRdata);
                String FEEDBACK_ID = PFRdata.getString("FEEDBACK_ID");//安置后报告ID
                String ADREG_DATE = PFRdata.getString("ADREG_DATE");//登记日期
                if(signDate.before(date2)){//2015-01-01之前
                    for(int i=1;i<=6;i++){
                        Data PFRRdata = new Data();
                        PFRRdata.add("FB_REC_ID", "");//安置后报告记录ID
                        PFRRdata.add("FEEDBACK_ID", FEEDBACK_ID);//安置后报告ID
                        PFRRdata.add("NUM", i);//次数
                        PFRRdata.add("REMINDERS_STATE", "0");//催交状态
                        PFRRdata.add("REPORT_STATE", "0");//报告状态
                        String LIMIT_DATE = "";
                        if(i == 1){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 1);
                        }
                        if(i == 2){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                        }
                        if(i == 3){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                        }
                        if(i == 4){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                        }
                        if(i == 5){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                        }
                        if(i == 6){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                        }
                        PFRRdata.add("LIMIT_DATE", LIMIT_DATE);//提交时限
                        PPhandler.savePfrFeedbackRecord(conn, PFRRdata);
                    }
                }
                if(date1.before(signDate)){//2014-12-31之后
                    for(int i=1;i<=6;i++){
                        Data PFRRdata = new Data();
                        PFRRdata.add("FB_REC_ID", "");//安置后报告记录ID
                        PFRRdata.add("FEEDBACK_ID", FEEDBACK_ID);//安置后报告ID
                        PFRRdata.add("NUM", i);//次数
                        PFRRdata.add("REMINDERS_STATE", "0");//催交状态
                        PFRRdata.add("REPORT_STATE", "0");//报告状态
                        String LIMIT_DATE = "";
                        if(i == 1){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                        }
                        if(i == 2){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                        }
                        if(i == 3){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                        }
                        if(i == 4){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                        }
                        if(i == 5){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 48);
                        }
                        if(i == 6){
                            LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                        }
                        PFRRdata.add("LIMIT_DATE", LIMIT_DATE);//提交时限
                        PPhandler.savePfrFeedbackRecord(conn, PFRRdata);
                    }
                }
                
                
            }
            //修改档案的登记信息
            Data AIdata = new Data();
            AIdata.add("MI_ID", MIdata.getString("MI_ID"));//匹配信息ID
            AIdata.add("ADREG_STATE", MIdata.getString("ADREG_STATE"));//收养登记_登记状态
            AIdata.add("ADREG_DATE", MIdata.getString("ADREG_DATE"));//收养登记_登记日期
            handler.storeArchiveInfo(conn, AIdata);
            
            modArchiveInfo(conn, MIdata.getString("MI_ID"));//更新档案表的家庭文件和材料信息
            
            /*if("1".equals(ADREG_RESULT)){//登记成功，重新生成登记证和跨国收养合格证明
                GetWord getWord = new GetWord();
                String path2 = CommonConfig.getProjectPath() + "/tempFile/收养登记证.doc";
                
                //产生收养登记证
                getWord.createDoc(conn, MIdata.getString("MI_ID"),"sydjz.ftl","hx.word.data.impl.GetWordSydjzImpl",path2);
                File file2 = new File(path2);
                if(file2.exists()){
                    AttHelper.delAttsOfPackageId(MIdata.getString("MI_ID"), AttConstants.SYDJZ, "AF");//删除原附件
                    
                    AttHelper.manualUploadAtt(file2, "AF", MIdata.getString("MI_ID"), "收养登记证.doc", AttConstants.SYDJZ, "AF", AttConstants.SYDJZ, MIdata.getString("MI_ID"));
                    file2.delete();//删除原来生成的收养登记证
                }
                String IS_CONVENTION_ADOPT = getParameter("Ins_IS_CONVENTION_ADOPT");//公约收养
                if("1".equals(IS_CONVENTION_ADOPT)){//公约收养的生成跨国收养合格证明
                    String path3 = CommonConfig.getProjectPath() + "/tempFile/跨国收养合格证明.doc";
                    getWord.createDoc(conn, MIdata.getString("MI_ID"),"syhgzm.ftl","hx.word.data.impl.GetWordSyhgzmImpl",path3);
                    File file3 = new File(path3);
                    if(file3.exists()){
                        AttHelper.delAttsOfPackageId(MIdata.getString("MI_ID"), AttConstants.KGSYHGZM, "AF");//删除原附件
                        
                        AttHelper.manualUploadAtt(file3, "AF", MIdata.getString("MI_ID"), "跨国收养合格证明.doc", AttConstants.KGSYHGZM, "AF", AttConstants.KGSYHGZM, MIdata.getString("MI_ID"));
                        file3.delete();//删除原来生成的跨国收养合格证明
                    }
                }
            }*/
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "收养登记保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "收养登记保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "收养登记保存失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "收养登记保存失败!");
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
        if("1".equals(ADREG_RESULT)){
            return "ok";
        }else if("2".equals(ADREG_RESULT)){
            return "invalid";
        }else{
            return retValue;
        }
    }
    
    
    public void modArchiveInfo(Connection conn, String MI_ID) throws DBException{
        BGSNoticeHandler bgsNoticeHandler = new BGSNoticeHandler();
        Data data = bgsNoticeHandler.getArchiveId(conn, MI_ID);
        String archiveId = data.getString("ARCHIVE_ID");
        Data AIdata = bgsNoticeHandler.getArchiveSaveInfo(conn, MI_ID);
        AIdata.add("ARCHIVE_ID", archiveId);
        Mhandler.saveNcmArchiveInfo(conn, AIdata);
    }
    
    /**
     * 
     * @Title: adoptionRegInfoMod
     * @Description: 收养登记信息修改
     * @author: xugy
     * @date: 2014-9-23下午9:08:34
     * @return
     */
    public String adoptionRegInfoMod(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.getAdoptionRegInfo(conn, MI_ID);
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
     * @Title: saveAdoptionRegInfo
     * @Description: 收养登记信息修改保存
     * @author: xugy
     * @date: 2014-9-23下午9:45:35
     * @return
     */
    public String saveAdoptionRegInfo(){
        //收养登记信息
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADREG_DATE","ADREG_REMARKS");
        //儿童信息
        Data CIdata = getRequestEntityData("CI_","CI_ID","SEX","BIRTHDAY","CHILD_IDENTITY","ID_CARD","SENDER","SENDER_EN","SENDER_ADDR","NATION_DATE","CHILD_NAME_EN");
        //收养人信息
        Data AFdata = new Data();
        String FILE_TYPE = getParameter("Ins_FILE_TYPE");//文件类型
        String FAMILY_TYPE = getParameter("Ins_FAMILY_TYPE");//收养类型
        String ADOPTER_SEX = getParameter("Ins_ADOPTER_SEX","");//收养人性别
        if("33".equals(FILE_TYPE)){//继子女收养
            if("1".equals(ADOPTER_SEX)){//男收养人
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO");
            }
            if("2".equals(ADOPTER_SEX)){//女收养人
                AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO");
            }
        }else{
            if("1".equals(FAMILY_TYPE)){//双亲收养
                AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","FEMALE_NATION","MALE_PASSPORT_NO","FEMALE_PASSPORT_NO","MALE_EDUCATION","FEMALE_EDUCATION","MALE_JOB_CN","FEMALE_JOB_CN","MALE_JOB_CN","FEMALE_JOB_CN","MALE_HEALTH","FEMALE_HEALTH","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","ADDRESS");
            }
            if("2".equals(FAMILY_TYPE)){//单亲收养
                if("1".equals(ADOPTER_SEX)){//男收养人
                    AFdata = getRequestEntityData("AF_","AF_ID","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_CN","MALE_HEALTH","MARRY_CONDITION","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","ADDRESS");
                }
                if("2".equals(ADOPTER_SEX)){//女收养人
                    AFdata = getRequestEntityData("AF_","AF_ID","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_CN","FEMALE_HEALTH","MARRY_CONDITION","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_CN","ADDRESS");
                }
            }
        }
        
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            String ADREG_DATE = MIdata.getString("ADREG_DATE", "");
            if("".equals(ADREG_DATE)){
                MIdata.remove("ADREG_DATE");
            }else{
                String ADREG_STATE = getParameter("MI_ADREG_STATE");
                String MI_ID = MIdata.getString("MI_ID");//匹配信息ID
                Data FIdata = handler.getFeedbackInfo(conn, MI_ID);
                if("1".equals(ADREG_STATE)){
                    String SIGN_DATE = getParameter("MI_SIGN_DATE");//签批日期
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date signDate = sdf.parse(SIGN_DATE);
                    String d1 = "2014-12-31";
                    Date date1 = sdf.parse(d1);
                    String d2 = "2015-01-01";
                    Date date2 = sdf.parse(d2);
                    
                    String FEEDBACK_ID = FIdata.getString("FEEDBACK_ID");//安置后报告ID
                    Data PFRdata = new Data();
                    PFRdata.add("FEEDBACK_ID", FEEDBACK_ID);//安置后报告ID
                    if(signDate.before(date2)){//2015-01-01之前
                        for(int i=1;i<=6;i++){
                            String LIMIT_DATE = "";
                            if(i == 1){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 1);
                                PFRdata.add("NUM", "1");//次数
                            }
                            if(i == 2){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                                PFRdata.add("NUM", "2");//次数
                            }
                            if(i == 3){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                                PFRdata.add("NUM", "3");//次数
                            }
                            if(i == 4){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                                PFRdata.add("NUM", "4");//次数
                            }
                            if(i == 5){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                                PFRdata.add("NUM", "5");//次数
                            }
                            if(i == 6){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                                PFRdata.add("NUM", "6");//次数
                            }
                            PFRdata.add("LIMIT_DATE", LIMIT_DATE);//提交时限
                            handler.storeFeedbackRecord(conn, PFRdata);
                        }
                    }
                    if(date1.before(signDate)){//2014-12-31之后
                        for(int i=1;i<=6;i++){
                            String LIMIT_DATE = "";
                            if(i == 1){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 6);
                                PFRdata.add("NUM", "1");//次数
                            }
                            if(i == 2){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 12);
                                PFRdata.add("NUM", "2");//次数
                            }
                            if(i == 3){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 24);
                                PFRdata.add("NUM", "3");//次数
                            }
                            if(i == 4){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 36);
                                PFRdata.add("NUM", "4");//次数
                            }
                            if(i == 5){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 48);
                                PFRdata.add("NUM", "5");//次数
                            }
                            if(i == 6){
                                LIMIT_DATE = UtilDate.getEndDate(ADREG_DATE, 60);
                                PFRdata.add("NUM", "6");//次数
                            }
                            PFRdata.add("LIMIT_DATE", LIMIT_DATE);//提交时限
                            handler.storeFeedbackRecord(conn, PFRdata);
                        }
                    }
                }
                FIdata.add("ADREG_DATE", ADREG_DATE);
                PPhandler.savePfrFeedbackInfo(conn, FIdata);
                Data AIdata = new Data();
                AIdata.add("MI_ID", MIdata.getString("MI_ID"));
                AIdata.add("ADREG_DATE", ADREG_DATE);
                handler.storeArchiveInfo(conn, AIdata);
            }
            
            Mhandler.saveNcmMatchInfo(conn, MIdata);//收养登记信息保存
            AFhandler.modifyFileInfo(conn, AFdata);//收养人信息保存
            CIhandler.save(conn, CIdata);//儿童信息保存
            modArchiveInfo(conn, MIdata.getString("MI_ID"));//更新档案表的家庭文件和材料信息
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "收养登记信息保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "收养登记信息保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "收养登记信息保存失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (ParseException e) {
            e.printStackTrace();
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
     * @Title: adoptionRegInfoShow
     * @Description: 收养登记信息查看
     * @author: xugy
     * @date: 2014-9-23下午9:47:01
     * @return
     */
    public String adoptionRegInfoShow(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.getAdoptionRegInfo(conn, MI_ID);
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
     * @Title: adoptionRegisCancelList
     * @Description: 登记注销列表
     * @author: xugy
     * @date: 2014-11-2下午5:06:52
     * @return
     */
    public String adoptionRegisCancelList(){
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
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","WELFARE_NAME_CN","CHILD_TYPE","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","ADREG_NO","ADREG_INVALID_DATE_START","ADREG_INVALID_DATE_END","ADREG_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAdoptionRegisCancelList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toAdoptionRegisCancel
     * @Description: 注销登记
     * @author: xugy
     * @date: 2014-11-3下午6:24:54
     * @return
     */
    public String toAdoptionRegisCancel(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            
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
     * @Title: saveAdoptionRegisCancel
     * @Description: 登记注销保存
     * @author: xugy
     * @date: 2014-11-3下午8:34:21
     * @return
     */
    public String saveAdoptionRegisCancel(){
      //收养登记信息
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADREG_INVALID_REASON","ADREG_DEAL_TYPE","ADREG_REMARKS");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            MIdata.add("ADREG_STATE", "3");//收养登记_登记状态
            MIdata.add("ADREG_INVALID_DATE", DateUtility.getCurrentDate());//收养登记_注销日期
            Mhandler.saveNcmMatchInfo(conn, MIdata);//收养登记信息保存
            String ADREG_NO = getParameter("MI_ADREG_NO");
            Data farData = new Data();
            farData.add("FAR_SN", ADREG_NO);
            farData.add("IS_USED", "0");
            handler.storeFarSN(conn, farData);
            
            //文件全局状态和位置
            FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
            Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.ST_SYDJ_DJWX);
            MatchHandler MHandler = new MatchHandler();
            Data _MIdata = MHandler.getNcmMatchInfo(conn, MIdata.getString("MI_ID"));
            String AF_ID = _MIdata.getString("AF_ID");
            _data.add("AF_ID", AF_ID);
            FileCommonManager AFhandler = new FileCommonManager();
            AFhandler.modifyFileInfo(conn, _data);//修改收养人的匹配信息
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "登记注销成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "登记注销失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "登记注销失败!");
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
     * @Title: adoptionRegisCancelDetail
     * @Description: 注销查看
     * @author: xugy
     * @date: 2014-11-3下午9:00:57
     * @return
     */
    public String adoptionRegisCancelDetail(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            
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
     * @Title: FLYAdoptionRegisList
     * @Description: 福利院收养登记列表
     * @author: xugy
     * @date: 2014-11-8下午5:36:16
     * @return
     */
    public String FLYAdoptionRegisList(){
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
        String ADOPT_ORG_NAME = (String)getParameter("N_ADOPT_ORG_NAME");
        String WELFARE_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode(); //福利机构ID
        //WELFARE_ID="11010611";
        //3 获取搜索参数
        Data data = getRequestEntityData("N_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NAME","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","ADREG_NO");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findFLYAdoptionRegisList(conn,WELFARE_ID,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            setAttribute("ADOPT_ORG_NAME",ADOPT_ORG_NAME);
            
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
     * @Title: FLYAdoptionRegisDetail
     * @Description: 福利院收养登记查看
     * @author: xugy
     * @date: 2014-11-8下午5:43:56
     * @return
     */
    public String FLYAdoptionRegisDetail(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
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
     * @Title: SYZZAdoptionRegisList
     * @Description: 收养组织收养登记列表
     * @author: xugy
     * @date: 2014-11-8下午5:53:21
     * @return
     */
    public String SYZZAdoptionRegisList(){
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
        String ADOPT_ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode(); //收养组织CODE
        //3 获取搜索参数
        Data data = getRequestEntityData("N_","FILE_NO","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME_PINYIN","IS_CONVENTION_ADOPT","SIGN_DATE_START","SIGN_DATE_END","SIGN_NO","ADREG_DATE_START","ADREG_DATE_END","ADREG_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findSYZZAdoptionRegisList(conn,ADOPT_ORG_ID,data,pageSize,page,compositor,ordertype);
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
     * @Title: SYZZAdoptionRegisDetail
     * @Description: 收养组织收养登记查看
     * @author: xugy
     * @date: 2014-11-8下午6:01:07
     * @return
     */
    public String SYZZAdoptionRegisDetail(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
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
     * @Title: AZBAdoptionRegisList
     * @Description: 安置部收养登记列表
     * @author: xugy
     * @date: 2014-11-8下午6:08:25
     * @return
     */
    public String AZBAdoptionRegisList(){
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
        Data data = getRequestEntityData("N_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NAME","MALE_NAME","FEMALE_NAME","IS_CONVENTION_ADOPT","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END","ADREG_ALERT","ADREG_STATE","ADREG_NO","SIGN_NO");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAZBAdoptionRegisList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: AZBAdoptionRegisDetail
     * @Description: 安置部收养登记查看
     * @author: xugy
     * @date: 2014-11-8下午6:10:30
     * @return
     */
    public String AZBAdoptionRegisDetail(){
        String MI_ID = getParameter("ids");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
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

}
