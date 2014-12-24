/**   
 * @Title: SuppleQueryAction.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: 补充查询操作
 * @author yangrt   
 * @date 2014-9-5 上午10:53:12 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.ModifyHistoryConfig;

/** 
 * @ClassName: SuppleQueryAction 
 * @Description: 补充查询操作
 * @author yangrt;
 * @date 2014-9-5 上午10:53:12 
 *  
 */
public class SuppleQueryAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(SuppleQueryAction.class);
	
	private SuppleQueryHandler handler = null;
	
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
	
	public SuppleQueryAction(){
		this.handler = new SuppleQueryHandler();
	}
	
	/**
	 * @Title: SuppleQueryList 
	 * @Description: 审核部补充查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String SuppleQueryList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AA_STATUS";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FILE_TYPE","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
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
			//操作来源，审核部：OperType：SHB
			String OperType = getParameter("type",""); 
			if("".equals(OperType)){
				OperType = (String) getAttribute("type");
			}
			//5 获取数据DataList
			DataList dl=handler.SuppleQueryList(conn,data,OperType,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "审核部补充文件查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("审核部补充文件查询操作异常:" + e.getMessage(),e);
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
						log.logError("SuppleQueryAction的SuppleQueryList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: SuppleQueryShow 
	 * @Description: 补充明细查看页面
	 * @author: yangrt
	 * @return String 
	 */
	public String SuppleQueryShow(){
		String flag = getParameter("Flag","");
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AA_STATUS";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//获取文件补充记录ID
		String aa_id = getParameter("AA_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据文件补充记录ID,获取文件补充信息Data
			Data aadata = handler.getSuppleData(conn, aa_id);
			//文件id
			String af_id = aadata.getString("AF_ID");
			//根据文件id，获取文件修改历史记录
			DataList reviseList = handler.getReviseList(conn,af_id,pageSize,page,compositor,ordertype);
			if(reviseList.size()>0){
	            for(int i=0;i<reviseList.size();i++){
	                Data data=reviseList.getData(i);
	                String colName=data.getString("UPDATE_FIELD");
	                data.add("UPDATE_FIELD",ModifyHistoryConfig.getShowstring(colName,"filemodifyhistory-config"));
	            }
		    }
			
			setAttribute("List", reviseList);
			setAttribute("data", aadata);
			setAttribute("AA_ID", aa_id);
			setAttribute("UPLOAD_IDS",aadata.getString("UPLOAD_IDS",aa_id));
			setAttribute("Flag", flag);
			if("suppleList".equals(flag)){
				retValue = "File";
			}else{
				retValue = "Query";
			}
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "审核部补充信息查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[审核部补充信息查看操作]:" + e.getMessage(),e);
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
                        log.logError("SuppleQueryAction的SuppleQueryShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: FileDetailShow 
	 * @Description: 文件详细信息查看页面
	 * @author: yangrt
	 * @return String 
	 */
	public String FileDetailShow(){
		//获取文件ID
		String af_id = getParameter("AF_ID");
		//根据文件ID,获取文件信息Data
		Data filedata = new FileManagerAction().GetFileByID(af_id);
		setAttribute("file_type", filedata.getString("FILE_TYPE"));
		setAttribute("filedata", filedata);
		setAttribute("AF_ID", af_id);
		setAttribute("RI_ID", filedata.getString("RI_ID",""));
		setAttribute("type", getParameter("type"));
		return retValue;
	}
	
	/**
	 * @Title: GetFileDetail 
	 * @Description: 获取文件的基本信息
	 * @author: yangrt
	 * @return String  
	 */
	public String GetFileDetail(){
		//获取文件ID
		String af_id = getParameter("AF_ID");
		String flag = getParameter("type");
		//根据文件ID,获取文件信息Data
		Data filedata = new FileManagerAction().GetFileByID(af_id);
		String file_type = filedata.getString("FILE_TYPE","");
		String family_type = filedata.getString("FAMILY_TYPE","");
		if(file_type.equals("33")){
			retValue = "step";
		}else{
			if(family_type.equals("1")){
				retValue = "double" + flag;
			}else if(family_type.equals("2")){
				retValue = "single" + flag;
			}
		}
		setAttribute("filedata", filedata);
		setAttribute("PACKAGE_ID",filedata.getString("PACKAGE_ID", af_id));
		setAttribute("PACKAGE_ID_CN",filedata.getString("PACKAGE_ID_CN", af_id));
		setAttribute("MALE_PHOTO",filedata.getString("MALE_PHOTO",""));
		setAttribute("FEMALE_PHOTO",filedata.getString("FEMALE_PHOTO",""));
		return retValue;
	}
	
	/**
	 * @Title: GetPreApproveData 
	 * @Description: 文件预批审核记录信息
	 * @author: yangrt
	 * @return String  
	 */
	public String GetPreApproveData(){
		//获取文件ID
		String af_id = getParameter("AF_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据文件ID,获取文件信息Data
			Data filedata = new FileManagerAction().GetFileByID(af_id);
			//儿童材料id
			String str_ci_id = filedata.getString("CI_ID","");
			//预锁定儿童信息列表DataList
			DataList childList = handler.getChildList(conn, str_ci_id);
			
			//预批申请记录id
			String ri_id = filedata.getString("RI_ID","");
			//获取文件预批信息
			DataList preList = handler.getPreAuditList(conn, ri_id);
			setAttribute("childList", childList);
			setAttribute("preList", preList);
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "审核部文件预批审核记录查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[审核部文件预批审核记录查看操作]:" + e.getMessage(),e);
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
                        log.logError("SuppleQueryAction的GetPreApproveData.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
		
	}

}
