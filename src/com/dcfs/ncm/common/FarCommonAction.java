package com.dcfs.ncm.common;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.ncm.leaderSign.LeaderSignAction;
import com.dcfs.ncm.leaderSign.LeaderSignHandler;

import hx.code.UtilCode;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

public class FarCommonAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(LeaderSignAction.class);
	
	private Connection conn = null;
    
	private FarCommonHandler handler;
    
	private DBTransaction dt = null;//������
    
	private String retValue = SUCCESS;
	
	public FarCommonAction(){
        this.handler=new FarCommonHandler();
    }
	
	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	/**
	 * 
	 * @description ���������ǼǺ�(�������X1X2Ϊ�������ֱ��룬X3X4Ϊʡ���������룬X5X6X7X8Ϊ��ȣ�X9X10X11X12Ϊ��ʡ�����Ǽ���ˮ�š���)
	 * @author 
	 * @date 2014-8-5
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createFARSn(Connection conn,String Country_Code,String province_Code) throws SQLException, DBException{
		String FAR_SN="";//���������ǼǺ�
		String year = DateUtility.getCurrentYear();//���
		String province="";//ʡ����д
		String pr_ye_sn = "" ;//ʡ����ˮ��
		
		province=province_Code.substring(0,2);//ȡʡ�ݵ�ǰ��λ
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			//��ȡʡ����������Ǽ���ˮ��
			Data datan = this.handler.getMaxFARSn(conn,year,province);
			String maxNoStr = (String)datan.get("SN");//�õ����4λ��ˮ��
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				pr_ye_sn="000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				pr_ye_sn="00"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				pr_ye_sn="0"+maxNo;
			}else{
				pr_ye_sn=""+maxNo;
			}
			//ƴ��ǩ����
			FAR_SN=Country_Code+province+year+pr_ye_sn;//���������ǼǱ��
			Data data4 = new Data();
			data4.add("YEAR",year);
			data4.add("COUNTRY_CODE",Country_Code);
			data4.add("SN",pr_ye_sn);
			data4.add("FAR_SN",FAR_SN);
			data4.add("PROVINCE_ID", province);
			data4.add("IS_USED", "1");
			this.handler.saveMaxFARSN(conn, data4);
		}
		return FAR_SN;
	}
    /**
	 * 
	 * @description �����쵼ǩ�����(�������X1X2X3X4Ϊ��ȣ�X5X6X7Ϊ������ĸ���룬X8X9X10X11Ϊ�ù��ұ������������ˮ�ţ�X12X13Ϊʡ���������룬X14X15X16X17X18Ϊ����ȵ�֪ͨ����ˮ�š�)
	 * @author 
	 * @date 2014-8-5
	 * @return String connectNo 15λ�ƽ������
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createSignSN(Connection conn,String Country_Code,String province_Code) throws SQLException, DBException{
		String SignSn="";//����ǩ����
		String year = DateUtility.getCurrentYear();//���
		String Country_Name = "";//������д
		String country_Sn = "" ; //����������ˮ��
		String province="";//�����д
		String Notice_sn = "" ;//���֪ͨ����ˮ��
		
		Country_Name=(UtilCode.getCodeLists("GJDM_EN").get("GJDM_EN").getName(Country_Code))[0];
		province=province_Code.substring(0,2);//ȡʡ�ݵ�ǰ��λ
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			//��ѯ�������������ˮ��
			Data data = this.handler.getMaxCountrySn(conn,year,Country_Code);
			String maxNoStr = (String)data.get("SN");//�õ����4λ��ˮ��
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				country_Sn="000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				country_Sn="00"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				country_Sn="0"+maxNo;
			}else{
				country_Sn=""+maxNo;
			}
			//��ȡ���֪ͨ����ˮ��
			Data datan = this.handler.getMaxNoticeSn(conn,year);
			String max5NoStr = (String)datan.get("SN");//�õ����5λ��ˮ��
			if("".equals(max5NoStr)||null==max5NoStr){
				max5NoStr="0";
			}
			int max5No=Integer.parseInt(max5NoStr);
			max5No=max5No+1;
			if(max5No<10){
				Notice_sn="0000"+max5No;
			}else if(max5No>9&&max5No<100){
				Notice_sn="000"+max5No;
			}else if(max5No>99&&max5No<1000){
				Notice_sn="00"+max5No;
			}else if(max5No>999&&max5No<10000){
				Notice_sn="0"+max5No;
			}else{
				Notice_sn=""+max5No;
			}
			//ƴ��ǩ����
			SignSn="("+year+")"+Country_Name+"-"+country_Sn+"-"+province+"-"+Notice_sn;//�����ƽ������
			Data data4 = new Data();
			data4.add("YEAR",year);
			data4.add("COUNTRY_CODE",Country_Code);
			data4.add("SN",country_Sn);
			data4.add("SIGN_NO",SignSn);
			this.handler.saveMaxCountrySN(conn, data4);
			Data data5 = new Data();
			data5.add("YEAR",year);
			data5.add("SN",Notice_sn);
			data5.add("SIGN_NO",SignSn);
			this.handler.saveMaxNoticeSN(conn, data5);
		}
		
		return SignSn;
	}
	

}
