<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page contentType="text/html; charset=gb2312"%>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="base.task.resource.datasourcetype.vo.DataSourceTypeVO"/>
<jsp:directive.page import="base.resource.util.StringUtil"/>
<%
	String contextpath = request.getContextPath();
	List dsTypeList= (List)request.getAttribute("dsTypeList");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="<%=contextpath%>/rwgl/css/style.css" rel="stylesheet" type="text/css" />
<title>新建数据源第一步</title>
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
function nextPage(){
    var radioObj= document.getElementsByName("DS_TYPE");
	var value=-1;
	for(var i=0;i<radioObj.length;i++){
		if(radioObj[i].checked== true){
			value= radioObj[i].value;
			break;
		}
	}
	if(value== -1){
		alert("请选择数据源");
		return;
	}else{
		document.frm.action="<%=contextpath%>/base/task/resource/datasource/NewDataSourceServlet?step=2";
	    document.frm.submit();
	}
}
function cancelback(){
	document.location.href="<%=contextpath%>/base/task/resource/datasource/DataSourceListServlet";
}
</script>
<body>
<form name="frm" method="post">
	

<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01" bgcolor="#FFFFFF">
<tr>
<td>
<fieldset>
<legend align="center">【第一步】请选择数据源类型</legend>
<table width="100%" border="0" cellpadding="1" cellspacing="1" align="center" >
<%
	for(int i=0;i<dsTypeList.size();i++){
		DataSourceTypeVO DSTVO= (DataSourceTypeVO)dsTypeList.get(i);
		String optionValue;
 %>
<tr><td align="left"><input type="radio" name="DS_TYPE" value="<%=DSTVO.getID() %>"><%=StringUtil.escapeHTMLTags(DSTVO.getDsTypeName()) %></td></tr>
<%
	}
 %>
</table>
</fieldset>
</td>
</tr>
</table>
<br>
<table width="60%" border="0" cellpadding="1" cellspacing="1" align="center" class="text01">
<tr><td align="center"><input type="button" name="next" value="下一步" onclick="nextPage();" class="input01">&nbsp;&nbsp; <input type="button" name="cancel" value="返回" onclick="cancelback();" class="input01"></td></tr>
</table>
</form>
</body>
</html>
