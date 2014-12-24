package com.hx.cms.tags;

import hx.database.databean.Data;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * 
 * @Title: InfoNewTag.java
 * @Description: 显示New标记<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:18:51 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoTopTag extends TagSupport {
    
    /**
     * 序列化
     */
    private static final long serialVersionUID = 330680087521827763L;
    
    /**
     * 图标路径
     */
    private String src = "";
    
    /**
     * 样式
     */
    private String style = "";
    
    /**
     * 备注
     */
    private String alt = "";
    
    /**
     * 宽度
     */
    private String width = "";
    
    /**
     * 高度
     */
    private String height = "";

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
                //比较
                if(Article.IS_TOP_YES.equals(data.getString(Article.IS_TOP))){
                    html = "<img src=\""+request.getContextPath()+"/"+src+"\" width=\""+width+"\" height=\""+height+"\" alt=\""+alt+"\" style=\""+style+"\"/>";
                }
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
    
    @Override
    public int doEndTag() throws JspException {
        src = "";
        style = "";
        alt = "";
        width = "";
        height = "";
        return EVAL_PAGE;
    }

    /**
     * @return Returns the src.
     */
    public String getSrc() {
        return src;
    }

    /**
     * @param src The src to set.
     */
    public void setSrc(String src) {
        this.src = src;
    }

    /**
     * @return Returns the style.
     */
    public String getStyle() {
        return style;
    }

    /**
     * @param style The style to set.
     */
    public void setStyle(String style) {
        this.style = style;
    }

    /**
     * @return Returns the alt.
     */
    public String getAlt() {
        return alt;
    }

    /**
     * @param alt The alt to set.
     */
    public void setAlt(String alt) {
        this.alt = alt;
    }

    /**
     * @return Returns the width.
     */
    public String getWidth() {
        return width;
    }

    /**
     * @param width The width to set.
     */
    public void setWidth(String width) {
        this.width = width;
    }

    /**
     * @return Returns the height.
     */
    public String getHeight() {
        return height;
    }

    /**
     * @param height The height to set.
     */
    public void setHeight(String height) {
        this.height = height;
    }
}
