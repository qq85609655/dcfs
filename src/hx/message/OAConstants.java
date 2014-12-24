/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

/**
 * @Title: OAConstants.java
 * @Description: OAϵͳ��������<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2012-3-13 ����5:23:42
 * @author yutao
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class OAConstants {

	/*
	 * -----------------------------------------------------------------
	 * ��������
	 * -----------------------------------------------------------------
	 */

	/**
	 * �������ͣ���������
	 */
	public static final String ATT_OA_WF_TEXT="OA_WF_TEXT";
	/**
	 * �������ͣ����̸���
	 */
	public static final String ATT_OA_WF_ATTS="OA_WF_ATTS";
	/**
	 * �������ͣ��������ġ�����
	 */
	public static final String ATT_EDOC_TEXT="OA_EDOC_TEXT";
	/**
	 * �������ͣ�����ģ��
	 */
	public static final String ATT_EDOC_TEMPLATE="OA_EDOC_TEMPLATE";
	/**
	 * �������ͣ��������ġ�����
	 */
	public static final String ATT_ARCHIVE="OA_ARCHIVE";
	/**
	 * �������ͣ�������ʷ
	 */
	public static final String ATT_TEXT_HISTORY="OA_TEXT_HISTORY";
	/**
	 * �������ͣ�OA������Ŀǰ������У�������ͼƬ������
	 */
	public static final String ATT_COMMON="OA_COMMON";


	/*
	 * -----------------------------------------------------------------
	 * ���뼯
	 * -----------------------------------------------------------------
	 */

	/**
	 * ���뼯�������ܼ�
	 */
	public static final String CODE_EDOC_SECURITY_LEVEL="EDOC_SECURITY_LEVEL";
	/**
	 * ���뼯����������Դ
	 */
	public static final String CODE_MEETING_ROOM_RESOURCES="MEETING_ROOM_RESOURCES";
	/**
	 * ���뼯���ʲ����ӷ�ʽ
	 */
	public static final String CODE_ASSET_INCREASE_METHOD="ASSET_INCREASE_METHOD";
	/**
	 * ���뼯���ʲ����޷�ʽ
	 */
	public static final String CODE_ASSET_WARRANTY_WAY="ASSET_WARRANTY_WAY";
	/**
	 * ���뼯��������Դ��ʽ
	 */
	public static final String CODE_ASSET_FUND="ASSET_FUND";
	/*
	 * ���뼯��������;
	 */
	public static final String CODE_RECIPIENTS_USE="RECIPIENTS_USE";
	/*
	 * ���뼯����������
	 */
	public static final String CODE_MEETING_TYPE="MEETING_TYPE";
	/*
	 * ���뼯��������Դ
	 */
	public static final String CODE_CONFERENCE_RES="CONFERENCE_RES";


	//��������
	/*
     * ��Ϣ���ķ������ʹ�÷�Χ ϵͳ�ڲ�=1
     */
    public static final String MESSAGE_ACC_RANGE_N="1";
    /*
     * ��Ϣ���ķ������ʹ�÷�Χ �ⲿ�û�=2
     */
    public static final String MESSAGE_ACC_RANGE_W="2";
    /*
     * ��Ϣ���ķ������ʹ�÷�Χ ȫ���û�=3
     */
    public static final String MESSAGE_ACC_RANGE_ALL="3";
    /**
     * �Ƿ��и�����1Ϊ�У�
     */
    public static final String SFYFJ_YES="1";
    /**
     * �Ƿ��и�����0Ϊ�ޣ�
     */
    public static final String SFYFJ_NO="0";
    /**
     * �Ƿ��Ķ���0Ϊδ�Ķ���
     */
    public static final String SFYD_NO="0";
    /**
     * �Ƿ��Ķ���1Ϊ�Ķ���
     */
    public static final String SFYD_YES="1";
    /**
     * �Ƿ�Ҫ��ִ��1Ϊ��ִ��
     */
    public static final String SFHZ_YES="1";
    /**
     * �Ƿ�Ҫ��ִ��0Ϊ����ִ��
     */
    public static final String SFHZ_NO="0";
    /**
     * �Ƿ�Ҫ��ִ��2Ϊ������ִ��
     */
    public static final String SFHZ_DT="2";
    /**
     * ��ִ״̬��0Ϊδ��ִ��
     */
    public static final String HZZT_NO="0";
    /**
     * ��ִ״̬��1Ϊ�ѻ�ִ��
     */
    public static final String HZZT_YES="1";
    /**
     * �ռ���
     */
    public static final String SJX_CN="�ռ���";
    /**
     * ������
     */
    public static final String FJX_CN="������";
    /**
     * ������
     */
    public static final String LJX_CN="������";
    /**
     * �ռ���
     */
    public static final String SJX="box_accept";
    /**
     * ������
     */
    public static final String FJX="box_send";
    /**
     * �ݸ���
     */
    public static final String CGX="box_draft";
    /**
     * ������
     */
    public static final String LJX="box_delete";
    /**
     * ����Ϣ���������䣩
     */
    public static final String NEWXX="box_new";
    /**
     * ȫ����Ա��ʶ
     */
    public static final String ALLPERSON="ALL";
    
    /**
     * �������ǻ��߿�
     */
    public static final String KEY_YES="1";
    /**
     * ����������߹�
     */
    public static final String KEY_NO="0";
    
    /**
     * ���ķ��� ���Ƿ��ѷַ�
     */
    public static final String EDOC_IS_ISSUED_YES="1";
    public static final String EDOC_IS_ISSUED_NO="0";
    /**
     * ���ĵǼ�״̬  �ݸ�   ��ʽ
     */
    public static final String EDOC_REGISTER_STATUS_DRAFT="0";
    public static final String EDOC_REGISTER_STATUS_FINAL="1";
    
    /**
     * ֻ��ѯ �����Ҫ �������� ����������ҪID
     */
    public static final String EDOC_SEND_HYJY_FINAL="468a7070-01f7-4913-93a5-f934ceecde4a";
    
    
}
