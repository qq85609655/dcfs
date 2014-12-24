/**   
 * @Title: ReceiveConfirmAction.java 
 * @Package com.dcfs.fam.receiveConfirm 
 * @Description: 费用管理-到账确认
 * @author yangrt   
 * @date 2014-10-21 下午9:00:37 
 * @version V1.0   
 */
package com.dcfs.fam.receiveConfirm;

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
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: ReceiveConfirmAction 
 * @Description: 费用管理-到账确认
 * @author yangrt
 * @date 2014-10-21 下午9:00:37 
 *  
 */
public class ReceiveConfirmAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(ReceiveConfirmAction.class);

    private ReceiveConfirmHandler handler;
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
	
	public ReceiveConfirmAction(){
		this.handler = new ReceiveConfirmHandler();
	}
	
	/**
	 * @Title: ReceiveConfirmList 
	 * @Description: 到账确认查询列表
	 * @author: yangrt
	 * @return String  
	 */
	public String ReceiveConfirmList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="ARRIVE_STATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","PAID_NO","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_WAY",
					"PAID_SHOULD_NUM","PAR_VALUE","FILE_NO","RECEIVE_DATE_START","RECEIVE_DATE_END",
					"ARRIVE_STATE","ARRIVE_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_ACCOUNT_VALUE","ACCOUNT_CURR");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.ReceiveConfirmList(conn,data,pageSize,page,compositor,ordertype);
			for(int i = 0; i < dl.size(); i++){
				Data tempdata = dl.getData(i);
				String file_no = tempdata.getString("FILE_NO","");
				if(file_no.contains(",")){
					tempdata.add("FILE_NO", "Multiple");
				}
			}
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "到账确认查询列表操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[到账确认查询列表]:" + e.getMessage(),e);
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
						log.logError("ReceiveConfirmAction的ReceiveConfirmList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: ReceiveConfirmShow 
	 * @Description: 到账确认添加/查看操作
	 * @author: yangrt
	 * @return String 
	 */
	public String ReceiveConfirmShow(){
		String type = getParameter("type");		//判断当前操作是添加还是查看，查看：show,添加：add
		retValue = type;
		//获取票据登记id
		String CHEQUE_ID = getParameter("CHEQUE_ID");
		String orgId = getParameter("ORG_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据票据登记id,获取票据信息Data
			Data data = handler.getFamChequeInfoById(conn, CHEQUE_ID);
			//获取收养组织余额账户信息
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgId);
			data.add("ACCOUNT_LMT", syzzinfo.getAccountLmt());	//余额账户_限额
			data.add("ACCOUNT_CURR", syzzinfo.getAccountCurr());	//余额账户_当前额度
			data.add("ORG_ID", orgId);
			
			String file_no = data.getString("FILE_NO","");	//文件编号
			DataList fileList = new DataList();
			Data filedata = new Data();
			if(file_no.contains(",")){
				String[] fileNo = file_no.split(",");
				for(int i=0; i<fileNo.length; i++){
					filedata = new FileCommonManager().getCommonFileInfo(fileNo[i], conn);
					String ci_id = filedata.getString("CI_ID","");
					//获取文件关联的儿童信息
					DataList cdataList = new FileManagerHandler().getChildDataList(conn, ci_id);
					for(int j=0; j<cdataList.size(); j++){
						Data cdata = cdataList.getData(j);
						if(cdata.getString("IS_MAIN").equals("1")){
							filedata.add("NAME", cdata.getString("NAME"));
						}
					}
					fileList.add(filedata);
				}
			}else{
				filedata = new FileCommonManager().getCommonFileInfo(file_no, conn);
				String ci_id = filedata.getString("CI_ID","");
				//获取文件关联的儿童信息
				DataList cdataList = new FileManagerHandler().getChildDataList(conn, ci_id);
				for(int j=0; j<cdataList.size(); j++){
					Data cdata = cdataList.getData(j);
					if(cdata.getString("IS_MAIN").equals("1")){
						filedata.add("NAME", cdata.getString("NAME"));
					}
				}
				fileList.add(filedata);
			}
			setAttribute("data", data);
			setAttribute("List", fileList);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "到账确认添加/查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[到账确认添加/查看]:" + e.getMessage(),e);
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
                        log.logError("ReceiveConfirmAction的ReceiveConfirmAdd.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
		
	}
	
	public String ReceiveConfirmSave(){
		//1 获得页面表单数据，构造数据结果集
		//票据信息
		Data pjdata = getRequestEntityData("R_","CHEQUE_ID","ADOPT_ORG_ID","FILE_NO","ARRIVE_STATE","ARRIVE_DATE","ARRIVE_VALUE","ARRIVE_REMARKS","ARRIVE_ACCOUNT_VALUE");
		//收养组织余额账户信息
		Data zhdata = getRequestEntityData("P_","ORG_ID","ACCOUNT_CURR");
		zhdata.add("ADOPT_ORG_ID", zhdata.getString("ORG_ID"));
		zhdata.remove("ORG_ID");
		
		//当前登录人信息
		UserInfo userinfo = SessionInfo.getCurUser();
		String personId = userinfo.getPersonId();
		String personName = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		//余额账户使用记录
		Data sydata = getRequestEntityData("L_","COUNTRY_CODE","PAID_NO","BILL_NO","OPP_TYPE","SUM","REMARKS");
		sydata.add("ADOPT_ORG_ID", pjdata.getString("ADOPT_ORG_ID"));
		sydata.add("CHEQUE_ID", pjdata.getString("CHEQUE_ID"));
		sydata.add("OPP_USERID", personId);
		sydata.add("OPP_USERNAME", personName);
		sydata.add("OPP_DATE", curDate);

		try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.ReceiveConfirmSave(conn,pjdata,zhdata,sydata);
            dt.commit();
            if(success){
                InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "到账确认信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[到账确认信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "到账确认信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("到账确认保存操作异常:" + e.getMessage(),e);
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
                        log.logError("ReceiveConfirmAction的ReceiveConfirmSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
		
	}
	
	/**
	 * @Title: ReviseAccountAdd 
	 * @Description: 调账添加操作
	 * @author: yangrt
	 * @return String 
	 */
	public String ReviseAccountAdd(){
		//获取票据登记id
		String CHEQUE_ID = getParameter("CHEQUE_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据票据登记id,获取票据信息Data
			Data data = handler.getFamChequeInfoById(conn, CHEQUE_ID);
			double arrive_value = Double.parseDouble(data.getString("ARRIVE_VALUE"));	//到账金额
			double should_value = Double.parseDouble(data.getString("PAID_SHOULD_NUM"));	//应缴金额
			String arrive_account = data.getString("ARRIVE_ACCOUNT_VALUE","");	//结余账户使用金额
			double used_value =	0;
			if(!"".equals(arrive_account)){
				used_value = Double.parseDouble(arrive_account);
			}
			data.add("BALANCE_VALUE", should_value - arrive_value - used_value);	//完费差额
			//获取收养组织余额账户信息
			String orgid = data.getString("ADOPT_ORG_ID");		//收养组织code		
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			data.add("ACCOUNT_LMT", syzzinfo.getAccountLmt());	//余额账户_限额
			data.add("ACCOUNT_CURR", syzzinfo.getAccountCurr());	//余额账户_当前额度
			
			data.remove("REMARKS");
			
			setAttribute("data", data);
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "调账添加操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[调账添加]:" + e.getMessage(),e);
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
                        log.logError("ReceiveConfirmAction的ReviseAccountAdd.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ReviseAccountSave 
	 * @Description: 调账信息保存操作
	 * @author: yangrt
	 * @return String 
	 */
	public String ReviseAccountSave(){
		//1 获得页面表单数据，构造数据结果集
		//票据信息
		Data pjdata = getRequestEntityData("R_","CHEQUE_ID","ADOPT_ORG_ID","FILE_NO","ARRIVE_STATE","ARRIVE_ACCOUNT_VALUE");
		//收养组织余额账户信息
		Data zhdata = getRequestEntityData("P_","ACCOUNT_CURR");
		zhdata.add("ADOPT_ORG_ID", pjdata.getString("ADOPT_ORG_ID"));
		
		//当前登录人信息
		UserInfo userinfo = SessionInfo.getCurUser();
		String personId = userinfo.getPersonId();
		String personName = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		//余额账户使用记录
		Data sydata = getRequestEntityData("L_","COUNTRY_CODE","PAID_NO","BILL_NO","OPP_TYPE","SUM","REMARKS");
		sydata.add("ADOPT_ORG_ID", pjdata.getString("ADOPT_ORG_ID"));
		sydata.add("CHEQUE_ID", pjdata.getString("CHEQUE_ID"));
		sydata.add("OPP_USERID", personId);
		sydata.add("OPP_USERNAME", personName);
		sydata.add("OPP_DATE", curDate);
		
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.ReceiveConfirmSave(conn,pjdata,zhdata,sydata);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "调账信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[调账信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "调账信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("调账保存操作异常:" + e.getMessage(),e);
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
                        log.logError("ReceiveConfirmAction的ReviseAccountSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}

}
