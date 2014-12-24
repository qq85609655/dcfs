
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String MODULE_ID=(String)request.getAttribute("MODULE_ID");
if(MODULE_ID==null){
	MODULE_ID="";
}
Data data=(Data)request.getAttribute("data");
 %>
<BZ:html>
<BZ:head>
<title>资源详细页面</title>
<BZ:script/>
<script>
$(document).ready(function() {
	dyniframesize(['mainFrame','mainFrame']);
});
	function _back(){
 	document.srcForm.action=path+"resource/resourcesList.action?APP_ID=<%=APP_ID%>&MODULE_ID=<%=MODULE_ID%>";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="P_MODULE_ID" value="<%=MODULE_ID%>"/>
<div class="kuangjia">
<div class="heading">应用系统详细</div>
<table class="contenttable">
<tr>
<td width="10%"></td>
<td width="10%">资源名称</td>
<td width="70%" colspan="3"><BZ:input field="CNAME" type="String" prefix="P_" disabled="true"/></td>
<td width="10%"></td>
</tr>
<tr>
<td></td>
<td>资源URL</td>
<td colspan="3"><BZ:input field="RES_URL" type="String" prefix="P_" size="50" disabled="true"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>资源权限控制URL</td>
<td colspan="3"><BZ:input field="CTR_URL" type="String" prefix="P_" size="50" disabled="true" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>创建时间</td>
<td colspan="3"><BZ:input field="CREATE_TIME" type="String" prefix="P_" disabled="true"/></td>
<td></td>
</tr>
<tr>
<td width="10%"></td>
<td width="10%">是否菜单入口</td>
<td width="30%">是&nbsp;<BZ:radio field="IS_NAVIGATE" prefix="P_" formTitle="菜单入口" value="1" property="data" />&nbsp;&nbsp;否&nbsp;<BZ:radio field="IS_NAVIGATE" prefix="P_" formTitle="菜单入口" value="0" property="data" /></td>
<td width="10%">状态</td>
<td width="30%"><BZ:select field="STATUS" formTitle="状态" property="data" prefix="P_"><BZ:option value="1">启用</BZ:option><BZ:option value="0">停用</BZ:option></BZ:select></td>
<td width="10%"></td>
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