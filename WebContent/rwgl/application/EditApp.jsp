<%@ page contentType="text/html;charset=GBK"%>
<jsp:directive.page import="base.task.resource.application.vo.ApplicationVO"/>
<%
	String contextPath= request.getContextPath();
	ApplicationVO appvo= (ApplicationVO)request.getAttribute("system");
	String message= (String)request.getAttribute("message");
	if(message== null) message="";
%>
<html>
<head>
<title>修改应用</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #F4F9FF;
}
-->
</style>

<SCRIPT LANGUAGE="JavaScript">
<!--

//检查表单
function _checkFrm()
{
   var sForm = document.frm;
    //if(_check(frm)) {
       sForm.action="<%= contextPath %>/base/task/resource/application/SaveAppServlet";
   sForm.submit();
     //}else{
    //return;
   //}

   
}

function _return()
{
    window.location.href="<%= contextPath %>/base/task/resource/application/AppListServlet";
}
//-->
</SCRIPT>
</head>

<body>
<form name="frm" method="post">
<input name="ID" type="hidden" value="<%=appvo.getId() %>"> 
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="text01">
  <tr>
    <td height="18"  valign="middle"><img src="<%=contextPath%>/images/currentpositionbg.jpg" width="8" height="18" id="positionimg"/><div class="currentposition"><strong>&nbsp;当前位置-&gt; 任务管理-&gt;系统应用管理-&gt;修改应用</strong></div></td>
    <td  class="currentposition" align="right"><strong></strong></td>
    <td width="4%" align="right"> 
    
    </td>
    <td width="9%"> 
      
    </td>
  </tr>
</table>	
<br>
<br>
<br>
<br>
<br>
<font class="text01" color="red" ><%=message %></font>
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01">
<tr>
<td>
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="center" bgcolor="#9CC6F7">
      <tr>
        <td width="18%" class="listdata"><div align="right">应用系统名称：</div></td>
        <td class="listdata" colspan="2"><div align="left"><input type="text" required=true name="SYSTEM_NAME" fieldTitle="应用系统名称" fieldType ="hasSpecialChar" class="inputtxt" size="30" maxlength="30" value="<%=appvo.getSystem_name() %>"><font  class="text01" color="#FF0000">*</font></div></td>
      </tr>
	  <tr>
        <td class="listdata"><div align="right">描述：</div></td>
        <td class="listdata" colspan="2"><div align="left">
          <input type="text" name="DESCRIPTION" class="inputtxt"  size="30" maxlength="100" fieldTitle="描述" fieldType ="hasSpecialChar" value="<%=appvo.getDescription() %>"><font  class="text01" color="#FF0000">*</font>
        </div></td>
      </tr>
      <tr>
        <td class="listdata" colspan="3" height="10"></td>
      </tr>			  		  		  		  
      <tr class="listdata"><td align="center" colspan="3"><input type="button" name="button" value="保 存" class="input01" onclick="_checkFrm()" style="">&nbsp;<input type="button" name="button2" value="返 回" class="input01" onclick="_return()" style=""></td></tr>
</table>
</td>
</tr>
</table>
</form>
</body>
</html>