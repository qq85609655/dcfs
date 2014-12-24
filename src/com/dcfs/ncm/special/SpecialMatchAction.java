package com.dcfs.ncm.special;

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
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchHandler;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.common.PublishCommonManagerHandler;
import com.hx.framework.authenticate.SessionInfo;

/**
 * 
 * @Title: SpecialMatchAction.java
 * @Description: 特需儿童匹配
 * @Company: 21softech
 * @Created on 2014-9-6 上午10:27:32
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class SpecialMatchAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(SpecialMatchAction.class);
    private Connection conn = null;
    private SpecialMatchHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public SpecialMatchAction() {
        this.handler=new SpecialMatchHandler();
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
     * @Title: AFSpecialMatchList
     * @Description: 收养文件特需匹配列表
     * @author: xugy
     * @date: 2014-9-6上午10:17:59
     * @return
     */
    public String AFSpecialMatchList(){
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
        String result = getParameter("result","");
        if("0".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(0, "匹配成功!");//保存成功 0
            setAttribute("clueTo", clueTo);//set操作结果提醒
        }
        if("2".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(2, "匹配失败或该数据已匹配，请重新匹配!");//保存失败 2
            setAttribute("clueTo", clueTo);//set操作结果提醒
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_NAME","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","MATCH_RECEIVEDATE_START","MATCH_RECEIVEDATE_END","FILE_TYPE","ADOPT_REQUEST_CN","UNDERAGE_NUM","MATCH_NUM","MATCH_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAFSpecialMatchList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Title: CISpecialMatchList
     * @Description: 选择特需儿童列表
     * @author: xugy
     * @date: 2014-9-6上午11:10:08
     * @return
     */
    public String CISpecialMatchList(){
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
        InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
        setAttribute("clueTo", clueTo);//set操作结果提醒
        String AFid = getParameter("AFid");//选择的收养人文件的ID
        
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","CHECKUP_DATE_START","CHECKUP_DATE_END","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END");//查询条件
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            Data AFdata=Mhandler.getAFInfoOfAfId(conn, AFid);//获取选择的收养人文件信息
            String nowYear = DateUtility.getCurrentYear();
            //男收养人年龄
            if(!"".equals(AFdata.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = AFdata.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                AFdata.add("MALE_AGE", maleAge);
            }
            //女收养人年龄
            if(!"".equals(AFdata.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = AFdata.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                AFdata.add("FEMALE_AGE", femaleAge);
            }
            data.addData(AFdata);
            //5 获取数据DataList
            DataList CIdl=handler.findCISpecialMatchList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("CIdl",CIdl);
            setAttribute("AFid",AFid);
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
     * @Title: specialMatchPreview
     * @Description: 
     * @author: xugy
     * @date: 2014-9-6下午12:03:19
     * @return
     */
    public String specialMatchPreview(){
        String CIid = getParameter("CIid");//匹配儿童ID
        String AFid = getParameter("AFid");//匹配收养人ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //查询收养人信息
            Data data = Mhandler.getAFInfoOfAfId(conn, AFid);
            
            //将结果集写入页面接收变量
            setAttribute("AFid",AFid);
            setAttribute("CIid",CIid);
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
     * @Title: saveSpecialMatchResult
     * @Description: 保存特需匹配结果
     * @author: xugy
     * @date: 2014-9-6下午2:00:06
     * @return
     */
    public String saveSpecialMatchResult(){
        String AFid = getParameter("AFid");//收养人文件ID
        String Ins_ADOPT_ORG_ID = getParameter("Ins_ADOPT_ORG_ID");//收养组织ID
        String CIid = getParameter("CIid");//儿童材料ID
        String CIids = CIid;
        String MATCH_SEASON = getParameter("Ins_MATCH_SEASON");//匹配原因
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data FUdata = Mhandler.selectMatchStateForUpdate(conn, AFid, CIid);
            String AF_MATCH_STATE = FUdata.getString("AF_MATCH_STATE", "");
            String CI_MATCH_STATE = FUdata.getString("CI_MATCH_STATE", "");
            if(!"1".equals(AF_MATCH_STATE) && !"1".equals(CI_MATCH_STATE)){
                //同胞儿童处理
                String TWINS_IDS = Mhandler.getCIInfoOfCiId(conn, CIid).getString("TWINS_IDS", "");
                if(!"".equals(TWINS_IDS)){
                    String[] childNoArry = TWINS_IDS.split(",");
                    for(int i=0;i<childNoArry.length;i++){
                        String childNo = childNoArry[i];
                        String CI_ID = Mhandler.getCiIdOfChildNo(conn, childNo);
                        CIids = CIids + "," + CI_ID;
                    }
                }
                String[] ciIdArry = CIids.split(",");
                
                for(int i=0;i<ciIdArry.length;i++){
                    Data data = new Data();
                    data.add("MI_ID", "");//匹配信息ID
                    data.add("ADOPT_ORG_ID", Ins_ADOPT_ORG_ID);//收养组织ID
                    data.add("AF_ID", AFid);//收养文件ID
                    data.add("CI_ID", ciIdArry[i]);//儿童材料ID
                    data.add("CHILD_TYPE", "2");//儿童类型
                    data.add("MATCH_SEASON", MATCH_SEASON);//匹配原因
                    data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//匹配人ID
                    data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//匹配人姓名
                    data.add("MATCH_DATE", DateUtility.getCurrentDate());//匹配日期
                    data.add("MATCH_STATE", "0");//匹配状态
                    //保存匹配结果
                    Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                    String MI_ID = MIdata.getString("MI_ID");//匹配信息ID
                    //插入一条匹配审核记录信息
                    Data MAdata = new Data();//匹配审核记录数据
                    MAdata.add("MAU_ID", "");//匹配审核记录ID
                    MAdata.add("MI_ID", MI_ID);//匹配信息ID
                    MAdata.add("AUDIT_LEVEL", "0");//审核级别：经办人审核
                    MAdata.add("OPERATION_STATE", "0");//操作状态：待处理
                    Mhandler.saveNcmMatchAudit(conn, MAdata);
                    
                    //查询儿童信息，以便获得匹配次数，修改儿童的匹配信息
                    Data CIdata = Mhandler.getCIInfoOfCiId(conn, ciIdArry[i]);
                    String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                    int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//儿童匹配次数加一
                    Data CIStateData = new Data();//儿童匹配数据
                    CIStateData.add("CI_ID", ciIdArry[i]);//儿童材料ID
                    CIStateData.add("MATCH_NUM", ci_num);//儿童材料匹配次数
                    CIStateData.add("MATCH_STATE", "1");//儿童材料匹配状态
                    //材料全局状态和位置
                    ChildCommonManager childCommonManager = new ChildCommonManager();
                    CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                    CIhandler.save(conn, CIStateData);
                }
                //查询收养人信息，以便获得匹配次数，修改收养人的匹配信息
                Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
                String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
                int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//收养人匹配次数加一
                Data AFStateData = new Data();//收养人匹配数据
                AFStateData.add("AF_ID", AFid);//收养人文件ID
                AFStateData.add("MATCH_NUM", af_num);//收养人匹配次数
                AFStateData.add("MATCH_STATE", "1");//收养人匹配状态
                AFStateData.add("CI_ID", CIid);//儿童材料ID
                
                if(ciIdArry.length>1){//如果匹配儿童多人，修改收养人文件的应缴金额和完费状态
                    int num = ciIdArry.length;
                    FileCommonManager fileCommonManager = new FileCommonManager();
                    int cost = fileCommonManager.getAfCost(conn, "TXWJFWF");
                    int AF_COST = cost * num;
                    if(AF_COST > AFdata.getInt("AF_COST")){
                        AFStateData.add("AF_COST", AF_COST);//收养人应缴金额
                        AFStateData.add("AF_COST_CLEAR", "0");//收养人完费状态
                    }
                    
                }
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_TXYW_PP_SUBMIT);
                AFStateData.addData(data);
                
                AFhandler.modifyFileInfo(conn, AFStateData);//修改文件信息
                String result = "0";
                setAttribute("result", result);
            }else{
                String result = "2";
                setAttribute("result", result);
            }
            dt.commit();
        }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "文件登记查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            //InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
            String result = "2";
            setAttribute("result", result);
            //retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            //InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            //setAttribute("clueTo", clueTo);
            String result = "2";
            setAttribute("result", result);
            //retValue = "error2";
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
        return SUCCESS;
    }
    
    /**
     * 特需匹配保存接口
     * @Title: saveMatchInfo
     * @Description: 保存匹配信息
     * @author: xugy
     * @date: 2014-9-22下午3:23:07
     * @param AFid 收养人文件ID
     * @return
     * @throws DBException 
     */
    public String saveMatchInfo(Connection conn, DataList AFidList) throws DBException{
        
        //获取收养人信息
        for(int i=0;i<AFidList.size();i++){
            Data AFStateData = new Data();//收养人匹配数据
            String AFid = AFidList.getData(i).getString("APP_ID");
            Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
            //判断文件的预批信息_预批记录ID是否有值
            String RI_ID = AFdata.getString("RI_ID", "");
            if(!"".equals(RI_ID)){//存在预批，则产生匹配信息
                String ADOPT_ORG_ID = AFdata.getString("ADOPT_ORG_ID");
                String CI_ID = AFdata.getString("CI_ID");
                String[] CIids = CI_ID.split(",");
                
                for(int j=0;j<CIids.length;j++){
                    Data data = new Data();
                    data.add("MI_ID", "");//匹配信息ID
                    data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);//收养组织ID
                    data.add("AF_ID", AFid);//收养文件ID
                    data.add("CI_ID", CIids[j]);//儿童材料ID
                    data.add("CHILD_TYPE", "2");//儿童类型
                    data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//匹配人ID
                    data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//匹配人姓名
                    data.add("MATCH_DATE", DateUtility.getCurrentDate());//匹配日期
                    data.add("MATCH_STATE", "0");//匹配状态
                    //保存匹配结果
                    Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                    String MI_ID = MIdata.getString("MI_ID");//匹配信息ID
                    //插入一条匹配审核记录信息
                    Data MAdata = new Data();//匹配审核记录数据
                    MAdata.add("MAU_ID", "");//匹配审核记录ID
                    MAdata.add("MI_ID", MI_ID);//匹配信息ID
                    MAdata.add("AUDIT_LEVEL", "0");//审核级别：经办人审核
                    MAdata.add("OPERATION_STATE", "0");//操作状态：待处理
                    Mhandler.saveNcmMatchAudit(conn, MAdata);
                    
                    //查询儿童信息，以便获得匹配次数，修改儿童的匹配信息
                    Data CIdata = Mhandler.getCIInfoOfCiId(conn, CIids[j]);
                    String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                    int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//儿童匹配次数加一
                    Data CIStateData = new Data();//儿童匹配数据
                    CIStateData.add("CI_ID", CIids[j]);//儿童材料ID
                    CIStateData.add("MATCH_NUM", ci_num);//儿童材料匹配次数
                    CIStateData.add("MATCH_STATE", "1");//儿童材料匹配状态
                    CIStateData.add("PUB_STATE", "4");//儿童材料发布状态
                    //材料全局状态和位置
                    ChildCommonManager childCommonManager = new ChildCommonManager();
                    CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                    CIhandler.save(conn, CIStateData);
                }
                //查询收养人信息，以便获得匹配次数，修改收养人的匹配信息
                String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
                int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//收养人匹配次数加一
                AFStateData.add("AF_ID", AFid);//收养人文件ID
                AFStateData.add("MATCH_NUM", af_num);//收养人匹配次数
                AFStateData.add("MATCH_STATE", "1");//收养人匹配状态
                AFStateData.add("MATCH_RECEIVEDATE", DateUtility.getCurrentDate());//档案部接收文件日期
                AFStateData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);//预批信息_预批状态
                
                //修改预批记录的预批状态
                String[] arry = RI_ID.split(",");
                for(int j=0;j<arry.length;j++){
                    Data RIStateData = new Data();//预批记录
                    RIStateData.add("RI_ID", arry[j]);//预批申请信息ID
                    RIStateData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);//预批状态
                    PublishCommonManagerHandler publishCommonManagerHandler = new PublishCommonManagerHandler();
                    publishCommonManagerHandler.saveRIData(conn, RIStateData);
                }
                
                if(CIids.length>1){//如果匹配儿童多人，修改收养人文件的应缴金额和完费状态
                    int num = CIids.length;
                    FileCommonManager fileCommonManager = new FileCommonManager();
                    int cost = fileCommonManager.getAfCost(conn, "TXWJFWF");
                    int AF_COST = cost * num;
                    if(AF_COST > AFdata.getInt("AF_COST")){
                        AFStateData.add("AF_COST", AF_COST);//收养人应缴金额
                        AFStateData.add("AF_COST_CLEAR", "0");//收养人完费状态
                    }
                }
                
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_TXYW_PP_SUBMIT);
                AFStateData.addData(data);
                
            }else{
                AFStateData.add("AF_ID", AFid);//收养人文件ID
                AFStateData.add("MATCH_STATE", "0");//收养人匹配状态
                AFStateData.add("MATCH_NUM", "0");//匹配信息_匹配次数
                AFStateData.add("MATCH_RECEIVEDATE", DateUtility.getCurrentDate());//档案部接收文件日期
            }
            AFhandler.modifyFileInfo(conn, AFStateData);//修改收养人的匹配信息
        }
        return retValue;
    }
    /**
     * 接口
     * @Title: saveMatchInfoForSYZZ
     * @Description: 收养组织提交预批产生匹配信息
     * @author: xugy
     * @date: 2014-11-17下午2:01:08
     * @param conn
     * @param AFidList
     * @return
     * @throws DBException
     */
    public String saveMatchInfoForSYZZ(Connection conn, DataList AFidList) throws DBException{
        //获取收养人信息
        for(int i=0;i<AFidList.size();i++){
            String AFid = AFidList.getData(i).getString("AF_ID");
            Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
            
            String ADOPT_ORG_ID = AFdata.getString("ADOPT_ORG_ID");
            String CI_ID = AFidList.getData(i).getString("CI_ID");
            String CIids = CI_ID;
            //同胞儿童处理
            String TWINS_IDS = Mhandler.getCIInfoOfCiId(conn, CI_ID).getString("TWINS_IDS", "");
            if(!"".equals(TWINS_IDS)){
                String[] childNoArry = TWINS_IDS.split(",");
                for(int k=0;k<childNoArry.length;k++){
                    String childNo = childNoArry[k];
                    String CIID = Mhandler.getCiIdOfChildNo(conn, childNo);
                    CIids = CIids + "," + CIID;
                }
            }
            String[] ciIdArry = CIids.split(",");
            
            for(int j=0;j<ciIdArry.length;j++){
                Data data = new Data();
                data.add("MI_ID", "");//匹配信息ID
                data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);//收养组织ID
                data.add("AF_ID", AFid);//收养文件ID
                data.add("CI_ID", ciIdArry[j]);//儿童材料ID
                data.add("CHILD_TYPE", "2");//儿童类型
                data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//匹配人ID
                data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//匹配人姓名
                data.add("MATCH_DATE", DateUtility.getCurrentDate());//匹配日期
                data.add("MATCH_STATE", "0");//匹配状态
                //保存匹配结果
                Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                String MI_ID = MIdata.getString("MI_ID");//匹配信息ID
                //插入一条匹配审核记录信息
                Data MAdata = new Data();//匹配审核记录数据
                MAdata.add("MAU_ID", "");//匹配审核记录ID
                MAdata.add("MI_ID", MI_ID);//匹配信息ID
                MAdata.add("AUDIT_LEVEL", "0");//审核级别：经办人审核
                MAdata.add("OPERATION_STATE", "0");//操作状态：待处理
                Mhandler.saveNcmMatchAudit(conn, MAdata);
                
                //查询儿童信息，以便获得匹配次数，修改儿童的匹配信息
                Data CIdata = Mhandler.getCIInfoOfCiId(conn, ciIdArry[j]);
                String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//儿童匹配次数加一
                Data CIStateData = new Data();//儿童匹配数据
                CIStateData.add("CI_ID", ciIdArry[j]);//儿童材料ID
                CIStateData.add("MATCH_NUM", ci_num);//儿童材料匹配次数
                CIStateData.add("MATCH_STATE", "1");//儿童材料匹配状态
                CIStateData.add("PUB_STATE", "4");//儿童材料发布状态
                //材料全局状态和位置
                ChildCommonManager childCommonManager = new ChildCommonManager();
                CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                CIhandler.save(conn, CIStateData);
            }
            //查询收养人信息，以便获得匹配次数，修改收养人的匹配信息
            Data AFStateData = new Data();//收养人匹配数据
            String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
            int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//收养人匹配次数加一
            AFStateData.add("AF_ID", AFid);//收养人文件ID
            AFStateData.add("MATCH_NUM", af_num);//收养人匹配次数
            AFStateData.add("MATCH_STATE", "1");//收养人匹配状态
            
            if(ciIdArry.length>1){//如果匹配儿童多人，修改收养人文件的应缴金额和完费状态
                int num = ciIdArry.length;
                FileCommonManager fileCommonManager = new FileCommonManager();
                int cost = fileCommonManager.getAfCost(conn, "TXWJFWF");
                int AF_COST = cost * num;
                if(AF_COST > AFdata.getInt("AF_COST")){
                    AFStateData.add("AF_COST", AF_COST);//收养人应缴金额
                    AFStateData.add("AF_COST_CLEAR", "0");//收养人完费状态
                }
            }
            //文件全局状态和位置
            FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
            Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_TXYW_PP_SUBMIT);
            AFStateData.addData(data);
            
            AFhandler.modifyFileInfo(conn, AFStateData);//修改收养人的匹配信息
        }
        return retValue;
        
    }

}
