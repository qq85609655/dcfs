<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%
String contextPath = request.getContextPath();
 %>
<html>
<head>
<link href="<%=contextPath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/customString.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/formVerify2.js"></script>
<script type="text/javascript" src="<%=contextPath%>/rwgl/js/verify.js"></script>
<title>���������</title>
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
</head>
<script>
//����
function _checkFrm()
{
   var sForm = document.frmSub;
   var desc = document.getElementById("DESCRIPTION");
   if(desc.value.length>=100){
     alert("������󳤶�Ϊ100!");
     sForm.DESCRIPTION.focus();
    return;
   }

   if(_check(frmSub)){ 
   sForm.action="<%= contextPath %>/base/task/resource/jobgroup/AddJobgroupServlet";
   sForm.submit();
   }else{
     
     sForm.GROUP_NAME.focus();
     return;
   }
  
}

function _return()
{
    window.location.href="<%= contextPath %>/base/task/resource/jobgroup/JobgroupListServlet";
}
</script>
<body>
<form  method="post" name="frmSub">

<table width="80%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01">
<tr>
<td>
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="center" bgcolor="#9CC6F7">
      <tr>
        <td class="listdata"><div align="right">���������ƣ�</div></td>
        <td class="listdata"><div align="left"><input type="text" fieldTitle="����������" name="GROUP_NAME" size="20"  fieldType ="hasSpecialChar" required=true maxlength="30"><font  class="text01" color="#FF0000">*</font></div></td>
      </tr>
      <tr>
        <td class="listdata"><div align="right">������</div></td>
        <td class="listdata"><div align="left"><textarea id="DESCRIPTION" name="DESCRIPTION" fieldTitle="����" fieldType ="hasSpecialChar"  rows="5" cols="50" ></textarea></div></td>
      </tr>		  		  		  		  		  
      <tr class="listdata"><td align="center" colspan="2"><input type="button" name="addNewButton" value="����" class="input01" onClick="_checkFrm();">&nbsp;<input type="button" name="returnButton" value="����" class="input01" onClick="_return();"></td></tr>
</table>
</td>
</tr>
</table>
</form>
</body>
</html>
