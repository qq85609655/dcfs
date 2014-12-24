package com.dcfs.cms.childManager;

import com.dcfs.cms.ChildInfoConstants;


public class ChildStateManager {
	//1���������״̬
	public static String CHILD_AUD_STATE_WTJ="0";//0��δ�ύ
	public static String CHILD_AUD_STATE_SDS="1";//1��ʡ����
	public static String CHILD_AUD_STATE_SSHZ="2";//2��ʡ�����
	public static String CHILD_AUD_STATE_SBTG="3";//3��ʡ��ͨ��
	public static String CHILD_AUD_STATE_STG="4";//4��ʡͨ��
	public static String CHILD_AUD_STATE_YJS="5";//5���Ѽ���
	public static String CHILD_AUD_STATE_YJIES="6";//6���ѽ���
	public static String CHILD_AUD_STATE_ZXSHZ="7";//7�����������
	public static String CHILD_AUD_STATE_ZXBTG="8";//8�����Ĳ�ͨ��
	public static String CHILD_AUD_STATE_ZXTG="9";//9������ͨ��
	
	//2��������˽��
	public static String CHILD_AUD_OPTION_REPORT="1";//�ϱ�
	public static String CHILD_AUD_OPTION_SUCCESS="2";//ͨ��
	public static String CHILD_AUD_OPTION_FAILURE="3";//��ͨ��
	public static String CHILD_AUD_OPTION_ADDITIONAL="4";//����
	public static String CHILD_AUD_OPTION_ADDTRANS="5";//����
	public static String CHILD_AUD_OPTION_RETRANS="6";//�ط�
	public static String CHILD_AUD_OPTION_RETURN="7";//�˻ؾ�����
	public static String CHILD_AUD_OPTION_REPORTBOSS="8";//�ϱ��ֹ�����
	
	//3�����ϲ���״̬
	public static String CHILD_ADD_STATE_TODO="0";// 0 ������
	public static String CHILD_ADD_STATE_DOING="1";// 1 ������
	public static String CHILD_ADD_STATE_DONE="2";// 2 �Ѳ���
	
	//4�����Ͻ���״̬
	public static String CHILD_RECEIVE_STATE_TODO="0";//0������
	public static String CHILD_RECEIVE_STATE_DONE="1";//1�ѽ���
	
	//5������ƥ��״̬
	public static String CHILD_MATCH_STATE_TODO="0";//0��ƥ��
	public static String CHILD_MATCH_STATE_DONE="1";//1��ƥ��
	
	//6������״̬	
	public static String CHILD_PUB_STATE_TODO="0";//0��������
	public static String CHILD_PUB_STATE_PLAN="1";//1���ƻ���
	public static String CHILD_PUB_STATE_PUBLISH="2";//2���ѷ���
	public static String CHILD_PUB_STATE_LOCK="3";//3��������
	public static String CHILD_PUB_STATE_REQ="4";//4:������
	
	//7��������˺�������
	public static String CHILD_AUD_RESULT_TRAN="1";//1���ͷ�
	public static String CHILD_AUD_RESULT_MATCH="2";//2��ֱ��ƥ��
	public static String CHILD_AUD_RESULT_PUB="3";//3��ֱ�ӷ���
	
	//8�����ϴ�¼��ʶ
	public static String CHILD_DAILU_FLAG_PROVINCE="2";//2��ʡ����¼
	public static String CHILD_DAILU_FLAG_CCCWA="3";//3�����Ĵ�¼
	
	//9���˲���ȷ��״̬
	public static String CHILD_RETURN_STATE_SDS="1";		//1��ʡ����
	public static String CHILD_RETURN_STATE_ZXDS="2";	//2�����Ĵ���
	public static String CHILD_RETURN_STATE_TG="3";		//3������ͨ��
	public static String CHILD_RETURN_STATE_QX="9";		//9��ȡ��
	
	//10����������
	public static String  CHILD_BACK_TYPE_FSQ="1";//����Ժ��������
	public static String  CHILD_BACK_TYPE_SBG="2";//ʡ����˲�ͨ������
	public static String  CHILD_BACK_TYPE_SSQ="3";//ʡ����������
	public static String  CHILD_BACK_TYPE_ZXTW="5";//���ò�����¼��
	public static String  CHILD_BACK_TYPE_ZXBG="6";//6�����ò���˲�ͨ������
	public static String  CHILD_BACK_TYPE_XTTW="7";//7��ϵͳ�Զ�����
	
	//11���˲��Ͻ��״̬��ֻ���ڶ�ͯ������Ϣ��CMS_CI_INFO���˲���״̬��RETURN_STATE���ĸ��£�
	public static String CHILD_RETURN_STATE_FLAG="1";//�˲��ϱ�ʶ
	
	//12���˲���ԭ������
	public static String CHILD_RETURN_REASON_SBG="ʡ����˲�ͨ��";//ʡ��˲�ͨ��
	public static String CHILD_RETURN_REASON_ZXBG="������˲�ͨ��";//������˲�ͨ��
	
	//����״̬
	public static String OPERATION_STATE_TODO="0";//������
	public static String OPERATION_STATE_DOING="1";//1:������
	public static String OPERATION_STATE_DONE="2";//2:�Ѵ���
	
	//��ͯ���ϸ���״̬
	public static String CHILD_UPDATE_STATE_WTJ="0";// 0 δ�ύ
	public static String CHILD_UPDATE_STATE_SDS="1";// 1 ʡ����
	public static String CHILD_UPDATE_STATE_ZXDS="2";// 2 ���Ĵ���
	public static String CHILD_UPDATE_STATE_TG="3";// 3 ͨ��
	public static String CHILD_UPDATE_STATE_BTG="4";// 4��ͨ��
	
	
	/*
	 * ��ò������״̬
	 */
	public String getChildAudState(String curAUD_STATE,String AUDIT_LEVEL,String AUDIT_OPTION,String OPERATION_STATE){
		String AUD_STATE = "";
		
		if(ChildStateManager.OPERATION_STATE_DOING.equals(OPERATION_STATE)){						//1����Ϊ����
			AUD_STATE =  curAUD_STATE;		
		}else if(ChildStateManager.OPERATION_STATE_DONE.equals(OPERATION_STATE)){					//2����Ϊ�ύ
			if(ChildInfoConstants.LEVEL_PROVINCE.equals(AUDIT_LEVEL)){											//2.1ʡ�����
				if(ChildStateManager.CHILD_AUD_OPTION_SUCCESS.equals(AUDIT_OPTION)){				//2.1.1ͨ��
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_STG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_FAILURE.equals(AUDIT_OPTION)){		//2.1.2��ͨ��
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_SBTG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL.equals(AUDIT_OPTION)){//2.1.3����
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_SSHZ;
				}
			}else if(ChildInfoConstants.LEVEL_CCCWA.equals(AUDIT_LEVEL)){										//2.2�������
				if(ChildStateManager.CHILD_AUD_OPTION_SUCCESS.equals(AUDIT_OPTION)){				//2.2.1ͨ��
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_ZXTG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_FAILURE.equals(AUDIT_OPTION)){		//2.2.2��ͨ��
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_ZXBTG;
				}else if(ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL.equals(AUDIT_OPTION)){//2.2.3����
					AUD_STATE = ChildStateManager.CHILD_AUD_STATE_ZXSHZ;
				}
			}
		}	
		return AUD_STATE;
	}
	
	

	public static void main(String[] args){
				
	}
	
}
