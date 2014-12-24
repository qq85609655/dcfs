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
  <script type="text/javascript" src="<%=resourcepath%>/mail/include/js/engine.js"></script>
<script language="javascript" type="text/javascript" src="<%=resourcepath%>/mail/include/js/divtbl.js"></script>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=gb_2312-80">
</head>
<script language="JavaScript">
<!--
 function goManager()
 {
 window.parent.rightFrame.location="<%=path+"/MessageServlet?method=showbox"%>";
 }
 function goManager2()
 {
 window.parent.rightFrame.location="<%=path+"?method=showbox"%>";
 }
 function changwjj(obj)
 {
 window.parent.rightFrame.location="<%=path+"/MessageServlet?method=receivemessage&boxuuid="%>"+obj;
 }
 
 function receivemail(){
     window.parent.location.reload();
 }
 
 
 function sendmail(){
     window.parent.rightFrame.location="<%=path+"/MessageServlet?method=tiaozhuan"%>";
 }
 
 function listmail(floder){
     if(floder=='news'){
       window.parent.rightFrame.location="<%=path+"?method=maillist"%>&floder=news";
     }{
       window.parent.rightFrame.location="<%=path+"?method=maillist"%>&floder="+floder;
     }
 }
 
//-->
</script>  

<TITLE>企业邮局</TITLE>
<META HTTP-EQUIV="Content-Type" content="text/html; charset=gb_2312-80">
<body class="gb" lang="zh" style="overflow-y:auto">
<table class="gMain">
	<tr class="gMtr">
		<td class="gLe">
			<div class="gMbtn" id="set_a_line_area3">
				<a href="#;" class="gCmBtn" title="收信" onClick="receivemail()"><b class="hide">收信</b></a>
				<a href="#;" class="gWmBtn" title="写信" onClick="sendmail()"><b class="hide">写信</b></a>
			</div>
			<div class="gFd">
				<h3 class="gfTit">
					<a href="#;" id="zhedie1" class="opnFd bgF1" title="折叠" onClick="toggleInfo('zhedie1','ulFolders1')"></a>
					<a href="#;" class="gfName" >我的短消息</a>
					<a href="#;" class="wjjGl bgF1" title="管理文件夹" onclick="goManager();"></a>
				</h3>
				<ul class="gFdBdy" id="ulFolders1">
				<li onMouseOver=this.className="on" onMouseOut=this.className=""><b class="icos icomFd"></b><a class="gFNm" href="#;" onclick="changwjj('<%=OAConstants.NEWXX%>');">新消息<%if(!newxxs.equals("0")) {%><strong>(<%=newxxs %>)</strong><%} %></a></li>
			  <%for(int i=0;i<dataMsg.size();i++)
				{
				  Data data=dataMsg.getData(i);
				 %>
				<li onMouseOver=this.className="on" onMouseOut=this.className=""><%if(data.getString("UUID","").equals(OAConstants.SJX)){ %><b class="icos icoIbx"></b><%}else if(data.getString("UUID","").equals(OAConstants.FJX)) {%><b class="icos icoSnt"></b><%}else if(data.getString("UUID","").equals(OAConstants.LJX)) {%><b class="icos icoDel"></b><%}else{ %><b class="icos icomFd"></b><%} %><a class="gFNm" href="#;" onclick="changwjj('<%=data.getString("UUID","") %>');"><%=data.getString("NAME","") %><%if(!data.getString("WYDNUM","0").equals("0")){ %><strong>(<%=data.getString("WYDNUM","") %>)</strong><%} %></a></li>
				<%} %>
				</ul>
			</div>
		</td>
		<td class="gRi" id="divMain">
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
















