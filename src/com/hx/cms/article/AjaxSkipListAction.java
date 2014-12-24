package com.hx.cms.article;

import hx.ajax.AjaxExecute;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.hx.cms.article.vo.Article;

public class AjaxSkipListAction extends AjaxExecute{
	
	private static Log log = UtilLog.getLog(AjaxSkipListAction.class);
	private ArticleHandler handler;

	@Override
	public boolean run(HttpServletRequest request) {
		
		String orderString = "IS_TOP DESC, SEQ_NUM ASC, CREATE_TIME DESC";
		
		//弹出栏目ID
		handler = new ArticleHandler();
    	String channelId = getParameter("CHANNEL_ID",request);
        Connection conn = null;
        StringBuffer json = new StringBuffer();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            
            if(channelId != null && !"".equals(channelId)){
            	Data data = new Data();
            	data.setEntityName(Article.ARTICLE_ENTITY);
                data.setPrimaryKey(Article.ID);
                data.add(Article.CHANNEL_ID, channelId);
                //审核通过的文章
                data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
                data.add(Article.IS_SKIP, Article.IS_SKIP_YES);
                //查询
                dataList = handler.findSkipList(conn,data,orderString);
            }
            json.append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
            if(dataList != null && dataList.size() > 0){
            	json.append("<root size=\""+dataList.size()+"\">");
            	for (int i = 0; i < dataList.size(); i++) {
					Data data = dataList.getData(i);
					json.append("<item num=\""+i+"\" title=\""+data.getString(Article.TITLE)+"\" id=\""+data.getString(Article.ID)+"\" />");
				}
            	json.append("</root>");
            }else{
            	json.append("<root size=\"0\"></root>");
            }
            setReturnValue(json.toString());
        } catch (Exception e) {
        	addError("弹出栏目加载出错!");
            log.logError("弹出栏目加载异常!", e);
            return false;
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去修改内部刊物时关闭Connection出错!", e);
            }
        }
        return true;
	}
}
