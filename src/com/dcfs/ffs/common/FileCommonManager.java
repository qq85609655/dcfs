package com.dcfs.ffs.common;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.UtilDateTime;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.common.transfercode.TransferCode;
import com.hp.hpl.sparta.xpath.ThisNodeTest;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;


/**
 * 
 * @description �ļ���������
 * @author MaYun
 * @date Jul 22, 2014
 * @return
 */
public class FileCommonManager{
	private static Log log = UtilLog.getLog(FileCommonManager.class);
	private FileCommonManagerHandler handler = new FileCommonManagerHandler();
	private Connection conn = null;//���ݿ�����
	private DBTransaction dt = null;//������
	
	/**
	 * �����ļ����ͺ͹��Ҵ��룬�õ������ļ��Ƿ�Ϊ��Լ���� 0:�ǹ�Լ������1����Լ����
	 * @description 
	 * @author MaYun
	 * @date Oct 27, 2014
	 * @return
	 * @throws DBException 
	 */
	public String getISGY(Connection conn,String fileType,String countryCode) throws DBException{
		String isGy="";
		Data data = new Data();
		data = this.handler.getCountryInfo(conn, countryCode);
		if(fileType.equals("31")||"31"==fileType){//����ļ�������"�ڻ�"�ģ���ù��һ�����Ϣ���"�ڻ���ס�Ƿ�Լ����"�ֶ�ֵ
			isGy = data.getString("SOLICIT_SUBMISSIONS");
		}else {//����ļ����Ͳ����ڻ��ģ���ù��һ�����Ϣ���"�Ƿ�Լ��"�ֶ�ֵ
			isGy = data.getString("CONVENTION");
		}
		
		return isGy;
	}
	
	/**
	 * @description �����ļ���ˮ��(�������11λ���֣�����4λ���+2λ�·�+2λ��+3λ��ˮ��)
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return String fileSeqNO �ļ���ˮ��
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createFileSeqNO(Connection conn) throws SQLException, DBException{
		String fileSeqNo="";
		String year = DateUtility.getCurrentYear();
		String month = DateUtility.getCurrentMonth();
		String day = DateUtility.getCurrentDay();
		int dayInt = Integer.parseInt(day);
		if(0<dayInt&&dayInt<10){
			day="0"+day;
		}
		
		synchronized (this) {
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxFileSeqNo(conn, year, month, day);//�õ���ǰ�����ˮ
			String maxNoStr = (String)data.get("no");
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="00"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="0"+maxNo;
			}else {
				maxNoStr=""+maxNo;
			}
			fileSeqNo=year+month+day+maxNoStr;//�����ļ���ˮ��
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("MONTH",month);
			data2.add("DAY",day);
			data2.add("NO",maxNoStr);
			data2.add("SEQ_NO",fileSeqNo);
			this.handler.saveMaxFileSeqNo(conn, data2);//���ļ���ˮ�ű������ˮ�������Ϣ
		}
		return fileSeqNo;
	}
	
	
	/**
	 * @description �������ı��(�������11λ���֣�����4λ���+2λ���Ҵ���+5λ��ˮ��)
	 * @param String orgCode ���Ҵ���
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return String fileNo ���ı��
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createFileNO(Connection conn,String orgCode) throws SQLException, DBException{
		String fileNo = "";
		String year = DateUtility.getCurrentYear();
		
		synchronized (this) {
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxFileNo(conn,year);
			String maxNoStr = (String)data.get("NO");//�õ����5λ��ˮ��
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="0000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="000"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				maxNoStr="00"+maxNo;
			}else if(maxNo>999&&maxNo<10000){
				maxNoStr="0"+maxNo;
			}else if(maxNo>9999){
				maxNoStr=""+maxNo;
			}
			
			fileNo=year+orgCode+maxNoStr;//�������ı��
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("COUNRTY_CODE",orgCode);
			data2.add("NO",maxNoStr);
			data2.add("FILE_NO",fileNo);
			this.handler.saveMaxFileNo(conn, data2);//�����ı�ű�������ı�������Ϣ
		}
		return fileNo;
	}
	
	/**
	 * 
	 * @description ���ɽɷѱ�ţ��������14λ���֣�����4λ���+5λ��������+2λ��������+3λ��ˮ�ţ�
	 * @author MaYun
	 * @date 2014-8-4
	 * @param String orgCode ������֯����
	 * @param String costType �������� 10:���������  20:��ͯ���Ϸ���� 99:����
	 * @return String payNo �ɷѱ��
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createPayNO(Connection conn,String orgCode,String costType) throws SQLException, DBException{
		String payNo="";
		String year = DateUtility.getCurrentYear();
		
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxPayNo(conn,year,orgCode,costType);
			String maxNoStr = (String)data.get("NO");//�õ����3λ��ˮ��
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="00"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="0"+maxNo;
			}else {
				maxNoStr=""+maxNo;
			}
			
			payNo=year+orgCode+costType+maxNoStr;//���ɽɷѱ��
			Data data3 = new Data();
			data3.add("YEAR",year);
			data3.add("ORG_CODE",orgCode);
			data3.add("COST_TYPE",costType);
			data3.add("NO",maxNoStr);
			data3.add("PAY_NO",payNo);
			this.handler.saveMaxPayNo(conn, data3);//��ɷѱ�ű����ɷѱ�������Ϣ
			
		}
		
		return payNo;
	}
	
	/**
	 * 
	 * @description �����ƽ������(�������15λ���֣�����4λ���+4λ���Ӳ���+4λ���ղ���+3λ���ӵ���ˮ��)
	 * @author MaYun
	 * @date 2014-8-5
	 * @param String transferCode �ƽ�����,����ֵ�����:com/dcfs/common/transfercode/TransferCode.java
	 * @return String connectNo 15λ�ƽ������
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createConnectNO(Connection conn,String transferCode) throws SQLException, DBException{
		String connectNo="";//�ƽ������
		String year = DateUtility.getCurrentYear();//���
		String fromDeptCode = "";//Դ����
		String toDeptCode = "";//Ŀ�겿��
		
		if(TransferCode.FILE_BGS_FYGS.equals(transferCode)||TransferCode.FILE_BGS_FYGS==transferCode){//�ļ����ӣ��칫�ҵ���֮��
			fromDeptCode = FileTransferDeptCodeConstant.BGS;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.FILE_FYGS_SHB.equals(transferCode)||TransferCode.FILE_FYGS_SHB==transferCode){//�ļ����ӣ���֮�ŵ���˲�
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.SHB;
		}else if(TransferCode.FILE_SHB_DAB.equals(transferCode)||TransferCode.FILE_SHB_DAB==transferCode){//�ļ����ӣ���˲���������
			fromDeptCode = FileTransferDeptCodeConstant.SHB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.CHILDINFO_AZB_FYGS.equals(transferCode)||TransferCode.CHILDINFO_AZB_FYGS==transferCode){//��ͯ���Ͻ��ӣ����ò������빫˾
			fromDeptCode = FileTransferDeptCodeConstant.AZB;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.CHILDINFO_FYGS_AZB.equals(transferCode)||TransferCode.CHILDINFO_FYGS_AZB==transferCode){//��ͯ���Ͻ��ӣ����빫˾�����ò�
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.AZB;
		}else if(TransferCode.CHILDINFO_AZB_DAB.equals(transferCode)||TransferCode.CHILDINFO_AZB_DAB==transferCode){//��ͯ���Ͻ��ӣ����ò���������
			fromDeptCode = FileTransferDeptCodeConstant.AZB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.CHEQUE_BGS_CWB.equals(transferCode)||TransferCode.CHEQUE_BGS_CWB==transferCode){//Ʊ�ݽ��ӣ��칫�ҵ�����
			fromDeptCode = FileTransferDeptCodeConstant.BGS;
			toDeptCode = FileTransferDeptCodeConstant.CWB;
		}else if(TransferCode.ARCHIVE_DAB_FYGS.equals(transferCode)||TransferCode.ARCHIVE_DAB_FYGS==transferCode){//���ú󱨸潻�ӣ������������빫˾
			fromDeptCode = FileTransferDeptCodeConstant.DAB;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.FILE_FYGS_SHB.equals(transferCode)||TransferCode.FILE_FYGS_SHB==transferCode){//���ú󱨸潻�ӣ����빫˾��������
			fromDeptCode = FileTransferDeptCodeConstant.DAB;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.ARCHIVE_FYGS_DAB.equals(transferCode)||TransferCode.ARCHIVE_FYGS_DAB==transferCode){//���ú󱨸潻�ӣ����빫˾��������
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_FILE_BGS_DAB.equals(transferCode)||TransferCode.RFM_FILE_BGS_DAB==transferCode){//�����ƽ�-�ļ����칫�ҵ�������
			fromDeptCode = FileTransferDeptCodeConstant.BGS;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_FILE_FYGS_DAB.equals(transferCode)||TransferCode.RFM_FILE_FYGS_DAB==transferCode){//�����ƽ�-�ļ������빫˾��������
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_FILE_SHB_DAB.equals(transferCode)||TransferCode.RFM_FILE_SHB_DAB==transferCode){//�����ƽ�-�ļ�����˲���������
			fromDeptCode = FileTransferDeptCodeConstant.SHB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_CHILDINFO_DAB_AZB.equals(transferCode)||TransferCode.RFM_CHILDINFO_DAB_AZB==transferCode){//�˲����ƽ�-���ϣ������������ò�
			fromDeptCode = FileTransferDeptCodeConstant.DAB;
			toDeptCode = FileTransferDeptCodeConstant.AZB;
		}
		
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxConnectNo(conn,year,fromDeptCode,toDeptCode);
			String maxNoStr = (String)data.get("NO");//�õ����3λ��ˮ��
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="00"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="0"+maxNo;
			}else {
				maxNoStr=""+maxNo;
			}
			
			connectNo=year+fromDeptCode+toDeptCode+maxNoStr;//�����ƽ������
			Data data4 = new Data();
			data4.add("YEAR",year);
			data4.add("FROM_DEPT_CODE",fromDeptCode);
			data4.add("TO_DEPT_CODE",toDeptCode);
			data4.add("NO",maxNoStr);
			data4.add("CONNECT_NO",connectNo);
			this.handler.saveMaxConnectNo(conn, data4);//���ƽ�����ű�����ƽ�����������Ϣ
			
		}
		
		return connectNo;
	}
	

  /**
    * 
    * @description ��ȡ�����ļ�ȫ��״̬��������֯��
    * @author MaYun
    * @date Jul 23, 2014
    * @return String globalStateName ������֯�����������ļ�ȫ��״̬
    */
   public String getGlobalStateNameForOrg(String seqNo,String fileNo){
	   String globalStateName = "";
	   //TODO
	   return globalStateName;
   }
	

   
   /**
    * 
    * @description ��ȡ�����ļ�λ�ã�������֯��
    * @author MaYun
    * @date Jul 23, 2014
    * @param String seqNo ��ˮ�� ��String fileNo ���ı��
    * @return String deptCode ������֯�����������ļ�λ��
    */
   public String getPositionForOrg(String seqNo,String fileNo){
	   String deptCode = "";
	   //TODO
	   return deptCode;
   }
   
   /**
    * 
    * @description  �������ı�Ż�������ļ���Ϣ
    * @author MaYun
    * @date Jul 28, 2014
    * @param String fileNo ���ı��
    * @return Data
    */
   public Data getCommonFileInfo(String fileNo,Connection conn){
	   Data data = new Data();
	   try {
		data = this.handler.getFileInfo(fileNo, conn);
	} catch (DBException e) {
		e.printStackTrace();
	}
	   return data;
   }
   
   /**
    * 
    * @description �������ı�Ż�������ļ���Ϣ������Ԥ������������Ϣ��
    * @author MaYun
    * @date Jul 28, 2014
    * @param String fileNo ���ı��
    * @return map
    */
   public Map getSpecialFileInfo(String fileNo){
	   Map map = new HashMap();
	   //TODO
	   return map;
   }
   
   /**
    * ������Ϣ��ʼ��
    * ��֮�Ž����ļ����ӵ���ϵͳ�Զ�����һ����������ļ���¼
	 * @author wangzheng
	 * @date 2014-7-30 10:02:37
	 * @param transferItem ���ӵ���¼
	 * @param transferDetailItems ������ϸ��¼
    * @return retValue
    */
   
   public void translationInit(Data transferItem,DataList transferDetailItems,Connection conn) throws DBException,SQLException{
   	//1����ʼ�����ݣ������ƽ�����ȡ����֪ͨ��Ϣ
   	
   	//��������
   	String strTranslationType = "0";
   	//����֪ͨ����=�ƽ�����
   	String strNoticeDate = transferItem.get("TRANSFER_DATE").toString();
   	//����֪ͨ��ID=�ƽ���ID
   	String strNoticeUserid = transferItem.get("TRANSFER_USERID").toString();
   	//����֪ͨ������=�ƽ�������
   	String strNoticeUserName = transferItem.get("TRANSFER_USERNAME").toString();
   	//����״̬=0�������룩
   	String strTranslationState = "0";

		//2 ִ�����ݿ⴦�����
       //2.1 �����ƽ���ϸ��¼���������ƽ����ļ����������¼
       DataList dl = new DataList();
       IDataExecute ide = DataBaseFactory.getDataBase(conn);
       
       for(int i=0;i<transferDetailItems.size();i++){
   		
       	//2.2���ļ�״̬Ϊ���Ļ���ͣ���򲻳�ʼ������
       //	if(transferItem.getString("IS_PAUSE").equals("1") || !transferItem.getString("RETURN_STATE").equals("")){
       //		break;	
       //	}
       	
       	//2.3 ��ʼ�������¼
       	Data ddata = (Data)transferDetailItems.get(i);            	
       	
       	Map<String, Object>  m = new HashMap<String, Object> ();
       	m.put("TRANSLATION_TYPE", strTranslationType);
       	m.put("AF_ID", ddata.get("APP_ID"));
       	m.put("NOTICE_DATE", strNoticeDate);
       	m.put("NOTICE_USERID", strNoticeUserid);
       	m.put("NOTICE_USERNAME", strNoticeUserName);
       	m.put("TRANSLATION_STATE", strTranslationState);
       	m.put("RECEIVE_DATE", UtilDateTime.nowDateString());
       	
       	Data data = new Data();
           data.setEntityName("FFS_AF_TRANSLATION");
           data.setPrimaryKey("AT_ID");
           data.setData(m);
       	dl.add(data);
   	}
       ide.batchCreate(dl);
   }


   
   /**
    * ��ʼ��������ϸ��TRANSFER_INFO_DETAIL������ 
    * Data ��װ����  ���£�
    * 1��APP_ID ҵ��ʵ���uuid 
    * 2��TRANSFER_CODE �������ʹ��� �������ݲμ� com.dcfs.common.transfercode.transfercode.java
    * 3��TRANSFER_STATE �ƽ�״̬ ����Ϊ��0��
    * @author WuTy
    * @param conn
    * @param dl
    * @return
    */
   public boolean transferDetailInit(Connection conn, DataList dl) throws DBException {
   	 //***��������*****
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
       for(int i=0;i<dl.size();i++){
       	dl.getData(i).setEntityName("TRANSFER_INFO_DETAIL");
       	dl.getData(i).setPrimaryKey("TID_ID");
       }
       ide.batchCreate(dl);
       
       return true;
   }
   
   /**
    * ��ʼ���ļ���˼�¼ <br>
    * @author mayun
    * @param Connection
    * @param DataList <br>
    * Data��װ���ݣ�<br>
    * AF_ID--�����ļ�������ID<br>
    * AUDIT_LEVEL--�������ʹ��� 0�����������; 1�������������;2���ֹ���������<br>
    */
   public void auditInit(Connection conn, DataList dl) throws DBException {
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   DataList fileInfoList = new DataList();//�ļ�������Ϣ��LIST
	   String curDate = DateUtility.getCurrentDateTime();//��ǰ����
	   
       for(int i=0;i<dl.size();i++){
    	   Data fileInfoData = new Data();//�ļ�������Ϣ��DATA
    	   fileInfoData.setEntityName("FFS_AF_INFO");
    	   fileInfoData.setPrimaryKey("AF_ID");
    	   fileInfoData.add("AF_ID", dl.getData(i).getString("AF_ID"));
    	   if("0".equals(dl.getData(i).getString("AUDIT_LEVEL"))||"0"==dl.getData(i).getString("AUDIT_LEVEL")){//���������
    		   fileInfoData.add("AUD_STATE","0"); //���״̬Ϊ�������˴����
    		   fileInfoData.add("RECEIVER_DATE",curDate);//���ļ���Ϣ���и���������ļ���������
    		   //TODO �����ļ�ȫ��״̬
    		   //TODO �����ļ�λ��
    	   }else if("1".equals(dl.getData(i).getString("AUDIT_LEVEL"))||"1"==dl.getData(i).getString("AUDIT_LEVEL")){//�������θ���
    		   fileInfoData.add("AUD_STATE","2"); //���״̬Ϊ���������δ�����
    		 //TODO �����ļ�ȫ��״̬
    		 //TODO �����ļ�λ��
    	   }else if("2".equals(dl.getData(i).getString("AUDIT_LEVEL"))||"2"==dl.getData(i).getString("AUDIT_LEVEL")){//�ֹ���������
    		   fileInfoData.add("AUD_STATE","3"); //���״̬Ϊ���ֹ����δ�����
    		 //TODO �����ļ�ȫ��״̬
    		 //TODO �����ļ�λ��
    	   }
    	   fileInfoList.add(fileInfoData);
    	   
    	   dl.getData(i).setEntityName("FFS_AF_AUDIT");
    	   dl.getData(i).setPrimaryKey("AU_ID");
    	   dl.getData(i).add("OPERATION_STATE", "0");//��˼�¼��Ĳ���״̬Ϊ:������
    	   
    	   
       }
       ide.batchCreate(dl);//����˼�¼���в��������Ϣ
       ide.batchStore(fileInfoList);//���ļ�������Ϣ���и����������״̬
   }
   
   /**
    * ��ʼ���ļ�ƥ���¼ʱ�������ļ�ƥ��״̬ <br>
    * @author mayun
    * @param Connection
    * @param DataList <br>
    * Data��װ���ݣ�<br>
    * AF_ID--�����ļ�������ID<br>
    * MATCH_STATE--ƥ��״̬<br>
    */
   public void piPeiInit(Connection conn, DataList dl) throws DBException {
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   DataList fileInfoList = new DataList();//�ļ�������Ϣ��LIST
	   
       for(int i=0;i<dl.size();i++){
    	   Data fileInfoData = new Data();//�ļ�������Ϣ��DATA
    	   fileInfoData.setEntityName("FFS_AF_INFO");
    	   fileInfoData.setPrimaryKey("AF_ID");
    	   fileInfoData.add("AF_ID", dl.getData(i).getString("AF_ID"));
    	   fileInfoData.add("MATCH_STATE", dl.getData(i).getString("MATCH_STATE"));
    	   //TODO �����ļ�ȫ��״̬
    	   //TODO �����ļ�λ��
    	   fileInfoList.add(fileInfoData);
    	   
       }
       ide.batchStore(fileInfoList);//���ļ�������Ϣ���и���ƥ��״̬Ϊ��ƥ��
   }
   
   
   /**
    * ������Ϣ��ʼ��
	 * @author wangzheng
	 * @date 2014-8-20
	 * @param afID �ļ�ID
	 * @param aaID �����¼ID
	 * @param translationType 		�������ͣ�0���ļ����룻1�����䷭�룻2�����·��룩
	 * @param noticeDate 			����֪ͨ���� ��ʽΪ��yyyy-MM-dd��
	 * @param aaContent  			����ԭ��
	 * @param noticeUserid  	 	֪ͨ��ID
	 * @param noticeUserName	֪ͨ������
	 * @param noticeFileId	֪ͨ����ID
	 * @param conn						���ݿ�����
    * @return 
    */
   
   public void translationInit(String afID,String aaID,String translationType,String noticeDate,String aaContent,String noticeUserid,String noticeUserName,String noticeFileId,Connection conn) throws DBException,SQLException{
   	//����״̬=0�������룩
   	String strTranslationState = "0";
   	String strTranslationUnit = "";
   	String strTranslationUnitName = "";
   	// ִ�����ݿ⴦�����
       IDataExecute ide = DataBaseFactory.getDataBase(conn);
       
       //��ȡ�ļ����뵥λ��Ϣ
       //����ǲ������ط������ȡ���ļ������¼�еķ��뵥λ��Ϣ
       Data dataTranslation = new Data();
       dataTranslation.setEntityName("FFS_AF_TRANSLATION");
       dataTranslation.put("AF_ID", afID);
       dataTranslation.put("TRANSLATION_TYPE", "0");
       dataTranslation.put("TRANSLATION_STATE", "2");
  	  	DataList dl =  ide.find(dataTranslation);
  	  	if(dl.size()!=0){
  	  		Data d = dl.getData(0);   	  		
  	  		strTranslationUnit = d.getString("TRANSLATION_UNIT");
  	  		strTranslationUnitName = d.getString("TRANSLATION_UNITNAME");
  	  	}
   	
		
       Map<String, Object>  m = new HashMap<String, Object> ();
   	m.put("TRANSLATION_TYPE", translationType);
   	m.put("AF_ID", afID);
   	m.put("AA_ID", aaID);
   	m.put("AA_CONTENT",aaContent);
   	m.put("NOTICE_DATE", noticeDate);
   	m.put("NOTICE_USERID", noticeUserid);
   	m.put("NOTICE_USERNAME", noticeUserName);
   	m.put("NOTICE_FILEID", noticeFileId);
   	m.put("TRANSLATION_STATE", strTranslationState);
   	m.put("RECEIVE_DATE", UtilDateTime.nowDateString());
   	m.put("TRANSLATION_UNIT",strTranslationUnit);
   	m.put("TRANSLATION_UNITNAME",strTranslationUnitName);
       	
       Data data = new Data();
       data.setEntityName("FFS_AF_TRANSLATION");
       data.setPrimaryKey("AT_ID");
       data.setData(m);
       ide.create(data);         
   }
   
   /**
    * @Title: revocationInit
    * @Description: ������Ϣ��ʼ������
	�����ķ������ģ��������ˡ���������Ϊ�գ�ֻ��дȷ�ϲ��š�ȷ���ˡ�ȷ������
	��������֯�������ģ���ȷ���ˡ�ȷ������Ϊ�գ�ϵͳ�����ļ�����λ���趨ȷ�ϲ���ID
    * @author: wangzheng
    * @param conn
    * @param data
    * 	Data��װ���ݣ�
		AF_ID���ļ�ID
		ADOPT_ORG_ID��������֯ID
		COUNTRY_CODE��������֯��������
		REGISTER_DATE����������
		FILE_NO�����ı��
		FILE_TYPE���ļ�����
		FAMILY_TYPE����������
		MALE_NAME��������������
		FEMALE_NAME��Ů����������
		RETURN_REASON������ԭ��
		HANDLE_TYPE�����Ĵ���ʽ
		    1����ȡ��Ĭ�ϣ�
			2����������
			3���Ļ�
			4������ת��֯
			9������
		APPLE_DATE��������������
		APPLE_PERSON_ID��������ID
		APPLE_PERSON_NAME������������
		ORG_ID��ȷ�ϲ���ID
		PERSON_ID��ȷ����ID
		PERSON_NAME��ȷ��������
		RETREAT_DATE��ȷ������
		BANK_CONTENT��ȷ�ϱ�ע
		APPLE_TYPE����������
			1�����������˳�����
			2����˲�ͨ���˳�����
			3������������� 
			4�������Ǽ�����
			5����ͣ��ʱ�˳�����
			9������
		RETURN_STATE������״̬
			��������Ϊ��2����˲���˲�ͨ����3������������ġ�4�������Ǽ����ġ�5����ͣ��ʱ�˳�������ʱ������״̬Ϊ1����ȷ��
			��������Ϊ1�����������˳�����ʱ������״̬Ϊ0����ȷ��
			0����ȷ��
			1����ȷ��
			2��������
			3���Ѵ���
		
    * @throws DBException
    * @return Data
    */
   public Data revocationInit(Connection conn, Data data) throws DBException {
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   data.setEntityName("RFM_AF_REVOCATION");
	   data.setPrimaryKey("AR_ID");
	   return ide.create(data);
   }

   /**
    * @Title: suppleInit 
    * @Description: �����ļ���Ϣ��ʼ������
    * @author: yangrt;
    * @param conn
    * @param data
    * 	Data��װ���ݣ�
    * 		AF_ID�������ļ�ID��
    * 		NOTICE_CONTENT������ԭ��
    * 		IS_MODIFY���Ƿ������޸Ļ�����Ϣ��
    * 		IS_ADDATTACH���Ƿ������丽����
    * @throws DBException
    * @return Data
    */
   public Data suppleInit(Connection conn, Data data) throws DBException {
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   UserInfo curuser = SessionInfo.getCurUser();
	   
	   if("".equals(data.getString("SEND_USERID"))||null==data.getString("SEND_USERID")){
		   data.add("SEND_USERID", curuser.getPersonId());	//���֪ͨ��ID
		   data.add("SEND_USERNAME", curuser.getPerson().getCName());	//���֪ͨ������
	   }
	   
	   if("".equals(data.getString("NOTICE_DATE"))||null==data.getString("NOTICE_DATE")){
		   data.add("NOTICE_DATE", DateUtility.getCurrentDate());	//���֪ͨ������
	   }
	   
	   data.setEntityName("FFS_AF_ADDITIONAL");
	   data.setPrimaryKey("AA_ID");
	   data.add("AA_STATUS", "0");	//��Ӳ���״̬��0=������
	   
	   return ide.create(data);
   }
   
    /**
     * �޸��ļ�������Ϣ
     * @description 
     * @author MaYun
     * @date Sep 5, 2014
     * @param Data fileData 
     * Data��װ���ݣ�
     * AF_ID:�ļ�����ID
     * @return
     * @throws DBException 
     */
	public void modifyFileInfo(Connection conn,Data data) throws DBException{
		 IDataExecute ide = DataBaseFactory.getDataBase(conn);
		data.setEntityName("FFS_AF_INFO");
		data.setPrimaryKey("AF_ID");
		String primaryID = data.getString("AF_ID");
		if("".equals(primaryID)||null==primaryID){
			return;
		}else{
			ide.store(data);
		}
	}
	
	
	/**
	 * @throws DBException 
	 * @Title: getAfCost 
	 * @Description: �����ļ����ͻ�ȡ�ļ�Ӧ�ɷ���
	 * @author: yangrt;
	 * @param conn
	 * @param file_type
	 * 		�����ļ���file_type="ZCWJFWF" : 800	
	 * 		�����ļ���file_type="TXWJFWF" : 500
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public int getAfCost(Connection conn, String file_type) throws DBException{
		 Data data = this.handler.getAfCost(conn, file_type);
		 return data.getInt("VALUE1");
	}
	
	public String getAdopterNation(Connection conn, String country_code) throws DBException{
		Data data = this.handler.getAdopterNation(conn, country_code);
		return data.getString("NATION","");
	}
	
	
	
	public static void main(String[] args){
		/*String year = DateUtility.getCurrentYear();
		String month = DateUtility.getCurrentMonth();
		String day = DateUtility.getCurrentDay();
		int dayInt = Integer.parseInt(day);
		if(0<dayInt&&dayInt<10){
			day="0"+day;
		}
		System.out.println(year+month+day);*/
		
		
		 SimpleDateFormat dfs = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		   java.util.Date begin;
		try {
			begin = dfs.parse("2004-01-02 11:30:24");
			java.util.Date end = dfs.parse("2004-03-26 13:31:40");
			long between=(end.getTime()-begin.getTime())/1000;//����1000��Ϊ��ת������

			   long day1=between/(24*3600);
			   long hour1=between%(24*3600)/3600;
			   long minute1=between%3600/60;
			   long second1=between%60/60;
			   System.out.println(""+day1+"��"+hour1+"Сʱ"+minute1+"��"+second1+"��");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   
		   

		
	}

}
