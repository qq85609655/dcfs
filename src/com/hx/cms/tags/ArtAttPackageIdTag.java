package com.hx.cms.tags;

import java.io.IOException;

import hx.database.databean.Data;

import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * 
 * @Title: ArtAttPackageIdTag.java
 * @Description: 文章附件标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 12:36:27 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ArtAttPackageIdTag extends TagSupport {

    /**
     * 序列号
     */
    private static final long serialVersionUID = 396431368880545381L;

    public int doStartTag() {
        String html = "";
        Tag tag = getParent();
        try {
            if (tag instanceof InfoShowTag) {
                InfoShowTag inforshowTag = (InfoShowTag) tag;
                Data data = inforshowTag.getData();
                if (data != null) {
                    html = data.getString(Article.PACKAGE_ID,"");
                    pageContext.getOut().println(html);
                } else {
                    return SKIP_BODY;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
}
