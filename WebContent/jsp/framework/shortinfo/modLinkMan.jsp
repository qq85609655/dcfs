
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String organId = (String)request.getAttribute("ORGAN_ID");
if(organId == null){
    organId = "";
}

Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>修改页面</title>
<BZ:script isEdit="true" isDate="true"/>
<script>
	function tijiao()
	{
	document.srcForm.action=path+"linkman/modify.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"linkman/outerlist.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<!-- 组织ID -->
<input type="hidden" name="ORGAN_ID" value="<%=organId%>"/>

<BZ:input field="ID" prefix="Man_" type="hidden"/>
<div class="kuangjia">
<div class="heading">修改联系人</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">姓名</td>
<td width="40%"><BZ:input field="CNAME" prefix="Man_" type="String" size="20" defaultValue=""/></td>
<td width="10%">手机号</td>
<td width="25%"><BZ:input field="MOBILE" prefix="Man_" defaultValue=""/></td>
<td width="10%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">单位</td>
<td width="40%"><BZ:input field="ORGNAME" prefix="Man_" type="String" size="20" defaultValue=""/></td>
<td width="10%"></td>
<td width="25%"></td>
<td width="10%"></td>
</tr>
<tr>
<td></td>
<td>备注</td>
<td colspan="4"><textarea rows="4" style="width:80%" name="Man_MEMO"></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_save" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>