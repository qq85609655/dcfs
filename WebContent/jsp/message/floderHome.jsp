<%@page import="hx.message.OAConstants"%>
<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.taglib.TagTools"%>
<%@page import="hx.database.databean.Data"%>
<%
String resourcepath=TagTools.getResourcePath(request,"");
String path = request.getContextPath();
DataList dataMsg=(DataList)request.getAttribute("dataMsg")==null?new DataList():(DataList)request.getAttribute("dataMsg");
String newxxs=(String)request.getAttribute("newxxs");
DataList flodermsg=(DataList)request.getAttribute("flodermsg");
Map mailnummap = (Map)request.getAttribute("mailnummap");
%>

<html>
<head>
 <link href="<%=resourcepath%>/message/css/globle.css" rel="stylesheet" type="text/css" />
  <link href="<%=resourcepath%>/message/css/blue.css" rel="stylesheet" type="text/css" />
<META HTTP-EQUIV="Content-Type" content="text/html; charset=gb_2312-80">
</head>
<script language="JavaScript">

 function changwjj(id,name,url)
 {
	window.top.openMenu(id,name,url);
 }
 
 function _shuaxin(){
	 window.location.reload();
 }
 
 setInterval("_shuaxin()",30000);
</script>  

<TITLE>邮件主页</TITLE>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=gb_2312-80">
<body style="overflow-y:auto;background-color:white;">
<table width="100%">
	<tr>
		<td>
			<div style="width:100%">
			   <table width="100%">
			   <tr>
			   <td><ul class="gFdBdy" id="ulFolders1"><li onMouseOver=this.className="on" onMouseOut=this.className=""><b class="icos icomFd"></b><a class="gFNm" href="#;" onclick="changwjj('<%=OAConstants.NEWXX%>','新消息','<%=path%>/MessageServlet?method=publicmail&boxuuid=<%=OAConstants.NEWXX%>');">新消息<%if(!newxxs.equals("0")) {%><strong>(<%=newxxs %>)</strong><%} %></a></li></ul></td>
			   <td></td>
			   </tr>
			   <%for(int i=1;i<=dataMsg.size();i++) {
			       Data data=dataMsg.getData(i-1);
			   %>
			   <%if(i%2!=0){ %>
			   <tr>
			   <td><ul class="gFdBdy" id="ulFolders1"><li onMouseOver=this.className="on" onMouseOut=this.className=""><%if(data.getString("UUID","").equals(OAConstants.SJX)){ %><b class="icos icoIbx"></b><%}else if(data.getString("UUID","").equals(OAConstants.FJX)) {%><b class="icos icoSnt"></b><%}else if(data.getString("UUID","").equals(OAConstants.LJX)) {%><b class="icos icoDel"></b><%}else{ %><b class="icos icomFd"></b><%} %><a class="gFNm" href="#;" onclick="changwjj('<%=data.getString("UUID","") %>','<%=data.getString("NAME","") %>','<%=path%>/MessageServlet?method=publicmail&boxuuid=<%=data.getString("UUID","") %>');"><%=data.getString("NAME","") %><%if(!data.getString("WYDNUM","0").equals("0")){ %><strong>(<%=data.getString("WYDNUM","") %>)</strong><%} %></a></li></ul></td>
			   <%}else{ %>
			   <td><ul class="gFdBdy" id="ulFolders1"><li onMouseOver=this.className="on" onMouseOut=this.className=""><%if(data.getString("UUID","").equals(OAConstants.SJX)){ %><b class="icos icoIbx"></b><%}else if(data.getString("UUID","").equals(OAConstants.FJX)) {%><b class="icos icoSnt"></b><%}else if(data.getString("UUID","").equals(OAConstants.LJX)) {%><b class="icos icoDel"></b><%}else{ %><b class="icos icomFd"></b><%} %><a class="gFNm" href="#;" onclick="changwjj('<%=data.getString("UUID","") %>','<%=data.getString("NAME","") %>','<%=path%>/MessageServlet?method=publicmail&boxuuid=<%=data.getString("UUID","") %>');"><%=data.getString("NAME","") %><%if(!data.getString("WYDNUM","0").equals("0")){ %><strong>(<%=data.getString("WYDNUM","") %>)</strong><%} %></a></li></ul></td>
			   </tr>
			   <%} %>
			   <%} %>
			   <%if(dataMsg.size()%2!=0){ %>
			   <td></td>
			   </tr>
			   <%} %>
			   </table>
			</div>
		</td>
	</tr>
</table>

</body>
<form name="leftval">
<INPUT NAME="temp" TYPE="hidden">
<INPUT NAME="to" TYPE="hidden">
<INPUT NAME="cc" TYPE="hidden">
<INPUT NAME="bcc" TYPE="hidden">
</form>
</html>
















