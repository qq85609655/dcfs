
<%@ page language="java" contentType="text/html; charset=GBK"  pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<BZ:html>
<BZ:head>
<title>��֯����������ϸ��Ϣ</title>
<BZ:script isEdit="true" isDate="true"/>
<script>
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
<div class="heading">��֯����������ϸ��Ϣ</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">����ID</td>
<td width="20%"><BZ:dataValue field="ID"  type="String" defaultValue=""/></td>
<td width="10%"></td>
<td width="20%"></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��������</td>
<td width="20%"><BZ:dataValue field="CNAME" type="String" defaultValue=""/></td>
<td width="10%">�Ƿ�ϵͳ����</td>
<td width="20%">
	<BZ:dataValue field="IS_RESERVED" type="String" defaultValue="" checkValue="1=����;0=������"/>
</td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td width="10%">����ʱ��</td>
<td width="20%">
	<BZ:dataValue field="CREATE_TIME"  type="date"  defaultValue="" />
</td>
<td>״̬</td>
<td colspan="4">
	<BZ:dataValue field="STATUS" type="String" defaultValue="" checkValue="1=��Ч;2=����;3=ɾ��"/>
</td>
</tr>

<tr>
<td></td>
<td>��ע</td>
<td colspan="4">
	<textarea disabled="disabled" rows="6" style="width:80%" name="OrganType_MEMO"><%=((Data)request.getAttribute("data")).getString("MEMO")!=null?((Data)request.getAttribute("data")).getString("MEMO"):"" %></textarea>
</td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>