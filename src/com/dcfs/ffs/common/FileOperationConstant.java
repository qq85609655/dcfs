package com.dcfs.ffs.common;

/**
 * 
 * @description 文件操作常量类
 * @author MaYun
 * @date Jul 28, 2014
 * @return
 */
public class FileOperationConstant {
	/**
	 * 
	 * @description 构造方法
	 * @author MaYun
	 * @date Jul 28, 2014
	 * @return
	 */
	public FileOperationConstant(){
		// TODO Auto-generated constructor stub
	}
	

    //******收养组织-文件办理-递交普通文件、递交特需文件、补充文件关键操作begin*********
	public static final String SYZZ_N_FILE_DELIVER_NEXT="01";//递交普通文件下一步
	public static final String SYZZ_N_FILE_DELIVER_SAVE="02";//递交普通文件保存
	public static final String SYZZ_N_FILE_DELIVER_SUBMIT="03";//递交普通文件提交
	public static final String SYZZ_S_FILE_DELIVER_SAVE="04";//递交特需文件保存
	public static final String SYZZ_S_FILE_DELIVER_SUBMIT="05";//递交特需文件提交
	public static final String SYZZ_FILE_SUPPLEMNET_SAVE="06";//补充文件保存
	public static final String SYZZ_FILE_SUPPLEMNET_SUBMIT="07";//补充文件提交
	//******收养组织-文件办理-递交普通文件、递交特需文件、补充文件关键操作end*********
	
	//******办公室-文件办理-文件代录、批量代录、文件登记、文件退回关键操作begin*********
	public static final String BGS_REGISTRATION_DL_SUBMIT="10";//文件代录提交
	public static final String BGS_REGISTRATION_PLDL_SUBMIT="11";//批量代录提交
	public static final String BGS_REGISTRATION_SGDJ_SUBMIT="12";//手工登记提交
	public static final String BGS_REGISTRATION_RETURN="13";//文件登记退回
	//******办公室-文件办理-文件代录、批量代录、文件登记、文件退回关键操作end*********
	
	//******爱之桥-文件翻译-翻译关键操作begin*********
	public static final String AZQ_FY_SAVE="15";//爱之桥翻译保存
	public static final String AZQ_FY_SUBMIT="16";//爱之桥翻译提交
	//******爱之桥-文件翻译-翻译关键操作end*********
	
	//******办公室-文件交接-办公室/爱之桥-交接单保存、提交关键操作begin*********
	public static final String BGS_BGSTOAZQ_JJD_SAVE="20";//办公室-爱之桥交接单保存
	public static final String BGS_BGSTOAZQ_JJD_SUBMIT="21";//办公室-爱之桥交接单提交
	//******办公室-文件交接-办公室/爱之桥-交接单保存、提交关键操作end*********
	
	//******爱之桥-文件移交-办公室/爱之桥/审核部-交接单接收、交接单保存、提交关键操作begin*********
	public static final String AZQ_BGSTOAZQ_JJD_ACCEPT="22";//办公室-爱之桥接收
	public static final String AZQ_AZQTOSHB_JJD_SAVE="23";//爱之桥-审核部交接单保存
	public static final String AZQ_AZQTOSHB_JJD_SUBMIT="24";//爱之桥-审核部交接单提交
	//******爱之桥-文件移交-办公室/爱之桥/审核部-交接单接收、交接单保存、提交关键操作end*********
	
	//******审核部-文件交接-爱之桥/审核部/档案部-交接单接收、交接单保存、提交关键操作begin*********
	public static final String SHB_AZQTOSHB_JJD_ACCEPT="25";//爱之桥-审核部接收
	public static final String SHB_SHBTODAB_JJD_SAVE="26";//审核部-档案部交接单保存
	public static final String SHB_SHBTODAB_JJD_SUBMIT="27";//审核部-档案部交接单提交
	//******审核部-文件交接-爱之桥/审核部/档案部-交接单接收、交接单保存、提交关键操作end*********
	
	//******档案部-文件交接-审核部/档案部-交接单接收关键操作begin*********
	public static final String DAB_SHBTODAB_JJD_ACCEPT="28";//审核部-档案部接收
	public static final String DAB_OTHERTODAB_JJD_ACCEPT="29";//档案部接收(退文待接收的)
	//******档案部-文件交接-审核部/档案部-交接单接收关键操作end*********
	
	//******审核部-退文办理-移交-交接单接保存、提交关键操作begin*********
	public static final String SHB_TW_JJD_SAVE="30";//审核部退文移交保存
	public static final String SHB_TW_JJD_SUBMIT="31";//审核部退文移交提交
	//******审核部-退文办理-移交-交接单接保存、提交关键操作end*********
	
	//******审核部-文件审核-初审关键操作begin*********
	public static final String SHB_WJCS_SB_SAVE="40";//文件审核初审上报保存
	public static final String SHB_WJCS_SB_SUBMIT="41";//文件审核初审上报提交
	public static final String SHB_WJCS_TG_SAVE="42";//文件审核初审通过保存
	public static final String SHB_WJCS_TG_SUBMIT="43";//文件审核初审通过提交
	public static final String SHB_WJCS_BTG_SAVE="44";//文件审核初审不通过保存
	public static final String SHB_WJCS_BTG_SUBMIT="45";//文件审核初审不通过提交
	public static final String SHB_WJCS_BCWJ_SAVE="46";//文件审核初审补充文件保存
	public static final String SHB_WJCS_BCWJ_SUBMIT="47";//文件审核初审补充文件提交
	public static final String SHB_WJCS_BCFY_SAVE="48";//文件审核初审补充翻译保存
	public static final String SHB_WJCS_BCFY_SUBMIT="49";//文件审核初审补充翻译提交
	public static final String SHB_WJCS_CXFY_SAVE="50";//文件审核初审重新翻译保存
	public static final String SHB_WJCS_CXFY_SUBMIT="51";//文件审核初审重新翻译提交
	//******审核部-文件审核-初审关键操作end*********
	
	//******审核部-文件审核-复核关键操作begin*********
	public static final String SHB_WJFH_TG_SAVE="52";//文件复核通过保存
	public static final String SHB_WJFH_TG_SUBMIT="53";//文件复核通过提交
	public static final String SHB_WJFH_THJBR_SAVE="54";//文件复核退回经办人保存
	public static final String SHB_WJFH_THJBR_SUBMIT="55";//文件复核退回经办人提交
	public static final String SHB_WJFH_SBFGZR_SAVE="56";//文件复核上报分管主任保存
	public static final String SHB_WJFH_SBFGZR_SUBMIT="57";//文件复核上报分管主任提交
	public static final String SHB_WJFH_BTG_SAVE="58";//文件复核不通过保存
	public static final String SHB_WJFH_BTG_SUBMIT="59";//文件复核不通过提交
	//******审核部-文件审核-复核关键操作end*********
	
	//******审核部-文件审核-审批关键操作begin*********
	public static final String SHB_WJSP_TG_SAVE="60";//文件审批通过保存
	public static final String SHB_WJSP_TG_SUBMIT="61";//文件审批通过提交
	public static final String SHB_WJSP_THJBR_SAVE="62";//文件审批退回经办人保存
	public static final String SHB_WJSP_THJBR_SUBMIT="63";//文件审批退回经办人提交
	public static final String SHB_WJSP_BTG_SAVE="64";//文件审批不通过保存
	public static final String SHB_WJSP_BTG_SUBMIT="65";//文件审批不通过提交
	//******审核部-文件审核-审批关键操作end*********
	
	//******安置部-正常业务办理-匹配关键操作begin*********
	public static final String AZB_ZCYW_PP_SUBMIT="70";//正常业务办理,匹配提交
	//******安置部-正常业务办理-匹配关键操作end*********
	
	//******安置部-特需业务办理-匹配关键操作begin*********
	public static final String AZB_TXYW_PP_SUBMIT="71";//特需业务办理,匹配提交
	//******安置部-特需业务办理-匹配关键操作end*********
	
	//******安置部-匹配后办理-匹配审核、复核、征求意见关键操作begin*********
	public static final String AZB_PPH_SH_SB="72";//匹配后办理-匹配审核-上报
	public static final String AZB_PPH_FHTG_SUBMIT="73";//匹配后办理-匹配复核通过-提交
	public static final String AZB_PPH_FHBTG_SUBMIT="74";//匹配后办理-匹配复核不通过-提交
	public static final String AZB_PPH_ZQYJ_TZ="75";//匹配后办理-征求意见-通知收养人
	public static final String AZB_PPH_ZQYJ_FKQR_AGREE="76";//匹配后办理-征求意见-反馈确认-同意
	public static final String AZB_PPH_ZQYJ_FKQR_CXPP="77";//匹配后办理-征求意见-反馈确认-重新匹配
	public static final String AZB_PPH_ZQYJ_FKQR_TW="78";//匹配后办理-征求意见-反馈确认-退文
	//******安置部-匹配后办理-匹配审核、复核、征求意见关键操作end*********
	
	//******收养组织-工作反馈-征求意见书提交关键操作begin*********
	public static final String SYZZ_GZFK_ZQYJ_SUBMIT="79";//征求意见反馈提交
	//******收养组织-工作反馈-征求意见书提交关键操作end*********
	
	//******档案部-文件交接-安置部到档案部-材料接收操作begin*********
	public static final String DAB_WJJJ_AZBTODAB_CLJS="80";//档案部材料接收
	//******档案部-文件交接-安置部到档案部-材料接收操作end*********
	
	//******档案部-安置后报告-报告审核操作begin*********
	public static final String DAB_AZH_SHJG_JSGZ="81";//报告审核结果为结束跟踪
	//******档案部-安置后报告-报告审核操作end*********
	
	//******中心领导-通知书签批-签批通过操作begin*********
	public static final String ZXLD_TZS_QPTG="82";//签批通过
	//******中心领导-通知书签批-签批通过操作begin*********
	
	//******办公室-通知书办理-打印寄发-通知书寄发操作begin*********
	public static final String BGS_TZS_JF="83";//通知书寄发
	//******办公室-通知书办理-打印寄发-通知书寄发操作end*********
	
	//******省厅-收养登记管理-收养登记关键操作begin*********
	public static final String ST_SYDJ_DJCG="85";//收养登记成功
	public static final String ST_SYDJ_DJWX="86";//收养登记无效
	//******省厅-收养登记管理-收养登记关键操作end*********

	//public static final String FILE_PAUSE_SUBMIT="90";//文件暂停提交
	//public static final String FILE_PAUSE_CANCLE="91";//文件取消暂停
	public static final String BACK_GERNERATION_SUBMIT="95";//退文代录提交
	public static final String FILE_BACK_CONFIRM="96";//退文确认
	
	
	
	
}
