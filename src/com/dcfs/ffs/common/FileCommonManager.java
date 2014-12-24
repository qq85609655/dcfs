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
 * @description 文件办理公共类
 * @author MaYun
 * @date Jul 22, 2014
 * @return
 */
public class FileCommonManager{
	private static Log log = UtilLog.getLog(FileCommonManager.class);
	private FileCommonManagerHandler handler = new FileCommonManagerHandler();
	private Connection conn = null;//数据库连接
	private DBTransaction dt = null;//事务处理
	
	/**
	 * 根据文件类型和国家代码，得到收养文件是否为公约收养 0:非公约收养；1：公约收养
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
		if(fileType.equals("31")||"31"==fileType){//如果文件类型是"在华"的，获得国家基本信息表的"在华居住是否公约收养"字段值
			isGy = data.getString("SOLICIT_SUBMISSIONS");
		}else {//如果文件类型不是在华的，获得国家基本信息表的"是否公约国"字段值
			isGy = data.getString("CONVENTION");
		}
		
		return isGy;
	}
	
	/**
	 * @description 生成文件流水号(编码规则：11位数字，其中4位年度+2位月份+2位天+3位流水号)
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return String fileSeqNO 文件流水号
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
			Data data = this.handler.getMaxFileSeqNo(conn, year, month, day);//得到当前最大流水
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
			fileSeqNo=year+month+day+maxNoStr;//生成文件流水号
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("MONTH",month);
			data2.add("DAY",day);
			data2.add("NO",maxNoStr);
			data2.add("SEQ_NO",fileSeqNo);
			this.handler.saveMaxFileSeqNo(conn, data2);//向文件流水号表插入流水号相关信息
		}
		return fileSeqNo;
	}
	
	
	/**
	 * @description 生成收文编号(编码规则：11位数字，其中4位年份+2位国家代码+5位流水号)
	 * @param String orgCode 国家代码
	 * @author MaYun
	 * @date Jul 22, 2014
	 * @return String fileNo 收文编号
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createFileNO(Connection conn,String orgCode) throws SQLException, DBException{
		String fileNo = "";
		String year = DateUtility.getCurrentYear();
		
		synchronized (this) {
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxFileNo(conn,year);
			String maxNoStr = (String)data.get("NO");//得到最大5位流水号
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
			
			fileNo=year+orgCode+maxNoStr;//生成收文编号
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("COUNRTY_CODE",orgCode);
			data2.add("NO",maxNoStr);
			data2.add("FILE_NO",fileNo);
			this.handler.saveMaxFileNo(conn, data2);//向收文编号表插入收文编号相关信息
		}
		return fileNo;
	}
	
	/**
	 * 
	 * @description 生成缴费编号（编码规则：14位数字，其中4位年度+5位收养机构+2位费用类型+3位流水号）
	 * @author MaYun
	 * @date 2014-8-4
	 * @param String orgCode 收养组织代码
	 * @param String costType 费用类型 10:收养服务费  20:儿童资料服务费 99:其他
	 * @return String payNo 缴费编号
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createPayNO(Connection conn,String orgCode,String costType) throws SQLException, DBException{
		String payNo="";
		String year = DateUtility.getCurrentYear();
		
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxPayNo(conn,year,orgCode,costType);
			String maxNoStr = (String)data.get("NO");//得到最大3位流水号
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
			
			payNo=year+orgCode+costType+maxNoStr;//生成缴费编号
			Data data3 = new Data();
			data3.add("YEAR",year);
			data3.add("ORG_CODE",orgCode);
			data3.add("COST_TYPE",costType);
			data3.add("NO",maxNoStr);
			data3.add("PAY_NO",payNo);
			this.handler.saveMaxPayNo(conn, data3);//向缴费编号表插入缴费编号相关信息
			
		}
		
		return payNo;
	}
	
	/**
	 * 
	 * @description 生成移交单编号(编码规则：15位数字，其中4位年度+4位交接部门+4位接收部门+3位交接单流水号)
	 * @author MaYun
	 * @date 2014-8-5
	 * @param String transferCode 移交类型,具体值请参照:com/dcfs/common/transfercode/TransferCode.java
	 * @return String connectNo 15位移交单编号
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createConnectNO(Connection conn,String transferCode) throws SQLException, DBException{
		String connectNo="";//移交单编号
		String year = DateUtility.getCurrentYear();//年份
		String fromDeptCode = "";//源部门
		String toDeptCode = "";//目标部门
		
		if(TransferCode.FILE_BGS_FYGS.equals(transferCode)||TransferCode.FILE_BGS_FYGS==transferCode){//文件交接：办公室到爱之桥
			fromDeptCode = FileTransferDeptCodeConstant.BGS;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.FILE_FYGS_SHB.equals(transferCode)||TransferCode.FILE_FYGS_SHB==transferCode){//文件交接：爱之桥到审核部
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.SHB;
		}else if(TransferCode.FILE_SHB_DAB.equals(transferCode)||TransferCode.FILE_SHB_DAB==transferCode){//文件交接：审核部到档案部
			fromDeptCode = FileTransferDeptCodeConstant.SHB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.CHILDINFO_AZB_FYGS.equals(transferCode)||TransferCode.CHILDINFO_AZB_FYGS==transferCode){//儿童材料交接：安置部到翻译公司
			fromDeptCode = FileTransferDeptCodeConstant.AZB;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.CHILDINFO_FYGS_AZB.equals(transferCode)||TransferCode.CHILDINFO_FYGS_AZB==transferCode){//儿童材料交接：翻译公司到安置部
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.AZB;
		}else if(TransferCode.CHILDINFO_AZB_DAB.equals(transferCode)||TransferCode.CHILDINFO_AZB_DAB==transferCode){//儿童材料交接：安置部到档案部
			fromDeptCode = FileTransferDeptCodeConstant.AZB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.CHEQUE_BGS_CWB.equals(transferCode)||TransferCode.CHEQUE_BGS_CWB==transferCode){//票据交接：办公室到财务部
			fromDeptCode = FileTransferDeptCodeConstant.BGS;
			toDeptCode = FileTransferDeptCodeConstant.CWB;
		}else if(TransferCode.ARCHIVE_DAB_FYGS.equals(transferCode)||TransferCode.ARCHIVE_DAB_FYGS==transferCode){//安置后报告交接：档案部到翻译公司
			fromDeptCode = FileTransferDeptCodeConstant.DAB;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.FILE_FYGS_SHB.equals(transferCode)||TransferCode.FILE_FYGS_SHB==transferCode){//安置后报告交接：翻译公司到档案部
			fromDeptCode = FileTransferDeptCodeConstant.DAB;
			toDeptCode = FileTransferDeptCodeConstant.AZQFYB;
		}else if(TransferCode.ARCHIVE_FYGS_DAB.equals(transferCode)||TransferCode.ARCHIVE_FYGS_DAB==transferCode){//安置后报告交接：翻译公司到档案部
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_FILE_BGS_DAB.equals(transferCode)||TransferCode.RFM_FILE_BGS_DAB==transferCode){//退文移交-文件：办公室到档案部
			fromDeptCode = FileTransferDeptCodeConstant.BGS;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_FILE_FYGS_DAB.equals(transferCode)||TransferCode.RFM_FILE_FYGS_DAB==transferCode){//退文移交-文件：翻译公司到档案部
			fromDeptCode = FileTransferDeptCodeConstant.AZQFYB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_FILE_SHB_DAB.equals(transferCode)||TransferCode.RFM_FILE_SHB_DAB==transferCode){//退文移交-文件：审核部到档案部
			fromDeptCode = FileTransferDeptCodeConstant.SHB;
			toDeptCode = FileTransferDeptCodeConstant.DAB;
		}else if(TransferCode.RFM_CHILDINFO_DAB_AZB.equals(transferCode)||TransferCode.RFM_CHILDINFO_DAB_AZB==transferCode){//退材料移交-材料：档案部到安置部
			fromDeptCode = FileTransferDeptCodeConstant.DAB;
			toDeptCode = FileTransferDeptCodeConstant.AZB;
		}
		
		synchronized(this){
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxConnectNo(conn,year,fromDeptCode,toDeptCode);
			String maxNoStr = (String)data.get("NO");//得到最大3位流水号
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
			
			connectNo=year+fromDeptCode+toDeptCode+maxNoStr;//生成移交单编号
			Data data4 = new Data();
			data4.add("YEAR",year);
			data4.add("FROM_DEPT_CODE",fromDeptCode);
			data4.add("TO_DEPT_CODE",toDeptCode);
			data4.add("NO",maxNoStr);
			data4.add("CONNECT_NO",connectNo);
			this.handler.saveMaxConnectNo(conn, data4);//向移交单编号表插入移交单编号相关信息
			
		}
		
		return connectNo;
	}
	

  /**
    * 
    * @description 获取收养文件全局状态（收养组织）
    * @author MaYun
    * @date Jul 23, 2014
    * @return String globalStateName 收养组织看到的收养文件全局状态
    */
   public String getGlobalStateNameForOrg(String seqNo,String fileNo){
	   String globalStateName = "";
	   //TODO
	   return globalStateName;
   }
	

   
   /**
    * 
    * @description 获取收养文件位置（收养组织）
    * @author MaYun
    * @date Jul 23, 2014
    * @param String seqNo 流水号 ，String fileNo 收文编号
    * @return String deptCode 收养组织看到的收养文件位置
    */
   public String getPositionForOrg(String seqNo,String fileNo){
	   String deptCode = "";
	   //TODO
	   return deptCode;
   }
   
   /**
    * 
    * @description  根据收文编号获得收养文件信息
    * @author MaYun
    * @date Jul 28, 2014
    * @param String fileNo 收文编号
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
    * @description 根据收文编号获得特需文件信息（包括预批申请和审核信息）
    * @author MaYun
    * @date Jul 28, 2014
    * @param String fileNo 收文编号
    * @return map
    */
   public Map getSpecialFileInfo(String fileNo){
	   Map map = new HashMap();
	   //TODO
	   return map;
   }
   
   /**
    * 翻译信息初始化
    * 爱之桥接收文件交接单后，系统自动生成一条待翻译的文件记录
	 * @author wangzheng
	 * @date 2014-7-30 10:02:37
	 * @param transferItem 交接单记录
	 * @param transferDetailItems 交接明细记录
    * @return retValue
    */
   
   public void translationInit(Data transferItem,DataList transferDetailItems,Connection conn) throws DBException,SQLException{
   	//1、初始化数据，根据移交单获取翻译通知信息
   	
   	//翻译类型
   	String strTranslationType = "0";
   	//翻译通知日期=移交日期
   	String strNoticeDate = transferItem.get("TRANSFER_DATE").toString();
   	//翻译通知人ID=移交人ID
   	String strNoticeUserid = transferItem.get("TRANSFER_USERID").toString();
   	//翻译通知人姓名=移交人姓名
   	String strNoticeUserName = transferItem.get("TRANSFER_USERNAME").toString();
   	//翻译状态=0（待翻译）
   	String strTranslationState = "0";

		//2 执行数据库处理操作
       //2.1 遍历移交明细记录，将所有移交的文件创建翻译记录
       DataList dl = new DataList();
       IDataExecute ide = DataBaseFactory.getDataBase(conn);
       
       for(int i=0;i<transferDetailItems.size();i++){
   		
       	//2.2如文件状态为退文或暂停，则不初始化数据
       //	if(transferItem.getString("IS_PAUSE").equals("1") || !transferItem.getString("RETURN_STATE").equals("")){
       //		break;	
       //	}
       	
       	//2.3 初始化翻译记录
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
    * 初始化交接详细表（TRANSFER_INFO_DETAIL）方法 
    * Data 封装内容  如下：
    * 1、APP_ID 业务实体的uuid 
    * 2、TRANSFER_CODE 交接类型代码 具体内容参见 com.dcfs.common.transfercode.transfercode.java
    * 3、TRANSFER_STATE 移交状态 设置为“0”
    * @author WuTy
    * @param conn
    * @param dl
    * @return
    */
   public boolean transferDetailInit(Connection conn, DataList dl) throws DBException {
   	 //***保存数据*****
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
       for(int i=0;i<dl.size();i++){
       	dl.getData(i).setEntityName("TRANSFER_INFO_DETAIL");
       	dl.getData(i).setPrimaryKey("TID_ID");
       }
       ide.batchCreate(dl);
       
       return true;
   }
   
   /**
    * 初始化文件审核记录 <br>
    * @author mayun
    * @param Connection
    * @param DataList <br>
    * Data封装内容：<br>
    * AF_ID--收养文件表主键ID<br>
    * AUDIT_LEVEL--交接类型代码 0：经办人审核; 1：部门主任审核;2：分管主任审批<br>
    */
   public void auditInit(Connection conn, DataList dl) throws DBException {
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   DataList fileInfoList = new DataList();//文件基本信息表LIST
	   String curDate = DateUtility.getCurrentDateTime();//当前日期
	   
       for(int i=0;i<dl.size();i++){
    	   Data fileInfoData = new Data();//文件基本信息表DATA
    	   fileInfoData.setEntityName("FFS_AF_INFO");
    	   fileInfoData.setPrimaryKey("AF_ID");
    	   fileInfoData.add("AF_ID", dl.getData(i).getString("AF_ID"));
    	   if("0".equals(dl.getData(i).getString("AUDIT_LEVEL"))||"0"==dl.getData(i).getString("AUDIT_LEVEL")){//经办人审核
    		   fileInfoData.add("AUD_STATE","0"); //审核状态为：经办人待审核
    		   fileInfoData.add("RECEIVER_DATE",curDate);//向文件信息表中更新审核人文件接收日期
    		   //TODO 更新文件全局状态
    		   //TODO 更新文件位置
    	   }else if("1".equals(dl.getData(i).getString("AUDIT_LEVEL"))||"1"==dl.getData(i).getString("AUDIT_LEVEL")){//部门主任复核
    		   fileInfoData.add("AUD_STATE","2"); //审核状态为：部门主任待复核
    		 //TODO 更新文件全局状态
    		 //TODO 更新文件位置
    	   }else if("2".equals(dl.getData(i).getString("AUDIT_LEVEL"))||"2"==dl.getData(i).getString("AUDIT_LEVEL")){//分管主任审批
    		   fileInfoData.add("AUD_STATE","3"); //审核状态为：分管主任待审批
    		 //TODO 更新文件全局状态
    		 //TODO 更新文件位置
    	   }
    	   fileInfoList.add(fileInfoData);
    	   
    	   dl.getData(i).setEntityName("FFS_AF_AUDIT");
    	   dl.getData(i).setPrimaryKey("AU_ID");
    	   dl.getData(i).add("OPERATION_STATE", "0");//审核记录表的操作状态为:待处理
    	   
    	   
       }
       ide.batchCreate(dl);//向审核记录表中插入审核信息
       ide.batchStore(fileInfoList);//向文件基本信息表中更新最新审核状态
   }
   
   /**
    * 初始化文件匹配记录时，更新文件匹配状态 <br>
    * @author mayun
    * @param Connection
    * @param DataList <br>
    * Data封装内容：<br>
    * AF_ID--收养文件表主键ID<br>
    * MATCH_STATE--匹配状态<br>
    */
   public void piPeiInit(Connection conn, DataList dl) throws DBException {
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   DataList fileInfoList = new DataList();//文件基本信息表LIST
	   
       for(int i=0;i<dl.size();i++){
    	   Data fileInfoData = new Data();//文件基本信息表DATA
    	   fileInfoData.setEntityName("FFS_AF_INFO");
    	   fileInfoData.setPrimaryKey("AF_ID");
    	   fileInfoData.add("AF_ID", dl.getData(i).getString("AF_ID"));
    	   fileInfoData.add("MATCH_STATE", dl.getData(i).getString("MATCH_STATE"));
    	   //TODO 更新文件全局状态
    	   //TODO 更新文件位置
    	   fileInfoList.add(fileInfoData);
    	   
       }
       ide.batchStore(fileInfoList);//向文件基本信息表中更新匹配状态为待匹配
   }
   
   
   /**
    * 翻译信息初始化
	 * @author wangzheng
	 * @date 2014-8-20
	 * @param afID 文件ID
	 * @param aaID 补充记录ID
	 * @param translationType 		翻译类型（0：文件翻译；1：补充翻译；2：重新翻译）
	 * @param noticeDate 			翻译通知日期 格式为‘yyyy-MM-dd’
	 * @param aaContent  			翻译原因
	 * @param noticeUserid  	 	通知人ID
	 * @param noticeUserName	通知人姓名
	 * @param noticeFileId	通知附件ID
	 * @param conn						数据库连接
    * @return 
    */
   
   public void translationInit(String afID,String aaID,String translationType,String noticeDate,String aaContent,String noticeUserid,String noticeUserName,String noticeFileId,Connection conn) throws DBException,SQLException{
   	//翻译状态=0（待翻译）
   	String strTranslationState = "0";
   	String strTranslationUnit = "";
   	String strTranslationUnitName = "";
   	// 执行数据库处理操作
       IDataExecute ide = DataBaseFactory.getDataBase(conn);
       
       //获取文件翻译单位信息
       //如果是补翻或重翻，则获取该文件翻译记录中的翻译单位信息
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
    * @Description: 退文信息初始化方法
	如中心发起退文，则申请人、申请日期为空，只填写确认部门、确认人、确认日期
	如收养组织发起退文，则确认人、确认日期为空，系统根据文件所在位置设定确认部门ID
    * @author: wangzheng
    * @param conn
    * @param data
    * 	Data封装内容：
		AF_ID：文件ID
		ADOPT_ORG_ID：收养组织ID
		COUNTRY_CODE：收养组织所属国家
		REGISTER_DATE：收文日期
		FILE_NO：收文编号
		FILE_TYPE：文件类型
		FAMILY_TYPE：收养类型
		MALE_NAME：男收养人姓名
		FEMALE_NAME：女收养人姓名
		RETURN_REASON：退文原因
		HANDLE_TYPE：退文处理方式
		    1：自取（默认）
			2：中心销毁
			3：寄回
			4：退文转组织
			9：其他
		APPLE_DATE：退文申请日期
		APPLE_PERSON_ID：申请人ID
		APPLE_PERSON_NAME：申请人姓名
		ORG_ID：确认部门ID
		PERSON_ID：确认人ID
		PERSON_NAME：确认人姓名
		RETREAT_DATE：确认日期
		BANK_CONTENT：确认备注
		APPLE_TYPE：退文类型
			1：机构申请退出收养
			2：审核不通过退出收养
			3：征求意见退文 
			4：收养登记退文
			5：暂停超时退出收养
			9：其他
		RETURN_STATE：退文状态
			退文类型为（2：审核部审核不通过、3：征求意见退文、4：收养登记退文、5：暂停超时退出收养）时，退文状态为1：已确认
			退文类型为1：机构申请退出收养时，退文状态为0：待确认
			0：待确认
			1：已确认
			2：待处置
			3：已处置
		
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
    * @Description: 补充文件信息初始化方法
    * @author: yangrt;
    * @param conn
    * @param data
    * 	Data封装内容：
    * 		AF_ID：收养文件ID；
    * 		NOTICE_CONTENT：补充原因；
    * 		IS_MODIFY：是否允许修改基本信息；
    * 		IS_ADDATTACH：是否允许补充附件；
    * @throws DBException
    * @return Data
    */
   public Data suppleInit(Connection conn, Data data) throws DBException {
	   IDataExecute ide = DataBaseFactory.getDataBase(conn);
	   UserInfo curuser = SessionInfo.getCurUser();
	   
	   if("".equals(data.getString("SEND_USERID"))||null==data.getString("SEND_USERID")){
		   data.add("SEND_USERID", curuser.getPersonId());	//添加通知人ID
		   data.add("SEND_USERNAME", curuser.getPerson().getCName());	//添加通知人姓名
	   }
	   
	   if("".equals(data.getString("NOTICE_DATE"))||null==data.getString("NOTICE_DATE")){
		   data.add("NOTICE_DATE", DateUtility.getCurrentDate());	//添加通知人日期
	   }
	   
	   data.setEntityName("FFS_AF_ADDITIONAL");
	   data.setPrimaryKey("AA_ID");
	   data.add("AA_STATUS", "0");	//添加补充状态，0=待补充
	   
	   return ide.create(data);
   }
   
    /**
     * 修改文件基本信息
     * @description 
     * @author MaYun
     * @date Sep 5, 2014
     * @param Data fileData 
     * Data封装内容：
     * AF_ID:文件主键ID
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
	 * @Description: 根据文件类型获取文件应缴费用
	 * @author: yangrt;
	 * @param conn
	 * @param file_type
	 * 		正常文件：file_type="ZCWJFWF" : 800	
	 * 		特需文件：file_type="TXWJFWF" : 500
	 * @return    设定文件 
	 * @return String    返回类型 
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
			long between=(end.getTime()-begin.getTime())/1000;//除以1000是为了转换成秒

			   long day1=between/(24*3600);
			   long hour1=between%(24*3600)/3600;
			   long minute1=between%3600/60;
			   long second1=between%60/60;
			   System.out.println(""+day1+"天"+hour1+"小时"+minute1+"分"+second1+"秒");
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		   
		   

		
	}

}
