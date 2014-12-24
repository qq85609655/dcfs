package com.hx.cms.article;

import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;

import com.hx.cms.article.vo.Article;

public class FullTextRetrievalHandler extends BaseHandler {
	
	private IDataExecute ide;

	/**
	 * 暂存（两个状态）和审核（两个状态）列表查询
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @return
	 * @throws Exception 
	 */
    public DataList findBySQL(Connection conn, Data data,int pageSize, int page) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        
        if("0".equals(data.getString(Article.CHANNEL_ID))){
            return ide.find(getSql("findAllBySQL",data.getString(Article.SEARCH_TYPE),data.getString(Article.CONTENT)), pageSize, page); 
        }else{
            return ide.find(getSql("findBySQL",data.getString(Article.SEARCH_TYPE),data.getString(Article.CONTENT),data.getString(Article.CHANNEL_ID)), pageSize, page);
        }
    }
    
    /**
     * 内网使用：加入密级过滤
     * @param conn
     * @param data
     * @param pageSize
     * @param page
     * @return
     * @throws Exception
     */
    public DataList findBySQL(Connection conn, Data data,int pageSize, int page, int securityLevel) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        
        if("0".equals(data.getString(Article.CHANNEL_ID))){
            return ide.find(getSql("findAllBySQL",data.getString(Article.SEARCH_TYPE),data.getString(Article.CONTENT),securityLevel==-1?null:securityLevel), pageSize, page); 
        }else{
            return ide.find(getSql("findBySQL",data.getString(Article.SEARCH_TYPE),data.getString(Article.CONTENT),data.getString(Article.CHANNEL_ID),securityLevel==-1?null:securityLevel), pageSize, page);
        }
    }
    
    /**
     * 查询所有栏目
     * @param conn
     * @return
     * @throws Exception
     */
    public DataList findChannelsBySQL(Connection conn) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findChannelsSQL"));
    }

    /**
     * 发布统计
     * @param beginTime
     * @param endTime
     * @param conn
     * @return
     * @throws Exception
     */
	public DataList findStatPersonList(Data data, Connection conn) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findStatListOfPersonBySQL",data.getString("BEGIN_TIME"),data.getString("END_TIME")));
	}
	public DataList findStatChannelList(Data data, Connection conn) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findStatListOfChannelBySQL",data.getString("BEGIN_TIME"),data.getString("END_TIME")));
	}
	
	
}