package com.hx.cms.tags;

import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * @Title PageTotalTag
 * @author lij
 * @Description:µ±«∞“≥<br>
 * @company: 21softech
 * @Create on:May 17,2011 16:39:21
 * @version:$Revision:1.0 $
 * @since 1.0
 */
public class PageTotalTag extends TagSupport {

    /**
     * –Ú¡–∫≈
     */
    private static final long serialVersionUID = 8271908520798728459L;

    @Override
    public int doStartTag() {
        String html = "1";
        Tag tag = getParent();
        try {
            if (tag instanceof InfoPageTag) {
                InfoPageTag infoPageTag = (InfoPageTag) tag;
                int pageTotal = infoPageTag.getPageTotal();
                html = String.valueOf(pageTotal);
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
}
