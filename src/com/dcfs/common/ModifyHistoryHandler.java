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
     * ��ʷ���۱���
     * @description 
     * @param Data originaldata �޸�ǰ����
     * @param Data newdata �޸ĺ�����
     * @param String tableName ���ۼ�¼������
     * @param String primaryName ���ۼ�¼����������
     * @param String colName ҵ����������
     * @param String colValue ҵ������ֵ
     * @param String reviseType �޸�����(1:��֯�����ļ�;2:��������ļ�;3:����ά��)
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
     * ���ԭʼ����
     * @param conn
     * @param tableName ������
     * @param tableName ����Name
     * @param tableName ����Value
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
     * �鿴��ʷ����List
     * @param conn
     * @param tableName ��ʷ���ۼ�¼�����ƣ������
     * @param colName ҵ���������ƣ������
     * @param colValue ҵ������ֵ�������
     * @param reviseType �ļ��޸�����(�Ǳ����1:��֯�����ļ���2:��������ļ���3:����ά�������Ϊ�գ��鿴ȫ�����͵ļ�¼)
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