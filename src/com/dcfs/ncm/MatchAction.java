package com.dcfs.ncm;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.config.CommonConfig;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import com.dcfs.cms.ChildInfoConstants;
import com.dcfs.cms.childManager.ChildCommonManager;
import com.dcfs.common.atttype.AttConstants;
import com.hx.framework.authenticate.SessionInfo;
import com.hx.upload.sdk.AttHelper;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfReader;
import com.lowagie.text.pdf.PdfStamper;
import com.lowagie.text.pdf.PdfWriter;
/**
 * 
 * @Title: MatchAction.java
 * @Description: 匹配公共方法
 * @Company: 21softech
 * @Created on 2014-10-30 上午10:17:42
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MatchAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(MatchAction.class);
    private Connection conn = null;
    private MatchHandler handler;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public MatchAction() {
        this.handler=new MatchHandler();
    }
    
    String HEIFontPath = CommonConfig.getProjectPath() + "/Fonts/SIMHEI.TTF";
    String SONGFontPatn = CommonConfig.getProjectPath() + "/Fonts/SIMSUN.TTC,0";
    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: showCIsInfoInChildNo
     * @Description: 儿童信息查看
     * @author: xugy
     * @date: 2014-10-30上午10:51:58
     * @return
     */
    public String showCIsInfoInChildNo(){
        String CHILD_NOs = getParameter("CHILD_NOs");//儿童编号，有同胞的多个儿童编号
        String[] Arry = CHILD_NOs.split(",");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            String InChildNo = "";
            for(int i=0;i<Arry.length;i++){
                String CHILD_NO = Arry[i];
                if(i==0){
                    InChildNo = "'" + CHILD_NO + "'";
                }else{
                    InChildNo = InChildNo + ",'" + CHILD_NO + "'";
                }
            }
            //获取数据DataList
            DataList CIdls=handler.getCIInfoInChildNo(conn,InChildNo);
            //将结果集写入页面接收变量
            setAttribute("CIdls",CIdls);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showCIInfoFirst
     * @Description: 根据主键获得儿童信息
     * @author: xugy
     * @date: 2014-10-30下午1:00:34
     * @return
     */
    public String showCIInfoFirst(){
        String CI_ID = getParameter("CI_ID");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            if(!"".equals(data.getString("BIRTHDAY", ""))){
                String birthdayYear = data.getDate("BIRTHDAY").substring(0, 4);
                String nowYear = DateUtility.getCurrentYear();
                int old = Integer.parseInt(nowYear)-Integer.parseInt(birthdayYear)+1;
                data.add("AGE", old);
            }
            String TWINS_IDS = data.getString("TWINS_IDS","");
            String TWINS_NAMES = "";
            if(!"".equals(TWINS_IDS)){
                String[] array = TWINS_IDS.split(",");
                for(int i=0;i<array.length;i++){
                    Data d = handler.getCIInfoOfChildNo(conn, array[i]);
                    String NAME = d.getString("NAME", "");
                    if(i==0){
                        TWINS_NAMES = NAME;
                    }else{
                        TWINS_NAMES = TWINS_NAMES + ";" + NAME;
                    }
                }
            }
            data.add("TWINS_NAMES", TWINS_NAMES);
            //将结果集写入页面接收变量
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: showCIInfoSign
     * @Description: 签批页面儿童查看
     * @author: xugy
     * @date: 2014-12-12下午3:52:15
     * @return
     */
    public String showCIInfoSign(){
        String CI_ID = getParameter("CI_ID");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            //将结果集写入页面接收变量
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: showCIInfoSecond
     * @Description: 儿童信息显示
     * @author: xugy
     * @date: 2014-11-3下午9:22:48
     * @return
     */
    public String showCIInfoSecond(){
        String CI_ID = getParameter("CI_ID");//
        String LANG = getParameter("LANG");//语言
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("LANG",LANG);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showCIInfoThird
     * @Description: 
     * @author: xugy
     * @date: 2014-11-15下午6:51:36
     * @return
     */
    public String showCIInfoThird(){
        String CI_ID = getParameter("CI_ID");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            Data data=handler.getCIInfoOfCiId(conn,CI_ID);
            //将结果集写入页面接收变量
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showAFInfoFirst
     * @Description: 根据主键获得收养人信息
     * @author: xugy
     * @date: 2014-10-30下午1:05:48
     * @return
     */
    public String showAFInfoFirst(){
        String AF_ID = getParameter("AF_ID");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            Data data=handler.getAFInfoOfAfId(conn,AF_ID);
            String nowYear = DateUtility.getCurrentYear();
            //男收养人年龄
            if(!"".equals(data.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = data.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                data.add("MALE_AGE", maleAge);
            }
            //女收养人年龄
            if(!"".equals(data.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = data.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                data.add("FEMALE_AGE", femaleAge);
            }
            //家庭净资产
            int TOTAL_ASSET = data.getInt("TOTAL_ASSET");
            int TOTAL_DEBT = data.getInt("TOTAL_DEBT");
            data.add("TOTAL_NET_ASSETS", TOTAL_ASSET - TOTAL_DEBT);
            
            //将结果集写入页面接收变量
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showAFInfoSecond
     * @Description: 收养人信息
     * @author: xugy
     * @date: 2014-11-3下午9:44:01
     * @return
     */
    public String showAFInfoSecond(){
        String AF_ID = getParameter("AF_ID");//
        String LANG = getParameter("LANG");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            Data data=handler.getAFInfoOfAfId(conn,AF_ID);
            String nowYear = DateUtility.getCurrentYear();
            //男收养人年龄
            if(!"".equals(data.getString("MALE_BIRTHDAY",""))){
                String maleBirthdayYear = data.getDate("MALE_BIRTHDAY").substring(0, 4);
                int maleAge = Integer.parseInt(nowYear)-Integer.parseInt(maleBirthdayYear)+1;
                data.add("MALE_AGE", maleAge);
            }
            //女收养人年龄
            if(!"".equals(data.getString("FEMALE_BIRTHDAY",""))){
                String femaleBirthdayYear = data.getDate("FEMALE_BIRTHDAY").substring(0, 4);
                int femaleAge = Integer.parseInt(nowYear)-Integer.parseInt(femaleBirthdayYear)+1;
                data.add("FEMALE_AGE", femaleAge);
            }
            //家庭净资产
            int TOTAL_ASSET = data.getInt("TOTAL_ASSET");
            int TOTAL_DEBT = data.getInt("TOTAL_DEBT");
            data.add("TOTAL_NET_ASSETS", TOTAL_ASSET - TOTAL_DEBT);
            
            //将结果集写入页面接收变量
            setAttribute("data",data);
            setAttribute("LANG",LANG);
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    /**
     * 
     * @Title: showAFInfoThird
     * @Description: 
     * @author: xugy
     * @date: 2014-11-15下午6:54:52
     * @return
     */
    public String showAFInfoThird(){
        String AF_ID = getParameter("AF_ID");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据DataList
            Data data=handler.getAFInfoOfAfId(conn,AF_ID);
            //将结果集写入页面接收变量
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: AdoptionRegistrationApplication
     * @Description: 收养登记申请书
     * @author: xugy
     * @date: 2014-12-2下午3:55:58
     * @return
     */
    public String AdoptionRegistrationApplication(){
        String MI_ID = getParameter("MI_ID");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data=getNcmMatchInfoForAdreg(conn,MI_ID);
            String FAMILY_TYPE = data.getString("FAMILY_TYPE");
            String ADOPTER_SEX = data.getString("ADOPTER_SEX");
            if("1".endsWith(FAMILY_TYPE)){//双亲收养
                data.put("MALE_MARRY_CONDITION", "已婚");    //收养人_婚姻状况
                data.put("FEMALE_MARRY_CONDITION", "已婚");  //收养人_婚姻状况
            }else{
                if("1".equals(ADOPTER_SEX)){//收养人性别为男
                    data.put("MALE_MARRY_CONDITION", data.getString("MARRY_CONDITION_NAME")); //收养人_婚姻状况
                    data.put("FEMALE_MARRY_CONDITION", "");    //收养人_婚姻状况
                }else{
                    data.put("FEMALE_MARRY_CONDITION", data.getString("MARRY_CONDITION_NAME"));   //收养人_婚姻状况
                    data.put("MALE_MARRY_CONDITION", "");  //收养人_婚姻状况
                }           
            }
            Integer TOTAL_RESULT = data.getInt("TOTAL_ASSET") - data.getInt("TOTAL_DEBT");
            data.put("TOTAL_RESULT", TOTAL_RESULT.toString());  //收养人_净资产
            
            if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(data.getString("CHILD_TYPE"))){//正常儿童
                data.put("SN_TYPE_NAME", "健康");   //身 体 状 况
            }
            
            //将结果集写入页面接收变量
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
                        log.logError("Connection因出现异常，未能关闭",e);
                    }
                    retValue = "error2";
                }
            }
        }
        return retValue;
    }
    
    /**
     * 
     * @Title: AdoptionRegistration
     * @Description: 收养登记证
     * @author: xugy
     * @date: 2014-12-3下午1:46:08
     * @return
     */
    public String AdoptionRegistration(){
        String MI_ID = getParameter("MI_ID");//
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            Data data=getNcmMatchInfoForAdregCard(conn,MI_ID);
            Data data1=getIntercountryAdoptionInfo(conn,MI_ID);
            data.addData(data1);
            
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
            
            String ADVICE_NOTICE_DATE = data.getDate("ADVICE_NOTICE_DATE");    //征求意见_通知日期
            if(!"".equals(ADVICE_NOTICE_DATE) && ADVICE_NOTICE_DATE.length()>=10 ){
                data.add("ADVICE_NOTICE_DATE_YEAR", ADVICE_NOTICE_DATE.substring(0,4));
                data.add("ADVICE_NOTICE_DATE_MONTH", ADVICE_NOTICE_DATE.substring(5,7));
                data.add("ADVICE_NOTICE_DATE_DAY", ADVICE_NOTICE_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(ADVICE_NOTICE_DATE);
                data.put("ADVICE_NOTICE_DATE", sdfEN.format(date));
            }
            
            String ADVICE_FEEDBACK_DATE = data.getDate("ADVICE_FEEDBACK_DATE");  //收养国机关签署日期
            if(!"".equals(ADVICE_FEEDBACK_DATE) && ADVICE_FEEDBACK_DATE.length()>=10 ){
                data.add("ADVICE_FEEDBACK_DATE_YEAR", ADVICE_FEEDBACK_DATE.substring(0,4));
                data.add("ADVICE_FEEDBACK_DATE_MONTH", ADVICE_FEEDBACK_DATE.substring(5,7));
                data.add("ADVICE_FEEDBACK_DATE_DAY", ADVICE_FEEDBACK_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(ADVICE_FEEDBACK_DATE);
                data.put("ADVICE_FEEDBACK_DATE", sdfEN.format(date));
            }
            
            String NOTICE_SIGN_DATE = data.getDate("NOTICE_SIGN_DATE");    //签发日期
            if(!"".equals(NOTICE_SIGN_DATE) && NOTICE_SIGN_DATE.length()>=10 ){
                data.add("NOTICE_SIGN_DATE_YEAR", NOTICE_SIGN_DATE.substring(0,4));
                data.add("NOTICE_SIGN_DATE_MONTH", NOTICE_SIGN_DATE.substring(5,7));
                data.add("NOTICE_SIGN_DATE_DAY", NOTICE_SIGN_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(NOTICE_SIGN_DATE);
                data.put("NOTICE_SIGN_DATE", sdfEN.format(date));
            }
            
            String ADREG_DATE = data.getDate("ADREG_DATE"); //收养登记日期
            if(!"".equals(ADREG_DATE) && ADREG_DATE.length()>=10 ){
                data.add("ADREG_DATE_YEAR", ADREG_DATE.substring(0,4));
                data.add("ADREG_DATE_MONTH", ADREG_DATE.substring(5,7));
                data.add("ADREG_DATE_DAY", ADREG_DATE.substring(8, 10));
                Date date = simpleDateFormat.parse(ADREG_DATE);
                data.put("ADREG_DATE", sdfEN.format(date));
            }
            //将结果集写入页面接收变量
            setAttribute("data",data);
        }catch (DBException e) {
            //设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (ParseException e) {
            e.printStackTrace();
        } finally {
            //关闭数据库连接
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
     * 
     * @Title: getNcmMatchInfoForAdreg
     * @Description: 收养登记申请书
     * @author: xugy
     * @date: 2014-11-10下午1:49:35
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmMatchInfoForAdreg(Connection conn, String MI_ID) throws DBException{
        Data data=handler.getNcmMatchInfoForAdreg(conn,MI_ID);
        return data;
    }
    
    /**
     * 
     * @Title: getNcmMatchInfoForAdregCard
     * @Description: 收养登记证
     * @author: xugy
     * @date: 2014-11-10下午1:48:44
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getNcmMatchInfoForAdregCard(Connection conn, String MI_ID) throws DBException{
        Data data=handler.getNcmMatchInfoForAdregCard(conn,MI_ID);
        return data;
    }
    
    /**
     * 
     * @Title: letterOfSeekingConfirmation
     * @Description: 征求意见书
     * @author: xugy
     * @param MI_ID匹配信息ID
     * @param isSY 是否加水印0：no；1：yes
     * @throws Exception 
     * @throws FileNotFoundException 
     * @date: 2014-11-9下午7:15:42
     */
    public void letterOfSeekingConfirmation(Connection conn, String MI_ID, String isSY) throws Exception{
        
        Data data = handler.getLetterInfo(conn, MI_ID);
        System.out.println(CommonConfig.getProjectPath());
        //实例化文档对象  
        Document document = new Document(PageSize.A4, 84, 85, 92, 50);//A4纸，左右上下空白
        String path = CommonConfig.getProjectPath() + "/tempFile/";//临时存放征求意见书的路径
        String FILE_NO = data.getString("FILE_NO");
        String PDFpath = path+FILE_NO+".pdf";//输出文件路径
        
        // PdfWriter对象
        PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//文件的输出路径+文件的实际名称 
        float width = document.getPageSize().getWidth() - 169;
        document.open();// 打开文档
        //pdf文档中中文字体的设置，注意一定要添加iTextAsian.jar包
        //中文字体
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//黑体
        //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//四通宋体
        //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 楷体字
        //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 仿宋体
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  宋体
        
        //黑体 粗体
        Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//黑体 10 粗体
        //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//黑体 11 粗体
        Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//黑体 12 粗体
        Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//黑体 16 粗体
        
        //宋体 正常
        
        //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//宋体 9 正常
        //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//宋体 9.5 正常
        Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//宋体 10 正常
        Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//宋体 10.5 正常
        Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//宋体 11 正常
        Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//宋体 12 正常
        Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//宋体 12.5 正常
        
        //宋体 粗体
        Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//宋体 10 粗体
        //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//宋体 10.5 粗体
        Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//宋体 11 粗体
        //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//宋体 12 粗体
        
        //宋体 斜体
        //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//宋体 10 斜体
        
        
        //西文字体
        //times new Roman 正常
        //Font FontEN_T9_5N = new Font(Font.TIMES_ROMAN, 9.5f, Font.NORMAL);//times new roman 9.5 正常
        Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 正常
        Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 正常
        Font FontEN_T11_5N = new Font(Font.TIMES_ROMAN, 11.5F, Font.NORMAL);//times new roman 11.5 正常
        Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 正常
        
        //times new Roman 粗体
        Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 粗体
        Font FontEN_T10_5B = new Font(Font.TIMES_ROMAN, 10.5f, Font.BOLD);//times new roman 10.5 粗体
        Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 粗体
        Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 粗体
        Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 粗体
        //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 粗体
        
        //times new Roman 斜体
        Font FontEN_T10I = new Font(Font.TIMES_ROMAN, 10, Font.ITALIC);//times new roman 10 斜体
        Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 斜体
        
        //中文标题
        Paragraph ParagraphTitleCN = new Paragraph("征 求 收 养 人 意 见 书", FontCN_HEI16B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        document.add(ParagraphTitleCN);
        //英文标题
        Paragraph ParagraphTitleEN = new Paragraph("Letter of Seeking Confirmation from Adopter", FontEN_T14B);
        ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
        ParagraphTitleEN.setSpacingAfter(4);
        document.add(ParagraphTitleEN);
        //文件编号
        Paragraph ParagraphFileCode = new Paragraph(FILE_NO+"   ", FontEN_T14B);
        ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
        ParagraphFileCode.setSpacingAfter(5);
        document.add(ParagraphFileCode);
        //收养人称呼
        String MALE_NAME = data.getString("MALE_NAME","");//男收养人
        String FEMALE_NAME = data.getString("FEMALE_NAME","");//女收养人
        if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME, FontEN_T12N);
            document.add(ParagraphMaleName);
            Paragraph ParagraphFemaleName = new Paragraph("MRS. "+FEMALE_NAME+":", FontEN_T12N);
            ParagraphFemaleName.setSpacingAfter(10);//与下段相隔
            document.add(ParagraphFemaleName);
        }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME+":", FontEN_T12N);
            ParagraphMaleName.setSpacingAfter(10);//与下段相隔
            document.add(ParagraphMaleName);
        }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphFemaleName = new Paragraph("MRS. "+FEMALE_NAME+":", FontEN_T12N);
            ParagraphFemaleName.setSpacingAfter(10);//与下段相隔
            document.add(ParagraphFemaleName);
        }
        //中文正文
        Paragraph ParagraphContextCN = new Paragraph();
        ParagraphContextCN.setFirstLineIndent(20);//首行缩进
        Phrase PhraseContextCN1 = new Phrase("根据你们的收养申请及《中华人民共和国收养法》的规定，中国儿童福利和收养中心为你们选配了一名儿童，现将有关资料转交你们征求意见。请将是否同意收养的意见签署在下面适当的位置，并将此意见书交还给为你们递交申请文件的机构", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN1);
        String NAME_CN = data.getString("NAME_CN");//收养组织
        Phrase PhraseContextCN2 = new Phrase(NAME_CN+"。", FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN2);
        ParagraphContextCN.setLeading(15f);
        ParagraphContextCN.setSpacingAfter(10);//与下段相隔
        document.add(ParagraphContextCN);
        //英文正文
        Paragraph ParagraphContextEN = new Paragraph();
        ParagraphContextEN.setFirstLineIndent(20);//首行缩进
        Phrase PhraseContextEN1 = new Phrase("Based on your application and in accordance with the ", FontEN_T10N);
        ParagraphContextEN.add(PhraseContextEN1);
        Phrase PhraseContextEN2 = new Phrase("Adoption Law of the People's Republic of China,", FontEN_T10I);
        ParagraphContextEN.add(PhraseContextEN2);
        Phrase PhraseContextEN3 = new Phrase("the China Center for Children's welfare and Adoption ", FontEN_T10B);
        ParagraphContextEN.add(PhraseContextEN3);
        Phrase PhraseContextEN4 = new Phrase("matched a child with you．Herein.we send the information about the child to you.You are kindly requested to make you decision.sign in the proper place below.and deliver this letter as soon as possible to the adoption organization which submitted your application file,", FontEN_T10N);
        ParagraphContextEN.add(PhraseContextEN4);
        String NAME_EN = data.getString("NAME_EN");//收养组织
        Phrase PhraseContextEN5 = new Phrase(NAME_EN+".", FontEN_T10B);
        ParagraphContextEN.add(PhraseContextEN5);
        ParagraphContextEN.setLeading(14f);
        ParagraphContextEN.setSpacingAfter(25);//与下段相隔
        document.add(ParagraphContextEN);
        
        //中文儿童信息
        //第一行信息
        float[] widths1 = {0.13f,0.30f,0.25f,0.32f};//表格列数和比例
        PdfPTable Table1 = new PdfPTable(widths1);//创建表格
        Table1.setWidthPercentage(100);//表格长度100%
        //第一个cell
        PdfPCell Table1_cell1 = new PdfPCell(new Paragraph("被收养人：", FontCN_SONG10N));
        Table1_cell1.setBorderWidth(0);//cell的border为0
        Table1_cell1.setLeading(2f, 1f);
        Table1.addCell(Table1_cell1);
        //第二个cell
        String NAME = data.getString("NAME");//儿童姓名
        PdfPCell Table1_cell2 = new PdfPCell(new Paragraph("姓名："+NAME, FontCN_SONG10N));
        Table1_cell2.setBorderWidth(0);//cell的border为0
        Table1_cell2.setLeading(2f, 1f);
        Table1.addCell(Table1_cell2);
        //第三个cell
        String SEX_CN = data.getString("SEX_CN");//性别
        PdfPCell Table1_cell3 = new PdfPCell(new Paragraph("性别："+SEX_CN, FontCN_SONG10N));
        Table1_cell3.setBorderWidth(0);
        Table1_cell3.setLeading(2f, 1f);
        Table1.addCell(Table1_cell3);
        //第四个cell
        String BIRTHDAY = data.getDate("BIRTHDAY");//儿童出生日期
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = sdf.parse(BIRTHDAY);
        SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy年MM月dd日");
        String BIRTHDAY_CN = sdfCN.format(date);
        PdfPCell Table1_cell4 = new PdfPCell(new Paragraph("出生日期："+BIRTHDAY_CN, FontCN_SONG10N));
        Table1_cell4.setBorderWidth(0);
        Table1_cell4.setLeading(2f, 1f);
        Table1.addCell(Table1_cell4);
        document.add(Table1);
        //第二行信息
        float[] widths2 = {0.13f,0.13f,0.74f};//表格列数和比例
        PdfPTable Table2 = new PdfPTable(widths2);//创建表格
        Table2.setWidthPercentage(100);//表格长度100%
        //第一个cell
        PdfPCell Table2_cell1 = new PdfPCell();
        Table2_cell1.setBorderWidth(0);//cell的border为0
        Table2_cell1.setLeading(2f, 1f);
        Table2.addCell(Table2_cell1);
        //第二个cell
        PdfPCell Table2_cell2 = new PdfPCell(new Paragraph("健康状况：", FontCN_SONG10N));
        Table2_cell2.setBorderWidth(0);//cell的border为0
        Table2_cell2.setLeading(2f, 1f);
        Table2.addCell(Table2_cell2);
        //第三个cell
        String CHILD_TYPE = data.getString("CHILD_TYPE");//儿童类型
        String HEALTH_STATUS_CN = "";
        if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(CHILD_TYPE)){
            HEALTH_STATUS_CN = data.getString("CHILD_TYPE_CN");
        }else{
            HEALTH_STATUS_CN = data.getString("SN_TYPE_CN");
        }
        PdfPCell Table2_cell3 = new PdfPCell(new Paragraph(HEALTH_STATUS_CN, FontCN_SONG10N));
        Table2_cell3.setBorderWidth(0);
        Table2_cell3.setLeading(2f, 1f);
        Table2.addCell(Table2_cell3);
        document.add(Table2);
        //第三行信息
        float[] widths3 = {0.13f,0.08f,0.79f};//表格列数和比例
        PdfPTable Table3 = new PdfPTable(widths3);//创建表格
        Table3.setWidthPercentage(100);//表格长度100%
        //第一个cell
        PdfPCell Table3_cell1 = new PdfPCell();
        Table3_cell1.setBorderWidth(0);//cell的border为0
        Table3_cell1.setLeading(2f, 1f);
        Table3.addCell(Table3_cell1);
        //第二个cell
        PdfPCell Table3_cell2 = new PdfPCell(new Paragraph("身份：", FontCN_SONG10N));
        Table3_cell2.setBorderWidth(0);//cell的border为0
        Table3_cell2.setLeading(2f, 1f);
        Table3.addCell(Table3_cell2);
        //第三个cell
        String CHILD_IDENTITY_CN = data.getString("CHILD_IDENTITY_CN");//儿童身份
        PdfPCell Table3_cell3 = new PdfPCell(new Paragraph(CHILD_IDENTITY_CN, FontCN_SONG10N));
        Table3_cell3.setBorderWidth(0);
        Table3_cell3.setLeading(2f, 1f);
        Table3.addCell(Table3_cell3);
        document.add(Table3);
        
        //英文儿童信息
        //第一行信息
        PdfPTable Table4 = new PdfPTable(widths1);//创建表格
        Table4.setWidthPercentage(100);//表格长度100%
        //第一个cell
        PdfPCell Table4_cell1 = new PdfPCell(new Paragraph("Adoptee:", FontEN_T10B));
        Table4_cell1.setBorderWidth(0);//cell的border为0
        Table4_cell1.setLeading(2f, 1f);
        Table4.addCell(Table4_cell1);
        //第二个cell
        Paragraph Paragraph_name = new Paragraph();
        Phrase Phrase_N = new Phrase("Name:", FontEN_T10B);
        Paragraph_name.add(Phrase_N);
        String NAME_PINYIN = data.getString("NAME_PINYIN");//儿童姓名拼音
        Phrase Phrase_Name = new Phrase(NAME_PINYIN, FontEN_T10N);
        Paragraph_name.add(Phrase_Name);
        PdfPCell Table4_cell2 = new PdfPCell(Paragraph_name);
        Table4_cell2.setBorderWidth(0);//cell的border为0
        Table4_cell2.setLeading(2f, 1f);
        Table4.addCell(Table4_cell2);
        //第三个cell
        Paragraph Paragraph_sex = new Paragraph();
        Phrase Phrase_S = new Phrase("Sex:", FontEN_T10B);
        Paragraph_sex.add(Phrase_S);
        String SEX_EN = data.getString("SEX_EN");//性别
        Phrase Phrase_Sex = new Phrase(SEX_EN, FontEN_T10N);
        Paragraph_sex.add(Phrase_Sex);
        PdfPCell Table4_cell3 = new PdfPCell(Paragraph_sex);
        Table4_cell3.setBorderWidth(0);//cell的border为0
        Table4_cell3.setLeading(2f, 1f);
        Table4.addCell(Table4_cell3);
        //第四个cell
        Paragraph Paragraph_birthday = new Paragraph();
        Phrase Phrase_B = new Phrase("Date of birth:", FontEN_T10B);
        Paragraph_birthday.add(Phrase_B);
        SimpleDateFormat sdfEN = new SimpleDateFormat("yyyy/MM/dd");
        //SimpleDateFormat sdfEN = new SimpleDateFormat("MMMM dd,yyyy", Locale.ENGLISH);
        String BIRTHDAY_EN = sdfEN.format(date);
        
        
        
        Phrase Phrase_birthday = new Phrase(BIRTHDAY_EN, FontEN_T10N);
        Paragraph_birthday.add(Phrase_birthday);
        PdfPCell Table4_cell4 = new PdfPCell(Paragraph_birthday);
        Table4_cell4.setBorderWidth(0);//cell的border为0
        Table4_cell4.setLeading(2f, 1f);
        Table4.addCell(Table4_cell4);
        document.add(Table4);
        //第二行信息
        float[] widths5 = {0.13f,0.18f,0.69f};//表格列数和比例
        PdfPTable Table5 = new PdfPTable(widths5);//创建表格
        Table5.setWidthPercentage(100);//表格长度100%
        //第一个cell
        PdfPCell Table5_cell1 = new PdfPCell();
        Table5_cell1.setBorderWidth(0);//cell的border为0
        Table5_cell1.setLeading(2f, 1f);
        Table5.addCell(Table5_cell1);
        //第二个cell
        PdfPCell Table5_cell2 = new PdfPCell(new Paragraph("Health Status:", FontEN_T10B));
        Table5_cell2.setBorderWidth(0);//cell的border为0
        Table5_cell2.setLeading(2f, 1f);
        Table5.addCell(Table5_cell2);
        //第三个cell
        String HEALTH_STATUS_EN = "";
        if(ChildInfoConstants.CHILD_TYPE_NORMAL.equals(CHILD_TYPE)){
            HEALTH_STATUS_EN = data.getString("CHILD_TYPE_EN");
        }else{
            HEALTH_STATUS_EN = data.getString("SN_TYPE_EN");
        }
        PdfPCell Table5_cell3 = new PdfPCell(new Paragraph(HEALTH_STATUS_EN, FontEN_T10N));
        Table5_cell3.setBorderWidth(0);
        Table5_cell3.setLeading(2f, 1f);
        Table5.addCell(Table5_cell3);
        document.add(Table5);
        //第三行信息
        float[] widths6 = {0.13f,0.12f,0.75f};//表格列数和比例
        PdfPTable Table6 = new PdfPTable(widths6);//创建表格
        Table6.setWidthPercentage(100);//表格长度100%
        //第一个cell
        PdfPCell Table6_cell1 = new PdfPCell();
        Table6_cell1.setBorderWidth(0);//cell的border为0
        Table6_cell1.setLeading(2f, 1f);
        Table6.addCell(Table6_cell1);
        //第二个cell
        PdfPCell Table6_cell2 = new PdfPCell(new Paragraph("Identity:", FontEN_T10B));
        Table6_cell2.setBorderWidth(0);//cell的border为0
        Table6_cell2.setLeading(2f, 1f);
        Table6.addCell(Table6_cell2);
        //第三个cell
        String CHILD_IDENTITY_EN = data.getString("CHILD_IDENTITY_EN");//儿童身份
        Paragraph Paragraph_identityEN = new Paragraph(CHILD_IDENTITY_EN, FontEN_T10N);
        PdfPCell Table6_cell3 = new PdfPCell(Paragraph_identityEN);
        Table6_cell3.setBorderWidth(0);
        Table6_cell3.setLeading(2f, 1f);
        Table6.addCell(Table6_cell3);
        document.add(Table6);
        
        //送养人中文
        PdfPTable Table7 = new PdfPTable(1);//创建表格
        Table7.setWidthPercentage(100);//表格长度100%
        String SENDER = data.getString("SENDER","");//送养人
        PdfPCell Table7_cell1 = new PdfPCell(new Paragraph("送养人姓名（名称）："+SENDER, FontCN_SONG10N));
        Table7_cell1.setBorderWidth(0);
        Table7_cell1.setLeading(2f, 1f);
        Table7.addCell(Table7_cell1);
        document.add(Table7);
        //送养人英文
        float[] widths8 = {0.08f,0.92f};//表格列数和比例
        PdfPTable Table8 = new PdfPTable(widths8);//创建表格
        Table8.setWidthPercentage(100);//表格长度100%
        PdfPCell Table8_cell1 = new PdfPCell(new Paragraph("From:", FontEN_T10B));
        Table8_cell1.setBorderWidth(0);
        Table8_cell1.setLeading(2f, 1f);
        Table8.addCell(Table8_cell1);
        ChildCommonManager ccm = new ChildCommonManager();
        String SENDER_EN = "";
        if(!"".equals(SENDER)){
            SENDER_EN = ccm.getPinyin(SENDER);
        }
        PdfPCell Table8_cell2 = new PdfPCell(new Paragraph(SENDER_EN, FontEN_T10N));
        Table8_cell2.setBorderWidth(0);
        Table8_cell2.setLeading(2f, 1f);
        Table8.addCell(Table8_cell2);
        document.add(Table8);
        
        //落款
        float[] widths9 = {0.42f,0.58f};//表格列数和比例
        PdfPTable Table9 = new PdfPTable(widths9);//创建表格
        Table9.setTotalWidth(width);
        Table9.setLockedWidth(true);
        //第一个cell
        PdfPCell Table9_cell1 = new PdfPCell(new Paragraph());
        Table9_cell1.setFixedHeight(22f);
        Table9_cell1.setBorder(0);
        Table9.addCell(Table9_cell1);
        //第二个cell
        PdfPCell Table9_cell2 = new PdfPCell(new Paragraph("      中国儿童福利和收养中心", FontCN_SONG12_5N));
        Table9_cell2.setBorder(0);
        Table9_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table9.addCell(Table9_cell2);
        //第三个cell
        PdfPCell Table9_cell3 = new PdfPCell(new Paragraph());
        Table9_cell3.setFixedHeight(20f);
        Table9_cell3.setBorder(0);
        Table9.addCell(Table9_cell3);
        //第四个cell
        PdfPCell Table9_cell4 = new PdfPCell(new Paragraph("   China Center for Children's welfare and Adoption", FontEN_T11_5N));
        Table9_cell4.setBorder(0);
        Table9_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table9.addCell(Table9_cell4);
        //第五个cell
        PdfPCell Table9_cell5 = new PdfPCell(new Paragraph("收养人意见：", FontCN_SONG11B));
        Table9_cell5.setBorder(0);
        Table9.addCell(Table9_cell5);
        //第六个cell
        String ADVICE_SIGN_DATE = data.getDate("ADVICE_SIGN_DATE");//落款日期默认日期为部门主任审核通过的日期MATCH_PASSDATE
        Date adviceSignDate = sdf.parse(ADVICE_SIGN_DATE);
        String inscribeDate = sdfEN.format(adviceSignDate);
        PdfPCell Table9_cell6 = new PdfPCell(new Paragraph("    "+inscribeDate, FontCN_SONG12N));
        Table9_cell6.setBorder(0);
        Table9_cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table9.addCell(Table9_cell6);
        Table8.setSpacingAfter(40);
        Table9.writeSelectedRows(0, -1, 84, 290, writer.getDirectContent());
        
        //收养人意见
        float[] widths10 = {0.04f,0.96f};
        PdfPTable Table10 = new PdfPTable(widths10);
        Table10.setTotalWidth(width);
        Table10.setLockedWidth(true);
        //第一个cell
        PdfPCell Table10_cell1 = new PdfPCell(new Paragraph("Decision of Adopter:", FontEN_T10_5B));
        Table10_cell1.setFixedHeight(16f);
        Table10_cell1.setBorderWidth(0);
        Table10_cell1.setColspan(2);
        Table10.addCell(Table10_cell1);
        //第二个cell
        PdfPCell Table10_cell2 = new PdfPCell(new Paragraph("□", FontCN_SONG10_5N));
        Table10_cell2.setBorderWidth(0);
        Table10.addCell(Table10_cell2);
        //第三个cell
        PdfPCell Table10_cell3 = new PdfPCell(new Paragraph("我们同意收养上述儿童。", FontCN_SONG10_5N));
        Table10_cell3.setBorderWidth(0);
        Table10.addCell(Table10_cell3);
        //第四个cell
        PdfPCell Table10_cell5 = new PdfPCell(new Paragraph("   We accept the adoptee mentiioned above.", FontEN_T10N));
        Table10_cell5.setColspan(2);
        Table10_cell5.setBorderWidth(0);
        Table10.addCell(Table10_cell5);
        //第五个cell
        PdfPCell Table10_cell6 = new PdfPCell(new Paragraph("□", FontCN_SONG10_5N));
        Table10_cell6.setBorderWidth(0);
        Table10.addCell(Table10_cell6);
        //第六个cell
        PdfPCell Table10_cell7 = new PdfPCell(new Paragraph("我们不同意收养上述儿童，理由是：", FontCN_SONG10_5N));
        Table10_cell7.setBorderWidth(0);
        Table10.addCell(Table10_cell7);
        //第七个cell
        PdfPCell Table10_cell9 = new PdfPCell(new Paragraph("   We cannot accept the adoptee mentiioned above，the reason is:", FontEN_T10N));
        Table10_cell9.setColspan(2);
        Table10_cell9.setBorderWidth(0);
        Table10.addCell(Table10_cell9);
        Table10.writeSelectedRows(0, -1, 84, 218, writer.getDirectContent());
        
        //收养人签字
        float[] widths11 = {0.72f,0.28f};
        PdfPTable Table11 = new PdfPTable(widths11);
        Table11.setTotalWidth(width);
        Table11.setLockedWidth(true);
        
        PdfPCell Table11_cell1 = new PdfPCell(new Paragraph("收养人父亲签字：", FontCN_SONG10B));
        Table11_cell1.setBorderWidth(0);
        Table11_cell1.setColspan(2);
        Table11.addCell(Table11_cell1);
        
        PdfPCell Table11_cell2 = new PdfPCell(new Paragraph("Signature of Adoptive Father:", FontEN_T10B));
        Table11_cell2.setBorderWidth(0);
        Table11.addCell(Table11_cell2);
        
        PdfPCell Table11_cell3 = new PdfPCell(new Paragraph("日期：", FontCN_SONG10B));
        Table11_cell3.setBorderWidth(0);
        Table11.addCell(Table11_cell3);
        
        PdfPCell Table11_cell4 = new PdfPCell(new Paragraph("收养人母亲签字：", FontCN_SONG10B));
        Table11_cell4.setBorderWidth(0);
        Table11_cell4.setColspan(2);
        Table11.addCell(Table11_cell4);
        
        PdfPCell Table11_cell5 = new PdfPCell(new Paragraph("Signature of Adoptive Mother:", FontEN_T10B));
        Table11_cell5.setBorderWidth(0);
        Table11.addCell(Table11_cell5);
        
        PdfPCell Table11_cell6 = new PdfPCell(new Paragraph("Date:year/month/date", FontEN_T10B));
        Table11_cell6.setBorderWidth(0);
        Table11.addCell(Table11_cell6);
        Table11.writeSelectedRows(0, -1, 84, 137, writer.getDirectContent());
        
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", "");
        if("1".equals(IS_CONVENTION_ADOPT)){//公约收养
            document.newPage();
            //中文标题
            Paragraph SParagraphTitleCN = new Paragraph("征 求 收 养 意 见 书", FontCN_HEI16B);
            SParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
            document.add(SParagraphTitleCN);
            //英文标题
            Paragraph SParagraphTitleEN = new Paragraph("Letter of Seeking Confirmation", FontEN_T14B);
            SParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
            SParagraphTitleEN.setSpacingAfter(4);
            document.add(SParagraphTitleEN);
            //文件编号
            Paragraph SParagraphFileCode = new Paragraph(FILE_NO+"      ", FontEN_T14B);
            SParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
            SParagraphFileCode.setSpacingAfter(4);
            document.add(SParagraphFileCode);
            //收养国中央机关
            Paragraph SParagraphMaleName = new Paragraph("收养国中央机关：", FontCN_HEI12B);
            document.add(SParagraphMaleName);
            Paragraph SParagraphFemaleName = new Paragraph("Central Authority of Receiving State:", FontEN_T12B);
            SParagraphFemaleName.setSpacingAfter(20);//与下段相隔
            document.add(SParagraphFemaleName);
            //中文正文
            Paragraph SParagraphContextCN = new Paragraph();
            SParagraphContextCN.setFirstLineIndent(20);//首行缩进
            Phrase SPhraseContextCN1 = new Phrase("根据《中华人民共和国收养法》及《跨国收养方面保护儿童及合作公约》第十七条的规定，中国国儿童福利和收养中心为收养人", FontCN_SONG11N);
            SParagraphContextCN.add(SPhraseContextCN1);
            Phrase SPhraseContextCN2 = new Phrase();
            if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextCN2 = new Phrase("MR. "+MALE_NAME+" & MRS. "+FEMALE_NAME, FontEN_T11B);
            }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
                SPhraseContextCN2 = new Phrase("MR. "+MALE_NAME, FontEN_T11B);
            }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextCN2 = new Phrase("MRS. "+FEMALE_NAME, FontEN_T11B);
            }
            SParagraphContextCN.add(SPhraseContextCN2);
            Phrase SPhraseContextCN3 = new Phrase("选配了一名儿童（ "+NAME+"，"+SEX_CN+"，"+BIRTHDAY_CN+"出生），随函附上该儿童的照片、体检表、成长报告。请将你们的意见签署在下面适当的位置。", FontCN_SONG11N);
            SParagraphContextCN.add(SPhraseContextCN3);
            SParagraphContextCN.setSpacingAfter(50);//与下段相隔
            document.add(SParagraphContextCN);
            //英文正文
            Paragraph SParagraphContextEN = new Paragraph();
            SParagraphContextEN.setFirstLineIndent(20);//首行缩进
            Phrase SPhraseContextEN1 = new Phrase("In accordance with the ", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN1);
            Phrase SPhraseContextEN2 = new Phrase("Adoption law of the People's Republic of China ", FontEN_T11I);
            SParagraphContextEN.add(SPhraseContextEN2);
            Phrase SPhraseContextEN3 = new Phrase("And the Article 17 of the ", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN3);
            Phrase SPhraseContextEN4 = new Phrase("Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption,", FontEN_T11I);
            SParagraphContextEN.add(SPhraseContextEN4);
            Phrase SPhraseContextEN5 = new Phrase("the China Center for Children's welfare and Adoption matched a child(Name:"+NAME_PINYIN+",Sex:"+SEX_EN+",D.O.B:"+BIRTHDAY_EN+")with the adoption applicants ", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN5);
            Phrase SPhraseContextEN6 = new Phrase();
            if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextEN6 = new Phrase("MR. "+MALE_NAME+" & MRS. "+FEMALE_NAME, FontEN_T11B);
            }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
                SPhraseContextEN6 = new Phrase("MR. "+MALE_NAME, FontEN_T11B);
            }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
                SPhraseContextEN6 = new Phrase("MRS. "+FEMALE_NAME, FontEN_T11B);
            }
            SParagraphContextEN.add(SPhraseContextEN6);
            Phrase SPhraseContextEN7 = new Phrase(".Enclosed please find the pictures,medical examination from,and growth report of the child,Please sign in the proper place underneath to present your opinion.", FontEN_T11N);
            SParagraphContextEN.add(SPhraseContextEN7);
            SParagraphContextEN.setLeading(14f);
            //ParagraphContextEN.setSpacingAfter(25);//与下段相隔
            document.add(SParagraphContextEN);
            
            //落款
            float[] Swidths1 = {0.42f,0.58f};//表格列数和比例
            PdfPTable STable1 = new PdfPTable(Swidths1);//创建表格
            STable1.setTotalWidth(width);
            STable1.setLockedWidth(true);
            //第一个cell
            PdfPCell STable1_cell1 = new PdfPCell(new Paragraph());
            STable1_cell1.setFixedHeight(20f);
            STable1_cell1.setBorder(0);
            STable1.addCell(STable1_cell1);
            //第二个cell
            PdfPCell STable1_cell2 = new PdfPCell(new Paragraph("      中国儿童福利和收养中心", FontCN_SONG12_5N));
            STable1_cell2.setBorder(0);
            STable1_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
            STable1.addCell(STable1_cell2);
            //第三个cell
            PdfPCell STable1_cell3 = new PdfPCell(new Paragraph());
            STable1_cell3.setFixedHeight(18f);
            STable1_cell3.setBorder(0);
            STable1.addCell(STable1_cell3);
            //第四个cell
            PdfPCell STable1_cell4 = new PdfPCell(new Paragraph("   China Center for Children's welfare and Adoption", FontEN_T11_5N));
            STable1_cell4.setBorder(0);
            STable1_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
            STable1.addCell(STable1_cell4);
            //第五个cell
            PdfPCell STable1_cell5 = new PdfPCell(new Paragraph());
            STable1_cell5.setBorder(0);
            STable1.addCell(STable1_cell5);
            //第六个cell
            PdfPCell STable1_cell6 = new PdfPCell(new Paragraph("    "+inscribeDate, FontCN_SONG12N));
            STable1_cell6.setBorder(0);
            STable1_cell6.setHorizontalAlignment(Element.ALIGN_CENTER);
            STable1.addCell(STable1_cell6);
            STable1.writeSelectedRows(0, -1, 84, 285, writer.getDirectContent());
            
            //收养人意见
            PdfPTable STable2 = new PdfPTable(1);
            STable2.setTotalWidth(width);
            STable2.setLockedWidth(true);
            //第一个cell
            PdfPCell STable2_cell1 = new PdfPCell(new Paragraph("收养国中央机关意见：", FontCN_HEI10B));
            STable2_cell1.setBorderWidth(0);
            STable2_cell1.setColspan(2);
            STable2.addCell(STable2_cell1);
            //第二个cell
            PdfPCell STable2_cell2 = new PdfPCell(new Paragraph("Opinion of the Central Authority of Receiving State:", FontEN_T10B));
            STable2_cell2.setBorderWidth(0);
            STable2.addCell(STable2_cell2);
            //第三个cell
            PdfPCell STable2_cell3 = new PdfPCell(new Paragraph("□ 我们同意中国儿童福利和收养中心该项儿童安置决定。", FontCN_SONG10N));
            STable2_cell3.setBorderWidth(0);
            STable2.addCell(STable2_cell3);
            //第四个cell
            PdfPCell STable2_cell5 = new PdfPCell(new Paragraph("   We agree with the decision made by CCCWA.", FontCN_SONG10N));
            STable2_cell5.setColspan(2);
            STable2_cell5.setBorderWidth(0);
            STable2.addCell(STable2_cell5);
            //第五个cell
            PdfPCell STable2_cell6 = new PdfPCell(new Paragraph("□ 我们不同意中国儿童福利和收养中心该项儿童安置决定，理由是：", FontCN_SONG10N));
            STable2_cell6.setBorderWidth(0);
            STable2.addCell(STable2_cell6);
            //第六个cell
            PdfPCell STable2_cell7 = new PdfPCell(new Paragraph("   We don't agree with the decision made by CCCWA,the reason is：", FontCN_SONG10_5N));
            STable2_cell7.setBorderWidth(0);
            STable2.addCell(STable2_cell7);
            STable2.writeSelectedRows(0, -1, 84, 230, writer.getDirectContent());
            
            //收养人签字
            float[] Swidths3 = {0.72f,0.28f};
            PdfPTable STable3 = new PdfPTable(Swidths3);
            STable3.setTotalWidth(width);
            STable3.setLockedWidth(true);
            
            PdfPCell STable3_cell1 = new PdfPCell(new Paragraph("签署人：", FontCN_SONG10B));
            STable3_cell1.setBorderWidth(0);
            STable3_cell1.setColspan(2);
            STable3.addCell(STable3_cell1);
            
            PdfPCell STable3_cell2 = new PdfPCell(new Paragraph("Signature:", FontEN_T10B));
            STable3_cell2.setBorderWidth(0);
            STable3_cell2.setColspan(2);
            STable3.addCell(STable3_cell2);
            
            PdfPCell STable3_cell3 = new PdfPCell(new Paragraph("收养国中央机关：", FontCN_SONG10B));
            STable3_cell3.setBorderWidth(0);
            STable3.addCell(STable3_cell3);
            
            PdfPCell STable3_cell4 = new PdfPCell(new Paragraph("日期：", FontCN_SONG10B));
            STable3_cell4.setBorderWidth(0);
            STable3.addCell(STable3_cell4);
            
            PdfPCell STable3_cell5 = new PdfPCell(new Paragraph("Central Authority of Receiving State:", FontEN_T10B));
            STable3_cell5.setBorderWidth(0);
            STable3.addCell(STable3_cell5);
            
            PdfPCell STable3_cell6 = new PdfPCell(new Paragraph(" Date:year/month/date", FontEN_T10B));
            STable3_cell6.setBorderWidth(0);
            STable3.addCell(STable3_cell6);
            STable3.writeSelectedRows(0, -1, 84, 137, writer.getDirectContent());
        }
        document.close();
        
        String Outpath = path+FILE_NO+"_SYZZ.pdf";//输出文件路径
        if("1".equals(isSY)){
            String imagePath = CommonConfig.getProjectPath()+"/resource/images/watermark-grap.png";
            waterMark(PDFpath, Outpath, imagePath);
        }
        File file = new File(PDFpath);//征求意见通知书
        if("1".equals(isSY)){
            File file_syzz = new File(Outpath);//征求意见通知书
            if (file_syzz.exists()) {
                AttHelper.delAttsOfPackageId(MI_ID, AttConstants.ZQYJSSY, "AF");
                
                AttHelper.manualUploadAtt(file_syzz, "AF", MI_ID, FILE_NO+"_SYZZ.pdf", AttConstants.ZQYJSSY, "AF", AttConstants.ZQYJSSY, MI_ID);
                
                file_syzz.delete();//删除原来生成的征求意见通知书
            }
        }
        if (file.exists()) {
            AttHelper.delAttsOfPackageId(MI_ID, AttConstants.ZQYJS, "AF");
            
            AttHelper.manualUploadAtt(file, "AF", MI_ID, FILE_NO+".pdf", AttConstants.ZQYJS, "AF", AttConstants.ZQYJS, MI_ID);
            
            file.delete();//删除原来生成的征求意见通知书
        }
    }
    
    /**
     * 
     * @Title: getIntercountryAdoptionInfo
     * @Description: 跨国收养合格证
     * @author: xugy
     * @date: 2014-11-10下午1:50:28
     * @param MI_ID
     * @return
     * @throws DBException 
     */
    public Data getIntercountryAdoptionInfo(Connection conn, String MI_ID) throws DBException{
        Data data=handler.getIntercountryAdoptionInfo(conn,MI_ID);
        return data;
    }
    
    
    /**
     * 
     * @Title: noticeOfTravellingToChinaForAdoption
     * @Description: 来华收养子女通知书
     * @author: xugy
     * @date: 2014-11-10下午9:05:49
     * @param conn
     * @param MI_ID 匹配信息ID
     * @param isFB 值0时通知书生成，值1时副本生成
     * @throws Exception
     */
    public void noticeOfTravellingToChinaForAdoption(Connection conn, String MI_ID, String isFB, String isSY) throws Exception{
        
        Data data = handler.getNoticeInfo(conn, MI_ID);
        
        //实例化文档对象  
        Document document = new Document(PageSize.A4, 80, 80, 100, 50);//A4纸，左右上下空白
        String PDFpath = CommonConfig.getProjectPath() + "/tempFile/来华收养子女通知书.pdf";//临时存放来华收养子女通知书的路径
        
        // PdfWriter对象
        PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//文件的输出路径+文件的实际名称 
        float width = document.getPageSize().getWidth() - 160;
        document.open();// 打开文档
        //pdf文档中中文字体的设置，注意一定要添加iTextAsian.jar包
        //中文字体
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//黑体
        //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//四通宋体
        //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 楷体字
        //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 仿宋体
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  宋体
        //黑体 粗体
        Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//黑体 10 粗体
        //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//黑体 11 粗体
        //Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//黑体 12 粗体
        //Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//黑体 16 粗体
        Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//黑体 20 粗体
        //黑体 正常
        //Font FontCN_HEI7N = new Font(bfHEI, 7, Font.NORMAL);//黑体 7 正常
        
        //宋体 正常
        //Font FontCN_SONG8N = new Font(bfSONG, 8, Font.NORMAL);//宋体 8 正常
        Font FontCN_SONG8_5N = new Font(bfSONG, 8.5f, Font.NORMAL);//宋体 8.5 正常
        //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//宋体 9 正常
        //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//宋体 9.5 正常
        Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//宋体 10 正常
        //Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//宋体 10.5 正常
        //Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//宋体 11 正常
        //Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//宋体 12 正常
        //Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//宋体 12.5 正常
        
        //宋体 粗体
        Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//宋体 10 粗体
        //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//宋体 10.5 粗体
        //Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//宋体 11 粗体
        //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//宋体 12 粗体
        Font FontCN_SONG15B = new Font(bfSONG, 15, Font.BOLD);//宋体 15 粗体
        
        //宋体 斜体
        //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//宋体 10 斜体
        
        
        //西文字体
        //times new Roman 正常
        //Font FontEN_T8N = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);//times new roman 8 正常
        Font FontEN_T8_5N = new Font(Font.TIMES_ROMAN, 8.5f, Font.NORMAL);//times new roman 8.5 正常
        //Font FontEN_T9N = new Font(Font.TIMES_ROMAN, 9, Font.NORMAL);//times new roman 9 正常
        //Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 正常
        Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 正常
        Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 正常
        
        //times new Roman 粗体
        Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 粗体
        Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 粗体
        Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 粗体
        Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 粗体
        //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 粗体
        
        //times new Roman 斜体
        Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 斜体
        
        //HELVETICA 正常
        Font FontEN_H7N = new Font(Font.HELVETICA, 7, Font.NORMAL);//HELVETICA 7 正常
        //HELVETICA 粗体
        Font FontEN_H10B = new Font(Font.HELVETICA, 10, Font.BOLD);//HELVETICA 10 粗体
        
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", "");//是否公约
        
        //中文标题
        Paragraph ParagraphTitleCN = new Paragraph("来 华 收 养 子 女 通 知 书", FontCN_HEI20B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        document.add(ParagraphTitleCN);
        //英文标题
        Paragraph ParagraphTitleEN = new Paragraph("Notice of Travelling to China for Adoption", FontEN_T12B);
        ParagraphTitleEN.setAlignment(Element.ALIGN_CENTER);
        if("0".equals(isFB)){
            ParagraphTitleEN.setSpacingAfter(20);
        }
        document.add(ParagraphTitleEN);
        if("1".equals(isFB)){
            //档案副本
            Paragraph ParagraphTitleFB = new Paragraph("（副    本）", FontCN_SONG15B);
            ParagraphTitleFB.setAlignment(Element.ALIGN_CENTER);
            document.add(ParagraphTitleFB);
        }
        //文件编号
        String SIGN_NO = data.getString("SIGN_NO");//
        Paragraph ParagraphFileCode = new Paragraph(SIGN_NO, FontEN_T14B);
        ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
        ParagraphFileCode.setSpacingAfter(5);
        document.add(ParagraphFileCode);
        //收养人称呼
        String MALE_NAME = data.getString("MALE_NAME","");//男收养人
        String FEMALE_NAME = data.getString("FEMALE_NAME","");//女收养人
        if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME, FontEN_T12N);
            document.add(ParagraphMaleName);
            Paragraph ParagraphFemaleName = new Paragraph("& MRS. "+FEMALE_NAME+":", FontEN_T12N);
            document.add(ParagraphFemaleName);
        }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
            Paragraph ParagraphMaleName = new Paragraph("MR. "+MALE_NAME+":", FontEN_T12N);
            document.add(ParagraphMaleName);
        }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            Paragraph ParagraphFemaleName = new Paragraph("MRS. "+FEMALE_NAME+":", FontEN_T12N);
            document.add(ParagraphFemaleName);
        }
        //中文正文
        Paragraph ParagraphContextCN = new Paragraph();
        ParagraphContextCN.setFirstLineIndent(20);//首行缩进
        Phrase PhraseContextCN1 = new Phrase();
        if("1".equals(IS_CONVENTION_ADOPT)){//公约
            PhraseContextCN1 = new Phrase("根据《中华人民共和国收养法》和《跨国收养方面保护儿童及合作公约》，经审查，同意你们收养", FontCN_SONG10N);
        }else{
            PhraseContextCN1 = new Phrase("根据《中华人民共和国收养法》，经审查，同意你们收养", FontCN_SONG10N);
        }
        ParagraphContextCN.add(PhraseContextCN1);
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN");//福利院
        Phrase PhraseContextCN2 = new Phrase(WELFARE_NAME_CN, FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN2);
        Phrase PhraseContextCN3 = new Phrase("抚养的", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN3);
        String NAME = data.getString("NAME");//儿童姓名
        Phrase PhraseContextCN4 = new Phrase(NAME, FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN4);
        Phrase PhraseContextCN5 = new Phrase("。请你们持本通知亲自到中国", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN5);
        String PROVINCE_CN = data.getString("PROVINCE_CN");//省份
        Phrase PhraseContextCN6 = new Phrase(PROVINCE_CN, FontCN_SONG10B);
        ParagraphContextCN.add(PhraseContextCN6);
        Phrase PhraseContextCN7 = new Phrase("民政厅收养登记机关办理收养登记手续。", FontCN_SONG10N);
        ParagraphContextCN.add(PhraseContextCN7);
        ParagraphContextCN.setLeading(20f);
        document.add(ParagraphContextCN);
        //英文正文
        Paragraph ParagraphContextEN = new Paragraph();
        ParagraphContextEN.setFirstLineIndent(20);//首行缩进
        Phrase PhraseContextEN1 = new Phrase("In accordance with the ", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN1);
        Phrase PhraseContextEN2 = new Phrase("Adoption Law of the People's Republic of China", FontEN_T11I);
        ParagraphContextEN.add(PhraseContextEN2);
        if("1".equals(IS_CONVENTION_ADOPT)){//公约
            Phrase PhraseContextEN2GY1 = new Phrase(" and the ", FontEN_T11N);
            ParagraphContextEN.add(PhraseContextEN2GY1);
            
            Phrase PhraseContextEN2GY2 = new Phrase("Convention on Protection of Children and Cooperation in Respect of Intercountry Adoption", FontEN_T11I);
            ParagraphContextEN.add(PhraseContextEN2GY2);
        }
        Phrase PhraseContextEN3 = new Phrase(",we agreed that the child,", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN3);
        String NAME_PINYIN = data.getString("NAME_PINYIN");//儿童姓名
        Phrase PhraseContextEN4 = new Phrase(NAME_PINYIN, FontEN_T11B);
        ParagraphContextEN.add(PhraseContextEN4);
        Phrase PhraseContextEN5 = new Phrase(",who is in the care of ", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN5);
        String WELFARE_NAME_EN = data.getString("WELFARE_NAME_EN");//福利院
        Phrase PhraseContextEN6 = new Phrase(WELFARE_NAME_EN, FontEN_T11B);
        ParagraphContextEN.add(PhraseContextEN6);
        Phrase PhraseContextEN7 = new Phrase(",be place with you for adoption.Please travel in person with this notice to the adoption registry office within the Civil Affairs Department of ", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN7);
        String PROVINCE_EN = data.getString("PROVINCE_EN");//省份
        Phrase PhraseContextEN8 = new Phrase(PROVINCE_EN, FontEN_T11B);
        ParagraphContextEN.add(PhraseContextEN8);
        Phrase PhraseContextEN9 = new Phrase("in China to proceed the registration formalities.", FontEN_T11N);
        ParagraphContextEN.add(PhraseContextEN9);
        ParagraphContextEN.setLeading(20f);
        ParagraphContextEN.setSpacingAfter(25);//与下段相隔
        document.add(ParagraphContextEN);
        
        PdfPTable Table1 = new PdfPTable(2);
        Table1.setTotalWidth(width);
        Table1.setLockedWidth(true);
        
        PdfPCell Table1_cell1 = new PdfPCell();
        Paragraph Paragraph_Adopted = new Paragraph();
        Phrase Phrase_Adopted1 = new Phrase("被收养人姓名 ", FontCN_SONG10N);
        Paragraph_Adopted.add(Phrase_Adopted1);
        Phrase Phrase_Adopted2 = new Phrase("Name of Adopted Child:", FontEN_H7N);
        Paragraph_Adopted.add(Phrase_Adopted2);
        Table1_cell1.addElement(Paragraph_Adopted);
        //Table1_cell1.setFixedHeight(1f);
        Table1_cell1.setBorder(0);
        Table1.addCell(Table1_cell1);
        
        PdfPCell Table1_cell2 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Father = new Paragraph();
        Phrase Phrase_Adoptive_Father1 = new Phrase("预收养父亲姓名 ", FontCN_SONG10N);
        Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father1);
        Phrase Phrase_Adoptive_Father2 = new Phrase("Name of Prospective Adoptive Father:", FontEN_H7N);
        Paragraph_Adoptive_Father.add(Phrase_Adoptive_Father2);
        Table1_cell2.addElement(Paragraph_Adoptive_Father);
        Table1_cell2.setBorder(0);
        Table1.addCell(Table1_cell2);
        
        PdfPCell Table1_cell3 = new PdfPCell();
        Table1_cell3.addElement(new Paragraph(NAME, FontCN_SONG10B));
        Table1_cell3.setBorder(0);
        Table1.addCell(Table1_cell3);
        
        PdfPCell Table1_cell4 = new PdfPCell();
        Table1_cell4.addElement(new Paragraph(MALE_NAME, FontEN_H10B));
        Table1_cell4.setBorder(0);
        Table1.addCell(Table1_cell4);
        
        
        PdfPCell Table1_cell5 = new PdfPCell();
        Paragraph Paragraph_Adopted_Sex = new Paragraph();
        Phrase Phrase_Adopted_Sex1 = new Phrase("性别 ", FontCN_SONG10N);
        Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex1);
        Phrase Phrase_Adopted_Sex2 = new Phrase("Sex: ", FontEN_H7N);
        Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex2);
        String SEX_CN = data.getString("SEX_CN");//儿童性别
        Phrase Phrase_Adopted_Sex3 = new Phrase(SEX_CN, FontCN_SONG10B);
        Paragraph_Adopted_Sex.add(Phrase_Adopted_Sex3);
        Table1_cell5.addElement(Paragraph_Adopted_Sex);
        Table1_cell5.setBorder(0);
        Table1.addCell(Table1_cell5);
        
        
        PdfPCell Table1_cell6 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Father_DOB = new Paragraph();
        Phrase Phrase_Adoptive_Father_DOB1 = new Phrase("出生日期 ", FontCN_SONG10N);
        Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB1);
        Phrase Phrase_Adoptive_Father_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
        Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB2);
        String MALE_BIRTHDAY = data.getDate("MALE_BIRTHDAY");//父亲生日
        Phrase Phrase_Adoptive_Father_DOB3 = new Phrase(MALE_BIRTHDAY, FontEN_H10B);
        Paragraph_Adoptive_Father_DOB.add(Phrase_Adoptive_Father_DOB3);
        Table1_cell6.addElement(Paragraph_Adoptive_Father_DOB);
        Table1_cell6.setBorder(0);
        Table1.addCell(Table1_cell6);
        
        PdfPCell Table1_cell7 = new PdfPCell();
        Paragraph Paragraph_Adopted_DOB = new Paragraph();
        Phrase Phrase_Adoped_DOB1 = new Phrase("出生日期 ", FontCN_SONG10N);
        Paragraph_Adopted_DOB.add(Phrase_Adoped_DOB1);
        Phrase Phrase_Adopted_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
        Paragraph_Adopted_DOB.add(Phrase_Adopted_DOB2);
        String BIRTHDAY = data.getDate("BIRTHDAY");//儿童生日
        Phrase Phrase_Adopted_DOB3 = new Phrase(BIRTHDAY, FontEN_H10B);
        Paragraph_Adopted_DOB.add(Phrase_Adopted_DOB3);
        Table1_cell7.addElement(Paragraph_Adopted_DOB);
        Table1_cell7.setBorder(0);
        Table1.addCell(Table1_cell7);
        
        PdfPCell Table1_cell8 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Mother = new Paragraph();
        Phrase Phrase_Adoptive_Mother1 = new Phrase("预收养母亲姓名 ", FontCN_SONG10N);
        Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother1);
        Phrase Phrase_Adoptive_Mother2 = new Phrase("Name of Prospective Adoptive Mother:", FontEN_H7N);
        Paragraph_Adoptive_Mother.add(Phrase_Adoptive_Mother2);
        Table1_cell8.addElement(Paragraph_Adoptive_Mother);
        Table1_cell8.setBorder(0);
        Table1.addCell(Table1_cell8);
        
        PdfPCell Table1_cell9 = new PdfPCell();
        Paragraph Paragraph_Adopted_Add = new Paragraph();
        Phrase Phrase_Adopted_Add1 = new Phrase("所在地 ", FontCN_SONG10N);
        Paragraph_Adopted_Add.add(Phrase_Adopted_Add1);
        Phrase Phrase_Adopted_Add2 = new Phrase("Residential information(SWI/Address):", FontEN_H7N);
        Paragraph_Adopted_Add.add(Phrase_Adopted_Add2);
        Table1_cell9.addElement(Paragraph_Adopted_Add);
        Table1_cell9.setBorder(0);
        Table1.addCell(Table1_cell9);
        
        PdfPCell Table1_cell10 = new PdfPCell();
        Table1_cell10.addElement(new Paragraph(FEMALE_NAME, FontEN_H10B));
        Table1_cell10.setBorder(0);
        Table1.addCell(Table1_cell10);
        
        PdfPCell Table1_cell11 = new PdfPCell();
        Table1_cell11.addElement(new Paragraph(WELFARE_NAME_CN, FontCN_SONG10B));
        Table1_cell11.setBorder(0);
        Table1.addCell(Table1_cell11);
        
        PdfPCell Table1_cell12 = new PdfPCell();
        Paragraph Paragraph_Adoptive_Mother_DOB = new Paragraph();
        Phrase Phrase_Adoptive_Mother_DOB1 = new Phrase("出生日期 ", FontCN_SONG10N);
        Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB1);
        Phrase Phrase_Adoptive_Mother_DOB2 = new Phrase("Date of Birth: ", FontEN_H7N);
        Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB2);
        String FEMALE_BIRTHDAY = data.getDate("FEMALE_BIRTHDAY");//母亲生日
        Phrase Phrase_Adoptive_Mother_DOB3 = new Phrase(FEMALE_BIRTHDAY, FontEN_H10B);
        Paragraph_Adoptive_Mother_DOB.add(Phrase_Adoptive_Mother_DOB3);
        Table1_cell12.addElement(Paragraph_Adoptive_Mother_DOB);
        Table1_cell12.setBorder(0);
        Table1.addCell(Table1_cell12);
        Table1.writeSelectedRows(0, -1, 80, 420, writer.getDirectContent());
        
        String CI_ID = data.getString("CI_ID");
        String photoPath = handler.getPhotoPath(conn, CI_ID);
        if(!"".equals(photoPath)){
            File file = new File(photoPath);//
            if (file.exists()) {
                Image photograph = Image.getInstance(photoPath);
                photograph.setAbsolutePosition(95, 160);
                photograph.scaleAbsolute(72f, 100f);
                document.add(photograph);
            }
        }
        
        PdfPTable Table2 = new PdfPTable(1);
        Table2.setTotalWidth(width-190);
        Table2.setLockedWidth(true);
        
        PdfPCell Table2_cell1 = new PdfPCell(new Paragraph("  中国儿童福利和收养中心", FontCN_SONG15B));
        Table2_cell1.setBorder(0);
        Table2_cell1.setFixedHeight(25f);
        Table2_cell1.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell1);
        
        PdfPCell Table2_cell2 = new PdfPCell(new Paragraph("China Center for Children's Welfare and Adoption", FontEN_T10B));
        Table2_cell2.setBorder(0);
        Table2_cell2.setFixedHeight(18f);
        Table2_cell2.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell2);
        String NOTICE_SIGN_DATE = data.getDate("NOTICE_SIGN_DATE");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if(!"".equals(NOTICE_SIGN_DATE)){
            Date date = sdf.parse(NOTICE_SIGN_DATE);
            SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy年MM月dd日");
            NOTICE_SIGN_DATE = sdfCN.format(date);
        }
        PdfPCell Table2_cell3 = new PdfPCell(new Paragraph(NOTICE_SIGN_DATE, FontCN_SONG10N));
        Table2_cell3.setBorder(0);
        Table2_cell3.setFixedHeight(18f);
        Table2_cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell3);
        
        PdfPCell Table2_cell4 = new PdfPCell(new Paragraph("地址：中国北京市东城区王家园胡同16号", FontCN_SONG8_5N));
        Table2_cell4.setBorder(0);
        Table2_cell4.setFixedHeight(18f);
        Table2_cell4.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell4);
        
        PdfPCell Table2_cell5 = new PdfPCell(new Paragraph("Address: No.16,Wangjiayuan Lane,Dongcheng District,Beijing,China", FontEN_T8_5N));
        Table2_cell5.setBorder(0);
        Table2_cell5.setHorizontalAlignment(Element.ALIGN_CENTER);
        Table2.addCell(Table2_cell5);
        
        Table2.writeSelectedRows(0, -1, 275, 250, writer.getDirectContent());
        
        PdfPTable Table3 = new PdfPTable(1);
        Table3.setTotalWidth(width);
        Table3.setLockedWidth(true);
        
        PdfPCell Table3_cell1 = new PdfPCell(new Paragraph("注：本通知书自签发之日起三个月内有效。", FontCN_HEI10B));
        Table3_cell1.setFixedHeight(18f);
        Table3_cell1.setBorder(0);
        Table3.addCell(Table3_cell1);
        
        PdfPCell Table3_cell2 = new PdfPCell(new Paragraph("Note:This Notice is valid within three months from the date of issuance.", FontEN_H10B));
        Table3_cell2.setBorder(0);
        Table3.addCell(Table3_cell2);
        if("1".equals(isFB)){
            String ARCHIVE_NO = data.getString("ARCHIVE_NO");//档案号
            PdfPCell Table3_cell3 = new PdfPCell(new Paragraph(ARCHIVE_NO, FontEN_H10B));
            Table3_cell3.setHorizontalAlignment(Element.ALIGN_RIGHT);
            Table3_cell3.setBorder(0);
            Table3.addCell(Table3_cell3);
        }
        Table3.writeSelectedRows(0, -1, 80, 130, writer.getDirectContent());
        document.close();
        
        File file = new File(PDFpath);//来华收养子女通知书
        if (file.exists()) {
            String smallType = "";
            if("0".equals(isFB)){
                String Outpath = CommonConfig.getProjectPath() + "/tempFile/来华收养子女通知书_SYZZ.pdf";//输出文件路径
                if("1".equals(isSY)){
                    String imagePath = CommonConfig.getProjectPath()+"/resource/images/watermark-grap.png";
                    waterMark(PDFpath, Outpath, imagePath);
                }
                File file_syzz = new File(Outpath);
                if(file_syzz.exists()){
                    AttHelper.delAttsOfPackageId(MI_ID, AttConstants.LHSYZNTZSSY, "AF");//删除原附件
                    AttHelper.manualUploadAtt(file_syzz, "AF", MI_ID, "来华收养子女通知书_SYZZ.pdf", AttConstants.LHSYZNTZSSY, "AF", AttConstants.LHSYZNTZSSY, MI_ID);
                    file_syzz.delete();//删除原来生成的来华收养子女通知书
                }
                
                smallType = AttConstants.LHSYZNTZS;//来华收养子女通知书
            }else{
                smallType = AttConstants.LHSYZNTZSFB;//来华收养子女通知书副本
            }
            AttHelper.delAttsOfPackageId(MI_ID, smallType, "AF");//删除原附件
            
            AttHelper.manualUploadAtt(file, "AF", MI_ID, "来华收养子女通知书.pdf", smallType, "AF", smallType, MI_ID);
            file.delete();//删除原来生成的来华收养子女通知书
        }
    }
    /**
     * 
     * @Title: noticeForAdoption
     * @Description: 涉外送养通知
     * @author: xugy
     * @date: 2014-11-10下午8:56:10
     * @param conn
     * @param MI_ID 匹配信息ID
     * @param isFB 值0时通知书生成，值1时副本生成
     * @throws Exception
     */
    public void noticeForAdoption(Connection conn, String MI_ID, String isFB) throws Exception{

        Data data = handler.getNoticeInfo(conn, MI_ID);
        
        //实例化文档对象  
        Document document = new Document(PageSize.A4, 140, 140, 100, 50);//A4纸，左右上下空白
        String PDFpath = CommonConfig.getProjectPath() + "/tempFile/涉外送养通知.pdf";//临时存放涉外送养通知的路径
        
        // PdfWriter对象
        PdfWriter writer = PdfWriter.getInstance(document,new FileOutputStream(PDFpath));//文件的输出路径+文件的实际名称 
        float width = document.getPageSize().getWidth() - 280;
        document.open();// 打开文档
        //pdf文档中中文字体的设置，注意一定要添加iTextAsian.jar包
        //中文字体
        BaseFont bfHEI = BaseFont.createFont(HEIFontPath,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//黑体
        //BaseFont bf2 = BaseFont.createFont("STSong-Light", "UniGB-UCS2-H", BaseFont.NOT_EMBEDDED);//四通宋体
        //BaseFont bf3 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMKAI.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 楷体字
        //BaseFont bf4 = BaseFont.createFont("C:\\Windows\\Fonts\\SIMFANG.TTF",BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);// 仿宋体
        BaseFont bfSONG = BaseFont.createFont(SONGFontPatn,BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);//  宋体
        
        //黑体 粗体
        //Font FontCN_HEI10B = new Font(bfHEI, 10, Font.BOLD);//黑体 10 粗体
        //Font FontCN_HEI11B = new Font(bfHEI, 11, Font.BOLD);//黑体 11 粗体
        //Font FontCN_HEI12B = new Font(bfHEI, 12, Font.BOLD);//黑体 12 粗体
        //Font FontCN_HEI16B = new Font(bfHEI, 16, Font.BOLD);//黑体 16 粗体
        Font FontCN_HEI20B = new Font(bfHEI, 20, Font.BOLD);//黑体 20 粗体
        //黑体 正常
        //Font FontCN_HEI7N = new Font(bfHEI, 7, Font.NORMAL);//黑体 7 正常
        
        //宋体 正常
        //Font FontCN_SONG8N = new Font(bfSONG, 8, Font.NORMAL);//宋体 8 正常
        //Font FontCN_SONG8_5N = new Font(bfSONG, 8.5f, Font.NORMAL);//宋体 8.5 正常
        //Font FontCN_SONG9N = new Font(bfSONG, 9, Font.NORMAL);//宋体 9 正常
        //Font FontCN_SONG9_5N = new Font(bfSONG, 9.5f, Font.NORMAL);//宋体 9.5 正常
        Font FontCN_SONG10N = new Font(bfSONG, 10, Font.NORMAL);//宋体 10 正常
        //Font FontCN_SONG10_5N = new Font(bfSONG, 10.5f, Font.NORMAL);//宋体 10.5 正常
        //Font FontCN_SONG11N = new Font(bfSONG, 11, Font.NORMAL);//宋体 11 正常
        //Font FontCN_SONG12N = new Font(bfSONG, 12, Font.NORMAL);//宋体 12 正常
        //Font FontCN_SONG12_5N = new Font(bfSONG, 12.5f, Font.NORMAL);//宋体 12.5 正常
        
        //宋体 粗体
        Font FontCN_SONG10B = new Font(bfSONG, 10, Font.BOLD);//宋体 10 粗体
        //Font FontCN_SONG10_5B = new Font(bfSONG, 10.5f, Font.BOLD);//宋体 10.5 粗体
        //Font FontCN_SONG11B = new Font(bfSONG, 11, Font.BOLD);//宋体 11 粗体
        //Font FontCN_SONG12B = new Font(bfSONG, 12, Font.BOLD);//宋体 12 粗体
        Font FontCN_SONG15B = new Font(bfSONG, 15, Font.BOLD);//宋体 15 粗体
        
        //宋体 斜体
        //Font FontCN_SONG10I = new Font(bfSONG, 10, Font.ITALIC);//宋体 10 斜体
        
        
        //西文字体
        //times new Roman 正常
        //Font FontEN_T8N = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL);//times new roman 8 正常
        //Font FontEN_T8_5N = new Font(Font.TIMES_ROMAN, 8.5f, Font.NORMAL);//times new roman 8.5 正常
        //Font FontEN_T9N = new Font(Font.TIMES_ROMAN, 9, Font.NORMAL);//times new roman 9 正常
        //Font FontEN_T10N = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);//times new roman 10 正常
        //Font FontEN_T11N = new Font(Font.TIMES_ROMAN, 11, Font.NORMAL);//times new roman 11 正常
        //Font FontEN_T12N = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);//times new roman 12 正常
        
        //times new Roman 粗体
        //Font FontEN_T10B = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);//times new roman 10 粗体
        //Font FontEN_T11B = new Font(Font.TIMES_ROMAN, 11, Font.BOLD);//times new roman 11 粗体
        //Font FontEN_T12B = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);//times new roman 12 粗体
        Font FontEN_T14B = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);//times new roman 14 粗体
        //Font FontEN_T15B = new Font(Font.TIMES_ROMAN, 15, Font.BOLD);//times new roman 15 粗体
        
        //times new Roman 斜体
        //Font FontEN_T11I = new Font(Font.TIMES_ROMAN, 11, Font.ITALIC);//times new roman 11 斜体
        
        //HELVETICA 正常
        //Font FontEN_H7N = new Font(Font.HELVETICA, 7, Font.NORMAL);//HELVETICA 7 正常
        //HELVETICA 粗体
        Font FontEN_H10B = new Font(Font.HELVETICA, 10, Font.BOLD);//HELVETICA 10 粗体
        
        String IS_CONVENTION_ADOPT = data.getString("IS_CONVENTION_ADOPT", "");//是否公约
        
        //中文标题
        Paragraph ParagraphTitleCN = new Paragraph("涉 外 送 养 通 知", FontCN_HEI20B);
        ParagraphTitleCN.setAlignment(Element.ALIGN_CENTER);
        document.add(ParagraphTitleCN);
        if("1".equals(isFB)){
            //档案副本
            Paragraph ParagraphTitleFB = new Paragraph("（副    本）", FontCN_SONG15B);
            ParagraphTitleFB.setAlignment(Element.ALIGN_CENTER);
            document.add(ParagraphTitleFB);
        }
        //文件编号
        String SIGN_NO = data.getString("SIGN_NO");
        Paragraph ParagraphFileCode = new Paragraph(SIGN_NO, FontEN_T14B);
        ParagraphFileCode.setAlignment(Element.ALIGN_RIGHT);
        ParagraphFileCode.setSpacingBefore(40);
        ParagraphFileCode.setSpacingAfter(40);
        document.add(ParagraphFileCode);
        //民政厅
        String ADREG_ORG_CN = data.getString("ADREG_ORG_CN");
        Paragraph ParagraphMZT = new Paragraph(ADREG_ORG_CN+":", FontCN_SONG10B);
        document.add(ParagraphMZT);
        //中文正文
        Paragraph ParagraphContext = new Paragraph();
        ParagraphContext.setFirstLineIndent(20);//首行缩进
        ParagraphContext.setLeading(22f);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfCN = new SimpleDateFormat("yyyy年MM月dd日");
        String MALE_NAME = data.getString("MALE_NAME","");//
        String MALE_NATION_NAME = data.getString("MALE_NATION_NAME");//
        String MALE_BIRTHDAY = data.getString("MALE_BIRTHDAY","");//
        if(!"".equals(MALE_BIRTHDAY)){
            Date date1 = sdf.parse(MALE_BIRTHDAY);
            MALE_BIRTHDAY = sdfCN.format(date1);
        }
        String FEMALE_NAME = data.getString("FEMALE_NAME","");//
        String FEMALE_NATION_NAME = data.getString("FEMALE_NATION_NAME");//
        String FEMALE_BIRTHDAY = data.getString("FEMALE_BIRTHDAY","");//
        if(!"".equals(FEMALE_BIRTHDAY)){
            Date date2 = sdf.parse(FEMALE_BIRTHDAY);
            FEMALE_BIRTHDAY = sdfCN.format(date2);
        }
        Phrase PhraseContext1 = new Phrase();
        if(!"".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            PhraseContext1 = new Phrase("经审查，收养人MR."+MALE_NAME+"（"+MALE_NATION_NAME+"国籍，"+MALE_BIRTHDAY+"出生）和MRS."+FEMALE_NAME+"（"+FEMALE_NATION_NAME+"国籍，"+FEMALE_BIRTHDAY+"出生）符合《中华人民共和国收养法》", FontCN_SONG10N);
        }else if(!"".equals(MALE_NAME) && "".equals(FEMALE_NAME)){
            PhraseContext1 = new Phrase("经审查，收养人MR."+MALE_NAME+"（"+MALE_NATION_NAME+"国籍，"+MALE_BIRTHDAY+"出生）符合《中华人民共和国收养法》", FontCN_SONG10N);
        }else if("".equals(MALE_NAME) && !"".equals(FEMALE_NAME)){
            PhraseContext1 = new Phrase("经审查，收养人MRS."+FEMALE_NAME+"（"+FEMALE_NATION_NAME+"国籍，"+FEMALE_BIRTHDAY+"出生）符合《中华人民共和国收养法》", FontCN_SONG10N);
        }
        ParagraphContext.add(PhraseContext1);
        if("1".equals(IS_CONVENTION_ADOPT)){//公约
            Phrase PhraseContext2 = new Phrase("和《跨国收养方面保护儿童及合作公约》", FontCN_SONG10N);
            ParagraphContext.add(PhraseContext2);
        }
        String WELFARE_NAME_CN = data.getString("WELFARE_NAME_CN");
        String NAME = data.getString("NAME");
        String SEX_CN = data.getString("SEX_CN");
        String BIRTHDAY = data.getString("BIRTHDAY");
        Date date3 = sdf.parse(BIRTHDAY);
        BIRTHDAY = sdfCN.format(date3);
        Phrase PhraseContext3 = new Phrase("及有关法律规定的收养条件。经征求意见，收养人同意收养"+WELFARE_NAME_CN+"抚养的"+NAME+"（"+SEX_CN+"，"+BIRTHDAY+"出生）。中国儿童福利院和收养中心已向收养人签发来华收养子女通知书，请通知送养人做好办理收养登记手续的准备工作。", FontCN_SONG10N);
        ParagraphContext.add(PhraseContext3);
        ParagraphContext.setSpacingAfter(20);
        document.add(ParagraphContext);
        
        //特此通知
        Paragraph ParagraphTCTZ = new Paragraph("特此通知", FontCN_SONG10N);
        ParagraphTCTZ.setFirstLineIndent(20);//首行缩进
        ParagraphTCTZ.setSpacingAfter(60);
        document.add(ParagraphTCTZ);
        
        
        PdfPTable Table1 = new PdfPTable(1);
        Table1.setTotalWidth(width);
        
        PdfPCell Table1_cell1 = new PdfPCell(new Paragraph("中国儿童福利和收养中心", FontCN_SONG10B));
        Table1_cell1.setBorder(0);
        Table1_cell1.setFixedHeight(25f);
        Table1_cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
        Table1.addCell(Table1_cell1);
        String NOTICE_SIGN_DATE = data.getDate("NOTICE_SIGN_DATE");
        if(!"".equals(NOTICE_SIGN_DATE)){
            Date date4 = sdf.parse(NOTICE_SIGN_DATE);
            NOTICE_SIGN_DATE = sdfCN.format(date4);
        }
        PdfPCell Table1_cell2 = new PdfPCell(new Paragraph(NOTICE_SIGN_DATE, FontCN_SONG10N));
        Table1_cell2.setBorder(0);
        Table1_cell2.setFixedHeight(18f);
        Table1_cell2.setHorizontalAlignment(Element.ALIGN_RIGHT);
        Table1.addCell(Table1_cell2);
        Table1.setSpacingAfter(30);
        document.add(Table1);
        
        if("1".equals(isFB)){//副本生成档案号
            PdfPTable Table2 = new PdfPTable(1);
            Table2.setTotalWidth(width);
            String ARCHIVE_NO = data.getString("ARCHIVE_NO");//档案号
            PdfPCell Table2_cell1 = new PdfPCell(new Paragraph(ARCHIVE_NO, FontEN_H10B));
            Table2_cell1.setHorizontalAlignment(Element.ALIGN_RIGHT);
            Table2_cell1.setBorder(0);
            Table2.addCell(Table2_cell1);
            document.add(Table2);
        }
        document.close();
        
        File file = new File(PDFpath);//涉外送养通知
        if (file.exists()) {
            String smallType = "";
            if("0".equals(isFB)){
                smallType = AttConstants.SWSYTZ;//涉外送养通知
            }else{
                smallType = AttConstants.SWSYTZFB;//涉外送养通知副本
            }
            AttHelper.delAttsOfPackageId(MI_ID, smallType, "AF");//删除原附件
            
            AttHelper.manualUploadAtt(file, "AF", MI_ID, "涉外送养通知.pdf", smallType, "AF", smallType, MI_ID);
            file.delete();//删除原来生成的征求意见通知书
        }
    }
    /**
     * 
     * @Title: plusPrintNum
     * @Description: 增加打印次数
     * @author: xugy
     * @date: 2014-11-12下午9:47:52
     * @param MI_ID
     * @param BIZ_TYPE
     * @return
     */
    public String plusPrintNum(String MI_ID, String BIZ_TYPE){
        String rValue = "0";
        String[] arry = MI_ID.split(",");
        try{
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            dt = DBTransaction.getInstance(conn);
            for(int i=0;i<arry.length;i++){
                Data PNdata = handler.getPrintNum(conn, arry[i]);
                Data MIdata = new Data();
                MIdata.add("MI_ID", arry[i]);
                Data PRdata = new Data();
                PRdata.add("PR_ID", "");//打印记录ID
                PRdata.add("BIZ_TYPE", BIZ_TYPE);//业务类型
                PRdata.add("MI_ID", arry[i]);//匹配信息ID
                PRdata.add("PRINTER_NAME", SessionInfo.getCurUser().getPerson().getCName());//打印人
                PRdata.add("PRINT_DATE", DateUtility.getCurrentDate());//打印日期
                if("1".equals(BIZ_TYPE)){//征求意见书
                    int NUM = PNdata.getInt("ADVICE_PRINT_NUM");//征求意见_打印次数
                    int ADVICE_PRINT_NUM = NUM + 1;
                    MIdata.add("ADVICE_PRINT_NUM", ADVICE_PRINT_NUM);//征求意见_打印次数
                    MIdata.add("ADVICE_PRINT_DATE", DateUtility.getCurrentDate());//征求意见_最后打印日期
                    PRdata.add("PRINT_SIGN_DATE", PNdata.getString("ADVICE_SIGN_DATE"));//落款日期
                }
                if("2".equals(BIZ_TYPE)){//通知书
                    int NUM = PNdata.getInt("NOTICE_PRINT_NUM");//通知书_打印次数
                    int NOTICE_PRINT_NUM = NUM + 1;
                    MIdata.add("NOTICE_PRINT_NUM", NOTICE_PRINT_NUM);//通知书_打印次数
                    MIdata.add("NOTICE_PRINT_DATE", DateUtility.getCurrentDate());//NOTICE_PRINT_DATE
                    PRdata.add("PRINT_SIGN_DATE", PNdata.getString("NOTICE_SIGN_DATE"));//落款日期
                }
                if("3".equals(BIZ_TYPE)){//通知书副本
                    int NUM = PNdata.getInt("NOTICECOPY_PRINT_NUM");//通知书副本_打印次数
                    int NOTICECOPY_PRINT_NUM = NUM + 1;
                    MIdata.add("NOTICECOPY_PRINT_NUM", NOTICECOPY_PRINT_NUM);//通知书副本_打印次数
                    MIdata.add("NOTICECOPY_PRINT_DATE", DateUtility.getCurrentDate());//NOTICECOPY_PRINT_DATE
                    String NOTICECOPY_REPRINT = PNdata.getString("NOTICECOPY_REPRINT");
                    if("1".equals(NOTICECOPY_REPRINT)){
                        MIdata.add("NOTICECOPY_REPRINT", "9");//通知书副本_是否重打
                    }
                    PRdata.add("PRINT_SIGN_DATE", PNdata.getString("NOTICECOPY_SIGN_DATE"));//落款日期
                    
                }
                handler.saveNcmMatchInfo(conn, MIdata);
                handler.saveNcmPrintRecord(conn, PRdata);
            }
            
            dt.commit();
            rValue = "1";
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
            
        } catch (SQLException e) {
            try {
                dt.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            if (log.isError()) {
                log.logError("操作异常:" + e.getMessage(),e);
            }
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
        return rValue;
        
    }
    
    /**
     * 
     * @Title: waterMark
     * @Description: pdf 添加水印
     * @author: xugy
     * @date: 2014-11-17下午6:38:24
     * @param inputPath
     * @param outputPath
     * @param imagePath
     */
    public void waterMark(String inputPath, String outputPath, String imagePath){
        try {
            PdfReader reader = new PdfReader(inputPath);
            PdfStamper stamper = new PdfStamper(reader, new FileOutputStream(outputPath));
            int total = reader.getNumberOfPages() + 1;
            PdfContentByte under;
            Image img = Image.getInstance(imagePath);// 插入水印
            img.setAbsolutePosition(60, 300);
            for (int i = 1; i < total; i++) {
                under = stamper.getUnderContent(i);
                under.addImage(img);
            }
            stamper.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
