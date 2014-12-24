package com.dcfs.ncm.normal;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;

import com.dcfs.common.transfercode.TransferCode;

/**
 * 
 * @Title: NormalMatchHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2014-9-2 下午3:55:02
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class NormalMatchHandler extends BaseHandler {
    
    /**
     * 
     * @Title: findMatchList
     * @Description: 匹配列表
     * @author: xugy
     * @date: 2014-9-2下午4:43:25
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//当前日期，判断文件的政府批准书是否过期
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);   //收文开始日期
        String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);   //收文结束日期
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null); //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null); //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String MATCH_RECEIVEDATE_START = data.getString("MATCH_RECEIVEDATE_START", null);   //接收开始日期
        String MATCH_RECEIVEDATE_END = data.getString("MATCH_RECEIVEDATE_END", null);   //接收结束日期
        String FILE_TYPE = data.getString("FILE_TYPE", "");   //文件类型
        if("".equals(FILE_TYPE)){
            FILE_TYPE = "(FILE_TYPE='10' or FILE_TYPE='30' or FILE_TYPE='31' or FILE_TYPE='32' or FILE_TYPE='33' or FILE_TYPE='34' or FILE_TYPE='35')";
        }else{
            FILE_TYPE = "FILE_TYPE='"+FILE_TYPE+"'";
        }
        String ADOPT_REQUEST_CN = data.getString("ADOPT_REQUEST_CN", null);   //收养要求
        String UNDERAGE_NUM = data.getString("UNDERAGE_NUM", null);   //子女数量
        String MATCH_NUM = data.getString("MATCH_NUM", null);   //匹配次数
        String MATCH_STATE = data.getString("MATCH_STATE", "");   //匹配状态
        if("".equals(MATCH_STATE)){
            MATCH_STATE = "MATCH_STATE='0'";
        }else if("9".equals(MATCH_STATE)){
            MATCH_STATE = "(MATCH_STATE='0' or MATCH_STATE='1')";
        }else{
            MATCH_STATE = "MATCH_STATE='"+MATCH_STATE+"'";
            
        }
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAFMatchList", nowDate, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, MATCH_RECEIVEDATE_START, MATCH_RECEIVEDATE_END, FILE_TYPE, ADOPT_REQUEST_CN, UNDERAGE_NUM, MATCH_NUM, MATCH_STATE, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: AFplanCountSum1
     * @Description: 通过REG_DATE查询收养文件数据
     * @author: xugy
     * @date: 2014-9-3上午10:38:13
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public Data AFplanCountSum1(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//当前日期，判断文件的政府批准书是否过期
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("AFplanCountSum1", nowDate, FILE_TYPE, DATE_START, DATE_END);
        //System.out.println(sql);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: AFplanCountSum2
     * @Description: 通过RECEIVER_DATE查询收养文件数据
     * @author: xugy
     * @date: 2014-9-3上午10:39:04
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public Data AFplanCountSum2(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//当前日期，判断文件的政府批准书是否过期
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String TRANSFER_CODE = TransferCode.FILE_SHB_DAB;//文件交接：审核部到档案部
        String sql = getSql("AFplanCountSum2", nowDate, FILE_TYPE, DATE_START, DATE_END, TRANSFER_CODE);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: CIplanCount
     * @Description: 儿童材料各省数据
     * @author: xugy
     * @date: 2014-9-3下午2:30:28
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList CIplanCount(Connection conn) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("CIplanCount");
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: CIplanCountSum
     * @Description: 儿童材料总数据
     * @author: xugy
     * @date: 2014-9-3下午2:41:49
     * @param conn
     * @return
     * @throws DBException
     */
    public Data CIplanCountSum(Connection conn) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("CIplanCountSum");
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findAFPlanList1
     * @Description: 通过REG_DATE查询收养文件数据
     * @author: xugy
     * @date: 2014-9-3下午4:20:48
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public DataList findAFPlanList1(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//当前日期，判断文件的政府批准书是否过期
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAFPlanList1", nowDate, FILE_TYPE, DATE_START, DATE_END);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: findAFPlanList2
     * @Description: 通过RECEIVER_DATE查询收养文件数据
     * @author: xugy
     * @date: 2014-9-3下午4:20:52
     * @param conn
     * @param FILE_TYPE
     * @param DATE_START
     * @param DATE_END
     * @return
     * @throws DBException
     */
    public DataList findAFPlanList2(Connection conn, String FILE_TYPE, String DATE_START, String DATE_END) throws DBException {
        String nowDate = DateUtility.getCurrentDate();//当前日期，判断文件的政府批准书是否过期
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String TRANSFER_CODE = TransferCode.FILE_SHB_DAB;//文件交接：审核部到档案部
        String sql = getSql("findAFPlanList2", nowDate, FILE_TYPE, DATE_START, DATE_END, TRANSFER_CODE);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getAFExpireDate
     * @Description: 获取文件的政府批准书的到期日期
     * @author: xugy
     * @date: 2014-9-4上午11:24:35
     * @param conn
     * @param AFid
     * @return
     * @throws DBException 
     */
    public Data getAFExpireDate(Connection conn, String AFid) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAFExpireDate", AFid);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: findCIMatchList
     * @Description: 选择匹配儿童列表
     * @author: xugy
     * @date: 2014-9-4下午2:35:03
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findCIMatchList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String CHECKUP_DATE_START = data.getString("CHECKUP_DATE_START", null);   //体检开始日期
        String CHECKUP_DATE_END = data.getString("CHECKUP_DATE_END", null); //体检结束日期
        String NAME = data.getString("NAME", null); //姓名
        String SEX = data.getString("SEX", null);   //性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //生日开始
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //生日结束
        String CHILD_TYPE = "1";   //儿童类型
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findCIMatchList", PROVINCE_ID, WELFARE_ID, CHECKUP_DATE_START, CHECKUP_DATE_END, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, CHILD_TYPE, compositor, ordertype);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

}
