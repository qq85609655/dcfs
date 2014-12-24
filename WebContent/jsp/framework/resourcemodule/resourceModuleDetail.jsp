
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String PMOUDLE=(String)request.getAttribute("PMOUDLE");
if(PMOUDLE==null){
    PMOUDLE="";
}
Data data=(Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>模块详细页面</title>
<BZ:script/>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _back(){
	document.srcForm.action=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>&PMOUDLE=<%=PMOUDLE%>";
	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<div class="kuangjia">
<div class="heading">应用系统详细</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">模块名称</td>
<td width="19%"><BZ:input field="CNAME" type="String" prefix="P_" defaultValue="" disabled="true"/></td>
<td width="12%">英文名称</td>
<td width="19%"><BZ:input field="ENNAME" type="String" prefix="P_" defaultValue="" disabled="true"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>父模块</td>
<td><BZ:input field="PNAME" id="PNAME" type="String" prefix="P_" defaultValue="" disabled="true"/></td>
<td>是否需要权限控制</td>
<td>是&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_" formTitle="权限控制" value="1" property="data" />&nbsp;&nbsp;否&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_" formTitle="权限控制" value="0" property="data" /></td>
<td></td>
</tr>
<tr>
<td></td>
<td>是否可管理</td>
<td>是&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="权限控制" value="1" property="data" />&nbsp;&nbsp;否&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="权限控制" value="0" property="data" /></td>
<td>状态</td>
<td><BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_"><BZ:option value="1">启用</BZ:option><BZ:option value="0">停用</BZ:option></BZ:select></td>
<td></td>
</tr>
<tr>
<td></td>
<td>描述</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO" disabled="true"><%=data.getString("MEMO","") %></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>