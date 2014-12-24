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
 * @Description:省厅代录
 * @Created on 2014-9-24 21:13:26
 * @author xcp
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class ChildSTAddAction extends BaseAction {

	private static Log log = UtilLog.getLog(ChildSTAddAction.class);

	private ChildSTAddHandler handler;

	private Connection conn = null;// 数据库连接

	private DBTransaction dt = null;// 事务处理

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
	 * 省厅批量提交儿童材料信息
	 * 
	 * @author xcp
	 * @date 2014-10-09
	 * @return
	 * 
	 */
	public String stBatchSubmit() {

		// 1 获得批量提交的材料id集合
		String uuids = getParameter("uuid", "");
		uuids = uuids.substring(1, uuids.length());
		String[] uuid = uuids.split("#");

		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			// 3 执行数据库处理操作
			success = handler.stBatchSubmit(conn, uuid);

			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (DBException e) {
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "材料提交异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("材料提交异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		}catch (Exception e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "材料提交败!");
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
						log.logError("ChildSTAddAction的Connection因出现异常，未能关闭",e);
					}
					e.printStackTrace();
				}
			}
		}
		return retValue;
	}

	/**
	 * 保存儿童材料基本信息(省厅代录)
	 * 
	 * @throws DBException
	 */
	public String basicinfoadd() throws DBException {
		//获取当前登录人的部门code，省厅用户的代码前两位为省份code前两位
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                }
            }
        }
		return retValue;
	}

	/**
	 * 儿童材料全部信息录入
	 * 
	 * @author xcp
	 * @date 2014-9-29
	 * @return retValue
	 * @throws DBException
	 */
	public String infoadd() throws DBException {
		// /根据用户身份，判断儿童材料的省份和福利院
		// 获取当前登录人的信息
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		
		// 当前登录用户及组织机构ID
		String orgId = organ.getOrgCode();
				
		// 省份ID
		String PROVINCE_ID = manager.getProviceId(orgId);
		Data data = getRequestEntityData("P_", "CHILD_TYPE", "WELFARE_ID","WELFARE_NAME_CN", "NAME", "SEX", "BIRTHDAY", "CHILD_IDENTITY","PHOTO_CARD", "IS_DAILU");
		data.put("PROVINCE_ID", PROVINCE_ID);
		// 1.1 设置儿童材料的登记人、登记部门信息
		data.put("REG_ORGID", organ.getOrgCode());
		data.put("REG_USERID", curuser.getPersonId());
		data.put("REG_USERNAME", curuser.getPerson().getCName());
		data.put("REG_DATE", DateUtility.getCurrentDate());
		// 儿童审核状态
		data.put("AUD_STATE", ChildStateManager.CHILD_AUD_STATE_WTJ);		
		
		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//创建事务
            dt = DBTransaction.getInstance(conn);
			// 2.1 判断该福利院是否存在儿童名称+性别+出生日期相同的儿童信息
			DataList dlist = handler.getChildInfoList(conn, data);
			if (dlist.size() != 0) {// 如果存在
				retValue = "bizerror";
				StringBuffer sb = new StringBuffer();
				sb.append("系统中已存在相同儿童信息！");
				setAttribute("error", sb.toString());
				String url = "/cms/childstadd/basicinfoadd.action";
				setAttribute("url", url);
				return retValue;
			}

			// 2.2 判断福利信息系统是否存在福利院+儿童名称+性别+出生日期相同的儿童信息，如存在则取出儿童信息
			Data flxtData = this.getChildDataFromFlxt(data);
			if (flxtData != null) {// 如果福利信息系统存在该儿童的信息
				// TODO
			}

			// 2.3 生成儿童编号
			String CHILD_NO = this.manager.createChildNO(data,conn);
			data.put("CHILD_NO", CHILD_NO);

			// 2.4 儿童姓名拼音处理
			String NAME = data.getString("NAME");			
			String NAME_PINYIN = this.manager.getPinyin(NAME);
			data.put("NAME_PINYIN", NAME_PINYIN);

			// 2.6同胞标识，默认为否
			String IS_TWINS = "0";
			String TWINS_IDS = "";
			data.put("IS_TWINS", IS_TWINS);
			data.put("TWINS_IDS", TWINS_IDS);
			data.put("IS_MAIN", "1");
			
			//2.9 设置全局状态
        	this.manager.createChildInfo(data, organ);
        	//如果是非福利机构需要设置儿童默认的送养人、送养人英文名称、送养人地址
        	String welfearName=data.getString("WELFARE_NAME_CN",null);
        	if(welfearName!=null&&(welfearName.indexOf("非福利机构")<0)){
        		//2.10设置儿童默认的送养人、送养人地址、送养人英文名称
            	data.add("SENDER", data.getString("WELFARE_NAME_CN"));//送养人
            	//根据福利院ID获取福利院地址
            	DataList orgDetails=new ChildManagerHandler().getOrgDeitail(conn,data.getString("WELFARE_ID"));
            	if(orgDetails.size()>0){
            		Data orgInfo=orgDetails.getData(0);
            		data.add("SENDER_ADDR",orgInfo.getString("DEPT_ADDRESS_CN"));//送养人地址
            		data.add("WELFARE_NAME_EN", orgInfo.getString("ENNAME"));//福利院英文
            		data.add("SENDER_EN", orgInfo.getString("ENNAME"));//送养人英文名称
            	}
        	}
			// 3 生成儿童记录
        	data.add("CI_ID", "");//如果没有改代码，则下面3.1获取的CI_ID值为空
			Data d = handler.save(conn, data);

			//3.1更新儿童记录信息                        
            data.put("CI_ID", d.getString("CI_ID"));
            data.put("FILE_CODE", d.getString("CI_ID"));	//附件ID            
            data.put("FILE_CODE_EN", "F_"+d.getString("CI_ID"));//附件ID_EN            
            data.put("MAIN_CI_ID", d.getString("CI_ID"));//主ID
            data.add("PHOTO_CARD", d.getString("CI_ID"));//设置头像的packageId
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
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (BadHanyuPinyinOutputFormatCombination e) {
			setAttribute(Constants.ERROR_MSG_TITLE, "姓名拼音转换异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("姓名拼音转换异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
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
						log.logError("ChildSTAddAction的Connection因出现异常，未能关闭",e);
					}
					e.printStackTrace();
				}
			}
		}

		return retValue;
	}

	/**
	 * 同胞设置列表
	 * 
	 * @author wangzheng
	 * @date 2014-9-12
	 * @param childNO
	 *            儿童编号
	 * @return Data
	 */
	public String twinsList() {

		// 1 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = "REG_DATE";
		}
		// 2.2 获取排序类型 ASC DESC
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
			// 3 获取数据库连接
			conn = ConnectionManager.getConnection();

			// 获得该儿童的同胞信息
			DataList twinsList = handler.getTwinsByChildNO(conn, CHILD_NO);
			// 获得本福利院所有儿童信息列表
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
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error";
		} finally {
			// 5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildSTAddAction的Connection因出现异常，未能关闭",e);
					}
					retValue = "error";
				}
			}
		}

		return retValue;
	}

	/**
	 * 增加同胞记录
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
				InfoClueTo clueTo = new InfoClueTo(0, "同胞设置成功!");
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
				log.logError("同胞设置操作异常[同胞设置操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "同胞设置失败!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 删除同胞记录
	 * 
	 * @return
	 */
	public String twinsdelete() {
		String cid = getParameter("cid", "");
		String cno = getParameter("cno", "");
		String CHILD_NO = getParameter("CHILD_NO", "");
		String CI_ID = getParameter("CI_ID", "");

		// 1 更新同胞删除的儿童属性，将同胞标识置为否
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
			// 获取该儿童的所有同胞记录
			DataList dl = handler.getTwinsByChildNO(conn, cno);
			if (dl.size() == 1) {// 如果只有一个同胞，则删除这条同胞记录后，另一个儿童也不存在同胞
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
				log.logError("同胞设置操作异常[同胞设置操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "同胞设置失败!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildManagerAction的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 省厅儿童代录查询列表
	 * 
	 * @author xcp
	 * @date 2014-9-24 21:13:26
	 * @return
	 */
	public String findList() {
		// 1 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 2.1 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 2.2 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}

		// 3 获取搜索参数
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
		setAttribute("clueTo", clueTo);// set操作结果提醒
		// 获取省厅登录人的省厅ID
		UserInfo user = SessionInfo.getCurUser();
		Organ o = user.getCurOrgan();
		String orgcode = o.getOrgCode();// 获取登录人所属机构代码
		String PROVINCE_ID = manager.getProviceId(orgcode);
		// 查询条件包括：福利院code、省份、代录标示、姓名、性别、儿童类型、病残种类、出生日期、录入人、报送状态、录入时间、体检日期
		Data data = getRequestEntityData("S_", "WELFARE_ID", "NAME","SEX", "CHILD_TYPE", "SN_TYPE", "BIRTHDAY_START","BIRTHDAY_END", "REG_USERNAME", "AUD_STATE", "REG_DATE_STRAT","REG_DATE_END", "CHECKUP_DATE_START", "CHECKUP_DATE_END");
		//如果提交状态为空则设置默认的提交状态为“未提交”；如果提交状态为“-1”则表明是查询全部，则将查询条件中的提交状态置为null
		String CHILD_STATE=data.getString("AUD_STATE",null);
		if(CHILD_STATE==null){
			data.add("AUD_STATE", "0");
		}else if("-1".equals(CHILD_STATE)){
			data.add("AUD_STATE", null);
		}
		data.put("PROVINCE_ID", PROVINCE_ID);
		data.put("IS_DAILU", ChildStateManager.CHILD_DAILU_FLAG_PROVINCE);
		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.findList(conn, data, pageSize, page,
					compositor, ordertype);
			// 6 将结果集写入页面接收变量
			setAttribute("List", dl);
			setAttribute("data", data);
			setAttribute("compositor", compositor);
			setAttribute("ordertype", ordertype);
		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			// 8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildSTAddAction的Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		return retValue;
	}

	/**
	 * 儿童材料修改
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
						log.logError("Connection因出现异常，未能关闭", e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 删除方法(描述可自定义)
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
				InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
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
				log.logError("删除操作异常[删除操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "删除失败!");
			setAttribute("clueTo", clueTo);
		} finally {
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("ChildSTAddAction的Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return retValue;
	}

	/**
	 * 根据条件检索福利信息系统儿童数据，如果有数据则返回Data，如果没有符合条件的数据则返回null
	 * 
	 * @author wangzheng
	 * @date 2014-9-3
	 * @return Data TODO
	 */
	private Data getChildDataFromFlxt(Data d) {
		return null;
	}

	

	/**
	 * 保存儿童材料信息
	 */
	public String save() {
		// 0 获得用户基本信息
		UserInfo curuser = SessionInfo.getCurUser();
		Organ organ = curuser.getCurOrgan();
		// 获取表单数据，得到结果集
		Data data = getRequestEntityData("P_", "CI_ID", "PROVINCE_ID",
				"WELFARE_ID", "WELFARE_NAME_CN", "NAME", "SEX", "BIRTHDAY",
				"CHILD_TYPE", "CHECKUP_DATE", "ID_CARD", "CHILD_IDENTITY",
				"SENDER", "SENDER_ADDR", "PICKUP_DATE", "ENTER_DATE",
				"SEND_DATE", "IS_ANNOUNCEMENT", "ANNOUNCEMENT_DATE",
				"NEWS_NAME", "SN_TYPE", "IS_PLAN", "IS_HOPE", "DISEASE_CN",
				"REMARKS", "NAME_PINYIN","SENDER_EN");
		data.put("IS_DAILU", ChildStateManager.CHILD_DAILU_FLAG_PROVINCE);
		
		// 1.1 设置儿童材料的登记人、登记部门信息
		data.put("REG_ORGID", organ.getOrgCode());
		data.put("REG_USERID", curuser.getPersonId());
		data.put("REG_USERNAME", curuser.getPerson().getCName());
		data.put("REG_DATE", DateUtility.getCurrentDate());
		// 1.2设置附件原件的packid
		data.add("PHOTO_CARD", data.getString("CI_ID"));
		data.add("FILE_CODE", data.getString("CI_ID"));
		data.add("FILE_CODE_EN", "F_"+data.getString("CI_ID"));

		// 状态处理
		String state = getParameter("state");
		data.add("AUD_STATE", state);
		
		//全局状态设置
		if(ChildStateManager.CHILD_AUD_STATE_STG.equals(state)){
			this.manager.stAuditPass(data, organ);
		}
		
		retValue = "save";
		String strRet = "儿童材料保存成功";
		try {
			// 2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			// 3 执行数据库处理操作
			Data ret = handler.save(conn, data);
			boolean boo = false;
			if (ret != null && ChildStateManager.CHILD_AUD_STATE_STG.equals(state)) {// 如果儿童信息保存成功，且提交，创建材料审核记录
				// 材料审核级别，缺省为省通过
				String AUDIT_LEVEL = data.getString("AUDIT_LEVEL",ChildStateManager.CHILD_AUD_STATE_STG);
				Data dataAduit = new Data();
				dataAduit.put("CI_ID", data.getString("CI_ID"));
				dataAduit.put("AUDIT_LEVEL", AUDIT_LEVEL);
				boo = handler.saveCIAduit(conn, dataAduit);
				retValue = "submit";
				strRet = "儿童材料提交成功";

			} else {
				boo = true;
			}
			if (boo) {
				InfoClueTo clueTo = new InfoClueTo(0, strRet);// 保存成功
				setAttribute("clueTo", clueTo);
				if ("save".equals(retValue)) {
					setAttribute("UUID", data.getString("CI_ID"));
				}
				// 将附件进行发布
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
			// 4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "保存操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("保存操作异常[保存操作]:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(), e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "保存失败!");// 保存失败 2
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
						log.logError("FfsAfTranslationAction的Connection因出现异常，未能关闭",e);
					}
					e.printStackTrace();
				}
			}
		}
		System.out.println(retValue);
		return retValue;
	}
}
