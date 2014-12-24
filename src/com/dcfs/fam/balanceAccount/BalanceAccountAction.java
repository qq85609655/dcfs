/**   
 * @Title: BalanceAccountAction.java 
 * @Package com.dcfs.fam.balanceAccount 
 * @Description: 收养组织结余账户管理
 * @author yangrt   
 * @date 2014-10-23 下午3:45:22 
 * @version V1.0   
 */
package com.dcfs.fam.balanceAccount;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.hx.framework.authenticate.SessionInfo;

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

/** 
 * @ClassName: BalanceAccountAction 
 * @Description: 收养组织结余账户管理
 * @author yangrt;
 * @date 2014-10-23 下午3:45:22 
 *  
 */
public class BalanceAccountAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(BalanceAccountAction.class);
	
	private BalanceAccountHandler handler;
	private Connection conn = null;//数据库连接
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;

	/* (非 Javadoc) 
	 * <p>Title: execute</p> 
	 * <p>Description: </p> 
	 * @return
	 * @throws Exception 
	 * @see hx.common.j2ee.BaseAction#execute() 
	 */
	@Override
	public String execute() throws Exception {
		return null;
	}
	
	public BalanceAccountAction(){
		this.handler = new BalanceAccountHandler();
	}
	
	/**
	 * @Title: BalanceAccountList 
	 * @Description: 收养组织结余账户查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String BalanceAccountList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="COUNTRY_CODE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NO","ACCOUNT_CURR","ACCOUNT_LMT");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.BalanceAccountList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "收养组织结余账户查询列表操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[收养组织结余账户查询列表]:" + e.getMessage(),e);
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
						log.logError("BalanceAccountAction的BalanceAccountList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: BalanceAccountAdd 
	 * @Description: 收养组织结余账户维护添加操作
	 * @author: yangrt
	 * @return String  
	 */
	public String BalanceAccountAdd(){
		//获取收养组织code
		String ADOPT_ORG_ID = getParameter("ADOPT_ORG_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据票据登记id,获取票据信息Data
			Data data = new Data();
			//获取收养组织余额账户信息
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, ADOPT_ORG_ID);
			data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);
			data.add("NAME_CN", syzzinfo.getSyzzCnName());
			data.add("COUNTRY_NAME", syzzinfo.getCountryCnName());
			data.add("ACCOUNT_LMT", syzzinfo.getAccountLmt());	//余额账户_限额
			data.add("ACCOUNT_CURR", syzzinfo.getAccountCurr());	//余额账户_当前额度
			data.add("MODIFYUSER_NAME", SessionInfo.getCurUser().getPerson().getCName());
			data.add("ACCOUNT_MODIFYUSER", SessionInfo.getCurUser().getPersonId());
			data.add("ACCOUNT_MODIFYDATE", DateUtility.getCurrentDateTime());
			
			setAttribute("data", data);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "收养组织结余账户维护添加操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[收养组织结余账户维护添加]:" + e.getMessage(),e);
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
                        log.logError("BalanceAccountAction的BalanceAccountAdd.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: BalanceAccountSave 
	 * @Description: 收养组织结余账户信息保存
	 * @author: yangrt
	 * @return String 
	 */
	public String BalanceAccountSave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","ADOPT_ORG_ID","ACCOUNT_LMT","ACCOUNT_MODIFYUSER","ACCOUNT_MODIFYDATE");
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.BalanceAccountSave(conn,data);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "收养组织结余账户信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[收养组织结余账户信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "收养组织结余账户信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("收养组织结余账户信息保存操作异常:" + e.getMessage(),e);
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
                        log.logError("BalanceAccountAction的BalanceAccountSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: BalanceAccountDetailList 
	 * @Description: 收养组织结余账户明细列表
	 * @author: yangrt
	 * @return String 
	 */
	public String BalanceAccountDetailList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
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
			ordertype="ASC";
		}
		
		Data data = new Data();
		String type = getParameter("type","");
		if(!"false".equals(type)){
			data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","ADOPT_ORG_NAME","OPP_DATE_START","OPP_DATE_END");
		}
		
		try {
			conn = ConnectionManager.getConnection();
			//根据票据登记id,获取票据信息Data
			DataList dl = handler.BalanceAccountDetailList(conn, data, pageSize, page, compositor, ordertype);
			setAttribute("data", data);
			setAttribute("List", dl);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "收养组织结余账户明细列表操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[收养组织结余账户明细列表]:" + e.getMessage(),e);
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
                        log.logError("BalanceAccountAction的BalanceAccountDetailList.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
}
