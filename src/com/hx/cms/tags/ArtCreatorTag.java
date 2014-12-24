package com.hx.cms.tags;

import hx.database.databean.Data;

import java.io.IOException;

import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * 
 * @Title: CreatorTag.java
 * @Description: 文章作者标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 12:47:44 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ArtCreatorTag extends TagSupport {

    /**
     * 
     */
    private static final long serialVersionUID = 511380142259659027L;

    public int doStartTag() {
        String html = "";
        Tag tag = getParent();
        try {
            // 判断tag对象是否与InforShowTag对象相等
            if (tag instanceof InfoShowTag) {
                InfoShowTag inforshowTag = (InfoShowTag) tag;
                Data data = inforshowTag.getData();
                if (data != null) {
                    html = data.getString(Article.CREATOR,"");
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
