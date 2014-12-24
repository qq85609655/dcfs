/**   
 * @Title: DcfsConstants.java 
 * @Package com.dcfs.common 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn@21softech.com   
 * @date 2014-7-15 上午9:49:13 
 * @version V1.0   
 */
package com.dcfs.common.atttype;

import hx.database.databean.DataList;

/** 
 * @ClassName: AttConstants 
 * @Description: 附件大类和小类常量
 * @author mayun
 * @date 2014-8-7
 *  
 */
public class AttConstants {

	
	public AttConstants() {
		
	}

	/**********************附件大类常量定义begin***********************/
	public static final String CI="1";//儿童材料大类
	public static final String AR="2";//档案文件大类
	public static final String AF="3";//家庭收养文件大类
	public static final String AF_PARENTS="301";//家庭收养文件-双亲收养
	public static final String AF_SIGNALPARENT="302";//家庭收养文件-单亲收养
	public static final String AF_STEPCHILD="303";//家庭收养文件-继子女收养
	
	public static final String CI_NORMAL_FOUNDLING ="1011";//儿童材料-正常-查找不到生父母的弃婴和儿童
	public static final String CI_NORMAL_FOUNDLING_ADOPT ="1012";//儿童材料-正常-查找不到生父母的弃婴和儿童-收养组织
	public static final String CI_SPECIAL_FOUNDLING ="1111";//儿童材料-特需-查找不到生父母的弃婴和儿童
	public static final String CI_SPECIAL_FOUNDLING_ADOPT ="1112";//儿童材料-特需-查找不到生父母的弃婴和儿童-收养组织
	
	public static final String CI_NORMAL_KINSHIP ="1021";//儿童材料-正常-三代以内旁系血亲的子女
	public static final String CI_NORMAL_KINSHIP_ADOPT ="1022";//儿童材料-正常-三代以内旁系血亲的子女-收养组织
	public static final String CI_SPECIAL_KINSHIP ="1121";//儿童材料-特需-三代以内旁系血亲的子女
	public static final String CI_SPECIAL_KINSHIP_ADOPT ="1122";//儿童材料-特需-三代以内旁系血亲的子女-收养组织
	
	public static final String CI_NORMAL_STEPCHILD ="1031";//儿童材料-正常-继子女
	public static final String CI_NORMAL_STEPCHILD_ADOPT  ="1032";//儿童材料-正常-继子女-收养组织
	public static final String CI_SPECIAL_STEPCHILD ="1131";//儿童材料-特需-继子女
	public static final String CI_SPECIAL_STEPCHILD_ADOPT ="1132";//儿童材料-特需-继子女-收养组织
	
	public static final String CI_NORMAL_WORPHAN ="1041";//儿童材料-正常-丧失父母的孤儿-福利机构作送养人
	public static final String CI_NORMAL_WORPHAN_ADOPT  ="1042";//儿童材料-正常-丧失父母的孤儿-福利机构作送养人-收养组织
	public static final String CI_SPECIAL_WORPHAN ="1141";//儿童材料-特需-丧失父母的孤儿-福利机构作送养人
	public static final String CI_SPECIAL_WORPHAN_ADOPT ="1142";//儿童材料-特需-丧失父母的孤儿-福利机构作送养人-收养组织
	
	public static final String CI_NORMAL_PORPHAN ="1051";//儿童材料-正常-丧失父母的孤儿-监护人作送养人
	public static final String CI_NORMAL_PORPHAN_ADOPT  ="1052";//儿童材料-正常-丧失父母的孤儿-监护人作送养人-收养组织
	public static final String CI_SPECIAL_PORPHAN ="1151";//儿童材料-特需-丧失父母的孤儿-监护人作送养人
	public static final String CI_SPECIAL_PORPHAN_ADOPT ="1152";//儿童材料-特需-丧失父母的孤儿-监护人作送养人-收养组织
	
	public static final String CI_NORMAL_PUNABLE ="1061";//儿童材料-正常-生父母有特殊困难无力抚养的子女-生父母均不具备完全民事行为能力
	public static final String CI_NORMAL_PUNABLE_ADOPT  ="1062";//儿童材料-正常-生父母有特殊困难无力抚养的子女-生父母均不具备完全民事行为能力-收养组织
	public static final String CI_SPECIAL_PUNABLE ="1161";//儿童材料-特需-生父母有特殊困难无力抚养的子女-生父母均不具备完全民事行为能力
	public static final String CI_SPECIAL_PUNABLE_ADOPT ="1162";//儿童材料-特需-生父母有特殊困难无力抚养的子女-生父母均不具备完全民事行为能力-收养组织
	
	public static final String CI_NORMAL_NOCIVILCONDUCT ="1071";//儿童材料-正常-生父母均不具备完全民事行为能力且对被收养人有严重危害可能的子女
	public static final String CI_NORMAL_NOCIVILCONDUCT_ADOPT  ="1072";//儿童材料-正常-生父母均不具备完全民事行为能力且对被收养人有严重危害可能的子女-收养组织
	public static final String CI_SPECIAL_NOCIVILCONDUCT ="1171";//儿童材料-特需-生父母均不具备完全民事行为能力且对被收养人有严重危害可能的子女
	public static final String CI_SPECIAL_NOCIVILCONDUCT_ADOPT ="1172";//儿童材料-特需-生父母均不具备完全民事行为能力且对被收养人有严重危害可能的子女-收养组织
	
	public static final String AR_NORMAL ="1200";//安置后报告-一般
	public static final String AR_CHANGE_FAMILY ="1210";//安置后报告-更换家庭-
	public static final String AR_DEAD ="1220";//安置后报告-死亡
	
	public static final String FAM="7";//费用大类
	/**********************附件大类常量定义end*************************/

	/**********************附件小类常量定义begin***********************/
	public static final String CI_TJB="34";//体检表-正常
	public static final String CI_CZBG="35";//成长报告-正常
	public static final String CI_CZZK="36";//成长状况-正常
	public static final String CI_HYD="37";//化验单-正常
	public static final String CI_SHZP="38";//生活照片-特需
	public static final String CI_SHDP="39";//生活短片-特需
	public static final String CI_TSJC="40";//特殊检查-特需
	public static final String CI_ZJZP="41";//证件照片-特需
	public static final String CI_CJSQ="42";//残疾术前照片-特需
	public static final String CI_SSXJ="43";//手术小节-特需
	public static final String CI_CJSH="44";//残疾术后照片-特需
	public static final String CI_BCCL="45";//补充材料
	public static final String CI_QTZL="46";//其他资料
	public static final String CI_HZCL="47";//汇总材料	
	public static final String CI_YMK="48";//疫苗卡(和紫光目前没有对应)
	public static final String CI_CLTW="71";//材料退文
	
	public static final String CI_IMAGE="51";//头像	
	
	public static final String CI_SWSYSCYJB="90";//涉外送养审查意见表
	public static final String CI_FLJGFZRSFZFYJ="91";//福利机构负责人身份证复印件
	public static final String CI_BSYRHJZM="92";//被收养人户籍证明
	public static final String CI_JSBAZM="93";//捡拾报案证明
	public static final String CI_FLYJSQY="94";//福利机构接受弃婴或孤儿入院登记表
	public static final String CI_GG="95";//公告
	public static final String CI_SYRHJZM="96";//送养人的户籍证明及身份证复印件
	public static final String CI_SYRBWFJHSY="97";//送养人与当地计划生育部门签订的不违反计划生育规定的协议
	public static final String CI_QSGXZM="98";//公安部门或公证部门出具的送养人、收养人和被收养人的亲属关系证明
	public static final String CI_SYRTYSYSM="99";//送养人同意送养的声明
	public static final String CI_SYRJHZM="100";//送养人结婚证明（送养人为夫妻双方的须出具）
	public static final String CI_BSYRTYSY="101";//被收养人同意被收养的声明（被收养人10岁以上须出具）
	public static final String CI_QZGXZM="102";//送养人与被收养人之间的亲子关系证明
	public static final String CI_TYSYSMYJ="103";//生父母或监护人同意送养的书面意见
	public static final String CI_SYETSFMSWZM="104";//被送养儿童生父母死亡证明
	
	public static final String CI_QTTYSYSMYJ="105";//其他有抚养义务的人同意送养的书面意见
	public static final String CI_BSYRYZWHKNZM="106";//父母不具备完全民事行为能力的证明
	//public static final String CI_BSYRCSZM="108";//被收养人的出生证明
	public static final String CI_WLFYZM="107";//生父母有特殊困难无力抚养的证明
	
	public static final String CI_JHRCDJHZZZM="109";//监护人实际承担监护责任的证明
	public static final String CI_SFMYFSWZM="110";//生父母一方死亡或者下落不明的证明
	public static final String CI_BXSYXFYQZM="111";//死亡或者下落不明一方的父母不行使优先抚养权的书面声明
	public static final String CI_YZWHKNZM="112";//生父母双方均不具备完全民事行为能力且对被收养人有严重危害可能的证明
	
	public static final String AR_BGZW="2";//报告正文
	public static final String AR_TXFK="3";//特殊需求儿童情况反馈表
	public static final String AR_RJZM="5";//入籍证明
	public static final String AR_SSDW="6";//十岁以上被收养人自己撰写的短文
	public static final String AR_BCFK="7";//其他补充反馈上传
	public static final String AR_BSYRJKZM="8";//被收养人身体健康检查证明
	public static final String AR_BSYRPY="9";//被收养人所在学校或幼儿园出具的评语照片
	public static final String AR_IMAGE="10";//照片
	
	public static final String AR_BGJTQKBG="11";//变更家庭情况报告
	public static final String AR_YSYRFQJHQZM="12";//原收养人放弃监护权证明
	public static final String AR_FYPJZZSYPJS="13";//法院判决终止收养判决书
	public static final String AR_XSYRSYSQS="14";//新收养人收养申请书
	public static final String AR_XSYRJTDCBG="15";//新收养人的家庭调查报告
	public static final String AR_FYPJS="16";//法院判决书
	public static final String AR_QTZMWJ="17";//'其他证明文件

	public static final String AR_ETSWQKBG="18";//儿童死亡情况报告
	public static final String AR_BSYRSWZM="19";//医疗机构出具的被收养人死亡证明、尸检证明
	public static final String AR_DCBG="20";//有关机构出具的调查结论
	
	public static final String AF_MALEPHOTO="55";//男收养人照片
	public static final String AF_FEMALEPHOTO="56";//女收养人照片
	public static final String AF_KGSY="58";//跨国收养申请书
	public static final String AF_CSZM="59";//出生证明
	public static final String AF_HYZK="60";//婚姻状况证明
	public static final String AF_ZJCZM="61";//职业、经济收入和财产状况证明
	public static final String AF_STJK="62";//身体健康检查证明
	public static final String AF_XSCF="63";//有无受过刑事处罚证明
	public static final String AF_JTQK="64";//家庭情况报告
	public static final String AF_KGSYZM="65";//所在国主管机关同一期跨国收养证明
	public static final String AF_HZFY="66";//护照复印件
	public static final String AF_SHZP="67";//免冠照及生活照
	public static final String AF_TJX="68";//推荐信
	public static final String AF_XLDC="69";//心里调查报告
	public static final String AF_WJBC="70";//文件补充
	public static final String AF_WJTW="71";//文件退文
	public static final String AF_DQSM="72";//单亲声明
	public static final String AF_FTSM="73";//非同性恋声明
	public static final String AF_JHRSM="80";//监护人声明
	
	public static final String AF_BFTZ="81";//补翻通知
	public static final String AF_BFFJ="82";//补翻附件
	
	public static final String AF_YPBCFJ="90";//预批补充附件
	
	
	
	public static final String FAW_JFPJ="1";//缴费凭据
	/**********************附件小类常量定义end*************************/
	
	/**********************匹配过程中生成的附件小类常量定义begin*************************/
	//本附件存放于家庭文件附件表（AF）中
	public static final String ZQYJS="3001";//征求收养人意见书和征求收养意见书（公约收养）
	public static final String ZQYJSSY="3002";//征求收养人意见书和征求收养意见书（公约收养）加水印
	public static final String LHSYZNTZS="3003";//来华收养子女通知书
	public static final String LHSYZNTZSSY="3004";//来华收养子女通知书加水印
	public static final String LHSYZNTZSFB="3005";//来华收养子女通知书副本
	public static final String SWSYTZ="3006";//涉外送养通知
	public static final String SWSYTZFB="3007";//涉外送养通知副本
	public static final String SYDJSQS="3008";//收养登记申请书
	public static final String SYDJZ="3009";//收养登记证
	public static final String KGSYHGZM="3010";//跨国收养合格证明
	
	/**********************匹配过程中生成的附件小类常量定义end*************************/
			
}
