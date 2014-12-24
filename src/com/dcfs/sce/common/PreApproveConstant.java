package com.dcfs.sce.common;

/**
 * 
 * @description 文件操作常量类
 * @author MaYun
 * @date Jul 28, 2014
 * @return
 */
public class PreApproveConstant {
	/**
	 * 
	 * <p>Title: </p> 
	 * <p>Description: </p>
	 */
	public PreApproveConstant(){
		// TODO Auto-generated constructor stub
	}
	

    //******预批状态begin*********
	public static final String PRE_APPROVAL_WTJ="0";	//未提交
	public static final String PRE_APPROVAL_YTJ="1";	//已提交
	public static final String PRE_APPROVAL_SHZ="2";	//审核中
	public static final String PRE_APPROVAL_SHBTG="3";	//审核不通过
	public static final String PRE_APPROVAL_SHTG="4";	//申通通过
	public static final String PRE_APPROVAL_WQD="5";	//未启动
	public static final String PRE_APPROVAL_YQD="6";	//已启动
	public static final String PRE_APPROVAL_YPP="7";	//已匹配
	public static final String PRE_APPROVAL_WX="9";		//无效
	//******预批状态end*********
	
}
