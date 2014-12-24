package com.dcfs.cms.childReturn;

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
import com.dcfs.cms.childAdditional.ChildAdditionAction;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.cms.childManager.ChildStateManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.framework.person.vo.Person;
import com.hx.upload.sdk.AttHelper;

public class ChildReturnAction  extends BaseAction{
	
	private static Log log = UtilLog.getLog(ChildAdditionAction.class);

    private ChildReturnHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    public ChildReturnAction(){
        this.handler=new ChildReturnHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	

	 /**
	 * 福利院儿童材料退材料列表
	 * @return
	 */
   public String returnListFLY(){
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
			compositor="APPLE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}		
		//3 获取查询条件数据
       //查询条件包括：姓名、性别、出生日期、申请日期、退文类型/退材料分类、退材料原因、状态/退材料结果
		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","APPLE_DATE_START","APPLE_DATE_END","BACK_TYPE","RETURN_REASON","BACK_RESULT");
		
		//获取福利院登录人的福利院Id
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
        try {
		    //4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
            DataList dl=handler.returnListFLY(conn,oId,data,pageSize,page,compositor,ordertype);
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
                        log.logError("ChildReturnAction的Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
        return  SUCCESS;
    }
   /**
	 * 省厅儿童材料退材料确认列表
	 * @return
	 */
   public String returnListST(){
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
			compositor="APPLE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}		
		//3 获取查询条件数据
       //查询条件包括：姓名、性别、出生日期、福利院、退材料原因、退文类型/退材料分类、状态/退材料结果、申请日期
		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","WELFARE_ID","RETURN_REASON","BACK_TYPE","BACK_RESULT","APPLE_DATE_START","APPLE_DATE_END");
		
		//获取省厅登陆人的组织机构代码
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
        try {
		    //4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
            DataList dl=handler.returnListST(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
	 * 中心（安置部）儿童材料退材料确认列表
	 * @return
	 */
   public String returnListZX(){
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
			compositor="APPLE_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}		
		//3 获取查询条件数据
		//查询条件包括：姓名、性别、出生日期、省份、福利院、退材料原因、退材料分类/退文类型、状态/退材料结果、申请日期
		Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","RETURN_REASON","BACK_TYPE","BACK_RESULT","APPLE_DATE_START","APPLE_DATE_END");

        try {
		    //4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
            DataList dl=handler.returnListZX(conn,data,pageSize,page,compositor,ordertype);
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
	 * 福利院儿童材料退材料选择列表 
	 * @return
	 */
   public String returnSelectFLY(){
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
       //查询条件包括：姓名、性别、出生日期、儿童类型、病残种类、体检日期、审核状态、儿童状态
		Data data = getRequestEntityData("S_","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","AUD_STATE");
		
		//获取福利院登录人的福利院Id
		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oId=o.getOrgCode();
        try {
		    //4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList 
            DataList dl=handler.returnSelectFLY(conn,oId,data,pageSize,page,compositor,ordertype);
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
	 * 省厅儿童材料退材料选择列表 
	 * @return
	 */
  public String returnSelectST(){
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
      //查询条件包括：福利院、姓名、性别、出生日期、儿童类型、病残种类、体检日期、审核状态、儿童状态
		Data data = getRequestEntityData("S_","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","AUD_STATE");
		
		//获取省厅登陆人的组织机构代码
 		UserInfo user=SessionInfo.getCurUser();
		Organ o=user.getCurOrgan();
		String oCode=o.getOrgCode();
		String provinceId=new ChildCommonManager().getProviceId(oCode);
       try {
		    //4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList 
           DataList dl=handler.returnSelectST(conn,provinceId,data,pageSize,page,compositor,ordertype);
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
		 * 中心儿童材料退材料选择列表 
		 * @return
		 */
	public String returnSelectZX(){
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
	    //查询条件包括：省份、福利院、姓名、性别、出生日期、儿童类型、病残种类、体检日期、审核状态、儿童状态
			Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END","CHILD_TYPE","SN_TYPE","CHECKUP_DATE_START","CHECKUP_DATE_END","AUD_STATE");
	     try {
			    //4 获取数据库连接
				conn = ConnectionManager.getConnection();
				//5 获取数据DataList 
	         DataList dl=handler.returnSelectZX(conn,data,pageSize,page,compositor,ordertype);
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
    * 儿童材料退材料申请页面
    */
   public String toReturnAdd(){
       String CI_ID= getParameter("CI_ID");
       String RETURN_LEVEL=getParameter("RETURN_LEVEL");
       Connection conn = null;
          try {
              conn = ConnectionManager.getConnection();
              Data showdata = handler.getChildInfoById(conn, CI_ID);
              UserInfo user=SessionInfo.getCurUser();
              Person person=user.getPerson();
              String pName=person.getCName();
              if(showdata!=null){
           	   showdata.add("APPLE_PERSON_NAME", pName);//申请人姓名
           	   showdata.add("APPLE_DATE",new Date());//申请日期
              }
              setAttribute("ORG_CODE",user.getCurOrgan().getOrgCode());
              setAttribute("RETURN_LEVEL", RETURN_LEVEL);
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
    * 儿童材料退材料申请（代录）的提交操作
    * @return
    */
	public String saveReturnData(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","CI_ID","APPLE_TYPE","UPLOAD_IDS","RETURN_REASON");
		Data childData=new Data();
		String Signal=getParameter("RETURN_LEVEL");
		try {
       	//2 获取数据库连接
           conn = ConnectionManager.getConnection();
           //3创建事务
           dt = DBTransaction.getInstance(conn);
            childData=handler.getChildInfoById(conn, data.getString("CI_ID"));
            //添加儿童相关信息
            data.add("PROVINCE_ID", childData.getString("PROVINCE_ID"));
            data.add("WELFARE_ID", childData.getString("WELFARE_ID"));
            data.add("NAME", childData.getString("NAME"));
            data.add("SEX", childData.getString("SEX"));
            data.add("BIRTHDAY", childData.getString("BIRTHDAY"));
            //添加申请人（代录人）相关信息
   			UserInfo curuser = SessionInfo.getCurUser();
   			data.add("APPLE_PERSON_ID", curuser.getPersonId());	//添加申请ID
   			data.add("APPLE_PERSON_NAME", curuser.getPerson().getCName());	//添加申请人姓名
   			data.add("APPLE_DATE", DateUtility.getCurrentDate());	//添加申请日期
   			//根据申请类型设置退材料分类（福利院申请、省厅代录、中心代录）
   			if("1".equals(Signal)){
   				data.add("BACK_TYPE",ChildStateManager.CHILD_BACK_TYPE_FSQ);//退材料分类为:福利院申请退文
   				data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_SDS);//省待审
   				childData.add("RETURN_TYPE", ChildStateManager.CHILD_BACK_TYPE_FSQ);//儿童材料基本信息表中的退材料分类为：福利院申请退文
   			}else if("2".equals(Signal)){
   				data.add("BACK_TYPE",ChildStateManager.CHILD_BACK_TYPE_SSQ);//退材料分类为:省厅申请退文
   				data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_ZXDS);//中心待审
   			    //添加省厅确认信息
   				data.add("ST_CONFIRM_USERID", curuser.getPersonId());	//添加省厅确认人id
   	   			data.add("ST_CONFIRM_USERNAME", curuser.getPerson().getCName());	//添加省厅确认人姓名
   	   			data.add("ST_CONFIRM_DATE", DateUtility.getCurrentDate());	//添加省厅确认日期
   				childData.add("RETURN_TYPE",ChildStateManager.CHILD_BACK_TYPE_SSQ);//儿童材料基本信息表中的退材料分类为：省厅申请退文
   			}else if("3".equals(Signal)){
   				data.add("BACK_TYPE",ChildStateManager.CHILD_BACK_TYPE_ZXTW);//退材料分类为:安置部退文录入
   				data.add("BACK_RESULT","1");//设置退材料结果为已确认
   				data.add("BACK_DATE", DateUtility.getCurrentDate());//设置退文日期
   			    //添加中心确认信息
   				data.add("ZX_CONFIRM_USERID", curuser.getPersonId());	//添加中心确认人id
   	   			data.add("ZX_CONFIRM_USERNAME", curuser.getPerson().getCName());	//添加中心确认人姓名
   	   			data.add("ZX_CONFIRM_DATE", DateUtility.getCurrentDate());	//添加中心确认日期
   				childData.add("RETURN_TYPE", ChildStateManager.CHILD_BACK_TYPE_ZXTW);//儿童材料基本信息表中的退材料分类为：安置部退文录入
   			}
   			//设置儿童材料基本信息的中退材料标志为：退材料
             childData.add("RETURN_STATE",ChildStateManager.CHILD_RETURN_STATE_FLAG);
            //更新儿童材料基本信息中退材料相关数据
            new ChildManagerHandler().save(conn, childData);
            //保存退材料信息
            handler.save(conn, data);
            InfoClueTo clueTo = new InfoClueTo(0, "操作成功!");
            setAttribute("clueTo", clueTo);
            AttHelper.publishAttsOfPackageId(data.getString("UPLOAD_IDS"), "CI");
            dt.commit();
           
       } catch (DBException e) {
       	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料退材料申请提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
           if (log.isError()) {
               log.logError("操作异常[儿童材料退材料申请提交操作]:" + e.getMessage(),e);
           }
           
           InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
           setAttribute("clueTo", clueTo);
           Signal = "error1";
       } catch (SQLException e) {
       	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料退材料申请提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
           try {
               dt.rollback();
           } catch (SQLException e1) {
               e1.printStackTrace();
           }
           if (log.isError()) {
               log.logError("儿童材料退材料申请提交操作异常:" + e.getMessage(),e);
           }
           InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
           setAttribute("clueTo", clueTo);
           
           Signal = "error1";
       } catch (Exception e) {
          	//6设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料退材料申请提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
          try {
              dt.rollback();
          } catch (SQLException e1) {
              e1.printStackTrace();
          }
          if (log.isError()) {
              log.logError("儿童材料退材料申请提交操作异常:" + e.getMessage(),e);
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
                       log.logError("ChildReturnAction的saveReturnData.Connection因出现异常，未能关闭",e);
                   }
                   e.printStackTrace();
                   
                   Signal = "error2";
               }
           }
       }
       return Signal;
	}
    /**
    * 儿童材料退材料申请确认页面
    */
   public String toConfirm(){
       String AR_ID= getParameter("AR_ID");
       String CONFIRM_LEVEL=getParameter("CONFIRM_LEVEL");
       Connection conn = null;
          try {
              conn = ConnectionManager.getConnection();
              Data showdata = handler.getConfirmDataByID(conn, AR_ID);
              setAttribute("CONFIRM_LEVEL", CONFIRM_LEVEL);
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
    * 儿童材料退材料确认、取消退材料操作
    * @return
    */
	public String saveConfirmResult(){
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","CI_ID","AR_ID","ST_CONFIRM_REMARK","ZX_CONFIRM_REMARK");
		Data childData=new Data();
		String Signal=getParameter("CONFIRM_LEVEL");
		String confirmResult=getParameter("result");
		ChildManagerHandler childHandler=new ChildManagerHandler();
		try {
	       	   //2 获取数据库连接
	            conn = ConnectionManager.getConnection();
	            //3创建事务
	            dt = DBTransaction.getInstance(conn);
	            childData=handler.getChildInfoById(conn, data.getString("CI_ID"));
	            UserInfo curuser = SessionInfo.getCurUser();
	            if("1".equals(confirmResult)){//确认操作
		       			if("2".equals(Signal)){//省厅确认操作
		       				    data.removeData("ZX_CONFIRM_REMARK");
			       				String aud_state=childData.getString("AUD_STATE");
			       				data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_ZXDS);//省厅已确认
			       				data.add("ST_CONFIRM_USERID", curuser.getPersonId());	//添加省厅确认人Id
			       	   			data.add("ST_CONFIRM_USERNAME", curuser.getPerson().getCName());	//添加省厅确认人姓名
			       	   			data.add("ST_CONFIRM_DATE", DateUtility.getCurrentDate());	//添加省厅确认日期
			       	   			//如果儿童材料在省厅则设置退材料结果为已确认、设置退材料日期（确认生效日期）
			       				if(ChildStateManager.CHILD_AUD_STATE_SDS.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_SSHZ.equals(aud_state)||ChildStateManager.CHILD_AUD_STATE_STG.equals(aud_state)){
			       					data.add("BACK_RESULT","1");//已确认
			           				data.add("BACK_DATE", DateUtility.getCurrentDate());//退材料日期
			       				}
			       			    //保存退材料信息
			                    handler.save(conn, data);
			                    InfoClueTo clueTo = new InfoClueTo(0, "操作成功!");
			                    setAttribute("clueTo", clueTo);
		       			}else if("3".equals(Signal)){//中心确认操作
		       				    data.removeData("ST_CONFIRM_REMARK");
			       				String childType=childData.getString("CHILD_TYPE");
			       				String matchState=childData.getString("MATCH_STATE");
			       				String pubState=childData.getString("PUB_STATE");
			       				//判断儿童是否已匹配
			       				if(ChildStateManager.CHILD_MATCH_STATE_DONE.equals(matchState)){
			       					InfoClueTo clueTo = new InfoClueTo(0, "     操作失败：该儿童已匹配,请先解除匹配再退材料!");
			       	                setAttribute("clueTo", clueTo);
			       				}else if(ChildInfoConstants.CHILD_TYPE_SPECAL.equals(childType)){//特需儿童还需判断是否预批申请和是否锁定
			       					if(ChildStateManager.CHILD_PUB_STATE_REQ.equals(pubState)){
				   						InfoClueTo clueTo = new InfoClueTo(0, "     操作失败：该儿童已递交预批申请,请先撤销预批再退材料!");
				       	                setAttribute("clueTo", clueTo);
			       					}else if(ChildStateManager.CHILD_PUB_STATE_LOCK.equals(pubState)){
			       						InfoClueTo clueTo = new InfoClueTo(0, "     操作失败：该儿童已锁定,请先解除锁定再退材料!");
				       	                setAttribute("clueTo", clueTo);
			       					}else{//特需儿童确认通过
			       	       				data.add("ZX_CONFIRM_USERID", curuser.getPersonId());	//添加中心确认人Id
			       	       	   			data.add("ZX_CONFIRM_USERNAME", curuser.getPerson().getCName());	//添加中心确认人姓名
			       	       	   			data.add("ZX_CONFIRM_DATE", DateUtility.getCurrentDate());	//添加中心确认日期
			       	       	        	data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_TG);//中心已确认
			       	       	   			data.add("BACK_RESULT","1");//已确认
					       				data.add("BACK_DATE", DateUtility.getCurrentDate());//退材料日期
					       				handler.save(conn, data);
					       				InfoClueTo clueTo = new InfoClueTo(0, "操作成功!");
					                    setAttribute("clueTo", clueTo);
			       				   }
			       			   }else{//正常儿童确认通过
				       				data.add("ZX_CONFIRM_USERID", curuser.getPersonId());	//添加中心确认人Id
		       	       	   			data.add("ZX_CONFIRM_USERNAME", curuser.getPerson().getCName());	//添加中心确认人姓名
		       	       	   			data.add("ZX_CONFIRM_DATE", DateUtility.getCurrentDate());	//添加中心确认日期
		       	       	        	data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_TG);//中心已确认
		       	       	   			data.add("BACK_RESULT","1");//已确认
				       				data.add("BACK_DATE", DateUtility.getCurrentDate());//退材料日期
				       				handler.save(conn, data);
				       				InfoClueTo clueTo = new InfoClueTo(0, "操作成功!");
				                    setAttribute("clueTo", clueTo);
			       			 }
		       		}
	         }else if("0".equals(confirmResult)){//取消退材料操作
	        	//设置儿童材料基本信息的中退材料标志为：null,退材料分类为：null
	            childData.add("RETURN_STATE","");
	            childData.add("RETURN_TYPE","");
	           //更新儿童材料基本信息中退材料相关数据
	            childHandler.save(conn, childData);
	           //更新退材料记录表中的退材料状态RETURN_STATE为：取消退材料
	           data.add("RETURN_STATE", ChildStateManager.CHILD_RETURN_STATE_QX);
	           //保存退材料信息
	           handler.save(conn, data);
	           InfoClueTo clueTo = new InfoClueTo(0, "操作成功!");
	           setAttribute("clueTo", clueTo);
	        }
	        dt.commit();
       } catch (DBException e) {
       	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料退材料确认/取消退材料操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
           if (log.isError()) {
               log.logError("操作异常[儿童材料退材料确认/取消退材料操作]:" + e.getMessage(),e);
           }
           
           InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
           setAttribute("clueTo", clueTo);
           Signal = "error1";
       } catch (SQLException e) {
       	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料退材料确认/取消退材料操作异常");
			setAttribute(Constants.ERROR_MSG, e);
           try {
               dt.rollback();
           } catch (SQLException e1) {
               e1.printStackTrace();
           }
           if (log.isError()) {
               log.logError("儿童材料退材料确认/取消退材料操作异常:" + e.getMessage(),e);
           }
           InfoClueTo clueTo = new InfoClueTo(2, "操作失败!");
           setAttribute("clueTo", clueTo);
           
           Signal = "error1";
       } catch (Exception e) {
          	//6设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童材料退材料确认/取消退材料操作异常");
			setAttribute(Constants.ERROR_MSG, e);
          try {
              dt.rollback();
          } catch (SQLException e1) {
              e1.printStackTrace();
          }
          if (log.isError()) {
              log.logError("儿童材料退材料确认/取消退材料操作异常:" + e.getMessage(),e);
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
                       log.logError("ChildReturnAction的saveConfirmResult.Connection因出现异常，未能关闭",e);
                   }
                   e.printStackTrace();
                   
                   Signal = "error2";
               }
           }
       }
       return Signal;
	}
}
