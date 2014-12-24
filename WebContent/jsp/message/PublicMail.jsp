<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.taglib.TagTools"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
<%@ page import="net.fckeditor.*"%>

<%
String path = request.getContextPath();
String resourcepath=TagTools.getResourcePath(request,"");
String dbIndex = request.getParameter("dbIndex");
String boxuuid = request.getParameter("boxuuid");
String uuid = request.getParameter("uuid");
if(dbIndex==null){
	dbIndex = "";
}
if(boxuuid==null){
    boxuuid="box_new";
}else if("".equals(boxuuid)){
    boxuuid="box_new";
}
if(uuid==null){
	uuid = "";
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<!-- InstanceBeginEditable name="doctitle" -->
<title>公共邮箱</title>  
<!-- InstanceEndEditable -->

<link href="<%=resourcepath%>/include/css/share.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/include/css/base.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/include/css/qm_core.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/include/css/qm_menu.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/include/css/navigation.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/include/css/newStyle.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/edit.js"></script>
<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/divtbl.js"></script>
<style>
body{
 margin:0px 0px 0px 0px;
}
</style>
</head> 
   <script language="JavaScript">
  function _onLoad()
    { 
    _initNav();
    }
   </script>
<body> 
<table width=100% height=100% border="0" cellpadding="0" cellspacing="0">
<tr>
    <td width="189" >
         <iframe id="leftFrame" style="border-right:#7CA3D4 1px solid;border-top:#7CA3D4 0px solid;"  name="leftFrame"  scrolling="no"   width=100% height=700 frameborder=0 src="<%=path%>/MessageServlet?method=floder">
		 </iframe></td>
	<td> 
	<%
		if(dbIndex.equals("newMessage")){
	 %>
	<iframe id="rightFrame" style="border-right:#7CA3D4 1px solid;border-top:#7CA3D4 0px solid;" name="rightFrame" scrolling="no"  width=100% height=700 frameborder=0 src="<%=path%>/MessageServlet?method=receivemessage&boxuuid=<%=boxuuid%>&uuid=<%=uuid %>">
		 </iframe>
	<%}else if(dbIndex.equals("newMail")){ %>
	<iframe id="rightFrame" style="border-right:#7CA3D4 1px solid;border-top:#7CA3D4 0px solid;" name="rightFrame" scrolling="no"  width=100% height=700 frameborder=0 src="<%=path%>servlet/mail/MailServlet?floder=box_accept&method=maillist&uuid=<%=uuid %>">
		 </iframe>
	<%}else if(dbIndex.equals("viewNewMail")){ %>
	<iframe id="rightFrame" style="border-right:#7CA3D4 1px solid;border-top:#7CA3D4 0px solid;" name="rightFrame" scrolling="no"  width=100% height=700 frameborder=0 src="<%=path%>servlet/mail/MailServlet?method=maillist&floder=news&uuid=<%=uuid %>">
		 </iframe>
	<%}else {%>
	<iframe id="rightFrame" style="border-right:#7CA3D4 1px solid;border-top:#7CA3D4 0px solid;" name="rightFrame" scrolling="no"  width=100% height=700 frameborder=0 src="<%=path%>servlet/mail/MailServlet?method=maillist&uuid=<%=uuid %>">
		 </iframe>
	<%}%>
    </td>
</tr> 
</table>
</body> 
</html>




