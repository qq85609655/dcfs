/**
 * $Id$
 *
 * Copyright (c) 2010 21softech. All rights reserved
 * XXXXX Project
 *
 */
package hx.message;

import hx.code.Code;
import hx.code.CodeList;
import hx.common.Exception.DBException;
import hx.common.handler.BaseHandler;
import hx.database.databean.Data;
import hx.database.databean.DataBaseFactory;
import hx.database.databean.DataList;
import hx.database.dbinterface.IDataExecute;
import hx.util.DateUtility;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;

import com.hx.framework.sdk.OrganHelper;
import com.hx.framework.sdk.PersonHelper;

/**
 * @Title: MessageHandler.java
 * @Description: <br>
 *               <br>
 * @Company: 21softech
 * @Created on 2011-2-25 上午10:08:52
 * @author baihy
 * @version $Revision: 1.0 $
 * @since 1.0
 */
public class MessageHandler extends BaseHandler{
    
    /**
     * 查看文件夹消息的个数
     * @param conn
     * @param person
     * @return
     * @throws DBException
     */
    public DataList getMessageNum(Connection conn,String person) throws DBException{
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql=getSql("getMessageNum",person,OAConstants.ALLPERSON,person);
        return ide.find(sql);
    }

    /**
     * 得到信箱消息
     * @param conn
     * @param person
     * @param boxuuid 
     * @return
     * @throws DBException 
     */
    public DataList getMessages(Connection conn, String person, String boxuuid) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        String sql="";
        if(!boxuuid.equals(OAConstants.NEWXX)){
        sql=getSql("getMessages",person,boxuuid);  
        }else{
        sql=getSql("getMessages1",person,OAConstants.SFYD_NO); 
        }
        return ide.find(sql);
    }

    /**
     * 得到邮件的所有文件夹
     * @param conn
     * @return
     * @throws DBException 
     */
    public DataList getAllFlodData(Connection conn) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(getSql("getAllFlodData"));
       }

    /**
     * 读取文件夹消息
     * @param conn
     * @param pageSize
     * @param page
     * @param boxuuid
     * @param fjr
     * @return
     * @throws DBException 
     */
    public DataList getReceiveMessage(Connection conn, int pageSize, int page,String boxuuid, String fjr) throws DBException {
        String sql="";
        if(!boxuuid.equals(OAConstants.NEWXX))
        {
            sql=getSql("getMessages",fjr,boxuuid);  
        }else
        {
            sql=getSql("getMessages1",fjr,OAConstants.SFYD_NO);  
        }
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(sql,pageSize,page);
    }

    /**
     * 查看文件夹
     * @param conn
     * @param fjr
     * @param type 
     * @return
     * @throws DBException 
     */
    public DataList getFindBox(Connection conn, String fjr, String type) throws DBException {
        String sql="";
        if(type.equals("0"))
        {
            sql=getSql("getFindBox",fjr,OAConstants.ALLPERSON,"all"); 
        }else{
            sql=getSql("getFindBox1",fjr,OAConstants.ALLPERSON); 
        }
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(sql);
    }

    /**
     * 查找人员信息
     * @param conn
     * @param orgid 
     * @return
     * @throws Throwable 
     */
    public CodeList getperson(Connection conn) throws Throwable {
        CodeList orglist=OrganHelper.getOrganCodeList();
        CodeList personlist=PersonHelper.getPersonCodeList();
        CodeList codeList=new CodeList();
        for(int i=0;i<orglist.size();i++){
            Code orgcode=orglist.get(i);
            Code code=new Code();
            code.setValue(orgcode.getValue());
            String parentvalue=orgcode.getParentValue();
            if(parentvalue!=null&&parentvalue.equals("ALL")){
                parentvalue="0";
            }
            code.setParentValue(parentvalue);
            code.setName(orgcode.getName());
            codeList.add(code);
        }
        for(int i=0;i<personlist.size();i++){
            Code personcode=personlist.get(i);
            Code code=new Code();
            code.setValue(personcode.getValue());
            code.setParentValue(personcode.getParentValue());
            code.setName(personcode.getName());
            codeList.add(code);
        }
        return codeList;
    }

    /**
     * 保存正文xml
     * @param contenthtml
     * @param contenttxt
     * @param url
     * @param string
     * @throws IOException 
     */
    public void SaveMessage(String neirong,String neirong1,String Url,String UUID) throws IOException {
        Element contenttxt=new Element("contenthtml");
        contenttxt.addContent(neirong);
        Element contenthtml=new Element("contenttxt");
        contenthtml.addContent(neirong1);
        Element content=new Element("content");
        content.addContent(contenttxt);
        content.addContent(contenthtml);
        Document doc = new Document(content);
        FileOutputStream fos = new FileOutputStream(Url+"/"+UUID+".xml");
        XMLOutputter outputter = new XMLOutputter();
        outputter.output(doc,fos);
    }

    /**
     * 保存短消息
     * @param dataMsg 
     * @param conn 
     * @throws DBException 
     */
    public void saveMessage(Connection conn, DataList dataMsg) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.batchCreate(dataMsg);
    }

    /**
     * 读取邮件
     * @param conn
     * @param uuid
     * @return
     * @throws DBException 
     */
    public DataList readMessage(Connection conn, String uuid) throws DBException {
        String sql=getSql("getMessageSql",uuid);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(sql);
    }

    /**
     * 读取邮件正文
     * @param request
     * @param string
     * @param long1
     * @return
     * @throws JDOMException 
     * @throws IOException 
     */
    public String ReadContent(HttpServletRequest request,String UUID,Long time) throws JDOMException, IOException {
        String Content=""; 
        String date=DateUtility.getStrDate(time, 0).replaceAll("-", "");
        StringBuffer sb=new StringBuffer();
        sb.append(MessageConfig.getRootDir())
          .append(MessageConfig.getRootDirMessage())
          .append("/")
          .append(date)
          .append("/")
          .append(UUID)
          .append("/")
          .append(UUID).append(".xml");
           String url=sb.toString();
           SAXBuilder builder = new SAXBuilder(false);
           Document document = builder.build(new File(url));
           Element element = document.getRootElement();
           List list= element.getChildren("contenthtml");
           for (int i=0;i<list.size();i++)
           {
           Element ele2=(Element)list.get(i);
           Content=ele2.getText();
           } 
      return Content;
       }
   
    /**
     * 获得附件URL
     * 
     */
    public DataList getContentUrl(String url,String uuid,String lujing) {
        DataList affixlist=new DataList();
        //获得所有的附件URL
             File dir = new File(url);
             File file[] = dir.listFiles();
             if(file!=null&&file.length>0){
                 for(int i=0;i<file.length;i++){
                  Data data=new Data();
                    File accfile=file[i];
                    String filename=accfile.getName();
                    if(!filename.equals(uuid+".xml")){
                        StringBuffer sp=new StringBuffer();
                        sp.append(lujing).append("/").append(filename);
                        data.add("fileurl", sp.toString());
                        data.add("filename", filename);
                        affixlist.add(data);
                   } 
                 }
             }
            return affixlist;   
    }

    /**
     * 回执(修改发送邮件的状态)
     * @param uuid
     * @return
     * @throws DBException 
     */
    public boolean HuizhiFjxMessage(Connection conn,String uuid) throws DBException {
        String sql=getSql("HuizhiFjxMessage",OAConstants.SFHZ_YES,uuid);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.execute(sql);
    }

    /**
     * 回执
     * @param conn 
     * @param uuid
     * @return
     * @throws DBException 
     */
    public boolean HuizhiMessage(Connection conn, String uuid) throws DBException {
        String sql=getSql("HuizhiMessage",OAConstants.SFHZ_YES,uuid);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.execute(sql);
    }

    /**
     * 查看回执详情
     * @param uuid 
     * @param conn 
     * @return
     * @throws DBException 
     */
    public DataList getHzdetailSql(Connection conn, String uuid) throws DBException {
        String sql=getSql("getHzdetailSql",uuid,uuid);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(sql);
    }

    /**
     * 移动邮件
     * @param conn 
     * @param dataMsg 
     * @throws DBException 
     */
    public void Xidongxj(Connection conn, DataList dataMsg) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.batchStore(dataMsg);
    }

    /**
     *  删除邮件
     * @param conn
     * @param dataMsg
     * @throws DBException 
     */
    public void Gbbox(Connection conn, DataList dataMsg) throws DBException {
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.batchStore(dataMsg);
    }

    /**
     *  判断是垃圾箱中的邮件附件是否还在使用(包含uuid)
     * @param conn
     * @param person
     * @param boxuuid
     * @param uuid
     * @throws DBException 
     */
    public DataList PdlajUuidMessages(Connection conn, String sjr,String boxuuid,String[] uuid) throws DBException {
        StringBuffer sb=new StringBuffer();
        StringBuffer sp=new StringBuffer();
        for(int i=0;i<uuid.length;i++)
        {
        if(i==(uuid.length-1))
        {
        sp.append("'").append(uuid[i]).append("'"); 
        }else
        {
        sp.append("'").append(uuid[i]).append("',");    
        }
        }
        sb.append(" SELECT A.UUID,A.MESSAGEUUID,COUNT(P.MESSAGEUUID) SL,A.MESSAGETIME FROM ((SELECT UUID,MESSAGEUUID,MESSAGETIME FROM T_MESSAGE T ");
        sb.append(" WHERE T.UUID IN (");
        sb.append(sp.toString());
        sb.append(" )) A LEFT JOIN (SELECT B.UUID,B.MESSAGEUUID,B.BOXUUID FROM T_MESSAGE B) P ON P.MESSAGEUUID=A.MESSAGEUUID ");
        sb.append(" AND P.UUID NOT IN (");
        sb.append(sp.toString());
        sb.append(" )) GROUP BY A.MESSAGEUUID,A.MESSAGETIME,A.UUID");
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(sb.toString());
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
  
    /**
     * 删除文件夹信息
     * @param conn 
     * @param string
     * @throws DBException 
     */
    public void getDeleteMessage(Connection conn, String uuid) throws DBException {
        String sql=getSql("getDeleteMessage",uuid);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.execute(sql);
    }

    /**
     * 判断是垃圾箱中的邮件附件是否还在使用
     * @param conn
     * @param person
     * @param boxuuid
     * @return
     * @throws DBException 
     */
    public DataList PdlajMessages(Connection conn, String person, String boxuuid) throws DBException {
        String pdlajMessages=getSql("pdlajMessages",person,OAConstants.LJX,OAConstants.LJX);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(pdlajMessages);
    }

    /**
     *  删除垃圾箱中的信息
     * @param conn
     * @param person
     * @param boxuuid
     * @throws DBException 
     */
    public void getDeleteMessages(Connection conn, String person, String boxuuid) throws DBException {
       String sql=getSql("getDeleteMessages",boxuuid,person);
       IDataExecute ide = DataBaseFactory.getDataBase(conn);
       ide.execute(sql);
    }

    /**
     * 清空文件夹
     * @param conn
     * @param person
     * @param boxuuid
     * @throws DBException 
     */
    public void getDeleteBoxMessages(Connection conn, String person,
            String boxuuid) throws DBException {
       String sql=getSql("getDeleteBoxMessages",OAConstants.LJX,boxuuid,person);
       IDataExecute ide = DataBaseFactory.getDataBase(conn);
       ide.execute(sql);
       }

    /**
     * 查看是否存在相同姓名的文件夹
     * @param conn
     * @param person
     * @param fileName
     * @return 
     * @throws DBException 
     */
    public DataList getBox(Connection conn, String person, String fileName) throws DBException {
        String sql=getSql("getBox",person,fileName);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        return ide.find(sql);
    }

    /**
     * 删除文件夹
     * @param conn
     * @param boxuuid
     * @throws DBException 
     */
    public void Shanchubox(Connection conn, String boxuuid) throws DBException {
        String sql=getSql("Shanchubox",boxuuid);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.execute(sql);
    }

    /**
     * 重命名文件夹
     * @param conn
     * @param boxuuid
     * @param fileName
     * @throws DBException 
     */
    public void Changeboxname(Connection conn, String boxuuid, String fileName) throws DBException {
        String sql=getSql("Changeboxname",fileName,boxuuid);
        IDataExecute ide = DataBaseFactory.getDataBase(conn);
        ide.execute(sql);
    }
    //站内消息获取数量Ajax
    public DataList znxxAjaxList(Connection conn, String PERSON_ID) throws DBException{
    	IDataExecute ide = DataBaseFactory.getDataBase(conn);
	    return ide.find(getSql("znxxAjaxList",PERSON_ID,OAConstants.SFYD_NO));
    }

}
