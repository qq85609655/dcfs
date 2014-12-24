package com.dcfs.cms.childAdditional;

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
import java.util.Date;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildStateManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.person.vo.Person;
import com.hx.upload.sdk.AttHelper;

public class ChildAdditionAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(ChildAdditionAction.class);

    private ChildAdditionHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    public ChildAdditionAction(){
        this.handler=new ChildAdditionHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	/**
	 * 省厅 业务查询-补充查询（查询由省厅发起的儿童材料补充通知）
	 * @return
	 */
    public String findListFromSt(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按通知日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 获取查询条件数据
        //查询条件包括：福利院名称、姓名、性别、儿童类型、补充通知来源、补充状态、反馈日期、出生日期、补充通知日期  
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","CHILD_TYPE","SOURCE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
 		
		//获取省厅登录人的省厅Id(由于方法体未实现，暂时使用固定值)
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
		System.out.println("省厅Id:"+provinceId);
 	  //  String provinceId="110000";
 	//	System.out.println("省厅Id:"+provinceId);
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.findListFromSt(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
	 * 安置部 业务查询-补充查询（查询由中心发起的儿童材料补充通知）
	 * @return
	 */
    public String findListFromAZB(){
    	 //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按通知日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 获取查询条件数据
        //查询条件包括：省份、福利院名称、姓名、性别、儿童类型、补充通知来源、补充状态、反馈日期、出生日期、补充通知日期  
 		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","CHILD_TYPE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.findListFromAZB(conn,data,pageSize,page,compositor,ordertype);
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
	 * 福利院儿童材料补充查询/福利院儿童材料补充列表
	 * @return
	 */
    public String findListFLY(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按通知日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 获取查询条件数据
        //查询条件包括：姓名、性别、儿童类型、补充通知来源、补充状态、反馈日期、出生日期、补充通知日期  
 		Data data = getRequestEntityData("S_","NAME","SEX","CHILD_TYPE","SOURCE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
 		
 		//获取福利院登录人的福利院Id
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
		System.out.println("组织代码:"+oId);
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.findListFLY(conn,oId,data,pageSize,page,compositor,ordertype);
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
  * 省厅儿童材料补充查询/省厅儿童材料补充列表
  * @return
  */
    public String findListST(){
        //1 设定参数
     	InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
 		setAttribute("clueTo", clueTo);//set操作结果提醒
 		
     	//2 设置分页参数
         int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
         int page = getNowPage();
         if (page == 0) {
             page = 1;
         }
 		//2.1 获取排序字段（默认按通知日期降序排列）
 		String compositor=(String)getParameter("compositor","");
 		if("".equals(compositor)){
 			compositor="NOTICE_DATE";
 		}
 		//2.2 获取排序类型   ASC DESC
 		String ordertype=(String)getParameter("ordertype","");
 		if("".equals(ordertype)){
 			ordertype="DESC";
 		}		
 		//3 获取查询条件数据
        //查询条件包括：福利院名称、姓名、性别、儿童类型、补充通知来源、补充状态、反馈日期、出生日期、补充通知日期  
 		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","CHILD_TYPE","SOURCE","CA_STATUS","FEEDBACK_DATE_START","FEEDBACK_DATE_END","BIRTHDAY_START","BIRTHDAY_END","NOTICE_DATE_START","NOTICE_DATE_END");
 		
		//获取省厅登录人的省厅Id
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
         try {
 		    //4 获取数据库连接
 			conn = ConnectionManager.getConnection();
 			//5 获取数据DataList
             DataList dl=handler.findListST(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
     * 儿童材料补充页面
	 * @author furx
	 * @date 2014-9-6
     */
    public String getModifyData(){
    	String uuid = getParameter("UUID");
    	//根据参数确定是福利院补充还是省厅补充来实现补充成功后所跳转的补充列表页面1为跳转到福利院2为跳转到省厅
        String signal=getParameter("signal");
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               Data showdata = handler.getModifyData(conn, uuid);
               UserInfo user=SessionInfo.getCurUser();
               Person person=user.getPerson();
               String pName=person.getCName();
               if(showdata!=null){
            	   showdata.add("FEEDBACK_ORGNAME", user.getCurOrgan().getCName());
            	   showdata.add("FEEDBACK_USERNAME", pName);
            	   showdata.add("FEEDBACK_DATE",new Date());
               }
               setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
               setAttribute("signal", signal);
               setAttribute("data", showdata);
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
     * 儿童材料补充信息查看页面
     * @return
     */
    public String getShowData(){
    	String uuid = getParameter("UUID");
        Connection conn = null;
           try {
               conn = ConnectionManager.getConnection();
               Data showdata = handler.getModifyData(conn, uuid);
               setAttribute("data", showdata);
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
     * 儿童材料补充页面的保存提交操作
     * @return
     */
	public String childSupplySave(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","CA_ID","CI_ID","CA_STATUS","UPLOAD_IDS","ADD_CONTENT","SOURCE");
		Data childData=new Data();
 		String Signal=getParameter("signal");
 		String source=data.getString("SOURCE","");
		try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
    			UserInfo curuser = SessionInfo.getCurUser();
    			data.add("FEEDBACK_USERID", curuser.getPersonId());	//添加反馈人ID
    			data.add("FEEDBACK_USERNAME", curuser.getPerson().getCName());	//添加反馈人姓名
    			data.add("FEEDBACK_ORGID", curuser.getCurOrgan().getOrgCode());//添加反馈人组织Id(所在组织机构代码)
    			data.add("FEEDBACK_ORGNAME", curuser.getCurOrgan().getCName());	//添加反馈人组织名称
    			data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());	//添加反馈日期
                childData.add("CI_ID", data.getString("CI_ID"));
                childData.add("SUPPLY_STATE", data.getString("CA_STATUS"));
                if(ChildStateManager.CHILD_ADD_STATE_DOING.equals(data.getString("CA_STATUS"))){//补充中
                	if(ChildInfoConstants.LEVEL_PROVINCE.equals(source)){//省厅审核要求福利院补充中
                		new ChildCommonManager().stAuditSupplySave(childData, null);
                	}else if(ChildInfoConstants.LEVEL_CCCWA.equals(source)){//中心审核要求材料补充中
                		new ChildCommonManager().zxAuditSupplySave(childData, null);
                	}
                }else if(ChildStateManager.CHILD_ADD_STATE_DONE.equals(data.getString("CA_STATUS"))){//已补充
					if(ChildInfoConstants.LEVEL_PROVINCE.equals(source)){//省厅审核要求福利院已补充
						new ChildCommonManager().stAuditSupplySubmit(childData, null);            		
                	}else if(ChildInfoConstants.LEVEL_CCCWA.equals(source)){//中心审核要求补充材料，已补充
                		new ChildCommonManager().zxAuditSupplySubimit(childData, null);
                	}
                }
    		//执行儿童材料补充保存操作，保存材料补充表中的补充内容 更新补充材料的补充状态和儿童基本信息表中的末次补充状态为：1:补充中
            boolean success = false;
            success=handler.childSupplySave(conn,data,childData);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "操作成功!");
                setAttribute("clueTo", clueTo);
                AttHelper.publishAttsOfPackageId(data.getString("UPLOAD_IDS"), "CI");
            }
            
            dt.commit();
            
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料补充保存/提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[儿童材料补充保存/提交操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            Signal = "error1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料补充保存/提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("儿童材料补充保存/提交操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }catch(Exception e){
        	//6设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料补充保存/提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("儿童材料补充保存/提交操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
            setAttribute("clueTo", clueTo);
            
            Signal = "error1";
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("ChildAdditionAction的childSupplySave.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    Signal = "error2";
                }
            }
        }
        return Signal;
	}
	 /**
     * 根据儿童材料信息主键获取补充记录（已补充的补充信息）
     * @return
     */
    public String getShowDataByCIID(){
    	String CI_ID = getParameter("CI_ID");
        Connection conn = null;
        DataList additionList=new DataList();
        try {
            conn = ConnectionManager.getConnection();
            additionList= handler.getAdditionDataByCIID(conn,CI_ID);
            setAttribute("additionList", additionList);
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
}
