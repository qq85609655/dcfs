package com.hx.cms.tags;

import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * @Title PageTotalSizeTag
 * @author lij
 * @Description:总新闻数量<br>
 * @company: 21softech
 * @Create on:May 17,2011 16:39:21
 * @version:$Revision:1.0 $
 * @since 1.0
 */
public class PageTotalSizeTag extends TagSupport {

    /**
     * 序列号
     */
    private static final long serialVersionUID = 8271908520798728459L;

    @Override
    public int doStartTag() {
        String html = "0";
        Tag tag = getParent();
        try {
            if (tag instanceof InfoPageTag) {
                InfoPageTag infoPageTag = (InfoPageTag) tag;
                int totalSize = infoPageTag.getTotalSize();
                html = String.valueOf(totalSize);
            }
            pageContext.getOut().println(html);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
}
