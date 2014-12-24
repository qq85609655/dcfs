package com.dcfs.sce.common;

import hx.common.Exception.DBException;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.dcfs.sce.REQInfo.REQInfoHandler;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.util.UUID;


/**
 * 
 * @description 发布管理公共类
 * @author MaYun
 * @date 2014-9-26
 * @return
 */
public class PublishCommonManager{
	private static Log log = UtilLog.getLog(PublishCommonManager.class);
	private PublishCommonManagerHandler handler = new PublishCommonManagerHandler();
	private REQInfoHandler reqHandler= new REQInfoHandler();
	private Connection conn = null;//数据库连接
	private DBTransaction dt = null;//事务处理
	
	/**
	 * @description 生成发布计划流水号(编码规则：9位数字，其中4位年度+5位流水号)
	 * @author MaYun
	 * @date 2014-9-26
	 * @return String pubPlanSeqNO 发布计划流水号
	 * @throws SQLException 
	 * @throws DBException 
	 */
	public String createPubPlanSeqNO(Connection conn) throws SQLException, DBException{
		String pubPlanSeqNO="";
		String year = DateUtility.getCurrentYear();
		
		synchronized (this) {
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxPubPlanSeqNo(conn, year);//得到当前最大流水
			String maxNoStr = (String)data.get("no");
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="0000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="000"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				maxNoStr="00"+maxNo;
			}else if(maxNo>999&&maxNo<10000){
				maxNoStr="0"+maxNo;
			}else {
				maxNoStr=""+maxNo;
			}
			pubPlanSeqNO=year+maxNoStr;//生成发布计划流水号
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("NO",maxNoStr);
			data2.add("SEQ_NO",pubPlanSeqNO);
			this.handler.saveMaxPubPlanSeqNo(conn, data2);//向发布计划流水号表插入流水号相关信息
		}
		return pubPlanSeqNO;
	}
	
	/**
	 * @Title: createPreApproveApplyNo 
	 * @Description: 创建预批申请编号
	 * @author: yangrt;
	 * @param conn
	 * @param orgCode 组织code
	 * @return String 
	 * @throws SQLException
	 * @throws DBException
	 */
	public String createPreApproveApplyNo(Connection conn,String orgCode) throws SQLException, DBException{
		String ApplyNo = "";
		String year = DateUtility.getCurrentYear();
		
		synchronized (this) {
			dt = DBTransaction.getInstance(conn);
			Data data = this.handler.getMaxPreApproveApplyNo(conn,year,orgCode);
			String maxNoStr = (String)data.get("NO");//得到最大5位流水号
			if("".equals(maxNoStr)||null==maxNoStr){
				maxNoStr="0";
			}
			int maxNo=Integer.parseInt(maxNoStr);
			maxNo=maxNo+1;
			if(maxNo<10){
				maxNoStr="0000"+maxNo;
			}else if(maxNo>9&&maxNo<100){
				maxNoStr="000"+maxNo;
			}else if(maxNo>99&&maxNo<1000){
				maxNoStr="00"+maxNo;
			}else if(maxNo>999&&maxNo<10000){
				maxNoStr="0"+maxNo;
			}else if(maxNo>9999){
				maxNoStr=""+maxNo;
			}
			
			ApplyNo=year.substring(2,year.length())+orgCode+maxNoStr;//生成预批申请编号
			Data data2 = new Data();
			data2.add("YEAR",year);
			data2.add("ORG_CODE",orgCode);
			data2.add("NO",maxNoStr);
			data2.add("SEQ_NO",ApplyNo);
			this.handler.saveMaxPreApproveApplyNo(conn, data2);//向收文编号表插入收文编号相关信息
		}
		return ApplyNo;
	}
	
	//解除匹配，修改预批信息。
	public void Removeprebatch(Connection conn,String ciid){
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	//根据预批ID查找预批记录
	 	try {
	 		//根据ci_id从预批表中查找ri_id;
	 		Data ypdata = reqHandler.findYPByCiid(conn,ciid);
	 		String RI_ID = ypdata.getString("RI_ID");
	 		//获取预批Data
    		Data ypwjData = reqHandler.getRIData(conn, RI_ID);
    		String AF_ID = ypwjData.getString("AF_ID");
	    	if(AF_ID!=null){
	    		//获取文件data
	    		Data wjData = reqHandler.getAFData(conn,AF_ID);
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
	    					d=reqHandler.getCHILDNOData(conn, CHILD_NO);
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
	    		reqHandler.saveFfsData(conn, wjData);
	    	}
			Data RIData =handler.getRIData(conn, RI_ID);
			RIData.add("RI_ID",RI_ID );
			RIData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX); //预批审批状态改为无效9
			String REVOKE_STATE = RIData.getString("REVOKE_STATE","");  //预批撤销状态
			if(REVOKE_STATE.equals("0")){
				RIData.add("REVOKE_TYPE", "0");//撤销类型为"组织撤销"
			}else{
				RIData.add("REVOKE_TYPE", "1");//撤销类型为"中心撤销"
			}
			RIData.add("REVOKE_CFM_USERID", personId);	//撤销申请确认人id
			RIData.add("REVOKE_CFM_USERNAME", personName);	//撤销申请确认人姓名
			RIData.add("REVOKE_CFM_DATE", curDate);	//撤销申请确认日期
			RIData.add("UNLOCKER_ID", personId);	//解除锁定人id
			RIData.add("UNLOCKER_NAME", personName);	//解除锁定人姓名
			RIData.add("UNLOCKER_DATE", curDate);	//解除锁定日期
			RIData.add("UNLOCKER_TYPE", "2");	//解除锁定类型：中心解除（UNLOCKER_TYPE：0）
			//发布记录表
			String PUB_ID = RIData.getString("PUB_ID");  //发布记录ID
			Data PubData = handler.getPubData(conn,PUB_ID);
			//儿童材料表
			String CI_ID = PubData.getString("CI_ID");
			Data CIData = handler.getCIData(conn,CI_ID);
			
			//获取安置期限
			String SETTLE_DATE = PubData.getString("SETTLE_DATE");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date SETTLE_DATE1 =  sdf.parse(SETTLE_DATE);
			Date curDate1 = sdf.parse(curDate);
			if(SETTLE_DATE1.getTime()>=curDate1.getTime()){
				PubData.add("PUB_STATE","2");  //发布记录表：发布状态改为已发布
				CIData.add("PUB_STATE", "2");  //儿童材料表：发布状态改为已发布
			}else if(SETTLE_DATE1.getTime()<curDate1.getTime()){
				PubData.add("PUB_STATE","9");  //发布记录表：发布状态改为待发布
				CIData.add("PUB_STATE", "0");  //儿童材料表：发布状态改为待发布
			}
			RIData.add("PUB_ID", "");  //预批表中的发布ID为空。
			handler.savePubData(conn,PubData);  //发布记录表
			handler.saveCIData(conn,CIData);  //儿童材料表
			handler.saveRIData(conn,RIData);  //预批记录表
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 文件审核不通过，撤销预批
	 * @param conn
	 * @param ciid
	 */
	public void RemoveByRIID(Connection conn,String RIIDS){
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	//根据预批ID查找预批记录
	 	String[] RI_IDS=RIIDS.split(",");
	 	String RI_ID="";
	 	try {
			for(int i=0;i<RI_IDS.length;i++){
				RI_ID=RI_IDS[i];
				//获取预批Data
				Data ypwjData = reqHandler.getRIData(conn, RI_ID);
				String AF_ID = ypwjData.getString("AF_ID");
				if(AF_ID!=null){
					//获取文件data
					Data wjData = reqHandler.getAFData(conn,AF_ID);
					//根据文件类型判断
					wjData.add("RI_ID", null);   //预批记录为null
					wjData.add("RI_STATE", null);  //预批状态null
					wjData.add("CI_ID", null);   //儿童材料null
					reqHandler.saveFfsData(conn, wjData);
				}
				Data RIData =handler.getRIData(conn, RI_ID);
				RIData.add("RI_ID",RI_ID );
				RIData.add("RI_STATE", PreApproveConstant.PRE_APPROVAL_WX); //预批审批状态改为无效9
				String REVOKE_STATE = RIData.getString("REVOKE_STATE","");  //预批撤销状态
				if(REVOKE_STATE.equals("0")){
					RIData.add("REVOKE_TYPE", "0");//撤销类型为"组织撤销"
				}else{
					RIData.add("REVOKE_TYPE", "1");//撤销类型为"中心撤销"
				}
				RIData.add("REVOKE_CFM_USERID", personId);	//撤销申请确认人id
				RIData.add("REVOKE_CFM_USERNAME", personName);	//撤销申请确认人姓名
				RIData.add("REVOKE_CFM_DATE", curDate);	//撤销申请确认日期
				RIData.add("UNLOCKER_ID", personId);	//解除锁定人id
				RIData.add("UNLOCKER_NAME", personName);	//解除锁定人姓名
				RIData.add("UNLOCKER_DATE", curDate);	//解除锁定日期
				RIData.add("UNLOCKER_TYPE", "2");	//解除锁定类型：中心解除（UNLOCKER_TYPE：0）
				//发布记录表
				String PUB_ID = RIData.getString("PUB_ID");  //发布记录ID
				Data PubData = handler.getPubData(conn,PUB_ID);
				//儿童材料表
				String CI_ID = PubData.getString("CI_ID");
				Data CIData = handler.getCIData(conn,CI_ID);
				
				//获取安置期限
				String SETTLE_DATE = PubData.getString("SETTLE_DATE");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date SETTLE_DATE1 =  sdf.parse(SETTLE_DATE);
				Date curDate1 = sdf.parse(curDate);
				if(SETTLE_DATE1.getTime()>=curDate1.getTime()){
					PubData.add("PUB_STATE","2");  //发布记录表：发布状态改为已发布
					CIData.add("PUB_STATE", "2");  //儿童材料表：发布状态改为已发布
				}else if(SETTLE_DATE1.getTime()<curDate1.getTime()){
					PubData.add("PUB_STATE","9");  //发布记录表：发布状态改为待发布
					CIData.add("PUB_STATE", "0");  //儿童材料表：发布状态改为待发布
				}
				handler.savePubData(conn,PubData);  //发布记录表
				handler.saveCIData(conn,CIData);  //儿童材料表
				handler.saveRIData(conn,RIData);  //预批记录表
			}
		} catch (DBException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	/**
	 * @Title: translationInit 
	 * @Description: 初始化预批翻译记录
	 * @author: yangrt;
	 * @param conn
	 * @param data
	 * 			ri_id 				预批id
	 * 			TRANSLATION_TYPE	翻译类型
	 * 			RA_ID				预批补充信息ID
	 * 			AT_TYPE				预批不翻来源
	 * @throws DBException
	 * @throws SQLException
	 * @return void
	 */
	public void translationInit(Connection conn, Data data) throws DBException {
		UserInfo userinfo = SessionInfo.getCurUser();
		String userid = userinfo.getPersonId();
		String username = userinfo.getPerson().getCName();
		String curDate = DateUtility.getCurrentDateTime();
		
		data.add("TRANSLATION_STATE", "0"); 	//翻译状态：待翻译=0
		data.add("NOTICE_USERID", userid);
		data.add("NOTICE_USERNAME", username);
		data.add("NOTICE_DATE", curDate);
		data.setConnection(conn);
		data.setEntityName("SCE_REQ_TRANSLATION");
		data.setPrimaryKey("AT_ID");
		data.create();
	}
	
	/**
	 * @Title: approveAuditInit 
	 * @Description: 初始化预批审核记录
	 * @author: yangrt;
	 * @param conn
	 * @param ri_id	预批申请记录id
	 * @throws DBException    设定文件 
	 * @return void    返回类型 
	 * @throws
	 */
	public void approveAuditInit(Connection conn, String ri_id) throws DBException {
		//初始化安置部预批审核记录信息(AUDIT_TYPE:2)
		Data azbdata = new Data();
		azbdata.add("RI_ID", ri_id);
		azbdata.add("AUDIT_TYPE", "2");
		azbdata.add("OPERATION_STATE", "0");	//待处理
		azbdata.setConnection(conn);
        azbdata.setEntityName("SCE_REQ_ADUIT");
        azbdata.setPrimaryKey("RAU_ID");
        azbdata.create();
		
		//初始化审核部预批审核记录信息(AUDIT_TYPE:1)
		Data shbdata = new Data();
		shbdata.add("RI_ID", ri_id);
		shbdata.add("AUDIT_TYPE", "1");
		shbdata.add("AUDIT_LEVEL", "0");		//经办人审核
		shbdata.add("OPERATION_STATE", "0");	//待处理
		shbdata.setConnection(conn);
		shbdata.setEntityName("SCE_REQ_ADUIT");
		shbdata.setPrimaryKey("RAU_ID");
		shbdata.create();
	}
	
	public static void main(String[] args){
		/*String year = DateUtility.getCurrentYear();
		String month = DateUtility.getCurrentMonth();
		String day = DateUtility.getCurrentDay();
		int dayInt = Integer.parseInt(day);
		if(0<dayInt&&dayInt<10){
			day="0"+day;
		}
		System.out.println(year+month+day);*/
		
		for(int i=0;i<10;i++){
			System.out.println(UUID.getUUID());
		}

		
	}

}
