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
 * @Description: 办公室支票据登记操作，包括查询、登记、修改、删除、打印、导出操作 
 * @author panfeng 
 * @date 2014-11-14
 *  
 */
public class BillRegistrationAction extends BaseAction{
	
	private static Log log = UtilLog.getLog(BillRegistrationAction.class);

    private BillRegistrationHandler handler;
    
    private Connection conn = null;//数据库连接
    
    private DBTransaction dt = null;//事务处理
    
    private String retValue = SUCCESS;
    
    public BillRegistrationAction(){
        this.handler=new BillRegistrationHandler();
    } 

	public String execute() throws Exception {
		return null;
	}
	
	
	/**
	 * @Title: billRegistrationList 
	 * @Description: 票据登记列表
	 * @author: panfeng
	 * @return String    返回类型 
	 * @throws
	 */
	public String billRegistrationList(){
		// 1 设置分页参数
		int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		//2.1 获取排序字段
		String compositor=(String)getParameter("compositor","");
		if("".equals(compositor)){
			compositor="REG_DATE";
		}
		//2.2 获取排序类型   ASC DESC
		String ordertype=(String)getParameter("ordertype","");
		if("".equals(ordertype)){
			ordertype="DESC";
		}
		//3 获取搜索参数
		InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
		setAttribute("clueTo", clueTo);//set操作结果提醒
		Data data = getRequestEntityData("S_","PAID_NO","COUNTRY_CODE","ADOPT_ORG_ID","COST_TYPE","PAID_WAY",
					"PAID_SHOULD_NUM","PAR_VALUE","FILE_NO","REG_DATE_START",
					"REG_DATE_END","CHEQUE_TRANSFER_STATE");
		try {
			//4 获取数据库连接
			conn = ConnectionManager.getConnection();
			//5 获取数据DataList
			DataList dl=handler.billRegistrationList(conn,data,pageSize,page,compositor,ordertype);
			//6 将结果集写入页面接收变量
			setAttribute("List",dl);
			setAttribute("data",data);
			setAttribute("compositor",compositor);
			setAttribute("ordertype",ordertype);
			
		} catch (DBException e) {
			//7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("查询操作异常:" + e.getMessage(),e);
			}
			
			retValue = "error1";
			
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}
		
		return retValue;
		
	}
	
	/**
	 * 跳转到票据登记页面
	 * @author Panfeng
	 * @date 2014-11-14
	 * @return
	 */
	public String billRegistrationAdd() {
		// 获取session中的手工添加列表，判断是否存在历史数据
		HttpSession session = getRequest().getSession();
		DataList dl = (DataList) session.getAttribute("fileList");
		if (dl == null) {
			// 创建页面初始化数据
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
			try {//解码处理
				nameCn = java.net.URLDecoder.decode(nameCn,"UTF-8");
				BILL_NO = java.net.URLDecoder.decode(BILL_NO,"UTF-8");
				REMARKS = java.net.URLDecoder.decode(REMARKS,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//session手工添加列表时保留页面数据
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
	 * @Description: 文件选择列表
	 * @author: panfeng
	 * @return String    返回类型 
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
		try {//解码处理
			name_cn = java.net.URLDecoder.decode(name_cn,"UTF-8");
			BILL_NO = java.net.URLDecoder.decode(BILL_NO,"UTF-8");
			REMARKS = java.net.URLDecoder.decode(REMARKS,"UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		// 1 设置分页参数
		int pageSize = getPageSize(Constants.DEFAULT_PAGESIZE);
		int page = getNowPage();
		if (page == 0) {
			page = 1;
		}
		// 获取排序字段
		String compositor = (String) getParameter("compositor", "");
		if ("".equals(compositor)) {
			compositor = null;
		}
		// 获取排序类型 ASC DESC
		String ordertype = (String) getParameter("ordertype", "");
		if ("".equals(ordertype)) {
			ordertype = null;
		}
		// 获取搜索参数
		InfoClueTo clueTo = (InfoClueTo) getAttribute("clueTo");// 获取操作结果提醒
		setAttribute("clueTo", clueTo);// set操作结果提醒
		Data data = getRequestEntityData("S_", "FILE_NO", "REGISTER_DATE_START", 
				"REGISTER_DATE_END", "AF_COST", "FILE_TYPE", 
				"AF_COST", "MALE_NAME", "FEMALE_NAME", "AF_COST_PAID");
		try {
			// 4 获取数据库连接
			conn = ConnectionManager.getConnection();
			// 5 获取数据DataList
			DataList dl = handler.selectFileList(conn, data, pageSize,
					page, compositor, ordertype, country_code, adopt_org_id, PAID_NO);
			// 6 将结果集写入页面接收变量
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

			// 将初次查询的文件列表放置到session中，供选择完成后对比
			HttpSession session = getRequest().getSession();
			session.setAttribute("newFileList", dl);

		} catch (DBException e) {
			// 7 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "列表查询操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			if (log.isError()) {
				log.logError("查询操作异常[查询操作]:" + e.getMessage(), e);
			}
			retValue = "error1";
		} finally {
			//8 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
					retValue = "error2";
				}
			}
		}

		return retValue;
	}
	
	
	/**
	 * @Title: billRegistrationSave
	 * @Description:票据登记保存、提交操作
	 * @author panfeng
	 * @date 2014-11-19
	 * @return
	 * @throws IOException 
	 * @throws
	 */
	public String billRegistrationSave() throws IOException{
		
//		// 获取页面类型（登记/修改）
//		String pageAction = this.getParameter("P_PAGEACTION");
		// 获取提交方式（保存/提交）
		String type = getParameter("type");
		// 获取操作人基本信息及系统日期
		String personId = SessionInfo.getCurUser().getPerson().getPersonId();
		String personName = SessionInfo.getCurUser().getPerson().getCName();
		String deptId = SessionInfo.getCurUser().getCurOrgan().getOrgCode();
		String curDate = DateUtility.getCurrentDate();
		
		// 获取session中的添加列表
		HttpSession session = getRequest().getSession();
		DataList dl = (DataList) session.getAttribute("fileList");
		
		// 获得页面表单数据，构造数据结果集
		
		// Start---------获取共用信息------------
		Data fileData = getRequestEntityData("P_","ADOPT_ORG_ID","NAME_CN","NAME_EN","COUNTRY_CODE","ORIGINAL_FILE_NO");
		Data billData = getRequestEntityData("P_","CHEQUE_ID","PAID_NO","COST_TYPE","PAID_SHOULD_NUM","PAID_WAY","PAR_VALUE","BILL_NO","REMARKS","CHEQUE_TRANSFER_STATE");
		
		// End---------获取共用信息------------
		billData.add("COUNTRY_CODE", (String)fileData.get("COUNTRY_CODE"));//票据国家
		billData.add("ADOPT_ORG_ID", (String)fileData.get("ADOPT_ORG_ID"));//票据收养组织ID
		billData.add("NAME_CN", (String)fileData.get("NAME_CN"));//票据收养组织中文
		billData.add("NAME_EN", (String)fileData.get("NAME_EN"));//票据收养组织英文
		billData.add("REG_USERID", personId);//票据录入人ID
		billData.add("REG_USERNAME", personName);//票据录入人姓名
		billData.add("REG_ORGID", deptId);//票据录入人所在部门ID
		billData.add("REG_DATE", curDate);//票据录入日期
		
		try {
			
			//3 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			//4 执行数据库处理操作
			FileCommonManager fileCommonManager = new FileCommonManager();
			String adoptOrgId = (String)fileData.get("ADOPT_ORG_ID");//组织机构代码
			String costType = (String)billData.get("COST_TYPE");//费用类别
			String billfileNo = "";//票据信息收文编号
			int totalAfCost = 0;//票据信息收文编号
			
			if ("".equals((String)billData.get("CHEQUE_ID")) || (String)billData.get("CHEQUE_ID")==null) {//登记操作
				String paidNo = fileCommonManager.createPayNO(conn, adoptOrgId, costType);//生成缴费编号
				billData.add("PAID_NO", paidNo);//缴费编号（票据表）
				DataList dataList = new DataList();
				for(int i=0; i<dl.size(); i++){
					Data fdata = dl.getData(i);
					String file_no = fdata.getString("FILE_NO");//文件编号
					billfileNo +=file_no + ","; 
					
					String af_cost = fdata.getString("AF_COST");//应缴金额（文件表）
					totalAfCost+=Integer.parseInt(af_cost);
					
					Data fidata = new Data();
					fidata.add("AF_ID", fdata.getString("AF_ID"));//文件信息主键
					fidata.add("PAID_NO", paidNo);//缴费编号（文件表）
					if("pjdjsubmit".equals(type)){
						fidata.add("AF_COST_PAID", "1");//提交业务时缴费状态为“已缴费”
					}
					dataList.add(handler.saveFile(conn, fidata, false));//保存文件信息业务数据
				}
				if(!"".equals(billfileNo) || billfileNo != ""){
					billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//票据信息收文编号
					billData.add("PAID_SHOULD_NUM", totalAfCost);//应缴金额（票据表）
				}else{
					billData.add("PAID_SHOULD_NUM", "0");
				}
			}else{//修改操作
				DataList dataList = new DataList();
				for(int i=0; i<dl.size(); i++){
					Data fdata = dl.getData(i);
					String file_no = fdata.getString("FILE_NO");//文件编号
					billfileNo +=file_no + ",";
					
					String af_cost = fdata.getString("AF_COST");//应缴金额（文件表）
					totalAfCost+=Integer.parseInt(af_cost);
					
					Data fidata = new Data();
					fidata.add("AF_ID", fdata.getString("AF_ID"));//文件信息主键
					fidata.add("PAID_NO", (String)billData.get("PAID_NO"));//缴费编号（文件表）
					if("pjdjsubmit".equals(type)){
						fidata.add("AF_COST_PAID", "1");//提交业务时缴费状态为“已缴费”
					}
					dataList.add(handler.saveFile(conn, fidata, false));//保存文件信息业务数据
				}
				if(!"".equals(billfileNo) || billfileNo != ""){
					billData.add("FILE_NO",billfileNo.substring(0, billfileNo.lastIndexOf(",")));//票据信息收文编号
					billData.add("PAID_SHOULD_NUM", totalAfCost);//应缴金额（票据表）
				}else{
					billData.add("FILE_NO", "");
					billData.add("PAID_SHOULD_NUM", "0");
				}
				billData.add("PAID_NO", (String)billData.get("PAID_NO"));//缴费编号（票据表）
			}
			DeptUtil deptUtil = new DeptUtil();
            SyzzDept syzzDept = deptUtil.getSYZZInfo(conn, adoptOrgId);
            String  syzzCnName = syzzDept.getSyzzCnName();//收养组织中文名称
            String  syzzEnName = syzzDept.getSyzzEnName();//收养组织英文名称
            billData.add("NAME_CN", syzzCnName);
            billData.add("NAME_EN", syzzEnName);
			billData = handler.saveBill(conn,billData);//保存票据业务数据
			
			DataList tranferDataList = new DataList();
			if("pjdjsubmit".equals(type)){//登记提交后，生成票据待移交数据
				Data dataTemp = new Data();
				dataTemp.add("APP_ID", billData.getString("CHEQUE_ID"));
				dataTemp.add("TRANSFER_CODE", TransferCode.CHEQUE_BGS_CWB);
				dataTemp.add("TRANSFER_STATE", "0");
				tranferDataList.add(dataTemp);			
				fileCommonManager.transferDetailInit(conn, tranferDataList);
			}
			
			dt.commit();
			if(type=="pjdjsubmit" || "pjdjsubmit".equals(type)){
				InfoClueTo clueTo = new InfoClueTo(0, "提交成功!");//提交成功 0
				setAttribute("clueTo", clueTo);
			}else{
				InfoClueTo clueTo = new InfoClueTo(0, "保存成功!");//保存成功 0
				setAttribute("clueTo", clueTo);
			}
		
		} catch (DBException e) {
			//5 设置异常处理
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			setAttribute(Constants.ERROR_MSG_TITLE, "操作异常");
			setAttribute(Constants.ERROR_MSG, e);
			
			if (log.isError()) {
				log.logError("操作异常[保存操作]:" + e.getMessage(),e);
			}
			//6 操作结果页面提示
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
			setAttribute("clueTo", clueTo);
			retValue = "error1";
		} catch (SQLException e) {
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
			setAttribute("clueTo", clueTo);
			retValue = "error2";
		} catch(Exception e){
			try {
				dt.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			if (log.isError()) {
				log.logError("操作异常:" + e.getMessage(),e);
			}
			InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
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
						log.logError("Connection因出现异常，未能关闭",e);
					}
					e.printStackTrace();
				}
			}
		}
		setAttribute("data", new Data());
		
		return retValue;
	}
	
	/**
	 * 修改
	 * @author Panfeng
	 * @date 2014-11-19
	 * @return
	 */
	public String billRevise(){
		//1 获取信息ID
		String uuid = getParameter("showuuid","");
		String file_no = getParameter("fileno","");
		String[] fileno = file_no.split(",");
		StringBuffer stringb = new StringBuffer();
		String wjbh = "";
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			for(int i=0; i<fileno.length; i++){
				stringb.append("'" + fileno[i] + "',");
			}
			wjbh = stringb.substring(0, stringb.length() - 1);
			DataList dl = handler.showFileList(conn, wjbh);//查询文件信息列表
			Data showdata = handler.getShowData(conn, uuid);//查询票据信息
			//4 变量代入查看页面
			
			// 将查询的文件列表放置到session中
			HttpSession session = getRequest().getSession();
			session.setAttribute("fileList", dl);
			
			setAttribute("fileList", dl);
			setAttribute("regData", showdata);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return SUCCESS;
	}
	
	/**
	 * @Title: billDelete 
	 * @Description: 删除未提交的票据信息
	 * @author: panfeng;
	 * @return    设定文件 
	 * @return String    返回类型 
	 * @throws
	 */
	public String billDelete() {
		//1 获取页面参数
		//票据ID
		String deleteuuid = getParameter("deleteuuid", "");
		String[] uuid = deleteuuid.split("#");
		//收文编号
		String file_no = getParameter("file_no", "");
		String[] fileNo = file_no.split(",");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			dt = DBTransaction.getInstance(conn);
			boolean success = false;
			//3 获取删除结果
			success = handler.billDelete(conn, uuid);//删除票据
			success = handler.fileUpdate(conn, fileNo);//更新文件信息
			if (success) {
				InfoClueTo clueTo = new InfoClueTo(0, "删除成功!");
				setAttribute("clueTo", clueTo);
			}
			dt.commit();
		} catch (Exception e) {
        	//4 设置异常处理
			setAttribute(Constants.ERROR_MSG_TITLE, "票据删除操作异常");
			setAttribute(Constants.ERROR_MSG, e);
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常[删除操作]:" + e.getMessage(),e);
            }
            InfoClueTo clueTo = new InfoClueTo(2, "数据删除失败!");
            setAttribute("clueTo", clueTo);
            
            retValue = "error1";
        } finally {
        	//5 关闭数据库
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
		return retValue;
	}
	
	/**
	 * 文件缴费通知单打印
	 * @author Panfeng
	 * @date 2014-12-9
	 * @return
	 */
	public String billPrint(){
		//1 获取信息ID
		String uuid = getParameter("printuuid","");
		String file_no = getParameter("fileno","");
		String[] fileno = file_no.split(",");
		StringBuffer stringb = new StringBuffer();
		String wjbh = "";
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			for(int i=0; i<fileno.length; i++){
				stringb.append("'" + fileno[i] + "',");
			}
			wjbh = stringb.substring(0, stringb.length() - 1);
			DataList dl = handler.showFileList(conn, wjbh);//查询文件信息列表
			Data printData = handler.getBothData(conn, uuid);//查询票据信息
			//获取票面金额合计数
//			Data sumData = handler.getSum(conn, wjbh);
//			printData.add("SUM", sumData.getString("SUM",""));
			//4 变量代入查看页面
			
			setAttribute("fileList", dl);
			setAttribute("data", printData);
		} catch (DBException e) {
			e.printStackTrace();
		}finally {
			//5 关闭数据库连接
			if (conn != null) {
				try {
					if (!conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					if (log.isError()) {
						log.logError("Connection因出现异常，未能关闭",e);
					}
				}
			}
		}
		return SUCCESS;
	}
	
	
	
}
