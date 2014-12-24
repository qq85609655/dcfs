package com.hx.cms.article;

import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import com.hx.cms.article.vo.Article;
import com.hx.framework.authenticate.UserInfo;

/**
 * 
 * @Title: ArticleAction.java
 * @Description: 栏目<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-11-22 上午01:33:46
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FullTextRetrievalAction extends BaseAction {
    
    private static Log log = UtilLog.getLog(FullTextRetrievalAction.class);

    private FullTextRetrievalHandler handler;
    
    /**
     * 初始化
     */
    public FullTextRetrievalAction() {
        handler = new FullTextRetrievalHandler();
    }

    /**
     * 全文检索
     * @return
     */
    public String search(){
        
        //分页显示
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        String cur_page = getParameter(formId+"_page");
        int page = 1;
        try {
            page = Integer.parseInt(cur_page);
        } catch (Exception e) {
            page = 1;
        }
        //分页结束
        
        //得到当前点击的组织机构的id值，作为它子机构的父ID进行查询，得到所有当前机构的下级
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //审核通过的文章
        data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
        //全文检索
        data.add(Article.CONTENT, getParameter(Article.CONTENT));
        
        //检索类型
        String searchType = getParameter("SEARCH_TYPE");
        setAttribute(Article.SEARCH_TYPE, searchType);
        //全文
        if("1".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.CONTENT);
        }
        //标题
        if("2".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.TITLE);
        }
        
        Connection conn = null;
        DataList dataList = new DataList();
        DataList channelList = new DataList(); //下拉select中的所有栏目
        try {
            conn = ConnectionManager.getConnection();
            dataList = handler.findBySQL(conn, data, pageSize, page);
            channelList = handler.findChannelsBySQL(conn);
        } catch (Exception e) {
            log.logError("全文检索时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("全文检索时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        setAttribute(Article.CONTENT, getParameter(Article.CONTENT));
        //传参
        setAttribute("dataList", dataList);
        setAttribute("channelList", channelList);
        return SUCCESS;
    }
    
    /**
     * 全文检索:内网
     * @return
     */
    public String searchNei(){
        
        //分页显示
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        String cur_page = getParameter(formId+"_page");
        int page = 1;
        try {
            page = Integer.parseInt(cur_page);
        } catch (Exception e) {
            page = 1;
        }
        //分页结束
        
        //得到当前点击的组织机构的id值，作为它子机构的父ID进行查询，得到所有当前机构的下级
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //审核通过的文章
        data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
        //全文检索
        data.add(Article.CONTENT, getParameter(Article.CONTENT));
        
        //检索类型
        String searchType = getParameter("SEARCH_TYPE");
        setAttribute(Article.SEARCH_TYPE, searchType);
        //全文
        if("1".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.CONTENT);
        }
        //标题
        if("2".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.TITLE);
        }
        
        Connection conn = null;
        DataList dataList = new DataList();
        DataList channelList = new DataList(); //下拉select中的所有栏目
        
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        //用户密级
        String secid=user.getPerson().getSecretLevel();
        int secLevel = -1;
        if(secid != null && !"".equals(secid)){
        	secLevel = Integer.parseInt(secid);
        }
        
        try {
            conn = ConnectionManager.getConnection();
            dataList = handler.findBySQL(conn, data, pageSize, page, secLevel);
            channelList = handler.findChannelsBySQL(conn);
        } catch (Exception e) {
            log.logError("全文检索时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("全文检索时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        setAttribute(Article.CONTENT, getParameter(Article.CONTENT));
        //传参
        setAttribute("dataList", dataList);
        setAttribute("channelList", channelList);
        return SUCCESS;
    }
    
    /**
     * 内外网内部刊物、新闻的发布统计
     * @return
     */
	public String publishStat(){
        //统计类别
    	String statType = getParameter("STAT_TYPE");
    	setAttribute("STAT_TYPE", statType);
    	String beginTime = getParameter("Search_BEGIN_TIME");
    	String endTime = getParameter("Search_END_TIME");
    	//开始结束时间
    	Data data = new Data();
    	if(beginTime == null){
    		data.add("BEGIN_TIME", "");
    	}else{
    		data.add("BEGIN_TIME", beginTime);
    	}
    	if(endTime == null){
    		data.add("END_TIME", "");
    	}else{
    		data.add("END_TIME", endTime);
    	}
    	setAttribute("data",data);
    	
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            if("1".equals(statType)){
            	dataList = handler.findStatPersonList(data,conn);
            }
            if("2".equals(statType)){
            	dataList = handler.findStatChannelList(data,conn);
            }
            int count = 0;
            if(dataList != null && dataList.size() >0){
            	for (int i = 0; i < dataList.size(); i++) {
					Data data2 = dataList.getData(i);
					int cu = data2.getInt("COUNT_NUM");
					count += cu;
				}
            }
            setAttribute("totalCount", count);
        } catch (Exception e) {
            log.logError("全文检索时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("全文检索时关闭Connection出错!", e);
            }
        }
        
        //传参
        setAttribute("dataList", dataList);
        return SUCCESS;
    }
    
    /**
     * 未实现
     */
    public String execute() throws Exception {
        return "default";
    }
}
