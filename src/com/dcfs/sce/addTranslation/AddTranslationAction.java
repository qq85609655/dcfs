package com.dcfs.sce.addTranslation;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;

/**
 * 
 * @Title: AddTranslationAction.java
 * @Description: 预批补翻信息查询、查看操作
 * @Company: 21softech
 * @Created on 2014-9-19 上午9:12:01 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AddTranslationAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AddTranslationAction.class);
    private Connection conn = null;
    private AddTranslationHandler handler;
    private String retValue = SUCCESS;
    
    public AddTranslationAction() {
        this.handler=new AddTranslationHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: addTranslationList
     * @Description: 预批补翻信息列表
     * @author: panfeng
     * @date: 2014-9-19 上午9:12:01 
     * @return
     */
    public String addTranslationList(){
        // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","PROVINCE_ID","WELFARE_ID",
        			"NAME","SEX","NOTICE_DATE_START","NOTICE_DATE_END","COMPLETE_DATE_START",
        			"COMPLETE_DATE_END","TRANSLATION_UNITNAME","TRANSLATION_STATE");
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
            DataList dl=handler.addTranslationList(conn,data,OperType,pageSize,page,compositor,ordertype);
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
	 * @Title: addTranslationShow 
	 * @Description: 查看预批补翻信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String addTranslationShow(){
		//获取预批申请信息id
		String uuid = getParameter("showuuid");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据 预批申请信息id获取详细信息
			Data showdata = handler.getShowData(conn,uuid);
			
			setAttribute("data", showdata);
			setAttribute("RI_ID", uuid);
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取预批补翻信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取预批补翻信息操作异常:" + e.getMessage(),e);
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
