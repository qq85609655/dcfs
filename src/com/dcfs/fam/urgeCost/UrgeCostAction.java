/**   
 * @Title: UrgeCostAction.java 
 * @Package com.dcfs.fam.urgeCost 
 * @Description: ���ô߽ɲ���
 * @author yangrt   
 * @date 2014-10-23 ����6:25:44 
 * @version V1.0   
 */
package com.dcfs.fam.urgeCost;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.config.CommonConfig;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.fam.receiveConfirm.ReceiveConfirmHandler;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.fileManager.FileManagerHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;
import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

/** 
 * @ClassName: UrgeCostAction 
 * @Description: ���ô߽ɲ��� 
 * @author yangrt;
 * @date 2014-10-23 ����6:25:44 
 *  
 */
public class UrgeCostAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(UrgeCostAction.class);
	
	private UrgeCostHandler handler;
	private Connection conn = null;//���ݿ�����
    private DBTransaction dt = null;//������
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
	
	public UrgeCostAction(){
		this.handler = new UrgeCostHandler();
	}
	
	/**
	 * @Title: UrgeCostList 
	 * @Description: ���ô߽ɲ�ѯ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="PAID_NO";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","PAID_NO","CHILD_NUM","S_CHILD_NUM","NOTICE_DATE_START","NOTICE_DATE_END","COST_TYPE","PAR_VALUE","PAY_DATE_START","PAY_DATE_END","ARRIVE_STATE","ARRIVE_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","COLLECTION_STATE","NOTICE_STATE");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.UrgeCostList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ô߽ɲ�ѯ�б�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[���ô߽ɲ�ѯ�б�]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction��UrgeCostList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeShow 
	 * @Description: �߽�֪ͨ���/�޸Ĳ���
	 * @author: yangrt
	 * @return String  
	 */
	public String UrgeCostNoticeShow(){
		//�жϵ�ǰ��������ӻ����޸�
		String type = getParameter("type","");
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		if(type.equals("add")){	//��ǰ����Ϊ���
			setAttribute("data", new Data());
		}else if(type.equals("mod")){	//��ǰ����Ϊ�޸�
			String rm_id = getParameter("RM_ID","");	//�߽ɼ�¼ID
			if(rm_id.equals("")){
				rm_id = (String)getAttribute("RM_ID");
			}
			try {
				conn = ConnectionManager.getConnection();
				//����Ʊ�ݵǼ�id,��ȡƱ����ϢData
				Data data = handler.getUrgeCostNoticeData(conn, rm_id);
				
				setAttribute("data", data);
				setAttribute("packageId", data.getString("UPLOAD_ID",""));
				
			} catch (DBException e) {
				//4�����쳣����
				setAttribute(Constants.ERROR_MSG_TITLE, "�߽�֪ͨ���/�޸Ĳ����쳣");
				setAttribute(Constants.ERROR_MSG, e);
	            if (log.isError()) {
	                log.logError("�����쳣[�߽�֪ͨ���/�޸Ĳ���]:" + e.getMessage(),e);
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
	                        log.logError("UrgeCostAction��UrgeCostNoticeShow.Connection������쳣��δ�ܹر�",e);
	                    }
	                    e.printStackTrace();
	                    
	                    retValue = "error2";
	                }
	            }
	        }
		}
		
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeSave 
	 * @Description: ���ô߽�֪ͨ��Ϣ����
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String UrgeCostNoticeSave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","RM_ID","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","CHILD_NUM","S_CHILD_NUM","PAID_SHOULD_NUM","PAID_CONTENT","REMARKS","UPLOAD_ID","NOTICE_STATE");
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            
            String orgCode = data.getString("ADOPT_ORG_ID");	//������֯code
            String costType = data.getString("COST_TYPE");	//��������
            String state = data.getString("NOTICE_STATE");	//֪ͨ״̬
            String paidNo = new FileCommonManager().createPayNO(conn, orgCode, costType);	//�ɷѱ��
            
            SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgCode);	//������֯��Ϣ
            data.add("NAME_CN", syzzinfo.getSyzzCnName());	//���������֯��������
            data.add("NAME_EN", syzzinfo.getSyzzEnName());	//���������֯Ӣ������
            data.add("PAID_NO", paidNo);
            
            //��ǰ��¼����Ϣ
            UserInfo userinfo = SessionInfo.getCurUser();
            String personId = userinfo.getPersonId();
            String personName = userinfo.getPerson().getCName();
            
            data.add("NOTICE_USERID", personId);
            data.add("NOTICE_USERNAME", personName);
            
            if(state.equals("1")){	//��ǰ����Ϊ�ύʱ�����֪ͨ����
            	data.add("NOTICE_DATE", DateUtility.getCurrentDateTime());
            	retValue = "submit";
            }else{
            	setAttribute("type","mod");
            	retValue = "save";
            }
            
            boolean success = handler.UrgeCostNoticeSave(conn,data);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
                
                String packageId = data.getString("UPLOAD_ID");//����
                AttHelper.publishAttsOfPackageId(packageId, "OTHER");//��������
            }
            
            setAttribute("data",data);
            setAttribute("RM_ID", data.getString("RM_ID"));
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ô߽�֪ͨ��Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[���ô߽�֪ͨ��Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ô߽�֪ͨ��Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("���ô߽�֪ͨ��Ϣ��������쳣:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction��UrgeCostNoticeSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeBatchAdd 
	 * @Description: ��תͳ��¼��ҳ��
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostNoticeBatchAdd(){
		setAttribute("data", new Data());
		setAttribute("List", new DataList());
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostStatisticsList 
	 * @Description: ͳ�Ʒ���������������֯Ӧ�ɷ���Ϣ
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostStatisticsList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","SEARCH_TYPE","DATE_START","DATE_END");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.UrgeCostStatisticsList(conn,data,pageSize,page);
			//6 �������д��ҳ����ձ���
			setAttribute("data",data);
			setAttribute("List",dl);
			setAttribute("ListSize",dl.size());
			setAttribute("FLAG","true");
			setAttribute("SEARCH_TYPE",data.getString("SEARCH_TYPE"));
			setAttribute("DATE_START",data.getString("DATE_START"));
			setAttribute("DATE_END",data.getString("DATE_END"));
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����ͳ��¼��ͳ���б�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[����ͳ��¼��ͳ���б�]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction��UrgeCostStatisticsList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostBatchNoticeSave 
	 * @Description: ͳ��¼����ô߽�֪ͨ��Ϣ����
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostBatchNoticeSave(){
		//1 ���ҳ������ݣ��������ݽ����
		String SEARCH_TYPE = getParameter("SEARCH_TYPE");
		String DATE_START = getParameter("DATE_START");
		String DATE_END = getParameter("DATE_END");
		String[] COUNTRY_CODE = getParameterValues("LCOUNTRY_CODE");
    	String[] ADOPT_ORG_ID = getParameterValues("LADOPT_ORG_ID");
    	String[] NAME_CN = getParameterValues("LNAME_CN");
    	String[] NAME_EN = getParameterValues("LNAME_EN");
    	String[] CHILD_NUM = getParameterValues("LCHILD_NUM");
    	String[] S_CHILD_NUM = getParameterValues("LS_CHILD_NUM");
    	String[] PAID_SHOULD_NUM = getParameterValues("LPAID_SHOULD_NUM");
    	
    	DataList saveList = new DataList();
    	Data saveData = new Data();
    	
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
        	//��ǰ��¼����Ϣ
            UserInfo userinfo = SessionInfo.getCurUser();
            String personId = userinfo.getPersonId();
            String personName = userinfo.getPerson().getCName();
        	
        	int num = COUNTRY_CODE.length;
        	for(int i = 0; i < num; i++){
        		String paidNo = new FileCommonManager().createPayNO(conn, ADOPT_ORG_ID[i], "20");	//�ɷѱ��
        		saveData.add("COUNTRY_CODE", COUNTRY_CODE[i]);
        		saveData.add("ADOPT_ORG_ID", ADOPT_ORG_ID[i]);
        		saveData.add("NAME_CN", NAME_CN[i]);
        		saveData.add("NAME_EN", NAME_EN[i]);
        		saveData.add("CHILD_NUM", CHILD_NUM[i]);
        		saveData.add("S_CHILD_NUM", S_CHILD_NUM[i]);
        		saveData.add("PAID_SHOULD_NUM", PAID_SHOULD_NUM[i]);
        		saveData.add("PAID_NO", paidNo);
        		saveData.add("COST_TYPE", "20");
        		saveData.add("NOTICE_STATE", "1");
        		saveData.add("NOTICE_USERID", personId);
        		saveData.add("NOTICE_USERNAME", personName);
        		saveData.add("NOTICE_DATE", DateUtility.getCurrentDateTime());
        		
        		//�ļ�����
        		String filenum = handler.getFileNum(conn, COUNTRY_CODE[i], ADOPT_ORG_ID[i], SEARCH_TYPE, DATE_START, DATE_END);
        		String PDFpath = this.CreatePDF(i+1, DATE_START, DATE_END, filenum, PAID_SHOULD_NUM[i]);
        		
        		File file = new File(PDFpath);
        		String packageId = UUID.getUUID();
        		AttHelper.manualUploadAtt(file, "OTHER", packageId, null, AttConstants.FAW_JFPJ, AttConstants.FAM, "class_code=FAM");
        		file.delete();
        		
        		saveData.add("UPLOAD_ID", packageId);
        		saveList.add(saveData);
        	}
            
            boolean success = handler.UrgeCostBatchNoticeSave(conn,saveList);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
                
                for(int i = 0; i < saveList.size(); i++){
                	String packageId = saveList.getData(i).getString("UPLOAD_ID");//����
                    AttHelper.publishAttsOfPackageId(packageId, "OTHER");//��������
                }
                
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����֪ͨͳ��¼����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[����֪ͨͳ��¼����Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����֪ͨͳ��¼����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("����֪ͨͳ��¼����Ϣ��������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (DocumentException e) {
        	setAttribute(Constants.ERROR_MSG_TITLE, "����PDF��Ϣ�����֪ͨ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("����PDF��Ϣ�����֪ͨ�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} catch (IOException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "����PDF��Ϣ�����֪ͨ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("����PDF��Ϣ�����֪ͨ�����쳣:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction��UrgeCostNoticeSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: ShowFileChildList 
	 * @Description: �鿴��Ӧ���ļ���ͯ�б���Ϣ
	 * @author: yangrt
	 * @return String 
	 */
	public String ShowFileChildList(){
		//��ȡ��������
		String countrycode = getParameter("COUNTRY_CODE");
		String orgcode = getParameter("ADOPT_ORG_ID");
		String SEARCH_TYPE = getParameter("SEARCH_TYPE");
		String DATE_START = getParameter("DATE_START");
		String DATE_END = getParameter("DATE_END");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// ��ȡ����DataList
			DataList dl = handler.getFileChildDataList(conn, countrycode, orgcode, SEARCH_TYPE, DATE_START, DATE_END);
			for(int i = 0; i < dl.size(); i++){
				Data d = dl.getData(i);
				String twins_ids = d.getString("TWINS_IDS","");
				String names = "";
				if(!twins_ids.equals("")){
					DataList childList = new FileManagerHandler().getChildDataList(conn, twins_ids);
					for(int j = 0; j < childList.size(); j++){
						names += childList.getData(j).getString("NAME") + ",";
					}
					names = names.substring(0, names.lastIndexOf(","));
				}
				d.add("NAMES", names);
			}
			
			// �������д��ҳ����ձ���
			setAttribute("List",dl);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���б�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[����ͳ��¼��ͳ���б�]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction��UrgeCostStatisticsList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeBatchDelete 
	 * @Description: ���ô߽�֪ͨ����ɾ��
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostNoticeBatchDelete(){
		String deleteid = getParameter("batchID");
		try{
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.UrgeCostNoticeBatchDelete(conn,deleteid);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        }catch (Exception e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("ɾ�������쳣[ɾ������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "ɾ��ʧ��!");
            setAttribute("clueTo", clueTo);
            
        	retValue = "error";
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                	retValue = "error";
                    if (log.isError()) {
                        log.logError("UrgeCostAction��UrgeCostNoticeBatchDelete.Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: UrgeCostNoticeBatchSubmit 
	 * @Description: ���ô߽�֪ͨ��������
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostNoticeBatchSubmit(){
		String submitid = getParameter("batchID");
		try{
			conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
            success=handler.UrgeCostNoticeBatchSubmit(conn,submitid);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
        }catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ô߽�֪ͨ�������Ͳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[���ô߽�֪ͨ�������Ͳ���]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ô߽�֪ͨ�������Ͳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("���ô߽�֪ͨ�������Ͳ����쳣:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction��UrgeCostNoticeBatchSubmit.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostFeedBackAdd 
	 * @Description: �߽�֪ͨ����¼����Ϣ
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostFeedBackAdd(){
		String rm_id = getParameter("RM_ID");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// ��ȡ����DataList
			Data data = handler.getUrgeCostNoticeData(conn, rm_id);
			// �������д��ҳ����ձ���
			setAttribute("data",data);
			
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�߽�֪ͨ����¼����Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[�߽�֪ͨ����¼����Ϣ]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction��UrgeCostFeedBackAdd.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostFeedBackSave 
	 * @Description: �߽�֪ͨ����¼����Ϣ����
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostFeedBackSave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data pjdata = getRequestEntityData("R_","RM_ID","COUNTRY_CODE","ADOPT_ORG_ID","NAME_CN","NAME_EN","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAR_VALUE","PAID_CONTENT","PAID_WAY","BILL_NO","PAY_USERNAME","PAY_DATE","FILE_CODE");
		Data tzdata = getRequestEntityData("L_","NOTICE_STATE");
		
		//��ǰ��¼����Ϣ
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgId = userinfo.getCurOrgan().getId();
		String personName = userinfo.getPerson().getCName();
		String pseronId = userinfo.getPersonId();
		String curDate = DateUtility.getCurrentDateTime();
		
		pjdata.add("REG_ORGID", orgId);	//¼�벿��ID
		pjdata.add("REG_USERID", pseronId);	//¼����id
		pjdata.add("REG_USERNAME", personName);	//¼��������
		pjdata.add("REG_DATE", curDate);	//¼������
		pjdata.add("COLLECTION_STATE", "0");	//����_����״̬(0��δ����)
		pjdata.add("ARRIVE_STATE", "0");	//����_����״̬(0����ȷ��)
		
		tzdata.add("RM_ID", pjdata.getString("RM_ID"));
		
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            
            boolean success = handler.UrgeCostFeedBackSave(conn,pjdata,tzdata);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
                
                String packageId = pjdata.getString("FILE_CODE");//����
                AttHelper.publishAttsOfPackageId(packageId, "OTHER");//��������
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�߽�֪ͨ����¼����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�߽�֪ͨ����¼����Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�߽�֪ͨ����¼����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�߽�֪ͨ����¼����Ϣ��������쳣:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction��UrgeCostNoticeSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: UrgeCostReceiveAdd 
	 * @Description: ���˷�����Ϣ¼��
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostReceiveAdd(){
		//��ȡƱ�ݵǼ�ID
		String CHEQUE_ID = getParameter("CHEQUE_ID");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// ��ȡ����Data
			Data data = new ReceiveConfirmHandler().getFamChequeInfoById(conn, CHEQUE_ID);
			// �������д��ҳ����ձ���
			setAttribute("data",data);
			
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���˷�����Ϣ¼����Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[���˷�����Ϣ¼����Ϣ]:" + e.getMessage(),e);
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
						log.logError("UrgeCostAction��UrgeCostReceiveAdd.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * @Title: UrgeCostReceiveSave 
	 * @Description: ���˷�����Ϣ����
	 * @author: yangrt
	 * @return String 
	 */
	public String UrgeCostReceiveSave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","CHEQUE_ID","ARRIVE_VALUE","ARRIVE_DATE","ARRIVE_STATE");
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            boolean success = handler.UrgeCostReceiveSave(conn,data);
            if(success){
            	InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���˷�����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[���˷�����Ϣ�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���˷�����Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("���˷�����Ϣ��������쳣:" + e.getMessage(),e);
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
                        log.logError("UrgeCostAction��UrgeCostReceiveSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: CreatePDF 
	 * @Description: ����PDF��ʽ����Ϣ�����֪ͨ
	 * @author: yangrt
	 * @param num
	 * @param start_date
	 * @param end_date
	 * @param filenum
	 * @param should_pay
	 * @return String 
	 * @throws DocumentException 
	 * @throws IOException 
	 */
	public String CreatePDF(int num, String start_date, String end_date, String filenum, String should_pay) throws DocumentException, IOException {
        //ʵ�����ĵ�����  
        Document document = new Document(PageSize.A4, 80, 80, 100, 50);//A4ֽ���������¿հ�
        
        String path = CommonConfig.getProjectPath() + "/tempFile/";
        String PDFpath = path + "costnotice.pdf";//����ļ�·��
        // PdfWriter����
        PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//�ļ������·��+�ļ���ʵ������ 
        document.open();// ���ĵ�
        
        
        String HEIFontPath = CommonConfig.getProjectPath() + "/Fonts/SIMHEI.TTF";
        String SONGFontPatn = CommonConfig.getProjectPath() + "/Fonts/SIMSUN.TTC,0";

        //���ı�������
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//����
        Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//���� 20 ����
        //������������
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  ����
        Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//���� 12 ����
        
        //Ӣ�ı�������
        Font FontEN_T20B = new Font(Font.TIMES_ROMAN, 20, Font.BOLD);//times new roman 20 ����
        //Ӣ����������
        Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 ����
        
        //���ı���
        Paragraph ParagraphTitleCN = new Paragraph("��Ϣ�����֪ͨ", FontCN_HEI20B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        ParagraphTitleCN.setSpacingAfter(10);	//�����������������
        document.add(ParagraphTitleCN);
        //��������
        Paragraph ParagraphContextCN = new Paragraph();
        ParagraphContextCN.setFirstLineIndent(20);//��������
        Phrase PhraseContextCN1 = new Phrase("��", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN1);
        Phrase PhraseContextCN2 = new Phrase(start_date, FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN2);
        Phrase PhraseContextCN3 = new Phrase("��", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN3);
        Phrase PhraseContextCN4 = new Phrase(end_date, FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN4);
        Phrase PhraseContextCN5 = new Phrase("�գ����������ϰ���", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN5);
        Phrase PhraseContextCN6 = new Phrase(filenum, FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN6);
        Phrase PhraseContextCN7 = new Phrase("������������ϵͳ��", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN7);
        Phrase PhraseContextCN8 = new Phrase("Adoption Applications Detail", FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN8);
        Phrase PhraseContextCN9 = new Phrase("ҳ���в�ѯ��ϸ�������������й�����������Ϣ������", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN9);
        Phrase PhraseContextCN10 = new Phrase("(86-10-65548860)", FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN10);
        Phrase PhraseContextCN11 = new Phrase("��ϵ���������뽻��", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN11);
        Phrase PhraseContextCN12 = new Phrase(should_pay + "$", FontEN_T12N);
        ParagraphContextCN.add(PhraseContextCN12);
        Phrase PhraseContextCN13 = new Phrase("����Ϣ���ϴ���ѡ�", FontCN_SONG12N);
        ParagraphContextCN.add(PhraseContextCN13);
        document.add(ParagraphContextCN);
        
        ParagraphContextCN.setSpacingAfter(30);
        
        //Ӣ�ı���
        Paragraph ParagraphTitleEN = new Paragraph("Notice of Information Tending", FontEN_T20B);
        ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
        ParagraphTitleEN.setSpacingAfter(10);
        document.add(ParagraphTitleEN);
        //Ӣ������
        Paragraph ParagraphContextEN = new Paragraph();
        ParagraphContextEN.setFirstLineIndent(20);//��������
        String contextEn = "From " + start_date + " to " + end_date + ", " + filenum + " applications have been processed through this system. Please use the page of Adoption Applications Detail In Special Need MIS to check detail. If there is any discrepancy, please contact the Information and Technology Department (86-10-65548860)If not, please pay the information processing fee of " + should_pay + "$.";
        Phrase PhraseContextEN1 = new Phrase(contextEn, FontEN_T12N);
        ParagraphContextEN.add(PhraseContextEN1);
        document.add(ParagraphContextEN);
        
        document.close();
        
        return PDFpath;
    }
	
}
