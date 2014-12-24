package com.hx.cms.tags;

import hx.database.databean.Data;
import hx.database.databean.DataList;

import java.sql.Connection;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import com.hx.cms.tags.handler.CmsTagHandler;
import com.hx.cms.util.Constants;

/**
 * 
 * @Title: ChannelListTag.java
 * @Description: 频道列表标签<br>
 *               <br>
 * @Company: 21softech
 * @Created on Mar 14, 2011 5:15:49 PM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class ChannelListTag extends TagSupport {

    //频道ID参数
    public static final String CHANNEL_ID = "CHANNEL_ID";

    //获取页面地址的参数名
    public static final String PAGINATION_PAGE = "PAGINATION_PAGE";

    /**
     * 序列化
     */
    private static final long serialVersionUID = 7088717549575957136L;

    /**
     * 频道ID号
     */
    private String channelId;

    /**
     * 显示前几条数据
     */
    private int length = 0;

    /**
     * 排序字段
     */
    private String orderName;

    /**
     * 排序方式：
     *      倒序 正序
     */
    private String orderType;

    /**
     * 指定参数名可以用于从pageContext中获取当前循环到的Data数据
     */
    private String forData;

    /**
     * 列表类型
     *      page : 带有分页信息显示频道下的文章列表
     *      simple : 显示标题和日期列表，并且不带分页，可以用length指定显示列表记录数
     *      picture : 缩略图的形式显示文章列表
     */
    private String type = "";
    
    /**
     * 列数：支持多列显示，目前只测试过2列
     */
    private boolean twoCols = false;
    
    /**
     * 不统计指定栏目的子栏目个数,即默认认为无子栏目;多个栏目用分号";"分隔
     */
    private String noStat = null;
    
    /**
     * 是否校验有对栏目的查看权限
     * 				true为校验
     * 				false为不校验(默认)
     */
    private boolean channelAuth = false;
    
    /*-------------------------------下边属性无需注册到tld--------------------------------*/

    /**
     * 当前遍历到的Data数据
     */
    private Data data = null;
    
    /**
     * 两列时的第二个Data数据
     */
    private Data secondData = null;

    /**
     * 列表集合DataList
     */
    private DataList dataList = null;

    /**
     * 当前遍历到的索引值
     */
    private int i = 0;

    /**
     * 当前页
     */
    private int page = 1;

    /**
     * 当前页显示大小
     */
    private int pageSize = 20;

    /**
     * 初始化数据
     */
    private void initDataList(Connection conn) {

        DataList initDataList = new DataList();
        try {
            //查询channelId
            if (channelId != null) {
                initDataList = CmsTagHandler.findChannels(conn,
                        channelId, orderName, orderType,
                        (length == 0 ? Integer.MAX_VALUE : length), getPage(),
                        getPageSize(), type,noStat);
            }

            //设置分页信息
            if ("page".equals(type)) {
                page = initDataList.getNowPage();
                pageSize = initDataList.getPageSize();
            }
            //设置数据集合
            setDataList(initDataList);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doStartTag()
     * 标签开始
     */
    @Override
    public int doStartTag() throws JspException {
        //设置分页
        setPageSize(Constants.DEFAULT_PAGE_SIZE);

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

        //初始化数据
        initDataList(conn);

        //不论length是否为0,现在的dataList已经确定有值
        if (dataList != null && dataList.size() > 0) {
            int size = dataList.size();
            if(twoCols){
                if(size > i){
                    //取出当前循环到的元素
                    data = dataList.getData(i);
                    //赋值
                    setData(data);
                    
                    if(size > (i + 1)){
                      //取出当前循环到的元素
                        secondData = dataList.getData(i+1);
                        //赋值
                        setSecondData(secondData);
                    }else{
                        setSecondData(null);
                    }
                    i = i + 2;
                }
            }else{
                if (size > i) {
                    //取出当前循环到的元素
                    data = dataList.getData(i);
                    //赋值
                    setData(data);
                    i++;
                }
            }
        } else {
            return SKIP_BODY;
        }

        return EVAL_BODY_INCLUDE;
    }

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doAfterBody()
     * 标签体结束后
     */
    @Override
    public int doAfterBody() throws JspException {
        int size = dataList.size();
        if(twoCols){
            if(size > i){
                //取出当前循环到的元素
                data = dataList.getData(i);
                //赋值
                setData(data);
                
                if(size > (i + 1)){
                  //取出当前循环到的元素
                    secondData = dataList.getData(i+1);
                    //赋值
                    setSecondData(secondData);
                }else{
                    setSecondData(null);
                }
                i = i + 2;
                //循环
                return EVAL_BODY_AGAIN;
            }else{
                return EVAL_PAGE;
            }
            
        }else{
            if (size > i) {
                //取出当前循环到的元素
                data = dataList.getData(i);
                //赋值
                setData(data);
                i++;
                //循环
                return EVAL_BODY_AGAIN;
            }
        }
        
        return EVAL_PAGE;
    }

    /* (non-Javadoc)
     * @see javax.servlet.jsp.tagext.TagSupport#doEndTag()
     * 标签结束
     */
    @Override
    public int doEndTag() throws JspException {
        //循环结束,执行数据初始化
        length = 0;
        data = null;
        secondData = null;
        dataList = null;
        twoCols = false;
        i = 0;
        //移除pageContext中的forData对应的Data参数
        if (forData != null && !"".equals(forData)) {
            pageContext.removeAttribute(forData);
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
     * @return Returns the length.
     */
    public int getLength() {
        return length;
    }

    /**
     * @param length The length to set.
     */
    public void setLength(int length) {
        this.length = length;
    }

    /**
     * @return Returns the orderName.
     */
    public String getOrderName() {
        return orderName;
    }

    /**
     * @param orderName The orderName to set.
     */
    public void setOrderName(String orderName) {
        this.orderName = orderName;
    }

    /**
     * @return Returns the orderType.
     */
    public String getOrderType() {
        return orderType;
    }

    /**
     * @param orderType The orderType to set.
     */
    public void setOrderType(String orderType) {
        this.orderType = orderType;
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
        //保存当前的Data到forData参数
        if (forData != null && !"".equals(forData)) {
            data.add("i", this.i);
            pageContext.setAttribute(forData, data);
        }
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
     * @return Returns the i.
     */
    public int getI() {
        return i;
    }

    /**
     * @param i The i to set.
     */
    public void setI(int i) {
        this.i = i;
    }

    /**
     * @return Returns the forData.
     */
    public String getForData() {
        return forData;
    }

    /**
     * @param forData The forData to set.
     */
    public void setForData(String forData) {
        this.forData = forData;
    }

    /**
     * @return Returns the type.
     */
    public String getType() {
        return type;
    }

    /**
     * @param type The type to set.
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * @return Returns the page.
     */
    public int getPage() {
        String curPage = (String) pageContext.findAttribute("page");
        if (curPage != null && !"".equals(curPage)) {
            page = Integer.parseInt(curPage);
        }
        return page;
    }

    /**
     * @param page The page to set.
     */
    public void setPage(int page) {
        this.page = page;
    }

    /**
     * @return Returns the pageSize.
     */
    public int getPageSize() {
        return pageSize;
    }

    /**
     * @param pageSize The pageSize to set.
     */
    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    /**
     * @return Returns the secondData.
     */
    public Data getSecondData() {
        return secondData;
    }

    /**
     * @param secondData The secondData to set.
     */
    public void setSecondData(Data secondData) {
        this.secondData = secondData;
    }

    /**
     * @return Returns the twoCols.
     */
    public boolean isTwoCols() {
        return twoCols;
    }

    /**
     * @param twoCols The twoCols to set.
     */
    public void setTwoCols(boolean twoCols) {
        this.twoCols = twoCols;
    }

    /**
     * @return Returns the noStat.
     */
    public String getNoStat() {
        return noStat;
    }

    /**
     * @param noStat The noStat to set.
     */
    public void setNoStat(String noStat) {
        this.noStat = noStat;
    }

	public boolean isChannelAuth() {
		return channelAuth;
	}

	public void setChannelAuth(boolean channelAuth) {
		this.channelAuth = channelAuth;
	}
}
