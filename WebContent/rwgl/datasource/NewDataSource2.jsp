<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gb2312"%>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.resource.parameter.vo.ParameterVO"/>
<jsp:directive.page import="base.task.resource.adapter.vo.AdapterVO"/>
<jsp:directive.page import="base.task.resource.application.vo.ApplicationVO"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
	String contextpath = request.getContextPath();
	List dsTypeParaList = (List)request.getAttribute("dsTypeParaList");
	
	List adapterList= (List)request.getAttribute("adapterList");
	List systemList= (List)request.getAttribute("systemList");
	String DS_TYPE= (String)request.getAttribute("DS_TYPE");
	String dsTypeName= (String)request.getAttribute("dsTypeName");
	List adapterParaList= (List)request.getAttribute("adapterParaList");
	String message=(String)request.getAttribute("message");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextpath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/customString.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/formVerify.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/verify.js"></script>
<title>�½�����Դ�ڶ���</title>
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

<script type="text/javascript">

function cancelback(){
	document.location.href="<%=contextpath%>/base/task/resource/datasource/NewDataSourceServlet";
}
function saveData(){
    if(document.frm.SYSTEMID.value==""){
      alert("��ѡ��Ӧ��ϵͳ��");
      return;
    }
	if(_check(frm)) {
       document.frm.action="<%=contextpath%>/base/task/resource/datasource/AddDataSourceServlet";
		document.frm.submit();
     }else{
    return;
   }
}
function changeAdapterParas(){
	var tableid= document.getElementById("DEF_ADAPTER").value;
	<%
	for(int i=0;i<adapterList.size();i++){
     	AdapterVO avo= (AdapterVO)adapterList.get(i);
     	String id= avo.getID();
	%>
	var objTable= document.getElementById("<%=id%>");
	if(objTable!=null) objTable.style.display="none"; 
	<%
	  }
	%>
	document.getElementById(tableid).style.display="";
}
</script>
</head>

<body>
<form name="frm" method="post">
<input type="hidden" name="DS_TYPE" value="<%=DS_TYPE %>">
	
<br>
<br>
<font color="red" class="text01"><%=message %></font>
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01" bgcolor="#FFFFFF">
<tr>
<td>
<fieldset>
<legend align="center">���ڶ�����<%=dsTypeName %></legend>
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="center" >
<tr><td align="left">����Դ���ƣ�</td><td><input type="text" name="DS_NAME" required=true fieldTitle="����Դ����" fieldType ="hasSpecialChar" size="20" maxlength="100"><font color="red">*</font></td></tr>
<tr><td align="left">����Դ������</td><td><input type="text" name="DESCRIPTION" size="20"��fieldTitle="����Դ����" maxlength="100"></td></tr>
<tr><td align="left">����Դ���ͣ�</td><td><%=dsTypeName %></td></tr>
<tr><td align="left">����Ӧ��ϵͳ��</td><td>
<select name="SYSTEMID">
  <%
     for(int i=0;i<systemList.size();i++){
       ApplicationVO appvo= (ApplicationVO)systemList.get(i);
   %>
  <option value="<%=appvo.getId() %>" selected><%=appvo.getSystem_name() %></option>
  <%
  }
   %>
</select></td></tr>
<tr><td align="left">Ĭ����������</td><td>
<select name="DEF_ADAPTER" id="DEF_ADAPTER" onchange="changeAdapterParas();">
  <%
     for(int i=0;i<adapterList.size();i++){
     	AdapterVO avo= (AdapterVO)adapterList.get(i);
   %>
  <option value="<%=avo.getID()%>"><%=StringUtil.escapeHTMLTags(avo.getAdapterName()) %></option>
  <%
     }
   %>
</select></td></tr>
<tr>
  <td colspan="2">
  <%
     for(int i=0;i<adapterList.size();i++){
     	AdapterVO avo= (AdapterVO)adapterList.get(i);
     	String id= avo.getID();
   %>
   <table id="<%= id%>" style="display: none" width="100%">    
   <%
   for(int j=0;j<adapterParaList.size();j++){
     		ParameterVO pvot= (ParameterVO)adapterParaList.get(j);
     		if(id.equals(pvot.getRefId())){
   %>
   <tr><td align="left" width="36%"><%=pvot.getCnname() %>��</td><td width="64%"><input name="<%=pvot.getParaname() %>" type="text" size="30" value="<%=pvot.getParavalue() %>"></td></tr>
   <%
     }
     }
   %>
   </table>
   <%
     }
   %>
   </td>
</tr>
<tr>
<td align="left">����Դ������</td>
<td></td>
</tr>
<%
for(int i=0;i<dsTypeParaList.size();i++){
	   ParameterVO pvo= (ParameterVO)dsTypeParaList.get(i);
	   String optionText=pvo.getOptionName();
	   String optionValue=pvo.getOptionValue();
 %>
 <tr>
 <td align="left"><%=pvo.getCnname() %></td>
 <td>
 <%
 if(optionText!=null && optionValue != null){
		   String[] optT= optionText.split(",");
		   String[] optV= optionValue.split(",");
%>
<select name="<%=pvo.getParaname()%>">
<%
   for(int mm=0;mm< optV.length;mm++){
 %>
 <option value="<%=optV[mm] %>" selected><%=optT[mm] %></option>
 <%
 }   
  }else if(pvo.getParaname().indexOf("PASSWORD")!=-1){
%>
 <input name="<%=pvo.getParaname() %>" type="password" fieldTitle="����Դ����" size="30">
 <%
 	}else{%>
 	 <input name="<%=pvo.getParaname() %>" type="text" fieldTitle="����Դ����" size="30">
 	<%}
 	}
  %>
</td>
</tr>
</table>
</fieldset>
</td>
</tr>
</table>
<br>
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01">
<tr><td align="center"><input type="button" name="next" value="����" onclick="saveData();" class="input01">&nbsp;&nbsp; <input type="button" name="cancel" value="����" onclick="cancelback();" class="input01"></td></tr>
</table>
</form>
<script type="text/javascript">
var tablesssid=document.getElementById("DEF_ADAPTER").value;
if(tablesssid!=""){
	var oT=document.getElementById(tablesssid);
	if(oT!=null)oT.style.display="";
}
</script>
</body>
</html>
