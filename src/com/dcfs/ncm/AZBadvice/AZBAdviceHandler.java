package com.dcfs.ncm.AZBadvice;

import java.sql.Connection;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: AZBAdviceHandler.java
 * @Description: 安置部征求意见
 * @Company: 21softech
 * @Created on 2014-9-11 上午9:50:40
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AZBAdviceHandler extends BaseHandler {
    /**
     * 
     * @Title: findAZBAdviceList
     * @Description: 安置部征求意见列表
     * @author: xugy
     * @date: 2014-9-11上午10:43:58
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findAZBAdviceList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String PROVINCE_ID = data.getString("PROVINCE_ID", null);   //省份
        String WELFARE_ID = data.getString("WELFARE_ID", null);   //福利院
        String NAME = data.getString("NAME", null);   //儿童姓名
        String SEX = data.getString("SEX", null);   //儿童性别
        String BIRTHDAY_START = data.getString("BIRTHDAY_START", null);   //开始儿童出生日期
        String BIRTHDAY_END = data.getString("BIRTHDAY_END", null);   //结束儿童出生日期
        String MATCH_PASSDATE_START = data.getString("MATCH_PASSDATE_START", null);   //开始通过日期
        String MATCH_PASSDATE_END = data.getString("MATCH_PASSDATE_END", null);   //结束通过日期
        String ADVICE_NOTICE_DATE_START = data.getString("ADVICE_NOTICE_DATE_START", null);   //开始通知日期
        String ADVICE_NOTICE_DATE_END = data.getString("ADVICE_NOTICE_DATE_END", null);   //结束通知日期
        String ADVICE_PRINT_NUM = data.getString("ADVICE_PRINT_NUM", null);   //打印次数
        String ADVICE_STATE = data.getString("ADVICE_STATE", null);   //征求状态
        String ADVICE_REMINDER_STATE = data.getString("ADVICE_REMINDER_STATE", null);   //催办状态
        String AF_COST_CLEAR = data.getString("AF_COST_CLEAR", null);   //完费状态
        String ADVICE_FEEDBACK_RESULT = data.getString("ADVICE_FEEDBACK_RESULT", null);   //反馈结果
        
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findAZBAdviceList", FILE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, PROVINCE_ID, WELFARE_ID, NAME, SEX, BIRTHDAY_START, BIRTHDAY_END, MATCH_PASSDATE_START, MATCH_PASSDATE_END, ADVICE_NOTICE_DATE_START, ADVICE_NOTICE_DATE_END, ADVICE_PRINT_NUM, ADVICE_STATE, ADVICE_REMINDER_STATE, AF_COST_CLEAR, ADVICE_FEEDBACK_RESULT, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }
    /**
     * 
     * @Title: getPrintData
     * @Description: 获取打印数据
     * @author: xugy
     * @date: 2014-9-21下午3:24:20
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException
     */
    public Data getPrintData(Connection conn, String MI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getPrintData", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getCode
     * @Description: 代码集对照
     * @author: xugy
     * @date: 2014-9-21下午5:01:33
     * @param conn
     * @param CODESORTID
     * @param CODEVALUE 
     * @return
     * @throws DBException 
     */
    public Data getCode(Connection conn, String CODESORTID, String CODEVALUE) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getCode", CODESORTID, CODEVALUE);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    
    /**
     * 
     * @Title: matchSave
     * @Description: 匹配信息保存
     * @author: xugy
     * @date: 2014-9-11下午4:04:03
     * @param conn
     * @param data
     * @throws DBException
     */
    public void matchSave(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("NCM_MATCH_INFO");
        dataadd.setPrimaryKey("MI_ID");
        dataadd.store();
    }
    /**
     * 
     * @Title: findCountryGovment
     * @Description: 获取收养国中央机关
     * @author: xugy
     * @date: 2014-9-12下午2:52:25
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public CodeList findCountryGovment(Connection conn, String MI_ID) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findCountryGovment", MI_ID);
        DataList dataList = ide.find(sql);
        CodeList list=new CodeList();
        for(int i=0;i<dataList.size();i++){
            Code c=new Code();
            c.setValue(dataList.getData(i).getString("VALUE"));
            c.setName(dataList.getData(i).getString("NAME"));
            c.setRem(dataList.getData(i).getString("NAME"));
            list.add(c);
        }
        return list;
    }


    /**
     * 
     * @Title: getRFMAFInfo
     * @Description: 获取文件需要存入退文记录表的信息
     * @author: xugy
     * @date: 2014-9-12下午6:12:52
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getRFMAFInfo(Connection conn, String AF_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getRFMAFInfo", AF_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }


    /**
     * 
     * @Title: getMatchReminderInfo
     * @Description: 获取催办查看信息
     * @author: xugy
     * @date: 2014-9-14下午3:32:22
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getMatchReminderInfo(Connection conn, String MI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchReminderInfo", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getAdviceSignDate
     * @Description: 获取征求意见_最后落款日期
     * @author: xugy
     * @date: 2014-11-12下午5:20:38
     * @param conn
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getAdviceSignDate(Connection conn, String MI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getAdviceSignDate", MI_ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: getMainCIIDS
     * @Description: 获取主儿童的ID
     * @author: xugy
     * @date: 2014-12-16下午5:54:21
     * @param conn
     * @param inCI_ID
     * @return
     * @throws DBException 
     */
    public DataList getMainCIIDS(Connection conn, String inCI_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMainCIIDS", inCI_ID);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getMatchInfo
     * @Description: 
     * @author: xugy
     * @date: 2014-12-21上午11:15:26
     * @param conn
     * @return
     * @throws DBException 
     */
    public DataList getMatchInfo(Connection conn) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getMatchInfo");
        DataList dl = ide.find(sql);
        return dl;
    }
}
