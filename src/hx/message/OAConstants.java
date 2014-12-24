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
 * @Description: OA系统常量定义<br>
 *               <br>
 * @Company: 21softech
 * @Created on 2012-3-13 下午5:23:42
 * @author yutao
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class OAConstants {

	/*
	 * -----------------------------------------------------------------
	 * 附件类型
	 * -----------------------------------------------------------------
	 */

	/**
	 * 附件类型：流程正文
	 */
	public static final String ATT_OA_WF_TEXT="OA_WF_TEXT";
	/**
	 * 附件类型：流程附件
	 */
	public static final String ATT_OA_WF_ATTS="OA_WF_ATTS";
	/**
	 * 附件类型：公文正文、附件
	 */
	public static final String ATT_EDOC_TEXT="OA_EDOC_TEXT";
	/**
	 * 附件类型：公文模板
	 */
	public static final String ATT_EDOC_TEMPLATE="OA_EDOC_TEMPLATE";
	/**
	 * 附件类型：档案正文、附件
	 */
	public static final String ATT_ARCHIVE="OA_ARCHIVE";
	/**
	 * 附件类型：正文历史
	 */
	public static final String ATT_TEXT_HISTORY="OA_TEXT_HISTORY";
	/**
	 * 附件类型：OA公共；目前保存的有：会议室图片、附件
	 */
	public static final String ATT_COMMON="OA_COMMON";


	/*
	 * -----------------------------------------------------------------
	 * 代码集
	 * -----------------------------------------------------------------
	 */

	/**
	 * 代码集：公文密级
	 */
	public static final String CODE_EDOC_SECURITY_LEVEL="EDOC_SECURITY_LEVEL";
	/**
	 * 代码集：会议室资源
	 */
	public static final String CODE_MEETING_ROOM_RESOURCES="MEETING_ROOM_RESOURCES";
	/**
	 * 代码集：资产增加方式
	 */
	public static final String CODE_ASSET_INCREASE_METHOD="ASSET_INCREASE_METHOD";
	/**
	 * 代码集：资产保修方式
	 */
	public static final String CODE_ASSET_WARRANTY_WAY="ASSET_WARRANTY_WAY";
	/**
	 * 代码集：经费来源方式
	 */
	public static final String CODE_ASSET_FUND="ASSET_FUND";
	/*
	 * 代码集：领用用途
	 */
	public static final String CODE_RECIPIENTS_USE="RECIPIENTS_USE";
	/*
	 * 代码集：会议类型
	 */
	public static final String CODE_MEETING_TYPE="MEETING_TYPE";
	/*
	 * 代码集：会务资源
	 */
	public static final String CODE_CONFERENCE_RES="CONFERENCE_RES";


	//其它常量
	/*
     * 消息中心发送配件使用范围 系统内部=1
     */
    public static final String MESSAGE_ACC_RANGE_N="1";
    /*
     * 消息中心发送配件使用范围 外部用户=2
     */
    public static final String MESSAGE_ACC_RANGE_W="2";
    /*
     * 消息中心发送配件使用范围 全部用户=3
     */
    public static final String MESSAGE_ACC_RANGE_ALL="3";
    /**
     * 是否有附件（1为有）
     */
    public static final String SFYFJ_YES="1";
    /**
     * 是否有附件（0为无）
     */
    public static final String SFYFJ_NO="0";
    /**
     * 是否阅读（0为未阅读）
     */
    public static final String SFYD_NO="0";
    /**
     * 是否阅读（1为阅读）
     */
    public static final String SFYD_YES="1";
    /**
     * 是否要回执（1为回执）
     */
    public static final String SFHZ_YES="1";
    /**
     * 是否要回执（0为不回执）
     */
    public static final String SFHZ_NO="0";
    /**
     * 是否要回执（2为多条回执）
     */
    public static final String SFHZ_DT="2";
    /**
     * 回执状态（0为未回执）
     */
    public static final String HZZT_NO="0";
    /**
     * 回执状态（1为已回执）
     */
    public static final String HZZT_YES="1";
    /**
     * 收件箱
     */
    public static final String SJX_CN="收件箱";
    /**
     * 发件箱
     */
    public static final String FJX_CN="发件箱";
    /**
     * 垃圾箱
     */
    public static final String LJX_CN="垃圾箱";
    /**
     * 收件箱
     */
    public static final String SJX="box_accept";
    /**
     * 发件箱
     */
    public static final String FJX="box_send";
    /**
     * 草稿箱
     */
    public static final String CGX="box_draft";
    /**
     * 垃圾箱
     */
    public static final String LJX="box_delete";
    /**
     * 新消息（虚拟信箱）
     */
    public static final String NEWXX="box_new";
    /**
     * 全体人员标识
     */
    public static final String ALLPERSON="ALL";
    
    /**
     * 常量：是或者开
     */
    public static final String KEY_YES="1";
    /**
     * 常量：否或者关
     */
    public static final String KEY_NO="0";
    
    /**
     * 公文发文 ，是否已分发
     */
    public static final String EDOC_IS_ISSUED_YES="1";
    public static final String EDOC_IS_ISSUED_NO="0";
    /**
     * 发文登记状态  草稿   正式
     */
    public static final String EDOC_REGISTER_STATUS_DRAFT="0";
    public static final String EDOC_REGISTER_STATUS_FINAL="1";
    
    /**
     * 只查询 会议纪要 发文类型 ，定义会议纪要ID
     */
    public static final String EDOC_SEND_HYJY_FINAL="468a7070-01f7-4913-93a5-f934ceecde4a";
    
    
}
