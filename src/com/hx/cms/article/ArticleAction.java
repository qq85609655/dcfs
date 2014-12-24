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
 * @Description: ��Ŀ<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2010-11-22 ����01:33:46
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
     * ��ʼ��
     */
    public ArticleAction() {
    	handler = new ArticleHandler();
    	channelHandler = new ChannelHandler();
    	organHandler = new OrganHandler();
    }
    
    /**
     * ��ǩ��ҳ�����õķ���
     * @return
     */
    public String test(){
        String formId = getParameter("formId");
        setAttribute("formId", formId);
        setAttribute(formId+"_page",getParameter(formId+"_page"));
        return "test";
    }
    
    /**
     * OA ��ҳ֪ͨ�������� 
     * @return
     */
    public String noticeListHomePage(){
    	return SUCCESS;
    }
    
    /**
     * OA ��ҳ֪ͨ�������� �б�
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String noticeList(){
    	
    	String channelId = getParameter("CHANNEL_ID");
    	setAttribute("CHANNEL_ID", channelId);
        
        Map search = getDataWithPrefix("S_", true);
        Data searchData = new Data(search);
        setAttribute("data", searchData);
    	
    	/************��ȡ���ݿ������ʾ--��ʼ***************/
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
		/************��ȡ���ݿ������ʾ--����***************/
        
        //��ҳ��ʾ
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
    	
    	//��ȡ��ǰ��¼��ӵ�еĽ�ɫ����
    	UserInfo user = SessionInfo.getCurUser();
        String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        String organId = PersonHelper.getOrganOfPerson(personId).getId();
        try {
            conn = ConnectionManager.getConnection();
            if(dataAccess){
		        //��������Ȩ��У��
                dataList = handler.findArtOfChannelForDataAccess(conn, channelId, searchData, orderString, pageSize, page, personId, organId);
		    }else{
		        //��Ȩ���ʣ��������
		    	dataList = handler.findArtOfChannel(conn, channelId, searchData, orderString, pageSize, page);
		    }
        } catch (Exception e) {
            log.logError("��ѯ��������ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ��������ʱ�ر�Connection����!", e);
            }
        }
        //����
        setAttribute("dataList", dataList);
        return SUCCESS;
    }
    
    /**
     * �л��汾
     * @return
     */
    public String toSwitchVersion(){
    	//��������+�汾
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
    	//��ѯ��֯��
    	Connection conn = null;
    	//�汾�б�
    	DataList dataList = new DataList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//��ȡ��ѡ�ڵ�
    		Data data = new Data();
    		data.setEntityName("WF_WORKFLOWDEFS");
    		data.setPrimaryKey("WF_NAME");
    		data.add("WF_NAME", wfName);
    		dataList = handler.findListByData(conn,data);
    	} catch (Exception e) {
    		log.logError("תȥ������Ա��֯ʱ����!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("תȥ������Ա��֯ʱ����!", e);
    		}
    	}
    	//����Ƶ����
    	setAttribute("dataList", dataList);
    	return SUCCESS;
    }
    
    /**
     * תȥ��������Ȩ��
     * @return
     */
    public String toDataAccess(){
        String dataAccess = getParameter("DATA_ACCESS");
        //��ѯ��֯��
        Connection conn = null;
        //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
        CodeList dataList = new CodeList();
        UserInfo user = SessionInfo.getCurUser();
        try {
            conn = ConnectionManager.getConnection();
            if("2".equals(dataAccess)){
                //��Ա
                if(CmsConfigUtil.isMultistageAdminMode()){
                	//����ּ�
                	if("0".equals(user.getAdminType())){
                		//��ѯ
                		dataList = handler.findPersons(conn);
                	}
                	if("1".equals(user.getAdminType())){
                		//��ѯ
                		dataList = handler.findPersonsForLevelList(conn, user.getPersonId());
                	}
                }
                if(CmsConfigUtil.isThreeAdminMode()){
                	//��ѯ
                	dataList = handler.findPersons(conn);
                }
            }
            if("3".equals(dataAccess)){
                //��֯
                if(CmsConfigUtil.isMultistageAdminMode()){
                	//����ּ�
                	if("0".equals(user.getAdminType())){
                		//��ѯ
                		dataList = handler.findOrgans(conn);
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
                	dataList = handler.findOrgans(conn);
                }
            }
            
            //ѡ������
            String selectedNode = getParameter("SELECTEDNODE");
            selectedNode = selectedNode.replaceAll("!", ",");
            setAttribute("selectedData", selectedNode);
        } catch (Exception e) {
            log.logError("תȥ������Ա��֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ������Ա��֯ʱ����!", e);
            }
        }
        //����Ƶ����
        setAttribute("dataList", dataList);
        return "toDataAccess";
    }
    
    /**
     * ��ʽ��ʼ��
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
     * ǰ̨��ʾ��������
     * @return
     */
    public String detailArt(){
        // ��ȡ����ֵ
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
            //�ܼ���ʾ
            int secLevel = data.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 1){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //��־
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_DETAIL,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
        } catch (Exception e) {
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
        setAttribute("data", data);
        
        if(bta != -1){
        	//Ϊ�����ļ�packageId��ֵ
        	ActionContext.getContext().getValueStack().set("PACKAGE_ID", bodyTextAtt);
        	return "webofficeShowAtt";
        }
        return "detailArt";
    }
    
    /**
     * �������ص�ַ
     * @return
     */
    public String generateDownloadUrl(){
    	// ��ȡ����ֵ
    	String id = getParameter(Article.ID);
    	Data data = new Data();
    	data.setEntityName(Article.ARTICLE_ENTITY);
    	data.setPrimaryKey(Article.ID);
    	data.add(Article.ID, id);
    	
    	Connection conn = null;
    	try {
    		// ����
    		conn = ConnectionManager.getConnection();
    		data = handler.findDataByKey(conn, data);
    	} catch (Exception e) {
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
    	setAttribute("data", data);
    	return "generateDownloadUrl";
    }
    
    /**
     * ���ѡ�е����£�Ҫ������������˼�¼
     * 		���ѡ�е�ƪ�������������ʷ
     * 		���ѡ�ж�ƪ�����򲻲�������ʷ
     * @return
     */
    public String auditArt(){
        // ��ȡ����ֵ
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
            		//����������˿���ֱ��Ԥ��
            		setAttribute("ART_SINGLETON", "ART_SINGLETON");
            	}
            }
        } catch (Exception e) {
            log.logError("�������ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("�������ʱ����!", e);
            }
        }
        setAttribute("dataList", dataList);
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        setAttribute(AuditOpinion.IDS, idString);
        return "auditArt";
    }
    
    /**
     * Ԥ�������/�޸ģ�
     * @return
     */
    public String detailArtScan(){
        
    	// ��ȡ������
		Data data = fillData(false);
		
		String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
		// ����
		// ����ID
		/*String articleId = UUIDGenerator.getUUID();
		data.add(Article.ID, articleId);*/

		// ����ʱ��
		Date date = new Date();
		/*data.add(Article.CREATE_TIME, date);
		data.add(Article.MODIFY_TIME, date);*/
		
		//Ԥ��ʹ��
		String createTime_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
		data.add(Article.CREATE_TIME, createTime_);
		data.add(Article.MODIFY_TIME, createTime_);

		//������
        UserInfo ui = SessionInfo.getCurUser();
        String personId = ui.getPerson().getPersonId();
        data.add(Article.CREATOR, personId);
        
        //������֯ID
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        Organ organ = user.getCurOrgan();
        String createDeptId = null;
        if(organ != null){
        	createDeptId = organ.getId();
        }
        data.add(Article.CREATE_DEPT_ID, createDeptId);

		// ��������������Ƿ���ͼƬ����У���ô�����ĵ�ַ���浽imageSource����
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

		// ֱ�ӷ���
		data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
		
		
		/*�ܼ���ʾ��ʼ*/
		//StringBuffer html = new StringBuffer();
		Connection conn = null;
		try{
			conn = ConnectionManager.getConnection();
			/*if (data != null) {
	        	//ʱ��
	            String securitLevel = data.getString(Article.SECURITY_LEVEL);
	            String periodTime = data.getString(Article.PROTECT_PERIOD);
	            CodeList securityList = new CodeList();
	    		securityList = UtilCode.getCodeList("SECURITY_LEVEL", conn);
	    		if(securityList != null && securityList.size() > 0){
	            	for (int i = 0; i < securityList.size(); i++) {
						Code code = securityList.get(i);
						if(code.getValue().equals(securitLevel)){
							if(!"��".equals(code.getRem())){
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
							if(!"��".equals(code.getRem())){
								html.append("��").append(code.getRem());
							}
						}
					}
	            }
	    	}*/
			//data.add("SECURITY_LEVEL_DESC", html.toString());
		} catch (Exception e) {
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
		setAttribute("data", data);
		setAttribute("dl", new DataList());
		return "detailArtScan";
    }
    
    /**
	 * ���¹������
	 * 
	 * @return
	 */
    public String queryIndex(){
        return "index";
    }
    
    /**
	 * �����ƶ����µ���Ŀ�������
	 * 
	 * @return
	 */
    public String changeChannelFrame(){
        setAttribute(Article.IDS, getParameter(Article.IDS));
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "changeChannelFrame";
    }
    
    /**
     * �����ת�������������ʾ��ҳ��:��ɫ��֤
     * @return
     */
    /*public String toChangeChannel(){
        //��ѯ��֯��
        Connection conn = null;
        //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //��ѯ
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            java.util.List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	dataList = channelHandler.findChannelsOfRole(conn,roles);
            }
        } catch (Exception e) {
            log.logError("תȥ������Ա��֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ������Ա��֯ʱ����!", e);
            }
        }
        //����Ƶ����
        setAttribute("dataList", dataList);
        setAttribute(Article.IDS, getParameter(Article.IDS));
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "changeChannel";
    }*/
    
    /**
     * �����ת�������������ʾ��ҳ��:��Ա��֤
     * @return
     */
    public String toChangeChannel(){
    	//��ѯ��֯��
    	Connection conn = null;
    	//ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//��ѯ
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
    		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
    		dataList = channelHandler.findChannelsOfPerson(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
    	} catch (Exception e) {
    		log.logError("תȥ������Ա��֯ʱ����!", e);
    	} finally {
    		try {
    			if (conn != null && !conn.isClosed()) {
    				conn.close();
    			}
    		} catch (SQLException e) {
    			log.logError("תȥ������Ա��֯ʱ����!", e);
    		}
    	}
    	//����Ƶ����
    	setAttribute("dataList", dataList);
    	setAttribute(Article.IDS, getParameter(Article.IDS));
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	
    	return "changeChannel";
    }
    
    /**
     * ͳ�����ش���
     * @return
     */
    public String statDownNum(){
        
    	String id = getParameter(Article.ID);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // ����
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
            // �ύ
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("���ش���ͳ��ʱ����!", e);
            }
            log.logError("���ش���ͳ��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("���ش���ͳ��ʱ����!", e);
            }
        }
        return null;
    }
    
    /**
     * �ƶ���Ŀ
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
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            if(ids != null){
            	for (int i = 0; i < ids.length; i++) {
            	    Data data1 = new Data();
            	    
            	    Data cur = new Data();
            	    
					String id = ids[i].split(",")[0];
					String store = ids[i].split(",")[1];
					if("REFERENCE".equals(store)){//�������ݵ��ƶ�=ԭ���ݵ����·���
					    Data reference = new Data();
                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                        reference.setPrimaryKey(Article2Channels.ID);
                        reference.add(Article2Channels.ID, id);
                        Data ref = handler.findDataByKey(conn, reference);
                        String articleId = ref.getString("ARTICLE_ID");
                        if(idString.contains(articleId)){//����������ݺ�ԭ����ͬʱ���ڣ�ɾ����������
                            handler.delete(conn, reference);
                        }else{//���������ԭ���ݣ��ж��Ƿ���ԭ���������ظ����Ƿ���ԭ�����ظ�
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
                            
                            if(ref2_ != null && !"".equals(ref2_.getString(Article2Channels.ID))){//��Ҫ�ƶ����������ݣ�ԭ�������ݴ���
                                handler.delete(conn, reference);
                            }else if(ArticleChannelId.equals(channelId)){//��Ҫ�ƶ�����������Ŀ����Ŀ��ԭ������ͬ
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
					    
					    //ɾ���ظ�����������
					    Data delRef = new Data();
					    delRef.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
					    delRef.setPrimaryKey(Article2Channels.ARTICLE_ID,Article2Channels.CHANNEL_ID);
					    delRef.add(Article2Channels.ARTICLE_ID, id);
					    delRef.add(Article2Channels.CHANNEL_ID, channelId);
					    handler.delete(conn, delRef);
					    
					    //�ܼ���ʾ
					    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
					    String securityLevel = "";
					    if(secLevel > 0){
					        securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
					    }
					    //��־
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
        setAttribute(Article.CHANNEL_ID, getParameter("Article_"+Article.CHANNEL_ID));
        setAttribute("refreshTree", "<script type='text/javascript'>parent.document.srcForm.submit();</script>");
        return "query";
    }

    /**
     * ��ҳ��ѯ�Ӽ�
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String query(){
    	
    	//��ѯ����
    	Map map = getDataWithPrefix("Search_", true);
    	Data searchData = new Data(map);
    	
    	/************��ȡ���ݿ������ʾ--��ʼ***************/
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
		/************��ȡ���ݿ������ʾ--����***************/
		
        //��ҳ��ʾ
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        //�õ���ǰ�������֯������idֵ����Ϊ���ӻ����ĸ�ID���в�ѯ���õ����е�ǰ�������¼�
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
        	channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //���ͨ��������
        data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
        
        //��ѯ
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
            
            
            //һ��Nģʽ
            if(CmsConfigUtil.is1nMode()){
            	//��ȡ����λ
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
            
            //Ͷ������Ŀ
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
            //�������Ŀ
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            //��ǰ̨�ж�
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
        setAttribute(Article.CHANNEL_ID, channelId);
        //����
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return SUCCESS;
    }
    
    /**
     * ���ƻ����ƹ���,�ı������
     * @return
     */
    public String changeSeqnum(){
        
        Data data = new Data();
        String id = getParameter(Article.ID);
        String channelId = getParameter(Article.CHANNEL_ID);
        String target = getParameter("target");
        //��֯����ID
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
                //��ѯ
                data = handler.findDataByKey(conn, data);
                
                int seqNum = data.getInt(Article.SEQ_NUM);
                
                //����
                if("up".equals(target)){
                	Data upData = new Data();
                	upData.setEntityName(Article.ARTICLE_ENTITY);
                	upData.setPrimaryKey(Article.CHANNEL_ID,Article.SEQ_NUM);
                	upData.add(Article.CHANNEL_ID, channelId);
                	upData.add(Article.SEQ_NUM, (seqNum - 1));
                	Data upData_ = handler.findDataByKey(conn, upData);
                	if(upData_ != null){
                		//��ʼ�ƶ�
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
                //����
                if("down".equals(target)){
                	Data downData = new Data();
                	downData.setEntityName(Article.ARTICLE_ENTITY);
                	downData.setPrimaryKey(Article.CHANNEL_ID,Article.SEQ_NUM);
                	downData.add(Article.CHANNEL_ID, channelId);
                	downData.add(Article.SEQ_NUM, (seqNum + 1));
                	Data downData_ = handler.findDataByKey(conn, downData);
                	if(downData_ != null){
                		//��ʼ�ƶ�
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
				log.logError("������������ʱ����!", e1);
			}
            log.logError("������������ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������������ʱ�ر�Connection����!", e);
            }
        }
        return "query";
    }
    
    /**
     * �ݴ��б�
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String tempQuery(){
    	
    	//��ѯ����
    	Map map = getDataWithPrefix("Search_", true);
    	Data searchData = new Data(map);
    	
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
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //�ݴ�״̬���˻ص�����
        data.add("STATUS_1", Article.STATUS_DRAFT);
        data.add("STATUS_2", Article.STATUS_BACK_AUDIT);
        
        //��ѯ
		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //Ͷ������Ŀ
            CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
            //�������Ŀ
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            
            //һ��Nģʽ
            if(CmsConfigUtil.is1nMode()){
            	//��ȡ����λ
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
        	
        	//��ǰ̨�ж�
        	if(channelList != null && channelList.size() > 0){
        		for (int i = 0; i < channelList.size(); i++) {
					Code code = channelList.get(i);
					if(code.getValue().equals(channelId)){
						setAttribute("WRITER_AUTH", "WRITER_AUTH");
						//�������Ŀ�ı�־
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
        setAttribute(Article.CHANNEL_ID, channelId);
        //����
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return "temp";
    }
    
    /**
     * �ݴ��б�,ֻ��ʾ�����б�
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public String tempPersonalQuery(){
        
        //��ѯ����
        Map map = getDataWithPrefix("Search_", true);
        Data searchData = new Data(map);
        
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
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //�ݴ�״̬���˻ص�����
        data.add("STATUS_1", Article.STATUS_DRAFT);
        data.add("STATUS_2", Article.STATUS_BACK_AUDIT);
        
        //��ѯ
        UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //Ͷ������Ŀ
            CodeList channelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
            //�������Ŀ
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            dataList = handler.findPersonalArticlesAllBySQL(conn, data, pageSize, page, channelList, orderString, searchData,personId);
            
            //��ǰ̨�ж�
            if(channelList != null && channelList.size() > 0){
                for (int i = 0; i < channelList.size(); i++) {
                    Code code = channelList.get(i);
                    if(code.getValue().equals(channelId)){
                        setAttribute("WRITER_AUTH", "WRITER_AUTH");
                        //�������Ŀ�ı�־
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
        setAttribute(Article.CHANNEL_ID, channelId);
        //����
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return "temp";
    }
    
    /**
     * ����б�
     * @return
     */
    @SuppressWarnings({})
	public String auditQuery(){
    	
    	//��ѯ����
    	Data searchData = getRequestEntityData("Search_", "TITLE");
    	
    	/************��ȡ���ݿ������ʾ--��ʼ***************/
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
		/************��ȡ���ݿ������ʾ--����***************/
        
        //��ҳ��ʾ
        int pageSize = getPageSize(hx.common.Constants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        //�õ���ǰ�������֯������idֵ����Ϊ���ӻ����ĸ�ID���в�ѯ���õ����е�ǰ�������¼�
        String channelId = getParameter(Article.CHANNEL_ID);
        if(channelId == null || "".equals(channelId) || "null".equals(channelId)){
            channelId = (String) getAttribute(Article.CHANNEL_ID);
        }
        
        Data data = new Data();
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);
        data.add(Article.CHANNEL_ID, channelId!=null&&!"".equals(channelId)?channelId:"0");
        //�ȴ���˵�����
        data.add("STATUS_1", Article.STATUS_WAIT_AUDIT);
        
        
        //��ѯ
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
        setAttribute(Article.CHANNEL_ID, channelId);
        //����
        setAttribute("dataList", dataList);
        setAttribute("data", searchData);
        return "audit";
    }
    
    /**
     * תȥ�����Ŀ
     * @return
     */
    public String toAdd(){
    	
    	String channelId = getParameter(Article.CHANNEL_ID);
    	Data channel = new Data();
    	channel.setEntityName(Channel.CHANNEL_ENTITY);
    	channel.setPrimaryKey(Channel.ID);
    	channel.add(Channel.ID, channelId);
    	
        Data data = new Data();
        
        //��ѯ
		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            //��Ŀ����
            CodeList codeList = channelHandler.findChannelToCodeList(conn);
            
            String codeId = "channelList";
            codeList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, codeList);
            setAttribute(Constants.CODE_LIST, map);
            
            //��ѯ��Ŀ
            channel = channelHandler.findDataByKey(conn, channel);
            if(channel == null){
                data.add(Channel.NAME, "ROOT");
            }else{
                data.add(Channel.NAME, channel.getString(Channel.NAME));
                //�������Ŀ�ı�־
				setAttribute("IS_AUTH", channel.getString(Channel.IS_AUTH));
            }
            
            
            //Ͷ������Ŀ
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
            //�������Ŀ
            CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            //��ǰ̨�ж�
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
        
        setAttribute("data", data);
        //��֯����ID
        setAttribute(Article.CHANNEL_ID, channelId);
        return "add";
    }
    
    /**
     * תȥ�޸���Ŀ
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
                //��ѯ
                data = handler.findDataByKey(conn, data);
                
                /***************************************************/
                //������Ȩ
                String dataAccess = data.getString(Article.DATA_ACCESS);
                if(dataAccess != null && !"".equals(dataAccess)){
                    //��ԱȨ��
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
                    //��֯Ȩ��
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
                //��ѯ��Ŀ����
                  Data channel = new Data();
                  channel.setEntityName(Channel.CHANNEL_ENTITY);
                  channel.setPrimaryKey(Channel.ID);
                  channel.add(Channel.ID, data.getString(Article.CHANNEL_ID));
                  channel = channelHandler.findDataByKey(conn, channel);
                  String IS_AUTH = channel.getString(Channel.IS_AUTH);
                  setAttribute("IS_AUTH", IS_AUTH);
                  //��ѯ�����
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
                
                //��˼�¼
                Data audit = new Data();
                audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                audit.setPrimaryKey(AuditOpinion.ARTICLE_ID);
                audit.add(AuditOpinion.ARTICLE_ID, id);
                dataList = handler.findAuditOpinionOfArt(conn, audit);
            }
            
            //��ѯ��Ŀ����
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
        setAttribute("dataList", dataList);
        //��֯����ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "modify";
    }
    
    public String toModifyTemp(){
        
        Data data = new Data();
        String id = getParameter(Article.ID);
        Connection conn = null;
        DataList dataList = new DataList();
        
        //��ѯ
//		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
//		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
        try {
            conn = ConnectionManager.getConnection();
            if(id != null && !"".equals(id.trim())){
                data.setEntityName(Article.ARTICLE_ENTITY);
                data.setPrimaryKey(Article.ID);
                data.add(Article.ID, id);
                //��ѯ
                data = handler.findDataByKey(conn, data);
                
                /***************************************************/
                //������Ȩ
                String dataAccess = data.getString(Article.DATA_ACCESS);
                if(dataAccess != null && !"".equals(dataAccess)){
                    //��ԱȨ��
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
                    //��֯Ȩ��
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
              //��ѯ��Ŀ����
                Data channel = new Data();
                channel.setEntityName(Channel.CHANNEL_ENTITY);
                channel.setPrimaryKey(Channel.ID);
                channel.add(Channel.ID, data.getString(Article.CHANNEL_ID));
                channel = channelHandler.findDataByKey(conn, channel);
                String IS_AUTH = channel.getString(Channel.IS_AUTH);
                setAttribute("IS_AUTH", IS_AUTH);
                //��ѯ�����
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
                //��˼�¼
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
                //�������Ŀ�ı�־
				setAttribute("IS_AUTH", channel.getString(Channel.IS_AUTH));
            }*/
            
          //Ͷ������Ŀ
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
            //�������Ŀ
            /*CodeList autherChannelList = channelHandler.findChannelsOfPerson2(conn, personId, PersonChannelRela.ROLE_STATUS_AUTHER);
            //��ǰ̨�ж�
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
        setAttribute("dataList", dataList);
        //��֯����ID
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "tempModify";
    }
    
    /**
     * ��ʾ����
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
                //��ѯ
                data = handler.findDataByKey(conn, data);
            }
            
            //��ѯ��Ŀ����
            Data channel = new Data();
            channel.setEntityName(Channel.CHANNEL_ENTITY);
            channel.setPrimaryKey(Channel.ID);
            channel.add(Channel.ID, data.getString(Article.CHANNEL_ID));
            channel = channelHandler.findDataByKey(conn, channel);
            data.add(Channel.NAME, channel.getString(Channel.NAME));
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
        return "queryDetail";
    }

    /**
     * ��֯�ṹ
     * 
     * @return
     */
    public String add() {
        // ��ȡ������
        Data data = fillData(true);
        
        //�ܼ� ����������λ"NULL"�ַ��������ݿ����ʾ����
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
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //����ID
            String articleId = UUIDGenerator.getUUID();
            data.add(Article.ID, articleId);
            
            //����ʱ��
            //Date date = new Date();
            //data.add(Article.CREATE_TIME, date);
            data.add(Article.MODIFY_TIME, data.getString(Article.CREATE_TIME));
            
            //������
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            UserInfo ui = SessionInfo.getCurUser();
            String personId = ui.getPerson().getPersonId();
            data.add(Article.CREATOR, personId);
            
            /*//��������������Ƿ���ͼƬ����У���ô�����ĵ�ַ���浽imageSource����
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
            
            //�ȴ����
            data.add(Article.STATUS, Article.STATUS_WAIT_AUDIT);
            //data.add(Article.ATT_ICON, iconPackageId);
            
            /********************************************/
            //����Ȩ��
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
            //��Ȩ��Ա
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
            //��Ȩ��֯
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
            //�����
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
            
            //������֯ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(Article.CREATE_DEPT_ID, createDeptId);
            
            //�ܼ���ʶ���۸�
            String seckey = data.getString(Article.ID)+"$"+data.getString(Article.SECURITY_LEVEL);
            data.add(Article.DATA_HASH, UtilHash.hashString(seckey));
            
            //��������
            Data data1 = handler.add(conn, data);
            
            //�ܼ���ʾ
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //��־
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_AUDIT,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS���ͳ��
            ClickCountHelper.addPage(data.getString(Article.ID), data.getString(Article.TITLE), data.getString(Article.CHANNEL_ID), "");
            
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));

        // ��ת
        return "query";
    }
    
    /**
     * ֱ�ӷ���
     * @return
     */
    public String addDirect() {
        // ��ȡ������
        Data data = fillData(true);
        
        data.put(Article.SECURITY_LEVEL, "0");
        //�ܼ� ����������λ"NULL"�ַ��������ݿ����ʾ����
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
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //����ID
            String articleId = UUIDGenerator.getUUID();
            data.add(Article.ID, articleId);
            
            //����ʱ��
            //Date date = new Date();
            //data.add(Article.CREATE_TIME, date);
            data.add(Article.MODIFY_TIME, data.getString(Article.CREATE_TIME));
            
            //������
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            UserInfo ui = SessionInfo.getCurUser();
            String personId = ui.getPerson().getPersonId();
            data.add(Article.CREATOR, personId);
            
            //��������������Ƿ���ͼƬ����У���ô�����ĵ�ַ���浽imageSource����
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
            
            //ֱ�ӷ���
            data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
            //data.add(Article.ATT_ICON, iconPackageId);
            
            /********************************************/
            //����Ȩ��
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
            //��Ȩ��Ա
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
            //��Ȩ��֯
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
            //�����
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
            
            //������֯ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(Article.CREATE_DEPT_ID, createDeptId);
            
            //�ܼ���ʶ���۸�
            String seckey = data.getString(Article.ID)+"$"+data.getString(Article.SECURITY_LEVEL);
            data.add(Article.DATA_HASH, UtilHash.hashString(seckey));
            
            //��������
            Data data1 = handler.add(conn, data);
            
            /*---------------����ҳ�沿�� ��ʼ------------------*/
            String skipChannel = data.getString(Article.IS_SKIP);
            String skipChannelId = CmsConfigUtil.getValue(com.hx.cms.util.Constants.SKIP_CHANNEL_ID);
            //����Ҫѡ�е�����Ŀ
            if(Article.IS_SKIP_YES.equals(skipChannel)){
            	//����Ҫ�е�����Ŀ
                if(skipChannelId != null && !"".equals(skipChannelId)){
                	//��ǰ��Ŀ�����ǵ�����Ŀ�����������Ҫ�ڸ���
                	if(!skipChannelId.equals(channelId)){
                		//��ʼ����
                		Data copyData = new Data(data);
                		copyData.setEntityName(Article.ARTICLE_ENTITY);
                		copyData.setPrimaryKey(Article.ID);
                		copyData.add(Article.ID, UUIDGenerator.getUUID());
                		copyData.add(Article.CHANNEL_ID, skipChannelId);
                		handler.add(conn, copyData);
                	}
                }
            }
            /*---------------����ҳ�沿�� ����------------------*/
            
            //�ܼ���ʾ
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //��־
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_PUBLISH,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS���ͳ��
            ClickCountHelper.addPage(data.getString(Article.ID), data.getString(Article.TITLE), data.getString(Article.CHANNEL_ID), "");
            
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));

        // ��ת
        return "query";
    }
    
    /**
     * �ݴ棺״̬Ϊ�ݴ�
     * @return
     */
    public String addTemp() {
        // ��ȡ������
        Data data = fillData(true);
        
        //�ܼ� ����������λ"NULL"�ַ��������ݿ����ʾ����
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
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //����ID
            String articleId = UUIDGenerator.getUUID();
            data.add(Article.ID, articleId);
            
            //����ʱ��
            //Date date = new Date();
            //data.add(Article.CREATE_TIME, date);
            data.add(Article.MODIFY_TIME, data.getString(Article.CREATE_TIME));
            
            //������
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            UserInfo ui = SessionInfo.getCurUser();
            String personId = ui.getPerson().getPersonId();
            data.add(Article.CREATOR, personId);
            
            /*//��������������Ƿ���ͼƬ����У���ô�����ĵ�ַ���浽imageSource����
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
            
            
            
            //�ݴ�
            data.add(Article.STATUS, Article.STATUS_DRAFT);
            //data.add(Article.ATT_ICON, iconPackageId);
            
            /********************************************/
            //����Ȩ��
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
            //��Ȩ��Ա
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
            //��Ȩ��֯
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
            //�����
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
            
            //������֯ID
            Organ organ = user.getCurOrgan();
            String createDeptId = null;
            if(organ != null){
            	createDeptId = organ.getId();
            }
            data.add(Article.CREATE_DEPT_ID, createDeptId);
            
            //�ܼ���ʶ���۸�
            String seckey = data.getString(Article.ID)+"$"+data.getString(Article.SECURITY_LEVEL);
            data.add(Article.DATA_HASH, UtilHash.hashString(seckey));
            
            //��������
            Data data1 = handler.add(conn, data);
            //�ܼ���ʾ
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //��־
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_TEMP,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_3,"");
            
            //CMS���ͳ��
            ClickCountHelper.addPage(data.getString(Article.ID), data.getString(Article.TITLE), data.getString(Article.CHANNEL_ID), "");
            
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));

        // ��ת
        return "query";
    }
    
    /**
     * �޸���֯�ṹ
     * 
     * @return
     */
    public String modify() {
    	
        // ��ȡ������
        Data data = fillData(false);
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //�޸�ʱ��
            Date date = new Date();
            data.add(Article.MODIFY_TIME, date);
            
            //��������������Ƿ���ͼƬ����У���ô�����ĵ�ַ���浽imageSource����
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
            //����Ȩ��
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
            //ɾ��֮ǰ��Ȩ����
            Data delpersonRela = new Data();
            delpersonRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
            delpersonRela.setPrimaryKey("ARTICLE_ID");
            delpersonRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delpersonRela);
            //��Ȩ��Ա
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    //��Ȩ
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
            //ɾ��֮ǰ��Ȩ����
            Data delorganRela = new Data();
            delorganRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
            delorganRela.setPrimaryKey("ARTICLE_ID");
            delorganRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delorganRela);
            //��Ȩ��֯
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    //��Ȩ
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
          //ɾ��֮ǰ�����
            Data delauditPerson = new Data();
            delauditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
            delauditPerson.setPrimaryKey("ARTICLE_ID");
            delauditPerson.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delauditPerson);
          //�����
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
            //�ܼ���ʾ
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //��־
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_MODIFY,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS���ͳ��
            ClickCountHelper.updatePage(data.getString(Article.ID), data.getString(Article.TITLE), getParameter(Article.CHANNEL_ID), "");
            
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        // ��ת
        return "tempQuery";
    }
    
    /**
     * �޸���֯�ṹ
     * 
     * @return
     */
    public String modifyDirect() {
        
        // ��ȡ������
        Data data = fillData(false);
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
        Connection conn = null;
        DBTransaction db = null;
        try {
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            
            //�޸�ʱ��
            Date date = new Date();
            data.add(Article.MODIFY_TIME, date);
            
            //��������������Ƿ���ͼƬ����У���ô�����ĵ�ַ���浽imageSource����
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
            
          //ֱ�ӷ���
            data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
            
            /********************************************/
            //����Ȩ��
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
            //ɾ��֮ǰ��Ȩ����
            Data delpersonRela = new Data();
            delpersonRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
            delpersonRela.setPrimaryKey("ARTICLE_ID");
            delpersonRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delpersonRela);
            //��Ȩ��Ա
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    //��Ȩ
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
            //ɾ��֮ǰ��Ȩ����
            Data delorganRela = new Data();
            delorganRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
            delorganRela.setPrimaryKey("ARTICLE_ID");
            delorganRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delorganRela);
            //��Ȩ��֯
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    //��Ȩ
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
          //ɾ��֮ǰ�����
            Data delauditPerson = new Data();
            delauditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
            delauditPerson.setPrimaryKey("ARTICLE_ID");
            delauditPerson.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delauditPerson);
          //�����
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
            //�ܼ���ʾ
            int secLevel = data1.getInt(Article.SECURITY_LEVEL);
            String securityLevel = "";
            if(secLevel > 0){
            	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
            }
            
            //��־
            AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
			        "",
			        AuditConstants.ACT_MODIFY,
			        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
			        securityLevel+data1.getString(Article.TITLE,""),
			        AuditConstants.ACT_RESULT_OK,
			        AuditConstants.AUDIT_LEVEL_5,"");
            
            //CMS���ͳ��
            ClickCountHelper.updatePage(data.getString(Article.ID), data.getString(Article.TITLE), getParameter(Article.CHANNEL_ID), "");
            
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        // ��ת
        return "query";
    }

    /**
     * ����ɾ����Ŀ,��������IDS
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
            // ��������ɾ�����󼯺�
            conn = ConnectionManager.getConnection();
            // ����ɾ��
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                	
                	//�鿴�Ƿ�Ϊ�������ݣ�����Ǿ�ֻɾ�����ñ��е����ü�¼
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
                      //ɾ������
                        data1 = handler.findDataByKey(conn, data);
                        String packageId = data1.getString("PACKAGE_ID");
                        if(AttHelper.hasAttsByPackageId(packageId)){
                            AttHelper.delAttsOfPackageId(packageId, "CMS_ARTICLE_ATT");
                        }
                        
                        //ɾ������
                        /*Data artAtt = new Data();
                        artAtt.setEntityName(Article.ARTICLE_ATT_ENTITY);
                        artAtt.setPrimaryKey(Article.ARTICLE_ATT_ARTICLE_ID);
                        artAtt.add(Article.ARTICLE_ATT_ARTICLE_ID, ids[i]);
                        handler.delete(conn, artAtt);*/
                        
                        //ɾ���������б�
                        Data audit = new Data();
                        audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                        audit.setPrimaryKey(AuditOpinion.ARTICLE_ID);
                        audit.add(AuditOpinion.ARTICLE_ID, id);
                        handler.delete(conn, audit);
                        
                        //ɾ����������
                        Data reference = new Data();
                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                        reference.setPrimaryKey(Article2Channels.ARTICLE_ID);
                        reference.add(Article2Channels.ARTICLE_ID, id);
                        handler.delete(conn, reference);
                        
                        /*****************ɾ��������Ȩ ��ʼ**********************/
                        //��ԱȨ��
                        Data personRela = new Data();
                        personRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRela.setPrimaryKey("ARTICLE_ID");
                        personRela.add("ARTICLE_ID", id);
                        handler.delete(conn, personRela);
                        //��֯ȫ�°�
                        Data organRela = new Data();
                        organRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRela.setPrimaryKey("ARTICLE_ID");
                        organRela.add("ARTICLE_ID", id);
                        handler.delete(conn, organRela);
                        /******************ɾ��������Ȩ ����*********************/
                        /******************ɾ������� ��ʼ*********************/
                        Data auditPerson = new Data();
                        auditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPerson.setPrimaryKey("ARTICLE_ID");
                        auditPerson.add("ARTICLE_ID", id);
                        handler.delete(conn, auditPerson);
                        
                        /******************ɾ������� ����*********************/
                        
                        
                        //�ܼ���ʾ
                        secLevel = data1.getInt(Article.SECURITY_LEVEL);
                        if(secLevel > 0){
                        	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                        }
                        
                        //��־
                        AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
						        "",
						        AuditConstants.ACT_DELETE,
						        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
						        securityLevel+data1.getString(Article.TITLE,""),
						        AuditConstants.ACT_RESULT_OK,
						        AuditConstants.AUDIT_LEVEL_5,"");
                        // ����ɾ��
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "query";
    }
    
    /**
     * ��ʱҳ���е�ɾ������
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
            // ��������ɾ�����󼯺�
            conn = ConnectionManager.getConnection();
            // ����ɾ��
            db = DBTransaction.getInstance(conn);
            if (ids != null) {
                for (int i = 0; i < ids.length; i++) {
                    String articleId = ids[i].split(",")[0];
                    String channel = ids[i].split(",")[1];
                    
                	//�鿴�Ƿ�Ϊ�������ݣ�����Ǿ�ֻɾ�����ñ��е����ü�¼
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
                      //ɾ������
                        data1 = handler.findDataByKey(conn, data);
                        String packageId = data1.getString("PACKAGE_ID","");
                        if(AttHelper.hasAttsByPackageId(packageId)){
                            AttHelper.delAttsOfPackageId(packageId, "CMS_ARTICLE_ATT");
                        }
                        
                        
                        //ɾ������
                        /*Data artAtt = new Data();
                        artAtt.setEntityName(Article.ARTICLE_ATT_ENTITY);
                        artAtt.setPrimaryKey(Article.ARTICLE_ATT_ARTICLE_ID);
                        artAtt.add(Article.ARTICLE_ATT_ARTICLE_ID, articleId);
                        handler.delete(conn, artAtt);*/
                        
                        //ɾ���������б�
                        Data audit = new Data();
                        audit.setEntityName(AuditOpinion.AUDIT_OPINION_ENTITY);
                        audit.setPrimaryKey(AuditOpinion.ARTICLE_ID);
                        audit.add(AuditOpinion.ARTICLE_ID, articleId);
                        handler.delete(conn, audit);
                        
                        //ɾ����������
                        Data reference = new Data();
                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
                        reference.setPrimaryKey(Article2Channels.ARTICLE_ID);
                        reference.add(Article2Channels.ARTICLE_ID, articleId);
                        handler.delete(conn, reference);
                        
                        /*****************ɾ��������Ȩ ��ʼ**********************/
                        //��ԱȨ��
                        Data personRela = new Data();
                        personRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
                        personRela.setPrimaryKey("ARTICLE_ID");
                        personRela.add("ARTICLE_ID", articleId);
                        handler.delete(conn, personRela);
                        //��֯ȫ�°�
                        Data organRela = new Data();
                        organRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
                        organRela.setPrimaryKey("ARTICLE_ID");
                        organRela.add("ARTICLE_ID", articleId);
                        handler.delete(conn, organRela);
                        /******************ɾ��������Ȩ ����*********************/
                        /******************ɾ������� ��ʼ*********************/
                        Data auditPerson = new Data();
                        auditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
                        auditPerson.setPrimaryKey("ARTICLE_ID");
                        auditPerson.add("ARTICLE_ID", articleId);
                        handler.delete(conn, auditPerson);
                        
                        /******************ɾ������� ����*********************/
                        
                        
                        //�ܼ���ʾ
                        int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                        String securityLevel = "";
                        if(secLevel > 0){
                        	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                        }
                        
                        //��־
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
        setAttribute(Article.CHANNEL_ID, channelId);
        
        return "tempQuery";
    }
    
    /**
     * ȡ����������������
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
                    //�ܼ���ʾ
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //��־
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "query";
    }
    
    /**
     * ͨ�����
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
                    //������ͨ��ʱ��
                    Date date = new Date();
                    String createTime_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
                    data.add(Article.AUDIT_PASS_TIME, createTime_);
                    
                    Data data1 = new Data();
                    data1.setEntityName(Article.ARTICLE_ENTITY);
                    data1.setPrimaryKey(Article.ID);
                    data1.add(Article.ID, ids[i]);
                    data1 = handler.findDataByKey(conn, data1);
                    
                    handler.modify(conn, data);
                    
                    /*---------------����ҳ�沿�� ��ʼ------------------*/
                    String skipChannel = data1.getString(Article.IS_SKIP);
                    String skipChannelId = CmsConfigUtil.getValue(com.hx.cms.util.Constants.SKIP_CHANNEL_ID);
                    //����Ҫѡ�е�����Ŀ
                    if(Article.IS_SKIP_YES.equals(skipChannel)){
                    	//����Ҫ�е�����Ŀ
                        if(skipChannelId != null && !"".equals(skipChannelId)){
                        	//��ǰ��Ŀ�����ǵ�����Ŀ�����������Ҫ�ڸ���
                        	if(!skipChannelId.equals(data1.getString(Article.CHANNEL_ID))){
                        		//��ʼ����
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
                    /*---------------����ҳ�沿�� ����------------------*/
                    	
                    //�ܼ���ʾ
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //��־
                    AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					        "",
					        AuditConstants.ACT_PUBLISH,
					        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					        securityLevel+data1.getString(Article.TITLE,""),
					        AuditConstants.ACT_RESULT_OK,
					        AuditConstants.AUDIT_LEVEL_5,"");
                    
                    //�����Ϣ
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "auditQuery";
    }
    
    /**
     * �ݴ��е�ֱ�ӷ���
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
				
				//������ͨ��ʱ��
				Date date = new Date();
				String createTime_ = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
				data.add(Article.AUDIT_PASS_TIME, createTime_);
				
				Data data1 = new Data();
				data1.setEntityName(Article.ARTICLE_ENTITY);
				data1.setPrimaryKey(Article.ID);
				data1.add(Article.ID, id);
				data1 = handler.findDataByKey(conn, data1);
				
				/********************************************/
	            //����Ȩ��
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
	            //��Ȩ��Ա
	            if(personRela != null && !"".equals(personRela)){
	                String[] personRelas = personRela.split(",");
	                if(personRelas != null){
	                    //ɾ��֮ǰ��Ȩ����
	                    Data del = new Data();
	                    del.setEntityName("CMS_PERSON_ARTICLE_RELA");
	                    del.setPrimaryKey("ARTICLE_ID");
	                    del.add("ARTICLE_ID", data.getString(Article.ID));
	                    handler.delete(conn, del);
	                    //��Ȩ
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
	            //��Ȩ��֯
	            if(organRela != null && !"".equals(organRela)){
	                String[] organRelas = organRela.split(",");
	                if(organRelas != null){
	                    //ɾ��֮ǰ��Ȩ����
	                    Data del = new Data();
	                    del.setEntityName("CMS_ORGAN_ARTICLE_RELA");
	                    del.setPrimaryKey("ARTICLE_ID");
	                    del.add("ARTICLE_ID", data.getString(Article.ID));
	                    handler.delete(conn, del);
	                    //��Ȩ
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
				
				/*---------------����ҳ�沿�� ��ʼ------------------*/
				String skipChannel = data1.getString(Article.IS_SKIP);
				String skipChannelId = CmsConfigUtil.getValue(com.hx.cms.util.Constants.SKIP_CHANNEL_ID);
				//����Ҫѡ�е�����Ŀ
				if(Article.IS_SKIP_YES.equals(skipChannel)){
					//����Ҫ�е�����Ŀ
					if(skipChannelId != null && !"".equals(skipChannelId)){
						//��ǰ��Ŀ�����ǵ�����Ŀ�����������Ҫ�ڸ���
						if(!skipChannelId.equals(data1.getString(Article.CHANNEL_ID))){
							//��ʼ����
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
				/*---------------����ҳ�沿�� ����------------------*/
				
				//�ܼ���ʾ
				int secLevel = data1.getInt(Article.SECURITY_LEVEL);
				String securityLevel = "";
				if(secLevel > 0){
					securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
				}
				
				//��־
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
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	return "tempQuery";
    }
    
    /**
     * ������ˣ�����Ϊ�ݴ�״̬
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
                    
                    //�ܼ���ʾ
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //��־
                    AuditAppHelper.log(ClientIPGetter.getInstance().getClientIP(getRequest()),
					        "",
					        AuditConstants.ACT_BACK,
					        CmsAuthConstants.ACT_OBJ_TYPE_ARTICLE,
					        securityLevel+data1.getString(Article.TITLE,""),
					        AuditConstants.ACT_RESULT_OK,
					        AuditConstants.AUDIT_LEVEL_5,"");
                    
                    //�����Ϣ
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        return "auditQuery";
    }
    
    /**
     * �ύ���
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
                    //�ܼ���ʾ
                    int secLevel = data1.getInt(Article.SECURITY_LEVEL);
                    String securityLevel = "";
                    if(secLevel > 0){
                    	securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
                    }
                    
                    //��־
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
        
        return "tempQuery";
    }
    
    /**
     * �ύ���
     * @return
     */
    public String submitAuditSingle() {
    	
     // ��ȡ������
        Data data = fillData(false);
        
        String C = getParameter("myContent");
        data.add(Article.CONTENT, C);
    	
    	Connection conn = null;
    	DBTransaction db = null;
    	try {
    		conn = ConnectionManager.getConnection();
    		db = DBTransaction.getInstance(conn);
    		
    		//�޸�ʱ��
            Date date = new Date();
            data.add(Article.MODIFY_TIME, date);
    		
    		/********************************************/
            //����Ȩ��
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
            //ɾ��֮ǰ��Ȩ����
            Data delpersonRela = new Data();
            delpersonRela.setEntityName("CMS_PERSON_ARTICLE_RELA");
            delpersonRela.setPrimaryKey("ARTICLE_ID");
            delpersonRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delpersonRela);
            //��Ȩ��Ա
            if(personRela != null && !"".equals(personRela)){
                String[] personRelas = personRela.split(",");
                if(personRelas != null){
                    //��Ȩ
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
            //ɾ��֮ǰ��Ȩ����
            Data delorganRela = new Data();
            delorganRela.setEntityName("CMS_ORGAN_ARTICLE_RELA");
            delorganRela.setPrimaryKey("ARTICLE_ID");
            delorganRela.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delorganRela);
            //��Ȩ��֯
            if(organRela != null && !"".equals(organRela)){
                String[] organRelas = organRela.split(",");
                if(organRelas != null){
                    //��Ȩ
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
          //ɾ��֮ǰ�����
            Data delauditPerson = new Data();
            delauditPerson.setEntityName("CMS_AUDITPERSON_ARTICLE_RELA");
            delauditPerson.setPrimaryKey("ARTICLE_ID");
            delauditPerson.add("ARTICLE_ID", data.getString(Article.ID));
            handler.delete(conn, delauditPerson);
          //�����
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
			//�ܼ���ʾ
			int secLevel = data1.getInt(Article.SECURITY_LEVEL);
			String securityLevel = "";
			if(secLevel > 0){
				securityLevel = "["+UtilCode.getCodeName("SECURITY_LEVEL", ""+secLevel)+"]";
			}
			
			//��־
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
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	
    	return "tempQuery";
    }
    
    /**
     * ��ʾ����ͼ��
     * @return
     */
    public String displayAttIcon(){
        String packageId = getParameter("PACKAGE_ID");
        String code = getParameter("CODE"); //��������
        HttpServletResponse response = getResponse();
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            if(code != null && !"".equals(code)){
                //���ͼƬ
                getAttIcon(packageId, code, response, conn);
            }else{
                //���ͼƬ
                getAttIconNoCode(packageId, response);
            }
        } catch (Exception e) {
            log.logError("��ʾ����ͼ��ʱ����!");
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ʾ����ͼ��ʱ�ر�Connection����!", e);
            }
        }
        return null;
    }
    
    /**
     * Ajax��ȡ����ҳ��ĸ������������Ⱥ�˳��
     * @return
     */
    public String ajaxSkipList(){
    	
    	String orderString = "IS_TOP DESC, SEQ_NUM ASC, CREATE_TIME DESC";

    	//������ĿID
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
                //���ͨ��������
                data.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
                //��ѯ
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
     * Ajax��ȡ�������ݵ���ϸ��Ϣ
     * @return
     */
    public String ajaxSkipDesc(){

    	//����ҳ������ID
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
                //���ͨ��������
            	data2.add(Article.STATUS, Article.STATUS_PASS_AUDIT);
                //��ѯ
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
     * �����ҵ���渽����weboffice��ʾ
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
            //�������ļ���׺
            setAttribute("SUFFIX", type);
            setAttribute("name", name);
        } catch (Exception e) {
            log.logError("תȥ��ʾ���ݸ���ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ��ʾ���ݸ���ʱ�ر�Connection����!", e);
            }
        }
        //����
        return "detail";
    }
    
    /**
     * ת�� --> ���Ѵ��ڵ���Ŀ�µ��������õ�������Ŀ:��ɫ��֤
     * @return
     */
    /*public String toReferenceArticle(){
    	Connection conn = null;
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //��ѯ
            UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            List<Role> roles = RoleHelper.getRolesToPerson(personId);
            if(roles != null && roles.size() > 0){
            	dataList = channelHandler.findChannelsOfRole(conn,roles);
            }
            
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
        setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	setAttribute(Article2Channels.IDS, getParameter(Article2Channels.IDS));
        // ������֯��
        setAttribute("dataList", dataList);
        return "toReferenceArticle";
    }*/
    
    /**
     * ת�� --> ���Ѵ��ڵ���Ŀ�µ��������õ�������Ŀ:��Ա��֤
     * @return
     */
    public String toReferenceArticle(){
    	Connection conn = null;
    	CodeList dataList = new CodeList();
    	try {
    		conn = ConnectionManager.getConnection();
    		//��ѯ
    		UserInfo user = (UserInfo)getRequest().getSession().getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
    		String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
    		dataList = channelHandler.findChannelsOfPerson(conn, personId, PersonChannelRela.ROLE_STATUS_WRITER);
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
    	setAttribute(Article.CHANNEL_ID, getParameter(Article.CHANNEL_ID));
    	setAttribute(Article2Channels.IDS, getParameter(Article2Channels.IDS));
    	// ������֯��
    	setAttribute("dataList", dataList);
    	return "toReferenceArticle";
    }
    
    /**
     * ���Ѵ��ڵ���Ŀ�µ��������õ�������Ŀ
     * 
     * @return
     */
    public String referenceArticle() {
        
        Connection conn = null;
        DBTransaction db = null;
        //��ȡ����
        String currentChannelId = getParameter(Article.CHANNEL_ID);
        String targetChannels = getParameter("CHANNELS");//����Ŀ����Ŀ
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
            // ����
            conn = ConnectionManager.getConnection();
            db = DBTransaction.getInstance(conn);
            //�����Ŀ
            if(channelIds != null){
            	for (int k = 0; k < channelIds.length; k++) {
            	    //�ָ���������V��ID(��������ID����������ID),store(���棬����),channel(ԭ����)
            	    
					String targetChannel = channelIds[k];//����Ŀ����Ŀ
					
					//Ӧ�õ�����Ŀ���ܺ�����ԭʼ������Ŀ�ظ�
					/*if(targetChannel.equals(currentChannelId)){
						continue;
					}*/
					
					if(ids != null){
					    for (int i = 0; i < ids.length; i++) {
					        //�ָ���������V��ID(��������ID����������ID),store(���棬����),channel(ԭ����)
					        String id = ids[i].split(",")[0];
					        String store = ids[i].split(",")[1];
		                    if("REFERENCE".equals(store)){//���������Ϊ�������ݣ����ԭ����ID
		                        Data reference = new Data();
		                        reference.setEntityName(Article2Channels.ARTICLE_2_CHANNELS_ENTITY);
		                        reference.setPrimaryKey(Article2Channels.ID);
		                        reference.add(Article2Channels.ID, id);
		                        Data ref = handler.findDataByKey(conn, reference);
		                        id = ref.getString("ARTICLE_ID");
		                    }
		                    DataList dl = handler.getChannelIdsOfArticle(conn,id);//ԭ�������е�channel
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
		                  //Ӧ�õ�����Ŀ���ܺ�����ԭʼ������Ŀ�ظ�
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
		            
		            //�������
		        	if(ids != null){
		            	for (int i = 0; i < ids.length; i++) {
		            		//��ǰ
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
            // �ύ
            db.commit();
        } catch (Exception e) {
            try {
                db.rollback();
            } catch (SQLException e1) {
                log.logError("�������ݵ�������Ŀʱ����!", e);
            }
            log.logError("�������ݵ�������Ŀʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("�������ݵ�������Ŀʱ����!", e);
            }
        }
        //��֯����ID
        setAttribute(Article.CHANNEL_ID, currentChannelId);
        // ��ת
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
                // ���� ������
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ�ܣ�");
            setAttribute("clueTo", clueTo);
        } finally {
            try {
                // ���� ���Ĳ�
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
        data.setEntityName(Article.ARTICLE_ENTITY);
        data.setPrimaryKey(Article.ID);

        // �õ����� ��֯�ṹ���� ����ǰ׺�ļ�ֵ����
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
     * û��CODEʱ��ȡ����ͼ��
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
                //����Ǵ������ʹӴ�������
                if(att.getFileSystemPath() != null && !"".equals(att.getFileSystemPath())){
                    File file = new File(att.getFileSystemPath(),att.getRandomName());
                    if(!file.exists()){
                        in = new BufferedInputStream(Article.class.getClassLoader().getResourceAsStream(Article.DEFAULT_ATT_ICON_NAME));
                    }else{
                        in = new BufferedInputStream(new FileInputStream(file));
                    }
                }else{
                    //��װ
                    in = new BufferedInputStream((InputStream) att.getAttContent());
                }
                //����
                response.reset();
                response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
                response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(att.getAttName(), getRequest().getCharacterEncoding()));
                out = response.getOutputStream();
                //��д
                byte[] b = new byte[1024];
                while(in.read(b) != -1){
                    out.write(b);
                    //����
                    b = new byte[1024];
                }
                //�ر�
                out.flush();
                in.close();
                out.close();
            }
        }else{
            //û���ϴ�ͼƬ����
            in = new BufferedInputStream(Article.class.getClassLoader().getResourceAsStream(Article.DEFAULT_ATT_ICON_NAME));
            //����
            response.reset();
            response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
            response.setHeader("Content-Disposition", "attachment;filename=default_icon");
            out = response.getOutputStream();
            //��д
            byte[] b = new byte[1024];
            while(in.read(b) != -1){
                out.write(b);
                //����
                b = new byte[1024];
            }
            //�ر�
            out.flush();
            in.close();
            out.close();
        }
    }

    /**
     * ��CODEʱ��ȡ����ͼ��
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
        //���Ҹ�������
        AttType attType = AttHelper.findAttTypeVo(code);
        OutputStream out;
        BufferedInputStream in;
        ResultSet rs;
        PreparedStatement pstm;
        if(packageId != null && !"".equals(packageId)){
            List<Att> dataList = AttHelper.findAttListByPackageId(packageId,code);
            if(dataList != null && dataList.size() > 0){
                Att data = dataList.get(0);
                //����Ǵ������ʹӴ�������
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
                //����
                response.reset();
                response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
                response.setHeader("Content-Disposition", "attachment;filename="+URLEncoder.encode(data.getAttName(), getRequest().getCharacterEncoding()));
                out = response.getOutputStream();
                //��д
                byte[] b = new byte[1024];
                while(in.read(b) != -1){
                    out.write(b);
                    //����
                    b = new byte[1024];
                }
                //�ر�
                out.flush();
                in.close();
                out.close();
            }
        }else{
            //û���ϴ�ͼƬ����
            in = new BufferedInputStream(Article.class.getClassLoader().getResourceAsStream(Article.DEFAULT_ATT_ICON_NAME));
            //����
            response.reset();
            response.setContentType("application/x-download;charset="+getRequest().getCharacterEncoding());
            response.setHeader("Content-Disposition", "attachment;filename=default_icon");
            out = response.getOutputStream();
            //��д
            byte[] b = new byte[1024];
            while(in.read(b) != -1){
                out.write(b);
                //����
                b = new byte[1024];
            }
            //�ر�
            out.flush();
            in.close();
            out.close();
        }
    }
}
