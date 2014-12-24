package com.dcfs.fam.billRegistration;

import hx.common.Constants;
import hx.common.Exception.DBException;

import com.dcfs.common.DcfsConstants;
import com.dcfs.common.DeptUtil;
import com.dcfs.common.SyzzDept;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;

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
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpSession;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;

/** 
 * @ClassName: BillRegistrationAction 
 * @Description: �칫��֧Ʊ�ݵǼǲ�����������ѯ���Ǽǡ��޸ġ�ɾ������ӡ���������� 
 * @author panfeng 
 * @date 2014-11-14
 *  
 */
public class BillRegistrationAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(BillRegistrationAction.class);

    private BillRegistrationHandler handler;
    
    private Connection conn = null;//���ݿ�����
    
    private DBTransaction dt = null;//������
    
    private String retValue = SUCCESS;
    
    public BillRegistrationAction(){
        this.handler=new BillRegistrationHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
	 * @Title: billRegistrationList 
	 * @Description: Ʊ�ݵǼ��б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String billRegistrationList(){
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
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
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//��ȡ�����������
		setAttribute("clueTo", clueTo);//set�����������
		Data data = getRequestEntityData("S_","PAID_NO","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_WAY",
					"PAID_SHOULD_NUM","PAR_VALUE","FILE_NO","REG_DATE_START",
					"REG_DATE_END","CHEQUE_TRANSFER_STATE");
		try {
			//4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//5 ��ȡ����DataList
			DataList dl=handler.billRegistrationList(conn,data,pageSize,page,compositor,ordertype);
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
	 * ��ת��Ʊ�ݵǼ�ҳ��
	 * @author Panfeng
	 * @date 2014-11-14
	 * @return
	 */
	public String billRegistrationAdd() {
		// ��ȡsession�е��ֹ�����б��ж��Ƿ������ʷ����
		HttpSession session = getRequest().getSession();
		DataList dl = (DataList) session.getAttribute("fileList");
		if (dl == null) {
			// ����ҳ���ʼ������
			dl = new DataList();
			setAttribute("fileList", dl);
		}
		
		String isinit = getParameter("init");
		if(isinit != null && "1".equals(isinit)){
			session.setAttribute("fileList", new DataList());
			session.removeAttribute("regData");
		}else{
			String CHEQUE_ID = getParameter("CHEQUE_ID");
			String PAID_NO = getParameter("PAID_NO");
			String countryCode = getParameter("COUNTRY_CODE");
			String adoptOrgId = getParameter("ADOPT_ORG_ID");
			String nameCn = getParameter("NAME_CN");
			String PAID_WAY = getParameter("PAID_WAY");
			String PAR_VALUE = getParameter("PAR_VALUE");
			String BILL_NO = getParameter("BILL_NO");
			String REMARKS = getParameter("REMARKS");
			try {//���봦��
				nameCn = java.net.URLDecoder.decode(nameCn,"UTF-8");
				BILL_NO = java.net.URLDecoder.decode(BILL_NO,"UTF-8");
				REMARKS = java.net.URLDecoder.decode(REMARKS,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//session�ֹ�����б�ʱ����ҳ������
			Data showdata = new Data();
//			String countryCode = dl.getData(0).getString("COUNTRY_CODE");
//			String adoptOrgId = dl.getData(0).getString("ADOPT_ORG_ID");
//			String nameCn = dl.getData(0).getString("NAME_CN");
			showdata.add("CHEQUE_ID", CHEQUE_ID);
			showdata.add("PAID_NO", PAID_NO);
			showdata.add("COUNTRY_CODE", countryCode);
			showdata.add("ADOPT_ORG_ID", adoptOrgId);
			showdata.add("NAME_CN", nameCn);
			showdata.add("PAID_WAY", PAID_WAY);
			showdata.add("PAR_VALUE", PAR_VALUE);
			showdata.add("BILL_NO", BILL_NO);
			showdata.add("REMARKS", REMARKS);
			setAttribute("regData", showdata);
		}

		return retValue;

	}
	
	/**
	 * @Title: selectFileList 
	 * @Description: �ļ�ѡ���б�
	 * @author: panfeng
	 * @return String    �������� 
	 * @throws
	 */
	public String selectFileList() {
		String CHEQUE_ID = getParameter("CHEQUE_ID","");
		String PAID_NO = getParameter("PAID_NO","");
		String country_code = getParameter("country_code","");
		String adopt_org_id = getParameter("adopt_org_id","");
		String name_cn = getParameter("name_cn","");
		String PAID_WAY = getParameter("PAID_WAY","");
		String PAR_VALUE = getParameter("PAR_VALUE","");
		String BILL_NO = getParameter("BILL_NO","");
		String REMARKS = getParameter("REMARKS","");
		try {//���봦��
			name_cn = java.net.URLDecoder.decode(name_cn,"UTF-8");
			BILL_NO = java.net.URLDecoder.decode(BILL_NO,"UTF-8");
			REMARKS = java.net.URLDecoder.decode(REMARKS,"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}
		// ��ȡ��������
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
		setAttribute("clueTo", clueTo);// set�����������
		Data data = getRequestEntityData("S_", "FILE_NO", "REGISTER_DATE_START", 
				"REGISTER_DATE_END", "AF_COST", "FILE_TYPE", 
				"AF_COST", "MALE_NAME", "FEMALE_NAME", "AF_COST_PAID");
		try {
			// 4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 5 ��ȡ����DataList
			DataList dl = handler.selectFileList(conn, data, pageSize,
					page, compositor, ordertype, country_code, adopt_org_id, PAID_NO);
			// 6 �������д��ҳ����ձ���
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("CHEQUE_ID", CHEQUE_ID);
			setAttribute("PAID_NO", PAID_NO);
			setAttribute("PAID_WAY", PAID_WAY);
			setAttribute("PAR_VALUE", PAR_VALUE);
			setAttribute("BILL_NO", BILL_NO);
			setAttribute("REMARKS", REMARKS);
			setAttribute("country_code", country_code);
			setAttribute("adopt_org_id", adopt_org_id);
			setAttribute("name_cn", name_cn);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);

			// �����β�ѯ���ļ��б���õ�session�У���ѡ����ɺ�Ա�
			HttpSession session = getRequest().getSession();
			session.setAttribute("newFileList", dl);

		} catch (DBException e) {
			// 7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
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
	 * @Title: billRegistrationSave
	 * @Description:Ʊ�ݵǼǱ��桢�ύ����
	 * @author panfeng
	 * @date 2014-11-19
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String billRegistrationSave() throws IOException{
		
//		// ��ȡҳ�����ͣ��Ǽ�/�޸ģ�
//		String pageAction = this.getParameter("P_PAGEACTION");
		// ��ȡ�ύ��ʽ������/�ύ��
		String type = getParameter("type");
		// ��ȡ�����˻�����Ϣ��ϵͳ����
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
		String personName = SessionInfo.getCurUser().getPerson().getCName();
		String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDate();
		
		// ��ȡsession�е�����б�
		HttpSession session = getRequest().getSession();
		DataList dl = (DataList) session.getAttribute("fileList");
		
		// ���ҳ������ݣ��������ݽ����
		
		// Start---------��ȡ������Ϣ------------
		Data fileData = getRequestEntityData("P_","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","ORIGINAL_FILE_NO");
		Data billData = getRequestEntityData("P_","CHEQUE_ID","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","CHEQUE_TRANSFER_STATE");
		
		// End---------��ȡ������Ϣ------------
		billData.add("COUNTRY_CODE", (String)fileData.get("COUNTRY_CODE"));//Ʊ�ݹ���
		billData.add("ADOPT_ORG_ID", (String)fileData.get("ADOPT_ORG_ID"));//Ʊ��������֯ID
		billData.add("NAME_CN", (String)fileData.get("NAME_CN"));//Ʊ��������֯����
		billData.add("NAME_EN", (String)fileData.get("NAME_EN"));//Ʊ��������֯Ӣ��
		billData.add("REG_USERID", personId);//Ʊ��¼����ID
		billData.add("REG_USERNAME", personName);//Ʊ��¼��������
		billData.add("REG_ORGID", deptId);//Ʊ��¼�������ڲ���ID
		billData.add("REG_DATE", curDate);//Ʊ��¼������
		
		try {
			
			//3 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//4 ִ�����ݿ⴦�����
			FileCommonManager fileCommonManager = new FileCommonManager();
			String adoptOrgId = (String)fileData.get("ADOPT_ORG_ID");//��֯��������
			String costType = (String)billData.get("COST_TYPE");//�������
			String billfileNo = "";//Ʊ����Ϣ���ı��
			int totalAfCost = 0;//Ʊ����Ϣ���ı��
			
			if ("".equals((String)billData.get("CHEQUE_ID")) || (String)billData.get("CHEQUE_ID")==null) {//�Ǽǲ���
				String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//���ɽɷѱ��
				billData.add("PAID_NO", paidNo);//�ɷѱ�ţ�Ʊ�ݱ�
				DataList dataList = new DataList();
				for(int i=0; i<dl.size(); i++){
					Data fdata = dl.getData(i);
					String file_no = fdata.getString("FILE_NO");//�ļ����
					billfileNo +=file_no + ","; 
					
					String af_cost = fdata.getString("AF_COST");//Ӧ�ɽ��ļ���
					totalAfCost+=Integer.parseInt(af_cost);
					
					Data fidata = new Data();
					fidata.add("AF_ID", fdata.getString("AF_ID"));//�ļ���Ϣ����
					fidata.add("PAID_NO", paidNo);//�ɷѱ�ţ��ļ���
					if("pjdjsubmit".equals(type)){
						fidata.add("AF_COST_PAID", "1");//�ύҵ��ʱ�ɷ�״̬Ϊ���ѽɷѡ�
					}
					dataList.add(handler.saveFile(conn, fidata, false));//�����ļ���Ϣҵ������
				}
				if(!"".equals(billfileNo) || billfileNo != ""){
					billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//Ʊ����Ϣ���ı��
					billData.add("PAID_SHOULD_NUM", totalAfCost);//Ӧ�ɽ�Ʊ�ݱ�
				}else{
					billData.add("PAID_SHOULD_NUM", "0");
				}
			}else{//�޸Ĳ���
				DataList dataList = new DataList();
				for(int i=0; i<dl.size(); i++){
					Data fdata = dl.getData(i);
					String file_no = fdata.getString("FILE_NO");//�ļ����
					billfileNo +=file_no + ",";
					
					String af_cost = fdata.getString("AF_COST");//Ӧ�ɽ��ļ���
					totalAfCost+=Integer.parseInt(af_cost);
					
					Data fidata = new Data();
					fidata.add("AF_ID", fdata.getString("AF_ID"));//�ļ���Ϣ����
					fidata.add("PAID_NO", (String)billData.get("PAID_NO"));//�ɷѱ�ţ��ļ���
					if("pjdjsubmit".equals(type)){
						fidata.add("AF_COST_PAID", "1");//�ύҵ��ʱ�ɷ�״̬Ϊ���ѽɷѡ�
					}
					dataList.add(handler.saveFile(conn, fidata, false));//�����ļ���Ϣҵ������
				}
				if(!"".equals(billfileNo) || billfileNo != ""){
					billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//Ʊ����Ϣ���ı��
					billData.add("PAID_SHOULD_NUM", totalAfCost);//Ӧ�ɽ�Ʊ�ݱ�
				}else{
					billData.add("FILE_NO", "");
					billData.add("PAID_SHOULD_NUM", "0");
				}
				billData.add("PAID_NO", (String)billData.get("PAID_NO"));//�ɷѱ�ţ�Ʊ�ݱ�
			}
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, adoptOrgId);
            String  syzzCnName = syzzDept.getSyzzCnName();//������֯��������
            String  syzzEnName = syzzDept.getSyzzEnName();//������֯Ӣ������
            billData.add("NAME_CN", syzzCnName);
            billData.add("NAME_EN", syzzEnName);
			billData = handler.saveBill(conn,billData);//����Ʊ��ҵ������
			
			DataList tranferDataList = new DataList();
			if("pjdjsubmit".equals(type)){//�Ǽ��ύ������Ʊ�ݴ��ƽ�����
				Data dataTemp = new Data();
				dataTemp.add("APP_ID", billData.getString("CHEQUE_ID"));
				dataTemp.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
				dataTemp.add("TRANSFER_STATE", "0");
				tranferDataList.add(dataTemp);			
				fileCommonManager.transferDetailInit(conn, tranferDataList);
			}
			
			dt.commit();
			if(type=="pjdjsubmit" || "pjdjsubmit".equals(type)){
				InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");//�ύ�ɹ� 0
				setAttribute("clueTo", clueTo);
			}else{
				InfoClueTo clueTo = new InfoClueTo(0, "����ɹ�!");//����ɹ� 0
				setAttribute("clueTo", clueTo);
			}
		
		} catch (DBException e) {
			//5 �����쳣����
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			setAttribute(Constants.ERROR_MSG_TITLE, "�����쳣");
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
						log.logError("Connection������쳣��δ�ܹر�",e);
					}
					e.printStackTrace();
				}
			}
		}
		setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * �޸�
	 * @author Panfeng
	 * @date 2014-11-19
	 * @return
	 */
	public String billRevise(){
		//1 ��ȡ��ϢID
		String uuid = getParameter("showuuid","");
		String file_no = getParameter("fileno","");
		String[] fileno = file_no.split(",");
		StringBuffer stringb = new StringBuffer();
		String wjbh = "";
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			for(int i=0; i<fileno.length; i++){
				stringb.append("'" + fileno[i] + "',");
			}
			wjbh = stringb.substring(0, stringb.length() - 1);
			DataList dl = handler.showFileList(conn, wjbh);//��ѯ�ļ���Ϣ�б�
			Data showdata = handler.getShowData(conn, uuid);//��ѯƱ����Ϣ
			//4 ��������鿴ҳ��
			
			// ����ѯ���ļ��б���õ�session��
			HttpSession session = getRequest().getSession();
			session.setAttribute("fileList", dl);
			
			setAttribute("fileList", dl);
			setAttribute("regData", showdata);
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
	 * @Title: billDelete 
	 * @Description: ɾ��δ�ύ��Ʊ����Ϣ
	 * @author: panfeng;
	 * @return    �趨�ļ� 
	 * @return String    �������� 
	 * @throws
	 */
	public String billDelete() {
		//1 ��ȡҳ�����
		//Ʊ��ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		//���ı��
		String file_no = getParameter("file_no", "");
		String[] fileNo = file_no.split(",");
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 ��ȡɾ�����
			success = handler.billDelete(conn, uuid);//ɾ��Ʊ��
			success = handler.fileUpdate(conn, fileNo);//�����ļ���Ϣ
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "Ʊ��ɾ�������쳣");
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
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * �ļ��ɷ�֪ͨ����ӡ
	 * @author Panfeng
	 * @date 2014-12-9
	 * @return
	 */
	public String billPrint(){
		//1 ��ȡ��ϢID
		String uuid = getParameter("printuuid","");
		String file_no = getParameter("fileno","");
		String[] fileno = file_no.split(",");
		StringBuffer stringb = new StringBuffer();
		String wjbh = "";
		try {
			//2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//3 ��ȡ��Ϣ�����
			for(int i=0; i<fileno.length; i++){
				stringb.append("'" + fileno[i] + "',");
			}
			wjbh = stringb.substring(0, stringb.length() - 1);
			DataList dl = handler.showFileList(conn, wjbh);//��ѯ�ļ���Ϣ�б�
			Data printData = handler.getBothData(conn, uuid);//��ѯƱ����Ϣ
			//��ȡƱ����ϼ���
//			Data sumData = handler.getSum(conn, wjbh);
//			printData.add("SUM", sumData.getString("SUM",""));
			//4 ��������鿴ҳ��
			
			setAttribute("fileList", dl);
			setAttribute("data", printData);
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
	
	
	
}
