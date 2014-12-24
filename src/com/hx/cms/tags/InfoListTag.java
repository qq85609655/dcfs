package com.hx.cms.tags;

import hx.code.Code;
import hx.code.CodeList;
import hx.database.databean.Data;
import hx.database.databean.DataList;

import java.sql.Connection;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.tags.handler.CmsTagHandler;
import com.hx.cms.util.CmsConfigUtil;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.role.vo.Role;
import com.hx.framework.sdk.PersonHelper;
import com.hx.framework.sdk.RoleHelper;

/**
 * 
 * @Title: InfoListTag.java
 * @Description: Ƶ���б��ǩ<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 14, 2011 5:15:49 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoListTag extends TagSupport {
    
    /**
     * Ƶ��ID����
     */
    public static final String CHANNEL_ID = "CHANNEL_ID";
    
    /**
     * ��ȡҳ���ַ�Ĳ�����
     */
    public static final String PAGINATION_PAGE = "PAGINATION_PAGE";

    /**
     * ���л�
     */
    private static final long serialVersionUID = 7088717549575957136L;

    /**
     * Ƶ��ID��
     */
    private String channelId;
    
    /**
     * ��ʾǰ��������
     */
    private int length = 0;

    /**
     * �����ֶ�
     */
    private String orderName;

    /**
     * ����ʽ��
     *      ���� ����
     */
    private String orderType;

    /**
     * ָ���������������ڴ�pageContext�л�ȡ��ǰѭ������Data����
     */
    private String forData;

    /**
     * �б�����
     *      page : ���з�ҳ��Ϣ��ʾƵ���µ������б�
     *      simple : ��ʾ����������б����Ҳ�����ҳ��������lengthָ����ʾ�б��¼��
     *      picture : ����ͼ����ʽ��ʾ�����б�
     */
    private String type = "";
    
    /**
     * �Ƿ���֤��ǰ�û�ӵ�еĽ�ɫ�Ƿ�ӵ����ĿȨ��
     */
    boolean channelAuth = false;
    
    /**
     * �Ƿ���Ҫʵʱ����ORDER_SEQ_NUM�ֶ�
     */
    boolean updateChannelId = false;

    /*-------------------------------�±���������ע�ᵽtld--------------------------------*/

	/**
     * ��ǰ��������Data����
     */
    private Data data = null;

    /**
     * �б���DataList
     */
    private DataList dataList = null;

    /**
     * ��ǰ������������ֵ
     */
    private int i = 0;

    /**
     * ��ǰҳ
     */
    private int page = 1;

    /**
     * ��ǰҳ��ʾ��С
     */
    private int pageSize = 20;

    /**
     * ��ʼ������
     */
    private void initDataList(Connection conn) {

        DataList initDataList = new DataList();
        //�ܼ���ȡ
        HttpSession session = pageContext.getSession();
        UserInfo user = (UserInfo)session.getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        
        int secLevel = 0;
        
        //�Ƿ���Ҫ��ȡ��ǰ�û� true����Ҫ��ȡ
        String isLoginConfig = CmsConfigUtil.getValue(com.hx.cms.util.Constants.IS_LOGIN);
    	boolean isLogin = false;
    	if(isLoginConfig != null && !"".equalsIgnoreCase(isLoginConfig)){
    		isLogin = Boolean.parseBoolean(isLoginConfig);
    	}
    	if(isLogin){
    		//�ܼ���ȡ
            String secid=user.getPerson().getSecretLevel();
            if(secid != null && !"".equals(secid)){
            	secLevel = Integer.parseInt(secid);
            }
    	}
        
        try {
        	String dataAccessPermission = CmsConfigUtil.getValue(com.hx.cms.util.Constants.DATA_ACCESS_PERMISSION);
        	boolean dataAccess = false;
        	if(dataAccessPermission != null && !"".equalsIgnoreCase(dataAccessPermission)){
        	    dataAccess = Boolean.parseBoolean(dataAccessPermission);
        	}
            //��ѯchannelId
            if (channelId != null) {
            	if(channelAuth){
            		//��ȡ��ǰ��¼��ӵ�еĽ�ɫ����
                    String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
                    String organId = PersonHelper.getOrganOfPerson(personId).getId();
                    java.util.List<Role> roles = RoleHelper.getRolesToPerson(personId);
            		//��ȡ���е�ǰ��Աӵ�н�ɫ��ӵ�е�������Ŀ���������ظ�
                    if(roles != null && roles.size() > 0){
                    	CodeList codeList = new CmsTagHandler().findChannelsOfRole(conn, roles);
                    	if(codeList != null && codeList.size() > 0){
                    		//��Ȩ
                        	boolean isRight = false;
                    		for (int i = 0; i < codeList.size(); i++) {
        						Code code = codeList.get(i);
        						if(channelId.equals(code.getValue())){
        							isRight = true;
        							break;
        						}
        					}
                    		if(isRight){
                    		    //�������ݷ���Ȩ�ޣ������Ҫ���飬���������Ȩ��У��
                    		    if(dataAccess){
                    		        //��������Ȩ��У��
                                    initDataList = CmsTagHandler.findArticleOfChannelForDataAccess(conn,
                                            channelId, orderName, orderType,
                                            (length == 0 ? Integer.MAX_VALUE : length), getPage(),
                                            getPageSize(), type, secLevel, personId, organId, updateChannelId);
                    		    }else{
                    		        //��Ȩ���ʣ��������
                                    initDataList = CmsTagHandler.findArticleOfChannel(conn,
                                            channelId, orderName, orderType,
                                            (length == 0 ? Integer.MAX_VALUE : length), getPage(),
                                            getPageSize(), type, secLevel,updateChannelId);
                    		    }
                            }
                    	}
                    }
            	}else{
            	    //�������ݷ���Ȩ�ޣ������Ҫ���飬���������Ȩ��У��
            	    if(dataAccess){
            	    	//��ȡ��ǰ��¼��ӵ�еĽ�ɫ����
                        String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
                        String organId = PersonHelper.getOrganOfPerson(personId).getId();
            	        //��������Ȩ��У��
            	        initDataList = CmsTagHandler.findArticleOfChannelForDataAccess(conn,
                                channelId, orderName, orderType,
                                (length == 0 ? Integer.MAX_VALUE : length), getPage(),
                                getPageSize(), type, secLevel, personId, organId,updateChannelId);
            	    }else{
            	        initDataList = CmsTagHandler.findArticleOfChannel(conn,
                                channelId, orderName, orderType,
                                (length == 0 ? Integer.MAX_VALUE : length), getPage(),
                                getPageSize(), type, secLevel,updateChannelId);
            	    }
            	}
            }else{
                if(dataList != null && dataList.size() > 0){
                    initDataList = dataList;
                }
            }
                
            //���÷�ҳ��Ϣ
            if ("page".equals(type)) {
                page = initDataList.getNowPage();
                pageSize = initDataList.getPageSize();
            }
            //�������ݼ���
            setDataList(initDataList);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * ��ǩ��ʼ
     */
    @Override
    public int doStartTag() throws JspException {
        //���÷�ҳ
        setPageSize(getPageSize());

        //��ȡHTML��ǩ�е�Connection
        Tag tag = getParent();
        Connection conn = null;
        
        //����Ƿ�ҳ����ô<infoList>���ϲ�Ϊ<cms:form>�����ϲ����<cms:html>
        if("page".equals(type)){
            tag = tag.getParent();
        }
        
        //ѭ��20��
        Tag htmlTag_ = getHtmlTag(tag, 1, 20);
        if(htmlTag_ != null){
        	if(htmlTag_ instanceof HtmlTag){
        		 HtmlTag htmlTag = (HtmlTag) htmlTag_;
                 conn = htmlTag.getConn();
        	}else{
        		throw new RuntimeException("ҳ��ȱ��CMS��ǩ<cms:html> , ����......");
        	}
        }else{
        	throw new RuntimeException("ҳ��ȱ��CMS��ǩ<cms:html> , ����......");
        }

        //��ʼ������
        initDataList(conn);

        //����length�Ƿ�Ϊ0,���ڵ�dataList�Ѿ�ȷ����ֵ
        if (dataList != null && dataList.size() > 0) {
            int size = dataList.size();
            if (size > i) {
                //ȡ����ǰѭ������Ԫ��
                data = dataList.getData(i);
                //��ֵ
                setData(data);
                i++;
            }
        } else {
            return SKIP_BODY;
        }

        return EVAL_BODY_INCLUDE;
    }

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doAfterBody()
     * ��ǩ�������
     */
    @Override
    public int doAfterBody() throws JspException {
        int size = dataList.size();
        if (size > i) {
            data = dataList.getData(i);
            setData(data);
            i++;
            //ѭ��
            return EVAL_BODY_AGAIN;
        }
        return EVAL_PAGE;
    }

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doEndTag()
     * ��ǩ����
     */
    @Override
    public int doEndTag() throws JspException {
        //ѭ������,ִ�����ݳ�ʼ��
        length = 0;
        data = null;
        dataList = null;
        page = 1;
        i = 0;
        //�Ƴ�pageContext�е�forData��Ӧ��Data����
        if (forData != null && !"".equals(forData)) {
            pageContext.removeAttribute(forData);
        }
        return EVAL_PAGE;
    }
    
    /**
     * ��ȡHtmlTag��ǩ
     * @param tag ��ǩ
     * @param i �����������ô�����1��Ȼ�������һ�����ӣ����ӵ�count��ʱ�Ͳ��ڵݹ飬��ֱ�ӷ���null
     * @param count ѭ������
     * @return
     */
	private Tag getHtmlTag(Tag tag,int i,int count) {
		if(tag instanceof HtmlTag){
			return tag;
		}else{
			if(i == count){
				return null;
			}else{
				return getHtmlTag(tag.getParent(),++i,count);
			}
		}
	}

    /**
     * @return Returns the channelId.
     */
    public String getChannelId() {
        return channelId;
    }

    /**
     * @param channelId The channelId to set.
     */
    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    /**
     * @return Returns the length.
     */
    public int getLength() {
        return length;
    }

    /**
     * @param length The length to set.
     */
    public void setLength(int length) {
        this.length = length;
    }

    /**
     * @return Returns the orderName.
     */
    public String getOrderName() {
        return orderName;
    }

    /**
     * @param orderName The orderName to set.
     */
    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    /**
     * @return Returns the orderType.
     */
    public String getOrderType() {
        return orderType;
    }

    /**
     * @param orderType The orderType to set.
     */
    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    /**
     * @return Returns the data.
     */
    public Data getData() {
        return data;
    }

    /**
     * @param data The data to set.
     */
    public void setData(Data data) {
        this.data = data;
        //���浱ǰ��Data��forData����
        if (forData != null && !"".equals(forData)) {
            data.add("i", this.i);
            pageContext.setAttribute(forData, data);
        }
    }

    /**
     * @return Returns the dataList.
     */
    public DataList getDataList() {
        return dataList;
    }

    /**
     * @param dataList The dataList to set.
     */
    public void setDataList(DataList dataList) {
        this.dataList = dataList;
    }

    /**
     * @return Returns the i.
     */
    public int getI() {
        return i;
    }

    /**
     * @param i The i to set.
     */
    public void setI(int i) {
        this.i = i;
    }

    /**
     * @return Returns the forData.
     */
    public String getForData() {
        return forData;
    }

    /**
     * @param forData The forData to set.
     */
    public void setForData(String forData) {
        this.forData = forData;
    }

    /**
     * @return Returns the type.
     */
    public String getType() {
        return type;
    }

    /**
     * @param type The type to set.
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return Returns the page.
     */
    public int getPage() {
        if("page".equals(type)){
            String formId = null;
            Tag tag = getParent();
            if (tag instanceof FormTag) {
                FormTag formTag = (FormTag) tag;
                formId = formTag.getId();
            } else {
                throw new RuntimeException("ҳ��ȱ��CMS��ǩ<cms:form> , ����......");
            }
            String reqFormId = (String) pageContext.findAttribute("formId");
            if(formId.equals(reqFormId)){
                String curPage = (String) pageContext.findAttribute(formId+"_page");
                if(curPage != null && !"".equals(curPage)){
                    page = Integer.parseInt(curPage);
                }
            }
        }
        return page;
    }
    
    /**
     * @return Returns the pageSize.
     */
    public int getPageSize() {
        return pageSize;
    }

    /**
     * @param pageSize The pageSize to set.
     */
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

	public boolean isChannelAuth() {
		return channelAuth;
	}

	public void setChannelAuth(boolean channelAuth) {
		this.channelAuth = channelAuth;
	}
	
	public boolean isUpdateChannelId() {
		return updateChannelId;
	}

	public void setUpdateChannelId(boolean updateChannelId) {
		this.updateChannelId = updateChannelId;
	}
}
