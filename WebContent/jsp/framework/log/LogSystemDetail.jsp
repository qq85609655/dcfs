
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<%
	Data data=(Data)request.getAttribute("data");
%>
<BZ:html> 
<BZ:head>
<title>详细页面</title>
<BZ:script/>
<script>
	function _back(){
		document.srcForm.action=path+"log/LogSys.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
<input type="hidden" name="LOGSYSEM_LOG_ID" value="<%=data.getString("LOG_ID","") %>" disabled="disabled"/>
<div class="kuangjia">
<div class="heading">详细</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">访问者ID</td>
<td width="20%">
	<input type="text" name="LOGSYSEM_ACTOR_ID"  value="<%=data.getString("ACTOR_ID","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">行为者名称</td>
<td width="20%">
	<input type="text" name="LOGSYSEM_ACTOR_NAME"  value="<%=data.getString("ACTOR_NAME","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">访问者名称</td>
<td width="20%">
	<input type="text" name="LOGSYSEM_ACTOR_NAME"  value="<%=data.getString("ACTOR_NAME","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">访问模块</td>
<td width="20%">
	<input type="text" name="LOGSYSEM_MODULE_ID"  value="<%=data.getString("MODULE_ID","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">访问资源ID</td>
<td width="20%">
	<input type="text" name="LOGSYSEM_RESOURCE_ID"  value="<%=data.getString("RESOURCE_ID","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">访问时间</td>
<td width="20%">
	<input type="text" name="LOGSYSEM_ACCESS_TIME"  value="<%=data.getString("ACCESS_TIME","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">日志级别</td>
<td width="20%">
	<input type="text" name="LOGSYSEM_LOG_LEVEL"  value="<%=data.getString("LOG_LEVEL","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>备注</td>
<td colspan="4">
	<textarea rows="6" style="width:80%" name="LOGSYSEM_MEMO" disabled="disabled"><%=data.getString("MEMO","") %></textarea>
</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>