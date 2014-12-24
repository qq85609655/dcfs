package com.dcfs.sce.additional;

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

/**
 * 
 * @Title: AdditionalAction.java
 * @Description: 预批补充信息查询、查看操作
 * @Company: 21softech
 * @Created on 2014-9-11 下午5:21:12 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AdditionalAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AdditionalAction.class);
    private Connection conn = null;
    private AdditionalHandler handler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public AdditionalAction() {
        this.handler=new AdditionalHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: findAddList
     * @Description: 预批补充信息列表
     * @author: panfeng
     * @date: 2014-9-11 下午5:21:12 
     * @return
     */
    public String findAddList(){
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
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME",
        			"PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END",
        			"REQ_DATE_START","REQ_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FEEDBACK_DATE_START",
        			"FEEDBACK_DATE_END","AA_STATUS");
        //男方、女方搜索输入条件转换大写
        String MALE_NAME = data.getString("MALE_NAME",null);
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		String OperType = getParameter("type","");
		if("".equals(OperType)){
			OperType = (String) getAttribute("OperFrom");
		}
		
		retValue = OperType;
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAddList(conn,data,OperType,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
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
	 * @Title: additionalShow 
	 * @Description: 查看预批补充信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String additionalShow(){
		//获取预批申请信息id
		String uuid = getParameter("showuuid");
		String ra_id = getParameter("ra_id");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据 预批申请信息id获取详细信息
			Data data = handler.getInfoData(conn,uuid);
			
			setAttribute("infodata", data);
			setAttribute("RI_ID", uuid);
			setAttribute("RA_ID", ra_id);
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取预批补充概要信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取预批补充概要信息操作异常:" + e.getMessage(),e);
			}
		}finally {
			// 关闭数据库连接
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
		return retValue;
	}
	
	/**
	 * @Title: ShowInfoDetail 
	 * @Description: 获取预批申请信息
	 * @author: panfeng
	 * @return String  
	 */
	public String ShowInfoDetail(){
		//获取预批申请信息ID
		String uuid = getParameter("RI_ID");
		String flag = getParameter("type");
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请信息ID,获取预批详细信息data
			Data data = handler.getInfoData(conn, uuid);
			String file_type = data.getString("FILE_TYPE","");
			String family_type = data.getString("FAMILY_TYPE","");
			if(file_type.equals("33")){
				retValue = "step";
			}else{
				if(family_type.equals("1")){
					retValue = "double" + flag;
				}else if(family_type.equals("2")){
					String male_name = data.getString("MALE_NAME","");
					String female_name = data.getString("FEMALE_NAME","");
					if(male_name.equals("")){
						setAttribute("maleFlag", "false");
					}else{
						setAttribute("maleFlag", "true");
					}
					if(female_name.equals("")){
						setAttribute("femaleFlag", "false");
					}else{
						setAttribute("femaleFlag", "true");
					}
					retValue = "single" + flag;
				}
			}
			setAttribute("infodata", data);
			setAttribute("MALE_PHOTO",data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO",data.getString("FEMALE_PHOTO",""));
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批详细信息查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[预批详细信息查看操作]:" + e.getMessage(),e);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ShowNoticeDetail 
	 * @Description: 获取预批补充通知信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String ShowNoticeDetail(){
		//获取预批补充信息id
		String uuid = getParameter("RA_ID");
		String flag = getParameter("type");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据 预批补充信息id获取详细信息
			Data data = handler.getNoticeData(conn,uuid);
			
			setAttribute("noticedata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("UPLOAD_IDS",data.getString("UPLOAD_IDS",""));
			setAttribute("UPLOAD_IDS_CN",data.getString("UPLOAD_IDS_CN",""));
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取预批补充通知信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取预批补充通知信息操作异常:" + e.getMessage(),e);
			}
		}finally {
			// 关闭数据库连接
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
		retValue = "notice" + flag;
		return retValue;
	}
	
	/**
	 * @Title: showNotice 
	 * @Description: 补充通知查看
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String showNotice(){
		//获取预批补充信息id
		String uuid = getParameter("showuuid");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据 预批补充信息id获取详细信息
			Data data = handler.getNoticeData(conn,uuid);
			
			setAttribute("detaildata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("UPLOAD_IDS",data.getString("UPLOAD_IDS",""));
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查看信息操作异常:" + e.getMessage(),e);
			}
		}finally {
			// 关闭数据库连接
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
		return retValue;
	}
    
}
