package com.dcfs.mkr.organesupp;

import hx.code.Code;
import hx.code.CodeList;
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

import com.dcfs.common.DcfsConstants;
import com.dcfs.mkr.organexp.OrganExpAction;
import com.dcfs.mkr.organexp.OrganExpHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;


public class OrganSuppAction extends BaseAction{

	private static Log log = UtilLog.getLog(OrganExpAction.class);

	private Connection conn = null;
	private OrganSuppHandler handler;
	private OrganExpHandler EXhandler;
	private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
	
	// 初始化
	public OrganSuppAction(){
		handler = new OrganSuppHandler();
		EXhandler = new OrganExpHandler();
	}
	//********在华联系人信息begin**************
	
	// 查询在华联系人信息
	public String linkManOrganList(){
		String type = getParameter("type","");
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        String id = getParameter("ID");   //收养组织ID
        String linkManId = getParameter("linkManId");  //获得从保存方法中得到的linkManId
        Data linkMan = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在华联系人信息
            dataList = handler.findLinkManOrganList(conn ,id, pageSize, page,orderString);
            
            if(linkManId != null && !"".equals(linkManId)){
            	linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
            }
        } catch (Exception e) {
            log.logError("查询在华联系人时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询在华联系人时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute("ID", id);
        setAttribute("data", linkMan);
        //联系人list
        setAttribute("dataList", dataList);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//修改在华联系人信息
	public String linkManModify(){
		String type = getParameter("type","");
		Data linkMan = new Data();
		String linkManId = getParameter("linkManId");  //联系人ID
		String ID = getParameter("ID","");   //组织ID
		try {
			conn = ConnectionManager.getConnection();
			linkMan.add("ADOPT_ORG_ID", ID);   //组织机构ID
			if(linkManId != null && !"".equals(linkManId)){
				linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
			}
		} catch (DBException e) {
			log.logError("转去修改联系人时出错!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改联系人时关闭Connection出错!", e);
			}
		}
		setAttribute("data", linkMan);
		if(type.equals("shb")){
			return "shb";
		}else{
			return retValue;
		}
	}
	
	//保存在华联系人信息
	public String linkManModifySubmit() throws SQLException, IOException{
		Map map = getDataWithPrefix("MKR_", false);
		Data linkManData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			linkManData.setEntityName("MKR_ORG_CONTACTS");
			linkManData.setPrimaryKey("ID");   //联系人主键ID
			String linkManId = linkManData.getString("ID","");  //联系人主键
			String PER_RESUME = linkManData.getString("PER_RESUME");
			String COMMITMENT_ITEM = linkManData.getString("COMMITMENT_ITEM");
			if(linkManId != null && !"".equals(linkManId)){
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				handler.modify(conn,linkManData);
				handler.modify_empty(conn,linkManId,PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}else{
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				Data resultData = handler.add(conn,linkManData);
				handler.modify_empty(conn, resultData.getString("ID"),PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("转去修改联系人时出错!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改联系人时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	//删除在华联系人信息
	public String deleteLinkMan(){
		//1.获取要删除信息的ID
		String ID = getParameter("linkManId");
		try {
			//2.获取数据库链接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.删除数据
			Data linkMan = new Data();
			linkMan.setEntityName("MKR_ORG_CONTACTS");
			linkMan.setPrimaryKey("ID");   //联系人主键ID
			linkMan.add("ID", ID);
			handler.delete(conn,linkMan);
			dt.commit();
		} catch (Exception e) {
			//4.设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "删除联系人操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
		}finally{
		//5.关闭数据库链接
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	//********在华联系人信息end**************
	
	//********援助和捐助项目begin******************
	//查询捐助或援助项目信息
	public String aidProjectOrganList(){
		String type = getParameter("type","");
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        String id = getParameter("ID");   //收养组织ID
        String aidProjectId = getParameter("aidProjectId");  //获得从保存方法中得到的项目ID
        Data aidProject = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在援助或捐赠项目信息
            dataList = handler.findAidProjectOrganList(conn ,id, pageSize, page,orderString);
            
            if(aidProjectId != null && !"".equals(aidProjectId)){
            	aidProject.setEntityName("MKR_ORG_AIDPROJECT");
            	aidProject.setPrimaryKey("ID");
            	aidProject.add("ID", aidProjectId);
            	aidProject = handler.findDataByKey(conn,aidProject);
            }
        } catch (Exception e) {
            log.logError("查询在华联系人时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询在华联系人时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute("ID", id);
        setAttribute("data", aidProject);
        //联系人list
        setAttribute("dataList", dataList);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//修改捐助或援助项目信息
	public String aidProjectModify(){
		String type = getParameter("type","");
		Data aidProject = new Data();
		String aidProjectId = getParameter("aidProjectId");  //捐助或援助项目ID
		String ID = getParameter("ID");   //组织ID
		try {
			conn = ConnectionManager.getConnection();
			aidProject.add("ADOPT_ORG_ID", ID);   //组织机构ID
			if(aidProjectId != null && !"".equals(aidProjectId)){
				aidProject.setEntityName("MKR_ORG_AIDPROJECT");
				aidProject.setPrimaryKey("ID");
				aidProject.add("ID", aidProjectId);
				aidProject = handler.findDataByKey(conn,aidProject);
			}
		} catch (DBException e) {
			log.logError("转去修改捐助或援助项目时出错!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改捐助或援助项目时关闭Connection出错!", e);
			}
		}
		setAttribute("data", aidProject);
		if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//保存援助或捐赠项目信息
	public String aidProjectModifySubmit(){
		Map map = getDataWithPrefix("MKR_", false);
		Data aidProjectData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			aidProjectData.setEntityName("MKR_ORG_AIDPROJECT");
			aidProjectData.setPrimaryKey("ID");   //援助或捐赠项目主键ID
			String aidProjectId = aidProjectData.getString("ID","");  //援助或捐赠主键
			if(aidProjectId != null && !"".equals(aidProjectId)){
				handler.modify(conn,aidProjectData);
				//setAttribute("ID", aidProjectData.getString("ID",""));  //援助或捐助项目ID
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,aidProjectData);
				//setAttribute("ID", "");  //新增援助或捐助项目ID为空
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("转去修改援助或捐赠项目时出错!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改援助或捐赠项目时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	//跳转到空白页面
	public String organNull(){
		String m = (String)getAttribute("m");
		String ID = (String)getAttribute("ADOPT_ORG_ID");
		String type = (String)getAttribute("type");
		if(m!=null && m!=""){
			if(m.equals("ok") && m!=null){
				setAttribute("m","ok");
				setAttribute("ADOPT_ORG_ID",ID);
				setAttribute("type",type);
			}
		}
		return retValue;
	}
	
	//删除援助或捐赠项目信息
	public String deleteAidProject(){
		//1.获取要删除信息的ID
		String ID = getParameter("aidProjectId");
		try {
			//2.获取数据库链接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.删除数据
			Data aidProject = new Data();
			aidProject.setEntityName("MKR_ORG_AIDPROJECT");
			aidProject.setPrimaryKey("ID");   //联系人主键ID
			aidProject.add("ID", ID);
			handler.delete(conn,aidProject);
			dt.commit();
		} catch (Exception e) {
			//4.设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "删除援助或捐赠项目操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
		}finally{
		//5.关闭数据库链接
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	} 
	
	//********援助或捐赠项目end*************
	
	//*******在华旅行接待begin*****************
	//在华旅行接待
	public String receptionOrganList(){
		String type = getParameter("type","");
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        String id = getParameter("ID");   //收养组织ID
        String receptionId = getParameter("receptionId");  //从保存方法中获取在华旅行接待ID
        Data reception = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在援助或捐赠项目信息
            dataList = handler.findReceptionOrganList(conn ,id, pageSize, page,orderString);
            
            if(receptionId != null && !"".equals(receptionId)){
            	reception.setEntityName("MKR_ORG_RECEPTION");   //收养组织在华旅行接待情况信息表
            	reception.setPrimaryKey("ID");
            	reception.add("ID", receptionId);
            	reception = handler.findDataByKey(conn,reception);
            }
        } catch (Exception e) {
            log.logError("查询收养组织在华旅行接待时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询收养组织在华旅行接待时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute("ID", id);
        setAttribute("data", reception);
        //联系人list
        setAttribute("dataList", dataList);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//修改在华旅行接待
	public String receptionModify(){
		String type = getParameter("type","");
		Data reception = new Data();
		String receptionId = getParameter("receptionId");  //在华旅行接待ID
		String ID = getParameter("ID");   //组织ID
		try {
			conn = ConnectionManager.getConnection();
			reception.add("ADOPT_ORG_ID", ID);   //组织机构ID
			if(receptionId != null && !"".equals(receptionId)){
				reception.setEntityName("MKR_ORG_RECEPTION");
				reception.setPrimaryKey("ID");
				reception.add("ID", receptionId);
				reception = handler.findDataByKey(conn,reception);
			}
		} catch (DBException e) {
			log.logError("转去修改在华旅行接待时出错!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改在华旅行接待时关闭Connection出错!", e);
			}
		}
		setAttribute("data", reception);
		if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	//保存在华旅行接待信息
	public String receptionModifySubmit(){
		Map map = getDataWithPrefix("MKR_", false);
		Data receptionData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			receptionData.setEntityName("MKR_ORG_RECEPTION");
			receptionData.setPrimaryKey("ID");   //在华旅行接待主键ID
			String receptionId = receptionData.getString("ID","");  //在华旅行接待主键
			if(receptionId != null && !"".equals(receptionId)){
				handler.modify(conn,receptionData);
				//setAttribute("ID", receptionData.getString("ID",""));  //联系人ID
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,receptionData);
				//setAttribute("ID", "");  //新增联系人ID为空
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("转去修改在华旅行接待时出错!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改在乎旅行接待时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	//删除在华旅行接待信息
	public String deleteReception(){
		//1.获取要删除信息的ID
		String ID = getParameter("receptionId");
		try {
			//2.获取数据库链接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.删除数据
			Data reception = new Data();
			reception.setEntityName("MKR_ORG_RECEPTION");
			reception.setPrimaryKey("ID");   //联系人主键ID
			reception.add("ID", ID);
			handler.delete(conn,reception);
			dt.commit();
		} catch (Exception e) {
			//4.设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "删除在华旅行接待信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
		}finally{
		//5.关闭数据库链接
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	//*****在华旅行接待end**************
	
	//**********机构备案begin***************
	public String organRecordStateList(){
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
        Data data = getRequestEntityData("MKR_","COUNTY_NAME","NAME_CN","NAME_EN","ORG_CODE","IS_VALID","FOUNDED_DATE_BEGIN","FOUNDED_DATE_END","RECORD_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findOrganRecordStateList(conn,data,pageSize,page,compositor,ordertype);
            //获取国家的DataList
            DataList countryList = handler.findCountryList(conn);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("countryList", countryList);
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
	
	//备案审核
	public String organRecordConfirm(){
		String ADOPT_ORG_ID = getParameter("ID");  //收养组织ID
		//审核人
		String RECORD_NAME = SessionInfo.getCurUser().getPerson().getCName();
		String RECORD_USERID = SessionInfo.getCurUser().getPerson().getPersonId();  //审核人ID
		//根据收养组织ID查找备案信息
		Data data = new Data();
		try {
			conn=ConnectionManager.getConnection();
        	data = handler.finfOrganRecordStateData(conn,ADOPT_ORG_ID);
        	data.add("ADOPT_ORG_ID", ADOPT_ORG_ID);  //组织ID
    		data.add("RECORD_NAME", RECORD_NAME);	//审核人
    		data.add("RECORD_USERID", RECORD_USERID);  //审核人ID
        	
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		setAttribute("data", data);
		return retValue;
	}
	
	//提交审核意见
	public String organRecordStateSubmit(){
		Map map = getDataWithPrefix("MKR_", false);
		Data recordState = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			recordState.setEntityName("MKR_ADOPT_ORG_INFO");
			recordState.setPrimaryKey("ADOPT_ORG_ID");   //组织ID主键
			recordState.add("RECORD_STATE", "2");//修改组织备案状态2：已备案
			handler.modify(conn,recordState);
		} catch (DBException e) {
			log.logError("转去提交审核意见时出错!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去提交审核意见时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	//机构备案信息查看
	public String organRecordStateDetail(){
			Data data = new Data();
	        String id = getParameter("ID");
	        Connection conn = null;
	        CodeList FWXMList = new CodeList();
	        CodeList GJList = new CodeList();
	        try {
	        	conn = ConnectionManager.getConnection();
	            data = EXhandler.findOrganModifyData(conn,id);
	            //获取所有国家信息
	            GJList = EXhandler.findCountryList(conn);
	            String codeId = "GJList";
	            GJList.setCodeSortId(codeId);
	            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
	            map.put(codeId, GJList);
	            setAttribute(Constants.CODE_LIST, map);
	            //服务项目 代码集
	            FWXMList = EXhandler.findCodesortListById(conn, "FWXM");
	        } catch (Exception e) {
	            log.logError("转去查看组织备案信息时出错!", e);
	        } finally {
	            try {
	                if (conn != null && !conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                log.logError("转去查看组织备案信息时关闭Connection出错!", e);
	            }
	        }
	        setAttribute("data", data);
	        setAttribute("FWXMList", FWXMList);
	        return retValue;
	}
	//********机构备案信息end************
	
	//更新纪录列表
	public String organUpdateList(){
		String type = getParameter("type","");
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CUI_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
		String ID = getParameter("ID");
        DataList dataList = new DataList();
        Data updateData = new Data();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在华联系人信息
            dataList = handler.findOrganUpdateList(conn,ID,pageSize, page,orderString);
            if(ID != null && !"".equals(ID)){
            	updateData.add("CUI_ID", ID);
            }
        } catch (Exception e) {
            log.logError("查询更新纪录时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询跟新纪录时关闭Connection出错!", e);
            }
        }
        //更新list
        setAttribute("dataList", dataList);
        setAttribute("data",updateData);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return retValue;
        }
	}
	
	
	//**************机构维护英文版****************
	public String linkManOrganListEn(){
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        String id = getParameter("ID");   //收养组织ID
        String linkManId = getParameter("linkManId");  //获得从保存方法中得到的linkManId
        Data linkMan = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在华联系人信息
            dataList = handler.findLinkManOrganList(conn ,id, pageSize, page,orderString);
            
            if(linkManId != null && !"".equals(linkManId)){
            	linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
            }
        } catch (Exception e) {
            log.logError("查询在华联系人时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询在华联系人时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute("ID", id);
        setAttribute("data", linkMan);
        //联系人list
        setAttribute("dataList", dataList);
        return retValue;
	}
	
	public String linkManModifyEn(){
		Data linkMan = new Data();
		String linkManId = getParameter("linkManId");  //联系人ID
		String ID = getParameter("ID","");   //组织ID
		try {
			conn = ConnectionManager.getConnection();
			linkMan.add("ADOPT_ORG_ID", ID);   //组织机构ID
			if(linkManId != null && !"".equals(linkManId)){
				linkMan.setEntityName("MKR_ORG_CONTACTS");
            	linkMan.setPrimaryKey("ID");
            	linkMan.add("ID", linkManId);
            	linkMan = handler.findDataByKey(conn,linkMan);
			}
		} catch (DBException e) {
			log.logError("转去修改联系人时出错!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改联系人时关闭Connection出错!", e);
			}
		}
		setAttribute("data", linkMan);
		return retValue;
	}
	
	public String linkManModifySubmitEn() throws SQLException, IOException{
		Map map = getDataWithPrefix("MKR_", false);
		Data linkManData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			linkManData.setEntityName("MKR_ORG_CONTACTS");
			linkManData.setPrimaryKey("ID");   //联系人主键ID
			String linkManId = linkManData.getString("ID","");  //联系人主键
			String PER_RESUME = linkManData.getString("PER_RESUME");
			String COMMITMENT_ITEM = linkManData.getString("COMMITMENT_ITEM");
			if(linkManId != null && !"".equals(linkManId)){
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				handler.modify(conn,linkManData);
				handler.modify_empty(conn,linkManId,PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}else{
				linkManData.remove("PER_RESUME");
				linkManData.remove("COMMITMENT_ITEM");
				Data resultData = handler.add(conn,linkManData);
				handler.modify_empty(conn, resultData.getString("ID"),PER_RESUME,COMMITMENT_ITEM);
				setAttribute("m","ok");
				setAttribute("type","linkMan");
				setAttribute("ADOPT_ORG_ID",linkManData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("转去修改联系人时出错!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改联系人时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	public String organNullEn(){
		String m = (String)getAttribute("m");
		String ID = (String)getAttribute("ADOPT_ORG_ID");
		String type = (String)getAttribute("type");
		if(m!=null && m!=""){
			if(m.equals("ok") && m!=null){
				setAttribute("m","ok");
				setAttribute("ADOPT_ORG_ID",ID);
				setAttribute("type",type);
			}
		}
		return retValue;
	}
	
	public String deleteLinkManEn(){
		//1.获取要删除信息的ID
		String ID = getParameter("linkManId");
		try {
			//2.获取数据库链接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.删除数据
			Data linkMan = new Data();
			linkMan.setEntityName("MKR_ORG_CONTACTS");
			linkMan.setPrimaryKey("ID");   //联系人主键ID
			linkMan.add("ID", ID);
			handler.delete(conn,linkMan);
			dt.commit();
		} catch (Exception e) {
			//4.设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "删除联系人操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
		}finally{
		//5.关闭数据库链接
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	public String aidProjectOrganListEn(){
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        String id = getParameter("ID");   //收养组织ID
        String aidProjectId = getParameter("aidProjectId");  //获得从保存方法中得到的项目ID
        Data aidProject = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在援助或捐赠项目信息
            dataList = handler.findAidProjectOrganList(conn ,id, pageSize, page,orderString);
            
            if(aidProjectId != null && !"".equals(aidProjectId)){
            	aidProject.setEntityName("MKR_ORG_AIDPROJECT");
            	aidProject.setPrimaryKey("ID");
            	aidProject.add("ID", aidProjectId);
            	aidProject = handler.findDataByKey(conn,aidProject);
            }
        } catch (Exception e) {
            log.logError("查询在华联系人时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询在华联系人时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute("ID", id);
        setAttribute("data", aidProject);
        //联系人list
        setAttribute("dataList", dataList);
        return retValue;
	}
	
	public String aidProjectModifyEn(){
		Data aidProject = new Data();
		String aidProjectId = getParameter("aidProjectId");  //捐助或援助项目ID
		String ID = getParameter("ID");   //组织ID
		try {
			conn = ConnectionManager.getConnection();
			aidProject.add("ADOPT_ORG_ID", ID);   //组织机构ID
			if(aidProjectId != null && !"".equals(aidProjectId)){
				aidProject.setEntityName("MKR_ORG_AIDPROJECT");
				aidProject.setPrimaryKey("ID");
				aidProject.add("ID", aidProjectId);
				aidProject = handler.findDataByKey(conn,aidProject);
			}
		} catch (DBException e) {
			log.logError("转去修改捐助或援助项目时出错!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改捐助或援助项目时关闭Connection出错!", e);
			}
		}
		setAttribute("data", aidProject);
		return retValue;
	}
	
	public String aidProjectModifySubmitEn(){
		Map map = getDataWithPrefix("MKR_", false);
		Data aidProjectData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			aidProjectData.setEntityName("MKR_ORG_AIDPROJECT");
			aidProjectData.setPrimaryKey("ID");   //援助或捐赠项目主键ID
			String aidProjectId = aidProjectData.getString("ID","");  //援助或捐赠主键
			if(aidProjectId != null && !"".equals(aidProjectId)){
				handler.modify(conn,aidProjectData);
				//setAttribute("ID", aidProjectData.getString("ID",""));  //援助或捐助项目ID
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,aidProjectData);
				//setAttribute("ID", "");  //新增援助或捐助项目ID为空
				setAttribute("m","ok");
				setAttribute("type","aidProject");
				setAttribute("ADOPT_ORG_ID",aidProjectData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("转去修改援助或捐赠项目时出错!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改援助或捐赠项目时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	public String deleteAidProjectEn(){
		//1.获取要删除信息的ID
		String ID = getParameter("aidProjectId");
		try {
			//2.获取数据库链接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.删除数据
			Data aidProject = new Data();
			aidProject.setEntityName("MKR_ORG_AIDPROJECT");
			aidProject.setPrimaryKey("ID");   //联系人主键ID
			aidProject.add("ID", ID);
			handler.delete(conn,aidProject);
			dt.commit();
		} catch (Exception e) {
			//4.设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "删除援助或捐赠项目操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
		}finally{
		//5.关闭数据库链接
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	} 
	
	public String receptionOrganListEn(){
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        String id = getParameter("ID");   //收养组织ID
        String receptionId = getParameter("receptionId");  //从保存方法中获取在华旅行接待ID
        Data reception = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在援助或捐赠项目信息
            dataList = handler.findReceptionOrganList(conn ,id, pageSize, page,orderString);
            
            if(receptionId != null && !"".equals(receptionId)){
            	reception.setEntityName("MKR_ORG_RECEPTION");   //收养组织在华旅行接待情况信息表
            	reception.setPrimaryKey("ID");
            	reception.add("ID", receptionId);
            	reception = handler.findDataByKey(conn,reception);
            }
        } catch (Exception e) {
            log.logError("查询收养组织在华旅行接待时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询收养组织在华旅行接待时关闭Connection出错!", e);
            }
        }
        //组织机构ID
        setAttribute("ID", id);
        setAttribute("data", reception);
        //联系人list
        setAttribute("dataList", dataList);
        return retValue;
	}
	
	public String receptionModifyEn(){
		Data reception = new Data();
		String receptionId = getParameter("receptionId");  //在华旅行接待ID
		String ID = getParameter("ID");   //组织ID
		try {
			conn = ConnectionManager.getConnection();
			reception.add("ADOPT_ORG_ID", ID);   //组织机构ID
			if(receptionId != null && !"".equals(receptionId)){
				reception.setEntityName("MKR_ORG_RECEPTION");
				reception.setPrimaryKey("ID");
				reception.add("ID", receptionId);
				reception = handler.findDataByKey(conn,reception);
			}
		} catch (DBException e) {
			log.logError("转去修改在华旅行接待时出错!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改在华旅行接待时关闭Connection出错!", e);
			}
		}
		setAttribute("data", reception);
		return retValue;
	}
	
	public String receptionModifySubmitEn(){
		Map map = getDataWithPrefix("MKR_", false);
		Data receptionData = new Data(map);
		try {
			conn = ConnectionManager.getConnection();
			receptionData.setEntityName("MKR_ORG_RECEPTION");
			receptionData.setPrimaryKey("ID");   //在华旅行接待主键ID
			String receptionId = receptionData.getString("ID","");  //在华旅行接待主键
			if(receptionId != null && !"".equals(receptionId)){
				handler.modify(conn,receptionData);
				//setAttribute("ID", receptionData.getString("ID",""));  //联系人ID
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}else{
				handler.add(conn,receptionData);
				//setAttribute("ID", "");  //新增联系人ID为空
				setAttribute("m","ok");
				setAttribute("type","reception");
				setAttribute("ADOPT_ORG_ID",receptionData.getString("ADOPT_ORG_ID",""));
			}
		} catch (DBException e) {
			log.logError("转去修改在华旅行接待时出错!", e);
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改在乎旅行接待时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	public String deleteReceptionEn(){
		//1.获取要删除信息的ID
		String ID = getParameter("receptionId");
		try {
			//2.获取数据库链接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.删除数据
			Data reception = new Data();
			reception.setEntityName("MKR_ORG_RECEPTION");
			reception.setPrimaryKey("ID");   //联系人主键ID
			reception.add("ID", ID);
			handler.delete(conn,reception);
			dt.commit();
		} catch (Exception e) {
			//4.设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "删除在华旅行接待信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
		}finally{
		//5.关闭数据库链接
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
           }
		}
		return "";
	}
	
	public String organUpdateListEn(){
		//分页显示
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CUI_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
		String ID = getParameter("ID");
        DataList dataList = new DataList();
        Data updateData = new Data();
        try {
            conn = ConnectionManager.getConnection();
            //根据收养组织信息ID查找在华联系人信息
            dataList = handler.findOrganUpdateList(conn,ID,pageSize, page,orderString);
            if(ID != null && !"".equals(ID)){
            	updateData.add("CUI_ID", ID);
            }
        } catch (Exception e) {
            log.logError("查询更新纪录时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询跟新纪录时关闭Connection出错!", e);
            }
        }
        //更新list
        setAttribute("dataList", dataList);
        setAttribute("data",updateData);
        return retValue;
	}
	//**********机构维护英文版end*******************
	
	//生成省份树形结构
	 public String provinceTree(){
	        Connection conn = null;
	        //使用CodeList封装查询出来的省份，报括通用的字段CNAME ID PARENT_ID三个字段
	        CodeList dataList = new CodeList();
	        try {
	            conn = ConnectionManager.getConnection();
	    		//查询
	    		dataList = handler.getProvinceTree(conn);
	    		if(dataList!=null&&dataList.size()>0){
	    			for(int i=0;i<dataList.size();i++){
	    				dataList.get(i).setIcon("folder");
	    			}
	    		}
	        } catch (Exception e) {
	            log.logError("生成组织树时出错!", e);
	        } finally {
	            try {
	                if (conn != null && !conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                log.logError("生成组织树时关闭Connection出错!", e);
	            }
	        }
	        setAttribute("dataList", dataList);
	        if(dataList != null && dataList.size() > 0){
	        	Code d = dataList.get(0);
	        	setAttribute("CODE_ID", d.getValue());
	        }
	        return SUCCESS;
	    }
	
	//根据省份查找福利机构
	public String findWelfareList(){
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        String id = getParameter("ID","");   //收养组织ID
        if(id == null || "".equals(id) || "null".equalsIgnoreCase(id)){
        	id = (String)getAttribute("ID");
        }
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            String code = null;
            //根据省份ID查找福利院信息
            if(id != null && !"".equals(id) && !"null".equalsIgnoreCase(id)){
            	code = id.substring(0, 2);
            }
            dataList = handler.findWelfareList(conn ,code, pageSize, page,orderString);
        } catch (Exception e) {
            log.logError("查询安置部福利机构时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("在查询安置部福利机构时关闭Connection出错!", e);
            }
        }
        //福利机构list集合
        setAttribute("dataList", dataList);
        setAttribute("ID", id);
        return retValue;
	}
	
	//tab页面
	public String provinceListMessage(){
		String pro_code = getParameter("pro_code","");//省份
		String ID = getParameter("ID","");  //福利机构ID
		String type = getParameter("type","");
		Data data = new Data();
		data.add("pro_code", pro_code);
		data.add("ID",ID);
		data.add("type",type);
		setAttribute("data", data);
		return retValue;
	}
	
	//跳转到修改页面
	public String toWelfareModif(){
		Data welfareData = new Data();
		Data organData = new Data();
		Data data = new Data();
		String pro_code = getParameter("pro_code","");//省份
		String ID = getParameter("ID","");  //福利机构ID
		String type = getParameter("type","");
		Data temp = new Data();
		temp.add("ID", ID);
		temp.add("pro_code", pro_code);
		temp.add("type", type);
		try {
			conn = ConnectionManager.getConnection();
			welfareData.add("INSTIT_ID", ID);   //福利机构ID
			if(ID != null && !"".equals(ID)){
				//福利机构信息表中的数据
				welfareData.setEntityName("IIM_ORG_INFO");
				welfareData.setPrimaryKey("INSTIT_ID");
				welfareData.add("INSTIT_ID", ID);
				welfareData = handler.findDataByKey(conn,welfareData);
				//pub_organ表中的数据补充福利机构表
				organData.setEntityName("PUB_ORGAN");
				organData.setPrimaryKey("ID");
				organData.add("ID", ID);
				organData = handler.findDataByKey(conn, organData);
			}
			data.add("ID",organData.getString("ID"));  //主见ID
			data.add("CNAME",organData.getString("CNAME"));  //中文名称
			data.add("ENNAME",organData.getString("ENNAME"));  //英文名称
			//省份
			if(organData.getString("ORG_CODE").length()>3){
				String str = organData.getString("ORG_CODE").substring(0, 2);
				String province = str+"0000";
				data.add("PROVINCE_ID",province);
			}
				data.add("ID", ID);  //pub_organ中的ID
			if(welfareData!=null){
				data.add("INSTIT_ID",ID);  //ID
				data.add("PRINCIPAL", welfareData.getString("PRINCIPAL")); //法人
				data.add("CITY_ADDRESS_CN", welfareData.getString("CITY_ADDRESS_CN"));//登记地点_中文
				data.add("CITY_ADDRESS_EN", welfareData.getString("CITY_ADDRESS_EN"));//登记地点_英文
				data.add("DEPT_ADDRESS_CN", welfareData.getString("DEPT_ADDRESS_CN"));//地址_中文
				data.add("DEPT_ADDRESS_EN", welfareData.getString("DEPT_ADDRESS_EN"));//地址_英文
				data.add("DEPT_POST", welfareData.getString("DEPT_POST"));//邮编
				data.add("DEPT_TEL", welfareData.getString("DEPT_TEL"));//电话
				data.add("DEPT_FAX", welfareData.getString("DEPT_FAX"));//传真
				data.add("CONTACT_NAME", welfareData.getString("CONTACT_NAME"));//经办人_姓名
				data.add("CONTACT_NAMEPY", welfareData.getString("CONTACT_NAMEPY"));	//经办人_姓名拼音
				data.add("CONTACT_SEX", welfareData.getString("CONTACT_SEX"));	//经办人_性别
				data.add("CONTACT_CARD", welfareData.getString("CONTACT_CARD"));//经办人_身份证号
				data.add("CONTACT_JOB", welfareData.getString("CONTACT_JOB"));	//经办人_职务
				data.add("CONTACT_TEL", welfareData.getString("CONTACT_TEL"));	//经办人_联系电话
				data.add("CONTACT_MAIL", welfareData.getString("CONTACT_MAIL"));//经办人_邮箱
				data.add("CONTACT_DESC", welfareData.getString("CONTACT_DESC"));	//经办人_备注
				data.add("STATE", welfareData.getString("STATE"));//机构状态
				data.add("PAUSE_USERNAME", welfareData.getString("PAUSE_USERNAME"));		//暂停人姓名
				data.add("PAUSE_DATE", welfareData.getString("PAUSE_DATE"));	//暂停日期
				data.add("CANCLE_USERNAME", welfareData.getString("CANCLE_USERNAME"));//撤销人姓名	
				data.add("CANCLE_DATE", welfareData.getString("CANCLE_DATE"));	//撤销日期
				data.add("REG_USERNAME", welfareData.getString("REG_USERNAME"));	//登记人姓名	
				data.add("REG_DATE", welfareData.getString("REG_DATE"));	//登记日期
				data.add("MODIFY_USERNAME", welfareData.getString("MODIFY_USERNAME"));//最后修改人姓名
				data.add("MODIFY_DATE", welfareData.getString("MODIFY_DATE"));//最后修改日期
			}
		} catch (DBException e) {
			log.logError("转去修改福利机构时出错!",e);
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改福利机构时关闭Connection出错!", e);
			}
		}
		setAttribute("data",data);
		setAttribute("temp", temp);
		if(type.equals("modif")){
			return "modif";
		}else if(type.equals("detail")){
			return "detail";
		}
		return retValue;
	}
	
	//保存对福利机构信息的修改
	public String welfareModifySubmit(){
		String ID = getParameter("pro_code","");  //省份
		String type=getParameter("type","");
		String IDS = getParameter("ID","");
		Map mkr = getDataWithPrefix("MKR_", false);  //福利机构修改信息
		Data mkrData = new Data(mkr);
		String REG_USERNAME = SessionInfo.getCurUser().getPerson().getCName();
		String REG_USERID = SessionInfo.getCurUser().getPerson().getPersonId(); 
		String curDate = DateUtility.getCurrentDate();  //系统时间
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("IIM_ORG_INFO");
			mkrData.setPrimaryKey("INSTIT_ID");
			if(mkrData.getString("INSTIT_ID") != null && !"".equals(mkrData.getString("INSTIT_ID")) && !"null".equalsIgnoreCase(mkrData.getString("INSTIT_ID"))){
				mkrData.remove("ID");
				//最后修改信息
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);  
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("INSTIT_ID", mkrData.getString("ID"));
				mkrData.remove("ID");
				mkrData.add("STATE","1");  //状态：0：撤销 1：有效 9：暂停
				//登记人信息
				mkrData.add("REG_USERNAME", REG_USERNAME);//登记人
				mkrData.add("REG_USERID", REG_USERID);//登记ID
				mkrData.add("REG_DATE",curDate);//登记时间
				//最后修改信息
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.add(conn, mkrData);
			}
			setAttribute("pro_code", ID);
			setAttribute("type", type);
			setAttribute("ID", IDS);
			dt.commit();
		} catch (Exception e) {
			log.logError("转去修改福利机构时出错!", e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("转去修改福利机构时出错，事务回滚!", e);
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改福利机构时关闭Connection出错!", e);
			}
		}
		return retValue;
	}
	
	//删除福利机构信息
	public String toWelfareDel(){
		String pro_code = getParameter("pro_code","");//省份
		//1.获取要删除信息的ID
		String ID = getParameter("INSTER_ID","");
		try {
			//2.获取数据库链接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3.删除数据
			Data welfareData = new Data();
			welfareData.setEntityName("IIM_ORG_INFO");
			welfareData.setPrimaryKey("INSTIT_ID");   //福利机构主键ID
			welfareData.add("INSTIT_ID", ID);
			handler.delete(conn,welfareData);
			dt.commit();
		} catch (Exception e) {
			//4.设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "删除福利机构操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
			retValue = "error1";
		}finally{
		//5.关闭数据库链接
		 if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("OrganSuppAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
           }
		}
		setAttribute("pro_code", pro_code);
		return retValue;
	}
	
	//根据组织机构查找福利机构
	public String findWelfareByOrgan(){
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        /************获取数据库排序标示--开始***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="ADOPT_ORG_ID";   //根据收养组织ID排序
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************获取数据库排序标示--结束***************/
        //String id = getParameter("ID","");   //收养组织ID
		UserInfo userInfo = SessionInfo.getCurUser();
		String id = userInfo.getCurOrgan().getOrgCode();
        if(id == null || "".equals(id) || "null".equalsIgnoreCase(id)){
        	id = (String)getAttribute("ID");
        }
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            String code = null;
            //根据省份ID查找福利院信息
            if(id != null && !"".equals(id) && !"null".equalsIgnoreCase(id)){
            	code = id.substring(0, 2);
            }
            dataList = handler.findWelfareList(conn ,code, pageSize, page,orderString);
        } catch (Exception e) {
            log.logError("查询安置部福利机构时出错!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("在查询安置部福利机构时关闭Connection出错!", e);
            }
        }
        //福利机构list集合
        setAttribute("dataList", dataList);
        setAttribute("ID", id);
        return retValue;
	}
	
	/**
	 * 用户修改组织机构  
	 * 福利院
	 * @return
	 */
	public String toModifWelfareById(){
		Data organData = new Data();
		UserInfo userInfo = SessionInfo.getCurUser();
		String ID = userInfo.getCurOrgan().getId();   //组织机构ID
		try {
			conn=ConnectionManager.getConnection();
			organData = handler.findWelfareById(conn, ID);
		} catch (DBException e) {
			e.printStackTrace();
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改福利机构时关闭Connection出错!", e);
			}
		}
		String org_code = organData.getString("ORG_CODE");  //机构代码
		String province_id = organData.getString("PROVINCE_ID");  //省份代码
		 if(province_id == null || "".equals(province_id) || "null".equalsIgnoreCase(province_id)){
			 organData.remove("PROVINCE_ID");
			 province_id = org_code.substring(0, 2)+"0000";
			 organData.add("PROVINCE_ID", province_id);
		 }
		setAttribute("data",organData);
		return retValue;
	}
	
	/**
	 * 福利院
	 * 保存用户修改内容
	 * @return
	 */
	public String WelfareByIdSubmit(){
		Map mkr = getDataWithPrefix("MKR_", false);  //福利机构修改信息
		Data mkrData = new Data(mkr);
		String REG_USERNAME = SessionInfo.getCurUser().getPerson().getCName();
		String REG_USERID = SessionInfo.getCurUser().getPerson().getPersonId(); 
		String curDate = DateUtility.getCurrentDate();  //系统时间
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("IIM_ORG_INFO");
			mkrData.setPrimaryKey("INSTIT_ID");
			if(mkrData.getString("INSTIT_ID") != null && !"".equals(mkrData.getString("INSTIT_ID")) && !"null".equalsIgnoreCase(mkrData.getString("INSTIT_ID"))){
				mkrData.remove("ID");
				//最后修改信息
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);  
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("INSTIT_ID", mkrData.getString("ID"));
				mkrData.remove("ID");
				mkrData.add("STATE","1");  //状态：0：撤销 1：有效 9：暂停
				//登记人信息
				mkrData.add("REG_USERNAME", REG_USERNAME);//登记人
				mkrData.add("REG_USERID", REG_USERID);//登记ID
				mkrData.add("REG_DATE",curDate);//登记时间
				//最后修改信息
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.add(conn, mkrData);
			}
			dt.commit();
		} catch (Exception e) {
			log.logError("转去修改福利机构时出错!", e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("转去修改福利机构时出错，事务回滚!", e);
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改福利机构时关闭Connection出错!", e);
			}
		}
		return SUCCESS;
	}
	
	/**
	 * 用户修改组织机构  
	 * 省厅
	 * @return
	 */
	public String toModifProvinceById(){
		Data organData = new Data();
		UserInfo userInfo = SessionInfo.getCurUser();
		String ID = userInfo.getCurOrgan().getId();   //组织机构ID
		try {
			conn=ConnectionManager.getConnection();
			organData = handler.findWelfareById(conn, ID);
		} catch (DBException e) {
			e.printStackTrace();
		}finally{
			try {
				if(conn != null && !conn.isClosed()){
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改福利机构时关闭Connection出错!", e);
			}
		}
		String org_code = organData.getString("ORG_CODE");  //机构代码
		String province_id = organData.getString("PROVINCE_ID");  //省份代码
		 if(province_id == null || "".equals(province_id) || "null".equalsIgnoreCase(province_id)){
			 organData.remove("PROVINCE_ID");
			 province_id = org_code.substring(0, 2)+"0000";
			 organData.add("PROVINCE_ID", province_id);
		 }
		setAttribute("data",organData);
		return retValue;
	}
	
	/**
	 * 省厅
	 * 保存用户修改内容
	 * @return
	 */
	public String PrivinceByIdSubmit(){
		Map mkr = getDataWithPrefix("MKR_", false);  //福利机构修改信息
		Data mkrData = new Data(mkr);
		String REG_USERNAME = SessionInfo.getCurUser().getPerson().getCName();
		String REG_USERID = SessionInfo.getCurUser().getPerson().getPersonId(); 
		String curDate = DateUtility.getCurrentDate();  //系统时间
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("IIM_ORG_INFO");
			mkrData.setPrimaryKey("INSTIT_ID");
			if(mkrData.getString("INSTIT_ID") != null && !"".equals(mkrData.getString("INSTIT_ID")) && !"null".equalsIgnoreCase(mkrData.getString("INSTIT_ID"))){
				mkrData.remove("ID");
				//最后修改信息
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);  
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("INSTIT_ID", mkrData.getString("ID"));
				mkrData.remove("ID");
				mkrData.add("STATE","1");  //状态：0：撤销 1：有效 9：暂停
				//登记人信息
				mkrData.add("REG_USERNAME", REG_USERNAME);//登记人
				mkrData.add("REG_USERID", REG_USERID);//登记ID
				mkrData.add("REG_DATE",curDate);//登记时间
				//最后修改信息
				mkrData.add("MODIFY_USERNAME", REG_USERNAME);
				mkrData.add("MODIFY_USERID", REG_USERID);
				mkrData.add("MODIFY_DATE",curDate);
				handler.add(conn, mkrData);
			}
			dt.commit();
		} catch (Exception e) {
			log.logError("转去修改福利机构时出错!", e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("转去修改福利机构时出错，事务回滚!", e);
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("转去修改福利机构时关闭Connection出错!", e);
			}
		}
		return SUCCESS;
	}
	
	
	@Override
	public String execute() throws Exception {
		return null;
	}
}
