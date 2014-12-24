package com.hx.cms.channel;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.UUIDGenerator;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import com.hx.cms.article.FullTextRetrievalHandler;
import com.hx.cms.article.vo.Article;
import com.hx.cms.auth.vo.PersonChannelRela;
import com.hx.cms.auth.vo.RoleChannelRela;
import com.hx.cms.channel.vo.Channel;
import com.hx.cms.util.CmsAuthConstants;
import com.hx.cms.util.CmsConfigUtil;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.common.ClientIPGetter;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.sdk.AuditAppHelper;
import com.hx.framework.sdk.AuditConstants;
import com.hx.framework.sdk.ClickCountHelper;

/**
 * 
 * @Title: ChannelAction.java
 * @Description: 栏目<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-11-22 上午01:33:46
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelAction extends BaseAction {
    
    private static Log log = UtilLog.getLog(ChannelAction.class);

    private ChannelHandler handler;
    private ChannelTypeHandler channelTypeHandler;
    private FullTextRetrievalHandler fullTextRetrievalHandler;
    
    /**
     * 初始化
     */
    public ChannelAction() {
        handler = new ChannelHandler();
        channelTypeHandler = new ChannelTypeHandler();
        fullTextRetrievalHandler = new FullTextRetrievalHandler();
    }
    
    /**
     * 供前台jsh系统中channelDetail.jsp使用的频道列表方法
     * @return
     */
    public String channelDetailForTechSupport(){
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //分页结束
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //所有栏目供全文检索
        DataList channelList = new DataList(); //下拉select中的所有栏目
        try {
            conn = ConnectionManager.getConnection();
            Data parent = new Data();
            parent.setEntityName(Channel.CHANNEL_ENTITY);
            parent.setPrimaryKey(Channel.ID);
            parent.add(Channel.ID, parentId);
            parent = handler.findDataByKey(conn, parent);
            setAttribute("parent", parent);
            
            Data child = new Data();
            child.setEntityName(Channel.CHANNEL_ENTITY);
            child.setPrimaryKey(Channel.ID);
            child.add(Channel.ID, channelId);
            child = handler.findDataByKey(conn, child);
            setAttribute("currentChannel", child);
            
            //所有栏目
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        return "channelDetailForTechSupport";
    }
    
    /**
     * 供前台jsh系统外网二级页面channelDetailOutside.jsp使用的频道列表方法
     * @return
     */
    public String channelDetailOutside(){
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //分页结束
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        
        //所有栏目供全文检索
        DataList channelList = new DataList(); //下拉select中的所有栏目
        
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            Data parent = new Data();
            parent.setEntityName(Channel.CHANNEL_ENTITY);
            parent.setPrimaryKey(Channel.ID);
            parent.add(Channel.ID, parentId);
            Data _parent = handler.findDataByKey(conn, parent);
            if(_parent == null){
            	_parent = parent;
            }
            setAttribute("parent", _parent);
            
            Data child = new Data();
            child.setEntityName(Channel.CHANNEL_ENTITY);
            child.setPrimaryKey(Channel.ID);
            child.add(Channel.ID, channelId);
            Data _child = handler.findDataByKey(conn, child);
            if(_child == null){
            	_child = child;
            }
            setAttribute("currentChannel", _child);
            
            //所有栏目
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        return "channelDetailOutside";
    }
    
    /**
     * 前台扩展和中经网方法
     * @return
     */
    public String channelDetailOutsideExt(){
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //分页结束
        
        String sign = getParameter("sign");
        setAttribute("target", getParameter("target"));
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //所有栏目供全文检索
        DataList channelList = new DataList(); //下拉select中的所有栏目
        try {
            conn = ConnectionManager.getConnection();
            Data parent = new Data();
            parent.setEntityName(Channel.CHANNEL_ENTITY);
            parent.setPrimaryKey(Channel.ID);
            
            if(parentId != null){
                parent.add(Channel.ID, parentId);
                parent = handler.findDataByKey(conn, parent);
            }
            setAttribute("parent", parent);
            
            Data child = new Data();
            child.setEntityName(Channel.CHANNEL_ENTITY);
            child.setPrimaryKey(Channel.ID);
            if(channelId != null){
                child.add(Channel.ID, channelId);
                child = handler.findDataByKey(conn, child);
            }
            setAttribute("currentChannel", child);
            
            //所有栏目
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        if(sign != null && !"".equals(sign) && sign.contains("ext")){
            String[] signs = sign.split("_");
            if(signs!=null){
                ActionContext.getContext().getValueStack().set("sign", "_"+signs[1]);
            }else{
                ActionContext.getContext().getValueStack().set("sign", "");
            }
            return "channelDetailOutsideExt";
        }
        
        if("zjw".equals(sign)){
            return "channelDetailOutsideZJW";
        }
        
        return "channelDetailOutside";
    }
    
    /**
     * 前台扩展和中经网方法
     * @return
     */
    public String channelDetailInnersideExt(){
    	//分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //分页结束
        
        String sign = getParameter("sign");
        setAttribute("target", getParameter("target"));
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        
        //所有栏目供全文检索
        DataList channelList = new DataList(); //下拉select中的所有栏目
        //固定栏目和以及子栏目
        DataList commTplTypeList = new DataList();   //常用模板
        DataList tplTypeList = new DataList();       //我的模板
        DataList catalogs=new DataList(); //业务培训;
        try {
            conn = ConnectionManager.getConnection();
            Data parent = new Data();
            parent.setEntityName(Channel.CHANNEL_ENTITY);
            parent.setPrimaryKey(Channel.ID);
            parent.add(Channel.ID, parentId);
            parent = handler.findDataByKey(conn, parent);
            setAttribute("parent", parent);
            Data child = new Data();
            child.setEntityName(Channel.CHANNEL_ENTITY);
            child.setPrimaryKey(Channel.ID);
            child.add(Channel.ID, channelId);
            child = handler.findDataByKey(conn, child);
            setAttribute("currentChannel", child);
            //所有栏目
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
            
            //固定栏目及子栏目
            Data commTplType = new Data();
            commTplType.setEntityName("JSH_TECH_COMMON_MODULE_TYPE");
            commTplType.setPrimaryKey("ID");
            commTplType.add("PARENT_ID", "0");
            //常用模板第一级
            commTplTypeList = handler.findData(conn, commTplType);
            setAttribute("commTplTypeList", commTplTypeList);
            //（针对个人定制）模板类别第一级
            Data tplType = new Data();
            tplType.setEntityName("JSH_TECH_MODULE_TYPE");
            tplType.setPrimaryKey("ID");
            tplType.add("PARENT_ID", "0");
            tplType.add("USER_ID", personId);
            //我的模板第一级
            tplTypeList = handler.findData(conn, tplType);
            setAttribute("tplTypeList", tplTypeList);
            //业务培训
            //查处所有分类;
            catalogs=handler.findYWPX(conn); 
            setAttribute("catalogs", catalogs);
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        if(sign != null && !"".equals(sign) && sign.contains("ext")){
            String[] signs = sign.split("_");
            if(signs!=null){
                ActionContext.getContext().getValueStack().set("sign", "_"+signs[1]);
            }else{
                ActionContext.getContext().getValueStack().set("sign", "");
            }
            return "channelDetailInnersideExt";
        }
        return "channelDetailInnerside";
    }
    
    /**
     * 供前台jsh系统中channelDetail.jsp使用的频道列表方法
     * @return
     */
    public String channelDetail(){
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //分页结束
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //所有栏目供全文检索
        DataList channelList = new DataList(); //下拉select中的所有栏目
        try {
            conn = ConnectionManager.getConnection();
            Data parent = new Data();
            parent.setEntityName(Channel.CHANNEL_ENTITY);
            parent.setPrimaryKey(Channel.ID);
            parent.add(Channel.ID, parentId);
            parent = handler.findDataByKey(conn, parent);
            setAttribute("parent", parent);
            
            Data child = new Data();
            child.setEntityName(Channel.CHANNEL_ENTITY);
            child.setPrimaryKey(Channel.ID);
            child.add(Channel.ID, channelId);
            child = handler.findDataByKey(conn, child);
            setAttribute("currentChannel", child);
            
            //所有栏目
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        return "channelDetail";
    }
    
    /**
     * 供前台jsh外网系统中downloadListOutside.jsp下载频道使用的频道列表方法
     * @return
     */
    public String channelDownloadOutside(){
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //分页结束
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //所有栏目供全文检索
        DataList channelList = new DataList(); //下拉select中的所有栏目
        try {
            conn = ConnectionManager.getConnection();
            Data parent = new Data();
            parent.setEntityName(Channel.CHANNEL_ENTITY);
            parent.setPrimaryKey(Channel.ID);
            parent.add(Channel.ID, parentId);
            parent = handler.findDataByKey(conn, parent);
            setAttribute("parent", parent);
            
            Data child = new Data();
            child.setEntityName(Channel.CHANNEL_ENTITY);
            child.setPrimaryKey(Channel.ID);
            child.add(Channel.ID, channelId);
            child = handler.findDataByKey(conn, child);
            setAttribute("currentChannel", child);
            
            //所有栏目
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        return "channelDownloadOutside";
    }
    
    /**
     * 供前台jsh系统中downloadList.jsp下载频道使用的频道列表方法
     * @return
     */
    public String channelDownload(){
        //分页开始
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //分页结束
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //所有栏目供全文检索
        DataList channelList = new DataList(); //下拉select中的所有栏目
        try {
            conn = ConnectionManager.getConnection();
            Data parent = new Data();
            parent.setEntityName(Channel.CHANNEL_ENTITY);
            parent.setPrimaryKey(Channel.ID);
            parent.add(Channel.ID, parentId);
            parent = handler.findDataByKey(conn, parent);
            setAttribute("parent", parent);
            
            Data child = new Data();
            child.setEntityName(Channel.CHANNEL_ENTITY);
            child.setPrimaryKey(Channel.ID);
            child.add(Channel.ID, channelId);
            child = handler.findDataByKey(conn, child);
            setAttribute("currentChannel", child);
            
            //所有栏目
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        return "channelDownload";
    }
    
    /***********************************隔离线*********************************/

    /**
     * 分页显示
     * 
     * @return 跳转页面
     */
    public String query() {

        return null;
    }
    
    public String index(){
        return "index";
    }
    
    /**
     * 生成栏目树形结构:作废，因为栏目不排序
     * @return
     */
    /*public String generateTree(){

        Connection conn = null;
        //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
        CodeList dataList = new CodeList();
        TreeMap<String,Code> channelsMap = new TreeMap<String,Code>();
        try {
            conn = ConnectionManager.getConnection();
            //查询
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	for (Role role : roles) {
            		CodeList temChannels = handler.findChannelsOfRole(conn,role.getRoleId());
            		if(temChannels != null && temChannels.size() > 0){
            			for (int i = 0; i < temChannels.size(); i++) {
							Code code = temChannels.get(i);
							//过滤重复的栏目
							channelsMap.put(code.getValue(), code);
						}
            		}
            	}
            }
            
            //重新生成
            if(!channelsMap.isEmpty()){
            	Iterator<Code> codes = channelsMap.values().iterator();
            	while(codes.hasNext()){
            		dataList.add(codes.next());
            	}
            }
            
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        //传递组织树
        setAttribute("dataList", dataList);
        return getParameter("treeDispatcher");
    }*/
    
    /**
     * 生成栏目树形结构:加入权限验证,角色校验
     * @return
     */
    /*
    public String generateTree(){

        Connection conn = null;
        //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //查询
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	dataList = handler.findChannelsOfRole(conn,roles);
            }
            
            System.out.println(dataList.size());
        } catch (Exception e) {
            log.logError("生成栏目树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成栏目树时关闭Connection出错!", e);
            }
        }
        
        //传递组织树
        setAttribute("dataList", dataList);
        return getParameter("treeDispatcher");
    }*/
    
    /**
     * 文章发布管理使用的树形
     */
    public String generateTree(){
    	
    	Connection conn = null;
    	//角色：投稿人 1 审核人2
        String role = "1";
    	//使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//查询
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            dataList = handler.findChannelsOfPerson(conn, personId, role);
    		
    		
    		/*dataList = authHandler.generateTree(conn);*/
    	} catch (Exception e) {
    		log.logError("生成栏目树时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("生成栏目树时关闭Connection出错!", e);
    		}
    	}
    	
    	//传递组织树
    	setAttribute("dataList", dataList);
    	return getParameter("treeDispatcher");
    }
    
    /**
     * 生成栏目树形结构:加入权限验证,人员校验
     * @return
     */
    public String generateTreeForPerson(){
    	
    	Connection conn = null;
    	//角色：投稿人 1 审核人2
    	String role = getParameter(PersonChannelRela.ROLE);
    	//使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//查询
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
    		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
    		dataList = handler.findChannelsOfPerson(conn, personId, role);
    	} catch (Exception e) {
    		log.logError("生成栏目树时出错!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("生成栏目树时关闭Connection出错!", e);
    		}
    	}
    	
    	//传递组织树
    	setAttribute("dataList", dataList);
    	return getParameter("treeDispatcher");
    }
    
    /**
     * 栏目管理中的树形结构，跟文章管理的权限过滤功能相区分
     */
    public String generateTreeForChannel(){
	    Connection conn = null;
	    //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
	    CodeList dataList = new CodeList();
	    UserInfo user = SessionInfo.getCurUser();
	    try {
	        conn = ConnectionManager.getConnection();
	        
	        if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		dataList = handler.generateTreeFor1nMode(conn,orgLevelCode);
            	}
            }else{
            	dataList = handler.generateTree(conn);
            }
	    } catch (Exception e) {
	        log.logError("生成栏目树时出错!", e);
	    } finally {
	        try {
	            if (conn != null && !conn.isClosed()) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            log.logError("生成栏目树时关闭Connection出错!", e);
	        }
	    }
	    
	    //传递组织树
	    setAttribute("dataList", dataList);
	    return getParameter("treeDispatcher");
    }
    
    /**
     * 分页查询子级
     * @return
     */
    public String queryChildren(){
    	
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
        String parentId = getParameter(Channel.PARENT_ID);
        if(parentId == null || "".equals(parentId) || "null".equals(parentId)){
            parentId = (String) getAttribute(Channel.PARENT_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Channel.CHANNEL_ENTITY);
        data.setPrimaryKey(Channel.ID);
        data.add(Channel.PARENT_ID, parentId!=null&&!"".equals(parentId)?parentId:"0");
        
        Connection conn = null;
        DataList dataList = new DataList();
        UserInfo user = SessionInfo.getCurUser();
        try {
            conn = ConnectionManager.getConnection();
            
            if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		dataList = handler.findChannelChildrenFor1nMode(conn, data, orgLevelCode, pageSize, page, orderString);
            	}
            }else{
            	dataList = handler.findChannelChildren(conn, data, pageSize, page, orderString);
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
        setAttribute(Channel.PARENT_ID, parentId);
        //传参
        setAttribute("dataList", dataList);
        return SUCCESS;
    }
    
    /**
     * 转去添加栏目
     * @return
     */
    public String toAdd(){
        Data data = new Data();
        setAttribute("data", data);
        
        Connection conn = null;
        UserInfo user = SessionInfo.getCurUser();
        try {
            conn = ConnectionManager.getConnection();
            //栏目类型
            CodeList codeList = new CodeList();
            
            if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		codeList = channelTypeHandler.findChannelTypeToCodeListFor1nMode(conn,orgLevelCode);
            	}
            }else{
            	codeList = channelTypeHandler.findChannelTypeToCodeList(conn);
            }
            
            String codeId = "channelTypeList";
            codeList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, codeList);
            setAttribute(Constants.CODE_LIST, map);
            
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
        
        //组织机构ID
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        return "add";
    }
    
    /**
     * 转去修改栏目
     * @return
     */
    public String toModify(){
        
        Data data = new Data();
        String id = getParameter(Channel.ID);
        Connection conn = null;
        UserInfo user = SessionInfo.getCurUser();
        try {
            conn = ConnectionManager.getConnection();
            if(id != null && !"".equals(id.trim())){
                data.setEntityName(Channel.CHANNEL_ENTITY);
                data.setPrimaryKey(Channel.ID);
                data.add(Channel.ID, id);
                //查询
                data = handler.findDataByKey(conn, data);
            }
            
            CodeList codeList = new CodeList();
            if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		codeList = channelTypeHandler.findChannelTypeToCodeListFor1nMode(conn,orgLevelCode);
            	}
            }else{
            	codeList = channelTypeHandler.findChannelTypeToCodeList(conn);
            }
            
            String codeId = "channelTypeList";
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
        //组织机构ID
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        return "modify";
    }

    /**
     * 组织结构
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String add() {
        // 获取表单数据
        Data data = fillData(true);

        Connection conn = null;
        DBTransaction db = null;
        UserInfo user = SessionInfo.getCurUser();
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            String parentId = getParameter(Channel.PARENT_ID);
            if(parentId == null || "".equals(parentId) || "null".equals(parentId)){
                parentId = "0";
            }
            
            //设置父组织
            data.add(Channel.PARENT_ID, parentId);
            //生成ID
            data.add(Channel.ID, UUIDGenerator.getUUID());
            if("0".equals(parentId)){
                data.add("CHANNEL_PATH", data.getString("ID"));
            }else{
                Data data2 = new Data();
                data2.setEntityName(Channel.CHANNEL_ENTITY);
                data2.setPrimaryKey(Channel.ID);
                data2.add(Channel.ID, parentId);
                data2 = handler.findDataByKey(conn, data2);
                String CHANNEL_PATH = data2.getString("CHANNEL_PATH");
                data.add("CHANNEL_PATH", CHANNEL_PATH+","+data.getString("ID"));
            }
            
            //加入组织ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(Channel.CREATE_DEPT_ID, createDeptId);
            
            Data data1 = handler.add(conn, data);
            
            if(data1 != null){
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_ADD,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL,
                        data1.getString(Channel.NAME),
                        AuditConstants.ACT_RESULT_OK,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }else{
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_ADD,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL,
                        data1.getString(Channel.NAME),
                        AuditConstants.ACT_RESULT_FAIL,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }
            
            //CMS点击统计
            ClickCountHelper.addCatalog(data.getString(Channel.ID), data.getString(Channel.NAME), data.getString(Channel.PARENT_ID), data.getString(Channel.MEMO));
            
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
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        // 跳转
        return "query";
    }
    
    /**
     * 修改组织结构
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String modify() {

        // 获取表单数据
        Data data = fillData(false);

        Connection conn = null;
        DBTransaction db = null;
        try {
            // 保存
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            Data data1 = handler.modify(conn, data);
            
            if(data1 != null){
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_MODIFY,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL,
                        data1.getString(Channel.NAME),
                        AuditConstants.ACT_RESULT_OK,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }else{
                AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                        "",
                        AuditConstants.ACT_MODIFY,
                        CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL,
                        data1.getString(Channel.NAME),
                        AuditConstants.ACT_RESULT_FAIL,
                        AuditConstants.AUDIT_LEVEL_5,"");
            }
            
            //CMS点击统计
            ClickCountHelper.updateCatalog(data.getString(Channel.ID), data.getString(Channel.NAME), getParameter(Channel.PARENT_ID), data.getString(Channel.MEMO));
            
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
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");

        // 跳转
        return "query";
    }

    /**
     * 批量删除栏目,参数名用IDS
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String deleteBatch() {

        String idString = getParameter(Channel.IDS);
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
                    Data data = new Data();
                    data.setEntityName(Channel.CHANNEL_ENTITY);
                    data.setPrimaryKey(Channel.ID);
                    data.add(Channel.ID, ids[i]);
                    
                    data1 = handler.findDataByKey(conn, data);
                    if(data1 != null){
                        AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                                "",
                                AuditConstants.ACT_DELETE,
                                CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL,
                                data1.getString(Channel.NAME),
                                AuditConstants.ACT_RESULT_OK,
                                AuditConstants.AUDIT_LEVEL_5,"");
                    }else{
                        AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                                "",
                                AuditConstants.ACT_DELETE,
                                CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL,
                                data1.getString(Channel.NAME),
                                AuditConstants.ACT_RESULT_FAIL,
                                AuditConstants.AUDIT_LEVEL_5,"");
                    }
                    
                    //删除栏目角色关系
                    Data channelRole = new Data();
                    channelRole.setEntityName(RoleChannelRela.ROLE_CHANNEL_RELA_ENTITY);
                    channelRole.setPrimaryKey(RoleChannelRela.CHANNEL_ID);
                    channelRole.add(RoleChannelRela.CHANNEL_ID, ids[i]);
                    handler.delete(conn, channelRole);
                    
                    //删除栏目人员关系
                    Data channelPerson = new Data();
                    channelPerson.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
                    channelPerson.setPrimaryKey(PersonChannelRela.CHANNEL_ID);
                    channelPerson.add(PersonChannelRela.CHANNEL_ID, ids[i]);
                    handler.delete(conn, channelPerson);
                    
                    // 处理删除
                    String id = ids[i];
                    handler.deleteChannels(conn, id);
                }
                db.commit();
            }
        } catch (Exception e) {
            data1 = null;
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
                    "",
                    AuditConstants.ACT_DELETE,
                    CmsAuthConstants.ACT_OBJ_TYPE_CHANNEL,
                    data1.getString(Channel.NAME),
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
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        return "query";
    }
    
    /**
     * 验证是否有子级栏目
     * @return 
     */
    public String hasChildren(){
        
        String parentId = getParameter(Channel.PARENT_ID);
        
        Data data = new Data();
        data.setEntityName(Channel.CHANNEL_ENTITY);
        data.setPrimaryKey(Channel.ID);
        data.add(Channel.PARENT_ID, parentId!=null&&!"".equals(parentId)?parentId:"0");
        //默认有0个下级栏目
        int num = 0;
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            num = handler.statChildren(conn, parentId);
            
        } catch (Exception e) {
            log.logError("验证是否存在子级栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("验证是否存在子级栏目时关闭Connection出错!", e);
            }
        }
        //传参
        setAttribute("num", num);
        return SUCCESS;
    }
    
    /**
     * 上移或下移功能,改变排序号
     * @return
     */
    public String changeSeqnum(){
        
        Data data = new Data();
        String id = getParameter(Channel.ID);
        String parentId = getParameter(Channel.PARENT_ID);
        String target = getParameter("target");
        //组织机构ID
        setAttribute(Channel.PARENT_ID, parentId);
        Connection conn = null;
        DBTransaction db = null;
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            if(id != null && !"".equals(id.trim())){
                data.setEntityName(Channel.CHANNEL_ENTITY);
                data.setPrimaryKey(Channel.ID);
                data.add(Channel.ID, id);
                //查询
                data = handler.findDataByKey(conn, data);
                
                int seqNum = data.getInt(Channel.SEQ_NUM);
                
                //上移
                if("up".equals(target)){
                	Data upData = new Data();
                	upData.setEntityName(Channel.CHANNEL_ENTITY);
                	upData.setPrimaryKey(Channel.PARENT_ID,Channel.SEQ_NUM);
                	upData.add(Channel.PARENT_ID, parentId);
                	upData.add(Channel.SEQ_NUM, (seqNum - 1));
                	Data upData_ = handler.findDataByKey(conn, upData);
                	if(upData_ != null){
                		//开始移动
                		upData_.add(Channel.SEQ_NUM, (seqNum));
                		upData_.setEntityName(Channel.CHANNEL_ENTITY);
                		upData_.setPrimaryKey(Channel.ID);
                		data.add(Channel.SEQ_NUM, (seqNum - 1));
                		data.setEntityName(Channel.CHANNEL_ENTITY);
                		data.setPrimaryKey(Channel.ID);
                		handler.modify(conn, data);
                		handler.modify(conn, upData_);
                	}else{
                		return "query"; 
                	}
                }
                //下移
                if("down".equals(target)){
                	Data downData = new Data();
                	downData.setEntityName(Channel.CHANNEL_ENTITY);
                	downData.setPrimaryKey(Channel.PARENT_ID,Channel.SEQ_NUM);
                	downData.add(Channel.PARENT_ID, parentId);
                	downData.add(Channel.SEQ_NUM, (seqNum + 1));
                	Data downData_ = handler.findDataByKey(conn, downData);
                	if(downData_ != null){
                		//开始移动
                		downData_.add(Channel.SEQ_NUM, (seqNum));
                		downData_.setEntityName(Channel.CHANNEL_ENTITY);
                		downData_.setPrimaryKey(Channel.ID);
                		data.add(Channel.SEQ_NUM, (seqNum + 1));
                		data.setEntityName(Channel.CHANNEL_ENTITY);
                		data.setPrimaryKey(Channel.ID);
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
				log.logError("转去修改栏目时出错!", e1);
			}
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
        return "query";
    }
    
    /**
     * 获取栏目的parentId值
     * @return
     */
    public String ajaxParentValue(){

    	//弹出页面内容ID
    	String id = getParameter("ID");
        Connection conn = null;
        StringBuffer json = new StringBuffer();
        Data data = null;
        try {
            conn = ConnectionManager.getConnection();
            
            if(id != null && !"".equals(id)){
            	Data data2 = new Data();
            	data2.setEntityName(Channel.CHANNEL_ENTITY);
            	data2.setPrimaryKey(Channel.ID);
            	data2.add(Channel.ID, id);
                data = handler.findDataByKey(conn,data2);
            }
            
            if(data != null){
            	json.append(data.getString(Channel.PARENT_ID));
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
     * 获取栏目样式
     * @return
     */
    public String ajaxStyleValue(){
    	
    	//弹出页面内容ID
    	String id = getParameter("ID");
    	Connection conn = null;
    	StringBuffer json = new StringBuffer();
    	Data data = null;
    	try {
    		conn = ConnectionManager.getConnection();
    		
    		if(id != null && !"".equals(id)){
    			Data data2 = new Data();
    			data2.setEntityName(Channel.CHANNEL_ENTITY);
    			data2.setPrimaryKey(Channel.ID);
    			data2.add(Channel.ID, id);
    			data = handler.findDataByKey(conn,data2);
    		}
    		
    		if(data != null){
    			json.append("{\"channelStyle\":\"").append(data.getString(Channel.CHANNEL_STYLE)).append("\"")
    			.append(",\"parentId\":\"").append(data.getString(Channel.PARENT_ID)).append("\"")
    			.append(",\"name\":\"").append(data.getString(Channel.NAME)).append("\"")
    			.append("}");
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
	 * 弹出栏目树框架
	 * 
	 * @return
	 */
    public String changeChannelFrame(){
        setAttribute(Channel.IDS, getParameter(Channel.IDS));
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        return "changeChannelFrame";
    }
    
    /**
     * 树框架转发的请求，最后显示树页面
     * @return
     */
    public String toChangeChannel(){
    	String channelIds = getParameter(Channel.IDS);
    	String[] channelId_ = null;
    	if(channelIds != null && !"".equals(channelIds)){
    		channelId_ = channelIds.split("!");
    	}
    	Connection conn = null;
	    //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
	    CodeList dataList = new CodeList();
	    UserInfo user = SessionInfo.getCurUser();
	    try {
	        conn = ConnectionManager.getConnection();
	        
	        if(CmsConfigUtil.is1nMode()){
            	//获取本单位
            	Organ organ = user.getCurOrgan0();
            	String orgLevelCode = null;
            	if(organ != null){
            		orgLevelCode = organ.getOrgLevelCode();
            	}
            	if(orgLevelCode != null && !"".equals(orgLevelCode)){
            		dataList = handler.generateTreeFor1nMode(conn,orgLevelCode);
            	}
            }else{
            	dataList = handler.generateTree(conn);
            }
	        
	        //除去当前被移动的栏目
	        if(channelId_ != null){
	        	if(dataList != null && dataList.size() > 0){
	        		for (int i = 0; i < channelId_.length; i++) {
						String channelId = channelId_[i];
						for (int j = 0; j < dataList.size(); j++) {
							Code code = dataList.get(j);
							if(code.getValue().equals(channelId)){
								dataList.remove(j);
							}
						}
					}
		        }
	        }
	    } catch (Exception e) {
	        log.logError("生成栏目树时出错!", e);
	    } finally {
	        try {
	            if (conn != null && !conn.isClosed()) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            log.logError("生成栏目树时关闭Connection出错!", e);
	        }
	    }
	    //传递组织树
        setAttribute("dataList", dataList);
        setAttribute(Channel.IDS, channelIds);
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        
        return "changeChannel";
    }
    
    /**
     * 移动栏目
     * @return
     */
    public String changeChannel(){
        
    	//被移动的栏目
        String idString = getParameter(Channel.IDS);
        //原栏目
        String parentId = getParameter(Channel.PARENT_ID);
        //目标栏目
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
					String id = ids[i];
					Data data1 = new Data();
		            data1.setEntityName(Channel.CHANNEL_ENTITY);
		            data1.setPrimaryKey(Channel.ID);
		            data1.add(Channel.ID, id);
		            data1.add(Channel.PARENT_ID, channelId);
		            handler.modifyPath(conn, data1);
		            handler.modify(conn, data1);
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
        setAttribute(Channel.PARENT_ID, parentId);
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        return "query";
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
        data.setEntityName(Channel.CHANNEL_ENTITY);
        data.setPrimaryKey(Channel.ID);

        // 得到所有 组织结构类型 参数前缀的键值集合
        Map<String, String> map = getDataWithPrefix(Channel.CHANNEL_PREFIX, isTrue);
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
    
    public static void main(String[] args) {
    	StringBuffer json = new StringBuffer();
    	json.append("{\"channelStyle\":\"").append(123).append("\"")
		.append(",\"parentId\":\"").append(123).append("\"")
		.append(",\"name\":\"").append(123).append("\"")
		.append("}");
		System.out.println(json.toString());
	}
}
