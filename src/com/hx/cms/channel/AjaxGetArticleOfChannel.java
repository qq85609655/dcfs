package com.hx.cms.channel;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

/**
 * 
 * @Title: AjaxGetArticleOfChannel.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2014-7-29 下午3:08:24
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AjaxGetArticleOfChannel extends AjaxExecute {
    
    private static Log log = UtilLog.getLog(AjaxGetArticleOfChannel.class);
    
    @Override
    public boolean run(HttpServletRequest request) {
        Connection conn = null;
        ChannelHandler h = new ChannelHandler();
        String uuid = (String)request.getParameter("uuid");
        try {
            conn = ConnectionManager.getConnection();
            DataList dl = new DataList();
            String[] ids = null;
            if (uuid != null && !"".equals(uuid.trim())) {
                ids = uuid.split("#");
            }
            StringBuffer channelIds = new StringBuffer();
            if(ids != null){
                for (int i = 0; i < ids.length; i++) {
                    String channel = ids[i];
                    DataList datalist = h.getChannels(conn,channel);
                    StringBuffer channels = new StringBuffer();
                    if(datalist.size()>0){
                        for(int j=0;j<datalist.size();j++){
                            String channelId = datalist.getData(j).getString("ID");
                            if(j != (datalist.size() - 1)){
                                channels.append("'").append(channelId).append("'").append(",");
                            }else{
                                channels.append("'").append(channelId).append("'");
                            }
                        }
                    }
                    if(i != (ids.length - 1)){
                        channelIds.append(channels.toString()).append(",");
                    }else{
                        channelIds.append(channels.toString());
                    }
                }
            }
            IDataExecute ide = DataBaseFactory.getDataBase(conn);
            String sql = "SELECT ID FROM cms_article WHERE CHANNEL_ID IN ("+channelIds.toString()+")";
            dl = ide.find(sql);
            try {
                this.setReturnValue(dl);
            } catch (IOException e) {
                log.logError("获取数据出现异常:" + e.getMessage(), e);
            } catch (SQLException e) {
                log.logError("获取SQL语句失败:" + e.getMessage(), e);
            }
        }catch (DBException e) {
            log.logError("获取数据出现异常:" + e.getMessage(), e);
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("CarAjax的Connection因出现异常，未能关闭", e);
                    }
                }
            }
        }
        return true;
    }

}
