package com.hx.cms.channel.vo;

public class Channel {
	
	public static final int CHANNEL_UP_DOWN_MAXNUM = 20; //20个以前的栏目都支持上移下移

    public static final String CHANNEL_PREFIX = "Channel_";
    public static final String CHANNEL_ENTITY = "CMS_CHANNEL"; //表名
    public static final String IDS = "IDS"; //ID数组键key
    public static final String ID = "ID";
    public static final String PARENT_ID = "PARENT_ID";
    public static final String TYPE_ID = "TYPE_ID";
    public static final String CHANNEL_TPL_ID = "CHANNEL_TPL_ID"; // 栏目模板ID
    public static final String ARTICLE_TPL_ID = "ARTICLE_TPL_ID"; //文章模板ID
    public static final String WEBSITE_ID = "WEBSITE_ID";
    public static final String DB_TABLE_NAME = "DB_TABLE_NAME"; //数据库表名
    public static final String NAME = "NAME";
    public static final String SEQ_NUM = "SEQ_NUM";
    public static final String VISIT_CONTROL = "VISIT_CONTROL"; //访问控制：开放浏览 普通会员(即受限)
    public static final String IS_VISIBLE = "IS_VISIBLE"; //是否显示
    public static final String CREATE_TIME = "CREATE_TIME";
    public static final String CREATOR = "CREATOR";
    public static final String STATUS = "STATUS";
    public static final String MEMO = "MEMO";
	public static final String COUNT_NUM = "COUNT_NUM";
	//外部链接
	public static final String URL_LINK = "URL_LINK";
	//子栏目个数（数据库没有,是查询出来的）
	public static final String CHILD_NUM = "CHILD_NUM";
	//全文检索ID，全文检索时的栏目从该字段中模糊查询
    public static final String FULL_TEXT_IDS = "FULL_TEXT_IDS";
    
    //是否审核
    public static final String IS_AUTH = "IS_AUTH";
    public static final String IS_AUTH_STATUS_YES = "1";
    public static final String IS_AUTH_STATUS_NO = "2";
    
    //栏目样式
    public static final String CHANNEL_STYLE = "CHANNEL_STYLE";
    public static final String CHANNEL_STYLE_STATUS_COMMON = "1"; //普通栏目
    public static final String CHANNEL_STYLE_STATUS_VIRTUAL = "2"; //虚拟栏目
    public static final String CHANNEL_STYLE_STATUS_OUTLINK = "3"; //外部链接
    
    //外部链接目标
    public static final String LINK_TARGET = "LINK_TARGET";
    public static final String LINK_TARGET_STATUS_BLANK = "_blank";
    public static final String LINK_TARGET_STATUS_SELF = "_self";
    public static final String LINK_TARGET_STATUS_PARENT = "_parent";
    public static final String LINK_TARGET_STATUS_TOP = "_top";
    public static final String LINK_TARGET_STATUS_FRAME = "_frame";
    
    //外部链接类型
    public static final String URL_LINK_TYPE = "URL_LINK_TYPE";
    public static final String URL_LINK_TYPE_STATUS_INNER = "1"; //系统内部，即加上应用上下文根
    public static final String URL_LINK_TYPE_STATUS_OUTER = "2"; //系统外部，不需要加应用上下文根
    
    //当前人所属部门
    public static final String CREATE_DEPT_ID = "CREATE_DEPT_ID";
    //栏目图标
    public static final String CHANNEL_ICON = "CHANNEL_ICON";
    //排序
    public static final String ORDER_SEQ_NUM = "ORDER_SEQ_NUM";
}
