package com.dcfs.cms.childManager;

import java.util.HashMap;
import java.util.Map;

/**
 * 
 * @description 材料全局状态和位置常量类
 * @author 王征
 * @date 2014-10-31
 * @return
 */
public class ChildGlobalStatusAndPositionConstant {
	private Map<String,String> childStatusMap;
	private Map<String,String> childStatusMap2;
	/**
	 * 
	 * @description 构造方法
	 * @author WangZ
	 * @date 2014-10-31
	 * @return
	 */
	public ChildGlobalStatusAndPositionConstant(){
		initChildStatusMap();
		initChildStatusMap2();		
	}
	
	public Map<String,String> getChildStatusMap(){
		return this.childStatusMap;
	}
	
	public Map<String,String> getChildStatusMap2(){
		return this.childStatusMap2;
	}
	
	//***********材料位置常量begin*********************/
	public static final String POS_BGS="0020";// 办公室
	public static final String POS_FYGS="0080";//翻译公司
	public static final String POS_DAB="0040";// 档案部
	public static final String POS_AZB="0050";//安置部
	public static final String POS_AZBTOFYGS="5080";//安置部--翻译公司
	public static final String POS_FYGSTOAZB="8050";//翻译公司--安置部
	public static final String POS_AZBTODAB="5040";//安置部--档案部
	public static final String POS_DABTOAZB="4050";//档案部--安置部	
	public static final String POS_FLY="0011";	//福利院
	public static final String POS_ST="0012";	//省厅
	public static final String POS_STTOAZB="1240";	//省厅--安置部
	
	
	//***********材料全局状态常量begin*********************/
	public static final String STA_WTJ			="00";		//00:未提交
	public static final String STA_ST_DSH		="01";		//01:省厅待审核
	public static final String STA_ST_FDB		="02";		//02：省退福待补
	public static final String STA_ST_FBZ		="03";		//03：省退福补中
	public static final String STA_ST_FYB		="04";		//04：省退福已补
	public static final String STA_ST_BTG		="05";		//05：省不通过
	
	public static final String STA_ST_TG		="10";		//10：省通过
	public static final String STA_ST_YJS		="11";		//11：省已寄送
	public static final String STA_ZX_YJS		="12";		//12：中心已接收
	public static final String STA_ZX_TDB		="13";		//13：中心退待补
	public static final String STA_ZX_TBZ		="14";		//14：中心退补中
	public static final String STA_ZX_TYB		="15";		//15：中心退已补
	public static final String STA_ZX_BTG		="16";		//16：中心不通过
	public static final String STA_ZX_DSF		="17";		//17：待送翻
	public static final String STA_ZX_SFZ		="18";		//18：送翻中
	public static final String STA_ZX_SFDJS	    ="19";		//19：送翻待接收

	public static final String STA_FY_DFY		="20";		//20：待翻译
	public static final String STA_FY_FYZ		="21";		//21：翻译中
	public static final String STA_FY_YFDYJ	    ="22";		//22：已翻译待移交
	public static final String STA_FY_YFYJZ	    ="23";		//23：已翻译移交中
	public static final String STA_FY_YFDJS	    ="24";		//24：翻译待接收
	
	public static final String STA_FB_DFB		="30";		//30：待发布
	public static final String STA_FB_JHZ		="31";		//31：计划中
	public static final String STA_FB_DYG		="32";		//32：待预告
	public static final String STA_FB_YYG		="33";		//33：已预告
	public static final String STA_FB_YFB		="34";		//34：已发布
	public static final String STA_FB_THDQR	    ="35";		//35：退回待确认
	
	public static final String STA_YP_YSD		="37";		//37：已锁定
	public static final String STA_YP_DFY		="38";		//38：预批待翻译
	public static final String STA_YP_FYZ		="39";		//39：预批翻译中
	public static final String STA_YP_DSH		="40";		//40：预批待审核
	public static final String STA_YP_SHZ		="41";		//41：预批审核中
	public static final String STA_YP_BTG		="47";		//47：预批不通过
	public static final String STA_YP_TG		="48";		//48：预批通过
	
	public static final String STA_YP_WQD       ="50";      //50：已交文待登记（未启动）
	public static final String STA_YP_YQD       ="51";      //51：启动绿通
	public static final String STA_YPCX_DQR     ="52";      //52：预批撤销待确认
	
	public static final String STA_SH_JBR		="60";		//60：经办人审核
	public static final String STA_SH_BMZR		="61";		//61：部门主任复核
	public static final String STA_SH_BTG		="81";		//81：部门主任复核不通过
	public static final String STA_YJ_DYJ		="62";		//62：待移交档案部（安置部未移交、征求意见同意）
	public static final String STA_YJ_YJZ		="63";		//63：向档案部移交中（安置部拟移交）
	public static final String STA_YJ_DJS		="64";		//64：档案部待接收（安置部已移交）
	public static final String STA_QP_DQP		="65";		//65：中心主任待签批（档案部已接收）
	public static final String STA_TZS_DJF		="66";		//66:待寄发（签批通过）
	public static final String STA_TZS_YJF		="67";		//67：已寄发（未登记）
	public static final String STA_SYDJ_YDJ		="68";		//68：已登记
	public static final String STA_SYDJ_WXDJ    ="69";      //69：无效登记
	public static final String STA_TCLYJ_WYJ    ="70";      //70：档案部材料未移交
	public static final String STA_TCLYJ_NYJ    ="71";      //71：档案部材料拟移交
	public static final String STA_TCLYJ_YYJ    ="72";      //72：档案部材料已移交（安置部材料待接收）
	public static final String STA_TCLYJ_YJS    ="73";      //73：安置部材料已接收
	
	public static final String STA_CX_STDQR	    ="90";		//90：地方撤销送养中（省厅待确认）
	public static final String STA_CX_STYQR   	="91";		//91：地方撤销送养中（省厅已确认）
	public static final String STA_CX_ZXDQR	    ="92";		//92：撤销送养待中心确认
	public static final String STA_CX_ZXYQR 	="93";		//93：材料退文（中心已确认）
	
	
	
	
	//***********文件全局状态常量end*********************/
	
	/**
	 * 构造儿童材料全局状态map（中心）
	 */
	private void initChildStatusMap(){
		childStatusMap = new HashMap();
		childStatusMap.put(STA_WTJ, "未提交");
		childStatusMap.put(STA_ST_DSH, "省厅待审核");
		childStatusMap.put(STA_ST_FDB, "省退福待补");
		childStatusMap.put(STA_ST_FBZ, "省退福补中");
		childStatusMap.put(STA_ST_FYB, "省退福已补");
		childStatusMap.put(STA_ST_BTG, "省不通过");
		childStatusMap.put(STA_ST_TG, "省通过");
		childStatusMap.put(STA_ST_YJS, "省已寄送");
	}
	/**
	 * 构造儿童材料全局状态map（省厅、福利院）
	 */
	private void initChildStatusMap2(){
		childStatusMap = new HashMap();
		childStatusMap.put(STA_WTJ, "未提交");
		childStatusMap.put(STA_ST_DSH, "省厅待审核");
		childStatusMap.put(STA_ST_FDB, "省退福待补");
		childStatusMap.put(STA_ST_FBZ, "省退福补中");
		childStatusMap.put(STA_ST_FYB, "省退福已补");
		childStatusMap.put(STA_ST_BTG, "省不通过");
		childStatusMap.put(STA_ST_TG, "省通过");
		childStatusMap.put(STA_ST_YJS, "省已寄送");
	}
	
}
