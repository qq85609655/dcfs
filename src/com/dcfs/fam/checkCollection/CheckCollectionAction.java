package com.dcfs.fam.checkCollection;

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
 * @ClassName: CheckCollectionAction 
 * @Description: 财务部支票托收办理操作，包括查询、支票托收、打印托收单、导出、托收单查询操作 
 * @author panfeng 
 * @date 2014-10-20
 *  
 */
public class CheckCollectionAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(CheckCollectionAction.class);

    private CheckCollectionHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;
    
    public CheckCollectionAction(){
        this.handler=new CheckCollectionHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
	 * @Title: checkCollectionList 
	 * @Description: 支票托收列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String checkCollectionList(){
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
		Data data = getRequestEntityData("S_","PAID_NO","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_WAY",
					"PAID_SHOULD_NUM","PAR_VALUE","RECEIVE_DATE_START","RECEIVE_DATE_END",
					"COLLECTION_DATE_START","COLLECTION_DATE_END","COLLECTION_USERNAME","COLLECTION_STATE");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.checkCollectionList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "支票托收查询操作异常");
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
	 * 跳转到支票托收页面
	 * @author Panfeng
	 * @date 2014-10-20
	 * @return
	 */
	public String checkCollectionShow(){
		//1 列表页获取信息ID
		String checkuuid = getParameter("checkuuid", "");
		String num = getParameter("num", "");
		String[] uuid = checkuuid.split(",");
		String checkId = "";
		StringBuffer stringb = new StringBuffer();
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			checkId = stringb.substring(0, stringb.length() - 1);
			DataList checkList = handler.getCollectionShow(conn, checkId);
			
			//4 变量代入页面
			//获取票面金额合计数
			Data showdata = handler.getSum(conn, checkId);
			//获取操作人基本信息及系统日期
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			showdata.add("COLLECTION_USERNAME", curPerson);//托收人
			showdata.add("COLLECTION_DATE", curDate);//托收日期
			showdata.add("NUM", num);//支票数量
			
			setAttribute("data", showdata);
			setAttribute("List", checkList);
			setAttribute("CHEQUE_ID", checkuuid);
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
	 * @Title: checkCollectionSave
	 * @Description:支票托收提交
	 * @author panfeng
	 * @date 2014-10-21
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String checkCollectionSave(){
	    //1 获得页面表单数据，构造数据结果集
		//托收单记录信息
        Data data = getRequestEntityData("R_","COLLECTION_USERNAME","COLLECTION_DATE","NUM","SUM");
        //票据登记信息
        String[] CHEQUE_ID = this.getParameterValues("P_CHEQUE_ID");
 		String[] COLLECTION_REMARKS = this.getParameterValues("P_COLLECTION_REMARKS");
 		
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            
            Data coldata = new Data();
            coldata.add("COL_USERNAME", (String)data.get("COLLECTION_USERNAME"));//托收人
            coldata.add("COL_DATE", (String)data.get("COLLECTION_DATE"));//托收日期
            coldata.add("NUM", (String)data.get("NUM"));//支票数量
            coldata.add("SUM", (String)data.get("SUM"));//托收单总金额
            coldata=handler.checkInfoSave(conn,coldata);//保存托收单记录表
            
            for (int i = 0; i < CHEQUE_ID.length; i++) {
            	Data checkData = new Data();
            	checkData.add("CHEQUE_ID", CHEQUE_ID[i]);
            	checkData.add("CHEQUE_COL_ID", coldata.getString("CHEQUE_COL_ID"));//托收单主键
            	checkData.add("COLLECTION_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//托收人ID
            	checkData.add("COLLECTION_USERNAME", (String)data.get("COLLECTION_USERNAME"));//托收人
            	checkData.add("COLLECTION_DATE", (String)data.get("COLLECTION_DATE"));//托收日期
            	checkData.add("COLLECTION_REMARKS", COLLECTION_REMARKS[i]);//托收备注
            	checkData.add("COLLECTION_STATE", "1");//托收状态为"已托收"
            	success=handler.checkCollectionSave(conn,checkData);//保存票据信息表
            }
            
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
                log.logError("操作异常[处置操作]:" + e.getMessage(),e);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * @Title: checkCollectionList 
	 * @Description: 支票托收列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String colSearchList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="COL_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","COL_DATE_START","COL_DATE_END","COL_USERNAME","SUM_MIN","SUM_MAX","NUM");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.colSearchList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "支票托收查询操作异常");
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
	 * 托收单打印页面
	 * @author Panfeng
	 * @date 2014-10-22
	 * @return
	 */
	public String checkCollectionPrint(){
		//1 列表页获取信息ID
		String coluuid = getParameter("coluuid", "");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			DataList colPrintList = handler.getPrintShow(conn, coluuid);
			//获取托收单记录
			Data showdata = handler.getColShow(conn, coluuid);
			//4 变量代入页面
			setAttribute("data", showdata);
			setAttribute("List", colPrintList);
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
