package com.hx.cms.article.vo;

public class Article {
	
	public static final int ARTICLE_UP_DOWN_MAXNUM = 50; //50个以前的内容都支持上移下移
    
    //默认的附件图标的文件名称
    public static final String DEFAULT_ATT_ICON_NAME = "DEFAULT_ATT_ICON.gif";
    
    //文章类型：暂存和发布
    public static final String STATUS_DRAFT = "1"; //暂存
    public static final String STATUS_WAIT_AUDIT = "2"; //等待审核
    public static final String STATUS_PASS_AUDIT = "3"; //已发布
    public static final String STATUS_BACK_AUDIT = "4"; //退回
    public static final String STATUS_CANCEL_PUBLISH = "5"; //撤销

    public static final String ARTICLE_PREFIX = "Article_";
    public static final String ARTICLE_ENTITY = "CMS_ARTICLE"; //表名
    public static final String ARTICLE_ATT_ENTITY = "CMS_ARTICLE_ATT"; //表名
    public static final String IDS = "IDS"; //ID数组键key
    public static final String ID = "ID";
    public static final String NAME = "NAME";
    public static final String CHANNEL_ID = "CHANNEL_ID";
    public static final String CREATE_TIME = "CREATE_TIME";
    public static final String MODIFY_TIME = "MODIFY_TIME";
    public static final String TITLE = "TITLE";
    public static final String CONTENT = "CONTENT";
    public static final String CREATOR = "CREATOR";
    public static final String SEQ_NUM = "SEQ_NUM";
    public static final String SOURCE = "SOURCE";
    public static final String SHORT_PICTURE = "SHORT_PICTURE"; //文章内容中第一个缩略图
    
    public static final String SHORT_TITLE = "SHORT_TITLE"; //短标题
    public static final String STATUS = "STATUS"; //状态
    
    public static final String PACKAGE_ID = "PACKAGE_ID"; //包ID
    public static final String ATT_ICON = "ATT_ICON"; //附件图标包ID
    public static final String ATT_DESC = "ATT_DESC"; //附件说明
    public static final String ARTICLE_ATT_ARTICLE_ID = "ARTICLE_ID"; //文章附件表中的文章编号ARTICLE_ID
    //全文检索类型
    public static final String SEARCH_TYPE = "SEARCH_TYPE";
    //是否常用软件
    public static final String IS_COMMON_SOFT = "IS_COMMON_SOFT";
    public static final String IS_COMMON_SOFT_YES = "1";
    public static final String IS_COMMON_SOFT_NO = "2";
    public static final String COMMON_SOFT_SEQ_NUM = "COMMON_SOFT_SEQ_NUM";
    
    //是否new标志
    public static final String IS_NEW_YES = "1";
    public static final String IS_NEW_NO = "0";
    public static final String IS_NEW = "IS_NEW";
    public static final String NEW_TIME = "NEW_TIME";
    //是否置顶
    public static final String IS_TOP_YES = "1";
    public static final String IS_TOP_NO = "0";
    public static final String IS_TOP = "IS_TOP";
    public static final String TOP_TIME = "TOP_TIME";
    //是否允许回执
    public static final String IS_RECEIPT_YES = "1";
    public static final String IS_RECEIPT_NO = "0";
    public static final String IS_RECEIPT = "IS_RECEIPT";
    //下载次数
    public static final String DOWN_NUM = "DOWN_NUM";
    //审核通过时间
    public static final String AUDIT_PASS_TIME = "AUDIT_PASS_TIME";
    
    //密级标识
    public static final String DATA_HASH = "DATA_HASH";
    public static final String SECURITY_LEVEL = "SECURITY_LEVEL";
    public static final String PROTECT_PERIOD = "PROTECT_PERIOD";
    public static final String PROTECT_START_DATE = "PROTECT_START_DATE";
    public static final String PROTECT_END_DATE = "PROTECT_END_DATE";
    
    //是否弹出
    public static final String IS_SKIP = "IS_SKIP";
    public static final String IS_SKIP_YES = "1"; //弹出
    public static final String IS_SKIP_NO = "0"; //不弹出
    
    //正文附件
    public static final String BODY_TEXT_ATT = "BODY_TEXT_ATT";
    
    //是否引用 PERSIST为保存 REFERENCE为引用
    public static final String STORE_STATUS = "STORE_STATUS";
    
    //数据权限
    public static final String DATA_ACCESS = "DATA_ACCESS";
    //所属部门ID
    public static final String CREATE_DEPT_ID = "CREATE_DEPT_ID";
}
