package com.hx.cms.tags;

import hx.database.databean.Data;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;
import com.hx.cms.util.CmsStringUtils;

/**
 * 
 * @Title: InfoTitleTag.java
 * @Description: 文章所属类别标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:11:03 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoTitleTag extends TagSupport {
    
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
    private boolean hrefTitle = false;
    
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

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 开始标签
     */
    @Override
    public int doStartTag() throws JspException {
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
        Tag tag = getParent();
        //输出内容
        String html = "";
        
        try {
            if(tag instanceof InfoListTag){
                InfoListTag infoListTag = (InfoListTag) tag;
                //得到当前循环到的Data元素
                Data data = infoListTag.getData();
                
                //标题
                String title = titleLength>0?CmsStringUtils.subString(data.getString(Article.TITLE), titleLength, "..."):data.getString(Article.TITLE);;
                //是否加超链接link要和href同时使用
                if(link && (href!=null&&!"".equals(href))){
                    
                    StringBuffer paramStr = new StringBuffer();
                    if(params != null && !"".equals(params)){
                        String[] paramsArr = params.split(";"); //参数
                        String[] valuesArr = paramValues.split(";"); //值，和参数一一对应
                        for (int i = 0; i < paramsArr.length; i++) {
                            paramStr.append("&").append(paramsArr[i]).append("=").append(valuesArr[i]);
                        }
                    }
                    
                    //自动传递ID参数
                    title = "<a title=\""+(hrefTitle?title:"")+"\" style=\"text-decoration: none;\" href=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Article.ID)+paramStr.toString()+"\" target=\""+target+"\">" + title + "</a>";
                }
                html = title;
                if(html != null && !"".equals(html)){
                	String[] reg = {"\r","\n"};
                	for (int i = 0; i < reg.length; i++) {
                		if(html.contains(reg[i])){
                    		html = html.replaceAll(reg[i], "");
                    	}
					}
                	
                	html = html.replaceAll("\n", "");
                }
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
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
     * @return Returns the hrefTitle.
     */
    public boolean isHrefTitle() {
        return hrefTitle;
    }

    /**
     * @param hrefTitle The hrefTitle to set.
     */
    public void setHrefTitle(boolean hrefTitle) {
        this.hrefTitle = hrefTitle;
    }
}
