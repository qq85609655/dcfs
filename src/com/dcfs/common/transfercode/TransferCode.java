package com.dcfs.common.transfercode;
/**
 * @ClassName: TransferCode
 * @Description: 交接类型代码常量类
 * @author 吴天宇
 *
 */
public class TransferCode {
	
	/** 
	 * <p>Title: </p> 
	 * <p>Description: </p>  
	 */
	public TransferCode() {
		// TODO Auto-generated constructor stub
	}
	/**
	 * 文件交接：办公室到翻译公司
	 */
	public static final String FILE_BGS_FYGS="11";
	/**
	 * 文件交接：翻译公司到审核部
	 */
	public static final String FILE_FYGS_SHB="12";
	/**
	 * 文件交接：审核部到档案部
	 */
	public static final String FILE_SHB_DAB="13";
	
	
	
	/**
	 * 儿童材料交接：安置部到翻译公司
	 */
	public static final String CHILDINFO_AZB_FYGS="21";
	/**
	 * 儿童材料交接：翻译公司到安置部
	 */
	public static final String CHILDINFO_FYGS_AZB="22";
	/**
	 * 儿童材料交接：安置部到档案部
	 */
	public static final String CHILDINFO_AZB_DAB="23";
	
	/**
	 * 票据交接：办公室到财务部
	 */
	public static final String CHEQUE_BGS_CWB="31";
	
	
	/**
	 * 安置后报告交接：档案部到翻译公司
	 */
	public static final String ARCHIVE_DAB_FYGS="41";
	/**
	 * 安置后报告交接：翻译公司到档案部
	 */
	public static final String ARCHIVE_FYGS_DAB="42";
	
	/**
	 * 退文移交-文件：办公室到档案部
	 */
	public static final String RFM_FILE_BGS_DAB="51";
	/**
	 * 退文移交-文件：翻译公司到档案部
	 */
	public static final String RFM_FILE_FYGS_DAB="52";
	/**
	 * 退文移交-文件：审核部到档案部
	 */
	public static final String RFM_FILE_SHB_DAB="53";
	/**
	 * 退文接收-文件：所有到档案部退文文件接收
	 */
	public static final String RFM_FILE_DAB="5";
	/**
	 * 退材料移交-材料：档案部到安置部
	 */
	public static final String RFM_CHILDINFO_DAB_AZB="61";
	
	/**
	 * 以下为支持数据迁移的退文定义
	 */
	/**
	 * 档案部-办公室历史退文数据
	 */
	public static final String RFM_DAB_BGS="91";
	/**
	 * 审核部-办公室历史退文数据
	 */
	public static final String RFM_SHB_BGS="92";
	/**
	 * 翻译部	办公室历史退文数据
	 */
	public static final String RFM_QZQ_BGS="93";
	/**
	 * 90259024
	 */
	public static final String RFM_BHS_DAB="94";
	
	public static final String getPrintTitleByTransferCode(String TRANSFER_CODE){
		String title = "";
		if(CHILDINFO_AZB_FYGS.equals(TRANSFER_CODE)){
			title = "(安置部-翻译公司)";
		}
		if(CHILDINFO_FYGS_AZB.equals(TRANSFER_CODE)){
			title = "(翻译公司-安置部)";
		}
		if(CHILDINFO_AZB_DAB.equals(TRANSFER_CODE)){
			title = "(安置部-档案部)";
		}
		if(ARCHIVE_DAB_FYGS.equals(TRANSFER_CODE)){
		    title = "(档案部-爱之桥)";
		}
		if(ARCHIVE_FYGS_DAB.equals(TRANSFER_CODE)){
		    title = "(爱之桥-档案部)";
		}
		if(CHEQUE_BGS_CWB.equals(TRANSFER_CODE)){
		    title = "(办公室-财务部)";
		}
		if(RFM_CHILDINFO_DAB_AZB.equals(TRANSFER_CODE)){
		    title = "(档案部-安置部)";
		}
		return title;
	}
	public static final String getPrintTitle0ByTransferCode(String TRANSFER_CODE){
		String title = "移交表";
		if(CHEQUE_BGS_CWB.equals(TRANSFER_CODE)){
		    title = "票据移交表";
		}		
		if(CHILDINFO_AZB_FYGS.equals(TRANSFER_CODE)){
			title = "儿童材料送翻表";
		}	
		if(CHILDINFO_AZB_DAB.equals(TRANSFER_CODE)){
			title = "儿童材料移交表";
		}
		if(ARCHIVE_DAB_FYGS.equals(TRANSFER_CODE) || ARCHIVE_FYGS_DAB.equals(TRANSFER_CODE)){
		    title = "安置后反馈报告送翻表";
		}	
		if(RFM_CHILDINFO_DAB_AZB.equals(TRANSFER_CODE)){
		    title = "儿童材料移交表";
		}
		return title;
	}
}
