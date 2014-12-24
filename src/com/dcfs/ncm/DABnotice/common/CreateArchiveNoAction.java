package com.dcfs.ncm.DABnotice.common;

import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

import java.sql.Connection;

/**
 * 
 * @Title: CreateArchiveNoAction.java
 * @Description: 生成涉外收养档案号流水号
 * @Company: 21softech
 * @Created on 2014-9-26 上午11:29:11
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class CreateArchiveNoAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(CreateArchiveNoAction.class);
    private Connection conn = null;
    private CreateArchiveNoHandler handler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public CreateArchiveNoAction() {
        this.handler=new CreateArchiveNoHandler();
        
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: createArchiveNo
     * @Description: 生成涉外档案号流水号
     * @author: xugy
     * @date: 2014-9-26下午2:15:43
     * @return
     * @throws DBException 
     */
    public String createArchiveNo(Connection conn) throws DBException{
        String ARCHIVE_NO = "";//最终档案号
        String year = DateUtility.getCurrentYear();//年份
        String year_sn = "";//年度流水号
        
        //获取本年度的最大流水号
        Data data = handler.getMaxSN(conn, year);
        String sn = data.getString("SN", "");
        if("".equals(sn)){
            sn = "0";
        }
        int maxSN = Integer.parseInt(sn);
        maxSN = maxSN + 1;
        if(maxSN<10){
            year_sn = "0000"+maxSN;
        }else if(maxSN>9 && maxSN<100){
            year_sn = "000"+maxSN;
        }else if(maxSN>99 && maxSN<1000){
            year_sn = "00"+maxSN;
        }else if(maxSN>999 && maxSN<10000){
            year_sn = "0"+maxSN;
        }else{
            year_sn = ""+maxSN;
        }
        
        ARCHIVE_NO = year + year_sn;
        Data adddata = new Data();
        adddata.add("YEAR", year);
        adddata.add("SN", year_sn);
        adddata.add("ARCHIVE_NO", ARCHIVE_NO);
        handler.save(conn, adddata);
        
        return ARCHIVE_NO;
    }

}
