/**   
 * @Title: LockChildAction.java 
 * @Package com.dcfs.sce.lockChild 
 * @Description: 锁定儿童操作
 * @author yangrt   
 * @date 2014-9-21 上午11:10:20 
 * @version V1.0   
 */
package com.dcfs.sce.lockChild;

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

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.preApproveApply.PreApproveApplyHandler;
import com.dcfs.sce.publishManager.PublishManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;

/** 
 * @ClassName: LockChildAction 
 * @Description: 锁定儿童操作
 * @author yangrt;
 * @date 2014-9-21 上午11:10:20 
 *  
 */
public class LockChildAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(LockChildAction.class);
	private LockChildHandler handler;
	private Connection conn = null;
	private DBTransaction dt = null;
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
	
	public LockChildAction(){
		this.handler = new LockChildHandler();
	}
	
	
	public String AdoptionAssociationConfirm(){
		return retValue;
	}
	
	/**
	 * @Title: LockChildList 
	 * @Description: 查看与锁定儿童查询列表
	 * @author: yangrt
	 * @return String 
	 */
	public String LockChildList(){
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="PUB_LASTDATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","SPECIAL_FOCUS","PROVINCE_ID","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","SN_TYPE","DISEASE_EN","PUB_LASTDATE_START","PUB_LASTDATE_END","PUB_TYPE","HAVE_VIDEO","SETTLE_DATE_START","SETTLE_DATE_END","LAST_UPDATE_DATE_START","LAST_UPDATE_DATE_END");
        String name_pinyin = data.getString("NAME_PINYIN","");
        if(!"".equals(name_pinyin)){
        	data.add("NAME_PINYIN", name_pinyin.toUpperCase());
        }
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.LockChildList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "锁定儿童查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("锁定儿童查询操作异常:" + e.getMessage(),e);
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
                        log.logError("LockChildAction的LockChildList.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ChildInfoShow 
	 * @Description: 儿童信息查看
	 * @author: yangrt
	 * @return String 
	 */
	public String ChildInfoShow(){
		//获取儿童材料id
		String ci_id = getParameter("CI_ID");
		//获取发布记录id
		String pub_id = getParameter("PUB_ID");
		Data data = new Data();
		data.add("CI_ID", ci_id);
		data.add("PUB_ID", pub_id);
		setAttribute("data", data);
		setAttribute("CI_ID", ci_id);
		setAttribute("PUB_ID", pub_id);
		
		return retValue;
	}
	
	/**
	 * @Title: getChildInfoByCIID 
	 * @Description: 根据儿童材料id,获取儿童信息
	 * @author: yangrt
	 * @return String 
	 */
	public String getChildInfoByCIID(){
		//获取儿童材料id
		String ci_id = getParameter("CI_ID");
		//获取发布记录id
		String pub_id = getParameter("PUB_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据主儿童材料ID,获取主儿童材料信息Data
			Data childdata = handler.getMainChildInfo(conn,ci_id);
			//根据主儿童材料ID,获取附儿童材料信息DataList
			DataList childlist = handler.getAttachChildList(conn, ci_id);
			//获取安置期限
			Data pubdata = handler.getPubData(conn,pub_id);
			childdata.add("SETTLE_DATE", pubdata.getString("SETTLE_DATE",""));
			setAttribute("childdata", childdata);
			setAttribute("childList", childlist);
			
			String CHILD_IDENTITY = childdata.getString("CHILD_IDENTITY","");
			String CHILD_TYPE = childdata.getString("CHILD_TYPE","");
			//根据儿童身份选择附件集合
			ChildCommonManager ccm = new ChildCommonManager();
			String packId = ccm.getChildPackIdByChildIdentity(CHILD_IDENTITY, CHILD_TYPE, false);
			
			setAttribute("CI_ID", ci_id);
			setAttribute("PackId", packId);
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "儿童信息查看操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[儿童信息查看操作]:" + e.getMessage(),e);
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
                        log.logError("LockChildAction的ChildInfoShow.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: LockTypeSelect 
	 * @Description: 锁定方式选择页面
	 * @author: yangrt
	 * @return String 
	 */
	public String LockTypeSelect(){
		//获取页面参数
		Data data = getRequestEntityData("R_", "CI_ID", "PUB_ID");
		String ci_id = data.getString("CI_ID");
		try {
			conn = ConnectionManager.getConnection();
			//根据主儿童材料ID,获取主儿童材料信息Data
			Data childdata = handler.getMainChildInfo(conn,ci_id);
			//根据主儿童材料ID,获取附儿童材料信息DataList
			DataList childlist = handler.getAttachChildList(conn, ci_id);
			setAttribute("data", data);
			setAttribute("childdata", childdata);
			setAttribute("attachList", childlist);
			setAttribute("NUM", childlist.size() + 1 + "");
		} catch (DBException e) {
			//4设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "跳转锁定方式选择页面操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[跳转锁定方式选择页面操作]:" + e.getMessage(),e);
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
                        log.logError("LockChildAction的LockTypeSelect.Connection因出现异常，未能关闭",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: FileInfoSelect 
	 * @Description: 选择家庭文件信息列表
	 * @author: yangrt
	 * @return String 
	 */
	public String FileInfoSelect(){
		//锁定类型
        String lock_type = getParameter("type");
        retValue = "locktype" + lock_type;
		// 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
        	if(lock_type.equals("E")){
        		compositor="PASS_DATE";
        	}else{
        		compositor="FILE_NO";
        	}
            
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="ASC";
        }
        //3 获取页面数据
        Data data = getRequestEntityData("R_","CI_ID","PUB_ID","FILE_TYPE","LOCK_MODE");
        //获取页面查询参数
        Data searchData = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REG_DATE_START","REG_DATE_END","REQ_DATE_START","REQ_DATE_END","PASS_DATE_START","PASS_DATE_END");
        String MALE_NAME = searchData.getString("MALE_NAME","");
		if(!"".equals(MALE_NAME)){
			searchData.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = searchData.getString("FEMALE_NAME","");
		if(!"".equals(FEMALE_NAME)){
			searchData.add("MALE_NAME", FEMALE_NAME.toUpperCase());
		}
       
        try {
            //4 获取数据库连接
        	conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.FileInfoSelect(conn,searchData,lock_type,pageSize,page,compositor,ordertype);
            //根据主儿童材料ID,获取主儿童材料信息Data
			Data childdata = handler.getMainChildInfo(conn,data.getString("CI_ID"));
			//根据主儿童材料ID,获取附儿童材料信息DataList
			DataList childlist = new DataList();
			if("1".equals(childdata.getString("IS_TWINS",""))){
				childlist = handler.getAttachChildList(conn, data.getString("CI_ID"));
			}
			setAttribute("childdata", childdata);
			setAttribute("attachList", childlist);
			setAttribute("NUM", childlist.size() + 1 + "");
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("searchData",searchData);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "家庭文件查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("家庭文件查询操作异常:" + e.getMessage(),e);
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
                        log.logError("LockChildAction的FileInfoSelect.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
		
	}
	
	/**
	 * @Title: ChildInfoLock 
	 * @Description: 跳转到锁定页面
	 * @author: yangrt
	 * @return String 
	 */
	public String ChildInfoLock(){
		retValue = getParameter("type");
		//1 获取页面数据
        Data data = getRequestEntityData("R_","CI_ID","AF_ID","RI_ID","PUB_ID","FILE_TYPE","PRE_REQ_NO","LOCK_MODE","MALE_NAME","FEMALE_NAME");
        try {
            //2 获取数据库连接
        	conn = ConnectionManager.getConnection();
            //根据主儿童材料ID,获取主儿童材料信息Data
			Data childdata = handler.getMainChildInfo(conn,data.getString("CI_ID"));
			//根据主儿童材料ID,获取附儿童材料信息DataList
			DataList childlist = new DataList();
			if("1".equals(childdata.getString("IS_TWINS",""))){
				childlist = handler.getAttachChildList(conn, data.getString("CI_ID"));
			}
			
			//3 将结果集写入页面接收变量
			setAttribute("data",data);
			setAttribute("childdata", childdata);
			setAttribute("attachList", childlist);
			setAttribute("NUM", childlist.size() + 1 + "");
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "跳转锁定页面操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("跳转锁定页面操作异常:" + e.getMessage(),e);
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
                        log.logError("LockChildAction的ChildInfoLock.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: InitPreApproveApply 
	 * @Description: 初始化预批申请记录信息
	 * @author: yangrt
	 * @return String 
	 */
	public String InitPreApproveApply(){
		//从页面获取预批申请初始化信息
		Data applydata = getRequestEntityData("R_","AF_ID","RI_ID","PRE_REQ_NO","CI_ID","PUB_ID","FILE_TYPE","LOCK_MODE","MALE_NAME","FEMALE_NAME","ADOPTER_SEX");
		//将男、女收养人姓名转化为大写
		if(!"".equals(applydata.getString("MALE_NAME",""))){
			applydata.put("MALE_NAME", applydata.getString("MALE_NAME").toUpperCase());
		}
		if(!"".equals(applydata.getString("FEMALE_NAME",""))){
			applydata.put("FEMALE_NAME", applydata.getString("FEMALE_NAME").toUpperCase());
		}
		//锁定方式
		String lock_mode = applydata.getString("LOCK_MODE");
		try {
			conn = ConnectionManager.getConnection();
			
			UserInfo userinfo = SessionInfo.getCurUser();
			String orgid = userinfo.getCurOrgan().getId();
			//获取收养组织信息
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			//收养组织信息
			applydata.add("ADOPT_ORG_ID", syzzinfo.getSyzzCode());
			applydata.add("ADOPT_ORG_NAME_CN", syzzinfo.getSyzzCnName());
			applydata.add("ADOPT_ORG_NAME_EN", syzzinfo.getSyzzEnName());
			applydata.add("COUNTRY_CODE", syzzinfo.getCountryCode());	
			
			//锁定信息
			String EnName = userinfo.getPerson().getEnName();
			String CnName = userinfo.getPerson().getCName();
			applydata.add("LOCKER_ID", userinfo.getPersonId());
			if("".equals(EnName) || "null".equals(EnName) || null == EnName){
				applydata.add("LOCKER_NAME", CnName);
			}else{
				applydata.add("LOCKER_NAME", EnName);
			}
			applydata.add("LOCK_DATE", DateUtility.getCurrentDateTime());
			applydata.add("LOCK_STATE", "0");	//（LOCK_STATE：0，已锁定）
			//预批状态
			applydata.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WTJ);	//（RI_STATE：0，未递交）
			
			String af_id = applydata.getString("AF_ID");
			String ri_id = applydata.getString("RI_ID");
			char mode = lock_mode.toCharArray()[0];
			Data filedata = new Data();
			switch(mode){
				//锁定方式1
				case '1':  
					filedata = new FileManagerHandler().GetFileByID(conn, af_id);
					this.createPreData(applydata, filedata, af_id);
					break;
				//锁定方式2 
				case '2':
					String country_code = applydata.getString("COUNTRY_CODE");
					String nation = new FileCommonManager().getAdopterNation(conn, country_code);
					//收养人性别
					String sex = applydata.getString("ADOPTER_SEX","");
					if("1".equals(sex)){
						applydata.add("FAMILY_TYPE", "2");	//单亲收养（FAMILY_TYPE:2）
						applydata.add("MALE_NATION", nation);
					}if("2".equals(sex)){
						applydata.add("FAMILY_TYPE", "2");	//单亲收养（FAMILY_TYPE:2）
						applydata.add("FEMALE_NATION", nation);
					}else{
						applydata.add("FAMILY_TYPE", "1");	//双亲收养（FAMILY_TYPE:1）
						applydata.add("MALE_NATION", nation);
						applydata.add("FEMALE_NATION", nation);
					}
					applydata.remove("AF_ID");
					applydata.remove("RI_ID");
					break;
				//锁定方式3
				case '3':
					filedata = new FileManagerHandler().GetFileByID(conn, af_id);
					applydata.add("ORIGINAL_FILE_NO", filedata.getString("FILE_NO",""));
					this.createPreData(applydata, filedata, af_id);
					applydata.remove("AF_ID");
					break;
				//锁定方式4
				case '4':
					filedata = new FileManagerHandler().GetFileByID(conn, af_id);
					applydata.add("ORIGINAL_FILE_NO", filedata.getString("FILE_NO",""));
					this.createPreData(applydata, filedata, af_id);
					applydata.remove("AF_ID");
					break;
				//锁定方式5
				case '5':
					Data predata = new Data();
					predata = new PreApproveApplyHandler().getPreApproveApplyData(conn, ri_id);
					this.createPreData(applydata, predata, ri_id);
					break;
				//锁定方式6
				case '6':
					filedata = new FileManagerHandler().GetFileByID(conn, af_id);
					applydata.add("ORIGINAL_FILE_NO", filedata.getString("FILE_NO",""));
					this.createPreData(applydata, filedata, af_id);
					applydata.remove("AF_ID");
					break;
			}
			
			synchronized (this) {
				PublishManagerHandler pmh = new PublishManagerHandler();
				Data pubData = pmh.getEtAndFbInfo(conn, applydata.getString("PUB_ID"));
				String pub_state = pubData.getString("PUB_STATE_FBRECORD");
				if("2".equals(pub_state)){
					dt = DBTransaction.getInstance(conn);
					boolean flag = handler.InitPreApproveApplySave(conn,applydata);
					if(flag){
						InfoClueTo clueTo = new InfoClueTo(0, "Saved successfully!");
			            setAttribute("clueTo", clueTo);
					}
					
					dt.commit();
				}else{
					InfoClueTo clueTo = new InfoClueTo(0, "该儿童已经被锁定，请选择其他儿童进行锁定！");
		            setAttribute("clueTo", clueTo);
					retValue = "other";
				}
				
				/*** 跳转预批申请修改页面所需的参数begin	***/
				setAttribute("type", "mod");
				setAttribute("RI_ID", applydata.getString("RI_ID",""));
				/*** 跳转预批申请修改页面所需的参数end	***/
			}
		} catch (DBException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "初始化预批申请记录操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("操作异常[初始化预批申请记录操作]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "初始化预批申请记录操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("文件保存操作异常:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            setAttribute("clueTo", clueTo);
            
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
                        log.logError("LockChildAction的InitPreApproveApply.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ConsignReturn 
	 * @Description: 委托退回跳转
	 * @author: yangrt
	 * @return String 
	 */
	public String ConsignReturn(){
		//发布记录id
		String pub_id = getParameter("PUB_ID");
		Data data = new Data();
		data.add("PUB_ID", pub_id);
		data.add("RETURN_DATE", DateUtility.getCurrentDateTime());	//退回日期
		data.add("RETURN_TYPE", "1");	//退回类型（RETURN_TYPE：1）
		setAttribute("data", data);
		setAttribute("PUB_ID", pub_id);
		return retValue;
	}
	
	/**
	 * @Title: GetAdoptionPersonInfo 
	 * @Description: 获取收养人基本信息
	 * @author: yangrt
	 * @return String 
	 */
	public String GetAdoptionPersonInfo(){
		String af_id = getParameter("AF_ID");	//文件id
		String ri_id = getParameter("RI_ID");	//预批申请记录id
		String lock_type = getParameter("type");	//锁定类型
		String type = "";
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			Data data = new Data();
			if(lock_type.equals("E")){
				//根据预批申请记录id(ri_id)获取预批申请的详细信息
				data = new PreApproveApplyHandler().getPreApproveApplyData(conn, ri_id);
				type = "ri";
			}else{
				//根据文件id(af_id)获取该文件的详细信息
				data = new FileManagerHandler().GetFileByID(conn, af_id);
				type = "af";
			}
			//根据收养类型(family_type)确定返回的页面
			String family_type = data.getString("FAMILY_TYPE");	//收养类型
			if("1".equals(family_type)){
				retValue = type + "double";	//返回双亲收养查看页面
			}else{
				retValue = type + "single";	//返回单亲收养查看页面
			}
			setAttribute("data", data);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
		}catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "获取文件信息操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("操作异常[获取文件信息操作]:" + e.getMessage(),e);
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
                        log.logError("LockChildAction的GetAdoptionPersonInfo.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	private void createPreData(Data applydata, Data filedata, String id){
		String ri_id = UUID.getUUID();
		applydata.add("RI_ID", ri_id);
		//男收养人信息
		applydata.add("MALE_NAME", filedata.getString("MALE_NAME",""));
		applydata.add("MALE_BIRTHDAY", filedata.getString("MALE_BIRTHDAY",""));
		applydata.add("MALE_PHOTO", filedata.getString("MALE_PHOTO",""));
		applydata.add("MALE_NATION", filedata.getString("MALE_NATION",""));
		applydata.add("MALE_PASSPORT_NO", filedata.getString("MALE_PASSPORT_NO",""));
		applydata.add("MALE_EDUCATION", filedata.getString("MALE_EDUCATION",""));
		applydata.add("MALE_JOB_EN", filedata.getString("MALE_JOB_EN",""));
		applydata.add("MALE_JOB_CN", filedata.getString("MALE_JOB_CN",""));
		applydata.add("MALE_HEALTH", filedata.getString("MALE_HEALTH",""));
		applydata.add("MALE_HEALTH_CONTENT_CN", filedata.getString("MALE_HEALTH_CONTENT_CN",""));
		applydata.add("MALE_HEALTH_CONTENT_EN", filedata.getString("MALE_HEALTH_CONTENT_EN",""));
		applydata.add("MALE_PUNISHMENT_FLAG", filedata.getString("MALE_PUNISHMENT_FLAG",""));
		applydata.add("MALE_PUNISHMENT_CN", filedata.getString("MALE_PUNISHMENT_CN",""));
		applydata.add("MALE_PUNISHMENT_EN", filedata.getString("MALE_PUNISHMENT_EN",""));
		applydata.add("MALE_ILLEGALACT_FLAG", filedata.getString("MALE_ILLEGALACT_FLAG",""));
		applydata.add("MALE_ILLEGALACT_CN", filedata.getString("MALE_ILLEGALACT_CN",""));
		applydata.add("MALE_ILLEGALACT_EN", filedata.getString("MALE_ILLEGALACT_EN",""));
		applydata.add("MALE_MARRY_TIMES", filedata.getString("MALE_MARRY_TIMES",""));
		applydata.add("MALE_YEAR_INCOME", filedata.getString("MALE_YEAR_INCOME",""));
		applydata.add("FEMALE_NAME", filedata.getString("FEMALE_NAME",""));
		applydata.add("FEMALE_BIRTHDAY", filedata.getString("FEMALE_BIRTHDAY",""));
		applydata.add("FEMALE_PHOTO", filedata.getString("FEMALE_PHOTO",""));
		applydata.add("FEMALE_NATION", filedata.getString("FEMALE_NATION",""));
		applydata.add("FEMALE_PASSPORT_NO", filedata.getString("FEMALE_PASSPORT_NO",""));
		applydata.add("FEMALE_EDUCATION", filedata.getString("FEMALE_EDUCATION",""));
		applydata.add("FEMALE_JOB_EN", filedata.getString("FEMALE_JOB_EN",""));
		applydata.add("FEMALE_JOB_CN", filedata.getString("FEMALE_JOB_CN",""));
		applydata.add("FEMALE_HEALTH", filedata.getString("FEMALE_HEALTH",""));
		applydata.add("FEMALE_HEALTH_CONTENT_CN", filedata.getString("FEMALE_HEALTH_CONTENT_CN",""));
		applydata.add("FEMALE_HEALTH_CONTENT_EN", filedata.getString("FEMALE_HEALTH_CONTENT_EN",""));
		applydata.add("FEMALE_PUNISHMENT_FLAG", filedata.getString("FEMALE_PUNISHMENT_FLAG",""));
		applydata.add("FEMALE_PUNISHMENT_CN", filedata.getString("FEMALE_PUNISHMENT_CN",""));
		applydata.add("FEMALE_PUNISHMENT_EN", filedata.getString("FEMALE_PUNISHMENT_EN",""));
		applydata.add("FEMALE_ILLEGALACT_FLAG", filedata.getString("FEMALE_ILLEGALACT_FLAG",""));
		applydata.add("FEMALE_ILLEGALACT_CN", filedata.getString("FEMALE_ILLEGALACT_CN",""));
		applydata.add("FEMALE_ILLEGALACT_EN", filedata.getString("FEMALE_ILLEGALACT_EN",""));
		applydata.add("FEMALE_MARRY_TIMES", filedata.getString("FEMALE_MARRY_TIMES",""));
		applydata.add("FEMALE_YEAR_INCOME", filedata.getString("FEMALE_YEAR_INCOME",""));
		applydata.add("ADOPTER_SEX", filedata.getString("ADOPTER_SEX",""));
		//家庭信息
		applydata.add("MARRY_CONDITION", filedata.getString("MARRY_CONDITION",""));
		applydata.add("MARRY_DATE", filedata.getString("MARRY_DATE",""));
		applydata.add("CONABITA_PARTNERS", filedata.getString("CONABITA_PARTNERS",""));
		applydata.add("CONABITA_PARTNERS_TIME", filedata.getString("CONABITA_PARTNERS_TIME",""));
		applydata.add("GAY_STATEMENT", filedata.getString("GAY_STATEMENT",""));
		applydata.add("CURRENCY", filedata.getString("CURRENCY",""));
		applydata.add("TOTAL_ASSET", filedata.getString("TOTAL_ASSET",""));
		applydata.add("TOTAL_DEBT", filedata.getString("TOTAL_DEBT",""));
		applydata.add("CHILD_CONDITION_CN", filedata.getString("CHILD_CONDITION_CN",""));
		applydata.add("CHILD_CONDITION_EN", filedata.getString("CHILD_CONDITION_EN",""));
		applydata.add("UNDERAGE_NUM", filedata.getString("UNDERAGE_NUM",""));
		applydata.add("ADDRESS", filedata.getString("ADDRESS",""));
		applydata.add("ADOPT_REQUEST_CN", filedata.getString("ADOPT_REQUEST_CN",""));
		applydata.add("ADOPT_REQUEST_EN", filedata.getString("ADOPT_REQUEST_EN",""));
		applydata.add("IS_FAMILY_OTHERS_FLAG", filedata.getString("IS_FAMILY_OTHERS_FLAG",""));
		applydata.add("IS_FAMILY_OTHERS_CN", filedata.getString("IS_FAMILY_OTHERS_CN",""));
		applydata.add("IS_FAMILY_OTHERS_EN", filedata.getString("IS_FAMILY_OTHERS_EN",""));
		//收养类型
		applydata.add("FAMILY_TYPE", filedata.getString("FAMILY_TYPE",""));
		
		//复制预批申请信息中的收养人照片
		String adopter_sex = applydata.getString("ADOPTER_SEX","");
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		if("".equals(adopter_sex)){
			AttHelper.copyAtts("AF", id, "AF", AttConstants.AF_MALEPHOTO, "AF", ri_id, "AF", AttConstants.AF_MALEPHOTO, "org_id=" + orgCode, "af_id=" + ri_id);
			AttHelper.copyAtts("AF", id, "AF", AttConstants.AF_FEMALEPHOTO, "AF", ri_id, "AF", AttConstants.AF_FEMALEPHOTO, "org_id=" + orgCode, "af_id=" + ri_id);
		}else if("1".equals(adopter_sex)){
			AttHelper.copyAtts("AF", id, "AF", AttConstants.AF_MALEPHOTO, "AF", ri_id, "AF", AttConstants.AF_MALEPHOTO, "org_id=" + orgCode, "af_id=" + ri_id);
		}else if("1".equals(adopter_sex)){
			AttHelper.copyAtts("AF", id, "AF", AttConstants.AF_FEMALEPHOTO, "AF", ri_id, "AF", AttConstants.AF_FEMALEPHOTO, "org_id=" + orgCode, "af_id=" + ri_id);
		}
	}
	
}
