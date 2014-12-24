package com.dcfs.ncm.DABnotice;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

/**
 * 
 * @Title: DABNoticeCopyHandler.java
 * @Description: 档案部通知书副本打印
 * @Company: 21softech
 * @Created on 2014-9-16 上午9:42:49
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class DABNoticeCopyHandler extends BaseHandler {
    
    /**
     * 
     * @Title: findDABNoticePrintList
     * @Description: 档案部通知书打印列表
     * @author: xugy
     * @date: 2014-9-16上午9:46:37
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABNoticePrintList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
        //查询条件
        String ARCHIVE_NO = data.getString("ARCHIVE_NO", null);   //档案号
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //儿童姓名
        String NOTICECOPY_PRINT_NUM = data.getString("NOTICECOPY_PRINT_NUM", "");   //打印次数
        String NOTICECOPY_REPRINT = data.getString("NOTICECOPY_REPRINT", "");   //是否重打
        String DEFAULT_DATA = "";
        if("".equals(NOTICECOPY_PRINT_NUM) && "".equals(NOTICECOPY_REPRINT)){
            DEFAULT_DATA = "(NOTICECOPY_PRINT_NUM='0' OR NOTICECOPY_REPRINT='1')";
        }else if(!"".equals(NOTICECOPY_PRINT_NUM) && "".equals(NOTICECOPY_REPRINT)){
            DEFAULT_DATA = "NOTICECOPY_PRINT_NUM='"+NOTICECOPY_PRINT_NUM+"'";
        }else if("".equals(NOTICECOPY_PRINT_NUM) && !"".equals(NOTICECOPY_REPRINT)){
            if("99".equals(NOTICECOPY_REPRINT)){
                DEFAULT_DATA = null;
            }else{
                DEFAULT_DATA = "NOTICECOPY_REPRINT='"+NOTICECOPY_REPRINT+"'";
            }
        }else if(!"".equals(NOTICECOPY_PRINT_NUM) && !"".equals(NOTICECOPY_REPRINT)){
            if("99".equals(NOTICECOPY_REPRINT)){
                DEFAULT_DATA = "NOTICECOPY_PRINT_NUM='"+NOTICECOPY_PRINT_NUM+"'";
            }else{
                DEFAULT_DATA = "NOTICECOPY_PRINT_NUM='"+NOTICECOPY_PRINT_NUM+"' and NOTICECOPY_REPRINT='"+NOTICECOPY_REPRINT+"'";
            }
        }
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABNoticePrintList", ARCHIVE_NO, FILE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, DEFAULT_DATA, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }

    
    
    
    
    
    
    
    
    /**
     * 
     * @Title: findDABArchiveFilingList
     * @Description: 档案部归档立卷
     * @author: xugy
     * @date: 2014-11-2下午5:47:27
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @param compositor
     * @param ordertype
     * @return
     * @throws DBException 
     */
    public DataList findDABArchiveFilingList(Connection conn, Data data, int pageSize, int page, String compositor, String ordertype) throws DBException {
      //查询条件
        String ARCHIVE_NO_START = data.getString("ARCHIVE_NO_START", null);   //起始档案号
        String ARCHIVE_NO_END = data.getString("ARCHIVE_NO_END", null);   //结束档案号
        String FILE_NO = data.getString("FILE_NO", null);   //收文编号
        String COUNTRY_CODE = data.getString("COUNTRY_CODE", null);   //国家
        String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID", null);   //收养组织
        String MALE_NAME = data.getString("MALE_NAME", null);   //男方
        String FEMALE_NAME = data.getString("FEMALE_NAME", null);   //女方
        String NAME = data.getString("NAME", null);   //儿童姓名
        String ARCHIVE_USERNAME = data.getString("ARCHIVE_USERNAME", null);   //归档人
        String ARCHIVE_DATE_START = data.getString("ARCHIVE_DATE_START", null);   //开始归档日期
        String ARCHIVE_DATE_END = data.getString("ARCHIVE_DATE_END", null);   //结束归档日期
        String ARCHIVE_STATE = data.getString("ARCHIVE_STATE", null);   //归档状态
        String FILING_REMARKS = data.getString("FILING_REMARKS", null);   //备注
        String ARCHIVE_VALID = data.getString("ARCHIVE_VALID", null);   //是否有效
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findDABArchiveFilingList", ARCHIVE_NO_START, ARCHIVE_NO_END, FILE_NO, COUNTRY_CODE, ADOPT_ORG_ID, MALE_NAME, FEMALE_NAME, NAME, ARCHIVE_USERNAME, ARCHIVE_DATE_START, ARCHIVE_DATE_END, ARCHIVE_STATE, FILING_REMARKS, ARCHIVE_VALID, compositor, ordertype);
        //System.out.println(sql);
        DataList dl = ide.find(sql, pageSize, page);
        return dl;
    }








    /**
     * 
     * @Title: getDABArchiveInfo
     * @Description: 目录
     * @author: xugy
     * @date: 2014-11-2下午6:48:38
     * @param conn
     * @param ARCHIVE_ID
     * @return
     * @throws DBException 
     */
    public Data getDABArchiveInfo(Connection conn, String ARCHIVE_ID) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getDABArchiveInfo", ARCHIVE_ID);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl.getData(0);
    }

    /**
     * 
     * @Title: getDABCatalogInfo
     * @Description: 批量打印目录获取信息
     * @author: xugy
     * @date: 2014-11-5下午3:00:48
     * @param conn
     * @param aRCHIVE_IDs
     * @return
     * @throws DBException 
     */
    public DataList getDABCatalogInfo(Connection conn, String ARCHIVE_IDs) throws DBException {
        //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getDABCatalogInfo", ARCHIVE_IDs);
        DataList dl = ide.find(sql);
        //System.out.println(dl);
        return dl;
    }

}
