
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
%>
<BZ:html>
<BZ:head>
<title>应用添加页面</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		else{
			if(confirm('是否要生成导航栏?')){
				document.srcForm.action=path+"app/resourceAppAdd.action?flag=1";
 				document.srcForm.submit();
			  }
			  else{
				document.srcForm.action=path+"app/resourceAppAdd.action?flag=2";
 				document.srcForm.submit();
			  }
		}
	}
	function _back(){
 	document.srcForm.action=path+"app/resourceAppList.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" token="resourceappAdd">
<div class="kuangjia">
<div class="heading">应用添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">应用系统名称</td>
<td width="20%"><BZ:input field="APP_NAME" type="String" prefix="P_" formTitle="应用系统名称" notnull="请输入应用系统名称" /></td>
<td width="10%">应用访问URL</td>
<td width="20%"><BZ:input field="URL_PREFIX" type="String" prefix="P_" /></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">开发商</td>
<td width="20%"><BZ:input field="DEVELOPER" type="String" prefix="P_" /></td>
<td width="10%">版本</td>
<td width="20%"><BZ:input field="VERSION" type="String" prefix="P_" /></td>
<td width="5%"></td>
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