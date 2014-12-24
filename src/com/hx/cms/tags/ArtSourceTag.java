package com.hx.cms.tags;

import hx.database.databean.Data;

import java.io.IOException;

import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * @Title InforShowTag
 * @author liut
 * @Description:������Դ��ǩ<br>
 * @company: 21softech
 * @Create on:May 17,2011 16:39:21
 * @version:$Revision:1.0 $
 * @since 1.0
 */

public class ArtSourceTag extends TagSupport {

    /**
     * ���к�
     */
    private static final long serialVersionUID = 8271908520798728459L;

    @Override
    public int doStartTag() {
        String html = "";
        Tag tag = getParent();
        try {
            // �ж�tag�����Ƿ���InforShowTag�������
            if (tag instanceof InfoShowTag) {
                InfoShowTag inforshowTag = (InfoShowTag) tag;
                Data data = inforshowTag.getData();
                if (data != null) {
                    html = data.getString(Article.SOURCE,"");
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
