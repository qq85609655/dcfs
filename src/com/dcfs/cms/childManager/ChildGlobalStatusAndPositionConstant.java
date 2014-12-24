package com.dcfs.cms.childManager;

import java.util.HashMap;
import java.util.Map;

/**
 * 
 * @description ����ȫ��״̬��λ�ó�����
 * @author ����
 * @date 2014-10-31
 * @return
 */
public class ChildGlobalStatusAndPositionConstant {
	private Map<String,String> childStatusMap;
	private Map<String,String> childStatusMap2;
	/**
	 * 
	 * @description ���췽��
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
	
	//***********����λ�ó���begin*********************/
	public static final String POS_BGS="0020";// �칫��
	public static final String POS_FYGS="0080";//���빫˾
	public static final String POS_DAB="0040";// ������
	public static final String POS_AZB="0050";//���ò�
	public static final String POS_AZBTOFYGS="5080";//���ò�--���빫˾
	public static final String POS_FYGSTOAZB="8050";//���빫˾--���ò�
	public static final String POS_AZBTODAB="5040";//���ò�--������
	public static final String POS_DABTOAZB="4050";//������--���ò�	
	public static final String POS_FLY="0011";	//����Ժ
	public static final String POS_ST="0012";	//ʡ��
	public static final String POS_STTOAZB="1240";	//ʡ��--���ò�
	
	
	//***********����ȫ��״̬����begin*********************/
	public static final String STA_WTJ			="00";		//00:δ�ύ
	public static final String STA_ST_DSH		="01";		//01:ʡ�������
	public static final String STA_ST_FDB		="02";		//02��ʡ�˸�����
	public static final String STA_ST_FBZ		="03";		//03��ʡ�˸�����
	public static final String STA_ST_FYB		="04";		//04��ʡ�˸��Ѳ�
	public static final String STA_ST_BTG		="05";		//05��ʡ��ͨ��
	
	public static final String STA_ST_TG		="10";		//10��ʡͨ��
	public static final String STA_ST_YJS		="11";		//11��ʡ�Ѽ���
	public static final String STA_ZX_YJS		="12";		//12�������ѽ���
	public static final String STA_ZX_TDB		="13";		//13�������˴���
	public static final String STA_ZX_TBZ		="14";		//14�������˲���
	public static final String STA_ZX_TYB		="15";		//15���������Ѳ�
	public static final String STA_ZX_BTG		="16";		//16�����Ĳ�ͨ��
	public static final String STA_ZX_DSF		="17";		//17�����ͷ�
	public static final String STA_ZX_SFZ		="18";		//18���ͷ���
	public static final String STA_ZX_SFDJS	    ="19";		//19���ͷ�������

	public static final String STA_FY_DFY		="20";		//20��������
	public static final String STA_FY_FYZ		="21";		//21��������
	public static final String STA_FY_YFDYJ	    ="22";		//22���ѷ�����ƽ�
	public static final String STA_FY_YFYJZ	    ="23";		//23���ѷ����ƽ���
	public static final String STA_FY_YFDJS	    ="24";		//24�����������
	
	public static final String STA_FB_DFB		="30";		//30��������
	public static final String STA_FB_JHZ		="31";		//31���ƻ���
	public static final String STA_FB_DYG		="32";		//32����Ԥ��
	public static final String STA_FB_YYG		="33";		//33����Ԥ��
	public static final String STA_FB_YFB		="34";		//34���ѷ���
	public static final String STA_FB_THDQR	    ="35";		//35���˻ش�ȷ��
	
	public static final String STA_YP_YSD		="37";		//37��������
	public static final String STA_YP_DFY		="38";		//38��Ԥ��������
	public static final String STA_YP_FYZ		="39";		//39��Ԥ��������
	public static final String STA_YP_DSH		="40";		//40��Ԥ�������
	public static final String STA_YP_SHZ		="41";		//41��Ԥ�������
	public static final String STA_YP_BTG		="47";		//47��Ԥ����ͨ��
	public static final String STA_YP_TG		="48";		//48��Ԥ��ͨ��
	
	public static final String STA_YP_WQD       ="50";      //50���ѽ��Ĵ��Ǽǣ�δ������
	public static final String STA_YP_YQD       ="51";      //51��������ͨ
	public static final String STA_YPCX_DQR     ="52";      //52��Ԥ��������ȷ��
	
	public static final String STA_SH_JBR		="60";		//60�����������
	public static final String STA_SH_BMZR		="61";		//61���������θ���
	public static final String STA_SH_BTG		="81";		//81���������θ��˲�ͨ��
	public static final String STA_YJ_DYJ		="62";		//62�����ƽ������������ò�δ�ƽ����������ͬ�⣩
	public static final String STA_YJ_YJZ		="63";		//63���򵵰����ƽ��У����ò����ƽ���
	public static final String STA_YJ_DJS		="64";		//64�������������գ����ò����ƽ���
	public static final String STA_QP_DQP		="65";		//65���������δ�ǩ�����������ѽ��գ�
	public static final String STA_TZS_DJF		="66";		//66:���ķ���ǩ��ͨ����
	public static final String STA_TZS_YJF		="67";		//67���Ѽķ���δ�Ǽǣ�
	public static final String STA_SYDJ_YDJ		="68";		//68���ѵǼ�
	public static final String STA_SYDJ_WXDJ    ="69";      //69����Ч�Ǽ�
	public static final String STA_TCLYJ_WYJ    ="70";      //70������������δ�ƽ�
	public static final String STA_TCLYJ_NYJ    ="71";      //71���������������ƽ�
	public static final String STA_TCLYJ_YYJ    ="72";      //72���������������ƽ������ò����ϴ����գ�
	public static final String STA_TCLYJ_YJS    ="73";      //73�����ò������ѽ���
	
	public static final String STA_CX_STDQR	    ="90";		//90���ط����������У�ʡ����ȷ�ϣ�
	public static final String STA_CX_STYQR   	="91";		//91���ط����������У�ʡ����ȷ�ϣ�
	public static final String STA_CX_ZXDQR	    ="92";		//92����������������ȷ��
	public static final String STA_CX_ZXYQR 	="93";		//93���������ģ�������ȷ�ϣ�
	
	
	
	
	//***********�ļ�ȫ��״̬����end*********************/
	
	/**
	 * �����ͯ����ȫ��״̬map�����ģ�
	 */
	private void initChildStatusMap(){
		childStatusMap = new HashMap();
		childStatusMap.put(STA_WTJ, "δ�ύ");
		childStatusMap.put(STA_ST_DSH, "ʡ�������");
		childStatusMap.put(STA_ST_FDB, "ʡ�˸�����");
		childStatusMap.put(STA_ST_FBZ, "ʡ�˸�����");
		childStatusMap.put(STA_ST_FYB, "ʡ�˸��Ѳ�");
		childStatusMap.put(STA_ST_BTG, "ʡ��ͨ��");
		childStatusMap.put(STA_ST_TG, "ʡͨ��");
		childStatusMap.put(STA_ST_YJS, "ʡ�Ѽ���");
	}
	/**
	 * �����ͯ����ȫ��״̬map��ʡ��������Ժ��
	 */
	private void initChildStatusMap2(){
		childStatusMap = new HashMap();
		childStatusMap.put(STA_WTJ, "δ�ύ");
		childStatusMap.put(STA_ST_DSH, "ʡ�������");
		childStatusMap.put(STA_ST_FDB, "ʡ�˸�����");
		childStatusMap.put(STA_ST_FBZ, "ʡ�˸�����");
		childStatusMap.put(STA_ST_FYB, "ʡ�˸��Ѳ�");
		childStatusMap.put(STA_ST_BTG, "ʡ��ͨ��");
		childStatusMap.put(STA_ST_TG, "ʡͨ��");
		childStatusMap.put(STA_ST_YJS, "ʡ�Ѽ���");
	}
	
}
