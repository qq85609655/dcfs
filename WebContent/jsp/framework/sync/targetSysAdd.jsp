
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>目标系统添加页面</title>
<BZ:script tree="true"/>
<script type="text/javascript" language="javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame','mainFrame']);
});
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"sync/saveTargetSys.action";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"sync/TargetSys.action";
		document.srcForm.submit();
	}
	function gotoEditParam(){
		document.srcForm.action=path+"sync/editParamToAdd.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="positionGradeAdd">
<div class="kuangjia">
<div class="heading">目标系统添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="20%">目标系统名称</td>
<td width="75%"><BZ:input field="TARGET_NAME" type="String" notnull="请输入目标系统名称" formTitle="目标系统名称" prefix="P_" defaultValue="" size="50"/></td>
</tr>
<tr>
<td></td>
<td>用户同步实现类</td>
<td><BZ:input field="USER_IMPL" type="String" notnull="请输入用户同步实现类" formTitle="用户同步实现类"  prefix="P_" defaultValue="" size="50"/></td>
</tr>
<tr>
<td></td>
<td>组织同步实现类</td>
<td><BZ:input field="ORG_IMPL" type="String" notnull="请输入组织同步实现类" formTitle="组织同步实现类" prefix="P_" defaultValue="" size="50"/></td>
</tr>
<tr>
<td></td>
<td>状态</td>
<td><BZ:select field="STATUS" formTitle="" prefix="P_">
		<BZ:option value="0" selected="true">启用</BZ:option>
		<BZ:option value="1">禁用</BZ:option>
	</BZ:select></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>