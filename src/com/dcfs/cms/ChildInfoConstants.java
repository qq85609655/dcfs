package com.dcfs.cms;

/** 
 * @ClassName: ChildInfoConstants 
 * @Description: ��ͯ���ϳ�����
 * @author wangzheng
 * @date 2014-9-15 
 *  
 */
public class ChildInfoConstants {
	//1����ͯ����
	public static final String CHILD_TYPE_NORMAL = "1"; //������ͯ
	public static final String CHILD_TYPE_SPECAL = "2"; //�����ͯ
	public static final String CHILD_TYPE_OTHER = "9"; //����
	
	//2����ͯ���
	public static final String CHILD_IDENTITY_FOUNDLING="10";				//	10    ���Ҳ�������ĸ����Ӥ�Ͷ�ͯ
	public static final String CHILD_IDENTITY_ORPHAN="20";						//	20	ɥʧ��ĸ�Ĺ¶�
	public static final String CHILD_IDENTITY_WORPHAN="201";				// 201	��ḣ������������ɥʧ��ĸ�Ĺ¶�	
	public static final String CHILD_IDENTITY_PORPHAN="202";					//202	��ḣ��������������໤��������ɥʧ��ĸ�Ĺ¶�
	public static final String CHILD_IDENTITY_UNABLE="30";						//30	    ����ĸ����������������������Ů	
	public static final String CHILD_IDENTITY_NOCIVILCON	="301";		//301	����ĸ�����߱���ȫ������Ϊ����
	public static final String CHILD_IDENTITY_NOCIVILCONDUCT="302";	//302	����ĸ�����߱���ȫ������Ϊ�����ҶԱ�������������Σ�����ܵ���Ů
	public static final String CHILD_IDENTITY_KINSHIP="40";						//40	��������ͬ����ϵѪ�׵���Ů
	public static final String CHILD_IDENTITY_STEPCHILD ="50";					//50	����Ů	
	public static final String CHILD_IDENTITY_UNDOQUALIFICATION="60";//60	������������ĸ�໤�ʸ�Ķ�ͯ
	
	
	//3�������ʶ
	public static final String IS_OVERAGE_ALERT="1";//	��������
	public static final String IS_OVERAGE_DONE="2";//	�ѳ���
	
	//20�����ϰ�����
	public static final String LEVEL_WELFARE="1";//	����Ժ
	public static final String LEVEL_PROVINCE="2";//	ʡ��
	public static final String LEVEL_CCCWA="3";//	����
	
	//30�����Ϸ�������
	public static final String TRANSLATION_TYPE_TR="0";//	���Ϸ���
	public static final String TRANSLATION_TYPE_ST="1";//	���䷭��
	public static final String TRANSLATION_TYPE_RT="2";//	���·���	
	public static final String TRANSLATION_TYPE_UT="3";//	���·���	
	
	//31�����Ϸ���״̬
	public static final String TRANSLATION_STATE_TODO="0";//	������
	public static final String TRANSLATION_STATE_DOING="1";//	������
	public static final String TRANSLATION_STATE_DONE="2";//	�ѷ���	
	
	//40����֯��������
	public static final String ORGAN_TYPE_FLY="5";// ����Ժ 
	public static final String ORGAN_TYPE_ZX="1";//����
	public static final String ORGAN_TYPE_ST="7";//ʡ����λ
	
	public ChildInfoConstants() {
		// TODO Auto-generated constructor stub
	}
}
