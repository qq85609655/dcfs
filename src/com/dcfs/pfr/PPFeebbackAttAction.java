package com.dcfs.pfr;

import hx.common.Constants;
import hx.common.Exception.DBException;
import hx.common.j2ee.BaseAction;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.database.transaction.DBTransaction;
import hx.log.Log;
import hx.log.UtilLog;
import hx.upload.UploadManagerHandler;
import hx.util.DateUtility;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dcfs.common.atttype.AttConstants;
import com.dcfs.common.batchattmanager.BatchAttManager;
/**
 * 
 * @Title: PPFeebbackAttAction.java
 * @Description: 安置后报告附件
 * @Company: 21softech
 * @Created on 2014-10-17 下午3:54:58
 * @author xugy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class PPFeebbackAttAction extends BaseAction {
    
    private static Log log=UtilLog.getLog(PPFeebbackAttAction.class);
    private Connection conn = null;
    private PPFeebbackAttHandler handler;
    private BatchAttManager bm;
    private DBTransaction dt = null;//事务处理
    private String retValue = SUCCESS;
    
    public PPFeebbackAttAction() {
        this.handler=new PPFeebbackAttHandler();
        this.bm=new BatchAttManager();
    }

    @Override
    public String execute() throws Exception {
        // TODO Auto-generated method stub
        return null;
    }
    /**
     * 
     * @Title: findPPFdeedbackAtt
     * @Description: 获取附件
     * @author: xugy
     * @date: 2014-10-17下午3:58:40
     * @return
     */
    public String findPPFdeedbackAtt() throws ParseException{
        String FB_REC_ID = getParameter("FB_REC_ID");//报告ID
        String BIRTHDAY = getParameter("BIRTHDAY");//儿童生日
        String NUM = getParameter("NUM");//报告次数
        String ACCIDENT_FLAG = getParameter("ACCIDENT_FLAG");//收养关系有无重大变故：1=一般；2=更换家庭；3=死亡
        String isCN = getParameter("isCN");//是否显示中文
        String isEdit = getParameter("isEdit");//isEdit=1 是否编辑状态
        String LANG = getParameter("LANG");
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            DataList dl = new DataList();
            if("1".equals(ACCIDENT_FLAG)){
                String birthdayYear = BIRTHDAY.substring(0, 4);
                dl = attTypeNormal(conn, birthdayYear, NUM);
            }
            if("2".equals(ACCIDENT_FLAG)){
                dl = attTypeChangeFamily(conn);
            }
            if("3".equals(ACCIDENT_FLAG)){
                dl = attTypeDead(conn);
            }
            
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                DataList Attdl = handler.findPPFdeedbackAtt(conn, FB_REC_ID, CODE);
                dl.getData(i).add("ATTDL", Attdl);
            }
            
            Data photoData = new Data();
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                if((AttConstants.AR_IMAGE).equals(CODE)){
                    photoData = dl.getData(i);
                    dl.remove(photoData);
                }
            }
            
            if("1".equals(isCN)){
                for(int i=0;i<dl.size();i++){
                    String CODE = dl.getData(i).getString("CODE");
                    String F_FB_REC_ID = "F_" + FB_REC_ID;
                    DataList AttCNdl = handler.findPPFdeedbackAtt(conn, F_FB_REC_ID, CODE);
                    dl.getData(i).add("ATTCNDL", AttCNdl);
                }
            }
            setAttribute("dl",dl);
            setAttribute("photoData",photoData);
            setAttribute("isCN",isCN);
            setAttribute("isEdit",isEdit);
            setAttribute("LANG",LANG);
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
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
     * 
     * @Title: showPicture
     * @Description: 
     * @author: xugy
     * @date: 2014-10-22上午10:55:38
     * @throws Exception
     */
    public void showPicture() throws Exception{
        
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            HttpServletResponse response = getResponse();
            HttpServletRequest request = getRequest();
            String ATT_TABLE = request.getParameter("ATT_TABLE");
            String ID = request.getParameter("ID");
            
            Data pathData = handler.getPhotoPath(conn, ATT_TABLE, ID);
            String FILESYSTEM_PATH = pathData.getString("FILESYSTEM_PATH");
            String RANDOM_NAME = pathData.getString("RANDOM_NAME");
            String path = FILESYSTEM_PATH + RANDOM_NAME;
            
            FileInputStream is = new FileInputStream(path);
            response.setCharacterEncoding("UTF-8");
            response.setContentType("image/*"); // 设置返回的文件类型
            //向目录中保存
            BufferedOutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
            BufferedInputStream inputStream = new BufferedInputStream(is);
            //读写
            byte[] b = new byte[1024];
            int len = 0;
            while((len = inputStream.read(b)) != -1){
                outputStream.write(b, 0, len);
                //重置
                b = new byte[1024];
            }
            //关闭
            outputStream.flush();
            inputStream.close();
            outputStream.close();
            
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
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
    }
    
    
    public void showThumbnail(){
        try {
            //获取数据库连接
            conn = ConnectionManager.getConnection();
            //获取数据Data
            HttpServletResponse response = getResponse();
            HttpServletRequest request = getRequest();
            String ATT_TABLE = request.getParameter("ATT_TABLE");
            String ID = request.getParameter("ID");
            UploadManagerHandler umh = new UploadManagerHandler();
            InputStream is = umh.getImg(conn, ATT_TABLE, ID);
            response.setCharacterEncoding("UTF-8");
            response.setContentType("image/*"); // 设置返回的文件类型
            //向目录中保存
            BufferedOutputStream outputStream = new BufferedOutputStream(response.getOutputStream());
            BufferedInputStream inputStream = new BufferedInputStream(is);
            //读写
            byte[] b = new byte[1024];
            int len = 0;
            while((len = inputStream.read(b)) != -1){
                outputStream.write(b, 0, len);
                //重置
                b = new byte[1024];
            }
            //关闭
            outputStream.flush();
            inputStream.close();
            outputStream.close();
            
            
            
        } catch (DBException e) {
            //7 设置异常处理
            setAttribute(Constants.ERROR_MSG_TITLE, "查询操作异常");
            setAttribute(Constants.ERROR_MSG, e);
            
            if (log.isError()) {
                log.logError("查询操作异常:" + e.getMessage(),e);
            }
            
            retValue = "error1";
            
        } catch (Exception e) {
            e.printStackTrace();
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
    }
    
    /**接口，只安置后报告
     * 安置后报告-一般
     * @Title: attTypeNormal
     * @Description: 获取附件类型list
     * @author: xugy
     * @date: 2014-10-20下午3:48:48
     * @param conn
     * @return
     * @throws DBException 
     */
    public DataList attTypeNormal(Connection conn, String birthdayYear, String NUM) throws DBException{
        DataList dl = new DataList();
        dl = bm.getAttType(conn, AttConstants.AR_NORMAL);
        //判断儿童是否超过10岁
        String nowYear = DateUtility.getCurrentYear();
        int old = Integer.parseInt(nowYear)-Integer.parseInt(birthdayYear)+1;
        Data oldData = new Data();
        if(old>=10){
            oldData = handler.getSmallTypeData(conn, AttConstants.AR_SSDW);
            dl.add(oldData);
        }
        //判断是否第三次反馈
        Data numData = new Data();
        if("3".equals(NUM)){
            numData = handler.getSmallTypeData(conn, AttConstants.AR_TXFK);
            dl.add(numData);
        }
        return dl;
    }
    /**接口，只安置后报告
     * 安置后报告-一般，中文附件，去掉照片上传
     * @Title: attTypeNormalCN
     * @Description: 获取附件类型list
     * @author: xugy
     * @date: 2014-10-20下午4:04:25
     * @param conn
     * @param birthdayYear
     * @param NUM
     * @return
     * @throws DBException
     */
    public DataList attTypeNormalCN(Connection conn, String birthdayYear, String NUM) throws DBException{
        DataList dl = new DataList();
        dl = attTypeNormal(conn, birthdayYear, NUM);
        if(dl.size()>0){
            for(int i=0;i<dl.size();i++){
                String CODE = dl.getData(i).getString("CODE");
                if((AttConstants.AR_IMAGE).equals(CODE)){
                    dl.remove(dl.getData(i));
                }
            }
        }
        return dl;
    }
    /**接口，只安置后报告
     * 安置后报告-更换家庭
     * @Title: attTypeChangeFamily
     * @Description: 获取附件类型list
     * @author: xugy
     * @date: 2014-10-20下午4:08:22
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList attTypeChangeFamily(Connection conn) throws DBException{
        DataList dl = new DataList();
        dl = bm.getAttType(conn, AttConstants.AR_CHANGE_FAMILY);
        return dl;
    }
    /**接口，只安置后报告
     * 安置后报告-死亡
     * @Title: attTypeDead
     * @Description: 获取附件类型list
     * @author: xugy
     * @date: 2014-10-20下午4:09:35
     * @param conn
     * @return
     * @throws DBException
     */
    public DataList attTypeDead(Connection conn) throws DBException{
        DataList dl = new DataList();
        dl = bm.getAttType(conn, AttConstants.AR_DEAD);
        return dl;
    }

}
