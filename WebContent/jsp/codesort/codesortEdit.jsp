
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%
Data codedata=(Data)request.getAttribute("data");
%>
<%@page import="hx.database.databean.Data"%>
<BZ:html>
<BZ:head>
<title>修改页面</title>
<BZ:script/>
<script>
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
	document.srcForm.action=path+"CodeSortServlet?method=savecodesort";
	document.srcForm.submit();
	}
	function _back(){
	document.srcForm.action=path+"CodeSortServlet";
	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post"  >
<input type="hidden" name="P_CODESORTID" value="<%=codedata.getString("CODESORTID","") %>"/>
<div class="kuangjia">
<div class="heading">修改</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">名称</td>
<td width="20%"><BZ:input field="CODESORTNAME" type="String" prefix="P_" defaultValue="" notnull="请输入名称" formTitle="名称"/></td>
<td width="10%">代码</td>
<td width="20%"><input type="text" name="CODESORTID" value="<%=codedata.getString("CODESORTID","") %>" disabled="disabled"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>代码描述</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_SORTDESC"><%=codedata.getString("SORTDESC","") %></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>