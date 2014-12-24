
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String appId=(String)request.getParameter("appId");
if(appId==null){
	appId="";
}
%>
<BZ:html>
<BZ:head>
<title>应用环境信息添加页面</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		else{
			document.srcForm.action=path+"app/appContextAdd.action";
 			document.srcForm.submit();
		}
	}
	function _back(){
	 	document.srcForm.action=path+"app/appContextList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" token="resourceappAdd">
<input type="hidden" name="appId" value="<%=appId%>"/>
<div class="kuangjia">
<div class="heading">应用环境信息添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">应用部署IP</td>
<td width="20%"><BZ:input field="APP_IP" type="String" prefix="P_" formTitle="应用部署IP" notnull="请输入应用部署IP" /></td>
<td width="10%">端口号</td>
<td width="20%"><BZ:input field="APP_PORT" type="String" prefix="P_" formTitle="端口号" notnull="请输入端口号" /></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">应用上下文根</td>
<td width="20%">/<BZ:input field="APP_CONTEXT" type="String" prefix="P_" formTitle="应用上下文根" notnull="请输入应用上下文根" /></td>
<td width="5%" colspan="3"></td>
</tr>
<tr>
<td></td>
<td>说明</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO"></textarea></td>
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