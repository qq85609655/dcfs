package com.dcfs.ffs.common;

import java.sql.Connection;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;


/**
 * 
 * @description �ļ�ȫ��״̬��λ�ù�����
 * @author MaYun
 * @date Jul 28, 2014
 */
public class FileCommonStatusAndPositionManager{
	private static Log log = UtilLog.getLog(FileCommonStatusAndPositionManager.class);
	private FileCommonStatusAndPositionManagerHandler handler = new FileCommonStatusAndPositionManagerHandler();
	private Connection conn = null;//���ݿ�����
	private DBTransaction dt = null;//������
	
	

   /**
    * 
    * @description ���ݲ������ͻ����һ�����ļ���ȫ��״̬���ļ�λ��
    * @author MaYun
    * @date Jul 28, 2014
    * @param String operType ��������<br>����com.dcfs.ffs.common.FileOperationConstant�ඨ�� <br>
    * @return Data <br>AF_GLOBAL_STATE:�ļ�ȫ��״̬;<br>AF_POSITION:�ļ�λ��;<br>
    * 
    */
   public Data getNextGlobalAndPosition(String operType){
	   String af_global_state = "";//�ļ�ȫ��״̬
	   String af_position = "";//�ļ�λ��
	   
	   if(operType.equals(FileOperationConstant.SYZZ_N_FILE_DELIVER_NEXT)||operType==FileOperationConstant.SYZZ_N_FILE_DELIVER_NEXT){//������֯-�ļ�����-�ݽ���ͨ�ļ���һ��
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//δ�ύ
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZ;//������֯
	   }else if(operType.equals(FileOperationConstant.SYZZ_N_FILE_DELIVER_SAVE)||operType==FileOperationConstant.SYZZ_N_FILE_DELIVER_SAVE){//������֯-�ļ�����-�ݽ���ͨ�ļ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//δ�ύ
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZ;//������֯
	   }else if(operType.equals(FileOperationConstant.SYZZ_N_FILE_DELIVER_SUBMIT)||operType==FileOperationConstant.SYZZ_N_FILE_DELIVER_SUBMIT){//������֯-�ļ�����-�ݽ���ͨ�ļ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//���Ǽ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZTOBGS;//������֯-�칫��
	   }else if(operType.equals(FileOperationConstant.SYZZ_S_FILE_DELIVER_SAVE)||operType==FileOperationConstant.SYZZ_S_FILE_DELIVER_SAVE){//������֯-�ļ�����-�ݽ������ļ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WTJ;//δ�ύ
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZ;//������֯
	   }else if(operType.equals(FileOperationConstant.SYZZ_S_FILE_DELIVER_SUBMIT)||operType==FileOperationConstant.SYZZ_S_FILE_DELIVER_SUBMIT){//������֯-�ļ�����-�ݽ������ļ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DDJ;//���Ǽ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_SYZZTOBGS;//������֯-�칫��
	   }else if(operType.equals(FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SAVE)||operType==FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SAVE){//������֯-�ļ�����-�����ļ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ2;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SUBMIT)||operType==FileOperationConstant.SYZZ_FILE_SUPPLEMNET_SUBMIT){//������֯-�ļ�����-�����ļ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ2;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_DL_SUBMIT)||operType==FileOperationConstant.BGS_REGISTRATION_DL_SUBMIT){//�칫��-�ļ�����-�ļ���¼�ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJDSF;//�ǼǴ��ͷ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//�칫��
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_PLDL_SUBMIT)||operType==FileOperationConstant.BGS_REGISTRATION_PLDL_SUBMIT){//�칫��-�ļ�����-������¼�ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJDSF;//�ǼǴ��ͷ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//�칫��
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_SGDJ_SUBMIT)||operType==FileOperationConstant.BGS_REGISTRATION_SGDJ_SUBMIT){//�칫��-�ļ�����-�ֹ��Ǽ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJDSF;//�ǼǴ��ͷ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//�칫��
	   }else if(operType.equals(FileOperationConstant.BGS_REGISTRATION_RETURN)||operType==FileOperationConstant.BGS_REGISTRATION_RETURN){//�칫��-�ļ�����-�˻�
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SWDJDBC;//���ĵǼǴ�����
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGS;//�칫��
	   }else if(operType.equals(FileOperationConstant.AZQ_FY_SAVE)||operType==FileOperationConstant.AZQ_FY_SAVE){//��֮��-�ļ�����-����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WJFYZ;//�ļ�������
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//���빫˾
	   }else if(operType.equals(FileOperationConstant.AZQ_FY_SUBMIT)||operType==FileOperationConstant.AZQ_FY_SUBMIT){//��֮��-�ļ�����-����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YFYDYJ;//�ļ��ѷ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//���빫˾
	   }else if(operType.equals(FileOperationConstant.AZQ_FY_SUBMIT)||operType==FileOperationConstant.AZQ_FY_SUBMIT){//��֮��-�ļ�����-�ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YFYDYJ;//�ļ��ѷ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//���빫˾
	   }else if(operType.equals(FileOperationConstant.BGS_BGSTOAZQ_JJD_SAVE)||operType==FileOperationConstant.BGS_BGSTOAZQ_JJD_SAVE){//�칫��-��֮�Ž��ӵ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SFZ;//�ͷ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_BGSTOFYGS;//�칫��-���빫˾
	   }else if(operType.equals(FileOperationConstant.BGS_BGSTOAZQ_JJD_SUBMIT)||operType==FileOperationConstant.BGS_BGSTOAZQ_JJD_SUBMIT){//�칫��-��֮�Ž��ӵ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SFDJS;//�ͷ�������
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//���빫˾
	   }else if(operType.equals(FileOperationConstant.AZQ_BGSTOAZQ_JJD_ACCEPT)||operType==FileOperationConstant.AZQ_BGSTOAZQ_JJD_ACCEPT){//�칫��-��֮�Ž�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WJDFY;//�ļ�������
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//���빫˾
	   }else if(operType.equals(FileOperationConstant.AZQ_AZQTOSHB_JJD_SAVE)||operType==FileOperationConstant.AZQ_AZQTOSHB_JJD_SAVE){//��֮��-��˲����ӵ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YFYDYJ;//�ѷ�����ƽ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGS;//���빫˾
	   }else if(operType.equals(FileOperationConstant.AZQ_AZQTOSHB_JJD_SUBMIT)||operType==FileOperationConstant.AZQ_AZQTOSHB_JJD_SUBMIT){//��֮��-��˲����ӵ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YBDJS;//һ��������
		   af_position = FileGlobalStatusAndPositionConstant.POS_FYGSTOSHB;//���빫˾-��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_AZQTOSHB_JJD_ACCEPT)||operType==FileOperationConstant.SHB_AZQTOSHB_JJD_ACCEPT){//��֮��-��˲�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRDSH;//�����˴����
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_SHBTODAB_JJD_SAVE)||operType==FileOperationConstant.SHB_SHBTODAB_JJD_SAVE){//��˲�-���������ӵ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DYJDAB;//���ƽ�������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_SHBTODAB_JJD_SUBMIT)||operType==FileOperationConstant.SHB_SHBTODAB_JJD_SUBMIT){//��˲�-���������ӵ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DABDJS;//������������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHBTODAB;//��˲�-������
	   }else if(operType.equals(FileOperationConstant.DAB_SHBTODAB_JJD_ACCEPT)||operType==FileOperationConstant.DAB_SHBTODAB_JJD_ACCEPT){//��˲�-����������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DPP;//��ƥ��
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.DAB_OTHERTODAB_JJD_ACCEPT)||operType==FileOperationConstant.DAB_OTHERTODAB_JJD_ACCEPT){//����������(���Ĵ����յ�)
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BTWDJS2;//���˴�����
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.SHB_TW_JJD_SAVE)||operType==FileOperationConstant.SHB_TW_JJD_SAVE){//��˲������ƽ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SHBTGDTW2;//��˲�ͨ��������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_TW_JJD_SUBMIT)||operType==FileOperationConstant.SHB_TW_JJD_SUBMIT){//��˲������ƽ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BTWDJS;//�����Ĵ�����
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_SB_SAVE)||operType==FileOperationConstant.SHB_WJCS_SB_SAVE){//�ļ���˳����ϱ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_SB_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_SB_SUBMIT){//�ļ���˳����ϱ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//�������θ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_TG_SAVE)||operType==FileOperationConstant.SHB_WJCS_TG_SAVE){//�ļ���˳���ͨ������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_TG_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_TG_SUBMIT){//�ļ���˳���ͨ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//�������θ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BTG_SAVE)||operType==FileOperationConstant.SHB_WJCS_BTG_SAVE){//�ļ���˳���ͨ������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BTG_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_BTG_SUBMIT){//�ļ���˳���ͨ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//�������θ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCWJ_SAVE)||operType==FileOperationConstant.SHB_WJCS_BCWJ_SAVE){//�ļ���˳��󲹳��ļ�����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCWJ_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_BCWJ_SUBMIT){//�ļ���˳��󲹳��ļ��ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCFY_SAVE)||operType==FileOperationConstant.SHB_WJCS_BCFY_SAVE){//�ļ���˳��󲹳䷭�뱣��
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_BCFY_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_BCFY_SUBMIT){//�ļ���˳��󲹳䷭���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_CXFY_SAVE)||operType==FileOperationConstant.SHB_WJCS_CXFY_SAVE){//�ļ���˳������·��뱣��
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJCS_CXFY_SUBMIT)||operType==FileOperationConstant.SHB_WJCS_CXFY_SUBMIT){//�ļ���˳������·����ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSHZ;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_TG_SAVE)||operType==FileOperationConstant.SHB_WJFH_TG_SAVE){//�ļ�����ͨ������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//�����������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_TG_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_TG_SUBMIT){//�ļ�����ͨ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DYJDAB;//���ƽ�������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_THJBR_SAVE)||operType==FileOperationConstant.SHB_WJFH_THJBR_SAVE){//�ļ������˻ؾ����˱���
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//�������θ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_THJBR_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_THJBR_SUBMIT){//�ļ������˻ؾ������ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSH;//���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_SBFGZR_SAVE)||operType==FileOperationConstant.SHB_WJFH_SBFGZR_SAVE){//�ļ������ϱ��ֹ����α���
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//�������θ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_SBFGZR_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_SBFGZR_SUBMIT){//�ļ������ϱ��ֹ������ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//�ֹ���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_BTG_SAVE)||operType==FileOperationConstant.SHB_WJFH_BTG_SAVE){//�ļ����˲�ͨ������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_BMZRFH;//�������θ���
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJFH_BTG_SUBMIT)||operType==FileOperationConstant.SHB_WJFH_BTG_SUBMIT){//�ļ����˲�ͨ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SHBTGDTW;//��˲�ͨ��������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_TG_SAVE)||operType==FileOperationConstant.SHB_WJSP_TG_SAVE){//�ļ�����ͨ������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//�ֹ���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_TG_SUBMIT)||operType==FileOperationConstant.SHB_WJSP_TG_SUBMIT){//�ļ�����ͨ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DYJDAB;//���ƽ�������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_THJBR_SAVE)||operType==FileOperationConstant.SHB_WJSP_THJBR_SAVE){//�ļ������˻ؾ����˱���
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//�ֹ���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_THJBR_SUBMIT)||operType==FileOperationConstant.SHB_WJSP_THJBR_SUBMIT){//�ļ������˻ؾ������ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_JBRSH;//���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_BTG_SAVE)||operType==FileOperationConstant.SHB_WJSP_BTG_SAVE){//�ļ�������ͨ������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_FGZRSP;//�ֹ���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.SHB_WJSP_BTG_SUBMIT)||operType==FileOperationConstant.SHB_WJSP_BTG_SUBMIT){//�ļ�������ͨ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_SHBTGDTW;//��˲�ͨ��������
		   af_position = FileGlobalStatusAndPositionConstant.POS_SHB;//��˲�
	   }else if(operType.equals(FileOperationConstant.AZB_ZCYW_PP_SUBMIT)||operType==FileOperationConstant.AZB_ZCYW_PP_SUBMIT){//����ҵ�����,ƥ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_PPJBRDSH;//ƥ�侭���˴����
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_TXYW_PP_SUBMIT)||operType==FileOperationConstant.AZB_TXYW_PP_SUBMIT){//����ҵ�����,ƥ���ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_PPJBRDSH;//ƥ�侭���˴����
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_SH_SB)||operType==FileOperationConstant.AZB_PPH_SH_SB){//ƥ������-ƥ�����-�ϱ�
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_PPBMZRDFH;//ƥ�䲿�����δ�����
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_FHTG_SUBMIT)||operType==FileOperationConstant.AZB_PPH_FHTG_SUBMIT){//ƥ������-ƥ�临��ͨ��-�ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DZQYJ;//���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_FHBTG_SUBMIT)||operType==FileOperationConstant.AZB_PPH_FHBTG_SUBMIT){//ƥ������-ƥ�临�˲�ͨ��-�ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DPP2;//��ƥ��
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_TZ)||operType==FileOperationConstant.AZB_PPH_ZQYJ_TZ){//ƥ������-�������-֪ͨ������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJZ;//���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_AGREE)||operType==FileOperationConstant.AZB_PPH_ZQYJ_FKQR_AGREE){//ƥ������-�������-����ȷ��-ͬ��
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJFKQR_TY;//�����������ȷ��ͬ��
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP)||operType==FileOperationConstant.AZB_PPH_ZQYJ_FKQR_CXPP){//ƥ������-�������-����ȷ��-����ƥ��
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJFKQR_CXPP;//�����������ȷ������ƥ��
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.AZB_PPH_ZQYJ_FKQR_TW)||operType==FileOperationConstant.AZB_PPH_ZQYJ_FKQR_TW){//ƥ������-�������-����ȷ��-����
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJFKQR_TW;//�����������ȷ������
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.SYZZ_GZFK_ZQYJ_SUBMIT)||operType==FileOperationConstant.SYZZ_GZFK_ZQYJ_SUBMIT){//������������ύ
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_ZQYJZ2;//���������
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.DAB_WJJJ_AZBTODAB_CLJS)||operType==FileOperationConstant.DAB_WJJJ_AZBTODAB_CLJS){//���������Ͻ���
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DQP;//��ǩ��
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.DAB_AZH_SHJG_JSGZ)||operType==FileOperationConstant.DAB_AZH_SHJG_JSGZ){//������˽��Ϊ��������
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YBJ;//�Ѱ��
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.ZXLD_TZS_QPTG)||operType==FileOperationConstant.ZXLD_TZS_QPTG){//�����쵼ǩ��ͨ��
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_DJF;//���ķ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.BGS_TZS_JF)||operType==FileOperationConstant.BGS_TZS_JF){//֪ͨ���ӡ�ķ�
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YJF;//�Ѽķ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.ST_SYDJ_DJCG)||operType==FileOperationConstant.ST_SYDJ_DJCG){//�����Ǽǳɹ�
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_YDJ;//�ѵǼ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }else if(operType.equals(FileOperationConstant.ST_SYDJ_DJWX)||operType==FileOperationConstant.ST_SYDJ_DJWX){//�����Ǽ���Ч
		   af_global_state = FileGlobalStatusAndPositionConstant.STA_WXDJ;//��Ч�Ǽ�
		   af_position = FileGlobalStatusAndPositionConstant.POS_DAB;//������
	   }
	   
	   
	   
	   Data data = new Data();
	   data.add("AF_GLOBAL_STATE", af_global_state);
	   data.add("AF_POSITION", af_position);
	   return data;
   }
   
   /**
    * 
    * @description ���ݵ�ǰ�ļ�ȫ��״̬����õ�ǰ�����ļ�λ���Լ�������֯�ļ�״̬
    * @author MaYun
    * @date Jul 23, 2014
    * @param String currentGlobalStatus ��ǰ�ļ�ȫ��״̬<br>����com.dcfs.ffs.common.FileGlobalStatusAndPositionConstant�ඨ��<br>
    * @return Data <br>AF_POSITION:�ļ�λ��;<br>AF_ORG_STATE:������֯�ļ�״̬<br>
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
    * @description ���ݲ������ͺ������ļ�����ID�������һ�����ļ���ȫ��״̬���ļ�λ�ò����µ��ļ�������Ϣ����
    * @author MaYun
    * @date Jul 29, 2014
    * @param Connection conn ���ݿ�����<br>
    * @param String operType ��������<br>����com.dcfs.ffs.common.FileOperationConstant�ඨ�� <br>
    * @param fileID �ļ�����ID<br>
    */
   public void updateNextGlobalStatusAndPositon(Connection conn,String operType,String fileID) throws DBException{
	   Data data =  this.getNextGlobalAndPosition(operType);
	   data.add("AF_ID", fileID);
	   handler.updateNextGlobalStatusAndPositon(conn, data);
   }

   
   
   
  
   
   
	
	
	
}
