
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
<%
Data data=(Data)request.getAttribute("data");
%>

<BZ:html>
<BZ:head>
<title>Ӧ���޸�ҳ��</title>
<BZ:script isDate="true"/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
	document.srcForm.action=path+"app/resourceAppModify.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"app/resourceAppList.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<BZ:input field="ID" type="hidden" prefix="P_" defaultValue=""/>
<div class="heading">Ӧ���޸�</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">Ӧ��ϵͳ����</td>
<td width="20%"><BZ:input field="APP_NAME" defaultValue="" type="String" prefix="P_" notnull="������Ӧ��ϵͳ����" formTitle="Ӧ��ϵͳ����"/></td>
<td width="10%">Ӧ�÷���URL</td>
<td width="20%"><BZ:input field="URL_PREFIX" type="String" prefix="P_" defaultValue=""/></td>

<td width="5%"></td>
<tr>
<td></td>
<td>������</td>
<td><BZ:input field="DEVELOPER" defaultValue="" type="String" prefix="P_"/></td>
<td>�汾</td>
<td><BZ:input field="VERSION" type="String" prefix="P_" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>˵��</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO"><%=data.getString("MEMO","") %></textarea></td>
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