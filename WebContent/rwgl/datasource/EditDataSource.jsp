<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gb2312"%>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.resource.parameter.vo.ParameterVO"/>
<jsp:directive.page import="base.task.resource.adapter.vo.AdapterVO"/>
<jsp:directive.page import="base.task.resource.application.vo.ApplicationVO"/>
<jsp:directive.page import="base.task.resource.datasource.vo.DataSourceVO"/>
<jsp:directive.page import="base.task.resource.datasourcetype.vo.DataSourceTypeVO"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
	String contextpath = request.getContextPath();
	DataSourceVO dsVo= (DataSourceVO)request.getAttribute("dsVo");
	AdapterVO avof= (AdapterVO)request.getAttribute("avof");
	DataSourceTypeVO dstvotemp= (DataSourceTypeVO)request.getAttribute("dstvotemp");	
	List paraList = (List)request.getAttribute("paraList");
	List systemList = (List)request.getAttribute("systemList");
	
	String message=(String)request.getAttribute("message");
	if(message==null) message="";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextpath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/customString.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/formVerify.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/formVerify2.js"></script>
        <script type="text/javascript" src="<%=contextpath%>/rwgl/js/verify.js"></script>
<title>新建数据源第二步</title>
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
	document.location.href="<%=contextpath%>/base/task/resource/datasource/DataSourceListServlet";
}
function saveData(){
    if(document.frm.SYSTEMID.value==""){
      alert("请选择应用系统！");
      return;
    }
	if(_check(frm)) {
       document.frm.action="<%=contextpath%>/base/task/resource/datasource/SaveDataSourceServlet";
		document.frm.submit();
     }else{
    return;
   }
}
</script>
</head>

<body>
<form name="frm" method="post">
<input type="hidden" name="ID" value="<%=dsVo.getID()%>">
<input type="hidden" name="DS_TYPE" value="<%=dstvotemp.getID()%>">
<input type="hidden" name="DEF_ADAPTER" value="<%=avof.getID()%>">
	
<br>
<br>
<font color="red" class="text01"><%=message %></font>
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01" bgcolor="#FFFFFF">
<tr>
<td>
<fieldset>
<legend align="center"></legend>
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="center" >
<tr><td align="left">数据源名称：</td><td><input type="text" name="DS_NAME" size="20" required=true fieldTitle="数据源名称" fieldType ="hasSpecialChar" maxlength="100" value="<%=dsVo.getDS_NAME() %>"><font color="red">*</font></td></tr>
<tr><td align="left">数据源描述：</td><td><input type="text" name="DESCRIPTION" size="20" maxlength="100" value="<%=dsVo.getDESCRIPTION() %>"></td></tr>
<tr><td align="left">数据源类型：</td><td><%=dstvotemp.getDsTypeName() %></td></tr>
<tr><td align="left">所属应用系统：</td><td>
<select name="SYSTEMID">
  <%
     for(int i=0;i<systemList.size();i++){
       ApplicationVO appvo= (ApplicationVO)systemList.get(i);
   %>
  <option value="<%=appvo.getId() %>" <%if(appvo.getId().equals(dsVo.getSYSTEMID())){%>selected<%}%>><%=StringUtil.escapeHTMLTags(appvo.getSystem_name()) %></option>
  <%
  }
   %>
</select></td></tr>
<tr><td align="left">默认适配器：</td><td><%=avof.getAdapterName()%></td></tr>
<tr>
<td align="left">数据源参数：</td>
<td></td>
</tr>
<%
for(int i=0;i<paraList.size();i++){
	   ParameterVO pvo= (ParameterVO)paraList.get(i);
	   String paraName = pvo.getParaname();
       String paraValue = pvo.getParavalue()==null?"":pvo.getParavalue();
	   String optionText=pvo.getOptionName();
	   String optionValue=pvo.getOptionValue();
	   
 %>
 <tr>
 <td align="left"><%=pvo.getCnname() %></td>
 <td>
 <%
 //modify by yinxk 2008-3-12
 if((optionText!=null && optionValue != null)&&(!"null".equals(optionText)&&!"null".equals(optionValue))){
		   String[] optT= optionText.split(",");
		   String[] optV= optionValue.split(",");
		  
%>
<select name="<%=paraName%>">
<%
   for(int mm=0;mm< optV.length;mm++){
 %>
 <option value=<%=optV[mm]%> <%if(paraValue.equals(optV[mm])){%>selected<%}%>><%=StringUtil.escapeHTMLTags(optT[mm]) %></option>
 <%}%>
 </select>
 <%}else if(paraName.indexOf("PASSWORD")>-1){%>
 <input name="<%=paraName%>" type="password" class="inputtxt" size="30" maxlength="100" value="<%=paraValue%>">
 <%}else{%>
 <input name="<%=paraName%>" type="text" class="inputtxt" size="30" maxlength="100" value="<%=paraValue%>">
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
<tr><td align="center"><input type="button" name="next" value="保存" onclick="saveData();" class="input01">&nbsp;&nbsp; <input type="button" name="cancel" value="返回" onclick="cancelback();" class="input01"></td></tr>
</table>
</form>
</body>
</html>
