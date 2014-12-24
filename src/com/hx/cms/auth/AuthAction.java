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
 * @Description: ��Ŀ<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-11-22 ����01:33:46
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
     * ��ʼ��
     */
    public AuthAction() {
    	handler = new AuthHandler();
    	roleGroupHandler = new RoleGroupHandler();
    	organHandler = new OrganHandler();
//    	personHandler = new PersonHandler();
    	authorizeHandler = new AuthorizeHandler();
    }
    
    /**
     * תȥ������Ŀ
     * @return
     */
    public String toAlotChannels() {

        Connection conn = null;
        CodeList dataList = new CodeList();
        // ��ɫ���
        String roleId = getParameter(RoleChannelRela.ROLE_ID);
        if(roleId != null){
            roleId = roleId.split("!")[0];
        }
        String res = null;
        try {
            conn = ConnectionManager.getConnection();
            // ��ѯ
            dataList = handler.generateTree(conn);
            // �õ����е��Ѿ��������Դ��ģ��
            res = handler.findSavedResourceOfRole(conn, roleId);
        } catch (Exception e) {
            log.logError("תȥ����ɫ������Դʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ����ɫ������Դʱ�ر�Connection����!", e);
            }
        }

        // ������֯��
        setAttribute("ownResource", res);
        setAttribute("dataList", dataList);
        setAttribute(Role.ROLE_ID, roleId);
        setAttribute(RoleGroup.PARENT_ID, getParameter(RoleGroup.PARENT_ID));

        return "allotResource";
    }
    
    /**
     * ��֯��������Ա�б�
     * @return
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
	public String personList() {
        
    	//��ȡ��ѯ����
    	Map<String,String> smap=this.getDataWithPrefix("S_", true);
    	Data sdata = new Data((Map)smap);
    	//��ѯ����
    	String orgId = sdata.getString("ORGAN_ID_"); //����ѯ�����Ƿ����
    	if("0".equals(orgId)){
    	    orgId = null;
    	    sdata.remove("ORGAN_ID_");
    	    sdata.remove("ORGAN_NAME_");
    	}
    	//ԭ��֯
    	String oldOrgId = getParameter(OrganPerson.ORG_ID);
    	if(oldOrgId == null || "".equals(oldOrgId) || "null".equals(oldOrgId)){
    		oldOrgId = (String) getAttribute(OrganPerson.ORG_ID);
        }
    	
        // ��ҳ��С�͵�ǰҳ
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1; //����1�Ż���ʾ��ҳ
        }

        Connection conn = null;
        DataList dataList = new DataList();
        UserInfo user = SessionInfo.getCurUser();
        try {
        	//��֯��������
        	String oldOrganName = "";
        	if(oldOrgId != null){
        		oldOrganName = OrganHelper.getOrganCNameById(oldOrgId); 
        	}
            conn = ConnectionManager.getConnection();
            
            //��������
            if(smap.isEmpty()){
        		//�����ǰѡ�е���֯����Ϊ��������ô�Ͳ����뵽��ѯ��ʡȥ����0�����
        		if(!"0".equals(oldOrgId)){
        			//�޲�ѯ
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
            
            // ʹ��SQL���в�ѯ
        	//dataList = personHandler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
        	if(CmsConfigUtil.isMultistageAdminMode()){
    			//����ּ�
    			if("0".equals(user.getAdminType())){
    				//��������Ա���������ó�������Ա��ϵͳ����Ա
    				//�ĳ�ORG_ID IN('',...,'')���ַ�ʽ
    				String organIdString = sdata.getString("ORGAN_ID_");
    				if(organIdString != null && !"".equals(organIdString)){
    					sdata.add("ORGAN_ID_", "'"+organIdString+"'");
    				}
    				dataList = handler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
    				sdata.add("ORGAN_ID_", oldOrgId);
    			}
    			if("1".equals(user.getAdminType())){
    				//�ɹ���Ľ�ɫ
    				//�ĳ�ORG_ID IN('',...,'')���ַ�ʽ
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
    					//�ĳ�ORG_ID IN('',...,'')���ַ�ʽ
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
    			//���ּ�
    			//�ĳ�ORG_ID IN('',...,'')���ַ�ʽ
    			String organIdString = sdata.getString("ORGAN_ID_");
				if(organIdString != null && !"".equals(organIdString)){
					sdata.add("ORGAN_ID_", "'"+organIdString+"'");
				}
				dataList = handler.findPersonOfOrg(conn, sdata, pageSize, page,"SEQ_NUM","ASC");
    			sdata.add("ORGAN_ID_", oldOrgId);
    		}
            
            //�����û���Ȩ���б�
            DataList rolesList = authorizeHandler.findRoleOfPer(conn, null);
            //�����ɫ
            if(dataList != null && dataList.size() > 0){
            	for (int i = 0; i < dataList.size(); i++) {
            		//��ɫ�б�
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
            log.logError("��ѯ��֯����Աʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ��֯����Աʱ�ر�Connection����!", e);
            }
        }
        //������֯����
        setAttribute(OrganPerson.ORG_ID, orgId);
        // �洢
        setAttribute("dataList", dataList);
        return "personList";
    }
    
    /**
     * ��ʾ��Ŀ��ѡ��:�����ⲿ������Ŀ
     * @return
     */
    public String toAlotChannelsNoConditions() {
    	
    	Connection conn = null;
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		// ��ѯ
    		dataList = handler.generateTree(conn);
    	} catch (Exception e) {
    		log.logError("תȥ����ɫ������Դʱ����!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("תȥ����ɫ������Դʱ�ر�Connection����!", e);
    		}
    	}
    	
    	// ������֯��
    	setAttribute("dataList", dataList);
    	return getParameter("treeDispatcher");
    }
    
    /**
     * ������֯�������νṹ
     * @return
     */
    public String generateOrganTree(){

        Connection conn = null;
        //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
        CodeList dataList = new CodeList();
        UserInfo user = SessionInfo.getCurUser();
        
        try {
            conn = ConnectionManager.getConnection();
            
            
            if(CmsConfigUtil.isMultistageAdminMode()){
            	//����ּ�
            	if("0".equals(user.getAdminType())){
            		//��ѯ
            		dataList = organHandler.generateTree(conn);
            	}
            	if("1".equals(user.getAdminType())){
            		//��ѯ
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
            			
            			//���붥��
            			Code p = new Code();
            			p.setName(parent.getString("NAME"));
            			p.setValue(parent.getString("VALUE"));
            			p.setParentValue("0");
            			dataList.add(p);
            		}
            	}
            }

            if(CmsConfigUtil.isThreeAdminMode()){
            	//��ѯ
        		dataList = organHandler.generateTree(conn);
            }
            
            
        } catch (Exception e) {
            log.logError("������֯��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������֯��ʱ�ر�Connection����!", e);
            }
        }
        
        //����CodeList��codeNames����-------<bz:codeTree>Ҫ���������
        //dataList.setCodeSortId("organTree");
        
        //������֯��
        setAttribute("dataList", dataList);
        return getParameter("treeDispatcher");
    }
    
    /**
     * ����ɫ������Ŀ
     * @return 
     */
    public String alotChannels(){
    	
    	//����ѡ�еĽ�ɫ
        String roleIdString = getParameter(RoleChannelRela.ROLE_ID);
        String[] roleIds = null;
        if(roleIdString != null && !"".equals(roleIdString)){
            roleIds = roleIdString.split("#");
        }
        
        //����ѡ�е���Ŀ
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
                    
                    //�ǽ�ɫ��Ľ�ɫ����Ч����ɫ��������У���������һ��
                    if(!roleGroupHandler.isRoleGroup(conn, roleId)){
                    	
                    	//����յ�ǰ��ɫ��Ŀ�Ĺ�ϵ����
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
                                
                                //���з���
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
                log.logError("����ɫ������Ŀʱ����!", e);
            }
            log.logError("����ɫ������Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("����ɫ������Ŀʱ�ر�Connection����!", e);
            }
        }
        setAttribute(RoleGroup.PARENT_ID, getParameter(RoleGroup.PARENT_ID));
        
        return "query";
    }
    
    /**
     * Ͷ������Ȩ
     * @return
     */
    public String writerChannels() {

		//����ѡ�е���Ŀ
		String channelsIdsString = getParameter("CHANNEL_IDS");
		String[] channelsIds = null;
		if (channelsIdsString != null && !"".equals(channelsIdsString)) {
			channelsIds = channelsIdsString.split("#");
		}

		//����ѡ�е���Ա
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

					//ɾ������Ȩ�ޣ����·��䣬��ѡ��Ŀʱ�����óɿ�ֵ
					Data old = new Data();
					old.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
					old.setPrimaryKey(PersonChannelRela.PERSON_ID,PersonChannelRela.ROLE);
					old.add(PersonChannelRela.PERSON_ID, personId);
					old.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_WRITER);
					handler.delete(conn, old);
					
					//����
					if (channelsIds != null) {
						for (int i = 0; i < channelsIds.length; i++) {
							String channelId = channelsIds[i];
								
							// ��ȡ����Ȩ�ޣ������ظ���ɫ��Ȩ
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

							// ������Ȩ
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
			    obj = "�Ƴ���"+persons+"��Ͷ��Ȩ��";
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
			    obj = "���衾"+persons+"����"+channels+"��Ͷ��Ȩ��";
			}
			
			
			db.commit();
			b = true;
		} catch (Exception e) {
			try {
				db.rollback();
			} catch (SQLException e1) {
				log.logError("��Ͷ������Ȩʱ����!", e);
			}
			log.logError("��Ͷ������Ȩʱ����!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("��Ͷ������Ȩʱ�ر�Connection����!", e);
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
     * �������Ȩ
     * @return
     */
    public String auditChannels() {
    	
    	//����ѡ�е���Ŀ
		String channelsIdsString = getParameter("CHANNEL_IDS");
		String[] channelsIds = null;
		if (channelsIdsString != null && !"".equals(channelsIdsString)) {
			channelsIds = channelsIdsString.split("#");
		}

		//����ѡ�е���Ա
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
					
					//ɾ������Ȩ�ޣ����·��䣬��ѡ��Ŀʱ�����óɿ�ֵ
					Data old = new Data();
					old.setEntityName(PersonChannelRela.PERSON_CHANNEL_RELA_ENTITY);
					old.setPrimaryKey(PersonChannelRela.PERSON_ID,PersonChannelRela.ROLE);
					old.add(PersonChannelRela.PERSON_ID, personId);
					old.add(PersonChannelRela.ROLE, PersonChannelRela.ROLE_STATUS_AUTHER);
					handler.delete(conn, old);
					
					//����
					if (channelsIds != null) {
						for (int i = 0; i < channelsIds.length; i++) {
							String channelId = channelsIds[i];
								
							// ��ȡ����Ȩ�ޣ������ظ���ɫ��Ȩ
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

							// ������Ȩ
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
                obj = "�Ƴ���"+persons+"�����Ȩ��";
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
                obj = "���衾"+persons+"����"+channels+"�����Ȩ��";
            }
            
            
            db.commit();
            b = true;
		} catch (Exception e) {
			try {
				db.rollback();
			} catch (SQLException e1) {
				log.logError("��Ͷ������Ȩʱ����!", e);
			}
			log.logError("��Ͷ������Ȩʱ����!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("��Ͷ������Ȩʱ�ر�Connection����!", e);
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
     * תȥ������Ա��Ŀ
     * @return
     */
    public String toAlotPersonChannels() {

        Connection conn = null;
        CodeList dataList = new CodeList();
        // ��Ա���
        String personsId = getParameter("PERSONS_ID");
        //��Ȩ��ɫ���ͣ�Ͷ����[1] �� �����[2]
        String role = getParameter(PersonChannelRela.ROLE);
        String res = null;
        try {
            conn = ConnectionManager.getConnection();
            // ��ѯ
            dataList = handler.generateTree(conn);
            // �õ����е��Ѿ��������Դ��ģ��
            res = handler.findSavedChannelsOfPerson(conn, personsId, role);
        } catch (Exception e) {
            log.logError("תȥ����ɫ������Դʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ����ɫ������Դʱ�ر�Connection����!", e);
            }
        }

        // ������֯��
        setAttribute("ownResource", res);
        setAttribute("dataList", dataList);
        setAttribute("PERSONS_ID", personsId);
        setAttribute(OrganPerson.ORG_ID, getParameter(OrganPerson.ORG_ID));
        setAttribute(PersonChannelRela.ROLE, role);

        return "allotPersonChannels";
    }

    /**
     * δʵ��
     */
    public String execute() throws Exception {
        return "default";
    }
}
