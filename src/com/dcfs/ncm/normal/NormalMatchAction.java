package com.dcfs.ncm.normal;

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

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.cms.childManager.ChildManagerHandler;
import com.dcfs.common.DcfsConstants;
import com.dcfs.ffs.common.FileCommonManager;
import com.dcfs.ffs.common.FileCommonStatusAndPositionManager;
import com.dcfs.ffs.common.FileOperationConstant;
import com.dcfs.ncm.MatchHandler;
import com.hx.framework.authenticate.SessionInfo;
/**
 * @Title: NormalMatchAction.java
 * @Description: 正常儿童匹配
 * @Company: 21softech
 * @Created on 2014-9-2 下午3:44:53
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */

public class NormalMatchAction extends BaseAction{

    private static Log log=UtilLog.getLog(NormalMatchAction.class);
    private Connection conn = null;
    private NormalMatchHandler handler;
    private MatchHandler Mhandler;
    private FileCommonManager AFhandler;
    private ChildManagerHandler CIhandler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
	public NormalMatchAction() {
	    this.handler=new NormalMatchHandler();
	    this.Mhandler=new MatchHandler();
	    this.AFhandler=new FileCommonManager();
	    this.CIhandler=new ChildManagerHandler();
	}

	@Override
	public String execute() throws Exception {
		return null;
	}
	
	/**
	 * 
	 * @Title: normalMatchAFList
	 * @Description: 匹配列表--收养人列表
	 * @author: xugy
	 * @date: 2014-9-2下午4:43:58
	 * @return
	 */
	public String normalMatchAFList(){
	    // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        String result = getParameter("result","");
        if("0".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(0, "匹配成功!");//保存成功 0
            setAttribute("clueTo", clueTo);//set操作结果提醒
        }
        if("2".equals(result)){
            InfoClueTo clueTo = new InfoClueTo(2, "匹配失败或该数据已匹配，请重新匹配!");//保存失败 2
            setAttribute("clueTo", clueTo);//set操作结果提醒
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","FILE_NO","REGISTER_DATE_START","REGISTER_DATE_END","COUNTRY_CODE","ADOPT_ORG_ID","MALE_NAME","FEMALE_NAME","MATCH_RECEIVEDATE_START","MATCH_RECEIVEDATE_END","FILE_TYPE","ADOPT_REQUEST_CN","UNDERAGE_NUM","MATCH_NUM","MATCH_STATE");
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findMatchList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("List",dl);
            setAttribute("data",data);
            setAttribute("compositor",compositor);
            setAttribute("ordertype",ordertype);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "正常儿童匹配列表查询操作异常");
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
                        log.logError("NormalMatchAction的matchList.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	
	/**
	 * 
	 * @Title: matchPlanCount
	 * @Description: 正常儿童预分配计划统计页面
	 * @author: xugy
	 * @date: 2014-9-2下午7:23:43
	 * @return
	 */
	public String toMatchPlanCount(){
	    Data Data = new Data();
	    DataList CIdl = new DataList();
	    setAttribute("CIdl",CIdl);
	    setAttribute("Data",Data);
        return retValue;
	}
	
	/**
	 * 
	 * @Title: planCount
	 * @Description: 正常儿童预分配计划统计
	 * @author: xugy
	 * @date: 2014-9-3下午3:19:27
	 * @return
	 */
	public String planCount(){
	    Data Data = getRequestEntityData("C_","COUNT_DATE","FILE_TYPE","DATE_START","DATE_END");
	    try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            /***************查询儿童材料数据****************/
            DataList CIdl = new DataList();
            Data CIdata = new Data();//儿童材料数据
            //String FILE_STATE = Data.getString("FILE_STATE");
            CIdl = handler.CIplanCount(conn);
            CIdata = handler.CIplanCountSum(conn);
            Data.addData(CIdata);
            /***************查询儿童材料数据****************/
            /***************查询收养文件数据****************/
            Data AFdata = new Data();//收养文件数据
            String FILE_TYPE = Data.getString("FILE_TYPE");
            String DATE_START = Data.getString("DATE_START");
            String DATE_END = Data.getString("DATE_END");
            //判断统计基准的不同：收文登记日期（REG_DATE）；文件交接日期（RECEIVER_DATE）， 不同的查询方法。
            String COUNT_DATE = Data.getString("COUNT_DATE");
            if("REG_DATE".equals(COUNT_DATE)){//如果统计基准是收文登记日期，查询REG_DATE字段
                AFdata=handler.AFplanCountSum1(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            if("RECEIVER_DATE".equals(COUNT_DATE)){//如果统计基准是文件交接日期，查询RECEIVER_DATE字段，需联表查询
                AFdata=handler.AFplanCountSum2(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            Data.addData(AFdata);
            /***************查询收养文件数据****************/
            //剩余材料
            int CI_COUNT = CIdata.getInt("CI_COUNT");
            int AF_COUNT = AFdata.getInt("AF_COUNT");
            int surplus = CI_COUNT-AF_COUNT;
            Data.add("SURPLUS", surplus);
            //将结果集写入页面接收变量
            setAttribute("CIdl",CIdl);
            setAttribute("Data",Data);
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "操作异常");
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
	
	public String AFPlanList(){
	    Data Data = new Data();
	    String COUNT_DATE = getParameter("COUNT_DATE");
	    String FILE_TYPE = getParameter("FILE_TYPE");
	    String DATE_START = getParameter("DATE_START");
	    String DATE_END = getParameter("DATE_END");
	    Data.add("COUNT_DATE", COUNT_DATE);
	    Data.add("FILE_TYPE", FILE_TYPE);
	    Data.add("DATE_START", DATE_START);
	    Data.add("DATE_END", DATE_END);
	    try {
	        //获取数据库连接
            conn = ConnectionManager.getConnection();
            DataList AFdl = new DataList();
            //判断统计基准的不同：收文登记日期（REG_DATE）；文件交接日期（RECEIVER_DATE）， 不同的查询方法。
            if("REG_DATE".equals(COUNT_DATE)){//如果统计基准是收文登记日期，查询REG_DATE字段
                AFdl=handler.findAFPlanList1(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            if("RECEIVER_DATE".equals(COUNT_DATE)){//如果统计基准是文件交接日期，查询RECEIVER_DATE字段，需联表查询
                AFdl=handler.findAFPlanList2(conn,FILE_TYPE,DATE_START,DATE_END);
            }
            
            
	        setAttribute("AFdl",AFdl);
	        setAttribute("Data",Data);
	    } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "操作异常");
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
	
	public String exportExcel() throws Exception{
	    Data Data = getRequestEntityData("E_","COUNT_DATE","FILE_TYPE","DATE_START","DATE_END");
	    HttpServletResponse response = getResponse();
        OutputStream os = response.getOutputStream();// 取得输出流
        response.reset();// 清空输出流
	    try {
	        //获取数据库连接
            conn = ConnectionManager.getConnection();
            DataList AFdl = new DataList();
            String FILE_TYPE = Data.getString("FILE_TYPE");
            String DATE_START = Data.getString("DATE_START");
            String DATE_END = Data.getString("DATE_END");
            //判断统计基准的不同：收文登记日期（REG_DATE）；文件交接日期（RECEIVER_DATE）， 不同的查询方法。
            String COUNT_DATE = Data.getString("COUNT_DATE");
            String tab_benchmark = "";//制表基准
            if("REG_DATE".equals(COUNT_DATE)){//如果统计基准是收文登记日期，查询REG_DATE字段
                AFdl=handler.findAFPlanList1(conn,FILE_TYPE,DATE_START,DATE_END);
                tab_benchmark = "收文登记日期";
            }
            if("RECEIVER_DATE".equals(COUNT_DATE)){//如果统计基准是文件交接日期，查询RECEIVER_DATE字段，需联表查询
                AFdl=handler.findAFPlanList2(conn,FILE_TYPE,DATE_START,DATE_END);
                tab_benchmark = "文件交接日期";
            }
            // 建立excel文件
            WritableWorkbook wbook = Workbook.createWorkbook(os);
            // sheet名称
            WritableSheet sheetOne = wbook.createSheet("分配计划表", 0);
            sheetOne.setColumnView(0, 5);//设置列宽
            sheetOne.setColumnView(11, 30);//设置列宽
            sheetOne.setColumnView(12, 30);//设置列宽
            sheetOne.getSettings().setDefaultColumnWidth(15); // 设置所有列默认宽度
            sheetOne.setRowView(0, 700);//设置行高
            sheetOne.setRowView(1, 500);//设置行高
            sheetOne.setRowView(2, 500);//设置行高
            sheetOne.setRowView(3, 500);//设置行高
            
            // 建立样式
            WritableFont wfont1 = new WritableFont(WritableFont.ARIAL, 12,WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
            WritableFont wfont2 = new WritableFont(WritableFont.ARIAL, 16,WritableFont.BOLD, false, UnderlineStyle.NO_UNDERLINE,Colour.BLACK); // 定义格式 字体 下划线 斜体 粗体 颜色
            // 建立单元格样式
            WritableCellFormat cfont1 = new WritableCellFormat(wfont1);
            cfont1.setBackground(Colour.WHITE); // 设置单元格的背景颜色
            cfont1.setAlignment(Alignment.CENTRE); // 设置水平对齐方式
            cfont1.setVerticalAlignment(VerticalAlignment.CENTRE);// 设置垂直对其方式;
            cfont1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK); // 设置边框
            cfont1.setWrap(true);// 自动换行
            WritableCellFormat cfont2 = new WritableCellFormat(wfont2);
            cfont2.setBackground(Colour.WHITE); // 设置单元格的背景颜色
            cfont2.setAlignment(Alignment.CENTRE); // 设置水平对齐方式
            cfont2.setVerticalAlignment(VerticalAlignment.CENTRE);// 设置垂直对其方式;
            cfont2.setBorder(jxl.format.Border.NONE,jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK); // 设置边框
            cfont2.setWrap(true);// 自动换行
            WritableCellFormat cfont3 = new WritableCellFormat(wfont1);
            cfont3.setBackground(Colour.WHITE); // 设置单元格的背景颜色
            cfont3.setAlignment(Alignment.LEFT); // 设置水平对齐方式
            cfont3.setVerticalAlignment(VerticalAlignment.CENTRE);// 设置垂直对其方式;
            cfont3.setBorder(jxl.format.Border.NONE,jxl.format.BorderLineStyle.THIN, jxl.format.Colour.BLACK); // 设置边框
            cfont3.setWrap(true);// 自动换行
            
            // 设置表头
            Label t00 = new Label(0, 0, "正常儿童预分配计划表", cfont2);
            sheetOne.mergeCells(0, 0, 12, 0);
            Label t01 = new Label(0, 1, "制表基准："+tab_benchmark, cfont3);
            sheetOne.mergeCells(0, 1, 8, 1);
            Label t02 = new Label(0, 2, "制表区间："+DATE_START+"~"+DATE_END, cfont3);
            sheetOne.mergeCells(0, 2, 8, 2);
            String tab_interval = "";//制表区间
            if("10".equals(FILE_TYPE)){
                tab_interval = "正常";
            }
            if("30".equals(FILE_TYPE)){
                tab_interval = "领导特批";
            }
            if("31".equals(FILE_TYPE)){
                tab_interval = "在华";
            }
            if("32".equals(FILE_TYPE)){
                tab_interval = "华人";
            }
            if("33".equals(FILE_TYPE)){
                tab_interval = "继子女收养";
            }
            if("34".equals(FILE_TYPE)){
                tab_interval = "亲属收养";
            }
            if("35".equals(FILE_TYPE)){
                tab_interval = "华侨";
            }
            Label t03 = new Label(0, 3, "制表对象："+tab_interval+"文件", cfont3);
            sheetOne.mergeCells(0, 3, 8, 3);
            
            Label t81 = new Label(9, 1, "", cfont3);
            sheetOne.mergeCells(9, 1, 12, 1);
            Label t82 = new Label(9, 2, "", cfont3);
            sheetOne.mergeCells(9, 2, 12, 2);
            Label t83 = new Label(9, 3, "制表日期："+DateUtility.getCurrentDate(), cfont3);
            sheetOne.mergeCells(9, 3, 12, 3);
            Label t04 = new Label(0, 4, "序号", cfont1);
            Label t14 = new Label(1, 4, "文件编号", cfont1);
            Label t24 = new Label(2, 4, "登记日期", cfont1);
            Label t34 = new Label(3, 4, "国家", cfont1);
            Label t44 = new Label(4, 4, "收养机构", cfont1);
            Label t54 = new Label(5, 4, "男收养人", cfont1);
            Label t64 = new Label(6, 4, "男方出生日期", cfont1);
            Label t74 = new Label(7, 4, "女收养人", cfont1);
            Label t84 = new Label(8, 4, "女方出生日期", cfont1);
            Label t94 = new Label(9, 4, "政府批准书日期", cfont1);
            Label t104 = new Label(10, 4, "到期日期", cfont1);
            Label t114 = new Label(11, 4, "子女情况", cfont1);
            Label t124 = new Label(12, 4, "收养要求", cfont1);
            // 将表头加入sheet中
            sheetOne.addCell(t00);
            sheetOne.addCell(t01);
            sheetOne.addCell(t02);
            sheetOne.addCell(t03);
            sheetOne.addCell(t81);
            sheetOne.addCell(t82);
            sheetOne.addCell(t83);
            sheetOne.addCell(t04);
            sheetOne.addCell(t14);
            sheetOne.addCell(t24);
            sheetOne.addCell(t34);
            sheetOne.addCell(t44);
            sheetOne.addCell(t54);
            sheetOne.addCell(t64);
            sheetOne.addCell(t74);
            sheetOne.addCell(t84);
            sheetOne.addCell(t94);
            sheetOne.addCell(t104);
            sheetOne.addCell(t114);
            sheetOne.addCell(t124);
            if(AFdl.size()>0){
                for(int i=0;i<AFdl.size();i++){
                    //序号
                    int k = i+1;
                    String num = String.valueOf(k);
                    Label xuhao = new Label(0, i + 5, num, cfont1);
                    sheetOne.addCell(xuhao);
                    //文件编号
                    String FILE_NO = AFdl.getData(i).getString("FILE_NO", "");
                    Label fileNo = new Label(1, i + 5, FILE_NO, cfont1);
                    sheetOne.addCell(fileNo);
                    //登记日期
                    String REG_DATE = AFdl.getData(i).getDate("REG_DATE");
                    Label regDate = new Label(2, i + 5, REG_DATE, cfont1);
                    sheetOne.addCell(regDate);
                    //国家
                    String COUNTRY_CN = AFdl.getData(i).getString("COUNTRY_CN", "");
                    Label countryCn = new Label(3, i + 5, COUNTRY_CN, cfont1);
                    sheetOne.addCell(countryCn);
                    //收养机构
                    String NAME_CN = AFdl.getData(i).getString("NAME_CN", "");
                    Label nameCn = new Label(4, i + 5, NAME_CN, cfont1);
                    sheetOne.addCell(nameCn);
                    //男收养人
                    String MALE_NAME = AFdl.getData(i).getString("MALE_NAME", "");
                    Label maleName = new Label(5, i + 5, MALE_NAME, cfont1);
                    sheetOne.addCell(maleName);
                    //男方出生日期
                    String MALE_BIRTHDAY = AFdl.getData(i).getDate("MALE_BIRTHDAY");
                    Label maleBirthday = new Label(6, i + 5, MALE_BIRTHDAY, cfont1);
                    sheetOne.addCell(maleBirthday);
                    //女收养人
                    String FEMALE_NAME = AFdl.getData(i).getString("FEMALE_NAME", "");
                    Label femaleName = new Label(7, i + 5, FEMALE_NAME, cfont1);
                    sheetOne.addCell(femaleName);
                    //女方出生日期
                    String FEMALE_BIRTHDAY = AFdl.getData(i).getDate("FEMALE_BIRTHDAY");
                    Label femaleBirthday = new Label(8, i + 5, FEMALE_BIRTHDAY, cfont1);
                    sheetOne.addCell(femaleBirthday);
                    //政府批准书日期
                    String GOVERN_DATE = AFdl.getData(i).getDate("GOVERN_DATE");
                    Label governDate = new Label(9, i + 5, GOVERN_DATE, cfont1);
                    sheetOne.addCell(governDate);
                    //到期日期
                    String EXPIRE_DATE = AFdl.getData(i).getDate("EXPIRE_DATE");
                    Label expireDate = new Label(10, i + 5, EXPIRE_DATE, cfont1);
                    sheetOne.addCell(expireDate);
                    //子女情况
                    String CHILD_CONDITION_CN = AFdl.getData(i).getString("CHILD_CONDITION_CN", "");
                    Label childConditionCn = new Label(11, i + 5, CHILD_CONDITION_CN, cfont1);
                    sheetOne.addCell(childConditionCn);
                    //收养要求
                    String ADOPT_REQUEST_CN = AFdl.getData(i).getString("ADOPT_REQUEST_CN", "");
                    Label adoptRequestCn = new Label(12, i + 5, ADOPT_REQUEST_CN, cfont1);
                    sheetOne.addCell(adoptRequestCn);
                }
                //合计
                int index = AFdl.size();
                String countSum = String.valueOf(index);
                Label heji = new Label(0, index + 5, "合计：共计"+countSum+"份", cfont3);
                sheetOne.mergeCells(0, index + 5, 12, index + 5);
                sheetOne.addCell(heji);
            }
            
            response.setHeader("Content-disposition", "attachment; filename="+ java.net.URLEncoder.encode("正常儿童预分配计划表.xls", "UTF-8"));// 设定输出文件头
            response.setContentType("application/msexcel");// 定义输出类型
            
            wbook.write();
            wbook.close();
	    }catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "操作异常");
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
        return null;
	}
	/**
	 * 
	 * @Title: normalMatchCIList
	 * @Description: 选择匹配儿童列表
	 * @author: xugy
	 * @date: 2014-9-4下午2:30:11
	 * @return
	 */
	public String normalMatchCIList(){
	    // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor=null;
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype=null;
        }
        //3 获取搜索参数
        InfoClueTo clueTo= (InfoClueTo)getAttribute("clueTo");//获取操作结果提醒
        setAttribute("clueTo", clueTo);//set操作结果提醒
        String AFid = getParameter("AFid");//选择的收养人文件的ID
        
        Data data = getRequestEntityData("S_","PROVINCE_ID","WELFARE_ID","CHECKUP_DATE_START","CHECKUP_DATE_END","NAME","SEX","BIRTHDAY_START","BIRTHDAY_END");//查询条件
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            Data AFdata=Mhandler.getAFInfoOfAfId(conn, AFid);//获取选择的收养人文件信息
            String nowYear = DateUtility.getCurrentYear();
            //男收养人年龄
            if(!"".equals(AFdata.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = AFdata.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                AFdata.add("MALE_AGE", maleAge);
            }
            //女收养人年龄
            if(!"".equals(AFdata.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = AFdata.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                AFdata.add("FEMALE_AGE", femaleAge);
            }
            data.addData(AFdata);
            //5 获取数据DataList
            DataList CIdl=handler.findCIMatchList(conn,data,pageSize,page,compositor,ordertype);
            //6 将结果集写入页面接收变量
            setAttribute("CIdl",CIdl);
            setAttribute("AFid",AFid);
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
                        log.logError("NormalMatchAction的CIMatchList.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	/**
	 * 
	 * @Title: showCIs
	 * @Description: 显示儿童信息
	 * @author: xugy
	 * @date: 2014-9-4下午5:01:14
	 * @return
	 */
	public String showCIs(){
	    String CHILD_NOs = getParameter("CHILD_NOs");//儿童编号，有同胞的多个儿童编号
	    try {
	        //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            //DataList CIdls=Mhandler.getCIInfoInChildNo(conn,InChildNo);
            //将结果集写入页面接收变量
            setAttribute("CHILD_NOs",CHILD_NOs);
	    }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction的showCIs.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	/**
	 * 
	 * @Title: matchPreview
	 * @Description: 匹配预览
	 * @author: xugy
	 * @date: 2014-9-4下午7:51:06
	 * @return
	 */
	public String matchPreview(){
	    String CIid = getParameter("CIid");//匹配儿童ID
	    String AFid = getParameter("AFid");//匹配收养人ID
	    try {
	        //获取数据库连接
            conn = ConnectionManager.getConnection();
            //查询收养人信息
            Data data = Mhandler.getAFInfoOfAfId(conn, AFid);
            //将结果集写入页面接收变量
            setAttribute("CIid",CIid);
            setAttribute("AFid",AFid);
            setAttribute("data",data);
	    }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction的matchPreview.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
	}
	/**
	 * 
	 * @Title: showTwinsCI
	 * @Description: 查看儿童同胞信息
	 * @author: xugy
	 * @date: 2014-9-5下午5:05:19
	 * @return
	 */
	public String showTwinsCI(){
	    String CHILD_NOs = getParameter("CHILD_NOs");//儿童同胞ID，或多个ID
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            //DataList CIdls=Mhandler.getCIInfoInChildNo(conn,ids);
            //将结果集写入页面接收变量
            setAttribute("CHILD_NOs",CHILD_NOs);
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } finally {
            //关闭数据库连接
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("NormalMatchAction的showCIs.Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
	/**
	 * 
	 * @Title: saveMatchResult
	 * @Description: 保存匹配结果
	 * @author: xugy
	 * @date: 2014-9-5上午10:06:48
	 * @return
	 */
	public String saveMatchResult(){
	    String AFid = getParameter("AFid");//收养人文件ID
	    String Ins_ADOPT_ORG_ID = getParameter("Ins_ADOPT_ORG_ID");//收养组织ID
	    String CIid = getParameter("CIid");//儿童材料ID
	    String CIids = CIid;
	    try{
	        //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            Data FUdata = Mhandler.selectMatchStateForUpdate(conn, AFid, CIid);
            String AF_MATCH_STATE = FUdata.getString("AF_MATCH_STATE", "");
            String CI_MATCH_STATE = FUdata.getString("CI_MATCH_STATE", "");
            if(!"1".equals(AF_MATCH_STATE) && !"1".equals(CI_MATCH_STATE)){
                //同胞儿童处理
                String TWINS_IDS = Mhandler.getCIInfoOfCiId(conn, CIid).getString("TWINS_IDS", "");
                if(!"".equals(TWINS_IDS)){
                    String[] childNoArry = TWINS_IDS.split(",");
                    for(int i=0;i<childNoArry.length;i++){
                        String childNo = childNoArry[i];
                        String CI_ID = Mhandler.getCiIdOfChildNo(conn, childNo);
                        CIids = CIids + "," + CI_ID;
                    }
                }
                String[] ciIdArry = CIids.split(",");
                
                for(int i=0;i<ciIdArry.length;i++){
                    Data data = new Data();
                    data.add("MI_ID", "");//匹配信息ID
                    data.add("ADOPT_ORG_ID", Ins_ADOPT_ORG_ID);//收养组织ID
                    data.add("AF_ID", AFid);//收养文件ID
                    data.add("CI_ID", ciIdArry[i]);//儿童材料ID
                    data.add("CHILD_TYPE", "1");//儿童类型
                    data.add("MATCH_USERID", SessionInfo.getCurUser().getPerson().getPersonId());//匹配人ID
                    data.add("MATCH_USERNAME", SessionInfo.getCurUser().getPerson().getCName());//匹配人姓名
                    data.add("MATCH_DATE", DateUtility.getCurrentDate());//匹配日期
                    data.add("MATCH_STATE", "0");//匹配状态
                    //保存匹配结果
                    Data MIdata = Mhandler.saveNcmMatchInfo(conn, data);
                    String MI_ID = MIdata.getString("MI_ID");//匹配信息ID
                    //插入一条匹配审核记录信息
                    Data MAdata = new Data();//匹配审核记录数据
                    MAdata.add("MAU_ID", "");//匹配审核记录ID
                    MAdata.add("MI_ID", MI_ID);//匹配信息ID
                    MAdata.add("AUDIT_LEVEL", "0");//审核级别：经办人审核
                    MAdata.add("OPERATION_STATE", "0");//操作状态：待处理
                    Mhandler.saveNcmMatchAudit(conn, MAdata);
                    
                    //查询儿童信息，以便获得匹配次数，修改儿童的匹配信息
                    Data CIdata = Mhandler.getCIInfoOfCiId(conn, ciIdArry[i]);
                    String CI_MATCH_NUM = CIdata.getString("MATCH_NUM", "0");
                    int ci_num = Integer.parseInt(CI_MATCH_NUM) + 1;//儿童匹配次数加一
                    Data CIStateData = new Data();//儿童匹配数据
                    CIStateData.add("CI_ID", ciIdArry[i]);//儿童材料ID
                    CIStateData.add("MATCH_NUM", ci_num);//儿童材料匹配次数
                    CIStateData.add("MATCH_STATE", "1");//儿童材料匹配状态
                    //材料全局状态和位置
                    ChildCommonManager childCommonManager = new ChildCommonManager();
                    CIStateData = childCommonManager.matchAuditJBR(CIStateData, SessionInfo.getCurUser().getCurOrgan());
                    CIhandler.save(conn, CIStateData);
                }
                //查询收养人信息，以便获得匹配次数，修改收养人的匹配信息
                Data AFdata = Mhandler.getAFInfoOfAfId(conn, AFid);
                String AF_MATCH_NUM = AFdata.getString("MATCH_NUM", "0");
                int af_num = Integer.parseInt(AF_MATCH_NUM) + 1;//收养人匹配次数加一
                Data AFStateData = new Data();//收养人匹配数据
                AFStateData.add("AF_ID", AFid);//收养人文件ID
                AFStateData.add("MATCH_NUM", af_num);//收养人匹配次数
                AFStateData.add("MATCH_STATE", "1");//收养人匹配状态
                AFStateData.add("CI_ID", CIid);//儿童材料ID
                
                if(ciIdArry.length>1){//如果匹配儿童多人，修改收养人文件的应缴金额和完费状态
                    int num = ciIdArry.length;
                    FileCommonManager fileCommonManager = new FileCommonManager();
                    int cost = fileCommonManager.getAfCost(conn, "ZCWJFWF");
                    int AF_COST = cost * num;
                    if(AF_COST > AFdata.getInt("AF_COST")){
                        AFStateData.add("AF_COST", AF_COST);//收养人应缴金额
                        AFStateData.add("AF_COST_CLEAR", "0");//收养人完费状态
                    }
                    
                }
                //文件全局状态和位置
                FileCommonStatusAndPositionManager fileCommonStatusAndPositionManager = new FileCommonStatusAndPositionManager();
                Data data = fileCommonStatusAndPositionManager.getNextGlobalAndPosition(FileOperationConstant.AZB_ZCYW_PP_SUBMIT);
                AFStateData.addData(data);
                
                AFhandler.modifyFileInfo(conn, AFStateData);//修改文件信息
                
                String result = "0";
                setAttribute("result", result);
            }else{
                String result = "2";
                setAttribute("result", result);
            }
            
            dt.commit();
	    }catch (DBException e) {
            //设置异常处理
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("操作异常[保存操作]:" + e.getMessage(),e);
            }
            
            //操作结果页面提示
            //InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");//保存失败 2
            String result = "2";
            setAttribute("result", result);
            //retValue = "error1";
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
            //InfoClueTo clueTo = new InfoClueTo(2, "数据保存失败!");
            //setAttribute("clueTo", clueTo);
            String result = "2";
            setAttribute("result", result);
            //retValue = "error2";
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
        return retValue;
	}
}
