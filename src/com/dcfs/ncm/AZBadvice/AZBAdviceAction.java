package com.dcfs.ncm.AZBadvice;

import hx.code.CodeList;
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
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.pause.PauseFileHandler;
import com.dcfs.ncm.MatchAction;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.audit.MatchAuditHandler;
import com.dcfs.rfm.insteadRecord.InsteadRecordHandler;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: AZBAdviceAction.java
 * @Description: 安置部征求意见
 * @Company: 21softech
 * @Created on 2014-9-11 上午9:49:21
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AZBAdviceAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AZBAdviceAction.class);
    private Connection conn = null;
    private AZBAdviceHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public AZBAdviceAction() {
        this.handler=new AZBAdviceHandler();
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
     * @Title: AZBAdviceList
     * @Description: 安置部征求意见列表
     * @author: xugy
     * @date: 2014-9-11上午10:40:58
     * @return
     */
    public String AZBAdviceList(){
        // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="MATCH_PASSDATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","FILE_NO","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","MATCH_PASSDATE_START","MATCH_PASSDATE_END","ADVICE_NOTICE_DATE_START","ADVICE_NOTICE_DATE_END","ADVICE_PRINT_NUM","ADVICE_STATE","ADVICE_REMINDER_STATE","AF_COST_CLEAR","ADVICE_FEEDBACK_RESULT");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAZBAdviceList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: toAZBPrintPreview
     * @Description: 通知书打印预览页面
     * @author: xugy
     * @date: 2014-11-11下午2:48:49
     * @return
     */
    public String toAZBPrintPreview(){
        String MI_IDs = getParameter("ids");
        String MI_ID = MI_IDs.split("#")[1];
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据
            Data data = handler.getAdviceSignDate(conn, MI_ID);
            List<Att> list = AttHelper.findAttListByPackageId(MI_ID, AttConstants.ZQYJS, "AF");
            String ID = list.get(0).getId();
            String ATT_NAME = list.get(0).getAttName();
            String ATT_TYPE = list.get(0).getAttType();
            data.add("ID", ID);
            data.add("ATT_NAME", ATT_NAME);
            data.add("ATT_TYPE", ATT_TYPE);
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
     * @Title: AZBprint
     * @Description: 安置部征求意见打印
     * @author: xugy
     * @date: 2014-9-11下午1:03:29
     * @return
     */
    public String AZBprint(){
        Data MIdata = getRequestEntityData("MI_","MI_ID","ADVICE_SIGN_DATE");
        /*String MI_ID = getParameter("MI_ID");
        String ADVICE_SIGN_DATE = getParameter("ADVICE_SIGN_DATE");*/
        String MI_ID = MIdata.getString("MI_ID");
        String ADVICE_SIGN_DATE = MIdata.getDate("ADVICE_SIGN_DATE");
        try{
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data data = handler.getAdviceSignDate(conn, MI_ID);
            if(!(data.getDate("ADVICE_SIGN_DATE")).equals(ADVICE_SIGN_DATE)){
                /*Data MIdata = new Data();
                MIdata.add("MI_ID", MI_ID);
                MIdata.add("ADVICE_SIGN_DATE", ADVICE_SIGN_DATE);*/
                Mhandler.saveNcmMatchInfo(conn, MIdata);
                //重新生成征求意见书
                MatchAction matchAction = new MatchAction();
                matchAction.letterOfSeekingConfirmation(conn, MI_ID, "1");//征求意见书
            }
            List<Att> list = AttHelper.findAttListByPackageId(MI_ID, AttConstants.ZQYJS, "AF");
            String ID = list.get(0).getId();
            String ATT_NAME = list.get(0).getAttName();
            String ATT_TYPE = list.get(0).getAttType();
            data.add("ID", ID);
            data.add("ATT_NAME", ATT_NAME);
            data.add("ATT_TYPE", ATT_TYPE);
            
            dt.commit();
            setAttribute("data",data);
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
     * @Title: AZBnotice
     * @Description: 安置部通知收养组织
     * @author: xugy
     * @date: 2014-9-11下午2:13:44
     * @return
     */
    public String AZBnotice(){
        String ids = getParameter("ids");//匹配信息ID
        String[] array = ids.split("#");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String MI_ID = array[i];
                String nowDate = DateUtility.getCurrentDate();
                String ADVICE_CLOSE_DATE = DateAddMonth(nowDate,3);//计算得到截止日期
                Data MIdata = new Data();//匹配信息数据
                MIdata.add("MI_ID", MI_ID);//匹配信息ID
                MIdata.add("ADVICE_NOTICE_DATE", nowDate);//征求意见_通知日期
                MIdata.add("ADVICE_CLOSE_DATE", ADVICE_CLOSE_DATE);//征求意见_截止日期
                MIdata.add("ADVICE_STATE", "2");//征求意见_状态
                MIdata.add("ADVICE_REMINDER_STATE", "0");//征求意见_催办状态
                MIdata.add("ADVICE_NOTICE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//征求意见_通知人ID
                MIdata.add("ADVICE_NOTICE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//征求意见_通知人姓名
                handler.matchSave(conn, MIdata);
                
                Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
                String AF_ID = data.getString("AF_ID");
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data AFdata = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_TZ);
                AFdata.add("AF_ID", AF_ID);
                AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "通知收养组织成功!");//保存成功 
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
            InfoClueTo clueTo = new InfoClueTo(2, "通知收养组织失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "通知收养组织失败!");
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
     * @Title: DateAddMonth
     * @Description: 获取当前日期的几个月后的日期
     * @author: xugy
     * @date: 2014-9-11下午2:20:44
     * @param nowDate
     * @param months
     * @return
     */
    public String DateAddMonth(String nowDate,int months){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        Date date;
        Calendar calendar = Calendar.getInstance();
        try {
            date = sdf.parse(nowDate);
            calendar.setTime(date);
            calendar.add(Calendar.MONTH, months);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return sdf.format(calendar.getTime());
    }
    /**
     * 
     * @Title: feedbackConfirm
     * @Description: 安置部反馈确认
     * @author: xugy
     * @date: 2014-9-12上午10:51:30
     * @return
     */
    public String feedbackConfirm(){
        String MI_ID = getParameter("ids");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据
            Data data = Mhandler.getNcmMatchInfo(conn, MI_ID);
            //获取收养国中央机关
            CodeList list = handler.findCountryGovment(conn, MI_ID);
            HashMap<String,CodeList> cmap=new HashMap<String,CodeList>();
            cmap.put("COUNTRY_GOVMENT_LIST", list);
            //将结果集写入页面接收变量
            setAttribute(Constants.CODE_LIST,cmap);
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
     * @Title: feedbackConfirmSave
     * @Description: 安置部反馈确认保存
     * @author: xugy
     * @date: 2014-9-12下午3:57:25
     * @return
     */
    public String feedbackConfirmSave(){
        String MI_ID = getParameter("Ins_MI_ID");//匹配信息ID
        
        Data data = getRequestEntityData("F_","ADVICE_GOV_ID","ADVICE_FEEDBACK_DATE","ADVICE_FEEDBACK_OPINION","ADVICE_FEEDBACK_RESULT","ADVICE_FEEDBACK_REMARKS");
        String ADVICE_FEEDBACK_RESULT = data.getString("ADVICE_FEEDBACK_RESULT");//反馈结果
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data MIdata = Mhandler.getNcmMatchInfo(conn, MI_ID);
            String CI_ID = MIdata.getString("CI_ID");//儿童材料ID
            String AF_ID = MIdata.getString("AF_ID");//文件ID
            Data AFdata = new Data();//文件数据
            AFdata.add("AF_ID", AF_ID);
            Data CIdata = new Data();//材料数据
            CIdata.add("CI_ID", CI_ID);
            data.add("ADVICE_STATE", "3");//征求意见_状态
            data.add("ADVICE_REMINDER_STATE", "");//征求意见_催办状态
            data.add("ADVICE_CFM_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//征求意见_确认人ID
            data.add("ADVICE_CFM_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//征求意见_确认人姓名
            data.add("ADVICE_CFM_DATE", DateUtility.getCurrentDate());//征求意见_确认人日期
            if("1".equals(ADVICE_FEEDBACK_RESULT)){//如果同意，移交儿童材料至档案部
                DataList transferList = new DataList();
                Data transferData = new Data();
                transferData.add("TID_ID", "");//交接明细ID
                transferData.add("APP_ID", CI_ID);//业务记录ID
                transferData.add("TRANSFER_CODE", TransferCode.CHILDINFO_AZB_DAB);//移交类型
                transferData.add("TRANSFER_STATE", "0");//移交状态
                transferList.add(transferData);
                FileCommonManager FC = new FileCommonManager();
                FC.transferDetailInit(conn, transferList);//插入一条移交信息
                
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_AGREE);
                AFdata.addData(_data);
                
                //材料全局状态和位置
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.adviceFeedBackAgree(CIdata, SessionInfo.getCurUser().getCurOrgan());
                
                data.add("MI_ID", MI_ID);//匹配信息ID
                handler.matchSave(conn, data);//保存匹配数据
                CIhandler.save(conn, CIdata);
                AFhandler.modifyFileInfo(conn, AFdata);//修改收养人的匹配信息
            }
            Data AFdataInfo = Mhandler.getAFInfoOfAfId(conn, AF_ID);
            String RI_ID = AFdataInfo.getString("RI_ID", "");//
            String FILE_TYPE = AFdataInfo.getString("FILE_TYPE", "");//文件类型
            if("2".equals(ADVICE_FEEDBACK_RESULT)){//如果文件暂停
                data.add("AF_ID", AF_ID);
                data.add("MATCH_STATE", "9");//匹配状态：无效
                data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//解除匹配日期
                data.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//解除匹配人ID
                data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//解除匹配人姓名
                data.add("REVOKE_MATCH_TYPE", "3");//解除匹配类型：重新匹配
                data.add("REVOKE_MATCH_REASON", "收养组织反馈结果文件暂停");//解除匹配原因
                //修改材料匹配状态
                String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//收养的儿童材料ID
                String inCI_ID = "";
                if(!"".equals(AF_CI_ID)){
                    String[] array = AF_CI_ID.split(",");
                    for(int i=0;i<array.length;i++){
                        Data everyCIdata = new Data();
                        everyCIdata.add("CI_ID", array[i]);//材料ID
                        everyCIdata.add("MATCH_STATE", "0");//材料匹配状态
                        CIhandler.save(conn, everyCIdata);
                        if(i==0){
                            inCI_ID = "'"+array[i]+"'";
                        }else{
                            inCI_ID = inCI_ID+",'"+array[i]+"'";                        
                        }
                    }
                }
                if("".equals(RI_ID)){//没有预批
                    AFdata.add("CI_ID", "");//文件儿童材料ID
                }else{//存在预批
                    DataList MCIdl = handler.getMainCIIDS(conn, inCI_ID);
                    if(MCIdl.size()>0){
                        for(int i=0;i<MCIdl.size();i++){
                            String MAIN_CI_ID = MCIdl.getData(i).getString("MAIN_CI_ID", "");
                            PublishCommonManager publishCommonManager = new PublishCommonManager();
                            publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                        }
                    }
                }
                //修改文件匹配状态
                AFdata.add("MATCH_STATE", "0");//文件匹配状态
                if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                    AFdata.add("FILE_TYPE", "10");
                }
                //文件暂停信息
                String PAUSE_REASON = getParameter("R_PAUSE_REASON");//暂停原因
                String END_DATE = getParameter("R_END_DATE");//暂停期限
                AFdata.add("IS_PAUSE", "1");//暂停标识
                AFdata.add("PAUSE_DATE", DateUtility.getCurrentDate());//暂停日期
                AFdata.add("PAUSE_REASON", PAUSE_REASON);//暂停原因
                //文件暂停记录
                Data PFdata = new Data();//文件暂停数据
                PFdata.add("AP_ID", "");//文件暂停记录ID
                PFdata.add("AF_ID", AF_ID);//文件ID
                PFdata.add("PAUSE_REASON", PAUSE_REASON);//暂停原因
                PFdata.add("PAUSE_DATE", DateUtility.getCurrentDate());//暂停日期
                PFdata.add("END_DATE", END_DATE);//暂停期限
                PFdata.add("PAUSE_UNITID", SessionInfo.getCurUser().getCurOrgan().getId());//暂停部门ID
                PFdata.add("PAUSE_UNITNAME", SessionInfo.getCurUser().getCurOrgan().getCName());//暂停部门名称
                PFdata.add("PAUSE_USERID", SessionInfo.getCurUser().getPersonId());//暂停人ID
                PFdata.add("PAUSE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//暂停人姓名
                PFdata.add("RECOVERY_STATE", "1");//暂停状态
                PauseFileHandler pauseFileHandler = new PauseFileHandler();
                pauseFileHandler.pauseFileSave(conn, AFdata, PFdata);
                
                Mhandler.storeNcmMatchInfoOne(conn, data);
            }
            if("3".equals(ADVICE_FEEDBACK_RESULT)){//如果重新匹配
                data.add("AF_ID", AF_ID);
                data.add("MATCH_STATE", "9");//匹配状态：无效
                data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//解除匹配日期
                data.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//解除匹配人ID
                data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//解除匹配人姓名
                data.add("REVOKE_MATCH_TYPE", "3");//解除匹配类型：重新匹配
                data.add("REVOKE_MATCH_REASON", "收养组织反馈结果重新匹配");//解除匹配原因
                if("".equals(RI_ID)){//没有预批信息即通过手动匹配,如儿童多人则一定是同胞兄弟
                    Mhandler.storeNcmMatchInfoOne(conn, data);
                    /****儿童与收养家庭解除匹配关系，修改文件和材料相关状态Begin****/
                    String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//文件匹配儿童的ID（多个为同胞）
                    if(!"".equals(AF_CI_ID)){
                        String[] array = AF_CI_ID.split(",");
                        for(int i=0;i<array.length;i++){
                            //修改材料匹配状态
                            Data everyCIdata = new Data();//材料数据
                            everyCIdata.add("CI_ID", array[i]);//材料ID
                            everyCIdata.add("MATCH_STATE", "0");//材料匹配状态
                            CIhandler.save(conn, everyCIdata);
                        }
                    }
                    //修改文件匹配状态
                    AFdata.add("MATCH_STATE", "0");//文件匹配状态
                    AFdata.add("CI_ID", "");//文件儿童材料ID置空
                    if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                        AFdata.add("FILE_TYPE", "10");
                    }
                    //文件全局状态和位置
                    FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                    Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP);
                    AFdata.addData(_data);
                    AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                    /****儿童与收养家庭解除匹配关系，修改文件和材料相关状态End****/
                }else{//存在预批信息,
                    Data CIdataInfo = Mhandler.getCIInfoOfCiId(conn, CI_ID);
                    String MAIN_CI_ID = CIdataInfo.getString("MAIN_CI_ID","");//儿童的主儿童ID
                    MatchAuditHandler matchAuditHandler = new MatchAuditHandler();
                    DataList CIdl = matchAuditHandler.getCIInfoOfMainCiId(conn, MAIN_CI_ID);
                    if(CIdl.size()>0){
                        for(int i=0;i<CIdl.size();i++){
                            String everyCiId = CIdl.getData(i).getString("CI_ID", "");
                            data.add("CI_ID", everyCiId);
                            Mhandler.storeNcmMatchInfoTwo(conn, data);//通过文件ID材料ID修改匹配信息
                            
                            //修改材料匹配状态
                            Data everyCIdata = new Data();//材料数据
                            everyCIdata.add("CI_ID", everyCiId);//材料ID
                            everyCIdata.add("MATCH_STATE", "0");//材料匹配状态
                            CIhandler.save(conn, everyCIdata);
                        }
                    }
                    PublishCommonManager publishCommonManager = new PublishCommonManager();
                    publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                    
                    if(!"23".equals(FILE_TYPE)){//文件类型不为“特双”的，有一个预批
                        //修改文件匹配状态
                        AFdata.add("MATCH_STATE", "0");//文件匹配状态
                        if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                            AFdata.add("FILE_TYPE", "10");
                        }
                        //文件全局状态和位置
                        FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                        Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP);
                        AFdata.addData(_data);
                        AFhandler.modifyFileInfo(conn, AFdata);//修改文件信息
                    }
                }
            }
            if("4".equals(ADVICE_FEEDBACK_RESULT)){//如果退文，添加退文信息
                data.add("AF_ID", AF_ID);
                data.add("MATCH_STATE", "9");//匹配状态：无效
                data.add("REVOKE_MATCH_DATE", DateUtility.getCurrentDate());//解除匹配日期
                data.add("REVOKE_MATCH_USERID", SessionInfo.getCurUser().getPersonId());//解除匹配人ID
                data.add("REVOKE_MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//解除匹配人姓名
                data.add("REVOKE_MATCH_TYPE", "1");//解除匹配类型：退文
                data.add("REVOKE_MATCH_REASON", "收养组织反馈结果退文");//解除匹配原因
                //修改材料匹配状态
                String AF_CI_ID = AFdataInfo.getString("CI_ID", "");//收养的儿童材料ID
                String inCI_ID = "";
                if(!"".equals(AF_CI_ID)){
                    String[] array = AF_CI_ID.split(",");
                    for(int i=0;i<array.length;i++){
                        Data everyCIdata = new Data();
                        everyCIdata.add("CI_ID", array[i]);//材料ID
                        everyCIdata.add("MATCH_STATE", "0");//材料匹配状态
                        CIhandler.save(conn, everyCIdata);
                        if(i==0){
                            inCI_ID = "'"+array[i]+"'";
                        }else{
                            inCI_ID = inCI_ID+",'"+array[i]+"'";                        
                        }
                    }
                }
                if("".equals(RI_ID)){//没有预批
                    AFdata.add("CI_ID", "");//文件儿童材料ID
                }else{//存在预批
                    DataList MCIdl = handler.getMainCIIDS(conn, inCI_ID);
                    if(MCIdl.size()>0){
                        for(int i=0;i<MCIdl.size();i++){
                            String MAIN_CI_ID = MCIdl.getData(i).getString("MAIN_CI_ID", "");
                            PublishCommonManager publishCommonManager = new PublishCommonManager();
                            publishCommonManager.Removeprebatch(conn,  MAIN_CI_ID);
                        }
                    }
                }
                //修改文件匹配状态
                AFdata.add("MATCH_STATE", "0");//文件匹配状态
                if("21".equals(FILE_TYPE)){//如果文件为特转，改为正常文件
                    AFdata.add("FILE_TYPE", "10");
                }
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_TW);
                AFdata.addData(_data);
                
                String RETURN_STATE = AFdataInfo.getString("RETURN_STATE", "");//退文状态
                String RETURN_REASON = getParameter("R_RETURN_REASON");//退文原因
                if("".equals(RETURN_STATE)){//没有退文
                    AFdata.add("RETURN_STATE", "0");//文件退文状态：待确认
                    AFdata.add("RETURN_REASON", RETURN_REASON);//文件退文原因
                    if("".equals(RETURN_STATE)){//没有退文
                        AFdata.add("RETURN_STATE", "0");//文件退文状态：待确认
                        AFdata.add("RETURN_REASON", RETURN_REASON);//文件退文原因
                        //获取文件需要存入退文记录表中信息
                        AZBAdviceHandler AZBAH = new AZBAdviceHandler();
                        Data RFMdata = AZBAH.getRFMAFInfo(conn, AFdata.getString("AF_ID"));
                        RFMdata.add("AR_ID", "");//退文记录ID
                        RFMdata.add("RETURN_REASON", RETURN_REASON);//退文原因
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
                
                Mhandler.storeNcmMatchInfoOne(conn, data);
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "反馈确认保存成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "反馈确认保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "反馈确认保存失败!");
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
     * @Title: feedbackDetail
     * @Description: 报告查看
     * @author: xugy
     * @date: 2014-11-2上午11:13:30
     * @return
     */
    public String feedbackDetail(){
        String MI_ID = getParameter("ids");
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
     * @Title: reminderDetail
     * @Description: 安置部查看催办查看
     * @author: xugy
     * @date: 2014-9-14下午3:27:26
     * @return
     */
    public String reminderDetail(){
        String MI_ID = getParameter("MI_ID");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据
            Data data = handler.getMatchReminderInfo(conn, MI_ID);
            
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
     * 历史数据生成征求意见书、来华领养通知书、送养通知书
     * @Title: createPDF
     * @Description: 
     * @author: xugy
     * @date: 2014-12-21上午11:13:43
     * @return
     */
    public String createPDF(){
        MatchAction matchAction = new MatchAction();
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            DataList dl = handler.getMatchInfo(conn);
            if(dl.size()>0){
                for(int i=0;i<dl.size();i++){
                    String MI_ID = dl.getData(i).getString("MI_ID");
                    System.out.println(MI_ID);
                    String MATCH_STATE = dl.getData(i).getString("MATCH_STATE");
                    String SIGN_STATE = dl.getData(i).getString("SIGN_STATE");
                    String NOTICE_STATE = dl.getData(i).getString("NOTICE_STATE");
                    if("3".equals(MATCH_STATE)){
                        matchAction.letterOfSeekingConfirmation(conn, MI_ID, "0");
                        matchAction.letterOfSeekingConfirmation(conn, MI_ID, "1");
                        if("1".equals(SIGN_STATE)){
                            matchAction.noticeOfTravellingToChinaForAdoption(conn, MI_ID, "0", "1");
                            matchAction.noticeForAdoption(conn, MI_ID, "0");
                            if("1".equals(NOTICE_STATE)){
                                matchAction.noticeOfTravellingToChinaForAdoption(conn, MI_ID, "1", "0");
                                matchAction.noticeForAdoption(conn, MI_ID, "1");
                            }
                        }
                    }
                }
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "生成PDF成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "生成PDF失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "生成PDF失败!");
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
            InfoClueTo clueTo = new InfoClueTo(2, "生成PDF失败!");
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
        return null;
    }
}
