package com.dcfs.ffs.common;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;


/**
 * 
 * @description 文件全局状态和位置公共类
 * @author MaYun
 * @date Jul 28, 2014
 */
public class FileCommonStatusAndPositionManager{
	private static Log log = UtilLog.getLog(FileCommonStatusAndPositionManager.class);
	private FileCommonStatusAndPositionManagerHandler handler = new FileCommonStatusAndPositionManagerHandler();
	private Connection conn = null;//数据库连接
	private DBTransaction dt = null;//事务处理
	
	

   /**
    * 
    * @description 根据操作类型获得下一环节文件的全局状态和文件位置
    * @author MaYun
    * @date Jul 28, 2014
    * @param String operType 操作类型<br>参照com.dcfs.ffs.common.FileOperationConstant类定义 <br>
    * @return Data <br>AF_GLOBAL_STATE:文件全局状态;<br>AF_POSITION:文件位置;<br>
    * 
    */
   public Data getNextGlobalAndPosition(String operType){
	   String af_global_state = "";//文件全局状态
	   String af_position = "";//文件位置
	   
	   if(operType.equals(FileOperationConstant.SYZZ_N_FILE_DELIVER_NEXT)||operType==FileOperationConstant.SYZZ_N_FILE_DELIVER_NEXT){//收养组织-文件办理-递交普通文件下一步
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//未提交
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZ;//收养组织
	   }else if(operType.equals(FileOperationConstant.SYZZ_N_FILE_DELIVER_SAVE)||operType==FileOperationConstant.SYZZ_N_FILE_DELIVER_SAVE){//收养组织-文件办理-递交普通文件保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//未提交
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZ;//收养组织
	   }else if(operType.equals(FileOperationConstant.SYZZ_N_FILE_DELIVER_SUBMIT)||operType==FileOperationConstant.SYZZ_N_FILE_DELIVER_SUBMIT){//收养组织-文件办理-递交普通文件提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//待登记
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZTOBGS;//收养组织-办公室
	   }else if(operType.equals(FileOperationConstant.SYZZ_S_FILE_DELIVER_SAVE)||operType==FileOperationConstant.SYZZ_S_FILE_DELIVER_SAVE){//收养组织-文件办理-递交特需文件保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//未提交
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZ;//收养组织
	   }else if(operType.equals(FileOperationConstant.SYZZ_S_FILE_DELIVER_SUBMIT)||operType==FileOperationConstant.SYZZ_S_FILE_DELIVER_SUBMIT){//收养组织-文件办理-递交特需文件提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DDJ;//待登记
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZTOBGS;//收养组织-办公室
	   }else if(operType.equals(FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SAVE)||operType==FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SAVE){//收养组织-文件办理-补充文件保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ2;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SUBMIT)||operType==FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SUBMIT){//收养组织-文件办理-补充文件提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ2;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_DL_SUBMIT)||operType==FileOperationConstant.BGS_REGISTRATION_DL_SUBMIT){//办公室-文件办理-文件代录提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJDSF;//登记待送翻
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//办公室
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_PLDL_SUBMIT)||operType==FileOperationConstant.BGS_REGISTRATION_PLDL_SUBMIT){//办公室-文件办理-批量代录提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJDSF;//登记待送翻
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//办公室
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_SGDJ_SUBMIT)||operType==FileOperationConstant.BGS_REGISTRATION_SGDJ_SUBMIT){//办公室-文件办理-手工登记提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJDSF;//登记待送翻
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//办公室
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_RETURN)||operType==FileOperationConstant.BGS_REGISTRATION_RETURN){//办公室-文件办理-退回
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SWDJDBC;//收文登记待补充
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//办公室
	   }else if(operType.equals(FileOperationConstant.AZQ_FY_SAVE)||operType==FileOperationConstant.AZQ_FY_SAVE){//爱之桥-文件翻译-保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WJFYZ;//文件翻译中
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//翻译公司
	   }else if(operType.equals(FileOperationConstant.AZQ_FY_SUBMIT)||operType==FileOperationConstant.AZQ_FY_SUBMIT){//爱之桥-文件翻译-保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YFYDYJ;//文件已翻译
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//翻译公司
	   }else if(operType.equals(FileOperationConstant.AZQ_FY_SUBMIT)||operType==FileOperationConstant.AZQ_FY_SUBMIT){//爱之桥-文件翻译-提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YFYDYJ;//文件已翻译
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//翻译公司
	   }else if(operType.equals(FileOperationConstant.BGS_BGSTOAZQ_JJD_SAVE)||operType==FileOperationConstant.BGS_BGSTOAZQ_JJD_SAVE){//办公室-爱之桥交接单保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SFZ;//送翻中
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGSTOFYGS;//办公室-翻译公司
	   }else if(operType.equals(FileOperationConstant.BGS_BGSTOAZQ_JJD_SUBMIT)||operType==FileOperationConstant.BGS_BGSTOAZQ_JJD_SUBMIT){//办公室-爱之桥交接单提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SFDJS;//送翻待接收
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//翻译公司
	   }else if(operType.equals(FileOperationConstant.AZQ_BGSTOAZQ_JJD_ACCEPT)||operType==FileOperationConstant.AZQ_BGSTOAZQ_JJD_ACCEPT){//办公室-爱之桥交接收
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WJDFY;//文件待翻译
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//翻译公司
	   }else if(operType.equals(FileOperationConstant.AZQ_AZQTOSHB_JJD_SAVE)||operType==FileOperationConstant.AZQ_AZQTOSHB_JJD_SAVE){//爱之桥-审核部交接单保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YFYDYJ;//已翻译待移交
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//翻译公司
	   }else if(operType.equals(FileOperationConstant.AZQ_AZQTOSHB_JJD_SUBMIT)||operType==FileOperationConstant.AZQ_AZQTOSHB_JJD_SUBMIT){//爱之桥-审核部交接单提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YBDJS;//一部待接收
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGSTOSHB;//翻译公司-审核部
	   }else if(operType.equals(FileOperationConstant.SHB_AZQTOSHB_JJD_ACCEPT)||operType==FileOperationConstant.SHB_AZQTOSHB_JJD_ACCEPT){//爱之桥-审核部接收
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRDSH;//经办人待审核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_SHBTODAB_JJD_SAVE)||operType==FileOperationConstant.SHB_SHBTODAB_JJD_SAVE){//审核部-档案部交接单保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DYJDAB;//待移交档案部
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_SHBTODAB_JJD_SUBMIT)||operType==FileOperationConstant.SHB_SHBTODAB_JJD_SUBMIT){//审核部-档案部交接单提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DABDJS;//档案部待接收
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHBTODAB;//审核部-档案部
	   }else if(operType.equals(FileOperationConstant.DAB_SHBTODAB_JJD_ACCEPT)||operType==FileOperationConstant.DAB_SHBTODAB_JJD_ACCEPT){//审核部-档案部接收
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DPP;//待匹配
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.DAB_OTHERTODAB_JJD_ACCEPT)||operType==FileOperationConstant.DAB_OTHERTODAB_JJD_ACCEPT){//档案部接收(退文待接收的)
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BTWDJS2;//档退待寄送
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.SHB_TW_JJD_SAVE)||operType==FileOperationConstant.SHB_TW_JJD_SAVE){//审核部退文移交保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SHBTGDTW2;//审核不通过待退文
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_TW_JJD_SUBMIT)||operType==FileOperationConstant.SHB_TW_JJD_SUBMIT){//审核部退文移交提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BTWDJS;//档退文待接收
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_SB_SAVE)||operType==FileOperationConstant.SHB_WJCS_SB_SAVE){//文件审核初审上报保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_SB_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_SB_SUBMIT){//文件审核初审上报提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//部门主任复核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_TG_SAVE)||operType==FileOperationConstant.SHB_WJCS_TG_SAVE){//文件审核初审通过保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_TG_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_TG_SUBMIT){//文件审核初审通过提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//部门主任复核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BTG_SAVE)||operType==FileOperationConstant.SHB_WJCS_BTG_SAVE){//文件审核初审不通过保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BTG_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_BTG_SUBMIT){//文件审核初审不通过提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//部门主任复核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCWJ_SAVE)||operType==FileOperationConstant.SHB_WJCS_BCWJ_SAVE){//文件审核初审补充文件保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCWJ_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_BCWJ_SUBMIT){//文件审核初审补充文件提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCFY_SAVE)||operType==FileOperationConstant.SHB_WJCS_BCFY_SAVE){//文件审核初审补充翻译保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCFY_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_BCFY_SUBMIT){//文件审核初审补充翻译提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_CXFY_SAVE)||operType==FileOperationConstant.SHB_WJCS_CXFY_SAVE){//文件审核初审重新翻译保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_CXFY_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_CXFY_SUBMIT){//文件审核初审重新翻译提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_TG_SAVE)||operType==FileOperationConstant.SHB_WJFH_TG_SAVE){//文件复核通过保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//经办人审核中
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_TG_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_TG_SUBMIT){//文件复核通过提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DYJDAB;//待移交档案部
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_THJBR_SAVE)||operType==FileOperationConstant.SHB_WJFH_THJBR_SAVE){//文件复核退回经办人保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//部门主任复核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_THJBR_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_THJBR_SUBMIT){//文件复核退回经办人提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSH;//经办人审核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_SBFGZR_SAVE)||operType==FileOperationConstant.SHB_WJFH_SBFGZR_SAVE){//文件复核上报分管主任保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//部门主任复核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_SBFGZR_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_SBFGZR_SUBMIT){//文件复核上报分管主任提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//分管主任审批
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_BTG_SAVE)||operType==FileOperationConstant.SHB_WJFH_BTG_SAVE){//文件复核不通过保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//部门主任复核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_BTG_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_BTG_SUBMIT){//文件复核不通过提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SHBTGDTW;//审核不通过待退文
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_TG_SAVE)||operType==FileOperationConstant.SHB_WJSP_TG_SAVE){//文件审批通过保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//分管主任审批
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_TG_SUBMIT)||operType==FileOperationConstant.SHB_WJSP_TG_SUBMIT){//文件审批通过提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DYJDAB;//待移交档案部
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_THJBR_SAVE)||operType==FileOperationConstant.SHB_WJSP_THJBR_SAVE){//文件审批退回经办人保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//分管主任审批
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_THJBR_SUBMIT)||operType==FileOperationConstant.SHB_WJSP_THJBR_SUBMIT){//文件审批退回经办人提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSH;//经办人审核
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_BTG_SAVE)||operType==FileOperationConstant.SHB_WJSP_BTG_SAVE){//文件审批不通过保存
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//分管主任审批
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_BTG_SUBMIT)||operType==FileOperationConstant.SHB_WJSP_BTG_SUBMIT){//文件审批不通过提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SHBTGDTW;//审核不通过待退文
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//审核部
	   }else if(operType.equals(FileOperationConstant.AZB_ZCYW_PP_SUBMIT)||operType==FileOperationConstant.AZB_ZCYW_PP_SUBMIT){//正常业务办理,匹配提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_PPJBRDSH;//匹配经办人待审核
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_TXYW_PP_SUBMIT)||operType==FileOperationConstant.AZB_TXYW_PP_SUBMIT){//特需业务办理,匹配提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_PPJBRDSH;//匹配经办人待审核
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_SH_SB)||operType==FileOperationConstant.AZB_PPH_SH_SB){//匹配后办理-匹配审核-上报
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_PPBMZRDFH;//匹配部门主任待复核
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_FHTG_SUBMIT)||operType==FileOperationConstant.AZB_PPH_FHTG_SUBMIT){//匹配后办理-匹配复核通过-提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DZQYJ;//待征求意见
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_FHBTG_SUBMIT)||operType==FileOperationConstant.AZB_PPH_FHBTG_SUBMIT){//匹配后办理-匹配复核不通过-提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DPP2;//待匹配
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_TZ)||operType==FileOperationConstant.AZB_PPH_ZQYJ_TZ){//匹配后办理-征求意见-通知收养人
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJZ;//征求意见中
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_AGREE)||operType==FileOperationConstant.AZB_PPH_ZQYJ_FKQR_AGREE){//匹配后办理-征求意见-反馈确认-同意
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJFKQR_TY;//征求意见反馈确认同意
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP)||operType==FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP){//匹配后办理-征求意见-反馈确认-重新匹配
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJFKQR_CXPP;//征求意见反馈确认重新匹配
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_TW)||operType==FileOperationConstant.AZB_PPH_ZQYJ_FKQR_TW){//匹配后办理-征求意见-反馈确认-退文
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJFKQR_TW;//征求意见反馈确认退文
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.SYZZ_GZFK_ZQYJ_SUBMIT)||operType==FileOperationConstant.SYZZ_GZFK_ZQYJ_SUBMIT){//征求意见反馈提交
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJZ2;//征求意见中
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.DAB_WJJJ_AZBTODAB_CLJS)||operType==FileOperationConstant.DAB_WJJJ_AZBTODAB_CLJS){//档案部材料接收
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DQP;//待签批
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.DAB_AZH_SHJG_JSGZ)||operType==FileOperationConstant.DAB_AZH_SHJG_JSGZ){//报告审核结果为结束跟踪
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YBJ;//已办结
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.ZXLD_TZS_QPTG)||operType==FileOperationConstant.ZXLD_TZS_QPTG){//中心领导签批通过
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJF;//待寄发
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.BGS_TZS_JF)||operType==FileOperationConstant.BGS_TZS_JF){//通知书打印寄发
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YJF;//已寄发
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.ST_SYDJ_DJCG)||operType==FileOperationConstant.ST_SYDJ_DJCG){//收养登记成功
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YDJ;//已登记
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }else if(operType.equals(FileOperationConstant.ST_SYDJ_DJWX)||operType==FileOperationConstant.ST_SYDJ_DJWX){//收养登记无效
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WXDJ;//无效登记
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//档案部
	   }
	   
	   
	   
	   Data data = new Data();
	   data.add("AF_GLOBAL_STATE", af_global_state);
	   data.add("AF_POSITION", af_position);
	   return data;
   }
   
   /**
    * 
    * @description 根据当前文件全局状态，获得当前环节文件位置以及收养组织文件状态
    * @author MaYun
    * @date Jul 23, 2014
    * @param String currentGlobalStatus 当前文件全局状态<br>参照com.dcfs.ffs.common.FileGlobalStatusAndPositionConstant类定义<br>
    * @return Data <br>AF_POSITION:文件位置;<br>AF_ORG_STATE:收养组织文件状态<br>
    */
   public Data getCurrentPositionAndStatusOfOrg(String currentGlobalStatus){
	   Data data = new Data();
	   data.add("AF_POSITION", "");
	   data.add("AF_ORG_STATE", "");
	   //TODO
	   return data;
   }
   
   /**
    * 
    * @description 根据操作类型和收养文件主键ID，获得下一环节文件的全局状态和文件位置并更新到文件基本信息表中
    * @author MaYun
    * @date Jul 29, 2014
    * @param Connection conn 数据库连接<br>
    * @param String operType 操作类型<br>参照com.dcfs.ffs.common.FileOperationConstant类定义 <br>
    * @param fileID 文件主键ID<br>
    */
   public void updateNextGlobalStatusAndPositon(Connection conn,String operType,String fileID) throws DBException{
	   Data data =  this.getNextGlobalAndPosition(operType);
	   data.add("AF_ID", fileID);
	   handler.updateNextGlobalStatusAndPositon(conn, data);
   }

   
   
   
  
   
   
	
	
	
}
