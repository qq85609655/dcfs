
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
<title>�˺��������ҳ��</title>
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
<div class="heading">�˺��������</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td>�˺���������</td>
<td><BZ:input field="CNAME" type="String" notnull="�������˺���������" formTitle="�˺���������" prefix="P_" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>�˺����ͱ���</td>
<td><BZ:input field="TYPE_CODE" type="String" notnull="�������˺����ͱ���" formTitle="�˺����ͱ���" prefix="P_" defaultValue=""/></td>
<td></td>
</tr>
<tr>
  <td></td>
  <td nowrap="nowrap">�Ƿ�����Key</td>
  <td><BZ:radio field="TYPE_EXT_VALUES"  prefix="P_" formTitle="" value="1">��</BZ:radio>&nbsp;&nbsp;&nbsp;&nbsp;<BZ:radio field="TYPE_EXT_VALUES"  prefix="P_" formTitle="" value="2">��</BZ:radio></td>
  <td></td>
</tr>
<tr>
<td></td>
<td>��ע</td>
<td><textarea rows="5" cols="100" name="P_MEMO"></textarea></td>
<td></td>
</tr>
<!-- 
<tr>
<td></td>
<td>��չ����Ԫ����</td>
<td colspan="3"><textarea rows="5" cols="100" name="P_EXT_METADATA"></textarea></td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>��չ����ֵ</td>
<td colspan="3">
    <textarea rows="5" cols="100" name="P_TYPE_EXT_VALUES"></textarea>
</td>
<td></td>
</tr>
 -->
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