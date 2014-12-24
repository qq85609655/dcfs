package com.dcfs.ffs.pause;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import com.dcfs.common.DcfsConstants;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.dcfs.ffs.fileManager.FileReturnHandler;
import com.hx.framework.authenticate.SessionInfo;
/**
 * 
 * @ClassName: PauseFileAction 
 * @Description: 由办公室对文件信息进行查询、暂停、取消暂停、退文、修改暂停期限、导出操作
 * @author panfeng;
 * @date 2014-9-4 下午2:03:18 
 *
 */
public class PauseFileAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(PauseFileAction.class);

    private PauseFileHandler handler;
    private FileReturnHandler fr_handler;
    private FileManagerHandler fm_handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;

    public PauseFileAction(){
        this.handler=new PauseFileHandler();
        this.fr_handler=new FileReturnHandler();
        this.fm_handler=new FileManagerHandler();
    } 

	@Override
	public String execute() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	/**
	 * @Title: pauseFileList 
	 * @Description: 文件暂停信息列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String pauseFileList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="PAUSE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","PAUSE_UNITNAME",
					"MALE_NAME","FEMALE_NAME","RECOVERY_STATE","PAUSE_DATE_START","PAUSE_DATE_END","RECOVERY_DATE_START","RECOVERY_DATE_END","AF_POSITION");
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
			DataList dl=handler.pauseFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件暂停信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("文件暂停信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("PauseFileAction的pauseFileList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: pauseSearchList 
	 * @Description: 收养组织文件暂停信息查询列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String pauseSearchList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="PAUSE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","PAUSE_UNITNAME",
				"MALE_NAME","FEMALE_NAME","RECOVERY_STATE","PAUSE_DATE_START","PAUSE_DATE_END","RECOVERY_DATE_START","RECOVERY_DATE_END","AF_POSITION");
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
			DataList dl=handler.pauseSearchList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件暂停信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("文件暂停信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("PauseFileAction的pauseFileList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * 文件超期提醒页面
	 * @author Panfeng
	 * @date 2014-9-4 
	 * @return
	 */
	public String remindShow(){
		//1 获取页面代进的ID
		String uuid = getParameter("AP_ID","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = handler.confirmShow(conn, uuid);
			
			//计算提醒日期
      		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      		Calendar cal = Calendar.getInstance();
      		String end_date = showdata.getString("END_DATE","");
      		cal.setTime(sdf.parse(end_date));
      		cal.add(Calendar.MONTH, -1);
      		showdata.add("REMIND_DATE", sdf.format(cal.getTime()));//提醒日期
      		
      		//日期转换yyyy年MM月dd日
      		SimpleDateFormat cn_fmt = new SimpleDateFormat("yyyy年MM月dd日");
      		Calendar cal1 = Calendar.getInstance();
      		cal1.setTime(sdf.parse(end_date));
      		String cn_end_date = cn_fmt.format(cal1.getTime()); 
      		showdata.add("CN_END_DATE",cn_end_date);//暂停期限日期
      		Calendar cal2 = Calendar.getInstance();
      		cal2.setTime(sdf.parse(showdata.getString("REMIND_DATE","")));
      		String cn_remind_date = cn_fmt.format(cal2.getTime()); 
      		showdata.add("CN_REMIND_DATE",cn_remind_date);//提醒开始日期
      		
      		//日期转换为英文格式
      		Locale l = new Locale("en");
      		Calendar cal3 = Calendar.getInstance();
      		cal3.setTime(sdf.parse(end_date));
      		String day1 = String.format("%td", cal3);
      		String month1 = String.format(l,"%tb", cal3);
    		String year1 = String.format("%tY", cal3);
      		showdata.add("EN_END_DATE",month1+" "+day1+","+year1);//暂停期限日期
      		Calendar cal4 = Calendar.getInstance();
      		cal4.setTime(sdf.parse(showdata.getString("REMIND_DATE","")));
      		String day2 = String.format("%td", cal4);
      		String month2 = String.format(l,"%tb", cal4);
      		String year2 = String.format("%tY", cal4);
      		showdata.add("EN_REMIND_DATE",month2+" "+day2+","+year2);//暂停期限日期
      		
			//4 变量代入页面
      		setAttribute("male_name", showdata.getString("MALE_NAME",""));
			setAttribute("female_name", showdata.getString("FEMALE_NAME",""));
			setAttribute("remindData", showdata);
		} catch (DBException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
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
	 * @Title: pauseChoiceList 
	 * @Description: 暂停文件选择列表
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String pauseChoiceList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END",
					"COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","NAME",
					"AF_POSITION","AF_GLOBAL_STATE");
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
			DataList dl=handler.pauseChoiceList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件信息查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("文件信息查询操作异常:" + e.getMessage(),e);
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
						log.logError("PauseFileAction的pauseChoiceList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	

	/**
	 * 跳转到文件暂停确认页面
	 * @author Panfeng
	 * @date 2014-9-4 
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
			
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curUnitId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
			String curUnitName = SessionInfo.getCurUser().getCurOrgan().getCName();
			String curDate = DateUtility.getCurrentDate();
			showdata.add("PAUSE_USERID",curId);//暂停人ID
			showdata.add("PAUSE_USERNAME",curPerson);//暂停人
			showdata.add("PAUSE_UNITID", curUnitId);//暂停部门ID
			showdata.add("PAUSE_UNITNAME",curUnitName);//暂停部门
			showdata.add("PAUSE_DATE",curDate);//暂停日期
			showdata.add("PAUSE_REASON","");//暂停原因
			
			//计算暂停期限
      		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      		Calendar cal = Calendar.getInstance();
      		cal.add(Calendar.MONTH, +6);
      		cal.add(Calendar.DATE, -1);
      		showdata.add("END_DATE", sdf.format(cal.getTime()));
      		
			//4 变量代入页面
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
	 * @Title: pauseFileSave 
	 * @Description: 文件暂停确认提交
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String pauseFileSave(){
	    //1 获得页面表单数据，构造数据结果集
		Data fileData = new Data();
        Data pauseData = getRequestEntityData("R_","AP_ID","AF_ID","PAUSE_UNITID","PAUSE_UNITNAME",
        			"PAUSE_USERID","PAUSE_USERNAME","PAUSE_DATE","END_DATE","PAUSE_REASON");
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
      		
            fileData.add("AF_ID", (String)pauseData.get("AF_ID"));
            fileData.add("IS_PAUSE", "1");//暂停标识为"y"
            fileData.add("PAUSE_DATE", (String)pauseData.get("PAUSE_DATE"));//暂停时间
            fileData.add("PAUSE_REASON", (String)pauseData.get("PAUSE_REASON"));//暂停原因
            pauseData.add("RECOVERY_STATE","1");//暂停状态为"已暂停"
            success=handler.pauseFileSave(conn,fileData,pauseData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");//提交成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "提交操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("提交操作异常[提交操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");//保存失败 2
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
                        log.logError("PauseFileAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * @Title: fileInfoShow 
	 * @Description: 暂停选择文件时查看详细信息操作
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String fileInfoShow(){
		//获取文件id
		String file_id = getParameter("showuuid");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据文件id(file_id)获取该文件的详细信息
			Data data = fm_handler.GetFileByID(conn,file_id);
			
			String file_type = data.getString("FILE_TYPE");	//文件类型
			String family_type = data.getString("FAMILY_TYPE");	//收养类型
			//根据文件类型(file_type)、收养类型(family_type)确定返回的页面
			if("33".equals(file_type)){
				retValue = "step";	//返回继子女收养查看页面
			}else{
				if("1".equals(family_type)){
					retValue = "double";	//返回双亲收养查看页面
				}else{
					retValue = "single";	//返回单亲收养查看页面
				}
			}
			
			setAttribute("data", data);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件详细信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取文件详细信息操作异常:" + e.getMessage(),e);
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
	 * @Title: fileRecovery 
	 * @Description: 文件取消暂停
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String fileRecovery() {
		//1 获取要取消暂停的文件ID
		String fileuuid = getParameter("fileuuid", "");
		String recuuid = getParameter("recuuid", "");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			
			success = handler.fileRecovery(conn, fileuuid, recuuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "取消暂停成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "取消暂停操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[取消暂停操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "取消暂停操作失败!");
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
	
	/**
	 * 跳转到退文确认页面
	 * @author Panfeng
	 * @date 2014-9-4 
	 * @return
	 */
	public String returnFileShow(){
		//1 获取页面代进的ID
		String uuid = getParameter("showuuid","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = fr_handler.confirmShow(conn, uuid);
			
			String curId = SessionInfo.getCurUser().getPerson().getPersonId();
			String curPerson = SessionInfo.getCurUser().getPerson().getCName();
			String curDate = DateUtility.getCurrentDate();
			showdata.add("APPLE_PERSON_ID",curId);//申请人ID
			showdata.add("APPLE_PERSON_NAME",curPerson);//申请人
			showdata.add("APPLE_DATE",curDate);//申请日期
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
	 * @Title: returnFileSave 
	 * @Description: 退文确认提交
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String returnFileSave(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","AR_ID","AF_ID","FILE_NO","REGISTER_DATE","FILE_TYPE",
        			"COUNTRY_CODE","ADOPT_ORG_ID","FAMILY_TYPE","MALE_NAME","FEMALE_NAME",
        			"APPLE_PERSON_ID","APPLE_PERSON_NAME","APPLE_DATE","HANDLE_TYPE","RETURN_REASON");
        Data fileData = new Data();
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            fileData.add("AF_ID", (String)data.get("AF_ID"));
            fileData.add("RETURN_REASON", (String)data.get("RETURN_REASON"));//退文原因
            fileData.add("RETURN_STATE", "0");//退文状态为"待确认"(文件信息表)
            data.add("RETURN_STATE","0");//退文状态为"待确认"（退文记录表）
            data.add("APPLE_TYPE","5");//退文类型为"暂停超时退出收养"（退文记录表）
            success=fr_handler.ReturnFileSave(conn,data,fileData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "退文提交成功!");//提交成功 0
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "提交操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("提交操作异常[提交操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "提交失败!");//保存失败 2
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
                        log.logError("FileReturnAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
	
	/**
	 * 打开修改暂停期限页面
	 * @author Panfeng
	 * @date 2014-9-4 
	 * @return
	 */
	public String modDeadline(){
		//1 获取页面代进的ID
		String uuid = getParameter("showuuid","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = handler.confirmShow(conn, uuid);
			
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
	 * @Title: reviseDeadline 
	 * @Description: 修改暂停期限
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String reviseDeadline() {
		 //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","AP_ID","END_DATE");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			
			success = handler.pauseFileSave(conn, null, data);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "修改暂停期限成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "修改暂停期限操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[修改暂停期限操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "修改暂停期限操作失败!");
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
	
	/**
	 * 文件暂停信息查看
	 * @author Panfeng
	 * @date 2014-12-4 
	 * @return
	 */
	public String pauseSearchShow(){
		//1 获取页面代进的ID
		String uuid = getParameter("showuuid","");
		String type = getParameter("type","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = handler.pauseSearchShow(conn, uuid);
			
			//4 变量代入页面
			setAttribute("data", showdata);
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
		if ("ZX".equals(type)) {
			return "ZX";
		} else if ("SYZZ".equals(type)) {
			return "SYZZ";
		} else {
			return SUCCESS;
		}
	}
	
}
