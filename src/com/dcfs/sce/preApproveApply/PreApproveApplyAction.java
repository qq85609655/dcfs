/**   
 * @Title: PreApproveApplyAction.java 
 * @Package com.dcfs.sce.preApproveApply 
 * @Description: Ԥ��������� 
 * @author yangrt   
 * @date 2014-9-12 ����3:11:13 
 * @version V1.0   
 */
package com.dcfs.sce.preApproveApply;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.dcfs.sce.common.PreApproveConstant;
import com.dcfs.sce.common.PublishCommonManager;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;

/** 
 * @ClassName: PreApproveApplyAction 
 * @Description: Ԥ��������� 
 * @author yangrt;
 * @date 2014-9-12 ����3:11:13 
 *  
 */
public class PreApproveApplyAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(PreApproveApplyAction.class);
	private PreApproveApplyHandler handler;
	private Connection conn = null;
	private DBTransaction dt = null;
	private String retValue = SUCCESS;

	/* (�� Javadoc) 
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
	
	public PreApproveApplyAction(){
		this.handler = new PreApproveApplyHandler();
	}
	
	public String PreApproveApplyList(){
		// 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="LOCK_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END",
        		"LOCK_DATE_START","LOCK_DATE_END","REQ_DATE_START","REQ_DATE_END","PASS_DATE_START",
        		"PASS_DATE_END","RI_STATE","SUBMIT_DATE_START","SUBMIT_DATE_END","REMINDERS_STATE",
        		"REM_DATE_START","REM_DATE_END","REGISTER_DATE_START","REGISTER_DATE_END","FILE_NO",
        		"UPDATE_DATE_START","UPDATE_DATE_END","LAST_STATE","LAST_STATE2");
        //���С�Ů����������ת��Ϊ��д
        String MALE_NAME = data.getString("MALE_NAME","");
        if(!MALE_NAME.equals("")){
        	data.put("MALE_NAME", MALE_NAME.toUpperCase());
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");
        if(!FEMALE_NAME.equals("")){
        	data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
        }
        String NAME_PINYIN = data.getString("NAME_PINYIN","");
        if(!NAME_PINYIN.equals("")){
        	data.put("NAME_PINYIN", NAME_PINYIN.toUpperCase());
        }
        try {
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.PreApproveApplyList(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�������ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("Ԥ�������ѯ�����쳣:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //8 �ر����ݿ�����
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction��PreApproveApplyList.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplyShow 
	 * @Description: Ԥ�������޸�/�鿴��ת����
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveApplyShow(){
		String type = getParameter("type","");	//�������ͱ�ʾ
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		retValue = type;
		//��ȡ�ļ�ID
		String ri_id = getParameter("RI_ID","");
		if(ri_id.equals("")){
			ri_id = (String)getAttribute("RI_ID");
		}
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//��ͯ����id
			String ci_id = applydata.getString("CI_ID","");
			Data childData = new LockChildHandler().getMainChildInfo(conn, ci_id);
			//���ݶ�ͯ����id,��ȡ��ͯ��ϢDataList
			DataList childList = new LockChildHandler().getAttachChildList(conn, ci_id);
			
			String planEN = applydata.getString("TENDING_EN","");
			String planCN = applydata.getString("TENDING_CN","");
			String opipionEN = applydata.getString("OPINION_EN","");
			String opinionCN = applydata.getString("OPINION_CN","");
			if(!"".equals(planEN)){
				applydata.put("TENDING_EN", planEN.replace("\n\r","<br>"));
			}
			if(!"".equals(planCN)){
				applydata.put("TENDING_CN", planCN.replace("\n\r","<br>"));
			}
			if(!"".equals(opipionEN)){
				applydata.put("OPINION_EN", opipionEN.replace("\n\r","<br>"));
			}
			if(!"".equals(opinionCN)){
				applydata.put("OPINION_CN", opinionCN.replace("\n\r","<br>"));
			}
			
			
			/***	����ʱ����begin		***/
			//��������
			String lockDate = applydata.getString("LOCK_DATE");
			//��ǰ����
			String nowDate = DateUtility.getCurrentDateTime();
			//���㵱ǰ�������������ڵ�ʱ���
			SimpleDateFormat dsf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar rightNow = Calendar.getInstance(); 
			
			Date lock = dsf.parse(lockDate);
			rightNow.setTime(lock);
			rightNow.add(Calendar.DATE,3);	//�����������������ڣ����Ľ�ֹ���ڣ�
			Date limtDate = rightNow.getTime();
			Date now = dsf.parse(nowDate);
			long between=(limtDate.getTime()-now.getTime())/1000;//����1000��Ϊ��ת������
			//����ʱ
			setAttribute("day", between/(24*3600));
			setAttribute("hour", between%(24*3600)/3600);
			setAttribute("minute", between%3600/60);
			setAttribute("second", between%60);
			/***	����ʱ����end	***/
			
			setAttribute("applydata", applydata);
			setAttribute("childData", childData);
			setAttribute("childList", childList);
			setAttribute("RI_ID", ri_id);
			setAttribute("ADOPT_ORG_ID", applydata.getString("ADOPT_ORG_ID",""));
			setAttribute("NALE_PHOTO", applydata.getString("NALE_PHOTO",""));
			setAttribute("FENALE_PHOTO", applydata.getString("FENALE_PHOTO",""));
			setAttribute("MALE_PUNISHMENT_FLAG", applydata.getString("MALE_PUNISHMENT_FLAG",""));
			setAttribute("MALE_ILLEGALACT_FLAG", applydata.getString("MALE_ILLEGALACT_FLAG",""));
			setAttribute("FEMALE_PUNISHMENT_FLAG", applydata.getString("FEMALE_PUNISHMENT_FLAG",""));
			setAttribute("FEMALE_ILLEGALACT_FLAG", applydata.getString("FEMALE_ILLEGALACT_FLAG",""));
			setAttribute("IS_FAMILY_OTHERS_FLAG", applydata.getString("IS_FAMILY_OTHERS_FLAG",""));
			setAttribute("CONABITA_PARTNERS", applydata.getString("CONABITA_PARTNERS",""));
			setAttribute("isPrint", getParameter("isPrint"));
			
			if("mod".equals(type)){
				String family_type = applydata.getString("FAMILY_TYPE");
				String file_type = applydata.getString("FILE_TYPE");
				if(!"21".equals(file_type)){
					if("1".equals(family_type)){
						retValue += "double";
					}else if("2".equals(family_type)){
						retValue += "single";
					} 
				}
			}
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�������޸�/�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[Ԥ�������޸�/�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} catch (ParseException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�������޸�/�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[Ԥ�������޸�/�鿴����]:" + e.getMessage(),e);
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
                        log.logError("PreApproveApplyAction��PreApproveApplyShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplyShowForFBGL 
	 * @Description: Ԥ�������޸�/�鿴��ת����(����������ڽ��еĲ鿴)
	 * @author: mayun
	 * @return String 
	 */
	public String PreApproveApplyShowForFBGL(){
		
		String type = getParameter("type","");
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		retValue = type;
		//��ȡ�ļ�ID
		String ri_id = getParameter("RI_ID","");
		if(ri_id.equals("")){
			ri_id = (String)getAttribute("RI_ID");
		}
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//��ͯ����id
			String ci_id = applydata.getString("CI_ID","");
			Data childData = new LockChildHandler().getMainChildInfo(conn, ci_id);
			//���ݶ�ͯ����id,��ȡ��ͯ��ϢDataList
			DataList childList = new LockChildHandler().getAttachChildList(conn, ci_id);
			
			String lock_type = applydata.getString("LOCK_MODE","");
			Data filedata = new Data();
			if("1".equals(lock_type) || "3".equals(lock_type) || "4".equals(lock_type) || "6".equals(lock_type)){
				filedata = new FileManagerHandler().GetFileByID(conn, applydata.getString("AF_ID",""));
			}else{
				
			}

			//��������
			String lockDate = applydata.getString("LOCK_DATE");
			//��ǰ����
			String nowDate = DateUtility.getCurrentDateTime();
			//���㵱ǰ�������������ڵ�ʱ���
			SimpleDateFormat dsf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Calendar rightNow = Calendar.getInstance(); 
			
			Date lock = dsf.parse(lockDate);
			rightNow.setTime(lock);
			rightNow.add(Calendar.DATE,3);	//�����������������ڣ����Ľ�ֹ���ڣ�
			Date limtDate = rightNow.getTime();
			Date now = dsf.parse(nowDate);
			long between=(limtDate.getTime()-now.getTime())/1000;//����1000��Ϊ��ת������
			//����ʱ
			setAttribute("day", between/(24*3600));
			setAttribute("hour", between%(24*3600)/3600);
			setAttribute("minute", between%3600/60);
			setAttribute("second", between%60/60);
			
			setAttribute("applydata", applydata);
			setAttribute("childData", childData);
			setAttribute("childList", childList);
			setAttribute("FILE_TYPE",applydata.getString("FILE_TYPE",""));
			setAttribute("filedata", filedata);
			setAttribute("AF_ID", applydata.getString("AF_ID",""));
			setAttribute("RI_ID", applydata.getString("RI_ID",""));
			setAttribute("NALE_PHOTO", applydata.getString("NALE_PHOTO",""));
			setAttribute("FENALE_PHOTO", applydata.getString("FENALE_PHOTO",""));
			setAttribute("MALE_PUNISHMENT_FLAG", applydata.getString("MALE_PUNISHMENT_FLAG",""));
			setAttribute("MALE_ILLEGALACT_FLAG", applydata.getString("MALE_ILLEGALACT_FLAG",""));
			setAttribute("FEMALE_PUNISHMENT_FLAG", applydata.getString("FEMALE_PUNISHMENT_FLAG",""));
			setAttribute("FEMALE_ILLEGALACT_FLAG", applydata.getString("FEMALE_ILLEGALACT_FLAG",""));
			setAttribute("CONABITA_PARTNERS", applydata.getString("CONABITA_PARTNERS",""));
			
			if("mod".equals(type)){
				String family_type = applydata.getString("FAMILY_TYPE");
				if("2".equals(lock_type) || "5".equals(lock_type)){
					if("1".equals(family_type)){
						retValue += "double";
					}else if("2".equals(family_type)){
						retValue += "single";
					} 
				}
			}
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�������޸�/�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[Ԥ�������޸�/�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} catch (ParseException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ�������޸�/�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[Ԥ�������޸�/�鿴����]:" + e.getMessage(),e);
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
                        log.logError("PreApproveApplyAction��PreApproveApplyShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplySave 
	 * @Description: Ԥ�����뱣��/�ύ����
	 * @author: yangrt
	 * @return String
	 */
	public String PreApproveApplySave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","AF_ID","RI_ID","PRE_REQ_NO","CI_ID","RI_STATE","LOCK_MODE","FILE_TYPE","PUB_ID",
				"MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN",
				"MALE_HEALTH","MALE_HEALTH_CONTENT_EN","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_EN",
				"MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME",
				"FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN",
				"FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN",
				"FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME",
				"CURRENCY","MARRY_CONDITION","MARRY_DATE","TOTAL_ASSET","TOTAL_DEBT","UNDERAGE_NUM","CHILD_CONDITION_EN","ADDRESS","ADOPT_REQUEST_EN",
				"ADOPTER_SEX","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME","GAY_STATEMENT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_EN",
				"TENDING_EN","OPINION_EN","TENDING_CN","OPINION_CN");
		//���С�Ů����������ת��Ϊ��д
		if(!"".equals(data.getString("MALE_NAME",""))){
			data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
		}
		if(!"".equals(data.getString("FEMALE_NAME",""))){
			data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
		}
		if(!"".equals(data.getString("ADDRESS",""))){
			data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
		}
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            
            UserInfo userinfo = SessionInfo.getCurUser();
			String orgid = userinfo.getCurOrgan().getOrgCode();
			//��ȡ������֯��Ϣ
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			String TRANS_FLAG = syzzinfo.getTransFlag();	//Ԥ���Ƿ��룺1=�ǣ�0=��
            
			String clueMes = "";
            //������Ϊ�ύʱ��Ԥ��״ֵ̬��1���������������
    		String ri_state = data.getString("RI_STATE");
    		if(PreApproveConstant.PRE_APPROVAL_YTJ.equals(ri_state)){
    			data.put("REQ_NO", new PublishCommonManager().createPreApproveApplyNo(conn, userinfo.getCurOrgan().getOrgCode()));
    			data.add("REQ_DATE", DateUtility.getCurrentDateTime());
    			clueMes = "Submitted successfully!";
    			retValue = "submit";
    		}else{
    			setAttribute("RI_ID", data.getString("RI_ID"));
    			setAttribute("type", "mod");
    			setAttribute("act", getParameter("act",""));
    			clueMes = "Saved successfully!";
    			retValue = "save";
    		}
    		
            boolean success = handler.PreApproveApplySave(conn,data,TRANS_FLAG);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, clueMes);
                setAttribute("clueTo", clueTo);
                
                //��������
            	AttHelper.publishAttsOfPackageId(data.getString("MALE_PHOTO"), "AF"); //��������������Ƭ
            	AttHelper.publishAttsOfPackageId(data.getString("FEMALE_PHOTO"), "AF"); //����Ů��������Ƭ
            }
            
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ��������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[Ԥ��������Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ��������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("Ԥ�����뱣������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
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
                        log.logError("PreApproveApplyAction��PreApproveApplySave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplySubmit 
	 * @Description: Ԥ�������ύ����
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveApplySubmit(){
		//1 ��ȡҪ�ύ���ļ�ID
		String submitid = getParameter("submitid");
		String[] submit_id = submitid.split(";");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			success = handler.PreApproveApplySubmit(conn, submit_id);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ύԤ����������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[Ԥ�������ύ����]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 �ر����ݿ�
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction��PreApproveApplySubmit.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveApplyDelete 
	 * @Description: Ԥ������ɾ������
	 * @author: yangrt
	 * @return String 
	 */
	public String PreApproveApplyDelete(){
		//1 ��ȡҪɾ�����ļ�ID
		String deleteuuid = getParameter("deleteid", "");
		String[] uuid = deleteuuid.split(";");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡɾ�����
			success = handler.PreApproveApplyDelete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Deleted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ������ɾ�������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[Ԥ������ɾ������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ɾ��ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 �ر����ݿ�
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction��PreApproveApplyDelete.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PlanOpinionShow 
	 * @Description: �����ƻ�����֯�����Ӳ鿴����
	 * @author: yangrt
	 * @return String 
	 */
	public String PlanOpinionShow(){
		//��ȡԤ������id
		String ri_id = getParameter("RI_ID");
		String type = getParameter("type");
		String flag = getParameter("Flag");
		String isPrint = getParameter("isPrint","");
		retValue = type + flag;
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//��ͯ����id
			String ci_id = applydata.getString("CI_ID","");
			Data childData = new LockChildHandler().getMainChildInfo(conn, ci_id);
			String planEN = applydata.getString("TENDING_EN","");
			String planCN = applydata.getString("TENDING_CN","");
			String opipionEN = applydata.getString("OPINION_EN","");
			String opinionCN = applydata.getString("OPINION_CN","");
			if(!"".equals(planEN)){
				childData.add("TENDING_EN", planEN.replace("\r\n","<br>"));
			}
			if(!"".equals(planCN)){
				childData.add("TENDING_CN", planCN.replace("\r\n","<br>"));
			}
			if(!"".equals(opipionEN)){
				childData.add("OPINION_EN", opipionEN.replace("\r\n","<br>"));
			}
			if(!"".equals(opinionCN)){
				childData.add("OPINION_CN", opinionCN.replace("\r\n","<br>"));
			}
			//���ݶ�ͯ����id,��ȡ��ͯ��ϢDataList
			DataList childList = new LockChildHandler().getAttachChildList(conn, ci_id);
			setAttribute("applydata", applydata);
			setAttribute("childList", childList);
			setAttribute("childdata", childData);
			setAttribute("RI_ID", ri_id);
			setAttribute("MALE_PHOTO",applydata.getString("MALE_PHOTO", ri_id));
			setAttribute("FEMALE_PHOTO",applydata.getString("FEMALE_PHOTO", ri_id));
			setAttribute("MAIN_PHOTO",childData.getString("PHOTO_CARD", ci_id));
			setAttribute("ADOPTER_SEX",applydata.getString("ADOPTER_SEX",""));
			setAttribute("isPrint", isPrint);
			
			if(flag.equals("infoEN") || flag.equals("infoCN")){
				retValue += applydata.getString("FAMILY_TYPE","");
			}
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ƻ�����֯����޸�/�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[�����ƻ�����֯����޸�/�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction��PlanOpinionShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveAuditResult 
	 * @Description: Ԥ��
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String PreApproveAuditResult(){
		//��ȡԤ������id
		String ri_id = getParameter("RI_ID");
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			//��ͯ����id
			String ci_id = applydata.getString("CI_ID","");
			//���ݶ�ͯ����id,��ȡ����ͯ��ϢData
			Data childdata = new LockChildHandler().getMainChildInfo(conn, ci_id);
			
			//��Ӷ�ͯ��Ϣ
			applydata.add("PROVINCE_ID", childdata.getString("PROVINCE_ID",""));
			applydata.add("WELFARE_NAME_CN", childdata.getString("WELFARE_NAME_CN",""));
			applydata.add("WELFARE_NAME_EN", childdata.getString("WELFARE_NAME_EN",""));
			applydata.add("NAME", childdata.getString("NAME",""));
			applydata.add("NAME_PINYIN", childdata.getString("NAME_PINYIN",""));
			
			String passdate = applydata.getString("PASS_DATE");
			String year = passdate.substring(0, 4);
			String month = passdate.substring(5, 7);
			String day = passdate.substring(8, 10);
			
			setAttribute("year", year);
			setAttribute("month", month);
			setAttribute("day", day);
			
			int monthnum;
			if(month.contains("0")){
				monthnum = Integer.parseInt(month.substring(1, month.length()));
			}else{
				monthnum = Integer.parseInt(month);
			}
			
			switch(monthnum){
				case 1:	setAttribute("monthEN", "January");
					break;
				case 2:	setAttribute("monthEN", "February");
					break;
				case 3:	setAttribute("monthEN", "March");
					break;
				case 4:	setAttribute("monthEN", "April");
					break;
				case 5:	setAttribute("monthEN", "May");
					break;
				case 6:	setAttribute("monthEN", "June");
					break;
				case 7:	setAttribute("monthEN", "July");
					break;
				case 8:	setAttribute("monthEN", "August");
					break;
				case 9:	setAttribute("monthEN", "September");
					break;
				case 10:	setAttribute("monthEN", "October");
					break;
				case 11:	setAttribute("monthEN", "November");
					break;
				case 12:	setAttribute("monthEN", "December");
					break;
			}	
			
			String birth = childdata.getString("BIRTHDAY");
			String birthyear = birth.substring(0, 4);
			String birthmonth = birth.substring(5, 7);
			String birthday = birth.substring(8, 10);
			
			setAttribute("birthyear", birthyear);
			setAttribute("birthmonth", birthmonth);
			setAttribute("birthday", birthday);
			
			int birthmonthnum;
			if(birthmonth.contains("0")){
				birthmonthnum = Integer.parseInt(birthmonth.substring(1, month.length()));
			}else{
				birthmonthnum = Integer.parseInt(birthmonth);
			}
			
			switch(birthmonthnum){
				case 1:	setAttribute("birthmonthEN", "January");
					break;
				case 2:	setAttribute("birthmonthEN", "February");
					break;
				case 3:	setAttribute("birthmonthEN", "March");
					break;
				case 4:	setAttribute("birthmonthEN", "April");
					break;
				case 5:	setAttribute("birthmonthEN", "May");
					break;
				case 6:	setAttribute("birthmonthEN", "June");
					break;
				case 7:	setAttribute("birthmonthEN", "July");
					break;
				case 8:	setAttribute("birthmonthEN", "August");
					break;
				case 9:	setAttribute("birthmonthEN", "September");
					break;
				case 10:	setAttribute("birthmonthEN", "October");
					break;
				case 11:	setAttribute("birthmonthEN", "November");
					break;
				case 12:	setAttribute("birthmonthEN", "December");
					break;
			}	
			
			String submitdate = applydata.getString("SUBMIT_DATE");
			String submityear = submitdate.substring(0, 4);
			String submitmonth = submitdate.substring(5, 7);
			String submitday = submitdate.substring(8, 10);
			
			setAttribute("submityear", submityear);
			setAttribute("submitmonth", submitmonth);
			setAttribute("submitday", submitday);
			
			int submitmonthnum;
			if(birthmonth.contains("0")){
				submitmonthnum = Integer.parseInt(birthmonth.substring(1, month.length()));
			}else{
				submitmonthnum = Integer.parseInt(birthmonth);
			}
			
			switch(submitmonthnum){
				case 1:	setAttribute("submitmonthEN", "January");
					break;
				case 2:	setAttribute("submitmonthEN", "February");
					break;
				case 3:	setAttribute("submitmonthEN", "March");
					break;
				case 4:	setAttribute("submitmonthEN", "April");
					break;
				case 5:	setAttribute("submitmonthEN", "May");
					break;
				case 6:	setAttribute("submitmonthEN", "June");
					break;
				case 7:	setAttribute("submitmonthEN", "July");
					break;
				case 8:	setAttribute("submitmonthEN", "August");
					break;
				case 9:	setAttribute("submitmonthEN", "September");
					break;
				case 10:	setAttribute("submitmonthEN", "October");
					break;
				case 11:	setAttribute("submitmonthEN", "November");
					break;
				case 12:	setAttribute("submitmonthEN", "December");
					break;
			}	
			
			setAttribute("data", applydata);
			setAttribute("childdata", childdata);
			setAttribute("ADOPTER_SEX", applydata.getString("ADOPTER_SEX",""));
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��˽��֪ͨ�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[��˽��֪ͨ�鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction��PreApproveAuditResult.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PreApproveRevokeReason 
	 * @Description: Ԥ����Чԭ��鿴
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String PreApproveRevokeReason(){
		String ri_id = getParameter("RI_ID","");
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data applydata = handler.getPreApproveApplyData(conn, ri_id);
			setAttribute("applydata", applydata);
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ����Чԭ��鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[Ԥ����Чԭ��鿴����]:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
		} finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("PreApproveApplyAction��PreApproveRevokeReason.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}

}
