package com.hx.cms.article;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;

import java.sql.Connection;
import java.util.List;

import com.hx.cms.article.vo.Article;
import com.hx.cms.article.vo.AuditOpinion;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.OrganHandler;
import com.hx.framework.person.vo.Person;
import com.hx.framework.sdk.PersonHelper;

public class ArticleHandler extends BaseHandler {
	
	private IDataExecute ide;

	/**
	 * 添加
	 * @param data
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public Data add(Connection conn, Data data) throws Exception{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.create(data);
	}

	/**
	 * 分页查询
	 * @param conn
	 * @param pageSize
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public DataList findArticlesPage(Connection conn, int pageSize, int page) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findArticleSQL"), pageSize, page);
	}

	/**
	 * 根据主键查询
	 * @param conn
	 * @param data
	 * @return
	 * @throws Exception 
	 */
	public Data findDataByKey(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.findByPrimaryKey(data);
	}

	/**
	 * 删除
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public void delete(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(data);
	}

	/**
	 * 批量删除
	 * @param conn
	 * @param dataList
	 * @throws Exception 
	 */
	public void deleteBatch(Connection conn, DataList dataList) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		ide.remove(dataList);
	}

	/**
	 * 修改
	 * @param conn
	 * @param data
	 * @throws Exception 
	 */
	public Data modify(Connection conn, Data data) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.store(data);
	}

	/**
	 * 查询对应栏目下边的文章
	 * @param conn
	 * @param channelIds 
	 * @param data
	 * @param pageSize
	 * @param page
	 * @return
	 * @throws Exception 
	 */
	public DataList findArticlesOfChannel(Connection conn, String channelIds, Data data,
			int pageSize, int page, String orderString, Data searchData) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		UserInfo ui = SessionInfo.getCurUser();
        String personId = ui.getPerson().getPersonId();
        String level = ui.getPerson().getSecretLevel();
		//System.out.println(getSql("findArticleOfChannelBySQL", channelIds, data.getString(Article.STATUS),null,searchData.getString(Article.TITLE),searchData.getString(Article.TITLE),searchData.getString(Article.STORE_STATUS),orderString,personId,level));
		return ide.find(getSql("findArticleOfChannelBySQL", channelIds, data.getString(Article.STATUS),null,searchData.getString(Article.TITLE),searchData.getString(Article.TITLE),searchData.getString(Article.STORE_STATUS),orderString,personId,level), pageSize, page);
	}

	/**
	 * 暂存（两个状态）和审核（两个状态）列表查询
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @return
	 * @throws Exception 
	 */
    public DataList findArticlesOfChannelBySQL(Connection conn, Data data,
            int pageSize, int page) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findArticlesOfChannelBySQL",data.getString(Article.CHANNEL_ID),data.getString("STATUS_1"),data.getString("STATUS_2")), pageSize, page);
    }
    
    public DataList findArticlesAllBySQL(Connection conn, Data data,
            int pageSize, int page, CodeList channelList,String orderString,Data searchData) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        String channelId = data.getString(Article.CHANNEL_ID);
        StringBuffer channelIds = new StringBuffer();
        if(!"0".equals(channelId)){
    		channelIds.append("'").append(channelId).append("'");
    	}else{
    		if(channelList != null & channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
    				Code channel = channelList.get(i);
    				if(i != (channelList.size() - 1)){
    					channelIds.append("'").append(channel.getValue()).append("'").append(",");
    				}else{
    					channelIds.append("'").append(channel.getValue()).append("'");
    				}
    			}
        	}else{
        		channelIds.append("''");
        	}
    	}
        UserInfo ui = SessionInfo.getCurUser();
        String personId = ui.getPerson().getPersonId();
        String level = ui.getPerson().getSecretLevel();
        String STATUS = searchData.getString(Article.STATUS);
        if("".equals(STATUS)){
            STATUS = null;
        }
        //System.out.println(getSql("findArticlesAllBySQL",channelIds.toString(),searchData.getString(Article.TITLE),STATUS,searchData.getString(Article.TITLE),STATUS,searchData.getString(Article.STORE_STATUS),orderString,personId,level));
        return ide.find(getSql("findArticlesAllBySQL",channelIds.toString(),searchData.getString(Article.TITLE),STATUS,searchData.getString(Article.TITLE),STATUS,searchData.getString(Article.STORE_STATUS),orderString,personId,level), pageSize, page);
    }

    public DataList findAllAuditArticlesBySQL(Connection conn, Data data,
            int pageSize, int page) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("findAllAuditArticlesBySQL",data.getString("STATUS_1"),data.getString("STATUS_2")), pageSize, page);
    }
    
    public DataList findAllAuditArticlesBySQL(Connection conn, Data data,
    		int pageSize, int page, CodeList channelList, String orderString, Data searchData) throws Exception {
    	ide = DataBaseFactory.getDataBase(conn);
    	
    	String channelId = data.getString(Article.CHANNEL_ID);
    	StringBuffer channelIds = new StringBuffer();
    	 if(!"0".equals(channelId)){
     		channelIds.append("'").append(channelId).append("'");
     	}else{
     		if(channelList != null & channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
    				Code channel = channelList.get(i);
    				if(i != (channelList.size() - 1)){
    					channelIds.append("'").append(channel.getValue()).append("'").append(",");
    				}else{
    					channelIds.append("'").append(channel.getValue()).append("'");
    				}
    			}
        	}else{
        		channelIds.append("''");
        	}
     	}
    	 UserInfo ui = SessionInfo.getCurUser();
    	 String personId = ui.getPerson().getPersonId();
         String level = ui.getPerson().getSecretLevel();
         String STATUS_1 = data.getString("STATUS_1");
         String channels = channelIds.toString();
         String title = searchData.getString(Article.TITLE);
         if("".equals(title)){
             title = null;
         }
         String sql = getSql("findAllAuditArticlesOfChannelsBySQL",STATUS_1,channels,personId,level,title,orderString);
    	//System.out.println(getSql("findAllAuditArticlesOfChannelsBySQL",data.getString("STATUS_1"),data.getString("STATUS_2"),channelIds.toString(),personId,level,searchData.getString(Article.TITLE),orderString));
    	return ide.find(sql, pageSize, page);
    }

	public DataList findAuditOpinionOfArt(Connection conn, Data art) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findAuditOpinionOfArtBySQL",art.getString(AuditOpinion.ARTICLE_ID)));
	}

	public DataList findSkipList(Connection conn, Data data, String orderString) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findArticleOfChannelBySQL", data.getString(Article.CHANNEL_ID), data.getString(Article.STATUS),data.getString(Article.IS_SKIP),null,null,null,orderString));
	}
	
	public DataList findListByData(Connection conn, Data data) throws Exception{
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(data);
	}

    public DataList findPersonalArticlesAllBySQL(Connection conn, Data data, int pageSize, int page,
            CodeList channelList, String orderString, Data searchData, String personId) throws Exception {
        ide = DataBaseFactory.getDataBase(conn);
        String channelId = data.getString(Article.CHANNEL_ID);
        StringBuffer channelIds = new StringBuffer();
        if(!"0".equals(channelId)){
            channelIds.append("'").append(channelId).append("'");
        }else{
            if(channelList != null & channelList.size() > 0){
                for (int i = 0; i < channelList.size(); i++) {
                    Code channel = channelList.get(i);
                    if(i != (channelList.size() - 1)){
                        channelIds.append("'").append(channel.getValue()).append("'").append(",");
                    }else{
                        channelIds.append("'").append(channel.getValue()).append("'");
                    }
                }
            }else{
                channelIds.append("''");
            }
        }
        //System.out.println(getSql("findPersonalArticlesAllBySQL",channelIds.toString(),searchData.getString(Article.TITLE),searchData.getString(Article.STATUS),searchData.getString(Article.TITLE),searchData.getString(Article.STATUS),personId,searchData.getString(Article.STORE_STATUS),orderString));
        return ide.find(getSql("findPersonalArticlesAllBySQL",channelIds.toString(),searchData.getString(Article.TITLE),searchData.getString(Article.STATUS),searchData.getString(Article.TITLE),searchData.getString(Article.STATUS),personId,searchData.getString(Article.STORE_STATUS),orderString), pageSize, page);
    }

    public CodeList findPersons(Connection conn) {
        CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("findPersonsBySQL"));
        return codeList;
    }
    public CodeList findOrgans(Connection conn) {
        CodeList codeList = new CodeList();
        codeList = UtilCode.getCodeListBySql(conn, getSql("findOrgansBySQL"));
        return codeList;
    }

	public DataList findNoticeList(Connection conn, Data searchData,
			int pageSize, int page, String orderString) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		return ide.find(getSql("findNoticeListBySQL"), pageSize, page);
	}
	
	/**
     * 查询指定频道的文章列表 ------ 为DataAccess（数据权限）提供数据 	前台
     * @return
     * @throws Exception
     */
    public DataList findArtOfChannelForDataAccess(Connection conn, String channelId, Data searchData, String orderString, int pageSize, int page, String personId, String organId) throws Exception{
        DataList dataList = new DataList();
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        try {
        	//因为排序前边已经有按照置顶排序
        	if(orderString != null && !"".equals(orderString)){
        		orderString = "," + orderString;
        	}
            //主意STATUS = '3' 为查询所有发布状态的文章
            //dataList = ide.find("SELECT * FROM ((SELECT BODY_TEXT_ATT,PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM,SECURITY_LEVEL,PROTECT_PERIOD FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '3' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND DATA_ACCESS = '1') UNION ALL (SELECT BODY_TEXT_ATT,PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM,SECURITY_LEVEL,PROTECT_PERIOD FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '3' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND (ID IN(SELECT ARTICLE_ID FROM CMS_PERSON_ARTICLE_RELA WHERE PERSON_ID = '"+personId+"') OR ID IN(SELECT ARTICLE_ID FROM CMS_ORGAN_ARTICLE_RELA WHERE ORGAN_ID = '"+organId+"')))) T1 ORDER BY IS_TOP DESC, "+orderString.toString(),pageSize,page);
        	//System.out.println("findArtOfChannelForDataAccess:"+getSql("findArtOfChannelForDataAccessBySQL",channelId,personId,organId,orderString));
            dataList = ide.find(getSql("findArtOfChannelForDataAccessBySQL",channelId,personId,organId,searchData.getString("TITLE"),searchData.getString("B_CREATE_TIME"),searchData.getString("E_CREATE_TIME"),orderString),pageSize,page);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(ide != null){
                ide = null;
            }
        }
        return dataList;
    }
    
    /**
     * 查询指定频道的文章列表 前台
     */
    public DataList findArtOfChannel(Connection conn, String channelId, Data searchData, String orderString, int pageSize, int page) throws Exception{
        DataList dataList = new DataList();
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        try {
        	//因为排序前边已经有按照置顶排序
        	if(orderString != null && !"".equals(orderString)){
        		orderString = "," + orderString;
        	}
            //主意STATUS = '3' 为查询所有发布状态的文章
            //dataList = ide.find("SELECT BODY_TEXT_ATT,PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM,SECURITY_LEVEL,PROTECT_PERIOD FROM CMS_ARTICLE WHERE (CHANNEL_ID = '"+channelId+"' AND STATUS = '3') OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"') ORDER BY IS_TOP DESC, "+orderString.toString(),pageSize,page);
        	//System.out.println(getSql("findArtOfChannelBySQL",channelId,searchData.getString("TITLE"),searchData.getString("B_CREATE_TIME"),searchData.getString("E_CREATE_TIME"),orderString));
        	dataList = ide.find(getSql("findArtOfChannelBySQL",channelId,searchData.getString("TITLE"),searchData.getString("B_CREATE_TIME"),searchData.getString("E_CREATE_TIME"),orderString),pageSize,page);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(ide != null){
                ide = null;
            }
        }
        return dataList;
    }
    
    public CodeList findPersonsForLevelList(Connection conn, String personId) throws Exception{
    	CodeList codeList = new CodeList();
    	OrganHandler organHandler = new OrganHandler();
    	DataList organList = organHandler.generateTreeForLevel(conn, personId);
    	if(organList != null && organList.size() > 0){
			Data parent = organList.getData(0);
			String parentId = parent.getString("ORG_LEVEL_CODE");
			DataList organLists = organHandler.generateTreeForLevelList(conn, parentId);
			if(organLists != null && organLists.size() > 0){
				for (int i = 0; i < organLists.size(); i++) {
					Data data = organLists.getData(i);
					Code org = new Code();
					org.setName(data.getString("NAME"));
					org.setValue(data.getString("VALUE"));
					org.setParentValue(data.getString("PARENTVALUE"));
					codeList.add(org);
					List<Person> persons = PersonHelper.getPersonsOfOrgan(org.getValue());
					if(persons != null && persons.size() > 0){
						for (Person person : persons) {
							Code per  = new Code();
							per.setName(person.getCName());
							per.setValue(person.getPersonId());
							per.setParentValue(PersonHelper.getOrganOfPerson(person.getPersonId()).getId());
							codeList.add(per);
						}
					}
				}
			}
			
			//加入顶级
			Code p = new Code();
			p.setName(parent.getString("NAME"));
			p.setValue(parent.getString("VALUE"));
			p.setParentValue("0");
			codeList.add(p);
			//添加顶级对应人员
			List<Person> persons = PersonHelper.getPersonsOfOrgan(parent.getString("VALUE"));
			if(persons != null && persons.size() > 0){
				for (Person person : persons) {
					Code per  = new Code();
					per.setName(person.getCName());
					per.setValue(person.getPersonId());
					per.setParentValue(PersonHelper.getOrganOfPerson(person.getPersonId()).getId());
					codeList.add(per);
				}
			}
		}
    	return codeList;
    }

	public DataList findArticlesOfChannelFor1nMode(Connection conn, Data data,
			String orgLevelCode, int pageSize, int page, String orderString,
			Data searchData) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
		//System.out.println(getSql("findArticleOfChannelBySQL", data.getString(Article.CHANNEL_ID), data.getString(Article.STATUS),null,searchData.getString(Article.TITLE),searchData.getString(Article.TITLE),searchData.getString(Article.STORE_STATUS),orderString));
		return ide.find(getSql("findArticleOfChannelFor1nModeBySQL", data.getString(Article.CHANNEL_ID), data.getString(Article.STATUS),null,searchData.getString(Article.TITLE),orgLevelCode,data.getString(Article.CHANNEL_ID),searchData.getString(Article.TITLE),orgLevelCode,searchData.getString(Article.STORE_STATUS),orderString), pageSize, page);
	}

	public DataList findArticlesAllFor1nModeBySQL(Connection conn, Data data,
			String orgLevelCode, int pageSize, int page, CodeList channelList,
			String orderString, Data searchData) throws Exception {
		ide = DataBaseFactory.getDataBase(conn);
        String channelId = data.getString(Article.CHANNEL_ID);
        StringBuffer channelIds = new StringBuffer();
        if(!"0".equals(channelId)){
    		channelIds.append("'").append(channelId).append("'");
    	}else{
    		if(channelList != null & channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
    				Code channel = channelList.get(i);
    				if(i != (channelList.size() - 1)){
    					channelIds.append("'").append(channel.getValue()).append("'").append(",");
    				}else{
    					channelIds.append("'").append(channel.getValue()).append("'");
    				}
    			}
        	}else{
        		channelIds.append("''");
        	}
    	}
        return ide.find(getSql("findArticlesAllFor1nModeBySQL",channelIds.toString(),searchData.getString(Article.TITLE),searchData.getString(Article.STATUS),orgLevelCode,channelIds.toString(),searchData.getString(Article.TITLE),searchData.getString(Article.STATUS),orgLevelCode,searchData.getString(Article.STORE_STATUS),orderString), pageSize, page);
	}

    public DataList getChannels(Connection conn, String channelId) throws DBException {
        ide = DataBaseFactory.getDataBase(conn);
        UserInfo ui = SessionInfo.getCurUser();
        String personId = ui.getPerson().getPersonId();
        String sql = getSql("getChannels", channelId,personId);
        DataList dl = ide.find(sql);
        return dl;
    }

    public DataList getChannelIdsOfArticle(Connection conn, String id) throws DBException {
        ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getChannelIdsOfArticle", id);
        DataList dl = ide.find(sql);
        return dl;
    }

    public DataList findReceiptList(Connection conn, String orgId,String compositor, String ordertype) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        UserInfo ui = SessionInfo.getCurUser();
        String level = ui.getPerson().getSecretLevel();
        String sql = getSql("findReceiptList",orgId,level ,compositor,ordertype);
        DataList dl = ide.find(sql);
        return dl;
    }

    public Data getArticle(Connection conn, String iD) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("getArticle",iD);
        DataList dl = ide.find(sql);
        return dl.getData(0);
    }

    public DataList findReceiptContent(Connection conn, String id, String personId) throws DBException {
        ide = DataBaseFactory.getDataBase(conn);
        String sql = getSql("findReceiptContent", id, personId);
        DataList dl = ide.find(sql);
        return dl;
    }

    public void receiptSave(Connection conn, Data data) throws DBException {
        Data dataadd = new Data(data);
        dataadd.setConnection(conn);
        dataadd.setEntityName("CMS_ARTICLE_RECEIPT");
        dataadd.setPrimaryKey("UUID");
        dataadd.create();
    }
}
