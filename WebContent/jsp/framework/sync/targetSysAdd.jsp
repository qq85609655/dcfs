
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>Ŀ��ϵͳ���ҳ��</title>
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
<div class="heading">Ŀ��ϵͳ���</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="20%">Ŀ��ϵͳ����</td>
<td width="75%"><BZ:input field="TARGET_NAME" type="String" notnull="������Ŀ��ϵͳ����" formTitle="Ŀ��ϵͳ����" prefix="P_" defaultValue="" size="50"/></td>
</tr>
<tr>
<td></td>
<td>�û�ͬ��ʵ����</td>
<td><BZ:input field="USER_IMPL" type="String" notnull="�������û�ͬ��ʵ����" formTitle="�û�ͬ��ʵ����"  prefix="P_" defaultValue="" size="50"/></td>
</tr>
<tr>
<td></td>
<td>��֯ͬ��ʵ����</td>
<td><BZ:input field="ORG_IMPL" type="String" notnull="��������֯ͬ��ʵ����" formTitle="��֯ͬ��ʵ����" prefix="P_" defaultValue="" size="50"/></td>
</tr>
<tr>
<td></td>
<td>״̬</td>
<td><BZ:select field="STATUS" formTitle="" prefix="P_">
		<BZ:option value="0" selected="true">����</BZ:option>
		<BZ:option value="1">����</BZ:option>
	</BZ:select></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>