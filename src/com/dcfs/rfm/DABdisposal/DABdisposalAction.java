package com.dcfs.rfm.DABdisposal;

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
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: DABdisposalAction 
 * @Description: 由档案部对退文信息进行查询、处置、查看、导出操作
 * @author panfeng;
 * @date 2014-9-25 下午7:42:16 
 *
 */
public class DABdisposalAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(DABdisposalAction.class);

    private DABdisposalHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;

    public DABdisposalAction(){
        this.handler=new DABdisposalHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
	
	/**
	 * @Title: DABdisposalList 
	 * @Description: 退文处置列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String DABdisposalList(){
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
					"APPLE_DATE_END","HANDLE_TYPE","RETREAT_DATE_START","RETREAT_DATE_END","RETURN_STATE",
					"DUAL_USERNAME","DUAL_DATE_START","DUAL_DATE_END","APPLE_TYPE");
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
			DataList dl=handler.DABdisposalList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "退文处置信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("退文处置信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("DABdisposalAction的DABdisposalList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * 跳转到退文处置页面
	 * @author Panfeng
	 * @date 2014-9-25 
	 * @return
	 */
	public String disposalShow(){
		//1 列表页获取信息ID
		String aruuid = getParameter("aruuid", "");
		System.out.println(aruuid);
		String[] uuid = aruuid.split(",");
		String arIds = "";
		StringBuffer stringb = new StringBuffer();
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			arIds = stringb.substring(0, stringb.length() - 1);
			DataList HandRegList = handler.disposalShow(conn, arIds);
			Data disposalData = new Data();
			//4 变量代入页面
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			disposalData.add("DUAL_USERID",curId);//处置人ID
			disposalData.add("DUAL_USERNAME",curPerson);//处置人
			disposalData.add("DUAL_DATE",curDate);//处置日期
			
			setAttribute("disposalData", disposalData);
			setAttribute("List", HandRegList);
			setAttribute("AR_ID", aruuid);
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
	 * @Title: DABdisposalSave 
	 * @Description: 退文批量处置操作
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String DABdisposalSave(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","DUAL_USERID","DUAL_USERNAME","DUAL_DATE");
        
        // Start---------获取批量退文记录信息------------
        String[] AR_ID = this.getParameterValues("P_AR_ID");
 		String[] AF_ID = this.getParameterValues("P_AF_ID");
 		// End---------获取批量退文记录信息------------
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            for (int i = 0; i < AR_ID.length; i++) {
            	Data batchData = new Data();
            	Data fileData = new Data();
            	batchData.add("AR_ID", AR_ID[i]);
            	batchData.add("DUAL_USERID", (String)data.get("DUAL_USERID"));//处置人ID
            	batchData.add("DUAL_USERNAME", (String)data.get("DUAL_USERNAME"));//处置人
            	batchData.add("DUAL_DATE", (String)data.get("DUAL_DATE"));//处置时间
            	batchData.add("RETURN_STATE","3");//退文状态为"已处置"（退文记录表）
            	fileData.add("AF_ID", AF_ID[i]);
            	fileData.add("RETURN_STATE", "3");//退文状态为"已处置"(文件信息表)
            	success=handler.BGSconfirmSave(conn,batchData,fileData);
            }
            
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "处置成功!");//提交成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "处置操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[处置操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "处置失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "处置失败!");//保存失败 2
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
                        log.logError("DABdisposalAction的Connection因出现异常，未能关闭",e);
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
			Data showdata = handler.getReturnData(conn, uuid);
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
