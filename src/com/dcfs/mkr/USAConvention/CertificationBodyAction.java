/**   
 * @Title: CertificationBodyAction.java 
 * @Package com.dcfs.ffs.audit 
 * @Description: TODO(审核部对美国公约认证信息进行创建、修改、删除、失效操作) 
 * @author panfeng   
 * @date 2014-8-20 下午5:27:31 
 * @version V1.0   
 */
package com.dcfs.mkr.USAConvention;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;
import com.hx.framework.authenticate.SessionInfo;

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


/** 
 * @ClassName: CertificationBodyAction 
 * @Description: 美国公约认证机构Action 
 * @author panfeng 
 * @date 2014-8-20
 *  
 */
public class CertificationBodyAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(CertificationBodyAction.class);

    private CertificationBodyHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;
    
    public CertificationBodyAction(){
        this.handler=new CertificationBodyHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * 跳转到机构创建页面
	 * @author panfeng
	 * @date 2014-8-20
	 * @return
	 */
	public String toBodyAdd(){
		
		return SUCCESS;
	}
	
	/**
     * 机构创建或修改保存
	 * @author panfeng
	 * @date 2014-8-20
     * @return
     */
    public String saveCerBody(){
    	
    	//获取操作人基本信息及系统日期
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
    	
	    //1获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("P_","COA_ID","TYPE","NAME","ADDR","VALID_DATE","EXPIRE_DATE","STATE","REG_USERID","REG_DATE","MOD_USERID","MOD_DATE");
        
        String pageAction = this.getParameter("P_PAGEACTION");//获取页面类型（创建/修改）
        boolean operation_type = true;
        
        if (("create").equals(pageAction)) {//机构创建
        	data.add("REG_USERID",personName);
        	data.add("REG_DATE",curDate);
        	data.add("MOD_USERID",personName);
        	data.add("MOD_DATE",curDate);
        	operation_type = true;
        }else if (("update").equals(pageAction)) {//修改
        	data.add("MOD_USERID",personName);
        	data.add("MOD_DATE",curDate);
			operation_type = false;
		}
        
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            success=handler.saveCerBody(conn,data,operation_type);
            //TODO:需要加定时器定时任务：检测认证机构的失效日期，到期系统将自动进行失效保存操作
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
                        log.logError("CertificationBodyAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * @Title: findBodyList 
	 * @Description: 认证机构列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String findBodyList(){
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
			DataList dl=handler.findBodyList(conn,pageSize,page,compositor,ordertype);
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
						log.logError("CertificationBodyAction的findBodyList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * 修改草稿、已生效记录
	 * @author panfeng
	 * @date 2014-8-20
	 * @return
	 */
	public String showCerBody(){
		//1 获取代入变量
		String COA_ID = getParameter("uuid","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取查看信息结果集
			Data showdata = handler.showCerBody(conn, COA_ID);
			//4 变量代入查看页面
			setAttribute("rzjgData", showdata);
			setAttribute("STATE", showdata.getString("STATE",""));
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
	 * @Title: bodyDelete 
	 * @Description: 批量删除草稿记录
	 * @author: panfeng;
	 * @return String    返回类型 
	 * @throws
	 */
	public String bodyDelete() {
		//1 获取要删除的文件ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取删除结果
			success = handler.bodyDelete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "记录删除操作异常");
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
                        log.logError("CertificationBodyAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: changeFail 
	 * @Description: 失效、恢复生效记录
	 * @author: panfeng;
	 * @return String    返回类型 
	 * @throws
	 */
	public String changeFail() {
		//1 获取要提交的文件ID
		String op_uuid = getParameter("op_uuid", "");
		String operation_type = getParameter("type");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			success = handler.changeFail(conn, op_uuid, operation_type);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "操作成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
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
                        log.logError("CertificationBodyAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * 恢复生效时，如当前日期小于失效时间弹出修改失效时间窗口
	 * @author Panfeng
	 * @date 2014-9-10 
	 * @return
	 */
	public String modExpireDate(){
		//1 获取页面代进的ID
		String uuid = getParameter("op_uuid","");
		System.out.println(uuid);
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = handler.showCerBody(conn, uuid);
			
			//4 变量代入页面
			setAttribute("modData", showdata);
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
	 * @Title: reviseExpireDate 
	 * @Description: 修改失效日期
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String reviseExpireDate() {
		 //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("P_","COA_ID","EXPIRE_DATE");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			data.add("STATE", "1");//状态变为已生效
			success = handler.saveCerBody(conn, data, false);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "修改失效日期成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "修改失效日期操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[修改失效日期操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "修改失效日期操作失败!");
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
                        log.logError("PauseFileAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	
}
