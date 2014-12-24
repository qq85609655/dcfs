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
 * @Description:������ʾ��ǩ<br>
 * @company: 21softech
 * @Create on:May 17,2011 09:39:21
 * @version:$Revision:1.0 $
 * @since 1.0
 */
public class InfoShowTag extends TagSupport {

	/**
	 * ���к�
	 */
	private static final long serialVersionUID = -7009963083804122121L;
	
	/**
	 * ҳ������Ĳ��������ݲ������Ҷ�Ӧ��Data
	 */
	private String infoId;
	
	/**
	 * ��ǰ��������data����
	 */
	private Data data = null;
	
	/**
	 * ��ǩ��ʼ
	 * @return
	 * @throws IOException 
	 */
	@Override
	public int doStartTag() {
	  
	    //��ȡHTML��ǩ�е�Connection
        Tag tag = getParent();
        Connection conn = null;
    	//ѭ��20��
        Tag htmlTag_ = getHtmlTag(tag, 1, 20);
        if(htmlTag_ != null){
        	if(htmlTag_ instanceof HtmlTag){
        		 HtmlTag htmlTag = (HtmlTag) htmlTag_;
                 conn = htmlTag.getConn();
        	}else{
        		throw new RuntimeException("ҳ��ȱ��CMS��ǩ<cms:html> , ����......");
        	}
        }else{
        	throw new RuntimeException("ҳ��ȱ��CMS��ǩ<cms:html> , ����......");
        }
        
		try {
            //��ʼ������
            if(infoId != null && !"".equals(infoId)){
                Data curData = new Data();
                curData.setEntityName(Article.ARTICLE_ENTITY);
                curData.setPrimaryKey(Article.ID);
                curData.add(Article.ID, infoId);
                curData = CmsTagHandler.findArticleById(conn, curData);
                data = curData;
                //�õ����packageId����
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

        //�ж�
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
     * ��ȡHtmlTag��ǩ
     * @param tag ��ǩ
     * @param i �����������ô�����1��Ȼ�������һ�����ӣ����ӵ�count��ʱ�Ͳ��ڵݹ飬��ֱ�ӷ���null
     * @param count ѭ������
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