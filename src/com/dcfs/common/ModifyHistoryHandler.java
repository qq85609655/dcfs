/**
 * $Id$
 *
 * Copyright (c) 2011 21softech. All rights reserved
 * OA Project
 *
 */

package com.dcfs.common;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.util.Iterator;
import java.util.Set;

import com.hx.framework.authenticate.SessionInfo;

/**
 * @Title: HourStatHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-12-20 ????09:47:14
 * @author zhaoyb
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class ModifyHistoryHandler extends BaseHandler{

    /**
     * 历史留痕保存
     * @description 
     * @param Data originaldata 修改前数据
     * @param Data newdata 修改后数据
     * @param String tableName 留痕记录表名称
     * @param String primaryName 留痕记录表主键名称
     * @param String colName 业务主键名称
     * @param String colValue 业务主键值
     * @param String reviseType 修改类型(1:组织补充文件;2:中心审核文件;3:数据维护)
     * @author MaYun
     * @date Aug 26, 2014
     * @return
     */
    public boolean savehistory(Connection conn, Data originaldata,Data newdata,String tableName,String primaryName,String colName,String colValue,String reviseType) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList savelist=new DataList();
        Set keysSet = newdata.keySet();
        Iterator iterator = keysSet.iterator();
        while(iterator.hasNext()) {
            Data savedata = new Data();
            Object key = iterator.next();//key
            if(newdata.getString(key)==null){
                newdata.add(key.toString(), "");
            }
            if(originaldata.getString(key)==null){
                originaldata.add(key.toString(), "");
            } 
            if(!originaldata.getString(key).equals(newdata.getString(key))){
                savedata.setEntityName(tableName);
                savedata.setPrimaryKey(primaryName);
                savedata.add(colName, colValue);
                savedata.add("REVISE_TYPE", reviseType);
                savedata.add("UPDATE_FIELD", key.toString());
                savedata.add("ORIGINAL_DATA", originaldata.getString(key));
                savedata.add("UPDATE_DATA", newdata.getString(key));
                savedata.add("UPDATE_DATE", DateUtility.getCurrentDateTime());
                savedata.add("REVISE_ORGID", SessionInfo.getCurUser().getCurOrgan().getId());
                savedata.add("REVISE_ORGNAME", SessionInfo.getCurUser().getCurOrgan().getCName());
                savedata.add("REVISE_USERID", SessionInfo.getCurUser().getPersonId());
                savedata.add("REVISE_USERNAME", SessionInfo.getCurUser().getPerson().getCName());
                savelist.add(savedata);
            }    
        }
        int j = ide.batchCreate(savelist);
        if (j >= 0) {
            return true;
        } else {
            return false;
        }

    }
    
    /**
     * 获得原始数据
     * @param conn
     * @param tableName 表名称
     * @param tableName 主键Name
     * @param tableName 主键Value
     * @return Data   
     * @throws DBException
     */
    public Data getOriginalData(Connection conn, String tableName,String primaryName,String primaryValue) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList resultList=new DataList();
        Data resultData = new Data();
        resultList=ide.find(getSql("getOriginalData", tableName,primaryName,primaryValue));
    	if(resultList.size()>0){
    		resultData=resultList.getData(0);
    	}
        return resultData;
    }


    /**
     * 查看历史留痕List
     * @param conn
     * @param tableName 历史留痕记录表名称（必填项）
     * @param colName 业务主键名称（必填项）
     * @param colValue 业务主键值（必填项）
     * @param reviseType 文件修改类型(非必填项，1:组织补充文件；2:中心审核文件；3:数据维护。如果为空，查看全部类型的记录)
     * @return DataList
     * @throws DBException
     */
    public DataList getModifyList(Connection conn, String tableName, String colName,String colValue,String reviseType) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DataList dataList = new DataList();
        dataList = ide.find(getSql("findModifyList", tableName, reviseType));
        return dataList;
    } 
    
}