/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.common.j2ee.servlet.BaseServlet;
import hx.common.j2ee.servlet.ServletTools;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.database.manager.ConnectionManager;
import hx.log.Log;
import hx.log.UtilLog;
import hx.util.DateUtility;
import hx.util.FileUtility;
import hx.util.UUIDGenerator;
import hx.util.UtilDateTime;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.hx.framework.authenticate.SessionInfo;
import com.hx.framework.authenticate.UserInfo;

/**
 * @Title: MessageAction.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-2-25 ����10:08:36
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MessageServlet extends BaseServlet{
    
    private static Log log = UtilLog.getLog(MessageServlet.class);
    
    private static MessageHandler messageHandler=new MessageHandler();
    
    @Override
    protected void execute(HttpServletRequest request, HttpServletResponse response) {
        String method=request.getParameter("method");
        try {
        if ("publicmail".equals(method))
        {   
            publicmail(request);
            String boxuuid=request.getParameter("boxuuid");
            if(boxuuid==null){
                boxuuid="";
            }
            forward(request, response, "/jsp/message/PublicMail.jsp?dbIndex=newMessage&boxuuid="+boxuuid);
        }else if("floder".equals(method)){
            floder(request);
            forward(request, response, "/jsp/message/Floder.jsp?dbIndex=newMessage");
        }else if("floderhome".equals(method)){
            floder(request);
            forward(request, response, "/jsp/message/floderHome.jsp?dbIndex=newMessage");
        }else if("receivemessage".equals(method)){
            receivemessage(request);
            forward(request, response, "/jsp/message/Messagelb.jsp");
        }else if("pagemessage".equals(method)){  //ҳ����ʾվ����Ϣ
            pagemessage(request);
            forward(request, response, "/jsp/message/pagemessage.jsp");
        }else if("tiaozhuan".equals(method)){
            tiaozhuan(request);
            forward(request, response, "/jsp/message/NewMail.jsp");
        }else if("xzpersontree".equals(method)){
            xzpersontree(request);
            forward(request, response, "/resources/tree/select.jsp");
        }else if("sendmessage".equals(method)){
            sendmessage(request,response);
            if(!response.isCommitted()){
                forward(request, response, "/jsp/message/NewMail.jsp");
            }
        }else if("readmessage".equals(method)){
            readmessage(request);
            forward(request, response, "/jsp/message/MessageRead.jsp");   
        }else if("hzdetail".equals(method)){
            hzdetail(request);
            forward(request, response, "/jsp/message/HzDetail.jsp");
        }else if("huifu".equals(method)){
            Huifu(request);
            forward(request, response, "/jsp/message/NewMail.jsp");
        }else if("xidongxj".equals(method)){
            String boxuuid=ServletTools.getParameter("boxuuid", request, "");
            String[] uuid=ServletTools.getParameterValues("uuidbox", request);
            Xidongxj(request,uuid);
            forward(request, response, "/MessageServlet?method=receivemessage&boxuuid="+boxuuid); 
        }else if("gbbox".equals(method)){
            String boxuuid=ServletTools.getParameter("boxuuid", request, "");
            String[] uuid=ServletTools.getParameterValues("uuidbox", request);
            Gbbox(request,boxuuid,uuid);
            forward(request, response, "/MessageServlet?method=receivemessage&boxuuid="+boxuuid);  
        }else if("showbox".equals(method)){
            Showbox(request);
            forward(request, response, "/jsp/message/Addbox.jsp");
        }
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
   
    /**
     * �ļ��й���
     * @param request
     */
    private void Showbox(HttpServletRequest request) {
        Connection conn = null;
        DataList dataMsg=new DataList();
        DataList dataMsg1=new DataList();
        try {
            UserInfo userInfo=SessionInfo.getCurUser();
            String person=userInfo.getPerson().getPersonId();
            String boxuuid="";
            conn = ConnectionManager.getConnection();
            dataMsg=messageHandler.getMessageNum(conn,person);
            for(int i=0;i<dataMsg.size();i++)
            {
             Data data1=new Data();
             Data data=dataMsg.getData(i);
             if(!data.getString("UUID","").equals(boxuuid))
             {
             data1.addData("NAME", data.getString("NAME",""));
             data1.addData("UUID", data.getString("UUID",""));
             if(data.getString("READSTATE","").equals(OAConstants.SFYD_NO))
             {
             data1.addData("WYDNUM",data.getString("NUM",""));   
             }else
             {
             data1.addData("YYDNUM",data.getString("NUM",""));   
             }
             boxuuid=data.getString("UUID","");
             dataMsg1.add(data1);
            }else
            {
             Data data2=dataMsg1.getData(i-1); 
            if(data.getString("READSTATE","").equals(OAConstants.SFYD_NO))
             {
             data2.addData("WYDNUM",data.getString("NUM",""));   
             }else
             {
             data2.addData("YYDNUM",data.getString("NUM",""));   
             }
            dataMsg1.remove(i-1);
            dataMsg1.add(data2);
            }
            }
            request.setAttribute("dataMsg",dataMsg1);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�ļ��й���ʧ��:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }    
    }

    /**
     * ɾ���ʼ�
     * @param request
     * @param boxuuid 
     * @param uuid 
     */
    private void Gbbox(HttpServletRequest request, String boxuuid, String[] uuid) {
        Connection conn = null;
        DataList dataMsg=new DataList();
        try {
            UserInfo userInfo=SessionInfo.getCurUser();
            String person=userInfo.getPerson().getPersonId();
            conn = ConnectionManager.getConnection();
            if(!boxuuid.equals(OAConstants.LJX))
            {
            for(int i=0;i<uuid.length;i++)
            {   
            Data data = new Data(conn,"T_MESSAGE");
            data.addData("UUID",uuid[i]);
            data.setPrimaryKey("UUID");
            data.addData("BOXUUID",OAConstants.LJX);
            dataMsg.add(data);
            }
            messageHandler.Gbbox(conn,dataMsg);
            }else
           {
            dataMsg=messageHandler.PdlajUuidMessages(conn,person,boxuuid,uuid);
            for(int i=0;i<uuid.length;i++)
            {
            for(int j=0;j<dataMsg.size();j++)
            {
            Data data=dataMsg.getData(j);
            if(data.getString("UUID","").equals(uuid[i])&&data.getString("SL","").equals("0"))
            {
             //��ø���·��
                 String date=DateUtility.getStrDate(DateUtility.getLongDate(data.getString("MESSAGETIME"), 1), 0).replaceAll("-", "");
                 StringBuffer sb=new StringBuffer();
                 sb.append(MessageConfig.getRootDir())
                .append(MessageConfig.getRootDirMessage())
                .append("/")
                .append(date)
                .append("/")
                .append(data.getString("MESSAGEUUID",""));
            String URL=sb.toString();  
            messageHandler.removeFile(URL);
            }   
            }
            messageHandler.getDeleteMessage(conn,uuid[i]);
            }   
            }
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("ɾ���ʼ�ʧ��:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }    
    }

    /**
     * �ƶ��ʼ�
     * @param request
     * @param uuid 
     */
    private void Xidongxj(HttpServletRequest request, String[] uuid) {
        Connection conn = null;
        String boxuuid=ServletTools.getParameter("zcwjj", request, "");
        DataList dataMsg=new DataList();
        try {
            conn = ConnectionManager.getConnection();
            for(int i=0;i<uuid.length;i++)
            {   
            Data data = new Data(conn,"T_MESSAGE");
            data.addData("UUID",uuid[i]);
            data.setPrimaryKey("UUID");
            data.addData("BOXUUID",boxuuid);
            dataMsg.add(data);
            }
            messageHandler.Xidongxj(conn,dataMsg);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�ƶ��ʼ�ʧ��:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }   
    }

    /**
     * �ظ��ʼ�
     * @param request
     */
    private void Huifu(HttpServletRequest request) {
        Connection conn = null;
        String uuid=ServletTools.getParameter("uuid", request, "");
        String boxuuid=ServletTools.getParameter("boxuuid", request, "");
        UserInfo userInfo=SessionInfo.getCurUser();
        String person=userInfo.getPerson().getPersonId();
        String name=userInfo.getPerson().getcName();
        DataList dataMsg=new DataList();
        Data data=new Data();
        try {
            conn = ConnectionManager.getConnection();
            dataMsg=messageHandler.readMessage(conn,uuid);
            for(int i=0;i<dataMsg.size();i++)
            {
            data=dataMsg.getData(i);    
            }
            String Content=messageHandler.ReadContent(request,data.getString("MESSAGEUUID",""),DateUtility.getLongDate(data.getString("MESSAGETIME"), 1));
            data.addData("CONTENT", Content);
            String fjr=data.getString("SENDER","");
            data.remove("SENDER");
            data.remove("RECEIVER");
            data.addData("SENDER", fjr);
            data.addData("RECEIVER", fjr);
            request.setAttribute("data", data);
            request.setAttribute("boxuuid", boxuuid);
            request.setAttribute("name", name);
            request.setAttribute("fjr", person);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�ظ��ʼ�ʧ��:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (JDOMException e) {
            if (log.isError()) {
                log.logError("�ظ��ʼ��鿴�ʼ�����ʧ��:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (IOException e) {
            if (log.isError()) {
                log.logError("�ظ��ʼ��鿴�ʼ�����ʧ��:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }   
    }

    /**
     * 
     * @param request
     */
    private void hzdetail(HttpServletRequest request) {
        Connection conn = null;
        String uuid=request.getParameter("uuid");
        DataList dataMsg=new DataList();
        try {
            conn = ConnectionManager.getConnection();
            dataMsg=messageHandler.getHzdetailSql(conn,uuid);
            request.setAttribute("dataMsg", dataMsg);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("���һ�ִ����ʧ��:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * ��ȡ�ʼ�
     * @param request
     */
    private void readmessage(HttpServletRequest request) {
        Connection conn = null;
        String uuid=ServletTools.getParameter("uuid", request, "");
        String boxuuid=ServletTools.getParameter("boxuuid", request, "");
        DataList dataMsg=new DataList();
        Data data=new Data();
        try {
            conn = ConnectionManager.getConnection();
            dataMsg=messageHandler.readMessage(conn,uuid);
            for(int i=0;i<dataMsg.size();i++)
            {
            data=dataMsg.getData(i);    
            }   
            Data data1 = new Data(conn,"T_MESSAGE");
            data1.addData("UUID",data.getString("UUID",""));
            data1.setPrimaryKey("UUID");
            data1.addData("READSTATE",OAConstants.SFYD_YES);
            data1.store();
            String Content=messageHandler.ReadContent(request,data.getString("MESSAGEUUID",""),DateUtility.getLongDate(data.getString("MESSAGETIME"), 1));
            data.addData("CONTENT", Content);
          //��ø�������
            String date=DateUtility.getStrDate(DateUtility.getLongDate(data.getString("MESSAGETIME"), 1), 0).replaceAll("-", "");
            StringBuffer sb=new StringBuffer();
            sb.append(MessageConfig.getRootDir())
              .append(MessageConfig.getRootDirMessage())
              .append("/")
              .append(date)
              .append("/")
              .append(data.getString("MESSAGEUUID",""));
          String url=sb.toString();
          DataList dataMsg1=messageHandler.getContentUrl(url,data.getString("MESSAGEUUID",""),sb.toString());
          request.setAttribute("data", data);
          request.setAttribute("dataMsg",dataMsg1);
          request.setAttribute("boxuuid",boxuuid);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (JDOMException e) {
            if (log.isError()) {
                log.logError("��ȡ�ʼ������쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (IOException e) {
            if (log.isError()) {
                log.logError("��ȡ�ʼ������쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * ��ת������Ϣ��ҳ��
     * @param request 
     * @return
     */
    public void publicmail(HttpServletRequest request){
        request.setAttribute("dbIndex", "newMessage");
    }
    
    /**
     * ����Ϣ�б�״̬ҳ��
     * @param request 
     * @return
     */
    public void floder(HttpServletRequest request){
        Connection conn = null;
        DataList dataMsg=new DataList();
        DataList dataMsg1=new DataList();
        DataList dataMsg2=new DataList();
        UserInfo userInfo=SessionInfo.getCurUser();
        String person=userInfo.getPerson().getPersonId();
        String boxuuid="";
        String newxxs="";
        try {
            conn = ConnectionManager.getConnection();
            dataMsg=messageHandler.getMessageNum(conn,person);
            dataMsg2=messageHandler.getMessages(conn,person,OAConstants.NEWXX);
            newxxs=String.valueOf(dataMsg2.size()); 
            for(int i=0;i<dataMsg.size();i++)
            {
             Data data1=new Data();
             Data data=dataMsg.getData(i);
             if(!data.getString("UUID","").equals(boxuuid))
             {
             data1.addData("NAME", data.getString("NAME",""));
             data1.addData("UUID", data.getString("UUID",""));
             if(data.getString("READSTATE","").equals(OAConstants.SFYD_NO))
             {
             data1.addData("WYDNUM",data.getString("NUM",""));   
             }else
             {
             data1.addData("YYDNUM",data.getString("NUM",""));   
             }
             boxuuid=data.getString("UUID","");
             dataMsg1.add(data1);
            }else
            {
             Data data2=dataMsg1.getData(i-1); 
            if(data.getString("READSTATE","").equals(OAConstants.SFYD_NO))
             {
             data2.addData("WYDNUM",data.getString("NUM",""));   
             }else
             {
             data2.addData("YYDNUM",data.getString("NUM",""));   
             }
            dataMsg1.remove(i-1);
            dataMsg1.add(data2);
            }
            }
            //�õ��ʼ��������ļ���
            DataList flodermsg=messageHandler.getAllFlodData(conn);
            //�õ����������������ʼ���
            Map mailnummap=new HashMap();
            Data maildata=new Data();
            maildata.setEntityName("T_MAIL");
            maildata.setConnection(conn);
            DataList mailmsg=new DataList();
            mailmsg.addAll(maildata.find());
            for(int i=0;i<mailmsg.size();i++){
                Data temdata=mailmsg.getData(i);
                
                //������
                String floderuuid=temdata.getString("FOLDERUUID","");
                if(mailnummap.get(floderuuid)==null){
                    mailnummap.put(floderuuid,"1");
                }
                else{
                    int pval=new Integer((String)mailnummap.get(floderuuid)).intValue();
                    pval++;
                    mailnummap.put(floderuuid,new Integer(pval).toString());
                }
                
                //δ�Ķ��ʼ�
                String readstate = temdata.getString("READSTATE","");
                if(readstate.equals(OAConstants.SFYD_NO)&&!floderuuid.equals(OAConstants.LJX)){
                     if(mailnummap.get("news")==null){
                         mailnummap.put("news","1");  
                     }else{
                         mailnummap.put("news",new Integer(new Integer((String)mailnummap.get("news")).intValue()+1).toString());
                     }
                }
            }
            request.setAttribute("mailnummap",mailnummap);
            request.setAttribute("newxxs",newxxs);
            request.setAttribute("dataMsg",dataMsg1);
            request.setAttribute("flodermsg",flodermsg);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * ��ȡ�ļ�����Ϣ
     * @param request 
     */
    public void receivemessage(HttpServletRequest request){
        Connection conn = null;
        // ���÷�ҳ
        int page=Integer.valueOf(ServletTools.getParameter("page", request, "1"));
        int pageSize=Integer.valueOf(ServletTools.getParameter("pageSize", request, String.valueOf(hx.common.Constants.DEFAULT_PAGESIZE)));
        DataList dataMsg=new DataList();
        DataList dataMsg1=new DataList();
        UserInfo userInfo=SessionInfo.getCurUser();
        String fjr=userInfo.getPerson().getPersonId();
        String boxuuid=request.getParameter("boxuuid");
        String boxname="";
        try {
            conn = ConnectionManager.getConnection();
            if(!boxuuid.equals(OAConstants.NEWXX))
            {
                Data data = new Data(conn,"T_MESSAGEBOX");
                data.setPrimaryKey("UUID");
                data.addData("UUID",boxuuid);
                DataList dataList=data.find();
                if(dataList!=null&&dataList.size()>=1){
                  boxname= dataList.getData(0).getString("NAME","");
                 }
            }else
            {
                boxname="����Ϣ";  
            } 
            dataMsg=messageHandler.getReceiveMessage(conn,pageSize,page,boxuuid,fjr);
            dataMsg1=messageHandler.getFindBox(conn,fjr,"0");
            request.setAttribute("yddataMsg", dataMsg1);
            request.setAttribute("dataMsg", dataMsg);
            request.setAttribute("boxuuid", boxuuid);
            request.setAttribute("boxname", boxname);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * ��ҳ����վ����Ϣ
     * @param request 
     */
    public void pagemessage(HttpServletRequest request){
        Connection conn = null;
        // ���÷�ҳ
        int page=Integer.valueOf(ServletTools.getParameter("page", request, "1"));
        int pageSize=Integer.valueOf(ServletTools.getParameter("pageSize", request, String.valueOf(hx.common.Constants.DEFAULT_PAGESIZE)));
        DataList dataMsg=new DataList();
        DataList dataMsg1=new DataList();
        UserInfo userInfo=SessionInfo.getCurUser();
        String fjr=userInfo.getPerson().getPersonId();
        String boxuuid=request.getParameter("boxuuid");
        String boxname="";
        try {
            conn = ConnectionManager.getConnection();
            //UserInfo userInfo=(UserInfo)SessionInfo.getCurUser();
            IDataExecute ide  = DataBaseFactory.getDataBase(conn);
      
                Data data = new Data();
                data.setEntityName("T_MESSAGE"); 
                data.addData("MESSAGEHOLDER", fjr);
                data.addData("READSTATE", "0");
                data.addData("BOXUUID", "box_accept");
                //data.addData("UUID",boxuuid);
                DataList dataList=ide.find(data);
                 
            dataMsg=messageHandler.getReceiveMessage(conn,pageSize,page,boxuuid,fjr);
            dataMsg1=messageHandler.getFindBox(conn,fjr,"0");
            request.setAttribute("yddataMsg", dataMsg1);
            request.setAttribute("dataMsg", dataMsg);
            request.setAttribute("boxuuid", boxuuid);
            request.setAttribute("boxname", boxname);
            request.setAttribute("dataList",dataList);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * ����Ϣ����ǰ����ת
     * @param request 
     */
    public void tiaozhuan(HttpServletRequest request){
        String boxuuid=ServletTools.getParameter("boxuuid", request, "");
        UserInfo userInfo=SessionInfo.getCurUser();
        String fjr=userInfo.getPerson().getPersonId();
        String name=userInfo.getPerson().getcName();
        request.setAttribute("name", name);
        request.setAttribute("fjr", fjr);
        request.setAttribute("boxuuid", boxuuid);
    }
    
    /**
     * ��תѡ����Աҳ��
     * @param request 
     */
    public void xzpersontree(HttpServletRequest request){
        CodeList codeList=new CodeList();
        Connection conn = null;
        try {
            conn = ConnectionManager.getConnection();
            codeList=messageHandler.getperson(conn);
            request.setAttribute("codeList", codeList);
            request.setAttribute("title", "ѡ����Ա");
            request.setAttribute("showParent", "fasle");
            request.setAttribute("values", "");
            request.setAttribute("type", "3");
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (Throwable e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    if (!conn.isClosed()) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    if (log.isError()) {
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }
    }
    
    /**
     * 
     * @param request 
     * @param response 
     * @throws IOException 
     * @throws ServletException 
     */
    public void sendmessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        Connection conn = null;
        //�����ϴ�request
        processingRequest(request);
        MultiPartRequest parser = (MultiPartRequest) request.getAttribute("MultiPartRequest_Parser");
        if(parser==null){
            sendRedirect(request, response, "/jsp/mail/NewMail.jsp?sendjg=big");
            return;
        }
        String fileNum=request.getParameter("fileNum");
        String boxuuid=parser.getParameter("boxuuid");
        if(boxuuid==null){
            boxuuid="";
        }
        String contenthtml=parser.getParameter("contenthtml");
        if(contenthtml==null){
            contenthtml="";
        }
        String contenttxt=parser.getParameter("contenttxt");
        if(contenttxt==null){
            contenttxt="";
        }
        int num=Integer.parseInt(fileNum);
        UserInfo userInfo=SessionInfo.getCurUser();
        String fjr=userInfo.getPerson().getPersonId();
        String name=userInfo.getPerson().getcName();
        String reloadleftframe="";
        String sendsuccess="false";
        try {
            conn = ConnectionManager.getConnection();
            Calendar c = Calendar.getInstance();
            SimpleDateFormat simpleDateTimeFormat  =   new  SimpleDateFormat( "yyyyMMdd" );
            c=Calendar.getInstance(Locale.CHINESE);
            Map mailmap=getRequestDataWithPrefix(request, "newmsg_", true,true);
            String HZ=parser.getParameter("HZ");
            if(HZ==null){
                HZ="";
            }
            String HZ1=parser.getParameter("HZ1");//�������ͱ�ʶ
            if(HZ1==null){
                HZ1="";
            }
          //��ȡ���ռ�������
            List usernameList=new ArrayList();
            String receiver=(String)mailmap.get("receiver");
            mailmap.remove("receiver");
            mailmap.remove("receiver_email");
            MessageService messageService=new MessageService();
            usernameList=messageService.getUser(receiver,";");
            StringBuffer sbname=new StringBuffer();
            //��ʽ���ռ�������
            for(int i=0;i<usernameList.size();i++){
                sbname.append(usernameList.get(i).toString());
                if(i!=usernameList.size()-1){
                    sbname.append(";");
                }
            }
          //��ȡ���ռ���(uuid)
            List useruuidList=new ArrayList();
            String personuuid=(String)mailmap.get("receiver_personuuid");
            mailmap.remove("receiver_personuuid");
            useruuidList=messageService.getUser(personuuid,hx.common.Constants.COMMON_DISTANCE_KEY);
            if(useruuidList.contains(fjr))
            {
                reloadleftframe="true";
            }
          //��ȡ������������
            List secretnameList=new ArrayList();
            String secretname=(String)mailmap.get("secret");
            mailmap.remove("secret");
            //��ʽ������������
            if(secretname!=null&&!"".equals(secretname))
            {
            secretnameList=messageService.getUser(secretname,";");
            StringBuffer sename=new StringBuffer();
            for(int i=0;i<secretnameList.size();i++){
                sename.append(secretnameList.get(i).toString());
                if(i!=secretnameList.size()-1){
                    sename.append(";");
                }
            }
            }
          //��ȡ��������uuid
            List secretuuidList=new ArrayList();
            String secretuuid=(String)mailmap.get("secret_personuuid");
            mailmap.remove("secret_personuuid");
            mailmap.remove("secret_email");
            //��ʽ��������uuid
            if(secretuuid!=null&&!"".equals(secretuuid)) 
            {
            secretuuidList=messageService.getUser(secretuuid,hx.common.Constants.COMMON_DISTANCE_KEY);
            }
            //ȡ������������uuid
            List copyuseruuidList=new ArrayList();
            String copyforeruuid=(String)mailmap.get("copyforer_personuuid");
            if(copyforeruuid!=null&&!"".equals(copyforeruuid))
            {
            mailmap.remove("copyforer_personuuid");
            mailmap.remove("copyforer_email");
            copyuseruuidList=messageService.getUser(copyforeruuid,hx.common.Constants.COMMON_DISTANCE_KEY);
            }
            //ȡ������������
            List copyusernameList=new ArrayList();
            StringBuffer spname=new StringBuffer();
            String copyforername=(String)mailmap.get("copyforer");
            if(copyforername!=null&&!"".equals(copyforername))
            {
            mailmap.remove("copyforer");
            copyusernameList=messageService.getUser(copyforername,";");
            //��ʽ������������
            for(int i=0;i<copyusernameList.size();i++){
                spname.append(copyusernameList.get(i).toString());
                if(i!=copyusernameList.size()-1){
                    spname.append(";");
                }
            }
            }
            if(num>1)
            {
            mailmap.put("ACCESSORY",OAConstants.SFYFJ_YES);   
            }else
            {
            mailmap.put("ACCESSORY",OAConstants.SFYFJ_NO);    
            }
            mailmap.put("READSTATE",OAConstants.SFHZ_YES);
            mailmap.put("MESSAGETIME",UtilDateTime.nowDateTimeString());
            if(useruuidList.size()==1)
            {
            if(HZ.equals("1"))
            {   
            mailmap.put("RECEIPT",OAConstants.SFHZ_YES);
            }else
            {
            mailmap.put("RECEIPT",OAConstants.SFHZ_NO);   
            }
            }else
            {
            if(HZ.equals("1"))
            {
            mailmap.put("RECEIPT",OAConstants.SFHZ_DT);   //���˻�ִ  
            }else
            {
            mailmap.put("RECEIPT",OAConstants.SFHZ_NO);   
            }
            }
            mailmap.put("COPYFORER", spname.toString());
            mailmap.put("RECEIVER", sbname.toString());
            mailmap.put("RECEIVERUUID",fjr);
            mailmap.put("BOXUUID",OAConstants.FJX);
            mailmap.put("MESSAGEHOLDER",fjr);
            mailmap.remove("sender");
            mailmap.put("SENDER", name);
            mailmap.remove("content");
            String uuid=UUIDGenerator.getUUID();
            Data data = new Data(conn,"T_MESSAGE");
            data.setPrimaryKey("UUID");
            data.addData("UUID",uuid);
            data.addData("MESSAGEUUID",uuid);
            data.addData(mailmap);
            data.create();
            String url=MessageConfig.getRootDir()+
            MessageConfig.getRootDirMessage()+"/"+simpleDateTimeFormat.format(c.getTime())+"/"+data.getString("UUID","");
            FileUtility.pathCheck(FileUtility.pathProcess(url));
            for(int i=1;i<num;i++)
            {
            String fileName=((MultiPartRequest)request.getAttribute("MultiPartRequest_Parser")).getFileName("fileinput"+i);;
            if(fileName!=null){
                String fileurl=url+"/"+fileName;
                boolean flag=UploadBase.saveFileTo(request,"fileinput"+i,fileurl);
            }
            }   
            messageHandler.SaveMessage(contenthtml,contenttxt,url,data.getString("UUID",""));
            DataList dataMsg = new DataList();
            for(int i=0;i<secretuuidList.size();i++)
            {
            Data dataSe=new Data(conn,"T_MESSAGE");
            dataSe.setPrimaryKey("UUID");
            if(!copyuseruuidList.contains(secretuuidList.get(i).toString())&&!useruuidList.contains(secretuuidList.get(i).toString()))
            {
            if(HZ1.equals("1"))
            {
            mailmap.remove("RECEIVER");
            mailmap.put("RECEIVER", secretnameList.get(i).toString());
            mailmap.remove("COPYFORER");
            }
            mailmap.remove("MESSAGEHOLDER");
            mailmap.put("MESSAGEHOLDER", secretuuidList.get(i).toString());
            mailmap.put("MESSAGEUUID", data.getString("UUID",""));
            mailmap.remove("BOXUUID");
            mailmap.put("BOXUUID", OAConstants.SJX);
            mailmap.remove("RECEIPT");
            if(HZ.equals("1"))
            {   
            mailmap.put("RECEIPT",OAConstants.SFHZ_YES);
            }else
            {
            mailmap.put("RECEIPT",OAConstants.SFHZ_NO);   
            }
            mailmap.put("RECEIPTSTATE", OAConstants.HZZT_NO);
            mailmap.remove("READSTATE");
            mailmap.put("READSTATE", OAConstants.SFYD_NO);
            mailmap.put("RECEIVERUUID",fjr);
            dataSe.setData(mailmap);
            dataMsg.add(dataSe);   
            }
            }
            for(int i=0;i<useruuidList.size();i++)
            {
            Data dataLj=new Data(conn,"T_MESSAGE");
            dataLj.setPrimaryKey("UUID");
            mailmap.remove("RECEIVER");
            if(HZ1.equals("1"))
            {
            mailmap.put("RECEIVER", usernameList.get(i).toString());
            mailmap.remove("COPYFORER");
            if(copyuseruuidList.contains(useruuidList.get(i).toString()))
            {
            mailmap.put("COPYFORER", usernameList.get(i).toString());
            }else
            {
            mailmap.put("COPYFORER", "");   
            }
            }else
            {
            mailmap.put("RECEIVER",sbname.toString());
            }
            mailmap.put("RECEIVERUUID",fjr);
            mailmap.put("RECEIPTSTATE", OAConstants.HZZT_NO);
            mailmap.remove("BOXUUID");
            mailmap.put("BOXUUID", OAConstants.SJX);
            mailmap.remove("READSTATE");
            mailmap.put("READSTATE", OAConstants.SFYD_NO);
            mailmap.remove("RECEIPT");
            mailmap.put("MESSAGEUUID", data.getString("UUID",""));
            mailmap.remove("MESSAGEHOLDER");
            mailmap.put("MESSAGEHOLDER",useruuidList.get(i).toString());
            if(HZ.equals("1"))
            {   
            mailmap.put("RECEIPT","1");
            }else
            {
            mailmap.put("RECEIPT","0"); 
            }
            dataLj.setData(mailmap);
            dataMsg.add(dataLj);
            }
            if(copyuseruuidList!=null)
            {
            for(int i=0;i<copyuseruuidList.size();i++)
            {
            if(!useruuidList.contains(copyuseruuidList.get(i).toString()))
            {
            Data dataLj=new Data(conn,"T_MESSAGE");
            dataLj.setPrimaryKey("UUID");
            mailmap.remove("RECEIVER");
            if(HZ1.equals("1"))
            {
            mailmap.put("RECEIVER", copyusernameList.get(i).toString());
            }else
            {
            mailmap.put("RECEIVER",sbname.toString());
            }
            mailmap.put("RECEIVERUUID",fjr);
            mailmap.put("RECEIPTSTATE", OAConstants.HZZT_NO);
            mailmap.remove("COPYFORER");
            mailmap.put("COPYFORER",copyusernameList.get(i).toString());
            mailmap.remove("BOXUUID");
            mailmap.put("BOXUUID", OAConstants.SJX);
            mailmap.remove("READSTATE");
            mailmap.put("READSTATE", OAConstants.SFYD_NO);
            mailmap.remove("RECEIPT");
            mailmap.put("MESSAGEUUID", data.getString("UUID",""));
            mailmap.remove("MESSAGEHOLDER");
            mailmap.put("MESSAGEHOLDER",copyuseruuidList.get(i).toString());
            if(HZ.equals("1"))
            {   
            mailmap.put("RECEIPT","1");
            }else
            {
            mailmap.put("RECEIPT","0"); 
            }
            dataLj.setData(mailmap);
            dataMsg.add(dataLj);
            }
            }
            }
            messageHandler.saveMessage(conn,dataMsg);
            sendsuccess="true";
            request.setAttribute("name", name);
            request.setAttribute("sendsuccess", sendsuccess);
            request.setAttribute("fjr", fjr);
            request.setAttribute("boxuuid",boxuuid);
            request.setAttribute("reloadleftframe",reloadleftframe);
        } catch (DBException e) {
            if (log.isError()) {
                log.logError("�����쳣:" + e.getMessage());
            }
            e.printStackTrace();
        } catch (IOException e) {
            if (log.isError()) {
                log.logError("�����ļ�����ʧ��:" + e.getMessage());
            }
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
                        log.logError("Connection������쳣��δ�ܹر�");
                    }
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * ����request
     * @param httpServletRequest
     */
    private void processingRequest(HttpServletRequest httpServletRequest) {
        String contentTypeStr = httpServletRequest.getContentType();
        if (contentTypeStr != null) {
            if (contentTypeStr.indexOf(",") != -1) {
                contentTypeStr = contentTypeStr.substring(0, contentTypeStr.indexOf(","));
            }
            // ʹ�õ��ϴ��ļ�
            if ((contentTypeStr != null) && contentTypeStr.startsWith("multipart/form-data")) {
                MultiPartRequest parser = getRequestParser(httpServletRequest);
                httpServletRequest.setAttribute("MultiPartRequest_Parser", parser);
            }
        }
    }

    /**
     * @param httpServletRequest
     * @return
     */
    private MultiPartRequest getRequestParser(
            HttpServletRequest httpServletRequest) {
        try {
            MultiPartRequest parser = null;
            javax.servlet.ServletContext context = getServletContext();
            parser = null;
            parser = new MultiPartRequest(context, httpServletRequest);
            parser.setAllowedTotalSize(getUploadLimitedSize());
            int result = parser.parseAndSave();
            if (result == 1) {
                new Exception("�ϴ��ļ���С��������!");
                return null;
            }

            return parser;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        } catch (ServletException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * ��ȡ�ϴ��ļ���С
     * @return
     */
    public int getUploadLimitedSize() {
        return 1024 * 1024 * MessageConfig.getUploadsize();
    }
    
    /**
     * ȡ��request������ָ��ǰ׺�Ĳ������ƺ�ֵ
     * @param request HttpServletRequest
     * @param prefix ������ǰ׺
     * @param blank Ϊtrue����ҳ������Ŀ�ֵ��
     * @return ��������ָ��ǰ׺�Ĳ�������ֵ��map���󣬷��صĲ��������ٰ���ǰ׺<br>
     * ��������в�����ָ��ǰ׺�Ĳ������򷵻ؿյ�Map
     * @throws Exception 
     */
    public final Map getRequestDataWithPrefix(HttpServletRequest request, String prefix, boolean blank,boolean isUpload)
        throws Exception {
        Map therequestdata = new HashMap();
        Enumeration names = null;
        if (isUpload == true) {
            MultiPartRequest parser = (MultiPartRequest) request.getAttribute("MultiPartRequest_Parser");
            names = parser.getParameterNames();
        }
        else
        {
            names = request.getParameterNames();
        }
        while (names.hasMoreElements()) {
            String name = names.nextElement().toString();
            if (name.startsWith(prefix)) {
                String _t="";
                if (isUpload == true) {
                    MultiPartRequest parser = (MultiPartRequest) request.getAttribute("MultiPartRequest_Parser");
                    _t= parser.getParameter(name);
                }else{
                    _t=request.getParameter(name);
                }
                if (blank) {
                    if (_t != null && _t.length() > 0) {
                        therequestdata.put(name.substring(prefix.length(), name.length()), _t);
        
                    }
                } else {
                    therequestdata.put(name.substring(prefix.length(), name.length()), _t);
                }

            }
        }
        return therequestdata;
    }
}
