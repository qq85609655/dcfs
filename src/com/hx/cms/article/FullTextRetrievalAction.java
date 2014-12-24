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
 * @Description: ��Ŀ<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-11-22 ����01:33:46
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FullTextRetrievalAction extends BaseAction {
    
    private static Log log = UtilLog.getLog(FullTextRetrievalAction.class);

    private FullTextRetrievalHandler handler;
    
    /**
     * ��ʼ��
     */
    public FullTextRetrievalAction() {
        handler = new FullTextRetrievalHandler();
    }

    /**
     * ȫ�ļ���
     * @return
     */
    public String search(){
        
        //��ҳ��ʾ
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        
        //��ҳ��ʼ
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
        //��ҳ����
        
        //�õ���ǰ�������֯������idֵ����Ϊ���ӻ����ĸ�ID���в�ѯ���õ����е�ǰ�������¼�
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //���ͨ��������
        data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
        //ȫ�ļ���
        data.add(Article.CONTENT, getParameter(Article.CONTENT));
        
        //��������
        String searchType = getParameter("SEARCH_TYPE");
        setAttribute(Article.SEARCH_TYPE, searchType);
        //ȫ��
        if("1".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.CONTENT);
        }
        //����
        if("2".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.TITLE);
        }
        
        Connection conn = null;
        DataList dataList = new DataList();
        DataList channelList = new DataList(); //����select�е�������Ŀ
        try {
            conn = ConnectionManager.getConnection();
            dataList = handler.findBySQL(conn, data, pageSize, page);
            channelList = handler.findChannelsBySQL(conn);
        } catch (Exception e) {
            log.logError("ȫ�ļ���ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("ȫ�ļ���ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute(Article.CHANNEL_ID, channelId);
        setAttribute(Article.CONTENT, getParameter(Article.CONTENT));
        //����
        setAttribute("dataList", dataList);
        setAttribute("channelList", channelList);
        return SUCCESS;
    }
    
    /**
     * ȫ�ļ���:����
     * @return
     */
    public String searchNei(){
        
        //��ҳ��ʾ
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        
        //��ҳ��ʼ
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
        //��ҳ����
        
        //�õ���ǰ�������֯������idֵ����Ϊ���ӻ����ĸ�ID���в�ѯ���õ����е�ǰ�������¼�
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //���ͨ��������
        data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
        //ȫ�ļ���
        data.add(Article.CONTENT, getParameter(Article.CONTENT));
        
        //��������
        String searchType = getParameter("SEARCH_TYPE");
        setAttribute(Article.SEARCH_TYPE, searchType);
        //ȫ��
        if("1".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.CONTENT);
        }
        //����
        if("2".equals(searchType)){
            data.add(Article.SEARCH_TYPE, Article.TITLE);
        }
        
        Connection conn = null;
        DataList dataList = new DataList();
        DataList channelList = new DataList(); //����select�е�������Ŀ
        
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        //�û��ܼ�
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
            log.logError("ȫ�ļ���ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("ȫ�ļ���ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute(Article.CHANNEL_ID, channelId);
        setAttribute(Article.CONTENT, getParameter(Article.CONTENT));
        //����
        setAttribute("dataList", dataList);
        setAttribute("channelList", channelList);
        return SUCCESS;
    }
    
    /**
     * �������ڲ�������ŵķ���ͳ��
     * @return
     */
	public String publishStat(){
        //ͳ�����
    	String statType = getParameter("STAT_TYPE");
    	setAttribute("STAT_TYPE", statType);
    	String beginTime = getParameter("Search_BEGIN_TIME");
    	String endTime = getParameter("Search_END_TIME");
    	//��ʼ����ʱ��
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
            log.logError("ȫ�ļ���ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("ȫ�ļ���ʱ�ر�Connection����!", e);
            }
        }
        
        //����
        setAttribute("dataList", dataList);
        return SUCCESS;
    }
    
    /**
     * δʵ��
     */
    public String execute() throws Exception {
        return "default";
    }
}
