package com.dcfs.ffs.transferManager;

public class TransferConstant {
	
	//1 ������ϸ״̬
	public static final String TRANSFER_STATE_TODO="0";		//0��δ�ƽ�
	public static final String TRANSFER_STATE_DOING="1";	//1�����ƽ�
	public static final String TRANSFER_STATE_DONE="2";		//2�����ƽ�
	public static final String TRANSFER_STATE_RECEIVED="3";	//3���ѽ���
	
	//2 ���ӵ�״̬
	public static final String AT_STATE_DOING="0";		//0�����ƽ�
	public static final String AT_STATE_DONE="1";		//1�����ƽ�
	public static final String AT_STATE_RECEIVED="2";		//2���ѽ���
	
	//3 ��������
	public static final String OPER_TYPE_SEND="1";	//1:�ƽ�
	public static final String OPER_TYPE_RECEIVE="2";//2������
	
	//4 ���ӵ����� 1:�����ļ���2����ͯ���ϣ�3��Ʊ�ݣ�4:���ú󱨸�
	public static final String TRANSFER_TYPE_FILE="1";
	public static final String TRANSFER_TYPE_CHILD="2";
	public static final String TRANSFER_TYPE_CHEQUE="3";
	public static final String TRANSFER_TYPE_REPORT="4";
	
}
