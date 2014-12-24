package com.dcfs.ffs.common;

/**
 * 
 * @description 文件全局状态和位置常量类
 * @author MaYun
 * @date Jul 28, 2014
 * @return
 */
public class FileGlobalStatusAndPositionConstant {
	/**
	 * 
	 * @description 构造方法
	 * @author MaYun
	 * @date Jul 28, 2014
	 * @return
	 */
	public FileGlobalStatusAndPositionConstant(){
		// TODO Auto-generated constructor stub
	}
	
	//***********文件位置常量begin*********************/
	public static final String POS_SYZZ="0010";//文件位置：收养组织
	public static final String POS_SYZZTOBGS="1020";//文件位置：收养组织-办公室
	public static final String POS_BGS="0020";//文件位置：办公室
	public static final String POS_BGSTOFYGS="2080";//文件位置：办公室-翻译公司
	public static final String POS_FYGS="0080";//文件位置：翻译公司
	public static final String POS_FYGSTOSHB="8030";//文件位置：翻译公司-审核部
	public static final String POS_SHB="0030";//文件位置：审核部
	public static final String POS_SHBTODAB="3040";//文件位置：审核部-档案部
	public static final String POS_DAB="0040";//文件位置：档案部
	

	
	
	//***********文件位置常量end*********************/
	
	//***********文件全局状态常量begin*********************/
	public static final String STA_WTJ="00";//文件全局状态：未提交
	public static final String STA_DDJ="01";//文件全局状态：待登记
	public static final String STA_SWDJDBC="02";//文件全局状态：收文登记待补充
	public static final String STA_DJDSF="03";//文件全局状态：登记待送翻
	public static final String STA_SFZ="04";//文件全局状态：送翻中
	public static final String STA_SFDJS="05";//文件全局状态：送翻待接收
	public static final String STA_WJDFY="10";//文件全局状态：文件待翻译
	public static final String STA_WJFYZ="11";//文件全局状态：文件翻译中
	public static final String STA_YFYDYJ="12";//文件全局状态：已翻译待移交
	public static final String STA_YFYDYJ2="13";//文件全局状态：已翻译待移交
	public static final String STA_YBDJS="14";//文件全局状态：一部待接收
	public static final String STA_JBRDSH="20";//文件全局状态：经办人待审核
	public static final String STA_JBRSHZ="21";//文件全局状态：经办人审核中
	public static final String STA_JBRSHZ2="22";//文件全局状态：经办人审核中
	public static final String STA_JBRSHZ3="23";//文件全局状态：经办人审核中
	public static final String STA_BMZRFH="24";//文件全局状态：部门主任复核
	public static final String STA_FGZRSP="25";//文件全局状态：分管主任审批
	public static final String STA_JBRSH="35";//文件全局状态：经办人审核
	public static final String STA_SHBTGDTW="26";//文件全局状态：审核不通过待退文
	public static final String STA_SHBTGDTW2="27";//文件全局状态：审核不通过待退文
	public static final String STA_BTWDJS="28";//文件全局状态：办退文待接收
	public static final String STA_BTWDJS2="29";//文件全局状态：办退文待寄送
	public static final String STA_BTWYJS="30";//文件全局状态：办退文已寄送
	public static final String STA_DYJDAB="31";//文件全局状态：待移交档案部
	public static final String STA_DYJDAB2="32";//文件全局状态：待移交档案部
	public static final String STA_DABDJS="33";//文件全局状态：档案部待接收
	public static final String STA_DPP="34";//文件全局状态：待匹配
	public static final String STA_ZT="40";//文件全局状态：暂停
	public static final String STA_PPJBRDSH="50";//文件全局状态：匹配经办人待审核	
	public static final String STA_PPBMZRDFH="51";//文件全局状态：匹配部门主任待复核
	public static final String STA_DZQYJ="53";//文件全局状态：待征求意见
	public static final String STA_ZQYJZ="54";//文件全局状态：征求意见中
	public static final String STA_ZQYJZ2="55";//文件全局状态：征求意见中
	public static final String STA_ZQYJFKQR="56";//文件全局状态：征求意见反馈确认
	public static final String STA_ZQYJFKQR_TY="560";//文件全局状态：征求意见反馈确认同意
	public static final String STA_ZQYJFKQR_CXPP="561";//文件全局状态：征求意见反馈确认重新匹配
	public static final String STA_ZQYJFKQR_TW="562";//文件全局状态：征求意见反馈确认退文
	public static final String STA_DPP2="57";//文件全局状态：待匹配
	public static final String STA_DQP="58";//文件全局状态：待签批
	public static final String STA_DJF="59";//文件全局状态：待寄发
	public static final String STA_YJF="60";//文件全局状态：已寄发
	public static final String STA_YDJ="61";//文件全局状态：已登记
	public static final String STA_WXDJ="62";//文件全局状态：无效登记
	public static final String STA_BGYFK="70";//文件全局状态：报告已反馈(1)
	public static final String STA_BGDFY="71";//文件全局状态：报告待翻译（1）
	public static final String STA_BGDSH="72";//文件全局状态：报告待审核（1）
	public static final String STA_BGSHZ="73";//文件全局状态：报告审核中（1）
	public static final String STA_BGSTG="74";//文件全局状态：报告审通过（1）
	public static final String STA_BGYFK2="75";//文件全局状态：报告已反馈（2）
	public static final String STA_BGDFY2="76";//文件全局状态：报告待翻译（2）
	public static final String STA_BGDSH2="77";//文件全局状态：报告待审核（2）
	public static final String STA_BGSHZ2="78";//文件全局状态：报告审核中（2）
	public static final String STA_BGSTG2="79";//文件全局状态：报告审通过（2）
	public static final String STA_BGYFK3="80";//文件全局状态：报告已反馈（3）
	public static final String STA_BGDFY3="81";//文件全局状态：报告待翻译（3）
	public static final String STA_BGDSH3="82";//文件全局状态：报告待审核（3）
	public static final String STA_BGSHZ3="83";//文件全局状态：报告审核中（3）
	public static final String STA_BGSTG3="84";//文件全局状态：报告审通过（3）
	public static final String STA_BGYFK4="85";//文件全局状态：报告已反馈（4）
	public static final String STA_BGDFY4="86";//文件全局状态：报告待翻译（4）
	public static final String STA_BGDSH4="87";//文件全局状态：报告待审核（4）
	public static final String STA_BGSHZ4="88";//文件全局状态：报告审核中（4）
	public static final String STA_BGSTG4="89";//文件全局状态：报告审通过（4）
	public static final String STA_BGYFK5="90";//文件全局状态：报告已反馈（5）
	public static final String STA_BGDFY5="91";//文件全局状态：报告待翻译（5）
	public static final String STA_BGDSH5="92";//文件全局状态：报告待审核（5）
	public static final String STA_BGSHZ5="93";//文件全局状态：报告审核中（5）
	public static final String STA_BGSTG5="94";//文件全局状态：报告审通过（5）
	public static final String STA_BGYFK6="95";//文件全局状态：报告已反馈（6）
	public static final String STA_BGDFY6="96";//文件全局状态：报告待翻译（6）
	public static final String STA_BGDSH6="97";//文件全局状态：报告待审核（6）
	public static final String STA_BGSHZ6="98";//文件全局状态：报告审核中（6）
	public static final String STA_YBJ="99";//文件全局状态：已办结
	//***********文件全局状态常量end*********************/

	
	
	
	
}
