/**   
 * @Title: FileManagerAction.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: 由收养组织对文件信息进行查询、录入、修改、删除、提交、流水号打印、导出操作
 * @author yangrt
 * @date 2014-7-21 下午5:37:35 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.ModifyHistoryHandler;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.CurrencyConverterAction;
import com.dcfs.ffs.common.FileCommonConstant;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileGlobalStatusAndPositionConstant;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.translation.FfsAfTranslationAction;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.excelexport.ExcelExporter;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;
/**
 * 
 * @ClassName: FileManagerAction 
 * @Description: 由收养组织对文件信息进行查询、录入、修改、删除、提交、流水号打印、导出操作
 * @author yangrt;
 * @date 2014-7-21 下午5:37:35 
 *
 */
public class FileManagerAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(FileManagerAction.class);

    private FileManagerHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;

    public FileManagerAction(){
        this.handler=new FileManagerHandler();
    } 

	@Override
	public String execute() throws Exception {
		return null;
	}

	/************** 递交普通文件处理Begin ***************/
	
	/**
	 * @Title: NormalFileList 
	 * @Description: 普通文件信息查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String NormalFileList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="CREATE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","AF_COST","FILE_TYPE","REG_STATE");
		String MALE_NAME = data.getString("MALE_NAME","");
		if(!"".equals(MALE_NAME)){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME","");
		if(!"".equals(FEMALE_NAME)){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.NormalFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件录入查询操作异常");
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
						log.logError("FileManagerAction的NormalFileList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: NormalFileAddFirst 
	 * @Description: 定向跳转到收养组织递交普通文件第一步操作页面
	 * @author: yangrt
	 * @return String
	 */
	public String NormalFileAddFirst(){
		Data data = new Data();
		//获取当前登录人的信息
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgid = userinfo.getCurOrgan().getId();
		try {
			conn = ConnectionManager.getConnection();
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			data.add("ADOPT_ORG_ID", syzzinfo.getSyzzCode());	//添加收养组织code
			data.add("NAME_CN", syzzinfo.getSyzzCnName());	//添加收养组织中文名称
			data.add("NAME_EN", syzzinfo.getSyzzEnName());		//添加收养组织英文名称
			data.add("COUNTRY_CODE", syzzinfo.getCountryCode());	//获取当前组织所属国家code
			data.add("COUNTRY_CN", syzzinfo.getCountryCnName());	//获取当前组织所属国家的中文名称
			data.add("COUNTRY_EN", syzzinfo.getCountryEnName());	//获取当前组织所属国家的中文名称
			setAttribute("data", data);
		} catch (DBException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "文件录入第一步操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("操作异常[文件录入第一步操作异常]:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction的NormalFileAddFirst.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		
		
		return retValue;
	}
	
	/**
	 * @Title: NormalFileSaveFirst 
	 * @Description: 根据男收养人、女收养人姓名查询该组织的收养文件
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String NormalFileSaveFirst(){
		String file_id = getParameter("AF_ID","");
		//1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","COUNTRY_CN","COUNTRY_EN","FILE_TYPE","FAMILY_TYPE","MALE_NAME","FEMALE_NAME","ADOPTER_SEX");
		
        try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 生成流水号
			FileCommonManager fcm = new FileCommonManager();
			String AF_SEQ_NO = fcm.createFileSeqNO(conn);
			//是否公约收养
			String IS_CONVENTION_ADOPT = fcm.getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));
			String NATION = fcm.getAdopterNation(conn, data.getString("COUNTRY_CODE"));
			//4 获取数据Data
			Data fileData = null;
			if(!"".equals(file_id)){
				fileData = handler.GetFileByID(conn, file_id);
			}
			if(fileData != null){
				//如果文件存在时
				fileData.remove("AF_ID");	//移除文件id
				fileData.remove("AF_SEQ_NO");	//移除流水号
				fileData.remove("FILE_TYPE");	//移除文件类型
				fileData.remove("FAMILY_TYPE");	//移除收养类型
				fileData.remove("CREATE_USERID");	//移除创建人
				fileData.remove("CREATE_DATE");	//移除创建日期
				fileData.remove("AF_COST");	//移除费用
				fileData.remove("AF_POSITION");	//移除文件位置
				fileData.remove("AF_GLOBAL_STATE");	//移除文件的全局状态
			}else{
				//当文件不存在时
				fileData = new Data();
				fileData.add("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID"));	//添加收养组织code
				fileData.add("NAME_CN", data.getString("NAME_CN"));				//添加收养组织中文名称
				fileData.add("NAME_EN", data.getString("NAME_EN"));				//添加收养组织英文名称
				fileData.add("COUNTRY_CODE", data.getString("COUNTRY_CODE"));	//添加收养组织所属国家code
				fileData.add("COUNTRY_CN", data.getString("COUNTRY_CN"));		//添加收养组织所属国家中文名称
				fileData.add("COUNTRY_EN", data.getString("COUNTRY_EN"));		//添加收养组织所属国家英文名称
				fileData.add("MALE_NAME", data.getString("MALE_NAME","").toUpperCase());	//添加男收养人姓名
				fileData.add("FEMALE_NAME", data.getString("FEMALE_NAME","").toUpperCase());	//添加女收养人姓名
				fileData.add("ADOPTER_SEX", data.getString("ADOPTER_SEX"));		//添加女收养人姓名
			}
			
			fileData.add("AF_SEQ_NO", AF_SEQ_NO);	//添加文件流水号
			fileData.add("AF_COST", "800");	//添加费用
			fileData.add("FILE_TYPE", data.getString("FILE_TYPE"));	//添加文件类型
			fileData.add("FAMILY_TYPE", data.getString("FAMILY_TYPE"));	//添加收养类型
			fileData.add("REG_STATE", FileCommonConstant.DJZT_WTJ);	//添加默认的登记状态（0：未提交）
			fileData.add("CREATE_USERID", SessionInfo.getCurUser().getPersonId());	//添加创建人Id
			fileData.add("CREATE_DATE", DateUtility.getCurrentDateTime());	//添加创建日期
			fileData.add("AF_POSITION", FileGlobalStatusAndPositionConstant.POS_SYZZ);	//添加文件默认位置
			fileData.add("AF_GLOBAL_STATE", FileGlobalStatusAndPositionConstant.STA_WTJ);	//添加文件全局状态
			fileData.add("IS_CONVENTION_ADOPT", IS_CONVENTION_ADOPT);
			
			//添加收养人国籍
			String sex = data.getString("ADOPTER_SEX","");
			if("".equals(sex)){
				fileData.add("MALE_NATION", NATION);
				fileData.add("FEMALE_NATION", NATION);
			}else if("1".equals(sex)){
				fileData.add("MALE_NATION", NATION);
			}else if("2".equals(sex)){
				fileData.add("FEMALE_NATION", NATION);
			}
			
			//5创建事务
			dt = DBTransaction.getInstance(conn);
			//新增一条文件记录，并返回该文件id（AF_ID）
            String af_id = handler.NormalFileSaveFirst(conn,fileData);	
			
            fileData.add("AF_ID", af_id);
            //6 将结果集写入页面接收变量
			setAttribute("data",fileData);
			setAttribute("REG_STATE",fileData.getString("REG_STATE",""));
            
            if (!"".equals(af_id)) {
                InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "根据男收养人、女收养人姓名查询该组织的收养文件操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			if (log.isError()) {
				log.logError("根据男收养人、女收养人姓名查询该组织的收养文件操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		}catch (SQLException e) {
			//8 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		}catch (Exception e) {
			//8 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} finally {
			//9 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction的NormalFileSaveFirst.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: NormalFileAdd 
	 * @Description: 根据文件ID获取收养文件信息,并跳转到相应的添加/修改页面
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String NormalFileAdd(){
		boolean flag = false;	//判断是否是点击保存之后跳转操作
		//收养类型（step：继子女，double：双亲，single：单亲）
		retValue = getParameter("type","");	
		
		//从页面获取文件id，当AF_ID为空时，则跳转到修改页面
		String AF_ID = getParameter("AF_ID","");
		
		if("".equals(AF_ID)){
			//如果AF_ID为空，获取要修改的文件ID
			AF_ID = (String)getAttribute("AF_ID");
			//保存之后跳转操作
			flag = true;
		}
		
		//根据文件id获取该文件信息
		Data data = this.GetFileByID(AF_ID);
		setAttribute("xmlstr", data.getString("xmlstr"));
		String file_type = data.getString("FILE_TYPE","");
		String family_type = data.getString("FAMILY_TYPE","");
		
		try {
			conn = ConnectionManager.getConnection();
			if(flag){
				if("33".equals(file_type)){
					retValue = "step";
				}else{
					if("1".equals(family_type)){
						retValue = "double";
					}else{
						retValue = "single";
					}
				}
				
			}else{
				String currency = data.getString("CURRENCY","");
				if("".equals(currency)){
					String orgid = SessionInfo.getCurUser().getCurOrgan().getId();
					SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
					//获取该国家默认的货币种类
					data.put("CURRENCY", syzzinfo.getCurrency());	//添加默认的货币种类
				}
			}
		}catch (DBException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "文件录入添加操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("操作异常[文件录入添加操作异常]:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "文件录入添加操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("操作异常[文件录入添加操作异常]:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} finally {
			//关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction的NormalFileAdd.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		//设置美国公约认证机构名称代码集
		HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
		CodeList coaList = this.getMKRORGCOAList();
    	cmap.put("ORGCOA_LIST", coaList);
    	setAttribute(Constants.CODE_LIST,cmap);
    	
    	//设置家调组织列表，如果家调组织名称不在内容中，则显示为Other
		String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
		if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
			setAttribute("isShowOrgName", "true");
			data.add("HOMESTUDY_ORG_DROP", "Other");
		}else{
			data.add("HOMESTUDY_ORG_DROP", HOMESTUDY_ORG_NAME);
		}
		data.add("HOMESTUDY_ORG_INPUT", HOMESTUDY_ORG_NAME);
		
		//设置页面接收变量
		setAttribute("data", data);
		setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG"));
		setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG"));
		setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG"));
		setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG"));
		setAttribute("IS_FAMILY_OTHERS_FLAG", data.getString("IS_FAMILY_OTHERS_FLAG"));
		
		setAttribute("AF_ID", AF_ID);
		setAttribute("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID",""));
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",AF_ID));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",AF_ID));
		
		return retValue;
	}
	
	/**
	 * @Title: NormalFileSave 
	 * @Description: 保存修改的数据
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String NormalFileSave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","AF_ID","AF_SEQ_NO","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","COUNTRY_CN","COUNTRY_EN","FILE_TYPE","FAMILY_TYPE",
				"MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN","MALE_HEALTH","IS_MEDICALRECOVERY",
				"MALE_HEALTH_CONTENT_EN","MALE_HEIGHT","MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","ADOPTER_SEX",
				"MALE_ILLEGALACT_EN","MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO",
				"FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT",
				"FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN","FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_EN",
				"FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
				"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_EN","FINISH_DATE",
				"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON",
				"IS_SUBMIT_REPORT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","ACCEPTED_CARD",
				"PARENTING","SOCIALWORKER","REMARK_EN","GOVERN_DATE","VALID_PERIOD","APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX",
				"CHILDREN_HEALTH_EN","REG_STATE","AF_POSITION","AF_GLOBAL_STATE","MEASUREMENT");
		//将男、女收养人姓名转化为大写
		String MALE_NAME = data.getString("MALE_NAME","");
		if(!"".equals(MALE_NAME)){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME","");
		if(!"".equals(FEMALE_NAME)){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		if(!("".equals(data.getString("ADDRESS"))) && data.getString("ADDRESS")!=null){
			data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
        }

		data.add("PACKAGE_ID", data.getString("AF_ID"));
		
		//根据有效期限值计算具体的截止日期
		String valid_period = data.getString("VALID_PERIOD","");
		if("-1".equals(valid_period)){
			data.add("EXPIRE_DATE", "2999-12-31");
		}else if(!"".equals(valid_period)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, Integer.parseInt(valid_period));
			cal.add(Calendar.DATE, -1);
			data.add("EXPIRE_DATE", sdf.format(cal.getTime()));
		}
		
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            
            String isGy = new FileCommonManager().getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));//是否公约收养
			data.add("IS_CONVENTION_ADOPT", isGy);//是否公约收养
			
			/*货币换换begin*/
			Data currencyData = new Data();
			currencyData.add("CURRENCY", data.getString("CURRENCY",""));
			currencyData.add("MALE_YEAR_INCOME", data.getString("MALE_YEAR_INCOME",""));
			currencyData.add("FEMALE_YEAR_INCOME", data.getString("FEMALE_YEAR_INCOME",""));
			currencyData.add("TOTAL_ASSET", data.getString("TOTAL_ASSET",""));
			currencyData.add("TOTAL_DEBT", data.getString("TOTAL_DEBT",""));
			
			currencyData = new CurrencyConverterAction().OtherToUSD(conn, currencyData);
			data.add("MALE_YEAR_INCOME", currencyData.getString("MALE_YEAR_INCOME",""));
			data.add("FEMALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("TOTAL_ASSET", currencyData.getString("TOTAL_ASSET",""));
			data.add("TOTAL_DEBT", currencyData.getString("TOTAL_DEBT",""));
			/*货币换换end*/
            
			String clueMes = "";
			FileCommonStatusAndPositionManager spm = new FileCommonStatusAndPositionManager();
			Data tempdata = new Data();	//获取文件位置和状态的data
            //当数据为提交时（状态值：1），添加提交人、提交日期
    		String reg_state = data.getString("REG_STATE");
    		if(reg_state.equals(FileCommonConstant.DJZT_DDJ)){
    			data.add("AF_COST", new FileCommonManager().getAfCost(conn, "ZCWJFWF"));
    			UserInfo curuser = SessionInfo.getCurUser();
    			data.add("SUBMIT_USERID", curuser.getPersonId());
    			data.add("SUBMIT_DATE", DateUtility.getCurrentDateTime());
    			//获取文件的全局状态和位置
    		    tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_N_FILE_DELIVER_SUBMIT);
    		    clueMes = "Submitted successfully!";
    			retValue = "tijiao";
    		}else{
    			//保存文件的全局状态和位置
    			tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_N_FILE_DELIVER_SAVE);
    			setAttribute("AF_ID", data.getString("AF_ID"));
    			clueMes = "Saved successfully!";
    			retValue = "baocun";
    		}
    		
    		//添加文件的全局状态和位置
    		data.add("AF_GLOBAL_STATE", tempdata.getString("AF_GLOBAL_STATE",""));
		    data.add("AF_POSITION", tempdata.getString("AF_POSITION",""));
            
            
            boolean success = false;
            success=handler.NormalFileSave(conn,data);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, clueMes);
                setAttribute("clueTo", clueTo);
                
                String male_photo = data.getString("MALE_PHOTO","");	//男收养人照片
                String female_photo = data.getString("FEMALE_PHOTO");	//女收养人照片
                String file_type = data.getString("FILE_TYPE","");
                if("33".equals(file_type)){	//如果是机子女收养
                	String adopter_sex = data.getString("ADOPTER_SEX","");
                	if(adopter_sex.equals("1")){
                		AttHelper.publishAttsOfPackageId(male_photo, "AF"); //发布男收养人照片
                	}else if(adopter_sex.equals("2")){
                		AttHelper.publishAttsOfPackageId(female_photo, "AF"); //发布女收养人照片
                	}
                }else if(!"".equals(male_photo)){
                	AttHelper.publishAttsOfPackageId(male_photo, "AF"); //发布男收养人照片
                }else if(!"".equals(female_photo)){
                	AttHelper.publishAttsOfPackageId(female_photo, "AF"); //发布女收养人照片
                }
                
                String packageId = data.getString("PACKAGE_ID");//附件
                AttHelper.publishAttsOfPackageId(packageId, "AF");//附件发布
            }
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (Exception e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的NormalFileSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: NormalFileRevise 
	 * @Description: 普通修改页面跳转
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String NormalFileRevise(){
		//获取文件ID
		String file_id = getParameter("AF_ID");
		//根据文件ID（file_id），获取该文件的详细信息
		Data data = this.GetFileByID(file_id);
		setAttribute("data", data);
		setAttribute("REG_STATE", data.getString("REG_STATE",""));
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",file_id));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",file_id));
		
		/*CodeList coaList = this.getMKRORGCOAList();
		String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
		if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
			setAttribute("isShowOrgName", "true");
		}*/
		return retValue;
	}
	
	/**
	 * @Title: NormalFileShow 
	 * @Description: 正常文件查看
	 * @author: yangrt
	 * @return String 
	 */
	public String NormalFileShow(){
		//获取文件id
		String file_id = getParameter("AF_ID");
		//根据文件id(file_id)获取该文件的详细信息
		Data data = this.GetFileByID(file_id);
		
		String file_type = data.getString("FILE_TYPE");	//文件类型
		String family_type = data.getString("FAMILY_TYPE");	//收养类型
		//根据文件类型(file_type)、收养类型(family_type)确定返回的页面
		if("33".equals(file_type)){
			retValue = "step";	//返回继子女收养查看页面
		}else{
			if("1".equals(family_type)){
				retValue = "double";	//返回双亲收养查看页面
			}else{
				retValue = "single";	//返回单亲收养查看页面
				String male_name = data.getString("MALE_NAME","");
				String female_name = data.getString("FEMALE_NAME","");
				if(male_name.equals("")){
					setAttribute("maleFlag", "false");
				}else{
					setAttribute("maleFlag", "true");
				}
				if(female_name.equals("")){
					setAttribute("femaleFlag", "false");
				}else{
					setAttribute("femaleFlag", "true");
				}
			}
		}
		
		setAttribute("data", data);
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO", file_id));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO", file_id));
		setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", file_id));
		
		return retValue;
	}
	
	/**
	 * @Title: NormalFileExport 
	 * @Description: 导出普通文件列表
	 * @author: panfeng
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String NormalFileExport(){
		
		//1  获取页面搜索字段数据
		Data data = getRequestEntityData("S_", "AF_SEQ_NO", "FILE_NO",
				"REGISTER_DATE_START", "REGISTER_DATE_END", "MALE_NAME", 
				"FEMALE_NAME", "FILE_TYPE", "AF_COST", "SUBMIT_DATE_START", 
				"SUBMIT_DATE_END", "REG_STATE");
		String AF_SEQ_NO = data.getString("AF_SEQ_NO", null); // 流水号
		String FILE_NO = data.getString("FILE_NO", null); // 收文编号
		String REGISTER_DATE_START = data
				.getString("REGISTER_DATE_START", null); // 收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null); // 收文结束日期
		
		String MALE_NAME = data.getString("MALE_NAME", null); // 男方
		if(null != MALE_NAME){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME", null); // 女方
		if(null != FEMALE_NAME){
			FEMALE_NAME = FEMALE_NAME.toUpperCase();
		}
		String FILE_TYPE = data.getString("FILE_TYPE", null); // 文件类型
		String AF_COST = data.getString("AF_COST", null); // 应缴金额
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null); // 提交开始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null); // 提交结束日期
		String REG_STATE = data.getString("REG_STATE", null); // 文件状态

		try {
			//2设置导出文件参数
			this.getResponse().setHeader(
					"Content-Disposition",
					"attachment;filename="
							+ new String("递交普通文件.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3处理代码字段 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("GJSY","WJLX_DL");
    		//文件类型代码
    		CodeList scList=codes.get("WJLX_DL");
    		Map<String,String> fileDengji=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			fileDengji.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", fileDengji);
    		//文件状态代码
    		Map<String,String> filestate=new HashMap<String,String>();
    		filestate.put("0","未提交");
    		filestate.put("1","未登记");
    		filestate.put("2","待修改");
    		filestate.put("3","已登记");
    		dict.put("REG_STATE", filestate);
    		//4 执行文件导出
			ExcelExporter.export2Stream("递交普通文件", "NormalFile", dict, this
					.getResponse().getOutputStream(),AF_SEQ_NO, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, FEMALE_NAME, null, FILE_TYPE, AF_COST, SUBMIT_DATE_START, SUBMIT_DATE_END, REG_STATE);
			
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  设置异常处理
			log.logError("导出普通文件出现异常", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "导出普通文件出现异常");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 页面不进行跳转，返回NULL 如需跳转，返回其他值
		return null;
	}
	
	/************** 递交普通文件处理End ***************/
	
	
	/************** 递交特需文件处理Begin ***************/
	
	/**
	 * @Title: SpecialFileList 
	 * @Description: 特需文件信息查询列表
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SpecialFileList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_STATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}
		
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","AF_COST","FILE_TYPE","REG_STATE","NAME","BIRTHDAY_START","BIRTHDAY_END","SEX");
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.SpecialFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件录入查询操作异常");
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
						log.logError("FileManagerAction的SpecialFileList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: SpecialFileSelectList 
	 * @Description: 获取预批通过的特需文件信息列表
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SpecialFileSelectList(){
		String type = getParameter("type","");	//防止列表页的排序条件带过来
		if("".equals(type)){
			type = (String) getAttribute("type");
		}
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REQ_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		
		Data data = new Data();
		if("select".equals(type)){
			compositor="REQ_DATE";
			ordertype="DESC";
		}else{
			//3 获取搜索参数
			data = getRequestEntityData("S_","REQ_NO","MALE_NAME","FEMALE_NAME","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","REQ_DATE_START","REQ_DATE_END","PASS_DATE_START","PASS_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","REMINDERS_STATE");
		}
		
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		String NAME_PINYIN = data.getString("NAME_PINYIN");
		if(null != NAME_PINYIN){
			data.add("NAME_PINYIN", NAME_PINYIN.toUpperCase());
		}
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取预批通过的文件数据(DataList)
			DataList dl=handler.SpecialFileSelectList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("data",data);
			setAttribute("List",dl);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转选择预批通过的特需文件操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("跳转选择预批通过的特需文件操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的SpecialFileSelectList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: SpecialFileAdd
	 * @Description: 特需文件递交的跳转
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SpecialFileAdd(){
		//获取预批申请信息ID
		String ri_id = getParameter("RI_ID");
		setAttribute("RI_ID",ri_id);
		//设置美国公约认证机构名称代码集
		HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
		CodeList coaList = this.getMKRORGCOAList();
    	cmap.put("ORGCOA_LIST", coaList);
    	setAttribute(Constants.CODE_LIST,cmap);
    	
		//设置文件主键id
		String af_id = UUID.getUUID();
		
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请信息ID(ri_id)获取该文件的详细信息
			Data data = handler.GetReqInfoByID(conn,ri_id);
			
			//获取当前收养组织信息
	    	String orgid = SessionInfo.getCurUser().getCurOrgan().getId();
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			String orgCode = syzzinfo.getSyzzCode();
			
			//根据儿童材料id获取附儿童信息
			String ci_id = data.getString("CI_ID");
			Data mainchild = new LockChildHandler().getMainChildInfo(conn, ci_id);
			DataList attachchild = new LockChildHandler().getAttachChildList(conn, ci_id); 
			DataList dataList = new DataList();
			dataList.add(mainchild);
			for(int i = 0; i < attachchild.size(); i++){
				dataList.add(attachchild.getData(i));
				ci_id += "," + attachchild.getData(i).getString("CI_ID","");
			}
			
			//获取附件上传的路径
			String file_type = data.getString("FILE_TYPE");	//文件类型
			String family_type = data.getString("FAMILY_TYPE");	//收养类型
			FfsAfTranslationAction action  = new  FfsAfTranslationAction();
			//parents	双亲 singleparent 单亲 stepchild 继子女		 
			String formType = action.getFormType(family_type, file_type);
			String xmlstr = action.getFileUploadParameter(conn,formType);
			
			//获取该国家是否公约收养
			String IS_CONVENTION_ADOPT = new FileCommonManager().getISGY(conn, file_type, data.getString("COUNTRY_CODE"));
			
			//对于特简文件，系统关联该家庭已提交的文件，将原家庭文件的收养人基本情况表复制一份
			if("22".equals(file_type)){
				//获取系统关联该家庭已提交的文件信息
				Data filedata = handler.getSpecialFileData(conn,data.getString("ORIGINAL_FILE_NO"));
				filedata.put("AF_ID",af_id);
				filedata.put("RI_ID",ri_id);
				filedata.put("RI_STATE",data.getString("RI_STATE"));
				filedata.put("ADOPT_ORG_ID", syzzinfo.getSyzzCode());	//添加收养组织code
				filedata.put("NAME_CN", syzzinfo.getSyzzCnName());	//添加收养组织中文名称
				filedata.put("NAME_EN", syzzinfo.getSyzzEnName());		//添加收养组织英文名称
				filedata.put("COUNTRY_CODE", syzzinfo.getCountryCode());	//获取当前组织所属国家code
				filedata.put("COUNTRY_CN", syzzinfo.getCountryCnName());	//获取当前组织所属国家的中文名称
				filedata.put("COUNTRY_EN", syzzinfo.getCountryEnName());	//获取当前组织所属国家的中文名称
				filedata.put("FILE_TYPE", "22");
				filedata.put("CI_ID", ci_id);
				filedata.remove("REG_STATE");
				filedata.add("IS_CONVENTION_ADOPT", IS_CONVENTION_ADOPT);
				
				String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
				if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
					setAttribute("isShowOrgName", "true");
					filedata.add("HOMESTUDY_ORG_DROP", "Other");
				}else{
					filedata.add("HOMESTUDY_ORG_DROP", HOMESTUDY_ORG_NAME);
				}
				filedata.add("HOMESTUDY_ORG_INPUT", HOMESTUDY_ORG_NAME);
				
				setAttribute("data", filedata);
				setAttribute("IS_FAMILY_OTHERS_FLAG",filedata.getString("IS_FAMILY_OTHERS_FLAG",""));
			}else{
				data.put("AF_ID", af_id);
				data.put("ADOPT_ORG_ID", syzzinfo.getSyzzCode());	//添加收养组织code
				data.put("NAME_CN", syzzinfo.getSyzzCnName());	//添加收养组织中文名称
				data.put("NAME_EN", syzzinfo.getSyzzEnName());		//添加收养组织英文名称
				data.put("COUNTRY_CODE", syzzinfo.getCountryCode());	//获取当前组织所属国家code
				data.put("COUNTRY_CN", syzzinfo.getCountryCnName());	//获取当前组织所属国家的中文名称
				data.put("COUNTRY_EN", syzzinfo.getCountryEnName());	//获取当前组织所属国家的中文名称
				data.put("IS_CONVENTION_ADOPT", IS_CONVENTION_ADOPT);
				if("23".equals(file_type)){
					String PRE_REQ_NO = data.getString("PRE_REQ_NO","");
					Data preData = handler.GetReqInfoByReqNo(conn, PRE_REQ_NO);
					ri_id += "," + preData.getString("RI_ID");
					data.put("RI_ID", ri_id);
					
					String pre_ci_id = preData.getString("CI_ID");
					Data premainchild = new LockChildHandler().getMainChildInfo(conn, pre_ci_id);
					DataList preattachchild = new LockChildHandler().getAttachChildList(conn, pre_ci_id); 
					dataList.add(premainchild);
					for(int i = 0; i < preattachchild.size(); i++){
						dataList.add(preattachchild.getData(i));
						pre_ci_id += "," + preattachchild.getData(i).getString("CI_ID","");
					}
					ci_id += "," + pre_ci_id;
					data.put("CI_ID", ci_id);
				}else{
					data.put("CI_ID", ci_id);
				}
				
				setAttribute("data", data);
				setAttribute("IS_FAMILY_OTHERS_FLAG",data.getString("IS_FAMILY_OTHERS_FLAG",""));
			}
			
			//复制预批申请信息中的收养人照片
			String adopter_sex = data.getString("ADOPTER_SEX","");
			ri_id = ri_id.split(",")[0];
			if("".equals(adopter_sex)){
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_MALEPHOTO, "AF", af_id, "AF", AttConstants.AF_MALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_FEMALEPHOTO, "AF", af_id, "AF", AttConstants.AF_FEMALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
			}else if("1".equals(adopter_sex)){
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_MALEPHOTO, "AF", af_id, "AF", AttConstants.AF_MALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
			}else if("1".equals(adopter_sex)){
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_FEMALEPHOTO, "AF", af_id, "AF", AttConstants.AF_FEMALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
			}
			
			setAttribute("List", dataList);
			setAttribute("AF_ID", af_id);
			setAttribute("CI_ID", ci_id);
			setAttribute("ADOPT_ORG_ID", orgCode);
			setAttribute("xmlstr", xmlstr);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",af_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",af_id));
			setAttribute("REG_STATE", data.getString("REG_STATE",""));
			setAttribute("SUBMIT_DATE", data.getString("SUBMIT_DATE").substring(0, 10));
			setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG"));	//男收养人违法行为及刑事处罚标识,0=无，1=有
			setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG"));	//男收养人有无不良嗜好标识,0=无，1=有
			setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG"));	//女收养人违法行为及刑事处罚标识,0=无，1=有
			setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG"));	//女收养人有无不良嗜好标识,0=无，1=有
			
			//根据收养类型(family_type)确定返回的页面,1:双亲收养,2：单亲收养
			if("1".equals(family_type)){
				retValue = "double";	//返回双亲收养查看页面
			}else{
				retValue = "single";	//返回单亲收养查看页面
			}
			
			setAttribute("FLAG", "add");	//设置添加、修改标示
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转录入特需文件操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("跳转录入特需文件操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转录入特需文件操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("跳转录入特需文件操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的SpecialFileAdd.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: SpecialFileSave 
	 * @Description: 特需文件递交保存
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SpecialFileSave(){
		//获取添加、修改标示，add为添加，mod为修改
		String flag = getParameter("FLAG");
		//获取当前登录人信息
		UserInfo curuser = SessionInfo.getCurUser();
		
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","AF_ID","RI_ID","RI_STATE","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","COUNTRY_CN","COUNTRY_EN","CI_ID","FILE_TYPE","FAMILY_TYPE",
				"MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN","MALE_HEALTH","IS_MEDICALRECOVERY",
				"MALE_HEALTH_CONTENT_EN","MALE_HEIGHT","MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG",
				"MALE_ILLEGALACT_EN","MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO",
				"FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT",
				"FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN","FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_EN",
				"FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
				"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_EN","FINISH_DATE",
				"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON",
				"IS_SUBMIT_REPORT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","ACCEPTED_CARD",
				"PARENTING","SOCIALWORKER","REMARK_EN","GOVERN_DATE","VALID_PERIOD","APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX",
				"CHILDREN_HEALTH_EN","REG_STATE","AF_POSITION","AF_GLOBAL_STATE","MEASUREMENT","ADOPTER_SEX","IS_CONVENTION_ADOPT");
		//将男、女收养人姓名转化为大写
		String MALE_NAME = data.getString("MALE_NAME","");
		if(!"".equals(MALE_NAME)){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME","");
		if(!"".equals(FEMALE_NAME)){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		if(!("".equals(data.getString("ADDRESS"))) && data.getString("ADDRESS")!=null){
			data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
        }
		data.add("PACKAGE_ID", data.getString("AF_ID"));
		
		//根据有效期限值计算具体的截止日期
		String valid_period = data.getString("VALID_PERIOD","");
		if("-1".equals(valid_period)){
			data.add("EXPIRE_DATE", "2999-12-31");
		}else if(!"".equals(valid_period)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, Integer.parseInt(valid_period));
			cal.add(Calendar.DATE, -1);
			data.add("EXPIRE_DATE", sdf.format(cal.getTime()));
		}
		
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            //添加流水号
            data.put("AF_SEQ_NO", new FileCommonManager().createFileSeqNO(conn));
            
            String isGy = new FileCommonManager().getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));//是否公约收养
			data.add("IS_CONVENTION_ADOPT", isGy);//是否公约收养
			
			/*货币换换begin*/
			Data currencyData = new Data();
			currencyData.add("CURRENCY", data.getString("CURRENCY",""));
			currencyData.add("MALE_YEAR_INCOME", data.getString("MALE_YEAR_INCOME",""));
			currencyData.add("FEMALE_YEAR_INCOME", data.getString("FEMALE_YEAR_INCOME",""));
			currencyData.add("TOTAL_ASSET", data.getString("TOTAL_ASSET",""));
			currencyData.add("TOTAL_DEBT", data.getString("TOTAL_DEBT",""));
			
			currencyData = new CurrencyConverterAction().OtherToUSD(conn, currencyData);
			data.add("MALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("FEMALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("TOTAL_ASSET", currencyData.getString("TOTAL_ASSET",""));
			data.add("TOTAL_DEBT", currencyData.getString("TOTAL_DEBT",""));
			/*货币换换end*/
            
			String clueMes = "";
			FileCommonStatusAndPositionManager spm = new FileCommonStatusAndPositionManager();
			Data tempdata = new Data();	//获取文件位置和状态的data
            //当数据为提交时（状态值：1），添加提交人、提交日期
    		String reg_state = data.getString("REG_STATE");
    		if(reg_state.equals(FileCommonConstant.DJZT_DDJ)){
    			
    			data.add("SUBMIT_USERID", curuser.getPersonId());
    			data.add("SUBMIT_DATE", DateUtility.getCurrentDateTime());
    			//获取文件的全局状态和位置
    			tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_S_FILE_DELIVER_SUBMIT);
    			clueMes = "Submitted successfully!";
    			retValue = "submit";
    		}else{
    			data.add("CREATE_USERID", curuser.getPersonId());
    			data.add("CREATE_DATE", DateUtility.getCurrentDateTime());
    			//获取文件的全局状态和位置
    			tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_S_FILE_DELIVER_SAVE);
    			clueMes = "Saved successfully!";
    			setAttribute("FLAG", "mod");	//设置添加、修改标示
    			retValue = "save";
    		}
            
    		//添加文件的全局状态和位置
    		data.add("AF_GLOBAL_STATE", tempdata.getString("AF_GLOBAL_STATE",""));
		    data.add("AF_POSITION", tempdata.getString("AF_POSITION",""));
		    
		    String ci_id = data.getString("CI_ID");
		    int child_num = 1;			//儿童数量
		    if(ci_id.contains(",")){
		    	child_num = ci_id.split(",").length;
		    }
		    int af_cost = new FileCommonManager().getAfCost(conn, "TXWJFWF");
		    data.add("AF_COST", child_num * af_cost);
		    
		    DataList dl = handler.forUpdateSceReqInfo(conn, data.getString("RI_ID",""));
		    String ri_stata = dl.getData(0).getString("RI_STATE");
		    if("4".equals(ri_stata)){
		    	boolean success = handler.SpecialFileSave(conn,data,flag);
	            if (success) {
	                InfoClueTo clueTo = new InfoClueTo(0, clueMes);
	                setAttribute("clueTo", clueTo);
	                
	                //附件发布
	                String male_photo = data.getString("MALE_PHOTO","");		//男收养人照片
	                if(!"".equals(male_photo)){
	                	AttHelper.publishAttsOfPackageId(male_photo, "AF"); 	//发布男收养人照片
	                }
	                String female_photo = data.getString("FEMALE_PHOTO");		//女收养人照片
	                if(!"".equals(female_photo)){
	                	AttHelper.publishAttsOfPackageId(female_photo, "AF"); 	//发布女收养人照片
	                }
	                String packageId = data.getString("PACKAGE_ID");			//附件
	                AttHelper.publishAttsOfPackageId(packageId, "AF");			//附件发布
	            }
	            
	            setAttribute("data", data);
	            setAttribute("AF_ID", data.getString("AF_ID",""));
	            
	            //设置美国公约认证机构名称代码集
				HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
		    	cmap.put("ORGCOA_LIST", getMKRORGCOAList());
		    	setAttribute(Constants.CODE_LIST,cmap);
		    	
		    	dt.commit();
		    }else if("5".equals(ri_stata)){
		    	InfoClueTo clueTo = new InfoClueTo(0, "该预批已递交文件，不能重复递交。请重新选择预批文件！");
	            setAttribute("clueTo", clueTo);
	            retValue = "select";					//跳转到预批选择页面
	            setAttribute("type", "select");			//调转预批选择页面所需参数
		    }
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "特需文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "特需文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (Exception e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "特需文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的SpecialFileSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: SpecialFileRevise 
	 * @Description: 修改页面跳转
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SpecialFileRevise(){
		//获取文件ID
		String file_id = getParameter("AF_ID","");
		if("".equals(file_id)){
			file_id = (String)getAttribute("AF_ID");
		}
		//设置美国公约认证机构名称代码集
        CodeList coaList = this.getMKRORGCOAList();
		HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
    	cmap.put("ORGCOA_LIST", coaList);
    	setAttribute(Constants.CODE_LIST,cmap);
		try{
			//根据文件ID（file_id），获取该文件的详细信息
			Data data = this.GetFileByID(file_id);
			conn = ConnectionManager.getConnection();
			String ri_id = data.getString("RI_ID");
			String ci_id = data.getString("CI_ID","");
			String[] riId = ri_id.split(",");
			Data tempData = new Data();
			for(int i = 0; i < riId.length; i++){
				Data ridata = handler.GetReqInfoByID(conn,riId[i]);
				tempData.add(ridata.getString("CI_ID"), ridata.getString("SUBMIT_DATE").substring(0, 10));
			}
			//获取预批申请记录中的交文期限
			
			//获取儿童材料信息
			DataList dl = handler.getChildDataList(conn, ci_id);
			for(int i = 0; i < dl.size(); i++){
				Data childdata = dl.getData(i);
				String MAIN_CI_ID = childdata.getString("MAIN_CI_ID","").toUpperCase();
				childdata.add("SUBMIT_DATE", tempData.getString(MAIN_CI_ID));
			}
			
			String isGy = new FileCommonManager().getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));//是否公约收养
			data.add("IS_CONVENTION_ADOPT", isGy);//是否公约收养
			
			String family_type = data.getString("FAMILY_TYPE");
			if("1".equals(family_type)){
				retValue = "double";	//返回双亲收养修改页面
			}else{
				retValue = "single";	//返回单亲收养修改页面
			}
			
			//完成家调组织输入框是否显示
			String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
			if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
				setAttribute("isShowOrgName", "true");
				data.add("HOMESTUDY_ORG_DROP", "Other");
			}else{
				data.add("HOMESTUDY_ORG_DROP", HOMESTUDY_ORG_NAME);
			}
			data.add("HOMESTUDY_ORG_INPUT", HOMESTUDY_ORG_NAME);
			
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("REG_STATE", data.getString("REG_STATE",""));
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",file_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",file_id));
			setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG",""));
            setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG",""));
            setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG",""));
            setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG",""));
            setAttribute("AF_ID", file_id);
            setAttribute("CI_ID", ci_id);
            setAttribute("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID",""));
            setAttribute("xmlstr", data.getString("xmlstr",""));
            setAttribute("IS_FAMILY_OTHERS_FLAG",data.getString("IS_FAMILY_OTHERS_FLAG",""));
            setAttribute("FLAG", "mod");	//设置添加、修改标示
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "特需文件修改操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[特需文件修改操作]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction的ChildDataShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		
		return retValue;
	}
	
	/**
	 * @Title: SpecialFileShow 
	 * @Description: 特需文件信息查看
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SpecialFileShow(){
		//获取文件id
		String file_id = getParameter("AF_ID");
		try {
			//根据文件id(file_id)获取该文件的详细信息
			Data data = this.GetFileByID(file_id);
			conn = ConnectionManager.getConnection();
			String ri_id = data.getString("RI_ID","");
			String[] riId = ri_id.split(",");
			//获取预批申请记录中的交文期限
			Data tempData = new Data();
			for(int i = 0; i < riId.length; i++){
				Data ridata = handler.GetReqInfoByID(conn,riId[i]);
				tempData.add(ridata.getString("CI_ID"), ridata.getString("SUBMIT_DATE").substring(0, 10));
			}
			
			//根据儿童材料id获取儿童信息
			String ci_id = data.getString("CI_ID");
			DataList dataList = handler.getChildDataList(conn, ci_id);
			for(int i = 0; i < dataList.size(); i++){
				Data childdata = dataList.getData(i);
				String MAIN_CI_ID = childdata.getString("MAIN_CI_ID","").toUpperCase();
				childdata.add("SUBMIT_DATE", tempData.getString(MAIN_CI_ID));
			}
			
			String family_type = data.getString("FAMILY_TYPE");	//收养类型
			//根据收养类型(family_type)确定返回的页面
			if("1".equals(family_type)){
				retValue = "double";	//返回双亲收养查看页面
			}else{
				retValue = "single";	//返回单亲收养查看页面
				String male_name = data.getString("MALE_NAME","");
				String female_name = data.getString("FEMALE_NAME","");
				if(male_name.equals("")){
					setAttribute("maleFlag", "false");
				}else{
					setAttribute("maleFlag", "true");
				}
				if(female_name.equals("")){
					setAttribute("femaleFlag", "false");
				}else{
					setAttribute("femaleFlag", "true");
				}
			}
			
			setAttribute("List", dataList);
			setAttribute("data", data);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",file_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",file_id));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", file_id));
		}catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "特需文件查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("特需文件查看操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的SpecialFileShow.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
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
		String str_id = getParameter("ci_id");
		String ri_id = getParameter("RI_ID","");
		try {
			conn = ConnectionManager.getConnection();
			DataList dl = handler.getChildDataList(conn, str_id);
			String[] riId = ri_id.split(",");
			//获取预批申请记录中的交文期限
			Data tempData = new Data();
			for(int i = 0; i < riId.length; i++){
				Data ridata = handler.GetReqInfoByID(conn,riId[i]);
				tempData.add(ridata.getString("CI_ID"), ridata.getString("SUBMIT_DATE").substring(0, 10));
			}
			for(int i = 0; i < dl.size(); i++){
				Data childdata = dl.getData(i);
				String MAIN_CI_ID = childdata.getString("MAIN_CI_ID","").toUpperCase();
				childdata.add("SUBMIT_DATE", tempData.getString(MAIN_CI_ID));
			}
			setAttribute("List", dl);
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
                        log.logError("FileManagerAction的ChildDataShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: SpecialFileExport 
	 * @Description: 导出特需文件信息
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SpecialFileExport(){
		
		//1  获取页面搜索字段数据
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO",
				"SUBMIT_DATE_START","SUBMIT_DATE_END","REGISTER_DATE_START","REGISTER_DATE_END",
				"AF_COST","FILE_TYPE","REG_STATE");
		String MALE_NAME = data.getString("MALE_NAME", null); // 男方
		if(null != MALE_NAME){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME", null); // 女方
		if(null != FEMALE_NAME){
			MALE_NAME = FEMALE_NAME.toUpperCase();
		}
		
		String FILE_NO = data.getString("FILE_NO", null); // 收文编号
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null); // 提交起始日期
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null); // 提交截止日期
		String REGISTER_DATE_START = data.getString("SUBMIT_DATE_START", null); // 收文起始日期
		String REGISTER_DATE_END = data.getString("SUBMIT_DATE_END", null); // 收文截止日期
		String AF_COST = data.getString("AF_COST", null); // 应缴金额
		/*String NAME = data.getString("NAME", null); // 儿童姓名
		String SEX = data.getString("SEX", null); // 性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START", null); // 出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END", null); // 出生截止日期
*/		String FILE_TYPE = data.getString("FILE_TYPE", null); // 文件类型
		String REG_STATE = data.getString("REG_STATE", null); // 登记状态
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();

		try {
			//2设置导出文件参数
			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("递交特需文件.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3处理代码字段 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("TXWJLX","ETXB");
    		//文件类型代码
    		CodeList scList=codes.get("TXWJLX");
    		Map<String,String> filetype=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			filetype.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", filetype);
    		//儿童性别代码
    		CodeList xbList=codes.get("ETXB");
    		Map<String,String> childsex=new HashMap<String,String>();
    		for(int i=0;i<xbList.size();i++){
    			Code c=xbList.get(i);
    			childsex.put(c.getValue(),c.getName());
    		}
    		dict.put("SEX", childsex);
    		//文件状态代码
    		Map<String,String> filestate=new HashMap<String,String>();
    		filestate.put("0","未提交");
    		filestate.put("1","未登记");
    		filestate.put("2","待修改");
    		filestate.put("3","已登记");
    		dict.put("REG_STATE", filestate);
    		//4 执行文件导出
			ExcelExporter.export2Stream("递交特需文件", "SpecialFile", dict, this.getResponse().getOutputStream(),
					MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, FILE_TYPE, AF_COST, SUBMIT_DATE_START, SUBMIT_DATE_END, REG_STATE, orgcode);
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  设置异常处理
			log.logError("导出特需文件出现异常", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "导出特需文件出现异常");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 页面不进行跳转，返回NULL 如需跳转，返回其他值
		return null;
	}
	
	/************** 递交特需文件处理End ***************/
	
	/************** 补充文件处理Start ***************/
	
	/**
	 * @Title: SuppleFileList 
	 * @Description: 补充文件列表
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SuppleFileList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AA_STATUS";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FILE_TYPE","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
		String MALE_NAME = data.getString("MALE_NAME",null);
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
			DataList dl=handler.SuppleFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "补充文件查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("补充文件查询操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的SuppleFileList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: SuppleFileAdd 
	 * @Description: 补充文件信息添加/修改操作
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SuppleFileAdd(){
		//获取补充文件主键ID(aa_id)
		String aa_id = getParameter("AA_ID");
		try {
			//获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据补充文件ID(aa_id)，获取文件信息及补充信息数据Data
			Data data = handler.getSuppleFileData(conn,aa_id);
			
			//将结果集写入页面接收变量
			setAttribute("data",data);
			setAttribute("AA_ID", aa_id);
			setAttribute("ORG_CODE", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "补充文件添加/修改操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("补充文件添加/修改操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的SuppleFileAdd.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: SuppleFileSave 
	 * @Description: 保存补充文件信息
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SuppleFileSave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","AA_ID","IS_ADDATTACH","IS_MODIFY","ADD_CONTENT_EN","AA_STATUS","NOTICE_CONTENT","NOTICE_DATE","UPLOAD_IDS","AF_ID","FILE_NO","FILE_TYPE","MALE_NAME","MALE_BIRTHDAY","FEMALE_NAME","FEMALE_BIRTHDAY");
		try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            
    		//创建补充文件保存数据aadata
            Data aadata = new Data();
            aadata.add("AA_ID", data.getString("AA_ID"));
            aadata.add("ADD_CONTENT_EN", data.getString("ADD_CONTENT_EN"));
            aadata.add("AA_STATUS", data.getString("AA_STATUS"));
            aadata.add("UPLOAD_IDS", data.getString("UPLOAD_IDS"));
            
            //创建文件信息保存数据filedata
            Data filedata = new Data();
            filedata.add("AF_ID", data.getString("AF_ID"));
            filedata.add("AA_ID", data.getString("AA_ID"));
            filedata.add("SUPPLY_STATE", data.getString("AA_STATUS"));
            
            String clueMes = "";
            //当数据为提交时（状态值：2）
    		String aa_state = data.getString("AA_STATUS");
    		if("2".equals(aa_state)){
    			UserInfo curuser = SessionInfo.getCurUser();
    			aadata.add("FEEDBACK_USERID", curuser.getPersonId());	//添加反馈人ID
    			aadata.add("FEEDBACK_USERNAME", curuser.getPerson().getCName());	//添加反馈人姓名
    			aadata.add("FEEDBACK_ORGID", curuser.getCurOrgan().getOrgCode());	//添加反馈人组织code
    			aadata.add("FEEDBACK_DATE", DateUtility.getCurrentDateTime());	//添加反馈日期
    			clueMes = "Submitted successfully!";
    			retValue = "submit";
    		}else{
    			clueMes = "Saved successfully!";
				retValue = "save";
    		}
    		
    		//执行补充文件保存操作
            boolean success = false;
            success=handler.SuppleFileSave(conn,aadata,filedata);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, clueMes);
                setAttribute("clueTo", clueTo);
                //判断附件是否上传
                String flag = getParameter("FLAG");
                if("true".equals(flag)){
                	AttHelper.publishAttsOfPackageId(data.getString("UPLOAD_IDS"), "AF");
                }
            }
            
            setAttribute("data", data);
            setAttribute("AA_ID", data.getString("AA_ID"));
            setAttribute("ORG_CODE", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "补充文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "补充文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (Exception e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "补充文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的SuppleFileSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: SuppleFileShow 
	 * @Description: 文件基本信息查看/修改操作
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SuppleFileShow(){
		//判断是添加还是修改操作，add为添加操作，mod为修改操作
		String type = getParameter("type");
		//获取文件信息ID
		String af_id = getParameter("AF_ID");
		//根据文件信息ID，获取文件详细信息
		Data data = this.GetFileByID(af_id);
		DataList dataList = new DataList();
		//根据文件类型(file_type)、收养类型(family_type)，判断返回的操作页面
		String file_type = data.getString("FILE_TYPE");	//文件类型
		String family_type = data.getString("FAMILY_TYPE");	//收养类型
		if("33".equals(file_type)){
			retValue = type + "step";
		}else{
			if("20".equals(file_type) || "21".equals(file_type) || "22".equals(file_type) || "23".equals(file_type)){
				try {
					conn = ConnectionManager.getConnection();
					//根据儿童材料id获取儿童信息
					String ci_id = data.getString("CI_ID");
					dataList = handler.getChildDataList(conn, ci_id);
					
				}catch (DBException e) {
					// 设置异常处理
					setAttribute(Constants.ERROR_MSG_TITLE, "补充文件查看操作异常");
					setAttribute(Constants.ERROR_MSG, e);
					if (log.isError()) {
						log.logError("补充文件查看操作异常:" + e.getMessage(),e);
					}
					
					retValue = "error1";
					
				} finally {
					//关闭数据库连接
					if (conn != null) {
						try {
							if (!conn.isClosed()) {
								conn.close();
							}
						} catch (SQLException e) {
							if (log.isError()) {
								log.logError("FileManagerAction的SuppleFileShow.Connection因出现异常，未能关闭",e);
							}
							retValue = "error2";
						}
					}
				}
			}
			if("1".equals(family_type)){
				retValue = type + "double";
			}else{
				retValue = type + "single";
				String male_name = data.getString("MALE_NAME","");
				String female_name = data.getString("FEMALE_NAME","");
				if(male_name.equals("")){
					setAttribute("maleFlag", "false");
				}else{
					setAttribute("maleFlag", "true");
				}
				if(female_name.equals("")){
					setAttribute("femaleFlag", "false");
				}else{
					setAttribute("femaleFlag", "true");
				}
			}
		}
		
		setAttribute("AF_ID", af_id);
		setAttribute("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID",""));
		setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG",""));
		setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG",""));
		setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG",""));
		setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG",""));
		setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG",""));
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
		setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", af_id));
		setAttribute("xmlstr", data.getString("xmlstr"));
		
		setAttribute("data", data);
		setAttribute("List", dataList);
		return retValue;
	}
	
	/**
	 * @Title: BasicInfoSave 
	 * @Description: 保存收养人基本信息
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public void BasicInfoSave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","AF_ID","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN",
				"MALE_HEALTH","IS_MEDICALRECOVERY","MALE_HEALTH_CONTENT_EN","MALE_HEIGHT","MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG",
				"MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_EN","MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME",
				"FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN",
				"FEMALE_HEIGHT","FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN","FEMALE_ILLEGALACT_FLAG",
				"FEMALE_ILLEGALACT_EN","FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE",
				"CONABITA_PARTNERS","CONABITA_PARTNERS_TIME","GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_EN",
				"UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_EN");
		
		//将男、女收养人姓名转化为大写
        if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
        	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
        	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("ADDRESS"))) && data.getString("ADDRESS")!=null){
        	data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
        }
        //获取文件的原数据
        Data olddata = this.GetFileByID(data.getString("AF_ID"));
        
		try {
			//2 获取数据库连接
	        conn = ConnectionManager.getConnection();
	        //3创建事务
	        dt = DBTransaction.getInstance(conn);
	        handler.NormalFileSave(conn, data);
	        //保存修改历史记录
	        ModifyHistoryHandler mhhandler = new ModifyHistoryHandler();
	        mhhandler.savehistory(conn, olddata, data, "FFS_AF_REVISE", "AR_ID", "AF_ID", data.getString("AF_ID"), "1");
	        
	    	AttHelper.publishAttsOfPackageId(data.getString("MALE_PHOTO"), "AF"); //发布男收养人照片
	    	AttHelper.publishAttsOfPackageId(data.getString("FEMALE_PHOTO"), "AF"); //发布女收养人照片
	        
	        dt.commit();
	        
		} catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "补充文件信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件基本信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件基本信息保存操作异常:" + e.getMessage(),e);
            }
            
        } catch (Exception e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件基本信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件基本信息保存操作异常:" + e.getMessage(),e);
            }
            
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的BasicInfoSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                }
            }
        }
	}
	
	/**
	 * @Title: SuppleBatchSubmit 
	 * @Description: 补充文件信息批量提交操作
	 * @author: yangrt
	 * @return String
	 * @throws
	 */
	public String SuppleBatchSubmit(){
		//1 获取要提交的文件ID
		String subuuid = getParameter("subuuid", "");
		String[] aa_id = subuuid.split("#");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			success = handler.SuppleBatchSubmit(conn, aa_id);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "批量提交补充文件操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("批量提交补充文件操作异常[提交操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: SuppleFileExport 
	 * @Description: 补充文件信息导出操作
	 * @author: yangrt
	 * @return String null
	 * @throws
	 */
	public String SuppleFileExport(){
		//1  获取页面搜索字段数据
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FILE_TYPE","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
		String MALE_NAME = data.getString("MALE_NAME",null);	//男收养人
		if(MALE_NAME != null){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//女收养人
		if(FEMALE_NAME != null){
			FEMALE_NAME = FEMALE_NAME.toUpperCase();
		}
		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
		String NOTICE_DATE_START = data.getString("SUBMIT_DATE_START", null);	//通知开始日期
		String NOTICE_DATE_END = data.getString("SUBMIT_DATE_END", null);	//通知结束日期
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
		String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);	//补充起始日期
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);	//补充截止日期
		String AA_STATUS = data.getString("AA_STATUS", null);	//文件补充状态
		
		try {
			//2设置导出文件参数
			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("补充文件信息.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3处理代码字段 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("WJLX");
    		//文件类型代码
			CodeList scList=codes.get("WJLX");
    		Map<String,String> filetype=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			filetype.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", filetype);
    		//文件补充状态代码
			Map<String,String> state = new HashMap<String,String>();
			state.put("0", "待补充");
			state.put("1", "补充中");
			state.put("2", "已补充");
    		//4 执行文件导出
			ExcelExporter.export2Stream("补充文件信息", "SuppleFile", dict, this.getResponse().getOutputStream(),
					MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, FILE_TYPE, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS);
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  设置异常处理
			log.logError("导出补充文件出现异常", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "导出补充文件出现异常");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 页面不进行跳转，返回NULL 如需跳转，返回其他值
		return null;
	}
	
	/**
	 * @Title: FileProgressList 
	 * @Description: 文件进度及缴费查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String FileProgressList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","FILE_NO","MALE_NAME","FEMALE_NAME","FILE_TYPE","CHILD_TYPE","PAID_NO","AF_COST_PAID","AF_COST","FEEDBACK_NUM","IS_PAUSE","AF_GLOBAL_STATE","IS_FINISH","REGISTER_DATE_START","REGISTER_DATE_END","ADVICE_NOTICE_DATE_START","ADVICE_NOTICE_DATE_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END");
												
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.FileProgressList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件进度及缴费信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("文件进度及缴费信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的FileProgressList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: FileProgressShow 
	 * @Description: 文件办理进度及缴费信息查看 
	 * @author: yangrt
	 * @return String 
	 */
	public String FileProgressShow(){
		//获取文件信息ID
		String af_id = getParameter("AF_ID");
		//根据文件信息ID,获取文件信息
		Data filedata = this.GetFileByID(af_id);
		//预批申请信息ID
		String ri_id = filedata.getString("RI_ID","");
		if("".equals(ri_id)){
			setAttribute("riTab", "false");
		}else{
			setAttribute("riTab", "true");
		}
		//预批儿童信息ID
		String ci_id = filedata.getString("CI_ID","");
		if("".equals(ci_id)){
			setAttribute("ciTab", "false");
		}else{
			setAttribute("ciTab", "true");
		}
		setAttribute("data", filedata);
		setAttribute("AF_ID", af_id);
		/*try {
			conn = ConnectionManager.getConnection();
			//根据预批信息ID,获取预批信息DataList
			DataList ridatalist = new DataList();
			String str_ri = "'";
			if(!ri_id.equals("")){
				if(ri_id.contains(",")){
					for(int i = 0; i < ri_id.split(",").length; i++){
						str_ri += ri_id.split(",")[i] + "',";
					}
				}else{
					str_ri += ri_id + "',";
				}
				ridatalist = handler.getReqDataList(conn, str_ri.substring(0, str_ri.lastIndexOf(",")));
				
			}else{
				setAttribute("riFlag","false");
			}
			
			//根据儿童信息ID,获取预批儿童信息DataList
			DataList cidatalist = new DataList();
			if(!ci_id.equals("")){
				cidatalist = handler.getChildDataList(conn, ci_id);
				
			}else{
				setAttribute("ciFlag","false");
			}
			
			setAttribute("data", filedata);
			setAttribute("MALE_PHOTO", filedata.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", filedata.getString("FEMALE_PHOTO",""));
			setAttribute("riList", ridatalist);
			setAttribute("ciList", cidatalist);
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件进度查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[文件进度查看操作]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction的FileProgressShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }*/
		return retValue;
	}
	
	public String getReqDataList(){
		String ri_id = getParameter("RI_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据预批信息ID,获取预批信息DataList
			DataList ridatalist = new DataList();
			String str_ri = "'";
			if(ri_id.contains(",")){
				for(int i = 0; i < ri_id.split(",").length; i++){
					str_ri += ri_id.split(",")[i] + "',";
				}
			}else{
				str_ri += ri_id + "',";
			}
			ridatalist = handler.getReqDataList(conn, str_ri.substring(0, str_ri.lastIndexOf(",")));
				
			setAttribute("riList", ridatalist);
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件进度查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[文件进度查看操作]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction的FileProgressShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/************** 补充文件处理End ***************/
	
	
	
	/************** 缴费信息处理Start ***************/
	
	/**
	 * @Title: PaymentList 
	 * @Description: 缴费信息查询列表
	 * @author: yangrt;
	 * @return String    返回类型 
	 * @throws
	 */
	public String PaymentList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAR_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_VALUE","ARRIVE_STATE","ARRIVE_ACCOUNT_VALUE","FILE_NO");
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.PaymentList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "缴费信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("缴费信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的PaymentList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: PaymentShow 
	 * @Description: 缴费信息及收养信息查看
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentShow(){
		//获取缴费信息信息ID
		String cheque_id = getParameter("CHEQUE_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据缴费信息ID,获取缴费信息Data
			Data data = handler.getPaymentData(conn, cheque_id);
			//获取与缴费信息相关的收养信息
			DataList dl = new DataList();
			String str_file_no = data.getString("FILE_NO","");
			if(str_file_no.contains(",")){
				String[] file_no = str_file_no.split(",");
				for(int i = 0; i < file_no.length; i++){
					Data filedata = handler.getSpecialFileData(conn, file_no[i]);
					dl.add(filedata);
				}
			}else{
				Data filedata = handler.getSpecialFileData(conn, str_file_no);
				dl.add(filedata);
			}
			setAttribute("data", data);
			setAttribute("List", dl);
			setAttribute("FILE_CODE", data.getString("FILE_CODE",cheque_id));
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "缴费信息及收养信息查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[缴费信息及收养信息查看操作]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction的PaymentShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PaymentExport 
	 * @Description: 缴费信息导出
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentExport(){
		//1  获取页面搜索字段数据
		Data data = getRequestEntityData("S_","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAR_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_VALUE","ARRIVE_STATE","ARRIVE_ACCOUNT_VALUE","FILE_NO");
		
		String PAID_NO = data.getString("PAID_NO", null);	//缴费编号
		String COST_TYPE = data.getString("COST_TYPE", null);	//缴费类型
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//应缴金额
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//票面金额
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//到账起始日期
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//到账截止日期
		String ARRIVE_VALUE = data.getString("SUBMIT_DATE_END", null);	//到账金额
		String ARRIVE_STATE = data.getString("FILE_TYPE", null);	//到账状态
		String ARRIVE_ACCOUNT_VALUE = data.getString("FEEDBACK_DATE_START", null);	//结余账号使用金额
		String FILE_NO = data.getString("FEEDBACK_DATE_END", null);	//收文编号
		
		try {
			//2设置导出文件参数
			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("缴费信息.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3处理代码字段 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("FYLB");
			//缴费类型代码
    		CodeList scList=codes.get("FYLB");
    		Map<String,String> costtype=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			costtype.put(c.getValue(),c.getName());
    		}
    		dict.put("COST_TYPE", costtype);
    		//到账状态代码
    		Map<String,String> state = new HashMap<String,String>();
    		state.put("0", "待确认");
    		state.put("1", "足额");
    		state.put("2", "不足");
    		dict.put("ARRIVE_STATE", state);
    		//4 执行文件导出
			ExcelExporter.export2Stream("缴费信息", "PaymentData", dict, this.getResponse().getOutputStream(),
					PAID_NO,COST_TYPE,PAID_SHOULD_NUM,PAR_VALUE,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_VALUE,ARRIVE_STATE,ARRIVE_ACCOUNT_VALUE,FILE_NO);
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  设置异常处理
			log.logError("导出缴费信息出现异常", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "导出缴费信息出现异常");
			setAttribute(Constants.ERROR_MSG, e);
		}
		return null;
	}
	
	/**
	 * @Title: PaymentNoticeList 
	 * @Description: 缴费通知信息查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentNoticeList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="NOTICE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","PAID_NO","COST_TYPE","CHILD_NUM","S_CHILD_NUM","PAID_SHOULD_NUM","NOTICE_DATE_START","NOTICE_DATE_END","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_VALUE");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.PaymentNoticeList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "缴费通知信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("缴费通知信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的PaymenNoticetList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: PaymentNoticeShow 
	 * @Description: 催缴通知信息列表
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentNoticeShow(){
		//获取催缴记录ID
		String rm_id = getParameter("RM_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据缴费信息ID,获取缴费信息Data
			Data data = handler.getPaymentNoticeData(conn, rm_id);
			setAttribute("UPLOAD_ID",data.getString("UPLOAD_ID",""));
			setAttribute("data", data);
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "催缴通知信息查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[催缴通知信息查看操作]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction的PaymentNoticeShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: AccountBalanceList 
	 * @Description: 结余账户信息列表
	 * @author: yangrt
	 * @return String
	 */
	public String AccountBalanceList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="OPP_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","PAID_NO","OPP_TYPE","SUM","OPP_USERNAME","OPP_DATE_START","OPP_DATE_END");
		String OPP_USERNAME = data.getString("OPP_USERNAME","");
		if(!OPP_USERNAME.equals("")){
			data.put("OPP_USERNAME", OPP_USERNAME.toUpperCase());
		}
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.AccountBalanceList(conn,data,pageSize,page,compositor,ordertype);
			String orgid = SessionInfo.getCurUser().getCurOrgan().getId(); 
			Data accountData = handler.getAdoptOrgInfo(conn, orgid);
			data.add("ADOPT_ORG_NAME",accountData.getString("NAME_EN",""));
			data.add("ACCOUNT_CURR",accountData.getString("ACCOUNT_CURR",""));
			data.add("ACCOUNT_LMT",accountData.getString("ACCOUNT_LMT",""));
			
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("searchData",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
			
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "结余账户信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("结余账户信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("FileManagerAction的AccountBalanceList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: AccountBalanceShow 
	 * @Description: 结余账户信息查看
	 * @author: yangrt
	 * @return String 
	 */
	public String AccountBalanceShow(){
		//获取结余账户使用记录ID
		String account_log_id = getParameter("ACCOUNT_LOG_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据缴费信息ID,获取缴费信息Data
			Data data = handler.getAccountBalanceData(conn, account_log_id);
			setAttribute("data", data);
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "缴费单信息查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[缴费单信息查看操作]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction的AccountBalanceShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/************** 缴费信息处理End ***************/
	
	
	/************** 文件办理公共方法类Start ***************/
	
	/**
	 * @Title: FileDelete 
	 * @Description: 删除未登记的文件信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String FileDelete() {
		//1 获取要删除的文件ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		retValue = getParameter("type");	//普通、特需文件标示
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取删除结果
			success = handler.FileDelete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Deleted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件删除操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据删除失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: FileBatchSubmit 
	 * @Description: 批量提交文件信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String FileBatchSubmit() {
		//1 获取要提交的文件ID
		String subuuid = getParameter("subuuid", "");
		String[] uuid = subuuid.split("#");
		retValue = getParameter("type");	//普通、特需文件标示
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			success = handler.FileBatchSubmit(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "批量提交文件操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[提交操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据提交失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * 流水号打印
	 * @author Panfeng
	 * @date 2014-7-24
	 * @return
	 */
	public String seqNoPrint(){
		//1 列表页获取信息ID
		String printuuid = getParameter("printuuid", "");
		String[] uuid = printuuid.split(",");
		String printId = "";
		retValue = getParameter("type");	//普通、特需文件标示
		StringBuffer stringb = new StringBuffer();
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			printId = stringb.substring(0, stringb.length() - 1);
			DataList printShow = handler.getShowData(conn, printId, retValue);
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
	 * @Title: GetFileByID 
	 * @Description: 根据文件id获取文件的详细信息
	 * @author: yangrt;
	 * @param FileID
	 * @return    设定文件 
	 * @return Data    返回类型 
	 * @throws
	 */
	public Data GetFileByID(String FileID){
		Data data = new Data();
		try {
			//1 获取数据库连接
			conn = ConnectionManager.getConnection();
			//2 获取数据结果集Data
			data = handler.GetFileByID(conn,FileID);
			
			/*货币转换（其他货币转换为美元展示）begin*/
			Data currencyData = new Data();
			currencyData.add("CURRENCY", data.getString("CURRENCY",""));
			currencyData.add("MALE_YEAR_INCOME", data.getString("MALE_YEAR_INCOME",""));
			currencyData.add("FEMALE_YEAR_INCOME", data.getString("FEMALE_YEAR_INCOME",""));
			currencyData.add("TOTAL_ASSET", data.getString("TOTAL_ASSET",""));
			currencyData.add("TOTAL_DEBT", data.getString("TOTAL_DEBT",""));
			
			currencyData = new CurrencyConverterAction().USDToOther(conn, currencyData);
			data.add("MALE_YEAR_INCOME", currencyData.getString("MALE_YEAR_INCOME",""));
			data.add("FEMALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("TOTAL_ASSET", currencyData.getString("TOTAL_ASSET",""));
			data.add("TOTAL_DEBT", currencyData.getString("TOTAL_DEBT",""));
			/*货币转换（其他货币转换为美元展示）end*/
			
			String file_type = data.getString("FILE_TYPE","");
			String family_type = data.getString("FAMILY_TYPE","");
			FfsAfTranslationAction action  = new  FfsAfTranslationAction();
			//parents	双亲 singleparent 单亲 stepchild 继子女		 
			String formType = action.getFormType(family_type, file_type);
			String xmlstr = action.getFileUploadParameter(conn,formType);
			data.add("xmlstr", xmlstr);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件详细信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取文件详细信息操作异常:" + e.getMessage(),e);
			}
			
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件详细信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取文件详细信息操作异常:" + e.getMessage(),e);
			}
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction的GetNormalFileByID.Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		
		return data;
	}
	
	/**
	 * @Title: getMKRORGCOAList 
	 * @Description: 获取美国公约认证机构名称
	 * @author: yangrt;
	 * @return    美国公约认证机构名称的代码集
	 * @return CodeList    返回类型 
	 * @throws
	 */
	public CodeList getMKRORGCOAList(){
    	CodeList codelist = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //获取美国公约认证机构信息
            DataList orglist = handler.getMKRORGCOAList(conn);
            //设置美国公约认证机构名称代码集
            for(int i = 0; i < orglist.size(); i++){
            	Code code = new Code();
            	
            	code.setName(orglist.getData(i).getString("NAME"));
            	code.setValue(orglist.getData(i).getString("NAME"));
            	code.setRem(orglist.getData(i).getString("NAME"));
            	codelist.add(code);
            }
            
            //添加"其他"选项
            Code code = new Code();
        	code.setName("Other");
        	code.setValue("Other");
        	code.setRem("Other");
        	codelist.add(code);
            
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("操作异常[美国公约认证机构名称代码集操作]:" + e.getMessage(),e);
            }
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的getMKRORGCOAList。Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
		return codelist;
    }
	
	public String GetAdoptionPersonInfo(){
		//1 获取文件id
		String file_id = getParameter("AF_ID");
		String flag = getParameter("Flag");	//判断中英文显示
		String type = getParameter("type");	//判断是添加，还是修改操作
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据文件id(file_id)获取该文件的详细信息
			Data data = handler.GetFileByID(conn, file_id);
		
			String file_type = data.getString("FILE_TYPE");	//文件类型
			String family_type = data.getString("FAMILY_TYPE");	//收养类型
			//根据文件类型(file_type)、收养类型(family_type)确定返回的页面
			if("33".equals(file_type)){
				retValue = "step" + flag + type;	//返回继子女收养查看页面
			}else{
				if("1".equals(family_type)){
					retValue = "double" + flag + type;	//返回双亲收养查看页面
				}else{
					retValue = "single" + flag + type;	//返回单亲收养查看页面
				}
			}
			setAttribute("data", data);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", file_id));
		}catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[获取文件信息操作]:" + e.getMessage(),e);
            }
            retValue = "error1";
        } finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的GetAdoptionPersonInfo.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/************** 文件办理公共方法类End ***************/
	/**
	 * 获取文件数据
	 * 参数说明：
	 * AF_ID：文件ID
	 * show：显示类别
	 * 				cn 为 翻译信息
	 * 				en 为 原文
	 * oper：操作类别
	 * 				view为显示，不能修改
	 * 				edit为编辑，可修改
	 */
	public String GetFileInfo(){
		
		//1、获取参数
		//1.1文件ID
		String AF_ID = getParameter("AF_ID");
		//1.2显示类别，默认为翻译件
		String show=getParameter("show","cn");
		//1.3操作类别、默认为显示
		String oper=getParameter("oper","view");
		
		//2、根据文件ID获取文件信息
		Data fileData = this.GetFileByID(AF_ID);
		setAttribute("xmlstr", fileData.getString("xmlstr"));
		//2.1设置家调组织列表，如果家调组织名称不在内容中，则显示为Other
		CodeList coaList = this.getMKRORGCOAList();
		String HOMESTUDY_ORG_NAME = fileData.getString("HOMESTUDY_ORG_NAME","");
		String HOMESTUDY_ORG = HOMESTUDY_ORG_NAME;
		if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
			HOMESTUDY_ORG = coaList.getCodeByValue("Other").getValue();
		}
		fileData.put("HOMESTUDY_ORG", HOMESTUDY_ORG);		
		
		FfsAfTranslationAction action  = new  FfsAfTranslationAction();

		//3、根据文件类型、收养类型、显示类别、操作类别，获取页面跳转结果
		//parents	双亲 singleparent 单亲 stepchild 继子女		 
		String formType = action.getFormType(fileData.getString("FAMILY_TYPE"), fileData.getString("FILE_TYPE"));
		retValue = formType + "_" + show +"_" + oper;		
		try {
			conn = ConnectionManager.getConnection();
			String xmlstr = action.getFileUploadParameter(conn,formType);
			setAttribute("xmlstr", xmlstr);
			setAttribute("data", fileData);
			
			//设置美国公约认证机构名称代码集
			HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
	    	cmap.put("ORGCOA_LIST", coaList);
	    	setAttribute(Constants.CODE_LIST, cmap);
			
		} catch (Exception e) {
			//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[获取文件信息操作]:" + e.getMessage(),e);
            }            
            retValue = "error1";
		}finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction的GetAdoptionPersonInfo.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
}
