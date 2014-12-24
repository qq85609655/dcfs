package com.hx.cms.tags;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 
 * @Title: FormTag.java
 * @Description: 内容管理form标签<br>
 * @Company: 21softech
 * @Created on Mar 17, 2011 4:39:09 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FormTag extends TagSupport{

    /**
     * 序列化
     */
    private static final long serialVersionUID = -6021838434861374981L;
    
    private String id = "";
    
    /**
     * <form>的action
     */
    private String action = "";
    
    /**
     * <form>的method
     */
    private String method = "";

    /* (non-Javadoc)
     * 页面开始标签
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     */
    @Override
    public int doStartTag() throws JspException {
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
        try {
            //输出正规html标签
            pageContext.getOut().println("<form id=\""+id+"\" action=\""+request.getContextPath()+"/"+action+"\" method=\""+method+"\">");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return EVAL_BODY_INCLUDE;
    }
    
    /* (non-Javadoc)
     * 页面开始标签
     * @see javax.servlet.jsp.tagext.TagSupport#doEndTag()
     */
    @Override
    public int doEndTag() throws JspException {
        try {
            //输出正规html结束标签
            pageContext.getOut().println("</form>");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    /**
     * @return Returns the id.
     */
    public String getId() {
        return id;
    }

    /**
     * @param id The id to set.
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @return Returns the action.
     */
    public String getAction() {
        return action;
    }

    /**
     * @param action The action to set.
     */
    public void setAction(String action) {
        this.action = action;
    }

    /**
     * @return Returns the method.
     */
    public String getMethod() {
        return method;
    }

    /**
     * @param method The method to set.
     */
    public void setMethod(String method) {
        this.method = method;
    }
}
