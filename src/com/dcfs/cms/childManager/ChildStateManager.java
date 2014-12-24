package com.dcfs.cms.childManager;

import com.dcfs.cms.ChildInfoConstants;


public class ChildStateManager {
	//1、材料审核状态
	public static String CHILD_AUD_STATE_WTJ="0";//0：未提交
	public static String CHILD_AUD_STATE_SDS="1";//1：省待审
	public static String CHILD_AUD_STATE_SSHZ="2";//2：省审核中
	public static String CHILD_AUD_STATE_SBTG="3";//3：省不通过
	public static String CHILD_AUD_STATE_STG="4";//4：省通过
	public static String CHILD_AUD_STATE_YJS="5";//5、已寄送
	public static String CHILD_AUD_STATE_YJIES="6";//6、已接收
	public static String CHILD_AUD_STATE_ZXSHZ="7";//7：中心审核中
	public static String CHILD_AUD_STATE_ZXBTG="8";//8：中心不通过
	public static String CHILD_AUD_STATE_ZXTG="9";//9：中心通过
	
	//2、材料审核结果
	public static String CHILD_AUD_OPTION_REPORT="1";//上报
	public static String CHILD_AUD_OPTION_SUCCESS="2";//通过
	public static String CHILD_AUD_OPTION_FAILURE="3";//不通过
	public static String CHILD_AUD_OPTION_ADDITIONAL="4";//补充
	public static String CHILD_AUD_OPTION_ADDTRANS="5";//补翻
	public static String CHILD_AUD_OPTION_RETRANS="6";//重翻
	public static String CHILD_AUD_OPTION_RETURN="7";//退回经办人
	public static String CHILD_AUD_OPTION_REPORTBOSS="8";//上报分管主任
	
	//3、材料补充状态
	public static String CHILD_ADD_STATE_TODO="0";// 0 待补充
	public static String CHILD_ADD_STATE_DOING="1";// 1 补充中
	public static String CHILD_ADD_STATE_DONE="2";// 2 已补充
	
	//4、材料接收状态
	public static String CHILD_RECEIVE_STATE_TODO="0";//0待接收
	public static String CHILD_RECEIVE_STATE_DONE="1";//1已接收
	
	//5、材料匹配状态
	public static String CHILD_MATCH_STATE_TODO="0";//0待匹配
	public static String CHILD_MATCH_STATE_DONE="1";//1已匹配
	
	//6、发布状态	
	public static String CHILD_PUB_STATE_TODO="0";//0：待发布
	public static String CHILD_PUB_STATE_PLAN="1";//1：计划中
	public static String CHILD_PUB_STATE_PUBLISH="2";//2：已发布
	public static String CHILD_PUB_STATE_LOCK="3";//3：已锁定
	public static String CHILD_PUB_STATE_REQ="4";//4:已申请
	
	//7、材料审核后续操作
	public static String CHILD_AUD_RESULT_TRAN="1";//1：送翻
	public static String CHILD_AUD_RESULT_MATCH="2";//2：直接匹配
	public static String CHILD_AUD_RESULT_PUB="3";//3：直接发布
	
	//8、材料代录标识
	public static String CHILD_DAILU_FLAG_PROVINCE="2";//2：省厅代录
	public static String CHILD_DAILU_FLAG_CCCWA="3";//3：中心代录
	
	//9、退材料确认状态
	public static String CHILD_RETURN_STATE_SDS="1";		//1：省待审
	public static String CHILD_RETURN_STATE_ZXDS="2";	//2：中心待审
	public static String CHILD_RETURN_STATE_TG="3";		//3：中心通过
	public static String CHILD_RETURN_STATE_QX="9";		//9：取消
	
	//10、退文类型
	public static String  CHILD_BACK_TYPE_FSQ="1";//福利院申请退文
	public static String  CHILD_BACK_TYPE_SBG="2";//省厅审核不通过退文
	public static String  CHILD_BACK_TYPE_SSQ="3";//省厅申请退文
	public static String  CHILD_BACK_TYPE_ZXTW="5";//安置部退文录入
	public static String  CHILD_BACK_TYPE_ZXBG="6";//6：安置部审核不通过退文
	public static String  CHILD_BACK_TYPE_XTTW="7";//7：系统自动退文
	
	//11、退材料结果状态（只用于儿童材料信息表【CMS_CI_INFO】退材料状态（RETURN_STATE）的更新）
	public static String CHILD_RETURN_STATE_FLAG="1";//退材料标识
	
	//12、退材料原因描述
	public static String CHILD_RETURN_REASON_SBG="省厅审核不通过";//省审核不通过
	public static String CHILD_RETURN_REASON_ZXBG="中心审核不通过";//中心审核不通过
	
	//操作状态
	public static String OPERATION_STATE_TODO="0";//待处理
	public static String OPERATION_STATE_DOING="1";//1:处理中
	public static String OPERATION_STATE_DONE="2";//2:已处理
	
	//儿童材料更新状态
	public static String CHILD_UPDATE_STATE_WTJ="0";// 0 未提交
	public static String CHILD_UPDATE_STATE_SDS="1";// 1 省待审
	public static String CHILD_UPDATE_STATE_ZXDS="2";// 2 中心待审
	public static String CHILD_UPDATE_STATE_TG="3";// 3 通过
	public static String CHILD_UPDATE_STATE_BTG="4";// 4不通过
	
	
	/*
	 * 获得材料审核状态
	 */
	public String getChildAudState(String curAUD_STATE,String AUDIT_LEVEL,String AUDIT_OPTION,String OPERATION_STATE){
		String AUD_STATE = "";
		
		if(ChildStateManager.OPERATION_STATE_DOING.equals(OPERATION_STATE)){						//1操作为保存
			AUD_STATE =  curAUD_STATE;		
		}else if(ChildStateManager.OPERATION_STATE_DONE.equals(OPERATION_STATE)){					//2操作为提交
			if(ChildInfoConstants.LEVEL_PROVINCE.equals(AUDIT_LEVEL)){											//2.1省厅审核
				if(ChildStateManager.CHILD_AUD_OPTION_SUCCESS.equals(AUDIT_OPTION)){				//2.1.1通过
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_STG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_FAILURE.equals(AUDIT_OPTION)){		//2.1.2不通过
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_SBTG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL.equals(AUDIT_OPTION)){//2.1.3补充
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_SSHZ;
				}
			}else if(ChildInfoConstants.LEVEL_CCCWA.equals(AUDIT_LEVEL)){										//2.2中心审核
				if(ChildStateManager.CHILD_AUD_OPTION_SUCCESS.equals(AUDIT_OPTION)){				//2.2.1通过
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_ZXTG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_FAILURE.equals(AUDIT_OPTION)){		//2.2.2不通过
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_ZXBTG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL.equals(AUDIT_OPTION)){//2.2.3补充
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_ZXSHZ;
				}
			}
		}	
		return AUD_STATE;
	}
	
	

	public static void main(String[] args){
				
	}
	
}
