/**   
 * @Title: DcfsConstants.java 
 * @Package com.dcfs.common 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn@21softech.com   
 * @date 2014-7-15 ����9:49:13 
 * @version V1.0   
 */
package com.dcfs.common.atttype;

import hx.database.databean.DataList;

/** 
 * @ClassName: AttConstants 
 * @Description: ���������С�ೣ��
 * @author mayun
 * @date 2014-8-7
 *  
 */
public class AttConstants {

	
	public AttConstants() {
		
	}

	/**********************�������ೣ������begin***********************/
	public static final String CI="1";//��ͯ���ϴ���
	public static final String AR="2";//�����ļ�����
	public static final String AF="3";//��ͥ�����ļ�����
	public static final String AF_PARENTS="301";//��ͥ�����ļ�-˫������
	public static final String AF_SIGNALPARENT="302";//��ͥ�����ļ�-��������
	public static final String AF_STEPCHILD="303";//��ͥ�����ļ�-����Ů����
	
	public static final String CI_NORMAL_FOUNDLING ="1011";//��ͯ����-����-���Ҳ�������ĸ����Ӥ�Ͷ�ͯ
	public static final String CI_NORMAL_FOUNDLING_ADOPT ="1012";//��ͯ����-����-���Ҳ�������ĸ����Ӥ�Ͷ�ͯ-������֯
	public static final String CI_SPECIAL_FOUNDLING ="1111";//��ͯ����-����-���Ҳ�������ĸ����Ӥ�Ͷ�ͯ
	public static final String CI_SPECIAL_FOUNDLING_ADOPT ="1112";//��ͯ����-����-���Ҳ�������ĸ����Ӥ�Ͷ�ͯ-������֯
	
	public static final String CI_NORMAL_KINSHIP ="1021";//��ͯ����-����-����������ϵѪ�׵���Ů
	public static final String CI_NORMAL_KINSHIP_ADOPT ="1022";//��ͯ����-����-����������ϵѪ�׵���Ů-������֯
	public static final String CI_SPECIAL_KINSHIP ="1121";//��ͯ����-����-����������ϵѪ�׵���Ů
	public static final String CI_SPECIAL_KINSHIP_ADOPT ="1122";//��ͯ����-����-����������ϵѪ�׵���Ů-������֯
	
	public static final String CI_NORMAL_STEPCHILD ="1031";//��ͯ����-����-����Ů
	public static final String CI_NORMAL_STEPCHILD_ADOPT  ="1032";//��ͯ����-����-����Ů-������֯
	public static final String CI_SPECIAL_STEPCHILD ="1131";//��ͯ����-����-����Ů
	public static final String CI_SPECIAL_STEPCHILD_ADOPT ="1132";//��ͯ����-����-����Ů-������֯
	
	public static final String CI_NORMAL_WORPHAN ="1041";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-����������������
	public static final String CI_NORMAL_WORPHAN_ADOPT  ="1042";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-����������������-������֯
	public static final String CI_SPECIAL_WORPHAN ="1141";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-����������������
	public static final String CI_SPECIAL_WORPHAN_ADOPT ="1142";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-����������������-������֯
	
	public static final String CI_NORMAL_PORPHAN ="1051";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-�໤����������
	public static final String CI_NORMAL_PORPHAN_ADOPT  ="1052";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-�໤����������-������֯
	public static final String CI_SPECIAL_PORPHAN ="1151";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-�໤����������
	public static final String CI_SPECIAL_PORPHAN_ADOPT ="1152";//��ͯ����-����-ɥʧ��ĸ�Ĺ¶�-�໤����������-������֯
	
	public static final String CI_NORMAL_PUNABLE ="1061";//��ͯ����-����-����ĸ����������������������Ů-����ĸ�����߱���ȫ������Ϊ����
	public static final String CI_NORMAL_PUNABLE_ADOPT  ="1062";//��ͯ����-����-����ĸ����������������������Ů-����ĸ�����߱���ȫ������Ϊ����-������֯
	public static final String CI_SPECIAL_PUNABLE ="1161";//��ͯ����-����-����ĸ����������������������Ů-����ĸ�����߱���ȫ������Ϊ����
	public static final String CI_SPECIAL_PUNABLE_ADOPT ="1162";//��ͯ����-����-����ĸ����������������������Ů-����ĸ�����߱���ȫ������Ϊ����-������֯
	
	public static final String CI_NORMAL_NOCIVILCONDUCT ="1071";//��ͯ����-����-����ĸ�����߱���ȫ������Ϊ�����ҶԱ�������������Σ�����ܵ���Ů
	public static final String CI_NORMAL_NOCIVILCONDUCT_ADOPT  ="1072";//��ͯ����-����-����ĸ�����߱���ȫ������Ϊ�����ҶԱ�������������Σ�����ܵ���Ů-������֯
	public static final String CI_SPECIAL_NOCIVILCONDUCT ="1171";//��ͯ����-����-����ĸ�����߱���ȫ������Ϊ�����ҶԱ�������������Σ�����ܵ���Ů
	public static final String CI_SPECIAL_NOCIVILCONDUCT_ADOPT ="1172";//��ͯ����-����-����ĸ�����߱���ȫ������Ϊ�����ҶԱ�������������Σ�����ܵ���Ů-������֯
	
	public static final String AR_NORMAL ="1200";//���ú󱨸�-һ��
	public static final String AR_CHANGE_FAMILY ="1210";//���ú󱨸�-������ͥ-
	public static final String AR_DEAD ="1220";//���ú󱨸�-����
	
	public static final String FAM="7";//���ô���
	/**********************�������ೣ������end*************************/

	/**********************����С�ೣ������begin***********************/
	public static final String CI_TJB="34";//����-����
	public static final String CI_CZBG="35";//�ɳ�����-����
	public static final String CI_CZZK="36";//�ɳ�״��-����
	public static final String CI_HYD="37";//���鵥-����
	public static final String CI_SHZP="38";//������Ƭ-����
	public static final String CI_SHDP="39";//�����Ƭ-����
	public static final String CI_TSJC="40";//������-����
	public static final String CI_ZJZP="41";//֤����Ƭ-����
	public static final String CI_CJSQ="42";//�м���ǰ��Ƭ-����
	public static final String CI_SSXJ="43";//����С��-����
	public static final String CI_CJSH="44";//�м�������Ƭ-����
	public static final String CI_BCCL="45";//�������
	public static final String CI_QTZL="46";//��������
	public static final String CI_HZCL="47";//���ܲ���	
	public static final String CI_YMK="48";//���翨(���Ϲ�Ŀǰû�ж�Ӧ)
	public static final String CI_CLTW="71";//��������
	
	public static final String CI_IMAGE="51";//ͷ��	
	
	public static final String CI_SWSYSCYJB="90";//����������������
	public static final String CI_FLJGFZRSFZFYJ="91";//�����������������֤��ӡ��
	public static final String CI_BSYRHJZM="92";//�������˻���֤��
	public static final String CI_JSBAZM="93";//��ʰ����֤��
	public static final String CI_FLYJSQY="94";//��������������Ӥ��¶���Ժ�ǼǱ�
	public static final String CI_GG="95";//����
	public static final String CI_SYRHJZM="96";//�����˵Ļ���֤�������֤��ӡ��
	public static final String CI_SYRBWFJHSY="97";//�������뵱�ؼƻ���������ǩ���Ĳ�Υ���ƻ������涨��Э��
	public static final String CI_QSGXZM="98";//�������Ż�֤���ų��ߵ������ˡ������˺ͱ������˵�������ϵ֤��
	public static final String CI_SYRTYSYSM="99";//������ͬ������������
	public static final String CI_SYRJHZM="100";//�����˽��֤����������Ϊ����˫��������ߣ�
	public static final String CI_BSYRTYSY="101";//��������ͬ�ⱻ��������������������10����������ߣ�
	public static final String CI_QZGXZM="102";//�������뱻������֮������ӹ�ϵ֤��
	public static final String CI_TYSYSMYJ="103";//����ĸ��໤��ͬ���������������
	public static final String CI_SYETSFMSWZM="104";//��������ͯ����ĸ����֤��
	
	public static final String CI_QTTYSYSMYJ="105";//�����и����������ͬ���������������
	public static final String CI_BSYRYZWHKNZM="106";//��ĸ���߱���ȫ������Ϊ������֤��
	//public static final String CI_BSYRCSZM="108";//�������˵ĳ���֤��
	public static final String CI_WLFYZM="107";//����ĸ��������������������֤��
	
	public static final String CI_JHRCDJHZZZM="109";//�໤��ʵ�ʳе��໤���ε�֤��
	public static final String CI_SFMYFSWZM="110";//����ĸһ�������������䲻����֤��
	public static final String CI_BXSYXFYQZM="111";//�����������䲻��һ���ĸ�ĸ����ʹ���ȸ���Ȩ����������
	public static final String CI_YZWHKNZM="112";//����ĸ˫�������߱���ȫ������Ϊ�����ҶԱ�������������Σ�����ܵ�֤��
	
	public static final String AR_BGZW="2";//��������
	public static final String AR_TXFK="3";//���������ͯ���������
	public static final String AR_RJZM="5";//�뼮֤��
	public static final String AR_SSDW="6";//ʮ�����ϱ��������Լ�׫д�Ķ���
	public static final String AR_BCFK="7";//�������䷴���ϴ�
	public static final String AR_BSYRJKZM="8";//�����������彡�����֤��
	public static final String AR_BSYRPY="9";//������������ѧУ���׶�԰���ߵ�������Ƭ
	public static final String AR_IMAGE="10";//��Ƭ
	
	public static final String AR_BGJTQKBG="11";//�����ͥ�������
	public static final String AR_YSYRFQJHQZM="12";//ԭ�����˷����໤Ȩ֤��
	public static final String AR_FYPJZZSYPJS="13";//��Ժ�о���ֹ�����о���
	public static final String AR_XSYRSYSQS="14";//������������������
	public static final String AR_XSYRJTDCBG="15";//�������˵ļ�ͥ���鱨��
	public static final String AR_FYPJS="16";//��Ժ�о���
	public static final String AR_QTZMWJ="17";//'����֤���ļ�

	public static final String AR_ETSWQKBG="18";//��ͯ�����������
	public static final String AR_BSYRSWZM="19";//ҽ�ƻ������ߵı�����������֤����ʬ��֤��
	public static final String AR_DCBG="20";//�йػ������ߵĵ������
	
	public static final String AF_MALEPHOTO="55";//����������Ƭ
	public static final String AF_FEMALEPHOTO="56";//Ů��������Ƭ
	public static final String AF_KGSY="58";//�������������
	public static final String AF_CSZM="59";//����֤��
	public static final String AF_HYZK="60";//����״��֤��
	public static final String AF_ZJCZM="61";//ְҵ����������ͲƲ�״��֤��
	public static final String AF_STJK="62";//���彡�����֤��
	public static final String AF_XSCF="63";//�����ܹ����´���֤��
	public static final String AF_JTQK="64";//��ͥ�������
	public static final String AF_KGSYZM="65";//���ڹ����ܻ���ͬһ�ڿ������֤��
	public static final String AF_HZFY="66";//���ո�ӡ��
	public static final String AF_SHZP="67";//����ռ�������
	public static final String AF_TJX="68";//�Ƽ���
	public static final String AF_XLDC="69";//������鱨��
	public static final String AF_WJBC="70";//�ļ�����
	public static final String AF_WJTW="71";//�ļ�����
	public static final String AF_DQSM="72";//��������
	public static final String AF_FTSM="73";//��ͬ��������
	public static final String AF_JHRSM="80";//�໤������
	
	public static final String AF_BFTZ="81";//����֪ͨ
	public static final String AF_BFFJ="82";//��������
	
	public static final String AF_YPBCFJ="90";//Ԥ�����丽��
	
	
	
	public static final String FAW_JFPJ="1";//�ɷ�ƾ��
	/**********************����С�ೣ������end*************************/
	
	/**********************ƥ����������ɵĸ���С�ೣ������begin*************************/
	//����������ڼ�ͥ�ļ�������AF����
	public static final String ZQYJS="3001";//����������������������������飨��Լ������
	public static final String ZQYJSSY="3002";//����������������������������飨��Լ��������ˮӡ
	public static final String LHSYZNTZS="3003";//����������Ů֪ͨ��
	public static final String LHSYZNTZSSY="3004";//����������Ů֪ͨ���ˮӡ
	public static final String LHSYZNTZSFB="3005";//����������Ů֪ͨ�鸱��
	public static final String SWSYTZ="3006";//��������֪ͨ
	public static final String SWSYTZFB="3007";//��������֪ͨ����
	public static final String SYDJSQS="3008";//�����Ǽ�������
	public static final String SYDJZ="3009";//�����Ǽ�֤
	public static final String KGSYHGZM="3010";//��������ϸ�֤��
	
	/**********************ƥ����������ɵĸ���С�ೣ������end*************************/
			
}
