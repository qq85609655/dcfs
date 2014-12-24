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
 * @Title: InfoSummaryTag.java
 * @Description: 文章概要预览标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:11:03 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoSummaryTag extends TagSupport {
    
    /**
     * 
     */
    private static final long serialVersionUID = 3712000293349201014L;

    /**
     * 标题长度,过长的显示成"..."
     */
    private int contentLength = 0;
    
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
     * 是否对内容中得html进行过滤，默认为true过滤
     */
    private boolean filter = true;
    
    public static void main(String[] args) {
//        String con = "        asdfasdfa      sdf<img src=lkejjihgigejmgdjgimg.jpg />sdflasjd<img src=lkejjihgigejmgdjgimg.jpg />lfjlskdjf";
        //System.out.println(con.replaceAll("(<img)(.*?)(>)", "-").replaceAll(" ", ""));
        String abc = "<h1>asdfasdf</h1> lsadjf <h2>sdfafe</h3>";
        System.out.println(abc.replaceAll("(<h*)(.*?)(>)", "").replaceAll("(</h*>)", ""));
    }
    
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
                String con = data.getString(Article.CONTENT);
                if(con != null && !"".equals(con)){
                	if(filter){
                		//去除img图片 全角/半角空格
                		con = con.replaceAll(" *", "").replaceAll("　*", "").replaceAll("\r", "").replaceAll("\n", "").replaceAll("(<STRONG>)", "").replaceAll("(<strong>)", "").replaceAll("(</STRONG>)", "").replaceAll("(</strong>)", "").replaceAll("(<FONT)(.*?)(>)", "").replaceAll("(<font)(.*?)(>)", "").replaceAll("(</FONT>)", "").replaceAll("(</font>)", "").replaceAll("(<BR>)", "").replaceAll("(<BR/>)", "").replaceAll("(<br *>)", "").replaceAll("(<br */>)", "").replaceAll("(<img)(.*?)(>)", "").replaceAll("(<IMG)(.*?)(>)", "").replaceAll("(<p)(.*?)(>)", "").replaceAll("(<P)(.*?)(>)", "").replaceAll("(</p>)", "").replaceAll("(</P>)", "").replaceAll("(<DIV)(.*?)(>)", "").replaceAll("(<div)(.*?)(>)", "").replaceAll("(</DIV>)", "").replaceAll("(</div>)", "").replaceAll("(<span)(.*?)(>)", "").replaceAll("(<SPAN)(.*?)(>)", "").replaceAll("(</SPAN>)", "").replaceAll("(</span>)", "").replaceAll("(&nbsp;)", "").replaceAll(" ", "");
                		con = con.replaceAll("(<h*)(.*?)(>)", "").replaceAll("(</h*>)", "").replaceAll("(<H*)(.*?)(>)", "").replaceAll("(</H*>)", "");
                	}
                }else{
                    con = "";
                }
                //内容
                //String content = contentLength>0?CmsStringUtils.subString(con, contentLength, "..."):con;
                String content = contentLength>0?CmsStringUtils.subString(con, contentLength,""):con;
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
                    if(con != null && !"".equals(con)){
                    	content = content + "..." + "<a style=\"text-decoration: none;\" href=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Article.ID)+paramStr.toString()+"\" target=\""+target+"\"><strong>详情查询</strong></a>";
                    }
                }
                
                html = content;
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
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
     * @return Returns the contentLength.
     */
    public int getContentLength() {
        return contentLength;
    }

    /**
     * @param contentLength The contentLength to set.
     */
    public void setContentLength(int contentLength) {
        this.contentLength = contentLength;
    }

	public boolean isFilter() {
		return filter;
	}

	public void setFilter(boolean filter) {
		this.filter = filter;
	}
}
