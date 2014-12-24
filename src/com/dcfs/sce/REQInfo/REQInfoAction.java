package com.dcfs.sce.REQInfo;

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
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.dcfs.sce.preApproveAudit.PreApproveAuditHandler;
import com.dcfs.sce.publishManager.PublishManagerConstant;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.util.UtilDate;


public class REQInfoAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(REQInfoAction.class);
    private Connection conn = null;
    private REQInfoHandler handler;
    private PublishManagerHandler PMhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public REQInfoAction() {
        this.handler=new REQInfoHandler();
        this.PMhandler=new PublishManagerHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * @Description: 收养组织撤销预批列表
     * @author: lihf
     */
    public String SYZZREQInfoList(){
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
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","REVOKE_REQ_DATE_START","REVOKE_REQ_DATE_END","REVOKE_CFM_DATE_START","REVOKE_CFM_DATE_END","REVOKE_STATE");
        if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
        	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
        	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
        }

        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            UserInfo user = SessionInfo.getCurUser();
            String organCode = user.getCurOrgan().getOrgCode();
            //5 获取数据DataList
            DataList dl=handler.findREQInfoList(conn,data,organCode,pageSize,page,compositor,ordertype);
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
     * @Description: 收养组织预批申请列表
     * @author: lihf
     */
    public String SYZZREQInfoApplicatList(){
    	String type = getParameter("type","");
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
       Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","REQ_DATE_START","REQ_DATE_END","RI_STATE","SUBMIT_DATE_START","SUBMIT_DATE_END","REMINDERS_STATE","REM_DATE_START","REM_DATE_END","REGISTER_DATE_START","REGISTER_DATE_END","FILE_NO","LAST_UPDATE_DATE_START","LAST_UPDATE_DATE_END","PASS_DATE_START","PASS_DATE_END");
       if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
       	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
       }
       if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
       	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
       }
       if(type.equals("one")){
    	   data = new Data();
       }
       try {
           //4 获取数据库连接
           conn = ConnectionManager.getConnection();
           UserInfo user = SessionInfo.getCurUser();
           String organCode = user.getCurOrgan().getOrgCode();
           //5 获取数据DataList
           DataList dl=handler.findREQInfoApplicatList(conn,data,organCode,pageSize,page,compositor,ordertype);
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
     * @Description: 跳转到填写收养组织申请撤销原因页面
     * @author: lihf
     */
    public String SYZZREQInfoReason(){
    	String id = getParameter("id");//申请撤销的RI_ID
    	//获取当前时间
    	Date now = new Date();  
    	//用DateFormat.getDateInstance()格式化时间后为：2012-1-29  
    	DateFormat d1 = DateFormat.getDateInstance();       
    	String str1 = d1.format(now); 
    	try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.findREQInfoReason(conn, id);
            data.add("REVOKE_REQ_DATE",str1);  //系统时间
            //系统当前登录用户
            UserInfo user = SessionInfo.getCurUser();
            String personId = user!=null?(user.getPerson()!=null?user.getPerson().getPersonId():""):"";
            String personName = user!=null?(user.getPerson()!=null?user.getPerson().getCName():""):"";
            data.add("REVOKE_REQ_USERNAME",personName);
            data.add("REVOKE_REQ_USERID",personId);
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
                        log.logError("REQInfoAction的REQInfoReason.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
   }
    
    /**
     * @Description: 收养组织添加申请撤销原因
     * @author: lihf
     */
    public String SYZZREQInfoAddReason(){
    	Data data = getRequestEntityData("S_","RI_ID","REVOKE_REASON","REVOKE_REQ_DATE","REVOKE_REQ_USERID","REVOKE_REQ_USERNAME");
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			data.add("REVOKE_STATE", "0");//撤销状态修改为待确认
			handler.findREQInfoAddReason(conn, data);
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
    
    /**
     * @Description: 收养组织申请撤销查看
     * @author: lihf
     */
    public String SYZZREQInfoSearchById(){
    	String id = getParameter("id");//申请撤销的RI_ID
    	try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.findREQInfoSearchById(conn, id);
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
                        log.logError("REQInfoAction的REQInfoSearchById.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }

    /**
     * @Description: 安置部预批撤销列表
     * @author: lihf
     */
    public String AZBREQInfoList(){
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
        Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_NAME_CN","MALE_NAME","FEMALE_NAME","NAME","REVOKE_REQ_DATE_START","REVOKE_REQ_DATE_END","REVOKE_CFM_DATE_START","REVOKE_CFM_DATE_END","REVOKE_STATE","ADOPT_ORG_ID");
        //将男、女收养人姓名转化为大写
        if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
        	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
        	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
        }

        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findAZBREQInfoList(conn,data,pageSize,page,compositor,ordertype);
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
     * @Description: 转到安置部预批撤销确认页面
     * @author: lihf
     */
    public String AZBREQInfoSearchById(){
    	String ids = getParameter("id");//确认信息ID
    	String id=ids.split(",")[0];
    	String type=getParameter("type");//查看或者是修改
    	try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            Data data = handler.findAZBREQInfoSearchById(conn, id);
            String personName = SessionInfo.getCurUser().getPerson().getCName();
    	 	String curDate = DateUtility.getCurrentDate();
//    	 	data.add("PUB_TYPE", "");
//    	 	data.add("PUB_MODE", "");
    	 	data.add("COUNTRY_CODE_NAME",data.getString("COUNTRY_CODE"));
    	 	data.add("COUNTRY_CODE", "");
//    	 	data.add("PUB_ORGID", "");
//    	 	data.add("ADOPT_ORG_NAME", "");
//    	 	data.add("TMP_TMP_PUB_ORGID_NAME", "");
//    	 	data.add("PUB_REMARKS", "");
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
                        log.logError("REQInfoAction的AZBREQInfoSearchById因出现异常，未能关闭",e);
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
     * @Description: 安置部撤销申请确认
     * @author: lihf
     * @throws ParseException
     * @throws NumberFormatException
     * @throws SQLException
     */
    public String AZBReqInfoconfirm() throws NumberFormatException, ParseException, SQLException{
    	//1 获得页面表单数据，构造数据结果集
		//1 获取操作人基本信息及系统日期
    	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
    	String RI_ID = getParameter("RI_ID");
    	Data hiddenData = getRequestEntityData("H_","CI_ID","SPECIAL_FOCUS","AF_ID");  //儿童data
    	Data dfData = getRequestEntityData("c_","isPublish","PUB_ID","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE","PUB_REMARKS","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL"); //点发data
    	Data qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//群发data
    	try {
    		//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            
            //4执行数据库处理操作
            String pubType = dfData.getString("PUB_TYPE");//发布类型 1:点发  2:群发
	    	String ciid = hiddenData.getString("CI_ID"); //儿童材料ID;
	    	String isSpecial = hiddenData.getString("SPECIAL_FOCUS");//是否特别关注
	    	//发布记录表信息保存
			Data saveFBData = new Data();//发布记录DATA
    		Data saveETData = new Data();    //儿童材料更新DATA
    		Data ypData = new Data();  //预批data
    		if(dfData.getString("isPublish").equals("1")){
    			//*****重新发布之后原来的发布数据置为无效begin********
    			Data RIData = handler.getRIData(conn, RI_ID);  //预批data
    			//发布记录表
    			String PUB_ID = RIData.getString("PUB_ID");
    			Data fabuData = handler.getPubData(conn, PUB_ID);
    			fabuData.add("PUB_STATE", "9");   //发布状态改为无效。
    			fabuData.add("ADOPT_ORG_ID", "");	//清空锁定组织id
    			fabuData.add("LOCK_DATE", "");	//清空锁定日期
    			handler.savePubData(conn,fabuData);
    			//*****重新发布之后原来的发布数据置为无效end********
	    		//*********保存发布相关信息begin**********
	    		if("1".equals(pubType)||"1"==pubType){
					try {
							saveFBData.add("CI_ID",ciid);//儿童材料ID
				    		saveFBData.add("PUB_TYPE", pubType);//发布类型
							//如果页面选择的是点发
							saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//点发的发布组织
							saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
							saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
							if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
								saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
							}else {//非特别关注
								saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
							}
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
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
	    		//*********保存发布相关信息end**********
	    		
	    		//**********更新儿童材料表相关信息begin**********
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
        		int num = PMhandler.getFbNum(conn, ciid);//获得该儿童发布次数
        		saveETData.add("PUB_NUM", num+1);//发布次数
        		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
        		//**********更新儿童材料表相关信息begin**********
    		}else{
    			saveFBData.add("PUB_ID", dfData.getString("PUB_ID",""));
    			//预批表
    			Data RIData = handler.getRIData(conn, RI_ID);
    			//发布记录表
    			String PUB_ID = RIData.getString("PUB_ID");
    			saveFBData = handler.getPubData(conn, PUB_ID);
    			//儿童材料表
    			String CI_ID = saveFBData.getString("CI_ID");
    			saveETData = handler.getCIData(conn, CI_ID);
    			saveFBData.add("ADOPT_ORG_ID", "");	//清空锁定组织id
    			saveFBData.add("LOCK_DATE", "");	//清空锁定日期
    			//获取安置期限
    			String SETTLE_DATE = saveFBData.getString("SETTLE_DATE");
    			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    			Date SETTLE_DATE1 =  sdf.parse(SETTLE_DATE);
    			Date curDate1 = sdf.parse(curDate);
    			if(SETTLE_DATE1.getTime()>=curDate1.getTime()){
    				saveFBData.add("PUB_STATE","2");  //发布记录表：发布状态改为已发布
    				saveETData.add("PUB_STATE", "2");  //儿童材料表：发布状态改为已发布
    			}else if(SETTLE_DATE1.getTime()<curDate1.getTime()){
    				saveFBData.add("PUB_STATE","9");  //发布记录表：发布状态改为待发布
    				saveETData.add("PUB_STATE", "0");  //儿童材料表：发布状态改为待发布
    			}
    		}
        	//**********更新儿童材料表相关信息end**********
	    	//**************特需预批申请信息更新begin************
    		//获取预批Data
    		Data ypwjData = handler.getRIData(conn, RI_ID);
    		String AF_ID = ypwjData.getString("AF_ID");
    		//根据预批撤销状态和预批状态判断预批
    		String REVOKESTATE = ypwjData.getString("REVOKE_STATE","");
    		String RIState = ypwjData.getString("RI_STATE","");
    		if(REVOKESTATE.equals("0")&&RIState.equals("9")){
    			ypData.add("REVOKE_STATE", "1");  //撤销状态改为已确认1
    		}else{
    			if(AF_ID!=null){
    	    		//获取文件data
    	    		Data wjData = handler.getAFData(conn,AF_ID);
    	    		//根据文件类型判断
    	    		String FILE_TYPE = wjData.getString("FILE_TYPE");
    	    		if(FILE_TYPE.equals("20")||FILE_TYPE.equals("22")){  //特普和特简
    	    			
    	    			wjData.add("RI_ID", null);   //预批记录为null
    	    			wjData.add("RI_STATE", null);  //预批状态null
    	    			wjData.add("CI_ID", null);   //儿童材料null
    	    			
    	    		}else if(FILE_TYPE.equals("21")){   //特转
    	    			
    	    			wjData.add("RI_ID", null);   //预批记录为null
    	    			wjData.add("RI_STATE", null);  //预批状态null
    	    			wjData.add("CI_ID", null);   //儿童材料null
    	    			wjData.add("FILE_TYPE", "10");  //文件类型改为正常
    	    			
    	    		}else if(FILE_TYPE.equals("23")){  //特双
    	    			
    	    			wjData.add("FILE_TYPE", "20");   //文件类型改为特普
    	    			String yp_id = wjData.getString("RI_ID");   //撤销预批ID
    	    			String id1=yp_id.split(",")[0];
    	    			String id2=yp_id.split(",")[1];
    	    			if(RI_ID.equals(id1)){
    	    				wjData.add("RI_ID",id2);   //预批记录减掉预批撤销的ID
    	    			}else if(RI_ID.equals(id2)){
    	    				wjData.add("RI_ID",id1);   //预批记录减掉预批撤销的ID
    	    			}
    	    			//根据CI_ID判断是否是多胞胎儿童
    	    			Data isTwinsData =  handler.getCIData(conn, ciid);
    	    			String IS_TWINS = isTwinsData.getString("IS_TWINS");
    	    			String[] et_id = wjData.getString("CI_ID").split(",");  //CI_ID
        				String str="";
    	    			if(IS_TWINS.equals("1")){  //1：yes是同胞胎兄弟
    	    				//获取其他同胞儿童编号
    	    				String[] TWINS_IDS = isTwinsData.getString("TWINS_IDS").split(",");
    	    				//根据同胞儿童的编号，查找其他儿童CI_ID等其他信息
    	    				DataList twinsList = new DataList();
    	    				for(int i=0;i<TWINS_IDS.length;i++){
    	    					Data d = new Data();
    	    					String CHILD_NO = TWINS_IDS[i];
    	    					d=handler.getCHILDNOData(conn, CHILD_NO);
    	    					twinsList.add(d);
    	    				}
    	    				Data erData = new Data();
    	    				erData.add("CI_ID",ciid);
    	    				twinsList.add(erData);
    	    				for(int i=0;i<et_id.length;i++){
    	    					boolean flag = true;
    	    					for(int j=0;j<twinsList.size();j++){
    	    						String temp=twinsList.getData(j).getString("CI_ID");
    	    						if(et_id[i].equals(temp)){
    	    							flag = false;
    	    							continue;
    	    						}
    	    					}
    	    					if(flag){
    	    						str+=et_id[i]+",";
    	    					}
    	    				}
    	    			}else{
    	    				for(int i=0;i<et_id.length;i++){
    	    					if(!et_id[i].equals(ciid)){
    	    						str+=et_id[i]+",";
    	    					}
    	    				}
    	    			}
    	    			str=str.substring(0, str.length()-1);
        				wjData.add("CI_ID", str);
    	    		}
    	    		//保存文件表
    	    		handler.saveFfsData(conn, wjData);
    	    	}
    			ypData.add("RI_ID",RI_ID );
    			ypData.add("AF_ID",hiddenData.getString("AF_ID"));   //文件ID
    			ypData.add("REVOKE_STATE", "1");  //撤销状态改为已确认1
    			ypData.add("RI_STATE",PreApproveConstant.PRE_APPROVAL_WX); //预批审批状态改为无效9
    			ypData.add("PUB_ID","");   //pubID值为空
    			ypData.add("REVOKE_TYPE", "0");//撤销类型为"组织撤销"
    			ypData.add("REVOKE_CFM_USERID", personId);	//撤销申请确认人id
    			ypData.add("REVOKE_CFM_USERNAME", personName);	//撤销申请确认人姓名
    			ypData.add("REVOKE_CFM_DATE", curDate);	//撤销申请确认日期
    			ypData.add("UNLOCKER_ID", personId);	//解除锁定人id
    			ypData.add("UNLOCKER_NAME", personName);	//解除锁定人姓名
    			ypData.add("UNLOCKER_DATE", curDate);	//解除锁定日期
    			ypData.add("UNLOCKER_TYPE", "2");	//解除锁定类型：中心解除（UNLOCKER_TYPE：0）
    		}
    		//************特需预批申请信息更新end************
			new PreApproveAuditHandler().PreApproveCancelApplySaveForAZB(conn,ypData,saveFBData,saveETData);
			dt.commit();
		}catch (DBException e) {
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
        } finally{
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
