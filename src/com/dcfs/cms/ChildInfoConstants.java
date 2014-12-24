package com.dcfs.cms;

/** 
 * @ClassName: ChildInfoConstants 
 * @Description: 儿童材料常量类
 * @author wangzheng
 * @date 2014-9-15 
 *  
 */
public class ChildInfoConstants {
	//1、儿童类型
	public static final String CHILD_TYPE_NORMAL = "1"; //正常儿童
	public static final String CHILD_TYPE_SPECAL = "2"; //特需儿童
	public static final String CHILD_TYPE_OTHER = "9"; //其他
	
	//2、儿童身份
	public static final String CHILD_IDENTITY_FOUNDLING="10";				//	10    查找不到生父母的弃婴和儿童
	public static final String CHILD_IDENTITY_ORPHAN="20";						//	20	丧失父母的孤儿
	public static final String CHILD_IDENTITY_WORPHAN="201";				// 201	社会福利机构送养的丧失父母的孤儿	
	public static final String CHILD_IDENTITY_PORPHAN="202";					//202	社会福利机构外的其他监护人送养的丧失父母的孤儿
	public static final String CHILD_IDENTITY_UNABLE="30";						//30	    生父母有特殊困难无力抚养的子女	
	public static final String CHILD_IDENTITY_NOCIVILCON	="301";		//301	生父母均不具备完全民事行为能力
	public static final String CHILD_IDENTITY_NOCIVILCONDUCT="302";	//302	生父母均不具备完全民事行为能力且对被收养人有严重危害可能的子女
	public static final String CHILD_IDENTITY_KINSHIP="40";						//40	三代以内同辈旁系血亲的子女
	public static final String CHILD_IDENTITY_STEPCHILD ="50";					//50	继子女	
	public static final String CHILD_IDENTITY_UNDOQUALIFICATION="60";//60	依法撤销生父母监护资格的儿童
	
	
	//3、超龄标识
	public static final String IS_OVERAGE_ALERT="1";//	超龄提醒
	public static final String IS_OVERAGE_DONE="2";//	已超龄
	
	//20、材料办理级别
	public static final String LEVEL_WELFARE="1";//	福利院
	public static final String LEVEL_PROVINCE="2";//	省厅
	public static final String LEVEL_CCCWA="3";//	中心
	
	//30、材料翻译类型
	public static final String TRANSLATION_TYPE_TR="0";//	材料翻译
	public static final String TRANSLATION_TYPE_ST="1";//	补充翻译
	public static final String TRANSLATION_TYPE_RT="2";//	重新翻译	
	public static final String TRANSLATION_TYPE_UT="3";//	更新翻译	
	
	//31、材料翻译状态
	public static final String TRANSLATION_STATE_TODO="0";//	待翻译
	public static final String TRANSLATION_STATE_DOING="1";//	翻译中
	public static final String TRANSLATION_STATE_DONE="2";//	已翻译	
	
	//40、组织机构类型
	public static final String ORGAN_TYPE_FLY="5";// 福利院 
	public static final String ORGAN_TYPE_ZX="1";//中心
	public static final String ORGAN_TYPE_ST="7";//省厅单位
	
	public ChildInfoConstants() {
		// TODO Auto-generated constructor stub
	}
}
