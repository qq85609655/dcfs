package com.hx.cms.tags;

import hx.database.databean.Data;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * 
 * @Title: ArtShortTitleTag.java
 * @Description: �������ͨ��ʱ���ǩ<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 12:45:06 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ArtAuditPassTimeTag extends TagSupport {

    /**
     * 
     */
    private static final long serialVersionUID = 635821431233092355L;

    /**
     * ���ڸ�ʽ��
     */
    private String dateFormat = null;
    
    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * ��ʼ��ǩ
     */
    @Override
    public int doStartTag() throws JspException {
        
        String html = "";
        Tag tag = getParent();
        try {
            // �ж�tag�����Ƿ���InforShowTag�������
            if (tag instanceof InfoShowTag) {
                InfoShowTag inforshowTag = (InfoShowTag) tag;
                Data data = inforshowTag.getData();
                if (data != null) {
                    //ʱ��
                    String auditTime = data.getString(Article.AUDIT_PASS_TIME);
                    if(auditTime != null && !"".equals(auditTime)){
                    	if(dateFormat != null && !"".equals(dateFormat)){
                            Date createTime_ = (Date)new SimpleDateFormat(dateFormat).parse(auditTime);
                            auditTime = new SimpleDateFormat(dateFormat).format(createTime_);
                        }
                    	html = auditTime;
                    }else{
                    	html = "";
                    }
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
        dateFormat = null;
        return EVAL_PAGE;
    }

    /**
     * @return Returns the dateFormat.
     */
    public String getDateFormat() {
        return dateFormat;
    }

    /**
     * @param dateFormat The dateFormat to set.
     */
    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }
}
