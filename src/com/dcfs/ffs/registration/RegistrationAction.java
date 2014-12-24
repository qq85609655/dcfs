/**   
 * @Title: RegistrationAction.java 
 * @Package com.dcfs.ffs.registration 
 * @Description: TODO(��һ�仰�������ļ���ʲô) 
 * @author songhn   
 * @date 2014-7-14 ����3:00:34 
 * @version V1.0   
 */
package com.dcfs.ffs.registration;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonConstant;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonManagerHandler;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ffs.registration.RegistrationHandler;

import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;





import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.hx.util.UUID;

/** 
 * @ClassName: RegistrationAction 
 * @Description: �����Ǽ�Action 
 * @author Mayun 
 * @date 2014-7-15
 *  
 */
public class RegistrationAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(RegistrationAction.class);

    private RegistrationHandler handler;
    private FileCommonManagerHandler fileCommonHandler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public RegistrationAction(){
        this.handler=new RegistrationHandler();
        this.fileCommonHandler=new FileCommonManagerHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * ��ת���ļ��ֹ��Ǽ�ҳ��
	 * @author Panfeng
	 * @date 2014-8-7
	 * @return
	 */
	public String FileHandReg(){
		//1 �б�ҳ��ȡ��ϢID
		String reguuid = getParameter("reguuid", "");
		String[] uuid = reguuid.split(",");
		String regId = "";
		StringBuffer stringb = new StringBuffer();
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			//int sum = (uuid.length)*800;
			//String paidNum = String.valueOf(sum); 
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
			regId = stringb.substring(0, stringb.length() - 1);
			DataList HandRegList = handler.FileHandReg(conn, regId);
		   
			
			
			/*******Ӧ�ɷ���begin*********/
			String zcCost = fileCommonHandler.getAfCost(conn, "ZCWJFWF").getString("VALUE1");//�����ļ�Ӧ�ɷ���
			String txCost = fileCommonHandler.getAfCost(conn, "TXWJFWF").getString("VALUE1");//�����ļ�Ӧ�ɷ���
			int zcCostInt =0;
			int txCostInt =0;
			int totalPaidNum = 0;
			int len = HandRegList.size();
			DataList dataList = new DataList();
			for(int i=0;i<len;i++){
				Data data = (Data)HandRegList.get(i);
				String file_type = data.getString("FILE_TYPE");
				String ci_id = data.getString("CI_ID");
				
				if(!"20".equals(file_type)&&"20"!=file_type&&!"21".equals(file_type)&&"21"!=file_type&&!"22".equals(file_type)&&"22"!=file_type&&!"23".equals(file_type)&&"23"!=file_type){
					zcCostInt = Integer.parseInt(zcCost);
					data.add("AF_COST", Integer.toString(zcCostInt));
					totalPaidNum+=zcCostInt;
				}else{//�����ļ�Ӧ�ɷ���
					int txnum =ci_id.split(",").length;
					txCostInt = txnum*Integer.parseInt(txCost);
					data.add("AF_COST", Integer.toString(txCostInt));
					totalPaidNum+=txCostInt;
				}
				dataList.add(data);
			}
			
			
			/*******Ӧ�ɷ���end*********/
			
			
			//4 ��������ҳ��
			setAttribute("List", dataList);
			setAttribute("AF_ID", reguuid);
			setAttribute("paidNum", Integer.toString(totalPaidNum));
			setAttribute("CHEQUE_ID", UUID.getUUID());
			setAttribute("ADOPT_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
		} catch (DBException e) {
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
				}
			}
		}
		return SUCCESS;
	}
	
	/**
	 * ��ת���ļ���¼¼��ҳ��
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 */
	public String toAddFlieRecord(){
		setAttribute("CHEQUE_ID", UUID.getUUID());
		setAttribute("ADOPT_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
		Data wjdlData = getRequestEntityData("P_","FILE_TYPE","FAMILY_TYPE","FAMILY_TYPE_VIEW","ADOPTER_SEX","ADOPTER_SEX_VIEW");
		wjdlData.add("FILE_TYPE_VIEW", wjdlData.get("FILE_TYPE"));
		wjdlData.add("FAMILY_TYPE_VIEW2", wjdlData.get("FAMILY_TYPE_VIEW"));
		wjdlData.add("ADOPTER_SEX_VIEW2", wjdlData.get("ADOPTER_SEX_VIEW"));
		setAttribute("wjdlData", wjdlData);
		
		return SUCCESS;
	}
	
	/**
	 * ��ת���ļ���¼¼���ļ����ͺ���������ѡ��ҳ��
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 */
	public String toAddFlieRecordChoise(){
		setAttribute("wjdlData", new Data());
		return SUCCESS;
	}
	
	/**
	 * ��ת���ļ�ת��֯ѡ��ҳ��
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 */
	public String toChoseFile(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor=null;
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype=null;
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","COUNTRY_CODE","ADOPT_ORG_ID","REGISTER_DATE_START","REGISTER_DATE_END","FILE_NO","MALE_NAME","FEMALE_NAME");
		String MALE_NAME = data.getString("MALE_NAME");
		if(null != MALE_NAME){
			data.add("MALE_NAME", MALE_NAME.toLowerCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME");
		if(null != FEMALE_NAME){
			data.add("FEMALE_NAME", FEMALE_NAME.toLowerCase());
		}
		
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.choseFileFindList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "ԭ���ı�Ų�ѯ�����쳣");
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
						log.logError("RegistrationAction��findList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}

	/**
	 * ��ת�������ļ���¼ҳ��
	 * @author panfeng
	 * @date 2014-8-5
	 * @return
	 */
	public String batchAddFlieRecord(){
		setAttribute("CHEQUE_ID", UUID.getUUID());
		setAttribute("ADOPT_ORG_ID", SessionInfo.getCurUser().getCurOrgan().getOrgCode());
		
		return SUCCESS;
	}
	
	/**
	 * @Title:saveFileRecord
	 * @Description:�����ļ���¼
	 * @author Mayun
	 * @date 2014-7-15
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String saveFlieRecord() throws IOException{
		
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
	 	String curDate = DateUtility.getCurrentDate();
        
        //2 ���ҳ������ݣ��������ݽ����
        Data fileData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CN","COUNTRY_EN","FILE_TYPE","MALE_NAME","MALE_BIRTHDAY","FAMILY_TYPE","FEMALE_NAME","FEMALE_BIRTHDAY","REG_REMARK","ORIGINAL_FILE_NO","ADOPTER_SEX","AF_COST");
        Data billData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","FILE_CODE","ISPIAOJUVALUE");

        fileData.add("REG_USERID", personId);//�ļ��Ǽ���ID
        fileData.add("REG_USERNAME", personName);//�ļ��Ǽ�������
        fileData.add("REG_DATE", curDate);//�ļ��Ǽ�����
        fileData.add("REGISTER_DATE", curDate);//��������
        fileData.add("REG_STATE", FileCommonConstant.DJZT_YDJ);//�Ǽ�״̬Ϊ�ѵǼ�
        fileData.add("AF_COST_CLEAR", "0");//���״̬Ϊδ���
        fileData.add("AF_COST_CLEAR_FLAG", "0");//���ά����ʶΪ��
        fileData.add("AF_POSITION", deptId);//�ļ�λ��
        fileData.add("AF_GLOBAL_STATE", "03");//ȫ��״̬
        fileData.add("CREATE_USERID", personId);//������ID
        fileData.add("CREATE_DATE", curDate);//��������
        String MALE_NAME = fileData.getString("MALE_NAME");
        if(!"".equals(MALE_NAME)&&null!=MALE_NAME){
        	MALE_NAME = MALE_NAME.toUpperCase();
        }
        String FEMALE_NAME = fileData.getString("FEMALE_NAME");
        if(!"".equals(FEMALE_NAME)&&null!=FEMALE_NAME){
        	FEMALE_NAME = FEMALE_NAME.toUpperCase();
        }
        fileData.removeData("MALE_NAME");
        fileData.removeData("FEMALE_NAME");
        fileData.add("MALE_NAME", MALE_NAME);
        fileData.add("FEMALE_NAME", FEMALE_NAME);
        
        billData.add("REG_USERID", personId);//Ʊ��¼����ID
        billData.add("REG_USERNAME", personName);//Ʊ��¼��������
        billData.add("REG_ORGID", deptId);//Ʊ��¼�������ڲ���ID
        billData.add("REG_DATE", curDate);//Ʊ��¼������
        
        billData.add("CHEQUE_TRANSFER_STATE", "0");//Ʊ���ƽ�״̬��ʼ��Ϊ��δ�ύ��
        
        try {
        	
        	//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 ִ�����ݿ⴦�����
            FileCommonManager fileCommonManager = new FileCommonManager();
            String fileSeqNo = fileCommonManager.createFileSeqNO(conn);//�����ļ���ˮ��
            String countryCode = (String)fileData.get("COUNTRY_CODE");//���Ҵ���
            String adoptOrgId = (String)fileData.get("ADOPT_ORG_ID");//��֯��������
            String costType = (String)billData.get("COST_TYPE");//�������
            String fileNo = "";//���ı��
            
            DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, adoptOrgId);
            String  syzzCnName = syzzDept.getSyzzCnName();//������֯��������
            String  syzzEnName = syzzDept.getSyzzEnName();//������֯Ӣ������
            String  countryCnName = syzzDept.getCountryCnName();//����������������
            String  countryEnName = syzzDept.getCountryEnName();//��������Ӣ������
            String isGy = fileCommonManager.getISGY(conn, fileData.getString("FILE_TYPE"), countryCode);//�Ƿ�Լ����
            
            
            fileData.add("NAME_CN", syzzCnName);
            fileData.add("NAME_EN", syzzEnName);
            fileData.add("COUNTRY_CN", countryCnName);
            fileData.add("COUNTRY_EN", countryEnName);
            fileData.add("IS_CONVENTION_ADOPT", isGy);
            
            billData.add("NAME_CN",syzzCnName );
            billData.add("NAME_EN",syzzEnName );
            
            if(null!=countryCode&&!"".equals(countryCode)){
            	 fileNo = fileCommonManager.createFileNO(conn,countryCode);//�������ı��
            }
            String isPJ = billData.getString("ISPIAOJUVALUE");//�Ƿ�¼��Ʊ����Ϣ��0����   1����
            if(isPJ=="1"||isPJ.equals("1")){
            	String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//���ɽɷѱ��
            	billData.add("PAID_NO", paidNo);
            	fileData.add("PAID_NO", paidNo);
            	//fileData.add("AF_COST_PAID", "1");//�ɷ�״̬Ϊ���ѽɷѡ�
            }
            /*if(isPJ=="0"||isPJ.equals("0")){
                fileData.add("AF_COST_PAID", "0");//�ɷ�״̬Ϊ��δ�ɷѡ�
            }*/
            fileData.add("AF_COST_PAID", "0");//�ɷ�״̬Ϊ��δ�ɷѡ�
            
            fileData.add("AF_SEQ_NO", fileSeqNo);
            fileData.add("FILE_NO", fileNo);
            billData.add("FILE_NO", fileNo);
            
            //******��ʽһ����ȡ�ļ�ȫ��״̬���ļ�λ�ã�������begin*****//*
            FileCommonStatusAndPositionManager fileStatusManager = new FileCommonStatusAndPositionManager();//�ļ�ȫ��״̬��λ�ù�����
            Data globalStatusAndPositionData = fileStatusManager.getNextGlobalAndPosition(FileOperationConstant.BGS_REGISTRATION_DL_SUBMIT);//����ļ�ȫ��״̬��λ��
            String globalState = (String)globalStatusAndPositionData.get("AF_GLOBAL_STATE");//�ļ�ȫ��״̬
            String position = (String)globalStatusAndPositionData.get("AF_POSITION");//�ļ�λ��
            fileData.add("AF_GLOBAL_STATE", globalState);
            fileData.add("AF_POSITION", position);
            //******��ʽһ����ȡ�ļ�ȫ��״̬���ļ�λ���Լ��ļ�״̬��������֯����������end*****//*
            
            //******��ʽ����ֱ�Ӹ����ļ�ȫ��״̬���ļ�λ��begin*****//*
           // fileStatusManager.updateNextGlobalStatusAndPositon(conn,FileOperationConstant.GERNERATION_SUBMIT, "", fileNo);
            //******��ʽ����ֱ�Ӹ����ļ�ȫ��״̬���ļ�λ��end******//*
            
            DataList dataList = handler.saveFlieRecord(conn,fileData,billData);//����ҵ������
            
            String packageId = billData.getString("FILE_CODE");//�������ɷ�ƾ֤��
            AttHelper.publishAttsOfPackageId(packageId, "OTHER");//��������
            
            DataList tranferDataList = new DataList();
            DataList tranferDataList2 = new DataList();
            
            if(dataList.size()>0){//�Ǽǳɹ���
            	//��ʼ���ļ��ƽ���Ϣ
            	Data data = (Data)dataList.get(0);
            	String afId = data.getString("AF_ID");
            	Data dataTemp = new Data();
            	dataTemp.add("APP_ID", afId);
            	dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
            	dataTemp.add("TRANSFER_STATE", "0");
            	tranferDataList.add(dataTemp);
            	fileCommonManager.transferDetailInit(conn, tranferDataList);
            }
            if(dataList.size()>1){//��Ʊ����Ϣ���򱣴�Ʊ����Ϣ
            	//��ʼ���ɷѵ��ƽ���Ϣ
            	Data pjyjData =(Data)dataList.get(1);
            	Data dataTemp2 = new Data();
            	String cheque_id = pjyjData.getString("CHEQUE_ID");
            	dataTemp2.add("APP_ID", cheque_id);
            	dataTemp2.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
            	dataTemp2.add("TRANSFER_STATE", "0");
            	tranferDataList2.add(dataTemp2);
            	fileCommonManager.transferDetailInit(conn, tranferDataList2);
            }
            
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 �����쳣����
        	try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��Ǽǲ�ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            
            //6 �������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch(Exception e){
        	 try {
                 dt.rollback();
             } catch (SQLException e1) {
                 e1.printStackTrace();
             }
             if (log.isError()) {
                 log.logError("�����쳣:" + e.getMessage(),e);
             }
             InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
             setAttribute("clueTo", clueTo);
             retValue = "error2";
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("RegistrationAction��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * @Title:saveBatchFlieRecord
	 * @Description:�ļ�������¼
	 * @author panfeng
	 * @date 2014-8-5
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String saveBatchFlieRecord() throws IOException{
		
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
		String personName = SessionInfo.getCurUser().getPerson().getCName();
		String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDate();
		
		//2 ���ҳ������ݣ��������ݽ����
		
		
		// Start---------��ȡ������Ϣ------------
		Data fileData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CN","COUNTRY_EN","FAMILY_TYPE","ORIGINAL_FILE_NO","AF_COST");
		Data billData = getRequestEntityData("P_","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","FILE_CODE","ISPIAOJUVALUE");
		// End---------��ȡ������Ϣ------------
//		String afCost = (String)billData.get("PAID_SHOULD_NUM");//Ӧ�ɷ���
		
		billData.add("REG_USERID", personId);//Ʊ��¼����ID
		billData.add("REG_USERNAME", personName);//Ʊ��¼��������
		billData.add("REG_ORGID", deptId);//Ʊ��¼�������ڲ���ID
		billData.add("REG_DATE", curDate);//Ʊ��¼������
		
		billData.add("CHEQUE_TRANSFER_STATE", "0");//Ʊ���ƽ�״̬��ʼ��Ϊ��δ�ύ��
		
		try {
			
			//3 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//4 ִ�����ݿ⴦�����
			FileCommonManager fileCommonManager = new FileCommonManager();
			String countryCode = (String)fileData.get("COUNTRY_CODE");//���Ҵ���
			String adoptOrgId = (String)fileData.get("ADOPT_ORG_ID");//��֯��������
			String costType = (String)billData.get("COST_TYPE");//�������
			String fileNo = "";//�ļ���Ϣ���ı��
			String billfileNo = "";//Ʊ����Ϣ���ı��
			String batchAfId = "";//�ǼǺ󷵻ص�����
			
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, adoptOrgId);
            String  syzzCnName = syzzDept.getSyzzCnName();//������֯��������
            String  syzzEnName = syzzDept.getSyzzEnName();//������֯Ӣ������
            String  countryCnName = syzzDept.getCountryCnName();//����������������
            String  countryEnName = syzzDept.getCountryEnName();//��������Ӣ������
            
			String isPJ = billData.getString("ISPIAOJUVALUE");//�Ƿ�¼��Ʊ����Ϣ��0����   1����
			if(isPJ=="1"||isPJ.equals("1")){
				String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//���ɽɷѱ��
				billData.add("PAID_NO", paidNo);
				fileData.add("PAID_NO", paidNo);
				//fileData.add("AF_COST_PAID", "1");//�ɷ�״̬Ϊ���ѽɷѡ�
			}
			/*if(isPJ=="0"||isPJ.equals("0")){
            	fileData.add("AF_COST_PAID", "0");//�ɷ�״̬Ϊ��δ�ɷѡ�
            }*/
			fileData.add("AF_COST_PAID", "0");//�ɷ�״̬Ϊ��δ�ɷѡ�
//			fileData.add("FILE_NO", fileNo);
//			billData.add("FILE_NO", fileNo);
			
			//******��ʽһ����ȡ�ļ�ȫ��״̬���ļ�λ���Լ��ļ�״̬��������֯����������begin*****//*
			FileCommonStatusAndPositionManager fileStatusManager = new FileCommonStatusAndPositionManager();//�ļ�ȫ��״̬��λ�ù�����
			Data globalStatusAndPositionData = fileStatusManager.getNextGlobalAndPosition(FileOperationConstant.BGS_REGISTRATION_PLDL_SUBMIT);//����ļ�ȫ��״̬��λ��
			String globalState = (String)globalStatusAndPositionData.get("AF_GLOBAL_STATE");//�ļ�ȫ��״̬
			String position = (String)globalStatusAndPositionData.get("AF_POSITION");//�ļ�λ��
			//******��ʽһ����ȡ�ļ�ȫ��״̬���ļ�λ���Լ��ļ�״̬��������֯����������end*****//*
			
			//******��ʽ����ֱ�Ӹ����ļ�ȫ��״̬���ļ�λ��begin*****//*
			// fileStatusManager.updateNextGlobalStatusAndPositon(conn,FileOperationConstant.GERNERATION_SUBMIT, "", fileNo);
			//******��ʽ����ֱ�Ӹ����ļ�ȫ��״̬���ļ�λ��end******//*
			DataList dataList = new DataList();
			String rowNum = this.getParameter("rowNum");
			
			// Start---------��ȡ�����ļ�������Ϣ------------
			String P_FILE_TYPE = this.getParameter("P_FILE_TYPE","");
			String P_FAMILY_TYPE = this.getParameter("P_FAMILY_TYPE","");
			String P_ADOPTER_SEX = this.getParameter("P_ADOPTER_SEX","");
			String P_MALE_NAME = this.getParameter("P_MALE_NAME","");
	        if(!"".equals(P_MALE_NAME)&&null!=P_MALE_NAME){
	        	P_MALE_NAME = P_MALE_NAME.toUpperCase();
	        }
	        String P_FEMALE_NAME = this.getParameter("P_FEMALE_NAME","");
	        if(!"".equals(P_FEMALE_NAME)&&null!=P_FEMALE_NAME){
	        	P_FEMALE_NAME = P_FEMALE_NAME.toUpperCase();
	        }
			String P_MALE_BIRTHDAY = this.getParameter("P_MALE_BIRTHDAY","");
			String P_FEMALE_BIRTHDAY = this.getParameter("P_FEMALE_BIRTHDAY","");
			String P_REG_REMARK = this.getParameter("P_REG_REMARK","");
			
            String isGy = fileCommonManager.getISGY(conn, P_FILE_TYPE, countryCode);//�Ƿ�Լ����

			// End---------��ȡ�����ļ�������Ϣ------------
			if(!"".equals(P_FILE_TYPE)){
				Data data = new Data();
				data.put("COUNTRY_CODE", (String)fileData.get("COUNTRY_CODE"));//����
				data.put("ADOPT_ORG_ID", (String)fileData.get("ADOPT_ORG_ID"));//��֯����
				data.put("NAME_CN", syzzCnName);//������֯��������
				data.put("NAME_EN", syzzEnName);//������֯Ӣ������
				data.put("COUNTRY_CN", countryCnName);//����������������
				data.put("COUNTRY_EN", countryEnName);//��������Ӣ������
				data.add("IS_CONVENTION_ADOPT", isGy);//�Ƿ�Լ����

				
				fileNo = fileCommonManager.createFileNO(conn,countryCode);//�������ı��
				billfileNo +=fileNo + ",";
				data.put("FILE_NO", fileNo);//���ı��
				data.put("PAID_NO", (String)fileData.get("PAID_NO"));//�ɷѱ��
				data.put("AF_COST_PAID", (String)fileData.get("AF_COST_PAID"));//�ɷ�״̬
				
				data.put("REG_USERID", personId);//�ļ��Ǽ���ID
				data.put("REG_USERNAME", personName);//�ļ��Ǽ�������
				data.put("REG_DATE", curDate);//�ļ��Ǽ�����
				data.put("REGISTER_DATE", curDate);//��������
				data.put("REG_STATE", "3");//�Ǽ�״̬Ϊ�ѵǼ�
				data.put("AF_COST",fileData.get("AF_COST"));//Ӧ�ɷ���
				data.add("AF_COST_CLEAR", "0");//���״̬Ϊδ���
				data.add("AF_COST_CLEAR_FLAG", "0");//���ά����ʶΪ��
				data.add("CREATE_USERID", personId);//������ID
		        data.add("CREATE_DATE", curDate);//��������
				
				String fileSeqNo = fileCommonManager.createFileSeqNO(conn);//�����ļ���ˮ��
				data.put("AF_SEQ_NO", fileSeqNo);//�ļ���ˮ��
				
				data.put("AF_GLOBAL_STATE", globalState);//�ļ�ȫ��״̬
				data.put("AF_POSITION", position);//�ļ�λ��
				
				data.put("FILE_TYPE", P_FILE_TYPE);
				data.put("FAMILY_TYPE", P_FAMILY_TYPE);
				data.put("ADOPTER_SEX", P_ADOPTER_SEX);
				data.put("MALE_NAME", P_MALE_NAME);
				data.put("MALE_BIRTHDAY", P_MALE_BIRTHDAY);
				data.put("FEMALE_NAME", P_FEMALE_NAME);
				data.put("FEMALE_BIRTHDAY", P_FEMALE_BIRTHDAY);
				data.put("REG_REMARK", P_REG_REMARK);
				dataList.add(handler.saveBatchFlieRecord(conn, data, true));//�����ļ���Ϣҵ������
				
				DataList tranferDataList0 = new DataList();
				if(dataList.size()>0){//�Ǽǳɹ��������ļ����ƽ�����
					Data tdata = (Data)dataList.get(0);
					String afId = tdata.getString("AF_ID");
					Data dataTemp = new Data();
					dataTemp.add("APP_ID", afId);
					dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
					dataTemp.add("TRANSFER_STATE", "0");
					tranferDataList0.add(dataTemp);
					fileCommonManager.transferDetailInit(conn, tranferDataList0);
				}
				if(dataList.size()>0){//��ȡ�ǼǺ󷵻ص�����
					Data afdata = (Data)dataList.get(0);
					String af_id = afdata.getString("AF_ID");
					batchAfId += af_id + ",";
				}
			}
			for (int i = 1; i <= Integer.parseInt(rowNum); i++) {
				String FILE_TYPE = this.getParameter("P_FILE_TYPE" + i,"");
				String ADOPTER_SEX = this.getParameter("P_ADOPTER_SEX" + i,"");
				String FAMILY_TYPE = this.getParameter("P_FAMILY_TYPE" + i,"");
				String MALE_NAME = this.getParameter("P_MALE_NAME" + i,"");
		        if(!"".equals(MALE_NAME)&&null!=MALE_NAME){
		        	MALE_NAME = MALE_NAME.toUpperCase();
		        }
		        String FEMALE_NAME = this.getParameter("P_FEMALE_NAME" + i,"");
		        if(!"".equals(FEMALE_NAME)&&null!=FEMALE_NAME){
		        	FEMALE_NAME = FEMALE_NAME.toUpperCase();
		        }
				String MALE_BIRTHDAY = this.getParameter("P_MALE_BIRTHDAY" + i,"");
				String FEMALE_BIRTHDAY = this.getParameter("P_FEMALE_BIRTHDAY" + i,"");
				String REG_REMARK = this.getParameter("P_REG_REMARK" + i,"");
				if(!"".equals(FILE_TYPE)){
					Data batchData = new Data();
					batchData.put("COUNTRY_CODE", (String)fileData.get("COUNTRY_CODE"));//����
					batchData.put("ADOPT_ORG_ID", (String)fileData.get("ADOPT_ORG_ID"));//��֯����
					batchData.add("NAME_CN",syzzCnName );//������֯��������
					batchData.add("NAME_EN",syzzEnName );//������֯Ӣ������
					batchData.put("COUNTRY_CN", countryCnName);//����������������
					batchData.put("COUNTRY_EN", countryEnName);//��������Ӣ������
					batchData.add("IS_CONVENTION_ADOPT", isGy);//�Ƿ�Լ����



					fileNo = fileCommonManager.createFileNO(conn,countryCode);//�������ı��
					billfileNo += fileNo + ",";
					batchData.put("FILE_NO", fileNo);//���ı��
					
					batchData.put("PAID_NO", (String)fileData.get("PAID_NO"));//�ɷѱ��
					batchData.put("AF_COST_PAID", (String)fileData.get("AF_COST_PAID"));//�ɷ�״̬
					
					batchData.put("REG_USERID", personId);//�ļ��Ǽ���ID
					batchData.put("REG_USERNAME", personName);//�ļ��Ǽ�������
					batchData.put("REG_DATE", curDate);//�ļ��Ǽ�����
					batchData.put("REGISTER_DATE", curDate);//��������
					batchData.put("REG_STATE", FileCommonConstant.DJZT_YDJ);//�Ǽ�״̬Ϊ�ѵǼ�
					batchData.put("AF_COST", fileData.get("AF_COST"));//Ӧ�ɷ���
					batchData.add("AF_COST_CLEAR", "0");//���״̬Ϊδ���
					batchData.add("AF_COST_CLEAR_FLAG", "0");//���ά����ʶΪ��
					batchData.add("CREATE_USERID", personId);//������ID
					batchData.add("CREATE_DATE", curDate);//��������
					
					String fileSeqNo = fileCommonManager.createFileSeqNO(conn);//�����ļ���ˮ��
					batchData.put("AF_SEQ_NO", fileSeqNo);//�ļ���ˮ��
					
					batchData.put("AF_GLOBAL_STATE", globalState);//�ļ�ȫ��״̬
					batchData.put("AF_POSITION", position);//�ļ�λ��
					
					batchData.put("FILE_TYPE", FILE_TYPE);
					batchData.put("ADOPTER_SEX", ADOPTER_SEX);
					batchData.put("FAMILY_TYPE", FAMILY_TYPE);
					batchData.put("MALE_NAME", MALE_NAME);
					batchData.put("MALE_BIRTHDAY", MALE_BIRTHDAY);
					batchData.put("FEMALE_NAME", FEMALE_NAME);
					batchData.put("FEMALE_BIRTHDAY", FEMALE_BIRTHDAY);
					batchData.put("REG_REMARK", REG_REMARK);
					dataList.add(handler.saveBatchFlieRecord(conn, batchData, true));//�����ļ���Ϣҵ������
					
					DataList tranferDataList = new DataList();
					if(dataList.size()>0){//�Ǽǳɹ��������ļ����ƽ�����
						Data data = (Data)dataList.get(i);
						String afId = data.getString("AF_ID");
						Data dataTemp = new Data();
						dataTemp.add("APP_ID", afId);
						dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
						dataTemp.add("TRANSFER_STATE", "0");
						tranferDataList.add(dataTemp);
						fileCommonManager.transferDetailInit(conn, tranferDataList);
					}
					if(dataList.size()>0){//��ȡ�ǼǺ󷵻ص�����
						Data afdata = (Data)dataList.get(i);
						String af_id = afdata.getString("AF_ID");
						batchAfId += af_id + ",";
					}
				}
			}
			
			String batch_af_id = batchAfId.substring(0, batchAfId.lastIndexOf(","));
			setAttribute("batchAfId", batch_af_id);
			
			billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//Ʊ����Ϣ���ı��
			billData.put("NAME_CN", syzzCnName);//������֯��������
			billData.put("NAME_EN", syzzEnName);//������֯Ӣ������
			handler.saveBatchCostRecord(conn,billData);//����Ʊ��ҵ������
			
			String packageId = billData.getString("FILE_CODE");//�������ɷ�ƾ֤��
			AttHelper.publishAttsOfPackageId(packageId, "OTHER");//��������
			
			DataList tranferDataList2 = new DataList();
			if(dataList.size()>1){//���¼����Ʊ����Ϣ���򱣴�Ʊ����Ϣ
				//��ʼ���ɷѵ��ƽ���Ϣ
            	Data pjyjData =(Data)dataList.get(1);
            	Data dataTemp2 = new Data();
            	String cheque_id = pjyjData.getString("CHEQUE_ID");
            	dataTemp2.add("APP_ID", cheque_id);
            	dataTemp2.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
            	dataTemp2.add("TRANSFER_STATE", "0");
            	tranferDataList2.add(dataTemp2);
            	fileCommonManager.transferDetailInit(conn, tranferDataList2);
			}
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//����ɹ� 0
			setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			//5 �����쳣����
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��Ǽǲ�ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[�������]:" + e.getMessage(),e);
			}
			//6 �������ҳ����ʾ
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
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
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch(Exception e){
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		}finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("RegistrationAction��Connection������쳣��δ�ܹر�",e);
					}
					e.printStackTrace();
				}
			}
		}
		setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * �����������ӡҳ��
	 * @author Panfeng
	 * @date 2014-12-3
	 * @return
	 */
	public String barCodeList(){
		//1 �б�ҳ��ȡ��ϢID
		String type = getParameter("type");
		String printId = "";
		StringBuffer stringb = new StringBuffer();
		if ("direct".equals(type)){//�б�ѡ�����ת
			String printuuid = getParameter("codeuuid");
			String[] uuid = printuuid.split(",");
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
		}else{//�ǼǺ���תҳ��
			String printuuid = (String) getAttribute("batchAfId");
			String[] uuid = printuuid.split(",");
			for(int i=0; i<uuid.length; i++){
				stringb.append("'" + uuid[i] + "',");
			}
		}
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			printId = stringb.substring(0, stringb.length() - 1);
			DataList printShow = handler.getPrintData(conn, printId);
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
	 * @Title:saveFileHandReg
	 * @Description:�ļ��ֹ��Ǽ�
	 * @author panfeng
	 * @date 2014-8-11
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String saveFileHandReg() throws IOException{
		
		//1 ��ȡ�����˻�����Ϣ��ϵͳ����
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
		String personName = SessionInfo.getCurUser().getPerson().getCName();
		String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDate();
		
		//2 ���ҳ������ݣ��������ݽ����
		// Start---------��ȡ�����ļ�������Ϣ------------
		String[] AF_ID = this.getParameterValues("P_AF_ID");
		String[] RI_ID = this.getParameterValues("P_RI_ID");
		String[] P_CI_ID = this.getParameterValues("P_CI_ID");
		String[] P_AF_COST = this.getParameterValues("P_AF_COST");
		String[] P_COUNTRY_CODE = this.getParameterValues("P_COUNTRY_CODE");
		String[] P_ADOPT_ORG_ID = this.getParameterValues("P_ADOPT_ORG_ID");
		String[] P_NAME_CN = this.getParameterValues("P_NAME_CN");
		String[] P_NAME_EN = this.getParameterValues("P_NAME_EN");
		String[] P_FILE_TYPE = this.getParameterValues("P_FILE_TYPE");
		String[] P_MALE_NAME = this.getParameterValues("P_MALE_NAME");
		String[] P_MALE_BIRTHDAY = this.getParameterValues("P_MALE_BIRTHDAY");
		String[] P_FEMALE_NAME = this.getParameterValues("P_FEMALE_NAME");
		String[] P_FEMALE_BIRTHDAY = this.getParameterValues("P_FEMALE_BIRTHDAY");
		// End---------��ȡ�����ļ�������Ϣ------------
		
		// Start---------��ȡ������Ϣ------------
		Data fileData = getRequestEntityData("P_","NAME_CN","NAME_EN","COUNTRY_CN","COUNTRY_EN","FAMILY_TYPE","ORIGINAL_FILE_NO");
		Data billData = getRequestEntityData("P_","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","FILE_CODE","ISPIAOJUVALUE");
		// End---------��ȡ������Ϣ------------
		
		billData.add("COUNTRY_CODE", P_COUNTRY_CODE[0]);//Ʊ��¼�����
		billData.add("ADOPT_ORG_ID", P_ADOPT_ORG_ID[0]);//Ʊ��¼��������֯
		billData.add("NAME_CN", P_NAME_CN[0]);//������֯��������
		billData.add("NAME_EN", P_NAME_EN[0]);//������֯Ӣ������
		billData.add("REG_USERID", personId);//Ʊ��¼����ID
		billData.add("REG_USERNAME", personName);//Ʊ��¼��������
		billData.add("REG_ORGID", deptId);//Ʊ��¼�������ڲ���ID
		billData.add("REG_DATE", curDate);//Ʊ��¼������
		
		billData.add("CHEQUE_TRANSFER_STATE", "0");//Ʊ���ƽ�״̬��ʼ��Ϊ��δ�ύ��
		
		try {
			
			//3 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//4 ִ�����ݿ⴦�����
			
			FileCommonManager fileCommonManager = new FileCommonManager();
			String adoptOrgId = (String)billData.get("ADOPT_ORG_ID");//��֯��������
			String costType = (String)billData.get("COST_TYPE");//�������
			String billfileNo = "";//Ʊ����Ϣ���ı��

			String isPJ = billData.getString("ISPIAOJUVALUE");//�Ƿ�¼��Ʊ����Ϣ��0����   1����
			if(isPJ=="1"||isPJ.equals("1")){
				String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//���ɽɷѱ��
				billData.add("PAID_NO", paidNo);
				fileData.add("PAID_NO", paidNo);
				//fileData.add("AF_COST_PAID", "1");//�ɷ�״̬Ϊ���ѽɷѡ�
			}
			/*if(isPJ=="0"||isPJ.equals("0")){
            	fileData.add("AF_COST_PAID", "0");//�ɷ�״̬Ϊ��δ�ɷѡ�
            }*/
			fileData.add("AF_COST_PAID", "0");//�ɷ�״̬Ϊ��δ�ɷѡ�
			
			//******��ʽһ����ȡ�ļ�ȫ��״̬���ļ�λ���Լ��ļ�״̬��������֯����������begin*****//*
			FileCommonStatusAndPositionManager fileStatusManager = new FileCommonStatusAndPositionManager();//�ļ�ȫ��״̬��λ�ù�����
			Data globalStatusAndPositionData = fileStatusManager.getNextGlobalAndPosition(FileOperationConstant.BGS_REGISTRATION_SGDJ_SUBMIT);//����ļ�ȫ��״̬��λ��
			String globalState = (String)globalStatusAndPositionData.get("AF_GLOBAL_STATE");//�ļ�ȫ��״̬
			String position = (String)globalStatusAndPositionData.get("AF_POSITION");//�ļ�λ��
			//******��ʽһ����ȡ�ļ�ȫ��״̬���ļ�λ���Լ��ļ�״̬��������֯����������end*****//*
			
			//******��ʽ����ֱ�Ӹ����ļ�ȫ��״̬���ļ�λ��begin*****//*
			// fileStatusManager.updateNextGlobalStatusAndPositon(conn,FileOperationConstant.GERNERATION_SUBMIT, "", fileNo);
			//******��ʽ����ֱ�Ӹ����ļ�ȫ��״̬���ļ�λ��end******//*
			
			int totalCost=0;//�ܵ�Ӧ�ɽ��
			DataList dataList = new DataList();
			if(P_COUNTRY_CODE.length>0&&null != P_COUNTRY_CODE[0]&&!"".equals( P_COUNTRY_CODE[0])&&!"null".equals(P_COUNTRY_CODE[0])){
				if (AF_ID != null && AF_ID.length != 0) {
					for (int i = 0; i < AF_ID.length; i++) {
						Data handRegData = new Data();
						String fileNo = "";
						
						fileNo = fileCommonManager.createFileNO(conn,P_COUNTRY_CODE[i]);//�������ı��
						billfileNo +=fileNo + ",";
						
						handRegData.add("FILE_NO", fileNo);
						handRegData.add("PAID_NO", (String)fileData.get("PAID_NO"));//�ɷѱ��
						handRegData.add("AF_COST_PAID", (String)fileData.get("AF_COST_PAID"));//�ɷ�״̬
						
						handRegData.add("REG_USERID", personId);//�ļ��Ǽ���ID
						handRegData.add("REG_USERNAME", personName);//�ļ��Ǽ�������
						handRegData.add("REG_DATE", curDate);//�ļ��Ǽ�����
						handRegData.add("REGISTER_DATE", curDate);//��������
						handRegData.add("REG_STATE", FileCommonConstant.DJZT_YDJ);//�Ǽ�״̬Ϊ�ѵǼ�
						if("20".equals(P_FILE_TYPE[i])||"21".equals(P_FILE_TYPE[i])||"22".equals(P_FILE_TYPE[i])||"23".equals(P_FILE_TYPE[i])){
							//handRegData.add("AF_COST", "500");//Ӧ�ɷ���
							handRegData.add("AF_COST", P_AF_COST[i]);//Ӧ�ɷ���
							handRegData.add("RI_STATE", "6");//�ļ���Ϣ��Ԥ��״̬����������
							if(RI_ID != null && !"".equals(RI_ID)){
								boolean success = false;
								String[] ri_ids = RI_ID[i].split(",");
								success = handler.saveSceReqInfo(conn,ri_ids);//����Ԥ����Ϣҵ������
							}
						}else{
							//handRegData.add("AF_COST", "800");
							handRegData.add("AF_COST", P_AF_COST[i]);
						}
						
						int tempCost = Integer.parseInt(P_AF_COST[i]);
						totalCost +=tempCost; 
						
						
						handRegData.add("AF_COST_CLEAR", "0");//���״̬Ϊδ���
						handRegData.add("AF_COST_CLEAR_FLAG", "0");//���ά����ʶΪ��
						
						handRegData.add("AF_GLOBAL_STATE", globalState);//�ļ�ȫ��״̬
						handRegData.add("AF_POSITION", position);//�ļ�λ��
						
						handRegData.setEntityName("FFS_AF_INFO");
						handRegData.setPrimaryKey("AF_ID");
						handRegData.add("AF_ID", AF_ID[i]);
						if(P_FILE_TYPE != null && !"".equals(P_FILE_TYPE)){
							handRegData.add("FILE_TYPE", P_FILE_TYPE[i]);
						}
						handRegData.add("MALE_NAME", P_MALE_NAME[i].toUpperCase());
						handRegData.add("MALE_BIRTHDAY", P_MALE_BIRTHDAY[i]);
						handRegData.add("FEMALE_NAME", P_FEMALE_NAME[i].toUpperCase());
						handRegData.add("FEMALE_BIRTHDAY", P_FEMALE_BIRTHDAY[i]);
						dataList.add(handler.saveBatchFlieRecord(conn, handRegData, false));//�����ļ���Ϣҵ������
						
						DataList tranferDataList = new DataList();
						if(dataList.size()>0){//�Ǽǳɹ��������ļ����ƽ�����
							Data data = (Data)dataList.get(i);
							String afId = data.getString("AF_ID");
							Data dataTemp = new Data();
							dataTemp.add("APP_ID", afId);
							dataTemp.add("TRANSFER_CODE", TransferCode.FILE_BGS_FYGS);
							dataTemp.add("TRANSFER_STATE", "0");
							tranferDataList.add(dataTemp);
							fileCommonManager.transferDetailInit(conn, tranferDataList);
						}
					}
				}
			billData.add("PAID_SHOULD_NUM", Integer.toString(totalCost));//�ܵ�Ӧ�ɽ��
			billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//Ʊ����Ϣ���ı��
			handler.saveBatchCostRecord(conn,billData);//����Ʊ��ҵ������
			
			String packageId = billData.getString("FILE_CODE");//�������ɷ�ƾ֤��
			AttHelper.publishAttsOfPackageId(packageId, "OTHER");//��������
			
			DataList tranferDataList2 = new DataList();
			if(dataList.size()>1){//���¼����Ʊ����Ϣ���򱣴�Ʊ����Ϣ
				//��ʼ���ɷѵ��ƽ���Ϣ
            	Data pjyjData =(Data)dataList.get(1);
            	Data dataTemp2 = new Data();
            	String cheque_id = pjyjData.getString("CHEQUE_ID");
            	dataTemp2.add("APP_ID", cheque_id);
            	dataTemp2.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
            	dataTemp2.add("TRANSFER_STATE", "0");
            	tranferDataList2.add(dataTemp2);
            	fileCommonManager.transferDetailInit(conn, tranferDataList2);
			}
			
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, "���ݱ���ɹ�!");//����ɹ� 0
			setAttribute("clueTo", clueTo);
		}else{
			InfoClueTo clueTo = new InfoClueTo(2, "�ֹ��Ǽ�ʧ��!����code����Ϊ�գ�");//����ʧ�� 0
			setAttribute("clueTo", clueTo);
		}
		
		} catch (DBException e) {
			//5 �����쳣����
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��Ǽǲ�ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�����쳣[�������]:" + e.getMessage(),e);
			}
			//6 �������ҳ����ʾ
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
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
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch(Exception e){
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
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
						log.logError("RegistrationAction��Connection������쳣��δ�ܹر�",e);
					}
					e.printStackTrace();
				}
			}
		}
		setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * @Title: findList 
	 * @Description: �ļ��Ǽ��б�
	 * @author: songhn
	 * @return String    �������� 
	 * @throws
	 */
	public String findList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 ��ȡ�����ֶ�
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="AF_SEQ_NO";
		}
		//2.2 ��ȡ��������   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="";
		}
		//3 ��ȡ��������
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","AF_SEQ_NO","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","MALE_NAME","FEMALE_NAME","ADOPT_ORG_ID","FILE_TYPE","AF_COST","SUBMIT_DATE_START","SUBMIT_DATE_END","REG_STATE");
		String MALE_NAME = data.getString("MALE_NAME");
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
			DataList dl=handler.findList(conn,data,pageSize,page,compositor,ordertype);
			//6 �������д��ҳ����ձ���
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��Ǽǲ�ѯ�����쳣");
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
						log.logError("RegistrationAction��findList.Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * ����������
	 * @author Panfeng
	 * @date 2014-7-21
	 * @return
	 */
	public String barCode(){
		//1 �б�ҳ��ȡ��ϢID
		String uuid = getParameter("codeuuid","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			Data codedata = handler.getShowData(conn, uuid, null);
			//4 ��������ҳ��
			setAttribute("data", codedata);
			setAttribute("file_no", codedata.getString("FILE_NO", ""));//�������ı��
		} catch (DBException e) {
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
				}
			}
		}
		return SUCCESS;
	}
	
	/**
	 * �鿴
	 * @author Panfeng
	 * @date 2014-7-15
	 * @return
	 */
	public String show(){
		//1 ��ȡ�鿴��Ϣ��ID
		String uuid = getParameter("showuuid","");
		String fileno = getParameter("fileno","");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ�鿴��Ϣ�����
			Data showdata = handler.getShowData(conn, uuid, fileno);
			//4 ��������鿴ҳ��
			setAttribute("wjdlData", showdata);
			setAttribute("is_change_org", showdata.getString("IS_CHANGE_ORG", ""));//�����Ƿ�ת��֯
			setAttribute("male_name", showdata.getString("MALE_NAME", ""));//������������
			setAttribute("famale_name", showdata.getString("FEMALE_NAME", ""));//����Ů������
			setAttribute("file_code", showdata.getString("FILE_CODE", showdata.getString("CHEQUE_ID")));//���븽��ID
		} catch (DBException e) {
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
				}
			}
		}
		return SUCCESS;
	}
	
	/********   �ļ��˻ز���		********/ 
	/**
	 * @Title: toAddFlieReturnReason 
	 * @Description: �ļ��˻�����
	 * @author: yangrt
	 * @return String 
	 * 			errer:��ת������ҳ��
	 * 			success:��ת���ļ��˻�����ҳ��
	 */
	public String toAddFlieReturnReason(){
		//1 ��ȡҪ�˻ص��ļ�ID
		String AF_ID = getParameter("AF_ID");
		//2 ��ȡ�����˻�����Ϣ��ϵͳ����
	 	String personId = SessionInfo.getCurUser().getPerson().getPersonId();
	 	String personName = SessionInfo.getCurUser().getPerson().getCName();
	 	String curDate = DateUtility.getCurrentDate();
	 	
		try {
			//3 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//4 ��ȡ��ʾ�����
			Data fileData = handler.getShowData(conn, AF_ID, null);
			fileData.add("REG_USERID", personId);//�ļ��Ǽ���ID
	        fileData.add("REG_USERNAME", personName);//�ļ��Ǽ�������
	        fileData.add("REG_RETURN_DATE", curDate);//�ļ��˻�����
	        //5 �������д��ҳ����ձ���
	        setAttribute("fileData", fileData);
		} catch (DBException e) {
			//6 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��˻ز����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("�ļ��˻ز����쳣:" + e.getMessage(),e);
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
						log.logError("RegistrationAction��toAddFlieReturnReason������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
	}
	/**
	 * �ļ��˻ر���
	 */
	public String saveFlieReturnReason(){
        //1 ���ҳ������ݣ��������ݽ����
        Data fileData = getRequestEntityData("R_","AF_ID","REG_USERID","REG_USERNAME","REG_RETURN_REASON","REG_RETURN_DESC","REG_RETURN_DATE");
        
        try {
        	//3 ��ȡ���ݿ�����
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            //4 ִ�����ݿ⴦�����
            fileData.add("REG_STATE", FileCommonConstant.DJZT_DXG);//�Ǽ�״̬Ϊ���޸�
            handler.saveFlieReturnReason(conn,fileData);
            //TODO���ļ��˻غ���Ҫ��������֯������
            dt.commit();
            InfoClueTo clueTo = new InfoClueTo(0, "�ļ��˻سɹ�!");//����ɹ� 0
            setAttribute("clueTo", clueTo);
        } catch (DBException e) {
        	//5 �����쳣����
        	setAttribute(Constants.ERROR_MSG_TITLE, "�ļ��˻ز����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			
            if (log.isError()) {
                log.logError("�����쳣[�������]:" + e.getMessage(),e);
            }
            //6 �������ҳ����ʾ
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");//����ʧ�� 2
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
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        } catch(Exception e ){
        	try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "���ݱ���ʧ��!");
            setAttribute("clueTo", clueTo);
            retValue = "error2";
        }finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("RegistrationAction��saveFlieReturnReason��Connection������쳣��δ�ܹر�",e);
                    }
                    e.printStackTrace();
                }
            }
        }
        
        setAttribute("data", new Data());
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
		String ci_id = getParameter("ci_id");
		try {
			conn = ConnectionManager.getConnection();
			if(!"".equals(ci_id)){
				DataList dataList = handler.getChildDataList(conn, ci_id);
				setAttribute("List", dataList);
			}
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
                       log.logError("RegistrationAction��ChildDataShow.Connection������쳣��δ�ܹر�",e);
                   }
                   e.printStackTrace();
                   
                   retValue = "error2";
               }
           }
       }
		
		return retValue;
	}
	 
}
