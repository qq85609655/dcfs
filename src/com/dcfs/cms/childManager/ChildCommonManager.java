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
	private Connection conn = null;//���ݿ�����
	
	private ChildManagerHandler handler;
	private ChildGlobalStatusAndPositionConstant globalStatus=new ChildGlobalStatusAndPositionConstant() ;

	public ChildCommonManager() {
		this.handler=new ChildManagerHandler();
	}
	//��ȡ��֯����ʡ��ID
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
     * ���ɶ�ͯ���
     * ��ͯ������ɹ���
     * ��2λʡ�ݴ���+4λ���+5λ����������ˮ�ţ�
     * @param data
     * 
     * @return CHILD_NO ��ͯ���
     * @throws DBException 
     */
    public String createChildNO(Data data,Connection conn) throws DBException{
    	StringBuffer CHILD_NO = new StringBuffer();
    	//���ʡ��ID�͵�ǰ���
    	String proviceId = data.getString("PROVINCE_ID","00");
    	String curYear = DateUtility.getCurrentYear();
    	//���ʡ��ID�ĳ���С��2����ֱ�Ӹ�ֵΪ00
    	if(proviceId.length()<2){
    		proviceId = "00";
    	}
    	proviceId = proviceId.substring(0,2);
    	int imaxNO = 1;
    	String operType = "revise";
    	synchronized(this){
    		//��ѯ��ͯ��ű���ȡ����ͯ���
    		Data d = handler.getMaxChildNO(conn,proviceId,curYear);
    		if(d!=null){//���ڵ�ǰ��ȣ���ʡ�ݵı�ż�¼
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
    			//����5λ��ˮ��
    			for(int i=strMaxNO.length();i<5;i++){
    				strMaxNO="0" + strMaxNO;
    			}
    			CHILD_NO = CHILD_NO.append(proviceId).append(curYear).append(strMaxNO);
    		}
    	}
    	return CHILD_NO.toString();    	
    }
	/**
	 * ����ʡ��CODE��ȡ��ʡ�����и���Ժ��¼
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
	 * ��ȡ���и���Ժ��Ϣ
	 * TODO
	 * @return
	 */
	public Map<String,DataList> getAllWelfareMap(){
		return null;
	}
	
	/**
	 * ��ȡ���и���Ժ��Ϣ
	 * @return
	 */
	public DataList getAllWelfareList(Connection conn) throws DBException{
        DataList orgList = handler.getAllWelfareList(conn);        
        return orgList;
	}
	
	/**
	 * ���ݶ�ͯ��Ż�ö�ͯ��Ϣ
	 * @param childNO
	 * @return
	 * TODO
	 */
	public Data getChildInfoByChildNO(String childNO){
		return null;
	}
	
	/**
	 * ���ݶ�ͯ��Ż�ö�ͯ��Ϣ(for ������֯)
	 * @param childNO
	 * @return
	 * TODO
	 */
	public Data getChildInfoByChildNO4Adopt(String childNO){
		return null;
	}
	
	/**
	 * ���ݶ�ͯ����ID��ö�ͯ��Ϣ
	 * @param CI_ID
	 * @return
	 * ������ʹ��
	 * TODO
	 */
	public Data getChildInfoByCiID(String ciID){
		return null;
	}
	
	/**
	 * ���ݶ�ͯ����ID��ö�ͯ��Ϣ(for ������֯)
	 * @param CI_ID
	 * @return
	 * ������ʹ��
	 * TODO
	 */
	public Data getChildInfoByCiID4Adopt(String ciID){
		return null;
	}
	
	/**
	 * ���ݶ�ͯ��ݡ���ͯ���ͷ��ض�ͯ���ϸ�������
	 * @param childIdentity
	 * @param childType
	 * @param isAdopt  �Ƿ�������֯��false���� Ĭ�ϣ�true���ǣ�
	 * @return �������ϴ��룬�緵��error ��������д���
	 * TODO
	 */
	public String getChildPackIdByChildIdentity(String childIdentity,String childType,boolean isAdopt){
		String retValue = "error";
		if(ChildInfoConstants.CHILD_IDENTITY_FOUNDLING.equals(childIdentity)){//���Ҳ�������ĸ����Ӥ�Ͷ�ͯ
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//������ͯ
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_FOUNDLING_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_FOUNDLING;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_FOUNDLING_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_FOUNDLING;
			}
		}
		if(ChildInfoConstants.CHILD_IDENTITY_KINSHIP.equals(childIdentity)){//����������ϵѪ�׵���Ů
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//������ͯ
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_KINSHIP_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_KINSHIP;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_KINSHIP_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_KINSHIP;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_STEPCHILD.equals(childIdentity)){//����Ů
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//������ͯ
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_STEPCHILD_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_STEPCHILD;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_STEPCHILD_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_STEPCHILD;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_WORPHAN.equals(childIdentity)){//ɥʧ��ĸ�Ĺ¶�-����������������
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//������ͯ
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_WORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_WORPHAN;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_WORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_WORPHAN;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_PORPHAN.equals(childIdentity)){//ɥʧ��ĸ�Ĺ¶�-�໤����������
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//������ͯ
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_PORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_PORPHAN;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_PORPHAN_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_PORPHAN;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_NOCIVILCON.equals(childIdentity)){//����ĸ�����߱���ȫ������Ϊ����
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//������ͯ
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_PUNABLE_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_PUNABLE;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_PUNABLE_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_PUNABLE;
			}
		}
		
		if(ChildInfoConstants.CHILD_IDENTITY_NOCIVILCONDUCT.equals(childIdentity)){//����ĸ�����߱���ȫ������Ϊ�����ҶԱ�������������Σ�����ܵ���Ů
			if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(childType)){//������ͯ
				if(isAdopt)
					retValue = AttConstants.CI_NORMAL_NOCIVILCONDUCT_ADOPT;
				else
					retValue = AttConstants.CI_NORMAL_NOCIVILCONDUCT;
			}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//�����ͯ
				if(isAdopt)
					retValue = AttConstants.CI_SPECIAL_NOCIVILCONDUCT_ADOPT;
				else
					retValue = AttConstants.CI_SPECIAL_NOCIVILCONDUCT;
			}
		}
		
		return retValue;
	}
	
	/**
	 * ��ú���ƴ��
	 * ������ﺬ�зǺ���ĵ��ʣ��򲻽���ת��
	 * �磺��zhang ���� ZHANG zhang
	 * @param src ����
	 * @return ƴ��
	 */
	public String getPinyin(String src) {
		
		char[] srcArray = src.toCharArray();
		
		// ���ú���ƴ������ĸ�ʽ 
		HanyuPinyinOutputFormat outputFormat = new HanyuPinyinOutputFormat();		
		outputFormat.setToneType(HanyuPinyinToneType.WITHOUT_TONE);
		outputFormat.setVCharType(HanyuPinyinVCharType.WITH_V);
		outputFormat.setCaseType(HanyuPinyinCaseType.UPPERCASE);

		String[] pinyinArray;
		StringBuffer strbuf = new StringBuffer();
		
		try {
			for (int i = 0; i < srcArray.length; i++) {
				
				// �ж��ܷ�Ϊ�����ַ�
				if(isChinese(srcArray[i])){
					pinyinArray = PinyinHelper.toHanyuPinyinStringArray(
							srcArray[i], outputFormat);

					if (pinyinArray.length != 0) {
						strbuf.append(pinyinArray[0]);
						strbuf.append(" ");
					}

				} else {
					// ������Ǻ����ַ������ȡ���ַ������ӵ��ַ���t4��
					strbuf.append(srcArray[i]);
				}
			}
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			e.printStackTrace();
		}
		return strbuf.toString().trim();
	}
	
	/**
	 * �ж�������ַ��Ƿ��Ǻ���
	 * @param a
	 * @return
	 */
	public boolean isChinese(char a) { 
	     int v = (int)a; 
	     return (v >=19968 && v <= 171941); 
	}
	
	/**
	 * ���ݶ�ͯȫ��״̬��ȡ������ʾ״̬
	 */
	
	public String getChildStatus(String ciGlobalState,String level){
		String childStatus = null;
		if(ChildInfoConstants.LEVEL_CCCWA.equals(level)){//����			
			childStatus = globalStatus.getChildStatusMap().get(ciGlobalState);			
		}else{//ʡ������Ժ
			childStatus =globalStatus.getChildStatusMap2().get(ciGlobalState);
		}		
		return childStatus;
	}
	
	/**
	 * ����ȫ��״̬��λ�á�������ͯ����
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
	 * ����ȫ��״̬��λ�á�����Ժ�ύ��ͯ����
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
	 * ����ȫ��״̬��λ�á�ʡ�����Ҫ����Ժ����
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
	 * ����ȫ��״̬��λ�á�ʡ�����Ҫ����Ժ������
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
	 * ����ȫ��״̬��λ�á�ʡ�����Ҫ����Ժ�Ѳ���
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
	 * ����ȫ��״̬��λ�á�ʡ����˲�ͨ��
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
	 * ����ȫ��״̬��λ�á�ʡ�����ͨ��
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
	 * ����ȫ��״̬��λ�á�ʡ���Ѽ���
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
	 * ����ȫ��״̬��λ�á����Ľ���
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
	 * ����ȫ��״̬��λ�á��������Ҫ�󲹳����
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
	 * ����ȫ��״̬��λ�á��������Ҫ����ϲ�����
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
	 * ����ȫ��״̬��λ�á��������Ҫ�󲹳���ϣ��Ѳ���
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
	 * ����ȫ��״̬��λ�á�������˲�ͨ��
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
	 * ����ȫ��״̬��λ�á��������ͨ���ͷ���
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
	 * ����ȫ��״̬��λ�á����Ķ�ͯ���������ͷ���
	 * @param conn
	 * @param TI_ID �ƽ���ID
	 * @param org
	 * @return
	 * @throws DBException 
	 */
	public void zxPreTranslation(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID,ChildGlobalStatusAndPositionConstant.STA_ZX_SFZ,ChildGlobalStatusAndPositionConstant.POS_AZB);
	}
	
	/**
	 * ����ȫ��״̬��λ�á����ͷ�
	 * @param conn
	 * @param TI_ID �ƽ���ID
	 * @param org
	 * @return
	 */
	public void zxSendTranslation(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID,ChildGlobalStatusAndPositionConstant.STA_ZX_SFDJS,ChildGlobalStatusAndPositionConstant.POS_AZBTOFYGS);
		
	}
	
	/**
	 * ����ȫ��״̬��λ�á��ͷ��ѽ���
	 * @param conn
	 * @param TI_ID �ƽ���ID
	 * @param org
	 * @return
	 * @throws DBException 
	 */
	public void fygsReceiveTranslation(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_FY_DFY, ChildGlobalStatusAndPositionConstant.POS_FYGS);		
	}
	
	/**
	 * ����ȫ��״̬��λ�á����빫˾������
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
	 * ����ȫ��״̬��λ�á����빫˾�ѷ������
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
	 * ����ȫ��״̬��λ�á����빫˾�����ƽ���
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
	 * ����ȫ��״̬��λ�á����빫˾���ƽ�
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
	 * ����ȫ��״̬��λ�á����ò������������ò��ѽ��ղ��ϣ�
	 * @Title: azbToBePublished
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:29:11
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
	 * ����ȫ��״̬��λ�á����ò������ƻ���
	 * @Title: azbPlanning
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:35:00
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
	 * ����ȫ��״̬��λ�á����ò�������Ԥ��
	 * @Title: azbToBeTrailered
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:39:58
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
	 * ����ȫ��״̬��λ�á����ò�������Ԥ��
	 * @Title: azbIsTrailered
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:40:45
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
	 * ����ȫ��״̬��λ�á����ò��ѷ���
	 * @Title: azbIsPublished
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:41:39
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
	 * ����ȫ��״̬��λ�á���֯�˻ش�ȷ��
	 * @Title: syzzReturnToBeConfirmed
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:43:41
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
	 * ����ȫ��״̬��λ�á���֯��������ͯ
	 * @Title: syzzIsLocked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:46:12
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
	 * ����ȫ��״̬��λ�á�Ԥ��������
	 * @Title: preapprovedToBeTranslated
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:49:45
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
	 * ����ȫ��״̬��λ�á�Ԥ��������
	 * @Title: preapprovedIsTranslating
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:51:40
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
	 * ����ȫ��״̬��λ�á�Ԥ�������
	 * @Title: preapprovedToBeAudited
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:53:19
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
	 * ����ȫ��״̬��λ�á�Ԥ�������
	 * @Title: preapprovedIsAuditing
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:53:59
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
	 * ����ȫ��״̬��λ�á�Ԥ����ͨ��
	 * @Title: preapprovedNotThrough
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:57:05
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
	 * ����ȫ��״̬��λ�á�Ԥ��ͨ��
	 * @Title: preapprovedThrough
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����4:58:25
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
	 * ����ȫ��״̬��λ�á��ѽ��Ĵ��Ǽǣ�Ԥ��δ������
	 * @Title: preapprovedNotStart
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����5:35:44
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
	 * ����ȫ��״̬��λ�á�������ͨ��Ԥ����������
	 * @Title: preapprovedIsStarted
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����5:36:44
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
     * ����ȫ��״̬��λ�á�Ԥ��������ȷ��
     * @Title: preapprovedRevokeToBeConfirmed
     * @Description: 
     * @author: xugy
     * @date: 2014-12-19����5:40:44
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
	 * ����ȫ��״̬��λ�á����������
	 * @Title: matchAuditJBR
	 * @Description: ������ͯ��ƥ���ύʱ���ã������ͯ�ڵ����������ļ�ʱ����
	 * @author: xugy
	 * @date: 2014-12-19����2:37:59
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
	 * ����ȫ��״̬��λ�á��������θ���
	 * @Title: matchAuditBMZR
	 * @Description: ����������ύʱ����
	 * @author: xugy
	 * @date: 2014-12-19����2:39:03
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
	 * ����ȫ��״̬��λ�á��������θ��˲�ͨ��
	 * @Title: matchAuditNotThrough
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����6:07:06
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
	 * ����ȫ��״̬��λ�á������������ͬ��
	 * @Description: ���ò��������ͬ��ʱ����
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
	 * ����ȫ��״̬��λ�á���ͯ�����򵵰����ƽ���
	 * @Description: ���ӵ�����ʱ����
	 * @param childData
	 * @param org
	 * @return
	 */
	public void childTransferToDABSave(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_YJ_YJZ, ChildGlobalStatusAndPositionConstant.POS_AZB);		
	}
	
	/**
	 * ����ȫ��״̬��λ�á���ͯ�����򵵰��� �ƽ�������
	 * @Description: ���ӵ��ύʱ����
	 * @param childData
	 * @param org
	 * @return
	 */
	public void childTransferToDABSubmit(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_YJ_DJS, ChildGlobalStatusAndPositionConstant.POS_AZBTODAB);
	}
	
	/**
	 * ����ȫ��״̬��λ�á���ͯ�����򵵰��� �ƽ��ѽ���
	 * @Description: ����������ʱ����
	 * @param childData
	 * @param org
	 * @return
	 */
	public void childTransferToDABReceive(Connection conn,String TI_ID,Organ org) throws DBException{
		this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_QP_DQP, ChildGlobalStatusAndPositionConstant.POS_DAB);		
	}
	
	/**
	 * ����ȫ��״̬��λ�á���������ǩ��ͨ����֪ͨ��δ�ķ���
	 * @Title: noticeToBeSend
	 * @Description: ��������ǩ��ͨ��ʱ����
	 * @author: xugy
	 * @date: 2014-12-19����3:25:01
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
	 * ����ȫ��״̬��λ�á�֪ͨ���Ѽķ���δ�Ǽǣ�
	 * @Title: noticeIsSent
	 * @Description: ֪ͨ��ķ�ʱ����
	 * @author: xugy
	 * @date: 2014-12-19����3:33:39
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
	 * ����ȫ��״̬��λ�á��ѵǼǣ��Ǽǳɹ���
	 * @Title: adoptionIsRegistered
	 * @Description: ʡ���Ǽǳɹ�ʱ����
	 * @author: xugy
	 * @date: 2014-12-19����3:41:30
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
	 * ����ȫ��״̬��λ�á���Ч�Ǽǣ�ע����
	 * @Title: adoptionIsInvalid
	 * @Description: ʡ����Ч�Ǽǻ�ע��ʱ�Ǽ�
	 * @author: xugy
	 * @date: 2014-12-19����6:05:20
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
	 * ����ȫ��״̬��λ�á��������˲���δ�ƽ�
	 * @Title: returnCINotTransfer
	 * @Description: ������ͬ�ⰲ�ò��˲�������ʱ����
	 * @author: xugy
	 * @date: 2014-12-19����5:57:29
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
	 * ����ȫ��״̬��λ�á��������˲������ƽ�
	 * @Title: returnCIToBeTransfered
	 * @Description: �������ƽ�����ʱ����
	 * @author: xugy
	 * @date: 2014-12-19����5:59:02
	 * @param childData
	 * @param org
	 * @return
	 */
	public Data returnCIToBeTransfered(Data childData,Organ org){//��ȡֵ
        childData.put("CI_GLOBAL_STATE", ChildGlobalStatusAndPositionConstant.STA_TCLYJ_NYJ);  
        childData.put("CI_POSITION",  ChildGlobalStatusAndPositionConstant.POS_DAB);
        return childData;
    }
	public void returnCIToBeTransfered(Connection conn,String TI_ID,Organ org) throws DBException{//�޸�
        this.handler.updateChildGlobalStatusByTiID(conn, TI_ID, ChildGlobalStatusAndPositionConstant.STA_TCLYJ_NYJ, ChildGlobalStatusAndPositionConstant.POS_DAB);     
    }
	/**
	 * ����ȫ��״̬��λ�á��������������ƽ������ò����ϴ����գ�
	 * @Title: returnCIIsTransfered
	 * @Description: �������ƽ��ύʱ����
	 * @author: xugy
	 * @date: 2014-12-19����5:59:43
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
	 * ����ȫ��״̬��λ�á����ò������ѽ���
	 * @Title: returnCIIsReceived
	 * @Description: ���ò����յ���������
	 * @author: xugy
	 * @date: 2014-12-19����6:01:29
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
	 * ����ȫ��״̬��λ��-���ϳ���ʡ����ȷ��
	 * @Title: stToBeRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����5:26:11
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
	 * ����ȫ��״̬��λ��-���ϳ���ʡ����ȷ��
	 * @Title: stIsRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����5:27:31
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
	 * ����ȫ��״̬��λ��-���ϳ������Ĵ�ȷ��
	 * @Title: azbToBeRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����5:28:08
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
	 * ����ȫ��״̬��λ��-���ϳ���������ȷ�ϣ��������ģ�
	 * @Title: azbIsRevoked
	 * @Description: 
	 * @author: xugy
	 * @date: 2014-12-19����5:28:55
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
	 * ���ö�ͯ����ȫ��״̬��λ��
	 * @param childData	��ͯ����data
	 * @param status		ȫ��״̬
	 * @param org			λ�ô���
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
