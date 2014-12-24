/**   
 * @Title: UrgeCostAction.java 
 * @Package com.dcfs.fam.urgeCost 
 * @Description: 费用催缴操作
 * @author yangrt   
 * @date 2014-10-23 下午6:25:44 
 * @version V1.0   
 */
package com.dcfs.fam.urgeCost;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.config.CommonConfig;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.fam.receiveConfirm.ReceiveConfirmHandler;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

/** 
 * @ClassName: UrgeCostAction 
 * @Description: 费用催缴操作 
 * @author yangrt;
 * @date 2014-10-23 下午6:25:44 
 *  
 */
public class UrgeCostAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(UrgeCostAction.class);
	
	private UrgeCostHandler handler;
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
	
	public UrgeCostAction(){
		this.handler = new UrgeCostHandler();
	}
	
	/**
	 * @Title: UrgeCostList 
	 * @Description: 费用催缴查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="PAID_NO";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","PAID_NO","CHILD_NUM","S_CHILD_NUM","NOTICE_DATE_START","NOTICE_DATE_END","COST_TYPE","PAR_VALUE","PAY_DATE_START","PAY_DATE_END","ARRIVE_STATE","ARRIVE_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","COLLECTION_STATE","NOTICE_STATE");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.UrgeCostList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用催缴查询列表操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[费用催缴查询列表]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction的UrgeCostList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeShow 
	 * @Description: 催缴通知添加/修改操作
	 * @author: yangrt
	 * @return String  
	 */
	public String UrgeCostNoticeShow(){
		//判断当前操作是添加还是修改
		String type = getParameter("type","");
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		if(type.equals("add")){	//当前操作为添加
			setAttribute("data", new Data());
		}else if(type.equals("mod")){	//当前操作为修改
			String rm_id = getParameter("RM_ID","");	//催缴记录ID
			if(rm_id.equals("")){
				rm_id = (String)getAttribute("RM_ID");
			}
			try {
				conn = ConnectionManager.getConnection();
				//根据票据登记id,获取票据信息Data
				Data data = handler.getUrgeCostNoticeData(conn, rm_id);
				
				setAttribute("data", data);
				setAttribute("packageId", data.getString("UPLOAD_ID",""));
				
			} catch (DBException e) {
				//4设置异常处理
				setAttribute(Constants.ERROR_MSG_TITLE, "催缴通知添加/修改操作异常");
				setAttribute(Constants.ERROR_MSG, e);
	            if (log.isError()) {
	                log.logError("操作异常[催缴通知添加/修改操作]:" + e.getMessage(),e);
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
	                        log.logError("UrgeCostAction的UrgeCostNoticeShow.Connection因出现异常，未能关闭",e);
	                    }
	                    e.printStackTrace();
	                    
	                    retValue = "error2";
	                }
	            }
	        }
		}
		
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeSave 
	 * @Description: 费用催缴通知信息保存
	 * @author: yangrt;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String UrgeCostNoticeSave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","RM_ID","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","CHILD_NUM","S_CHILD_NUM","PAID_SHOULD_NUM","PAID_CONTENT","REMARKS","UPLOAD_ID","NOTICE_STATE");
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            
            String orgCode = data.getString("ADOPT_ORG_ID");	//收养组织code
            String costType = data.getString("COST_TYPE");	//费用类型
            String state = data.getString("NOTICE_STATE");	//通知状态
            String paidNo = new FileCommonManager().createPayNO(conn, orgCode, costType);	//缴费编号
            
            SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgCode);	//收养组织信息
            data.add("NAME_CN", syzzinfo.getSyzzCnName());	//添加收养组织中文名称
            data.add("NAME_EN", syzzinfo.getSyzzEnName());	//添加收养组织英文名称
            data.add("PAID_NO", paidNo);
            
            //当前登录人信息
            UserInfo userinfo = SessionInfo.getCurUser();
            String personId = userinfo.getPersonId();
            String personName = userinfo.getPerson().getCName();
            
            data.add("NOTICE_USERID", personId);
            data.add("NOTICE_USERNAME", personName);
            
            if(state.equals("1")){	//当前操作为提交时，添加通知日期
            	data.add("NOTICE_DATE", DateUtility.getCurrentDateTime());
            	retValue = "submit";
            }else{
            	setAttribute("type","mod");
            	retValue = "save";
            }
            
            boolean success = handler.UrgeCostNoticeSave(conn,data);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
                
                String packageId = data.getString("UPLOAD_ID");//附件
                AttHelper.publishAttsOfPackageId(packageId, "OTHER");//附件发布
            }
            
            setAttribute("data",data);
            setAttribute("RM_ID", data.getString("RM_ID"));
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用催缴通知信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[费用催缴通知信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用催缴通知信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("费用催缴通知信息保存操作异常:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction的UrgeCostNoticeSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeBatchAdd 
	 * @Description: 跳转统计录入页面
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostNoticeBatchAdd(){
		setAttribute("data", new Data());
		setAttribute("List", new DataList());
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostStatisticsList 
	 * @Description: 统计符合条件的收养组织应缴费信息
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostStatisticsList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//3 获取搜索参数
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","SEARCH_TYPE","DATE_START","DATE_END");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.UrgeCostStatisticsList(conn,data,pageSize,page);
			//6 将结果集写入页面接收变量
			setAttribute("data",data);
			setAttribute("List",dl);
			setAttribute("ListSize",dl.size());
			setAttribute("FLAG","true");
			setAttribute("SEARCH_TYPE",data.getString("SEARCH_TYPE"));
			setAttribute("DATE_START",data.getString("DATE_START"));
			setAttribute("DATE_END",data.getString("DATE_END"));
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用统计录入统计列表操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[费用统计录入统计列表]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction的UrgeCostStatisticsList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostBatchNoticeSave 
	 * @Description: 统计录入费用催缴通知信息保存
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostBatchNoticeSave(){
		//1 获得页面表单数据，构造数据结果集
		String SEARCH_TYPE = getParameter("SEARCH_TYPE");
		String DATE_START = getParameter("DATE_START");
		String DATE_END = getParameter("DATE_END");
		String[] COUNTRY_CODE = getParameterValues("LCOUNTRY_CODE");
    	String[] ADOPT_ORG_ID = getParameterValues("LADOPT_ORG_ID");
    	String[] NAME_CN = getParameterValues("LNAME_CN");
    	String[] NAME_EN = getParameterValues("LNAME_EN");
    	String[] CHILD_NUM = getParameterValues("LCHILD_NUM");
    	String[] S_CHILD_NUM = getParameterValues("LS_CHILD_NUM");
    	String[] PAID_SHOULD_NUM = getParameterValues("LPAID_SHOULD_NUM");
    	
    	DataList saveList = new DataList();
    	Data saveData = new Data();
    	
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
        	//当前登录人信息
            UserInfo userinfo = SessionInfo.getCurUser();
            String personId = userinfo.getPersonId();
            String personName = userinfo.getPerson().getCName();
        	
        	int num = COUNTRY_CODE.length;
        	for(int i = 0; i < num; i++){
        		String paidNo = new FileCommonManager().createPayNO(conn, ADOPT_ORG_ID[i], "20");	//缴费编号
        		saveData.add("COUNTRY_CODE", COUNTRY_CODE[i]);
        		saveData.add("ADOPT_ORG_ID", ADOPT_ORG_ID[i]);
        		saveData.add("NAME_CN", NAME_CN[i]);
        		saveData.add("NAME_EN", NAME_EN[i]);
        		saveData.add("CHILD_NUM", CHILD_NUM[i]);
        		saveData.add("S_CHILD_NUM", S_CHILD_NUM[i]);
        		saveData.add("PAID_SHOULD_NUM", PAID_SHOULD_NUM[i]);
        		saveData.add("PAID_NO", paidNo);
        		saveData.add("COST_TYPE", "20");
        		saveData.add("NOTICE_STATE", "1");
        		saveData.add("NOTICE_USERID", personId);
        		saveData.add("NOTICE_USERNAME", personName);
        		saveData.add("NOTICE_DATE", DateUtility.getCurrentDateTime());
        		
        		//文件数量
        		String filenum = handler.getFileNum(conn, COUNTRY_CODE[i], ADOPT_ORG_ID[i], SEARCH_TYPE, DATE_START, DATE_END);
        		String PDFpath = this.CreatePDF(i+1, DATE_START, DATE_END, filenum, PAID_SHOULD_NUM[i]);
        		
        		File file = new File(PDFpath);
        		String packageId = UUID.getUUID();
        		AttHelper.manualUploadAtt(file, "OTHER", packageId, null, AttConstants.FAW_JFPJ, AttConstants.FAM, "class_code=FAM");
        		file.delete();
        		
        		saveData.add("UPLOAD_ID", packageId);
        		saveList.add(saveData);
        	}
            
            boolean success = handler.UrgeCostBatchNoticeSave(conn,saveList);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
                
                for(int i = 0; i < saveList.size(); i++){
                	String packageId = saveList.getData(i).getString("UPLOAD_ID");//附件
                    AttHelper.publishAttsOfPackageId(packageId, "OTHER");//附件发布
                }
                
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用通知统计录入信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[费用通知统计录入信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用通知统计录入信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("费用通知统计录入信息保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (DocumentException e) {
        	setAttribute(Constants.ERROR_MSG_TITLE, "生成PDF信息服务费通知操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("生成PDF信息服务费通知操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} catch (IOException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "生成PDF信息服务费通知操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("生成PDF信息服务费通知操作异常:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction的UrgeCostNoticeSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ShowFileChildList 
	 * @Description: 查看相应的文件儿童列表信息
	 * @author: yangrt
	 * @return String 
	 */
	public String ShowFileChildList(){
		//获取搜索参数
		String countrycode = getParameter("COUNTRY_CODE");
		String orgcode = getParameter("ADOPT_ORG_ID");
		String SEARCH_TYPE = getParameter("SEARCH_TYPE");
		String DATE_START = getParameter("DATE_START");
		String DATE_END = getParameter("DATE_END");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 获取数据DataList
			DataList dl = handler.getFileChildDataList(conn, countrycode, orgcode, SEARCH_TYPE, DATE_START, DATE_END);
			for(int i = 0; i < dl.size(); i++){
				Data d = dl.getData(i);
				String twins_ids = d.getString("TWINS_IDS","");
				String names = "";
				if(!twins_ids.equals("")){
					DataList childList = new FileManagerHandler().getChildDataList(conn, twins_ids);
					for(int j = 0; j < childList.size(); j++){
						names += childList.getData(j).getString("NAME") + ",";
					}
					names = names.substring(0, names.lastIndexOf(","));
				}
				d.add("NAMES", names);
			}
			
			// 将结果集写入页面接收变量
			setAttribute("List",dl);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查列表操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[费用统计录入统计列表]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction的UrgeCostStatisticsList.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeBatchDelete 
	 * @Description: 费用催缴通知批量删除
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostNoticeBatchDelete(){
		String deleteid = getParameter("batchID");
		try{
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.UrgeCostNoticeBatchDelete(conn,deleteid);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        }catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("删除操作异常[删除操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "删除失败!");
            setAttribute("clueTo", clueTo);
            
        	retValue = "error";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                	retValue = "error";
                    if (log.isError()) {
                        log.logError("UrgeCostAction的UrgeCostNoticeBatchDelete.Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeBatchSubmit 
	 * @Description: 费用催缴通知批量发送
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostNoticeBatchSubmit(){
		String submitid = getParameter("batchID");
		try{
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.UrgeCostNoticeBatchSubmit(conn,submitid);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        }catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用催缴通知批量发送操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[费用催缴通知批量发送操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "费用催缴通知批量发送操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("费用催缴通知批量发送操作异常:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction的UrgeCostNoticeBatchSubmit.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostFeedBackAdd 
	 * @Description: 催缴通知反馈录入信息
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostFeedBackAdd(){
		String rm_id = getParameter("RM_ID");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 获取数据DataList
			Data data = handler.getUrgeCostNoticeData(conn, rm_id);
			// 将结果集写入页面接收变量
			setAttribute("data",data);
			
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "催缴通知反馈录入信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[催缴通知反馈录入信息]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction的UrgeCostFeedBackAdd.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostFeedBackSave 
	 * @Description: 催缴通知反馈录入信息保存
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostFeedBackSave(){
		//1 获得页面表单数据，构造数据结果集
		Data pjdata = getRequestEntityData("R_","RM_ID","COUNTRY_CODE","ADOPT_ORG_ID","NAME_CN","NAME_EN","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAR_VALUE","PAID_CONTENT","PAID_WAY","BILL_NO","PAY_USERNAME","PAY_DATE","FILE_CODE");
		Data tzdata = getRequestEntityData("L_","NOTICE_STATE");
		
		//当前登录人信息
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgId = userinfo.getCurOrgan().getId();
		String personName = userinfo.getPerson().getCName();
		String pseronId = userinfo.getPersonId();
		String curDate = DateUtility.getCurrentDateTime();
		
		pjdata.add("REG_ORGID", orgId);	//录入部门ID
		pjdata.add("REG_USERID", pseronId);	//录入人id
		pjdata.add("REG_USERNAME", personName);	//录入人姓名
		pjdata.add("REG_DATE", curDate);	//录入日期
		pjdata.add("COLLECTION_STATE", "0");	//托收_托收状态(0：未托收)
		pjdata.add("ARRIVE_STATE", "0");	//到账_到账状态(0：待确认)
		
		tzdata.add("RM_ID", pjdata.getString("RM_ID"));
		
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            
            boolean success = handler.UrgeCostFeedBackSave(conn,pjdata,tzdata);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
                
                String packageId = pjdata.getString("FILE_CODE");//附件
                AttHelper.publishAttsOfPackageId(packageId, "OTHER");//附件发布
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "催缴通知反馈录入信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[催缴通知反馈录入信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "催缴通知反馈录入信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("催缴通知反馈录入信息保存操作异常:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction的UrgeCostNoticeSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostReceiveAdd 
	 * @Description: 到账反馈信息录入
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostReceiveAdd(){
		//获取票据登记ID
		String CHEQUE_ID = getParameter("CHEQUE_ID");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 获取数据Data
			Data data = new ReceiveConfirmHandler().getFamChequeInfoById(conn, CHEQUE_ID);
			// 将结果集写入页面接收变量
			setAttribute("data",data);
			
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "到账反馈信息录入信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[到账反馈信息录入信息]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction的UrgeCostReceiveAdd.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * @Title: UrgeCostReceiveSave 
	 * @Description: 到账反馈信息保存
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostReceiveSave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","CHEQUE_ID","ARRIVE_VALUE","ARRIVE_DATE","ARRIVE_STATE");
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.UrgeCostReceiveSave(conn,data);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "到账反馈信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[到账反馈信息保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "到账反馈信息保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("到账反馈信息保存操作异常:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction的UrgeCostReceiveSave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: CreatePDF 
	 * @Description: 生成PDF格式的信息服务费通知
	 * @author: yangrt
	 * @param num
	 * @param start_date
	 * @param end_date
	 * @param filenum
	 * @param should_pay
	 * @return String 
	 * @throws DocumentException 
	 * @throws IOException 
	 */
	public String CreatePDF(int num, String start_date, String end_date, String filenum, String should_pay) throws DocumentException, IOException {
        //实例化文档对象  
        Document document = new Document(PageSize.A4, 80, 80, 100, 50);//A4纸，左右上下空白
        
        String path = CommonConfig.getProjectPath() + "/tempFile/";
        String PDFpath = path + "costnotice.pdf";//输出文件路径
        // PdfWriter对象
        PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//文件的输出路径+文件的实际名称 
        document.open();// 打开文档
        
        
        String HEIFontPath = CommonConfig.getProjectPath() + "/Fonts/SIMHEI.TTF";
        String SONGFontPatn = CommonConfig.getProjectPath() + "/Fonts/SIMSUN.TTC,0";

        //中文标题字体
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//黑体
        Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//黑体 20 粗体
        //中文正文字体
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  宋体
        Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//宋体 12 正常
        
        //英文标题字体
        Font FontEN_T20B = new Font(Font.TIMES_ROMAN, 20, Font.BOLD);//times new roman 20 粗体
        //英文正文字体
        Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 正常
        
        //中文标题
        Paragraph ParagraphTitleCN = new Paragraph("信息服务费通知", FontCN_HEI20B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        ParagraphTitleCN.setSpacingAfter(10);	//标题与正文相隔距离
        document.add(ParagraphTitleCN);
        //中文正文
        Paragraph ParagraphContextCN = new Paragraph();
        ParagraphContextCN.setFirstLineIndent(20);//首行缩进
        Phrase PhraseContextCN1 = new Phrase("自", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN1);
        Phrase PhraseContextCN2 = new Phrase(start_date, FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN2);
        Phrase PhraseContextCN3 = new Phrase("至", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN3);
        Phrase PhraseContextCN4 = new Phrase(end_date, FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN4);
        Phrase PhraseContextCN5 = new Phrase("日，贵机构完成上办理", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN5);
        Phrase PhraseContextCN6 = new Phrase(filenum, FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN6);
        Phrase PhraseContextCN7 = new Phrase("件，请在特需系统的", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN7);
        Phrase PhraseContextCN8 = new Phrase("Adoption Applications Detail", FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN8);
        Phrase PhraseContextCN9 = new Phrase("页面中查询明细。如有误差，请与中国收养中心信息技术部", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN9);
        Phrase PhraseContextCN10 = new Phrase("(86-10-65548860)", FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN10);
        Phrase PhraseContextCN11 = new Phrase("联系，如无误差，请交付", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN11);
        Phrase PhraseContextCN12 = new Phrase(should_pay + "$", FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN12);
        Phrase PhraseContextCN13 = new Phrase("的信息资料处理费。", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN13);
        document.add(ParagraphContextCN);
        
        ParagraphContextCN.setSpacingAfter(30);
        
        //英文标题
        Paragraph ParagraphTitleEN = new Paragraph("Notice of Information Tending", FontEN_T20B);
        ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
        ParagraphTitleEN.setSpacingAfter(10);
        document.add(ParagraphTitleEN);
        //英文正文
        Paragraph ParagraphContextEN = new Paragraph();
        ParagraphContextEN.setFirstLineIndent(20);//首行缩进
        String contextEn = "From " + start_date + " to " + end_date + ", " + filenum + " applications have been processed through this system. Please use the page of Adoption Applications Detail In Special Need MIS to check detail. If there is any discrepancy, please contact the Information and Technology Department (86-10-65548860)If not, please pay the information processing fee of " + should_pay + "$.";
        Phrase PhraseContextEN1 = new Phrase(contextEn, FontEN_T12N);
        ParagraphContextEN.add(PhraseContextEN1);
        document.add(ParagraphContextEN);
        
        document.close();
        
        return PDFpath;
    }
	
}
