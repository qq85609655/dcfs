<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
%>
<BZ:html>
<BZ:head>
<title>添加页面</title>
<BZ:script isEdit="true" isDate="true"/>
<link type="text/css" rel="stylesheet" href="<BZ:url/>/resource/style/base/form.css"/>
<script>
$(document).ready(function(){
	  dyniframesize([ 'mainFrame' ]);
});
	function tijiao()
	{
	var name = document.getElementById("ChannelType_NAME").value.trim();
	if(name==""){
		alert("类型名称不能为空，请填写！");
		return;
	}
	document.srcForm.action=path+"channel/ChannelType!add.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"channel/ChannelType!query.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">添加栏目类型</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">
	<font style="vertical-align: middle;" color="red">*</font>
	类型名称
</td>
<td width="20%"><BZ:input field="NAME" prefix="ChannelType_" id="ChannelType_NAME" type="String" defaultValue=""/></td>
<td width="10%">排序号</td>
<td width="20%"><BZ:input field="SEQ_NUM" prefix="ChannelType_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>状态</td>
<td colspan="4">
	<BZ:select field="STATUS" prefix="ChannelType_" formTitle="" className="rs-edit-select">
		<BZ:option value="1" selected="true">正常</BZ:option>
		<BZ:option value="2">禁用</BZ:option>
		<BZ:option value="3">删除</BZ:option>
	</BZ:select>
</td>
</tr>

<tr>
<td></td>
<td>说明</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="ChannelType_MEMO"></textarea></td>
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