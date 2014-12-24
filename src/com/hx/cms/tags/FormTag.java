package com.hx.cms.tags;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 
 * @Title: FormTag.java
 * @Description: ���ݹ���form��ǩ<br>
 * @Company: 21softech
 * @Created on Mar 17, 2011 4:39:09 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FormTag extends TagSupport{

    /**
     * ���л�
     */
    private static final long serialVersionUID = -6021838434861374981L;
    
    private String id = "";
    
    /**
     * <form>��action
     */
    private String action = "";
    
    /**
     * <form>��method
     */
    private String method = "";

    /* (non-Javadoc)
     * ҳ�濪ʼ��ǩ
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     */
    @Override
    public int doStartTag() throws JspException {
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
        try {
            //�������html��ǩ
            pageContext.getOut().println("<form id=\""+id+"\" action=\""+request.getContextPath()+"/"+action+"\" method=\""+method+"\">");
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return EVAL_BODY_INCLUDE;
    }
    
    /* (non-Javadoc)
     * ҳ�濪ʼ��ǩ
     * @see javax.servlet.jsp.tagext.TagSupport#doEndTag()
     */
    @Override
    public int doEndTag() throws JspException {
        try {
            //�������html������ǩ
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
