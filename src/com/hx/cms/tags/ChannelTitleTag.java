package com.hx.cms.tags;

import hx.code.Code;
import hx.code.CodeList;
import hx.database.databean.Data;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.channel.vo.Channel;
import com.hx.cms.tags.handler.CmsTagHandler;
import com.hx.cms.util.CmsConfigUtil;
import com.hx.cms.util.CmsStringUtils;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.role.vo.Role;
import com.hx.framework.sdk.RoleHelper;

/**
 * 
 * @Title: ChannelTitleTag.java
 * @Description: Ƶ�������ǩ<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:11:03 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelTitleTag extends TagSupport {
    
    /**
     * 
     */
    private static final long serialVersionUID = 3712000293349201014L;

    /**
     * ���ⳤ��,��������ʾ��"..."
     */
    private int titleLength = 0;
    
    /**
     * �����Ƿ��������
     *      linkҪ��hrefͬʱʹ��
     */
    private boolean link = false;
    
    /**
     * �������ӵ���target
     */
    private String target = "_blank";
    
    /**
     * ���ⳬ����
     *      linkҪ��hrefͬʱʹ��
     */
    private String href = "";
    
    /**
     * �����ӱ���
     */
    private String hrefTitle = "";
    
    /**
     * �����Ӵ��ݵĲ�����
     *      ʹ��;�ŷָ�
     */
    private String params = "";
    
    /**
     * �����Ӵ��ݵĲ�������Ӧ��ֵ
     *      ʹ��;�ŷָ�
     */
    private String paramValues = "";
    
    /**
     * �ڶ������ݱ���
     */
    private boolean twoCols = false;
    
    /**
     * <A>��ǩ���¼�
     */
    private String onclick = "";
    
    /**
     * �Ƿ���ʾ��ǰ��Ŀ���ж��������ݵ���Ϣ
     */
    private boolean total = false;
    
    /**
     * �Ƿ���ݵ�ǰ��Ŀ����ʽ�����ⲿ���ӽ������⴦�������ⲿ���Ӻ�Ŀ��
     */
    private boolean runChannelStyle = false;
    
    private Data data = null;

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * ��ʼ��ǩ
     */
    @Override
    public int doStartTag() throws JspException {
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
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
        
        Tag tag = getParent();
        //�������
        String html = "";
        String count = "( ";
        
        try {
            if(tag instanceof ChannelListTag){
                ChannelListTag channelListTag = (ChannelListTag) tag;
                //�Ƿ�У�鵱ǰ��Ŀ�Ĳ鿴Ȩ��
                boolean channelAuth = channelListTag.isChannelAuth();
                //�õ���ǰѭ������DataԪ��
                if(twoCols){
                    data = channelListTag.getSecondData();
                    
                }else{
                    data = channelListTag.getData();
                }
                
                //����
                String title = "";
                if(data != null){
                    title = titleLength>0?CmsStringUtils.subString(data.getString(Channel.NAME), titleLength, "..."):data.getString(Channel.NAME);
                    
                    //ȡ������
                    /*Tag htmlTag_ = .getParent()getParent();
                    Connection conn = null;
                    if (htmlTag_ instanceof HtmlTag) {
                        HtmlTag htmlTag = (HtmlTag) htmlTag_;
                        conn = htmlTag.getConn();
                    }*/
                    
                    //ѭ��20��
                    Tag htmlTag_ = getHtmlTag(tag, 1, 20);
                    Connection conn = null;
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
                    
                    //ͳ����Ŀ��������
                    if(total){
                        if (conn != null) {
                            int total = CmsTagHandler.statChannel(conn,data,secLevel);
                            count += total;
                        } 
                    }
                    count +=" )";
                    //��ͳ��
                    if(total){
                        title += count;
                    }
                    
                    //�Ƿ�ӳ�����linkҪ��hrefͬʱʹ��
                    if(link){
                    	
                    	/****************�������� ��ʼ*************/
                    	//����֤
                		StringBuffer paramStr = new StringBuffer();
                        if(params != null && !"".equals(params)){
                            String[] paramsArr = params.split(";"); //����
                            String[] valuesArr = paramValues.split(";"); //ֵ���Ͳ���һһ��Ӧ
                            for (int i = 0; i < paramsArr.length; i++) {
                                paramStr.append("&").append(paramsArr[i]).append("=").append(valuesArr[i]);
                            }
                        }
                        String hreTitle = hrefTitle!=null&&!"".equals(hrefTitle)?hrefTitle:data.getString(Channel.NAME);
                        /****************�������� ����*************/
                    	
                    	//�Ƿ�У����Ŀ�鿴Ȩ��
                    	if(channelAuth){
                    		//��ȡ��ǰ��¼��ӵ�еĽ�ɫ����
                            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
                            java.util.List<Role> roles = RoleHelper.getRolesToPerson(personId);
                    		
                    		//��ȡ���е�ǰ��Աӵ�н�ɫ��ӵ�е�������Ŀ���������ظ�
                    		CodeList codeList = new CodeList();
                    		//��Ȩ
                        	boolean isRight = false;
                            if(roles != null && roles.size() > 0){
                            	if(conn != null){
                            		codeList = new CmsTagHandler().findChannelsOfRole(conn,roles);
                            	}
                            	 //��ǰ��ĿID
                                String channelId = data.getString(Channel.ID);
                                if(codeList != null && codeList.size() > 0){
                                	for (int i = 0; i < codeList.size(); i++) {
    									Code code = codeList.get(i);
    									if(channelId.equals(code.getValue())){
    										isRight = true;
    										break;
    									}
    								}
                                }
                            }
                            if(isRight){
                            	//��Ȩ���ʣ��������
                            	title = getTitle(request, title, paramStr, hreTitle);
                            }else{
                            	//��Ȩ���ʣ������ʾ��Ȩ����Ϣ
                            	title = "<a title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\"javaScript:alert('��Ȩ���ʡ�"+hreTitle+"��Ŀ��');\">" + title + "</a>";
                            }
                    	}else{
                            title = getTitle(request, title, paramStr, hreTitle);
                    	}
                    }
                }
                
                html = title;
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    /**
     * ��ȡ���ܱ���
     * @param request
     * @param title
     * @param paramStr
     * @param hreTitle
     * @return
     */
	private String getTitle(HttpServletRequest request, String title,
			StringBuffer paramStr, String hreTitle) {
		//�Զ�����ID����,�ж����ڲ����ⲿ����
		if(!runChannelStyle){
			//����������
		    title = "<a onclick=\""+onclick+"\" title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Channel.ID)+paramStr.toString()+"\" target=\""+target+"\">" + title + "</a>";
		}else{
			//��������
			String channelStyle = data.getString(Channel.CHANNEL_STYLE); //��Ŀ��ʽ
			if(Channel.CHANNEL_STYLE_STATUS_OUTLINK.equals(channelStyle)){
				//�ⲿ����
				String urlLink = data.getString(Channel.URL_LINK); //�ⲿ����
				String linkTarget = data.getString(Channel.LINK_TARGET); //�ⲿ����Ŀ��
				String urlLinkType = data.getString(Channel.URL_LINK_TYPE); //�ⲿ��������
				
				//ϵͳ�ڲ���ת
				if(Channel.URL_LINK_TYPE_STATUS_INNER.equals(urlLinkType)){
					title = "<a channelStyle=\""+channelStyle+"\" linkTarget=\""+linkTarget+"\" linkHref=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Channel.ID)+paramStr.toString()+"\" onclick=\""+onclick+"\" title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\""+request.getContextPath() + "/" + urlLink+"\" target=\""+linkTarget+"\">" + title + "</a>";
				}
				
				//ϵͳ�ⲿ��ת
				if(Channel.URL_LINK_TYPE_STATUS_OUTER.equals(urlLinkType)){
					title = "<a channelStyle=\""+channelStyle+"\" linkTarget=\""+linkTarget+"\" linkHref=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Channel.ID)+paramStr.toString()+"\" onclick=\""+onclick+"\" title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\""+urlLink+"\" target=\""+linkTarget+"\">" + title + "</a>";
				}
			}else{
				//���ⲿ����
				title = "<a channelStyle=\""+channelStyle+"\" onclick=\""+onclick+"\" title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Channel.ID)+paramStr.toString()+"\" target=\""+target+"\">" + title + "</a>";
			}
		}
		return title;
	}
    
    @Override
    public int doEndTag() throws JspException {
        twoCols = false;
        data = null;
        total = false;
        runChannelStyle = false;
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
     * @return Returns the titleLength.
     */
    public int getTitleLength() {
        return titleLength;
    }

    /**
     * @param titleLength The titleLength to set.
     */
    public void setTitleLength(int titleLength) {
        this.titleLength = titleLength;
    }

    /**
     * @return Returns the link.
     */
    public boolean isLink() {
        return link;
    }

    /**
     * @param link The link to set.
     */
    public void setLink(boolean link) {
        this.link = link;
    }

    /**
     * @return Returns the target.
     */
    public String getTarget() {
        return target;
    }

    /**
     * @param target The target to set.
     */
    public void setTarget(String target) {
        this.target = target;
    }

    /**
     * @return Returns the href.
     */
    public String getHref() {
        return href;
    }

    /**
     * @param href The href to set.
     */
    public void setHref(String href) {
        this.href = href;
    }

    /**
     * @return Returns the hrefTitle.
     */
    public String getHrefTitle() {
        return hrefTitle;
    }

    /**
     * @param hrefTitle The hrefTitle to set.
     */
    public void setHrefTitle(String hrefTitle) {
        this.hrefTitle = hrefTitle;
    }

    /**
     * @return Returns the params.
     */
    public String getParams() {
        return params;
    }

    /**
     * @param params The params to set.
     */
    public void setParams(String params) {
        this.params = params;
    }

    /**
     * @return Returns the paramValues.
     */
    public String getParamValues() {
        return paramValues;
    }

    /**
     * @param paramValues The paramValues to set.
     */
    public void setParamValues(String paramValues) {
        this.paramValues = paramValues;
    }

    /**
     * @return Returns the twoCols.
     */
    public boolean isTwoCols() {
        return twoCols;
    }

    /**
     * @param twoCols The twoCols to set.
     */
    public void setTwoCols(boolean twoCols) {
        this.twoCols = twoCols;
    }

    /**
     * @return Returns the total.
     */
    public boolean isTotal() {
        return total;
    }

    /**
     * @param total The total to set.
     */
    public void setTotal(boolean total) {
        this.total = total;
    }

    /**
     * @return Returns the onclick.
     */
    public String getOnclick() {
        return onclick;
    }

    /**
     * @param onclick The onclick to set.
     */
    public void setOnclick(String onclick) {
        this.onclick = onclick;
    }

	public boolean isRunChannelStyle() {
		return runChannelStyle;
	}

	public void setRunChannelStyle(boolean runChannelStyle) {
		this.runChannelStyle = runChannelStyle;
	}
}
