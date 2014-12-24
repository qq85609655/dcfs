package com.dcfs.sce.PUBRecord;

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
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;


public class PUBRecordAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(PUBRecordAction.class);
    private Connection conn = null;
    private PUBRecordHandler handler;
    private PublishManagerHandler PMhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public PUBRecordAction() {
        this.handler=new PUBRecordHandler();
        this.PMhandler=new PublishManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * @Description: 安置部点发退回列表
     * @author: lihf
     */
    public String PUBRecordList(){
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
        Data data = getRequestEntityData("C_","PROVINCE_ID","WELFARE_NAME_CN","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","SPECIAL_FOCUS","PUB_DATE_START","PUB_DATE_END","PUB_MODE","RETURN_TYPE","PUB_ORGID","RETURN_DATE_START","RETURN_DATE_END","RETURN_CFM_DATE_START","RETURN_CFM_DATE_END","RETURN_STATE","PUB_TYPE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findPUBRecordList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Description: 安置部点发退回（查看）
     * @author: lihf
     */
    public String PUBCheck(){
    	String id = getParameter("id");//确认信息ID pub_id
    	try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.findPUBCheck(conn, id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
    	 	data.add("PUB_TYPE", "");
    	 	data.add("PUB_MODE", "");
    	 	Data datacountry = handler.findCountry(conn,data.getString("PUB_ORGI"));
    	 	data.add("COUNTRY_COD", datacountry.getString("COUNTRY_CODE"));  //国家
    	 	data.add("COUNTRY_CODE", "");
    	 	data.add("PUB_ORGID", "");
    	 	data.add("ADOPT_ORG_NAME", "");
    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
    	 	data.add("PUB_REMARKS", "");
    		data.add("PLAN_USERNAME", personName);
    		data.add("PLAN_DATE", curDate);
            setAttribute("data", data);
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AZBAdviceAction的AZBConfirm.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    //安置部点发退回信息查看
    public String returnTypeCheck(){
    	String id = getParameter("id");//确认信息ID pub_id
    	String type=getParameter("type");  //查看类型
    	try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.findPUBCheck(conn, id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
    	 	data.add("PUB_TYPE", "");
    	 	data.add("PUB_MODE", "");
    	 	Data datacountry = handler.findCountry(conn,data.getString("PUB_ORGI"));
    	 	data.add("COUNTRY_COD", datacountry.getString("COUNTRY_CODE"));  //国家
    	 	data.add("COUNTRY_CODE", "");
    	 	data.add("PUB_ORGID", "");
    	 	data.add("ADOPT_ORG_NAME", "");
    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
    	 	data.add("PUB_REMARKS", "");
    		data.add("PLAN_USERNAME", personName);
    		data.add("PLAN_DATE", curDate);
            setAttribute("data", data);
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AZBAdviceAction的AZBConfirm.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
    	if(type.equals("child")){
    		return "child";
    	}else{
    		return "returnShow";
    	}
    }
    
    /**
     * @Description: 安置部点发退回（确认）
     * @author: lihf
     */
    public String PUBConfirm(){
    	String ids = getParameter("id");//确认信息IDS pub_ids
    	String id="";
    	String newStr ="";
    	try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            if(ids!=null){
    	 		id = ids.substring(0, ids.length()-1);
    	 	    newStr = id.replaceAll(",", "','");
    	 		
    	 	}
            DataList dataList = handler.findPUBConfirm(conn, newStr);
            setAttribute("newStr", id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
    	 	setAttribute("List", dataList);
    	 	Data data = dataList.getData(0);
    	 	data.add("PUB_TYPE", "");
    	 	data.add("PUB_MODE", "");
    	 	Data datacountry = handler.findCountry(conn,data.getString("PUB_ORGI"));
    	 	data.add("COUNTRY_COD", datacountry.getString("COUNTRY_CODE"));  //国家
    	 	data.add("COUNTRY_CODE", "");
    	 	data.add("PUB_ORGID", "");
    	 	data.add("ADOPT_ORG_NAME", "");
    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
    	 	data.add("PUB_REMARKS", "");
    		data.add("PLAN_USERNAME", personName);
    		data.add("PLAN_DATE", curDate);
    	 	setAttribute("Data",dataList.getData(0));
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            retValue = "error1";
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AZBAdviceAction的AZBConfirm.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * @Description: 安置部点发退回信息确认退回
     * @author: lihf
     * @throws ParseException 
     * @throws NumberFormatException 
     * @throws SQLException 
     */
    public String PUBReturn() throws NumberFormatException, ParseException, SQLException{
    	//1 获得页面表单数据，构造数据结果集
		//1 获取操作人基本信息及系统日期
    	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	String ids = getParameter("id");   //获取批量提交发布ID(PUB_ID)
	 	String newStr = ids.replace(",", "','");
	 	DataList dataList = new DataList();
	 	
    	Data dfData = getRequestEntityData("c_","isPublish","PUB_ID","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE","PUB_REMARKS","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL"); //点发信息
    	Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//群发data
    	DataList saveFBDataList = new DataList();//发布记录DataList
        DataList saveETDataList = new DataList();//儿童材料DataList
        
    	try {
    		//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            dataList = handler.findCIDataList(conn,newStr);
            //4 执行数据库处理操作
            String isPublish = dfData.getString("isPublish");  //是否继续发布
			String pubType = dfData.getString("PUB_TYPE");//发布类型 1:点发  2:群发
			if(isPublish.equals("1")){
		    	for(int i=0;i<dataList.size();i++){
		    		String ciid = dataList.getData(i).getString("CI_ID");   //儿童材料ID
		    		String isSpecial = dataList.getData(i).getString("SPECIAL_FOCUS");  //是否特别关注
		    		Data saveFBData = new Data();//发布记录DATA
		    		saveFBData.add("CI_ID",ciid);//儿童材料ID
		    		saveFBData.add("PUB_TYPE", pubType);//发布类型
		    		//*********保存儿童发布相关信息begin**********
		    		if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
		    			saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//点发的发布组织
		    			saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
		    			saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
		    			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
		        			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
		        		}else {//非特别关注
		        			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
		        		}
		    		}else{//如果页面选择的是群发
		    			saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//群发的发布组织
		    			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
		        			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
		        		}else {//非特别关注
		        			saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
		        		}
		    		}
		    		saveFBData.add("PUBLISHER_ID",personId);//发布人
		    		saveFBData.add("PUBLISHER_NAME",personName);//发布人姓名
		    		saveFBData.add("PUB_DATE",curDate);//发布日期
		    		saveFBData.add("PUB_STATE",PublishManagerConstant.YFB);//发布状态为"已发布"
		    		saveFBDataList.add(saveFBData);
		    		
		    		Data saveETData = new Data();    //儿童材料更新DATA
		    		saveETData.add("CI_ID", ciid);   //儿童材料ID
		    		saveETData.add("PUB_TYPE", pubType);//发布类型
		    		
		    		if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
		        		saveETData.add("PUB_ORGID", dfData.getString("PUB_ORGID"));//点发发布组织
		        	}else{
		        		saveETData.add("PUB_ORGID", qfData.getString("PUB_ORGID"));//群发发布组织
		        	}
		    		
		    		saveETData.add("PUB_USERID", personId);//发布人ID
		        	saveETData.add("PUB_USERNAME", personName);//发布人名称
		        	saveETData.add("PUB_STATE", PublishManagerConstant.YFB);//发布状态为“已发布”
		        	if(PMhandler.isFirstFb(conn, ciid)){//判断该儿童是否发布过，true:发布过  false:未发布过
		        		int num = PMhandler.getFbNum(conn, ciid);//获得该儿童发布次数
		        		saveETData.add("PUB_NUM", num+1);//发布次数
		        		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
		        	}else{
		        		saveETData.add("PUB_NUM", 1);//发布次数
		        		saveETData.add("PUB_FIRSTDATE", curDate);//首次发布日期
		        		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
		        	}
		        	saveETDataList.add(saveETData);
		    	}
		    	PMhandler.batchSubmitForETFB(conn,saveFBDataList);//生成儿童发布记录信息
		        PMhandler.batchUpdateETCL(conn, saveETDataList);//更新儿童材料信息
			}
	    	//批量处理退回信息
			DataList pubList = new DataList();
			DataList childList = new DataList();
			String[] str = ids.split(",");
			for(int i=0;i<str.length;i++){
				Data data = new Data();
				data.add("RETURN_STATE", "1");//修改退回状态为以确认
				String pub_id = str[i];   //pub_id
				data.add("PUB_ID",pub_id);   //主键
	        	String RETURN_CFM_USERID = SessionInfo.getCurUser().getPerson().getPersonId();  //退回确认人ID	
	        	String RETURN_CFM_USERNAME =SessionInfo.getCurUser().getPerson().getCName();   //退回确认人姓名	
	        	String RETURN_CFM_DATE = curDate;   //退回确认日期		
	        	data.add("RETURN_CFM_USERID",RETURN_CFM_USERID);
	        	data.add("RETURN_CFM_USERNAME",RETURN_CFM_USERNAME);
	        	data.add("RETURN_CFM_DATE",RETURN_CFM_DATE);
	        	pubList.add(data);
	        	Data childData = new Data();
	        	String ci_id = dataList.getData(i).getString("CI_ID");
	        	childData.add("CI_ID", ci_id);
	        	if(isPublish.equals("1")){	   //如果是继续发布，儿童发布状态变为已发布：2     		
	        		childData.add("PUB_STATE","2");   //儿童材料表中的发布状态改为已发布。
	        	}else{
	        		childData.add("PUB_STATE","0");   //儿童材料表中的发布状态改为待发布。
	        	}
	        	childList.add(childData);
	        	
			}
			handler.findSYZZPUBRecordAddReason(conn, pubList);
        	handler.updateChildMessage(conn, childList);
			dt.commit();
		} catch (DBException e) {
			//5 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "文件退回操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            //6 操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
			dt.rollback();
		}catch (SQLException e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
            try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        }  finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//关闭数据库链接
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
    
    /**
     * @Description: 收养组织点发退回查看列表
     * @author: lihf
     */
    public String SYZZPUBRecordList(){
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
        Data data = getRequestEntityData("C_","PROVINCE_ID","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","PUB_DATE_START","PUB_DATE_END","SETTLE_DATE_START","SETTLE_DATE_END","RETURN_DATE_START","RETURN_DATE_END","RETURN_CFM_DATE_START","RETURN_CFM_DATE_END","RETURN_STATE");
        //获取该机构的组织ID
        String ORG_ID = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
        data.add("ORG_ID", ORG_ID);
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findSYZZPUBRecordList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Description: 收养组织点发退回type=show查看type=revise添加点发退回原因
     * @author: lihf
     */
    public String SYZZPUBRecordDetail(){
    	String id = getParameter("PUB_ID");//确认信息ID
    	String type = getParameter("type"); 
    	//获取当前时间
    	Date now = new Date();  
    	//用DateFormat.getDateInstance()格式化时间后为：2012-1-29  
    	DateFormat d1 = DateFormat.getDateInstance();       
    	String str1 = d1.format(now); 
    	try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data d = new Data();
            d.add("PUB_ID", id);
            Data data = handler.findSYZZPUBRecordDetail(conn, d);
            if(type.equals("revise")){
            	data.add("RETURN_DATE", str1);
            	data.add("RETURN_TYPE", "1");
            }
            setAttribute("data", data);
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("AZBAdviceAction的AZBConfirm.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        if(type.equals("show")){
        	return "show";
        }else {        	
        	return retValue;
        }
    }
    
    /**
     * @Description: 收养组织点发退回原因保存
     * @author: lihf
     */
    public String SYZZPUBRecordAddReason(){
    	Data data = getRequestEntityData("S_","PUB_ID","RETURN_REASON","RETURN_DATE","RETURN_TYPE");
    	DataList dl = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			String person = SessionInfo.getCurUser().getPerson().getCName();
			String personId = SessionInfo.getCurUser().getPerson().getPersonId();
			data.add("RETURN_STATE", "0");//点发退回状态为：0 待确认
			data.add("RETURN_USERID", personId);  //退回人员ID
			data.add("RETURN_USERNAME", person);   //退回人员姓名
			dl.add(data);
			handler.findSYZZPUBRecordAddReason(conn, dl);
			dt.commit();
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				dt.setAutoCommit();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//关闭数据库链接
			if (conn!=null){
                try {
					if(!conn.isClosed()){
					    conn.close();
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            }
		}
    	return retValue;
    }
    
}
