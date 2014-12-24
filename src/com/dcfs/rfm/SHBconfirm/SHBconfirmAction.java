package com.dcfs.rfm.SHBconfirm;

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
 * @ClassName: SHBconfirmAction 
 * @Description: 由审核部对退文信息进行查询、确认、查看、取消退文、导出操作
 * @author panfeng;
 * @date 2014-9-28 上午11:01:09 
 *
 */
public class SHBconfirmAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(SHBconfirmAction.class);

    private SHBconfirmHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;

    public SHBconfirmAction(){
        this.handler=new SHBconfirmHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: SHBconfirmList 
	 * @Description: 退文确认列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SHBconfirmList(){
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
					"REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","FILE_TYPE","APPLE_DATE_START",
					"APPLE_DATE_END","HANDLE_TYPE","RETREAT_DATE_START","RETREAT_DATE_END","RETURN_STATE");
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
			DataList dl=handler.SHBconfirmList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "退文确认信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("退文确认信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("SHBconfirmAction的SHBconfirmList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * 跳转到退文确认页面
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
	 * @Title: SHBconfirmSave 
	 * @Description: 退文确认操作
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String SHBconfirmSave(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","AR_ID","AF_ID");
        Data fileData = new Data();
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            String curOrgId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
            String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			data.add("ORG_ID",curOrgId);//确认部门ID
			data.add("PERSON_ID",curId);//确认人ID
			data.add("PERSON_NAME",curPerson);//确认人
			data.add("RETREAT_DATE",curDate);//确认日期
            fileData.add("AF_ID", (String)data.get("AF_ID"));
        	fileData.add("RETURN_STATE", "1");//退文状态为"已确认"(文件信息表)
        	data.add("RETURN_STATE","1");//退文状态为"已确认"（退文记录表）
        	
        	//初始化退文移交记录（审核部-档案部）
        	FileCommonManager fileCommonManager = new FileCommonManager();
        	DataList tranferDataList = new DataList();
        	Data tranferData = new Data();
        	tranferData.add("APP_ID", (String)data.get("AF_ID"));
        	tranferData.add("TRANSFER_CODE", TransferCode.RFM_FILE_SHB_DAB);
        	tranferData.add("TRANSFER_STATE", "0");
        	tranferDataList.add(tranferData);
        	fileCommonManager.transferDetailInit(conn, tranferDataList);//初始化退文移交记录
            
            success=handler.SHBconfirmSave(conn,data,fileData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "确认成功!");//提交成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "确认操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[确认操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "确认失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "确认失败!");//保存失败 2
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
                        log.logError("SHBconfirmAction的Connection因出现异常，未能关闭",e);
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
	
	/**
	 * @Title: returnFileDelete 
	 * @Description: 批量取消退文信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String returnFileDelete() {
		//1 获取要取消的退文记录ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		String fileuuid = getParameter("fileuuid", "");
		String[] file_uuid = fileuuid.split("#");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取删除结果
			success = handler.returnFileDelete(conn, uuid, file_uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "退文取消成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "退文取消操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[退文取消操作]:" + e.getMessage(),e);
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
                        log.logError("InsteadRecordAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}

	
	
}
