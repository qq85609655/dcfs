package com.hx.cms.tags.handler;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.database.transaction.DBTransaction;

import java.sql.Connection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.hx.cms.article.vo.Article;
import com.hx.cms.channel.vo.Channel;
import com.hx.framework.role.vo.Role;

public class CmsTagHandler extends BaseHandler{
    
    /**
     * ��ѯָ��Ƶ���������б�
     * @param conn
     *          ����
     * @param channelId
     *          Ƶ��ID
     * @param orderName
     *          �����ֶ�
     * @param orderType
     *          ��������
     * @param length
     *          �б������б��С
     * @param page
     *          ��ǰҳ
     * @param pageSize
     *          ��ҳ��С
     * @param type ���ͣ�
     *          pageΪ��ҳ����
     *          simpleΪ����ҳ����
     * @return
     * @throws Exception
     */
    public static DataList findArticleOfChannel(Connection conn, String channelId, String orderName, String orderType, int length, int page, int pageSize, String type, int securityLevel, boolean updateChannelId) throws Exception{
        DataList dataList = new DataList();
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DBTransaction db = DBTransaction.getInstance(conn);
        try {
            
            //���򷽰�
            StringBuffer orderString = new StringBuffer();
            if(orderName != null && !"".equals(orderName) && orderType != null && !"".equals(orderType)){
                if(orderName.contains(";") && orderType.contains(";")){
                    String[] orderNames = orderName.split(";");
                    String[] orderTypes = orderType.split(";");
                    for (int i = 0; i < orderNames.length; i++) {
                        if(i == (orderNames.length - 1)){
                            orderString.append(orderNames[i]).append(" ").append(orderTypes[i]);
                        }else{
                            orderString.append(orderNames[i]).append(" ").append(orderTypes[i]).append(",");
                        }
                    }
                }else{
                    orderString.append(orderName).append(" ").append(orderType);
                }
            }else{
                orderString.append("CREATE_TIME DESC");
            }
            
            String strLength = null;
            if(length != 0 && length != Integer.MAX_VALUE){
                strLength = String.valueOf(length);
            }
            
            //����STATUS = '3' Ϊ��ѯ���з���״̬������
            String orderStr = orderString.toString();
            if(orderStr != null && !"".equals(orderStr) && !"".equals(orderStr.trim())){
            	orderStr = "," + orderStr;
            }
            
            
            String[] channelIds = channelId.split(",");
            StringBuffer channelStrBuf = new StringBuffer();
            if(channelIds != null){
            	for (int i = 0; i < channelIds.length; i++) {
					String _channelId = channelIds[i];
					if(i == 0){
						channelStrBuf.append("'").append(_channelId).append("'");
					}else{
						channelStrBuf.append(",").append("'").append(_channelId).append("'");
					}
					
					//����order_seq_num
					if(updateChannelId){
						Data data = new Data();
						data.setEntityName(Channel.CHANNEL_ENTITY);
						data.setPrimaryKey(Channel.ID);
						data.add(Channel.ID, _channelId);
						data.add(Channel.ORDER_SEQ_NUM, i+1);
						ide.store(data);
					}
				}
            }
            
            String isOrderSeqNum = null;
            if(updateChannelId){
            	isOrderSeqNum = "isNotNull";
            	db.commit();
            }
            
            if("page".equals(type)){
            	//System.out.println("page:"+"select PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM from CMS_ARTICLE where CHANNEL_ID = '"+channelId+"' and STATUS = '3' ORDER BY IS_TOP DESC, "+orderString.toString());
            	//System.out.println("findArticleOfChannelPageBySQL:"+getSql("findArticleOfChannelPageBySQL", new CmsTagHandler(),channelId,securityLevel,channelId,orderStr));
                dataList = ide.find(getSql("findArticleOfChannelPageBySQL", new CmsTagHandler(),channelStrBuf.toString(),securityLevel,channelStrBuf.toString(),isOrderSeqNum,orderStr),pageSize,page);
            }
            
            if("simple".equals(type) || "".equals(type)){
            	//System.out.println(getSql("findArticleOfChannelSimpleBySQL", new CmsTagHandler(),strLength,channelId,securityLevel,channelId,orderStr));
                dataList = ide.find(getSql("findArticleOfChannelSimpleBySQL", new CmsTagHandler(),strLength,channelStrBuf.toString(),securityLevel,channelStrBuf.toString(),orderStr));
            }
        } catch (Exception e) {
        	db.rollback();
            e.printStackTrace();
        } finally {
            if(ide != null){
                ide = null;
            }
        }
        return dataList;
    }
    
    /**
     * ��ѯָ��Ƶ���������б� ------ ΪDataAccess������Ȩ�ޣ��ṩ����
     * @param conn
     *          ����
     * @param channelId
     *          Ƶ��ID
     * @param orderName
     *          �����ֶ�
     * @param orderType
     *          ��������
     * @param length
     *          �б������б��С
     * @param page
     *          ��ǰҳ
     * @param pageSize
     *          ��ҳ��С
     * @param type ���ͣ�
     *          pageΪ��ҳ����
     *          simpleΪ����ҳ����
     * @return
     * @throws Exception
     */
    public static DataList findArticleOfChannelForDataAccess(Connection conn, String channelId, String orderName, String orderType, int length, int page, int pageSize, String type, int securityLevel, String personId, String organId, boolean updateChannelId) throws Exception{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        DBTransaction db = DBTransaction.getInstance(conn);
        DataList dataList = new DataList();
        try {
            
            /******************���� ��ʼ***********************/
            StringBuffer orderString = new StringBuffer();
            if(orderName != null && !"".equals(orderName) && orderType != null && !"".equals(orderType)){
                if(orderName.contains(";") && orderType.contains(";")){
                    String[] orderNames = orderName.split(";");
                    String[] orderTypes = orderType.split(";");
                    for (int i = 0; i < orderNames.length; i++) {
                        if(i == (orderNames.length - 1)){
                            orderString.append(orderNames[i]).append(" ").append(orderTypes[i]);
                        }else{
                            orderString.append(orderNames[i]).append(" ").append(orderTypes[i]).append(",");
                        }
                    }
                }else{
                    orderString.append(orderName).append(" ").append(orderType);
                }
            }else{
                orderString.append("CREATE_TIME DESC");
            }
            /******************���� ����***********************/
            
            String strLength = null;
            if(length != 0 && length != Integer.MAX_VALUE){
                strLength = String.valueOf(length);
            }
            
            //����STATUS = '3' Ϊ��ѯ���з���״̬������
            String orderStr = orderString.toString();
            if(orderStr != null && !"".equals(orderStr) && !"".equals(orderStr.trim())){
            	orderStr = "," + orderStr;
            }
            
            String[] channelIds = channelId.split(",");
            StringBuffer channelStrBuf = new StringBuffer();
            if(channelIds != null){
            	for (int i = 0; i < channelIds.length; i++) {
					String _channelId = channelIds[i];
					if(i == 0){
						channelStrBuf.append("'").append(_channelId).append("'");
					}else{
						channelStrBuf.append(",").append("'").append(_channelId).append("'");
					}
					
					//����order_seq_num
					if(updateChannelId){
						Data data = new Data();
						data.setEntityName(Channel.CHANNEL_ENTITY);
						data.setPrimaryKey(Channel.ID);
						data.add(Channel.ID, _channelId);
						data.add(Channel.ORDER_SEQ_NUM, i+1);
						ide.store(data);
					}
				}
            }
            //�ύ����order_seq_num
            String isOrderSeqNum = null;
            if(updateChannelId){
            	isOrderSeqNum = "isNotNull";
            	db.commit();
            }
            
            if("page".equals(type)){
                //System.out.println("SELECT * FROM ((SELECT BODY_TEXT_ATT,PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM,SECURITY_LEVEL,PROTECT_PERIOD FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '3' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND DATA_ACCESS = '1') UNION ALL (SELECT BODY_TEXT_ATT,PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM,SECURITY_LEVEL,PROTECT_PERIOD FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '3' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND (ID IN(SELECT ARTICLE_ID FROM CMS_PERSON_ARTICLE_RELA WHERE PERSON_ID = '"+personId+"') OR ID IN(SELECT ARTICLE_ID FROM CMS_ORGAN_ARTICLE_RELA WHERE ORGAN_ID = '"+organId+"')))) T1 ORDER BY IS_TOP DESC, "+orderString.toString());
            	//System.out.println("findArticleOfChannelForDataAccessPageBySQL:"+getSql("findArticleOfChannelForDataAccessPageBySQL", new CmsTagHandler(),channelId,securityLevel,channelId,securityLevel,channelId,personId,organId,orderStr));
                dataList = ide.find(getSql("findArticleOfChannelForDataAccessPageBySQL", new CmsTagHandler(),channelStrBuf.toString(),securityLevel,channelStrBuf.toString(),securityLevel,channelStrBuf.toString(),personId,organId,isOrderSeqNum,orderStr),pageSize,page);
            }
            if("simple".equals(type) || "".equals(type)){
                //System.out.println("SELECT * FROM ((SELECT TOP "+length+" BODY_TEXT_ATT,PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM,SECURITY_LEVEL,PROTECT_PERIOD FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '3' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND DATA_ACCESS = '1') UNION ALL (SELECT TOP "+length+" BODY_TEXT_ATT,PACKAGE_ID,ID,CONTENT,CHANNEL_ID,TEMPLATE_ID,WEBSITE_ID,TITLE,SHORT_TITLE,SOURCE,IS_NEW,NEW_TIME,IS_TOP,TOP_TIME,CREATE_TIME,CREATOR,MODIFY_TIME,SEQ_NUM,ATT_ICON,ATT_DESC,DOWN_NUM,SECURITY_LEVEL,PROTECT_PERIOD FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '3' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND (ID IN(SELECT ARTICLE_ID FROM CMS_PERSON_ARTICLE_RELA WHERE PERSON_ID = '"+personId+"') OR ID IN(SELECT ARTICLE_ID FROM CMS_ORGAN_ARTICLE_RELA WHERE ORGAN_ID = '"+organId+"')))) T1 ORDER BY IS_TOP DESC, "+orderString.toString());
            	//System.out.println("findArticleOfChannelForDataAccessSimpleBySQL:"+getSql("findArticleOfChannelForDataAccessSimpleBySQL", new CmsTagHandler(),strLength,channelId,securityLevel,channelId,strLength,channelId,securityLevel,channelId,personId,organId,orderStr));
                dataList = ide.find(getSql("findArticleOfChannelForDataAccessSimpleBySQL", new CmsTagHandler(),strLength,channelStrBuf.toString(),securityLevel,channelStrBuf.toString(),strLength,channelStrBuf.toString(),securityLevel,channelStrBuf.toString(),personId,organId,orderStr));
            }
        } catch (Exception e) {
        	db.rollback();
            e.printStackTrace();
        } finally {
            if(ide != null){
                ide = null;
            }
        }
        return dataList;
    }
    
    /**
     * ͳ����Ŀ�±�"�ѷ���"����������
     * @param conn
     * @param infoId
     * @return
     */
    public static int statChannel(Connection conn, Data data, int securityLevel) throws Exception{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        //System.out.println("statChannelBySQL:"+getSql("statChannelBySQL", new CmsTagHandler(),data.getString(Channel.ID),securityLevel,data.getString(Channel.ID)));
        DataList dataList = ide.find(getSql("statChannelBySQL", new CmsTagHandler(),data.getString(Channel.ID),securityLevel,data.getString(Channel.ID)));
        if(dataList != null && dataList.size() > 0){ 
            return dataList.getData(0).getInt("COUNT");
        }
        return 0;
    }

    /**
     * ��ѯ����
     * @param conn
     * @param channelId
     * @return
     * @throws Exception
     */
    public static DataList findArticleOfChannelPageTatal(Connection conn,
            String channelId, int securityLevel) throws Exception {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        //SELECT COUNT(*) COUNT FROM CMS_ARTICLE WHERE (CHANNEL_ID = '"+channelId+"' AND STATUS = '"+Article.STATUS_PASS_AUDIT+"' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')
        //System.out.println("findArticleOfChannelPageTatalBySQL:"+getSql("findArticleOfChannelPageTatalBySQL", new CmsTagHandler(),channelId,Article.STATUS_PASS_AUDIT,securityLevel,channelId));
        String[] channelIds = channelId.split(",");
        int count = 0;
        if(channelIds != null){
        	for (int i = 0; i < channelIds.length; i++) {
				String _channelId = channelIds[i];
				DataList dataList = ide.find(getSql("findArticleOfChannelPageTatalBySQL", new CmsTagHandler(),_channelId,Article.STATUS_PASS_AUDIT,securityLevel,_channelId));
				if(dataList !=null && dataList.size() > 0){
					Data d = dataList.getData(0);
					count += d.getInt("COUNT");
				}
			}
        }
        Data data = new Data();
        data.add("COUNT", count);
        DataList list = new DataList();
        list.add(data);
        return list;
    }
    
    /**
     * ������Ȩ��ѯ������
     * @param conn
     * @param channelId
     * @param securityLevel
     * @return
     * @throws Exception
     */
    public static DataList findArticleOfChannelPageTatalForDataAccess(Connection conn,
            String channelId, int securityLevel, String personId, String organId) throws Exception {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        //System.out.println("SELECT SUM(COUNT) COUNT FROM ((SELECT COUNT(*) COUNT FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '"+Article.STATUS_PASS_AUDIT+"' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND DATA_ACCESS = '1') UNION ALL (SELECT COUNT(*) COUNT FROM CMS_ARTICLE WHERE ((CHANNEL_ID = '"+channelId+"' AND STATUS = '"+Article.STATUS_PASS_AUDIT+"' AND (SECURITY_LEVEL <= "+securityLevel+" OR SECURITY_LEVEL IS NULL)) OR ID IN(SELECT ARTICLE_ID FROM CMS_ARTICLE_TO_CHANNELS WHERE CHANNEL_ID = '"+channelId+"')) AND (ID IN(SELECT ARTICLE_ID FROM CMS_PERSON_ARTICLE_RELA WHERE PERSON_ID = '"+personId+"') OR ID IN(SELECT ARTICLE_ID FROM CMS_ORGAN_ARTICLE_RELA WHERE ORGAN_ID = '"+organId+"'))))) T1");
        //System.out.println("findArticleOfChannelPageTatalForDataAccess:"+getSql("findArticleOfChannelPageTatalForDataAccessBySQL", new CmsTagHandler(),channelId,Article.STATUS_PASS_AUDIT,securityLevel,channelId,Article.STATUS_PASS_AUDIT,securityLevel,channelId,personId,organId));
        String[] channelIds = channelId.split(",");
        int count = 0;
        if(channelIds != null){
        	for (int i = 0; i < channelIds.length; i++) {
				String _channelId = channelIds[i];
				DataList dataList = ide.find(getSql("findArticleOfChannelPageTatalForDataAccessBySQL", new CmsTagHandler(),_channelId,Article.STATUS_PASS_AUDIT,securityLevel,_channelId,Article.STATUS_PASS_AUDIT,securityLevel,_channelId,personId,organId));
				if(dataList !=null && dataList.size() > 0){
					Data d = dataList.getData(0);
					count += d.getInt("COUNT");
				}
			}
        }
        Data data = new Data();
        data.add("COUNT", count);
        DataList list = new DataList();
        list.add(data);
        return list;
    }

    public static DataList findChannels(Connection conn, String channelId, String orderName, String orderType, int length, int page, int pageSize, String type) throws Exception{
        return findChannels(conn, channelId, orderName, orderType, length, page, pageSize, type, null);
    }
    
    /**
     * ��ȡ����ָ����ĿID������Ŀ
     * @param conn
     * @param channelId ����ĿID
     * @param orderName �����ֶ�
     * @param orderType ����ʽ
     * @param length ����
     * @param page ��ǰҳ
     * @param pageSize ÿҳ��С
     * @param type ��ѯ���ͣ���ҳ������ҳ
     * @param noStat ���ղ�ͳ����Ŀ����Ŀ��ID
     * @return
     * @throws Exception
     */
    public static DataList findChannels(Connection conn, String channelId, String orderName, String orderType, int length, int page, int pageSize, String type, String noStat) throws Exception{
        DataList dataList = new DataList();
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        try {
            
            //��ͳ������Ŀ���ֵ���ĿID
            StringBuffer nostatStr = new StringBuffer();
            String[] noStats = null;
            if(noStat != null && !"".equals(noStat)){
                noStats = noStat.split(";");
                if(noStats != null){
                    for (int i = 0; i < noStats.length; i++) {
                        String noStatId = noStats[i];
                        nostatStr.append("AND PARENT_ID != '").append(noStatId).append("' ");    
                    }
                }
            }
           
            //���򷽰�
            StringBuffer orderString = new StringBuffer();
            if(orderName != null && !"".equals(orderName) && orderType != null && !"".equals(orderType)){
                if(orderName.contains(";") && orderType.contains(";")){
                    String[] orderNames = orderName.split(";");
                    String[] orderTypes = orderType.split(";");
                    for (int i = 0; i < orderNames.length; i++) {
                        if(i == (orderNames.length - 1)){
                            orderString.append(orderNames[i]).append(" ").append(orderTypes[i]);
                        }else{
                            orderString.append(orderNames[i]).append(" ").append(orderTypes[i]).append(",");
                        }
                    }
                }else{
                    orderString.append(orderName).append(" ").append(orderType);
                }
            }else{
                orderString.append("CREATE_TIME DESC");
            }
            
            
            //����
            String strLength = null;
            if(length != 0 && length != Integer.MAX_VALUE){
                strLength = String.valueOf(length);
            }
            
            if("page".equals(type)){
            	//System.out.println("findChannelsPageBySQL:"+getSql("findChannelsPageBySQL", new CmsTagHandler(),nostatStr.toString(),channelId,orderString.toString()));
                dataList = ide.find(getSql("findChannelsPageBySQL", new CmsTagHandler(),nostatStr.toString(),channelId,orderString.toString()),pageSize,page);
            }
            
            if("simple".equals(type) || "".equals(type)){
            	//System.out.println("findChannelsSimpleBySQL:"+getSql("findChannelsSimpleBySQL", new CmsTagHandler(),strLength,nostatStr.toString(),channelId,orderString.toString()));
                dataList = ide.find(getSql("findChannelsSimpleBySQL", new CmsTagHandler(),strLength,nostatStr.toString(),channelId,orderString.toString()));
            }
            
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
     * ��ȡָ����ĿID������Ŀ
     * @param conn
     * @param channelId
     * @return
     * @throws Exception
     */
    public static DataList findChildrenOfChannel(Connection conn, String channelId) throws Exception{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        //System.out.println("findChildrenOfChannelBySQL:"+getSql("findChildrenOfChannelBySQL", new CmsTagHandler(),channelId));
        return ide.find(getSql("findChildrenOfChannelBySQL", new CmsTagHandler(),channelId));
    }
    
    /**
     * ��������ID��ѯ������Data����
     * @param conn
     * @param infoId
     * @return
     */
    public static Data findArticleById(Connection conn, Data data) throws Exception{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.findByPrimaryKey(data);
    }
    
    /**
     * ��ô��뼯�б�
     * @param conn
     * @param codeSortId
     * @return
     * @throws Exception
     */
    public static CodeList findCodeList(Connection conn, String codeSortId) throws Exception{
        return UtilCode.getCodeList(codeSortId, conn);
    }
    
    /**
     * ��ѯָ����Ŀ�ĸ���ĿID
     * @param conn
     * @param channelId
     * @return
     * @throws Exception
     */
    public static String findParentIdOfChannel(Connection conn, String channelId) throws Exception{
    	if(channelId == null || "".equals(channelId)){
    		return "";
    	}
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        Data data = new Data();
        data.setEntityName(Channel.CHANNEL_ENTITY);
        data.setPrimaryKey(Channel.ID);
        data.add(Channel.ID, channelId);
        data = ide.findByPrimaryKey(data);
        if(data != null){
        	return data.getString(Channel.PARENT_ID);
        }
        return "";
    }
    
    /**
     * 
     * @param conn
     * @param channelId
     * @return
     * @throws Exception
     */
    public static Data findParentOfChannel(Connection conn, String channelId) throws Exception{
    	if(channelId == null || "".equals(channelId)){
    		return null;
    	}
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        Data data = new Data();
        data.setEntityName(Channel.CHANNEL_ENTITY);
        data.setPrimaryKey(Channel.ID);
        data.add(Channel.ID, channelId);
        return ide.findByPrimaryKey(data);
    }
    
    
    /**
     * �Ǿ�̬��������ѯָ����ɫ��Ӧ����ĿȨ��
     * @param conn
     * @param personId
     * @param role
     * @return
     */
    public CodeList findChannelsOfRole(Connection conn, String roleId) throws Exception {
		CodeList codeList = new CodeList();
		//System.out.println("findChannelsOfRoleBySQL:"+getSql("findChannelsOfRoleBySQL",roleId));
        codeList = UtilCode.getCodeListBySql(conn, getSql("findChannelsOfRoleBySQL",roleId));
        return codeList;
    }
    
    /**
	 * �Ǿ�̬��������ѯ��ɫӵ�е���Ŀ�б�
	 * @param conn
	 * @param roleId
	 * @return
	 * @throws Exception
	 */
	public CodeList findChannelsOfRole(Connection conn, List<Role> roles) throws Exception {
		CodeList codeList = new CodeList();
		
		StringBuffer buffer = new StringBuffer();
		for (int i = 0; i < roles.size(); i++) {
			Role role = roles.get(i);
			if(i == (roles.size() - 1)){
				buffer.append("ROLE_ID = '").append(role.getRoleId()).append("'");
			}else{
				buffer.append("ROLE_ID = '").append(role.getRoleId()).append("' OR ");
			}
		}
		//System.out.println("findChannelsOfRoleBySQL_buffer:"+getSql("findChannelsOfRoleBySQL",buffer.toString()));
        codeList = UtilCode.getCodeListBySql(conn, getSql("findChannelsOfRoleBySQL",buffer.toString()));
        //�Ƴ��ظ�ֵ����ԭ˳��
        return removeDuplicateWithOrder(codeList);
    }
	
	/**
	 * ȥ��List���ظ�ֵ������ԭ��˳��
	 * @param arlList
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static CodeList removeDuplicateWithOrder(CodeList codeList){    
		Set set = new HashSet();    
		CodeList newList = new CodeList();
		//System.out.println(codeList.size()+":ԭ");
		for (Iterator iter = codeList.iterator(); iter.hasNext(); ){
			Object element = iter.next();    
			if (set.add(element)){
				newList.add((Code) element);
			}
		}
		//System.out.println(newList.size()+":ԭ");
		return newList;
	}
	
	/**
	 * ��д��������Ϊ�˴���̬�����޷�����getSql����
	 * @param key
	 * @param handler
	 * @param replace
	 * @return
	 */
	public static String getSql(String key, BaseHandler handler, Object ... replace){
		return handler.getSql(key, replace);
	}
	
	/**
	 * ��д��������Ϊ�˴���̬�����޷�����getSql����
	 * @param key
	 * @param handler
	 * @return
	 */
	public static String getSql(String key,BaseHandler handler){
		return handler.getSql(key);
	}
}
