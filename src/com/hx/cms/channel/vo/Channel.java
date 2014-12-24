package com.hx.cms.channel.vo;

public class Channel {
	
	public static final int CHANNEL_UP_DOWN_MAXNUM = 20; //20����ǰ����Ŀ��֧����������

    public static final String CHANNEL_PREFIX = "Channel_";
    public static final String CHANNEL_ENTITY = "CMS_CHANNEL"; //����
    public static final String IDS = "IDS"; //ID�����key
    public static final String ID = "ID";
    public static final String PARENT_ID = "PARENT_ID";
    public static final String TYPE_ID = "TYPE_ID";
    public static final String CHANNEL_TPL_ID = "CHANNEL_TPL_ID"; // ��Ŀģ��ID
    public static final String ARTICLE_TPL_ID = "ARTICLE_TPL_ID"; //����ģ��ID
    public static final String WEBSITE_ID = "WEBSITE_ID";
    public static final String DB_TABLE_NAME = "DB_TABLE_NAME"; //���ݿ����
    public static final String NAME = "NAME";
    public static final String SEQ_NUM = "SEQ_NUM";
    public static final String VISIT_CONTROL = "VISIT_CONTROL"; //���ʿ��ƣ�������� ��ͨ��Ա(������)
    public static final String IS_VISIBLE = "IS_VISIBLE"; //�Ƿ���ʾ
    public static final String CREATE_TIME = "CREATE_TIME";
    public static final String CREATOR = "CREATOR";
    public static final String STATUS = "STATUS";
    public static final String MEMO = "MEMO";
	public static final String COUNT_NUM = "COUNT_NUM";
	//�ⲿ����
	public static final String URL_LINK = "URL_LINK";
	//����Ŀ���������ݿ�û��,�ǲ�ѯ�����ģ�
	public static final String CHILD_NUM = "CHILD_NUM";
	//ȫ�ļ���ID��ȫ�ļ���ʱ����Ŀ�Ӹ��ֶ���ģ����ѯ
    public static final String FULL_TEXT_IDS = "FULL_TEXT_IDS";
    
    //�Ƿ����
    public static final String IS_AUTH = "IS_AUTH";
    public static final String IS_AUTH_STATUS_YES = "1";
    public static final String IS_AUTH_STATUS_NO = "2";
    
    //��Ŀ��ʽ
    public static final String CHANNEL_STYLE = "CHANNEL_STYLE";
    public static final String CHANNEL_STYLE_STATUS_COMMON = "1"; //��ͨ��Ŀ
    public static final String CHANNEL_STYLE_STATUS_VIRTUAL = "2"; //������Ŀ
    public static final String CHANNEL_STYLE_STATUS_OUTLINK = "3"; //�ⲿ����
    
    //�ⲿ����Ŀ��
    public static final String LINK_TARGET = "LINK_TARGET";
    public static final String LINK_TARGET_STATUS_BLANK = "_blank";
    public static final String LINK_TARGET_STATUS_SELF = "_self";
    public static final String LINK_TARGET_STATUS_PARENT = "_parent";
    public static final String LINK_TARGET_STATUS_TOP = "_top";
    public static final String LINK_TARGET_STATUS_FRAME = "_frame";
    
    //�ⲿ��������
    public static final String URL_LINK_TYPE = "URL_LINK_TYPE";
    public static final String URL_LINK_TYPE_STATUS_INNER = "1"; //ϵͳ�ڲ���������Ӧ�������ĸ�
    public static final String URL_LINK_TYPE_STATUS_OUTER = "2"; //ϵͳ�ⲿ������Ҫ��Ӧ�������ĸ�
    
    //��ǰ����������
    public static final String CREATE_DEPT_ID = "CREATE_DEPT_ID";
    //��Ŀͼ��
    public static final String CHANNEL_ICON = "CHANNEL_ICON";
    //����
    public static final String ORDER_SEQ_NUM = "ORDER_SEQ_NUM";
}
