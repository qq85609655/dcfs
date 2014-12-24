package com.dcfs.common.transfercode;
/**
 * @ClassName: TransferCode
 * @Description: �������ʹ��볣����
 * @author ������
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
	 * �ļ����ӣ��칫�ҵ����빫˾
	 */
	public static final String FILE_BGS_FYGS="11";
	/**
	 * �ļ����ӣ����빫˾����˲�
	 */
	public static final String FILE_FYGS_SHB="12";
	/**
	 * �ļ����ӣ���˲���������
	 */
	public static final String FILE_SHB_DAB="13";
	
	
	
	/**
	 * ��ͯ���Ͻ��ӣ����ò������빫˾
	 */
	public static final String CHILDINFO_AZB_FYGS="21";
	/**
	 * ��ͯ���Ͻ��ӣ����빫˾�����ò�
	 */
	public static final String CHILDINFO_FYGS_AZB="22";
	/**
	 * ��ͯ���Ͻ��ӣ����ò���������
	 */
	public static final String CHILDINFO_AZB_DAB="23";
	
	/**
	 * Ʊ�ݽ��ӣ��칫�ҵ�����
	 */
	public static final String CHEQUE_BGS_CWB="31";
	
	
	/**
	 * ���ú󱨸潻�ӣ������������빫˾
	 */
	public static final String ARCHIVE_DAB_FYGS="41";
	/**
	 * ���ú󱨸潻�ӣ����빫˾��������
	 */
	public static final String ARCHIVE_FYGS_DAB="42";
	
	/**
	 * �����ƽ�-�ļ����칫�ҵ�������
	 */
	public static final String RFM_FILE_BGS_DAB="51";
	/**
	 * �����ƽ�-�ļ������빫˾��������
	 */
	public static final String RFM_FILE_FYGS_DAB="52";
	/**
	 * �����ƽ�-�ļ�����˲���������
	 */
	public static final String RFM_FILE_SHB_DAB="53";
	/**
	 * ���Ľ���-�ļ������е������������ļ�����
	 */
	public static final String RFM_FILE_DAB="5";
	/**
	 * �˲����ƽ�-���ϣ������������ò�
	 */
	public static final String RFM_CHILDINFO_DAB_AZB="61";
	
	/**
	 * ����Ϊ֧������Ǩ�Ƶ����Ķ���
	 */
	/**
	 * ������-�칫����ʷ��������
	 */
	public static final String RFM_DAB_BGS="91";
	/**
	 * ��˲�-�칫����ʷ��������
	 */
	public static final String RFM_SHB_BGS="92";
	/**
	 * ���벿	�칫����ʷ��������
	 */
	public static final String RFM_QZQ_BGS="93";
	/**
	 * 90259024
	 */
	public static final String RFM_BHS_DAB="94";
	
	public static final String getPrintTitleByTransferCode(String TRANSFER_CODE){
		String title = "";
		if(CHILDINFO_AZB_FYGS.equals(TRANSFER_CODE)){
			title = "(���ò�-���빫˾)";
		}
		if(CHILDINFO_FYGS_AZB.equals(TRANSFER_CODE)){
			title = "(���빫˾-���ò�)";
		}
		if(CHILDINFO_AZB_DAB.equals(TRANSFER_CODE)){
			title = "(���ò�-������)";
		}
		if(ARCHIVE_DAB_FYGS.equals(TRANSFER_CODE)){
		    title = "(������-��֮��)";
		}
		if(ARCHIVE_FYGS_DAB.equals(TRANSFER_CODE)){
		    title = "(��֮��-������)";
		}
		if(CHEQUE_BGS_CWB.equals(TRANSFER_CODE)){
		    title = "(�칫��-����)";
		}
		if(RFM_CHILDINFO_DAB_AZB.equals(TRANSFER_CODE)){
		    title = "(������-���ò�)";
		}
		return title;
	}
	public static final String getPrintTitle0ByTransferCode(String TRANSFER_CODE){
		String title = "�ƽ���";
		if(CHEQUE_BGS_CWB.equals(TRANSFER_CODE)){
		    title = "Ʊ���ƽ���";
		}		
		if(CHILDINFO_AZB_FYGS.equals(TRANSFER_CODE)){
			title = "��ͯ�����ͷ���";
		}	
		if(CHILDINFO_AZB_DAB.equals(TRANSFER_CODE)){
			title = "��ͯ�����ƽ���";
		}
		if(ARCHIVE_DAB_FYGS.equals(TRANSFER_CODE) || ARCHIVE_FYGS_DAB.equals(TRANSFER_CODE)){
		    title = "���ú��������ͷ���";
		}	
		if(RFM_CHILDINFO_DAB_AZB.equals(TRANSFER_CODE)){
		    title = "��ͯ�����ƽ���";
		}
		return title;
	}
}
