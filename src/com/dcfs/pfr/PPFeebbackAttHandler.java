package com.dcfs.pfr;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
/**
 * 
 * @Title: PPFeebbackAttHandler.java
 * @Description: 安置后报告附件
 * @Company: 21softech
 * @Created on 2014-10-17 下午3:55:15
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PPFeebbackAttHandler extends BaseHandler {
    /**
     * 
     * @Title: getSmallType
     * @Description: 获取附件小类
     * @author: xugy
     * @date: 2014-10-17下午5:37:58
     * @param conn
     * @param CODE
     * @return
     * @throws DBException 
     */
    public DataList getSmallType(Connection conn, String CODE) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getSmallType", CODE);
        DataList dl = ide.find(sql);
        return dl;
    }
    
    /**
     * 
     * @Title: findPPFdeedbackAtt
     * @Description: 获取附件
     * @author: xugy
     * @date: 2014-10-17下午3:58:55
     * @param conn
     * @param FB_REC_ID
     * @param CODE 
     * @return
     * @throws DBException 
     */
    public DataList findPPFdeedbackAtt(Connection conn, String FB_REC_ID, String CODE) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findPPFdeedbackAtt", FB_REC_ID, CODE);
        DataList dl = ide.find(sql);
        return dl;
    }
    /**
     * 
     * @Title: getPhotoPath
     * @Description: 获取附件路径
     * @author: xugy
     * @date: 2014-10-19下午2:38:18
     * @param conn
     * @param ID
     * @param ID 
     * @return
     * @throws DBException 
     */
    public Data getPhotoPath(Connection conn, String ATT_TABLE, String ID) throws DBException {
      //数据操作
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getPhotoPath", ATT_TABLE, ID);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }
    /**
     * 
     * @Title: saveARDES
     * @Description: 保存照片描述
     * @author: xugy
     * @date: 2014-10-19下午5:20:28
     * @param conn
     * @param data
     * @throws DBException 
     */
    public void saveARDES(Connection conn, Data data) throws DBException {
        data.setConnection(conn);
        data.setEntityName("ATT_AR");
        data.setPrimaryKey("ID");
        data.store();
    }
    /**
     * 
     * @Title: getSmallTypeData
     * @Description: 获取小类附件数据
     * @author: xugy
     * @date: 2014-10-20下午3:54:16
     * @param conn
     * @param CODE
     * @return
     * @throws DBException
     */
    public Data getSmallTypeData(Connection conn, String CODE) throws DBException {
        //数据操作
          IDataExecute ide = DataBaseFactory.getDataBase(conn);
          String sql = getSql("getSmallTypeData", CODE);
          DataList dl = ide.find(sql);
          return dl.getData(0);
      }

    

}
