package com.hx.cms.article.vo;

public class Article {
	
	public static final int ARTICLE_UP_DOWN_MAXNUM = 50; //50����ǰ�����ݶ�֧����������
    
    //Ĭ�ϵĸ���ͼ����ļ�����
    public static final String DEFAULT_ATT_ICON_NAME = "DEFAULT_ATT_ICON.gif";
    
    //�������ͣ��ݴ�ͷ���
    public static final String STATUS_DRAFT = "1"; //�ݴ�
    public static final String STATUS_WAIT_AUDIT = "2"; //�ȴ����
    public static final String STATUS_PASS_AUDIT = "3"; //�ѷ���
    public static final String STATUS_BACK_AUDIT = "4"; //�˻�
    public static final String STATUS_CANCEL_PUBLISH = "5"; //����

    public static final String ARTICLE_PREFIX = "Article_";
    public static final String ARTICLE_ENTITY = "CMS_ARTICLE"; //����
    public static final String ARTICLE_ATT_ENTITY = "CMS_ARTICLE_ATT"; //����
    public static final String IDS = "IDS"; //ID�����key
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
    public static final String SHORT_PICTURE = "SHORT_PICTURE"; //���������е�һ������ͼ
    
    public static final String SHORT_TITLE = "SHORT_TITLE"; //�̱���
    public static final String STATUS = "STATUS"; //״̬
    
    public static final String PACKAGE_ID = "PACKAGE_ID"; //��ID
    public static final String ATT_ICON = "ATT_ICON"; //����ͼ���ID
    public static final String ATT_DESC = "ATT_DESC"; //����˵��
    public static final String ARTICLE_ATT_ARTICLE_ID = "ARTICLE_ID"; //���¸������е����±��ARTICLE_ID
    //ȫ�ļ�������
    public static final String SEARCH_TYPE = "SEARCH_TYPE";
    //�Ƿ������
    public static final String IS_COMMON_SOFT = "IS_COMMON_SOFT";
    public static final String IS_COMMON_SOFT_YES = "1";
    public static final String IS_COMMON_SOFT_NO = "2";
    public static final String COMMON_SOFT_SEQ_NUM = "COMMON_SOFT_SEQ_NUM";
    
    //�Ƿ�new��־
    public static final String IS_NEW_YES = "1";
    public static final String IS_NEW_NO = "0";
    public static final String IS_NEW = "IS_NEW";
    public static final String NEW_TIME = "NEW_TIME";
    //�Ƿ��ö�
    public static final String IS_TOP_YES = "1";
    public static final String IS_TOP_NO = "0";
    public static final String IS_TOP = "IS_TOP";
    public static final String TOP_TIME = "TOP_TIME";
    //�Ƿ������ִ
    public static final String IS_RECEIPT_YES = "1";
    public static final String IS_RECEIPT_NO = "0";
    public static final String IS_RECEIPT = "IS_RECEIPT";
    //���ش���
    public static final String DOWN_NUM = "DOWN_NUM";
    //���ͨ��ʱ��
    public static final String AUDIT_PASS_TIME = "AUDIT_PASS_TIME";
    
    //�ܼ���ʶ
    public static final String DATA_HASH = "DATA_HASH";
    public static final String SECURITY_LEVEL = "SECURITY_LEVEL";
    public static final String PROTECT_PERIOD = "PROTECT_PERIOD";
    public static final String PROTECT_START_DATE = "PROTECT_START_DATE";
    public static final String PROTECT_END_DATE = "PROTECT_END_DATE";
    
    //�Ƿ񵯳�
    public static final String IS_SKIP = "IS_SKIP";
    public static final String IS_SKIP_YES = "1"; //����
    public static final String IS_SKIP_NO = "0"; //������
    
    //���ĸ���
    public static final String BODY_TEXT_ATT = "BODY_TEXT_ATT";
    
    //�Ƿ����� PERSISTΪ���� REFERENCEΪ����
    public static final String STORE_STATUS = "STORE_STATUS";
    
    //����Ȩ��
    public static final String DATA_ACCESS = "DATA_ACCESS";
    //��������ID
    public static final String CREATE_DEPT_ID = "CREATE_DEPT_ID";
}
