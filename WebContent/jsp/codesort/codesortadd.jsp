
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
%>
<BZ:html>
<BZ:head>
<title>���ҳ��</title>
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
	document.srcForm.action=path+"CodeSortServlet?method=create";
	document.srcForm.submit();
	}
	function _back(){
	document.srcForm.action=path+"CodeSortServlet";
	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">���</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">����</td>
<td width="20%"><BZ:input field="CODESORTNAME" prefix="P_" notnull="����������" formTitle="����"/></td>
<td width="10%">����</td>
<td width="20%"><input type="text" name="P_CODESORTID" value=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>����</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_SORTDESC"></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset" />&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>