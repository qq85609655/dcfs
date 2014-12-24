package com.dcfs.sce.addMaterial;

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

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.sce.common.PublishCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;

/**
 * 
 * @Title: AddMaterialAction.java
 * @Description: 补充预批资料查询、查看补充通知、补充操作
 * @Company: 21softech
 * @Created on 2014-9-14 下午3:43:13 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AddMaterialAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AddMaterialAction.class);
    private Connection conn = null;
    private AddMaterialHandler handler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public AddMaterialAction() {
        this.handler=new AddMaterialHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: findMaterialList
     * @Description: 补充预批资料列表
     * @author: panfeng
     * @date: 2014-9-11 下午5:21:12 
     * @return
     */
    public String findMaterialList(){
        // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","PROVINCE_ID",
        			"NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","SPECIAL_FOCUS",
        			"ADD_TYPE","NOTICE_DATE_START","NOTICE_DATE_END","FEEDBACK_DATE_START",
        			"FEEDBACK_DATE_END","AA_STATUS");
        //儿童姓名、男方、女方搜索输入条件转换大写
        String NAME_PINYIN = data.getString("NAME_PINYIN",null);
        if(NAME_PINYIN != null){
        	data.put("NAME_PINYIN", NAME_PINYIN.toUpperCase());
        }
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
            DataList dl=handler.findMaterialList(conn,data,pageSize,page,compositor,ordertype);
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
	 * @Title: showMaterialDetail 
	 * @Description: 补充通知详细查看信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String showMaterialDetail(){
		//获取预批补充信息id
		String uuid = getParameter("showuuid");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据 预批补充信息id获取详细信息
			Data data = handler.getDetailData(conn,uuid);
			
			setAttribute("detaildata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("IS_TWINS",data.getString("IS_TWINS",""));
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查看信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查看信息操作异常:" + e.getMessage(),e);
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
	 * @Title: addMaterialShow 
	 * @Description: 跳转到预批材料补充页面
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String addMaterialShow(){
		//获取预批补充信息id
		String uuid = getParameter("showuuid");
		try {
			// 获取数据库连接
			conn = ConnectionManager.getConnection();
			//根据 预批补充信息id获取详细信息
			Data data = handler.getSupData(conn,uuid);
			data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());
			
			setAttribute("supdata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("AF_ID", data.getString("AF_ID",""));//附件所在收养文件ID
			setAttribute("ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//附件操作当前人单位ID
		} catch (DBException e) {
			// 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取预批补充信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("获取预批补充信息操作异常:" + e.getMessage(),e);
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
     * @Title: addMaterialSave 
	 * @Description: 补充预批资料保存
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
     */
    public String addMaterialSave(){
	    //1 获得页面表单数据，构造数据结果集
        Data data = getRequestEntityData("R_","RA_ID","RI_ID","ADD_TYPE","ADD_CONTENT_EN","FEEDBACK_DATE","UPLOAD_IDS","AA_STATUS");
        String type = getParameter("type");
        try {
            //2 获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 执行数据库处理操作
            Data infodata = new Data();
            infodata.add("RI_ID", (String)data.get("RI_ID"));
            //根据操作更新预批基本信息表末次补充状态
            String add_type = (String)data.get("ADD_TYPE");
            if(type=="save" || "save".equals(type)){
            	if("1".equals(add_type)){
            		infodata.add("LAST_STATE","1");//将审核部末次补充状态更新为"补充中"
            	}else if("2".equals(add_type)){
            		infodata.add("LAST_STATE2","1");//将安置部末次补充状态更新为"补充中"
            	}
            }else{
            	if("1".equals(add_type)){
    				infodata.add("LAST_STATE", "2");//将审核部末次补充状态更新为"已补充"
    			}else if("2".equals(add_type)){
    				infodata.add("LAST_STATE2", "2");//将安置部末次补充状态更新为"已补充"
    			}
            }
            
            data.add("FEEDBACK_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//反馈人ID
            data.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//反馈人
            
            //提交操作时根据本收养组织是否预批翻译判断是否初始化预批补充翻译记录
            if(type=="submit" || "submit".equals(type)){
				UserInfo userinfo = SessionInfo.getCurUser();
				String orgid = userinfo.getCurOrgan().getOrgCode();
				//获取收养组织信息
				SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
				String TRANS_FLAG = syzzinfo.getTransFlag();	//预批是否翻译：1=是；0=否
				if("1".equals(TRANS_FLAG)){
					//初始化预批补充翻译记录
					PublishCommonManager publishcommonmanager = new PublishCommonManager();
					Data cdata = new Data();
					cdata.add("RI_ID", (String)data.get("RI_ID"));
					cdata.add("TRANSLATION_TYPE", "1");
					cdata.add("RA_ID", (String)data.get("RA_ID"));
					cdata.add("AT_TYPE", add_type);
					publishcommonmanager.translationInit(conn, cdata);
					if("1".equals(add_type)){
						infodata.add("ATRANSLATION_STATE", "0");//预批基本信息表审核部补翻状态：待翻译
					}else if("2".equals(add_type)){
						infodata.add("ATRANSLATION_STATE2", "0");//预批基本信息表安置部补翻状态：待翻译
					}
				}
            }
            
            success=handler.modInfoSave(conn,infodata);//保存预批基本信息表业务
            success=handler.addMaterialSave(conn,data);//保存补充记录表业务
            
            String packageId = data.getString("UPLOAD_IDS");//附件
            AttHelper.publishAttsOfPackageId(packageId, "AF");//附件发布
            if (success) {
            	if(type=="save" || "save".equals(type)){
            		InfoClueTo clueTo = new InfoClueTo(0, "Saved.");//保存成功 0
            		setAttribute("clueTo", clueTo);
            	}else{
            		InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");//提交成功 0
            		setAttribute("clueTo", clueTo);
            	}
            }
            dt.commit();
        } catch (DBException e) {
		    //4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("保存操作异常[保存操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");//保存失败 2
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
                        log.logError("OpinionTemAction的Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
        return retValue;
    }
    
    /**
	 * @Title: modInfoPO 
	 * @Description: 预批基本信息/抚育计划和组织意见修改跳转操作
	 * @author: panfeng
	 * @return String 
	 */
	public String modInfoPO(){
		
		//获取页面提交数据
		String ri_id = getParameter("ri_id","");
		if(ri_id.equals("")){
			ri_id = (String)getAttribute("ri_id");
		}
		String type = getParameter("type","");
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		try {
			conn = ConnectionManager.getConnection();
			//根据预批申请记录ID,获取预批申请信息Data
			Data showdata = handler.getInfoData(conn, ri_id);
			String family_type = showdata.getString("FAMILY_TYPE");	//收养类型
			//根据收养类型(family_type)确定返回的页面
			if("info".equals(type)){
				if("1".equals(family_type)){
					retValue = "double";	//返回双亲收养修改页面
				}else{
					retValue = "single";	//返回单亲收养修改页面
				}
			}else if("PO".equals(type)){
				retValue = "PO";
			}

			setAttribute("data", showdata);
			setAttribute("MALE_PHOTO", showdata.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", showdata.getString("FEMALE_PHOTO",""));
			setAttribute("MALE_PUNISHMENT_FLAG", showdata.getString("MALE_PUNISHMENT_FLAG",""));
			setAttribute("MALE_ILLEGALACT_FLAG", showdata.getString("MALE_ILLEGALACT_FLAG",""));
			setAttribute("FEMALE_PUNISHMENT_FLAG", showdata.getString("FEMALE_PUNISHMENT_FLAG",""));
			setAttribute("FEMALE_ILLEGALACT_FLAG", showdata.getString("FEMALE_ILLEGALACT_FLAG",""));
			setAttribute("IS_FAMILY_OTHERS_FLAG", showdata.getString("IS_FAMILY_OTHERS_FLAG",""));
			setAttribute("CONABITA_PARTNERS", showdata.getString("CONABITA_PARTNERS",""));
			setAttribute("ADOPTER_SEX", showdata.getString("ADOPTER_SEX",""));
			
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "预批基本信息修改操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[预批基本信息修改操作]:" + e.getMessage(),e);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: modInfoSave 
	 * @Description: 预批基本信息保存操作
	 * @author: yangrt
	 * @return String
	 */
	public String modInfoSave(){
		String type = getParameter("type","");
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		//1 获得页面表单数据，构造数据结果集
		Data data = getRequestEntityData("R_","AF_ID","RI_ID",
				"MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN","MALE_HEALTH",
				"MALE_HEALTH_CONTENT_EN","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_EN",
				"MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME",
				"FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN","FEMALE_HEALTH",
				"FEMALE_HEALTH_CONTENT_EN","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN",
				"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME",
				"CURRENCY","MARRY_CONDITION","MARRY_DATE","TOTAL_ASSET","TOTAL_DEBT","UNDERAGE_NUM","CHILD_CONDITION_EN","ADDRESS",
				"ADOPTER_SEX","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME","GAY_STATEMENT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_EN");
		Data POdata = getRequestEntityData("P_", "RI_ID","TENDING_EN","TENDING_CN","OPINION_EN","OPINION_CN");
		//将男、女收养人姓名转化为大写
		if(!"".equals(data.getString("MALE_NAME",""))){
			data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
		}
		if(!"".equals(data.getString("FEMALE_NAME",""))){
			data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
		}
		
        try {
        	//2 获取数据库连接
            conn = ConnectionManager.getConnection();
            //3创建事务
            dt = DBTransaction.getInstance(conn);
    		if("info".equals(type)){
    			boolean success = handler.modInfoSave(conn,data);
    			if(success){
    				InfoClueTo clueTo = new InfoClueTo(0, "Saved.");
    				setAttribute("clueTo", clueTo);
    			}
    			//附件发布
    			AttHelper.publishAttsOfPackageId(data.getString("MALE_PHOTO"), "AF"); //发布男收养人照片
    			AttHelper.publishAttsOfPackageId(data.getString("FEMALE_PHOTO"), "AF"); //发布女收养人照片
    		}else{
    			boolean success = handler.modInfoSave(conn,POdata);
    			if(success){
    				InfoClueTo clueTo = new InfoClueTo(0, "Saved.");
    				setAttribute("clueTo", clueTo);
    			}
    		}
            
            dt.commit();
        } catch (DBException e) {
        	//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("保存操作异常:" + e.getMessage(),e);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
    /**
	 * @Title: materialSubmit 
	 * @Description: 补充预批材料提交
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String materialSubmit() {
		//1 获取页面选取数据
		String subuuid = getParameter("subuuid", "");
		String ri_id = getParameter("ri_id", "");
		String add_type = getParameter("add_type", "");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取提交后更新数据结果
			Data data = new Data();
			data.add("RA_ID", subuuid);
			data.add("AA_STATUS", "2");//将状态为"补充中"的信息变成"已补充"
			data.add("FEEDBACK_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//反馈人ID
            data.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//反馈人
            data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());//反馈日期
			success = handler.addMaterialSave(conn, data);//保存补充记录表业务
						
			Data infodata = new Data();
			infodata.add("RI_ID", ri_id);
			if("1".equals(add_type)){
				infodata.add("LAST_STATE", "2");//将审核部末次补充状态更新为"已补充"
			}else if("2".equals(add_type)){
				infodata.add("LAST_STATE2", "2");//将安置部末次补充状态更新为"已补充"
			}
			//根据本收养组织是否预批翻译判断是否初始化预批补充翻译记录
			UserInfo userinfo = SessionInfo.getCurUser();
			String orgid = userinfo.getCurOrgan().getOrgCode();
			//获取收养组织信息
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			String TRANS_FLAG = syzzinfo.getTransFlag();	//预批是否翻译：1=是；0=否
			if("1".equals(TRANS_FLAG)){
				//初始化预批补充翻译记录
				PublishCommonManager publishcommonmanager = new PublishCommonManager();
				Data cdata = new Data();
				cdata.add("RI_ID", ri_id);
				cdata.add("TRANSLATION_TYPE", "1");
				cdata.add("RA_ID", subuuid);
				cdata.add("AT_TYPE", add_type);
				publishcommonmanager.translationInit(conn, cdata);
				if("1".equals(add_type)){
					infodata.add("ATRANSLATION_STATE", "0");//预批基本信息表审核部补翻状态：待翻译
				}else if("2".equals(add_type)){
					infodata.add("ATRANSLATION_STATE2", "0");//预批基本信息表安置部补翻状态：待翻译
				}
			}
			
			success = handler.modInfoSave(conn, infodata);//保存预批基本信息表业务
			
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "提交操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[提交操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "提交操作失败!");
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	
}
