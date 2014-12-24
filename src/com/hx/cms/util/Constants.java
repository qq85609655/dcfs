package com.hx.cms.util;

public class Constants {

    //分页大小
    public static final int DEFAULT_PAGE_SIZE = 15;
    
    /**
     * 配置文件名字
     */
    public static final String CMS_CONFIG_FILE = "cms-config";
    
    /**
     * 弹出栏目ID的key --------- 从配置文件获取对应的value
     */
    public static final String SKIP_CHANNEL_ID = "skip_channel_id";
    
    /**
     * 数据访问权限
     */
    public static final String DATA_ACCESS_PERMISSION = "data_access_permission";
    
	/**
	 * 管理模式：三员
	 */
	public static final String ADMIN_MODE_THREE_MEMBER = "1";
	/**
	 * 管理模式：多级管理
	 */
	public static final String ADMIN_MODE_MULTISTAGE = "2";
	
	/**
	 * 管理模式：key
	 */
	public static final String ADMIN_MODE = "admin_mode";
	/**
	 * 一拖N模式
	 */
	public static final String N_MODE = "1n_mode";
	/**
	 * 前台标签数据的过滤是否需要用户登录
	 */
	public static final String IS_LOGIN = "is_login";
}
