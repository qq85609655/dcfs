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
 * @Description: ��Ŀ<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-11-22 ����01:33:46
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
     * ��ʼ��
     */
    public ChannelAction() {
        handler = new ChannelHandler();
        channelTypeHandler = new ChannelTypeHandler();
        fullTextRetrievalHandler = new FullTextRetrievalHandler();
    }
    
    /**
     * ��ǰ̨jshϵͳ��channelDetail.jspʹ�õ�Ƶ���б���
     * @return
     */
    public String channelDetailForTechSupport(){
        //��ҳ��ʼ
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //��ҳ����
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //������Ŀ��ȫ�ļ���
        DataList channelList = new DataList(); //����select�е�������Ŀ
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
            
            //������Ŀ
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
            }
        }
        
        return "channelDetailForTechSupport";
    }
    
    /**
     * ��ǰ̨jshϵͳ��������ҳ��channelDetailOutside.jspʹ�õ�Ƶ���б���
     * @return
     */
    public String channelDetailOutside(){
        //��ҳ��ʼ
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //��ҳ����
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        
        //������Ŀ��ȫ�ļ���
        DataList channelList = new DataList(); //����select�е�������Ŀ
        
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
            
            //������Ŀ
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
            }
        }
        
        return "channelDetailOutside";
    }
    
    /**
     * ǰ̨��չ���о�������
     * @return
     */
    public String channelDetailOutsideExt(){
        //��ҳ��ʼ
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //��ҳ����
        
        String sign = getParameter("sign");
        setAttribute("target", getParameter("target"));
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //������Ŀ��ȫ�ļ���
        DataList channelList = new DataList(); //����select�е�������Ŀ
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
            
            //������Ŀ
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
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
     * ǰ̨��չ���о�������
     * @return
     */
    public String channelDetailInnersideExt(){
    	//��ҳ��ʼ
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //��ҳ����
        
        String sign = getParameter("sign");
        setAttribute("target", getParameter("target"));
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        
        //������Ŀ��ȫ�ļ���
        DataList channelList = new DataList(); //����select�е�������Ŀ
        //�̶���Ŀ���Լ�����Ŀ
        DataList commTplTypeList = new DataList();   //����ģ��
        DataList tplTypeList = new DataList();       //�ҵ�ģ��
        DataList catalogs=new DataList(); //ҵ����ѵ;
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
            //������Ŀ
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
            
            //�̶���Ŀ������Ŀ
            Data commTplType = new Data();
            commTplType.setEntityName("JSH_TECH_COMMON_MODULE_TYPE");
            commTplType.setPrimaryKey("ID");
            commTplType.add("PARENT_ID", "0");
            //����ģ���һ��
            commTplTypeList = handler.findData(conn, commTplType);
            setAttribute("commTplTypeList", commTplTypeList);
            //����Ը��˶��ƣ�ģ������һ��
            Data tplType = new Data();
            tplType.setEntityName("JSH_TECH_MODULE_TYPE");
            tplType.setPrimaryKey("ID");
            tplType.add("PARENT_ID", "0");
            tplType.add("USER_ID", personId);
            //�ҵ�ģ���һ��
            tplTypeList = handler.findData(conn, tplType);
            setAttribute("tplTypeList", tplTypeList);
            //ҵ����ѵ
            //�鴦���з���;
            catalogs=handler.findYWPX(conn); 
            setAttribute("catalogs", catalogs);
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
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
     * ��ǰ̨jshϵͳ��channelDetail.jspʹ�õ�Ƶ���б���
     * @return
     */
    public String channelDetail(){
        //��ҳ��ʼ
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //��ҳ����
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //������Ŀ��ȫ�ļ���
        DataList channelList = new DataList(); //����select�е�������Ŀ
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
            
            //������Ŀ
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
            }
        }
        
        return "channelDetail";
    }
    
    /**
     * ��ǰ̨jsh����ϵͳ��downloadListOutside.jsp����Ƶ��ʹ�õ�Ƶ���б���
     * @return
     */
    public String channelDownloadOutside(){
        //��ҳ��ʼ
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //��ҳ����
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //������Ŀ��ȫ�ļ���
        DataList channelList = new DataList(); //����select�е�������Ŀ
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
            
            //������Ŀ
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
            }
        }
        
        return "channelDownloadOutside";
    }
    
    /**
     * ��ǰ̨jshϵͳ��downloadList.jsp����Ƶ��ʹ�õ�Ƶ���б���
     * @return
     */
    public String channelDownload(){
        //��ҳ��ʼ
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        //��ҳ����
        
        String parentId = getParameter(Channel.PARENT_ID);
        String channelId = getParameter(Channel.ID);
        Connection conn = null;
        
        //������Ŀ��ȫ�ļ���
        DataList channelList = new DataList(); //����select�е�������Ŀ
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
            
            //������Ŀ
            channelList = fullTextRetrievalHandler.findChannelsBySQL(conn);
            setAttribute("channelList", channelList);
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
            }
        }
        
        return "channelDownload";
    }
    
    /***********************************������*********************************/

    /**
     * ��ҳ��ʾ
     * 
     * @return ��תҳ��
     */
    public String query() {

        return null;
    }
    
    public String index(){
        return "index";
    }
    
    /**
     * ������Ŀ���νṹ:���ϣ���Ϊ��Ŀ������
     * @return
     */
    /*public String generateTree(){

        Connection conn = null;
        //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
        CodeList dataList = new CodeList();
        TreeMap<String,Code> channelsMap = new TreeMap<String,Code>();
        try {
            conn = ConnectionManager.getConnection();
            //��ѯ
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	for (Role role : roles) {
            		CodeList temChannels = handler.findChannelsOfRole(conn,role.getRoleId());
            		if(temChannels != null && temChannels.size() > 0){
            			for (int i = 0; i < temChannels.size(); i++) {
							Code code = temChannels.get(i);
							//�����ظ�����Ŀ
							channelsMap.put(code.getValue(), code);
						}
            		}
            	}
            }
            
            //��������
            if(!channelsMap.isEmpty()){
            	Iterator<Code> codes = channelsMap.values().iterator();
            	while(codes.hasNext()){
            		dataList.add(codes.next());
            	}
            }
            
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
            }
        }
        
        //������֯��
        setAttribute("dataList", dataList);
        return getParameter("treeDispatcher");
    }*/
    
    /**
     * ������Ŀ���νṹ:����Ȩ����֤,��ɫУ��
     * @return
     */
    /*
    public String generateTree(){

        Connection conn = null;
        //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //��ѯ
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	dataList = handler.findChannelsOfRole(conn,roles);
            }
            
            System.out.println(dataList.size());
        } catch (Exception e) {
            log.logError("������Ŀ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ŀ��ʱ�ر�Connection����!", e);
            }
        }
        
        //������֯��
        setAttribute("dataList", dataList);
        return getParameter("treeDispatcher");
    }*/
    
    /**
     * ���·�������ʹ�õ�����
     */
    public String generateTree(){
    	
    	Connection conn = null;
    	//��ɫ��Ͷ���� 1 �����2
        String role = "1";
    	//ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//��ѯ
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            dataList = handler.findChannelsOfPerson(conn, personId, role);
    		
    		
    		/*dataList = authHandler.generateTree(conn);*/
    	} catch (Exception e) {
    		log.logError("������Ŀ��ʱ����!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("������Ŀ��ʱ�ر�Connection����!", e);
    		}
    	}
    	
    	//������֯��
    	setAttribute("dataList", dataList);
    	return getParameter("treeDispatcher");
    }
    
    /**
     * ������Ŀ���νṹ:����Ȩ����֤,��ԱУ��
     * @return
     */
    public String generateTreeForPerson(){
    	
    	Connection conn = null;
    	//��ɫ��Ͷ���� 1 �����2
    	String role = getParameter(PersonChannelRela.ROLE);
    	//ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//��ѯ
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
    		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
    		dataList = handler.findChannelsOfPerson(conn, personId, role);
    	} catch (Exception e) {
    		log.logError("������Ŀ��ʱ����!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("������Ŀ��ʱ�ر�Connection����!", e);
    		}
    	}
    	
    	//������֯��
    	setAttribute("dataList", dataList);
    	return getParameter("treeDispatcher");
    }
    
    /**
     * ��Ŀ�����е����νṹ�������¹����Ȩ�޹��˹���������
     */
    public String generateTreeForChannel(){
	    Connection conn = null;
	    //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
	    CodeList dataList = new CodeList();
	    UserInfo user = SessionInfo.getCurUser();
	    try {
	        conn = ConnectionManager.getConnection();
	        
	        if(CmsConfigUtil.is1nMode()){
            	//��ȡ����λ
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
	        log.logError("������Ŀ��ʱ����!", e);
	    } finally {
	        try {
	            if (conn != null && !conn.isClosed()) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            log.logError("������Ŀ��ʱ�ر�Connection����!", e);
	        }
	    }
	    
	    //������֯��
	    setAttribute("dataList", dataList);
	    return getParameter("treeDispatcher");
    }
    
    /**
     * ��ҳ��ѯ�Ӽ�
     * @return
     */
    public String queryChildren(){
    	
    	/************��ȡ���ݿ������ʾ--��ʼ***************/
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
		/************��ȡ���ݿ������ʾ--����***************/
        
        //��ҳ��ʾ
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        //�õ���ǰ�������֯������idֵ����Ϊ���ӻ����ĸ�ID���в�ѯ���õ����е�ǰ�������¼�
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
            	//��ȡ����λ
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
            log.logError("��ѯ�Ӽ���Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ�Ӽ���Ŀʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute(Channel.PARENT_ID, parentId);
        //����
        setAttribute("dataList", dataList);
        return SUCCESS;
    }
    
    /**
     * תȥ�����Ŀ
     * @return
     */
    public String toAdd(){
        Data data = new Data();
        setAttribute("data", data);
        
        Connection conn = null;
        UserInfo user = SessionInfo.getCurUser();
        try {
            conn = ConnectionManager.getConnection();
            //��Ŀ����
            CodeList codeList = new CodeList();
            
            if(CmsConfigUtil.is1nMode()){
            	//��ȡ����λ
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
            log.logError("תȥ�����Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�����Ŀʱ�ر�Connection����!", e);
            }
        }
        
        //��֯����ID
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        return "add";
    }
    
    /**
     * תȥ�޸���Ŀ
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
                //��ѯ
                data = handler.findDataByKey(conn, data);
            }
            
            CodeList codeList = new CodeList();
            if(CmsConfigUtil.is1nMode()){
            	//��ȡ����λ
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
            log.logError("תȥ�޸���Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���Ŀʱ�ر�Connection����!", e);
            }
        }
        
        setAttribute("data", data);
        //��֯����ID
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        return "modify";
    }

    /**
     * ��֯�ṹ
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String add() {
        // ��ȡ������
        Data data = fillData(true);

        Connection conn = null;
        DBTransaction db = null;
        UserInfo user = SessionInfo.getCurUser();
        try {
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            String parentId = getParameter(Channel.PARENT_ID);
            if(parentId == null || "".equals(parentId) || "null".equals(parentId)){
                parentId = "0";
            }
            
            //���ø���֯
            data.add(Channel.PARENT_ID, parentId);
            //����ID
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
            
            //������֯ID
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
            
            //CMS���ͳ��
            ClickCountHelper.addCatalog(data.getString(Channel.ID), data.getString(Channel.NAME), data.getString(Channel.PARENT_ID), data.getString(Channel.MEMO));
            
            // �ύ
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("�����Ŀʱ����!", e);
            }
            log.logError("�����Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("�����Ŀʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        // ��ת
        return "query";
    }
    
    /**
     * �޸���֯�ṹ
     * 
     * @return
     */
    @SuppressWarnings("null")
	public String modify() {

        // ��ȡ������
        Data data = fillData(false);

        Connection conn = null;
        DBTransaction db = null;
        try {
            // ����
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
            
            //CMS���ͳ��
            ClickCountHelper.updateCatalog(data.getString(Channel.ID), data.getString(Channel.NAME), getParameter(Channel.PARENT_ID), data.getString(Channel.MEMO));
            
            // �ύ
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("�޸���Ŀʱ����!", e);
            }
            log.logError("�޸���Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("�޸���Ŀʱ����!", e);
            }
        }
        //��֯����ID
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");

        // ��ת
        return "query";
    }

    /**
     * ����ɾ����Ŀ,��������IDS
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
            // ��������ɾ�����󼯺�
            conn = ConnectionManager.getConnection();
            // ����ɾ��
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
                    
                    //ɾ����Ŀ��ɫ��ϵ
                    Data channelRole = new Data();
                    channelRole.setEntityName(RoleChannelRela.ROLE_CHANNEL_RELA_ENTITY);
                    channelRole.setPrimaryKey(RoleChannelRela.CHANNEL_ID);
                    channelRole.add(RoleChannelRela.CHANNEL_ID, ids[i]);
                    handler.delete(conn, channelRole);
                    
                    //ɾ����Ŀ��Ա��ϵ
                    Data channelPerson = new Data();
                    channelPerson.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
                    channelPerson.setPrimaryKey(PersonChannelRela.CHANNEL_ID);
                    channelPerson.add(PersonChannelRela.CHANNEL_ID, ids[i]);
                    handler.delete(conn, channelPerson);
                    
                    // ����ɾ��
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
                log.logError("����ɾ����Ŀʱ����!", e);
            }
            log.logError("����ɾ����Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("ɾ����Ŀʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        return "query";
    }
    
    /**
     * ��֤�Ƿ����Ӽ���Ŀ
     * @return 
     */
    public String hasChildren(){
        
        String parentId = getParameter(Channel.PARENT_ID);
        
        Data data = new Data();
        data.setEntityName(Channel.CHANNEL_ENTITY);
        data.setPrimaryKey(Channel.ID);
        data.add(Channel.PARENT_ID, parentId!=null&&!"".equals(parentId)?parentId:"0");
        //Ĭ����0���¼���Ŀ
        int num = 0;
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            num = handler.statChildren(conn, parentId);
            
        } catch (Exception e) {
            log.logError("��֤�Ƿ�����Ӽ���Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��֤�Ƿ�����Ӽ���Ŀʱ�ر�Connection����!", e);
            }
        }
        //����
        setAttribute("num", num);
        return SUCCESS;
    }
    
    /**
     * ���ƻ����ƹ���,�ı������
     * @return
     */
    public String changeSeqnum(){
        
        Data data = new Data();
        String id = getParameter(Channel.ID);
        String parentId = getParameter(Channel.PARENT_ID);
        String target = getParameter("target");
        //��֯����ID
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
                //��ѯ
                data = handler.findDataByKey(conn, data);
                
                int seqNum = data.getInt(Channel.SEQ_NUM);
                
                //����
                if("up".equals(target)){
                	Data upData = new Data();
                	upData.setEntityName(Channel.CHANNEL_ENTITY);
                	upData.setPrimaryKey(Channel.PARENT_ID,Channel.SEQ_NUM);
                	upData.add(Channel.PARENT_ID, parentId);
                	upData.add(Channel.SEQ_NUM, (seqNum - 1));
                	Data upData_ = handler.findDataByKey(conn, upData);
                	if(upData_ != null){
                		//��ʼ�ƶ�
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
                //����
                if("down".equals(target)){
                	Data downData = new Data();
                	downData.setEntityName(Channel.CHANNEL_ENTITY);
                	downData.setPrimaryKey(Channel.PARENT_ID,Channel.SEQ_NUM);
                	downData.add(Channel.PARENT_ID, parentId);
                	downData.add(Channel.SEQ_NUM, (seqNum + 1));
                	Data downData_ = handler.findDataByKey(conn, downData);
                	if(downData_ != null){
                		//��ʼ�ƶ�
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
				log.logError("תȥ�޸���Ŀʱ����!", e1);
			}
            log.logError("תȥ�޸���Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���Ŀʱ�ر�Connection����!", e);
            }
        }
        return "query";
    }
    
    /**
     * ��ȡ��Ŀ��parentIdֵ
     * @return
     */
    public String ajaxParentValue(){

    	//����ҳ������ID
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
            log.logError("תȥ�޸��ڲ�����ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸��ڲ�����ʱ�ر�Connection����!", e);
            }
        }
        return null;
    }
    
    /**
     * ��ȡ��Ŀ��ʽ
     * @return
     */
    public String ajaxStyleValue(){
    	
    	//����ҳ������ID
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
    		log.logError("תȥ�޸��ڲ�����ʱ����!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("תȥ�޸��ڲ�����ʱ�ر�Connection����!", e);
    		}
    	}
    	return null;
    }
    
    /**
	 * ������Ŀ�����
	 * 
	 * @return
	 */
    public String changeChannelFrame(){
        setAttribute(Channel.IDS, getParameter(Channel.IDS));
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        return "changeChannelFrame";
    }
    
    /**
     * �����ת�������������ʾ��ҳ��
     * @return
     */
    public String toChangeChannel(){
    	String channelIds = getParameter(Channel.IDS);
    	String[] channelId_ = null;
    	if(channelIds != null && !"".equals(channelIds)){
    		channelId_ = channelIds.split("!");
    	}
    	Connection conn = null;
	    //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
	    CodeList dataList = new CodeList();
	    UserInfo user = SessionInfo.getCurUser();
	    try {
	        conn = ConnectionManager.getConnection();
	        
	        if(CmsConfigUtil.is1nMode()){
            	//��ȡ����λ
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
	        
	        //��ȥ��ǰ���ƶ�����Ŀ
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
	        log.logError("������Ŀ��ʱ����!", e);
	    } finally {
	        try {
	            if (conn != null && !conn.isClosed()) {
	                conn.close();
	            }
	        } catch (SQLException e) {
	            log.logError("������Ŀ��ʱ�ر�Connection����!", e);
	        }
	    }
	    //������֯��
        setAttribute("dataList", dataList);
        setAttribute(Channel.IDS, channelIds);
        setAttribute(Channel.PARENT_ID, getParameter(Channel.PARENT_ID));
        
        return "changeChannel";
    }
    
    /**
     * �ƶ���Ŀ
     * @return
     */
    public String changeChannel(){
        
    	//���ƶ�����Ŀ
        String idString = getParameter(Channel.IDS);
        //ԭ��Ŀ
        String parentId = getParameter(Channel.PARENT_ID);
        //Ŀ����Ŀ
        String channelId = getParameter(Article.CHANNEL_ID);
        String[] ids = null;
        if (idString != null && !"".equals(idString.trim())) {
            ids = idString.split("!");
        }

        Connection conn = null;
        DBTransaction db = null;
        try {
            // ����
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
            // �ύ
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("������Ա��֯ʱ����!", e);
            }
            log.logError("������Ա��֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������Ա��֯ʱ����!", e);
            }
        }
        //����ǰƵ��
        setAttribute(Channel.PARENT_ID, parentId);
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        return "query";
    }

    /**
     * δʵ��
     */
    public String execute() throws Exception {
        return "default";
    }

    /*---------------------��private�ڲ�����-----------------------*/

    /**
     * �������ݵ�Data����
     * 
     * @return
     */
    private Data fillData(boolean isTrue) {
        // ��ȡ����
        Data data = new Data();
        data.setEntityName(Channel.CHANNEL_ENTITY);
        data.setPrimaryKey(Channel.ID);

        // �õ����� ��֯�ṹ���� ����ǰ׺�ļ�ֵ����
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
