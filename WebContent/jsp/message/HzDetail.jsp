<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.util.Map"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.taglib.TagTools"%>
<%@page import="hx.database.databean.Data"%>
<%
String path = request.getContextPath();
String resourcepath=TagTools.getResourcePath(request,"");
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
DataList dataMsg=(DataList)request.getAttribute("dataMsg")==null?new DataList():(DataList)request.getAttribute("dataMsg");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>  
    <title>查看回执状态</title>
     <link href="<%=resourcepath%>/mail/css/share.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/mail/css/base.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/mail/css/qm_core.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/mail/css/qm_menu.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/mail/css/navigation.css" rel="stylesheet" type="text/css" />
<link href="<%=resourcepath%>/mail/css/newStyle.css" rel="stylesheet" type="text/css" />

<script language="javascript" type="text/javascript" src="<%=resourcepath%>/mail/js/divtbl.js"></script>
  </head>
   <body id="body">
  <form  name="srcForm" method="post" action="">
<table cellspacing="0" id="the-table" class="tableData heading" width="100%" style="margin-top:10px;" >
 <thead>
  <tr style="background:#eeeeee;" >
    <th width="20%">序号</th>
    <th width="40%">收件人</th>
    <th width="40%">是否回执</th>
    </tr>
    </thead>
    <tbody>
  <%int i;
    for(i=0;i<dataMsg.size();i++){
    Data data=dataMsg.getData(i);
   %>
  <tr>
    <td align="middle"><%=i+1%></td>
    <td align="middle"><%=data.getString("MESSAGEHOLDER","&nbsp;") %></td>
	<td align="middle"><%=data.getString("RECEIPTSTATE","").equals("1")?"<img src='"+resourcepath+"/message/images/tick.gif' width='16' height='16' alt='已回执'/>":"<img src='"+resourcepath+"/include/images/cross.gif' width='15' height='14' alt='未回执'/>"%></td>
    </tr>
  <%} %>
      <% for(int j=i;j<10;j++)
           {
           %>
           <tr>
		   <td>&nbsp;</td>
		   <td>&nbsp;</td>
		   <td>&nbsp;</td>
		   <td>&nbsp;</td>
		   <td>&nbsp;</td>
		   <td>&nbsp;</td>
		   <td>&nbsp;</td>
           </tr>
           <% 
           }            
           %>   
    </tbody>
</table>
</form>
  </body>
</html>
