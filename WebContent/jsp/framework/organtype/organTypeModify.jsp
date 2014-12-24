
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<BZ:html>
<BZ:head>
<title>修改组织机构类型</title>
<BZ:script isEdit="true" isDate="true"/>
<script>
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
	document.srcForm.action=path+"organ/OrganType!modify.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"organ/OrganType!query.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<BZ:input field="ID" type="hidden" defaultValue="" prefix="OrganType_"/>
<div class="kuangjia">
<div class="heading">修改组织机构类型</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">类型ID</td>
<td width="20%">
<BZ:dataValue field="ID"  type="String"  defaultValue="" /></td>
<td width="10%"></td>
<td width="20%"><BZ:input field="TYPE_CODE" prefix="OrganType_" formTitle="类型编码" notnull="请输入类型编码" type="hidden" defaultValue="0"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">类型名称</td>
<td width="20%"><BZ:input field="CNAME" prefix="OrganType_" notnull="请输入类型名称" formTitle="类型名称" type="String" defaultValue=""/></td>
<td width="10%">是否系统内置</td>
<td width="20%">
	<BZ:select field="IS_RESERVED" formTitle="" prefix="OrganType_">
		<BZ:option value="1">内置</BZ:option>
		<BZ:option value="0">非内置</BZ:option>
	</BZ:select>
</td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td width="10%">创建时间</td>
<td width="20%"><BZ:input field="CREATE_TIME" prefix="OrganType_" notnull="请选择创建时间" formTitle="创建时间" type="date" readonly="readonly"/></td>
<td>状态</td>
<td colspan="4">
	<BZ:select field="STATUS" formTitle="" prefix="OrganType_">
		<BZ:option value="1">有效</BZ:option>
		<BZ:option value="2">禁用</BZ:option>
		<BZ:option value="3">删除</BZ:option>
	</BZ:select>	
</td>
</tr>

<tr>
<td></td>
<td>备注</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="OrganType_MEMO"><%=((Data)request.getAttribute("data")).getString("MEMO")!=null?((Data)request.getAttribute("data")).getString("MEMO"):"" %></textarea></td>
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