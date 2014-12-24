package com.hx.cms.tags;

import java.io.IOException;

import hx.database.databean.Data;

import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;

/**
 * 
 * @Title: ArtShortTitleTag.java
 * @Description: 文章内容标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 12:45:06 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ArtContentTag extends TagSupport {
	
	private String filter = "jsh";

    /**
     * 
     */
    private static final long serialVersionUID = 635821431233092355L;

    public int doStartTag() {
        String html = "";
        Tag tag = getParent();
        try {
            // 判断tag对象是否与InforShowTag对象相等
            if (tag instanceof InfoShowTag) {
                InfoShowTag inforshowTag = (InfoShowTag) tag;
                Data data = inforshowTag.getData();
                if (data != null) {
                    html = data.getString(Article.CONTENT,"");
                    if("jsh".equalsIgnoreCase(filter)){
                    	if(html != null && !"".equals(html)){
                    		html = html.replaceAll("<p>&nbsp;</p>", "").replaceAll("<P>&nbsp;</P>", "").replaceAll("<p>&nbsp;&nbsp;&nbsp;&nbsp;", "<p>").replaceAll("<P>&nbsp;&nbsp;&nbsp;&nbsp;", "<P>");
                    	}
                    }
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

	public String getFilter() {
		return filter;
	}

	public void setFilter(String filter) {
		this.filter = filter;
	}
}
