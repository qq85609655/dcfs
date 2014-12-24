package com.hx.cms.tags;

import hx.database.manager.ConnectionManager;

import java.sql.Connection;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 
 * @Title: HtmlTag.java
 * @Description: 内容管理html标签<br>
 *                      为整个页面准备共用的Connection对象<br>
 * @Company: 21softech
 * @Created on Mar 17, 2011 4:39:09 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class HtmlTag extends TagSupport{

    /**
     * 序列化
     */
    private static final long serialVersionUID = -6021838434861374981L;
    
    /**
     * html标签属性
     */
    private String xmlns = "";
    
	/**
     * 整个页面共用连接
     */
    private Connection conn;

    /* (non-Javadoc)
     * 页面开始标签
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     */
    @Override
    public int doStartTag() throws JspException {
        
        //初始化Connection
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
            conn = ConnectionManager.getConnection();
            
            //输出正规html标签
            StringBuffer head = new StringBuffer();
            head.append("<html");
            if(xmlns != null && !"".equals(xmlns)){
            	head.append(" xmlns=\"").append(xmlns).append("\"");
            }
            head.append(">");
            pageContext.getOut().println(head.toString());
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
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
            
            //输出正规html结束标签
            pageContext.getOut().println("</html>");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }

    /**
     * @return Returns the conn.
     */
    public Connection getConn() {
        return conn;
    }

    /**
     * @param conn The conn to set.
     */
    public void setConn(Connection conn) {
        this.conn = conn;
    }
    
    public String getXmlns() {
		return xmlns;
	}

	public void setXmlns(String xmlns) {
		this.xmlns = xmlns;
	}
}
