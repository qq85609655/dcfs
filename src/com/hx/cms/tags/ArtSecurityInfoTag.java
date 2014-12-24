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
 * @Description: ����ʱ���ǩ<br>
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
     * ���ܼ���
     */
    private String securityLevelCodeName = null;
    
    /**
     * ��������
     */
    private String periodCodeName = null;
    
    //�������
    private String left = "";
    
    //�����ұ�
    private String right = "";
    
    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * ��ʼ��ǩ
     */
    @Override
    public int doStartTag() throws JspException {
        
        StringBuffer html = new StringBuffer();
        Tag tag = getParent();
        Connection conn = null;
        try {
        	
        	//��ΪInfoList��ǩ���ӱ�ǩ
            if(tag instanceof InfoListTag) {
                InfoListTag infoListTag = (InfoListTag) tag;
                Data data = infoListTag.getData();
                tag = tag.getParent();
                
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
                
                if (data != null) {
                	//ʱ��
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
    								if(!"��".equals(code.getRem())){
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
    								if(!"��".equals(code.getRem())){
    									html.append("��").append(code.getRem());
    								}
    							}
    						}
                        }
                	}
                }
            }
        	
            // �ж�tag�����Ƿ���InforShowTag�������
            if (tag instanceof InfoShowTag) {
            	
                InfoShowTag inforshowTag = (InfoShowTag) tag;
                Data data = inforshowTag.getData();
                
                tag = tag.getParent();
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
                
                if (data != null) {
                	//ʱ��
                    String securitLevel = data.getString(Article.SECURITY_LEVEL);
                    String periodTime = data.getString(Article.PROTECT_PERIOD);
                    CodeList securityList = new CodeList();
                	if(securityLevelCodeName != null && !"".equals(securityLevelCodeName)){
                		securityList = CmsTagHandler.findCodeList(conn, securityLevelCodeName);
                		if(securityList != null && securityList.size() > 0){
                        	for (int i = 0; i < securityList.size(); i++) {
    							Code code = securityList.get(i);
    							if(code.getValue().equals(securitLevel)){
    								if(!"��".equals(code.getRem())){
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
    								if(!"��".equals(code.getRem())){
    									html.append("��").append(code.getRem());
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
