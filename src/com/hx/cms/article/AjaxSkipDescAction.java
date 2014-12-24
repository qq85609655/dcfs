package com.hx.cms.article;

import hx.ajax.AjaxExecute;
import hx.database.databean.Data;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.hx.cms.article.vo.Article;

public class AjaxSkipDescAction extends AjaxExecute{
	
	private static Log log = UtilLog.getLog(AjaxSkipListAction.class);
	private ArticleHandler handler;
	
	@Override
	public boolean run(HttpServletRequest request) {
		handler = new ArticleHandler();
		//����ҳ������ID
		String id = getParameter("ID",request);
	    Connection conn = null;
	    StringBuffer json = new StringBuffer();
	    Data data = null;
	    try {
	        conn = ConnectionManager.getConnection();
	        
	        if(id != null && !"".equals(id)){
	        	Data data2 = new Data();
	        	data2.setEntityName(Article.ARTICLE_ENTITY);
	        	data2.setPrimaryKey(Article.ID);
	        	data2.add(Article.ID, id);
	            //���ͨ��������
	        	data2.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
	            //��ѯ
	            data = handler.findDataByKey(conn,data2);
	        }
	        if(data != null){
	        	json.append(data.getString(Article.CONTENT));
	        }
	        setReturnValue(json.toString());
	    } catch (Exception e) {
	        log.logError("תȥ�޸��ڲ�����ʱ����!", e);
	        return false;
	    } finally {
	        try {
	            if (conn != null && !conn.isClosed()) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            log.logError("תȥ�޸��ڲ�����ʱ�ر�Connection����!", e);
	        }
	    }
	    return true;
	}
}
