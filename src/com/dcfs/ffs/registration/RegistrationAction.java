/**   
 * @Title: RegistrationAction.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author songhn   
 * @date 2014-7-14 下午3:00:34 
 * @version V1.0   
 */
package com.dcfs.ffs.registration;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonConstant;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonManagerHandler;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.registration.RegistrationHandler;

import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;





import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;

/** 
 * @ClassName: RegistrationAction 
 * @Description: 收养登记Action 
 * @author Mayun 
 * @date 2014-7-15
 *  
 */
public class RegistrationAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(RegistrationAction.class);

    private RegistrationHandler handler;
    private FileCommonManagerHandler fileCommonHandler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;
    
    public RegistrationAction(){
        this.handler=new RegistrationHandler();
        this.fileCommonHandler=new FileCommonManagerHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * 跳转到文件手工登记页面
	 * @author Panfeng
	 * @date 2014-8-7
	 * @return
	 */
	public String FileHandReg(){
		//1 列表页获取信息ID
		String reguuid = getParameter("reguuid", "");
		String[] uuid = reguuid.split(",");
		String regId = "";
		StringBuffer stringb = new StringBuffer();
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			//int sum = (uuid.length)*800;
			//String paidNum = String.valueOf(sum); 
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			regId = stringb.substring(0, stringb.length() - 1);
			DataList HandRegList = handler.FileHandReg(conn, regId);
		   
			
			
			/*******应缴费用begin*********/
			String zcCost = fileCommonHandler.getAfCost(conn, "ZCWJFWF").getString("VALUE1");//正常文件应缴费用
			String txCost = fileCommonHandler.getAfCost(conn, "TXWJFWF").getString("VALUE1");//特需文件应缴费用
			int zcCostInt =0;
			int txCostInt =0;
			int totalPaidNum = 0;
			int len = HandRegList.size();
			DataList dataList = new DataList();
			for(int i=0;i<len;i++){
				Data data = (Data)HandRegList.get(i);
				String file_type = data.getString("FILE_TYPE");
				String ci_id = data.getString("CI_ID");
				
				if(!"20".equals(file_type)&&"20"!=file_type&&!"21".equals(file_type)&&"21"!=file_type&&!"22".equals(file_type)&&"22"!=file_type&&!"23".equals(file_type)&&"23"!=file_type){
					zcCostInt = Integer.parseInt(zcCost);
					data.add("AF_COST", Integer.toString(zcCostInt));
					totalPaidNum+=zcCostInt;
				}else{//特需文件应缴费用
					int txnum =ci_id.split(",").length;
					txCostInt = txnum*Integer.parseInt(txCost);
					data.add("AF_COST", Integer.toString(txCostInt));
					totalPaidNum+=txCostInt;
				}
				dataList.add(data);
			}
			
			
			/*******应缴费用end*********/
			
			
			//4 变量代入页面
			setAttribute("List", dataList);
			setAttribute("AF_ID", reguuid);
			setAttribute("paidNum", Integer.toString(totalPaidNum));
			setAttribute("CHEQUE_ID", UUID.getUUID());
			setAttribute("ADOPT_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return SUCCESS;
	}
	
	/**
	 * 跳转到文件代录录入页面
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 */
	public String toAddFlieRecord(){
		setAttribute("CHEQUE_ID", UUID.getUUID());
		setAttribute("ADOPT_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
		Data wjdlData = getRequestEntityData("P_","FILE_TYPE","FAMILY_TYPE","FAMILY_TYPE_VIEW","ADOPTER_SEX","ADOPTER_SEX_VIEW");
		wjdlData.add("FILE_TYPE_VIEW", wjdlData.get("FILE_TYPE"));
		wjdlData.add("FAMILY_TYPE_VIEW2", wjdlData.get("FAMILY_TYPE_VIEW"));
		wjdlData.add("ADOPTER_SEX_VIEW2", wjdlData.get("ADOPTER_SEX_VIEW"));
		setAttribute("wjdlData", wjdlData);
		
		return SUCCESS;
	}
	
	/**
	 * 跳转到文件代录录入文件类型和收养类型选择页面
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 */
	public String toAddFlieRecordChoise(){
		setAttribute("wjdlData", new Data());
		return SUCCESS;
	}
	
	/**
	 * 跳转到文件转组织选择页面
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 */
	public String toChoseFile(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor=null;
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype=null;
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","REGISTER_DATE_START","REGISTER_DATE_END","FILE_NO","MALE_NAME","FEMALE_NAME");
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toLowerCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toLowerCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.choseFileFindList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "原收文编号查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction的findList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}

	/**
	 * 跳转到批量文件代录页面
	 * @author panfeng
	 * @date 2014-8-5
	 * @return
	 */
	public String batchAddFlieRecord(){
		setAttribute("CHEQUE_ID", UUID.getUUID());
		setAttribute("ADOPT_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
		
		return SUCCESS;
	}
	
	/**
	 * @Title:saveFileRecord
	 * @Description:新增文件代录
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String saveFlieRecord() throws IOException{
		
		//1 获取操作人基本信息及系统日期
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
	 	String curDate = DateUtility.getCurrentDate();
        
        //2 获得页面表单数据，构造数据结果集
        Data fileData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CN","COUNTRY_EN","FILE_TYPE","MALE_NAME","MALE_BIRTHDAY","FAMILY_TYPE","FEMALE_NAME","FEMALE_BIRTHDAY","REG_REMARK","ORIGINAL_FILE_NO","ADOPTER_SEX","AF_COST");
        Data billData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","FILE_CODE","ISPIAOJUVALUE");

        fileData.add("REG_USERID", personId);//文件登记人ID
        fileData.add("REG_USERNAME", personName);//文件登记人姓名
        fileData.add("REG_DATE", curDate);//文件登记日期
        fileData.add("REGISTER_DATE", curDate);//收文日期
        fileData.add("REG_STATE", FileCommonConstant.DJZT_YDJ);//登记状态为已登记
        fileData.add("AF_COST_CLEAR", "0");//完费状态为未完费
        fileData.add("AF_COST_CLEAR_FLAG", "0");//完费维护标识为否
        fileData.add("AF_POSITION", deptId);//文件位置
        fileData.add("AF_GLOBAL_STATE", "03");//全局状态
        fileData.add("CREATE_USERID", personId);//创建人ID
        fileData.add("CREATE_DATE", curDate);//创建日期
        String MALE_NAME = fileData.getString("MALE_NAME");
        if(!"".equals(MALE_NAME)&&null!=MALE_NAME){
        	MALE_NAME = MALE_NAME.toUpperCase();
        }
        String FEMALE_NAME = fileData.getString("FEMALE_NAME");
        if(!"".equals(FEMALE_NAME)&&null!=FEMALE_NAME){
        	FEMALE_NAME = FEMALE_NAME.toUpperCase();
        }
        fileData.removeData("MALE_NAME");
        fileData.removeData("FEMALE_NAME");
        fileData.add("MALE_NAME", MALE_NAME);
        fileData.add("FEMALE_NAME", FEMALE_NAME);
        
        billData.add("REG_USERID", personId);//票据录入人ID
        billData.add("REG_USERNAME", personName);//票据录入人姓名
        billData.add("REG_ORGID", deptId);//票据录入人所在部门ID
        billData.add("REG_DATE", curDate);//票据录入日期
        
        billData.add("CHEQUE_TRANSFER_STATE", "0");//票据移交状态初始化为“未提交”
        
        try {
        	
        	//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 执行数据库处理操作
            FileCommonManager fileCommonManager = new FileCommonManager();
            String fileSeqNo = fileCommonManager.createFileSeqNO(conn);//生成文件流水号
            String countryCode = (String)fileData.get("COUNTRY_CODE");//国家代码
            String adoptOrgId = (String)fileData.get("ADOPT_ORG_ID");//组织机构代码
            String costType = (String)billData.get("COST_TYPE");//费用类别
            String fileNo = "";//收文编号
            
            DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, adoptOrgId);
            String  syzzCnName = syzzDept.getSyzzCnName();//收养组织中文名称
            String  syzzEnName = syzzDept.getSyzzEnName();//收养组织英文名称
            String  countryCnName = syzzDept.getCountryCnName();//所属国家中文名称
            String  countryEnName = syzzDept.getCountryEnName();//所属国家英文名称
            String isGy = fileCommonManager.getISGY(conn, fileData.getString("FILE_TYPE"), countryCode);//是否公约收养
            
            
            fileData.add("NAME_CN", syzzCnName);
            fileData.add("NAME_EN", syzzEnName);
            fileData.add("COUNTRY_CN", countryCnName);
            fileData.add("COUNTRY_EN", countryEnName);
            fileData.add("IS_CONVENTION_ADOPT", isGy);
            
            billData.add("NAME_CN",syzzCnName );
            billData.add("NAME_EN",syzzEnName );
            
            if(null!=countryCode&&!"".equals(countryCode)){
            	 fileNo = fileCommonManager.createFileNO(conn,countryCode);//生成收文编号
            }
            String isPJ = billData.getString("ISPIAOJUVALUE");//是否录入票据信息，0：否   1：是
            if(isPJ=="1"||isPJ.equals("1")){
            	String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//生成缴费编号
            	billData.add("PAID_NO", paidNo);
            	fileData.add("PAID_NO", paidNo);
            	//fileData.add("AF_COST_PAID", "1");//缴费状态为“已缴费”
            }
            /*if(isPJ=="0"||isPJ.equals("0")){
                fileData.add("AF_COST_PAID", "0");//缴费状态为“未缴费”
            }*/
            fileData.add("AF_COST_PAID", "0");//缴费状态为“未缴费”
            
            fileData.add("AF_SEQ_NO", fileSeqNo);
            fileData.add("FILE_NO", fileNo);
            billData.add("FILE_NO", fileNo);
            
            //******方式一：获取文件全局状态、文件位置，并更新begin*****//*
            FileCommonStatusAndPositionManager fileStatusManager = new FileCommonStatusAndPositionManager();//文件全局状态和位置公共类
            Data globalStatusAndPositionData = fileStatusManager.getNextGlobalAndPosition(FileOperationConstant.BGS_REGISTRATION_DL_SUBMIT);//获得文件全局状态和位置
            String globalState = (String)globalStatusAndPositionData.get("AF_GLOBAL_STATE");//文件全局状态
            String position = (String)globalStatusAndPositionData.get("AF_POSITION");//文件位置
            fileData.add("AF_GLOBAL_STATE", globalState);
            fileData.add("AF_POSITION", position);
            //******方式一：获取文件全局状态、文件位置以及文件状态（收养组织），并更新end*****//*
            
            //******方式二：直接更新文件全局状态、文件位置begin*****//*
           // fileStatusManager.updateNextGlobalStatusAndPositon(conn,FileOperationConstant.GERNERATION_SUBMIT, "", fileNo);
            //******方式二：直接更新文件全局状态、文件位置end******//*
            
            DataList dataList = handler.saveFlieRecord(conn,fileData,billData);//保存业务数据
            
            String packageId = billData.getString("FILE_CODE");//附件（缴费凭证）
            AttHelper.publishAttsOfPackageId(packageId, "OTHER");//附件发布
            
            DataList tranferDataList = new DataList();
            DataList tranferDataList2 = new DataList();
            
            if(dataList.size()>0){//登记成功后
            	//初始化文件移交信息
            	Data data = (Data)dataList.get(0);
            	String afId = data.getString("AF_ID");
            	Data dataTemp = new Data();
            	dataTemp.add("APP_ID", afId);
            	dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
            	dataTemp.add("TRANSFER_STATE", "0");
            	tranferDataList.add(dataTemp);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);
            }
            if(dataList.size()>1){//有票据信息，则保存票据信息
            	//初始化缴费单移交信息
            	Data pjyjData =(Data)dataList.get(1);
            	Data dataTemp2 = new Data();
            	String cheque_id = pjyjData.getString("CHEQUE_ID");
            	dataTemp2.add("APP_ID", cheque_id);
            	dataTemp2.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
            	dataTemp2.add("TRANSFER_STATE", "0");
            	tranferDataList2.add(dataTemp2);
            	fileCommonManager.transferDetailInit(conn, tranferDataList2);
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 设置异常处理
        	try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "文件登记查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //6 操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch(Exception e){
        	 try {
                 dt.rollback();
             } catch (SQLException e1) {
                 e1.printStackTrace();
             }
             if (log.isError()) {
                 log.logError("操作异常:" + e.getMessage(),e);
             }
             InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
             setAttribute("clueTo", clueTo);
             retValue = "error2";
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("RegistrationAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * @Title:saveBatchFlieRecord
	 * @Description:文件批量代录
	 * @author panfeng
	 * @date 2014-8-5
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String saveBatchFlieRecord() throws IOException{
		
		//1 获取操作人基本信息及系统日期
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
		String personName = SessionInfo.getCurUser().getPerson().getCName();
		String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDate();
		
		//2 获得页面表单数据，构造数据结果集
		
		
		// Start---------获取共用信息------------
		Data fileData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CN","COUNTRY_EN","FAMILY_TYPE","ORIGINAL_FILE_NO","AF_COST");
		Data billData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","FILE_CODE","ISPIAOJUVALUE");
		// End---------获取共用信息------------
//		String afCost = (String)billData.get("PAID_SHOULD_NUM");//应缴费用
		
		billData.add("REG_USERID", personId);//票据录入人ID
		billData.add("REG_USERNAME", personName);//票据录入人姓名
		billData.add("REG_ORGID", deptId);//票据录入人所在部门ID
		billData.add("REG_DATE", curDate);//票据录入日期
		
		billData.add("CHEQUE_TRANSFER_STATE", "0");//票据移交状态初始化为“未提交”
		
		try {
			
			//3 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//4 执行数据库处理操作
			FileCommonManager fileCommonManager = new FileCommonManager();
			String countryCode = (String)fileData.get("COUNTRY_CODE");//国家代码
			String adoptOrgId = (String)fileData.get("ADOPT_ORG_ID");//组织机构代码
			String costType = (String)billData.get("COST_TYPE");//费用类别
			String fileNo = "";//文件信息收文编号
			String billfileNo = "";//票据信息收文编号
			String batchAfId = "";//登记后返回的主键
			
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, adoptOrgId);
            String  syzzCnName = syzzDept.getSyzzCnName();//收养组织中文名称
            String  syzzEnName = syzzDept.getSyzzEnName();//收养组织英文名称
            String  countryCnName = syzzDept.getCountryCnName();//所属国家中文名称
            String  countryEnName = syzzDept.getCountryEnName();//所属国家英文名称
            
			String isPJ = billData.getString("ISPIAOJUVALUE");//是否录入票据信息，0：否   1：是
			if(isPJ=="1"||isPJ.equals("1")){
				String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//生成缴费编号
				billData.add("PAID_NO", paidNo);
				fileData.add("PAID_NO", paidNo);
				//fileData.add("AF_COST_PAID", "1");//缴费状态为“已缴费”
			}
			/*if(isPJ=="0"||isPJ.equals("0")){
            	fileData.add("AF_COST_PAID", "0");//缴费状态为“未缴费”
            }*/
			fileData.add("AF_COST_PAID", "0");//缴费状态为“未缴费”
//			fileData.add("FILE_NO", fileNo);
//			billData.add("FILE_NO", fileNo);
			
			//******方式一：获取文件全局状态、文件位置以及文件状态（收养组织），并更新begin*****//*
			FileCommonStatusAndPositionManager fileStatusManager = new FileCommonStatusAndPositionManager();//文件全局状态和位置公共类
			Data globalStatusAndPositionData = fileStatusManager.getNextGlobalAndPosition(FileOperationConstant.BGS_REGISTRATION_PLDL_SUBMIT);//获得文件全局状态和位置
			String globalState = (String)globalStatusAndPositionData.get("AF_GLOBAL_STATE");//文件全局状态
			String position = (String)globalStatusAndPositionData.get("AF_POSITION");//文件位置
			//******方式一：获取文件全局状态、文件位置以及文件状态（收养组织），并更新end*****//*
			
			//******方式二：直接更新文件全局状态、文件位置begin*****//*
			// fileStatusManager.updateNextGlobalStatusAndPositon(conn,FileOperationConstant.GERNERATION_SUBMIT, "", fileNo);
			//******方式二：直接更新文件全局状态、文件位置end******//*
			DataList dataList = new DataList();
			String rowNum = this.getParameter("rowNum");
			
			// Start---------获取批量文件基本信息------------
			String P_FILE_TYPE = this.getParameter("P_FILE_TYPE","");
			String P_FAMILY_TYPE = this.getParameter("P_FAMILY_TYPE","");
			String P_ADOPTER_SEX = this.getParameter("P_ADOPTER_SEX","");
			String P_MALE_NAME = this.getParameter("P_MALE_NAME","");
	        if(!"".equals(P_MALE_NAME)&&null!=P_MALE_NAME){
	        	P_MALE_NAME = P_MALE_NAME.toUpperCase();
	        }
	        String P_FEMALE_NAME = this.getParameter("P_FEMALE_NAME","");
	        if(!"".equals(P_FEMALE_NAME)&&null!=P_FEMALE_NAME){
	        	P_FEMALE_NAME = P_FEMALE_NAME.toUpperCase();
	        }
			String P_MALE_BIRTHDAY = this.getParameter("P_MALE_BIRTHDAY","");
			String P_FEMALE_BIRTHDAY = this.getParameter("P_FEMALE_BIRTHDAY","");
			String P_REG_REMARK = this.getParameter("P_REG_REMARK","");
			
            String isGy = fileCommonManager.getISGY(conn, P_FILE_TYPE, countryCode);//是否公约收养

			// End---------获取批量文件基本信息------------
			if(!"".equals(P_FILE_TYPE)){
				Data data = new Data();
				data.put("COUNTRY_CODE", (String)fileData.get("COUNTRY_CODE"));//国家
				data.put("ADOPT_ORG_ID", (String)fileData.get("ADOPT_ORG_ID"));//组织机构
				data.put("NAME_CN", syzzCnName);//收养组织中文名称
				data.put("NAME_EN", syzzEnName);//收养组织英文名称
				data.put("COUNTRY_CN", countryCnName);//所属国家中文名称
				data.put("COUNTRY_EN", countryEnName);//所属国家英文名称
				data.add("IS_CONVENTION_ADOPT", isGy);//是否公约收养

				
				fileNo = fileCommonManager.createFileNO(conn,countryCode);//生成收文编号
				billfileNo +=fileNo + ",";
				data.put("FILE_NO", fileNo);//收文编号
				data.put("PAID_NO", (String)fileData.get("PAID_NO"));//缴费编号
				data.put("AF_COST_PAID", (String)fileData.get("AF_COST_PAID"));//缴费状态
				
				data.put("REG_USERID", personId);//文件登记人ID
				data.put("REG_USERNAME", personName);//文件登记人姓名
				data.put("REG_DATE", curDate);//文件登记日期
				data.put("REGISTER_DATE", curDate);//收文日期
				data.put("REG_STATE", "3");//登记状态为已登记
				data.put("AF_COST",fileData.get("AF_COST"));//应缴费用
				data.add("AF_COST_CLEAR", "0");//完费状态为未完费
				data.add("AF_COST_CLEAR_FLAG", "0");//完费维护标识为否
				data.add("CREATE_USERID", personId);//创建人ID
		        data.add("CREATE_DATE", curDate);//创建日期
				
				String fileSeqNo = fileCommonManager.createFileSeqNO(conn);//生成文件流水号
				data.put("AF_SEQ_NO", fileSeqNo);//文件流水号
				
				data.put("AF_GLOBAL_STATE", globalState);//文件全局状态
				data.put("AF_POSITION", position);//文件位置
				
				data.put("FILE_TYPE", P_FILE_TYPE);
				data.put("FAMILY_TYPE", P_FAMILY_TYPE);
				data.put("ADOPTER_SEX", P_ADOPTER_SEX);
				data.put("MALE_NAME", P_MALE_NAME);
				data.put("MALE_BIRTHDAY", P_MALE_BIRTHDAY);
				data.put("FEMALE_NAME", P_FEMALE_NAME);
				data.put("FEMALE_BIRTHDAY", P_FEMALE_BIRTHDAY);
				data.put("REG_REMARK", P_REG_REMARK);
				dataList.add(handler.saveBatchFlieRecord(conn, data, true));//保存文件信息业务数据
				
				DataList tranferDataList0 = new DataList();
				if(dataList.size()>0){//登记成功后，生成文件待移交数据
					Data tdata = (Data)dataList.get(0);
					String afId = tdata.getString("AF_ID");
					Data dataTemp = new Data();
					dataTemp.add("APP_ID", afId);
					dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
					dataTemp.add("TRANSFER_STATE", "0");
					tranferDataList0.add(dataTemp);
					fileCommonManager.transferDetailInit(conn, tranferDataList0);
				}
				if(dataList.size()>0){//获取登记后返回的主键
					Data afdata = (Data)dataList.get(0);
					String af_id = afdata.getString("AF_ID");
					batchAfId += af_id + ",";
				}
			}
			for (int i = 1; i <= Integer.parseInt(rowNum); i++) {
				String FILE_TYPE = this.getParameter("P_FILE_TYPE" + i,"");
				String ADOPTER_SEX = this.getParameter("P_ADOPTER_SEX" + i,"");
				String FAMILY_TYPE = this.getParameter("P_FAMILY_TYPE" + i,"");
				String MALE_NAME = this.getParameter("P_MALE_NAME" + i,"");
		        if(!"".equals(MALE_NAME)&&null!=MALE_NAME){
		        	MALE_NAME = MALE_NAME.toUpperCase();
		        }
		        String FEMALE_NAME = this.getParameter("P_FEMALE_NAME" + i,"");
		        if(!"".equals(FEMALE_NAME)&&null!=FEMALE_NAME){
		        	FEMALE_NAME = FEMALE_NAME.toUpperCase();
		        }
				String MALE_BIRTHDAY = this.getParameter("P_MALE_BIRTHDAY" + i,"");
				String FEMALE_BIRTHDAY = this.getParameter("P_FEMALE_BIRTHDAY" + i,"");
				String REG_REMARK = this.getParameter("P_REG_REMARK" + i,"");
				if(!"".equals(FILE_TYPE)){
					Data batchData = new Data();
					batchData.put("COUNTRY_CODE", (String)fileData.get("COUNTRY_CODE"));//国家
					batchData.put("ADOPT_ORG_ID", (String)fileData.get("ADOPT_ORG_ID"));//组织机构
					batchData.add("NAME_CN",syzzCnName );//收养组织中文名称
					batchData.add("NAME_EN",syzzEnName );//收养组织英文名称
					batchData.put("COUNTRY_CN", countryCnName);//所属国家中文名称
					batchData.put("COUNTRY_EN", countryEnName);//所属国家英文名称
					batchData.add("IS_CONVENTION_ADOPT", isGy);//是否公约收养



					fileNo = fileCommonManager.createFileNO(conn,countryCode);//生成收文编号
					billfileNo += fileNo + ",";
					batchData.put("FILE_NO", fileNo);//收文编号
					
					batchData.put("PAID_NO", (String)fileData.get("PAID_NO"));//缴费编号
					batchData.put("AF_COST_PAID", (String)fileData.get("AF_COST_PAID"));//缴费状态
					
					batchData.put("REG_USERID", personId);//文件登记人ID
					batchData.put("REG_USERNAME", personName);//文件登记人姓名
					batchData.put("REG_DATE", curDate);//文件登记日期
					batchData.put("REGISTER_DATE", curDate);//收文日期
					batchData.put("REG_STATE", FileCommonConstant.DJZT_YDJ);//登记状态为已登记
					batchData.put("AF_COST", fileData.get("AF_COST"));//应缴费用
					batchData.add("AF_COST_CLEAR", "0");//完费状态为未完费
					batchData.add("AF_COST_CLEAR_FLAG", "0");//完费维护标识为否
					batchData.add("CREATE_USERID", personId);//创建人ID
					batchData.add("CREATE_DATE", curDate);//创建日期
					
					String fileSeqNo = fileCommonManager.createFileSeqNO(conn);//生成文件流水号
					batchData.put("AF_SEQ_NO", fileSeqNo);//文件流水号
					
					batchData.put("AF_GLOBAL_STATE", globalState);//文件全局状态
					batchData.put("AF_POSITION", position);//文件位置
					
					batchData.put("FILE_TYPE", FILE_TYPE);
					batchData.put("ADOPTER_SEX", ADOPTER_SEX);
					batchData.put("FAMILY_TYPE", FAMILY_TYPE);
					batchData.put("MALE_NAME", MALE_NAME);
					batchData.put("MALE_BIRTHDAY", MALE_BIRTHDAY);
					batchData.put("FEMALE_NAME", FEMALE_NAME);
					batchData.put("FEMALE_BIRTHDAY", FEMALE_BIRTHDAY);
					batchData.put("REG_REMARK", REG_REMARK);
					dataList.add(handler.saveBatchFlieRecord(conn, batchData, true));//保存文件信息业务数据
					
					DataList tranferDataList = new DataList();
					if(dataList.size()>0){//登记成功后，生成文件待移交数据
						Data data = (Data)dataList.get(i);
						String afId = data.getString("AF_ID");
						Data dataTemp = new Data();
						dataTemp.add("APP_ID", afId);
						dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
						dataTemp.add("TRANSFER_STATE", "0");
						tranferDataList.add(dataTemp);
						fileCommonManager.transferDetailInit(conn, tranferDataList);
					}
					if(dataList.size()>0){//获取登记后返回的主键
						Data afdata = (Data)dataList.get(i);
						String af_id = afdata.getString("AF_ID");
						batchAfId += af_id + ",";
					}
				}
			}
			
			String batch_af_id = batchAfId.substring(0, batchAfId.lastIndexOf(","));
			setAttribute("batchAfId", batch_af_id);
			
			billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//票据信息收文编号
			billData.put("NAME_CN", syzzCnName);//收养组织中文名称
			billData.put("NAME_EN", syzzEnName);//收养组织英文名称
			handler.saveBatchCostRecord(conn,billData);//保存票据业务数据
			
			String packageId = billData.getString("FILE_CODE");//附件（缴费凭证）
			AttHelper.publishAttsOfPackageId(packageId, "OTHER");//附件发布
			
			DataList tranferDataList2 = new DataList();
			if(dataList.size()>1){//如果录入了票据信息，则保存票据信息
				//初始化缴费单移交信息
            	Data pjyjData =(Data)dataList.get(1);
            	Data dataTemp2 = new Data();
            	String cheque_id = pjyjData.getString("CHEQUE_ID");
            	dataTemp2.add("APP_ID", cheque_id);
            	dataTemp2.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
            	dataTemp2.add("TRANSFER_STATE", "0");
            	tranferDataList2.add(dataTemp2);
            	fileCommonManager.transferDetailInit(conn, tranferDataList2);
			}
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//保存成功 0
			setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			//5 设置异常处理
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			setAttribute(Constants.ERROR_MSG_TITLE, "文件登记查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[保存操作]:" + e.getMessage(),e);
			}
			//6 操作结果页面提示
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch(Exception e){
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		}finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction的Connection因出现异常，未能关闭",e);
					}
					e.printStackTrace();
				}
			}
		}
		setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * 批量条形码打印页面
	 * @author Panfeng
	 * @date 2014-12-3
	 * @return
	 */
	public String barCodeList(){
		//1 列表页获取信息ID
		String type = getParameter("type");
		String printId = "";
		StringBuffer stringb = new StringBuffer();
		if ("direct".equals(type)){//列表选择后跳转
			String printuuid = getParameter("codeuuid");
			String[] uuid = printuuid.split(",");
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
		}else{//登记后跳转页面
			String printuuid = (String) getAttribute("batchAfId");
			String[] uuid = printuuid.split(",");
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
		}
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			printId = stringb.substring(0, stringb.length() - 1);
			DataList printShow = handler.getPrintData(conn, printId);
			//4 变量代入页面
			setAttribute("printShow", printShow);
		} catch (DBException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}finally {
			//5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title:saveFileHandReg
	 * @Description:文件手工登记
	 * @author panfeng
	 * @date 2014-8-11
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String saveFileHandReg() throws IOException{
		
		//1 获取操作人基本信息及系统日期
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
		String personName = SessionInfo.getCurUser().getPerson().getCName();
		String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDate();
		
		//2 获得页面表单数据，构造数据结果集
		// Start---------获取批量文件基本信息------------
		String[] AF_ID = this.getParameterValues("P_AF_ID");
		String[] RI_ID = this.getParameterValues("P_RI_ID");
		String[] P_CI_ID = this.getParameterValues("P_CI_ID");
		String[] P_AF_COST = this.getParameterValues("P_AF_COST");
		String[] P_COUNTRY_CODE = this.getParameterValues("P_COUNTRY_CODE");
		String[] P_ADOPT_ORG_ID = this.getParameterValues("P_ADOPT_ORG_ID");
		String[] P_NAME_CN = this.getParameterValues("P_NAME_CN");
		String[] P_NAME_EN = this.getParameterValues("P_NAME_EN");
		String[] P_FILE_TYPE = this.getParameterValues("P_FILE_TYPE");
		String[] P_MALE_NAME = this.getParameterValues("P_MALE_NAME");
		String[] P_MALE_BIRTHDAY = this.getParameterValues("P_MALE_BIRTHDAY");
		String[] P_FEMALE_NAME = this.getParameterValues("P_FEMALE_NAME");
		String[] P_FEMALE_BIRTHDAY = this.getParameterValues("P_FEMALE_BIRTHDAY");
		// End---------获取批量文件基本信息------------
		
		// Start---------获取共用信息------------
		Data fileData = getRequestEntityData("P_","NAME_CN","NAME_EN","COUNTRY_CN","COUNTRY_EN","FAMILY_TYPE","ORIGINAL_FILE_NO");
		Data billData = getRequestEntityData("P_","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","FILE_CODE","ISPIAOJUVALUE");
		// End---------获取共用信息------------
		
		billData.add("COUNTRY_CODE", P_COUNTRY_CODE[0]);//票据录入国家
		billData.add("ADOPT_ORG_ID", P_ADOPT_ORG_ID[0]);//票据录入收养组织
		billData.add("NAME_CN", P_NAME_CN[0]);//收养组织中文名称
		billData.add("NAME_EN", P_NAME_EN[0]);//收养组织英文名称
		billData.add("REG_USERID", personId);//票据录入人ID
		billData.add("REG_USERNAME", personName);//票据录入人姓名
		billData.add("REG_ORGID", deptId);//票据录入人所在部门ID
		billData.add("REG_DATE", curDate);//票据录入日期
		
		billData.add("CHEQUE_TRANSFER_STATE", "0");//票据移交状态初始化为“未提交”
		
		try {
			
			//3 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//4 执行数据库处理操作
			
			FileCommonManager fileCommonManager = new FileCommonManager();
			String adoptOrgId = (String)billData.get("ADOPT_ORG_ID");//组织机构代码
			String costType = (String)billData.get("COST_TYPE");//费用类别
			String billfileNo = "";//票据信息收文编号

			String isPJ = billData.getString("ISPIAOJUVALUE");//是否录入票据信息，0：否   1：是
			if(isPJ=="1"||isPJ.equals("1")){
				String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//生成缴费编号
				billData.add("PAID_NO", paidNo);
				fileData.add("PAID_NO", paidNo);
				//fileData.add("AF_COST_PAID", "1");//缴费状态为“已缴费”
			}
			/*if(isPJ=="0"||isPJ.equals("0")){
            	fileData.add("AF_COST_PAID", "0");//缴费状态为“未缴费”
            }*/
			fileData.add("AF_COST_PAID", "0");//缴费状态为“未缴费”
			
			//******方式一：获取文件全局状态、文件位置以及文件状态（收养组织），并更新begin*****//*
			FileCommonStatusAndPositionManager fileStatusManager = new FileCommonStatusAndPositionManager();//文件全局状态和位置公共类
			Data globalStatusAndPositionData = fileStatusManager.getNextGlobalAndPosition(FileOperationConstant.BGS_REGISTRATION_SGDJ_SUBMIT);//获得文件全局状态和位置
			String globalState = (String)globalStatusAndPositionData.get("AF_GLOBAL_STATE");//文件全局状态
			String position = (String)globalStatusAndPositionData.get("AF_POSITION");//文件位置
			//******方式一：获取文件全局状态、文件位置以及文件状态（收养组织），并更新end*****//*
			
			//******方式二：直接更新文件全局状态、文件位置begin*****//*
			// fileStatusManager.updateNextGlobalStatusAndPositon(conn,FileOperationConstant.GERNERATION_SUBMIT, "", fileNo);
			//******方式二：直接更新文件全局状态、文件位置end******//*
			
			int totalCost=0;//总的应缴金额
			DataList dataList = new DataList();
			if(P_COUNTRY_CODE.length>0&&null != P_COUNTRY_CODE[0]&&!"".equals( P_COUNTRY_CODE[0])&&!"null".equals(P_COUNTRY_CODE[0])){
				if (AF_ID != null && AF_ID.length != 0) {
					for (int i = 0; i < AF_ID.length; i++) {
						Data handRegData = new Data();
						String fileNo = "";
						
						fileNo = fileCommonManager.createFileNO(conn,P_COUNTRY_CODE[i]);//生成收文编号
						billfileNo +=fileNo + ",";
						
						handRegData.add("FILE_NO", fileNo);
						handRegData.add("PAID_NO", (String)fileData.get("PAID_NO"));//缴费编号
						handRegData.add("AF_COST_PAID", (String)fileData.get("AF_COST_PAID"));//缴费状态
						
						handRegData.add("REG_USERID", personId);//文件登记人ID
						handRegData.add("REG_USERNAME", personName);//文件登记人姓名
						handRegData.add("REG_DATE", curDate);//文件登记日期
						handRegData.add("REGISTER_DATE", curDate);//收文日期
						handRegData.add("REG_STATE", FileCommonConstant.DJZT_YDJ);//登记状态为已登记
						if("20".equals(P_FILE_TYPE[i])||"21".equals(P_FILE_TYPE[i])||"22".equals(P_FILE_TYPE[i])||"23".equals(P_FILE_TYPE[i])){
							//handRegData.add("AF_COST", "500");//应缴费用
							handRegData.add("AF_COST", P_AF_COST[i]);//应缴费用
							handRegData.add("RI_STATE", "6");//文件信息表预批状态“已启动”
							if(RI_ID != null && !"".equals(RI_ID)){
								boolean success = false;
								String[] ri_ids = RI_ID[i].split(",");
								success = handler.saveSceReqInfo(conn,ri_ids);//保存预批信息业务数据
							}
						}else{
							//handRegData.add("AF_COST", "800");
							handRegData.add("AF_COST", P_AF_COST[i]);
						}
						
						int tempCost = Integer.parseInt(P_AF_COST[i]);
						totalCost +=tempCost; 
						
						
						handRegData.add("AF_COST_CLEAR", "0");//完费状态为未完费
						handRegData.add("AF_COST_CLEAR_FLAG", "0");//完费维护标识为否
						
						handRegData.add("AF_GLOBAL_STATE", globalState);//文件全局状态
						handRegData.add("AF_POSITION", position);//文件位置
						
						handRegData.setEntityName("FFS_AF_INFO");
						handRegData.setPrimaryKey("AF_ID");
						handRegData.add("AF_ID", AF_ID[i]);
						if(P_FILE_TYPE != null && !"".equals(P_FILE_TYPE)){
							handRegData.add("FILE_TYPE", P_FILE_TYPE[i]);
						}
						handRegData.add("MALE_NAME", P_MALE_NAME[i].toUpperCase());
						handRegData.add("MALE_BIRTHDAY", P_MALE_BIRTHDAY[i]);
						handRegData.add("FEMALE_NAME", P_FEMALE_NAME[i].toUpperCase());
						handRegData.add("FEMALE_BIRTHDAY", P_FEMALE_BIRTHDAY[i]);
						dataList.add(handler.saveBatchFlieRecord(conn, handRegData, false));//保存文件信息业务数据
						
						DataList tranferDataList = new DataList();
						if(dataList.size()>0){//登记成功后，生成文件待移交数据
							Data data = (Data)dataList.get(i);
							String afId = data.getString("AF_ID");
							Data dataTemp = new Data();
							dataTemp.add("APP_ID", afId);
							dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
							dataTemp.add("TRANSFER_STATE", "0");
							tranferDataList.add(dataTemp);
							fileCommonManager.transferDetailInit(conn, tranferDataList);
						}
					}
				}
			billData.add("PAID_SHOULD_NUM", Integer.toString(totalCost));//总的应缴金额
			billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//票据信息收文编号
			handler.saveBatchCostRecord(conn,billData);//保存票据业务数据
			
			String packageId = billData.getString("FILE_CODE");//附件（缴费凭证）
			AttHelper.publishAttsOfPackageId(packageId, "OTHER");//附件发布
			
			DataList tranferDataList2 = new DataList();
			if(dataList.size()>1){//如果录入了票据信息，则保存票据信息
				//初始化缴费单移交信息
            	Data pjyjData =(Data)dataList.get(1);
            	Data dataTemp2 = new Data();
            	String cheque_id = pjyjData.getString("CHEQUE_ID");
            	dataTemp2.add("APP_ID", cheque_id);
            	dataTemp2.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
            	dataTemp2.add("TRANSFER_STATE", "0");
            	tranferDataList2.add(dataTemp2);
            	fileCommonManager.transferDetailInit(conn, tranferDataList2);
			}
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//保存成功 0
			setAttribute("clueTo", clueTo);
		}else{
			InfoClueTo clueTo = new InfoClueTo(2, "手工登记失败!国家code不能为空！");//保存失败 0
			setAttribute("clueTo", clueTo);
		}
		
		} catch (DBException e) {
			//5 设置异常处理
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			setAttribute(Constants.ERROR_MSG_TITLE, "文件登记查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[保存操作]:" + e.getMessage(),e);
			}
			//6 操作结果页面提示
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch(Exception e){
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction的Connection因出现异常，未能关闭",e);
					}
					e.printStackTrace();
				}
			}
		}
		setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * @Title: findList 
	 * @Description: 文件登记列表
	 * @author: songhn
	 * @return String    返回类型 
	 * @throws
	 */
	public String findList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AF_SEQ_NO";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","AF_SEQ_NO","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","AF_COST","SUBMIT_DATE_START","SUBMIT_DATE_END","REG_STATE");
		String MALE_NAME = data.getString("MALE_NAME");
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件登记查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction的findList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * 生成条形码
	 * @author Panfeng
	 * @date 2014-7-21
	 * @return
	 */
	public String barCode(){
		//1 列表页获取信息ID
		String uuid = getParameter("codeuuid","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data codedata = handler.getShowData(conn, uuid, null);
			//4 变量代入页面
			setAttribute("data", codedata);
			setAttribute("file_no", codedata.getString("FILE_NO", ""));//代入收文编号
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return SUCCESS;
	}
	
	/**
	 * 查看
	 * @author Panfeng
	 * @date 2014-7-15
	 * @return
	 */
	public String show(){
		//1 获取查看信息的ID
		String uuid = getParameter("showuuid","");
		String fileno = getParameter("fileno","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取查看信息结果集
			Data showdata = handler.getShowData(conn, uuid, fileno);
			//4 变量代入查看页面
			setAttribute("wjdlData", showdata);
			setAttribute("is_change_org", showdata.getString("IS_CHANGE_ORG", ""));//代入是否转组织
			setAttribute("male_name", showdata.getString("MALE_NAME", ""));//代入男收养人
			setAttribute("famale_name", showdata.getString("FEMALE_NAME", ""));//代入女收养人
			setAttribute("file_code", showdata.getString("FILE_CODE", showdata.getString("CHEQUE_ID")));//代入附件ID
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return SUCCESS;
	}
	
	/********   文件退回操作		********/ 
	/**
	 * @Title: toAddFlieReturnReason 
	 * @Description: 文件退回新增
	 * @author: yangrt
	 * @return String 
	 * 			errer:跳转到错误页面
	 * 			success:跳转到文件退回新增页面
	 */
	public String toAddFlieReturnReason(){
		//1 获取要退回的文件ID
		String AF_ID = getParameter("AF_ID");
		//2 获取操作人基本信息及系统日期
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
		try {
			//3 获取数据库连接
			conn = ConnectionManager.getConnection();
			//4 获取显示结果集
			Data fileData = handler.getShowData(conn, AF_ID, null);
			fileData.add("REG_USERID", personId);//文件登记人ID
	        fileData.add("REG_USERNAME", personName);//文件登记人姓名
	        fileData.add("REG_RETURN_DATE", curDate);//文件退回日期
	        //5 将结果集写入页面接收变量
	        setAttribute("fileData", fileData);
		} catch (DBException e) {
			//6 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件退回操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("文件退回操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		}finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction的toAddFlieReturnReason因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	/**
	 * 文件退回保存
	 */
	public String saveFlieReturnReason(){
        //1 获得页面表单数据，构造数据结果集
        Data fileData = getRequestEntityData("R_","AF_ID","REG_USERID","REG_USERNAME","REG_RETURN_REASON","REG_RETURN_DESC","REG_RETURN_DATE");
        
        try {
        	//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 执行数据库处理操作
            fileData.add("REG_STATE", FileCommonConstant.DJZT_DXG);//登记状态为待修改
            handler.saveFlieReturnReason(conn,fileData);
            //TODO：文件退回后，需要给收养组织发短信
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "文件退回成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 设置异常处理
        	setAttribute(Constants.ERROR_MSG_TITLE, "文件退回操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            //6 操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch(Exception e ){
        	try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("RegistrationAction的saveFlieReturnReason的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
        return retValue;
	}
	
	/**
	 * @Title: ChildDataShow 
	 * @Description: 根据儿童材料id获取儿童详细信息
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String ChildDataShow(){
		String ci_id = getParameter("ci_id");
		try {
			conn = ConnectionManager.getConnection();
			if(!"".equals(ci_id)){
				DataList dataList = handler.getChildDataList(conn, ci_id);
				setAttribute("List", dataList);
			}
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童信息查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
           if (log.isError()) {
               log.logError("操作异常[儿童信息查看操作]:" + e.getMessage(),e);
           }
           
           retValue = "error1";
           
		}finally {
           if (conn != null) {
               try {
                   if (!conn.isClosed()) {
                       conn.close();
                   }
               } catch (SQLException e) {
                   if (log.isError()) {
                       log.logError("RegistrationAction的ChildDataShow.Connection因出现异常，未能关闭",e);
                   }
                   e.printStackTrace();
                   
                   retValue = "error2";
               }
           }
       }
		
		return retValue;
	}
	 
}
