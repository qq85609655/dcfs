package com.hx.cms.tags;

import hx.database.databean.Data;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;
import com.hx.cms.tags.handler.CmsTagHandler;

/**
 * @Title InforShowTag
 * @author liut
 * @Description:文章显示标签<br>
 * @company: 21softech
 * @Create on:May 17,2011 09:39:21
 * @version:$Revision:1.0 $
 * @since 1.0
 */
public class InfoShowTag extends TagSupport {

	/**
	 * 序列号
	 */
	private static final long serialVersionUID = -7009963083804122121L;
	
	/**
	 * 页面请求的参数，根据参数查找对应的Data
	 */
	private String infoId;
	
	/**
	 * 当前传过来的data数据
	 */
	private Data data = null;
	
	/**
	 * 标签开始
	 * @return
	 * @throws IOException 
	 */
	@Override
	public int doStartTag() {
	  
	    //获取HTML标签中的Connection
        Tag tag = getParent();
        Connection conn = null;
    	//循环20次
        Tag htmlTag_ = getHtmlTag(tag, 1, 20);
        if(htmlTag_ != null){
        	if(htmlTag_ instanceof HtmlTag){
        		 HtmlTag htmlTag = (HtmlTag) htmlTag_;
                 conn = htmlTag.getConn();
        	}else{
        		throw new RuntimeException("页面缺少CMS标签<cms:html> , 请检查......");
        	}
        }else{
        	throw new RuntimeException("页面缺少CMS标签<cms:html> , 请检查......");
        }
        
		try {
            //初始化数据
            if(infoId != null && !"".equals(infoId)){
                Data curData = new Data();
                curData.setEntityName(Article.ARTICLE_ENTITY);
                curData.setPrimaryKey(Article.ID);
                curData.add(Article.ID, infoId);
                curData = CmsTagHandler.findArticleById(conn, curData);
                data = curData;
                //得到相关packageId附件
                Data relaAtt = new Data();
                relaAtt.setEntityName(Article.ARTICLE_ATT_ENTITY);
                relaAtt.setPrimaryKey(Article.ARTICLE_ATT_ARTICLE_ID);
                relaAtt.add(Article.ARTICLE_ATT_ARTICLE_ID, infoId);
                relaAtt = CmsTagHandler.findArticleById(conn, relaAtt);
                if(relaAtt != null){
                    data.add(Article.PACKAGE_ID, relaAtt.getString(Article.PACKAGE_ID));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        //判断
		if(data==null)
			return SKIP_BODY;
		else{
		    pageContext.setAttribute("data", data);
			return EVAL_BODY_INCLUDE;
		}
	}
	
	@Override
	public int doEndTag() throws JspException {
	    pageContext.removeAttribute("data");
	    data = null;
	    return EVAL_PAGE;
	}
	
	/**
     * 获取HtmlTag标签
     * @param tag 标签
     * @param i 索引数，调用处传入1，然后该数字一次增加，增加到count数时就不在递归，而直接返回null
     * @param count 循环次数
     * @return
     */
	private Tag getHtmlTag(Tag tag,int i,int count) {
		if(tag instanceof HtmlTag){
			return tag;
		}else{
			if(i == count){
				return null;
			}else{
				return getHtmlTag(tag.getParent(),++i,count);
			}
		}
	}

    /**
     * @return Returns the infoId.
     */
    public String getInfoId() {
        return infoId;
    }

    /**
     * @param infoId The infoId to set.
     */
    public void setInfoId(String infoId) {
        this.infoId = infoId;
    }

    /**
     * @return Returns the data.
     */
    public Data getData() {
        return data;
    }

    /**
     * @param data The data to set.
     */
    public void setData(Data data) {
        this.data = data;
    }
}