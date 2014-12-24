package com.dcfs.mkr.MAINCountry;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import base.task.token.Request;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.sce.PUBRecord.PUBRecordAction;
import com.dcfs.sce.PUBRecord.PUBRecordHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;

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
import hx.util.InfoClueTo;

public class MAINCountryAction extends BaseAction{

	
	private static Log log=UtilLog.getLog(MAINCountryAction.class);
    private Connection conn = null;
    private MAINCountryHandler handler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public MAINCountryAction() {
        this.handler=new MAINCountryHandler();
    }
	
    @Override
	public String execute() throws Exception {
		return null;
	}
    
	// 生成国家树形结构
    public String mainCountryTree(){
        //使用CodeList封装查询出来的组织信息，报括通用的字段CNAME ID PARENT_ID三个字段
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            String COUNTRY_CODE = getParameter("COUNTRY_CODE",null);
            if(COUNTRY_CODE==null){
            	//查询
                dataList = handler.getMainCountryTree(conn);
                COUNTRY_CODE = dataList.get(0).getValue();
                setAttribute("COUNTRY_CODE", COUNTRY_CODE);
            }
        } catch (Exception e) {
            log.logError("生成树时出错!", e);
            retValue = "error1";
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("生成组织树时关闭Connection出错!", e);
            }
        }
        //传递树
        setAttribute("dataList", dataList);
        return retValue;
    }
    
    //查找国家信息
    public String findCountry(){
    	String m = getParameter("m");
    		try {
    			String COUNTRY_CODE = (String) getAttribute("COUNTRY_CODE"); //getParameter("COUNTRY_CODE");
    			if(COUNTRY_CODE==null){
    				COUNTRY_CODE=getParameter("COUNTRY_CODE");
    			}
    			conn = ConnectionManager.getConnection();
    			String ID="";
    			if(COUNTRY_CODE==null||COUNTRY_CODE.equals("0")){
    				CodeList dataList = handler.getMainCountryTree(conn);
            		ID = dataList.get(0).getValue();
    			}else{
    				ID=COUNTRY_CODE;
    			}
    			//根据国家ID查找国家的基本信息
				Data countryData = handler.findCountryMessage(conn, ID);
				setAttribute("data", countryData);
				setAttribute("m", m);
			} catch (DBException e) {
				e.printStackTrace();
				retValue = "error1";
			}finally {
	            try {
	                if (conn != null && !conn.isClosed()) {
	                    conn.close();
	                }
	            } catch (SQLException e) {
	                log.logError("查询国家信息时关闭Connection出错!", e);
	            }
	        }
			return retValue;
    }
    
    //根据国家ID查找对应的政府部门
    public String findGovement(){
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
		String ID = (String)getParameter("ID","");
		if(ID==null||ID==""){
			ID=(String)getAttribute("ID");
		}
		try {
			conn = ConnectionManager.getConnection();
			//根据国家的ID查找相关政府部门的信息
    		DataList govementList = handler.findGovement(conn,ID,pageSize,page,compositor,ordertype);
    		String GOV_ID = (String)getParameter("GOV_ID");
    		setAttribute("List", govementList);
    		setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            setAttribute("COUNTRY_CODE", ID);
            setAttribute("GOV_ID", GOV_ID);
		} catch (DBException e) {
			//7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            retValue = "error1";
		}finally {
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
    
    //根据国家ID完善，修改国家信息
    public String reviseCountry(){
    	Data data = getRequestEntityData("C_","COUNTRY_CODE","CURRENCY","CONVENTION","SOLICIT_SUBMISSIONS","SEQ_NO");
    	try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			handler.findReviseCountry(conn, data);
			String COUNTRY_CODE=data.getString("COUNTRY_CODE");
			setAttribute("COUNTRY_CODE",COUNTRY_CODE);
			dt.commit();
		} catch (DBException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//关闭数据库链接
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
    //根据政府ID查找政府详细信息和联系人信息
    public String findGovementAndContact(){
    	//国家ID
    	String COUNTRY_CODE = getParameter("COUNTRY_CODE","");
    	if(""==COUNTRY_CODE){
    		COUNTRY_CODE = (String)getAttribute("COUNTRY_CODE");
    	}
    	setAttribute("COUNTRY_CODE", COUNTRY_CODE);
    	//根据政府ID查找政府信息
    	try {
			String GOV_ID = getParameter("GOV_ID",null);
			if(GOV_ID==null){
				GOV_ID = (String) getAttribute("GOV_ID");
			}
			setAttribute("GOV_ID", GOV_ID);
			conn = ConnectionManager.getConnection();
			setAttribute("data", new Data());
			//政府职能list
			DataList goveList = handler.findGoveList(conn);
			setAttribute("goveList", goveList);
			if(GOV_ID==null){
				//如果政府信息为空默认显示添加页面
				retValue="govementAdd";
			}else{
				String ID = GOV_ID;
				//根据政府ID查找政府的基本信息
				Data govementData = handler.findGovementMessage(conn, ID);
				String GOVER_FUNCTIONS = govementData.getString("GOVER_FUNCTIONS","");
				if(""!=GOVER_FUNCTIONS&&GOVER_FUNCTIONS.contains(",")){
					String [] str = GOVER_FUNCTIONS.split(",");
					String GOVER_FUNCTIONS0="";
					String GOVER_FUNCTIONS1="";
					String GOVER_FUNCTIONS2="";
					String GOVER_FUNCTIONS3="";
					for(int i=0;i<str.length;i++){
						if(str[i].equals("0")){
							GOVER_FUNCTIONS0="0";
						}
						if(str[i].equals("1")){
							GOVER_FUNCTIONS1="1";
						}
						if(str[i].equals("2")){
							GOVER_FUNCTIONS2="2";
						}
						if(str[i].equals("3")){
							GOVER_FUNCTIONS3="3";
						}
					}
					if(""!=GOVER_FUNCTIONS0){
						govementData.add("GOVER_FUNCTIONS0", GOVER_FUNCTIONS0);
					}
					if(""!=GOVER_FUNCTIONS1){
						govementData.add("GOVER_FUNCTIONS1", GOVER_FUNCTIONS1);
					}
					if(""!=GOVER_FUNCTIONS2){
						govementData.add("GOVER_FUNCTIONS2", GOVER_FUNCTIONS2);
					}
					if(""!=GOVER_FUNCTIONS3){
						govementData.add("GOVER_FUNCTIONS3", GOVER_FUNCTIONS3);
					}
				}
				setAttribute("govementData", govementData);
				//根据政府ID查找联系人的基本信息
				DataList  contactList = handler.findContactMessage(conn,ID);
				setAttribute("contactList",contactList);
			}
		} catch (DBException e) {
			e.printStackTrace();
			retValue = "error1";
		}finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("查询政府，联系人信息时关闭Connection出错!", e);
            }
        }
		return retValue;
    }

    //修改政府部门信息
    public String reviseGovement(){
    	//Data data = getRequestEntityData("G_","GOV_ID","NAME_CN","NAME_EN","NATURE","GOVER_FUNCTIONS0","GOVER_FUNCTIONS1","GOVER_FUNCTIONS2","GOVER_FUNCTIONS3","HEAD_NAME","HEAD_PHONE","HEAD_EMAIL","WEBSITE","ADDRESS","REG_DATE","SEQ_NO");
    	Map map = getDataWithPrefix("G_", false);
    	Data data = new Data(map);
    	try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//查找政府职能信息
			DataList dl = handler.findGoveList(conn);
			//有多少条数据，就获得多少条信息
			Data da = new Data();
			StringBuffer GOVER_FUNCTION = new StringBuffer();
			for(int i=0;i<dl.size();i++){
				String a = data.getString("GOVER_FUNCTIONS"+i,"");
				String s = String.valueOf(i);
				if(!"".equals(a)){
					da.add(s, a);
				}
			}
			//拼装数据
			StringBuffer GOVER_FUNCTIONS = new StringBuffer();
			for(int j=0;j<dl.size();j++){
				String  v = da.getString((String.valueOf(j)));
				if(!"".equals(v)&&v!=null){
					GOVER_FUNCTIONS.append(v+",");
				}
			}
			String gf = GOVER_FUNCTIONS.toString();
			String gfs="";
			if(gf.length()>=2){
				gfs = gf.substring(0, gf.length()-1);
			}
			data.add("GOVER_FUNCTIONS", gfs);
			for(int i=0;i<dl.size();i++){
				data.remove("GOVER_FUNCTIONS"+i);
			}
			//最后修改日期去当前系统时间
			data.add("MOD_DATE", time());
			handler.findReviseGovement(conn, data);
			String GOV_ID=data.getString("GOV_ID");
			String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
			setAttribute("COUNTRY_CODE", COUNTRY_CODE);
			setAttribute("GOV_ID",GOV_ID);
			dt.commit();
		} catch (DBException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//关闭数据库链接
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
    //添加政府部门信息
    public String addGovement(){
    	String COUNTRY_CODE =getParameter("COUNTRY_CODE");
    	Map map = getDataWithPrefix("G_", true);
    	Data data = new Data(map);
    	try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//查找政府职能信息
			DataList dl = handler.findGoveList(conn);
			//有多少条数据，就获得多少条信息
			Data da = new Data();
			StringBuffer GOVER_FUNCTION = new StringBuffer();
			for(int i=0;i<dl.size();i++){
				String a = data.getString("GOVER_FUNCTIONS"+i,"");
				String s = String.valueOf(i);
				if(!"".equals(a)){
					da.add(s, a);
				}
			}
			//拼装数据
			StringBuffer GOVER_FUNCTIONS = new StringBuffer();
			for(int j=0;j<dl.size();j++){
				String  v = da.getString((String.valueOf(j)));
				if(!"".equals(v)&&v!=null){
					GOVER_FUNCTIONS.append(v+",");
				}
			}
			String gf = GOVER_FUNCTIONS.toString();
			String gfs="";
			if(gf.length()>=2){
				gfs = gf.substring(0, gf.length()-1);
			}
			
			data.add("GOVER_FUNCTIONS", gfs);
			data.add("COUNTRY_CODE", COUNTRY_CODE);
			for(int i=0;i<dl.size();i++){
				data.remove("GOVER_FUNCTIONS"+i);
			}
			handler.findAddGovement(conn, data);
			String GOV_ID=data.getString("GOV_ID");
			setAttribute("ID", COUNTRY_CODE);
			setAttribute("GOV_ID",GOV_ID);
			dt.commit();
		} catch (DBException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			//关闭数据库链接
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
            }
		}
    	return "";
    }
    
    //保存联系人信息
    public String addContact() throws IOException{
		try {
			//3 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			String rowNum = this.getParameter("rowNum");
			DataList dataList = new DataList();
			for (int i = 1; i <= Integer.parseInt(rowNum); i++) {
				String CONTACT_NAME = this.getParameter("C_CONTACT_NAME"+i,"");      //联系人姓名
				String CONTACT_POSITION = this.getParameter("C_CONTACT_POSITION"+i,"");    //联系人职位
				String CONTACT_TEL = this.getParameter("C_CONTACT_TEL"+i,"");      //联系人电话
				String CONTACT_EMAIL = this.getParameter("C_CONTACT_EMAIL"+i,"");     //联系人邮箱
				String GOV_ID = this.getParameter("C_GOV_ID","");   //政府ID
				Data contactData = new Data();
				contactData.put("CONTACT_NAME",CONTACT_NAME );	//联系人姓名
				contactData.put("CONTACT_POSITION",CONTACT_POSITION );	//联系人职位
				contactData.put("CONTACT_TEL",CONTACT_TEL );	//联系人电话
				contactData.put("CONTACT_EMAIL",CONTACT_EMAIL );	 //联系人邮箱
				contactData.put("GOV_ID", GOV_ID);	//政府ID
				dataList.add(contactData);
			}
			String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
			String GOV_ID = (String)getParameter("GOV_ID");
			setAttribute("COUNTRY_CODE", COUNTRY_CODE);
			setAttribute("GOV_ID",GOV_ID);
			handler.saveContact(conn, dataList);  //保存联系人信息
			dt.commit();
		} catch (DBException e) {
			//5 设置异常处理
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常[保存操作]:" + e.getMessage(),e);
			}
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
			retValue = "error2";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction的Connection因出现异常，未能关闭",e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}
    
    //删除联系人信息
    public String delContact(){
    	//1 获取要删除的文件ID
		String ID = getParameter("ID", "");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//3 获取删除结果
		    handler.delContact(conn, ID);
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
                        log.logError("MAINCountryAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
		String GOV_ID = (String)getParameter("GOV_ID");
		setAttribute("COUNTRY_CODE", COUNTRY_CODE);
		setAttribute("GOV_ID",GOV_ID);
		return retValue;
    }

    //删除政府信息
    public String delGovement(){
    	//1 获取要删除的文件ID
		String ID = getParameter("ID", "");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//根据政府ID查找联系人信息，删除
			DataList dataList = handler.findContactMessage(conn, ID);
			DataList delData = new DataList();
			for(int i=0;i<dataList.size();i++){
				Data data = dataList.getData(i);
				data.setEntityName("MKR_COUNTRY_GOVMENT_CONTACTS");
				data.setPrimaryKey("ID");
				delData.add(data);
			}
			handler.delContactList(conn, delData);
		    handler.delGovement(conn, ID);
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
                        log.logError("MAINCountryAction的Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        String COUNTRY_CODE = (String)getParameter("COUNTRY_CODE");
		setAttribute("ID", COUNTRY_CODE);
		String m = (String)getParameter("m");
		setAttribute("m", m);
		return retValue;
    }
 
    //获取系统当前时间
    public String time(){
		  Date date=new Date();
		  DateFormat format=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		  String time=format.format(date);
		  return time;
	 }
}
