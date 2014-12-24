package com.dcfs.cms.childManager;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.common.atttype.AttConstants;
import com.hx.framework.organ.vo.Organ;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.util.DateUtility;

public class ChildCommonManager {
	private Connection conn = null;//数据库连接
	
	private ChildManagerHandler handler;
	private ChildGlobalStatusAndPositionConstant globalStatus=new ChildGlobalStatusAndPositionConstant() ;

	public ChildCommonManager() {
		this.handler=new ChildManagerHandler();
	}
	//获取组织所属省份ID
	public String getProviceId(String orgCode){
		if("".equals(orgCode) || orgCode==null){
			return null;
		}else{
			String ret = orgCode.substring(0, 2) + "0000";		
			return ret;
		}
	}
	public static void main(String[] args){
		
	}
	
	/**
     * 生成儿童编号
     * 儿童编号生成规则：
     * （2位省份代码+4位年份+5位该区本年流水号）
     * @param data
     * 
     * @return CHILD_NO 儿童编号
     * @throws DBException 
     */
    public String createChildNO(Data data,Connection conn) throws DBException{
    	StringBuffer CHILD_NO = new StringBuffer();
    	//获得省份ID和当前年度
    	String proviceId = data.getString("PROVINCE_ID","00");
    	String curYear = DateUtility.getCurrentYear();
    	//如果省份ID的长度小于2，则直接赋值为00
    	if(proviceId.length()<2){
    		proviceId = "00";
    	}
    	proviceId = proviceId.substring(0,2);
    	int imaxNO = 1;
    	String operType = "revise";
    	synchronized(this){
    		//查询儿童编号表，获取最大儿童编号
    		Data d = handler.getMaxChildNO(conn,proviceId,curYear);
    		if(d!=null){//存在当前年度，该省份的编号记录
    			imaxNO = d.getInt("MAXNO");
    			imaxNO++;
    		}else{
    			operType = "new";
    		}
    		String smaxNO = String.valueOf(imaxNO);
    		Data dd = new Data();
    		dd.put("MAXNO",smaxNO);    				
    		dd.put("YEAR",curYear);
    		dd.put("PROVINCE_ID", proviceId);
    		
    		boolean ret = handler.createChildNO(conn, dd,operType);	
    		
    		if(ret){
    			String strMaxNO = String.valueOf(imaxNO);
    			//补齐5位流水号
    			for(int i=strMaxNO.length();i<5;i++){
    				strMaxNO="0" + strMaxNO;
    			}
    			CHILD_NO = CHILD_NO.append(proviceId).append(curYear).append(strMaxNO);
    		}
    	}
    	return CHILD_NO.toString();    	
    }
	/**
	 * 根据省份CODE获取该省下所有福利院记录
	 * @return
	 * @throws DBException 
	 */
	public CodeList getWelfareByProvinceCode(String orgCode,Connection conn) throws DBException{
            DataList orgList = handler.getWelfareByProvinceCode(conn, orgCode);
            CodeList list=new CodeList();
            for(int i=0;i<orgList.size();i++){
                Code c=new Code();
                c.setValue(orgList.getData(i).getString("ORG_CODE"));
                c.setName(orgList.getData(i).getString("CNAME"));
                c.setRem(orgList.getData(i).getString("CNAME"));
                list.add(c);
            }
            return list;
	}
	/**
	 * 获取所有福利院信息
	 * TODO
	 * @return
	 */
	public Map<String,DataList> getAllWelfareMap(){
		return null;
	}
	
	/**
	 * 获取所有福利院信息
	 * @return
	 */
	public DataList getAllWelfareList(Connection conn) throws DBException{
        DataList orgList = handler.getAllWelfareList(conn);        
        return orgList;
	}
	
	/**
	 * 根据儿童编号获得儿童信息
	 * @param childNO
	 * @return
	 * TODO
	 */
	public Data getChildInfoByChildNO(String childNO){
		return null;
	}
	
	/**
	 * 根据儿童编号获得儿童信息(for 收养组织)
	 * @param childNO
	 * @return
	 * TODO
	 */
	public Data getChildInfoByChildNO4Adopt(String childNO){
		return null;
	}
	
	/**
	 * 根据儿童材料ID获得儿童信息
	 * @param CI_ID
	 * @return
	 * 不建议使用
	 * TODO
	 */
	public Data getChildInfoByCiID(String ciID){
		return null;
	}
	
	/**
	 * 根据儿童材料ID获得儿童信息(for 收养组织)
	 * @param CI_ID
	 * @return
	 * 不建议使用
	 * TODO
	 */
	public Data getChildInfoByCiID4Adopt(String ciID){
		return null;
	}
	
	/**
	 * 根据儿童身份、儿童类型返回儿童材料附件集合
	 * @param childIdentity
	 * @param childType
	 * @param isAdopt  是否收养组织（false，否 默认，true，是）
	 * @return 附件集合代码，如返回error 代表参数有错误
	 * TODO
	 */
	public String getChildPackIdByChildIdentity(String childIdentity,String childType,boolean isAdopt){
		String retValue = "error";
		if(ChildInfoConstants.CHILD_IDENTITY_FOUNDLING.equals(childIdentity)){//查找不到生父母的弃婴和儿童
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//正常儿童
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_FOUNDLING_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_FOUNDLING;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_FOUNDLING_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_FOUNDLING;
			}
		}
		if(ChildInfoConstants.CHILD_IDENTITY_KINSHIP.equals(childIdentity)){//三代以内旁系血亲的子女
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//正常儿童
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_KINSHIP_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_KINSHIP;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_KINSHIP_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_KINSHIP;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_STEPCHILD.equals(childIdentity)){//继子女
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//正常儿童
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_STEPCHILD_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_STEPCHILD;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_STEPCHILD_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_STEPCHILD;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_WORPHAN.equals(childIdentity)){//丧失父母的孤儿-福利机构作收养人
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//正常儿童
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_WORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_WORPHAN;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_WORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_WORPHAN;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_PORPHAN.equals(childIdentity)){//丧失父母的孤儿-监护人作收养人
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//正常儿童
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_PORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_PORPHAN;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_PORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_PORPHAN;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_NOCIVILCON.equals(childIdentity)){//生父母均不具备完全民事行为能力
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//正常儿童
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_PUNABLE_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_PUNABLE;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_PUNABLE_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_PUNABLE;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_NOCIVILCONDUCT.equals(childIdentity)){//生父母均不具备完全民事行为能力且对被收养人有严重危害可能的子女
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//正常儿童
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_NOCIVILCONDUCT_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_NOCIVILCONDUCT;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_NOCIVILCONDUCT_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_NOCIVILCONDUCT;
			}
		}
		
		return retValue;
	}
	
	/**
	 * 获得汉语拼音
	 * 如果词语含有非汉语的单词，则不进行转换
	 * 如：张zhang 返回 ZHANG zhang
	 * @param src 词语
	 * @return 拼音
	 */
	public String getPinyin(String src) {
		
		char[] srcArray = src.toCharArray();
		
		// 设置汉字拼音输出的格式 
		HanyuPinyinOutputFormat outputFormat = new HanyuPinyinOutputFormat();		
		outputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		outputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
		outputFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);

		String[] pinyinArray;
		StringBuffer strbuf = new StringBuffer();
		
		try {
			for (int i = 0; i < srcArray.length; i++) {
				
				// 判断能否为汉字字符
				if(isChinese(srcArray[i])){
					pinyinArray = PinyinHelper.toHanyuPinyinStringArray(
							srcArray[i], outputFormat);

					if (pinyinArray.length != 0) {
						strbuf.append(pinyinArray[0]);
						strbuf.append(" ");
					}

				} else {
					// 如果不是汉字字符，间接取出字符并连接到字符串t4后
					strbuf.append(srcArray[i]);
				}
			}
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		return strbuf.toString().trim();
	}
	
	/**
	 * 判断输入的字符是否是汉字
	 * @param a
	 * @return
	 */
	public boolean isChinese(char a) { 
	     int v = (int)a; 
	     return (v >=19968 && v <= 171941); 
	}
	
	/**
	 * 根据儿童全局状态获取中心显示状态
	 */
	
	public String getChildStatus(String ciGlobalState,String level){
		String childStatus = null;
		if(ChildInfoConstants.LEVEL_CCCWA.equals(level)){//中心			
			childStatus = globalStatus.getChildStatusMap().get(ciGlobalState);			
		}else{//省厅或福利院
			childStatus =globalStatus.getChildStatusMap2().get(ciGlobalState);
		}		
		return childStatus;
	}
	
	/**
	 * 设置全局状态和位置—创建儿童材料
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data createChildInfo(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_WTJ);	
		String postion = "";
		if(org.getOrgType()==5){
			postion = ChildGlobalStatusAndPositionConstant.POS_FLY;
		}else if(org.getOrgType()==7){
			postion = ChildGlobalStatusAndPositionConstant.POS_ST;
		}else{
			postion = ChildGlobalStatusAndPositionConstant.POS_AZB;
		}
		
		childData.put("CI_POSITION", postion);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—福利院提交儿童材料
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data flySubmitChildInfo(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ST_DSH);
		childData.put("CI_POSITION", ChildGlobalStatusAndPositionConstant.POS_ST);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—省厅审核要求福利院补充
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stAuditSupply(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ST_FDB);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_ST);
		return childData;
	}	
	
	/**
	 * 设置全局状态和位置—省厅审核要求福利院补充中
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stAuditSupplySave(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ST_FBZ);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_ST);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—省厅审核要求福利院已补充
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stAuditSupplySubmit(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ST_FYB);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_ST);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—省厅审核不通过
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stAuditNoPass(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ST_BTG);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_ST);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—省厅审核通过
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stAuditPass(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ST_TG);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_ST);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—省厅已寄送
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stAuditPost(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ST_YJS);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_STTOAZB);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—中心接收
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data zxReceiveChildInfo(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ZX_YJS);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—中心审核要求补充材料
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data zxAuditSupply(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ZX_TDB);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
		return childData;
	}
	/**
	 * 设置全局状态和位置—中心审核要求材料补充中
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data zxAuditSupplySave(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ZX_TBZ);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—中心审核要求补充材料，已补充
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data zxAuditSupplySubimit(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ZX_TYB);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—中心审核不通过
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data zxAuditNoPass(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ZX_BTG);
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—中心审核通过送翻译
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data zxToTranslation(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_ZX_DSF);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—中心儿童材料批量送翻中
	 * @param conn
	 * @param TI_ID 移交单ID
	 * @param org
	 * @return
	 * @throws DBException 
	 */
	public void zxPreTranslation(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID,ChildGlobalStatusAndPositionConstant.STA_ZX_SFZ,ChildGlobalStatusAndPositionConstant.POS_AZB);
	}
	
	/**
	 * 设置全局状态和位置—已送翻
	 * @param conn
	 * @param TI_ID 移交单ID
	 * @param org
	 * @return
	 */
	public void zxSendTranslation(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID,ChildGlobalStatusAndPositionConstant.STA_ZX_SFDJS,ChildGlobalStatusAndPositionConstant.POS_AZBTOFYGS);
		
	}
	
	/**
	 * 设置全局状态和位置—送翻已接收
	 * @param conn
	 * @param TI_ID 移交单ID
	 * @param org
	 * @return
	 * @throws DBException 
	 */
	public void fygsReceiveTranslation(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_FY_DFY, ChildGlobalStatusAndPositionConstant.POS_FYGS);		
	}
	
	/**
	 * 设置全局状态和位置—翻译公司翻译中
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data fygsTranslationSave(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FY_FYZ);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_FYGS);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—翻译公司已翻译完成
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data fygsTranslationSubmit(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FY_YFDYJ);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_FYGS);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—翻译公司材料移交中
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data fygsAddTransfer(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FY_YFYJZ);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_FYGS);
		return childData;
	}
	
	/**
	 * 设置全局状态和位置—翻译公司已移交
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data fygsSubmitTransfer(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FY_YFDJS);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_FYGSTOAZB);
		return childData;
	}
	
	
	
	/**
	 * 设置全局状态和位置—安置部待发布（安置部已接收材料）
	 * @Title: azbToBePublished
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:29:11
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data azbToBePublished(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FB_DFB);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—安置部发布计划中
	 * @Title: azbPlanning
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:35:00
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data azbPlanning(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FB_JHZ);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	
	/**
	 * 设置全局状态和位置—安置部发布待预告
	 * @Title: azbToBeTrailered
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:39:58
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data azbToBeTrailered(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FB_DYG);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—安置部发布已预告
	 * @Title: azbIsTrailered
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:40:45
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data azbIsTrailered(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FB_YYG);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—安置部已发布
	 * @Title: azbIsPublished
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:41:39
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data azbIsPublished(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FB_YFB);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	
	/**
	 * 设置全局状态和位置—组织退回待确认
	 * @Title: syzzReturnToBeConfirmed
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:43:41
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data syzzReturnToBeConfirmed(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_FB_THDQR);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—组织已锁定儿童
	 * @Title: syzzIsLocked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:46:12
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data syzzIsLocked(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_YSD);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—预批待翻译
	 * @Title: preapprovedToBeTranslated
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:49:45
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedToBeTranslated(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_DFY);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—预批翻译中
	 * @Title: preapprovedIsTranslating
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:51:40
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedIsTranslating(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_FYZ);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—预批待审核
	 * @Title: preapprovedToBeAudited
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:53:19
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedToBeAudited(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_DSH);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—预批审核中
	 * @Title: preapprovedIsAuditing
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:53:59
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedIsAuditing(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_SHZ);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—预批不通过
	 * @Title: preapprovedNotThrough
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:57:05
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedNotThrough(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_BTG);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—预批通过
	 * @Title: preapprovedThrough
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午4:58:25
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedThrough(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_TG);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—已交文待登记（预批未启动）
	 * @Title: preapprovedNotStart
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午5:35:44
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedNotStart(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_WQD);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—启动绿通（预批已启动）
	 * @Title: preapprovedIsStarted
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午5:36:44
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data preapprovedIsStarted(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YP_YQD);    
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	
	/**
     * 设置全局状态和位置—预批撤销待确认
     * @Title: preapprovedRevokeToBeConfirmed
     * @Description: 
     * @author: xugy
     * @date: 2014-12-19下午5:40:44
     * @param childData
     * @param org
     * @return
     */
    public Data preapprovedRevokeToBeConfirmed(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YPCX_DQR);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	
	/**
	 * 设置全局状态和位置—经办人审核
	 * @Title: matchAuditJBR
	 * @Description: 正常儿童在匹配提交时调用，特需儿童在档案部接收文件时调用
	 * @author: xugy
	 * @date: 2014-12-19下午2:37:59
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data matchAuditJBR(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_SH_JBR);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	
	/**
	 * 设置全局状态和位置—部门主任复核
	 * @Title: matchAuditBMZR
	 * @Description: 经办人审核提交时调用
	 * @author: xugy
	 * @date: 2014-12-19下午2:39:03
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data matchAuditBMZR(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_SH_BMZR);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—部门主任复核不通过
	 * @Title: matchAuditNotThrough
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午6:07:06
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data matchAuditNotThrough(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_SH_BTG);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	
	/**
	 * 设置全局状态和位置—征求意见反馈同意
	 * @Description: 安置部征求意见同意时调用
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data adviceFeedBackAgree(Data childData,Organ org){
		childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_YJ_DYJ);	
		childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
		return childData;
	}
	
	
	
	/**
	 * 设置全局状态和位置—儿童材料向档案部移交中
	 * @Description: 交接单保存时调用
	 * @param childData
	 * @param org
	 * @return
	 */
	public void childTransferToDABSave(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_YJ_YJZ, ChildGlobalStatusAndPositionConstant.POS_AZB);		
	}
	
	/**
	 * 设置全局状态和位置—儿童材料向档案部 移交待接收
	 * @Description: 交接单提交时调用
	 * @param childData
	 * @param org
	 * @return
	 */
	public void childTransferToDABSubmit(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_YJ_DJS, ChildGlobalStatusAndPositionConstant.POS_AZBTODAB);
	}
	
	/**
	 * 设置全局状态和位置—儿童材料向档案部 移交已接收
	 * @Description: 档案部接收时调用
	 * @param childData
	 * @param org
	 * @return
	 */
	public void childTransferToDABReceive(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_QP_DQP, ChildGlobalStatusAndPositionConstant.POS_DAB);		
	}
	
	/**
	 * 设置全局状态和位置—中心主任签批通过（通知书未寄发）
	 * @Title: noticeToBeSend
	 * @Description: 中心主任签批通过时调用
	 * @author: xugy
	 * @date: 2014-12-19下午3:25:01
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data noticeToBeSent(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_TZS_DJF);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—通知书已寄发（未登记）
	 * @Title: noticeIsSent
	 * @Description: 通知书寄发时调用
	 * @author: xugy
	 * @date: 2014-12-19下午3:33:39
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data noticeIsSent(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_TZS_YJF);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	
	/**
	 * 设置全局状态和位置—已登记（登记成功）
	 * @Title: adoptionIsRegistered
	 * @Description: 省厅登记成功时调用
	 * @author: xugy
	 * @date: 2014-12-19下午3:41:30
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data adoptionIsRegistered(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_SYDJ_YDJ);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—无效登记（注销）
	 * @Title: adoptionIsInvalid
	 * @Description: 省厅无效登记或注销时登记
	 * @author: xugy
	 * @date: 2014-12-19下午6:05:20
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data adoptionIsInvalid(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_SYDJ_WXDJ);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	
	/**
	 * 设置全局状态和位置—档案部退材料未移交
	 * @Title: returnCINotTransfer
	 * @Description: 档案部同意安置部退材料申请时调用
	 * @author: xugy
	 * @date: 2014-12-19下午5:57:29
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data returnCINotTransfer(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_TCLYJ_WYJ);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	/**
	 * 设置全局状态和位置—档案部退材料拟移交
	 * @Title: returnCIToBeTransfered
	 * @Description: 档案部移交保存时调用
	 * @author: xugy
	 * @date: 2014-12-19下午5:59:02
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data returnCIToBeTransfered(Data childData,Organ org){//获取值
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_TCLYJ_NYJ);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	public void returnCIToBeTransfered(Connection conn,String TI_ID,Organ org) throws DBException{//修改
        this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_TCLYJ_NYJ, ChildGlobalStatusAndPositionConstant.POS_DAB);     
    }
	/**
	 * 设置全局状态和位置—档案部材料已移交（安置部材料待接收）
	 * @Title: returnCIIsTransfered
	 * @Description: 档案部移交提交时调用
	 * @author: xugy
	 * @date: 2014-12-19下午5:59:43
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data returnCIIsTransfered(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_TCLYJ_YYJ);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DABTOAZB);
        return childData;
    }
	public void returnCIIsTransfered(Connection conn,String TI_ID,Organ org) throws DBException{
        this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_TCLYJ_YYJ, ChildGlobalStatusAndPositionConstant.POS_DABTOAZB);     
    }
	/**
	 * 设置全局状态和位置—安置部材料已接收
	 * @Title: returnCIIsReceived
	 * @Description: 安置部接收档案部材料
	 * @author: xugy
	 * @date: 2014-12-19下午6:01:29
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data returnCIIsReceived(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_TCLYJ_YJS);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_AZB);
        return childData;
    }
	public void returnCIIsReceived(Connection conn,String TI_ID,Organ org) throws DBException{
        this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_TCLYJ_YJS, ChildGlobalStatusAndPositionConstant.POS_AZB);     
    }
	/**
	 * 设置全局状态和位置-材料撤销省厅待确认
	 * @Title: stToBeRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午5:26:11
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stToBeRevoked(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_CX_STDQR);  
        //childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	/**
	 * 设置全局状态和位置-材料撤销省厅已确认
	 * @Title: stIsRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午5:27:31
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data stIsRevoked(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_CX_STYQR);  
        //childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	/**
	 * 设置全局状态和位置-材料撤销中心待确认
	 * @Title: azbToBeRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午5:28:08
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data azbToBeRevoked(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_CX_ZXDQR);  
        //childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	/**
	 * 设置全局状态和位置-材料撤销中心已确认（材料退文）
	 * @Title: azbIsRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19下午5:28:55
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data azbIsRevoked(Data childData,Organ org){
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_CX_ZXYQR);  
        //childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	
	
	/**
	 * 设置儿童材料全局状态和位置
	 * @param childData	儿童材料data
	 * @param status		全局状态
	 * @param org			位置代码
	 * @return
	 */
	private Data setChildGlobalStatus(Data childData,String status,String orgCode){
		childData.setEntityName("CMS_CI_INFO");
		childData.setPrimaryKey("CI_ID");
		childData.put("CI_GLOBAL_STATE", status);	
		childData.put("CI_POSITION", orgCode);
		return childData;
	}
}
