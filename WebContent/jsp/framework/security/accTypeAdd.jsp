
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%

request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>账号类型添加页面</title>
<BZ:script tree="true" isEdit="true"/>
<script type="text/javascript" language="javascript">
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action=path+"accType/accTypeAdd.action";
	 	document.srcForm.submit();
	}
	function _back()
	{
		document.srcForm.action=path+"accType/accTypeList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="accountTypeAdd">
<div class="kuangjia">
<div class="heading">账号类型添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td>账号类型名称</td>
<td><BZ:input field="CNAME" type="String" notnull="请输入账号类型名称" formTitle="账号类型名称" prefix="P_" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>账号类型编码</td>
<td><BZ:input field="TYPE_CODE" type="String" notnull="请输入账号类型编码" formTitle="账号类型编码" prefix="P_" defaultValue=""/></td>
<td></td>
</tr>
<tr>
  <td></td>
  <td nowrap="nowrap">是否绑定域和Key</td>
  <td><BZ:radio field="TYPE_EXT_VALUES"  prefix="P_" formTitle="" value="1">是</BZ:radio>&nbsp;&nbsp;&nbsp;&nbsp;<BZ:radio field="TYPE_EXT_VALUES"  prefix="P_" formTitle="" value="2">否</BZ:radio></td>
  <td></td>
</tr>
<tr>
<td></td>
<td>备注</td>
<td><textarea rows="5" cols="100" name="P_MEMO"></textarea></td>
<td></td>
</tr>
<!-- 
<tr>
<td></td>
<td>扩展属性元数据</td>
<td colspan="3"><textarea rows="5" cols="100" name="P_EXT_METADATA"></textarea></td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>扩展属性值</td>
<td colspan="3">
    <textarea rows="5" cols="100" name="P_TYPE_EXT_VALUES"></textarea>
</td>
<td></td>
</tr>
 -->
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