package com.hx.cms.auth;

import hx.code.Code;
import hx.code.CodeList;
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
import java.util.Map;

import com.hx.cms.auth.vo.PersonChannelRela;
import com.hx.cms.auth.vo.RoleChannelRela;
import com.hx.cms.channel.vo.Channel;
import com.hx.cms.util.CmsConfigUtil;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.authorize.AuthorizeHandler;
import com.hx.framework.authorize.vo.PersonRole;
import com.hx.framework.common.ClientIPGetter;
import com.hx.framework.organ.OrganHandler;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.organ.vo.OrganPerson;
import com.hx.framework.person.vo.Person;
import com.hx.framework.role.RoleGroupHandler;
import com.hx.framework.role.vo.Role;
import com.hx.framework.role.vo.RoleGroup;
import com.hx.framework.sdk.AuditAppHelper;
import com.hx.framework.sdk.AuditConstants;
import com.hx.framework.sdk.OrganHelper;

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
public class AuthAction extends BaseAction {
    
    private static Log log = UtilLog.getLog(AuthAction.class);
    private AuthHandler handler;
    private OrganHandler organHandler;
    private RoleGroupHandler roleGroupHandler;
//    private PersonHandler personHandler;
    private AuthorizeHandler authorizeHandler;

    /**
     * 初始化
     */
    public AuthAction() {
    	handler = new AuthHandler();
    	roleGroupHandler = new RoleGroupHandler();
    	organHandler = new OrganHandler();
//    	personHandler = new PersonHandler();
    	authorizeHandler = new AuthorizeHandler();
    }
    
    /**
     * 转去分配栏目
     * @return
     */
    public String toAlotChannels() {

        Connection conn = null;
        CodeList dataList = new CodeList();
        // 角色编号
        String roleId = getParameter(RoleChannelRela.ROLE_ID);
        if(roleId != null){
            roleId = roleId.split("!")[0];
        }
        String res = null;
        try {
            conn = ConnectionManager.getConnection();
            // 查询
            dataList = handler.generateTree(conn);
            // 得到所有的已经分配的资源和模块
            res = handler.findSavedResourceOfRole(conn, roleId);
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

        // 传递组织树
        setAttribute("ownResource", res);
        setAttribute("dataList", dataList);
        setAttribute(Role.ROLE_ID, roleId);
        setAttribute(RoleGroup.PARENT_ID, getParameter(RoleGroup.PARENT_ID));

        return "allotResource";
    }
    
    /**
     * 组织机构下人员列表
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public String personList() {
        
    	//获取查询条件
    	Map<String,String> smap=this.getDataWithPrefix("S_", true);
    	Data sdata = new Data((Map)smap);
    	//查询条件
    	String orgId = sdata.getString("ORGAN_ID_"); //检查查询条件是否存在
    	if("0".equals(orgId)){
    	    orgId = null;
    	    sdata.remove("ORGAN_ID_");
    	    sdata.remove("ORGAN_NAME_");
    	}
    	//原组织
    	String oldOrgId = getParameter(OrganPerson.ORG_ID);
    	if(oldOrgId == null || "".equals(oldOrgId) || "null".equals(oldOrgId)){
    		oldOrgId = (String) getAttribute(OrganPerson.ORG_ID);
        }
    	
        // 分页大小和当前页
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1; //等于1才会显示分页
        }

        Connection conn = null;
        DataList dataList = new DataList();
        UserInfo user = SessionInfo.getCurUser();
        try {
        	//组织机构名称
        	String oldOrganName = "";
        	if(oldOrgId != null){
        		oldOrganName = OrganHelper.getOrganCNameById(oldOrgId); 
        	}
            conn = ConnectionManager.getConnection();
            
            //检索条件
            if(smap.isEmpty()){
        		//如果当前选中的组织机构为顶级，那么就不加入到查询，省去出现0的情况
        		if(!"0".equals(oldOrgId)){
        			//无查询
            		sdata.add("ORGAN_ID_", oldOrgId);
            		/*Data data = new Data();
                    data.setEntityName(Organ.ORGAN_ENTITY);
                    data.setPrimaryKey(Organ.ID);
                    data.add(Organ.ID, oldOrgId);
                    data = handler.findDataByKey(conn, data);*/
                    if(oldOrganName != null){
                    	sdata.add("ORGAN_NAME_", oldOrganName);
                    }
        		}
        	}
        	setAttribute("data", sdata);
            
            // 使用SQL进行查询
        	//dataList = personHandler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
        	if(CmsConfigUtil.isMultistageAdminMode()){
    			//如果分级
    			if("0".equals(user.getAdminType())){
    				//超级管理员，可以设置超级管理员和系统管理员
    				//改成ORG_ID IN('',...,'')这种方式
    				String organIdString = sdata.getString("ORGAN_ID_");
    				if(organIdString != null && !"".equals(organIdString)){
    					sdata.add("ORGAN_ID_", "'"+organIdString+"'");
    				}
    				dataList = handler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
    				sdata.add("ORGAN_ID_", oldOrgId);
    			}
    			if("1".equals(user.getAdminType())){
    				//可管理的角色
    				//改成ORG_ID IN('',...,'')这种方式
    				if(oldOrgId == null || "".equals(oldOrgId) || "0".equals(oldOrgId)){
    					DataList organList = organHandler.findManagedOrgan(conn, user.getPersonId());
    					if(organList != null && organList.size() > 0){
    						StringBuffer organString = new StringBuffer();
    						Data organ = organList.getData(0);
    						String parentId = organ.getString(Organ.ORG_LEVEL_CODE);
    						String id = organ.getString(Organ.ID);
    						organString.append("'").append(id).append("'");
    						DataList subOrgans = organHandler.generateTreeForLevelList(conn, parentId);
    						if(subOrgans != null && subOrgans.size() > 0){
    							for (int i = 0; i < subOrgans.size(); i++) {
									Data sub = subOrgans.getData(i);
									organString.append(",'").append(sub.getString("VALUE")).append("'");
								}
    						}
    						sdata.add("ORGAN_ID_", organString.toString());
    						dataList = handler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
        					sdata.add("ORGAN_ID_", oldOrgId);
    					}
    				}else{
    					//改成ORG_ID IN('',...,'')这种方式
    					String organIdString = sdata.getString("ORGAN_ID_");
        				if(organIdString != null && !"".equals(organIdString)){
        					sdata.add("ORGAN_ID_", "'"+organIdString+"'");
        				}
        				dataList = handler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
    					sdata.add("ORGAN_ID_", oldOrgId);
    				}
    			}
    		}
    		if(CmsConfigUtil.isThreeAdminMode()){
    			//不分级
    			//改成ORG_ID IN('',...,'')这种方式
    			String organIdString = sdata.getString("ORGAN_ID_");
				if(organIdString != null && !"".equals(organIdString)){
					sdata.add("ORGAN_ID_", "'"+organIdString+"'");
				}
				dataList = handler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
    			sdata.add("ORGAN_ID_", oldOrgId);
    		}
            
            //所有用户的权限列表
            DataList rolesList = authorizeHandler.findRoleOfPer(conn, null);
            //加入角色
            if(dataList != null && dataList.size() > 0){
            	for (int i = 0; i < dataList.size(); i++) {
            		//角色列表
            		StringBuffer buffer = new StringBuffer();
            		String bufferStr = "";
					Data data = dataList.getData(i);
					String personId = data.getString(Person.PERSON_ID);
					
					if(rolesList != null && rolesList.size() > 0){
						for (int k = 0; k < rolesList.size(); k++) {
							Data role = rolesList.getData(k);
							if(personId.equals(role.getString(PersonRole.PERSON_ID))){
								buffer.append(role.getString(Role.CNAME)).append(",");
							}
						}
						bufferStr = buffer.toString();
						if(bufferStr != null && !"".equals(bufferStr) && bufferStr.lastIndexOf(",") == (bufferStr.length() - 1)){
							bufferStr = bufferStr.substring(0,bufferStr.length() - 1);
						}
					}
					data.add("ROLE_CNAME", bufferStr);
				}
            }
        } catch (Exception e) {
            log.logError("查询组织下人员时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询组织下人员时关闭Connection出错!", e);
            }
        }
        //所属组织机构
        setAttribute(OrganPerson.ORG_ID, orgId);
        // 存储
        setAttribute("dataList", dataList);
        return "personList";
    }
    
    /**
     * 显示栏目多选树:过滤外部链接栏目
     * @return
     */
    public String toAlotChannelsNoConditions() {
    	
    	Connection conn = null;
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		// 查询
    		dataList = handler.generateTree(conn);
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
    	
    	// 传递组织树
    	setAttribute("dataList", dataList);
    	return getParameter("treeDispatcher");
    }
    
    /**
     * 生成组织机构树形结构
     * @return
     */
    public String generateOrganTree(){

        Connection conn = null;
        //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
        CodeList dataList = new CodeList();
        UserInfo user = SessionInfo.getCurUser();
        
        try {
            conn = ConnectionManager.getConnection();
            
            
            if(CmsConfigUtil.isMultistageAdminMode()){
            	//如果分级
            	if("0".equals(user.getAdminType())){
            		//查询
            		dataList = organHandler.generateTree(conn);
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
        		dataList = organHandler.generateTree(conn);
            }
            
            
        } catch (Exception e) {
            log.logError("生成组织树时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成组织树时关闭Connection出错!", e);
            }
        }
        
        //设置CodeList的codeNames属性-------<bz:codeTree>要用这个属性
        //dataList.setCodeSortId("organTree");
        
        //传递组织树
        setAttribute("dataList", dataList);
        return getParameter("treeDispatcher");
    }
    
    /**
     * 给角色分配栏目
     * @return 
     */
    public String alotChannels(){
    	
    	//所有选中的角色
        String roleIdString = getParameter(RoleChannelRela.ROLE_ID);
        String[] roleIds = null;
        if(roleIdString != null && !"".equals(roleIdString)){
            roleIds = roleIdString.split("#");
        }
        
        //所有选中的栏目
        String channelIdString = getParameter("CHANNEL_IDS");
        String[] channelIds = null;
        if(channelIdString != null && !"".equals(channelIdString)){
        	channelIds = channelIdString.split("#");
        }
        
        Connection conn = null;
        DBTransaction db = null;
        try {
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            if(roleIds != null){
                for (int i = 0; i < roleIds.length; i++) {
                    String roleId = roleIds[i];
                    
                    //非角色组的角色才有效，角色组数据少校验起来会快一点
                    if(!roleGroupHandler.isRoleGroup(conn, roleId)){
                    	
                    	//先清空当前角色栏目的关系数据
                    	Data delData = new Data();
                    	delData.setEntityName(RoleChannelRela.ROLE_CHANNEL_RELA_ENTITY);
                    	delData.setPrimaryKey(RoleChannelRela.ROLE_ID);
                    	delData.add(RoleChannelRela.ROLE_ID, roleId);
                    	handler.delete(conn, delData);
                    	
                    	if(channelIds != null){
                            for (int j = 0; j < channelIds.length; j++) {
                                String channelId = channelIds[j];
                                
                                Data channel = new Data();
                                channel.setEntityName(Channel.CHANNEL_ENTITY);
                                channel.setPrimaryKey(Channel.ID);
                                channel.add(Channel.ID, channelId);
                                channel = handler.findDataByKey(conn, channel);
                                
                                //进行分配
                                Data data = new Data();
                                data.setEntityName(RoleChannelRela.ROLE_CHANNEL_RELA_ENTITY);
                                data.setPrimaryKey(RoleChannelRela.ID);
                                data.add(RoleChannelRela.ID, UUIDGenerator.getUUID());
                                data.add(RoleChannelRela.ROLE_ID, roleId);
                                data.add(RoleChannelRela.CHANNEL_ID, channelId);
                                data.add(RoleChannelRela.SEQ_NUM, channel!=null?channel.getInt(Channel.SEQ_NUM):Integer.MAX_VALUE);
                                handler.add(conn, data);
                            }
                        }
                    }
                }
            }
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("给角色分配栏目时出错!", e);
            }
            log.logError("给角色分配栏目时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("给角色分配栏目时关闭Connection出错!", e);
            }
        }
        setAttribute(RoleGroup.PARENT_ID, getParameter(RoleGroup.PARENT_ID));
        
        return "query";
    }
    
    /**
     * 投稿人授权
     * @return
     */
    public String writerChannels() {

		//所有选中的栏目
		String channelsIdsString = getParameter("CHANNEL_IDS");
		String[] channelsIds = null;
		if (channelsIdsString != null && !"".equals(channelsIdsString)) {
			channelsIds = channelsIdsString.split("#");
		}

		//所有选中的人员
		String personIdString = getParameter("PERSONS_IDS");
		String[] personIds = null;
		if (personIdString != null && !"".equals(personIdString)) {
			personIds = personIdString.split("#");
		}

		Connection conn = null;
		DBTransaction db = null;
		boolean b = false;
		String obj = "";
		String cao = "";
		try {
			conn = ConnectionManager.getConnection();
			db = DBTransaction.getInstance(conn);

			if (personIds != null) {
				for (int j = 0; j < personIds.length; j++) {
					String personId = personIds[j];

					//删除已有权限，重新分配，不选栏目时将会置成空值
					Data old = new Data();
					old.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
					old.setPrimaryKey(PersonChannelRela.PERSON_ID,PersonChannelRela.ROLE);
					old.add(PersonChannelRela.PERSON_ID, personId);
					old.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_WRITER);
					handler.delete(conn, old);
					
					//保存
					if (channelsIds != null) {
						for (int i = 0; i < channelsIds.length; i++) {
							String channelId = channelsIds[i];
								
							// 获取已有权限，不对重复角色授权
							Data check = new Data();
							check.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
							check.setPrimaryKey(PersonChannelRela.PERSON_ID,PersonChannelRela.CHANNEL_ID,PersonChannelRela.ROLE);
							check.add(PersonChannelRela.PERSON_ID, personId);
							check.add(PersonChannelRela.CHANNEL_ID, channelId);
							check.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_WRITER);
							check = handler.findDataByKey(conn, check);
							if (check != null) {
								continue;
							}

							// 进行授权
							Data data = new Data();
							data.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
							data.setPrimaryKey(PersonChannelRela.ID);
							data.add(PersonChannelRela.ID, UUIDGenerator.getUUID());
							data.add(PersonChannelRela.PERSON_ID, personId);
							data.add(PersonChannelRela.CHANNEL_ID, channelId);
							data.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_WRITER);
							handler.add(conn, data);
						}
					}
				}
			}
			String persons = "";
			for(int i=0;i<personIds.length;i++){
			    Data data = new Data();
			    data.setEntityName("PUB_PERSON");
                data.setPrimaryKey("PERSON_ID");
                data.add("PERSON_ID", personIds[i]);
                data = handler.findDataByKey(conn, data);
                String person = data.getString("CNAME");
                if(i==0){
                    persons = person;
                }else{
                    persons = persons + "," +person;
                }
			}
			String channels = "";
			if(channelsIdsString == null || "".equals(channelsIdsString)){
			    cao = AuditConstants.ACT_REMOVE_AUTHORIZE;
			    obj = "移除【"+persons+"】投稿权限";
			}else{
			    for(int i=0;i<channelsIds.length;i++){
			        Data data = new Data();
	                data.setEntityName("CMS_CHANNEL");
	                data.setPrimaryKey("ID");
	                data.add("ID", channelsIds[i]);
	                data = handler.findDataByKey(conn, data);
	                String channel = data.getString("NAME");
	                if(i==0){
	                    channels = channel;
	                }else{
	                    channels = channels + "," + channel;
	                }
			    }
			    cao = AuditConstants.ACT_AUTHORIZE;
			    obj = "授予【"+persons+"】（"+channels+"）投稿权限";
			}
			
			
			db.commit();
			b = true;
		} catch (Exception e) {
			try {
				db.rollback();
			} catch (SQLException e1) {
				log.logError("给投稿人授权时出错!", e);
			}
			log.logError("给投稿人授权时出错!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("给投稿人授权时关闭Connection出错!", e);
			}
		}
		
		setAttribute(OrganPerson.ORG_ID, getParameter(OrganPerson.ORG_ID));
		String result = getParameter("RESULT");
		String actR = b ? AuditConstants.ACT_RESULT_OK : AuditConstants.ACT_RESULT_FAIL;
		AuditAppHelper.log(
		        ClientIPGetter.getInstance().getClientIP(getRequest()), "",
		        cao,"", obj, actR,
		        AuditConstants.AUDIT_LEVEL_5, "");
		if("NO".equals(result)){
			return null;
		}else{
			return "personListQ";
		}
	}
    
    /**
     * 审核人授权
     * @return
     */
    public String auditChannels() {
    	
    	//所有选中的栏目
		String channelsIdsString = getParameter("CHANNEL_IDS");
		String[] channelsIds = null;
		if (channelsIdsString != null && !"".equals(channelsIdsString)) {
			channelsIds = channelsIdsString.split("#");
		}

		//所有选中的人员
		String personIdString = getParameter("PERSONS_IDS");
		String[] personIds = null;
		if (personIdString != null && !"".equals(personIdString)) {
			personIds = personIdString.split("#");
		}

		Connection conn = null;
		DBTransaction db = null;
		boolean b = false;
        String obj = "";
        String cao = "";
		try {
			conn = ConnectionManager.getConnection();
			db = DBTransaction.getInstance(conn);

			if (personIds != null) {
				for (int j = 0; j < personIds.length; j++) {
					String personId = personIds[j];
					
					//删除已有权限，重新分配，不选栏目时将会置成空值
					Data old = new Data();
					old.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
					old.setPrimaryKey(PersonChannelRela.PERSON_ID,PersonChannelRela.ROLE);
					old.add(PersonChannelRela.PERSON_ID, personId);
					old.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_AUTHER);
					handler.delete(conn, old);
					
					//保存
					if (channelsIds != null) {
						for (int i = 0; i < channelsIds.length; i++) {
							String channelId = channelsIds[i];
								
							// 获取已有权限，不对重复角色授权
							Data check = new Data();
							check.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
							check.setPrimaryKey(PersonChannelRela.PERSON_ID,PersonChannelRela.CHANNEL_ID,PersonChannelRela.ROLE);
							check.add(PersonChannelRela.PERSON_ID, personId);
							check.add(PersonChannelRela.CHANNEL_ID, channelId);
							check.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_AUTHER);
							check = handler.findDataByKey(conn, check);
							if (check != null) {
								continue;
							}

							// 进行授权
							Data data = new Data();
							data.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
							data.setPrimaryKey(PersonChannelRela.ID);
							data.add(PersonChannelRela.ID, UUIDGenerator.getUUID());
							data.add(PersonChannelRela.PERSON_ID, personId);
							data.add(PersonChannelRela.CHANNEL_ID, channelId);
							data.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_AUTHER);
							handler.add(conn, data);
						}
					}
				}
			}
			String persons = "";
            for(int i=0;i<personIds.length;i++){
                Data data = new Data();
                data.setEntityName("PUB_PERSON");
                data.setPrimaryKey("PERSON_ID");
                data.add("PERSON_ID", personIds[i]);
                data = handler.findDataByKey(conn, data);
                String person = data.getString("CNAME");
                if(i==0){
                    persons = person;
                }else{
                    persons = persons + "," +person;
                }
            }
			String channels = "";
            if(channelsIdsString == null || "".equals(channelsIdsString)){
                cao = AuditConstants.ACT_REMOVE_AUTHORIZE;
                obj = "移除【"+persons+"】审核权限";
            }else{
                for(int i=0;i<channelsIds.length;i++){
                    Data data = new Data();
                    data.setEntityName("CMS_CHANNEL");
                    data.setPrimaryKey("ID");
                    data.add("ID", channelsIds[i]);
                    data = handler.findDataByKey(conn, data);
                    String channel = data.getString("NAME");
                    if(i==0){
                        channels = channel;
                    }else{
                        channels = channels + "," + channel;
                    }
                }
                cao = AuditConstants.ACT_AUTHORIZE;
                obj = "授予【"+persons+"】（"+channels+"）审核权限";
            }
            
            
            db.commit();
            b = true;
		} catch (Exception e) {
			try {
				db.rollback();
			} catch (SQLException e1) {
				log.logError("给投稿人授权时出错!", e);
			}
			log.logError("给投稿人授权时出错!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("给投稿人授权时关闭Connection出错!", e);
			}
		}
		
		setAttribute(OrganPerson.ORG_ID, getParameter(OrganPerson.ORG_ID));
		String result = getParameter("RESULT");
		String actR = b ? AuditConstants.ACT_RESULT_OK : AuditConstants.ACT_RESULT_FAIL;
		AuditAppHelper.log(
		        ClientIPGetter.getInstance().getClientIP(getRequest()), "",
		        cao,"", obj, actR,
		        AuditConstants.AUDIT_LEVEL_5, "");
		if("NO".equals(result)){
			return null;
		}else{
			return "personListQ";
		}
    }
    
    public String toAlotPersonChannelsFrame() {
        setAttribute("PERSONS_ID", getParameter("PERSONS_ID"));
        setAttribute(PersonChannelRela.ROLE, getParameter(PersonChannelRela.ROLE));
        return "allotPersonChannelsFrame";
    }
    
    /**
     * 转去分配人员栏目
     * @return
     */
    public String toAlotPersonChannels() {

        Connection conn = null;
        CodeList dataList = new CodeList();
        // 人员编号
        String personsId = getParameter("PERSONS_ID");
        //授权角色类型：投稿人[1] 、 审核人[2]
        String role = getParameter(PersonChannelRela.ROLE);
        String res = null;
        try {
            conn = ConnectionManager.getConnection();
            // 查询
            dataList = handler.generateTree(conn);
            // 得到所有的已经分配的资源和模块
            res = handler.findSavedChannelsOfPerson(conn, personsId, role);
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

        // 传递组织树
        setAttribute("ownResource", res);
        setAttribute("dataList", dataList);
        setAttribute("PERSONS_ID", personsId);
        setAttribute(OrganPerson.ORG_ID, getParameter(OrganPerson.ORG_ID));
        setAttribute(PersonChannelRela.ROLE, role);

        return "allotPersonChannels";
    }

    /**
     * 未实现
     */
    public String execute() throws Exception {
        return "default";
    }
}
