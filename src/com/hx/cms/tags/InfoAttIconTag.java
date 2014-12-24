package com.hx.cms.tags;

import hx.database.databean.Data;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * 
 * @Title: ArtTitleTag.java
 * @Description: 文章标题标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 12:36:27 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoAttIconTag extends TagSupport {
    
    /**
     * 附件类型值
     */
    private String attTypeCode = "";

    /**
     * 序列号
     */
    private static final long serialVersionUID = 396431368880545381L;

    public int doStartTag() {
        Tag tag = getParent();
        String html = null;
        String packageId = null; 
        try {
            if(tag instanceof InfoListTag){
                InfoListTag inforlistTag = (InfoListTag) tag;
                Data data = inforlistTag.getData();
                if (data != null) {
                    packageId = data.getString(Article.ATT_ICON,"");
                }
                if(packageId != null && !"".equals(packageId) && attTypeCode != null && !"".equals(attTypeCode)){
                    packageId += "&CODE="+attTypeCode;
                }
            }
            html = pageContext.getServletContext().getContextPath()+"/article/Article!displayAttIcon.action?PACKAGE_ID="+packageId;
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
    
    @Override
    public int doEndTag() throws JspException {
        attTypeCode = "";
        return EVAL_PAGE;
    }

    /**
     * @return Returns the attTypeCode.
     */
    public String getAttTypeCode() {
        return attTypeCode;
    }

    /**
     * @param attTypeCode The attTypeCode to set.
     */
    public void setAttTypeCode(String attTypeCode) {
        this.attTypeCode = attTypeCode;
    }
}
