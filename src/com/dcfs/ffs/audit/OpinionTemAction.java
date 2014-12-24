/**   
 * @Title: OpinionTemAction.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(用一句话描述该文件做什么) 
 * @author panfeng   
 * @date 2014-8-13 下午2:47:21 
 * @version V1.0   
 */
package com.dcfs.ffs.audit;

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
 * @ClassName: OpinionTemAction 
 * @Description: 审核意见模板Action 
 * @author panfeng 
 * @date 2014-8-13
 *  
 */
public class OpinionTemAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(OpinionTemAction.class);

    private OpinionTemHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;
    
    public OpinionTemAction(){
        this.handler=new OpinionTemHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
     * 保存审核意见模板
	 * @author panfeng
	 * @date 2014-8-13
     * @return
     */
    public String saveOpinionTem(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("P_","AAM_ID","AUDIT_MODEL_CONTENT");
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            success=handler.saveOpinionTem(conn,data);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "保存成功!");//保存成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
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
                        log.logError("OpinionTemAction的Connection因出现异常，未能关闭",e);
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
	 * @Description: 审核意见模板列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String findListTem(){
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
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findListTem(conn,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
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
						log.logError("OpinionTemAction的findList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * 查看
	 * @author panfeng
	 * @date 2014-8-13
	 * @return
	 */
	public String showOpinionTem(){
		//1 获取代入变量
		String AAM_ID = getParameter("AAM_ID","");
		String type = getParameter("type");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取查看信息结果集
			Data showdata = handler.showOpinionTem(conn, AAM_ID);
			//4 变量代入查看页面
			setAttribute("shmbData", showdata);
			setAttribute("audit_type", showdata.getString("AUDIT_TYPE", ""));
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
		} else if ("mod".equals(type)) {
			return "mod";
		} else {
			return SUCCESS;
		}
	}
	
	
}
