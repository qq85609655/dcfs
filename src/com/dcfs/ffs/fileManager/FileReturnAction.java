package com.dcfs.ffs.fileManager;

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

import com.dcfs.common.DcfsConstants;
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: FileReturnAction 
 * @Description: 由收养组织对文件信息进行查询、退文申请、导出操作
 * @author panfeng;
 * @date 2014-9-2 下午3:01:44 
 *
 */
public class FileReturnAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(FileReturnAction.class);

    private FileReturnHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;

    public FileReturnAction(){
        this.handler=new FileReturnHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: ReturnFileList 
	 * @Description: 退文信息列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String ReturnFileList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="APPLE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","APPLE_DATE_START","APPLE_DATE_END","FILE_TYPE","DUAL_USERNAME","DUAL_DATE_START","DUAL_DATE_END","RETURN_STATE","HANDLE_TYPE");
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
			DataList dl=handler.ReturnFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "退文信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("退文信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("FileReturnAction的ReturnFileList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: ReturnApplyList 
	 * @Description: 退文申请列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String ReturnApplyList(){
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
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","MALE_NAME","FEMALE_NAME","FILE_TYPE","PAUSE_DATE_START","PAUSE_DATE_END","RECOVERY_STATE");
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
			DataList dl=handler.ReturnApplyList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "退文申请查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("退文申请查询操作异常:" + e.getMessage(),e);
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
						log.logError("FileReturnAction的ReturnApplyList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * 跳转到退文申请确认页面
	 * @author Panfeng
	 * @date 2014-9-2 
	 * @return
	 */
	public String confirmShow(){
		//1 获取页面代进的ID
		String uuid = getParameter("showuuid","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = handler.confirmShow(conn, uuid);
			
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDateTime();
			showdata.add("HANDLE_TYPE","");
			showdata.add("RETURN_REASON","");
			showdata.add("APPLE_PERSON_ID",curId);//申请人ID
			showdata.add("APPLE_PERSON_NAME",curPerson);//申请人
			showdata.add("APPLE_DATE",curDate);//申请日期
			//4 变量代入查看页面
			setAttribute("confirmData", showdata);
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
	 * @Title: ReturnFileSave 
	 * @Description: 退文申请确认提交
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String ReturnFileSave(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","AR_ID","AF_ID","FILE_NO","REGISTER_DATE","FILE_TYPE",
        			"COUNTRY_CODE","ADOPT_ORG_ID","FAMILY_TYPE","MALE_NAME","FEMALE_NAME",
        			"APPLE_PERSON_ID","APPLE_PERSON_NAME","APPLE_DATE","HANDLE_TYPE","RETURN_REASON");
        Data fileData = new Data();
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            fileData.add("AF_ID", (String)data.get("AF_ID"));
            fileData.add("RETURN_REASON", (String)data.get("RETURN_REASON"));//退文原因
            fileData.add("RETURN_STATE", "0");//退文状态为"待确认"(文件信息表)
            data.add("RETURN_STATE","0");//退文状态为"待确认"（退文记录表）
            data.add("APPLE_TYPE","1");//退文类型为"机构申请退出收养"（退文记录表）
            success=handler.ReturnFileSave(conn,data,fileData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");//提交成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "提交操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("提交操作异常[提交操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");//保存失败 2
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
                        log.logError("FileReturnAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	
	/**
	 * @Title: ReturnFileExport 
	 * @Description: 退文信息导出操作
	 * @author: panfeng
	 * @return String null
	 * @throws
	 */
//	public String ReturnFileExport(){
//		//1  获取页面搜索字段数据
//		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","APPLE_DATE_START","APPLE_DATE_END","FILE_TYPE","DUAL_USERNAME","DUAL_DATE_START","DUAL_DATE_END","RETURN_STATE","HANDLE_TYPE");
//		String MALE_NAME = data.getString("MALE_NAME",null);	//男收养人
//		if(MALE_NAME != null){
//			MALE_NAME = MALE_NAME.toUpperCase();
//		}
//		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//女收养人
//		if(FEMALE_NAME != null){
//			FEMALE_NAME = FEMALE_NAME.toUpperCase();
//		}
//		String FILE_NO = data.getString("FILE_NO", null);	//收文编号
//		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//收文开始日期
//		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//收文结束日期
//		String APPLE_DATE_START = data.getString("APPLE_DATE_START", null);	//申请开始日期
//		String APPLE_DATE_END = data.getString("APPLE_DATE_END", null);	//申请结束日期
//		String FILE_TYPE = data.getString("FILE_TYPE", null);	//文件类型
//		String DUAL_USERNAME = data.getString("DUAL_USERNAME", null);	//处置人
//		String DUAL_DATE_START = data.getString("DUAL_DATE_START", null);	//处置起始日期
//		String DUAL_DATE_END = data.getString("DUAL_DATE_END", null);	//处置截止日期
//		String RETURN_STATE = data.getString("RETURN_STATE", null);	//退文状态
//		String HANDLE_TYPE = data.getString("HANDLE_TYPE", null);	//退文处置方式
//		
//		try {
//			//2设置导出文件参数
//			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("退文信息.xls".getBytes(), "iso8859-1"));
//    		this.getResponse().setContentType("application/xls");
//    		//3处理代码字段 
//    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
//			Map<String, CodeList> codes = UtilCode.getCodeLists("WJLX","TWCZFS_SYZZ");
//    		//文件类型代码
//			CodeList scList=codes.get("WJLX");
//    		Map<String,String> filetype=new HashMap<String,String>();
//    		for(int i=0;i<scList.size();i++){
//    			Code c=scList.get(i);
//    			filetype.put(c.getValue(),c.getName());
//    		}
//    		dict.put("FILE_TYPE", filetype);
//    		//退文处置方式代码
//    		CodeList czList=codes.get("TWCZFS_SYZZ");
//    		Map<String,String> handletype=new HashMap<String,String>();
//    		for(int i=0;i<czList.size();i++){
//    			Code c=czList.get(i);
//    			handletype.put(c.getValue(),c.getName());
//    		}
//    		dict.put("HANDLE_TYPE", handletype);
//    		//退文状态代码
//			Map<String,String> state = new HashMap<String,String>();
//			state.put("0", "待确认");
//			state.put("1", "已确认");
//    		//4 执行文件导出
//			ExcelExporter.export2Stream("退文信息", "SuppleFile", dict, this.getResponse().getOutputStream(),
//					MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, APPLE_DATE_START, APPLE_DATE_END, FILE_TYPE, DUAL_USERNAME, DUAL_DATE_START, DUAL_DATE_END, RETURN_STATE, HANDLE_TYPE);
//			this.getResponse().getOutputStream().flush();
//		} catch (Exception e) {
//			//5  设置异常处理
//			log.logError("导出退文信息出现异常", e);
//			setAttribute(Constants.ERROR_MSG_TITLE, "导出退文信息出现异常");
//			setAttribute(Constants.ERROR_MSG, e);
//		}
//		//6 页面不进行跳转，返回NULL 如需跳转，返回其他值
//		return null;
//	}
	
}
