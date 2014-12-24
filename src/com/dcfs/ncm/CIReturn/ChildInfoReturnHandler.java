package com.dcfs.ncm.CIReturn;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: ChildInfoReturnHandler.java
 * @Description: 档案部退回材料到安置部
 * @Company: 21softech
 * @Created on 2014-12-16 下午7:28:22
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChildInfoReturnHandler extends BaseHandler {
    /**
     * 
     * @Title: findAZBApplyCIReturnList
     * @Description: 安置部申请材料退回列表
     * @author: xugy
     * @date: 2014-12-16下午8:54:59
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAZBApplyCIReturnList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //姓名
        String SEX = data.getString("SEX", null);   //性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束出生日期
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String SN_TYPE = data.getString("SN_TYPE", null);   //病残种类
        String APPLY_USER = data.getString("APPLY_USER", null);   //申请人
        String APPLY_DATE_START = data.getString("APPLY_DATE_START", null);   //开始申请日期
        String APPLY_DATE_END = data.getString("APPLY_DATE_END", null);   //结束申请日期
        String CONFIRM_DATE_START = data.getString("CONFIRM_DATE_START", null);   //开始确认日期
        String CONFIRM_DATE_END = data.getString("CONFIRM_DATE_END", null);   //结束确认日期
        String APPLY_STATE = data.getString("APPLY_STATE", null);   //申请状态
        String CONFIRM_STATE = data.getString("CONFIRM_STATE", null);   //确认结果
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBApplyCIReturnList", PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, SN_TYPE, APPLY_USER, APPLY_DATE_START, APPLY_DATE_END, CONFIRM_DATE_START, CONFIRM_DATE_END, APPLY_STATE, CONFIRM_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: findAZBSelectDABCIList
     * @Description: 安置部选择已移交的儿童材料列表
     * @author: xugy
     * @date: 2014-12-17上午11:16:04
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAZBSelectDABCIList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //姓名
        String SEX = data.getString("SEX", null);   //性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束出生日期
        String CHILD_TYPE = data.getString("CHILD_TYPE", null);   //儿童类型
        String SN_TYPE = data.getString("SN_TYPE", null);   //病残种类
        String TRANSFER_DATE_START = data.getString("TRANSFER_DATE_START", null);   //开始移交日期
        String TRANSFER_DATE_END = data.getString("TRANSFER_DATE_END", null);   //结束移交日期
        String RECEIVER_DATE_START = data.getString("RECEIVER_DATE_START", null);   //开始接收日期
        String RECEIVER_DATE_END = data.getString("RECEIVER_DATE_END", null);   //结束接收日期
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBSelectDABCIList", PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, SN_TYPE, TRANSFER_DATE_START, TRANSFER_DATE_END, RECEIVER_DATE_START, RECEIVER_DATE_END, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: saveNcmArchRevocation
     * @Description: 保存申请数据
     * @author: xugy
     * @date: 2014-12-17下午1:19:17
     * @param conn
     * @param data
     * @return
     * @throws DBException
     */
    public Data saveNcmArchRevocation(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_ARCH_REVOCATION");
        dataadd.setPrimaryKey("NAR_ID");
        if("".equals(dataadd.getString("NAR_ID", ""))){
            return dataadd.create();
        }else{
            return dataadd.store();
        }
        
    }
    /**
     * 
     * @Title: findDABRevokeArchiveList
     * @Description: 档案部撤销档案列表
     * @author: xugy
     * @date: 2014-12-17下午2:26:29
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABRevokeArchiveList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //档案号
        String SIGN_NO = data.getString("SIGN_NO", null);   //签批号
        String SIGN_DATE_START = data.getString("SIGN_DATE_START", null);   //开始签批日期
        String SIGN_DATE_END = data.getString("SIGN_DATE_END", null);   //结束签批日期
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String FILE_NO = data.getString("FILE_NO", null);   //文件编号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男收养人
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女收养人
        String ARCHIVE_STATE = data.getString("ARCHIVE_STATE", null);   //归档状态
        String CONFIRM_USER = data.getString("CONFIRM_USER", null);   //确认人
        String CONFIRM_DATE_START = data.getString("CONFIRM_DATE_START", null);   //开始确认日期
        String CONFIRM_DATE_END = data.getString("CONFIRM_DATE_END", null);   //结束确认日期
        String APPLY_STATE = data.getString("APPLY_STATE", null);   //确认状态
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABRevokeArchiveList", ARCHIVE_NO, SIGN_NO, SIGN_DATE_START, SIGN_DATE_END, PROVINCE_ID, WELFARE_ID, NAME, FILE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, ARCHIVE_STATE, CONFIRM_USER, CONFIRM_DATE_START, CONFIRM_DATE_END, APPLY_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getNcmArchRevocation
     * @Description: 
     * @author: xugy
     * @date: 2014-12-17下午4:07:15
     * @param conn
     * @param NAR_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmArchRevocation(Connection conn, String NAR_ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNcmArchRevocation", NAR_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }
    /**
     * 
     * @Title: getNcmArchiveInfo
     * @Description: 获取档案信息
     * @author: xugy
     * @date: 2014-12-17下午4:48:16
     * @param conn
     * @param CI_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmArchiveInfo(Connection conn, String CI_ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getNcmArchiveInfo", CI_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        if(dl.size()>0){
            return dl.getData(0);
        }else{
            return new Data();
        }
    }

}
