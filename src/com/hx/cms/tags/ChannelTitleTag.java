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
 * @Description: 频道标题标签<br>
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
     * 标题长度,过长的显示成"..."
     */
    private int titleLength = 0;
    
    /**
     * 标题是否带超链接
     *      link要和href同时使用
     */
    private boolean link = false;
    
    /**
     * 标题连接弹出target
     */
    private String target = "_blank";
    
    /**
     * 标题超连接
     *      link要和href同时使用
     */
    private String href = "";
    
    /**
     * 超链接标题
     */
    private String hrefTitle = "";
    
    /**
     * 超链接传递的参数名
     *      使用;号分隔
     */
    private String params = "";
    
    /**
     * 超链接传递的参数名对应的值
     *      使用;号分隔
     */
    private String paramValues = "";
    
    /**
     * 第二列数据标题
     */
    private boolean twoCols = false;
    
    /**
     * <A>标签的事件
     */
    private String onclick = "";
    
    /**
     * 是否显示当前栏目下有多少条内容的信息
     */
    private boolean total = false;
    
    /**
     * 是否根据当前栏目的样式，对外部链接进行特殊处理，包括外部链接和目标
     */
    private boolean runChannelStyle = false;
    
    private Data data = null;

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 开始标签
     */
    @Override
    public int doStartTag() throws JspException {
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
        HttpSession session = pageContext.getSession();
        UserInfo user = (UserInfo)session.getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);

        int secLevel = 0;
        
        //是否需要获取当前用户 true就是要获取
        String isLoginConfig = CmsConfigUtil.getValue(com.hx.cms.util.Constants.IS_LOGIN);
    	boolean isLogin = false;
    	if(isLoginConfig != null && !"".equalsIgnoreCase(isLoginConfig)){
    		isLogin = Boolean.parseBoolean(isLoginConfig);
    	}
    	if(isLogin){
    		//密级获取
            String secid=user.getPerson().getSecretLevel();
            if(secid != null && !"".equals(secid)){
            	secLevel = Integer.parseInt(secid);
            }
    	}
        
        Tag tag = getParent();
        //输出内容
        String html = "";
        String count = "( ";
        
        try {
            if(tag instanceof ChannelListTag){
                ChannelListTag channelListTag = (ChannelListTag) tag;
                //是否校验当前栏目的查看权限
                boolean channelAuth = channelListTag.isChannelAuth();
                //得到当前循环到的Data元素
                if(twoCols){
                    data = channelListTag.getSecondData();
                    
                }else{
                    data = channelListTag.getData();
                }
                
                //标题
                String title = "";
                if(data != null){
                    title = titleLength>0?CmsStringUtils.subString(data.getString(Channel.NAME), titleLength, "..."):data.getString(Channel.NAME);
                    
                    //取得连接
                    /*Tag htmlTag_ = .getParent()getParent();
                    Connection conn = null;
                    if (htmlTag_ instanceof HtmlTag) {
                        HtmlTag htmlTag = (HtmlTag) htmlTag_;
                        conn = htmlTag.getConn();
                    }*/
                    
                    //循环20次
                    Tag htmlTag_ = getHtmlTag(tag, 1, 20);
                    Connection conn = null;
                    if(htmlTag_ != null){
                    	if(htmlTag_ instanceof HtmlTag){
                    		 HtmlTag htmlTag = (HtmlTag) htmlTag_;
                             conn = htmlTag.getConn();
                    	}else{
                    		throw new RuntimeException("页面缺少CMS标签<cms:html> , 请检查......");
                    	}
                    }else{
                    	throw new RuntimeException("页面缺少CMS标签<cms:html> , 请检查......");
                    }
                    
                    //统计栏目新闻总数
                    if(total){
                        if (conn != null) {
                            int total = CmsTagHandler.statChannel(conn,data,secLevel);
                            count += total;
                        } 
                    }
                    count +=" )";
                    //加统计
                    if(total){
                        title += count;
                    }
                    
                    //是否加超链接link要和href同时使用
                    if(link){
                    	
                    	/****************公共部分 开始*************/
                    	//不验证
                		StringBuffer paramStr = new StringBuffer();
                        if(params != null && !"".equals(params)){
                            String[] paramsArr = params.split(";"); //参数
                            String[] valuesArr = paramValues.split(";"); //值，和参数一一对应
                            for (int i = 0; i < paramsArr.length; i++) {
                                paramStr.append("&").append(paramsArr[i]).append("=").append(valuesArr[i]);
                            }
                        }
                        String hreTitle = hrefTitle!=null&&!"".equals(hrefTitle)?hrefTitle:data.getString(Channel.NAME);
                        /****************公共部分 结束*************/
                    	
                    	//是否校验栏目查看权限
                    	if(channelAuth){
                    		//获取当前登录人拥有的角色集合
                            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
                            java.util.List<Role> roles = RoleHelper.getRolesToPerson(personId);
                    		
                    		//获取所有当前人员拥有角色所拥有的所有栏目，并过滤重复
                    		CodeList codeList = new CodeList();
                    		//无权
                        	boolean isRight = false;
                            if(roles != null && roles.size() > 0){
                            	if(conn != null){
                            		codeList = new CmsTagHandler().findChannelsOfRole(conn,roles);
                            	}
                            	 //当前栏目ID
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
                            	//有权访问：正常输出
                            	title = getTitle(request, title, paramStr, hreTitle);
                            }else{
                            	//无权访问：点击提示无权限信息
                            	title = "<a title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\"javaScript:alert('无权访问【"+hreTitle+"栏目】');\">" + title + "</a>";
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
     * 获取最总标题
     * @param request
     * @param title
     * @param paramStr
     * @param hreTitle
     * @return
     */
	private String getTitle(HttpServletRequest request, String title,
			StringBuffer paramStr, String hreTitle) {
		//自动传递ID参数,判断是内部、外部链接
		if(!runChannelStyle){
			//不启动功能
		    title = "<a onclick=\""+onclick+"\" title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Channel.ID)+paramStr.toString()+"\" target=\""+target+"\">" + title + "</a>";
		}else{
			//启动功能
			String channelStyle = data.getString(Channel.CHANNEL_STYLE); //栏目样式
			if(Channel.CHANNEL_STYLE_STATUS_OUTLINK.equals(channelStyle)){
				//外部链接
				String urlLink = data.getString(Channel.URL_LINK); //外部链接
				String linkTarget = data.getString(Channel.LINK_TARGET); //外部链接目标
				String urlLinkType = data.getString(Channel.URL_LINK_TYPE); //外部链接类型
				
				//系统内部跳转
				if(Channel.URL_LINK_TYPE_STATUS_INNER.equals(urlLinkType)){
					title = "<a channelStyle=\""+channelStyle+"\" linkTarget=\""+linkTarget+"\" linkHref=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Channel.ID)+paramStr.toString()+"\" onclick=\""+onclick+"\" title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\""+request.getContextPath() + "/" + urlLink+"\" target=\""+linkTarget+"\">" + title + "</a>";
				}
				
				//系统外部跳转
				if(Channel.URL_LINK_TYPE_STATUS_OUTER.equals(urlLinkType)){
					title = "<a channelStyle=\""+channelStyle+"\" linkTarget=\""+linkTarget+"\" linkHref=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Channel.ID)+paramStr.toString()+"\" onclick=\""+onclick+"\" title=\""+hreTitle+"\" style=\"text-decoration: none;\" href=\""+urlLink+"\" target=\""+linkTarget+"\">" + title + "</a>";
				}
			}else{
				//非外部链接
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
     * 获取HtmlTag标签
     * @param tag 标签
     * @param i 索引数，调用处传入1，然后该数字一次增加，增加到count数时就不在递归，而直接返回null
     * @param count 循环次数
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
