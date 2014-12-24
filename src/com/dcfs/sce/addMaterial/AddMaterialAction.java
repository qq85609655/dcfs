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
 * @Description: ����Ԥ�����ϲ�ѯ���鿴����֪ͨ���������
 * @Company: 21softech
 * @Created on 2014-9-14 ����3:43:13 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class AddMaterialAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(AddMaterialAction.class);
    private Connection conn = null;
    private AddMaterialHandler handler;
    private DBTransaction dt = null;//������
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
     * @Description: ����Ԥ�������б�
     * @author: panfeng
     * @date: 2014-9-11 ����5:21:12 
     * @return
     */
    public String findMaterialList(){
        // 1 ���÷�ҳ����
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 ��ȡ�����ֶ�
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="NOTICE_DATE";
        }
        //2.2 ��ȡ��������   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 ��ȡ��������
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","PROVINCE_ID",
        			"NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","SPECIAL_FOCUS",
        			"ADD_TYPE","NOTICE_DATE_START","NOTICE_DATE_END","FEEDBACK_DATE_START",
        			"FEEDBACK_DATE_END","AA_STATUS");
        //��ͯ�������з���Ů��������������ת����д
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
            //4 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //5 ��ȡ����DataList
            DataList dl=handler.findMaterialList(conn,data,pageSize,page,compositor,ordertype);
            //6 �������д��ҳ����ձ���
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 �����쳣����
            setAttribute(Constants.ERROR_MSG_TITLE, "��ѯ�����쳣");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("��ѯ�����쳣:" + e.getMessage(),e);
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
	 * @Title: showMaterialDetail 
	 * @Description: ����֪ͨ��ϸ�鿴��Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String showMaterialDetail(){
		//��ȡԤ��������Ϣid
		String uuid = getParameter("showuuid");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//���� Ԥ��������Ϣid��ȡ��ϸ��Ϣ
			Data data = handler.getDetailData(conn,uuid);
			
			setAttribute("detaildata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("IS_TWINS",data.getString("IS_TWINS",""));
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�鿴��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�鿴��Ϣ�����쳣:" + e.getMessage(),e);
			}
		}finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return retValue;
	}
    
    
    /**
	 * @Title: addMaterialShow 
	 * @Description: ��ת��Ԥ�����ϲ���ҳ��
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String addMaterialShow(){
		//��ȡԤ��������Ϣid
		String uuid = getParameter("showuuid");
		try {
			// ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//���� Ԥ��������Ϣid��ȡ��ϸ��Ϣ
			Data data = handler.getSupData(conn,uuid);
			data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());
			
			setAttribute("supdata", data);
			setAttribute("RA_ID", uuid);
			setAttribute("AF_ID", data.getString("AF_ID",""));//�������������ļ�ID
			setAttribute("ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());//����������ǰ�˵�λID
		} catch (DBException e) {
			// �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡԤ��������Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡԤ��������Ϣ�����쳣:" + e.getMessage(),e);
			}
		}finally {
			// �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return retValue;
	}
	
	/**
     * @Title: addMaterialSave 
	 * @Description: ����Ԥ�����ϱ���
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
     */
    public String addMaterialSave(){
	    //1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","RA_ID","RI_ID","ADD_TYPE","ADD_CONTENT_EN","FEEDBACK_DATE","UPLOAD_IDS","AA_STATUS");
        String type = getParameter("type");
        try {
            //2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            boolean success = false;
			//3 ִ�����ݿ⴦�����
            Data infodata = new Data();
            infodata.add("RI_ID", (String)data.get("RI_ID"));
            //���ݲ�������Ԥ��������Ϣ��ĩ�β���״̬
            String add_type = (String)data.get("ADD_TYPE");
            if(type=="save" || "save".equals(type)){
            	if("1".equals(add_type)){
            		infodata.add("LAST_STATE","1");//����˲�ĩ�β���״̬����Ϊ"������"
            	}else if("2".equals(add_type)){
            		infodata.add("LAST_STATE2","1");//�����ò�ĩ�β���״̬����Ϊ"������"
            	}
            }else{
            	if("1".equals(add_type)){
    				infodata.add("LAST_STATE", "2");//����˲�ĩ�β���״̬����Ϊ"�Ѳ���"
    			}else if("2".equals(add_type)){
    				infodata.add("LAST_STATE2", "2");//�����ò�ĩ�β���״̬����Ϊ"�Ѳ���"
    			}
            }
            
            data.add("FEEDBACK_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//������ID
            data.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//������
            
            //�ύ����ʱ���ݱ�������֯�Ƿ�Ԥ�������ж��Ƿ��ʼ��Ԥ�����䷭���¼
            if(type=="submit" || "submit".equals(type)){
				UserInfo userinfo = SessionInfo.getCurUser();
				String orgid = userinfo.getCurOrgan().getOrgCode();
				//��ȡ������֯��Ϣ
				SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
				String TRANS_FLAG = syzzinfo.getTransFlag();	//Ԥ���Ƿ��룺1=�ǣ�0=��
				if("1".equals(TRANS_FLAG)){
					//��ʼ��Ԥ�����䷭���¼
					PublishCommonManager publishcommonmanager = new PublishCommonManager();
					Data cdata = new Data();
					cdata.add("RI_ID", (String)data.get("RI_ID"));
					cdata.add("TRANSLATION_TYPE", "1");
					cdata.add("RA_ID", (String)data.get("RA_ID"));
					cdata.add("AT_TYPE", add_type);
					publishcommonmanager.translationInit(conn, cdata);
					if("1".equals(add_type)){
						infodata.add("ATRANSLATION_STATE", "0");//Ԥ��������Ϣ����˲�����״̬��������
					}else if("2".equals(add_type)){
						infodata.add("ATRANSLATION_STATE2", "0");//Ԥ��������Ϣ���ò�����״̬��������
					}
				}
            }
            
            success=handler.modInfoSave(conn,infodata);//����Ԥ��������Ϣ��ҵ��
            success=handler.addMaterialSave(conn,data);//���油���¼��ҵ��
            
            String packageId = data.getString("UPLOAD_IDS");//����
            AttHelper.publishAttsOfPackageId(packageId, "AF");//��������
            if (success) {
            	if(type=="save" || "save".equals(type)){
            		InfoClueTo clueTo = new InfoClueTo(0, "Saved.");//����ɹ� 0
            		setAttribute("clueTo", clueTo);
            	}else{
            		InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");//�ύ�ɹ� 0
            		setAttribute("clueTo", clueTo);
            	}
            }
            dt.commit();
        } catch (DBException e) {
		    //4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "������������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("��������쳣[�������]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
            setAttribute("clueTo", clueTo);
			retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");//����ʧ�� 2
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
                        log.logError("OpinionTemAction��Connection������쳣��δ�ܹر�",e);
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
	 * @Description: Ԥ��������Ϣ/�����ƻ�����֯����޸���ת����
	 * @author: panfeng
	 * @return String 
	 */
	public String modInfoPO(){
		
		//��ȡҳ���ύ����
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
			//����Ԥ�������¼ID,��ȡԤ��������ϢData
			Data showdata = handler.getInfoData(conn, ri_id);
			String family_type = showdata.getString("FAMILY_TYPE");	//��������
			//������������(family_type)ȷ�����ص�ҳ��
			if("info".equals(type)){
				if("1".equals(family_type)){
					retValue = "double";	//����˫�������޸�ҳ��
				}else{
					retValue = "single";	//���ص��������޸�ҳ��
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
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ԥ��������Ϣ�޸Ĳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[Ԥ��������Ϣ�޸Ĳ���]:" + e.getMessage(),e);
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
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
	 * @Description: Ԥ��������Ϣ�������
	 * @author: yangrt
	 * @return String
	 */
	public String modInfoSave(){
		String type = getParameter("type","");
		if(type.equals("")){
			type = (String)getAttribute("type");
		}
		//1 ���ҳ������ݣ��������ݽ����
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
		//���С�Ů����������ת��Ϊ��д
		if(!"".equals(data.getString("MALE_NAME",""))){
			data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
		}
		if(!"".equals(data.getString("FEMALE_NAME",""))){
			data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
		}
		
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
    		if("info".equals(type)){
    			boolean success = handler.modInfoSave(conn,data);
    			if(success){
    				InfoClueTo clueTo = new InfoClueTo(0, "Saved.");
    				setAttribute("clueTo", clueTo);
    			}
    			//��������
    			AttHelper.publishAttsOfPackageId(data.getString("MALE_PHOTO"), "AF"); //��������������Ƭ
    			AttHelper.publishAttsOfPackageId(data.getString("FEMALE_PHOTO"), "AF"); //����Ů��������Ƭ
    		}else{
    			boolean success = handler.modInfoSave(conn,POdata);
    			if(success){
    				InfoClueTo clueTo = new InfoClueTo(0, "Saved.");
    				setAttribute("clueTo", clueTo);
    			}
    		}
            
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "errer1";
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("��������쳣:" + e.getMessage(),e);
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
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
	 * @Description: ����Ԥ�������ύ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String materialSubmit() {
		//1 ��ȡҳ��ѡȡ����
		String subuuid = getParameter("subuuid", "");
		String ri_id = getParameter("ri_id", "");
		String add_type = getParameter("add_type", "");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			Data data = new Data();
			data.add("RA_ID", subuuid);
			data.add("AA_STATUS", "2");//��״̬Ϊ"������"����Ϣ���"�Ѳ���"
			data.add("FEEDBACK_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//������ID
            data.add("FEEDBACK_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//������
            data.add("FEEDBACK_DATE", DateUtility.getCurrentDate());//��������
			success = handler.addMaterialSave(conn, data);//���油���¼��ҵ��
						
			Data infodata = new Data();
			infodata.add("RI_ID", ri_id);
			if("1".equals(add_type)){
				infodata.add("LAST_STATE", "2");//����˲�ĩ�β���״̬����Ϊ"�Ѳ���"
			}else if("2".equals(add_type)){
				infodata.add("LAST_STATE2", "2");//�����ò�ĩ�β���״̬����Ϊ"�Ѳ���"
			}
			//���ݱ�������֯�Ƿ�Ԥ�������ж��Ƿ��ʼ��Ԥ�����䷭���¼
			UserInfo userinfo = SessionInfo.getCurUser();
			String orgid = userinfo.getCurOrgan().getOrgCode();
			//��ȡ������֯��Ϣ
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			String TRANS_FLAG = syzzinfo.getTransFlag();	//Ԥ���Ƿ��룺1=�ǣ�0=��
			if("1".equals(TRANS_FLAG)){
				//��ʼ��Ԥ�����䷭���¼
				PublishCommonManager publishcommonmanager = new PublishCommonManager();
				Data cdata = new Data();
				cdata.add("RI_ID", ri_id);
				cdata.add("TRANSLATION_TYPE", "1");
				cdata.add("RA_ID", subuuid);
				cdata.add("AT_TYPE", add_type);
				publishcommonmanager.translationInit(conn, cdata);
				if("1".equals(add_type)){
					infodata.add("ATRANSLATION_STATE", "0");//Ԥ��������Ϣ����˲�����״̬��������
				}else if("2".equals(add_type)){
					infodata.add("ATRANSLATION_STATE2", "0");//Ԥ��������Ϣ���ò�����״̬��������
				}
			}
			
			success = handler.modInfoSave(conn, infodata);//����Ԥ��������Ϣ��ҵ��
			
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ύ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[�ύ����]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "�ύ����ʧ��!");
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	
}
