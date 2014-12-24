package com.hx.cms.tags;

import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * @Title InforShowTag
 * @author lij
 * @Description:��ҳ<br>
 * @company: 21softech
 * @Create on:May 17,2011 16:39:21
 * @version:$Revision:1.0 $
 * @since 1.0
 */
public class PageHeadTag extends TagSupport {

    /**
     * ���к�
     */
    private static final long serialVersionUID = 8271908520798728459L;

    @Override
    public int doStartTag() {
        String html = "";
        Tag tag = getParent();
        try {
            if (tag instanceof InfoPageTag) {
                InfoPageTag infoPageTag = (InfoPageTag) tag;
                int pageTotal = infoPageTag.getPageTotal();
                String formId = infoPageTag.getFormId();
                html = "_pageGoto('"+formId+"','begin',1,"+pageTotal+");";
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
}
