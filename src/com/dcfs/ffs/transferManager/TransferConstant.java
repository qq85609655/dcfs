package com.dcfs.ffs.transferManager;

public class TransferConstant {
	
	//1 交接明细状态
	public static final String TRANSFER_STATE_TODO="0";		//0：未移交
	public static final String TRANSFER_STATE_DOING="1";	//1：拟移交
	public static final String TRANSFER_STATE_DONE="2";		//2：已移交
	public static final String TRANSFER_STATE_RECEIVED="3";	//3：已接收
	
	//2 交接单状态
	public static final String AT_STATE_DOING="0";		//0：拟移交
	public static final String AT_STATE_DONE="1";		//1：已移交
	public static final String AT_STATE_RECEIVED="2";		//2：已接收
	
	//3 操作类型
	public static final String OPER_TYPE_SEND="1";	//1:移交
	public static final String OPER_TYPE_RECEIVE="2";//2：接收
	
	//4 交接单类型 1:收养文件；2：儿童材料；3：票据；4:安置后报告
	public static final String TRANSFER_TYPE_FILE="1";
	public static final String TRANSFER_TYPE_CHILD="2";
	public static final String TRANSFER_TYPE_CHEQUE="3";
	public static final String TRANSFER_TYPE_REPORT="4";
	
}
