package com.dcfs.ncm.BGSnotice;

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

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchAction;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.ncm.DABnotice.common.CreateArchiveNoAction;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;

/**
 * 
 * @Title: BGSNoticeAction.java
 * @Description: 办公室通知书办理--打印寄发
 * @Company: 21softech
 * @Created on 2014-9-15 下午4:49:13
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class BGSNoticeAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(BGSNoticeAction.class);
    private Connection conn = null;
    private BGSNoticeHandler handler;
    private MatchHandler Mhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public BGSNoticeAction() {
        this.handler=new BGSNoticeHandler();
        this.Mhandler=new MatchHandler();
    }

    @Override
    public String execute() throws Exception {
        return null;
    }
    /**
     * 
     * @Title: BGSNoticePrintList
     * @Description: 办公室通知书办理打印寄发列表
     * @author: xugy
     * @date: 2014-9-15下午4:54:23
     * @return
     */
    public String BGSNoticePrintList(){
        // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="SIGN_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_TYPE","CHILD_TYPE","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SIGN_SUBMIT_DATE_START","SIGN_SUBMIT_DATE_END","SIGN_DATE_START","SIGN_DATE_END","NOTICE_SIGN_DATE_START","NOTICE_SIGN_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","NOTICE_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findBGSNoticePrintList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: BGSNoticePrintMod
     * @Description: 修改打印
     * @author: xugy
     * @date: 2014-9-16下午2:52:53
     * @return
     */
    public String BGSNoticePrintMod(){
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
     * @Title: saveAndPrint
     * @Description: 打印修改保存并打印
     * @author: xugy
     * @date: 2014-9-25下午5:36:16
     * @return
     */
    public String saveAndPrint(){
        
        Data data = getRequestEntityData("MI_","MI_ID","NOTICE_SIGN_DATE");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data AIdata = handler.getArchiveId(conn, data.getString("MI_ID"));
            if(!"".equals(AIdata.getString("ARCHIVE_ID", ""))){//档案ID不为空，存在档案信息，则通知档案部重新打印
                data.add("NOTICECOPY_REPRINT", "1");//通知书副本_是否重打
            }
            data.add("NOTICECOPY_SIGN_DATE", data.getString("NOTICE_SIGN_DATE"));//通知书副本_最后落款日期
            Mhandler.saveNcmMatchInfo(conn, data);
            
            //重新生成附件
            MatchAction matchAction = new MatchAction();
            matchAction.noticeOfTravellingToChinaForAdoption(conn, data.getString("MI_ID"), "0", "1");//来华收养子女通知书
            matchAction.noticeForAdoption(conn, data.getString("MI_ID"), "0");//涉外收养通知
            if(!"".equals(AIdata.getString("ARCHIVE_ID", ""))){//档案ID不为空，存在档案信息，则修改通知书副本
                matchAction.noticeOfTravellingToChinaForAdoption(conn, data.getString("MI_ID"), "1", "0");//来华收养子女通知书
                matchAction.noticeForAdoption(conn, data.getString("MI_ID"), "1");//涉外收养通知
            }
            ArrayList<Att> arraylist = new ArrayList<Att>();
            List<Att> list1 = AttHelper.findAttListByPackageId(data.getString("MI_ID"), AttConstants.LHSYZNTZS, "AF");
            arraylist.addAll(list1);
            List<Att> list2 = AttHelper.findAttListByPackageId(data.getString("MI_ID"), AttConstants.SWSYTZ, "AF");
            arraylist.addAll(list2);
            
            dt.commit();
            setAttribute("list", arraylist);
            setAttribute("MI_ID", data.getString("MI_ID"));
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
            // TODO Auto-generated catch block
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
     * @Title: toPrint
     * @Description: 列表页面打印按钮
     * @author: xugy
     * @date: 2014-11-13下午1:49:58
     * @return
     */
    public String toPrint(){
        String type = getParameter("type");
        String MI_ID = getParameter("ids","");//匹配信息ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            DataList MIIDdl = new DataList();
            if("".equals(MI_ID)){
                if("0".equals(type)){
                    MIIDdl = handler.getPrintInfoId(conn, "af.ADOPT_ORG_ID ASC");
                }
                if("1".equals(type)){
                    MIIDdl = handler.getPrintInfoId(conn, "ci.PROVINCE_ID ASC");
                }
            }else{
                String ids = "";
                String[] arry = MI_ID.split("#");
                for(int i=1;i<arry.length;i++){
                    if(i == 1){
                        ids = "'"+arry[i]+"'";
                    }else{
                        ids = ids+",'"+arry[i]+"'";
                    }
                }
                if("0".equals(type)){
                    MIIDdl = handler.getIdInId(conn, ids, "af.ADOPT_ORG_ID ASC");
                }
                if("1".equals(type)){
                    MIIDdl = handler.getIdInId(conn, ids, "ci.PROVINCE_ID ASC");
                }
            }
            ArrayList<Att> arraylist = new ArrayList<Att>();
            String ids = "";
            if(MIIDdl.size()>0){
                for(int i=0;i<MIIDdl.size();i++){
                    String packageId = MIIDdl.getData(i).getString("MI_ID");
                    List<Att> list = new ArrayList<Att>();
                    if("0".equals(type)){
                        list = AttHelper.findAttListByPackageId(packageId, AttConstants.LHSYZNTZS, "AF");
                    }
                    if("1".equals(type)){
                        list = AttHelper.findAttListByPackageId(packageId, AttConstants.SWSYTZ, "AF");
                    }
                    if(list != null){
                        arraylist.addAll(list);
                    }
                    if(i == 0){
                        ids = packageId;
                    }else{
                        ids = ids + "," + packageId;
                    }
                    
                }
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
     * @Title: BGSNoticeSend
     * @Description: 办公室寄发通知书
     * @author: xugy
     * @date: 2014-9-16下午3:36:50
     * @return
     */
    public String BGSNoticeSend(){
        String ids = getParameter("ids");//匹配信息ID
        String[] array = ids.split("#");
        
        String NOTICE_DATE = getParameter("NOTICE_DATE");//寄发日期
        
        
        /*GetWord getWord = new GetWord();
        String path1 = CommonConfig.getProjectPath() + "/tempFile/收养登记申请书.doc";
        String path2 = CommonConfig.getProjectPath() + "/tempFile/收养登记证.doc";
        String path3 = CommonConfig.getProjectPath() + "/tempFile/跨国收养合格证明.doc";*/
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=1;i<array.length;i++){
                String MI_ID = array[i];
                Data MIdata = new Data();//匹配信息数据
                MIdata.add("MI_ID", MI_ID);//匹配信息ID
                MIdata.add("NOTICE_DATE", NOTICE_DATE);//通知书_寄发日期
                MIdata.add("NOTICE_STATE", "1");//通知书_通知状态
                MIdata.add("NOTICE_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//通知书_通知人ID
                MIdata.add("NOTICE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//通知书_通知人姓名
                MIdata.add("NOTICECOPY_PRINT_NUM", "0");//通知书副本打印次数
                MIdata.add("NOTICECOPY_REPRINT", "0");//通知书副本是否重打：否
                MIdata.add("ADREG_STATE", "0");//收养登记_登记状态
                Mhandler.saveNcmMatchInfo(conn, MIdata);
                
                MatchHandler MHandler = new MatchHandler();
                Data _MIdata = MHandler.getNcmMatchInfo(conn, MI_ID);
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data _data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.BGS_TZS_JF);
                String AF_ID = _MIdata.getString("AF_ID");
                _data.add("AF_ID", AF_ID);
                FileCommonManager AFhandler = new FileCommonManager();
                AFhandler.modifyFileInfo(conn, _data);//修改收养人的匹配信息
                
                //材料全局状态和位置
                Data CIdata = new Data();
                String CI_ID = _MIdata.getString("CI_ID");
                CIdata.add("CI_ID", CI_ID);
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIdata = childCommonManager.noticeIsSent(CIdata, SessionInfo.getCurUser().getCurOrgan());
                ChildManagerHandler childManagerHandler = new ChildManagerHandler();
                childManagerHandler.save(conn, CIdata);
                //生成附件要判断的信息
                //Data attData = handler.getAttInfo(conn, MI_ID);
                //产生收养登记申请书
                /*getWord.createDoc(conn, MI_ID,"sydjsqs.ftl","hx.word.data.impl.GetWordSydjsqsImpl",path1);
                File file1 = new File(path1);
                if(file1.exists()){
                    AttHelper.delAttsOfPackageId(MI_ID, AttConstants.SYDJSQS, "AF");//删除原附件
                    
                    AttHelper.manualUploadAtt(file1, "AF", MI_ID, "收养登记申请书.doc", AttConstants.SYDJSQS, "AF", AttConstants.SYDJSQS, MI_ID);
                    file1.delete();//删除原来生成的收养登记申请书
                }
                //产生收养登记证
                getWord.createDoc(conn, MI_ID,"sydjz.ftl","hx.word.data.impl.GetWordSydjzImpl",path2);
                File file2 = new File(path2);
                if(file2.exists()){
                    AttHelper.delAttsOfPackageId(MI_ID, AttConstants.SYDJZ, "AF");//删除原附件
                    
                    AttHelper.manualUploadAtt(file2, "AF", MI_ID, "收养登记证.doc", AttConstants.SYDJZ, "AF", AttConstants.SYDJZ, MI_ID);
                    file2.delete();//删除原来生成的收养登记证
                }
                String IS_CONVENTION_ADOPT = attData.getString("IS_CONVENTION_ADOPT", "");//公约收养
                if("1".equals(IS_CONVENTION_ADOPT)){//公约收养的生成跨国收养合格证明
                    getWord.createDoc(conn, MI_ID,"syhgzm.ftl","hx.word.data.impl.GetWordSyhgzmImpl",path3);
                    File file3 = new File(path3);
                    if(file3.exists()){
                        AttHelper.delAttsOfPackageId(MI_ID, AttConstants.KGSYHGZM, "AF");//删除原附件
                        
                        AttHelper.manualUploadAtt(file3, "AF", MI_ID, "跨国收养合格证明.doc", AttConstants.KGSYHGZM, "AF", AttConstants.KGSYHGZM, MI_ID);
                        file3.delete();//删除原来生成的跨国收养合格证明
                    }
                }*/
                
                Data data = handler.getArchiveSaveInfo(conn, MI_ID);
                CreateArchiveNoAction CAN = new CreateArchiveNoAction();
                String ARCHIVE_NO = CAN.createArchiveNo(conn);
                data.add("ARCHIVE_ID", "");//档案信息ID
                data.add("ARCHIVE_NO", ARCHIVE_NO);//档案号
                data.add("ARCHIVE_NO_DATE", DateUtility.getCurrentDate());//档案号生成日期
                data.add("ARCHIVE_STATE", "0");//归档状态:未归档
                data.add("ARCHIVE_VALID", "1");//是否有效:是
                Mhandler.saveNcmArchiveInfo(conn, data);
                
                MatchAction matchAction = new MatchAction();
                //来华收养子女通知书副本
                matchAction.noticeOfTravellingToChinaForAdoption(conn, MI_ID, "1", "0");
                //涉外收养通知副本
                matchAction.noticeForAdoption(conn, MI_ID, "1");
                
            }
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "通知书寄发成功!");//保存成功 0
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
            InfoClueTo clueTo = new InfoClueTo(2, "通知书寄发失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "通知书寄发失败!");
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
            InfoClueTo clueTo = new InfoClueTo(2, "通知书寄发失败!");
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
    
}
