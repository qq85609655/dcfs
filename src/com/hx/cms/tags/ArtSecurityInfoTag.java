package com.hx.cms.tags;

import hx.code.Code;
import hx.code.CodeList;
import hx.database.databean.Data;

import java.sql.Connection;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.article.vo.Article;
import com.hx.cms.tags.handler.CmsTagHandler;

/**
 * 
 * @Title: ArtShortTitleTag.java
 * @Description: 文章时间标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 12:45:06 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ArtSecurityInfoTag extends TagSupport {

    /**
     * 
     */
    private static final long serialVersionUID = 635821431233092355L;

    /**
     * 秘密级别
     */
    private String securityLevelCodeName = null;
    
    /**
     * 保密期限
     */
    private String periodCodeName = null;
    
    //内容左边
    private String left = "";
    
    //内容右边
    private String right = "";
    
    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 开始标签
     */
    @Override
    public int doStartTag() throws JspException {
        
        StringBuffer html = new StringBuffer();
        Tag tag = getParent();
        Connection conn = null;
        try {
        	
        	//作为InfoList标签的子标签
            if(tag instanceof InfoListTag) {
                InfoListTag infoListTag = (InfoListTag) tag;
                Data data = infoListTag.getData();
                tag = tag.getParent();
                
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
                
                if (data != null) {
                	//时间
                    String securitLevel = data.getString(Article.SECURITY_LEVEL);
                    String periodTime = data.getString(Article.PROTECT_PERIOD);
                    CodeList securityList = new CodeList();
                	if(securityLevelCodeName != null && !"".equals(securityLevelCodeName)){
                		securityList = CmsTagHandler.findCodeList(conn, securityLevelCodeName);
                		if(securityList != null && securityList.size() > 0){
                        	for (int i = 0; i < securityList.size(); i++) {
    							Code code = securityList.get(i);
    							//System.out.println(code.getValue()+":"+code.getRem());
    							if(code.getValue().equals(securitLevel)){
    								if(!"无".equals(code.getRem())){
    									String desc = code.getRem();
    									/*
        								if(desc != null && !"".equals(desc)){
        									desc = desc.replaceAll("\r\n", "<br/>").replaceAll("\n\r", "<br/>").replaceAll("[\n|\r]", "<br/>");
        									//System.out.println(desc);
        								}
        								*/
        								html.append(desc);
    								}
    							}
    						}
                        }
                	}
                	CodeList periodList = new CodeList();
                	if(periodCodeName != null && !"".equals(periodCodeName)){
                		periodList = CmsTagHandler.findCodeList(conn, periodCodeName);
                		if(periodList != null && periodList.size() > 0){
                        	for (int i = 0; i < periodList.size(); i++) {
    							Code code = periodList.get(i);
    							//System.out.println(code.getValue()+":"+code.getRem());
    							if(code.getValue().equals(periodTime)){
    								if(!"无".equals(code.getRem())){
    									html.append("★").append(code.getRem());
    								}
    							}
    						}
                        }
                	}
                }
            }
        	
            // 判断tag对象是否与InforShowTag对象相等
            if (tag instanceof InfoShowTag) {
            	
                InfoShowTag inforshowTag = (InfoShowTag) tag;
                Data data = inforshowTag.getData();
                
                tag = tag.getParent();
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
                
                if (data != null) {
                	//时间
                    String securitLevel = data.getString(Article.SECURITY_LEVEL);
                    String periodTime = data.getString(Article.PROTECT_PERIOD);
                    CodeList securityList = new CodeList();
                	if(securityLevelCodeName != null && !"".equals(securityLevelCodeName)){
                		securityList = CmsTagHandler.findCodeList(conn, securityLevelCodeName);
                		if(securityList != null && securityList.size() > 0){
                        	for (int i = 0; i < securityList.size(); i++) {
    							Code code = securityList.get(i);
    							if(code.getValue().equals(securitLevel)){
    								if(!"无".equals(code.getRem())){
    									String desc = code.getRem();
        								if(desc != null && !"".equals(desc)){
        									desc = desc.replaceAll("\r\n", "<br/>").replaceAll("\n\r", "<br/>").replaceAll("[\n|\r]", "<br/>");
        								}
        								html.append(desc);
    								}
    							}
    						}
                        }
                	}
                	CodeList periodList = new CodeList();
                	if(periodCodeName != null && !"".equals(periodCodeName)){
                		periodList = CmsTagHandler.findCodeList(conn, periodCodeName);
                		if(periodList != null && periodList.size() > 0){
                        	for (int i = 0; i < periodList.size(); i++) {
    							Code code = periodList.get(i);
    							//System.out.println(code.getValue()+":"+code.getRem());
    							if(code.getValue().equals(periodTime)){
    								if(!"无".equals(code.getRem())){
    									html.append("★").append(code.getRem());
    								}
    							}
    						}
                        }
                	}
                }
            }
            
            String htmlFinal = html.toString();
            if(htmlFinal != null && !"".equals(htmlFinal) && htmlFinal.length() > 0){
            	pageContext.getOut().println(left+html.toString()+right);
            }else{
            	pageContext.getOut().println(html.toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
    
    @Override
    public int doEndTag() throws JspException {
        securityLevelCodeName = null;
        periodCodeName = null;
        return EVAL_PAGE;
    }

	public String getSecurityLevelCodeName() {
		return securityLevelCodeName;
	}

	public void setSecurityLevelCodeName(String securityLevelCodeName) {
		this.securityLevelCodeName = securityLevelCodeName;
	}

	public String getPeriodCodeName() {
		return periodCodeName;
	}

	public void setPeriodCodeName(String periodCodeName) {
		this.periodCodeName = periodCodeName;
	}

	public String getLeft() {
		return left;
	}

	public void setLeft(String left) {
		this.left = left;
	}

	public String getRight() {
		return right;
	}

	public void setRight(String right) {
		this.right = right;
	}
}
