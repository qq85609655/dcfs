/**
 * @Title: ChildManagerAction.java
 * @Package com.dcfs.cms.childManager
 * @Description: ��ͯ������Ϣ�����࣬�����ͯ���ϵ�¼�롢���͡�
 * @author wangzheng   
 * @project DCFS 
 * @date 2014-9-3
 * @version V1.0   
 */
package com.dcfs.cms.childManager;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;

import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import hx.common.Exception.DBException;
import hx.common.Constants;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.InfoClueTo;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childAdditional.ChildAdditionHandler;
import com.dcfs.cms.childReturn.ChildReturnHandler;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.dcfs.common.transfercode.TransferCode;
import com.dcfs.ffs.common.FileCommonManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;

public class ChildManagerAction extends BaseAction {

	private static Log log = UtilLog.getLog(ChildManagerAction.class);

	private ChildManagerHandler handler;

	private ChildCommonManager manager;

	private Connection conn = null;// ���ݿ�����

	private DBTransaction dt = null;// ������

	private String retValue = SUCCESS;

	public ChildManagerAction() {
		this.handler = new ChildManagerHandler();
		this.manager = new ChildCommonManager();
	}

	public String execute() throws Exception {
		return null;
	}

	/**
	 * ��ͯ���ϼ�¼��ѯ
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return
	 */
	public String findList() {
		// 1 �趨����
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
		setAttribute("clueTo", clueTo);// set�����������

		// 2 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 2.2 ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}
		// 2.3 ��ȡ�б����
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");

		// ���û�д���listType��ֱ�ӷ��ش���
		if ("".equals(listType)) {
			String s = "��������";
			clueTo = new InfoClueTo(0, s);
			setAttribute("clueTo", clueTo); // set�����������
			retValue = "error";
			return retValue;
		} else {
			retValue = listType;
		}

		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String orgCode = organ.getOrgCode();

		// 3 ��ȡ��������
		Data data = getRequestEntityData("S_", "PROVINCE_ID", // ʡ��
				"WELFARE_ID", // ����Ժid
				"WELFARE_NAME_CN", // ����Ժ����
				"NAME", // ����
				"SEX", // �Ա�
				"CHILD_TYPE", // ��ͯ����
				"SN_TYPE", // ��������
				"CHILD_STATE", // ��ѯ״̬
				"PUB_STATE", // ����״̬
				"MATCH_STATE", // ƥ��״̬
				"BIRTHDAY_START", // ��������_��ʼ����
				"BIRTHDAY_END", // ��������
				"CHECKUP_DATE_START", // �������_��ʼ����
				"CHECKUP_DATE_END", // �������_��������
				"IS_PLAN", // ����ƻ�
				"IS_HOPE", // ϣ��֮��
				"REG_USERNAME", // �Ǽ���
				"REG_DATE_START", // �Ǽ�����_��ʼ����
				"REG_DATE_END", // �Ǽ�����_��������
				"POST_DATE_START", // ��������_��ʼ����
				"POST_DATE_END", // ��������_��������
				"RECEIVE_DATE_START", // ��������_��ʼ����
				"RECEIVE_DATE_END", // ��������_��������
				"UPDATE_NUM_START", // ���´���_��ʼ����
				"UPDATE_NUM_END", // ���´���_��������
				"SEND_DATE_START", // ��������_��ʼ����
				"SEND_DATE_END"); // ��������_��������
		// ����ύ״̬Ϊ��������Ĭ�ϵ��ύ״̬Ϊ��δ�ύ��������ύ״̬Ϊ��-1��������ǲ�ѯȫ�����򽫲�ѯ�����е��ύ״̬��Ϊnull
		String CHILD_STATE = data.getString("CHILD_STATE", null);
		if (CHILD_STATE == null) {
			data.add("CHILD_STATE", "0");
		} else if ("-1".equals(CHILD_STATE)) {
			data.add("CHILD_STATE", null);
		}
		// ��ͯ���״̬ת��
		String childState = this.getChildAudState(
				data.getString("CHILD_STATE"), listType);
		data.put("AUD_STATE", childState);

		String orgType = String.valueOf(organ.getOrgType());
		// ��¼��Ϊ����Ժ�û�
		if (ChildInfoConstants.ORGAN_TYPE_FLY.equals(orgType)) {
			data.put("WELFARE_ID", orgCode);
		}

		// �ж��Ƿ��¼
		if ("CMS_AZB_DL_LIST".equals(listType)) {
			// ���ò���¼
			data.put("IS_DAILU", ChildInfoConstants.LEVEL_CCCWA);
		}

		// 3.1 �趨�б�Ĭ����������

		// 3.2������������

		try {
			// 4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 5 ��ȡ����DataList
			DataList dl = handler.findList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 �������д��ҳ����ձ���
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			setAttribute("listType", listType);

		} catch (DBException e) {
			// 7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			// 8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ�����ۺϲ�ѯ
	 * 
	 * @author wangzheng
	 * @date 2014-11-12
	 * @return
	 */
	public String azbChildInfoSynQuery() {
		// 1 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 1.1 ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "REG_DATE";
		}
		// 1.2 ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}

		// 3 ��ȡ��������
		Data data = getRequestEntityData("S_", "PROVINCE_ID", // ʡ��
				"WELFARE_ID", // ����Ժid
				"WELFARE_NAME_CN", // ����Ժ����
				"NAME", // ����
				"SEX", // �Ա�
				"CHILD_TYPE", // ��ͯ����
				"SN_TYPE", // ��������
				"MATCH_STATE", // ƥ��״̬
				"BIRTHDAY_START", // ��������_��ʼ����
				"BIRTHDAY_END", // ��������
				"CHECKUP_DATE_START", // �������_��ʼ����
				"CHECKUP_DATE_END", // �������_��������
				"IS_OVERAGE", // �����ʶ
				"CI_GLOBAL_STATE"); // ��ͯ����ȫ��״̬

		try {
			// 4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 5 ��ȡ����DataList
			DataList dl = handler.ChildInfoSynQuery(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 �������д��ҳ����ձ���
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);

		} catch (DBException e) {
			// 7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			// 8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * ʡ����ͯ���ϴ�¼��ѯ�б�
	 * 
	 * @author wangzheng
	 * @date 2014-9-21
	 * @return
	 */
	public String stDailuList() {
		// 1 �趨����
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
		setAttribute("clueTo", clueTo);// set�����������

		// 2 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "REG_DATE";
		}
		// 2.2 ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}
		// 2.3 ��ȡ�б����
		String listType = "CMS_ST_DL_LIST";
		retValue = listType;

		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String PROVINCE_ID = organ.getOrgCode();

		// 3 ��ȡ��������
		Data data = getRequestEntityData("S_", "WELFARE_NAME_CN", "NAME",
				"SEX", "CHILD_TYPE", "SN_TYPE", "CHILD_STATE",
				"BIRTHDAY_START", "BIRTHDAY_END", "CHECKUP_DATE_START",
				"CHECKUP_DATE_END", "REG_USERNAME", "REG_DATE_START",
				"REG_DATE_END");
		String childState = this.getChildAudState(
				data.getString("CHILD_STATE"), listType);
		data.put("AUD_STATE", childState);
		data.put("PROVINCE_ID", PROVINCE_ID);
		data.put("IS_DAILU", ChildStateManager.CHILD_DAILU_FLAG_PROVINCE);
		// 3.1 �趨�б�Ĭ����������

		// 3.2������������

		try {
			// 4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 5 ��ȡ����DataList
			DataList dl = handler.findList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 �������д��ҳ����ձ���
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			// setAttribute("listType",listType);
		} catch (DBException e) {
			// 7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					retValue = "error";
				}
			}
		}
		return retValue;
	}

	/**
	 * ʡ����˼��Ͳ�ѯ�б�
	 * 
	 * @return
	 */
	public String STAuditList() {

		// 1 �趨����
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
		setAttribute("clueTo", clueTo);// set�����������

		// 2 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 2.2 ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}

		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String orgCode = organ.getOrgCode();
		ChildCommonManager ccm = new ChildCommonManager();
		String proviceId = ccm.getProviceId(orgCode);

		// 3 ��ȡ��������
		Data data = getRequestEntityData("S_", "WELFARE_ID", "NAME", "SEX",
				"CHILD_TYPE", "SN_TYPE", "CHILD_STATE", "BIRTHDAY_START",
				"BIRTHDAY_END", "CHECKUP_DATE_START", "CHECKUP_DATE_END",
				"IS_PLAN", "IS_HOPE", "SEND_DATE_START", "SEND_DATE_END",
				"POST_DATE_START", "POST_DATE_END", "RECEIVE_DATE_START",
				"RECEIVE_DATE_END", "AUDIT_DATE_START", "AUDIT_DATE_END");
		String childState = this.getChildAudState(
				data.getString("CHILD_STATE"), "CMS_ST_SHJS_LIST");
		data.put("AUD_STATE", childState);
		data.put("PROVINCE_ID", proviceId);

		try {
			// 4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 5 ��ȡ����DataList
			DataList dl = handler.STAuditList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 �������д��ҳ����ձ���
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			retValue = "CMS_ST_SHJS_LIST";

		} catch (DBException e) {
			// 7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					retValue = "error";
				}
			}
		}
		return retValue;
	}

	/**
	 * ���ò������б�
	 * 
	 * @author wangzheng
	 * @date 2014-9-19
	 * @return
	 */
	public String azbReceiveList() {
		// 1 �趨����
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
		setAttribute("clueTo", clueTo);// set�����������

		// 2 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "POST_DATE";
		}
		// 2.2 ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}

		// 3 ��ȡ��������
		Data data = getRequestEntityData("S_", "PROVINCE_ID", "WELFARE_ID",
				"POST_DATE_START", "POST_DATE_END", "NAME", "SEX",
				"BIRTHDAY_START", "BIRTHDAY_END", "CHILD_TYPE", "SN_TYPE",
				"CHECKUP_DATE_START", "CHECKUP_DATE_END", "IS_PLAN", "IS_HOPE",
				"RECEIVE_STATE", "RECEIVE_DATE_START", "RECEIVE_DATE_END");

		// 3.1 �趨�б�Ĭ����������

		// 3.2������������

		try {
			// 4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 5 ��ȡ����DataList
			DataList dl = handler.childReceiveList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 �������д��ҳ����ձ���
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);

		} catch (DBException e) {
			// 7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			// 8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * ���ò���˲�ѯ�б�
	 * 
	 * @return
	 */
	public String azbAuditList() {

		// 1 �趨����
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
		setAttribute("clueTo", clueTo);// set�����������

		// 2 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 2.2 ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}
		// 2.3 ��ö�ͯ���
		String CHILD_TYPE = (String) getParameter("CHILD_TYPE", "");
		if ("".equals(CHILD_TYPE)) {
			CHILD_TYPE = (String) getAttribute("CHILD_TYPE");
		}
		// 3 ��ȡ��������
		Data data = getRequestEntityData("S_", "PROVINCE_ID", "WELFARE_ID",
				"NAME", "SEX", "BIRTHDAY_START", "BIRTHDAY_END",
				"CHECKUP_DATE_START", "CHECKUP_DATE_END", "SN_TYPE",
				"DISEASE_CN", "HAVE_VIDEO", "SPECIAL_FOCUS", "IS_HOPE",
				"IS_PLAN", "RECEIVE_DATE_START", "RECEIVE_DATE_END",
				"PUB_STATE", "AUD_STATE", "MATCH_STATE", "TRANSLATION_STATE");
		data.put("CHILD_TYPE", CHILD_TYPE);
		if (ChildInfoConstants.CHILD_TYPE_NORMAL.equals(CHILD_TYPE)) {// ������ͯ
			retValue = "CMS_AZB_ZCSH_LIST";
		} else if (ChildInfoConstants.CHILD_TYPE_SPECAL.equals(CHILD_TYPE)) {// �����ͯ
			retValue = "CMS_AZB_TXSH_LIST";
		} else {// ��������
			retValue = "error";
			return retValue;
		}

		try {
			// 4 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 5 ��ȡ����DataList
			DataList dl = handler.AZBAuditList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 �������д��ҳ����ձ���
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
		} catch (DBException e) {
			// 7 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 8 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					retValue = "error";
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ���Ϸ����б�
	 * 
	 * @author wangzheng
	 * @date 2014-10-16
	 * @return
	 */
	public String childTranslationList() {
		return retValue;
	}

	/**
	 * ��ͯ�������
	 * 
	 * @author wangzheng
	 * @date 2014-9-16
	 * @return
	 */
	public String childInfoAudit() {
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		String level = getParameter("level", "");
		if ("".equals(uuid)) {
			level = (String) this.getAttribute("level");
		}
		if (ChildInfoConstants.LEVEL_CCCWA.equals(level)) {
			retValue = "CMS_ZX_CLSH_AUDIT";
		} else if (ChildInfoConstants.LEVEL_PROVINCE.equals(level)) {
			retValue = "CMS_ST_SHJS_AUDIT";
		}

		try {
			conn = ConnectionManager.getConnection();
			Data data = handler.getChildInfoAuditData(conn, uuid);
			setAttribute("data", data);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							data.getString("CHILD_IDENTITY"),
							data.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			setAttribute("uploadParameter", xmlstr);

		} catch (DBException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;

	}

	/**
	 * ��ͯ������˱����ύ
	 * 
	 * @author wangzheng
	 * @date 2014-9-16
	 * @return
	 * 
	 */
	public String childInfoAuditSave() {

		// 1 ���ҳ������ݣ��������ݽ����
		// 1.1��ö�ͯ������Ϣ
		Data cdata = getRequestEntityData("P_", "CI_ID", "PROVINCE_ID",
				"WELFARE_ID", "NAME", "SEX", "BIRTHDAY", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_EN",
				"SENDER_ADDR", "PICKUP_DATE", "ENTER_DATE", "SEND_DATE",
				"IS_ANNOUNCEMENT", "ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE",
				"IS_HOPE", "IS_PLAN", "DISEASE_CN", "REMARKS", "AUD_STATE",
				"FILE_CODE", "FILE_CODE_EN", "CHILD_TYPE", "SPECIAL_FOCUS",
				"SN_DEGREE", "NAME_PINYIN");

		// 1.2��ò��������Ϣ
		Data adata = getRequestEntityData("A_", "CA_ID", "AUDIT_LEVEL",
				"AUDIT_OPTION", "AUDIT_CONTENT", "AUDIT_DATE", "AUDIT_REMARKS");
		// 1.3��ñ�������ʶ
		String OPERATION_STATE = this.getParameter("state");
		adata.put("OPERATION_STATE", OPERATION_STATE);// ������
		// 1.4���ݲ�����ʶ����˼����ò������״̬
		ChildStateManager csm = new ChildStateManager();
		String AUD_STATE = csm.getChildAudState(cdata.getString("AUD_STATE"),
				adata.getString("AUDIT_LEVEL"),
				adata.getString("AUDIT_OPTION"), OPERATION_STATE);
		cdata.put("AUD_STATE", AUD_STATE);

		// 1.5 �����Ա��Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		adata.put("AUDIT_USERID", curuser.getPerson().getPersonId());
		adata.put("AUDIT_USERNAME", curuser.getPerson().getCName());

		// 1.6 ��ò��ϲ�����Ϣ
		Data adddata = getRequestEntityData("ADD_", "NOTICE_CONTENT",
				"IS_MODIFY", "IS_FLY", "IS_ST");
		// 1.7���ò�����������Ϣ
		/*
		 * if(ChildStateManager.OPERATION_STATE_DOING.equals(OPERATION_STATE)){
		 * retValue = "save"; strRet = "��ͯ������˱���ɹ�"; }else
		 * if(ChildStateManager.OPERATION_STATE_DONE.equals(OPERATION_STATE)){
		 * retValue = "submit"; strRet = "��ͯ��������ύ�ɹ�"; }
		 */
		String result = this.getParameter("result", "");

		// 1.8 ��˼����ж�
		String SOURCE = "";
		if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
				.getString("AUDIT_LEVEL"))) {// ʡ���
			retValue = "CMS_ST_SHJS_LIST";
			SOURCE = ChildInfoConstants.LEVEL_PROVINCE;
		} else if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
				.getString("AUDIT_LEVEL"))) {// �������
			if (ChildInfoConstants.CHILD_TYPE_NORMAL.equals(cdata
					.getString("CHILD_TYPE"))) {// ������ͯ
				retValue = "CMS_ZX_ZCCLSH_LIST";
			} else {
				retValue = "CMS_ZX_TXCLSH_LIST";
			}
			SOURCE = ChildInfoConstants.LEVEL_CCCWA;
		}

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean ret = true;
			// 3 ִ�����ݿ⴦�����
			// 3.1�����������ֱ���
			if (ChildStateManager.CHILD_AUD_OPTION_FAILURE.equals(adata
					.getString("AUDIT_OPTION"))) {// ��ͨ��
				// adata.put("OPERATION_STATE",
				// ChildStateManager.OPERATION_STATE_DONE);//�������
				// 3.1.1 ���²�����������״̬
				cdata.put("RETURN_STATE",
						ChildStateManager.CHILD_RETURN_STATE_FLAG);
				// 3.1.2 �����˲��ϼ�¼
				Data ciRevocationData = new Data();
				// ��ͯ����ID
				ciRevocationData.put("CI_ID", cdata.getString("CI_ID"));
				// ʡ��ID
				ciRevocationData.put("PROVINCE_ID",
						cdata.getString("PROVINCE_ID"));
				// ����ԺID
				ciRevocationData.put("WELFARE_ID",
						cdata.getString("WELFARE_ID"));
				// ����
				ciRevocationData.put("NAME", cdata.getString("NAME"));
				// �Ա�
				ciRevocationData.put("SEX", cdata.getString("SEX"));
				// ��������
				ciRevocationData.put("BIRTHDAY", cdata.getString("BIRTHDAY"));
				// �˲��Ͻ��
				ciRevocationData.put("BACK_RESULT",
						ChildStateManager.CHILD_RETURN_STATE_FLAG);
				// ��������
				ciRevocationData.put("BACK_DATE", DateUtility.getCurrentDate());

				// ������˼��������˲��Ϸ���
				if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
						.getString("AUDIT_LEVEL"))) {// �������
					cdata.put("RETURN_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_ZXBG);
					// �˲��Ϸ���
					ciRevocationData.put("BACK_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_ZXBG);
					// �˲���ԭ��
					ciRevocationData.put("RETURN_REASON",
							ChildStateManager.CHILD_RETURN_REASON_ZXBG);
					// ����ȫ��״̬
					manager.zxAuditNoPass(cdata, curuser.getCurOrgan());
				}
				if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
						.getString("AUDIT_LEVEL"))) {// ʡ�����
					cdata.put("RETURN_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_SBG);
					// �˲��Ϸ���
					ciRevocationData.put("BACK_TYPE",
							ChildStateManager.CHILD_BACK_TYPE_SBG);
					// �˲���ԭ��
					ciRevocationData.put("RETURN_REASON",
							ChildStateManager.CHILD_RETURN_REASON_SBG);

					// ����ȫ��״̬
					manager.stAuditNoPass(cdata, curuser.getCurOrgan());
				}
				ChildReturnHandler crHandler = new ChildReturnHandler();
				crHandler.save(conn, ciRevocationData);

			} else if (ChildStateManager.CHILD_AUD_OPTION_ADDITIONAL
					.equals(adata.getString("AUDIT_OPTION"))) {// ����
				// adata.put("OPERATION_STATE",
				// ChildStateManager.OPERATION_STATE_DOING);//������
				ChildAdditionHandler caHandler = new ChildAdditionHandler();
				// ���������¼
				// 1��ͯ����ID
				adddata.put("CI_ID", cdata.getString("CI_ID"));
				// 2ʡ��ID
				adddata.put("PROVINCE_ID", cdata.getString("PROVINCE_ID"));
				// 3����ԺID
				adddata.put("WELFARE_ID", cdata.getString("WELFARE_ID"));
				// 4����״̬
				adddata.put("CA_STATUS", ChildStateManager.CHILD_ADD_STATE_TODO);
				// 5֪ͨ��Դ
				adddata.put("SOURCE", SOURCE);
				// 6֪ͨ����
				adddata.put("NOTICE_DATE", DateUtility.getCurrentDate());
				// 7֪ͨ��ID
				adddata.put("SEND_USERID", curuser.getPerson().getPersonId());
				// 8֪ͨ������
				adddata.put("SEND_USERNAME", curuser.getPerson().getCName());
				// 9����ĩ�β���״̬
				cdata.put("SUPPLY_STATE",
						ChildStateManager.CHILD_ADD_STATE_TODO);

				ret = caHandler.save(conn, adddata);
				if (!ret) {
					InfoClueTo clueTo = new InfoClueTo(2, "�����¼����ʧ��!");// ����ʧ�� 2
					setAttribute("clueTo", clueTo);
					retValue = "error";
					return retValue;
				}

				if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
						.getString("AUDIT_LEVEL"))) {// �������
					// ����ȫ��״̬
					manager.zxAuditSupply(cdata, curuser.getCurOrgan());
					// ���ö�ͯ���״̬Ϊ���������20141211furx
					cdata.add("AUD_STATE",
							ChildStateManager.CHILD_AUD_STATE_ZXSHZ);
				}
				if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
						.getString("AUDIT_LEVEL"))) {// ʡ�����
					// ����ȫ��״̬
					manager.stAuditSupply(cdata, curuser.getCurOrgan());
					// ���ö�ͯ���״̬Ϊʡ�������20141211furx
					cdata.add("AUD_STATE",
							ChildStateManager.CHILD_AUD_STATE_SSHZ);
				}

			} else if (ChildStateManager.CHILD_AUD_OPTION_SUCCESS.equals(adata
					.getString("AUDIT_OPTION"))) {// ͨ��
				// adata.put("OPERATION_STATE",
				// ChildStateManager.OPERATION_STATE_DONE);//�������
				if (ChildInfoConstants.LEVEL_CCCWA.equals(adata
						.getString("AUDIT_LEVEL"))) {// �������
					if (ChildStateManager.CHILD_AUD_RESULT_TRAN.equals(result)) {// �ͷ�
						// �������Ͻ��Ӽ�¼
						DataList dl = new DataList();
						Data dataTransfer = new Data();
						dataTransfer.put("APP_ID", cdata.getString("CI_ID"));
						dataTransfer.put("TRANSFER_CODE",
								TransferCode.CHILDINFO_AZB_FYGS);
						dataTransfer.put("TRANSFER_STATE", "0");
						dl.add(dataTransfer);
						FileCommonManager fm = new FileCommonManager();
						fm.transferDetailInit(conn, dl);
						// ����ȫ��״̬
						manager.zxToTranslation(cdata, curuser.getCurOrgan());
					}
					if (ChildStateManager.CHILD_AUD_RESULT_MATCH.equals(result)) {// ֱ��ƥ��
						cdata.put("MATCH_STATE",
								ChildStateManager.CHILD_MATCH_STATE_TODO);
					}
					if (ChildStateManager.CHILD_AUD_RESULT_PUB.equals(result)) {// ֱ�ӷ���
						cdata.put("PUB_STATE",
								ChildStateManager.CHILD_PUB_STATE_TODO);
					}
				}
				if (ChildInfoConstants.LEVEL_PROVINCE.equals(adata
						.getString("AUDIT_LEVEL"))) {// ʡ�����
					// ����ȫ��״̬
					manager.stAuditPass(cdata, curuser.getCurOrgan());
				}
			}
			ret = handler.childInfoAudit(conn, cdata, adata);
			if (ret) {
				InfoClueTo clueTo = new InfoClueTo(0, "��˼�¼�ύ�ɹ�");// ����ɹ�
				setAttribute("clueTo", clueTo);

				// ���������з���
				AttHelper.publishAttsOfPackageId(cdata.getString("FILE_CODE"),
						"CI");
				AttHelper.publishAttsOfPackageId(
						cdata.getString("FILE_CODE_EN"), "CI");

				dt.commit();
			} else {
				InfoClueTo clueTo = new InfoClueTo(2, "��˼�¼�ύʧ��!");// ����ʧ�� 2
				setAttribute("clueTo", clueTo);
				retValue = "error";
				return retValue;
			}
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��������쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}

		return retValue;
	}

	/**
	 * �����ͯ������ϸ��Ϣ
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return
	 */
	public String save() {
		// 1 ���ҳ������ݣ��������ݽ����
		// 1.1��ö�ͯ������Ϣ
		Data data = getRequestEntityData("P_", "CI_ID", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_ADDR",
				"PICKUP_DATE", "ENTER_DATE", "SEND_DATE", "IS_ANNOUNCEMENT",
				"ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE", "IS_HOPE",
				"IS_PLAN", "DISEASE_CN", "REMARKS", "SN_DEGREE",
				"SPECIAL_FOCUS", "NAME_PINYIN", "SENDER_EN");

		// 1.2���ø���ԭ�����������packid
		data.add("FILE_CODE", data.getString("CI_ID"));
		String FILE_CODE_EN = "F_" + data.getString("CI_ID");
		data.add("FILE_CODE_EN", FILE_CODE_EN);
		// 1.3 ״̬����
		String state = getParameter("state");
		retValue = "save";
		String strRet = "��ͯ���ϱ���ɹ�";

		// 1.4 ���Ĵ�¼����ʽ
		String result = getParameter("result",
				ChildStateManager.CHILD_AUD_RESULT_TRAN);

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);

			// ��ȡ��ǰ��¼�˵���Ϣ
			UserInfo curuser = SessionInfo.getCurUser();
			Organ organ = curuser.getCurOrgan();
			String orgType = String.valueOf(organ.getOrgType());

			if (ChildInfoConstants.ORGAN_TYPE_FLY.equals(orgType)) { // ��¼��Ϊ����Ժ�û�
				// ���ö�ͯ�������״̬
				data.add("AUD_STATE", state);
				if (ChildStateManager.CHILD_AUD_STATE_SDS.equals(state)) {// �����ͯ��Ϣ����ɹ������ύ������������˼�¼

					// ����ȫ��״̬
					this.manager.flySubmitChildInfo(data, organ);
					// ������˼���ʡ���
					String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",
							ChildInfoConstants.LEVEL_PROVINCE);
					Data dataAduit = new Data();
					dataAduit.put("CI_ID", data.getString("CI_ID"));
					dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
					dataAduit.put("OPERATION_STATE",
							ChildStateManager.OPERATION_STATE_TODO);
					// ������˼�¼
					handler.saveCIAduit(conn, dataAduit);
					strRet = "��ͯ�����ύ�ɹ�";
					retValue = "CMS_FLY_CLBS_LIST";
				}
			} else if (ChildInfoConstants.ORGAN_TYPE_ST.equals(orgType)) {// ��¼��Ϊʡ���û�

			} else if (ChildInfoConstants.ORGAN_TYPE_ZX.equals(orgType)) {// ��¼��Ϊ�����û�

				if ("1".equals(state)) {// �����ͯ��Ϣ�ύ
					// ���ö�ͯ�������״̬��״̬Ϊ������ͨ����
					state = ChildStateManager.CHILD_AUD_STATE_ZXTG;
					if (ChildStateManager.CHILD_AUD_RESULT_TRAN.equals(result)) {// �ͷ�
						// �������Ͻ��Ӽ�¼
						DataList dl = new DataList();
						Data dataTransfer = new Data();
						dataTransfer.put("APP_ID", data.getString("CI_ID"));
						dataTransfer.put("TRANSFER_CODE",
								TransferCode.CHILDINFO_AZB_FYGS);
						dataTransfer.put("TRANSFER_STATE", "0");
						dl.add(dataTransfer);
						FileCommonManager fm = new FileCommonManager();
						fm.transferDetailInit(conn, dl);
						// ����ȫ��״̬
						manager.zxToTranslation(data, curuser.getCurOrgan());
					}

					if (ChildStateManager.CHILD_AUD_RESULT_MATCH.equals(result)) {// ֱ��ƥ��
						data.put("MATCH_STATE",
								ChildStateManager.CHILD_MATCH_STATE_TODO);
					}
					if (ChildStateManager.CHILD_AUD_RESULT_PUB.equals(result)) {// ֱ�ӷ���
						data.put("PUB_STATE",
								ChildStateManager.CHILD_PUB_STATE_TODO);
					}

					strRet = "��ͯ�����ύ�ɹ�";
					retValue = "CMS_AZB_DL_LIST";
				}
				data.add("AUD_STATE", state);
			}
			// �����ͯ���ϼ�¼
			handler.save(conn, data);

			// ���������з���
			AttHelper.publishAttsOfPackageId(data.getString("FILE_CODE"), "CI");
			AttHelper.publishAttsOfPackageId(FILE_CODE_EN, "CI");

			if ("save".equals(retValue)) {// ����Ǳ��棬�����ύ
				setAttribute("UUID", data.getString("CI_ID"));
				setAttribute("type", "mod");
				DataList attType = new DataList();
				ChildCommonManager ccm = new ChildCommonManager();
				BatchAttManager bm = new BatchAttManager();
				attType = bm.getAttType(
						conn,
						ccm.getChildPackIdByChildIdentity(
								data.getString("CHILD_IDENTITY"),
								data.getString("CHILD_TYPE"), false));
				String xmlstr = bm.getUploadParameter(attType);
				setAttribute("uploadParameter", xmlstr);
			}
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, strRet);
			setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��������쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		System.out.println(retValue);
		return retValue;
	}

	/**
	 * ��ͯ���ϲ���ҳ��ġ��޸Ķ�ͯ������Ϣ����ť��Ӧ���޸�ҳ��
	 * 
	 * @author furx
	 * @date 2014-10-24
	 * @return
	 */
	public String toChildInfoModify() {
		String ci_id = getParameter("CI_ID", "");
		retValue = SUCCESS;
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.getShowData(conn, ci_id);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);

			setAttribute("data", showdata);
			setAttribute("uploadParameter", xmlstr);

		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}

		return retValue;
	}

	/**
	 * �����ͯ������ϸ��Ϣ(��ͯ���ϲ���ҳ�桰�޸Ĳ�����Ϣ����ť��Ӧ��ͯ�����޸�ҳ��ı������)
	 * 
	 * @author furx
	 * @date 2014-10-24
	 * @return
	 */
	public String saveChildInfo() {
		// 1 ���ҳ������ݣ��������ݽ����
		// 1.1��ö�ͯ������Ϣ
		Data data = getRequestEntityData("P_", "CI_ID", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_ADDR",
				"PICKUP_DATE", "ENTER_DATE", "SEND_DATE", "IS_ANNOUNCEMENT",
				"ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE", "IS_HOPE",
				"IS_PLAN", "DISEASE_CN", "REMARKS", "SN_DEGREE",
				"SPECIAL_FOCUS", "NAME_PINYIN", "SENDER_EN");

		// 1.2���ø���ԭ�����������packid
		data.add("FILE_CODE", data.getString("CI_ID"));
		String FILE_CODE_EN = "F_" + data.getString("CI_ID");
		data.add("FILE_CODE_EN", FILE_CODE_EN);
		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			// �����ͯ���ϼ�¼
			handler.save(conn, data);
			// ���������з���
			AttHelper.publishAttsOfPackageId(data.getString("FILE_CODE"), "CI");
			AttHelper.publishAttsOfPackageId(FILE_CODE_EN, "CI");
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��������쳣[�������]:" + e.getMessage(), e);
			}
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return SUCCESS;
	}

	/**
	 * ����Ժ�����ύ��ͯ������Ϣ
	 * 
	 * @author wangzheng
	 * @date 2014-9-15
	 * @return
	 * 
	 */
	public String flyBatchSubmit() {
		// 0 ����û�������Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();

		// 1 ��������ύ�Ĳ���id����
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		// ���ϼ�¼list
		DataList dataList = new DataList();
		// ������˼�¼list
		DataList aduitDataList = new DataList();
		try {
			for (int i = 0; i < uuid.length; i++) {
				// ���¶�ͯ����״̬
				Data data = new Data();
				data.setConnection(conn);
				data.setEntityName("CMS_CI_INFO");
				data.setPrimaryKey("CI_ID");
				data.add("CI_ID", uuid[i]);
				data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_SDS);

				// ����ȫ��״̬
				this.manager.flySubmitChildInfo(data, organ);
				dataList.add(data);

				// ������ͯ������˼�¼
				Data aduitData = new Data();
				aduitData.setConnection(conn);
				aduitData.setEntityName("CMS_CI_ADUIT");
				aduitData.setPrimaryKey("CA_ID");
				aduitData.put("CI_ID", uuid[i]);
				aduitData.put("AUDIT_LEVEL", ChildInfoConstants.LEVEL_PROVINCE);
				aduitData.put("OPERATION_STATE",
						ChildStateManager.OPERATION_STATE_TODO);
				aduitDataList.add(aduitData);
			}

			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 ִ�����ݿ⴦�����
			success = handler.flyBatchSubmit(conn, dataList, aduitDataList);

			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����ύ�쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύ��!");
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
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ʡ���������Ͷ�ͯ������Ϣ
	 * 
	 * @author wangzheng
	 * @date 2014-9-18
	 * @return
	 * 
	 */
	public String stBatchPost() {

		// 1 ��������ύ�Ĳ���id����
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 ִ�����ݿ⴦�����
			success = handler.stBatchPost(conn, uuid);

			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "���ͳɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ϼ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("���ϼ����쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ϼ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ϼ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ϼ���ʧ��!");
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
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ���Ͷ�ͯ���ϴ�ӡ
	 * 
	 * @author wangzheng
	 * @date 2014-9-18
	 * @return
	 * 
	 */
	public String postPrint() {

		// 1 ��������ύ�Ĳ���id����
		String uuids = (String) getParameter("printid", "");
		System.out.println("uuid:" + uuids);
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 3 ִ�����ݿ⴦�����
			DataList list = handler.getChildListByCIID(conn, uuid);
			// ��ȡ������ͯ��Ŀ
			DataList normalList = handler.getChildListByCIIDAndChildType(conn,
					uuid, ChildInfoConstants.CHILD_TYPE_NORMAL);
			// ��ȡ�����ͯ��Ŀ
			DataList specialList = handler.getChildListByCIIDAndChildType(conn,
					uuid, ChildInfoConstants.CHILD_TYPE_SPECAL);
			UserInfo curuser = SessionInfo.getCurUser();
			String postPerson = curuser.getPerson().getCName();
			Calendar postCalendar = GregorianCalendar.getInstance();
			String dateStr = postCalendar.get(Calendar.YEAR) + "��"
					+ (postCalendar.get(Calendar.MONTH) + 1) + "��"
					+ postCalendar.get(Calendar.DAY_OF_MONTH) + "��";
			setAttribute("normalSize", normalList.size() + "");
			setAttribute("specialSize", specialList.size() + "");
			setAttribute("allSize", list.size() + "");
			setAttribute("postDate", dateStr);
			setAttribute("postPerson", postPerson);
			setAttribute("list", list);
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���ϼ��ʹ�ӡ���쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("���ϼ��ʹ�ӡ���쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���ϼ��ʹ�ӡʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ���ò��������ն�ͯ������Ϣ
	 * 
	 * @author wangzheng
	 * @date 2014-9-18
	 * @return
	 * 
	 */
	public String azbBatchReceive() {

		// 1 ��������ύ�Ĳ���id����
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 ִ�����ݿ⴦�����
			success = handler.azbBatchReceive(conn, uuid);

			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "���ճɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "���Ͻ����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("���Ͻ����쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���Ͻ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���Ͻ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "���Ͻ���ʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ���ò���¼�����ύ��ͯ������Ϣ state=1 �����ͷ� state=2 ��������
	 * 
	 * @author wangzheng
	 * @date 2014-10-24
	 * @return
	 * 
	 */
	public String azbBatchSubmit() {

		// 1 ��������ύ�Ĳ���id����
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		// 1.2 ����ͷ������ʶ
		String state = getParameter("state", "1");

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 ִ�����ݿ⴦�����
			success = handler.azbBatchSubmit(conn, uuid, state);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "�ύ�ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�����ύ�쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("�����ύ�쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "�����ύ��!");
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
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ���ϲ鿴���޸�
	 * 
	 * @author wangzheng
	 * @date 2014-9-15
	 * @return
	 */
	public String show() {
		// ��ȡ��������־��ͯ���ϻ�����Ϣ�鿴ҳ���Ƿ���Ϊ����ҳ�����
		String onlyOne = getParameter("onlyOne", "");
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		String type = getParameter("type", "");
		if ("".equals(type)) {
			type = (String) this.getAttribute("type");
		}
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.getShowData(conn, uuid);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			// ��øö�ͯ��ͬ����Ϣ
			DataList twinsList = handler.getTwinsByChildNO(conn,
					showdata.getString("CHILD_NO"));
			setAttribute("twinsList", twinsList);
			setAttribute("data", showdata);
			setAttribute("uploadParameter", xmlstr);
			setAttribute("onlyOne", onlyOne);

		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		if ("show".equals(type)) {
			return "show";
		} else if ("mod".equals(type)) {
			return "mod";
		} else {
			return retValue;
		}
	}

	/**
	 * ��ͯ���ϲ鿴(��ͯ��Ϣ������֯ͳһ�鿴ҳ��)
	 * 
	 * @author furx
	 * @date 2014-11-18
	 * @return
	 */
	public String showForAdoption() {
		String ri_state = getParameter("RI_STATE","");
		String uuid = getParameter("UUID", "");
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.showForAdoption(conn, uuid, ri_state);
			DataList attType = new DataList();

			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			setAttribute("uploadParameter", xmlstr);
			setAttribute("data", showdata);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 
	 * ��ͯ���ϲ鿴 ��ͯ��Ϣ+���¼�¼(��ͯ��Ϣ������֯ͳһ�鿴ҳ��)
	 * 
	 * @author furx
	 * @date 2014-11-30
	 * @return retValue
	 */
	public String childInfoForAdoption() {
		// ��ȡ����
		String CI_ID = (String) getParameter("UUID");
		String ri_state = (String) getParameter("RI_STATE");
		String onlyPage = (String) getParameter("onlyPage");
		setAttribute("CI_ID", CI_ID);
		setAttribute("RI_STATE", ri_state);
		setAttribute("onlyPage", onlyPage);
		return retValue;
	}

	/**
	 * ��ͯ���ϸ�����Ϣ�鿴(�����鿴ҳ�������Ӣ��)
	 * 
	 * @author furx
	 * @date 2014-11-30
	 * @return
	 */
	public String childAttShowList() {
		String CI_ID = getParameter("CI_ID");// ��ͯ����ID/���ĸ���packageId
		String CHILD_TYPE = getParameter("CHILD_TYPE");// ��ͯ����
		String CHILD_IDENTITY = getParameter("CHILD_IDENTITY");// ��ͯ���
		String FILE_CODE_EN = "F_" + CI_ID;// Ӣ�ĸ���packageId
		try {
			conn = ConnectionManager.getConnection();
			// ����С��
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(
					CHILD_IDENTITY, CHILD_TYPE, true));
			// ��������С�࣬��ȡ��Ӧ����Ӣ�ĸ�������
			for (int i = 0; i < attType.size(); i++) {
				String CODE = attType.getData(i).getString("CODE");
				DataList Attdl = handler.childAttShowList(conn, CI_ID, CODE);// ���ĸ���
				DataList Attdl1 = handler.childAttShowList(conn, FILE_CODE_EN,
						CODE);// Ӣ�ĸ���
				attType.getData(i).add("ATTCNLIST", Attdl);
				attType.getData(i).add("ATTENLIST", Attdl1);
			}
			setAttribute("attType", attType);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}
	public String childAttShowListCN() {
		String CI_ID = getParameter("CI_ID");// ��ͯ����ID/���ĸ���packageId
		String CHILD_TYPE = getParameter("CHILD_TYPE");// ��ͯ����
		String CHILD_IDENTITY = getParameter("CHILD_IDENTITY");// ��ͯ���
		String FILE_CODE_EN = "F_" + CI_ID;// Ӣ�ĸ���packageId
		try {
			conn = ConnectionManager.getConnection();
			// ����С��
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(
					CHILD_IDENTITY, CHILD_TYPE, true));
			// ��������С�࣬��ȡ��Ӧ����Ӣ�ĸ�������
			for (int i = 0; i < attType.size(); i++) {
				String CODE = attType.getData(i).getString("CODE");
				DataList Attdl = handler.childAttShowList(conn, CI_ID, CODE);// ���ĸ���
				DataList Attdl1 = handler.childAttShowList(conn, FILE_CODE_EN,
						CODE);// Ӣ�ĸ���
				attType.getData(i).add("ATTCNLIST", Attdl);
				attType.getData(i).add("ATTENLIST", Attdl1);
			}
			setAttribute("attType", attType);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}
	/**
	 * ��ͯ���ϼ����¼�¼�鿴ҳ�棨��֮��/���빫˾ ���ϸ���-������ϸ��� ��Ӧ�б��еĲ鿴ҳ�棩
	 * 
	 * @author wangzheng
	 * @date 2014-9-15
	 * @return
	 */
	public String showForAZQ() {
		String uuid = getParameter("UUID", "");
		setAttribute("CI_ID", uuid);
		return retValue;
	}

	/**
	 * ��ͯ���Ͻ��������ӡ
	 * 
	 * @author panfeng
	 * @date 2014-10-26
	 * @return
	 * 
	 */
	public String receivePrint() {

		// 1 ��������ύ�Ĳ���id����
		String printuuid = getParameter("printuuid", "");
		String[] uuid = printuuid.split(",");
		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// 3 ִ�����ݿ⴦�����
			DataList list = handler.getChildListByCIID(conn, uuid);
			setAttribute("list", list);
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "����Ԥ����ӡ���쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("����Ԥ����ӡ���쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����Ԥ����ӡʧ��!");
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ����CIID��ö�ͯ��˼�¼�б�
	 * 
	 * @author wangzheng
	 * @date 2014-9-19
	 * @return
	 */
	public String getChildAuditRecorderByCIID() {
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		try {
			conn = ConnectionManager.getConnection();
			DataList auditList = handler.getAuditListByCIID(conn, uuid);
			setAttribute("List", auditList);
		} catch (DBException e) {
			e.printStackTrace();
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						retValue = "error";
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ������Ϣɾ��
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return retValue
	 */
	public String delete() {
		String deleteuuid = getParameter("uuid", "");
		String listType = getParameter("listType", "CMS_FLY_CLBS_LIST");
		retValue = listType;

		deleteuuid = deleteuuid.substring(1, deleteuuid.length());
		String[] uuid = deleteuuid.split("#");
		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			success = handler.delete(conn, uuid);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "ɾ���ɹ�!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
			retValue = "error";
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("ɾ�������쳣[ɾ������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "ɾ��ʧ��!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError(
								"CmsCiAdditionalAction��Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ���ϻ�����Ϣ¼��
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return retValue
	 */
	public String basicadd() {
		// �����û���ݣ��ж϶�ͯ���ϵ�ʡ�ݺ͸���Ժ
		// ��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();

		Data data = new Data();
		DataList welfareList = new DataList();
		// String orgType = String.valueOf(organ.getOrgType());

		// ��ȡ�б����
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		try {
			conn = ConnectionManager.getConnection();
			if ("CMS_FLY_CLBS_LIST".equals(listType)) {
				// ��¼��Ϊ����Ժ�û�
				String WELFARE_ID = organ.getOrgCode();
				String WELFARE_NAME_CN = organ.getCName();
				String WELFARE_NAME_EN = organ.getEnName();
				// ʡ��ID
				String PROVINCE_ID = manager.getProviceId(WELFARE_ID);
				data.put("WELFARE_ID", WELFARE_ID);
				data.put("WELFARE_NAME_CN", WELFARE_NAME_CN);
				data.put("WELFARE_NAME_EN", WELFARE_NAME_EN);
				data.put("PROVINCE_ID", PROVINCE_ID);

			} else if ("CMS_AZB_DL_LIST".equals(listType)) {
				// ��¼��Ϊ�����û�
				// ��ȡ���и���Ժ��Ϣ
				welfareList = this.manager.getAllWelfareList(conn);
			}
			setAttribute("data", data);
			setAttribute("listType", listType);
			setAttribute("welfareList", welfareList);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
						System.out.println("basicaddConnection");
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ������ϸ��Ϣ¼��
	 * 
	 * @author wangzheng
	 * @date 2014-9-10
	 * @return retValue
	 */
	public String infoadd() {
		// 0 ����û�������Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		// 1 ������ʼ��
		Data data = getRequestEntityData("P_", "PROVINCE_ID", "WELFARE_ID",
				"WELFARE_NAME_CN", "WELFARE_NAME_EN", "CHILD_TYPE", "NAME",
				"SEX", "BIRTHDAY", "CHILD_IDENTITY", "IS_DAILU");
		// 1.1 ���ö�ͯ���ϵĵǼ��ˡ��Ǽǲ�����Ϣ
		data.put("REG_ORGID", organ.getOrgCode());
		data.put("REG_USERID", curuser.getPersonId());
		data.put("REG_USERNAME", curuser.getPerson().getCName());
		data.put("REG_DATE", DateUtility.getCurrentDate());

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// ��������
			dt = DBTransaction.getInstance(conn);

			// 2.1 �жϸø���Ժ�Ƿ���ڶ�ͯ����+�Ա�+����������ͬ�Ķ�ͯ��Ϣ
			DataList dlist = handler.getChildInfoList(conn, data);
			if (dlist.size() != 0) {// �������
				retValue = "bizerror";
				StringBuffer sb = new StringBuffer();
				sb.append("ϵͳ���Ѵ�����ͬ��ͯ��Ϣ��");
				setAttribute("error", sb.toString());
				String url = "/cms/childManager/basicadd.action?listType="
						+ listType;
				setAttribute("url", url);
				return retValue;
			}

			// 2.2 �жϸ�����Ϣϵͳ�Ƿ���ڸ���Ժ+��ͯ����+�Ա�+����������ͬ�Ķ�ͯ��Ϣ���������ȡ����ͯ��Ϣ
			Data flxtData = this.getChildDataFromFlxt(data);
			if (flxtData != null) {// ���������Ϣϵͳ���ڸö�ͯ����Ϣ
				// TODO
			}

			// 2.3 ���ɶ�ͯ���
			String CHILD_NO = this.manager.createChildNO(data, conn);
			data.put("CHILD_NO", CHILD_NO);

			// 2.4 ��ͯ����ƴ������
			String NAME = data.getString("NAME");
			String NAME_PINYIN = this.manager.getPinyin(NAME);
			data.put("NAME_PINYIN", NAME_PINYIN);

			// 2.5 ��ͯ���״̬
			data.put("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_WTJ);

			// 2.6ͬ����ʶ��Ĭ��Ϊ��
			String IS_TWINS = "0";
			String TWINS_IDS = "";
			data.put("IS_TWINS", IS_TWINS);
			data.put("TWINS_IDS", TWINS_IDS);
			data.put("IS_MAIN", "1");

			// 2.9 ����ȫ��״̬
			this.manager.createChildInfo(data, organ);
			// ����ǷǸ���������Ҫ���ö�ͯĬ�ϵ������ˡ�������Ӣ�����ơ������˵�ַ
			String welfearName = data.getString("WELFARE_NAME_CN", null);
			if (welfearName != null && (welfearName.indexOf("�Ǹ�������") < 0)) {
				// 2.10���ö�ͯĬ�ϵ������ˡ������˵�ַ��������Ӣ������
				data.add("SENDER", data.getString("WELFARE_NAME_CN"));// ������
				data.add("SENDER_EN", data.getString("WELFARE_NAME_EN"));// ������Ӣ������
				// ���ݸ���ԺID��ȡ����Ժ��ַ
				DataList orgDetails = handler.getOrgDeitail(conn,
						data.getString("WELFARE_ID"));
				if (orgDetails.size() > 0) {
					Data orgInfo = orgDetails.getData(0);
					data.add("SENDER_ADDR",
							orgInfo.getString("DEPT_ADDRESS_CN"));// �����˵�ַ
				}
			}
			// 3 ���ɶ�ͯ��¼
			data.add("CI_ID", "");// ���û�иĴ��룬������3.1��ȡ��CI_IDֵΪ��
			Data d = handler.save(conn, data);

			// 3.1���¶�ͯ��¼��Ϣ
			data.put("CI_ID", d.getString("CI_ID"));
			data.put("FILE_CODE", d.getString("CI_ID")); // ����ID
			data.put("FILE_CODE_EN", "F_" + d.getString("CI_ID"));// ����ID_EN
			data.put("MAIN_CI_ID", d.getString("CI_ID"));// ��ID
			data.add("PHOTO_CARD", d.getString("CI_ID"));// ����ͷ���packageId
			handler.save(conn, data);

			// 3.2���ݶ�ͯ��ݻ�ȡ�����б�
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							data.getString("CHILD_IDENTITY"),
							data.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);

			setAttribute("data", data);
			setAttribute("uploadParameter", xmlstr);
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("��������쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "����ƴ��ת���쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("����ƴ��ת���쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			retValue = "error1";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
						System.out.println("infoaddConnection");
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ͬ�������б�
	 * 
	 * @author wangzheng
	 * @date 2014-9-12
	 * @param childNO
	 *            ��ͯ���
	 * @return Data
	 */
	public String twinsList() {

		// 1 ���÷�ҳ����
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		// int pageSize = 5;
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 ��ȡ�����ֶ�
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "REG_DATE";
		}
		// 2.2 ��ȡ�������� ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = "DESC";
		}

		String CHILD_NO = (String) getParameter("CHILD_NO", "");
		String CI_ID = (String) getParameter("CI_ID", "");
		String WELFARE_ID = (String) getParameter("WELFARE_ID", "");

		// UserInfo curuser = SessionInfo.getCurUser();
		// Organ organ = curuser.getCurOrgan();
		// String WELFARE_ID = organ.getOrgCode();

		Data data = getRequestEntityData("S_", "NAME", "SEX", "BIRTHDAY_START",
				"BIRTHDAY_END");
		data.put("WELFARE_ID", WELFARE_ID);
		data.put("CI_ID", CI_ID);
		data.add("CHILD_NO", CHILD_NO);

		try {
			// 3 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();

			// ��øö�ͯ��ͬ����Ϣ
			DataList twinsList = handler.getTwinsByChildNO(conn, CHILD_NO);
			// ��ñ�����Ժ���ж�ͯ��Ϣ�б�
			DataList dataList = handler.getValidChildList(conn, data, pageSize,
					page, compositor, ordertype);
			setAttribute("twinsList", twinsList);
			setAttribute("dataList", dataList);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
			setAttribute("CHILD_NO", CHILD_NO);
			setAttribute("CI_ID", CI_ID);
			setAttribute("WELFARE_ID", WELFARE_ID);

		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "�б��ѯ�����쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��ѯ�����쳣[��ѯ����]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 5 �ر����ݿ�����
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					retValue = "error";
				}
			}
		}

		return retValue;
	}

	/**
	 * ����ͬ����¼ ������õĶ�ͯΪ����ʶ��ͯ
	 * 
	 * @return
	 */
	public String twinsadd() {

		String cids = getParameter("cid", "");
		// String cnos=getParameter("cno", "");

		String CHILD_NO = getParameter("CHILD_NO", "");
		String CI_ID = getParameter("CI_ID", "");

		// cids=cids.substring(1, cids.length());
		// cnos=cnos.substring(1,cnos.length());
		cids = cids.substring(1, cids.length());
		String[] cid = cids.split("#");
		// String[] cno=cnos.split("#");

		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			StringBuffer sbMainCIID = new StringBuffer();
			sbMainCIID.append("(");
			for (int i = 0; i < cid.length; i++) {
				sbMainCIID.append("'");
				sbMainCIID.append(cid[i]);
				sbMainCIID.append("'");
				if (i != cid.length - 1) {
					sbMainCIID.append(",");
				}
			}
			sbMainCIID.append(")");
			// ��ȡ����ӵ�ͬ����ͯ��Ϣ
			DataList newChildList = handler.getChildListByMainCIIDS(conn,
					sbMainCIID.toString());

			// ���ԭ�е�ͬ����ͯ����Ϣ
			DataList oldChilddata = handler.getTwinListByCIID(conn, CI_ID);
			newChildList.addAll(oldChilddata);

			// ����ͬ����ͯ���
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < newChildList.size(); i++) {
				sb.append(newChildList.getData(i).getString("CHILD_NO", ""));
				if (i != newChildList.size() - 1) {
					sb.append(",");
				}
			}

			String TWINS_IDS = sb.toString();
			System.out.println("TWINS_IDS:" + TWINS_IDS);

			// ���ö�ͯ��Ϣͬ������
			for (int j = 0; j < newChildList.size(); j++) {
				newChildList.getData(j).setEntityName("CMS_CI_INFO");
				newChildList.getData(j).setPrimaryKey("CI_ID");
				newChildList.getData(j).put("IS_TWINS", "1");
				newChildList.getData(j).put("MAIN_CI_ID", CI_ID);
				newChildList.getData(j).put(
						"TWINS_IDS",
						handler.getTWINS_IDS(TWINS_IDS, newChildList.getData(j)
								.getString("CHILD_NO")));
				if (CI_ID.equals(newChildList.getData(j).getString("CI_ID"))) {// ������ͬ���Ķ�ͯ��Ϊ����ʶ��ͯ
					newChildList.getData(j).put("IS_MAIN", "1");
				} else {
					newChildList.getData(j).put("IS_MAIN", "0");
				}
			}
			handler.setTwins(conn, newChildList);
			InfoClueTo clueTo = new InfoClueTo(0, "ͬ�����óɹ�!");
			setAttribute("clueTo", clueTo);
			dt.commit();
			setAttribute("CHILD_NO", CHILD_NO);
			setAttribute("CI_ID", CI_ID);
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("ͬ�����ò����쳣[ͬ�����ò���]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "ͬ������ʧ��!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * ɾ��ͬ����¼
	 * 
	 * @return
	 */
	public String twinsdelete() {
		String cid = getParameter("cid", "");
		String cno = getParameter("cno", "");
		String CHILD_NO = getParameter("CHILD_NO", "");
		String CI_ID = getParameter("CI_ID", "");

		// 1 ����ͬ��ɾ���Ķ�ͯ���ԣ���ͬ����ʶ��Ϊ��
		Data twinsdeleteData = new Data();
		twinsdeleteData.put("CI_ID", cid);
		twinsdeleteData.put("IS_TWINS", "0");
		twinsdeleteData.put("TWINS_IDS", "");
		twinsdeleteData.put("IS_MAIN", "1");
		twinsdeleteData.put("MAIN_CI_ID", cid);

		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			// ��ȡ�ö�ͯ������ͬ����¼
			DataList dl = handler.getTwinListByCIID(conn, CI_ID);
			if (dl.size() <= 2) {// ���ֻ��һ��ͬ������ɾ������ͬ����¼����һ����ͯҲ������ͬ��
				Data d = new Data();
				d.add("CI_ID", CI_ID);
				d.add("IS_TWINS", "0");
				d.add("TWINS_IDS", "");
				d.add("IS_MAIN", "1");
				d.add("MAIN_CI_ID", CI_ID);
				this.handler.save(conn, d);
			} else {
				for (int i = 0; i < dl.size(); i++) {
					Data d = dl.getData(i);
					if (CI_ID.equals(d.getString("CI_ID"))) {// ��������ʶ��ͯ
						d.put("IS_TWINS", "1");
						d.put("TWINS_IDS", handler.getTWINS_IDS(
								d.getString("TWINS_IDS"), cno));
						d.put("IS_MAIN", "1");
						d.put("MAIN_CI_ID", CI_ID);
						this.handler.save(conn, d);
					} else if (!cid.equals(d.getString("CI_ID"))) {// ����ɾ����ͬ����ͯ
						d.put("IS_TWINS", "1");
						d.put("TWINS_IDS", handler.getTWINS_IDS(
								d.getString("TWINS_IDS"), cno));
						d.put("IS_MAIN", "0");
						d.put("MAIN_CI_ID", CI_ID);
						this.handler.save(conn, d);
					}
				}
			}
			handler.save(conn, twinsdeleteData);
			dt.commit();
			setAttribute("CHILD_NO", CHILD_NO);
			setAttribute("CI_ID", CI_ID);
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("ͬ�����ò����쳣[ͬ�����ò���]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "ͬ������ʧ��!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",
								e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * ������������������Ϣϵͳ��ͯ���ݣ�����������򷵻�Data�����û�з��������������򷵻�null
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return Data TODO
	 */
	private Data getChildDataFromFlxt(Data d) {
		return null;
	}

	/**
	 * ���ݲ�ѯ״̬���б����ͻ��ʵ�ʶ�ͯ���״̬ ��ͯ���״̬������ 0��δ�ύ 1��ʡ���� 2��ʡ����� 3��ʡ��ͨ�� 4��ʡͨ�� 5���Ѽ���
	 * 6���ѽ��� 7����������� 8�����Ĳ�ͨ�� 9������ͨ��
	 * 
	 * @param childState
	 *            ��ͯ��ѯ״̬����
	 * @param listType
	 *            listType ��ͯ��Ϣ�б� (1)CMS_FLY_CLBS_LIST 0��δ�ύ -> 0��δ�ύ 1�����ύ ->
	 *            1,2,3,4,5,6,7,8,9
	 * 
	 * @return AUD_STATE
	 */
	private String getChildAudState(String childState, String listType) {
		String audState = childState;
		if ("CMS_FLY_CLBS_LIST".equals(listType)
				|| "CMS_ST_DL_LIST".equals(listType)
				|| "CMS_AZB_DL_LIST".equals(listType)) {
			if ("0".equals(childState)) {
				audState = ",0,"; // ��ͯ����δ�ύ
			} else if ("1".equals(childState)) {
				audState = ",1,2,3,4,5,6,7,8,9,";// ��ͯ�������ύ
			}
		}

		if ("CMS_ST_SHJS_LIST".equals(listType)) {
			audState = childState;
		}
		return audState;
	}

	/**
	 * ��ͯ���ϻ�����Ϣ�޸�
	 * 
	 * @author furx
	 * @date 2014-11-17
	 * @return retValue
	 */
	public String toBasicInfoMod() {
		// ��ȡ��ͯ��������
		String uuid = getParameter("UUID", "");
		// ��ȡ�б����
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		try {
			Data showdata = new Data();
			DataList welfareList = new DataList();
			conn = ConnectionManager.getConnection();
			showdata = handler.getShowData(conn, uuid);
			// ��ȡ���и���Ժ��Ϣ
			welfareList = this.manager.getAllWelfareList(conn);

			setAttribute("data", showdata);
			setAttribute("listType", listType);
			setAttribute("welfareList", welfareList);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * �����ͯ���ϻ�����Ϣ
	 * 
	 * @author furx
	 * @date 2014-11-17
	 * @return retValue
	 */
	public String saveBasicInfo() {
		// 0 ��ȡ����
		String listType = (String) getParameter("listType", "CMS_FLY_CLBS_LIST");
		String oprovince = (String) getParameter("OPROVINCE_ID", "");
		String owelfareId = (String) getParameter("OWELFARE_ID", "");
		String owelfareCn = (String) getParameter("OWELFARE_NAME_CN", "");
		// 1 ��ȡҳ������
		Data data = getRequestEntityData("P_", "PROVINCE_ID", "WELFARE_ID",
				"WELFARE_NAME_CN", "WELFARE_NAME_EN", "CHILD_TYPE", "NAME",
				"SEX", "BIRTHDAY", "CHILD_IDENTITY", "CI_ID");
		String ci_id = data.getString("CI_ID");
		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			// ��������
			dt = DBTransaction.getInstance(conn);

			// 2.1 �жϸø���Ժ�Ƿ���ڶ�ͯ����+�Ա�+����������ͬ�Ķ�ͯ��Ϣ
			DataList dlist = handler.getRepeatChildList(conn, data);
			if (dlist.size() != 0) {// �������
				retValue = "bizerror";
				StringBuffer sb = new StringBuffer();
				sb.append("ϵͳ���Ѵ�����ͬ��ͯ��Ϣ��");
				setAttribute("error", sb.toString());
				String url = "/cms/childManager/toBasicInfoMod.action?listType="
						+ listType + "&UUID=" + ci_id;
				setAttribute("url", url);
				return retValue;
			}

			// 2.2 �жϸ�����Ϣϵͳ�Ƿ���ڸ���Ժ+��ͯ����+�Ա�+����������ͬ�Ķ�ͯ��Ϣ���������ȡ����ͯ��Ϣ
			Data flxtData = this.getChildDataFromFlxt(data);
			if (flxtData != null) {// ���������Ϣϵͳ���ڸö�ͯ����Ϣ
				// TODO
			}

			// 2.3 �����ͯ����ʡ�ݷ����仯����Ҫ�������ö�ͯ�ı��
			if (!oprovince.equals(data.getString("PROVINCE_ID"))) {
				String CHILD_NO = this.manager.createChildNO(data, conn);
				data.add("CHILD_NO", CHILD_NO);
			}
			// 20141212�����ͯ���ڸ���Ժ�����仯����Ҫ�������ö�ͯĬ�ϵ����������ġ�������Ӣ�ġ������˵�ַ
			if (!owelfareId.equals(data.getString("WELFARE_ID", ""))) {
				// ����ǷǸ���������Ҫ���ö�ͯĬ�ϵ������ˡ�������Ӣ�����ơ������˵�ַ
				String welfearName = data.getString("WELFARE_NAME_CN", null);
				if (welfearName != null && (welfearName.indexOf("�Ǹ�������") < 0)) {// ������������Ĭ�ϵ���������Ϣ
					// 2.10���ö�ͯĬ�ϵ������ˡ������˵�ַ��������Ӣ������
					data.add("SENDER", data.getString("WELFARE_NAME_CN"));// ������
					data.add("SENDER_EN", data.getString("WELFARE_NAME_EN"));// ������Ӣ������
					// ���ݸ���ԺID��ȡ����Ժ��ַ
					DataList orgDetails = handler.getOrgDeitail(conn,
							data.getString("WELFARE_ID"));
					if (orgDetails.size() > 0) {
						Data orgInfo = orgDetails.getData(0);
						data.add("SENDER_ADDR",
								orgInfo.getString("DEPT_ADDRESS_CN"));// �����˵�ַ
					}
				} else if (welfearName != null
						&& (welfearName.indexOf("�Ǹ�������") > 0)
						&& (owelfareCn.indexOf("�Ǹ�������") < 0)) {// ��������=���Ǹ���������Ĭ�ϵ���������ϢΪ��
					data.add("SENDER", null);// ������
					data.add("SENDER_EN", null);// ������Ӣ������
					data.add("SENDER_ADDR", null);// �����˵�ַ
				}
			}
			// 2.4 ��ͯ����ƴ������
			String NAME = data.getString("NAME");
			String NAME_PINYIN = this.manager.getPinyin(NAME);
			data.put("NAME_PINYIN", NAME_PINYIN);

			// 3 ���¶�ͯ��¼
			handler.save(conn, data);

			setAttribute("listType", listType);
			setAttribute("UUID", ci_id);
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("��������쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ����ͳһ�޸�ҳ���޸�
	 * 
	 * @author furx
	 * @date 2014-10-17
	 * @return
	 */
	public String toDetailInfoMod() {
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		String listType = getParameter("listType", "");
		if ("".equals(listType)) {
			listType = (String) this.getAttribute("listType");
		}
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.getShowData(conn, uuid);

			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(
					conn,
					ccm.getChildPackIdByChildIdentity(
							showdata.getString("CHILD_IDENTITY"),
							showdata.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			setAttribute("listType", listType);
			setAttribute("data", showdata);
			setAttribute("uploadParameter", xmlstr);
		} catch (DBException e) {
			retValue = "error";
			e.printStackTrace();
		} catch (Exception e) {
			retValue = "error";
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					retValue = "error";
					if (log.isError()) {
						log.logError("Connection������쳣��δ�ܹر�", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * �����ͯ������ϸ��Ϣ
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return
	 */
	public String saveDetailInfo() {
		// 1 ���ҳ������ݣ��������ݽ����
		// 1.1��ö�ͯ������Ϣ
		Data data = getRequestEntityData("P_", "CI_ID", "CHECKUP_DATE",
				"ID_CARD", "CHILD_IDENTITY", "SENDER", "SENDER_ADDR",
				"PICKUP_DATE", "ENTER_DATE", "SEND_DATE", "IS_ANNOUNCEMENT",
				"ANNOUNCEMENT_DATE", "NEWS_NAME", "SN_TYPE", "IS_HOPE",
				"IS_PLAN", "DISEASE_CN", "REMARKS", "SN_DEGREE",
				"SPECIAL_FOCUS", "NAME_PINYIN", "SENDER_EN");

		// 1.2���ø���ԭ�����������packid
		data.add("FILE_CODE", data.getString("CI_ID"));
		String FILE_CODE_EN = "F_" + data.getString("CI_ID");
		data.add("FILE_CODE_EN", FILE_CODE_EN);
		// 1.3 ״̬����
		String state = getParameter("state");
		retValue = "save";
		String strRet = "��ͯ���ϱ���ɹ�";

		// 1.4 ���Ĵ�¼����ʽ
		String result = getParameter("result",
				ChildStateManager.CHILD_AUD_RESULT_TRAN);
		// ��ȡ�б�����
		String listType = getParameter("listType");
		String uuid = getParameter("UUID");

		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);

			// ��ȡ��ǰ��¼�˵���Ϣ
			UserInfo curuser = SessionInfo.getCurUser();
			Organ organ = curuser.getCurOrgan();
			String orgType = String.valueOf(organ.getOrgType());
			if ("1".equals(state)) {// ������ύ�������޸��б����Դ������Ӧ�Ĵ���
				if ("CMS_FLY_CLBS_LIST".equals(listType)) {// ����Ժ�ύ����Ҫ����������˼�¼
					// ���ö�ͯ�������״̬Ϊʡ����
					data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_SDS);
					// ����ȫ��״̬
					this.manager.flySubmitChildInfo(data, organ);
					// ������˼���ʡ���
					String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",
							ChildInfoConstants.LEVEL_PROVINCE);
					Data dataAduit = new Data();
					dataAduit.put("CI_ID", data.getString("CI_ID"));
					dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
					dataAduit.put("OPERATION_STATE",
							ChildStateManager.OPERATION_STATE_TODO);
					// ������˼�¼
					handler.saveCIAduit(conn, dataAduit);
					strRet = "��ͯ�����ύ�ɹ�";
					retValue = "CMS_FLY_CLBS_LIST";
				} else if ("CMS_ST_DL_LIST".equals(listType)) {// ʡ���ύ����Ҫ����������˼�¼
					// ���ö�ͯ�������״̬Ϊʡͨ��
					data.add("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_STG);
					// ����ȫ��״̬
					this.manager.stAuditPass(data, organ);
					// ������˼���ȱʡΪʡͨ��
					String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",
							ChildStateManager.CHILD_AUD_STATE_STG);
					Data dataAduit = new Data();
					dataAduit.put("CI_ID", data.getString("CI_ID"));
					dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
					// ������˼�¼
					handler.saveCIAduit(conn, dataAduit);
					strRet = "��ͯ�����ύ�ɹ�";
					retValue = "CMS_ST_DL_LIST";
				} else if ("CMS_AZB_DL_LIST".equals(listType)) {// ���ò��ύ
					// ���ö�ͯ�������״̬��״̬Ϊ������ͨ����
					data.add("AUD_STATE",
							ChildStateManager.CHILD_AUD_STATE_ZXTG);
					if (ChildStateManager.CHILD_AUD_RESULT_TRAN.equals(result)) {// �ͷ�
						// �������Ͻ��Ӽ�¼
						DataList dl = new DataList();
						Data dataTransfer = new Data();
						dataTransfer.put("APP_ID", data.getString("CI_ID"));
						dataTransfer.put("TRANSFER_CODE",
								TransferCode.CHILDINFO_AZB_FYGS);
						dataTransfer.put("TRANSFER_STATE", "0");
						dl.add(dataTransfer);
						FileCommonManager fm = new FileCommonManager();
						fm.transferDetailInit(conn, dl);
						// ����ȫ��״̬
						manager.zxToTranslation(data, curuser.getCurOrgan());
					}

					if (ChildStateManager.CHILD_AUD_RESULT_MATCH.equals(result)) {// ֱ��ƥ��
						data.put("MATCH_STATE",
								ChildStateManager.CHILD_MATCH_STATE_TODO);
					}
					if (ChildStateManager.CHILD_AUD_RESULT_PUB.equals(result)) {// ֱ�ӷ���
						data.put("PUB_STATE",
								ChildStateManager.CHILD_PUB_STATE_TODO);
					}
					strRet = "��ͯ�����ύ�ɹ�";
					retValue = "CMS_AZB_DL_LIST";
				}
			}

			// �����ͯ���ϼ�¼
			handler.save(conn, data);

			// ���������з���
			AttHelper.publishAttsOfPackageId(data.getString("FILE_CODE"), "CI");
			AttHelper.publishAttsOfPackageId(FILE_CODE_EN, "CI");

			if ("save".equals(retValue)) {// ����Ǳ��棬�����ύ
				setAttribute("UUID", uuid);
				setAttribute("listType", listType);
				DataList attType = new DataList();
				ChildCommonManager ccm = new ChildCommonManager();
				BatchAttManager bm = new BatchAttManager();
				attType = bm.getAttType(
						conn,
						ccm.getChildPackIdByChildIdentity(
								data.getString("CHILD_IDENTITY"),
								data.getString("CHILD_TYPE"), false));
				String xmlstr = bm.getUploadParameter(attType);
				setAttribute("uploadParameter", xmlstr);
			}
			dt.commit();
			InfoClueTo clueTo = new InfoClueTo(0, strRet);
			setAttribute("clueTo", clueTo);
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��������쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("�����쳣:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError(
								"FfsAfTranslationAction��Connection������쳣��δ�ܹر�",
								e);
					}
					e.printStackTrace();
				}
			}
		}
		System.out.println("retValue:" + retValue);
		return retValue;
	}

}
