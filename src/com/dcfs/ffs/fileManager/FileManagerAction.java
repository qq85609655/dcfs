/**   
 * @Title: FileManagerAction.java 
 * @Package com.dcfs.ffs.fileManager 
 * @Description: ��������֯���ļ���Ϣ���в�ѯ��¼�롢�޸ġ�ɾ�����ύ����ˮ�Ŵ�ӡ����������
 * @author yangrt
 * @date 2014-7-21 ����5:37:35 
 * @version V1.0   
 */
package com.dcfs.ffs.fileManager;

import hx.code.Code;
import hx.code.CodeList;
import hx.code.UtilCode;
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
import java.util.HashMap;
import java.util.Map;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.ModifyHistoryHandler;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.atttype.AttConstants;
import com.dcfs.ffs.common.CurrencyConverterAction;
import com.dcfs.ffs.common.FileCommonConstant;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileGlobalStatusAndPositionConstant;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.translation.FfsAfTranslationAction;
import com.dcfs.sce.lockChild.LockChildHandler;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.excelexport.ExcelExporter;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;
/**
 * 
 * @ClassName: FileManagerAction 
 * @Description: ��������֯���ļ���Ϣ���в�ѯ��¼�롢�޸ġ�ɾ�����ύ����ˮ�Ŵ�ӡ����������
 * @author yangrt;
 * @date 2014-7-21 ����5:37:35 
 *
 */
public class FileManagerAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(FileManagerAction.class);

    private FileManagerHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;

    public FileManagerAction(){
        this.handler=new FileManagerHandler();
    } 

	@Override
	public String execute() throws Exception {
		return null;
	}

	/************** �ݽ���ͨ�ļ�����Begin ***************/
	
	/**
	 * @Title: NormalFileList 
	 * @Description: ��ͨ�ļ���Ϣ��ѯ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String NormalFileList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="CREATE_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","AF_COST","FILE_TYPE","REG_STATE");
		String MALE_NAME = data.getString("MALE_NAME","");
		if(!"".equals(MALE_NAME)){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME","");
		if(!"".equals(FEMALE_NAME)){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.NormalFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�¼���ѯ�����쳣");
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
						log.logError("FileManagerAction��NormalFileList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: NormalFileAddFirst 
	 * @Description: ������ת��������֯�ݽ���ͨ�ļ���һ������ҳ��
	 * @author: yangrt
	 * @return String
	 */
	public String NormalFileAddFirst(){
		Data data = new Data();
		//��ȡ��ǰ��¼�˵���Ϣ
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgid = userinfo.getCurOrgan().getId();
		try {
			conn = ConnectionManager.getConnection();
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			data.add("ADOPT_ORG_ID", syzzinfo.getSyzzCode());	//���������֯code
			data.add("NAME_CN", syzzinfo.getSyzzCnName());	//���������֯��������
			data.add("NAME_EN", syzzinfo.getSyzzEnName());		//���������֯Ӣ������
			data.add("COUNTRY_CODE", syzzinfo.getCountryCode());	//��ȡ��ǰ��֯��������code
			data.add("COUNTRY_CN", syzzinfo.getCountryCnName());	//��ȡ��ǰ��֯�������ҵ���������
			data.add("COUNTRY_EN", syzzinfo.getCountryEnName());	//��ȡ��ǰ��֯�������ҵ���������
			setAttribute("data", data);
		} catch (DBException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�¼���һ�������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����쳣[�ļ�¼���һ�������쳣]:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//�ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction��NormalFileAddFirst.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		
		
		return retValue;
	}
	
	/**
	 * @Title: NormalFileSaveFirst 
	 * @Description: �����������ˡ�Ů������������ѯ����֯�������ļ�
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String NormalFileSaveFirst(){
		String file_id = getParameter("AF_ID","");
		//1 ���ҳ������ݣ��������ݽ����
        Data data = getRequestEntityData("R_","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","COUNTRY_CN","COUNTRY_EN","FILE_TYPE","FAMILY_TYPE","MALE_NAME","FEMALE_NAME","ADOPTER_SEX");
		
        try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ������ˮ��
			FileCommonManager fcm = new FileCommonManager();
			String AF_SEQ_NO = fcm.createFileSeqNO(conn);
			//�Ƿ�Լ����
			String IS_CONVENTION_ADOPT = fcm.getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));
			String NATION = fcm.getAdopterNation(conn, data.getString("COUNTRY_CODE"));
			//4 ��ȡ����Data
			Data fileData = null;
			if(!"".equals(file_id)){
				fileData = handler.GetFileByID(conn, file_id);
			}
			if(fileData != null){
				//����ļ�����ʱ
				fileData.remove("AF_ID");	//�Ƴ��ļ�id
				fileData.remove("AF_SEQ_NO");	//�Ƴ���ˮ��
				fileData.remove("FILE_TYPE");	//�Ƴ��ļ�����
				fileData.remove("FAMILY_TYPE");	//�Ƴ���������
				fileData.remove("CREATE_USERID");	//�Ƴ�������
				fileData.remove("CREATE_DATE");	//�Ƴ���������
				fileData.remove("AF_COST");	//�Ƴ�����
				fileData.remove("AF_POSITION");	//�Ƴ��ļ�λ��
				fileData.remove("AF_GLOBAL_STATE");	//�Ƴ��ļ���ȫ��״̬
			}else{
				//���ļ�������ʱ
				fileData = new Data();
				fileData.add("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID"));	//���������֯code
				fileData.add("NAME_CN", data.getString("NAME_CN"));				//���������֯��������
				fileData.add("NAME_EN", data.getString("NAME_EN"));				//���������֯Ӣ������
				fileData.add("COUNTRY_CODE", data.getString("COUNTRY_CODE"));	//���������֯��������code
				fileData.add("COUNTRY_CN", data.getString("COUNTRY_CN"));		//���������֯����������������
				fileData.add("COUNTRY_EN", data.getString("COUNTRY_EN"));		//���������֯��������Ӣ������
				fileData.add("MALE_NAME", data.getString("MALE_NAME","").toUpperCase());	//���������������
				fileData.add("FEMALE_NAME", data.getString("FEMALE_NAME","").toUpperCase());	//���Ů����������
				fileData.add("ADOPTER_SEX", data.getString("ADOPTER_SEX"));		//���Ů����������
			}
			
			fileData.add("AF_SEQ_NO", AF_SEQ_NO);	//����ļ���ˮ��
			fileData.add("AF_COST", "800");	//��ӷ���
			fileData.add("FILE_TYPE", data.getString("FILE_TYPE"));	//����ļ�����
			fileData.add("FAMILY_TYPE", data.getString("FAMILY_TYPE"));	//�����������
			fileData.add("REG_STATE", FileCommonConstant.DJZT_WTJ);	//���Ĭ�ϵĵǼ�״̬��0��δ�ύ��
			fileData.add("CREATE_USERID", SessionInfo.getCurUser().getPersonId());	//��Ӵ�����Id
			fileData.add("CREATE_DATE", DateUtility.getCurrentDateTime());	//��Ӵ�������
			fileData.add("AF_POSITION", FileGlobalStatusAndPositionConstant.POS_SYZZ);	//����ļ�Ĭ��λ��
			fileData.add("AF_GLOBAL_STATE", FileGlobalStatusAndPositionConstant.STA_WTJ);	//����ļ�ȫ��״̬
			fileData.add("IS_CONVENTION_ADOPT", IS_CONVENTION_ADOPT);
			
			//��������˹���
			String sex = data.getString("ADOPTER_SEX","");
			if("".equals(sex)){
				fileData.add("MALE_NATION", NATION);
				fileData.add("FEMALE_NATION", NATION);
			}else if("1".equals(sex)){
				fileData.add("MALE_NATION", NATION);
			}else if("2".equals(sex)){
				fileData.add("FEMALE_NATION", NATION);
			}
			
			//5��������
			dt = DBTransaction.getInstance(conn);
			//����һ���ļ���¼�������ظ��ļ�id��AF_ID��
            String af_id = handler.NormalFileSaveFirst(conn,fileData);	
			
            fileData.add("AF_ID", af_id);
            //6 �������д��ҳ����ձ���
			setAttribute("data",fileData);
			setAttribute("REG_STATE",fileData.getString("REG_STATE",""));
            
            if (!"".equals(af_id)) {
                InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");
                setAttribute("clueTo", clueTo);
            }
            dt.commit();
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����������ˡ�Ů������������ѯ����֯�������ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			
			if (log.isError()) {
				log.logError("�����������ˡ�Ů������������ѯ����֯�������ļ������쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		}catch (SQLException e) {
			//8 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		}catch (Exception e) {
			//8 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
		} finally {
			//9 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction��NormalFileSaveFirst.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: NormalFileAdd 
	 * @Description: �����ļ�ID��ȡ�����ļ���Ϣ,����ת����Ӧ�����/�޸�ҳ��
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String NormalFileAdd(){
		boolean flag = false;	//�ж��Ƿ��ǵ������֮����ת����
		//�������ͣ�step������Ů��double��˫�ף�single�����ף�
		retValue = getParameter("type","");	
		
		//��ҳ���ȡ�ļ�id����AF_IDΪ��ʱ������ת���޸�ҳ��
		String AF_ID = getParameter("AF_ID","");
		
		if("".equals(AF_ID)){
			//���AF_IDΪ�գ���ȡҪ�޸ĵ��ļ�ID
			AF_ID = (String)getAttribute("AF_ID");
			//����֮����ת����
			flag = true;
		}
		
		//�����ļ�id��ȡ���ļ���Ϣ
		Data data = this.GetFileByID(AF_ID);
		setAttribute("xmlstr", data.getString("xmlstr"));
		String file_type = data.getString("FILE_TYPE","");
		String family_type = data.getString("FAMILY_TYPE","");
		
		try {
			conn = ConnectionManager.getConnection();
			if(flag){
				if("33".equals(file_type)){
					retValue = "step";
				}else{
					if("1".equals(family_type)){
						retValue = "double";
					}else{
						retValue = "single";
					}
				}
				
			}else{
				String currency = data.getString("CURRENCY","");
				if("".equals(currency)){
					String orgid = SessionInfo.getCurUser().getCurOrgan().getId();
					SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
					//��ȡ�ù���Ĭ�ϵĻ�������
					data.put("CURRENCY", syzzinfo.getCurrency());	//���Ĭ�ϵĻ�������
				}
			}
		}catch (DBException e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�¼����Ӳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����쳣[�ļ�¼����Ӳ����쳣]:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�¼����Ӳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����쳣[�ļ�¼����Ӳ����쳣]:" + e.getMessage(),e);
			}
			
			retValue = "error1";
		} finally {
			//�ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction��NormalFileAdd.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		//����������Լ��֤�������ƴ��뼯
		HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
		CodeList coaList = this.getMKRORGCOAList();
    	cmap.put("ORGCOA_LIST", coaList);
    	setAttribute(Constants.CODE_LIST,cmap);
    	
    	//���üҵ���֯�б�����ҵ���֯���Ʋ��������У�����ʾΪOther
		String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
		if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
			setAttribute("isShowOrgName", "true");
			data.add("HOMESTUDY_ORG_DROP", "Other");
		}else{
			data.add("HOMESTUDY_ORG_DROP", HOMESTUDY_ORG_NAME);
		}
		data.add("HOMESTUDY_ORG_INPUT", HOMESTUDY_ORG_NAME);
		
		//����ҳ����ձ���
		setAttribute("data", data);
		setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG"));
		setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG"));
		setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG"));
		setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG"));
		setAttribute("IS_FAMILY_OTHERS_FLAG", data.getString("IS_FAMILY_OTHERS_FLAG"));
		
		setAttribute("AF_ID", AF_ID);
		setAttribute("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID",""));
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",AF_ID));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",AF_ID));
		
		return retValue;
	}
	
	/**
	 * @Title: NormalFileSave 
	 * @Description: �����޸ĵ�����
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String NormalFileSave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","AF_ID","AF_SEQ_NO","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","COUNTRY_CN","COUNTRY_EN","FILE_TYPE","FAMILY_TYPE",
				"MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN","MALE_HEALTH","IS_MEDICALRECOVERY",
				"MALE_HEALTH_CONTENT_EN","MALE_HEIGHT","MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","ADOPTER_SEX",
				"MALE_ILLEGALACT_EN","MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO",
				"FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT",
				"FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN","FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_EN",
				"FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
				"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_EN","FINISH_DATE",
				"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON",
				"IS_SUBMIT_REPORT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","ACCEPTED_CARD",
				"PARENTING","SOCIALWORKER","REMARK_EN","GOVERN_DATE","VALID_PERIOD","APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX",
				"CHILDREN_HEALTH_EN","REG_STATE","AF_POSITION","AF_GLOBAL_STATE","MEASUREMENT");
		//���С�Ů����������ת��Ϊ��д
		String MALE_NAME = data.getString("MALE_NAME","");
		if(!"".equals(MALE_NAME)){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME","");
		if(!"".equals(FEMALE_NAME)){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		if(!("".equals(data.getString("ADDRESS"))) && data.getString("ADDRESS")!=null){
			data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
        }

		data.add("PACKAGE_ID", data.getString("AF_ID"));
		
		//������Ч����ֵ�������Ľ�ֹ����
		String valid_period = data.getString("VALID_PERIOD","");
		if("-1".equals(valid_period)){
			data.add("EXPIRE_DATE", "2999-12-31");
		}else if(!"".equals(valid_period)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, Integer.parseInt(valid_period));
			cal.add(Calendar.DATE, -1);
			data.add("EXPIRE_DATE", sdf.format(cal.getTime()));
		}
		
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            
            String isGy = new FileCommonManager().getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));//�Ƿ�Լ����
			data.add("IS_CONVENTION_ADOPT", isGy);//�Ƿ�Լ����
			
			/*���һ���begin*/
			Data currencyData = new Data();
			currencyData.add("CURRENCY", data.getString("CURRENCY",""));
			currencyData.add("MALE_YEAR_INCOME", data.getString("MALE_YEAR_INCOME",""));
			currencyData.add("FEMALE_YEAR_INCOME", data.getString("FEMALE_YEAR_INCOME",""));
			currencyData.add("TOTAL_ASSET", data.getString("TOTAL_ASSET",""));
			currencyData.add("TOTAL_DEBT", data.getString("TOTAL_DEBT",""));
			
			currencyData = new CurrencyConverterAction().OtherToUSD(conn, currencyData);
			data.add("MALE_YEAR_INCOME", currencyData.getString("MALE_YEAR_INCOME",""));
			data.add("FEMALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("TOTAL_ASSET", currencyData.getString("TOTAL_ASSET",""));
			data.add("TOTAL_DEBT", currencyData.getString("TOTAL_DEBT",""));
			/*���һ���end*/
            
			String clueMes = "";
			FileCommonStatusAndPositionManager spm = new FileCommonStatusAndPositionManager();
			Data tempdata = new Data();	//��ȡ�ļ�λ�ú�״̬��data
            //������Ϊ�ύʱ��״ֵ̬��1��������ύ�ˡ��ύ����
    		String reg_state = data.getString("REG_STATE");
    		if(reg_state.equals(FileCommonConstant.DJZT_DDJ)){
    			data.add("AF_COST", new FileCommonManager().getAfCost(conn, "ZCWJFWF"));
    			UserInfo curuser = SessionInfo.getCurUser();
    			data.add("SUBMIT_USERID", curuser.getPersonId());
    			data.add("SUBMIT_DATE", DateUtility.getCurrentDateTime());
    			//��ȡ�ļ���ȫ��״̬��λ��
    		    tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_N_FILE_DELIVER_SUBMIT);
    		    clueMes = "Submitted successfully!";
    			retValue = "tijiao";
    		}else{
    			//�����ļ���ȫ��״̬��λ��
    			tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_N_FILE_DELIVER_SAVE);
    			setAttribute("AF_ID", data.getString("AF_ID"));
    			clueMes = "Saved successfully!";
    			retValue = "baocun";
    		}
    		
    		//����ļ���ȫ��״̬��λ��
    		data.add("AF_GLOBAL_STATE", tempdata.getString("AF_GLOBAL_STATE",""));
		    data.add("AF_POSITION", tempdata.getString("AF_POSITION",""));
            
            
            boolean success = false;
            success=handler.NormalFileSave(conn,data);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, clueMes);
                setAttribute("clueTo", clueTo);
                
                String male_photo = data.getString("MALE_PHOTO","");	//����������Ƭ
                String female_photo = data.getString("FEMALE_PHOTO");	//Ů��������Ƭ
                String file_type = data.getString("FILE_TYPE","");
                if("33".equals(file_type)){	//����ǻ���Ů����
                	String adopter_sex = data.getString("ADOPTER_SEX","");
                	if(adopter_sex.equals("1")){
                		AttHelper.publishAttsOfPackageId(male_photo, "AF"); //��������������Ƭ
                	}else if(adopter_sex.equals("2")){
                		AttHelper.publishAttsOfPackageId(female_photo, "AF"); //����Ů��������Ƭ
                	}
                }else if(!"".equals(male_photo)){
                	AttHelper.publishAttsOfPackageId(male_photo, "AF"); //��������������Ƭ
                }else if(!"".equals(female_photo)){
                	AttHelper.publishAttsOfPackageId(female_photo, "AF"); //����Ů��������Ƭ
                }
                
                String packageId = data.getString("PACKAGE_ID");//����
                AttHelper.publishAttsOfPackageId(packageId, "AF");//��������
            }
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���Ϣ��������쳣");
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
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (Exception e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��NormalFileSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: NormalFileRevise 
	 * @Description: ��ͨ�޸�ҳ����ת
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String NormalFileRevise(){
		//��ȡ�ļ�ID
		String file_id = getParameter("AF_ID");
		//�����ļ�ID��file_id������ȡ���ļ�����ϸ��Ϣ
		Data data = this.GetFileByID(file_id);
		setAttribute("data", data);
		setAttribute("REG_STATE", data.getString("REG_STATE",""));
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",file_id));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",file_id));
		
		/*CodeList coaList = this.getMKRORGCOAList();
		String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
		if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
			setAttribute("isShowOrgName", "true");
		}*/
		return retValue;
	}
	
	/**
	 * @Title: NormalFileShow 
	 * @Description: �����ļ��鿴
	 * @author: yangrt
	 * @return String 
	 */
	public String NormalFileShow(){
		//��ȡ�ļ�id
		String file_id = getParameter("AF_ID");
		//�����ļ�id(file_id)��ȡ���ļ�����ϸ��Ϣ
		Data data = this.GetFileByID(file_id);
		
		String file_type = data.getString("FILE_TYPE");	//�ļ�����
		String family_type = data.getString("FAMILY_TYPE");	//��������
		//�����ļ�����(file_type)����������(family_type)ȷ�����ص�ҳ��
		if("33".equals(file_type)){
			retValue = "step";	//���ؼ���Ů�����鿴ҳ��
		}else{
			if("1".equals(family_type)){
				retValue = "double";	//����˫�������鿴ҳ��
			}else{
				retValue = "single";	//���ص��������鿴ҳ��
				String male_name = data.getString("MALE_NAME","");
				String female_name = data.getString("FEMALE_NAME","");
				if(male_name.equals("")){
					setAttribute("maleFlag", "false");
				}else{
					setAttribute("maleFlag", "true");
				}
				if(female_name.equals("")){
					setAttribute("femaleFlag", "false");
				}else{
					setAttribute("femaleFlag", "true");
				}
			}
		}
		
		setAttribute("data", data);
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO", file_id));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO", file_id));
		setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", file_id));
		
		return retValue;
	}
	
	/**
	 * @Title: NormalFileExport 
	 * @Description: ������ͨ�ļ��б�
	 * @author: panfeng
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String NormalFileExport(){
		
		//1  ��ȡҳ�������ֶ�����
		Data data = getRequestEntityData("S_", "AF_SEQ_NO", "FILE_NO",
				"REGISTER_DATE_START", "REGISTER_DATE_END", "MALE_NAME", 
				"FEMALE_NAME", "FILE_TYPE", "AF_COST", "SUBMIT_DATE_START", 
				"SUBMIT_DATE_END", "REG_STATE");
		String AF_SEQ_NO = data.getString("AF_SEQ_NO", null); // ��ˮ��
		String FILE_NO = data.getString("FILE_NO", null); // ���ı��
		String REGISTER_DATE_START = data
				.getString("REGISTER_DATE_START", null); // ���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null); // ���Ľ�������
		
		String MALE_NAME = data.getString("MALE_NAME", null); // �з�
		if(null != MALE_NAME){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME", null); // Ů��
		if(null != FEMALE_NAME){
			FEMALE_NAME = FEMALE_NAME.toUpperCase();
		}
		String FILE_TYPE = data.getString("FILE_TYPE", null); // �ļ�����
		String AF_COST = data.getString("AF_COST", null); // Ӧ�ɽ��
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null); // �ύ��ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null); // �ύ��������
		String REG_STATE = data.getString("REG_STATE", null); // �ļ�״̬

		try {
			//2���õ����ļ�����
			this.getResponse().setHeader(
					"Content-Disposition",
					"attachment;filename="
							+ new String("�ݽ���ͨ�ļ�.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3��������ֶ� 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("GJSY","WJLX_DL");
    		//�ļ����ʹ���
    		CodeList scList=codes.get("WJLX_DL");
    		Map<String,String> fileDengji=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			fileDengji.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", fileDengji);
    		//�ļ�״̬����
    		Map<String,String> filestate=new HashMap<String,String>();
    		filestate.put("0","δ�ύ");
    		filestate.put("1","δ�Ǽ�");
    		filestate.put("2","���޸�");
    		filestate.put("3","�ѵǼ�");
    		dict.put("REG_STATE", filestate);
    		//4 ִ���ļ�����
			ExcelExporter.export2Stream("�ݽ���ͨ�ļ�", "NormalFile", dict, this
					.getResponse().getOutputStream(),AF_SEQ_NO, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, MALE_NAME, FEMALE_NAME, null, FILE_TYPE, AF_COST, SUBMIT_DATE_START, SUBMIT_DATE_END, REG_STATE);
			
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  �����쳣����
			log.logError("������ͨ�ļ������쳣", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "������ͨ�ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 ҳ�治������ת������NULL ������ת����������ֵ
		return null;
	}
	
	/************** �ݽ���ͨ�ļ�����End ***************/
	
	
	/************** �ݽ������ļ�����Begin ***************/
	
	/**
	 * @Title: SpecialFileList 
	 * @Description: �����ļ���Ϣ��ѯ�б�
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SpecialFileList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_STATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="ASC";
		}
		
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","AF_COST","FILE_TYPE","REG_STATE","NAME","BIRTHDAY_START","BIRTHDAY_END","SEX");
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.SpecialFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�¼���ѯ�����쳣");
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
						log.logError("FileManagerAction��SpecialFileList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: SpecialFileSelectList 
	 * @Description: ��ȡԤ��ͨ���������ļ���Ϣ�б�
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SpecialFileSelectList(){
		String type = getParameter("type","");	//��ֹ�б�ҳ����������������
		if("".equals(type)){
			type = (String) getAttribute("type");
		}
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REQ_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		
		Data data = new Data();
		if("select".equals(type)){
			compositor="REQ_DATE";
			ordertype="DESC";
		}else{
			//3 ��ȡ��������
			data = getRequestEntityData("S_","REQ_NO","MALE_NAME","FEMALE_NAME","NAME_PINYIN","SEX","BIRTHDAY_START","BIRTHDAY_END","REQ_DATE_START","REQ_DATE_END","PASS_DATE_START","PASS_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END","REMINDERS_STATE");
		}
		
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		String NAME_PINYIN = data.getString("NAME_PINYIN");
		if(null != NAME_PINYIN){
			data.add("NAME_PINYIN", NAME_PINYIN.toUpperCase());
		}
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡԤ��ͨ�����ļ�����(DataList)
			DataList dl=handler.SpecialFileSelectList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("data",data);
			setAttribute("List",dl);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��תѡ��Ԥ��ͨ���������ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��תѡ��Ԥ��ͨ���������ļ������쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��SpecialFileSelectList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * @Title: SpecialFileAdd
	 * @Description: �����ļ��ݽ�����ת
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SpecialFileAdd(){
		//��ȡԤ��������ϢID
		String ri_id = getParameter("RI_ID");
		setAttribute("RI_ID",ri_id);
		//����������Լ��֤�������ƴ��뼯
		HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
		CodeList coaList = this.getMKRORGCOAList();
    	cmap.put("ORGCOA_LIST", coaList);
    	setAttribute(Constants.CODE_LIST,cmap);
    	
		//�����ļ�����id
		String af_id = UUID.getUUID();
		
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ��������ϢID(ri_id)��ȡ���ļ�����ϸ��Ϣ
			Data data = handler.GetReqInfoByID(conn,ri_id);
			
			//��ȡ��ǰ������֯��Ϣ
	    	String orgid = SessionInfo.getCurUser().getCurOrgan().getId();
			SyzzDept syzzinfo = new DeptUtil().getSYZZInfo(conn, orgid);
			String orgCode = syzzinfo.getSyzzCode();
			
			//���ݶ�ͯ����id��ȡ����ͯ��Ϣ
			String ci_id = data.getString("CI_ID");
			Data mainchild = new LockChildHandler().getMainChildInfo(conn, ci_id);
			DataList attachchild = new LockChildHandler().getAttachChildList(conn, ci_id); 
			DataList dataList = new DataList();
			dataList.add(mainchild);
			for(int i = 0; i < attachchild.size(); i++){
				dataList.add(attachchild.getData(i));
				ci_id += "," + attachchild.getData(i).getString("CI_ID","");
			}
			
			//��ȡ�����ϴ���·��
			String file_type = data.getString("FILE_TYPE");	//�ļ�����
			String family_type = data.getString("FAMILY_TYPE");	//��������
			FfsAfTranslationAction action  = new  FfsAfTranslationAction();
			//parents	˫�� singleparent ���� stepchild ����Ů		 
			String formType = action.getFormType(family_type, file_type);
			String xmlstr = action.getFileUploadParameter(conn,formType);
			
			//��ȡ�ù����Ƿ�Լ����
			String IS_CONVENTION_ADOPT = new FileCommonManager().getISGY(conn, file_type, data.getString("COUNTRY_CODE"));
			
			//�����ؼ��ļ���ϵͳ�����ü�ͥ���ύ���ļ�����ԭ��ͥ�ļ��������˻����������һ��
			if("22".equals(file_type)){
				//��ȡϵͳ�����ü�ͥ���ύ���ļ���Ϣ
				Data filedata = handler.getSpecialFileData(conn,data.getString("ORIGINAL_FILE_NO"));
				filedata.put("AF_ID",af_id);
				filedata.put("RI_ID",ri_id);
				filedata.put("RI_STATE",data.getString("RI_STATE"));
				filedata.put("ADOPT_ORG_ID", syzzinfo.getSyzzCode());	//���������֯code
				filedata.put("NAME_CN", syzzinfo.getSyzzCnName());	//���������֯��������
				filedata.put("NAME_EN", syzzinfo.getSyzzEnName());		//���������֯Ӣ������
				filedata.put("COUNTRY_CODE", syzzinfo.getCountryCode());	//��ȡ��ǰ��֯��������code
				filedata.put("COUNTRY_CN", syzzinfo.getCountryCnName());	//��ȡ��ǰ��֯�������ҵ���������
				filedata.put("COUNTRY_EN", syzzinfo.getCountryEnName());	//��ȡ��ǰ��֯�������ҵ���������
				filedata.put("FILE_TYPE", "22");
				filedata.put("CI_ID", ci_id);
				filedata.remove("REG_STATE");
				filedata.add("IS_CONVENTION_ADOPT", IS_CONVENTION_ADOPT);
				
				String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
				if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
					setAttribute("isShowOrgName", "true");
					filedata.add("HOMESTUDY_ORG_DROP", "Other");
				}else{
					filedata.add("HOMESTUDY_ORG_DROP", HOMESTUDY_ORG_NAME);
				}
				filedata.add("HOMESTUDY_ORG_INPUT", HOMESTUDY_ORG_NAME);
				
				setAttribute("data", filedata);
				setAttribute("IS_FAMILY_OTHERS_FLAG",filedata.getString("IS_FAMILY_OTHERS_FLAG",""));
			}else{
				data.put("AF_ID", af_id);
				data.put("ADOPT_ORG_ID", syzzinfo.getSyzzCode());	//���������֯code
				data.put("NAME_CN", syzzinfo.getSyzzCnName());	//���������֯��������
				data.put("NAME_EN", syzzinfo.getSyzzEnName());		//���������֯Ӣ������
				data.put("COUNTRY_CODE", syzzinfo.getCountryCode());	//��ȡ��ǰ��֯��������code
				data.put("COUNTRY_CN", syzzinfo.getCountryCnName());	//��ȡ��ǰ��֯�������ҵ���������
				data.put("COUNTRY_EN", syzzinfo.getCountryEnName());	//��ȡ��ǰ��֯�������ҵ���������
				data.put("IS_CONVENTION_ADOPT", IS_CONVENTION_ADOPT);
				if("23".equals(file_type)){
					String PRE_REQ_NO = data.getString("PRE_REQ_NO","");
					Data preData = handler.GetReqInfoByReqNo(conn, PRE_REQ_NO);
					ri_id += "," + preData.getString("RI_ID");
					data.put("RI_ID", ri_id);
					
					String pre_ci_id = preData.getString("CI_ID");
					Data premainchild = new LockChildHandler().getMainChildInfo(conn, pre_ci_id);
					DataList preattachchild = new LockChildHandler().getAttachChildList(conn, pre_ci_id); 
					dataList.add(premainchild);
					for(int i = 0; i < preattachchild.size(); i++){
						dataList.add(preattachchild.getData(i));
						pre_ci_id += "," + preattachchild.getData(i).getString("CI_ID","");
					}
					ci_id += "," + pre_ci_id;
					data.put("CI_ID", ci_id);
				}else{
					data.put("CI_ID", ci_id);
				}
				
				setAttribute("data", data);
				setAttribute("IS_FAMILY_OTHERS_FLAG",data.getString("IS_FAMILY_OTHERS_FLAG",""));
			}
			
			//����Ԥ��������Ϣ�е���������Ƭ
			String adopter_sex = data.getString("ADOPTER_SEX","");
			ri_id = ri_id.split(",")[0];
			if("".equals(adopter_sex)){
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_MALEPHOTO, "AF", af_id, "AF", AttConstants.AF_MALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_FEMALEPHOTO, "AF", af_id, "AF", AttConstants.AF_FEMALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
			}else if("1".equals(adopter_sex)){
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_MALEPHOTO, "AF", af_id, "AF", AttConstants.AF_MALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
			}else if("1".equals(adopter_sex)){
				AttHelper.copyAtts("AF", ri_id, "AF", AttConstants.AF_FEMALEPHOTO, "AF", af_id, "AF", AttConstants.AF_FEMALEPHOTO, "org_id=" + orgCode, "af_id=" + af_id);
			}
			
			setAttribute("List", dataList);
			setAttribute("AF_ID", af_id);
			setAttribute("CI_ID", ci_id);
			setAttribute("ADOPT_ORG_ID", orgCode);
			setAttribute("xmlstr", xmlstr);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",af_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",af_id));
			setAttribute("REG_STATE", data.getString("REG_STATE",""));
			setAttribute("SUBMIT_DATE", data.getString("SUBMIT_DATE").substring(0, 10));
			setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG"));	//��������Υ����Ϊ�����´�����ʶ,0=�ޣ�1=��
			setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG"));	//�����������޲����Ⱥñ�ʶ,0=�ޣ�1=��
			setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG"));	//Ů������Υ����Ϊ�����´�����ʶ,0=�ޣ�1=��
			setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG"));	//Ů���������޲����Ⱥñ�ʶ,0=�ޣ�1=��
			
			//������������(family_type)ȷ�����ص�ҳ��,1:˫������,2����������
			if("1".equals(family_type)){
				retValue = "double";	//����˫�������鿴ҳ��
			}else{
				retValue = "single";	//���ص��������鿴ҳ��
			}
			
			setAttribute("FLAG", "add");	//������ӡ��޸ı�ʾ
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת¼�������ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ת¼�������ļ������쳣:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "��ת¼�������ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ת¼�������ļ������쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��SpecialFileAdd.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: SpecialFileSave 
	 * @Description: �����ļ��ݽ�����
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SpecialFileSave(){
		//��ȡ��ӡ��޸ı�ʾ��addΪ��ӣ�modΪ�޸�
		String flag = getParameter("FLAG");
		//��ȡ��ǰ��¼����Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","AF_ID","RI_ID","RI_STATE","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","COUNTRY_CN","COUNTRY_EN","CI_ID","FILE_TYPE","FAMILY_TYPE",
				"MALE_NAME","MALE_BIRTHDAY","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN","MALE_HEALTH","IS_MEDICALRECOVERY",
				"MALE_HEALTH_CONTENT_EN","MALE_HEIGHT","MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG","MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG",
				"MALE_ILLEGALACT_EN","MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME","FEMALE_NAME","FEMALE_BIRTHDAY","FEMALE_PHOTO",
				"FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN","FEMALE_HEIGHT",
				"FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN","FEMALE_ILLEGALACT_FLAG","FEMALE_ILLEGALACT_EN",
				"FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE","CONABITA_PARTNERS","CONABITA_PARTNERS_TIME",
				"GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_EN","UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_EN","FINISH_DATE",
				"HOMESTUDY_ORG_NAME","RECOMMENDATION_NUM","HEART_REPORT","MEDICALRECOVERY_EN","IS_FORMULATE","ADOPT_PREPARE","RISK_AWARENESS","IS_ABUSE_ABANDON",
				"IS_SUBMIT_REPORT","IS_FAMILY_OTHERS_FLAG","IS_FAMILY_OTHERS_EN","ADOPT_MOTIVATION","CHILDREN_ABOVE","INTERVIEW_TIMES","ACCEPTED_CARD",
				"PARENTING","SOCIALWORKER","REMARK_EN","GOVERN_DATE","VALID_PERIOD","APPROVE_CHILD_NUM","AGE_FLOOR","AGE_UPPER","CHILDREN_SEX",
				"CHILDREN_HEALTH_EN","REG_STATE","AF_POSITION","AF_GLOBAL_STATE","MEASUREMENT","ADOPTER_SEX","IS_CONVENTION_ADOPT");
		//���С�Ů����������ת��Ϊ��д
		String MALE_NAME = data.getString("MALE_NAME","");
		if(!"".equals(MALE_NAME)){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME","");
		if(!"".equals(FEMALE_NAME)){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		if(!("".equals(data.getString("ADDRESS"))) && data.getString("ADDRESS")!=null){
			data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
        }
		data.add("PACKAGE_ID", data.getString("AF_ID"));
		
		//������Ч����ֵ�������Ľ�ֹ����
		String valid_period = data.getString("VALID_PERIOD","");
		if("-1".equals(valid_period)){
			data.add("EXPIRE_DATE", "2999-12-31");
		}else if(!"".equals(valid_period)){
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, Integer.parseInt(valid_period));
			cal.add(Calendar.DATE, -1);
			data.add("EXPIRE_DATE", sdf.format(cal.getTime()));
		}
		
        try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            //�����ˮ��
            data.put("AF_SEQ_NO", new FileCommonManager().createFileSeqNO(conn));
            
            String isGy = new FileCommonManager().getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));//�Ƿ�Լ����
			data.add("IS_CONVENTION_ADOPT", isGy);//�Ƿ�Լ����
			
			/*���һ���begin*/
			Data currencyData = new Data();
			currencyData.add("CURRENCY", data.getString("CURRENCY",""));
			currencyData.add("MALE_YEAR_INCOME", data.getString("MALE_YEAR_INCOME",""));
			currencyData.add("FEMALE_YEAR_INCOME", data.getString("FEMALE_YEAR_INCOME",""));
			currencyData.add("TOTAL_ASSET", data.getString("TOTAL_ASSET",""));
			currencyData.add("TOTAL_DEBT", data.getString("TOTAL_DEBT",""));
			
			currencyData = new CurrencyConverterAction().OtherToUSD(conn, currencyData);
			data.add("MALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("FEMALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("TOTAL_ASSET", currencyData.getString("TOTAL_ASSET",""));
			data.add("TOTAL_DEBT", currencyData.getString("TOTAL_DEBT",""));
			/*���һ���end*/
            
			String clueMes = "";
			FileCommonStatusAndPositionManager spm = new FileCommonStatusAndPositionManager();
			Data tempdata = new Data();	//��ȡ�ļ�λ�ú�״̬��data
            //������Ϊ�ύʱ��״ֵ̬��1��������ύ�ˡ��ύ����
    		String reg_state = data.getString("REG_STATE");
    		if(reg_state.equals(FileCommonConstant.DJZT_DDJ)){
    			
    			data.add("SUBMIT_USERID", curuser.getPersonId());
    			data.add("SUBMIT_DATE", DateUtility.getCurrentDateTime());
    			//��ȡ�ļ���ȫ��״̬��λ��
    			tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_S_FILE_DELIVER_SUBMIT);
    			clueMes = "Submitted successfully!";
    			retValue = "submit";
    		}else{
    			data.add("CREATE_USERID", curuser.getPersonId());
    			data.add("CREATE_DATE", DateUtility.getCurrentDateTime());
    			//��ȡ�ļ���ȫ��״̬��λ��
    			tempdata = spm.getNextGlobalAndPosition(FileOperationConstant.SYZZ_S_FILE_DELIVER_SAVE);
    			clueMes = "Saved successfully!";
    			setAttribute("FLAG", "mod");	//������ӡ��޸ı�ʾ
    			retValue = "save";
    		}
            
    		//����ļ���ȫ��״̬��λ��
    		data.add("AF_GLOBAL_STATE", tempdata.getString("AF_GLOBAL_STATE",""));
		    data.add("AF_POSITION", tempdata.getString("AF_POSITION",""));
		    
		    String ci_id = data.getString("CI_ID");
		    int child_num = 1;			//��ͯ����
		    if(ci_id.contains(",")){
		    	child_num = ci_id.split(",").length;
		    }
		    int af_cost = new FileCommonManager().getAfCost(conn, "TXWJFWF");
		    data.add("AF_COST", child_num * af_cost);
		    
		    DataList dl = handler.forUpdateSceReqInfo(conn, data.getString("RI_ID",""));
		    String ri_stata = dl.getData(0).getString("RI_STATE");
		    if("4".equals(ri_stata)){
		    	boolean success = handler.SpecialFileSave(conn,data,flag);
	            if (success) {
	                InfoClueTo clueTo = new InfoClueTo(0, clueMes);
	                setAttribute("clueTo", clueTo);
	                
	                //��������
	                String male_photo = data.getString("MALE_PHOTO","");		//����������Ƭ
	                if(!"".equals(male_photo)){
	                	AttHelper.publishAttsOfPackageId(male_photo, "AF"); 	//��������������Ƭ
	                }
	                String female_photo = data.getString("FEMALE_PHOTO");		//Ů��������Ƭ
	                if(!"".equals(female_photo)){
	                	AttHelper.publishAttsOfPackageId(female_photo, "AF"); 	//����Ů��������Ƭ
	                }
	                String packageId = data.getString("PACKAGE_ID");			//����
	                AttHelper.publishAttsOfPackageId(packageId, "AF");			//��������
	            }
	            
	            setAttribute("data", data);
	            setAttribute("AF_ID", data.getString("AF_ID",""));
	            
	            //����������Լ��֤�������ƴ��뼯
				HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
		    	cmap.put("ORGCOA_LIST", getMKRORGCOAList());
		    	setAttribute(Constants.CODE_LIST,cmap);
		    	
		    	dt.commit();
		    }else if("5".equals(ri_stata)){
		    	InfoClueTo clueTo = new InfoClueTo(0, "��Ԥ���ѵݽ��ļ��������ظ��ݽ���������ѡ��Ԥ���ļ���");
	            setAttribute("clueTo", clueTo);
	            retValue = "select";					//��ת��Ԥ��ѡ��ҳ��
	            setAttribute("type", "select");			//��תԤ��ѡ��ҳ���������
		    }
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���Ϣ��������쳣");
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
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (Exception e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��SpecialFileSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: SpecialFileRevise 
	 * @Description: �޸�ҳ����ת
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SpecialFileRevise(){
		//��ȡ�ļ�ID
		String file_id = getParameter("AF_ID","");
		if("".equals(file_id)){
			file_id = (String)getAttribute("AF_ID");
		}
		//����������Լ��֤�������ƴ��뼯
        CodeList coaList = this.getMKRORGCOAList();
		HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
    	cmap.put("ORGCOA_LIST", coaList);
    	setAttribute(Constants.CODE_LIST,cmap);
		try{
			//�����ļ�ID��file_id������ȡ���ļ�����ϸ��Ϣ
			Data data = this.GetFileByID(file_id);
			conn = ConnectionManager.getConnection();
			String ri_id = data.getString("RI_ID");
			String ci_id = data.getString("CI_ID","");
			String[] riId = ri_id.split(",");
			Data tempData = new Data();
			for(int i = 0; i < riId.length; i++){
				Data ridata = handler.GetReqInfoByID(conn,riId[i]);
				tempData.add(ridata.getString("CI_ID"), ridata.getString("SUBMIT_DATE").substring(0, 10));
			}
			//��ȡԤ�������¼�еĽ�������
			
			//��ȡ��ͯ������Ϣ
			DataList dl = handler.getChildDataList(conn, ci_id);
			for(int i = 0; i < dl.size(); i++){
				Data childdata = dl.getData(i);
				String MAIN_CI_ID = childdata.getString("MAIN_CI_ID","").toUpperCase();
				childdata.add("SUBMIT_DATE", tempData.getString(MAIN_CI_ID));
			}
			
			String isGy = new FileCommonManager().getISGY(conn, data.getString("FILE_TYPE"), data.getString("COUNTRY_CODE"));//�Ƿ�Լ����
			data.add("IS_CONVENTION_ADOPT", isGy);//�Ƿ�Լ����
			
			String family_type = data.getString("FAMILY_TYPE");
			if("1".equals(family_type)){
				retValue = "double";	//����˫�������޸�ҳ��
			}else{
				retValue = "single";	//���ص��������޸�ҳ��
			}
			
			//��ɼҵ���֯������Ƿ���ʾ
			String HOMESTUDY_ORG_NAME = data.getString("HOMESTUDY_ORG_NAME","");
			if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
				setAttribute("isShowOrgName", "true");
				data.add("HOMESTUDY_ORG_DROP", "Other");
			}else{
				data.add("HOMESTUDY_ORG_DROP", HOMESTUDY_ORG_NAME);
			}
			data.add("HOMESTUDY_ORG_INPUT", HOMESTUDY_ORG_NAME);
			
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("REG_STATE", data.getString("REG_STATE",""));
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",file_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",file_id));
			setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG",""));
            setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG",""));
            setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG",""));
            setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG",""));
            setAttribute("AF_ID", file_id);
            setAttribute("CI_ID", ci_id);
            setAttribute("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID",""));
            setAttribute("xmlstr", data.getString("xmlstr",""));
            setAttribute("IS_FAMILY_OTHERS_FLAG",data.getString("IS_FAMILY_OTHERS_FLAG",""));
            setAttribute("FLAG", "mod");	//������ӡ��޸ı�ʾ
			
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ��޸Ĳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[�����ļ��޸Ĳ���]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��ChildDataShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		
		return retValue;
	}
	
	/**
	 * @Title: SpecialFileShow 
	 * @Description: �����ļ���Ϣ�鿴
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SpecialFileShow(){
		//��ȡ�ļ�id
		String file_id = getParameter("AF_ID");
		try {
			//�����ļ�id(file_id)��ȡ���ļ�����ϸ��Ϣ
			Data data = this.GetFileByID(file_id);
			conn = ConnectionManager.getConnection();
			String ri_id = data.getString("RI_ID","");
			String[] riId = ri_id.split(",");
			//��ȡԤ�������¼�еĽ�������
			Data tempData = new Data();
			for(int i = 0; i < riId.length; i++){
				Data ridata = handler.GetReqInfoByID(conn,riId[i]);
				tempData.add(ridata.getString("CI_ID"), ridata.getString("SUBMIT_DATE").substring(0, 10));
			}
			
			//���ݶ�ͯ����id��ȡ��ͯ��Ϣ
			String ci_id = data.getString("CI_ID");
			DataList dataList = handler.getChildDataList(conn, ci_id);
			for(int i = 0; i < dataList.size(); i++){
				Data childdata = dataList.getData(i);
				String MAIN_CI_ID = childdata.getString("MAIN_CI_ID","").toUpperCase();
				childdata.add("SUBMIT_DATE", tempData.getString(MAIN_CI_ID));
			}
			
			String family_type = data.getString("FAMILY_TYPE");	//��������
			//������������(family_type)ȷ�����ص�ҳ��
			if("1".equals(family_type)){
				retValue = "double";	//����˫�������鿴ҳ��
			}else{
				retValue = "single";	//���ص��������鿴ҳ��
				String male_name = data.getString("MALE_NAME","");
				String female_name = data.getString("FEMALE_NAME","");
				if(male_name.equals("")){
					setAttribute("maleFlag", "false");
				}else{
					setAttribute("maleFlag", "true");
				}
				if(female_name.equals("")){
					setAttribute("femaleFlag", "false");
				}else{
					setAttribute("femaleFlag", "true");
				}
			}
			
			setAttribute("List", dataList);
			setAttribute("data", data);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",file_id));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",file_id));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", file_id));
		}catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ��鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����ļ��鿴�����쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��SpecialFileShow.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: ChildDataShow 
	 * @Description: ���ݶ�ͯ����id��ȡ��ͯ��ϸ��Ϣ
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String ChildDataShow(){
		String str_id = getParameter("ci_id");
		String ri_id = getParameter("RI_ID","");
		try {
			conn = ConnectionManager.getConnection();
			DataList dl = handler.getChildDataList(conn, str_id);
			String[] riId = ri_id.split(",");
			//��ȡԤ�������¼�еĽ�������
			Data tempData = new Data();
			for(int i = 0; i < riId.length; i++){
				Data ridata = handler.GetReqInfoByID(conn,riId[i]);
				tempData.add(ridata.getString("CI_ID"), ridata.getString("SUBMIT_DATE").substring(0, 10));
			}
			for(int i = 0; i < dl.size(); i++){
				Data childdata = dl.getData(i);
				String MAIN_CI_ID = childdata.getString("MAIN_CI_ID","").toUpperCase();
				childdata.add("SUBMIT_DATE", tempData.getString(MAIN_CI_ID));
			}
			setAttribute("List", dl);
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ͯ��Ϣ�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[��ͯ��Ϣ�鿴����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��ChildDataShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/**
	 * @Title: SpecialFileExport 
	 * @Description: ���������ļ���Ϣ
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SpecialFileExport(){
		
		//1  ��ȡҳ�������ֶ�����
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO",
				"SUBMIT_DATE_START","SUBMIT_DATE_END","REGISTER_DATE_START","REGISTER_DATE_END",
				"AF_COST","FILE_TYPE","REG_STATE");
		String MALE_NAME = data.getString("MALE_NAME", null); // �з�
		if(null != MALE_NAME){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME", null); // Ů��
		if(null != FEMALE_NAME){
			MALE_NAME = FEMALE_NAME.toUpperCase();
		}
		
		String FILE_NO = data.getString("FILE_NO", null); // ���ı��
		String SUBMIT_DATE_START = data.getString("SUBMIT_DATE_START", null); // �ύ��ʼ����
		String SUBMIT_DATE_END = data.getString("SUBMIT_DATE_END", null); // �ύ��ֹ����
		String REGISTER_DATE_START = data.getString("SUBMIT_DATE_START", null); // ������ʼ����
		String REGISTER_DATE_END = data.getString("SUBMIT_DATE_END", null); // ���Ľ�ֹ����
		String AF_COST = data.getString("AF_COST", null); // Ӧ�ɽ��
		/*String NAME = data.getString("NAME", null); // ��ͯ����
		String SEX = data.getString("SEX", null); // �Ա�
		String BIRTHDAY_START = data.getString("BIRTHDAY_START", null); // ������ʼ����
		String BIRTHDAY_END = data.getString("BIRTHDAY_END", null); // ������ֹ����
*/		String FILE_TYPE = data.getString("FILE_TYPE", null); // �ļ�����
		String REG_STATE = data.getString("REG_STATE", null); // �Ǽ�״̬
		
		UserInfo userinfo = SessionInfo.getCurUser();
		String orgcode = userinfo.getCurOrgan().getOrgCode();

		try {
			//2���õ����ļ�����
			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("�ݽ������ļ�.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3��������ֶ� 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("TXWJLX","ETXB");
    		//�ļ����ʹ���
    		CodeList scList=codes.get("TXWJLX");
    		Map<String,String> filetype=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			filetype.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", filetype);
    		//��ͯ�Ա����
    		CodeList xbList=codes.get("ETXB");
    		Map<String,String> childsex=new HashMap<String,String>();
    		for(int i=0;i<xbList.size();i++){
    			Code c=xbList.get(i);
    			childsex.put(c.getValue(),c.getName());
    		}
    		dict.put("SEX", childsex);
    		//�ļ�״̬����
    		Map<String,String> filestate=new HashMap<String,String>();
    		filestate.put("0","δ�ύ");
    		filestate.put("1","δ�Ǽ�");
    		filestate.put("2","���޸�");
    		filestate.put("3","�ѵǼ�");
    		dict.put("REG_STATE", filestate);
    		//4 ִ���ļ�����
			ExcelExporter.export2Stream("�ݽ������ļ�", "SpecialFile", dict, this.getResponse().getOutputStream(),
					MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, FILE_TYPE, AF_COST, SUBMIT_DATE_START, SUBMIT_DATE_END, REG_STATE, orgcode);
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  �����쳣����
			log.logError("���������ļ������쳣", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "���������ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 ҳ�治������ת������NULL ������ת����������ֵ
		return null;
	}
	
	/************** �ݽ������ļ�����End ***************/
	
	/************** �����ļ�����Start ***************/
	
	/**
	 * @Title: SuppleFileList 
	 * @Description: �����ļ��б�
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SuppleFileList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AA_STATUS";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FILE_TYPE","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
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
			DataList dl=handler.SuppleFileList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����ļ���ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��SuppleFileList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: SuppleFileAdd 
	 * @Description: �����ļ���Ϣ���/�޸Ĳ���
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SuppleFileAdd(){
		//��ȡ�����ļ�����ID(aa_id)
		String aa_id = getParameter("AA_ID");
		try {
			//��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//���ݲ����ļ�ID(aa_id)����ȡ�ļ���Ϣ��������Ϣ����Data
			Data data = handler.getSuppleFileData(conn,aa_id);
			
			//�������д��ҳ����ձ���
			setAttribute("data",data);
			setAttribute("AA_ID", aa_id);
			setAttribute("ORG_CODE", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ����/�޸Ĳ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����ļ����/�޸Ĳ����쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��SuppleFileAdd.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: SuppleFileSave 
	 * @Description: ���油���ļ���Ϣ
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SuppleFileSave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","AA_ID","IS_ADDATTACH","IS_MODIFY","ADD_CONTENT_EN","AA_STATUS","NOTICE_CONTENT","NOTICE_DATE","UPLOAD_IDS","AF_ID","FILE_NO","FILE_TYPE","MALE_NAME","MALE_BIRTHDAY","FEMALE_NAME","FEMALE_BIRTHDAY");
		try {
        	//2 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            //3��������
            dt = DBTransaction.getInstance(conn);
            
    		//���������ļ���������aadata
            Data aadata = new Data();
            aadata.add("AA_ID", data.getString("AA_ID"));
            aadata.add("ADD_CONTENT_EN", data.getString("ADD_CONTENT_EN"));
            aadata.add("AA_STATUS", data.getString("AA_STATUS"));
            aadata.add("UPLOAD_IDS", data.getString("UPLOAD_IDS"));
            
            //�����ļ���Ϣ��������filedata
            Data filedata = new Data();
            filedata.add("AF_ID", data.getString("AF_ID"));
            filedata.add("AA_ID", data.getString("AA_ID"));
            filedata.add("SUPPLY_STATE", data.getString("AA_STATUS"));
            
            String clueMes = "";
            //������Ϊ�ύʱ��״ֵ̬��2��
    		String aa_state = data.getString("AA_STATUS");
    		if("2".equals(aa_state)){
    			UserInfo curuser = SessionInfo.getCurUser();
    			aadata.add("FEEDBACK_USERID", curuser.getPersonId());	//��ӷ�����ID
    			aadata.add("FEEDBACK_USERNAME", curuser.getPerson().getCName());	//��ӷ���������
    			aadata.add("FEEDBACK_ORGID", curuser.getCurOrgan().getOrgCode());	//��ӷ�������֯code
    			aadata.add("FEEDBACK_DATE", DateUtility.getCurrentDateTime());	//��ӷ�������
    			clueMes = "Submitted successfully!";
    			retValue = "submit";
    		}else{
    			clueMes = "Saved successfully!";
				retValue = "save";
    		}
    		
    		//ִ�в����ļ��������
            boolean success = false;
            success=handler.SuppleFileSave(conn,aadata,filedata);
            if (success) {
                InfoClueTo clueTo = new InfoClueTo(0, clueMes);
                setAttribute("clueTo", clueTo);
                //�жϸ����Ƿ��ϴ�
                String flag = getParameter("FLAG");
                if("true".equals(flag)){
                	AttHelper.publishAttsOfPackageId(data.getString("UPLOAD_IDS"), "AF");
                }
            }
            
            setAttribute("data", data);
            setAttribute("AA_ID", data.getString("AA_ID"));
            setAttribute("ORG_CODE", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
            dt.commit();
        } catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���Ϣ��������쳣");
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
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } catch (Exception e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ���������쳣:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��SuppleFileSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * @Title: SuppleFileShow 
	 * @Description: �ļ�������Ϣ�鿴/�޸Ĳ���
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String SuppleFileShow(){
		//�ж�����ӻ����޸Ĳ�����addΪ��Ӳ�����modΪ�޸Ĳ���
		String type = getParameter("type");
		//��ȡ�ļ���ϢID
		String af_id = getParameter("AF_ID");
		//�����ļ���ϢID����ȡ�ļ���ϸ��Ϣ
		Data data = this.GetFileByID(af_id);
		DataList dataList = new DataList();
		//�����ļ�����(file_type)����������(family_type)���жϷ��صĲ���ҳ��
		String file_type = data.getString("FILE_TYPE");	//�ļ�����
		String family_type = data.getString("FAMILY_TYPE");	//��������
		if("33".equals(file_type)){
			retValue = type + "step";
		}else{
			if("20".equals(file_type) || "21".equals(file_type) || "22".equals(file_type) || "23".equals(file_type)){
				try {
					conn = ConnectionManager.getConnection();
					//���ݶ�ͯ����id��ȡ��ͯ��Ϣ
					String ci_id = data.getString("CI_ID");
					dataList = handler.getChildDataList(conn, ci_id);
					
				}catch (DBException e) {
					// �����쳣����
					setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ��鿴�����쳣");
					setAttribute(Constants.ERROR_MSG, e);
					if (log.isError()) {
						log.logError("�����ļ��鿴�����쳣:" + e.getMessage(),e);
					}
					
					retValue = "error1";
					
				} finally {
					//�ر����ݿ�����
					if (conn != null) {
						try {
							if (!conn.isClosed()) {
								conn.close();
							}
						} catch (SQLException e) {
							if (log.isError()) {
								log.logError("FileManagerAction��SuppleFileShow.Connection������쳣��δ�ܹر�",e);
							}
							retValue = "error2";
						}
					}
				}
			}
			if("1".equals(family_type)){
				retValue = type + "double";
			}else{
				retValue = type + "single";
				String male_name = data.getString("MALE_NAME","");
				String female_name = data.getString("FEMALE_NAME","");
				if(male_name.equals("")){
					setAttribute("maleFlag", "false");
				}else{
					setAttribute("maleFlag", "true");
				}
				if(female_name.equals("")){
					setAttribute("femaleFlag", "false");
				}else{
					setAttribute("femaleFlag", "true");
				}
			}
		}
		
		setAttribute("AF_ID", af_id);
		setAttribute("ADOPT_ORG_ID", data.getString("ADOPT_ORG_ID",""));
		setAttribute("MALE_PUNISHMENT_FLAG", data.getString("MALE_PUNISHMENT_FLAG",""));
		setAttribute("MALE_ILLEGALACT_FLAG", data.getString("MALE_ILLEGALACT_FLAG",""));
		setAttribute("FEMALE_PUNISHMENT_FLAG", data.getString("FEMALE_PUNISHMENT_FLAG",""));
		setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG",""));
		setAttribute("FEMALE_ILLEGALACT_FLAG", data.getString("FEMALE_ILLEGALACT_FLAG",""));
		setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
		setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
		setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", af_id));
		setAttribute("xmlstr", data.getString("xmlstr"));
		
		setAttribute("data", data);
		setAttribute("List", dataList);
		return retValue;
	}
	
	/**
	 * @Title: BasicInfoSave 
	 * @Description: ���������˻�����Ϣ
	 * @author: yangrt;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public void BasicInfoSave(){
		//1 ���ҳ������ݣ��������ݽ����
		Data data = getRequestEntityData("R_","AF_ID","MALE_PHOTO","MALE_NATION","MALE_PASSPORT_NO","MALE_EDUCATION","MALE_JOB_EN",
				"MALE_HEALTH","IS_MEDICALRECOVERY","MALE_HEALTH_CONTENT_EN","MALE_HEIGHT","MALE_WEIGHT","MALE_BMI","MALE_PUNISHMENT_FLAG",
				"MALE_PUNISHMENT_EN","MALE_ILLEGALACT_FLAG","MALE_ILLEGALACT_EN","MALE_RELIGION_EN","MALE_MARRY_TIMES","MALE_YEAR_INCOME",
				"FEMALE_PHOTO","FEMALE_NATION","FEMALE_PASSPORT_NO","FEMALE_EDUCATION","FEMALE_JOB_EN","FEMALE_HEALTH","FEMALE_HEALTH_CONTENT_EN",
				"FEMALE_HEIGHT","FEMALE_WEIGHT","FEMALE_BMI","FEMALE_PUNISHMENT_FLAG","FEMALE_PUNISHMENT_EN","FEMALE_ILLEGALACT_FLAG",
				"FEMALE_ILLEGALACT_EN","FEMALE_RELIGION_EN","FEMALE_MARRY_TIMES","FEMALE_YEAR_INCOME","MARRY_CONDITION","MARRY_DATE",
				"CONABITA_PARTNERS","CONABITA_PARTNERS_TIME","GAY_STATEMENT","CURRENCY","TOTAL_ASSET","TOTAL_DEBT","CHILD_CONDITION_EN",
				"UNDERAGE_NUM","ADDRESS","ADOPT_REQUEST_EN");
		
		//���С�Ů����������ת��Ϊ��д
        if(!("".equals(data.getString("MALE_NAME"))) && data.getString("MALE_NAME")!=null){
        	data.put("MALE_NAME", data.getString("MALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("FEMALE_NAME")))&& data.getString("FEMALE_NAME")!=null){
        	data.put("FEMALE_NAME", data.getString("FEMALE_NAME").toUpperCase());
        }
        if(!("".equals(data.getString("ADDRESS"))) && data.getString("ADDRESS")!=null){
        	data.put("ADDRESS", data.getString("ADDRESS").toUpperCase());
        }
        //��ȡ�ļ���ԭ����
        Data olddata = this.GetFileByID(data.getString("AF_ID"));
        
		try {
			//2 ��ȡ���ݿ�����
	        conn = ConnectionManager.getConnection();
	        //3��������
	        dt = DBTransaction.getInstance(conn);
	        handler.NormalFileSave(conn, data);
	        //�����޸���ʷ��¼
	        ModifyHistoryHandler mhhandler = new ModifyHistoryHandler();
	        mhhandler.savehistory(conn, olddata, data, "FFS_AF_REVISE", "AR_ID", "AF_ID", data.getString("AF_ID"), "1");
	        
	    	AttHelper.publishAttsOfPackageId(data.getString("MALE_PHOTO"), "AF"); //��������������Ƭ
	    	AttHelper.publishAttsOfPackageId(data.getString("FEMALE_PHOTO"), "AF"); //����Ů��������Ƭ
	        
	        dt.commit();
	        
		} catch (DBException e) {
        	//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ļ���Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
        } catch (SQLException e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ�������Ϣ��������쳣:" + e.getMessage(),e);
            }
            
        } catch (Exception e) {
        	//5�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�������Ϣ��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�ļ�������Ϣ��������쳣:" + e.getMessage(),e);
            }
            
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction��BasicInfoSave.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                }
            }
        }
	}
	
	/**
	 * @Title: SuppleBatchSubmit 
	 * @Description: �����ļ���Ϣ�����ύ����
	 * @author: yangrt
	 * @return String
	 * @throws
	 */
	public String SuppleBatchSubmit(){
		//1 ��ȡҪ�ύ���ļ�ID
		String subuuid = getParameter("subuuid", "");
		String[] aa_id = subuuid.split("#");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			success = handler.SuppleBatchSubmit(conn, aa_id);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ύ�����ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����ύ�����ļ������쳣[�ύ����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: SuppleFileExport 
	 * @Description: �����ļ���Ϣ��������
	 * @author: yangrt
	 * @return String null
	 * @throws
	 */
	public String SuppleFileExport(){
		//1  ��ȡҳ�������ֶ�����
		Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","NOTICE_DATE_START","NOTICE_DATE_END","FILE_TYPE","FEEDBACK_DATE_START","FEEDBACK_DATE_END","AA_STATUS");
		String MALE_NAME = data.getString("MALE_NAME",null);	//��������
		if(MALE_NAME != null){
			MALE_NAME = MALE_NAME.toUpperCase();
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);	//Ů������
		if(FEMALE_NAME != null){
			FEMALE_NAME = FEMALE_NAME.toUpperCase();
		}
		String FILE_NO = data.getString("FILE_NO", null);	//���ı��
		String REGISTER_DATE_START = data.getString("REGISTER_DATE_START", null);	//���Ŀ�ʼ����
		String REGISTER_DATE_END = data.getString("REGISTER_DATE_END", null);	//���Ľ�������
		String NOTICE_DATE_START = data.getString("SUBMIT_DATE_START", null);	//֪ͨ��ʼ����
		String NOTICE_DATE_END = data.getString("SUBMIT_DATE_END", null);	//֪ͨ��������
		String FILE_TYPE = data.getString("FILE_TYPE", null);	//�ļ�����
		String FEEDBACK_DATE_START = data.getString("FEEDBACK_DATE_START", null);	//������ʼ����
		String FEEDBACK_DATE_END = data.getString("FEEDBACK_DATE_END", null);	//�����ֹ����
		String AA_STATUS = data.getString("AA_STATUS", null);	//�ļ�����״̬
		
		try {
			//2���õ����ļ�����
			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("�����ļ���Ϣ.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3��������ֶ� 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("WJLX");
    		//�ļ����ʹ���
			CodeList scList=codes.get("WJLX");
    		Map<String,String> filetype=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			filetype.put(c.getValue(),c.getName());
    		}
    		dict.put("FILE_TYPE", filetype);
    		//�ļ�����״̬����
			Map<String,String> state = new HashMap<String,String>();
			state.put("0", "������");
			state.put("1", "������");
			state.put("2", "�Ѳ���");
    		//4 ִ���ļ�����
			ExcelExporter.export2Stream("�����ļ���Ϣ", "SuppleFile", dict, this.getResponse().getOutputStream(),
					MALE_NAME, FEMALE_NAME, FILE_NO, REGISTER_DATE_START, REGISTER_DATE_END, NOTICE_DATE_START, NOTICE_DATE_END, FILE_TYPE, FEEDBACK_DATE_START, FEEDBACK_DATE_END, AA_STATUS);
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  �����쳣����
			log.logError("���������ļ������쳣", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "���������ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
		}
		//6 ҳ�治������ת������NULL ������ת����������ֵ
		return null;
	}
	
	/**
	 * @Title: FileProgressList 
	 * @Description: �ļ����ȼ��ɷѲ�ѯ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String FileProgressList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","FILE_NO","MALE_NAME","FEMALE_NAME","FILE_TYPE","CHILD_TYPE","PAID_NO","AF_COST_PAID","AF_COST","FEEDBACK_NUM","IS_PAUSE","AF_GLOBAL_STATE","IS_FINISH","REGISTER_DATE_START","REGISTER_DATE_END","ADVICE_NOTICE_DATE_START","ADVICE_NOTICE_DATE_END","SIGN_DATE_START","SIGN_DATE_END","ADREG_DATE_START","ADREG_DATE_END");
												
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.FileProgressList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ����ȼ��ɷ���Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�ļ����ȼ��ɷ���Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��FileProgressList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: FileProgressShow 
	 * @Description: �ļ�������ȼ��ɷ���Ϣ�鿴 
	 * @author: yangrt
	 * @return String 
	 */
	public String FileProgressShow(){
		//��ȡ�ļ���ϢID
		String af_id = getParameter("AF_ID");
		//�����ļ���ϢID,��ȡ�ļ���Ϣ
		Data filedata = this.GetFileByID(af_id);
		//Ԥ��������ϢID
		String ri_id = filedata.getString("RI_ID","");
		if("".equals(ri_id)){
			setAttribute("riTab", "false");
		}else{
			setAttribute("riTab", "true");
		}
		//Ԥ����ͯ��ϢID
		String ci_id = filedata.getString("CI_ID","");
		if("".equals(ci_id)){
			setAttribute("ciTab", "false");
		}else{
			setAttribute("ciTab", "true");
		}
		setAttribute("data", filedata);
		setAttribute("AF_ID", af_id);
		/*try {
			conn = ConnectionManager.getConnection();
			//����Ԥ����ϢID,��ȡԤ����ϢDataList
			DataList ridatalist = new DataList();
			String str_ri = "'";
			if(!ri_id.equals("")){
				if(ri_id.contains(",")){
					for(int i = 0; i < ri_id.split(",").length; i++){
						str_ri += ri_id.split(",")[i] + "',";
					}
				}else{
					str_ri += ri_id + "',";
				}
				ridatalist = handler.getReqDataList(conn, str_ri.substring(0, str_ri.lastIndexOf(",")));
				
			}else{
				setAttribute("riFlag","false");
			}
			
			//���ݶ�ͯ��ϢID,��ȡԤ����ͯ��ϢDataList
			DataList cidatalist = new DataList();
			if(!ci_id.equals("")){
				cidatalist = handler.getChildDataList(conn, ci_id);
				
			}else{
				setAttribute("ciFlag","false");
			}
			
			setAttribute("data", filedata);
			setAttribute("MALE_PHOTO", filedata.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", filedata.getString("FEMALE_PHOTO",""));
			setAttribute("riList", ridatalist);
			setAttribute("ciList", cidatalist);
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ����Ȳ鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�ļ����Ȳ鿴����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��FileProgressShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }*/
		return retValue;
	}
	
	public String getReqDataList(){
		String ri_id = getParameter("RI_ID");
		try {
			conn = ConnectionManager.getConnection();
			//����Ԥ����ϢID,��ȡԤ����ϢDataList
			DataList ridatalist = new DataList();
			String str_ri = "'";
			if(ri_id.contains(",")){
				for(int i = 0; i < ri_id.split(",").length; i++){
					str_ri += ri_id.split(",")[i] + "',";
				}
			}else{
				str_ri += ri_id + "',";
			}
			ridatalist = handler.getReqDataList(conn, str_ri.substring(0, str_ri.lastIndexOf(",")));
				
			setAttribute("riList", ridatalist);
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ����Ȳ鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�ļ����Ȳ鿴����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��FileProgressShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/************** �����ļ�����End ***************/
	
	
	
	/************** �ɷ���Ϣ����Start ***************/
	
	/**
	 * @Title: PaymentList 
	 * @Description: �ɷ���Ϣ��ѯ�б�
	 * @author: yangrt;
	 * @return String    �������� 
	 * @throws
	 */
	public String PaymentList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAR_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_VALUE","ARRIVE_STATE","ARRIVE_ACCOUNT_VALUE","FILE_NO");
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.PaymentList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ɷ���Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�ɷ���Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��PaymentList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: PaymentShow 
	 * @Description: �ɷ���Ϣ��������Ϣ�鿴
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentShow(){
		//��ȡ�ɷ���Ϣ��ϢID
		String cheque_id = getParameter("CHEQUE_ID");
		try {
			conn = ConnectionManager.getConnection();
			//���ݽɷ���ϢID,��ȡ�ɷ���ϢData
			Data data = handler.getPaymentData(conn, cheque_id);
			//��ȡ��ɷ���Ϣ��ص�������Ϣ
			DataList dl = new DataList();
			String str_file_no = data.getString("FILE_NO","");
			if(str_file_no.contains(",")){
				String[] file_no = str_file_no.split(",");
				for(int i = 0; i < file_no.length; i++){
					Data filedata = handler.getSpecialFileData(conn, file_no[i]);
					dl.add(filedata);
				}
			}else{
				Data filedata = handler.getSpecialFileData(conn, str_file_no);
				dl.add(filedata);
			}
			setAttribute("data", data);
			setAttribute("List", dl);
			setAttribute("FILE_CODE", data.getString("FILE_CODE",cheque_id));
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ɷ���Ϣ��������Ϣ�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�ɷ���Ϣ��������Ϣ�鿴����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��PaymentShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: PaymentExport 
	 * @Description: �ɷ���Ϣ����
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentExport(){
		//1  ��ȡҳ�������ֶ�����
		Data data = getRequestEntityData("S_","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAR_VALUE","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_VALUE","ARRIVE_STATE","ARRIVE_ACCOUNT_VALUE","FILE_NO");
		
		String PAID_NO = data.getString("PAID_NO", null);	//�ɷѱ��
		String COST_TYPE = data.getString("COST_TYPE", null);	//�ɷ�����
		String PAID_SHOULD_NUM = data.getString("PAID_SHOULD_NUM", null);	//Ӧ�ɽ��
		String PAR_VALUE = data.getString("PAR_VALUE", null);	//Ʊ����
		String ARRIVE_DATE_START = data.getString("ARRIVE_DATE_START", null);	//������ʼ����
		String ARRIVE_DATE_END = data.getString("ARRIVE_DATE_END", null);	//���˽�ֹ����
		String ARRIVE_VALUE = data.getString("SUBMIT_DATE_END", null);	//���˽��
		String ARRIVE_STATE = data.getString("FILE_TYPE", null);	//����״̬
		String ARRIVE_ACCOUNT_VALUE = data.getString("FEEDBACK_DATE_START", null);	//�����˺�ʹ�ý��
		String FILE_NO = data.getString("FEEDBACK_DATE_END", null);	//���ı��
		
		try {
			//2���õ����ļ�����
			this.getResponse().setHeader("Content-Disposition","attachment;filename=" + new String("�ɷ���Ϣ.xls".getBytes(), "iso8859-1"));
    		this.getResponse().setContentType("application/xls");
    		//3��������ֶ� 
    		Map<String,Map<String,String>> dict=new HashMap<String,Map<String,String>>();
			Map<String, CodeList> codes = UtilCode.getCodeLists("FYLB");
			//�ɷ����ʹ���
    		CodeList scList=codes.get("FYLB");
    		Map<String,String> costtype=new HashMap<String,String>();
    		for(int i=0;i<scList.size();i++){
    			Code c=scList.get(i);
    			costtype.put(c.getValue(),c.getName());
    		}
    		dict.put("COST_TYPE", costtype);
    		//����״̬����
    		Map<String,String> state = new HashMap<String,String>();
    		state.put("0", "��ȷ��");
    		state.put("1", "���");
    		state.put("2", "����");
    		dict.put("ARRIVE_STATE", state);
    		//4 ִ���ļ�����
			ExcelExporter.export2Stream("�ɷ���Ϣ", "PaymentData", dict, this.getResponse().getOutputStream(),
					PAID_NO,COST_TYPE,PAID_SHOULD_NUM,PAR_VALUE,ARRIVE_DATE_START,ARRIVE_DATE_END,ARRIVE_VALUE,ARRIVE_STATE,ARRIVE_ACCOUNT_VALUE,FILE_NO);
			this.getResponse().getOutputStream().flush();
		} catch (Exception e) {
			//5  �����쳣����
			log.logError("�����ɷ���Ϣ�����쳣", e);
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ɷ���Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
		}
		return null;
	}
	
	/**
	 * @Title: PaymentNoticeList 
	 * @Description: �ɷ�֪ͨ��Ϣ��ѯ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentNoticeList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
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
		Data data = getRequestEntityData("S_","PAID_NO","COST_TYPE","CHILD_NUM","S_CHILD_NUM","PAID_SHOULD_NUM","NOTICE_DATE_START","NOTICE_DATE_END","ARRIVE_DATE_START","ARRIVE_DATE_END","ARRIVE_VALUE");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.PaymentNoticeList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ɷ�֪ͨ��Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�ɷ�֪ͨ��Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��PaymenNoticetList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}
	
	/**
	 * @Title: PaymentNoticeShow 
	 * @Description: �߽�֪ͨ��Ϣ�б�
	 * @author: yangrt
	 * @return String 
	 */
	public String PaymentNoticeShow(){
		//��ȡ�߽ɼ�¼ID
		String rm_id = getParameter("RM_ID");
		try {
			conn = ConnectionManager.getConnection();
			//���ݽɷ���ϢID,��ȡ�ɷ���ϢData
			Data data = handler.getPaymentNoticeData(conn, rm_id);
			setAttribute("UPLOAD_ID",data.getString("UPLOAD_ID",""));
			setAttribute("data", data);
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�߽�֪ͨ��Ϣ�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�߽�֪ͨ��Ϣ�鿴����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��PaymentNoticeShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: AccountBalanceList 
	 * @Description: �����˻���Ϣ�б�
	 * @author: yangrt
	 * @return String
	 */
	public String AccountBalanceList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="OPP_DATE";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 ��ȡ��������
		Data data = getRequestEntityData("S_","PAID_NO","OPP_TYPE","SUM","OPP_USERNAME","OPP_DATE_START","OPP_DATE_END");
		String OPP_USERNAME = data.getString("OPP_USERNAME","");
		if(!OPP_USERNAME.equals("")){
			data.put("OPP_USERNAME", OPP_USERNAME.toUpperCase());
		}
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.AccountBalanceList(conn,data,pageSize,page,compositor,ordertype);
			String orgid = SessionInfo.getCurUser().getCurOrgan().getId(); 
			Data accountData = handler.getAdoptOrgInfo(conn, orgid);
			data.add("ADOPT_ORG_NAME",accountData.getString("NAME_EN",""));
			data.add("ACCOUNT_CURR",accountData.getString("ACCOUNT_CURR",""));
			data.add("ACCOUNT_LMT",accountData.getString("ACCOUNT_LMT",""));
			
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("searchData",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
			
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����˻���Ϣ��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����˻���Ϣ��ѯ�����쳣:" + e.getMessage(),e);
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
						log.logError("FileManagerAction��AccountBalanceList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	
	/**
	 * @Title: AccountBalanceShow 
	 * @Description: �����˻���Ϣ�鿴
	 * @author: yangrt
	 * @return String 
	 */
	public String AccountBalanceShow(){
		//��ȡ�����˻�ʹ�ü�¼ID
		String account_log_id = getParameter("ACCOUNT_LOG_ID");
		try {
			conn = ConnectionManager.getConnection();
			//���ݽɷ���ϢID,��ȡ�ɷ���ϢData
			Data data = handler.getAccountBalanceData(conn, account_log_id);
			setAttribute("data", data);
		} catch (DBException e) {
			//4�����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ɷѵ���Ϣ�鿴�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
            if (log.isError()) {
                log.logError("�����쳣[�ɷѵ���Ϣ�鿴����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��AccountBalanceShow.Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                    
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/************** �ɷ���Ϣ����End ***************/
	
	
	/************** �ļ�������������Start ***************/
	
	/**
	 * @Title: FileDelete 
	 * @Description: ɾ��δ�Ǽǵ��ļ���Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String FileDelete() {
		//1 ��ȡҪɾ�����ļ�ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		retValue = getParameter("type");	//��ͨ�������ļ���ʾ
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡɾ�����
			success = handler.FileDelete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Deleted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ�ɾ�������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[ɾ������]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * @Title: FileBatchSubmit 
	 * @Description: �����ύ�ļ���Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String FileBatchSubmit() {
		//1 ��ȡҪ�ύ���ļ�ID
		String subuuid = getParameter("subuuid", "");
		String[] uuid = subuuid.split("#");
		retValue = getParameter("type");	//��ͨ�������ļ���ʾ
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡ�ύ��������ݽ��
			success = handler.FileBatchSubmit(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "Submitted successfully!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ύ�ļ������쳣");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣[�ύ����]:" + e.getMessage(),e);
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
                        log.logError("FileManagerAction��Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * ��ˮ�Ŵ�ӡ
	 * @author Panfeng
	 * @date 2014-7-24
	 * @return
	 */
	public String seqNoPrint(){
		//1 �б�ҳ��ȡ��ϢID
		String printuuid = getParameter("printuuid", "");
		String[] uuid = printuuid.split(",");
		String printId = "";
		retValue = getParameter("type");	//��ͨ�������ļ���ʾ
		StringBuffer stringb = new StringBuffer();
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			printId = stringb.substring(0, stringb.length() - 1);
			DataList printShow = handler.getShowData(conn, printId, retValue);
			//4 ��������ҳ��
			setAttribute("printShow", printShow);
		} catch (DBException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}finally {
			//5 �ر����ݿ�����
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
	 * @Title: GetFileByID 
	 * @Description: �����ļ�id��ȡ�ļ�����ϸ��Ϣ
	 * @author: yangrt;
	 * @param FileID
	 * @return    �趨�ļ� 
	 * @return Data    �������� 
	 * @throws
	 */
	public Data GetFileByID(String FileID){
		Data data = new Data();
		try {
			//1 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//2 ��ȡ���ݽ����Data
			data = handler.GetFileByID(conn,FileID);
			
			/*����ת������������ת��Ϊ��Ԫչʾ��begin*/
			Data currencyData = new Data();
			currencyData.add("CURRENCY", data.getString("CURRENCY",""));
			currencyData.add("MALE_YEAR_INCOME", data.getString("MALE_YEAR_INCOME",""));
			currencyData.add("FEMALE_YEAR_INCOME", data.getString("FEMALE_YEAR_INCOME",""));
			currencyData.add("TOTAL_ASSET", data.getString("TOTAL_ASSET",""));
			currencyData.add("TOTAL_DEBT", data.getString("TOTAL_DEBT",""));
			
			currencyData = new CurrencyConverterAction().USDToOther(conn, currencyData);
			data.add("MALE_YEAR_INCOME", currencyData.getString("MALE_YEAR_INCOME",""));
			data.add("FEMALE_YEAR_INCOME", currencyData.getString("FEMALE_YEAR_INCOME",""));
			data.add("TOTAL_ASSET", currencyData.getString("TOTAL_ASSET",""));
			data.add("TOTAL_DEBT", currencyData.getString("TOTAL_DEBT",""));
			/*����ת������������ת��Ϊ��Ԫչʾ��end*/
			
			String file_type = data.getString("FILE_TYPE","");
			String family_type = data.getString("FAMILY_TYPE","");
			FfsAfTranslationAction action  = new  FfsAfTranslationAction();
			//parents	˫�� singleparent ���� stepchild ����Ů		 
			String formType = action.getFormType(family_type, file_type);
			String xmlstr = action.getFileUploadParameter(conn,formType);
			data.add("xmlstr", xmlstr);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡ�ļ���ϸ��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡ�ļ���ϸ��Ϣ�����쳣:" + e.getMessage(),e);
			}
			
		} catch (Exception e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡ�ļ���ϸ��Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("��ȡ�ļ���ϸ��Ϣ�����쳣:" + e.getMessage(),e);
			}
		} finally {
			//8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FileManagerAction��GetNormalFileByID.Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		
		return data;
	}
	
	/**
	 * @Title: getMKRORGCOAList 
	 * @Description: ��ȡ������Լ��֤��������
	 * @author: yangrt;
	 * @return    ������Լ��֤�������ƵĴ��뼯
	 * @return CodeList    �������� 
	 * @throws
	 */
	public CodeList getMKRORGCOAList(){
    	CodeList codelist = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            //��ȡ������Լ��֤������Ϣ
            DataList orglist = handler.getMKRORGCOAList(conn);
            //����������Լ��֤�������ƴ��뼯
            for(int i = 0; i < orglist.size(); i++){
            	Code code = new Code();
            	
            	code.setName(orglist.getData(i).getString("NAME"));
            	code.setValue(orglist.getData(i).getString("NAME"));
            	code.setRem(orglist.getData(i).getString("NAME"));
            	codelist.add(code);
            }
            
            //���"����"ѡ��
            Code code = new Code();
        	code.setName("Other");
        	code.setValue("Other");
        	code.setRem("Other");
        	codelist.add(code);
            
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣[������Լ��֤�������ƴ��뼯����]:" + e.getMessage(),e);
            }
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction��getMKRORGCOAList��Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
		return codelist;
    }
	
	public String GetAdoptionPersonInfo(){
		//1 ��ȡ�ļ�id
		String file_id = getParameter("AF_ID");
		String flag = getParameter("Flag");	//�ж���Ӣ����ʾ
		String type = getParameter("type");	//�ж�����ӣ������޸Ĳ���
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//�����ļ�id(file_id)��ȡ���ļ�����ϸ��Ϣ
			Data data = handler.GetFileByID(conn, file_id);
		
			String file_type = data.getString("FILE_TYPE");	//�ļ�����
			String family_type = data.getString("FAMILY_TYPE");	//��������
			//�����ļ�����(file_type)����������(family_type)ȷ�����ص�ҳ��
			if("33".equals(file_type)){
				retValue = "step" + flag + type;	//���ؼ���Ů�����鿴ҳ��
			}else{
				if("1".equals(family_type)){
					retValue = "double" + flag + type;	//����˫�������鿴ҳ��
				}else{
					retValue = "single" + flag + type;	//���ص��������鿴ҳ��
				}
			}
			setAttribute("data", data);
			setAttribute("MALE_PHOTO", data.getString("MALE_PHOTO",""));
			setAttribute("FEMALE_PHOTO", data.getString("FEMALE_PHOTO",""));
			setAttribute("PACKAGE_ID", data.getString("PACKAGE_ID", file_id));
		}catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡ�ļ���Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[��ȡ�ļ���Ϣ����]:" + e.getMessage(),e);
            }
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
                        log.logError("FileManagerAction��GetAdoptionPersonInfo.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		
		return retValue;
	}
	
	/************** �ļ�������������End ***************/
	/**
	 * ��ȡ�ļ�����
	 * ����˵����
	 * AF_ID���ļ�ID
	 * show����ʾ���
	 * 				cn Ϊ ������Ϣ
	 * 				en Ϊ ԭ��
	 * oper���������
	 * 				viewΪ��ʾ�������޸�
	 * 				editΪ�༭�����޸�
	 */
	public String GetFileInfo(){
		
		//1����ȡ����
		//1.1�ļ�ID
		String AF_ID = getParameter("AF_ID");
		//1.2��ʾ���Ĭ��Ϊ�����
		String show=getParameter("show","cn");
		//1.3�������Ĭ��Ϊ��ʾ
		String oper=getParameter("oper","view");
		
		//2�������ļ�ID��ȡ�ļ���Ϣ
		Data fileData = this.GetFileByID(AF_ID);
		setAttribute("xmlstr", fileData.getString("xmlstr"));
		//2.1���üҵ���֯�б�����ҵ���֯���Ʋ��������У�����ʾΪOther
		CodeList coaList = this.getMKRORGCOAList();
		String HOMESTUDY_ORG_NAME = fileData.getString("HOMESTUDY_ORG_NAME","");
		String HOMESTUDY_ORG = HOMESTUDY_ORG_NAME;
		if(!"".equals(HOMESTUDY_ORG_NAME) && coaList.getCodeByValue(HOMESTUDY_ORG_NAME)==null){
			HOMESTUDY_ORG = coaList.getCodeByValue("Other").getValue();
		}
		fileData.put("HOMESTUDY_ORG", HOMESTUDY_ORG);		
		
		FfsAfTranslationAction action  = new  FfsAfTranslationAction();

		//3�������ļ����͡��������͡���ʾ��𡢲�����𣬻�ȡҳ����ת���
		//parents	˫�� singleparent ���� stepchild ����Ů		 
		String formType = action.getFormType(fileData.getString("FAMILY_TYPE"), fileData.getString("FILE_TYPE"));
		retValue = formType + "_" + show +"_" + oper;		
		try {
			conn = ConnectionManager.getConnection();
			String xmlstr = action.getFileUploadParameter(conn,formType);
			setAttribute("xmlstr", xmlstr);
			setAttribute("data", fileData);
			
			//����������Լ��֤�������ƴ��뼯
			HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
	    	cmap.put("ORGCOA_LIST", coaList);
	    	setAttribute(Constants.CODE_LIST, cmap);
			
		} catch (Exception e) {
			//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��ȡ�ļ���Ϣ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
            if (log.isError()) {
                log.logError("�����쳣[��ȡ�ļ���Ϣ����]:" + e.getMessage(),e);
            }            
            retValue = "error1";
		}finally {
        	//5 �ر����ݿ�
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("FileManagerAction��GetAdoptionPersonInfo.Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
}
