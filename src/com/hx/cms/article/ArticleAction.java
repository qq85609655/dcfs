package com.hx.cms.article;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;
import hx.util.UUIDGenerator;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.hx.cms.article.vo.Article;
import com.hx.cms.article.vo.Article2Channels;
import com.hx.cms.article.vo.AuditOpinion;
import com.hx.cms.auth.vo.PersonChannelRela;
import com.hx.cms.channel.ChannelHandler;
import com.hx.cms.channel.vo.Channel;
import com.hx.cms.util.CmsAuthConstants;
import com.hx.cms.util.CmsConfigUtil;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.common.ClientIPGetter;
import com.hx.framework.common.UtilHash;
import com.hx.framework.organ.OrganHandler;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.sdk.AuditAppHelper;
import com.hx.framework.sdk.AuditConstants;
import com.hx.framework.sdk.ClickCountHelper;
import com.hx.framework.sdk.PersonHelper;
import com.hx.upload.sdk.AttHelper;
import com.hx.upload.vo.Att;
import com.hx.upload.vo.AttType;

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
public class ArticleAction extends BaseAction {
    
    private static Log log = UtilLog.getLog(ArticleAction.class);

    private ArticleHandler handler;
    private ChannelHandler channelHandler;
    private OrganHandler organHandler;
    
    /**
     * 初始化
     */
    public ArticleAction() {
    	handler = new ArticleHandler();
    	channelHandler = new ChannelHandler();
    	organHandler = new OrganHandler();
    }
    
    /**
     * 标签分页测试用的方法
     * @return
     */
    public String test(){
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        return "test";
    }
    
    /**
     * OA 首页通知公告数据 
     * @return
     */
    public String noticeListHomePage(){
    	return SUCCESS;
    }
    
    /**
     * OA 首页通知公告数据 列表
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String noticeList(){
    	
    	String channelId = getParameter("CHANNEL_ID");
    	setAttribute("CHANNEL_ID", channelId);
        
        Map search = getDataWithPrefix("S_", true);
        Data searchData = new Data(search);
        setAttribute("data", searchData);
    	
    	/************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        
        //分页显示
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        Connection conn = null;
        DataList dataList = new DataList();
        
        String dataAccessPermission = CmsConfigUtil.getValue(com.hx.cms.util.Constants.DATA_ACCESS_PERMISSION);
    	boolean dataAccess = false;
    	if(dataAccessPermission != null && !"".equalsIgnoreCase(dataAccessPermission)){
    	    dataAccess = Boolean.parseBoolean(dataAccessPermission);
    	}
    	
    	//获取当前登录人拥有的角色集合
    	UserInfo user = SessionInfo.getCurUser();
        String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        String organId = PersonHelper.getOrganOfPerson(personId).getId();
        try {
            conn = ConnectionManager.getConnection();
            if(dataAccess){
		        //加入数据权限校验
                dataList = handler.findArtOfChannelForDataAccess(conn, channelId, searchData, orderString, pageSize, page, personId, organId);
		    }else{
		        //有权访问：正常输出
		    	dataList = handler.findArtOfChannel(conn, channelId, searchData, orderString, pageSize, page);
		    }
        } catch (Exception e) {
            log.logError("查询待办任务时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询待办任务时关闭Connection出错!", e);
            }
        }
        //传参
        setAttribute("dataList", dataList);
        return SUCCESS;
    }
    
    /**
     * 切换版本
     * @return
     */
    public String toSwitchVersion(){
    	//流程名字+版本
    	String id = getParameter("ID");
    	String wfName = getParameter("WF_NAME");
    	setAttribute("ID", id);
    	setAttribute("WF_NAME", wfName);
    	
    	//String wfDescription = getParameter("WF_DESCRIPTION");
    	//String wfVersion = getParameter("WF_VERSION");
    	//String state = getParameter("STATE");
    	//setAttribute("WF_DESCRIPTION", wfDescription);
    	//setAttribute("WF_VERSION", wfVersion);
    	//setAttribute("STATE", state);
    	//查询组织树
    	Connection conn = null;
    	//版本列表
    	DataList dataList = new DataList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//获取已选节点
    		Data data = new Data();
    		data.setEntityName("WF_WORKFLOWDEFS");
    		data.setPrimaryKey("WF_NAME");
    		data.add("WF_NAME", wfName);
    		dataList = handler.findListByData(conn,data);
    	} catch (Exception e) {
    		log.logError("转去调整人员组织时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("转去调整人员组织时出错!", e);
    		}
    	}
    	//传递频道树
    	setAttribute("dataList", dataList);
    	return SUCCESS;
    }
    
    /**
     * 转去打开数据授权树
     * @return
     */
    public String toDataAccess(){
        String dataAccess = getParameter("DATA_ACCESS");
        //查询组织树
        Connection conn = null;
        //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
        CodeList dataList = new CodeList();
        UserInfo user = SessionInfo.getCurUser();
        try {
            conn = ConnectionManager.getConnection();
            if("2".equals(dataAccess)){
                //人员
                if(CmsConfigUtil.isMultistageAdminMode()){
                	//如果分级
                	if("0".equals(user.getAdminType())){
                		//查询
                		dataList = handler.findPersons(conn);
                	}
                	if("1".equals(user.getAdminType())){
                		//查询
                		dataList = handler.findPersonsForLevelList(conn, user.getPersonId());
                	}
                }
                if(CmsConfigUtil.isThreeAdminMode()){
                	//查询
                	dataList = handler.findPersons(conn);
                }
            }
            if("3".equals(dataAccess)){
                //组织
                if(CmsConfigUtil.isMultistageAdminMode()){
                	//如果分级
                	if("0".equals(user.getAdminType())){
                		//查询
                		dataList = handler.findOrgans(conn);
                	}
                	if("1".equals(user.getAdminType())){
                		//查询
                		DataList organList = organHandler.generateTreeForLevel(conn, user.getPersonId());
                		if(organList != null && organList.size() > 0){
                			Data parent = organList.getData(0);
                			String parentId = parent.getString("ORG_LEVEL_CODE");
                			DataList organLists = organHandler.generateTreeForLevelList(conn, parentId);
                			if(organLists != null && organLists.size() > 0){
                				for (int i = 0; i < organLists.size(); i++) {
    								Data data = organLists.getData(i);
    								Code code = new Code();
    								code.setName(data.getString("NAME"));
    								code.setValue(data.getString("VALUE"));
    								code.setParentValue(data.getString("PARENTVALUE"));
    								dataList.add(code);
    							}
                			}
                			
                			//加入顶级
                			Code p = new Code();
                			p.setName(parent.getString("NAME"));
                			p.setValue(parent.getString("VALUE"));
                			p.setParentValue("0");
                			dataList.add(p);
                		}
                	}
                }
                if(CmsConfigUtil.isThreeAdminMode()){
                	//查询
                	dataList = handler.findOrgans(conn);
                }
            }
            
            //选中数据
            String selectedNode = getParameter("SELECTEDNODE");
            selectedNode = selectedNode.replaceAll("!", ",");
            setAttribute("selectedData", selectedNode);
        } catch (Exception e) {
            log.logError("转去调整人员组织时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去调整人员组织时出错!", e);
            }
        }
        //传递频道树
        setAttribute("dataList", dataList);
        return "toDataAccess";
    }
    
    /**
     * 格式初始化
     * @return
     */
    public String clearStyle(){
        String content = getParameter("Article_CONTENT");
        if(content != null){
            content = content.trim();
            String regex = "/<(?!/?p|br|div\b)[^>]+>/ig";
            content = content.replaceAll(regex, "");
        }
        //System.out.println(content);
        return "null";
    }
    
    /**
     * 前台显示新闻内容
     * @return
     */
    public String detailArt(){
        // 获取数据值
        String ids = getParameter(Article.ID);
        Data data = new Data();
        Connection conn = null;
        
        String bodyTextAtt = "";
        int bta = -1;
        try {
            conn = ConnectionManager.getConnection();
            String id = ids.split(",")[0];
            String store = ids.split(",")[1];
            if("REFERENCE".equals(store)){
                Data reference = new Data();
                reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                reference.setPrimaryKey(Article2Channels.ID);
                reference.add(Article2Channels.ID, id);
                Data ref = handler.findDataByKey(conn, reference);
                id = ref.getString("ARTICLE_ID");
            }
            
            
            data.setEntityName(Article.ARTICLE_ENTITY);
            data.setPrimaryKey(Article.ID);
            data.add(Article.ID, id);
            data = handler.findDataByKey(conn, data);
            
            String title = data.getString("TITLE", "");
            title = title.replaceAll("\n", "<br />");
            data.put("TITLE", title);
            
            String PACKAGE_ID = data.getString("PACKAGE_ID", "");
            if(AttHelper.hasAttsByPackageId(PACKAGE_ID)){
                data.put("IS_HAVE_ATT", "1");
            }else{
                data.put("IS_HAVE_ATT", "0");
            }
            
            DataList dl = handler.findReceiptContent(conn,id,null);
            setAttribute("dl", dl);
            //密级标示
            int secLevel = data.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 1){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //日志
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_DETAIL,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
        } catch (Exception e) {
            log.logError("调整人员组织时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("调整人员组织时出错!", e);
            }
        }
        setAttribute("data", data);
        
        if(bta != -1){
        	//为配置文件packageId赋值
        	ActionContext.getContext().getValueStack().set("PACKAGE_ID", bodyTextAtt);
        	return "webofficeShowAtt";
        }
        return "detailArt";
    }
    
    /**
     * 生成下载地址
     * @return
     */
    public String generateDownloadUrl(){
    	// 获取数据值
    	String id = getParameter(Article.ID);
    	Data data = new Data();
    	data.setEntityName(Article.ARTICLE_ENTITY);
    	data.setPrimaryKey(Article.ID);
    	data.add(Article.ID, id);
    	
    	Connection conn = null;
    	try {
    		// 保存
    		conn = ConnectionManager.getConnection();
    		data = handler.findDataByKey(conn, data);
    	} catch (Exception e) {
    		log.logError("调整人员组织时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("调整人员组织时出错!", e);
    		}
    	}
    	setAttribute("data", data);
    	return "generateDownloadUrl";
    }
    
    /**
     * 审核选中的文章：要求查出以往的审核记录
     * 		如果选中单篇文章则查出审核历史
     * 		如果选中多篇文章则不查出审核历史
     * @return
     */
    public String auditArt(){
        // 获取数据值
    	String idString = getParameter(Article.IDS);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            if(ids != null){
            	if(ids.length == 1){
            		String artId = ids[0];
            		Data art = new Data();
            		art.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
            		art.setPrimaryKey(AuditOpinion.ID);
            		art.add(AuditOpinion.ARTICLE_ID, artId);
            		dataList = handler.findAuditOpinionOfArt(conn,art);
            		//单个内容审核可以直接预览
            		setAttribute("ART_SINGLETON", "ART_SINGLETON");
            	}
            }
        } catch (Exception e) {
            log.logError("文章审核时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("文章审核时出错!", e);
            }
        }
        setAttribute("dataList", dataList);
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        setAttribute(AuditOpinion.IDS, idString);
        return "auditArt";
    }
    
    /**
     * 预览（添加/修改）
     * @return
     */
    public String detailArtScan(){
        
    	// 获取表单数据
		Data data = fillData(false);
		
		String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
		// 保存
		// 生成ID
		/*String articleId = UUIDGenerator.getUUID();
		data.add(Article.ID, articleId);*/

		// 创建时间
		Date date = new Date();
		/*data.add(Article.CREATE_TIME, date);
		data.add(Article.MODIFY_TIME, date);*/
		
		//预览使用
		String createTime_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		data.add(Article.CREATE_TIME, createTime_);
		data.add(Article.MODIFY_TIME, createTime_);

		//创建人
        UserInfo ui = SessionInfo.getCurUser();
        String personId = ui.getPerson().getPersonId();
        data.add(Article.CREATOR, personId);
        
        //加入组织ID
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        Organ organ = user.getCurOrgan();
        String createDeptId = null;
        if(organ != null){
        	createDeptId = organ.getId();
        }
        data.add(Article.CREATE_DEPT_ID, createDeptId);

		// 检查新闻内容中是否有图片如果有，那么将它的地址保存到imageSource属性
		/*String articleContent = data.getString(Article.CONTENT);
		if (articleContent != null && !"".equals(articleContent)) {
			if (articleContent.contains(new StringBuffer()
					.append("<input type=\"image\""))) {
				int index = articleContent.indexOf("src=\"", articleContent
						.indexOf("<input type=\"image\""));
				data.add(Article.SHORT_PICTURE, articleContent.substring(index
						+ "src=\"".length(), articleContent.indexOf("\"", index
						+ "src=\"".length())));
			}
			if (articleContent.contains(new StringBuffer().append("<img"))) {
				int index = articleContent.indexOf("src=\"", articleContent
						.indexOf("<img"));
				data.add(Article.SHORT_PICTURE, articleContent.substring(index
						+ "src=\"".length(), articleContent.indexOf("\"", index
						+ "src=\"".length())));
			}
		}*/

		// 直接发布
		data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
		
		
		/*密级标示开始*/
		//StringBuffer html = new StringBuffer();
		Connection conn = null;
		try{
			conn = ConnectionManager.getConnection();
			/*if (data != null) {
	        	//时间
	            String securitLevel = data.getString(Article.SECURITY_LEVEL);
	            String periodTime = data.getString(Article.PROTECT_PERIOD);
	            CodeList securityList = new CodeList();
	    		securityList = UtilCode.getCodeList("SECURITY_LEVEL", conn);
	    		if(securityList != null && securityList.size() > 0){
	            	for (int i = 0; i < securityList.size(); i++) {
						Code code = securityList.get(i);
						if(code.getValue().equals(securitLevel)){
							if(!"无".equals(code.getRem())){
								String desc = code.getRem();
								if(desc != null && !"".equals(desc)){
									desc = desc.replaceAll("\r\n", "<br/>").replaceAll("\n\r", "<br/>").replaceAll("[\n|\r]", "<br/>");
								}
								html.append(desc);
							}
						}
					}
	            }*/
	    		
	        	/*CodeList periodList = new CodeList();
	    		periodList = UtilCode.getCodeList("SECURITY_XX", conn);
	    		if(periodList != null && periodList.size() > 0){
	            	for (int i = 0; i < periodList.size(); i++) {
						Code code = periodList.get(i);
						if(code.getValue().equals(periodTime)){
							if(!"无".equals(code.getRem())){
								html.append("★").append(code.getRem());
							}
						}
					}
	            }
	    	}*/
			//data.add("SECURITY_LEVEL_DESC", html.toString());
		} catch (Exception e) {
            log.logError("修改栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("修改栏目时出错!", e);
            }
        }
		setAttribute("data", data);
		setAttribute("dl", new DataList());
		return "detailArtScan";
    }
    
    /**
	 * 文章管理入口
	 * 
	 * @return
	 */
    public String queryIndex(){
        return "index";
    }
    
    /**
	 * 弹出移动文章到栏目的树框架
	 * 
	 * @return
	 */
    public String changeChannelFrame(){
        setAttribute(Article.IDS, getParameter(Article.IDS));
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "changeChannelFrame";
    }
    
    /**
     * 树框架转发的请求，最后显示树页面:角色验证
     * @return
     */
    /*public String toChangeChannel(){
        //查询组织树
        Connection conn = null;
        //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //查询
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            java.util.List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	dataList = channelHandler.findChannelsOfRole(conn,roles);
            }
        } catch (Exception e) {
            log.logError("转去调整人员组织时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去调整人员组织时出错!", e);
            }
        }
        //传递频道树
        setAttribute("dataList", dataList);
        setAttribute(Article.IDS, getParameter(Article.IDS));
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "changeChannel";
    }*/
    
    /**
     * 树框架转发的请求，最后显示树页面:人员验证
     * @return
     */
    public String toChangeChannel(){
    	//查询组织树
    	Connection conn = null;
    	//使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//查询
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
    		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
    		dataList = channelHandler.findChannelsOfPerson(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
    	} catch (Exception e) {
    		log.logError("转去调整人员组织时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("转去调整人员组织时出错!", e);
    		}
    	}
    	//传递频道树
    	setAttribute("dataList", dataList);
    	setAttribute(Article.IDS, getParameter(Article.IDS));
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	
    	return "changeChannel";
    }
    
    /**
     * 统计下载次数
     * @return
     */
    public String statDownNum(){
        
    	String id = getParameter(Article.ID);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            Data data = new Data();
            data.setEntityName(Article.ARTICLE_ENTITY);
            data.setPrimaryKey(Article.ID);
            data.add(Article.ID, id);
            
            Data result = handler.findDataByKey(conn, data);
            if(result != null){
            	data.add(Article.DOWN_NUM, result.getInt(Article.DOWN_NUM) + 1);
            }
            
            handler.modify(conn, data);
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("下载次数统计时出错!", e);
            }
            log.logError("下载次数统计时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("下载次数统计时出错!", e);
            }
        }
        return null;
    }
    
    /**
     * 移动栏目
     * @return
     */
    public String changeChannel(){
        
        String idString = getParameter(Article.IDS);
        String channelId = getParameter(Article.CHANNEL_ID);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("!");
        }

        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            if(ids != null){
            	for (int i = 0; i < ids.length; i++) {
            	    Data data1 = new Data();
            	    
            	    Data cur = new Data();
            	    
					String id = ids[i].split(",")[0];
					String store = ids[i].split(",")[1];
					if("REFERENCE".equals(store)){//引用数据的移动=原数据的重新发布
					    Data reference = new Data();
                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                        reference.setPrimaryKey(Article2Channels.ID);
                        reference.add(Article2Channels.ID, id);
                        Data ref = handler.findDataByKey(conn, reference);
                        String articleId = ref.getString("ARTICLE_ID");
                        if(idString.contains(articleId)){//如果引用数据和原数据同时存在，删除引用数据
                            handler.delete(conn, reference);
                        }else{//如果不存在原数据，判断是否与原引用数据重复和是否与原数据重复
                            /*data1.setEntityName(Article.ARTICLE_ENTITY);
                            data1.setPrimaryKey(Article.ID);
                            data1.add(Article.ID, articleId);
                            data1 = handler.findDataByKey(conn, data1);*/
                            Data ref2 = new Data();
                            ref2.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                            ref2.setPrimaryKey(Article2Channels.ARTICLE_ID,Article2Channels.CHANNEL_ID);
                            ref2.add(Article2Channels.ARTICLE_ID, articleId);
                            ref2.add(Article2Channels.CHANNEL_ID, channelId);
                            Data ref2_ = handler.findDataByKey(conn, ref2);
                            
                            Data articleChannel = new Data();
                            articleChannel.setEntityName(Article.ARTICLE_ENTITY);
                            articleChannel.setPrimaryKey(Article.ID);
                            articleChannel.add(Article.ID, articleId);
                            Data articleD = handler.findDataByKey(conn, articleChannel);
                            String ArticleChannelId = articleD.getString("CHANNEL_ID");
                            
                            if(ref2_ != null && !"".equals(ref2_.getString(Article2Channels.ID))){//需要移动的引用数据，原引用数据存在
                                handler.delete(conn, reference);
                            }else if(ArticleChannelId.equals(channelId)){//需要移动的引用数据目标栏目与原数据相同
                                handler.delete(conn, reference);
                            }else{
                                cur.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                                cur.setPrimaryKey(Article2Channels.ID);
                                cur.add(Article2Channels.ID, id);
                                cur.add(Article2Channels.CHANNEL_ID, channelId);
                                handler.modify(conn, cur);
                            }
                        }
					}else{
					    data1.setEntityName(Article.ARTICLE_ENTITY);
					    data1.setPrimaryKey(Article.ID);
					    data1.add(Article.ID, id);
					    data1 = handler.findDataByKey(conn, data1);
					    
					    cur.setEntityName(Article.ARTICLE_ENTITY);
					    cur.setPrimaryKey(Article.ID);
					    cur.add(Article.ID, id);
					    cur.add(Article.CHANNEL_ID, channelId);
					    handler.modify(conn, cur);
					    
					    //删除重复的引用数据
					    Data delRef = new Data();
					    delRef.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
					    delRef.setPrimaryKey(Article2Channels.ARTICLE_ID,Article2Channels.CHANNEL_ID);
					    delRef.add(Article2Channels.ARTICLE_ID, id);
					    delRef.add(Article2Channels.CHANNEL_ID, channelId);
					    handler.delete(conn, delRef);
					    
					    //密级标示
					    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
					    String securityLevel = "";
					    if(secLevel > 0){
					        securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
					    }
					    //日志
					    AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					            "",
					            AuditConstants.ACT_MOVE,
					            CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					            securityLevel+data1.getString(Article.TITLE,""),
					            AuditConstants.ACT_RESULT_OK,
					            AuditConstants.AUDIT_LEVEL_5,"");
					}
					
		            
		            
				}
            }
            
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("调整人员组织时出错!", e);
            }
            log.logError("调整人员组织时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("调整人员组织时出错!", e);
            }
        }
        //调整前频道
        setAttribute(Article.CHANNEL_ID, getParameter("Article_"+Article.CHANNEL_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        return "query";
    }

    /**
     * 分页查询子级
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String query(){
    	
    	//查询条件
    	Map map = getDataWithPrefix("Search_", true);
    	Data searchData = new Data(map);
    	
    	/************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="IS_TOP DESC, SEQ_NUM ASC, CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
		
        //分页显示
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        //得到当前点击的组织机构的id值，作为它子机构的父ID进行查询，得到所有当前机构的下级
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
        	channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //审核通过的文章
        data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
        
        //查询
		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //dataList = handler.findArticlesOfChannel(conn, data, pageSize, page, orderString, searchData);
            DataList dl = new DataList();
            if("0".equals(channelId)){
                dl = handler.getChannels(conn,null);
            }else{
                dl = handler.getChannels(conn,channelId);
            }
            StringBuffer channels = new StringBuffer();
            for(int i=0;i<dl.size();i++){
                String channel = dl.getData(i).getString("CHANNEL_ID");
                if(i != (dl.size() - 1)){
                    channels.append("'").append(channel).append("'").append(",");
                }else{
                    channels.append("'").append(channel).append("'");
                }
            }
            String channelIds = channels.toString();
            
            
            //一拖N模式
            if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		dataList = handler.findArticlesOfChannelFor1nMode(conn, data, orgLevelCode, pageSize, page, orderString, searchData);
            	}
            }else{
            	dataList = handler.findArticlesOfChannel(conn,channelIds ,data, pageSize, page, orderString, searchData);
            }
            
            //投稿人栏目
            CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
            if(channelList != null && channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
					Code code = channelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("WRITER_AUTH", "WRITER_AUTH");
						break;
					}
				}
        	}
            //审核人栏目
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            //供前台判断
        	if(autherChannelList != null && autherChannelList.size() > 0){
        		for (int i = 0; i < autherChannelList.size(); i++) {
					Code code = autherChannelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("AUTHER_AUTH", "AUTHER_AUTH");
						break;
					}
				}
        	}
        } catch (Exception e) {
            log.logError("查询子级栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询子级栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        //传参
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return SUCCESS;
    }
    
    /**
     * 上移或下移功能,改变排序号
     * @return
     */
    public String changeSeqnum(){
        
        Data data = new Data();
        String id = getParameter(Article.ID);
        String channelId = getParameter(Article.CHANNEL_ID);
        String target = getParameter("target");
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        Connection conn = null;
        DBTransaction db = null;
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            if(id != null && !"".equals(id.trim())){
                data.setEntityName(Article.ARTICLE_ENTITY);
                data.setPrimaryKey(Article.ID);
                data.add(Article.ID, id);
                //查询
                data = handler.findDataByKey(conn, data);
                
                int seqNum = data.getInt(Article.SEQ_NUM);
                
                //上移
                if("up".equals(target)){
                	Data upData = new Data();
                	upData.setEntityName(Article.ARTICLE_ENTITY);
                	upData.setPrimaryKey(Article.CHANNEL_ID,Article.SEQ_NUM);
                	upData.add(Article.CHANNEL_ID, channelId);
                	upData.add(Article.SEQ_NUM, (seqNum - 1));
                	Data upData_ = handler.findDataByKey(conn, upData);
                	if(upData_ != null){
                		//开始移动
                		upData_.add(Article.SEQ_NUM, (seqNum));
                		upData_.setEntityName(Article.ARTICLE_ENTITY);
                		upData_.setPrimaryKey(Article.ID);
                		data.add(Article.SEQ_NUM, (seqNum - 1));
                		data.setEntityName(Article.ARTICLE_ENTITY);
                		data.setPrimaryKey(Article.ID);
                		handler.modify(conn, data);
                		handler.modify(conn, upData_);
                	}else{
                		return "query"; 
                	}
                }
                //下移
                if("down".equals(target)){
                	Data downData = new Data();
                	downData.setEntityName(Article.ARTICLE_ENTITY);
                	downData.setPrimaryKey(Article.CHANNEL_ID,Article.SEQ_NUM);
                	downData.add(Article.CHANNEL_ID, channelId);
                	downData.add(Article.SEQ_NUM, (seqNum + 1));
                	Data downData_ = handler.findDataByKey(conn, downData);
                	if(downData_ != null){
                		//开始移动
                		downData_.add(Channel.SEQ_NUM, (seqNum));
                		downData_.setEntityName(Article.ARTICLE_ENTITY);
                		downData_.setPrimaryKey(Article.ID);
                		data.add(Article.SEQ_NUM, (seqNum + 1));
                		data.setEntityName(Article.ARTICLE_ENTITY);
                		data.setPrimaryKey(Article.ID);
                		handler.modify(conn, data);
                		handler.modify(conn, downData_);
                	}else{
                		return "query"; 
                	}
                }
            }
            db.commit();
        } catch (Exception e) {
        	try {
				db.rollback();
			} catch (SQLException e1) {
				log.logError("上移下移内容时出错!", e1);
			}
            log.logError("上移下移内容时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("上移下移内容时关闭Connection出错!", e);
            }
        }
        return "query";
    }
    
    /**
     * 暂存列表
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String tempQuery(){
    	
    	//查询条件
    	Map map = getDataWithPrefix("Search_", true);
    	Data searchData = new Data(map);
    	
    	/************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="SEQ_NUM ASC, CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        
        //分页显示
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        //得到当前点击的组织机构的id值，作为它子机构的父ID进行查询，得到所有当前机构的下级
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //暂存状态和退回的文章
        data.add("STATUS_1", Article.STATUS_DRAFT);
        data.add("STATUS_2", Article.STATUS_BACK_AUDIT);
        
        //查询
		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //投稿人栏目
            CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
            //审核人栏目
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            
            //一拖N模式
            if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		dataList = handler.findArticlesAllFor1nModeBySQL(conn, data, orgLevelCode, pageSize, page, channelList, orderString, searchData);
            	}
            }else{
            	dataList = handler.findArticlesAllBySQL(conn, data, pageSize, page, channelList, orderString, searchData);
            }
        	
        	//供前台判断
        	if(channelList != null && channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
					Code code = channelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("WRITER_AUTH", "WRITER_AUTH");
						//不审核栏目的标志
						setAttribute("IS_AUTH", code.getName());
						break;
					}
				}
        	}
        	
        	if(autherChannelList != null && autherChannelList.size() > 0){
        		for (int i = 0; i < autherChannelList.size(); i++) {
					Code code = autherChannelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("AUTHER_AUTH", "AUTHER_AUTH");
						break;
					}
				}
        	}
        } catch (Exception e) {
            log.logError("查询子级栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询子级栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        //传参
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return "temp";
    }
    
    /**
     * 暂存列表,只显示本人列表
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String tempPersonalQuery(){
        
        //查询条件
        Map map = getDataWithPrefix("Search_", true);
        Data searchData = new Data(map);
        
        /************获取数据库排序标示--开始***************/
        String compositor=getParameter("compositor");
        setAttribute("compositor", compositor);
        if(compositor==null || "".equals(compositor)){
            compositor="SEQ_NUM ASC, CREATE_TIME";
        }
        String ordertype=getParameter("ordertype");
        setAttribute("ordertype", ordertype);
        if(ordertype==null || "".equals(ordertype)){
            ordertype="DESC";
        }
        String orderString = compositor + " " + ordertype;
        /************获取数据库排序标示--结束***************/
        
        //分页显示
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        //得到当前点击的组织机构的id值，作为它子机构的父ID进行查询，得到所有当前机构的下级
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //暂存状态和退回的文章
        data.add("STATUS_1", Article.STATUS_DRAFT);
        data.add("STATUS_2", Article.STATUS_BACK_AUDIT);
        
        //查询
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //投稿人栏目
            CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
            //审核人栏目
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            dataList = handler.findPersonalArticlesAllBySQL(conn, data, pageSize, page, channelList, orderString, searchData,personId);
            
            //供前台判断
            if(channelList != null && channelList.size() > 0){
                for (int i = 0; i < channelList.size(); i++) {
                    Code code = channelList.get(i);
                    if(code.getValue().equals(channelId)){
                        setAttribute("WRITER_AUTH", "WRITER_AUTH");
                        //不审核栏目的标志
                        setAttribute("IS_AUTH", code.getName());
                        break;
                    }
                }
            }
            
            if(autherChannelList != null && autherChannelList.size() > 0){
                for (int i = 0; i < autherChannelList.size(); i++) {
                    Code code = autherChannelList.get(i);
                    if(code.getValue().equals(channelId)){
                        setAttribute("AUTHER_AUTH", "AUTHER_AUTH");
                        break;
                    }
                }
            }
        } catch (Exception e) {
            log.logError("查询子级栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询子级栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        //传参
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return "temp";
    }
    
    /**
     * 审核列表
     * @return
     */
    @SuppressWarnings({})
	public String auditQuery(){
    	
    	//查询条件
    	Data searchData = getRequestEntityData("Search_", "TITLE");
    	
    	/************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        
        //分页显示
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        //得到当前点击的组织机构的id值，作为它子机构的父ID进行查询，得到所有当前机构的下级
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //等待审核的文章
        data.add("STATUS_1", Article.STATUS_WAIT_AUDIT);
        
        
        //查询
		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //if("0".equals(data.getString(Article.CHANNEL_ID))){
            CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            dataList = handler.findAllAuditArticlesBySQL(conn, data, pageSize, page, channelList, orderString, searchData);
            /*}else{
                dataList = handler.findArticlesOfChannelBySQL(conn, data, pageSize, page);
            }*/
        } catch (Exception e) {
            log.logError("查询子级栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询子级栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        //传参
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return "audit";
    }
    
    /**
     * 转去添加栏目
     * @return
     */
    public String toAdd(){
    	
    	String channelId = getParameter(Article.CHANNEL_ID);
    	Data channel = new Data();
    	channel.setEntityName(Channel.CHANNEL_ENTITY);
    	channel.setPrimaryKey(Channel.ID);
    	channel.add(Channel.ID, channelId);
    	
        Data data = new Data();
        
        //查询
		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            //栏目类型
            CodeList codeList = channelHandler.findChannelToCodeList(conn);
            
            String codeId = "channelList";
            codeList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, codeList);
            setAttribute(Constants.CODE_LIST, map);
            
            //查询栏目
            channel = channelHandler.findDataByKey(conn, channel);
            if(channel == null){
                data.add(Channel.NAME, "ROOT");
            }else{
                data.add(Channel.NAME, channel.getString(Channel.NAME));
                //不审核栏目的标志
				setAttribute("IS_AUTH", channel.getString(Channel.IS_AUTH));
            }
            
            
            //投稿人栏目
            /*CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
            if(channelList != null && channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
					Code code = channelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("WRITER_AUTH", "WRITER_AUTH");
						break;
					}
				}
        	}*/
            //审核人栏目
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            //供前台判断
        	if(autherChannelList != null && autherChannelList.size() > 0){
        		for (int i = 0; i < autherChannelList.size(); i++) {
					Code code = autherChannelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("AUTHER_AUTH", "AUTHER_AUTH");
						break;
					}
				}
        	}
        } catch (Exception e) {
            log.logError("转去添加栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去添加栏目时关闭Connection出错!", e);
            }
        }
        
        setAttribute("data", data);
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        return "add";
    }
    
    /**
     * 转去修改栏目
     * @return
     */
    public String toModify(){
        
        Data data = new Data();
        String id = getParameter(Article.ID);
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            if(id != null && !"".equals(id.trim())){
                data.setEntityName(Article.ARTICLE_ENTITY);
                data.setPrimaryKey(Article.ID);
                data.add(Article.ID, id);
                //查询
                data = handler.findDataByKey(conn, data);
                
                /***************************************************/
                //数据授权
                String dataAccess = data.getString(Article.DATA_ACCESS);
                if(dataAccess != null && !"".equals(dataAccess)){
                    //人员权限
                    if(dataAccess.contains("2")){
                        Data personRela = new Data();
                        personRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRela.setPrimaryKey("ARTICLE_ID");
                        personRela.add("ARTICLE_ID", id);
                        DataList list = handler.findListByData(conn, personRela);
                        if(list != null && list.size() > 0){
                            StringBuffer bu = new StringBuffer();
                            for (int i = 0; i < list.size(); i++) {
                                Data d = list.getData(i);
                                if(i == (list.size() - 1)){
                                    bu.append(d.getString("PERSON_ID"));
                                }else{
                                    bu.append(d.getString("PERSON_ID")).append(",");
                                }
                            }
                            data.add("IDS_PERSON_ARTICLE_RELA", bu.toString());
                        }
                    }
                    //组织权限
                    if(dataAccess.contains("3")){
                        Data organRela = new Data();
                        organRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRela.setPrimaryKey("ARTICLE_ID");
                        organRela.add("ARTICLE_ID", id);
                        DataList list = handler.findListByData(conn, organRela);
                        if(list != null && list.size() > 0){
                            StringBuffer bu = new StringBuffer();
                            for (int i = 0; i < list.size(); i++) {
                                Data d = list.getData(i);
                                if(i == (list.size() - 1)){
                                    bu.append(d.getString("ORGAN_ID"));
                                }else{
                                    bu.append(d.getString("ORGAN_ID")).append(",");
                                }
                            }
                            data.add("IDS_ORGAN_ARTICLE_RELA", bu.toString());
                        }
                    }
                }
                /***************************************************/
                
                /***************************************************/
                //查询栏目名称
                  Data channel = new Data();
                  channel.setEntityName(Channel.CHANNEL_ENTITY);
                  channel.setPrimaryKey(Channel.ID);
                  channel.add(Channel.ID, data.getString(Article.CHANNEL_ID));
                  channel = channelHandler.findDataByKey(conn, channel);
                  String IS_AUTH = channel.getString(Channel.IS_AUTH);
                  setAttribute("IS_AUTH", IS_AUTH);
                  //查询审核人
                  if(Channel.IS_AUTH_STATUS_YES.equals(IS_AUTH)){
                      Data auditPerson = new Data();
                      auditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                      auditPerson.setPrimaryKey("ARTICLE_ID");
                      auditPerson.add("ARTICLE_ID", id);
                      DataList list = handler.findListByData(conn, auditPerson);
                      if(list != null && list.size() > 0){
                          StringBuffer bu = new StringBuffer();
                          for (int i = 0; i < list.size(); i++) {
                              Data d = list.getData(i);
                              if(i == (list.size() - 1)){
                                  bu.append(d.getString("AUDIT_PERSON_ID"));
                              }else{
                                  bu.append(d.getString("AUDIT_PERSON_ID")).append(",");
                              }
                          }
                          data.add("AUDITPERSON_ARTICLE_RELA", bu.toString());
                      }
                  }
                  /***************************************************/
                
                //审核记录
                Data audit = new Data();
                audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                audit.setPrimaryKey(AuditOpinion.ARTICLE_ID);
                audit.add(AuditOpinion.ARTICLE_ID, id);
                dataList = handler.findAuditOpinionOfArt(conn, audit);
            }
            
            //查询栏目名称
            Data channel = new Data();
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, data.getString(Article.CHANNEL_ID));
            channel = channelHandler.findDataByKey(conn, channel);
            data.add(Channel.NAME, channel.getString(Channel.NAME));
            
            CodeList codeList = channelHandler.findChannelToCodeList(conn);
            String codeId = "channelList";
            codeList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, codeList);
            setAttribute(Constants.CODE_LIST, map);
        } catch (Exception e) {
            log.logError("转去修改栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去修改栏目时关闭Connection出错!", e);
            }
        }
        
        setAttribute("data", data);
        setAttribute("dataList", dataList);
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "modify";
    }
    
    public String toModifyTemp(){
        
        Data data = new Data();
        String id = getParameter(Article.ID);
        Connection conn = null;
        DataList dataList = new DataList();
        
        //查询
//		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
//		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        try {
            conn = ConnectionManager.getConnection();
            if(id != null && !"".equals(id.trim())){
                data.setEntityName(Article.ARTICLE_ENTITY);
                data.setPrimaryKey(Article.ID);
                data.add(Article.ID, id);
                //查询
                data = handler.findDataByKey(conn, data);
                
                /***************************************************/
                //数据授权
                String dataAccess = data.getString(Article.DATA_ACCESS);
                if(dataAccess != null && !"".equals(dataAccess)){
                    //人员权限
                    if(dataAccess.contains("2")){
                        Data personRela = new Data();
                        personRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRela.setPrimaryKey("ARTICLE_ID");
                        personRela.add("ARTICLE_ID", id);
                        DataList list = handler.findListByData(conn, personRela);
                        if(list != null && list.size() > 0){
                            StringBuffer bu = new StringBuffer();
                            for (int i = 0; i < list.size(); i++) {
                                Data d = list.getData(i);
                                if(i == (list.size() - 1)){
                                    bu.append(d.getString("PERSON_ID"));
                                }else{
                                    bu.append(d.getString("PERSON_ID")).append(",");
                                }
                            }
                            data.add("IDS_PERSON_ARTICLE_RELA", bu.toString());
                        }
                    }
                    //组织权限
                    if(dataAccess.contains("3")){
                        Data organRela = new Data();
                        organRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRela.setPrimaryKey("ARTICLE_ID");
                        organRela.add("ARTICLE_ID", id);
                        DataList list = handler.findListByData(conn, organRela);
                        if(list != null && list.size() > 0){
                            StringBuffer bu = new StringBuffer();
                            for (int i = 0; i < list.size(); i++) {
                                Data d = list.getData(i);
                                if(i == (list.size() - 1)){
                                    bu.append(d.getString("ORGAN_ID"));
                                }else{
                                    bu.append(d.getString("ORGAN_ID")).append(",");
                                }
                            }
                            data.add("IDS_ORGAN_ARTICLE_RELA", bu.toString());
                        }
                    }
                }
                /***************************************************/
                
                
                /***************************************************/
              //查询栏目名称
                Data channel = new Data();
                channel.setEntityName(Channel.CHANNEL_ENTITY);
                channel.setPrimaryKey(Channel.ID);
                channel.add(Channel.ID, data.getString(Article.CHANNEL_ID));
                channel = channelHandler.findDataByKey(conn, channel);
                String IS_AUTH = channel.getString(Channel.IS_AUTH);
                setAttribute("IS_AUTH", IS_AUTH);
                //查询审核人
                if(Channel.IS_AUTH_STATUS_YES.equals(IS_AUTH)){
                    Data auditPerson = new Data();
                    auditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                    auditPerson.setPrimaryKey("ARTICLE_ID");
                    auditPerson.add("ARTICLE_ID", id);
                    DataList list = handler.findListByData(conn, auditPerson);
                    if(list != null && list.size() > 0){
                        StringBuffer bu = new StringBuffer();
                        for (int i = 0; i < list.size(); i++) {
                            Data d = list.getData(i);
                            if(i == (list.size() - 1)){
                                bu.append(d.getString("AUDIT_PERSON_ID"));
                            }else{
                                bu.append(d.getString("AUDIT_PERSON_ID")).append(",");
                            }
                        }
                        data.add("AUDITPERSON_ARTICLE_RELA", bu.toString());
                    }
                }
                /***************************************************/
                //审核记录
                Data audit = new Data();
                audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                audit.setPrimaryKey(AuditOpinion.ARTICLE_ID);
                audit.add(AuditOpinion.ARTICLE_ID, id);
                dataList = handler.findAuditOpinionOfArt(conn, audit);
            }
            
            
            /*if(channel == null){
                data.add(Channel.NAME, "ROOT");
            }else{
                data.add(Channel.NAME, channel.getString(Channel.NAME));
                //不审核栏目的标志
				setAttribute("IS_AUTH", channel.getString(Channel.IS_AUTH));
            }*/
            
          //投稿人栏目
            /*CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
            if(channelList != null && channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
					Code code = channelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("WRITER_AUTH", "WRITER_AUTH");
						break;
					}
				}
        	}*/
            //审核人栏目
            /*CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            //供前台判断
        	if(autherChannelList != null && autherChannelList.size() > 0){
        		for (int i = 0; i < autherChannelList.size(); i++) {
					Code code = autherChannelList.get(i);
					if(code.getValue().equals(data.getString(Article.CHANNEL_ID))){
						setAttribute("AUTHER_AUTH", "AUTHER_AUTH");
						break;
					}
				}
        	}*/
            
            CodeList codeList = channelHandler.findChannelToCodeList(conn);
            String codeId = "channelList";
            codeList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, codeList);
            setAttribute(Constants.CODE_LIST, map);
        } catch (Exception e) {
            log.logError("转去修改栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去修改栏目时关闭Connection出错!", e);
            }
        }
        
        setAttribute("data", data);
        setAttribute("dataList", dataList);
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "tempModify";
    }
    
    /**
     * 显示详情
     * @return
     */
    public String queryDetail(){
        
        Data data = new Data();
        String id = getParameter(Article.ID);
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            if(id != null && !"".equals(id.trim())){
                data.setEntityName(Article.ARTICLE_ENTITY);
                data.setPrimaryKey(Article.ID);
                data.add(Article.ID, id);
                //查询
                data = handler.findDataByKey(conn, data);
            }
            
            //查询栏目名称
            Data channel = new Data();
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, data.getString(Article.CHANNEL_ID));
            channel = channelHandler.findDataByKey(conn, channel);
            data.add(Channel.NAME, channel.getString(Channel.NAME));
        } catch (Exception e) {
            log.logError("转去修改栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去修改栏目时关闭Connection出错!", e);
            }
        }
        
        setAttribute("data", data);
        return "queryDetail";
    }

    /**
     * 组织结构
     * 
     * @return
     */
    public String add() {
        // 获取表单数据
        Data data = fillData(true);
        
        //密级 当保存数据位"NULL"字符串是数据库会提示错误
        String _securityLevel = data.getString(Article.SECURITY_LEVEL);
        if("0".equals(_securityLevel) || "1".equals(_securityLevel)){
            data.remove(Article.PROTECT_START_DATE);
            data.remove(Article.PROTECT_END_DATE);
        }
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //生成ID
            String articleId = UUIDGenerator.getUUID();
            data.add(Article.ID, articleId);
            
            //创建时间
            //Date date = new Date();
            //data.add(Article.CREATE_TIME, date);
            data.add(Article.MODIFY_TIME, data.getString(Article.CREATE_TIME));
            
            //创建人
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            UserInfo ui = SessionInfo.getCurUser();
            String personId = ui.getPerson().getPersonId();
            data.add(Article.CREATOR, personId);
            
            /*//检查新闻内容中是否有图片如果有，那么将它的地址保存到imageSource属性
            String articleContent = data.getString(Article.CONTENT);
            if(articleContent != null && !"".equals(articleContent)){
                if(articleContent.contains(new StringBuffer().append("<input type=\"image\""))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<input type=\"image\""));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
                if(articleContent.contains(new StringBuffer().append("<img"))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<img"));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
            }*/
            
            //等待审核
            data.add(Article.STATUS, Article.STATUS_WAIT_AUDIT);
            //data.add(Article.ATT_ICON, iconPackageId);
            
            /********************************************/
            //数据权限
            String[] dataAccesss = getParameterValues(Article.DATA_ACCESS);
            if(dataAccesss != null && dataAccesss.length > 0){
                StringBuffer dac = new StringBuffer();
                for (int i = 0; i < dataAccesss.length; i++) {
                    String dataAccess = dataAccesss[i];
                    if(i == (dataAccesss.length - 1)){
                        dac.append(dataAccess);
                    }else{
                        dac.append(dataAccess).append(",");
                    }
                }
                data.add(Article.DATA_ACCESS, dac.toString());
            }
            
            String personRela = getParameter("IDS_PERSON_ARTICLE_RELA");
            String organRela = getParameter("IDS_ORGAN_ARTICLE_RELA");
            //授权人员
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    for (int i = 0; i < personRelas.length; i++) {
                        Data personRelaData = new Data();
                        personRelaData.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRelaData.setPrimaryKey("ID");
                        personRelaData.add("ID", UUIDGenerator.getUUID());
                        personRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        personRelaData.add("PERSON_ID", personRelas[i]);
                        handler.add(conn, personRelaData);
                    }
                }
            }
            //授权组织
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    for (int i = 0; i < organRelas.length; i++) {
                        Data organRelaData = new Data();
                        organRelaData.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRelaData.setPrimaryKey("ID");
                        organRelaData.add("ID", UUIDGenerator.getUUID());
                        organRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        organRelaData.add("ORGAN_ID", organRelas[i]);
                        handler.add(conn, organRelaData);
                    }
                }
            }
            /********************************************/
            
            /********************************************/
            //审核人
            /*Data channel = new Data();
            String channelId = data.getString("CHANNEL_ID");
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, channelId);
            
            channel = channelHandler.findDataByKey(conn, channel);
            if(Channel.IS_AUTH_STATUS_YES.equals(channel.getString(Channel.IS_AUTH))){
            }*/
            String auditPerson = getParameter("IDS_AUDITPERSON_ARTICLE_RELA");
            if(auditPerson != null && !"".equals(auditPerson)){
                String[] auditPersons = auditPerson.split(",");
                for (int i = 0; i < auditPersons.length; i++) {
                    Data auditPersonData = new Data();
                    auditPersonData.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                    auditPersonData.setPrimaryKey("ID");
                    auditPersonData.add("ID", UUIDGenerator.getUUID());
                    auditPersonData.add("ARTICLE_ID", data.getString(Article.ID));
                    auditPersonData.add("AUDIT_PERSON_ID", auditPersons[i]);
                    handler.add(conn, auditPersonData);
                }
            }
            
            /********************************************/
            
            //加入组织ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(Article.CREATE_DEPT_ID, createDeptId);
            
            //密级标识防篡改
            String seckey = data.getString(Article.ID)+"$"+data.getString(Article.SECURITY_LEVEL);
            data.add(Article.DATA_HASH, UtilHash.hashString(seckey));
            
            //保存文章
            Data data1 = handler.add(conn, data);
            
            //密级标示
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //日志
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_AUDIT,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS点击统计
            ClickCountHelper.addPage(data.getString(Article.ID), data.getString(Article.TITLE), data.getString(Article.CHANNEL_ID), "");
            
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("添加栏目时出错!", e);
            }
            log.logError("添加栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("添加栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));

        // 跳转
        return "query";
    }
    
    /**
     * 直接发布
     * @return
     */
    public String addDirect() {
        // 获取表单数据
        Data data = fillData(true);
        
        data.put(Article.SECURITY_LEVEL, "0");
        //密级 当保存数据位"NULL"字符串是数据库会提示错误
        String _securityLevel = data.getString(Article.SECURITY_LEVEL);
        if("0".equals(_securityLevel) || "1".equals(_securityLevel)){
            data.remove(Article.PROTECT_START_DATE);
            data.remove(Article.PROTECT_END_DATE);
        }
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //生成ID
            String articleId = UUIDGenerator.getUUID();
            data.add(Article.ID, articleId);
            
            //创建时间
            //Date date = new Date();
            //data.add(Article.CREATE_TIME, date);
            data.add(Article.MODIFY_TIME, data.getString(Article.CREATE_TIME));
            
            //创建人
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            UserInfo ui = SessionInfo.getCurUser();
            String personId = ui.getPerson().getPersonId();
            data.add(Article.CREATOR, personId);
            
            //检查新闻内容中是否有图片如果有，那么将它的地址保存到imageSource属性
            /*String articleContent = data.getString(Article.CONTENT);
            if(articleContent != null && !"".equals(articleContent)){
                if(articleContent.contains(new StringBuffer().append("<input type=\"image\""))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<input type=\"image\""));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
                if(articleContent.contains(new StringBuffer().append("<img"))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<img"));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
            }*/
            
            //直接发布
            data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
            //data.add(Article.ATT_ICON, iconPackageId);
            
            /********************************************/
            //数据权限
            String[] dataAccesss = getParameterValues(Article.DATA_ACCESS);
            if(dataAccesss != null && dataAccesss.length > 0){
                StringBuffer dac = new StringBuffer();
                for (int i = 0; i < dataAccesss.length; i++) {
                    String dataAccess = dataAccesss[i];
                    if(i == (dataAccesss.length - 1)){
                        dac.append(dataAccess);
                    }else{
                        dac.append(dataAccess).append(",");
                    }
                }
                data.add(Article.DATA_ACCESS, dac.toString());
            }
            
            String personRela = getParameter("IDS_PERSON_ARTICLE_RELA");
            String organRela = getParameter("IDS_ORGAN_ARTICLE_RELA");
            //授权人员
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    for (int i = 0; i < personRelas.length; i++) {
                        Data personRelaData = new Data();
                        personRelaData.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRelaData.setPrimaryKey("ID");
                        personRelaData.add("ID", UUIDGenerator.getUUID());
                        personRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        personRelaData.add("PERSON_ID", personRelas[i]);
                        handler.add(conn, personRelaData);
                    }
                }
            }
            //授权组织
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    for (int i = 0; i < organRelas.length; i++) {
                        Data organRelaData = new Data();
                        organRelaData.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRelaData.setPrimaryKey("ID");
                        organRelaData.add("ID", UUIDGenerator.getUUID());
                        organRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        organRelaData.add("ORGAN_ID", organRelas[i]);
                        handler.add(conn, organRelaData);
                    }
                }
            }
            /********************************************/
            
            /********************************************/
            //审核人
            Data channel = new Data();
            String channelId = data.getString("CHANNEL_ID");
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, channelId);
            
            channel = channelHandler.findDataByKey(conn, channel);
            if(Channel.IS_AUTH_STATUS_YES.equals(channel.getString(Channel.IS_AUTH))){
                String auditPerson = getParameter("IDS_AUDITPERSON_ARTICLE_RELA");
                if(auditPerson != null && !"".equals(auditPerson)){
                    String[] auditPersons = auditPerson.split(",");
                    for (int i = 0; i < auditPersons.length; i++) {
                        Data auditPersonData = new Data();
                        auditPersonData.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPersonData.setPrimaryKey("ID");
                        auditPersonData.add("ID", UUIDGenerator.getUUID());
                        auditPersonData.add("ARTICLE_ID", data.getString(Article.ID));
                        auditPersonData.add("AUDIT_PERSON_ID", auditPersons[i]);
                        handler.add(conn, auditPersonData);
                    }
                }
            }
            
            /********************************************/
            
            //加入组织ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(Article.CREATE_DEPT_ID, createDeptId);
            
            //密级标识防篡改
            String seckey = data.getString(Article.ID)+"$"+data.getString(Article.SECURITY_LEVEL);
            data.add(Article.DATA_HASH, UtilHash.hashString(seckey));
            
            //保存文章
            Data data1 = handler.add(conn, data);
            
            /*---------------弹出页面部分 开始------------------*/
            String skipChannel = data.getString(Article.IS_SKIP);
            String skipChannelId = CmsConfigUtil.getValue(com.hx.cms.util.Constants.SKIP_CHANNEL_ID);
            //首先要选中弹出栏目
            if(Article.IS_SKIP_YES.equals(skipChannel)){
            	//首先要有弹出栏目
                if(skipChannelId != null && !"".equals(skipChannelId)){
                	//当前栏目不能是弹出栏目，如果是则不需要在复制
                	if(!skipChannelId.equals(channelId)){
                		//开始复制
                		Data copyData = new Data(data);
                		copyData.setEntityName(Article.ARTICLE_ENTITY);
                		copyData.setPrimaryKey(Article.ID);
                		copyData.add(Article.ID, UUIDGenerator.getUUID());
                		copyData.add(Article.CHANNEL_ID, skipChannelId);
                		handler.add(conn, copyData);
                	}
                }
            }
            /*---------------弹出页面部分 结束------------------*/
            
            //密级标示
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //日志
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_PUBLISH,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS点击统计
            ClickCountHelper.addPage(data.getString(Article.ID), data.getString(Article.TITLE), data.getString(Article.CHANNEL_ID), "");
            
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("添加栏目时出错!", e);
            }
            log.logError("添加栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("添加栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));

        // 跳转
        return "query";
    }
    
    /**
     * 暂存：状态为暂存
     * @return
     */
    public String addTemp() {
        // 获取表单数据
        Data data = fillData(true);
        
        //密级 当保存数据位"NULL"字符串是数据库会提示错误
        String _securityLevel = data.getString(Article.SECURITY_LEVEL);
        if("0".equals(_securityLevel) || "1".equals(_securityLevel)){
        	data.remove(Article.PROTECT_START_DATE);
        	data.remove(Article.PROTECT_END_DATE);
        }
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //生成ID
            String articleId = UUIDGenerator.getUUID();
            data.add(Article.ID, articleId);
            
            //创建时间
            //Date date = new Date();
            //data.add(Article.CREATE_TIME, date);
            data.add(Article.MODIFY_TIME, data.getString(Article.CREATE_TIME));
            
            //创建人
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            UserInfo ui = SessionInfo.getCurUser();
            String personId = ui.getPerson().getPersonId();
            data.add(Article.CREATOR, personId);
            
            /*//检查新闻内容中是否有图片如果有，那么将它的地址保存到imageSource属性
            String articleContent = data.getString(Article.CONTENT);
            if(articleContent != null && !"".equals(articleContent)){
                if(articleContent.contains(new StringBuffer().append("<input type=\"image\""))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<input type=\"image\""));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
                if(articleContent.contains(new StringBuffer().append("<img"))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<img"));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
            }*/
            
            
            
            //暂存
            data.add(Article.STATUS, Article.STATUS_DRAFT);
            //data.add(Article.ATT_ICON, iconPackageId);
            
            /********************************************/
            //数据权限
            String[] dataAccesss = getParameterValues(Article.DATA_ACCESS);
            if(dataAccesss != null && dataAccesss.length > 0){
                StringBuffer dac = new StringBuffer();
                for (int i = 0; i < dataAccesss.length; i++) {
                    String dataAccess = dataAccesss[i];
                    if(i == (dataAccesss.length - 1)){
                        dac.append(dataAccess);
                    }else{
                        dac.append(dataAccess).append(",");
                    }
                }
                data.add(Article.DATA_ACCESS, dac.toString());
            }
            
            String personRela = getParameter("IDS_PERSON_ARTICLE_RELA");
            String organRela = getParameter("IDS_ORGAN_ARTICLE_RELA");
            //授权人员
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    for (int i = 0; i < personRelas.length; i++) {
                        Data personRelaData = new Data();
                        personRelaData.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRelaData.setPrimaryKey("ID");
                        personRelaData.add("ID", UUIDGenerator.getUUID());
                        personRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        personRelaData.add("PERSON_ID", personRelas[i]);
                        handler.add(conn, personRelaData);
                    }
                }
            }
            //授权组织
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    for (int i = 0; i < organRelas.length; i++) {
                        Data organRelaData = new Data();
                        organRelaData.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRelaData.setPrimaryKey("ID");
                        organRelaData.add("ID", UUIDGenerator.getUUID());
                        organRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        organRelaData.add("ORGAN_ID", organRelas[i]);
                        handler.add(conn, organRelaData);
                    }
                }
            }
            /********************************************/
            
            /********************************************/
            //审核人
            Data channel = new Data();
            String channelId = data.getString("CHANNEL_ID");
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, channelId);
            
            channel = channelHandler.findDataByKey(conn, channel);
            if(Channel.IS_AUTH_STATUS_YES.equals(channel.getString(Channel.IS_AUTH))){
                String auditPerson = getParameter("IDS_AUDITPERSON_ARTICLE_RELA");
                if(auditPerson != null && !"".equals(auditPerson)){
                    String[] auditPersons = auditPerson.split(",");
                    for (int i = 0; i < auditPersons.length; i++) {
                        Data auditPersonData = new Data();
                        auditPersonData.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPersonData.setPrimaryKey("ID");
                        auditPersonData.add("ID", UUIDGenerator.getUUID());
                        auditPersonData.add("ARTICLE_ID", data.getString(Article.ID));
                        auditPersonData.add("AUDIT_PERSON_ID", auditPersons[i]);
                        handler.add(conn, auditPersonData);
                    }
                }
            }
            
            /********************************************/
            
            //加入组织ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(Article.CREATE_DEPT_ID, createDeptId);
            
            //密级标识防篡改
            String seckey = data.getString(Article.ID)+"$"+data.getString(Article.SECURITY_LEVEL);
            data.add(Article.DATA_HASH, UtilHash.hashString(seckey));
            
            //保存文章
            Data data1 = handler.add(conn, data);
            //密级标示
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //日志
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_TEMP,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_3,"");
            
            //CMS点击统计
            ClickCountHelper.addPage(data.getString(Article.ID), data.getString(Article.TITLE), data.getString(Article.CHANNEL_ID), "");
            
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("添加栏目时出错!", e);
            }
            log.logError("添加栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("添加栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));

        // 跳转
        return "query";
    }
    
    /**
     * 修改组织结构
     * 
     * @return
     */
    public String modify() {
    	
        // 获取表单数据
        Data data = fillData(false);
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //修改时间
            Date date = new Date();
            data.add(Article.MODIFY_TIME, date);
            
            //检查新闻内容中是否有图片如果有，那么将它的地址保存到imageSource属性
            /*String articleContent = data.getString(Article.CONTENT);
            if(articleContent != null && !"".equals(articleContent)){
                if(articleContent.contains(new StringBuffer().append("<input type=\"image\""))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<input type=\"image\""));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
                if(articleContent.contains(new StringBuffer().append("<img"))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<img"));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
            }*/
            
            Data data1 = new Data();
            data1.setEntityName(Article.ARTICLE_ENTITY);
            data1.setPrimaryKey(Article.ID);
            data1.add(Article.ID, data.getString(Article.ID));
            data1 = handler.findDataByKey(conn, data1);
            
            /********************************************/
            //数据权限
            String[] dataAccesss = getParameterValues(Article.DATA_ACCESS);
            if(dataAccesss != null && dataAccesss.length > 0){
                StringBuffer dac = new StringBuffer();
                for (int i = 0; i < dataAccesss.length; i++) {
                    String dataAccess = dataAccesss[i];
                    if(i == (dataAccesss.length - 1)){
                        dac.append(dataAccess);
                    }else{
                        dac.append(dataAccess).append(",");
                    }
                }
                data.add(Article.DATA_ACCESS, dac.toString());
            }
            
            String personRela = getParameter("IDS_PERSON_ARTICLE_RELA");
            String organRela = getParameter("IDS_ORGAN_ARTICLE_RELA");
            //删除之前授权数据
            Data delpersonRela = new Data();
            delpersonRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
            delpersonRela.setPrimaryKey("ARTICLE_ID");
            delpersonRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delpersonRela);
            //授权人员
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    //授权
                    for (int i = 0; i < personRelas.length; i++) {
                        Data personRelaData = new Data();
                        personRelaData.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRelaData.setPrimaryKey("ID");
                        personRelaData.add("ID", UUIDGenerator.getUUID());
                        personRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        personRelaData.add("PERSON_ID", personRelas[i]);
                        handler.add(conn, personRelaData);
                    }
                }
            }
            //删除之前授权数据
            Data delorganRela = new Data();
            delorganRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
            delorganRela.setPrimaryKey("ARTICLE_ID");
            delorganRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delorganRela);
            //授权组织
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    //授权
                    for (int i = 0; i < organRelas.length; i++) {
                        Data organRelaData = new Data();
                        organRelaData.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRelaData.setPrimaryKey("ID");
                        organRelaData.add("ID", UUIDGenerator.getUUID());
                        organRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        organRelaData.add("ORGAN_ID", organRelas[i]);
                        handler.add(conn, organRelaData);
                    }
                }
            }
            /********************************************/
            
            /********************************************/
          //删除之前审核人
            Data delauditPerson = new Data();
            delauditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
            delauditPerson.setPrimaryKey("ARTICLE_ID");
            delauditPerson.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delauditPerson);
          //审核人
            Data channel = new Data();
            String channelId = data.getString("CHANNEL_ID");
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, channelId);
            channel = channelHandler.findDataByKey(conn, channel);
            
            if(Channel.IS_AUTH_STATUS_YES.equals(channel.getString(Channel.IS_AUTH))){
                String auditPerson = getParameter("IDS_AUDITPERSON_ARTICLE_RELA");
                if(auditPerson != null && !"".equals(auditPerson)){
                    String[] auditPersons = auditPerson.split(",");
                    for (int i = 0; i < auditPersons.length; i++) {
                        Data auditPersonData = new Data();
                        auditPersonData.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPersonData.setPrimaryKey("ID");
                        auditPersonData.add("ID", UUIDGenerator.getUUID());
                        auditPersonData.add("ARTICLE_ID", data.getString(Article.ID));
                        auditPersonData.add("AUDIT_PERSON_ID", auditPersons[i]);
                        handler.add(conn, auditPersonData);
                    }
                }
            }
            
            /********************************************/
            
            handler.modify(conn, data);
            //密级标示
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //日志
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_MODIFY,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS点击统计
            ClickCountHelper.updatePage(data.getString(Article.ID), data.getString(Article.TITLE), getParameter(Article.CHANNEL_ID), "");
            
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("修改栏目时出错!", e);
            }
            log.logError("修改栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("修改栏目时出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        // 跳转
        return "tempQuery";
    }
    
    /**
     * 修改组织结构
     * 
     * @return
     */
    public String modifyDirect() {
        
        // 获取表单数据
        Data data = fillData(false);
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //修改时间
            Date date = new Date();
            data.add(Article.MODIFY_TIME, date);
            
            //检查新闻内容中是否有图片如果有，那么将它的地址保存到imageSource属性
            /*String articleContent = data.getString(Article.CONTENT);
            if(articleContent != null && !"".equals(articleContent)){
                if(articleContent.contains(new StringBuffer().append("<input type=\"image\""))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<input type=\"image\""));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
                if(articleContent.contains(new StringBuffer().append("<img"))){
                    int index = articleContent.indexOf("src=\"",articleContent.indexOf("<img"));
                    data.add(Article.SHORT_PICTURE, articleContent.substring(index + "src=\"".length(),articleContent.indexOf("\"", index + "src=\"".length())));
                }
            }*/
            
          //直接发布
            data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
            
            /********************************************/
            //数据权限
            String[] dataAccesss = getParameterValues(Article.DATA_ACCESS);
            if(dataAccesss != null && dataAccesss.length > 0){
                StringBuffer dac = new StringBuffer();
                for (int i = 0; i < dataAccesss.length; i++) {
                    String dataAccess = dataAccesss[i];
                    if(i == (dataAccesss.length - 1)){
                        dac.append(dataAccess);
                    }else{
                        dac.append(dataAccess).append(",");
                    }
                }
                data.add(Article.DATA_ACCESS, dac.toString());
            }
            
            String personRela = getParameter("IDS_PERSON_ARTICLE_RELA");
            String organRela = getParameter("IDS_ORGAN_ARTICLE_RELA");
            //删除之前授权数据
            Data delpersonRela = new Data();
            delpersonRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
            delpersonRela.setPrimaryKey("ARTICLE_ID");
            delpersonRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delpersonRela);
            //授权人员
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    //授权
                    for (int i = 0; i < personRelas.length; i++) {
                        Data personRelaData = new Data();
                        personRelaData.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRelaData.setPrimaryKey("ID");
                        personRelaData.add("ID", UUIDGenerator.getUUID());
                        personRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        personRelaData.add("PERSON_ID", personRelas[i]);
                        handler.add(conn, personRelaData);
                    }
                }
            }
            //删除之前授权数据
            Data delorganRela = new Data();
            delorganRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
            delorganRela.setPrimaryKey("ARTICLE_ID");
            delorganRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delorganRela);
            //授权组织
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    //授权
                    for (int i = 0; i < organRelas.length; i++) {
                        Data organRelaData = new Data();
                        organRelaData.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRelaData.setPrimaryKey("ID");
                        organRelaData.add("ID", UUIDGenerator.getUUID());
                        organRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        organRelaData.add("ORGAN_ID", organRelas[i]);
                        handler.add(conn, organRelaData);
                    }
                }
            }
            /********************************************/
            
            /********************************************/
          //删除之前审核人
            Data delauditPerson = new Data();
            delauditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
            delauditPerson.setPrimaryKey("ARTICLE_ID");
            delauditPerson.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delauditPerson);
          //审核人
            Data channel = new Data();
            String channelId = data.getString("CHANNEL_ID");
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, channelId);
            channel = channelHandler.findDataByKey(conn, channel);
            
            if(Channel.IS_AUTH_STATUS_YES.equals(channel.getString(Channel.IS_AUTH))){
                String auditPerson = getParameter("IDS_AUDITPERSON_ARTICLE_RELA");
                if(auditPerson != null && !"".equals(auditPerson)){
                    String[] auditPersons = auditPerson.split(",");
                    for (int i = 0; i < auditPersons.length; i++) {
                        Data auditPersonData = new Data();
                        auditPersonData.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPersonData.setPrimaryKey("ID");
                        auditPersonData.add("ID", UUIDGenerator.getUUID());
                        auditPersonData.add("ARTICLE_ID", data.getString(Article.ID));
                        auditPersonData.add("AUDIT_PERSON_ID", auditPersons[i]);
                        handler.add(conn, auditPersonData);
                    }
                }
            }
            
            Data data1 = new Data();
            data1.setEntityName(Article.ARTICLE_ENTITY);
            data1.setPrimaryKey(Article.ID);
            data1.add(Article.ID, data.getString(Article.ID));
            data1 = handler.findDataByKey(conn, data1);
            
            handler.modify(conn, data);
            //密级标示
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //日志
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_MODIFY,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS点击统计
            ClickCountHelper.updatePage(data.getString(Article.ID), data.getString(Article.TITLE), getParameter(Article.CHANNEL_ID), "");
            
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("修改栏目时出错!", e);
            }
            log.logError("修改栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("修改栏目时出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        // 跳转
        return "query";
    }

    /**
     * 批量删除栏目,参数名用IDS
     * 
     * @return
     */
    public String deleteBatch() {
    	
    	//String channelId = getParameter(Article.CHANNEL_ID);

        String idString = getParameter(Article.IDS);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }

        Connection conn = null;
        DBTransaction db = null;
        Data data1 = null;
        int secLevel = -1;
        String securityLevel = "";
        try {
            // 构建批量删除对象集合
            conn = ConnectionManager.getConnection();
            // 批量删除
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                	
                	//查看是否为引用数据，如果是就只删除引用表中得引用记录
                	/*Data reference_ = new Data();
                	reference_.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                	reference_.setPrimaryKey(Article2Channels.ARTICLE_ID,Article2Channels.CHANNEL_ID);
                	reference_.add(Article2Channels.ARTICLE_ID, ids[i]);
                	reference_.add(Article2Channels.CHANNEL_ID, channelId);
                	Data ref_ = handler.findDataByKey(conn, reference_);
                	if(ref_ != null && !"".equals(ref_.getString(Article2Channels.ID))){
                        handler.delete(conn, reference_);*/
                    String id = ids[i].split(",")[0];
                    String store = ids[i].split(",")[1];
                    if("REFERENCE".equals(store)){
                        Data reference_ = new Data();
                        reference_.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                        reference_.setPrimaryKey(Article2Channels.ID);
                        reference_.add(Article2Channels.ID, id);
                        handler.delete(conn, reference_);
                	}else{
                		Data data = new Data();
                        data.setEntityName(Article.ARTICLE_ENTITY);
                        data.setPrimaryKey(Article.ID);
                        data.add(Article.ID, id);
                      //删除附件
                        data1 = handler.findDataByKey(conn, data);
                        String packageId = data1.getString("PACKAGE_ID");
                        if(AttHelper.hasAttsByPackageId(packageId)){
                            AttHelper.delAttsOfPackageId(packageId, "CMS_ARTICLE_ATT");
                        }
                        
                        //删除附件
                        /*Data artAtt = new Data();
                        artAtt.setEntityName(Article.ARTICLE_ATT_ENTITY);
                        artAtt.setPrimaryKey(Article.ARTICLE_ATT_ARTICLE_ID);
                        artAtt.add(Article.ARTICLE_ATT_ARTICLE_ID, ids[i]);
                        handler.delete(conn, artAtt);*/
                        
                        //删除审核意见列表
                        Data audit = new Data();
                        audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                        audit.setPrimaryKey(AuditOpinion.ARTICLE_ID);
                        audit.add(AuditOpinion.ARTICLE_ID, id);
                        handler.delete(conn, audit);
                        
                        //删除引用数据
                        Data reference = new Data();
                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                        reference.setPrimaryKey(Article2Channels.ARTICLE_ID);
                        reference.add(Article2Channels.ARTICLE_ID, id);
                        handler.delete(conn, reference);
                        
                        /*****************删除数据授权 开始**********************/
                        //人员权限
                        Data personRela = new Data();
                        personRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRela.setPrimaryKey("ARTICLE_ID");
                        personRela.add("ARTICLE_ID", id);
                        handler.delete(conn, personRela);
                        //组织全新啊
                        Data organRela = new Data();
                        organRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRela.setPrimaryKey("ARTICLE_ID");
                        organRela.add("ARTICLE_ID", id);
                        handler.delete(conn, organRela);
                        /******************删除数据授权 结束*********************/
                        /******************删除审核人 开始*********************/
                        Data auditPerson = new Data();
                        auditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPerson.setPrimaryKey("ARTICLE_ID");
                        auditPerson.add("ARTICLE_ID", id);
                        handler.delete(conn, auditPerson);
                        
                        /******************删除审核人 结束*********************/
                        
                        
                        //密级标示
                        secLevel = data1.getInt(Article.SECURITY_LEVEL);
                        if(secLevel > 0){
                        	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                        }
                        
                        //日志
                        AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
						        "",
						        AuditConstants.ACT_DELETE,
						        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
						        securityLevel+data1.getString(Article.TITLE,""),
						        AuditConstants.ACT_RESULT_OK,
						        AuditConstants.AUDIT_LEVEL_5,"");
                        // 处理删除
                        handler.delete(conn, data);
                	}
                    
                }
                db.commit();
            }
        } catch (Exception e) {
            data1 = new Data();
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                    "",
                    AuditConstants.ACT_DELETE,
                    CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
                    securityLevel+data1.getString(Article.TITLE,""),
                    AuditConstants.ACT_RESULT_FAIL,
                    AuditConstants.AUDIT_LEVEL_5,"");
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("批量删除栏目时出错!", e);
            }
            log.logError("批量删除栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("删除栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "query";
    }
    
    /**
     * 临时页面中的删除操作
     * @return
     */
    public String deleteBatchForTemp() {
    	
    	String channelId = getParameter(Article.CHANNEL_ID);

        String idString = getParameter(Article.IDS);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }

        Connection conn = null;
        DBTransaction db = null;
        Data data1 = null;
        try {
            // 构建批量删除对象集合
            conn = ConnectionManager.getConnection();
            // 批量删除
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                    String articleId = ids[i].split(",")[0];
                    String channel = ids[i].split(",")[1];
                    
                	//查看是否为引用数据，如果是就只删除引用表中得引用记录
                	Data reference_ = new Data();
                	reference_.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                	reference_.setPrimaryKey(Article2Channels.ARTICLE_ID,Article2Channels.CHANNEL_ID);
                	reference_.add(Article2Channels.ARTICLE_ID, articleId);
                	reference_.add(Article2Channels.CHANNEL_ID, channel);
                	Data ref_ = handler.findDataByKey(conn, reference_);
                	
                	if(ref_ != null && !"".equals(ref_.getString(Article2Channels.ID))){
                        handler.delete(conn, reference_);
                	}else{
                		Data data = new Data();
                        data.setEntityName(Article.ARTICLE_ENTITY);
                        data.setPrimaryKey(Article.ID);
                        data.add(Article.ID, articleId);
                      //删除附件
                        data1 = handler.findDataByKey(conn, data);
                        String packageId = data1.getString("PACKAGE_ID","");
                        if(AttHelper.hasAttsByPackageId(packageId)){
                            AttHelper.delAttsOfPackageId(packageId, "CMS_ARTICLE_ATT");
                        }
                        
                        
                        //删除附件
                        /*Data artAtt = new Data();
                        artAtt.setEntityName(Article.ARTICLE_ATT_ENTITY);
                        artAtt.setPrimaryKey(Article.ARTICLE_ATT_ARTICLE_ID);
                        artAtt.add(Article.ARTICLE_ATT_ARTICLE_ID, articleId);
                        handler.delete(conn, artAtt);*/
                        
                        //删除审核意见列表
                        Data audit = new Data();
                        audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                        audit.setPrimaryKey(AuditOpinion.ARTICLE_ID);
                        audit.add(AuditOpinion.ARTICLE_ID, articleId);
                        handler.delete(conn, audit);
                        
                        //删除引用数据
                        Data reference = new Data();
                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                        reference.setPrimaryKey(Article2Channels.ARTICLE_ID);
                        reference.add(Article2Channels.ARTICLE_ID, articleId);
                        handler.delete(conn, reference);
                        
                        /*****************删除数据授权 开始**********************/
                        //人员权限
                        Data personRela = new Data();
                        personRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRela.setPrimaryKey("ARTICLE_ID");
                        personRela.add("ARTICLE_ID", articleId);
                        handler.delete(conn, personRela);
                        //组织全新啊
                        Data organRela = new Data();
                        organRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRela.setPrimaryKey("ARTICLE_ID");
                        organRela.add("ARTICLE_ID", articleId);
                        handler.delete(conn, organRela);
                        /******************删除数据授权 结束*********************/
                        /******************删除审核人 开始*********************/
                        Data auditPerson = new Data();
                        auditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPerson.setPrimaryKey("ARTICLE_ID");
                        auditPerson.add("ARTICLE_ID", articleId);
                        handler.delete(conn, auditPerson);
                        
                        /******************删除审核人 结束*********************/
                        
                        
                        //密级标示
                        int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                        String securityLevel = "";
                        if(secLevel > 0){
                        	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                        }
                        
                        //日志
                        AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
						        "",
						        AuditConstants.ACT_DELETE,
						        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
						        securityLevel+data1.getString(Article.TITLE,""),
						        AuditConstants.ACT_RESULT_OK,
						        AuditConstants.AUDIT_LEVEL_5,"");
                        handler.delete(conn, data);
                	}
                }
            }
            
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("批量删除栏目时出错!", e);
            }
            log.logError("批量删除栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("删除栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, channelId);
        
        return "tempQuery";
    }
    
    /**
     * 取消发布：撤销发布
     * @return 
     */
    public String cancelPublish() {

        String idString = getParameter(Article.IDS);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }

        Connection conn = null;
        DBTransaction db = null;
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                    Data data = new Data();
                    data.setEntityName(Article.ARTICLE_ENTITY);
                    data.setPrimaryKey(Article.ID);
                    data.add(Article.ID, ids[i]);
                    data.add(Article.STATUS, Article.STATUS_CANCEL_PUBLISH);
                    
                    Data data1 = new Data();
                    data1.setEntityName(Article.ARTICLE_ENTITY);
                    data1.setPrimaryKey(Article.ID);
                    data1.add(Article.ID, ids[i]);
                    data1 = handler.findDataByKey(conn, data1);
                    
                    handler.modify(conn, data);
                    //密级标示
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //日志
                    AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					        "",
					        AuditConstants.ACT_BACK,
					        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					        securityLevel+data1.getString(Article.TITLE,""),
					        AuditConstants.ACT_RESULT_OK,
					        AuditConstants.AUDIT_LEVEL_5,"");
                }
            }
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("批量删除栏目时出错!", e);
            }
            log.logError("批量删除栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("删除栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "query";
    }
    
    /**
     * 通过审核
     * @return 
     */
    public String passAudit() {

        String idString = getParameter(Article.IDS);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }
        
        Connection conn = null;
        DBTransaction db = null;
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        String auditOpinion = getParameter(AuditOpinion.AUDIT_OPINION);
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                    Data data = new Data();
                    data.setEntityName(Article.ARTICLE_ENTITY);
                    data.setPrimaryKey(Article.ID);
                    data.add(Article.ID, ids[i]);
                    data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
                    //添加审核通过时间
                    Date date = new Date();
                    String createTime_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
                    data.add(Article.AUDIT_PASS_TIME, createTime_);
                    
                    Data data1 = new Data();
                    data1.setEntityName(Article.ARTICLE_ENTITY);
                    data1.setPrimaryKey(Article.ID);
                    data1.add(Article.ID, ids[i]);
                    data1 = handler.findDataByKey(conn, data1);
                    
                    handler.modify(conn, data);
                    
                    /*---------------弹出页面部分 开始------------------*/
                    String skipChannel = data1.getString(Article.IS_SKIP);
                    String skipChannelId = CmsConfigUtil.getValue(com.hx.cms.util.Constants.SKIP_CHANNEL_ID);
                    //首先要选中弹出栏目
                    if(Article.IS_SKIP_YES.equals(skipChannel)){
                    	//首先要有弹出栏目
                        if(skipChannelId != null && !"".equals(skipChannelId)){
                        	//当前栏目不能是弹出栏目，如果是则不需要在复制
                        	if(!skipChannelId.equals(data1.getString(Article.CHANNEL_ID))){
                        		//开始复制
                        		Data copyData = new Data(data1);
                        		copyData.setEntityName(Article.ARTICLE_ENTITY);
                        		copyData.setPrimaryKey(Article.ID);
                        		copyData.add(Article.ID, UUIDGenerator.getUUID());
                        		copyData.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
                        		copyData.add(Article.AUDIT_PASS_TIME, createTime_);
                        		copyData.add(Article.CHANNEL_ID, skipChannelId);
                        		handler.add(conn, copyData);
                        	}
                        }
                    }
                    /*---------------弹出页面部分 结束------------------*/
                    	
                    //密级标示
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //日志
                    AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					        "",
					        AuditConstants.ACT_PUBLISH,
					        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					        securityLevel+data1.getString(Article.TITLE,""),
					        AuditConstants.ACT_RESULT_OK,
					        AuditConstants.AUDIT_LEVEL_5,"");
                    
                    //审核信息
                    if(auditOpinion != null && !"".equals(auditOpinion)){
                    	Data audit = new Data();
                        audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                        audit.setPrimaryKey(AuditOpinion.ID);
                        audit.add(AuditOpinion.ID, UUIDGenerator.getUUID());
                        audit.add(AuditOpinion.USER_ID, user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"");
                        audit.add(AuditOpinion.ARTICLE_ID, ids[i]);
                        audit.add(AuditOpinion.AUDIT_OPINION, getParameter(AuditOpinion.AUDIT_OPINION));
                        
                        
                        audit.add(AuditOpinion.AUDIT_TIME, createTime_);
                        handler.add(conn, audit);
                    }
                }
            }
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("批量删除栏目时出错!", e);
            }
            log.logError("批量删除栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("删除栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "auditQuery";
    }
    
    /**
     * 暂存中的直接发布
     * @return
     */
    public String tempModifyDirect() {
    	
    	String id = getParameter("Article_ID");
    	
    	Connection conn = null;
    	DBTransaction db = null;
    	try {
    		conn = ConnectionManager.getConnection();
    		db = DBTransaction.getInstance(conn);
    		if (id != null && !"".equals(id)) {
    			Data data = fillData(false);
				data.setEntityName(Article.ARTICLE_ENTITY);
				data.setPrimaryKey(Article.ID);
				data.add(Article.ID, id);
				data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
				
				//添加审核通过时间
				Date date = new Date();
				String createTime_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
				data.add(Article.AUDIT_PASS_TIME, createTime_);
				
				Data data1 = new Data();
				data1.setEntityName(Article.ARTICLE_ENTITY);
				data1.setPrimaryKey(Article.ID);
				data1.add(Article.ID, id);
				data1 = handler.findDataByKey(conn, data1);
				
				/********************************************/
	            //数据权限
	            String[] dataAccesss = getParameterValues(Article.DATA_ACCESS);
	            if(dataAccesss != null && dataAccesss.length > 0){
	                StringBuffer dac = new StringBuffer();
	                for (int i = 0; i < dataAccesss.length; i++) {
	                    String dataAccess = dataAccesss[i];
	                    if(i == (dataAccesss.length - 1)){
	                        dac.append(dataAccess);
	                    }else{
	                        dac.append(dataAccess).append(",");
	                    }
	                }
	                data.add(Article.DATA_ACCESS, dac.toString());
	            }
	            
	            String personRela = getParameter("IDS_PERSON_ARTICLE_RELA");
	            String organRela = getParameter("IDS_ORGAN_ARTICLE_RELA");
	            //授权人员
	            if(personRela != null && !"".equals(personRela)){
	                String[] personRelas = personRela.split(",");
	                if(personRelas != null){
	                    //删除之前授权数据
	                    Data del = new Data();
	                    del.setEntityName("CMS_PERSON_ARTICLE_RELA");
	                    del.setPrimaryKey("ARTICLE_ID");
	                    del.add("ARTICLE_ID", data.getString(Article.ID));
	                    handler.delete(conn, del);
	                    //授权
	                    for (int i = 0; i < personRelas.length; i++) {
	                        Data personRelaData = new Data();
	                        personRelaData.setEntityName("CMS_PERSON_ARTICLE_RELA");
	                        personRelaData.setPrimaryKey("ID");
	                        personRelaData.add("ID", UUIDGenerator.getUUID());
	                        personRelaData.add("ARTICLE_ID", data.getString(Article.ID));
	                        personRelaData.add("PERSON_ID", personRelas[i]);
	                        handler.add(conn, personRelaData);
	                    }
	                }
	            }
	            //授权组织
	            if(organRela != null && !"".equals(organRela)){
	                String[] organRelas = organRela.split(",");
	                if(organRelas != null){
	                    //删除之前授权数据
	                    Data del = new Data();
	                    del.setEntityName("CMS_ORGAN_ARTICLE_RELA");
	                    del.setPrimaryKey("ARTICLE_ID");
	                    del.add("ARTICLE_ID", data.getString(Article.ID));
	                    handler.delete(conn, del);
	                    //授权
	                    for (int i = 0; i < organRelas.length; i++) {
	                        Data organRelaData = new Data();
	                        organRelaData.setEntityName("CMS_ORGAN_ARTICLE_RELA");
	                        organRelaData.setPrimaryKey("ID");
	                        organRelaData.add("ID", UUIDGenerator.getUUID());
	                        organRelaData.add("ARTICLE_ID", data.getString(Article.ID));
	                        organRelaData.add("ORGAN_ID", organRelas[i]);
	                        handler.add(conn, organRelaData);
	                    }
	                }
	            }
	            /********************************************/
				
				handler.modify(conn, data);
				
				/*---------------弹出页面部分 开始------------------*/
				String skipChannel = data1.getString(Article.IS_SKIP);
				String skipChannelId = CmsConfigUtil.getValue(com.hx.cms.util.Constants.SKIP_CHANNEL_ID);
				//首先要选中弹出栏目
				if(Article.IS_SKIP_YES.equals(skipChannel)){
					//首先要有弹出栏目
					if(skipChannelId != null && !"".equals(skipChannelId)){
						//当前栏目不能是弹出栏目，如果是则不需要在复制
						if(!skipChannelId.equals(data1.getString(Article.CHANNEL_ID))){
							//开始复制
							Data copyData = new Data(data1);
							copyData.setEntityName(Article.ARTICLE_ENTITY);
							copyData.setPrimaryKey(Article.ID);
							copyData.add(Article.ID, UUIDGenerator.getUUID());
							copyData.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
							copyData.add(Article.AUDIT_PASS_TIME, createTime_);
							copyData.add(Article.CHANNEL_ID, skipChannelId);
							handler.add(conn, copyData);
						}
					}
				}
				/*---------------弹出页面部分 结束------------------*/
				
				//密级标示
				int secLevel = data1.getInt(Article.SECURITY_LEVEL);
				String securityLevel = "";
				if(secLevel > 0){
					securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
				}
				
				//日志
				AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
						"",
						AuditConstants.ACT_PUBLISH,
						CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
						securityLevel+data1.getString(Article.TITLE,""),
						AuditConstants.ACT_RESULT_OK,
						AuditConstants.AUDIT_LEVEL_5,"");
			}
    		db.commit();
    	} catch (Exception e) {
    		try {
    			db.rollback();
    		} catch (SQLException e1) {
    			log.logError("批量删除栏目时出错!", e);
    		}
    		log.logError("批量删除栏目时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("删除栏目时关闭Connection出错!", e);
    		}
    	}
    	//组织机构ID
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	return "tempQuery";
    }
    
    /**
     * 驳回审核：即成为暂存状态
     * @return
     */
    public String backAudit() {

        String idString = getParameter(Article.IDS);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }

        Connection conn = null;
        DBTransaction db = null;
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        String auditOpinion = getParameter(AuditOpinion.AUDIT_OPINION);
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                    Data data = new Data();
                    data.setEntityName(Article.ARTICLE_ENTITY);
                    data.setPrimaryKey(Article.ID);
                    data.add(Article.ID, ids[i]);
                    data.add(Article.STATUS, Article.STATUS_BACK_AUDIT);
                    handler.modify(conn, data);
                    
                    Data data1 = new Data();
                    data1.setEntityName(Article.ARTICLE_ENTITY);
                    data1.setPrimaryKey(Article.ID);
                    data1.add(Article.ID, ids[i]);
                    data1 = handler.findDataByKey(conn, data1);
                    
                    //密级标示
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //日志
                    AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					        "",
					        AuditConstants.ACT_BACK,
					        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					        securityLevel+data1.getString(Article.TITLE,""),
					        AuditConstants.ACT_RESULT_OK,
					        AuditConstants.AUDIT_LEVEL_5,"");
                    
                    //审核信息
                    if(auditOpinion != null && !"".equals(auditOpinion)){
                    	Data audit = new Data();
                        audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                        audit.setPrimaryKey(AuditOpinion.ID);
                        audit.add(AuditOpinion.ID, UUIDGenerator.getUUID());
                        audit.add(AuditOpinion.USER_ID, user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"");
                        audit.add(AuditOpinion.ARTICLE_ID, ids[i]);
                        audit.add(AuditOpinion.AUDIT_OPINION, getParameter(AuditOpinion.AUDIT_OPINION));
                        Date date = new Date();
                        String createTime_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
                        audit.add(AuditOpinion.AUDIT_TIME, createTime_);
                        handler.add(conn, audit);
                    }
                }
            }
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("批量删除栏目时出错!", e);
            }
            log.logError("批量删除栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("删除栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "auditQuery";
    }
    
    /**
     * 提交审核
     * @return
     */
    public String submitAudit() {

        String idString = getParameter(Article.IDS);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("#");
        }

        Connection conn = null;
        DBTransaction db = null;
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                    Data data = new Data();
                    data.setEntityName(Article.ARTICLE_ENTITY);
                    data.setPrimaryKey(Article.ID);
                    data.add(Article.ID, ids[i]);
                    data.add(Article.STATUS, Article.STATUS_WAIT_AUDIT);
                    
                    
                    Data data1 = new Data();
                    data1.setEntityName(Article.ARTICLE_ENTITY);
                    data1.setPrimaryKey(Article.ID);
                    data1.add(Article.ID, ids[i]);
                    data1 = handler.findDataByKey(conn, data1);
                    
                    handler.modify(conn, data);
                    //密级标示
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //日志
                    AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					        "",
					        AuditConstants.ACT_AUDIT,
					        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					        securityLevel+data1.getString(Article.TITLE,""),
					        AuditConstants.ACT_RESULT_OK,
					        AuditConstants.AUDIT_LEVEL_5,"");
                }
            }
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("批量删除栏目时出错!", e);
            }
            log.logError("批量删除栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("删除栏目时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "tempQuery";
    }
    
    /**
     * 提交审核
     * @return
     */
    public String submitAuditSingle() {
    	
     // 获取表单数据
        Data data = fillData(false);
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
    	
    	Connection conn = null;
    	DBTransaction db = null;
    	try {
    		conn = ConnectionManager.getConnection();
    		db = DBTransaction.getInstance(conn);
    		
    		//修改时间
            Date date = new Date();
            data.add(Article.MODIFY_TIME, date);
    		
    		/********************************************/
            //数据权限
            String[] dataAccesss = getParameterValues(Article.DATA_ACCESS);
            if(dataAccesss != null && dataAccesss.length > 0){
                StringBuffer dac = new StringBuffer();
                for (int i = 0; i < dataAccesss.length; i++) {
                    String dataAccess = dataAccesss[i];
                    if(i == (dataAccesss.length - 1)){
                        dac.append(dataAccess);
                    }else{
                        dac.append(dataAccess).append(",");
                    }
                }
                data.add(Article.DATA_ACCESS, dac.toString());
            }
            
            String personRela = getParameter("IDS_PERSON_ARTICLE_RELA");
            String organRela = getParameter("IDS_ORGAN_ARTICLE_RELA");
            //删除之前授权数据
            Data delpersonRela = new Data();
            delpersonRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
            delpersonRela.setPrimaryKey("ARTICLE_ID");
            delpersonRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delpersonRela);
            //授权人员
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    //授权
                    for (int i = 0; i < personRelas.length; i++) {
                        Data personRelaData = new Data();
                        personRelaData.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRelaData.setPrimaryKey("ID");
                        personRelaData.add("ID", UUIDGenerator.getUUID());
                        personRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        personRelaData.add("PERSON_ID", personRelas[i]);
                        handler.add(conn, personRelaData);
                    }
                }
            }
            //删除之前授权数据
            Data delorganRela = new Data();
            delorganRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
            delorganRela.setPrimaryKey("ARTICLE_ID");
            delorganRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delorganRela);
            //授权组织
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    //授权
                    for (int i = 0; i < organRelas.length; i++) {
                        Data organRelaData = new Data();
                        organRelaData.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRelaData.setPrimaryKey("ID");
                        organRelaData.add("ID", UUIDGenerator.getUUID());
                        organRelaData.add("ARTICLE_ID", data.getString(Article.ID));
                        organRelaData.add("ORGAN_ID", organRelas[i]);
                        handler.add(conn, organRelaData);
                    }
                }
            }
            /********************************************/
            
            /********************************************/
          //删除之前审核人
            Data delauditPerson = new Data();
            delauditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
            delauditPerson.setPrimaryKey("ARTICLE_ID");
            delauditPerson.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delauditPerson);
          //审核人
            Data channel = new Data();
            String channelId = data.getString("CHANNEL_ID");
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, channelId);
            channel = channelHandler.findDataByKey(conn, channel);
            
            if(Channel.IS_AUTH_STATUS_YES.equals(channel.getString(Channel.IS_AUTH))){
                String auditPerson = getParameter("IDS_AUDITPERSON_ARTICLE_RELA");
                if(auditPerson != null && !"".equals(auditPerson)){
                    String[] auditPersons = auditPerson.split(",");
                    for (int i = 0; i < auditPersons.length; i++) {
                        Data auditPersonData = new Data();
                        auditPersonData.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPersonData.setPrimaryKey("ID");
                        auditPersonData.add("ID", UUIDGenerator.getUUID());
                        auditPersonData.add("ARTICLE_ID", data.getString(Article.ID));
                        auditPersonData.add("AUDIT_PERSON_ID", auditPersons[i]);
                        handler.add(conn, auditPersonData);
                    }
                }
            }
    		
			data.add(Article.STATUS, Article.STATUS_WAIT_AUDIT);
			
			
			Data data1 = new Data();
			data1.setEntityName(Article.ARTICLE_ENTITY);
			data1.setPrimaryKey(Article.ID);
			data1.add(Article.ID, data.getString(Article.ID));
			data1 = handler.findDataByKey(conn, data1);
			
			handler.modify(conn, data);
			//密级标示
			int secLevel = data1.getInt(Article.SECURITY_LEVEL);
			String securityLevel = "";
			if(secLevel > 0){
				securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
			}
			
			//日志
			AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					"",
					AuditConstants.ACT_AUDIT,
					CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					securityLevel+data1.getString(Article.TITLE,""),
					AuditConstants.ACT_RESULT_OK,
					AuditConstants.AUDIT_LEVEL_5,"");
    		db.commit();
    	} catch (Exception e) {
    		try {
    			db.rollback();
    		} catch (SQLException e1) {
    			log.logError("批量删除栏目时出错!", e);
    		}
    		log.logError("批量删除栏目时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("删除栏目时关闭Connection出错!", e);
    		}
    	}
    	//组织机构ID
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	
    	return "tempQuery";
    }
    
    /**
     * 显示附件图标
     * @return
     */
    public String displayAttIcon(){
        String packageId = getParameter("PACKAGE_ID");
        String code = getParameter("CODE"); //附件类型
        HttpServletResponse response = getResponse();
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            if(code != null && !"".equals(code)){
                //获得图片
                getAttIcon(packageId, code, response, conn);
            }else{
                //获得图片
                getAttIconNoCode(packageId, response);
            }
        } catch (Exception e) {
            log.logError("显示附件图标时出错!");
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("显示附件图标时关闭Connection出错!", e);
            }
        }
        return null;
    }
    
    /**
     * Ajax获取弹出页面的个数及弹出的先后顺序
     * @return
     */
    public String ajaxSkipList(){
    	
    	String orderString = "IS_TOP DESC, SEQ_NUM ASC, CREATE_TIME DESC";

    	//弹出栏目ID
    	String channelId = getParameter("CHANNEL_ID");
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
                //查询
                dataList = handler.findSkipList(conn,data,orderString);
            }
            json.append("<?xml version=\"1.0\"?>");
            if(dataList != null && dataList.size() > 0){
            	json.append("<root size=\""+dataList.size()+"\"");
            	for (int i = 0; i < dataList.size(); i++) {
					Data data = dataList.getData(i);
					json.append("<item num=\""+i+"\" name=\""+data.getString(Article.TITLE)+"\" id=\""+data.getString(Article.ID)+"\" />");
				}
            	json.append("</root>");
            }else{
            	json.append("<root></root>");
            }
            
            
            HttpServletResponse response = getResponse();
            response.reset();
            //response.setContentType("text/html;charset="+Constants.ENCODE_TYPE);
            response.setContentType("text/xml;charset="+getRequest().getCharacterEncoding());
            response.getWriter().println(json.toString());
            response.getWriter().flush();
            response.getWriter().close();
            
        } catch (Exception e) {
            log.logError("转去修改内部刊物时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去修改内部刊物时关闭Connection出错!", e);
            }
        }
        return null;
    }
    
    /**
     * Ajax获取弹出内容的详细信息
     * @return
     */
    public String ajaxSkipDesc(){

    	//弹出页面内容ID
    	String id = getParameter("ID");
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
                //审核通过的文章
            	data2.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
                //查询
                data = handler.findDataByKey(conn,data2);
            }
            
            if(data != null){
            	json.append(data.getString(Article.CONTENT));
            }
            HttpServletResponse response = getResponse();
            response.reset();
            response.setContentType("text/html;charset="+getRequest().getCharacterEncoding());
            response.getWriter().println(json.toString());
            response.getWriter().flush();
            response.getWriter().close();
            
        } catch (Exception e) {
            log.logError("转去修改内部刊物时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去修改内部刊物时关闭Connection出错!", e);
            }
        }
        return null;
    }
    
    /**
     * 年度行业报告附件用weboffice显示
     * @return
     */
    @SuppressWarnings("deprecation")
	public String detail(){
        String packageId = getParameter(Article.PACKAGE_ID);
        String code = getParameter("CODE");
        setAttribute(Article.PACKAGE_ID, packageId);
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            List<Att> dataList = null;
            if(code != null && !"".equals(code)){
            	//dataList = AttHelper.findAttsByPackageId(packageId, code);
            	dataList = AttHelper.findAttListByPackageId(packageId,code);
            }else{
            	//dataList = AttHelper.findAttsByPackageId(packageId);
            	dataList = AttHelper.findAttListByPackageId(packageId);
            }
            
            String type = "";
            String name = "";
            if(dataList != null && dataList.size() > 0){
            	Att data2 = dataList.get(0);
            	if(data2 != null){
            		type = data2.getAttName();
            		if(type != null && !"".equals(type)){
            			String[] as = type.split("[.]");
            			if(as != null && as.length > 0){
            				type = as[(as.length - 1)];
            				name = as[0];
            			}
            		}
            	}
            }
            //附件的文件后缀
            setAttribute("SUFFIX", type);
            setAttribute("name", name);
        } catch (Exception e) {
            log.logError("转去显示内容附件时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去显示内容附件时关闭Connection出错!", e);
            }
        }
        //结束
        return "detail";
    }
    
    /**
     * 转向 --> 将已存在的栏目下得内容引用到其他栏目:角色验证
     * @return
     */
    /*public String toReferenceArticle(){
    	Connection conn = null;
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //查询
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	dataList = channelHandler.findChannelsOfRole(conn,roles);
            }
            
        } catch (Exception e) {
            log.logError("转去给角色分配资源时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("转去给角色分配资源时关闭Connection出错!", e);
            }
        }
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	setAttribute(Article2Channels.IDS, getParameter(Article2Channels.IDS));
        // 传递组织树
        setAttribute("dataList", dataList);
        return "toReferenceArticle";
    }*/
    
    /**
     * 转向 --> 将已存在的栏目下得内容引用到其他栏目:人员验证
     * @return
     */
    public String toReferenceArticle(){
    	Connection conn = null;
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//查询
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
    		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
    		dataList = channelHandler.findChannelsOfPerson(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
    	} catch (Exception e) {
    		log.logError("转去给角色分配资源时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("转去给角色分配资源时关闭Connection出错!", e);
    		}
    	}
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	setAttribute(Article2Channels.IDS, getParameter(Article2Channels.IDS));
    	// 传递组织树
    	setAttribute("dataList", dataList);
    	return "toReferenceArticle";
    }
    
    /**
     * 将已存在的栏目下得内容引用到其他栏目
     * 
     * @return
     */
    public String referenceArticle() {
        
        Connection conn = null;
        DBTransaction db = null;
        //获取参数
        String currentChannelId = getParameter(Article.CHANNEL_ID);
        String targetChannels = getParameter("CHANNELS");//发布目标栏目
        String[] channelIds = null;
        if (targetChannels != null && !"".equals(targetChannels.trim())) {
        	channelIds = targetChannels.split(",");
        }
        
        String V = getParameter(Article2Channels.IDS);
        String[] ids = null;
        if (V != null && !"".equals(V.trim())) {
            ids = V.split("#");
        }
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            //多个栏目
            if(channelIds != null){
            	for (int k = 0; k < channelIds.length; k++) {
            	    //分隔传过来的V：ID(保存数据ID或引用数据ID),store(保存，引用),channel(原来的)
            	    
					String targetChannel = channelIds[k];//发布目标栏目
					
					//应用到的栏目不能和文章原始所在栏目重复
					/*if(targetChannel.equals(currentChannelId)){
						continue;
					}*/
					
					if(ids != null){
					    for (int i = 0; i < ids.length; i++) {
					        //分隔传过来的V：ID(保存数据ID或引用数据ID),store(保存，引用),channel(原来的)
					        String id = ids[i].split(",")[0];
					        String store = ids[i].split(",")[1];
		                    if("REFERENCE".equals(store)){//如果该数据为引用数据，查出原数据ID
		                        Data reference = new Data();
		                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
		                        reference.setPrimaryKey(Article2Channels.ID);
		                        reference.add(Article2Channels.ID, id);
		                        Data ref = handler.findDataByKey(conn, reference);
		                        id = ref.getString("ARTICLE_ID");
		                    }
		                    DataList dl = handler.getChannelIdsOfArticle(conn,id);//原数据所有的channel
		                    StringBuffer SB = new StringBuffer();
		                    for(int j=0;j<dl.size();j++){
		                        String channel = dl.getData(j).getString("CHANNEL_ID");
		                        if(j == 0){
		                            SB.append(channel);
		                        }else{
		                            SB.append(",").append(channel);
		                        }
		                    }
		                    String oldChannels = SB.toString();
		                  //应用到的栏目不能和文章原始所在栏目重复
		                    if(oldChannels.contains(targetChannel)){
		                        continue;
		                    }
		                    Data data1 = new Data();
                            data1.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                            data1.setPrimaryKey(Article2Channels.ID);
                            data1.add(Article2Channels.ID, UUIDGenerator.getUUID());
                            data1.add(Article2Channels.CHANNEL_ID, targetChannel);
                            data1.add(Article2Channels.ARTICLE_ID, id);
                            handler.add(conn, data1);
					    }
					}
            		
					/*Data data = new Data();
		            data.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
		            data.setPrimaryKey(Article2Channels.ID);
		            data.add(Article2Channels.CHANNEL_ID, targetChannel);
		            DataList dataList = handler.findListByData(conn, data);
		            
		            //多个文章
		        	if(ids != null){
		            	for (int i = 0; i < ids.length; i++) {
		            		//当前
		            		String articleId = ids[i];
		            		if(dataList != null && dataList.size() > 0){
		            			boolean f = true;
		                		for (int j = 0; j < dataList.size(); j++) {
		    						Data data2 = dataList.getData(j);
		    						if(articleId.equals(data2.getString(Article2Channels.ARTICLE_ID))){
		    							f = false;
		    							break;
		    						}
		    					}
		                		if(!f){
		                			continue;
		                		}
		            		}
		            		
		            		Data data1 = new Data();
		            		data1.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
		            		data1.setPrimaryKey(Article2Channels.ID);
		            		data1.add(Article2Channels.ID, UUIDGenerator.getUUID());
		            		data1.add(Article2Channels.CHANNEL_ID, targetChannel);
		            		data1.add(Article2Channels.ARTICLE_ID, articleId);
		                    handler.add(conn, data1);
		            	}
		            }*/
				}
            }
            // 提交
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("引用内容到其他栏目时出错!", e);
            }
            log.logError("引用内容到其他栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("引用内容到其他栏目时出错!", e);
            }
        }
        //组织机构ID
        setAttribute(Article.CHANNEL_ID, currentChannelId);
        // 跳转
        return "query";
    }
    
    public String receiptList() throws Exception{
        String compositor=getParameter("compositor","");
        if(compositor==null||compositor.equals("")){
            compositor="CREATE_TIME";
        }
        String ordertype=getParameter("ordertype","");
        if(ordertype!=null&&ordertype.equals("")){
            ordertype="DESC";
        }
        Connection conn=null;
        try {
            conn=ConnectionManager.getConnection();
            UserInfo ui = SessionInfo.getCurUser();
            String orgId = ui.getCurOrgan().getId();
            DataList dl = handler.findReceiptList(conn,orgId,compositor,ordertype);
            setAttribute("dl", dl);
            setAttribute("compositor", compositor);
            setAttribute("ordertype", ordertype);
        }catch (Exception e) {
            throw e;
        }finally{
            if (conn!=null){
                if(!conn.isClosed()){
                    conn.close();
                }
            }
        }
        
        return SUCCESS;
    }
    
    public String receiptAdd() throws Exception{
        Connection conn=null;
        String ID = getParameter("ID");
        try {
            conn=ConnectionManager.getConnection();
            Data showdata = handler.getArticle(conn,ID);
            String title = showdata.getString("TITLE", "");
            title = title.replaceAll("\n", "<br />");
            showdata.put("TITLE", title);
            showdata.add("LOGIN_PERSON", SessionInfo.getCurUser().getPerson().getPersonId());
            String PACKAGE_ID = showdata.getString("PACKAGE_ID", "");
            if(AttHelper.hasAttsByPackageId(PACKAGE_ID)){
                showdata.put("IS_HAVE_ATT", "1");
            }else{
                showdata.put("IS_HAVE_ATT", "0");
            }
            
            String id = showdata.getString("ID", "");
            UserInfo ui = SessionInfo.getCurUser();
            String personId = ui.getPersonId();
            DataList dl = handler.findReceiptContent(conn,id,personId);
            setAttribute("data", showdata);
            setAttribute("dl", dl);
        }catch (Exception e) {
            throw e;
        }finally{
            if (conn!=null){
                if(!conn.isClosed()){
                    conn.close();
                }
            }
        }
        
        return SUCCESS;
    }
    
    public String receiptSave() throws Exception{
        Connection conn = null;
        DBTransaction dt = null;
        Data data = getRequestEntityData("R_","ID","RECEIPT_CONTENT","RECEIPT_OBJECT");
        try {
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data receiptD = new Data();
            receiptD.add("UUID", "");
            receiptD.add("ARTICLE_ID", data.getString("ID"));
            receiptD.add("RECEIPT_CONTENT", data.getString("RECEIPT_CONTENT"));
            receiptD.add("RECEIPT_PERSON", SessionInfo.getCurUser().getPerson().getPersonId());
            receiptD.add("RECEIPT_TIME", DateUtility.getCurrentDateTime());
            receiptD.add("RECEIPT_OBJECT", data.getString("RECEIPT_OBJECT",""));
            
            handler.receiptSave(conn,receiptD);
            dt.commit();
        } catch (SQLException e) {
            try {
                // 事务 第三步
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败！");
            setAttribute("clueTo", clueTo);
        } finally {
            try {
                // 事务 第四步
                dt.setAutoCommit();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (conn!=null){
                if(!conn.isClosed()){
                    conn.close();
                }
            }
        }
        return SUCCESS;
    }

    /**
     * 未实现
     */
    public String execute() throws Exception {
        return "default";
    }

    /*---------------------类private内部方法-----------------------*/

    /**
     * 填充表单数据到Data对象
     * 
     * @return
     */
    private Data fillData(boolean isTrue) {
        // 获取数据
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);

        // 得到所有 组织结构类型 参数前缀的键值集合
        Map<String, String> map = getDataWithPrefix(Article.ARTICLE_PREFIX, isTrue);
        if (map != null && !map.isEmpty()) {
            Iterator<String> keys = map.keySet().iterator();
            while (keys.hasNext()) {
                String key = (String) keys.next();
                String value = (String) map.get(key);
                data.add(key, value);
            }
        }
        return data;
    }
    
    /**
     * 没有CODE时获取附件图标
     * @param packageId
     * @param response
     * @throws FileNotFoundException
     * @throws UnsupportedEncodingException
     * @throws IOException
     */
    @SuppressWarnings("deprecation")
	private void getAttIconNoCode(String packageId, HttpServletResponse response)
            throws FileNotFoundException, UnsupportedEncodingException,
            IOException {
        Data data;
        OutputStream out;
        BufferedInputStream in;
        if(packageId != null && !"".equals(packageId)){
            //DataList dataList = AttHelper.findAttsByPackageId(packageId);
        	List<Att> dataList = AttHelper.findAttListByPackageId(packageId);
            if(dataList != null && dataList.size() > 0){
            	Att att = dataList.get(0);
                //如果是磁盘类型从磁盘下载
                if(att.getFileSystemPath() != null && !"".equals(att.getFileSystemPath())){
                    File file = new File(att.getFileSystemPath(),att.getRandomName());
                    if(!file.exists()){
                        in = new BufferedInputStream(Article.class.getClassLoader().getResourceAsStream(Article.DEFAULT_ATT_ICON_NAME));
                    }else{
                        in = new BufferedInputStream(new FileInputStream(file));
                    }
                }else{
                    //封装
                    in = new BufferedInputStream((InputStream) att.getAttContent());
                }
                //重置
                response.reset();
                response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
                response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(att.getAttName(), getRequest().getCharacterEncoding()));
                out = response.getOutputStream();
                //读写
                byte[] b = new byte[1024];
                while(in.read(b) != -1){
                    out.write(b);
                    //重置
                    b = new byte[1024];
                }
                //关闭
                out.flush();
                in.close();
                out.close();
            }
        }else{
            //没有上传图片附件
            in = new BufferedInputStream(Article.class.getClassLoader().getResourceAsStream(Article.DEFAULT_ATT_ICON_NAME));
            //重置
            response.reset();
            response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
            response.setHeader("Content-Disposition", "attachment;filename=default_icon");
            out = response.getOutputStream();
            //读写
            byte[] b = new byte[1024];
            while(in.read(b) != -1){
                out.write(b);
                //重置
                b = new byte[1024];
            }
            //关闭
            out.flush();
            in.close();
            out.close();
        }
    }

    /**
     * 有CODE时获取附件图标
     * @param packageId
     * @param code
     * @param response
     * @param conn
     * @throws FileNotFoundException
     * @throws SQLException
     * @throws UnsupportedEncodingException
     * @throws IOException
     */
    @SuppressWarnings("deprecation")
	private void getAttIcon(String packageId, String code,
            HttpServletResponse response, Connection conn)
            throws FileNotFoundException, SQLException,
            UnsupportedEncodingException, IOException {
        //查找附件类型
        AttType attType = AttHelper.findAttTypeVo(code);
        OutputStream out;
        BufferedInputStream in;
        ResultSet rs;
        PreparedStatement pstm;
        if(packageId != null && !"".equals(packageId)){
            List<Att> dataList = AttHelper.findAttListByPackageId(packageId,code);
            if(dataList != null && dataList.size() > 0){
                Att data = dataList.get(0);
                //如果是磁盘类型从磁盘下载
                if(AttType.SELECT_VALUE_FIRST == attType.getStoreType()){
                    File file = new File(data.getFileSystemPath(),data.getRandomName());
                    if(!file.exists()){
                        in = new BufferedInputStream(Article.class.getClassLoader().getResourceAsStream(Article.DEFAULT_ATT_ICON_NAME));
                    }else{
                        in = new BufferedInputStream(new FileInputStream(file));
                    }
                }else{
                    String sql = "SELECT ATT_CONTENT FROM " + attType.getEntityName() + " WHERE ID = '"+data.getId()+"'";
                    pstm = conn.prepareStatement(sql);
                    rs = pstm.executeQuery();
                    InputStream stream = null;
                    if (rs.next()) {
                        stream = rs.getBinaryStream(Att.ATT_CONTENT);
                    }
                    in = new BufferedInputStream(stream);
                }
                //重置
                response.reset();
                response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
                response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(data.getAttName(), getRequest().getCharacterEncoding()));
                out = response.getOutputStream();
                //读写
                byte[] b = new byte[1024];
                while(in.read(b) != -1){
                    out.write(b);
                    //重置
                    b = new byte[1024];
                }
                //关闭
                out.flush();
                in.close();
                out.close();
            }
        }else{
            //没有上传图片附件
            in = new BufferedInputStream(Article.class.getClassLoader().getResourceAsStream(Article.DEFAULT_ATT_ICON_NAME));
            //重置
            response.reset();
            response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
            response.setHeader("Content-Disposition", "attachment;filename=default_icon");
            out = response.getOutputStream();
            //读写
            byte[] b = new byte[1024];
            while(in.read(b) != -1){
                out.write(b);
                //重置
                b = new byte[1024];
            }
            //关闭
            out.flush();
            in.close();
            out.close();
        }
    }
}
