package com.dcfs.cms.childUpdate;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
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
import java.util.HashMap;
import java.util.Map;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childAdditional.ChildAdditionAction;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildStateManager;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;

public class ChildUpdateAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(ChildAdditionAction.class);

    private ChildUpdateHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    public ChildUpdateAction(){
        this.handler=new ChildUpdateHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	 /**
	 * 福利院儿童材料更新列表
	 * @return
	 */
    public String updateListFLY(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="UPDATE_DATE";
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 获取查询条件数据
        //查询条件包括：姓名、性别、出生日期、儿童类型、病残种类、体检日期、更新状态、申请日期
 		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END");
 		
 		//获取福利院登录人的福利院Id
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.updateListFLY(conn,oId,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
	 * 省厅儿童材料更新列表
	 * @return
	 */
    public String updateListST(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="UPDATE_DATE";
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 获取查询条件数据
        //查询条件包括：福利院、姓名、性别、出生日期、儿童类型、病残种类、体检日期、更新状态、申请日期
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END");
 		
 		//获取省厅登陆人的组织机构代码
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.updateListST(conn,provinceId,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("provinceId",provinceId);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
	 * 中心（爱之桥）儿童材料更新列表
	 * @return
	 */
    public String updateListZX(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="UPDATE_DATE";
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 获取查询条件数据
        //查询条件包括：省份、福利院、姓名、性别、出生日期、儿童类型、病残种类、体检日期、更新状态、更新日期、更新人
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END","UPDATE_USERNAME");
 		
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.updateListZX(conn,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
	 * 福利院儿童材料更新选择列表 
	 * @return
	 */
    public String updateSelectFLY(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor",null);
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype",null);
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 获取查询条件数据
        //查询条件包括：姓名、性别、出生日期、儿童类型、病残种类、体检日期、报送日期、儿童状态、锁定组织
 		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","SEND_DATE_START","SEND_DATE_END","CI_GLOBAL_STATE","NAME_CN");
 		
 		//获取福利院登录人的福利院Id
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList 
             DataList dl=handler.updateSelectFLY(conn,oId,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
	 * 省厅儿童材料更新选择列表 
	 * @return
	 */
    public String updateSelectST(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor",null);
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype",null);
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 获取查询条件数据
        //查询条件包括：福利院、姓名、性别、出生日期、儿童类型、病残种类、体检日期、报送日期、儿童状态、锁定组织
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","SEND_DATE_START","SEND_DATE_END","CI_GLOBAL_STATE","NAME_CN");
 		
 		//获取省厅登陆人的组织机构代码
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList 
             DataList dl=handler.updateSelectST(conn,provinceId,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("provinceId",provinceId);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
	 * 中心儿童材料更新选择列表（爱之桥办理：对应菜单中的超期查询）
	 * @return
	 */
    public String updateSelectZX(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor",null);
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype",null);
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 获取查询条件数据
        //查询条件包括：省份、福利院、姓名、性别、出生日期、病残种类、体检日期、特别关注、更新次数、发布状态、预批申请状态、登记状态
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","SPECIAL_FOCUS","UPDATE_NUM","PUB_STATE","RI_STATE","ADREG_STATE");
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList 
             DataList dl=handler.updateSelectZX(conn,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
     * 儿童材料更新添加页面
     * @return
     */
    public String toUpdateFLY(){
    	String ci_id = getParameter("CI_ID");
    	String update_type=getParameter("UPDATE_TYPE");
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               Data showdata = handler.getChildInfoById(conn, ci_id);
               UserInfo user=SessionInfo.getCurUser();
               //根据儿童材料的儿童类型和儿童身份获取该类儿童的附件smalltype
               String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
               DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
               //将获取到的附件小类的code值和显示名称以","拼接成字符串
              	String smTypeValues="";
             	String smTypeStrs="";
              	for(int i=0;i<smallTypes.size();i++){
              		Data tmp=smallTypes.getData(i);
              		if(i!=(smallTypes.size()-1)){
              			smTypeValues+=tmp.getString("CODE")+",";
              			smTypeStrs+=tmp.getString("CNAME")+",";
              		}else{
              			smTypeValues+=tmp.getString("CODE");
              			smTypeStrs+=tmp.getString("CNAME");
              		}
              	}
               setAttribute("UPDATE_TYPE", update_type);
               setAttribute("data", showdata);
               setAttribute("pakgId", pakgId);
               setAttribute("smTypeValues", smTypeValues);
               setAttribute("smTypeStrs", smTypeStrs);
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
           } catch (DBException e) {
               e.printStackTrace();
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
                   }
               }
           }
               return SUCCESS;
           }
    
    /**
     * 儿童材料更新信息审核页面
     * @return
     */
    public String toUpdateAudit(){
    	String cua_id = getParameter("CUA_ID");
    	Connection conn = null;
        DataList updateList=new DataList();
        DataList attUpdateDetail=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               //根据更新审核记录主键获取更新信息及儿童材料展示信息
               Data showdata = handler.getShowDataByCuaId(conn, cua_id);
               UserInfo curuser = SessionInfo.getCurUser();
               showdata.add("AUDIT_USERNAME", curuser.getPerson().getCName());
               showdata.add("AUDIT_DATE", DateUtility.getCurrentDate());
               String CUI_ID=showdata.getString("CUI_ID",null);
               if(CUI_ID!=null){
            	   updateList=handler.getUpdateDetail(conn,CUI_ID,"0");
               }
             //将明细列表信息转化成可展示的数据
               for(int i=0;i<updateList.size();i++){
            	   Data detail=updateList.getData(i);
            	   showdata.add("N"+detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
               }
             //获取更新明细信息（更新附件信息）
               if(CUI_ID!=null){
                   attUpdateDetail=handler.getUpdateDetail(conn, CUI_ID,"1");
               }
               UserInfo user=SessionInfo.getCurUser();
               String smTypeUsed="";
               String smTypeUsedStr="";
               String updateTypes="";//更新类型 0覆盖1追加
               if(attUpdateDetail.size()>0){
            	 //根据儿童材料的儿童类型和儿童身份获取该类儿童的附件smalltype
                   String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
                   DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
                   //将获取到的附件小类的code值和显示名称以","拼接成字符串
                  	String smTypeValues="";
                  	for(int i=0;i<smallTypes.size();i++){
                  		Data tmp=smallTypes.getData(i);
                  		if(i!=(smallTypes.size()-1)){
                  			smTypeValues+=tmp.getString("CODE")+",";
                  		}else{
                  			smTypeValues+=tmp.getString("CODE");
                  		}
                  	}
            	   for(int i=0;i<attUpdateDetail.size();i++){
                	   Data attDetail=attUpdateDetail.getData(i);
                	   String field=attDetail.getString("UPDATE_FIELD");
                	   if(smTypeValues.indexOf(field)!=-1){
                		   for(int j=0;j<smallTypes.size();j++){
                         		Data tmp=smallTypes.getData(j);
                         		if(tmp.getString("CODE").equals(field)){
                         			field=tmp.getString("CNAME");
                         			break;
                         		}
                         	}
                		   if(i!=(attUpdateDetail.size()-1)){
                    		   smTypeUsed+=attDetail.getString("UPDATE_FIELD")+",";
                    		   updateTypes+=attDetail.getString("UPDATE_TYPE")+",";
                    		   smTypeUsedStr+=field+",";
                    	   }else{
                    		   smTypeUsed+=attDetail.getString("UPDATE_FIELD");
                    		   updateTypes+=attDetail.getString("UPDATE_TYPE");
                    		   smTypeUsedStr+=field;
                    	   }
                	   }
                	  
                   }
            	   if(smTypeUsed.indexOf(",")!=-1&&(smTypeUsed.lastIndexOf(",")==(smTypeUsed.length()-1))){
            		   smTypeUsed=smTypeUsed.substring(0,smTypeUsed.length()-1);
            		   updateTypes=updateTypes.substring(0,updateTypes.length()-1);
            		   smTypeUsedStr=smTypeUsedStr.substring(0,smTypeUsedStr.length()-1);
            	   }
               }
              
               setAttribute("data", showdata);
               setAttribute("updateList", updateList);
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
               setAttribute("smTypeUsed", smTypeUsed);
               setAttribute("updateTypes", updateTypes);
               setAttribute("smTypeUsedStr", smTypeUsedStr);
           } catch (DBException e) {
               e.printStackTrace();
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
                   }
               }
           }
                return SUCCESS;
           }
    /**
     * 儿童材料更新信息修改页面
     * @return
     */
    public String toModify(){
    	String cui_id = getParameter("CUI_ID");
    	String ci_id = getParameter("CI_ID");
    	String update_type=getParameter("UPDATE_TYPE");//更新级别1
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               //获取儿童基本信息原数据
               Data showdata = handler.getChildInfoById(conn, ci_id);
               //获取更新明细信息（基本信息）
               DataList updateDetail=handler.getUpdateDetail(conn, cui_id,"0");
               //将明细列表信息转化成可展示的数据（儿童基本信息）
               for(int i=0;i<updateDetail.size();i++){
            	   Data detail=updateDetail.getData(i);
            	   showdata.add("N"+detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
               }
               
               UserInfo user=SessionInfo.getCurUser();
               //根据儿童材料的儿童类型和儿童身份获取该类儿童的附件smalltype
               String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
               DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
               //将获取到的附件小类的code值和显示名称以","拼接成字符串
              	String smTypeValues="";
             	String smTypeStrs="";
              	for(int i=0;i<smallTypes.size();i++){
              		Data tmp=smallTypes.getData(i);
              		if(i!=(smallTypes.size()-1)){
              			smTypeValues+=tmp.getString("CODE")+",";
              			smTypeStrs+=tmp.getString("CNAME")+",";
              		}else{
              			smTypeValues+=tmp.getString("CODE");
              			smTypeStrs+=tmp.getString("CNAME");
              		}
              	}
               //获取更新明细信息（更新附件信息）
               DataList attUpdateDetail=handler.getUpdateDetail(conn, cui_id,"1");
               String smTypeUsed="";
               String updateTypes="";//更新类型 0覆盖1追加
               for(int i=0;i<attUpdateDetail.size();i++){
            	   Data attDetail=attUpdateDetail.getData(i);
            	   if(smTypeValues.indexOf(attDetail.getString("UPDATE_FIELD"))!=-1){
            		   if(i!=(attUpdateDetail.size()-1)){
                		   smTypeUsed+=attDetail.getString("UPDATE_FIELD")+",";
                		   updateTypes+=attDetail.getString("UPDATE_TYPE")+",";
                	   }else{
                		   smTypeUsed+=attDetail.getString("UPDATE_FIELD");
                		   updateTypes+=attDetail.getString("UPDATE_TYPE");
                	   }
            	   }
               }
               
               if(smTypeUsed.indexOf(",")!=-1&&(smTypeUsed.lastIndexOf(",")==(smTypeUsed.length()-1))){
        		   smTypeUsed=smTypeUsed.substring(0,smTypeUsed.length()-1);
        		   updateTypes=updateTypes.substring(0,updateTypes.length()-1);
        	   }
               setAttribute("updateDetail", updateDetail);
               setAttribute("CUI_ID", cui_id);
               setAttribute("UPDATE_TYPE", update_type);
               setAttribute("data", showdata);
               setAttribute("pakgId", pakgId);
               setAttribute("smTypeValues", smTypeValues);
               setAttribute("smTypeStrs", smTypeStrs);
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
               setAttribute("smTypeUsed", smTypeUsed);
               setAttribute("updateTypes", updateTypes);
           } catch (DBException e) {
               e.printStackTrace();
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
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * 儿童材料更新详细信息页面的保存、提交省厅、提交中心操作
     * @return
     */
    public String saveUpdateData(){
		//1 获得页面表单数据，构造数据结果集
		Data newData = getRequestEntityData("N_","NCHECKUP_DATE","NID_CARD","NSENDER","NSENDER_ADDR","NPICKUP_DATE","NENTER_DATE","NSEND_DATE","NIS_ANNOUNCEMENT","NANNOUNCEMENT_DATE","NNEWS_NAME","NSN_TYPE","NDISEASE_CN","NIS_PLAN","NIS_HOPE");
		String ci_id=getParameter("CI_ID");
		String cui_id=getParameter("CUI_ID");
		String updtate_state=getParameter("UPDATE_STATE");
		String update_type=getParameter("UPDATE_TYPE");
		Data updateData=new Data();
		String Signal=update_type;
		String[] smallTypes=getParameterValues("smalltype");
		String[] updatetypes=getParameterValues("updatetype");
		if(ChildInfoConstants.LEVEL_CCCWA.equals(update_type)&&cui_id!=null){//如果是中心材料修改操作，操作后需返回至更新查询列表中
        	Signal="3-1";
        }
		//定义变量来记录更新明细信息（当更新级别为中心时，在更新页面点击提交后除了保存更新明细信息外，还需要将信息信息更新到儿童材料基本信息表中）
		DataList updateDetails=new DataList();//基本信息更新明细
		DataList attUpdateDetails=new DataList();//附件信息更新明细
		try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            boolean attSuccess = false;
            //获取儿童材料基本信息原始数据
    	    Data orignalData= handler.getChildInfoById(conn, ci_id);
    	    //如果儿童材料的审核状态为"省不通过"或者"中心不通过"，则不允许更新申请的继续
    	    String aud_state=orignalData.getString("AUD_STATE");
    	    String file_code=orignalData.getString("FILE_CODE");//儿童附件信息的packageId
    	    if(ChildStateManager.CHILD_AUD_STATE_SBTG.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXBTG.equals(aud_state)){
    	    	InfoClueTo clueTo = new InfoClueTo(0, "儿童材料审核不通过，更新申请无效");
                setAttribute("clueTo", clueTo);
        	    return Signal;
    	    }
    	    //先发布附件  如果放在事物提交之后发布会存在问题：如果是中心更新提交时会直接更新附件信息，附件的packageId已变为file_code而不是"N"+file_code,会导致更新的附件因不会被发布二丢失
    	    AttHelper.publishAttsOfPackageId("N"+file_code, "CI"); 
    	    //保存更新记录
    	    UserInfo curuser = SessionInfo.getCurUser();
    	    updateData.add("CUI_ID", cui_id);	//添加更新记录主键
    	    updateData.add("CI_ID", ci_id);	//添加儿童材料基本信息ID
    	    updateData.add("UPDATE_TYPE", update_type);	//添加更新级别
    	    //if(ChildStateManager.CHILD_UPDATE_STATE_SDS.equals(updtate_state)||ChildStateManager.CHILD_UPDATE_STATE_ZXDS.equals(updtate_state)||ChildStateManager.CHILD_UPDATE_STATE_TG.equals(updtate_state)){
    	    	updateData.add("ORG_CODE",curuser.getCurOrgan().getOrgCode());	//添加申请单位机构代码
	    	    updateData.add("ORG_NAME",curuser.getCurOrgan().getCName());	//添加申请单位名称
	    	    updateData.add("UPDATE_USERID",curuser.getPersonId() );//添加申请人ID
	    	    updateData.add("UPDATE_USERNAME",curuser.getPerson().getCName() );	//添加申请人姓名
	    	    updateData.add("UPDATE_DATE", DateUtility.getCurrentDate());	//添加更新申请日期
    	    //}
    	    updateData.add("UPDATE_STATE", updtate_state);	//添加更新状态
    	    handler.saveUpdateData(conn, updateData);
    	    cui_id=updateData.getString("CUI_ID", null);
    	    if(cui_id==null){
    	    	Signal = "error1";
        	    return Signal;
    	    }
    	    //保存更新明细（基本信息）
    	    success=handler.saveUpdateDetail(conn,updateDetails,cui_id,orignalData,newData);
    	    //保存更新明细（附件信息）
    	    attSuccess=handler.saveAttUpdateDetail(conn,attUpdateDetails,smallTypes,updatetypes,cui_id,file_code); 
    	    if (success||attSuccess) {                
	    	      //更新儿童材料基本信息表的更新状态
	        	    Data child=new Data();
	        	    child.add("UPDATE_STATE", updtate_state);
	        	    child.add("CI_ID",ci_id );
	        	    if("3".equals(updtate_state)){//如果是中心更新提交，则直接更新儿童基本信息，不需要进行更新审核 UPDATE_NUM LAST_UPDATE_DATE
		        	       for(int i=0;i<updateDetails.size();i++){
		        	    	   Data tmpData=updateDetails.getData(i);
		        	    	   child.add(tmpData.getString("UPDATE_FIELD"), tmpData.getString("UPDATE_DATA"));
		        	       }
		        	       String numStr=orignalData.getString("UPDATE_NUM",null);
		        	       if(numStr==null){
		        	    	  child.add("UPDATE_NUM",1);
		        	       }else{
		        	    	  child.add("UPDATE_NUM",(Integer.parseInt(numStr)+1));
		        	       }
		        	       child.add("LAST_UPDATE_DATE", DateUtility.getCurrentDate());
		        	       //附件信息的更新
		        	       if(smallTypes!=null){
		        	    	   for(int j=0;j<attUpdateDetails.size();j++){
		        	    		    Data attUpdate=attUpdateDetails.getData(j);
		        	    		    handler.updateAttachment(conn,file_code,attUpdate.getString("UPDATE_FIELD"),attUpdate.getString("UPDATE_TYPE"));
		        	    	   }
		        	       }
	        	    }
	        	    handler.saveChildUpdateState(conn,child);
	        	    //如果是提交省厅或提交中心需要保存一条材料更新审核记录信息
	        	    if("1".equals(updtate_state)||"2".equals(updtate_state)){
	        	    	Data audit=new Data();
	        	    	audit.add("CUI_ID", cui_id);
	        	    	audit.add("OPERATION_STATE", ChildStateManager.OPERATION_STATE_TODO);
	        	    	if("1".equals(updtate_state)){
	        	    	   audit.add("AUDIT_TYPE", ChildInfoConstants.LEVEL_PROVINCE);
	        	    	}else{
	        	    	   audit.add("AUDIT_TYPE", ChildInfoConstants.LEVEL_CCCWA);
	        	    	}
	        	    	handler.saveAuditInfo(conn,audit);
	        	    }
	        	    //设置操作成功后的提示信息
	    	    	String infoStr="";
	    	    	if("0".equals(updtate_state)){
	    	    		infoStr="保存成功";
	    	    	}else if("1".equals(updtate_state)){
	    	    		infoStr="提交省厅成功";
	    	    	}else if("2".equals(updtate_state)){
	    	    		 infoStr="提交中心成功";
	    	    		if("2".equals(update_type)){
	    	    		 infoStr="提交成功";
	    	    		}
	    	    	}else if("3".equals(updtate_state)){
	    	    		infoStr="提交成功";
	    	    	}
	                InfoClueTo clueTo = new InfoClueTo(0, infoStr);
	                setAttribute("clueTo", clueTo);
            }else if((!success)&&smallTypes==null){
            	    dt.rollback();
            	    InfoClueTo clueTo = new InfoClueTo(0, "没有填写更新数据，操作无效");
	                setAttribute("clueTo", clueTo);
	        	    return Signal;
            }
    	   
           dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料更新保存/提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[儿童材料更新保存/提交操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料更新保存/提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("儿童材料更新保存/提交操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }catch(Exception e){
        	//6设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料更新保存/提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("儿童材料更新保存/提交操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ChildUpdateAction的saveUpdateData.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    Signal = "error2";
                }
            }
        }
        return Signal;
	}
    /**
     * 儿童材料更新信息查看页面
     * @return
     */
    public String getShowData(){
    	String uuid = getParameter("UUID");
        Connection conn = null;
        DataList updateList=new DataList();
        DataList attUpdateDetail=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               //获取查看页面的儿童材料展示信息及更新记录信息
               Data showdata = handler.getShowData(conn, uuid);
               String CUI_ID=showdata.getString("CUI_ID",null);
               //获取更新明细信息
               if(CUI_ID!=null){
            	   updateList=handler.getUpdateDetail(conn,CUI_ID,"0");
               }
             //获取更新明细信息（更新附件信息）
               if(CUI_ID!=null){
                   attUpdateDetail=handler.getAttUpdateDetail(conn, CUI_ID);
               }
          /*     if(attUpdateDetail.size()>0){
            	 //根据儿童材料的儿童类型和儿童身份获取该类儿童的附件smalltype
                  // String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(showdata.getString("CHILD_IDENTITY"), showdata.getString("CHILD_TYPE"), false);
                  // DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
        		   for(int j=0;j<attUpdateDetail.size();j++){
        			    Data dat =attUpdateDetail.getData(j);
						String updateType=dat.getString("UPDATE_TYPE","");
						String smallType=dat.getString("UPDATE_FIELD","");
						//更新项目
						for(int k=0;k<smallTypes.size();k++){
	                  		Data tmp=smallTypes.getData(k);
	                  		if(tmp.getString("CODE").equals(smallType)){
	                  			dat.add("UPDATE_FIELD", tmp.getString("CNAME"));
	                  			break;
	                  		}
	                  	}
						//更新类型
						if("0".equals(updateType)){
							dat.add("UPDATE_TYPE","覆盖");
						  }else if("1".equals(updateType)){
							dat.add("UPDATE_TYPE","追加");
						  }
						
        		   }
               }*/
               setAttribute("data", showdata);
               setAttribute("updateList", updateList);
               setAttribute("attUpdateDetail", attUpdateDetail);
           } catch (DBException e) {
               e.printStackTrace();
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
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * 根据儿童材料信息主键获取更新记录信息（更新审核通过的更新信息）
     * @return
     */
    public String getShowDataByCIID(){
    	String CI_ID = getParameter("CI_ID");
        Connection conn = null;
        DataList updateList=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               updateList= handler.getUpdateDataByCIID(conn,CI_ID);
	           if(updateList.size()!=0){
            	   for(int i=0;i<updateList.size();i++){
            		   Data showData=updateList.getData(i);
            		   String CUI_ID=showData.getString("CUI_ID");
            		   DataList updateDetail=handler.getUpdateDetail(conn,CUI_ID,"0");
            		   DataList updateAttDetail=handler.getAttUpdateDetail(conn, CUI_ID);//getUpdateDetail(conn,CUI_ID,"1");
            		   setAttribute("DETAILLIST"+i, updateDetail);
            		   showData.add("DETAILLIST", "DETAILLIST"+i);
            		 //根据儿童材料的儿童类型和儿童身份获取该类儿童的附件smalltype
                      // String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(childData.getString("CHILD_IDENTITY"), childData.getString("CHILD_TYPE"), false);
                     //  DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
            		   for(int j=0;j<updateAttDetail.size();j++){
            			    Data dat =updateAttDetail.getData(j);
							String updateType=dat.getString("UPDATE_TYPE","");
							/*String smallType=dat.getString("UPDATE_FIELD","");
							//更新项目
							for(int k=0;k<smallTypes.size();k++){
		                  		Data tmp=smallTypes.getData(k);
		                  		if(tmp.getString("CODE").equals(smallType)){
		                  			dat.add("UPDATE_FIELD", tmp.getString("CNAME"));
		                  			break;
		                  		}
		                  	}*/
							//更新类型
							if("0".equals(updateType)){
								dat.add("UPDATE_TYPE","覆盖");
							  }else if("1".equals(updateType)){
								dat.add("UPDATE_TYPE","追加");
							  }
							
            		   }
            		   setAttribute("ATTDETAILLIST"+i, updateAttDetail);
            		   showData.add("ATTDETAILLIST", "ATTDETAILLIST"+i);
                    }
               }
               setAttribute("updateList", updateList);
           } catch (DBException e) {
               e.printStackTrace();
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
                   }
               }
           }
               return SUCCESS;
           }
    /**
     * 根据儿童材料信息主键获取更新记录信息（更新审核通过的更新信息）
     * @return
     */
    public String getShowDataByCIIDForAdoption(){
    	String CI_ID = getParameter("CI_ID");
        Connection conn = null;
        DataList updateList=new DataList();
           try {
               conn = ConnectionManager.getConnection();
               updateList= handler.getUpdateDataByCIID(conn,CI_ID);
	           if(updateList.size()!=0){
            	    for(int i=0;i<updateList.size();i++){
            		   Data showData=updateList.getData(i);
            		   String CUI_ID=showData.getString("CUI_ID");
            		   DataList updateDetail=handler.getUpdateDetail(conn,CUI_ID,"0");
            		   DataList updateAttDetail=handler.getAttUpdateDetailEN(conn, CUI_ID);//getUpdateDetail(conn,CUI_ID,"1");
            		   setAttribute("DETAILLIST"+i, updateDetail);
            		   showData.add("DETAILLIST", "DETAILLIST"+i);
            		 //根据儿童材料的儿童类型和儿童身份获取该类儿童的附件smalltype
                      // String pakgId=new ChildCommonManager().getChildPackIdByChildIdentity(childData.getString("CHILD_IDENTITY"), childData.getString("CHILD_TYPE"), false);
                     //  DataList smallTypes=new BatchAttManager().getAttType(conn, pakgId);
            		   for(int j=0;j<updateAttDetail.size();j++){
            			    Data dat =updateAttDetail.getData(j);
							String updateType=dat.getString("UPDATE_TYPE","");
							/*String smallType=dat.getString("UPDATE_FIELD","");
							//更新项目
							for(int k=0;k<smallTypes.size();k++){
		                  		Data tmp=smallTypes.getData(k);
		                  		if(tmp.getString("CODE").equals(smallType)){
		                  			dat.add("UPDATE_FIELD", tmp.getString("CNAME"));
		                  			break;
		                  		}
		                  	}*/
							//更新类型
							if("0".equals(updateType)){
								dat.add("UPDATE_TYPE","覆盖");
							  }else if("1".equals(updateType)){
								dat.add("UPDATE_TYPE","追加");
							  }
							
            		   }
            		   setAttribute("ATTDETAILLIST"+i, updateAttDetail);
            		   showData.add("ATTDETAILLIST", "ATTDETAILLIST"+i);
                    }
               }
               setAttribute("updateList", updateList);
           } catch (DBException e) {
               e.printStackTrace();
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
                   }
               }
           }
               return SUCCESS;
           }
    /**
	 * 省厅儿童材料更新审核列表
	 * @return
	 */
    public String updateAuditListSt(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 获取查询条件数据
        //查询条件包括：福利院、姓名、性别、出生日期、儿童类型、病残种类、体检日期、更新状态、申请日期、审核人、审核时间
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END","AUDIT_USERNAME","AUDIT_DATE_START","AUDIT_DATE_END");
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//获取省厅登陆人的组织机构代码
 	 		UserInfo user=SessionInfo.getCurUser();
 			Organ o=user.getCurOrgan();
 			String oCode=o.getOrgCode();
 			String provinceId=new ChildCommonManager().getProviceId(oCode);
 			//5 获取数据DataList
             DataList dl=handler.updateAuditListSt(conn,provinceId,ChildInfoConstants.LEVEL_PROVINCE,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("provinceId",provinceId);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    
    /**
	 * 中心（安置部）儿童材料更新审核列表
	 * @return
	 */
    public String updateAuditListZX(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按申请日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor=null;
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype=null;
 		}		
 		//3 获取查询条件数据
        //查询条件包括：省份、福利院、姓名、性别、出生日期、儿童类型、病残种类、体检日期、更新状态、申请日期、审核人、审核时间
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","UPDATE_STATE","UPDATE_DATE_START","UPDATE_DATE_END","AUDIT_USERNAME","AUDIT_DATE_START","AUDIT_DATE_END");
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.updateAuditListZX(conn,ChildInfoConstants.LEVEL_CCCWA,data,pageSize,page,compositor,ordertype);
 			//6 将结果集写入页面接收变量
             setAttribute("List",dl);
             setAttribute("data",data);
             setAttribute("compositor",compositor);
             setAttribute("ordertype",ordertype);
             
         } catch (DBException e) {
 		    //7 设置异常处理
 			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
 			setAttribute(Constants.ERROR_MSG, e);
             if (log.isError()) {
                 log.logError("查询操作异常[查询操作]:" + e.getMessage(),e);
             }
         } finally {
 		    //8 关闭数据库连接
             if (conn != null) {
                 try {
                     if (!conn.isClosed()) {
                         conn.close();
                     }
                 } catch (SQLException e) {
                     if (log.isError()) {
                         log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
                     }
                 }
             }
         }
         return  SUCCESS;
     }
    /**
     * 儿童材料更新申请审核操作
     * @return
     */
    public String saveUpdateAudit(){
		//1 获得页面表单数据，构造数据结果集
    	  //获取审核页面提交的最新更新明细信息
		Data newDetail = getRequestEntityData("N_","NCHECKUP_DATE","NID_CARD","NSENDER","NSENDER_ADDR","NPICKUP_DATE","NENTER_DATE","NSEND_DATE","NIS_ANNOUNCEMENT","NANNOUNCEMENT_DATE","NNEWS_NAME","NSN_TYPE","NDISEASE_CN","NIS_PLAN","NIS_HOPE");
		 //获取审核结果及审核意见相关信息
		Data auditInfo= getRequestEntityData("S_","AUDIT_OPTION","AUDIT_CONTENT","AUDIT_REMARKS");//审核记录
		String ci_id=getParameter("CI_ID");
		String cui_id=getParameter("CUI_ID");
		String cua_id=getParameter("CUA_ID");
		String updateType=getParameter("AUDIT_TYPE");//审核级别
		String[] smallTypes=getParameterValues("smalltype");
		String[] updatetypes=getParameterValues("updatetype");
		String Signal=updateType;
		DataList updateDetails=new DataList();
		DataList attUpdateDetail=new DataList();
		try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
            Data updateInf=new Data();//更新记录
            Data childUpdate=new Data();
            String resultInfo="审核成功";
           //获取儿童材料基本信息
    	    Data childInfo= handler.getChildInfoById(conn, ci_id);
            String aud_state=childInfo.getString("AUD_STATE");
            //如果儿童材料的最新审核状态为省不通过或中心不通过则审核通过操作无效
            if("1".equals(auditInfo.getString("AUDIT_OPTION"))&&(ChildStateManager.CHILD_AUD_STATE_SBTG.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXBTG.equals(aud_state))){
            	InfoClueTo clueTo = new InfoClueTo(0, "儿童材料审核不通过，更新审核通过操作无效");
                setAttribute("clueTo", clueTo);
        	    return Signal;
            }
           //先发布附件  如果放在事物提交之后发布会存在问题：如果审核通过会更新附件信息，附件的packageId已变为file_code而不是"N"+file_code,会导致更新的附件因不会被发布而丢失
    	    AttHelper.publishAttsOfPackageId("N"+childInfo.getString("FILE_CODE"), "CI");
            UserInfo curuser = SessionInfo.getCurUser();
            //设置更新审核记录、更新记录、儿童信息
            auditInfo.add("CUA_ID", cua_id);
            auditInfo.add("OPERATION_STATE",ChildStateManager.OPERATION_STATE_DONE);//设置操作状态为已处理
            auditInfo.add("AUDIT_USERID", curuser.getPersonId());
            auditInfo.add("AUDIT_USERNAME", curuser.getPerson().getCName());
            auditInfo.add("AUDIT_DATE", DateUtility.getCurrentDate());
            
            updateInf.add("CUI_ID", cui_id);
            if(ChildInfoConstants.LEVEL_PROVINCE.equals(updateType)){//审审核意见
            	updateInf.add("P_AUD_OPTION",auditInfo.getString("AUDIT_OPTION"));
            	updateInf.add("P_AUD_CONTENT",auditInfo.getString("AUDIT_CONTENT") );
            	updateInf.add("P_AUD_REMARKS",auditInfo.getString("AUDIT_REMARKS") );
            	updateInf.add("P_AUD_USERID",curuser.getPersonId() );
            	updateInf.add("P_AUD_USERNAME",curuser.getPerson().getCName() );
            	updateInf.add("P_AUD_DATE",DateUtility.getCurrentDate() );
            }else if(ChildInfoConstants.LEVEL_CCCWA.equals(updateType)){//中心审核意见
            	updateInf.add("C_AUD_OPTION",auditInfo.getString("AUDIT_OPTION"));
            	updateInf.add("C_AUD_CONTENT",auditInfo.getString("AUDIT_CONTENT") );
            	updateInf.add("C_AUD_REMARKS",auditInfo.getString("AUDIT_REMARKS") );
            	updateInf.add("C_AUD_USERID",curuser.getPersonId() );
            	updateInf.add("C_AUD_USERNAME",curuser.getPerson().getCName() );
            	updateInf.add("C_AUD_DATE",DateUtility.getCurrentDate() );	
            }
            
            childUpdate.add("CI_ID",ci_id );
            
            //获取原始更新明细(基本信息)
             updateDetails=handler.getUpdateDetail(conn,cui_id,"0");
             if("0".equals(auditInfo.getString("AUDIT_OPTION"))){//审核不通过时
            	 updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_BTG);
            	 childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_BTG);
            	 handler.saveAuditInfo(conn, auditInfo);
            	 handler.saveUpdateData(conn, updateInf);
            	 handler.saveChildUpdateState(conn,childUpdate );
            	 //如果有更新附件，则将更新附件进行逻辑删除(package Nfile_code置为Dfile_code)如果不删除则更新信息查看页面更新附件丢失，显示为空白
            	 attUpdateDetail=handler.getUpdateDetail(conn,cui_id,"1");
            	 if(attUpdateDetail.size()>0){
            		 for(int j=0;j<attUpdateDetail.size();j++){
       	    		    Data attUpdate=attUpdateDetail.getData(j);
       	    		    handler.changeUpdateAttPackagId(conn,childInfo.getString("FILE_CODE"),attUpdate.getString("UPDATE_FIELD"));
       	    	   }
            	 }
             }else{//审核通过时
            	    handler.saveUpdateDetailStore(conn,updateDetails,newDetail,"N");//保存更新明细信息(基本信息)
            	    if(smallTypes!=null){
            	    	// handler.saveAttUpdateDetailStore(conn, attUpdateDetail, smallTypes, updatetypes, cui_id, childInfo.getString("FILE_CODE"));//保存更新明细信息(附件信息)
            	    	handler.saveAttUpdateDetail(conn, attUpdateDetail, smallTypes, updatetypes, cui_id, childInfo.getString("FILE_CODE"));//保存更新明细信息(附件信息)
            	    }
            	   //如果是省待审需要判断是否需要中心审核
            	    if(ChildInfoConstants.LEVEL_PROVINCE.equals(updateType)){
            		   //需要中心审核则不更新儿童材料基本信息,需要新增一条更新审核记录
            		   if(ChildStateManager.CHILD_AUD_STATE_YJIES.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_YJS.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXSHZ.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_ZXTG.equals(aud_state)){
	            			  updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_ZXDS);
	            			  childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_ZXDS);
	            			  Data newAudit=new Data();
	            			  newAudit.add("CUI_ID", cui_id);
	            			  newAudit.add("OPERATION_STATE", ChildStateManager.OPERATION_STATE_TODO);
	            			  newAudit.add("AUDIT_TYPE", ChildInfoConstants.LEVEL_CCCWA);
	            			  handler.saveAuditInfo(conn, newAudit);
	            			  handler.saveAuditInfo(conn,auditInfo);
	            			  handler.saveUpdateData(conn, updateInf);
	            			  handler.saveChildUpdateState(conn, childUpdate);
	            			  resultInfo="审核成功,需要中心审核";
                    	 }else if(ChildStateManager.CHILD_AUD_STATE_SDS.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_SSHZ.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_STG.equals(aud_state)){
                    	//不需要中心审核则更新儿童材料基本信息
                    		 updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
                    		//将明细列表信息转化成儿童材料更新数据
                             for(int i=0;i<updateDetails.size();i++){
                          	   Data detail=updateDetails.getData(i);
                          	   childUpdate.add(detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
                             }
               			     childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
               			     childUpdate.add("LAST_UPDATE_DATE", DateUtility.getCurrentDate());//保存最后一次更新日期
	               		     String numStr=childInfo.getString("UPDATE_NUM",null);//保存更新次数
	   	        	         if(numStr==null){
	   	        	        	childUpdate.add("UPDATE_NUM",1);
	   	        	         }else{
	   	        	        	childUpdate.add("UPDATE_NUM",(Integer.parseInt(numStr)+1));
	   	        	         }
		   	        	     //附件信息的更新
		  	        	     if(smallTypes!=null){
	  	        	    	   for(int j=0;j<attUpdateDetail.size();j++){
	  	        	    		    Data attUpdate=attUpdateDetail.getData(j);
	  	        	    		    handler.updateAttachment(conn,childInfo.getString("FILE_CODE"),attUpdate.getString("UPDATE_FIELD"),attUpdate.getString("UPDATE_TYPE"));
	  	        	    	   }
		  	        	     }
	   	        	        handler.saveAuditInfo(conn,auditInfo);
            			    handler.saveUpdateData(conn, updateInf);
            			    handler.saveChildUpdateState(conn, childUpdate);
            			    resultInfo="审核成功,儿童材料信息更新生效"; 
                    	 }
	               }else if(ChildInfoConstants.LEVEL_CCCWA.equals(updateType)){
			             //中心审核成功，直接更新数据    
			        	  updateInf.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
			     		   //将明细列表信息转化成儿童材料更新数据
			              for(int i=0;i<updateDetails.size();i++){
			           	   Data detail=updateDetails.getData(i);
			           	   childUpdate.add(detail.getString("UPDATE_FIELD"), detail.getString("UPDATE_DATA"));
			              }
						  childUpdate.add("UPDATE_STATE", ChildStateManager.CHILD_UPDATE_STATE_TG);
						  childUpdate.add("LAST_UPDATE_DATE", DateUtility.getCurrentDate());//保存最后一次更新日期
			    		  String numStr=childInfo.getString("UPDATE_NUM",null);//保存更新次数
			    	      if(numStr==null){
			    	        childUpdate.add("UPDATE_NUM",1);
			    	      }else{
			    	        childUpdate.add("UPDATE_NUM",(Integer.parseInt(numStr)+1));
			    	      }
			    	     //附件信息的更新
		  	        	  if(smallTypes!=null){
	  	        	    	   for(int j=0;j<attUpdateDetail.size();j++){
	  	        	    		    Data attUpdate=attUpdateDetail.getData(j);
	  	        	    		    handler.updateAttachment(conn,childInfo.getString("FILE_CODE"),attUpdate.getString("UPDATE_FIELD"),attUpdate.getString("UPDATE_TYPE"));
	  	        	    	   }
		  	        	   }
			    	      handler.saveAuditInfo(conn,auditInfo);
					      handler.saveUpdateData(conn, updateInf);
					      handler.saveChildUpdateState(conn, childUpdate);
					      resultInfo="审核成功,儿童材料信息更新生效";  
	             }
            	 
           }
            InfoClueTo clueTo = new InfoClueTo(0, resultInfo);
            setAttribute("clueTo", clueTo);
            dt.commit();
            
       } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料更新审核操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[儿童材料更新审核交操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料更新审核操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("儿童材料更新审核操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }catch (Exception e) {
        	//6设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料更新审核操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("儿童材料更新审核操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ChildUpdateAction的saveUpdateAudit.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    Signal = "error2";
                }
            }
        }
        return updateType;
	}
    /**
     * 儿童材料附件更新上传
     * @return
     */
    public String updateAtt(){
    	String uploadId=getParameter("uploadId"); 
    	String packageId=getParameter("packageId"); 
    	String smallType=getParameter("smallType"); 
    	String org_af_id=getParameter("org_af_id"); 
    	setAttribute("uploadId",uploadId);
        setAttribute("packageId",packageId);
        setAttribute("smallType",smallType);
        setAttribute("org_af_id",org_af_id);
        return SUCCESS;
     }
}
