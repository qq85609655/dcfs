/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import hx.ajax.AjaxExecute;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.databean.DataList;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.UtilDateTime;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;
/**
 * @Title: MessageAjax.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-3-2 下午06:15:46
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MessageAjax extends AjaxExecute{
    
    private static Log log = UtilLog.getLog(MessageServlet.class);
    
    private static MessageHandler messageHandler=new MessageHandler();

    @Override
    public boolean run(HttpServletRequest request) {
        String method = ServletTools.getParameter("method", request, "");
        if("huizhi".equals(method)){
            this.setReturnValue(getBooleanXml(Huizhi(request)));
            return true;
        }else if("qingkong".equals(method)){
            this.setReturnValue(getBooleanXml(Qingkong(request)));
            return true;
        }else if("addbox".equals(method)){
            try {
                this.setReturnValue(Addbox(request).toXmlString());
                return true;
            } catch (IOException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }else if("shanchubox".equals(method)){
            this.setReturnValue(getBooleanXml(Shanchubox(request)));
            return true;
        }else if("changeboxname".equals(method)){
            this.setReturnValue(getBooleanXml(Changeboxname(request)));
            return true;
        }
        return false;
    }

    /**
     * 重命名文件夹
     * @param request
     * @return
     */
    private boolean Changeboxname(HttpServletRequest request) {
        Connection conn=null;
        boolean result=false;
        try {
            String boxuuid=request.getParameter("boxuuid");
            String fileName=request.getParameter("fileName1");
            if(fileName!=null){
                fileName=URLDecoder.decode(fileName,"UTF-8");
            }
            conn = ConnectionManager.getConnection();
            messageHandler.Changeboxname(conn,boxuuid,fileName);
            result=true;
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("重命名文件夹异常:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            if (log.isError()) {
                log.logError("重命名文件夹异常:" + e.getMessage());
            }
            e.printStackTrace();
        }finally{
            try{
                if(conn!=null&&!conn.isClosed()){
                    conn.close();
                }
            }catch(Exception e){
                if (log.isError()) {
                    log.logError("重命名文件夹数据库连接关闭异常:" + e.getMessage());
                }
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 删除文件夹
     * @param request
     * @return
     */
    private boolean Shanchubox(HttpServletRequest request) {
        Connection conn=null;
        boolean result=false;
        try {
            UserInfo userInfo=SessionInfo.getCurUser();
            String person=userInfo.getPerson().getPersonId();
            String boxuuid=request.getParameter("boxuuid");
            conn = ConnectionManager.getConnection();
            messageHandler.getDeleteBoxMessages(conn,person,boxuuid);
            messageHandler.Shanchubox(conn,boxuuid);
            result=true;
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("删除文件夹异常:" + e.getMessage());
            }
            e.printStackTrace();
        }finally{
            try{
                if(conn!=null&&!conn.isClosed()){
                    conn.close();
                }
            }catch(Exception e){
                if (log.isError()) {
                    log.logError("删除文件夹数据库连接关闭异常:" + e.getMessage());
                }
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 创建文件夹
     * @param request
     * @return
     */
    private Data Addbox(HttpServletRequest request) {
        Connection conn=null;
        DataList dataMsg=new DataList();
        Data data=new Data();
        try {
            UserInfo userInfo=SessionInfo.getCurUser();
            String person=userInfo.getPerson().getPersonId();
            String fileName=request.getParameter("fileName");
            if(fileName!=null){
                fileName=URLDecoder.decode(fileName,"UTF-8");
            }
            conn = ConnectionManager.getConnection();
            dataMsg = messageHandler.getBox(conn,person,fileName);
            if(dataMsg.size()<=0){
                data=new Data(conn,"T_MESSAGEBOX");
                data.setPrimaryKey("UUID");
                data.addData("NAME",fileName );
                data.addData("PERSONID", person);
                data.addData("CREATEDTIME", UtilDateTime.nowDateTimeString());
                data.create();
              }
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("创建文件夹异常:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            if (log.isError()) {
                log.logError("创建文件夹异常:" + e.getMessage());
            }
            e.printStackTrace();
        }finally{
            try{
                if(conn!=null&&!conn.isClosed()){
                    conn.close();
                }
            }catch(Exception e){
                if (log.isError()) {
                    log.logError("创建文件夹数据库连接关闭异常:" + e.getMessage());
                }
                e.printStackTrace();
            }
        }
        return data;
    }

    /**
     * 清空文件夹
     * @param request
     * @return 
     */
    private boolean Qingkong(HttpServletRequest request) {
        Connection conn=null;
        DataList dataMsg=new DataList();
        boolean result=false;
        try {
            UserInfo userInfo=SessionInfo.getCurUser();
            String person=userInfo.getPerson().getPersonId();
            String boxuuid=request.getParameter("boxuuid");
            conn = ConnectionManager.getConnection();
            if(boxuuid.equals(OAConstants.LJX))
            {
            dataMsg = messageHandler.PdlajMessages(conn,person,boxuuid);
            for(int i=0;i<dataMsg.size();i++)
            {
            Data data=dataMsg.getData(i);
            
            if(data.getString("SL","").equals("0"))
            {
               //获得附件路径
              String date=hx.util.DateUtility.getStrDate(new Long(DateUtility.getLongDate(data.getString("MESSAGETIME"), 1)), 0).replaceAll("-", "");
              StringBuffer sb=new StringBuffer();
              sb.append(MessageConfig.getRootDir())
                .append(MessageConfig.getRootDirMessage())
                .append("/")
                .append(date)
                .append("/")
                .append(data.getString("MESSAGEUUID",""));
            String URL=sb.toString();  
            removeFile(URL);
            }   
            }
            messageHandler.getDeleteMessages(conn,person,boxuuid);
            result=true;
            }else
            {
            messageHandler.getDeleteBoxMessages(conn,person,boxuuid);   
            result=true;
            }
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("清空文件夹异常:" + e.getMessage());
            }
            e.printStackTrace();
        }finally{
            try{
                if(conn!=null&&!conn.isClosed()){
                    conn.close();
                }
            }catch(Exception e){
                if (log.isError()) {
                    log.logError("清空文件夹数据库连接关闭异常:" + e.getMessage());
                }
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 回执邮件
     * @param request
     * @return
     */
    private boolean Huizhi(HttpServletRequest request) {
        String uuid=request.getParameter("uuid");
        Connection conn=null;
        boolean result=false;
        try {
            conn = ConnectionManager.getConnection();
            messageHandler.HuizhiMessage(conn,uuid);
            messageHandler.HuizhiFjxMessage(conn,uuid);
            result=true;
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("数据库异常:" + e.getMessage());
            }
            e.printStackTrace();
        }finally{
            try{
                if(conn!=null&&!conn.isClosed()){
                    conn.close();
                }
            }catch(Exception e){
                if (log.isError()) {
                    log.logError("读取邮件正文异常:" + e.getMessage());
                }
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 删除文件、文件夹
     * 
     * @param path
     * 需要删除的文件|文件夹
     */
    public void removeFile(String path){
             this.removeFile(new File(path));
    }

    public void removeFile(File path){
        if (path.isDirectory()){
            File[] child = path.listFiles();
            if (child != null && child.length != 0){
                for (int i = 0; i < child.length; i++){
                    removeFile(child[i]);
                    child[i].delete();
                }
            }
        }
        path.delete();
    }
    
}
