package com.dcfs.ncm.audit;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

import com.dcfs.ncm.MatchHandler;


/**
 * 
 * @Title: MatchAuditHandler.java
 * @Description: 匹配审核
 * @Company: 21softech
 * @Created on 2014-9-6 下午3:38:44
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MatchAuditHandler extends BaseHandler {
    
    private MatchHandler Mhandler;
    public MatchAuditHandler() {
        this.Mhandler=new MatchHandler();
    }
    
    /**
     * 
     * @Title: findMatchAuditList
     * @Description: 匹配审核列表
     * @author: xugy
     * @date: 2014-9-6下午5:01:24
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMatchAuditList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //开始收文日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //结束收文日期
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //文件类型
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //匹配次数
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String OPERATION_STATE = data.getString("OPERATION_STATE", null);   //操作状态
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //匹配状态
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='0'";
        }else if("99".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE IN ('0','1','3','4','9')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
        }
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findMatchAuditList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, MATCH_NUM, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, OPERATION_STATE, MATCH_STATE,compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getMatchAudit
     * @Description: 审核信息
     * @author: xugy
     * @date: 2014-9-9下午4:31:39
     * @param conn
     * @param MAU_ID
     * @return
     * @throws DBException 
     */
    public Data getMatchAudit(Connection conn, String AUDIT_LEVEL, String MAU_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchAudit", AUDIT_LEVEL, MAU_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getJBRAuditInfo
     * @Description: 经办人审核信息
     * @author: xugy
     * @date: 2014-9-10下午3:41:59
     * @param conn
     * @param MIid
     * @return
     * @throws DBException
     */
    public Data getJBRAuditInfo(Connection conn, String MIid) throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getJBRAuditInfo", MIid);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getBMZRAuditInfo
     * @Description: 部门主任审核信息
     * @author: xugy
     * @date: 2014-9-10下午3:43:24
     * @param conn
     * @param MIid
     * @return
     * @throws DBException
     */
    public Data getBMZRAuditInfo(Connection conn, String MIid) throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getBMZRAuditInfo", MIid);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    
    /**
     * 
     * @Title: getMatchAuditOnly
     * @Description: 
     * @author: xugy
     * @date: 2014-12-21下午9:28:52
     * @param conn
     * @param AUDIT_LEVEL
     * @param MAU_ID
     * @return
     * @throws DBException
     */
    public Data getMatchAuditOnly(Connection conn, String AUDIT_LEVEL, String MAU_ID) throws DBException{
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchAuditOnly", AUDIT_LEVEL, MAU_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getAllAFMatchInfo
     * @Description: 收养人历次匹配信息
     * @author: xugy
     * @date: 2014-9-10下午2:19:50
     * @param conn
     * @param AF_ID
     * @return
     * @throws DBException 
     */
    public DataList getAllAFMatchInfo(Connection conn, String AF_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAllAFMatchInfo", AF_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            for(int i=0;i<dl.size();i++){
                String CIid = dl.getData(i).getString("CI_ID");//儿童ID
                Data CIdata = Mhandler.getCIInfoOfCiId(conn, CIid);//儿童信息
                dl.getData(i).addData(CIdata);
                //经办人审核信息
                String MIid = dl.getData(i).getString("MI_ID");//匹配信息ID
                Data JBRdata = getJBRAuditInfo(conn, MIid);
                dl.getData(i).addData(JBRdata);
                //部门主任审核信息
                Data BMZRdata = getBMZRAuditInfo(conn, MIid);
                dl.getData(i).addData(BMZRdata);
            }
        }
        return dl;
    }
    /**
     * 
     * @Title: getAllCIMatchInfo
     * @Description: 儿童历次匹配信息
     * @author: xugy
     * @date: 2014-9-10下午3:50:46
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException 
     */
    public DataList getAllCIMatchInfo(Connection conn, String CI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAllCIMatchInfo", CI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            for(int i=0;i<dl.size();i++){
                String AFid = dl.getData(i).getString("AF_ID");//收养人ID
                Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);//收养人信息
                dl.getData(i).addData(AFdata);
                //经办人审核信息
                String MIid = dl.getData(i).getString("MI_ID");//匹配信息ID
                Data JBRdata = getJBRAuditInfo(conn, MIid);
                dl.getData(i).addData(JBRdata);
                //部门主任审核信息
                Data BMZRdata = getBMZRAuditInfo(conn, MIid);
                dl.getData(i).addData(BMZRdata);
            }
        }
        return dl;
    }
    /**
     * 
     * @Title: getTendingAndOpinion
     * @Description: 特需的抚育计划和组织意见
     * @author: xugy
     * @date: 2014-10-31下午1:40:20
     * @param conn
     * @param MAIN_CI_ID
     * @return
     * @throws DBException 
     */
    public Data getTendingAndOpinion(Connection conn, String MAIN_CI_ID, String CI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTendingAndOpinion", MAIN_CI_ID);
        //System.out.println(sql);
        DataList dl = ide.find(sql);
        Data data = new Data();
        if(dl.size()>0){
            data = dl.getData(0);
        }
        String CIsql = getSql("getTendingAndOpinionCI", CI_ID);
        DataList CIdl = ide.find(CIsql);
        Data CIdata = new Data();
        if(CIdl.size()>0){
            CIdata = CIdl.getData(0);
        }
        data.addData(CIdata);
        return data;
    }
    
    /**
     * 
     * @Title: findMatchAuditAgainList
     * @Description: 复核列表
     * @author: xugy
     * @date: 2014-9-9下午7:17:54
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMatchAuditAgainList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //开始收文日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //结束收文日期
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String FILE_TYPE = data.getString("FILE_TYPE", null);   //文件类型
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //匹配次数
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String OPERATION_STATE = data.getString("OPERATION_STATE", null);   //操作状态
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //匹配状态
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='1'";
        }else if("99".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE IN ('0','1','3','4','9')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
        }
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findMatchAuditAgainList", FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, FILE_TYPE, MATCH_NUM, CHILD_TYPE, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, OPERATION_STATE, MATCH_STATE,compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getMatchAudit1
     * @Description: 经办人审核信息
     * @author: xugy
     * @date: 2014-9-9下午7:40:46
     * @param conn
     * @param mAU_ID
     * @return
     * @throws DBException 
     */
    public Data getMatchAuditForJBR(Connection conn, String MAU_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchAuditForJBR" , MAU_ID);
        System.out.println(sql);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
            
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getAllMatchState
     * @Description: 获取匹配信息的各个状态
     * @author: xugy
     * @date: 2014-9-29上午10:19:36
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getAllMatchState(Connection conn, String MI_ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAllMatchState" , MI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getArchiveId
     * @Description: 获取涉外收养档案ID
     * @author: xugy
     * @date: 2014-9-29下午2:41:46
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getArchiveInfo(Connection conn, String MI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getArchiveInfo" , MI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getCIInfoOfMainCiId
     * @Description: 根据儿童的主ID获取信息
     * @author: xugy
     * @date: 2014-12-16上午11:49:02
     * @param conn
     * @param MAIN_CI_ID
     * @return
     * @throws DBException 
     */
    public DataList getCIInfoOfMainCiId(Connection conn, String MAIN_CI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIInfoOfMainCiId" , MAIN_CI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getCIPosition
     * @Description: 材料位置
     * @author: xugy
     * @date: 2014-12-17下午5:49:50
     * @param conn
     * @param MAIN_CI_ID
     * @return
     * @throws DBException 
     */
    public DataList getCIPosition(Connection conn, String MAIN_CI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCIPosition" , MAIN_CI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getTransferInfoDetail
     * @Description: 
     * @author: xugy
     * @date: 2014-12-17下午6:47:53
     * @param conn
     * @param everyCiId
     * @return
     * @throws DBException
     */
    public Data getTransferInfoDetail(Connection conn, String everyCiId) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTransferInfoDetail" , everyCiId);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getTransferInfo
     * @Description: 
     * @author: xugy
     * @date: 2014-12-17下午7:05:20
     * @param conn
     * @param TI_ID
     * @return
     * @throws DBException
     */
    public Data getTransferInfo(Connection conn, String TI_ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getTransferInfo" , TI_ID);
        DataList dl = ide.find(sql);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: deleteTransferInfoDetail
     * @Description: 删除
     * @author: xugy
     * @date: 2014-12-17下午7:05:30
     * @param conn
     * @param TID_ID
     * @throws DBException 
     */
    public void deleteTransferInfoDetail(Connection conn, String TID_ID) throws DBException {
        IDataExecute ide=DataBaseFactory.getDataBase(conn);
        Data data=new Data();
        data.setConnection(conn);
        data.setEntityName("TRANSFER_INFO_DETAIL");
        data.setPrimaryKey("TID_ID");
        data.add("TID_ID", TID_ID);
        ide.remove(data);
    }
}
