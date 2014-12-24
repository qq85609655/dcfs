package com.dcfs.rfm.insteadRecord;

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
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: InsteadRecordAction 
 * @Description: 由办公室对退文代录信息进行查询、退文代录、查看、导出操作
 * @author panfeng;
 * @date 2014-9-23 上午9:03:08 
 *
 */
public class InsteadRecordAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(InsteadRecordAction.class);

    private InsteadRecordHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;

    public InsteadRecordAction(){
        this.handler=new InsteadRecordHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: insteadRecordList 
	 * @Description: 退文代录列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String insteadRecordList(){
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
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START",
					"REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","FILE_TYPE","AF_POSITION","APPLE_DATE_START",
					"APPLE_DATE_END","HANDLE_TYPE","DUAL_DATE_START","DUAL_DATE_END","RETURN_STATE");
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
			DataList dl=handler.insteadRecordList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "退文代录信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("退文代录信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("InsteadRecordAction的insteadRecordList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: returnChoiceList 
	 * @Description: 退文代录选择文件列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String returnChoiceList(){
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
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
					"FILE_TYPE","AF_POSITION","AF_GLOBAL_STATE","MATCH_STATE","COUNTRY_CODE","ADOPT_ORG_ID");
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.returnChoiceList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "退文代录选择文件查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("退文代录选择文件查询操作异常:" + e.getMessage(),e);
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
						log.logError("InsteadRecordAction的returnChoiceList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * 跳转到退文代录确认页面
	 * @author Panfeng
	 * @date 2014-9-23 
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
			
			//获取收养组织名称
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, showdata.getString("ADOPT_ORG_ID",""));
            String  syzzCnName = syzzDept.getSyzzCnName();//收养组织中文名称
            showdata.add("NAME_CN", syzzCnName);
			
            //获取当前操作信息
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			showdata.add("APPLE_TYPE","");//退文类型
			showdata.add("HANDLE_TYPE","");//退文处置方式
			showdata.add("RETURN_REASON","");//退文原因
			showdata.add("APPLE_PERSON_ID",curId);//申请（代录）人ID
			showdata.add("APPLE_PERSON_NAME",curPerson);//申请（代录）人
			showdata.add("APPLE_DATE",curDate);//申请（代录）日期
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
	 * @Title: insteadRecordSave 
	 * @Description: 退文代录确认提交
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String insteadRecordSave(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","AR_ID","AF_ID","FILE_NO","REGISTER_DATE","FILE_TYPE",
        			"COUNTRY_CODE","ADOPT_ORG_ID","FAMILY_TYPE","MALE_NAME","FEMALE_NAME",
        			"APPLE_PERSON_ID","APPLE_PERSON_NAME","APPLE_DATE","APPLE_TYPE","HANDLE_TYPE","RETURN_REASON");
        Data fileData = getRequestEntityData("P_","AF_POSITION");
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            fileData.add("AF_ID", (String)data.get("AF_ID"));
            fileData.add("RETURN_REASON", (String)data.get("RETURN_REASON"));//退文原因
            //根据文件位置是否在办公室决定退文状态
            String af_position = (String)fileData.get("AF_POSITION");
            if("0020".equals(af_position)){
            	fileData.add("RETURN_STATE", "1");//退文状态为"已确认"(文件信息表)
            	data.add("RETURN_STATE","1");//退文状态为"已确认"（退文记录表）
            	String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();//获取当前部门
            	data.add("ORG_ID", curOrgId);//确认部门ID
            	data.add("PERSON_ID", (String)data.get("APPLE_PERSON_ID"));//确认人ID
            	data.add("PERSON_NAME", (String)data.get("APPLE_PERSON_NAME"));//确认人
            	data.add("RETREAT_DATE", (String)data.get("APPLE_DATE"));//确认时间
            	//初始化退文移交记录（办公室-档案部）
            	FileCommonManager fileCommonManager = new FileCommonManager();
            	DataList tranferDataList = new DataList();
            	Data tranferData = new Data();
            	tranferData.add("APP_ID", (String)data.get("AF_ID"));
            	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_BGS_DAB);
            	tranferData.add("TRANSFER_STATE", "0");
            	tranferDataList.add(tranferData);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);//初始化退文移交记录
            }else{
            	fileData.add("RETURN_STATE", "0");//退文状态为"待确认"(文件信息表)
            	data.add("RETURN_STATE","0");//退文状态为"待确认"（退文记录表）
            }
            
            success=handler.ReturnFileSave(conn,data,fileData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");//提交成功 0
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
                        log.logError("InsteadRecordAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * 查看退文详细信息
	 * @author Panfeng
	 * @date 2014-9-23 
	 * @return
	 */
	public String showReturnFile(){
		//1 获取页面代进的ID
		String uuid = getParameter("showuuid","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = handler.confirmShow(conn, uuid);
			//获取收养组织名称
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, showdata.getString("ADOPT_ORG_ID",""));
            String  syzzCnName = syzzDept.getSyzzCnName();//收养组织中文名称
            showdata.add("NAME_CN", syzzCnName);
			
			//4 变量代入查看页面
			setAttribute("showdata", showdata);
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
	
	
}
