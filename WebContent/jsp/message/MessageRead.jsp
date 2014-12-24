<%@page import="java.net.URLEncoder"%>
<%@page import="hx.message.OAConstants"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.hx.framework.person.vo.Person"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.taglib.TagTools"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String resourcepath=TagTools.getResourcePath(request,"");
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String servletPath=path+"/MessageServlet";
Data data=request.getAttribute("data")==null?new Data():(Data) request.getAttribute("data");
String boxuuid=(String)request.getAttribute("boxuuid");
DataList dataMsg=request.getAttribute("dataMsg")==null?new DataList():(DataList)request.getAttribute("dataMsg");
String type=(String)request.getParameter("type")==null?"":(String)request.getParameter("type");
String RECEIVERUUID="";
try{
Person info=SessionInfo.getCurUser().getPerson();
RECEIVERUUID = info.getPersonId();
}catch(Exception e){
    RECEIVERUUID="";
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <BZ:head>
    <title>查看消息</title>
 <style type="text/css">
 <!--
 .neirong{
	background-color:#FFFFFF; 
	border: solid 1px #C5D7ED; 
	width: 713px; 
	height: 300px; 
	overflow: scroll; 
	scrollbar-face-color: #F0F0F0;
	scrollbar-shadow-color: #7F7F7F;
	scrollbar-highlight-color: #F0F0F0;
	scrollbar-3dlight-color: #7F7F7F;
	scrollbar-darkshadow-color: #F0F0F0;
	scrollbar-track-color: #F0F0F0;
	scrollbar-arrow-color: #7F7F7F;
 }
   -->
  </style>
  <BZ:script isEdit="true" isAjax="true"/>
<link href="<%=resourcepath%>/message/css/newStyle.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/message/css/mail.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="<%=resourcepath %>/message/css/csi.css"/>
    <script type="text/javascript" charset="utf-8" src="<%=resourcepath%>/message/kindeditor/kindeditor.js"></script>
  </BZ:head>
  <style type="text/css">
   body{
   background-color:#F6F9FD;
 
   }
   </style>
 <script language="javascript"> 
 function goback(){
	window.location = "<%=path%>/MessageServlet?method=receivemessage&boxuuid=<%=boxuuid%>";
  }
  
 function restoredl()
{
    document.schForm.action="<%=servletPath%>?method=huifudl&uuid=<%=data.getString("UUID","")%>";
	document.schForm.submit();
} 
  
  function restore()
{
    document.schForm.action="<%=servletPath%>?method=huifu&uuid=<%=data.getString("UUID","")%>&xians=duanxx";
	document.schForm.submit();
}
  function gohz()
  {
  var v=document.getElementById('uuid').value;
  var dm=getBoolean("com.hx.oa.ppla.message.MessageAjax","method=huizhi&uuid="+v);
  if(dm)
  {
  		document.getElementById("huizhi").style.display="none";
		document.getElementById("hzok").style.display="";
  }
  }
  try{
	  window.parent.leftFrame.location.reload();  
  }catch(e){
  }
  
 </script> 
  <body>
  <form id="schForm" name="schForm" method="post" action="">
  <input type="hidden" name="uuid" value="<%=data.getString("UUID","") %>"/>
  <input type="hidden" name="boxuuid" value="<%=boxuuid%>"/>
 <div class="titleContent" align="left" style="background:url(<%=path%>/include/images/bg_title2.gif);height:35px;line-height:35px;vertical-align:middle;border-bottom:solid 1px #7CA3D4">消息查看</div>
 <div id="clientBorder" style="min-height:400px;">
<div id="clientArea" >
<table width="100%" class="table01" border="0" cellpadding="0" cellspacing="0">

    <tr>
      <td width="10%">收件人：</td>
      <td width="90%"><input name="newmail_receiver" type="text" value="<%=data.getString("RECEIVER","") %>" size="100" readonly/></td> 
    </tr>
     <tr>
      <td width="10%">抄送人：</td>
      <td width="90%"><input name="newmail_receiver" type="text" value="<%=data.getString("COPYFORER","") %>" size="100" readonly/></td> 
    </tr>
    <tr> 
      <td>发件人：</td>
      <td><input name="newmail_sender" type="text" value="<%=data.getString("SENDER","") %>" size="100" readonly/></td> 
    </tr>
    <tr> 
      <td>主题：</td>
      <td><input name="newmail_mailtitle" type="text" value="<%=data.getString("MAILTITLE","") %>" size="100" readonly/></td> 
    </tr>
        <tr> 
      <td>邮件时间：</td>
      <td><input name="newmail_messagetime" type="text" value="<%=data.getString("MESSAGETIME")%>" size="100" readonly/></td> 
    </tr>
    <tr> 
      <td>附件：</td>
      <td><div>
      <%if(data.getString("ACCESSORY","").equals("0")) {%>无附件！<%}else{
      for(int i=0;i<dataMsg.size();i++){ 
       Data filedata=dataMsg.getData(i);
       %><a href='<%=path%>/servlet/base/attachfileservlet?fileUrl=<%=URLEncoder.encode(URLEncoder.encode(filedata.getString("FILEURL",""), "UTF-8"),"UTF-8")  %>&fileName=<%=URLEncoder.encode(URLEncoder.encode(filedata.getString("FILENAME",""), "UTF-8"),"UTF-8") %>'><%=filedata.getString("FILENAME","") %></a>&nbsp;&nbsp;&nbsp;&nbsp;<%}} %></div></td>
    </tr>  
    <tr> 
      <td>内容：</td>
      <td><div class="neirong"><%=data.getString("CONTENT","") %></div></td>
    </tr>
    <tr>  
      <td></td>
      <td>
			 <input type="button" name="" value="回复"  onclick="<%if(type.equals("duli")) {%>restoredl();<%}else{ %>restore();<%} %>" class="btn2"/>
			 <%if(data.getString("RECEIPT","").equals(OAConstants.SFHZ_YES)){ %>
              <input type="button" name="huizhi" value="回执" onclick="gohz();" style="display:<%=data.getString("RECEIPTSTATE","").equals(OAConstants.SFHZ_YES)?"none":""%>;" class="btn2"/>
             <input name="hzok" id="hzok" type="button" value="已回执" class="btn2" style="display:<%=data.getString("RECEIPTSTATE","").equals(OAConstants.SFHZ_YES)?"":"none"%>;" disabled="disabled" /><%} %>
             <input type="button" name="" value="返回"  onclick="goback();" class="btn2"/>
      </td>   
    </tr>
  </table> 
 </div>
 </div>
 <iframe style="display:none" name="fileDownLoad" id="fileDownLoad"></iframe>
 </form>
  </body>
  <script type="text/javascript">
  <%if(data.getString("RECEIPT","").equals(OAConstants.SFHZ_YES)&&data.getString("RECEIPTSTATE","").equals("0")&&!data.getString("RECEIVERUUID","").equals(RECEIVERUUID)){ %>
  if(confirm("检测到邮件需要回执要现在回执吗?")){
  gohz();
  }
  <%}%>
  </script>
</html>
