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
 * @Description: ���¸�ҪԤ����ǩ<br>
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
     * ���ⳤ��,��������ʾ��"..."
     */
    private int contentLength = 0;
    
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
     * �Ƿ�������е�html���й��ˣ�Ĭ��Ϊtrue����
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
     * ��ʼ��ǩ
     */
    @Override
    public int doStartTag() throws JspException {
        HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
        Tag tag = getParent();
        //�������
        String html = "";
        
        try {
            if(tag instanceof InfoListTag){
                InfoListTag infoListTag = (InfoListTag) tag;
                //�õ���ǰѭ������DataԪ��
                Data data = infoListTag.getData();
                String con = data.getString(Article.CONTENT);
                if(con != null && !"".equals(con)){
                	if(filter){
                		//ȥ��imgͼƬ ȫ��/��ǿո�
                		con = con.replaceAll(" *", "").replaceAll("��*", "").replaceAll("\r", "").replaceAll("\n", "").replaceAll("(<STRONG>)", "").replaceAll("(<strong>)", "").replaceAll("(</STRONG>)", "").replaceAll("(</strong>)", "").replaceAll("(<FONT)(.*?)(>)", "").replaceAll("(<font)(.*?)(>)", "").replaceAll("(</FONT>)", "").replaceAll("(</font>)", "").replaceAll("(<BR>)", "").replaceAll("(<BR/>)", "").replaceAll("(<br *>)", "").replaceAll("(<br */>)", "").replaceAll("(<img)(.*?)(>)", "").replaceAll("(<IMG)(.*?)(>)", "").replaceAll("(<p)(.*?)(>)", "").replaceAll("(<P)(.*?)(>)", "").replaceAll("(</p>)", "").replaceAll("(</P>)", "").replaceAll("(<DIV)(.*?)(>)", "").replaceAll("(<div)(.*?)(>)", "").replaceAll("(</DIV>)", "").replaceAll("(</div>)", "").replaceAll("(<span)(.*?)(>)", "").replaceAll("(<SPAN)(.*?)(>)", "").replaceAll("(</SPAN>)", "").replaceAll("(</span>)", "").replaceAll("(&nbsp;)", "").replaceAll(" ", "");
                		con = con.replaceAll("(<h*)(.*?)(>)", "").replaceAll("(</h*>)", "").replaceAll("(<H*)(.*?)(>)", "").replaceAll("(</H*>)", "");
                	}
                }else{
                    con = "";
                }
                //����
                //String content = contentLength>0?CmsStringUtils.subString(con, contentLength, "..."):con;
                String content = contentLength>0?CmsStringUtils.subString(con, contentLength,""):con;
                //�Ƿ�ӳ�����linkҪ��hrefͬʱʹ��
                if(link && (href!=null&&!"".equals(href))){
                    StringBuffer paramStr = new StringBuffer();
                    if(params != null && !"".equals(params)){
                        String[] paramsArr = params.split(";"); //����
                        String[] valuesArr = paramValues.split(";"); //ֵ���Ͳ���һһ��Ӧ
                        for (int i = 0; i < paramsArr.length; i++) {
                            paramStr.append("&").append(paramsArr[i]).append("=").append(valuesArr[i]);
                        }
                    }
                    //�Զ�����ID����
                    if(con != null && !"".equals(con)){
                    	content = content + "..." + "<a style=\"text-decoration: none;\" href=\""+request.getContextPath()+"/"+href+"?ID="+data.getString(Article.ID)+paramStr.toString()+"\" target=\""+target+"\"><strong>�����ѯ</strong></a>";
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
