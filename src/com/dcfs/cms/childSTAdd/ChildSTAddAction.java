package com.dcfs.cms.childSTAdd;

import hx.code.CodeList;
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
import java.util.HashMap;

import net.sourceforge.pinyin4j.PinyinHelper;
import net.sourceforge.pinyin4j.format.HanyuPinyinCaseType;
import net.sourceforge.pinyin4j.format.HanyuPinyinOutputFormat;
import net.sourceforge.pinyin4j.format.HanyuPinyinToneType;
import net.sourceforge.pinyin4j.format.HanyuPinyinVCharType;
import net.sourceforge.pinyin4j.format.exception.BadHanyuPinyinOutputFormatCombination;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.cms.childManager.ChildStateManager;
import com.dcfs.common.batchattmanager.BatchAttManager;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
import com.hx.framework.organ.vo.Organ;
import com.hx.upload.sdk.AttHelper;

/**
 * @Title: ChildSTAddAction.java
 * @Description:ʡ����¼
 * @Created on 2014-9-24 21:13:26
 * @author xcp
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class ChildSTAddAction extends BaseAction {

	private static Log log = UtilLog.getLog(ChildSTAddAction.class);

	private ChildSTAddHandler handler;

	private Connection conn = null;// ���ݿ�����

	private DBTransaction dt = null;// ������

	private String retValue = SUCCESS;

	private ChildCommonManager manager;

	public ChildSTAddAction() {
		this.handler = new ChildSTAddHandler();
		this.manager = new ChildCommonManager();
	}

	public String execute() throws Exception {
		return null;
	}

	/**
	 * ʡ�������ύ��ͯ������Ϣ
	 * 
	 * @author xcp
	 * @date 2014-10-09
	 * @return
	 * 
	 */
	public String stBatchSubmit() {

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
			success = handler.stBatchSubmit(conn, uuid);

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
		}catch (Exception e) {
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
		}  finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildSTAddAction��Connection������쳣��δ�ܹر�",e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * �����ͯ���ϻ�����Ϣ(ʡ����¼)
	 * 
	 * @throws DBException
	 */
	public String basicinfoadd() throws DBException {
		//��ȡ��ǰ��¼�˵Ĳ���code��ʡ���û��Ĵ���ǰ��λΪʡ��codeǰ��λ
		String orgCode = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		try{
			conn = ConnectionManager.getConnection();
			CodeList list = manager.getWelfareByProvinceCode(orgCode,conn);
			HashMap<String, CodeList> cmap = new HashMap<String, CodeList>();
			cmap.put("WELFARE_LIST", list);
			setAttribute(Constants.CODE_LIST, cmap);
			Data data = new Data();
			data.put("PROVINCE_ID", orgCode);
			setAttribute("data", data);
		} catch (DBException e) {
        	retValue = "error";
            e.printStackTrace();
        } catch (Exception e) {	
        	retValue = "error";
			e.printStackTrace();
		}finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                        System.out.println("stbasicAdd");
                    }
                } catch (SQLException e) {
                	retValue = "error";
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�",e);
                    }
                }
            }
        }
		return retValue;
	}

	/**
	 * ��ͯ����ȫ����Ϣ¼��
	 * 
	 * @author xcp
	 * @date 2014-9-29
	 * @return retValue
	 * @throws DBException
	 */
	public String infoadd() throws DBException {
		// /�����û���ݣ��ж϶�ͯ���ϵ�ʡ�ݺ͸���Ժ
		// ��ȡ��ǰ��¼�˵���Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		
		// ��ǰ��¼�û�����֯����ID
		String orgId = organ.getOrgCode();
				
		// ʡ��ID
		String PROVINCE_ID = manager.getProviceId(orgId);
		Data data = getRequestEntityData("P_", "CHILD_TYPE", "WELFARE_ID","WELFARE_NAME_CN", "NAME", "SEX", "BIRTHDAY", "CHILD_IDENTITY","PHOTO_CARD", "IS_DAILU");
		data.put("PROVINCE_ID", PROVINCE_ID);
		// 1.1 ���ö�ͯ���ϵĵǼ��ˡ��Ǽǲ�����Ϣ
		data.put("REG_ORGID", organ.getOrgCode());
		data.put("REG_USERID", curuser.getPersonId());
		data.put("REG_USERNAME", curuser.getPerson().getCName());
		data.put("REG_DATE", DateUtility.getCurrentDate());
		// ��ͯ���״̬
		data.put("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_WTJ);		
		
		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			//��������
            dt = DBTransaction.getInstance(conn);
			// 2.1 �жϸø���Ժ�Ƿ���ڶ�ͯ����+�Ա�+����������ͬ�Ķ�ͯ��Ϣ
			DataList dlist = handler.getChildInfoList(conn, data);
			if (dlist.size() != 0) {// �������
				retValue = "bizerror";
				StringBuffer sb = new StringBuffer();
				sb.append("ϵͳ���Ѵ�����ͬ��ͯ��Ϣ��");
				setAttribute("error", sb.toString());
				String url = "/cms/childstadd/basicinfoadd.action";
				setAttribute("url", url);
				return retValue;
			}

			// 2.2 �жϸ�����Ϣϵͳ�Ƿ���ڸ���Ժ+��ͯ����+�Ա�+����������ͬ�Ķ�ͯ��Ϣ���������ȡ����ͯ��Ϣ
			Data flxtData = this.getChildDataFromFlxt(data);
			if (flxtData != null) {// ���������Ϣϵͳ���ڸö�ͯ����Ϣ
				// TODO
			}

			// 2.3 ���ɶ�ͯ���
			String CHILD_NO = this.manager.createChildNO(data,conn);
			data.put("CHILD_NO", CHILD_NO);

			// 2.4 ��ͯ����ƴ������
			String NAME = data.getString("NAME");			
			String NAME_PINYIN = this.manager.getPinyin(NAME);
			data.put("NAME_PINYIN", NAME_PINYIN);

			// 2.6ͬ����ʶ��Ĭ��Ϊ��
			String IS_TWINS = "0";
			String TWINS_IDS = "";
			data.put("IS_TWINS", IS_TWINS);
			data.put("TWINS_IDS", TWINS_IDS);
			data.put("IS_MAIN", "1");
			
			//2.9 ����ȫ��״̬
        	this.manager.createChildInfo(data, organ);
        	//����ǷǸ���������Ҫ���ö�ͯĬ�ϵ������ˡ�������Ӣ�����ơ������˵�ַ
        	String welfearName=data.getString("WELFARE_NAME_CN",null);
        	if(welfearName!=null&&(welfearName.indexOf("�Ǹ�������")<0)){
        		//2.10���ö�ͯĬ�ϵ������ˡ������˵�ַ��������Ӣ������
            	data.add("SENDER", data.getString("WELFARE_NAME_CN"));//������
            	//���ݸ���ԺID��ȡ����Ժ��ַ
            	DataList orgDetails=new ChildManagerHandler().getOrgDeitail(conn,data.getString("WELFARE_ID"));
            	if(orgDetails.size()>0){
            		Data orgInfo=orgDetails.getData(0);
            		data.add("SENDER_ADDR",orgInfo.getString("DEPT_ADDRESS_CN"));//�����˵�ַ
            		data.add("WELFARE_NAME_EN", orgInfo.getString("ENNAME"));//����ԺӢ��
            		data.add("SENDER_EN", orgInfo.getString("ENNAME"));//������Ӣ������
            	}
        	}
			// 3 ���ɶ�ͯ��¼
        	data.add("CI_ID", "");//���û�иĴ��룬������3.1��ȡ��CI_IDֵΪ��
			Data d = handler.save(conn, data);

			//3.1���¶�ͯ��¼��Ϣ                        
            data.put("CI_ID", d.getString("CI_ID"));
            data.put("FILE_CODE", d.getString("CI_ID"));	//����ID            
            data.put("FILE_CODE_EN", "F_"+d.getString("CI_ID"));//����ID_EN            
            data.put("MAIN_CI_ID", d.getString("CI_ID"));//��ID
            data.add("PHOTO_CARD", d.getString("CI_ID"));//����ͷ���packageId
            handler.save(conn, data);
            
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(
					data.getString("CHILD_IDENTITY"), data
							.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);

			setAttribute("data", data);
			setAttribute("uploadParameter", xmlstr);
			dt.commit();
		} catch (DBException e) {
			// 4 �����쳣����
			setAttribute(Constants.ERROR_MSG_TITLE, "��������쳣");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("��������쳣[�������]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "����ʧ��!");// ����ʧ�� 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "����ƴ��ת���쳣");
			setAttribute(Constants.ERROR_MSG, e);
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
			retValue = "error";
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
						System.out.println("stinfoadd");
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildSTAddAction��Connection������쳣��δ�ܹر�",e);
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

		Data data = getRequestEntityData("S_", "NAME", "SEX", "BIRTHDAY_START","BIRTHDAY_END");
		data.put("WELFARE_ID", WELFARE_ID);
		data.put("CI_ID", CI_ID);

		try {
			// 3 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();

			// ��øö�ͯ��ͬ����Ϣ
			DataList twinsList = handler.getTwinsByChildNO(conn, CHILD_NO);
			// ��ñ�����Ժ���ж�ͯ��Ϣ�б�
			DataList dataList = handler.getValidChildList(conn, data, pageSize,page, compositor, ordertype);
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
						log.logError("ChildSTAddAction��Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error";
				}
			}
		}

		return retValue;
	}

	/**
	 * ����ͬ����¼
	 * 
	 * @return
	 */
	public String twinsadd() {
		String cids = getParameter("cid", "");
		String cnos = getParameter("cno", "");
		String CHILD_NO = getParameter("CHILD_NO", "");
		String CI_ID = getParameter("CI_ID", "");
		String[] cid = cids.split("#");
		String[] cno = cnos.split("#");

		try {
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;

			success = handler.setTwins(conn, cid, cno, CI_ID);
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "ͬ�����óɹ�!");
				setAttribute("clueTo", clueTo);
			}
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
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",e);
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
			String IS_TWINS = "1";
			// ��ȡ�ö�ͯ������ͬ����¼
			DataList dl = handler.getTwinsByChildNO(conn, cno);
			if (dl.size() == 1) {// ���ֻ��һ��ͬ������ɾ������ͬ����¼����һ����ͯҲ������ͬ��
				IS_TWINS = "0";
			}

			for (int i = 0; i < dl.size(); i++) {
				Data d = dl.getData(i);
				String TWINS_IDS = d.getString("TWINS_IDS");
				TWINS_IDS = this.handler.getTWINS_IDS(TWINS_IDS, cno);
				d.put("TWINS_IDS", TWINS_IDS);
				d.put("IS_TWINS", IS_TWINS);
				this.handler.save(conn, d);
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
						log.logError("ChildManagerAction��Connection������쳣��δ�ܹر�",e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * ʡ����ͯ��¼��ѯ�б�
	 * 
	 * @author xcp
	 * @date 2014-9-24 21:13:26
	 * @return
	 */
	public String findList() {
		// 1 ���÷�ҳ����
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

		// 3 ��ȡ��������
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// ��ȡ�����������
		setAttribute("clueTo", clueTo);// set�����������
		// ��ȡʡ����¼�˵�ʡ��ID
		UserInfo user = SessionInfo.getCurUser();
		Organ o = user.getCurOrgan();
		String orgcode = o.getOrgCode();// ��ȡ��¼��������������
		String PROVINCE_ID = manager.getProviceId(orgcode);
		// ��ѯ��������������Ժcode��ʡ�ݡ���¼��ʾ���������Ա𡢶�ͯ���͡��������ࡢ�������ڡ�¼���ˡ�����״̬��¼��ʱ�䡢�������
		Data data = getRequestEntityData("S_", "WELFARE_ID", "NAME","SEX", "CHILD_TYPE", "SN_TYPE", "BIRTHDAY_START","BIRTHDAY_END", "REG_USERNAME", "AUD_STATE", "REG_DATE_STRAT","REG_DATE_END", "CHECKUP_DATE_START", "CHECKUP_DATE_END");
		//����ύ״̬Ϊ��������Ĭ�ϵ��ύ״̬Ϊ��δ�ύ��������ύ״̬Ϊ��-1��������ǲ�ѯȫ�����򽫲�ѯ�����е��ύ״̬��Ϊnull
		String CHILD_STATE=data.getString("AUD_STATE",null);
		if(CHILD_STATE==null){
			data.add("AUD_STATE", "0");
		}else if("-1".equals(CHILD_STATE)){
			data.add("AUD_STATE", null);
		}
		data.put("PROVINCE_ID", PROVINCE_ID);
		data.put("IS_DAILU", ChildStateManager.CHILD_DAILU_FLAG_PROVINCE);
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
						log.logError("ChildSTAddAction��Connection������쳣��δ�ܹر�",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * ��ͯ�����޸�
	 * 
	 * @author xcp
	 * @date 2014-10-09
	 * @return
	 */
	public String show() {
		String uuid = getParameter("UUID", "");
		if ("".equals(uuid)) {
			uuid = (String) this.getAttribute("UUID");
		}
		try {
			conn = ConnectionManager.getConnection();
			Data showdata = handler.getShowData(conn, uuid);
			
			DataList attType = new DataList();
			ChildCommonManager ccm = new ChildCommonManager();
			BatchAttManager bm = new BatchAttManager();
			attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(
					showdata.getString("CHILD_IDENTITY"), showdata
							.getString("CHILD_TYPE"), false));
			String xmlstr = bm.getUploadParameter(attType);
			
			setAttribute("uploadParameter", xmlstr);			
			setAttribute("data", showdata);
			
		
		} catch (Exception e) {			
			e.printStackTrace();
			retValue = "error1";
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
	 * ɾ������(�������Զ���)
	 * 
	 * @author xxx
	 * @date 2014-9-24 21:13:26
	 * @return
	 */
	public String delete() {
		String deleteuuid = getParameter("uuid", "");
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
					if (log.isError()) {
						log.logError("ChildSTAddAction��Connection������쳣��δ�ܹر�",e);
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
	 * �����ͯ������Ϣ
	 */
	public String save() {
		// 0 ����û�������Ϣ
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		// ��ȡ�����ݣ��õ������
		Data data = getRequestEntityData("P_", "CI_ID", "PROVINCE_ID",
				"WELFARE_ID", "WELFARE_NAME_CN", "NAME", "SEX", "BIRTHDAY",
				"CHILD_TYPE", "CHECKUP_DATE", "ID_CARD", "CHILD_IDENTITY",
				"SENDER", "SENDER_ADDR", "PICKUP_DATE", "ENTER_DATE",
				"SEND_DATE", "IS_ANNOUNCEMENT", "ANNOUNCEMENT_DATE",
				"NEWS_NAME", "SN_TYPE", "IS_PLAN", "IS_HOPE", "DISEASE_CN",
				"REMARKS", "NAME_PINYIN","SENDER_EN");
		data.put("IS_DAILU", ChildStateManager.CHILD_DAILU_FLAG_PROVINCE);
		
		// 1.1 ���ö�ͯ���ϵĵǼ��ˡ��Ǽǲ�����Ϣ
		data.put("REG_ORGID", organ.getOrgCode());
		data.put("REG_USERID", curuser.getPersonId());
		data.put("REG_USERNAME", curuser.getPerson().getCName());
		data.put("REG_DATE", DateUtility.getCurrentDate());
		// 1.2���ø���ԭ����packid
		data.add("PHOTO_CARD", data.getString("CI_ID"));
		data.add("FILE_CODE", data.getString("CI_ID"));
		data.add("FILE_CODE_EN", "F_"+data.getString("CI_ID"));

		// ״̬����
		String state = getParameter("state");
		data.add("AUD_STATE", state);
		
		//ȫ��״̬����
		if(ChildStateManager.CHILD_AUD_STATE_STG.equals(state)){
			this.manager.stAuditPass(data, organ);
		}
		
		retValue = "save";
		String strRet = "��ͯ���ϱ���ɹ�";
		try {
			// 2 ��ȡ���ݿ�����
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			// 3 ִ�����ݿ⴦�����
			Data ret = handler.save(conn, data);
			boolean boo = false;
			if (ret != null && ChildStateManager.CHILD_AUD_STATE_STG.equals(state)) {// �����ͯ��Ϣ����ɹ������ύ������������˼�¼
				// ������˼���ȱʡΪʡͨ��
				String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",ChildStateManager.CHILD_AUD_STATE_STG);
				Data dataAduit = new Data();
				dataAduit.put("CI_ID", data.getString("CI_ID"));
				dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
				boo = handler.saveCIAduit(conn, dataAduit);
				retValue = "submit";
				strRet = "��ͯ�����ύ�ɹ�";

			} else {
				boo = true;
			}
			if (boo) {
				InfoClueTo clueTo = new InfoClueTo(0, strRet);// ����ɹ�
				setAttribute("clueTo", clueTo);
				if ("save".equals(retValue)) {
					setAttribute("UUID", data.getString("CI_ID"));
				}
				// ���������з���
				AttHelper.publishAttsOfPackageId(data.getString("FILE_CODE"),"CI");
				DataList attType = new DataList();
				ChildCommonManager ccm = new ChildCommonManager();
				BatchAttManager bm = new BatchAttManager();
				attType = bm.getAttType(conn, ccm.getChildPackIdByChildIdentity(data.getString("CHILD_IDENTITY"), data.getString("CHILD_TYPE"), false));
				String xmlstr = bm.getUploadParameter(attType);
				setAttribute("uploadParameter", xmlstr);
				dt.commit();
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("FfsAfTranslationAction��Connection������쳣��δ�ܹر�",e);
					}
					e.printStackTrace();
				}
			}
		}
		System.out.println(retValue);
		return retValue;
	}
}
