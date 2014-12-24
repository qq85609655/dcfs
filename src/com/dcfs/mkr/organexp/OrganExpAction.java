package com.dcfs.mkr.organexp;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.common.ClientIPGetter;
import com.hx.upload.sdk.AttHelper;

/**
 * 
 * @Title: OrganExpAction.java
 * @Description: ��Ŀ���<br>
 *               <br>
 * @Company: 21softech
 * @Created on Dec 10, 2010 11:19:42 AM
 * @author lijie
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class OrganExpAction extends BaseAction {
	
	private static Log log = UtilLog.getLog(OrganExpAction.class);

	private OrganExpHandler handler;

	/**
	 * ��ʼ��
	 */
	public OrganExpAction() {
		handler = new OrganExpHandler();
	}
	
	/**
     * ������֯�������νṹ
     * @return
     */
    public String organExpTree(){
        Connection conn = null;
        //ʹ��CodeList��װ��ѯ��������֯��Ϣ������ͨ�õ��ֶ�CNAME ID PARENT_ID�����ֶ�
        CodeList dataList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
    		//��ѯ
    		dataList = handler.generateOrganTree(conn);
    		if(dataList!=null&&dataList.size()>0){
    			for(int i=0;i<dataList.size();i++){
    				dataList.get(i).setIcon("folder");
    			}
    		}
        } catch (Exception e) {
            log.logError("������֯��ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("������֯��ʱ�ر�Connection����!", e);
            }
        }
        setAttribute("dataList", dataList);
        if(dataList != null && dataList.size() > 0){
        	Code d = dataList.get(0);
        	setAttribute("CODE_ID", d.getValue());
        }
        return SUCCESS;
    }

	/**
	 * ��ҳ��ѯ
	 * @return
	 */
	public String organExpList() {
		/*****���򼰷�ҳ����**********************/
		String compositor = getParameter("compositor");
		if (compositor == null || compositor.equals("")) {
			compositor = "SEQ_NUM";
		}
		String ordertype = getParameter("ordertype");
		if (ordertype == null) {
			ordertype = "ASC";
		}
		/******�߼���д����***********************/
		
		String id = getParameter("ID");
		setAttribute("ID", id);
		
		Connection conn = null;
		DataList dataList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			
		} catch (Exception e) {
			log.logError("��ѯ��Ŀ���ʱ����!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("��ѯ��Ŀ���ʱ�ر�Connection����!", e);
			}
		}
		// �洢
		setAttribute("dataList", dataList);
		setAttribute("compositor", compositor);
        setAttribute("ordertype", ordertype);
		return SUCCESS;
	}
	
	/**
	 * �޸���֯����
	 * @return
	 */
	public String organModify(){
		String type = getParameter("type","");
		Data data = new Data();
        String id = getParameter("ID");
        Connection conn = null;
        CodeList FWXMList = new CodeList();
        CodeList GJList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            data = handler.findOrganModifyData(conn,id);
            
            //��ȡ���й�����Ϣ
            GJList = handler.findCountryList(conn);
            String codeId = "GJList";
            GJList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, GJList);
            setAttribute(Constants.CODE_LIST, map);
            
            //������Ŀ ���뼯
            FWXMList = handler.findCodesortListById(conn, "FWXM");
        } catch (Exception e) {
            log.logError("תȥ�޸���֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
            }
        }
        setAttribute("data", data);
        setAttribute("FWXMList", FWXMList);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return SUCCESS;
        }
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String organModifySubmit(){
		Connection conn = null;
		DBTransaction dbt = null;
		Data data = new Data();
		Map mkr = getDataWithPrefix("MKR_", false);
		Map org = getDataWithPrefix("ORG_", false);
		Data mkrData = new Data(mkr);
		Data orgData = new Data(org);
		CodeList FWXMList = new CodeList();
        CodeList GJList = new CodeList();
        boolean isResult=true;
        Data updateData = new Data();
        updateData.setEntityName("MKR_ORG_UPDATE");//����
		updateData.setPrimaryKey("ID");
		try {
			conn = ConnectionManager.getConnection();
			dbt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("MKR_ADOPT_ORG_INFO");
			mkrData.setPrimaryKey("ADOPT_ORG_ID");
			String[] ser = getParameterValues("MKR_SERVICE");
			StringBuffer serv = new StringBuffer();
			if(ser != null && ser.length > 0){
				for (String str : ser) {
					serv.append(str).append(",");
				}
			}
			String service = serv.toString();
			mkrData.add("SERVICE", service);
			
			if(mkrData.getString("ADOPT_ORG_ID") != null && !"".equals(mkrData.getString("ADOPT_ORG_ID")) && !"null".equalsIgnoreCase(mkrData.getString("ADOPT_ORG_ID"))){
				handler.modify(conn, mkrData);
				//���²���IDADOPT_ORG_ID
	    		updateData.add("CUI_ID", mkrData.getString("ADOPT_ORG_ID"));
			}else{
				mkrData.add("ADOPT_ORG_ID", orgData.getString("ID"));
				//���²���IDADOPT_ORG_ID
	    		updateData.add("CUI_ID", orgData.getString("ID"));
				//����״̬ δ����
				mkrData.add("RECORD_STATE", "0");
				handler.add(conn, mkrData);
			}
			
			orgData.setEntityName("PUB_ORGAN");
			orgData.setPrimaryKey("ID");
			handler.modify(conn, orgData);
			
			//�־û�����
			AttHelper.publishAttsOfPackageId(mkrData.getString("LOGO"), "AF");
			
			//�޸Ĳ鿴ҳ��׼������
			data = handler.findOrganModifyData(conn,orgData.getString("ID"));
            
            //��ȡ���й�����Ϣ
            GJList = handler.findCountryList(conn);
            String codeId = "GJList";
            GJList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, GJList);
            setAttribute(Constants.CODE_LIST, map);
            //������Ŀ ���뼯
            FWXMList = handler.findCodesortListById(conn, "FWXM");
            dbt.commit();
            //********�޸ĳɹ������¼�¼begin*******
    		//IP��ַ
    		String IP = ClientIPGetter.getInstance().getClientIP(this.getRequest());
    		updateData.add("IP_ADDR", IP);
    		//������
    		String RECORD_NAME = SessionInfo.getCurUser().getPerson().getCName();
    		updateData.add("OPERATOR", RECORD_NAME);
    		//����ʱ��
    		String curDate = DateUtility.getCurrentDate();
    		updateData.add("OPERATE_TIME",curDate);
    		if(isResult){
    			updateData.add("OPERATE_RESULT", "1");//0��ʧ��1���޸ĳɹ�
    		}else{
    			updateData.add("OPERATE_RESULT", "0");//0��ʧ��1���޸ĳɹ�
    		}
    		handler.add(conn, updateData);
		} catch (Exception e) {
			log.logError("תȥ�޸���֯ʱ����!", e);
			try {
				dbt.rollback();
				isResult=false;
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("תȥ�޸���֯ʱ��������ع�!", e);
			}
			if(isResult){
    			updateData.add("OPERATE_RESULT", "1");//0��ʧ��1���޸ĳɹ�
    		}else{
    			updateData.add("OPERATE_RESULT", "0");//0��ʧ��1���޸ĳɹ�
    		}
    		try {
				handler.add(conn, updateData);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", data);
        setAttribute("FWXMList", FWXMList);
		return SUCCESS;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String headerModifySubmit(){
		Connection conn = null;
		DBTransaction dbt = null;
		Data data = new Data();
		Map mkr = getDataWithPrefix("MKR_", false);
		Map org = getDataWithPrefix("ORG_", false);
		Data mkrData = new Data(mkr);
		Data orgData = new Data(org);
		try {
			conn = ConnectionManager.getConnection();
			dbt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("MKR_ORG_HEAD");
			mkrData.setPrimaryKey("ADOPT_ORG_ID");
			
			if(mkrData.getString("ADOPT_ORG_ID") != null && !"".equals(mkrData.getString("ADOPT_ORG_ID")) && !"null".equalsIgnoreCase(mkrData.getString("ADOPT_ORG_ID"))){
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("ADOPT_ORG_ID", orgData.getString("ID"));
				handler.add(conn, mkrData);
			}
			
			//�־û�����
			AttHelper.publishAttsOfPackageId(mkrData.getString("PHOTO"), "AF");
			
			//�޸Ĳ鿴ҳ��׼������
			data.setEntityName("MKR_ORG_HEAD");
            data.setPrimaryKey("ADOPT_ORG_ID");
            data.add("ADOPT_ORG_ID", orgData.getString("ID"));
            data = handler.findDataByKey(conn, data);
			dbt.commit();
		} catch (Exception e) {
			log.logError("תȥ�޸���֯ʱ����!", e);
			try {
				dbt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("תȥ�޸���֯ʱ��������ع�!", e);
			}
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", data);
		setAttribute("ID", orgData.getString("ID"));
		return SUCCESS;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String branchModifySubmit(){
		Connection conn = null;
		Map mkr = getDataWithPrefix("MKR_", false);
		Data mkrData = new Data(mkr);
		try {
			conn = ConnectionManager.getConnection();
			mkrData.setEntityName("MKR_ORG_BRANCH");
			mkrData.setPrimaryKey("ID");
			//String BRIEF_RESUME = mkrData.getString("INTRODUCTION_INFO");  //�������
			if(mkrData.getString("ID") != null && !"".equals(mkrData.getString("ID")) && !"null".equalsIgnoreCase(mkrData.getString("ID"))){
				handler.modify(conn, mkrData);
				//handler.modify_clob(conn,mkrData.getString("ID"),BRIEF_RESUME);
			}else{
				mkrData.add("ID", mkrData.getString("ID"));
				mkrData.add("CREATE_TIME", new SimpleDateFormat("yyyy-MM-dd mm:HH:ss").format(Calendar.getInstance().getTime()));
				Data da = handler.add(conn, mkrData);
				//handler.modify_clob(conn,da.getString("ID"),BRIEF_RESUME);
			}
			
		} catch (Exception e) {
			log.logError("תȥ�޸���֯ʱ����!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", mkrData);
		setAttribute("ADOPT_ORG_ID", mkrData.getString("ADOPT_ORG_ID"));
        setAttribute("ID", mkrData.getString("ID"));
		return SUCCESS;
	}
	
	//��ת���հ�ҳ��
	public String organNull(){
		Data branch = new Data();
		branch = (Data)getAttribute("data");
		setAttribute("data", branch);
		return SUCCESS;
	}
	
	public String branchOrganList(){
		String type = getParameter("type","");
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        
        String id = getParameter("ADOPT_ORG_ID");

        Connection conn = null;
        //Data branch = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            dataList = handler.findBranchOrganList(conn ,id, pageSize, page,orderString);
            
/*            if(branchId != null && !"".equals(branchId)){
            	branch.setEntityName("MKR_ORG_BRANCH");
            	branch.setPrimaryKey("ADOPT_ORG_ID");
            	branch.add("ADOPT_ORG_ID", branchId);
            	branch = handler.findDataByKey(conn, branch);
            }
*/        } catch (Exception e) {
            log.logError("��ѯ��֧����ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ��֧����ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ADOPT_ORG_ID", id);
        //setAttribute("data", branch==null?new Data():branch);
        //����
        setAttribute("dataList", dataList);
        if(type.equals("shb")){
        	return "shb";
        }else{	
        	return SUCCESS;
        }
	}
	
	public String deleteBranch(){
		//��ҳ��ʾ
		int pageSize = 5;
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		
		/************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
		
		String id = getParameter("ADOPT_ORG_ID");
		String branchId = getParameter("ID");
		
		Connection conn = null;
		DBTransaction dbt = null;
 		//Data branch = new Data();
		DataList dataList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			dbt = DBTransaction.getInstance(conn);
			
			//ɾ��branch
			if(branchId != null && !"".equals(branchId)){
				Data data = new Data();
				data.setEntityName("MKR_ORG_BRANCH");
				data.setPrimaryKey("ID");
				data.add("ID", branchId);
				handler.delete(conn, data);
			}
			
			dataList = handler.findBranchOrganList(conn ,id, pageSize, page,orderString);
			
			dbt.commit();
		} catch (Exception e) {
			log.logError("��ѯ��֧����ʱ����!", e);
			try {
				dbt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("��ѯ��֧����ʱ�ر�Connection����!", e);
			}
		}
		//��֯����ID
		setAttribute("ADOPT_ORG_ID", id);
		//setAttribute("data", branch==null?new Data():branch);
		//����
		setAttribute("dataList", dataList);
		return SUCCESS;
	}
	
	public String branchModify(){
		String type = getParameter("type","");
		Data branch = new Data();
        String branchId = getParameter("ID");
        String orgId = getParameter("ADOPT_ORG_ID");
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            if(branchId != null && !"".equals(branchId)){
            	branch.setEntityName("MKR_ORG_BRANCH");
            	branch.setPrimaryKey("ID");
            	branch.add("ID", branchId);
            	branch = handler.findDataByKey(conn, branch);
            }
        } catch (Exception e) {
            log.logError("תȥ�޸���֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
            }
        }
        setAttribute("data", branch==null?new Data():branch);
        setAttribute("ADOPT_ORG_ID", orgId);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return SUCCESS;
        }
	}
	
	public String headerModify(){
		String type = getParameter("type","");
		Data data = new Data();
        String id = getParameter("ID");
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            data.setEntityName("MKR_ORG_HEAD");
            data.setPrimaryKey("ADOPT_ORG_ID");
            data.add("ADOPT_ORG_ID", id);
            data = handler.findDataByKey(conn, data);
        } catch (Exception e) {
            log.logError("תȥ�޸���֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
            }
        }
        setAttribute("data", data!=null?data:new Data());
        setAttribute("ID", id);
        if(type.equals("shb")){
        	return "shb";
        }else{
        	return SUCCESS;
        }
	}
	
	public String isOrgan(){
		String orgId = getParameter("ID");
		Connection conn = null;
		try {
			conn = ConnectionManager.getConnection();
			DataList dataList = handler.isOrganList(conn, orgId);
			StringBuffer json = new StringBuffer();
			if(dataList != null && dataList.size() > 0){
				json.append("{\"flag\":\"").append(1).append("\"}");
			}
			getResponse().reset();
			getResponse().setContentType("text/html;charset="+getRequest().getCharacterEncoding());
			getResponse().getWriter().println(json.toString());
    		getResponse().getWriter().flush();
    		getResponse().getWriter().close();
		} catch (Exception e) {
			log.logError("תȥ�޸���֯ʱ����!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
			}
		}
		return null;
	}

	//**********����ά��Ӣ�İ�*********
	
	public String organExpListEn() {
		/*****���򼰷�ҳ����**********************/
		String compositor = getParameter("compositor");
		if (compositor == null || compositor.equals("")) {
			compositor = "SEQ_NUM";
		}
		String ordertype = getParameter("ordertype");
		if (ordertype == null) {
			ordertype = "ASC";
		}
		/******�߼���д����***********************/
		
		UserInfo user = SessionInfo.getCurUser();
		String ID = user.getCurOrgan().getId();  //��֯����ID
		setAttribute("ID", ID);
		
		Connection conn = null;
		DataList dataList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			
		} catch (Exception e) {
			log.logError("��ѯ��Ŀ���ʱ����!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("��ѯ��Ŀ���ʱ�ر�Connection����!", e);
			}
		}
		// �洢
		setAttribute("dataList", dataList);
		setAttribute("compositor", compositor);
        setAttribute("ordertype", ordertype);
		return SUCCESS;
	}
	
	public String organModifyEn(){
		Data data = new Data();
        String id = getParameter("ID");
        Connection conn = null;
        CodeList FWXMList = new CodeList();
        CodeList GJList = new CodeList();
        try {
            conn = ConnectionManager.getConnection();
            data = handler.findOrganModifyData(conn,id);
            
            //��ȡ���й�����Ϣ
            GJList = handler.findCountryList(conn);
            String codeId = "GJList";
            GJList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, GJList);
            setAttribute(Constants.CODE_LIST, map);
            
            //������Ŀ ���뼯
            FWXMList = handler.findCodesortListById(conn, "FWXM");
        } catch (Exception e) {
            log.logError("תȥ�޸���֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
            }
        }
        setAttribute("data", data);
        setAttribute("FWXMList", FWXMList);
        return SUCCESS;
	}
   
	public String organModifySubmitEn(){
		Connection conn = null;
		DBTransaction dbt = null;
		Data data = new Data();
		Map mkr = getDataWithPrefix("MKR_", false);
		Map org = getDataWithPrefix("ORG_", false);
		Data mkrData = new Data(mkr);
		Data orgData = new Data(org);
		CodeList FWXMList = new CodeList();
        CodeList GJList = new CodeList();
        boolean isResult=true;
        Data updateData = new Data();
        updateData.setEntityName("MKR_ORG_UPDATE");//����
		updateData.setPrimaryKey("ID");
		try {
			conn = ConnectionManager.getConnection();
			dbt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("MKR_ADOPT_ORG_INFO");
			mkrData.setPrimaryKey("ADOPT_ORG_ID");
			String[] ser = getParameterValues("MKR_SERVICE");
			StringBuffer serv = new StringBuffer();
			if(ser != null && ser.length > 0){
				for (String str : ser) {
					serv.append(str).append(",");
				}
			}
			String service = serv.toString();
			mkrData.add("SERVICE", service);
			
			if(mkrData.getString("ADOPT_ORG_ID") != null && !"".equals(mkrData.getString("ADOPT_ORG_ID")) && !"null".equalsIgnoreCase(mkrData.getString("ADOPT_ORG_ID"))){
				handler.modify(conn, mkrData);
				//���²���IDADOPT_ORG_ID
	    		updateData.add("CUI_ID", mkrData.getString("ADOPT_ORG_ID"));
			}else{
				mkrData.add("ADOPT_ORG_ID", orgData.getString("ID"));
				//���²���IDADOPT_ORG_ID
	    		updateData.add("CUI_ID", orgData.getString("ID"));
				//����״̬ δ����
				mkrData.add("RECORD_STATE", "0");
				handler.add(conn, mkrData);
			}
			
			orgData.setEntityName("PUB_ORGAN");
			orgData.setPrimaryKey("ID");
			handler.modify(conn, orgData);
			
			//�־û�����
			AttHelper.publishAttsOfPackageId(mkrData.getString("LOGO"), "AF");
			
			//�޸Ĳ鿴ҳ��׼������
			data = handler.findOrganModifyData(conn,orgData.getString("ID"));
            
            //��ȡ���й�����Ϣ
            GJList = handler.findCountryList(conn);
            String codeId = "GJList";
            GJList.setCodeSortId(codeId);
            HashMap<String, CodeList> map = new HashMap<String, CodeList>();
            map.put(codeId, GJList);
            setAttribute(Constants.CODE_LIST, map);
            //������Ŀ ���뼯
            FWXMList = handler.findCodesortListById(conn, "FWXM");
            dbt.commit();
            //********�޸ĳɹ������¼�¼begin*******
    		//IP��ַ
    		String IP = ClientIPGetter.getInstance().getClientIP(this.getRequest());
    		updateData.add("IP_ADDR", IP);
    		//������
    		String RECORD_NAME = SessionInfo.getCurUser().getPerson().getCName();
    		updateData.add("OPERATOR", RECORD_NAME);
    		//����ʱ��
    		String curDate = DateUtility.getCurrentDate();
    		updateData.add("OPERATE_TIME",curDate);
    		if(isResult){
    			updateData.add("OPERATE_RESULT", "1");//0��ʧ��1���޸ĳɹ�
    		}else{
    			updateData.add("OPERATE_RESULT", "0");//0��ʧ��1���޸ĳɹ�
    		}
    		handler.add(conn, updateData);
		} catch (Exception e) {
			log.logError("תȥ�޸���֯ʱ����!", e);
			try {
				dbt.rollback();
				isResult=false;
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("תȥ�޸���֯ʱ��������ع�!", e);
			}
			if(isResult){
    			updateData.add("OPERATE_RESULT", "1");//0��ʧ��1���޸ĳɹ�
    		}else{
    			updateData.add("OPERATE_RESULT", "0");//0��ʧ��1���޸ĳɹ�
    		}
    		try {
				handler.add(conn, updateData);
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		}finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", data);
        setAttribute("FWXMList", FWXMList);
		return SUCCESS;
	}

	public String branchOrganListEn(){
		//��ҳ��ʾ
        int pageSize = 5;
        int page = getNowPage();
        if(page == 0){
            page = 1;
        }
        
        /************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
        
        String id = getParameter("ADOPT_ORG_ID");

        Connection conn = null;
        //Data branch = new Data();
        DataList dataList = new DataList();
        try {
            conn = ConnectionManager.getConnection();
            dataList = handler.findBranchOrganList(conn ,id, pageSize, page,orderString);
            
/*            if(branchId != null && !"".equals(branchId)){
            	branch.setEntityName("MKR_ORG_BRANCH");
            	branch.setPrimaryKey("ADOPT_ORG_ID");
            	branch.add("ADOPT_ORG_ID", branchId);
            	branch = handler.findDataByKey(conn, branch);
            }
*/        } catch (Exception e) {
            log.logError("��ѯ��֧����ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("��ѯ��֧����ʱ�ر�Connection����!", e);
            }
        }
        //��֯����ID
        setAttribute("ADOPT_ORG_ID", id);
        //setAttribute("data", branch==null?new Data():branch);
        //����
        setAttribute("dataList", dataList);
        return SUCCESS;
	}
	
	public String branchModifyEn(){
		Data branch = new Data();
        String branchId = getParameter("ID");
        String orgId = getParameter("ADOPT_ORG_ID");
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            if(branchId != null && !"".equals(branchId)){
            	branch.setEntityName("MKR_ORG_BRANCH");
            	branch.setPrimaryKey("ID");
            	branch.add("ID", branchId);
            	branch = handler.findDataByKey(conn, branch);
            }
        } catch (Exception e) {
            log.logError("תȥ�޸���֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
            }
        }
        setAttribute("data", branch==null?new Data():branch);
        setAttribute("ADOPT_ORG_ID", orgId);
        return SUCCESS;
	}
	
	public String deleteBranchEn(){
		//��ҳ��ʾ
		int pageSize = 5;
		int page = getNowPage();
		if(page == 0){
			page = 1;
		}
		
		/************��ȡ���ݿ������ʾ--��ʼ***************/
		String compositor=getParameter("compositor");
		setAttribute("compositor", compositor);
		if(compositor==null || "".equals(compositor)){
			compositor="CREATE_TIME";
		}
		String ordertype=getParameter("ordertype");
		setAttribute("ordertype", ordertype);
		if(ordertype==null || "".equals(ordertype)){
			ordertype="DESC";
		}
		String orderString = compositor + " " + ordertype;
		/************��ȡ���ݿ������ʾ--����***************/
		
		String id = getParameter("ADOPT_ORG_ID");
		String branchId = getParameter("ID");
		
		Connection conn = null;
		DBTransaction dbt = null;
 		//Data branch = new Data();
		DataList dataList = new DataList();
		try {
			conn = ConnectionManager.getConnection();
			dbt = DBTransaction.getInstance(conn);
			
			//ɾ��branch
			if(branchId != null && !"".equals(branchId)){
				Data data = new Data();
				data.setEntityName("MKR_ORG_BRANCH");
				data.setPrimaryKey("ID");
				data.add("ID", branchId);
				handler.delete(conn, data);
			}
			
			dataList = handler.findBranchOrganList(conn ,id, pageSize, page,orderString);
			
			dbt.commit();
		} catch (Exception e) {
			log.logError("��ѯ��֧����ʱ����!", e);
			try {
				dbt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("��ѯ��֧����ʱ�ر�Connection����!", e);
			}
		}
		//��֯����ID
		setAttribute("ADOPT_ORG_ID", id);
		//setAttribute("data", branch==null?new Data():branch);
		//����
		setAttribute("dataList", dataList);
		return SUCCESS;
	}
	
	public String branchModifySubmitEn(){
		Connection conn = null;
		Map mkr = getDataWithPrefix("MKR_", false);
		Data mkrData = new Data(mkr);
		try {
			conn = ConnectionManager.getConnection();
			mkrData.setEntityName("MKR_ORG_BRANCH");
			mkrData.setPrimaryKey("ID");
			//String BRIEF_RESUME = mkrData.getString("INTRODUCTION_INFO");  //�������
			if(mkrData.getString("ID") != null && !"".equals(mkrData.getString("ID")) && !"null".equalsIgnoreCase(mkrData.getString("ID"))){
				handler.modify(conn, mkrData);
				//handler.modify_clob(conn,mkrData.getString("ID"),BRIEF_RESUME);
			}else{
				mkrData.add("ID", mkrData.getString("ID"));
				mkrData.add("CREATE_TIME", new SimpleDateFormat("yyyy-MM-dd mm:HH:ss").format(Calendar.getInstance().getTime()));
				Data da = handler.add(conn, mkrData);
				//handler.modify_clob(conn,da.getString("ID"),BRIEF_RESUME);
			}
			
		} catch (Exception e) {
			log.logError("תȥ�޸���֯ʱ����!", e);
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", mkrData);
		setAttribute("ADOPT_ORG_ID", mkrData.getString("ADOPT_ORG_ID"));
        setAttribute("ID", mkrData.getString("ID"));
		return SUCCESS;
	}
	
	//��ת���հ�ҳ��
	public String organNullEn(){
		Data branch = new Data();
		branch = (Data)getAttribute("data");
		setAttribute("data", branch);
		return SUCCESS;
	}
		
	public String headerModifyEn(){
		Data data = new Data();
        String id = getParameter("ID");
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            data.setEntityName("MKR_ORG_HEAD");
            data.setPrimaryKey("ADOPT_ORG_ID");
            data.add("ADOPT_ORG_ID", id);
            data = handler.findDataByKey(conn, data);
        } catch (Exception e) {
            log.logError("תȥ�޸���֯ʱ����!", e);
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
            }
        }
        setAttribute("data", data!=null?data:new Data());
        setAttribute("ID", id);
        return SUCCESS;
	}
	
	public String headerModifySubmitEn(){
		Connection conn = null;
		DBTransaction dbt = null;
		Data data = new Data();
		Map mkr = getDataWithPrefix("MKR_", false);
		Map org = getDataWithPrefix("ORG_", false);
		Data mkrData = new Data(mkr);
		Data orgData = new Data(org);
		try {
			conn = ConnectionManager.getConnection();
			dbt = DBTransaction.getInstance(conn);
			mkrData.setEntityName("MKR_ORG_HEAD");
			mkrData.setPrimaryKey("ADOPT_ORG_ID");
			
			if(mkrData.getString("ADOPT_ORG_ID") != null && !"".equals(mkrData.getString("ADOPT_ORG_ID")) && !"null".equalsIgnoreCase(mkrData.getString("ADOPT_ORG_ID"))){
				handler.modify(conn, mkrData);
			}else{
				mkrData.add("ADOPT_ORG_ID", orgData.getString("ID"));
				handler.add(conn, mkrData);
			}
			
			//�־û�����
			AttHelper.publishAttsOfPackageId(mkrData.getString("PHOTO"), "AF");
			
			//�޸Ĳ鿴ҳ��׼������
			data.setEntityName("MKR_ORG_HEAD");
            data.setPrimaryKey("ADOPT_ORG_ID");
            data.add("ADOPT_ORG_ID", orgData.getString("ID"));
            data = handler.findDataByKey(conn, data);
			dbt.commit();
		} catch (Exception e) {
			log.logError("תȥ�޸���֯ʱ����!", e);
			try {
				dbt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
				log.logError("תȥ�޸���֯ʱ��������ع�!", e);
			}
		} finally {
			try {
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				log.logError("תȥ�޸���֯ʱ�ر�Connection����!", e);
			}
		}
		setAttribute("data", data);
		setAttribute("ID", orgData.getString("ID"));
		return SUCCESS;
	}
	
	
	//������֯:����ά��
	public String organSyzzMaintain(){
			/*****���򼰷�ҳ����**********************/
			String compositor = getParameter("compositor");
			if (compositor == null || compositor.equals("")) {
				compositor = "SEQ_NUM";
			}
			String ordertype = getParameter("ordertype");
			if (ordertype == null) {
				ordertype = "ASC";
			}
			/******�߼���д����***********************/
			String id = SessionInfo.getCurUser().getCurOrgan().getId();
			setAttribute("ID", id);
			
			Connection conn = null;
			DataList dataList = new DataList();
			try {
				conn = ConnectionManager.getConnection();
				
			} catch (Exception e) {
				log.logError("��ѯ��Ŀ���ʱ����!", e);
			} finally {
				try {
					if (conn != null && !conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					log.logError("��ѯ��Ŀ���ʱ�ر�Connection����!", e);
				}
			}
			// �洢
			setAttribute("dataList", dataList);
			setAttribute("compositor", compositor);
	        setAttribute("ordertype", ordertype);
			return SUCCESS;
	}
	/**
     * δʵ��:Ĭ�ϵ��ò�ѯ(query)����
     */
    public String execute() throws Exception {
        return organExpList();
    }
}
