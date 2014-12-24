package com.dcfs.sce.publishManager;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;


import com.dcfs.common.DateUtil;
import com.dcfs.common.DcfsConstants;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.util.UtilDate;

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

/** 
 * @ClassName: PublishManagerAction 
 * @Description: 发布管理Action
 * @author mayun
 * @date 2014-9-12
 *  
 */
public class PublishManagerAction extends BaseAction {
	
	private static Log log=UtilLog.getLog(PublishManagerAction.class);
	private Connection conn = null;
	private PublishManagerHandler handler;
    private DBTransaction dt = null;//事务处理
	private String retValue = SUCCESS;
	    

	public PublishManagerAction() {
		this.handler=new PublishManagerHandler();
	}

	public String execute() throws Exception {
		return SUCCESS;
	}
	
	
	
	/**
	 * 发布管理查询列表	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-12
	 * @return
	 */
	public String findListForFBGL(){
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒

		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SPECIAL_FOCUS","SN_TYPE","PUB_FIRSTDATE_START","PUB_FIRSTDATE_END","PUB_LASTDATE_START","PUB_LASTDATE_END","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_START","SETTLE_DATE_END","PUB_STATE","ADOPT_ORG_ID2","LOCK_NUM","SUBMIT_DATE_START","SUBMIT_DATE_END","RI_STATE","DISEASE_CN");
		String NAME = data.getString("NAME");
		if(null != NAME){
			data.add("NAME", NAME.toLowerCase());
		}
		
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findListForFBGL(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布管理查询操作异常");
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
						log.logError("PublishManagerAction的findListForFBGL.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	
	/**
	 * 已发布组织列表	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-12
	 * @return
	 */
	public String findListForFBORG(){
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		
		Data hData = getRequestEntityData("H_","PUB_ID");
		String pub_id = getParameter("pub_id");//发布记录ID
		if(null==pub_id||"".equals(pub_id)){
			pub_id = hData.getString("PUB_ID");
		}

		Data data = getRequestEntityData("S_","COUNTRY_CODE","PUB_ORGID");
		
		data.add("PUB_ID", pub_id);
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.findListForFBORG(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "已发布组织列表查询操作异常");
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
						log.logError("PublishManagerAction的findListForFBORG.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	
	/**
	 * 跳转到待发布儿童选择列表	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toChoseETForFB(){
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","SPECIAL_FOCUS","PUB_NUM","PUB_FIRSTDATE_START","PUB_FIRSTDATE_END","PUB_LASTDATE_START","PUB_LASTDATE_END");
		
		String NAME = data.getString("NAME");
		if(null != NAME){
			data.add("NAME", NAME.toLowerCase());
		}
		
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.toChoseETForFB(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "发布管理查询操作异常");
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
						log.logError("PublishManagerAction的toChoseETForFB.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	
	/**
	 * 跳转到发布提交页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toAddFBTJInfo(){
		String ciids = getParameter("ciids");
		setAttribute("ciids", ciids);
		setAttribute("rtfbData", new Data());
		return retValue;
	}
	
	/**
	 * 跳转到发布撤销页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toCancleFB(){
		String pubid = getParameter("pubid");//发布记录主键
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取查看信息结果集
			Data showdata = handler.getEtAndFbInfo(conn, pubid);
			String names = handler.getETNameForTB(conn, showdata.getString("CI_ID"));//获得同胞姓名
			showdata.add("REVOKE_USERNAME", personName);
			showdata.add("REVOKE_USERID", personId);
			showdata.add("REVOKE_DATE", curDate);
			showdata.add("TB_NAME", names);
			//4 变量代入查看页面
			setAttribute("pubid", pubid);
			setAttribute("rtfbData", showdata);
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
		
		
		return retValue;
	}
	
	/**
	 * 跳转到解除锁定页面	
	 * @description 
	 * @author MaYun
	 * @date 2014-9-16
	 * @return
	 */
	public String toUnlockFB(){
		String pubid = getParameter("pubid");//发布记录主键
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
		
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取查看信息结果集
			Data showdata = handler.getYpEtAndFbInfo(conn, pubid);
			String names = handler.getETNameForTB(conn, showdata.getString("CI_ID"));//获得同胞姓名
			showdata.add("UNLOCKER_NAME", personName);
			showdata.add("UNLOCKER_ID", personId);
			showdata.add("UNLOCKER_DATE", curDate);
			showdata.add("UNLOCKER_TYPE", "2");//解除锁定类型为：2 中心解除锁定
			showdata.add("TB_NAME", names);//同胞名称
			//4 变量代入查看页面
			setAttribute("pubid", pubid);//发布主键ID
			setAttribute("riid", showdata.getString("RI_ID"));//预批主键ID
			setAttribute("ciid", showdata.getString("CI_ID"));//儿童材料主键ID
			setAttribute("rtfbData", showdata);
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
		
		
		return retValue;
	}
	
	
	/**
	 * 儿童发布提交
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 * @throws SQLException 
	 */
	public String saveFbInfo() throws NumberFormatException, ParseException, SQLException{
		 //1 获得页面表单数据，构造数据结果集
		//1 获取操作人基本信息及系统日期
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
		Data hiddenData = getRequestEntityData("H_","CIIDS");
        Data  dfData = getRequestEntityData("P_","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");
        Data  qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");
        
        DataList saveFBDataList = new DataList();//发布记录DataList
        DataList saveETDataList = new DataList();//儿童材料DataList
        
        String pubType = dfData.getString("PUB_TYPE");//发布类型 1:点发  2:群发
        String ciids = hiddenData.getString("CIIDS");//儿童材料IDS
        String[] ciidsArray = ciids.split(";");
        
        try {
        	//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 执行数据库处理操作
            
            for(int i =0;i<ciidsArray.length;i++){
        		String[] tempArray = ciidsArray[i].split(",");
        		String ciid = tempArray[0];//儿童材料ID
        		String isSpecial = tempArray[1];//是否特别关注
        		
        		Data saveFBData = new Data();//发布记录DATA
        		saveFBData.add("CI_ID",ciid);//儿童材料ID
        		saveFBData.add("PUB_TYPE", pubType);//发布类型
        		
        		//*********保存儿童发布相关信息begin**********
        		if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
        			saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//点发的发布组织
        			saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
        			saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
        			
        			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
            			//saveFBData.add("SETTLE_DATE",UtilDate.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
            		}else {//非特别关注
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
            		}
        		}else{//如果页面选择的是群发
        			saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//群发的发布组织
        			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
            		}else {//非特别关注
            			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
            		}
        		}
        		
        		saveFBData.add("PUBLISHER_ID",personId);//发布人
        		saveFBData.add("PUBLISHER_NAME",personName);//发布人姓名
        		saveFBData.add("PUB_DATE",curDate);//发布日期
        		saveFBData.add("PUB_STATE",PublishManagerConstant.YFB);//发布状态为"已发布"
            	
            	saveFBDataList.add(saveFBData);
            	//*********保存儿童发布相关信息end**********
            	
            	//**********更新儿童材料表相关信息begin**********
            	Data saveETData = new Data();//儿童材料更新DATA
            	saveETData.add("CI_ID", ciid);//儿童材料ID
            	saveETData.add("PUB_TYPE", pubType);//发布类型
            	
            	if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
            		saveETData.add("PUB_ORGID", dfData.getString("PUB_ORGID"));//点发发布组织
            	}else{
            		saveETData.add("PUB_ORGID", qfData.getString("PUB_ORGID"));//群发发布组织
            	}
            	
            	saveETData.add("PUB_USERID", personId);//发布人ID
            	saveETData.add("PUB_USERNAME", personName);//发布人名称
            	saveETData.add("PUB_STATE", PublishManagerConstant.YFB);//发布状态为“已发布”
            	
            	if(this.handler.isFirstFb(conn, ciid)){//判断该儿童是否发布过，true:发布过  false:未发布过
            		int num = this.handler.getFbNum(conn, ciid);//获得该儿童发布次数
            		saveETData.add("PUB_NUM", num+1);//发布次数
            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
            	}else{
            		saveETData.add("PUB_NUM", 1);//发布次数
            		saveETData.add("PUB_FIRSTDATE", curDate);//首次发布日期
            		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
            	}
            	saveETDataList.add(saveETData);
            	//**********更新儿童材料表相关信息end**********
        	}
        	
	     
        
	        this.handler.batchSubmitForETFB(conn,saveFBDataList);//保存儿童发布记录信息
	        this.handler.batchUpdateETCL(conn, saveETDataList);//保存儿童材料信息
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
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
        } catch (SQLException e) {
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
        } catch (Exception e) {
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
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PublishManagerAction的saveFbInfo的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
        return retValue;
		
	}
	
	/**
	 * 儿童撤销发布提交
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 * @throws SQLException 
	 */
	public String saveCxfbInfo() throws NumberFormatException, ParseException, SQLException{
		 //1 获得页面表单数据，构造数据结果集
		//1 获取操作人基本信息及系统日期
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
	 	Data sData = getRequestEntityData("S_","IS_FB");
		Data hiddenData = getRequestEntityData("H_","PUBID","CI_ID","SPECIAL_FOCUS");//隐藏区域data
		Data etData = new Data();//儿童材料data
        Data  cxfbData = getRequestEntityData("P_","REVOKE_DATE","REVOKE_USERID","REVOKE_USERNAME","REVOKE_REASON");//撤销发布记录data
        Data  dfData = getRequestEntityData("P_","PUB_TYPE","PUB_ORGID","PUB_MODE","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL","PUB_REMARKS");//点发data
        Data  qfData = getRequestEntityData("M_","PUB_ORGID","SETTLE_DATE_SPECIAL","SETTLE_DATE_NORMAL");//群发data
        
        DataList saveFBDataList = new DataList();//发布记录DataList
        DataList saveETDataList = new DataList();//儿童材料DataList
        
        String pubType = dfData.getString("PUB_TYPE");//发布类型 1:点发  2:群发
        String pubid = hiddenData.getString("PUBID");//发布记录ID
        String ciid = hiddenData.getString("CI_ID");//儿童材料ID
        String isSpecial = hiddenData.getString("SPECIAL_FOCUS");//是否特别关注
        
        try {
        	//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 执行数据库处理操作
            
            //***********************不继续进行发布操作begin***********************
            etData.add("CI_ID",ciid);
            etData.add("PUB_STATE", PublishManagerConstant.DFB);//儿童信息表的发布状态为“待发布”
            cxfbData.add("PUB_ID", pubid);//发布记录表的发布主键ID
            cxfbData.add("PUB_STATE", PublishManagerConstant.WX);//发布记录的发布状态为“无效”
            this.handler.updateFbInfo(conn, cxfbData);//更新发布记录信息
            this.handler.updateETCL(conn, etData);//更新儿童材料信息
            //***********************不继续进行发布操作end***********************
            
            //***********************继续进行发布操作begin***********************
            if("1".equals(sData.getString("IS_FB"))||"1"==sData.getString("IS_FB")){//继续发布
             		
             		Data saveFBData = new Data();//发布记录DATA
             		saveFBData.add("CI_ID",ciid);//儿童材料ID
             		saveFBData.add("PUB_TYPE", pubType);//发布类型
             		
             		//*********保存儿童发布相关信息begin**********
             		if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
             			saveFBData.add("PUB_ORGID",dfData.getString("PUB_ORGID"));//点发的发布组织
             			saveFBData.add("PUB_MODE",dfData.getString("PUB_MODE"));
             			saveFBData.add("PUB_REMARKS",dfData.getString("PUB_REMARKS"));
             			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
                 		}else {//非特别关注
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(dfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
                 		}
             		}else{//如果页面选择的是群发
             			saveFBData.add("PUB_ORGID",qfData.getString("PUB_ORGID"));//群发的发布组织
             			if("1".equals(isSpecial)||"1"==isSpecial){//特别关注
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_SPECIAL"))));//安置期限
                 		}else {//非特别关注
                 			saveFBData.add("SETTLE_DATE",DateUtil.getEndDate(curDate,Integer.parseInt(qfData.getString("SETTLE_DATE_NORMAL"))));//安置期限
                 		}
             		}
             		
             		saveFBData.add("PUBLISHER_ID",personId);//发布人
             		saveFBData.add("PUBLISHER_NAME",personName);//发布人姓名
             		saveFBData.add("PUB_DATE",curDate);//发布日期
             		saveFBData.add("PUB_STATE",PublishManagerConstant.YFB);//发布状态为"已发布"
                 	
                 	saveFBDataList.add(saveFBData);
                 	//*********保存儿童发布相关信息end**********
                 	
                 	//**********更新儿童材料表相关信息begin**********
                 	Data saveETData = new Data();//儿童材料更新DATA
                 	saveETData.add("CI_ID", ciid);//儿童材料ID
                 	saveETData.add("PUB_TYPE", pubType);//发布类型
                 	
                 	if("1".equals(pubType)||"1"==pubType){//如果页面选择的是点发
                 		saveETData.add("PUB_ORGID", dfData.getString("PUB_ORGID"));//点发发布组织
                 	}else{
                 		saveETData.add("PUB_ORGID", qfData.getString("PUB_ORGID"));//群发发布组织
                 	}
                 	
                 	saveETData.add("PUB_USERID", personId);//发布人ID
                 	saveETData.add("PUB_USERNAME", personName);//发布人名称
                 	saveETData.add("PUB_STATE", PublishManagerConstant.YFB);//发布状态为“已发布”
                 	
                 	if(this.handler.isFirstFb(conn, ciid)){//判断该儿童是否发布过，true:发布过  false:未发布过
                 		int num = this.handler.getFbNum(conn, ciid);//获得该儿童发布次数
                 		saveETData.add("PUB_NUM", num+1);//发布次数
                 		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
                 	}else{
                 		saveETData.add("PUB_NUM", 1);//发布次数
                 		saveETData.add("PUB_FIRSTDATE", curDate);//首次发布日期
                 		saveETData.add("PUB_LASTDATE", curDate);//末次发布日期
                 	}
                 	saveETDataList.add(saveETData);
                 	//**********更新儿童材料表相关信息end**********
                 	this.handler.batchSubmitForETFB(conn,saveFBDataList);//保存儿童发布记录信息
         	        this.handler.batchUpdateETCL(conn, saveETDataList);//保存儿童材料信息
             	}
            //***********************继续进行发布操作end***********************
            
           
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "数据保存成功!");//保存成功 0
            setAttribute("clueTo", clueTo);
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
        } catch (SQLException e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (Exception e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
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
                        log.logError("PublishManagerAction的saveCxfbInfo的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
        return retValue;
		
	}
	
	
	/**
	 * 解除锁定提交
	 * @description 
	 * @author MaYun
	 * @date Sep 17, 2014
	 * @return
	 * @throws ParseException 
	 * @throws NumberFormatException 
	 * @throws SQLException 
	 */
	public String saveUnlockFbInfo() throws NumberFormatException, ParseException, SQLException{
		 //1 获得页面表单数据，构造数据结果集
		//1 获取操作人基本信息及系统日期
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
		Data hiddenData = getRequestEntityData("H_","PUB_ID","CI_ID","RI_ID");//隐藏区域data
		Data unlockData = getRequestEntityData("P_","UNLOCKER_REASON","UNLOCKER_NAME","UNLOCKER_ID","UNLOCKER_DATE");//解除锁定data
		Data etData = new Data();//儿童材料data
		Data ypData = new Data();//预批data
		Data fbData = new Data();//发布data
		String ciid=hiddenData.getString("CI_ID");//儿童材料主键ID
		String riid=hiddenData.getString("RI_ID");//预批主键ID
		String pubid=hiddenData.getString("PUB_ID");//发布主键ID
		
		etData.add("CI_ID", ciid);
		etData.add("PUB_STATE", PublishManagerConstant.YFB);//发布状态变为已发布
        
		ypData.add("RI_ID", riid);
		ypData.add("UNLOCKER_ID", personId);
		ypData.add("UNLOCKER_NAME", personName);
		ypData.add("UNLOCKER_DATE", curDate);
		ypData.add("UNLOCKER_REASON", unlockData.getString("UNLOCKER_REASON"));
		ypData.add("UNLOCKER_TYPE", "2");//解锁类型为中心解锁
		ypData.add("LOCK_STATE", "1");//锁定状态为已解锁
		ypData.add("RI_STATE", "9");//预批状态为无效
		ypData.add("PUB_ID", "");//对应的发布记录ID置空
		
		fbData.add("PUB_ID", pubid);
		fbData.add("PUB_STATE", PublishManagerConstant.YFB);//发布状态变为已发布
		fbData.add("ADOPT_ORG_ID", "");//锁定组织置为空
		fbData.add("LOCK_DATE", "");//锁定日期置为空
		
   
        
        try {
        	//3 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 执行数据库处理操作
            
            this.handler.updateYpInfo(conn, ypData);//更新预批信息
            this.handler.updateFbInfo(conn, fbData	);//更新发布记录信息
            this.handler.updateETCL(conn, etData);//更新儿童材料信息
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "成功解除锁定!");//保存成功 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 设置异常处理
        	setAttribute(Constants.ERROR_MSG_TITLE, "解除锁定提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            //6 操作结果页面提示
            InfoClueTo clueTo = new InfoClueTo(2, "解除锁定失败!");//保存失败 2
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
            dt.rollback();
        } catch (SQLException e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "解除锁定失败!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch (Exception e) {
            dt.rollback();
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "解除锁定失败!");
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
                        log.logError("PublishManagerAction的saveUnlockFbInfo的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
        return retValue;
		
	}
	
	/**
	 * 查看该儿童历次锁定信息
	 * @description 
	 * @author MaYun
	 * @date 2014-9-24
	 * @return
	 */
	public String showLockHistory(){
		String ciid = getParameter("ciid");//儿童材料ID
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.showLockHistory(conn,ciid);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data","");
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看该儿童历次锁定信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看该儿童历次锁定信息操作异常");
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
						log.logError("PublishManagerAction的showLockHistory.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * 查看该儿童历次发布信息
	 * @description 
	 * @author MaYun
	 * @date 2014-9-24
	 * @return
	 */
	public String showFbHistory(){
		String ciid = getParameter("ciid");//儿童材料ID
		
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.showFbHistory(conn,ciid);
			Data data=handler.getETInfo(conn, ciid);
			String names = handler.getETNameForTB(conn, ciid);
			data.add("TB_NAME", names);//同胞名称
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看该儿童历次发布信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看该儿童历次发布信息操作异常");
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
						log.logError("PublishManagerAction的showFbHistory.Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	
	
	
	public static void main(String arg[]) throws ParseException{
		String curDate = DateUtility.getCurrentDate();
		System.out.println(curDate);
		System.out.println(UtilDate.getEndDate(curDate,2));
	}

}
