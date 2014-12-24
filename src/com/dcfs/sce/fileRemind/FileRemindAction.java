package com.dcfs.sce.fileRemind;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import com.dcfs.common.DcfsConstants;

/**
 * 
 * @Title: FileRemindAction.java
 * @Description: 递交文件催办查询、查看操作
 * @Company: 21softech
 * @Created on 2014-9-15 下午5:01:29 
 * @author panfeng
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class FileRemindAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(FileRemindAction.class);
    private Connection conn = null;
    private FileRemindHandler handler;
    private String retValue = SUCCESS;
    
    public FileRemindAction() {
        this.handler=new FileRemindHandler();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    
    /**
     * 
     * @Title: findRemindList
     * @Description: 递交文件催办查询列表
     * @author: panfeng
     * @date: 2014-9-15 下午5:01:29 
     * @return
     */
    public String findRemindList(){
        // 1 设置分页参数
        int pageSize = getPageSize(DcfsConstants.DEFAULT_PAGESIZE);
        int page = getNowPage();
        if (page == 0) {
            page = 1;
        }
        //2.1 获取排序字段
        String compositor=(String)getParameter("compositor","");
        if("".equals(compositor)){
            compositor="REQ_DATE";
        }
        //2.2 获取排序类型   ASC DESC
        String ordertype=(String)getParameter("ordertype","");
        if("".equals(ordertype)){
            ordertype="DESC";
        }
        //3 获取搜索参数
        Data data = getRequestEntityData("S_","MALE_NAME","FEMALE_NAME","NAME_PINYIN","SEX",
        			"BIRTHDAY_START","BIRTHDAY_END","REQ_DATE_START","REQ_DATE_END",
        			"PASS_DATE_START","PASS_DATE_END","SUBMIT_DATE_START","SUBMIT_DATE_END",
        			"REM_DATE_START","REM_DATE_END");
        //男方、女方搜索输入条件转换大写
        String MALE_NAME = data.getString("MALE_NAME",null);
		if(MALE_NAME != null){
			data.put("MALE_NAME", MALE_NAME.toUpperCase());
		}
		String FEMALE_NAME = data.getString("FEMALE_NAME",null);
		if(FEMALE_NAME != null){
			data.put("FEMALE_NAME", FEMALE_NAME.toUpperCase());
		}
		String NAME_PINYIN = data.getString("NAME_PINYIN",null);
		if(NAME_PINYIN != null){
			data.put("NAME_PINYIN", NAME_PINYIN.toUpperCase());
		}
        try {
            //4 获取数据库连接
            conn = ConnectionManager.getConnection();
            //5 获取数据DataList
            DataList dl=handler.findRemindList(conn,data,pageSize,page,compositor,ordertype);
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
	 * 文件超期提醒页面
	 * @author Panfeng
	 * @date 2014-9-4 
	 * @return
	 */
	public String showRemindNotice(){
		//1 获取页面代进的ID
		String uuid = getParameter("showuuid","");
		try {
			//2 获取数据库连接
			conn = ConnectionManager.getConnection();
			//3 获取信息结果集
			Data showdata = handler.getRemindShow(conn, uuid);
			
			//计算通知日期
      		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      		Calendar cal = Calendar.getInstance();
      		String submit_date = showdata.getString("SUBMIT_DATE","");
      		cal.setTime(sdf.parse(submit_date));
      		cal.add(Calendar.MONTH, -6);
      		showdata.add("NOTICE_DATE", sdf.format(cal.getTime()));//通知日期
      		
      		//日期转换yyyy年MM月dd日
      		SimpleDateFormat cn_fmt = new SimpleDateFormat("yyyy年MM月dd日");
      		Calendar cal1 = Calendar.getInstance();
      		cal1.setTime(sdf.parse(showdata.getString("NOTICE_DATE","")));
      		String cn_notice_date = cn_fmt.format(cal1.getTime()); 
      		showdata.add("CN_NOTICE_DATE",cn_notice_date);//通知日期
      		Calendar cal2 = Calendar.getInstance();
      		cal2.setTime(sdf.parse(submit_date));
      		String cn_submit_date = cn_fmt.format(cal2.getTime()); 
      		showdata.add("CN_SUBMIT_DATE",cn_submit_date);//递交文件期限日期
      		Calendar cal3 = Calendar.getInstance();
      		cal3.setTime(sdf.parse(showdata.getString("REM_DATE","")));
      		String cn_rem_date = cn_fmt.format(cal3.getTime()); 
      		showdata.add("CN_REM_DATE",cn_rem_date);//催办日期
      		
      		//日期转换为英文格式
      		Locale l = new Locale("en");
      		Calendar cal4 = Calendar.getInstance();
      		cal4.setTime(sdf.parse(showdata.getString("NOTICE_DATE","")));
      		String day1 = String.format("%td", cal4);
      		String month1 = String.format(l,"%tb", cal4);
    		String year1 = String.format("%tY", cal4);
      		showdata.add("EN_NOTICE_DATE",month1+" "+day1+","+year1);//通知日期
      		Calendar cal5 = Calendar.getInstance();
      		cal5.setTime(sdf.parse(submit_date));
      		String day2 = String.format("%td", cal5);
      		String month2 = String.format(l,"%tb", cal5);
      		String year2 = String.format("%tY", cal5);
      		showdata.add("EN_SUBMIT_DATE",month2+" "+day2+","+year2);//递交文件期限日期
      		Calendar cal6 = Calendar.getInstance();
      		cal6.setTime(sdf.parse(showdata.getString("REM_DATE","")));
      		String day3 = String.format("%td", cal6);
      		String month3 = String.format(l,"%tb", cal6);
      		String year3 = String.format("%tY", cal6);
      		showdata.add("EN_REM_DATE",month3+" "+day3+","+year3);//催办日期
      		
			//4 变量代入页面
      		setAttribute("male_name", showdata.getString("MALE_NAME",""));
			setAttribute("female_name", showdata.getString("FEMALE_NAME",""));
			setAttribute("remindData", showdata);
		} catch (DBException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
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
