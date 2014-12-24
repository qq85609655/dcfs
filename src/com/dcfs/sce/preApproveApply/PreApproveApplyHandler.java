/**   
 * @Title: PreApproveApplyHandler.java 
 * @Package PreApproveApplyHandler 
 * @Description: 预批申请操作
 * @author yangrt   
 * @date 2014-9-12 下午3:19:45 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveApply;

import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.sql.Connection;
import java.util.Map;

import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileGlobalStatusAndPositionConstant;
import com.dcfs.ffs.fileManager.FileManagerAction;
import com.dcfs.ncm.special.SpecialMatchAction;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.common.PublishCommonManager;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/** 
 * @ClassName: PreApproveApplyHandler 
 * @Description: 预批申请操作
 * @author yangrt;
 * @date 2014-9-12 下午3:19:45 
 *  
 */
public class PreApproveApplyHandler extends BaseHandler {

	/**
	 * @Title: PreApproveApplyList 
	 * @Description: 预批申请信息查询列表
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
	public DataList PreApproveApplyList(Connection conn, Data data,
			int pageSize, int page, String compositor, String ordertype) throws DBException {
		//查询条件
		String MALE_NAME = data.getString("MALE_NAME",null);				//男收养人姓名
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);			//女收养人姓名
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);			//儿童姓名
		String SEX = data.getString("SEX",null);							//儿童性别
		String BIRTHDAY_START = data.getString("BIRTHDAY_START",null);		//儿童出生起始日期
		String BIRTHDAY_END = data.getString("BIRTHDAY_END",null);			//儿童出生截止日期
		String LOCK_DATE_START = data.getString("REQ_DATE_START",null);		//锁定起始日期
		String LOCK_DATE_END = data.getString("REQ_DATE_END",null);			//锁定截止日期
		String REQ_DATE_START = data.getString("REQ_DATE_START",null);		//申请起始日期
		String REQ_DATE_END = data.getString("REQ_DATE_END",null);			//申请截止日期
		String PASS_DATE_START = data.getString("PASS_DATE_START",null);	//预批通过起始日期
		String PASS_DATE_END = data.getString("PASS_DATE_END",null);		//预批通过截止日期
		String RI_STATE = data.getString("RI_STATE",null);					//预批状态
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START",null);//递交文件起始期限
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END",null);	//递交文件截止期限
		String REMINDERS_STATE = data.getString("REMINDERS_STATE",null);	//催办状态
		String REM_DATE_START = data.getString("REM_DATE_START",null);		//催办起始日期
		String REM_DATE_END = data.getString("REM_DATE_END",null);			//催办截止日期
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START",null);//收文起始日期
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END",null);//收文截止日期
		String FILE_NO = data.getString("FILE_NO",null);					//收文编号
		String UPDATE_DATE_START = data.getString("UPDATE_DATE_START",null);//文件最后更新起始日期
		String UPDATE_DATE_END = data.getString("UPDATE_DATE_END",null);	//文件最后更新截止日期
		String LAST_STATE = data.getString("LAST_STATE",null);				//审核部补充状态
		String LAST_STATE2 = data.getString("LAST_STATE2",null);			//安置部补充状态
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();
		
		//数据库操作
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("PreApproveApplyList", MALE_NAME,FEMALE_NAME,NAME_PINYIN,SEX,
        		BIRTHDAY_START,BIRTHDAY_END,REQ_DATE_START,REQ_DATE_END,PASS_DATE_START,
        		PASS_DATE_END,RI_STATE,SUBMIT_DATE_START,SUBMIT_DATE_END,REMINDERS_STATE,
        		REM_DATE_START,REM_DATE_END,REGISTER_DATE_START,REGISTER_DATE_END,FILE_NO,
        		UPDATE_DATE_START,UPDATE_DATE_END,LAST_STATE,LOCK_DATE_START,LOCK_DATE_END,compositor,ordertype,orgcode,LAST_STATE2);
		DataList dl = ide.find(sql, pageSize, page);
		return dl;
	}

	/**
	 * @Title: getPreApproveApplyData 
	 * @Description: 根据预批申请记录ID,获取预批申请信息Data
	 * @author: yangrt
	 * @param conn
	 * @param ri_id
	 * @return Data
	 * @throws DBException  
	 */
	public Data getPreApproveApplyData(Connection conn, String ri_id) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getPreApproveApplyData", ri_id);
		DataList dl = ide.find(sql);
		return dl.getData(0);
	}

	/**
	 * @Title: PreApproveApplySubmit 
	 * @Description: 预批申请提交操作
	 * @author: yangrt
	 * @param conn
	 * @param submit_id
	 * @return boolean
	 * @throws DBException 
	 */
	public boolean PreApproveApplySubmit(Connection conn, String[] submit_id) throws DBException {
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgid = userinfo.getCurOrgan().getId();
		//获取收养组织信息
		SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
		String TRANS_FLAG = syzzinfo.getTransFlag();	//预批是否翻译：1=是；0=否
		
		for (int i = 0; i < submit_id.length; i++) {
			Data applyData = this.getPreApproveApplyData(conn, submit_id[i]);
			applyData.add("REQ_DATE", DateUtility.getCurrentDateTime());	//预批申请日期
			applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YTJ);									//预批状态:已提交
			
			String af_id = applyData.getString("AF_ID","");
			String file_type = applyData.getString("FILE_TYPE");		//文件类型
			
			boolean flag = af_id.equals("");								//是否是选择文件进行锁定（flag=true:未选择文件）
			
			Data fileData = new Data();
			if(!flag){
				//根据文件id,获取文件信息
				fileData = new FileManagerAction().GetFileByID(af_id);
				fileData.removeData("XMLSTR");
			}
			
			if("21".equals(file_type)){
				
				DataList afList = new DataList();
				Data afData = new Data();
				
	        	fileData.add("FILE_TYPE", applyData.getString("FILE_TYPE"));	//文件类型：特转（FILE_TYPE:21）
				String af_position = fileData.getString("AF_POSITION","");		//文件的当前位置
				String match_state = fileData.getString("MATCH_STATE","");		//文件的匹配状态
	        	if(af_position.equals(FileGlobalStatusAndPositionConstant.POS_DAB) || match_state.equals("0")){
	        		applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);								//预批状态改为已匹配（RI_STATE:7）
	        		afData.add("AF_ID", af_id);
	        		afData.add("CI_ID", applyData.getString("CI_ID"));
	        		afData.add("ADOPT_ORG_ID", fileData.getString("ADOPT_ORG_ID",""));
	            	afList.add(afData);
	        	}else{
	        		applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YQD);	//预批状态改为已启动（RI_STATE:6）
	        	}
		        if(afList.size() > 0){
		        	new SpecialMatchAction().saveMatchInfoForSYZZ(conn, afList);
		        }
    			
			}else{
				if("1".equals(TRANS_FLAG)){
					//初始化预批翻译记录
					Data initData = new Data();
					initData.add("RI_ID", submit_id[i]);
					initData.add("TRANSLATION_TYPE", "0");		//翻译类型：翻译=0
	    			PublishCommonManager pcm = new PublishCommonManager();
	    			pcm.translationInit(conn, initData);
	    			//添加预批记录中的翻译状态:待翻译(TRANSLATION_STATE：0)
	    			applyData.add("TRANSLATION_STATE", "0");
				}else{
					//初始化安置部预批审核记录信息(AUDIT_TYPE:2)
					Data azbdata = new Data();
					azbdata.add("RI_ID", applyData.getString("RI_ID",""));
					azbdata.add("AUDIT_TYPE", "2");
					azbdata.add("OPERATION_STATE", "0");	//待处理
					azbdata.setConnection(conn);
		            azbdata.setEntityName("SCE_REQ_ADUIT");
		            azbdata.setPrimaryKey("RAU_ID");
		            azbdata.create();
					
					//初始化审核部预批审核记录信息(AUDIT_TYPE:1)
					Data shbdata = new Data();
					shbdata.add("RI_ID", applyData.getString("RI_ID",""));
					shbdata.add("AUDIT_TYPE", "1");
					shbdata.add("AUDIT_LEVEL", "0");		//经办人审核
					shbdata.add("OPERATION_STATE", "0");	//待处理
					shbdata.setConnection(conn);
					shbdata.setEntityName("SCE_REQ_ADUIT");
					shbdata.setPrimaryKey("RAU_ID");
					shbdata.create();
					
					//初始化预批申请记录中的安置部状态（AUD_STATE2）、审核部状态（AUD_STATE1）
					applyData.add("AUD_STATE2", "0");
					applyData.add("AUD_STATE1", "0");
				}
			}
			
			applyData.setConnection(conn);
			applyData.setEntityName("SCE_REQ_INFO");
			applyData.setPrimaryKey("RI_ID");
			applyData.store();
			
			//如果选择文件进行锁定，则需要更新收养文件信息表中的预批信息
			if(!flag){
				
				String ci_id = applyData.getString("CI_ID","");
				LockChildHandler lch = new LockChildHandler();
				Data mainData = lch.getMainChildInfo(conn, ci_id);
				DataList dl = new DataList();
				String ciIdstr = ci_id;
				String is_twins = mainData.getString("IS_TWINS","");
				if("1".equals(is_twins)){
					dl = lch.getAttachChildList(conn, ci_id);
					for(int j = 0; j < dl.size(); j++){
						ciIdstr += "," + dl.getData(j).getString("CI_ID");
					}
				}
				
				//更新收养文件信息表中的预批信息（RI_ID：预批记录ID，RI_STATE：预批状态）
				fileData.add("RI_ID", applyData.getString("RI_ID"));
				fileData.add("RI_STATE", applyData.getString("RI_STATE"));
				
				fileData.add("CI_ID", ciIdstr);
				fileData.setConnection(conn);
				fileData.setEntityName("FFS_AF_INFO");
				fileData.setPrimaryKey("AF_ID");
				fileData.store();
			}
		}
		
		return true;
	}

	/**
	 * @Title: PreApproveApplyDelete 
	 * @Description: 预批申请删除操作
	 * @author: yangrt
	 * @param conn
	 * @param uuid
	 * @return boolean
	 * @throws DBException
	 */
	public boolean PreApproveApplyDelete(Connection conn, String[] uuid) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for (int i = 0; i < uuid.length; i++) {
			//获取预批申请信息
			String sql = getSql("getPreApproveApplyData", uuid[i]);
			Data applydata = ide.find(sql).getData(0);
			//根据预批申请信息，获取锁定儿童信息id
			String ci_id = applydata.getString("CI_ID");
			Data childdata = ide.find(getSql("getChildDataById",ci_id)).getData(0);
			//根据儿童信息，获取特需儿童末次发布日期
			String pub_lastdate = childdata.getString("PUB_LASTDATE");
			Data pubdata = ide.find(getSql("getPubRecodeData", ci_id, pub_lastdate)).getData(0);
			
			UserInfo userinfo = SessionInfo.getCurUser();
			
			//修改预批申请记录表中的预批状态，改为无效（RI_STATE：9）
			Data applyData = new Data();
			applyData.setConnection(conn);
			applyData.setEntityName("SCE_REQ_INFO");
			applyData.setPrimaryKey("RI_ID");
			applyData.add("RI_ID", uuid[i]);
			applyData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX);
			applyData.add("PUB_ID", "");										//发布状态制空
			applyData.add("AF_ID", "");											//文件id
			applyData.add("LOCK_STATE", "1");									//解除锁定
			applyData.add("UNLOCKER_ID", userinfo.getPersonId());				//解除锁定人id
			applyData.add("UNLOCKER_NAME", userinfo.getPerson().getEnName());	//解除锁定人姓名
			applyData.add("UNLOCKER_DATE", DateUtility.getCurrentDateTime());	//解除锁定日期
			applyData.add("UNLOCKER_TYPE", "1");								//解除锁定类型：组织解除（UNLOCKER_TYPE：1）
			applyData.add("REVOKE_TYPE", "0");									//预批撤销类型：组织撤销（REVOKE_TYPE：0）
			ide.store(applyData);
			
			//修改特需儿童发布记录表中的发布状态，改为已发布（PUB_STATE：2）
			Data pubData = new Data();
			pubData.setConnection(conn);
			pubData.setEntityName("SCE_PUB_RECORD");
			pubData.setPrimaryKey("PUB_ID");
			pubData.add("PUB_ID", pubdata.getString("PUB_ID"));
			pubData.add("PUB_STATE", "2");
			pubData.add("LOCK_DATE", "");
			pubData.add("ADOPT_ORG_ID", "");
			ide.store(pubData);
			
			//修改儿童材料信息表中的发布状态，改为已发布（PUB_STATE：2）
			Data childData = new Data();
			childData.setConnection(conn);
			childData.setEntityName("CMS_CI_INFO");
			childData.setPrimaryKey("CI_ID");
			childData.add("CI_ID", ci_id);
			childData.add("PUB_STATE", "2");
			ide.store(childData);
			
			/*//清空文件信息表中的预批记录id、预批状态
			Data fileData = new Data();
			fileData.setConnection(conn);
			fileData.setEntityName("FFS_AF_INFO");
			fileData.setPrimaryKey("AF_ID");
			fileData.add("AF_ID", applydata.getString("AF_ID"));
			fileData.add("RI_ID", "");
			fileData.add("RI_STATE", "");
			//如锁定方式为1的，文件类型由“特转”变为“正常”
			if(lock_mode.equals("1")){
				if(applydata.getString("FILE_TYPE").equals("21")){
					fileData.add("FILE_TYPE", "10");
				}
				fileData.add("CI_ID", "");
			}
			ide.store(fileData);*/
		}
		return true;
	}

	/**
	 * @Title: PreApproveApplySave 
	 * @Description: 预批申请信息保存操作
	 * @author: yangrt
	 * @param conn
	 * @param data
	 * @param TRANS_FLAG
	 * @return boolean    返回类型 
	 * @throws DBException
	 */
	public boolean PreApproveApplySave(Connection conn, Map<String, Object> data, String TRANS_FLAG) throws DBException {
		Data ridata = new Data(data);
		
		String af_id = ridata.getString("AF_ID","");
		String ri_state = ridata.getString("RI_STATE","");		//预批状态
		String file_type = ridata.getString("FILE_TYPE");		//文件类型
		String lock_mode = ridata.getString("LOCK_MODE");		//锁定方式
		String preReqNo = ridata.getString("PRE_REQ_NO");		//之前预批编号
		
		char mode = lock_mode.toCharArray()[0];
		Data fileData = new Data();
		switch(mode){
			case '1':
				fileData = new FileManagerAction().GetFileByID(af_id);
				fileData.removeData("XMLSTR");
				if(PreApproveConstant.PRE_APPROVAL_YTJ.equals(ri_state)){
					//提交时，正常文件的文件类型改为特转（FILE_TYPE:21）
					if("21".equals(file_type)){
						fileData.put("FILE_TYPE", ridata.getString("FILE_TYPE"));
						ridata.add("PASS_DATE", DateUtility.getCurrentDateTime());
						ridata.add("SUBMIT_DATE", "2999-12-31");
					}
					//初始化匹配记录信息
			        DataList afList = new DataList();
			        Data afData = new Data();
			        
					String match_state = fileData.getString("MATCH_STATE","");			//文件的匹配状态
		        	if("0".equals(match_state)){
		        		ridata.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YPP);	//预批状态改为已匹配（RI_STATE:7）
		        		afData.add("AF_ID", af_id);
		        		afData.add("CI_ID", ridata.getString("CI_ID"));
		        		afData.add("ADOPT_ORG_ID", fileData.getString("ADOPT_ORG_ID",""));
		            	afList.add(afData);
		            	new SpecialMatchAction().saveMatchInfoForSYZZ(conn, afList);
		        	}else{
		        		ridata.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_YQD);	//预批状态改为已启动（RI_STATE:6）
		        	}
		        
		        	String ci_id = ridata.getString("CI_ID","");
					LockChildHandler lch = new LockChildHandler();
					Data mainData = lch.getMainChildInfo(conn, ci_id);
					DataList dl = new DataList();
					String ciIdstr = ci_id;
					String is_twins = mainData.getString("IS_TWINS","");
					if("1".equals(is_twins)){
						dl = lch.getAttachChildList(conn, ci_id);
						for(int j = 0; j < dl.size(); j++){
							ciIdstr += "," + dl.getData(j).getString("CI_ID");
						}
					}
					
					//更新收养文件信息表中的预批信息（RI_ID：预批记录ID，RI_STATE：预批状态）
					int cost = new FileCommonManager().getAfCost(conn, "TXWJFWF");
					int childnum = ciIdstr.split(",").length;
					int pre_af_cost = fileData.getInt("AF_COST");
					int new_af_cost = cost * childnum;
					fileData.add("AF_COST", new_af_cost); 
					if(new_af_cost > pre_af_cost){
						fileData.add("AF_COST_CLEAR", "0");			//文件的完费状态为未完费（AF_COST_CLEAR：0）
					}
					fileData.add("RI_ID", ridata.getString("RI_ID"));
					fileData.add("RI_STATE", ridata.getString("RI_STATE"));
					fileData.add("CI_ID", ciIdstr);
					fileData.setConnection(conn);
					fileData.setEntityName("FFS_AF_INFO");
					fileData.setPrimaryKey("AF_ID");
					fileData.store();
				}
				break;
			case '2':
				break;
			case '3':
				break;
			case '4':
				break;
			case '5':
				//更新之前预批申请记录中的文件类型为特双
				Data preRiData = new Data();
				preRiData.add("REQ_NO", preReqNo);		//预批编号
				preRiData.add("PRE_REQ_NO", ridata.getString("REQ_NO"));		//预批编号
				preRiData.add("FILE_TYPE", "23");		//更新预批申请中的文件类型为特双：23
				preRiData.setConnection(conn);
				preRiData.setEntityName("SCE_REQ_INFO");
				preRiData.setPrimaryKey("REQ_NO");
				preRiData.store();
				break;
			case '6':
				break;
		}
		
		//初始化预批翻译记录
		if(ri_state.equals(PreApproveConstant.PRE_APPROVAL_YTJ)){
			if(!"1".equals(lock_mode)){
				if("1".equals(TRANS_FLAG)){
					//初始化预批翻译记录
					Data initData = new Data();
					initData.add("RI_ID", ridata.getString("RI_ID"));
					initData.add("TRANSLATION_TYPE", "0");		//翻译类型：翻译=0
	    			PublishCommonManager pcm = new PublishCommonManager();
	    			pcm.translationInit(conn, initData);
	    			//添加预批记录中的翻译状态:待翻译(TRANSLATION_STATE：0)
	    			ridata.add("TRANSLATION_STATE", "0");
				}else{
					//初始化安置部预批审核记录信息(AUDIT_TYPE:2)
					Data azbdata = new Data();
					azbdata.add("RI_ID", ridata.getString("RI_ID",""));
					azbdata.add("AUDIT_TYPE", "2");
					azbdata.add("OPERATION_STATE", "0");	//待处理
					azbdata.setConnection(conn);
		            azbdata.setEntityName("SCE_REQ_ADUIT");
		            azbdata.setPrimaryKey("RAU_ID");
		            azbdata.create();
					
					//初始化审核部预批审核记录信息(AUDIT_TYPE:1)
					Data shbdata = new Data();
					shbdata.add("RI_ID", ridata.getString("RI_ID",""));
					shbdata.add("AUDIT_TYPE", "1");
					shbdata.add("AUDIT_LEVEL", "0");		//经办人审核
					shbdata.add("OPERATION_STATE", "0");	//待处理
					shbdata.setConnection(conn);
					shbdata.setEntityName("SCE_REQ_ADUIT");
					shbdata.setPrimaryKey("RAU_ID");
					shbdata.create();
					
					//初始化预批申请记录中的安置部状态（AUD_STATE2）、审核部状态（AUD_STATE1）
					ridata.add("AUD_STATE2", "0");
					ridata.add("AUD_STATE1", "0");
				}
			}
		}

		//保存预批申请记录
		ridata.setConnection(conn);
        ridata.setEntityName("SCE_REQ_INFO");
        ridata.setPrimaryKey("RI_ID");
		ridata.store();
		
		//更新发布记录表中的发布状态为已申请（PUB_STATE:4）
		Data pubData = new Data();
		pubData.add("PUB_ID", ridata.getString("PUB_ID"));
		pubData.add("PUB_STATE", "4");
		pubData.setConnection(conn);
		pubData.setEntityName("SCE_PUB_RECORD");
		pubData.setPrimaryKey("PUB_ID");
		pubData.store();
		
		//更新儿童材料表中的发布状态为已申请（PUB_STATE:4）
		Data ciData = new Data();
		ciData.add("CI_ID", ridata.getString("CI_ID"));
		ciData.add("PUB_STATE", "4");
		ciData.setConnection(conn);
		ciData.setEntityName("CMS_CI_INFO");
		ciData.setPrimaryKey("CI_ID");
		ciData.store();
    	
		return true;
	}

	/**
	 * @throws DBException  
	 * @Title: getRiIdForReminderNotice 
	 * @Description: 获取初始化预批催办通知所需的预批信息
	 * @author: yangrt
	 * @param conn
	 * @return DataList 
	 */
	public DataList getRiIdForReminderNotice(Connection conn) throws DBException {
		String curDate = DateUtility.getCurrentDateTime();
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		String sql = getSql("getRiIdForReminderNotice", curDate);
		DataList dl = ide.find(sql);
		return dl;
	}

	/**
	 * @throws DBException  
	 * @Title: updateRiDataList 
	 * @Description: 更新预批申请记录的催办信息
	 * @author: yangrt
	 * @param conn
	 * @param updateRiList 
	 * @return void 
	 */
	public void updateRiDataList(Connection conn, DataList updateRiList) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for(int i=0;i<updateRiList.size();i++){
			updateRiList.getData(i).setEntityName("SCE_REQ_INFO");
			updateRiList.getData(i).setPrimaryKey("RI_ID");
    	}
    	ide.batchStore(updateRiList);
		
	}

	/**
	 * @throws DBException  
	 * @Title: initReminderNoticeList 
	 * @Description: 初始化预批催办通知
	 * @author: yangrt
	 * @param conn
	 * @param initNoticeList 
	 * @return void
	 */
	public void initReminderNoticeList(Connection conn, DataList initNoticeList) throws DBException {
		IDataExecute ide = DataBaseFactory.getDataBase(conn);
		for(int i=0;i<initNoticeList.size();i++){
			initNoticeList.getData(i).setEntityName("SCE_REQ_REMINDER");
			initNoticeList.getData(i).setPrimaryKey("REM_ID");
    	}
    	ide.batchCreate(initNoticeList);
		
	}

}
