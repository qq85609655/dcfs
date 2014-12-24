package com.dcfs.fam.completeCost;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;

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

import com.hx.framework.authenticate.SessionInfo;

/** 
 * @ClassName: CompleteCostAction 
 * @Description: 财务部对文件完费列表查询、完费维护操作 
 * @author panfeng 
 * @date 2014-10-22
 *  
 */
public class CompleteCostAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(CompleteCostAction.class);

    private CompleteCostHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;
    
    public CompleteCostAction(){
        this.handler=new CompleteCostHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
	 * @Title: completeCostList 
	 * @Description: 文件完费管理列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String completeCostList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
				"COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","NAME","AF_COST",
				"PAID_NO","AF_COST_CLEAR","AF_COST_CLEAR_FLAG");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.completeCostList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件完费查询操作异常");
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
						log.logError("Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * 跳转到完费维护页面
	 * @author Panfeng
	 * @date 2014-10-22
	 * @return
	 */
	public String completeCostShow(){
		//1 列表页获取信息ID
		String type = getParameter("type");
		String showuuid = getParameter("showuuid", "");
		String fileno = getParameter("fileno","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取查看信息结果集
			Data showdata = handler.getCostShow(conn, showuuid, fileno);
			//获取操作人基本信息及系统日期
			if("maintain".equals(type)){
				String curId = SessionInfo.getCurUser().getPerson().getPersonId();
				String curPerson = SessionInfo.getCurUser().getPerson().getCName();
				String curDate = DateUtility.getCurrentDate();
				showdata.add("AF_COST_CLEAR_USERID", curId);//操作人id
				showdata.add("AF_COST_CLEAR_USERNAME", curPerson);//操作人
				showdata.add("AF_COST_CLEAR_DATE", curDate);//操作日期
			}
			//4 变量代入查看页面
			setAttribute("data", showdata);
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
		if ("show".equals(type)) {
			return "show";
		} else if ("maintain".equals(type)) {
			return "maintain";
		} else {
			return SUCCESS;
		}
	}
	
	/**
	 * 查看缴费单
	 * @author panfeng
	 * @date 2014-12-10
	 * @return
	 */
	public String billShow(){
		//1 获取代入变量
		String PAID_NO = getParameter("PAID_NO","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取查看信息结果集
			Data showdata = handler.getBillShow(conn, PAID_NO);
			//4 变量代入查看页面
			setAttribute("data", showdata);
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
	 * @Title: completeCostSave
	 * @Description:完费维护提交
	 * @author panfeng
	 * @date 2014-10-22
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String completeCostSave(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("P_","AF_ID","AF_COST_CLEAR_REASON","AF_COST_CLEAR_USERNAME","AF_COST_CLEAR_DATE");
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            data.add("AF_COST_CLEAR", "1");//完费状态变为"已完费"
            data.add("AF_COST_CLEAR_FLAG", "1");//维护标识变为"是"
            success=handler.completeCostSave(conn,data);
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
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");//提交失败 2
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	
	
}
