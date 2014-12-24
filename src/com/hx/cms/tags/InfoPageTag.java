package com.hx.cms.tags;

import hx.database.databean.DataList;

import java.sql.Connection;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.tags.handler.CmsTagHandler;
import com.hx.cms.util.CmsConfigUtil;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.sdk.PersonHelper;

/**
 * 
 * @Title: InfoPublishTimeTag.java
 * @Description: 文章列表分页标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 18, 2011 10:18:51 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class InfoPageTag extends TagSupport {
    
    /**
     * 序列化
     */
    private static final long serialVersionUID = 330680087521827763L;

    /**
     * 要提交的表单的id
     */
    private String formId;
    
    /**
     * 当前页
     */
    private int page = 1;
    
    /**
     * 频道ID
     */
    private String channelId;
    
    /**
     * 共多少页
     */
    private int pageTotal = 1;
    
    /**
     * 总数量
     */
    private int totalSize = 0;
    
    /**
     * 传入dataList集合
     */
    private DataList dataList = null;
    
    /**
     * 当前页显示大小
     */
    private int pageSize = 20;
    
	/**
     * 初始化数据
     */
    private void initDataList(Connection conn) {
    	
    	//密级获取
        HttpSession session = pageContext.getSession();
        UserInfo user = (UserInfo)session.getAttribute(com.hx.framework.common.Constants.LOGIN_USER_INFO);
        
        int secLevel = 0;
        
        //是否需要获取当前用户 true就是要获取
        String isLoginConfig = CmsConfigUtil.getValue(com.hx.cms.util.Constants.IS_LOGIN);
    	boolean isLogin = false;
    	if(isLoginConfig != null && !"".equalsIgnoreCase(isLoginConfig)){
    		isLogin = Boolean.parseBoolean(isLoginConfig);
    	}
    	if(isLogin){
    		//密级获取
            String secid=user.getPerson().getSecretLevel();
            if(secid != null && !"".equals(secid)){
            	secLevel = Integer.parseInt(secid);
            }
    	}
        
        //数据权限
        String dataAccessPermission = CmsConfigUtil.getValue(com.hx.cms.util.Constants.DATA_ACCESS_PERMISSION);
        boolean dataAccess = false;
        if(dataAccessPermission != null && !"".equalsIgnoreCase(dataAccessPermission)){
            dataAccess = Boolean.parseBoolean(dataAccessPermission);
        }
    	
        try {
            //查询channelId
            DataList dataList_ = new DataList();
            if (channelId != null) {
                if(dataAccess){
                	String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
                    String organId = PersonHelper.getOrganOfPerson(personId).getId();
                    //加入数据权限校验
                    dataList_ = CmsTagHandler.findArticleOfChannelPageTatalForDataAccess(conn,channelId,secLevel,personId,organId);
                }else{
                    dataList_ = CmsTagHandler.findArticleOfChannelPageTatal(conn,channelId,secLevel);
                }
                //校验
                if(dataList_ != null && dataList_.size() > 0){
                    int count = dataList_.getData(0).getInt("COUNT");
                    totalSize = count; //总个数
                    pageTotal = count/getPageSize();
                    int y =  count%getPageSize();
                    if (y>0){
                        pageTotal++;
                    }
                    //0的话就是只有一页
                    if(pageTotal < 1){
                        pageTotal = 1;
                    }
                }else{
                    totalSize = 0;
                    pageTotal = 1;
                }
            }else{
                if(dataList != null && dataList.size() > 0){
                    dataList_ = dataList;
                    if(dataList_ != null && dataList_.size() > 0){
                        int count = dataList_.getDataTotal();
                        page = dataList_.getNowPage();
                        totalSize = count; //总个数
                        pageTotal = count/getPageSize();
                        int y =  count%getPageSize();
                        if (y>0){
                            pageTotal++;
                        }
                        //0的话就是只有一页
                        if(pageTotal < 1){
                            pageTotal = 1;
                        }
                        if(page < 1){
                            page = 1;
                        }
                    }else{
                        totalSize = 0;
                        pageTotal = 1;
                    }
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        System.out.println(15/15);
    }
    
    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 开始标签
     */
    @Override
    public int doStartTag() throws JspException {
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
        
        //初始化
        initDataList(conn);
        
        try {
            
            //输出内容
            StringBuffer html = new StringBuffer();
            html.append("<input id=\""+formId+"_page\" type=\"hidden\" name=\""+formId+"_page\" value=\""+getPage()+"\">")
            .append("<input type=\"hidden\" name=\"formId\" value=\""+formId+"\">");
            pageContext.getOut().println(html.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return EVAL_PAGE;
    }
    
    @Override
    public int doEndTag() throws JspException {
        page = 1;
        pageTotal = 1;
        dataList = null;
        totalSize = 0; 
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
     * @return Returns the page.
     */
    public int getPage() {
        Tag tag = getParent();
        String formId = null;
        if (tag instanceof FormTag) {
            FormTag formTag = (FormTag) tag;
            formId = formTag.getId();
        } else {
            throw new RuntimeException("页面缺少CMS标签<cms:form> , 请检查......");
        }
        String reqFormId = (String) pageContext.findAttribute("formId");
        if(formId.equalsIgnoreCase(reqFormId)){
            String curPage = (String) pageContext.findAttribute(formId+"_page");
            if(curPage != null && !"".equals(curPage)){
                page = Integer.parseInt(curPage);
            }
        }
        return page;
    }

    /**
     * @return Returns the channelId.
     */
    public String getChannelId() {
        return channelId;
    }

    /**
     * @param channelId The channelId to set.
     */
    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    /**
     * @return Returns the pageTotal.
     */
    public int getPageTotal() {
        return pageTotal;
    }

    /**
     * @param pageTotal The pageTotal to set.
     */
    public void setPageTotal(int pageTotal) {
        this.pageTotal = pageTotal;
    }

    /**
     * @return Returns the formId.
     */
    public String getFormId() {
        return formId;
    }

    /**
     * @param formId The formId to set.
     */
    public void setFormId(String formId) {
        this.formId = formId;
    }

    /**
     * @return Returns the dataList.
     */
    public DataList getDataList() {
        return dataList;
    }

    /**
     * @param dataList The dataList to set.
     */
    public void setDataList(DataList dataList) {
        this.dataList = dataList;
    }

    /**
     * @return Returns the totalSize.
     */
    public int getTotalSize() {
        return totalSize;
    }

    /**
     * @param totalSize The totalSize to set.
     */
    public void setTotalSize(int totalSize) {
        this.totalSize = totalSize;
    }
    
    public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
}
