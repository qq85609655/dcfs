package com.dcfs.sce.overageRemind;

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
import hx.util.InfoClueTo;

import java.sql.Connection;
import java.sql.SQLException;


/** 
 * @ClassName: OverageRemindAction 
 * @Description: 安置部查询、查看、超龄提醒设置、超龄自动退材料操作 
 * @author panfeng 
 * @date 2014-9-16
 *  
 */
public class OverageRemindAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(OverageRemindAction.class);

    private OverageRemindHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;
    
    public OverageRemindAction(){
        this.handler=new OverageRemindHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * @Title: overageRemindList 
	 * @Description: 儿童超期提醒列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String overageRemindList(){
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		//3 获取查询条件数据
		Data data = getRequestEntityData("S_","PROVINCE_ID","NAME","SEX","BIRTHDAY_START",
					"BIRTHDAY_END","CHILD_TYPE","SN_TYPE","DISEASE_CN","AUD_STATE","PUB_STATE");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.overageRemindList(conn,data,pageSize,page,compositor,ordertype);
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
						log.logError("Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * 
	 * @Title: showChildInfo
	 * @Description: 显示儿童信息
	 * @author: panfeng
	 * @date: 2014-9-16
	 * @return
	 */
	public String showChildInfo(){
	    String CIids = getParameter("CIids");//儿童ID，有同胞的多个ID
	    String[] CIidArry = CIids.split(",");
	    try {
	        //获取数据库连接
            conn = ConnectionManager.getConnection();
            String ids = "";
            for(int i=0;i<CIidArry.length;i++){
                String CIid = CIidArry[i];
                if(i==0){
                    ids = "'" + CIid + "'";
                }else{
                    ids = ids + ",'" + CIid + "'";
                }
            }
            //获取数据DataList
            DataList CIdls=handler.getChildrenData(conn,ids);
            //将结果集写入页面接收变量
            setAttribute("CIdls",CIdls);
	    }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * 
	 * @Title: showTwinsInfo
	 * @Description: 查看儿童同胞信息
	 * @author: panfeng
	 * @date: 2014-9-16
	 * @return
	 */
	public String showTwinsInfo(){
	    String CIids = getParameter("CIids");//儿童同胞ID，或多个ID
        String[] CIidArry = CIids.split(",");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            String ids = "";
            for(int i=0;i<CIidArry.length;i++){
                String CIid = CIidArry[i];
                if(i==0){
                    ids = "'" + CIid + "'";
                }else{
                    ids = ids + ",'" + CIid + "'";
                }
            }
            //获取数据DataList
            DataList CIdls=handler.getChildrenData(conn,ids);
            //将结果集写入页面接收变量
            setAttribute("CIdls",CIdls);
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
	
	/**
	 * @Title: changeRemindMark 
	 * @Description: 根据定时器自动扫描，如满足超龄提醒限制（提前1年）的儿童，改变超龄提醒标识为"1"（超龄提醒）
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String changeRemindMark(){
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 获取提交后更新数据结果
			
			//TODO:统一调用定时器方法
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	// 关闭数据库
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
	 * @Title: changeOverageMark 
	 * @Description: 根据定时器自动扫描，如满足超龄限制的儿童，改变超龄提醒标识为"2"（已超龄）
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String changeOverageMark(){
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 获取提交后更新数据结果
			
			//TODO:统一调用定时器方法
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	// 关闭数据库
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
	
}
