/**   
 * @Title: PreApproveAuditHandler.java 
 * @Package com.dcfs.sce.preApproveAudit 
 * @Description: 预批申请审核操作
 * @author yangrt   
 * @date 2014-10-9 下午4:01:45 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveAudit;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.util.Map;

import com.dcfs.sce.common.PreApproveConstant;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: PreApproveAuditHandler 
 * @Description: 预批审核数据操作
 * @author yangrt
 * @date 2014-10-9 下午4:01:45 
 *  
 */
public class PreApproveAuditHandler extends BaseHandler {

	/**
	 * @Title: PreApproveAuditListAZB
	 * @Description: 安置部预批申请审核查询列表
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList
	 * @throws DBException
	 */
	public DataList PreApproveAuditListAZB(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String ADOPT_ORG_NAME_CN = data.getString("ADOPT_ORG_NAME_CN",null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME",null);					//男收养人姓名
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);				//女收养人姓名
		String PROVINCE_ID = data.getString("PROVINCE_ID",null);				//省份
		String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN",null);		//福利院
		String NAME = data.getString("NAME",null);								//儿童姓名
		String SEX = data.getString("SEX",null);								//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);			//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);				//儿童出生截止日期
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS",null);			//特别关注
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);			//申请起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);				//申请截止日期
		String AUD_STATE2 = data.getString("AUD_STATE2",null);					//安置部状态
		String AUD_STATE1 = data.getString("AUD_STATE1",null);					//审核部状态
		String LAST_STATE2 = data.getString("LAST_STATE2",null);				//文件末次补充状态
		String ATRANSLATION_STATE2 = data.getString("ATRANSLATION_STATE2",null);//文件补翻状态
		String RI_STATE = data.getString("RI_STATE",null);						//预批状态
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);		//预批通过起始日期
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);			//预批通过截止日期
		
		if(RI_STATE == null || "".equals(RI_STATE)){
			RI_STATE = "('1','2')";
			if(AUD_STATE2 == null || "".equals(AUD_STATE2)){
				AUD_STATE2 = "('0','4')";
			}else{
				String str = AUD_STATE2;
				AUD_STATE2 = "('" + str + "')";
			}
		}else{
			RI_STATE = "('" + RI_STATE + "')";
			if(AUD_STATE2 != null && !"".equals(AUD_STATE2)){
				String str = AUD_STATE2;
				AUD_STATE2 = "('" + str + "')";
			}
		}
		
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveAuditList",ADOPT_ORG_NAME_CN,MALE_NAME,FEMALE_NAME,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,SPECIAL_FOCUS,REQ_DATE_START,REQ_DATE_END,AUD_STATE1,LAST_STATE2,ATRANSLATION_STATE2,RI_STATE,PASS_DATE_START,PASS_DATE_END,compositor,ordertype,AUD_STATE2);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: PreApproveAuditSave 
	 * @Description: 预批申请审核信息保存操作
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param applydata
	 * @return boolean 
	 * @throws DBException
	 */
	public boolean PreApproveAuditSave(Connection conn, Map<String, Object> data,Map<String, Object> applydata,Map<String, Object> suppledata, Map<String, Object> suppletranslationdata, String type) throws DBException {
		//保存审核信息
		Data auditdata = new Data(data);
		auditdata.setConnection(conn);
        auditdata.setEntityName("SCE_REQ_ADUIT");
        auditdata.setPrimaryKey("RAU_ID");
        auditdata.store();
        
        //审核不通过时，撤销预批并解除锁定
        Data updatedata = new Data(applydata);
        String ri_state = updatedata.getString("RI_STATE");
        if(PreApproveConstant.PRE_APPROVAL_SHBTG.equals(ri_state)){
        	UserInfo userinfo = SessionInfo.getCurUser();
        	updatedata.add("PUB_ID", "");										//发布状态制空
        	updatedata.add("LOCK_STATE", "1");									//解除锁定
        	updatedata.add("UNLOCKER_ID", userinfo.getPersonId());				//解除锁定人id
        	updatedata.add("UNLOCKER_NAME", userinfo.getPerson().getEnName());	//解除锁定人姓名
        	updatedata.add("UNLOCKER_DATE", DateUtility.getCurrentDateTime());	//解除锁定日期
			updatedata.add("UNLOCKER_TYPE", "2");								//解除锁定类型：中心解除（UNLOCKER_TYPE：2）
			
			//修改特需儿童发布记录表中的发布状态，改为已发布（PUB_STATE：2）
			Data pubData = new Data();
			pubData.setConnection(conn);
			pubData.setEntityName("SCE_PUB_RECORD");
			pubData.setPrimaryKey("PUB_ID");
			pubData.add("PUB_ID", updatedata.getString("PUB_ID"));
			pubData.add("PUB_STATE", "2");
			pubData.add("LOCK_DATE", "");
			pubData.add("ADOPT_ORG_ID", "");
			pubData.store();
			
			//修改儿童材料信息表中的发布状态，改为已发布（PUB_STATE：2）
			Data childData = new Data();
			childData.setConnection(conn);
			childData.setEntityName("CMS_CI_INFO");
			childData.setPrimaryKey("CI_ID");
			childData.add("CI_ID", updatedata.getString("CI_ID"));
			childData.add("PUB_STATE", "2");
			childData.store();
        }
    			
		//保存申请信息
        updatedata.setConnection(conn);
        updatedata.setEntityName("SCE_REQ_INFO");
        updatedata.setPrimaryKey("RI_ID");
		updatedata.store();
		
		//当前操作的审核结果
    	String audit_option = auditdata.getString("AUDIT_OPTION","");
    	if("4".equals(audit_option)){
    		//如果审核结果为补充材料，则初始化预批申请补充记录
    		Data initdata = new Data(suppledata);
    		initdata.setConnection(conn);
    		initdata.setEntityName("SCE_REQ_ADDITIONAL");
    		initdata.setPrimaryKey("RA_ID");
    		initdata.create();
    	}else if("6".equals(audit_option)){
    		//初始化补翻记录
    		Data initdata = new Data(suppletranslationdata);
    		initdata.setConnection(conn);
    		initdata.setEntityName("SCE_REQ_TRANSLATION");
    		initdata.setPrimaryKey("AT_ID");
    		initdata.create();
    	}
    	
    	//初始化下一审核级别的审核记录
    	if("SHB".equals(type)){
    		String level = auditdata.getString("AUDIT_LEVEL","");
    		if("0".equals(level)){
    			if("1".equals(audit_option) || "2".equals(audit_option)){
        			Data auditData = new Data();
        			auditData.add("RI_ID", updatedata.getString("RI_ID"));
        			auditData.add("AUDIT_TYPE", "1");		//审核类型：审核部审核
        			auditData.add("AUDIT_LEVEL", "1");		//审核级别:1：部门主任审核
        			auditData.add("OPERATION_STATE", "0");	//操作状态：待处理
            		auditData.setConnection(conn);
        			auditData.setEntityName("SCE_REQ_ADUIT");
        			auditData.setPrimaryKey("RAU_ID");
        			auditData.create();
        		}
    		}else{
    			if("7".equals(audit_option) || "8".equals(audit_option)){
        			Data auditData = new Data();
        			auditData.add("RI_ID", updatedata.getString("RI_ID"));
        			auditData.add("AUDIT_TYPE", "1");		//审核类型：审核部审核
        			auditData.add("OPERATION_STATE", "0");	//操作状态：待处理
            		if("8".equals(audit_option)){			//复审上报
            			auditData.add("AUDIT_LEVEL", "2");	//审核级别：分管主任审批
            		}else if("7".equals(audit_option)){		//退回经办人
            			auditData.add("AUDIT_LEVEL", "0");	//审核级别：经办人审核
            		}
            		auditData.setConnection(conn);
        			auditData.setEntityName("SCE_REQ_ADUIT");
        			auditData.setPrimaryKey("RAU_ID");
        			auditData.create();
        		}
    		}
    	}
        
		return true;
	}
	
	/**
	 * @Title: PreApproveAuditRecordsList 
	 * @Description: 根据预批申请记录id,获取预批申请补充记录信息
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @param type
	 * @return DataList
	 * @throws DBException
	 */
	public DataList PreApproveSuppleRecordsList(Connection conn, String ri_id) throws DBException {
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveSuppleRecordsList",ri_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @Title: PreApproveAuditRecordsList 
	 * @Description: 根据预批申请记录id,获取预批申请审核记录信息
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @param type
	 * @return DataList
	 * @throws DBException
	 */
	public DataList PreApproveAuditRecordsList(Connection conn, String ri_id) throws DBException {
		/*String AUDIT_TYPE = null;
		if(type.equals("AZB")){
			AUDIT_TYPE = "2";	//安置部审核
		}else{
			AUDIT_TYPE = "1";	//审核部审核
		}*/
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveAuditRecordsList",ri_id);
		DataList dl = ide.find(sql);
		return dl;
	}

	/** 
	 * @Title: PreApproveCancelApplySave 
	 * @Description: 撤销预批保存预批申请信息
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @return boolean 
	 * @throws DBException 
	 */
	public boolean PreApproveCancelApplySave(Connection conn, Map<String,Object> data, Map<String,Object> fbdata, Map<String,Object> cdata) throws DBException {
		Data ridata = new Data(data);
		ridata.setConnection(conn);
		ridata.setEntityName("SCE_REQ_INFO");
		ridata.setPrimaryKey("RI_ID");
		ridata.store();
		
		//更新/创建发布记录
		Data pubData = new Data(fbdata);
		pubData.setConnection(conn);
		pubData.setEntityName("SCE_PUB_RECORD");
		pubData.setPrimaryKey("PUB_ID");
		if("".equals(pubData.getString("PUB_ID",""))){
			pubData.create();
		}else{
			pubData.store();
		}
		
		//更新儿童材料信息表的发布状态
		Data childData = new Data(cdata);
		childData.setConnection(conn);
		childData.setEntityName("CMS_CI_INFO");
		childData.setPrimaryKey("CI_ID");
		childData.store();
		
		//如果存在文件，则更行文件表中的预批信息
		String af_id = ridata.getString("AF_ID","");
		String file_type = ridata.getString("FILE_TYPE","");
		if(!af_id.equals("")){						//如果存在文件，则清空文件中的预批信息
			Data filedata = new Data();
			filedata.add("AF_ID", af_id);
			filedata.add("RI_ID", "");
			filedata.add("RI_STATE", "");
			filedata.add("CI_ID", "");
			if(file_type.equals("21")){				//如果文件类型为特转（file_type:21）
				filedata.add("FILE_TYPE", "10");	//文件类型改为正常（FILE_TYPE:10）
			}/*else if(file_type.equals("23")){		//如果文件类型为特双（file_type:23）
				filedata.add("FILE_TYPE", "20");	//文件类型改为特普（FILE_TYPE:20）
			}*/
			filedata.setConnection(conn);
			filedata.setEntityName("FFS_AF_INFO");
			filedata.setPrimaryKey("AF_ID");
			filedata.store();
		}
		
		return false;
	}

	/**
	 * 安置部预批撤销确认
	 * @param conn
	 * @param data
	 * @param fbdata
	 * @param cdata
	 * @return
	 * @throws DBException
	 */
	public boolean PreApproveCancelApplySaveForAZB(Connection conn, Map<String,Object> data, Map<String,Object> fbdata, Map<String,Object> cdata) throws DBException {
		Data ridata = new Data(data);
		ridata.setConnection(conn);
		ridata.setEntityName("SCE_REQ_INFO");
		ridata.setPrimaryKey("RI_ID");
		ridata.store();
		
		//更新/创建发布记录
		Data pubData = new Data(fbdata);
		pubData.setConnection(conn);
		pubData.setEntityName("SCE_PUB_RECORD");
		pubData.setPrimaryKey("PUB_ID");
		if("".equals(pubData.getString("PUB_ID",""))){
			pubData.create();
		}else{
			pubData.store();
		}
		
		//更新儿童材料信息表的发布状态
		Data childData = new Data(cdata);
		childData.setConnection(conn);
		childData.setEntityName("CMS_CI_INFO");
		childData.setPrimaryKey("CI_ID");
		childData.store();
		return false;
	}
	/** 
	 * @Title: PreApproveAuditListSHB 
	 * @Description: 审核部预批申请审核列表
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param pageSize
	 * @param page
	 * @param compositor
	 * @param ordertype
	 * @return DataList 
	 * @throws DBException
	 */
	public DataList PreApproveAuditListSHB(Connection conn, Data data,String level,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String ADOPT_ORG_NAME_CN = data.getString("ADOPT_ORG_NAME_CN",null);	//收养组织
		String MALE_NAME = data.getString("MALE_NAME",null);					//男收养人姓名
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);				//女收养人姓名
		String PROVINCE_ID = data.getString("PROVINCE_ID",null);				//省份
		String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN",null);		//福利院
		String NAME = data.getString("NAME",null);								//儿童姓名
		String SEX = data.getString("SEX",null);								//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);			//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);				//儿童出生截止日期
		String SPECIAL_FOCUS = data.getString("SPECIAL_FOCUS",null);			//特别关注
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);			//申请起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);				//申请截止日期
		String AUD_STATE2 = data.getString("AUD_STATE2",null);					//安置部状态
		String AUD_STATE1 = data.getString("AUD_STATE1",null);					//审核部状态
		String LAST_STATE = data.getString("LAST_STATE",null);				//文件末次补充状态
		String ATRANSLATION_STATE = data.getString("ATRANSLATION_STATE",null);//文件补翻状态
		String RI_STATE = data.getString("RI_STATE",null);						//预批状态
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);		//预批通过起始日期
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);			//预批通过截止日期
		
		if(RI_STATE == null || "".equals(RI_STATE)){
			RI_STATE = "('1','2')";
			if(AUD_STATE1 == null || "".equals(AUD_STATE1)){
				if(level.equals("one")){
					AUD_STATE1 = "('0','1','9')";
				}else if(level.equals("two")){
					AUD_STATE1 = "('2')";
				}else if(level.equals("three")){
					AUD_STATE1 = "('3')";
				}
			}else{
				String str = AUD_STATE1;
				AUD_STATE1 = "('" + str + "')";
			}
		}else{
			RI_STATE = "('" + RI_STATE + "')";
			if(AUD_STATE1 != null && !"".equals(AUD_STATE1)){
				String str = AUD_STATE1;
				AUD_STATE1 = "('" + str + "')";
			}
		}
			
//		if(AUD_STATE1 == null || "".equals(AUD_STATE1)){
//			if(level.equals("one")){
//				AUD_STATE1 = "('0','1','9')";
//			}else if(level.equals("two")){
//				AUD_STATE1 = "('2')";
//			}else if(level.equals("three")){
//				AUD_STATE1 = "('3')";
//			}
//		}else{
//			String str = AUD_STATE1;
//			AUD_STATE1 = "('" + str + "')";
//		}
		
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveAuditListSHB",ADOPT_ORG_NAME_CN,MALE_NAME,FEMALE_NAME,PROVINCE_ID,WELFARE_NAME_CN,NAME,SEX,BIRTHDAY_START,BIRTHDAY_END,SPECIAL_FOCUS,REQ_DATE_START,REQ_DATE_END,AUD_STATE2,LAST_STATE,ATRANSLATION_STATE,RI_STATE,PASS_DATE_START,PASS_DATE_END,compositor,ordertype,AUD_STATE1);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/** 
	 * @Title: getPreApproveByReqNo 
	 * @Description: 根据预批申请编号，获取预批申请信息
	 * @author: yangrt
	 * @param conn
	 * @param pre_reqNo
	 * @return Data 
	 * @throws DBException 
	 */
	public Data getPreApproveByReqNo(Connection conn, String reqNo) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreApproveByReqNo", reqNo);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @throws DBException  
	 * @Title: getPubDataById 
	 * @Description: 根据发布记录id，获取发布记录信息
	 * @author: yangrt
	 * @param conn
	 * @param pub_id
	 * @return Data 
	 */
	public Data getPubDataById(Connection conn, String pub_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPubDataById", pub_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @throws DBException  
	 * @Title: getPreAuditId 
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @author: yangrt;
	 * @param conn
	 * @param ri_id    设定文件 
	 * @return void    返回类型 
	 * @throws 
	 */
	public Data getPreAuditId(Connection conn, String ri_id, String audit_type, String audit_level) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreAuditId", ri_id, audit_type, audit_level);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

}
