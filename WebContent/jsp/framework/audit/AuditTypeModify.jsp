
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
<title>修改页面</title>
<BZ:script/>
<script>
	function _submit() {
		document.srcForm.action=path+"audit/AuditType!modify.action";
	 	document.srcForm.submit();
	}
	function _back() {
	 	document.srcForm.action=path+"audit/AuditType.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
<input type="hidden" name="TYPE_ID" value="<%=data.getString("ID","") %>"/>
<div class="kuangjia">
<div class="heading">修改</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">名称</td>
<td width="20%">
	<input type="text" name="TYPE_CNAME" value="<%=data.getString("CNAME","") %>"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>代码描述</td>
<td colspan="4">
	<textarea rows="6" style="width:80%" name="TYPE_MEMO"><%=data.getString("MEMO","") %></textarea>
</td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<input type="button" value="保存" class="button_add" onclick="_submit()"/>&nbsp;&nbsp;
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>