
<%@page import="com.hx.framework.organ.vo.OrganType"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
<%
%>
<BZ:html>
<BZ:head>
<title>���ҳ��</title>
<BZ:script isEdit="true" isDate="true" isAjax="true"/>
<script>
	
	function _back() {
		document.srcForm.action = path + "clustermanage/findCluster.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">�鿴��ȺԪ��</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">ID</td>
<td width="20%">
<BZ:dataValue field="NODEID"  type="String" defaultValue=""/>
<BZ:dataValue field="PERSON_ID"  type="String" defaultValue=""/>
</td>
<td width="10%">��ȺIP��ַ</td>
<td width="20%"><BZ:dataValue field="IPADDRESS"  type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�˿ں�</td>
<td width="20%"><BZ:dataValue field="PORT"  type="String" defaultValue=""/></td>
<td width="10%">Э��</td>
<td width="20%">
	<BZ:dataValue field="PROTOCOL"  type="String" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�����ĸ�</td>
<td width="20%"><BZ:dataValue field="CONTEXTPATH"  type="String" defaultValue=""/></td>
<td width="10%">��ȺID</td>
<td width="20%">
	<BZ:dataValue field="CLUSTERID"  type="Number" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">����ʱ��</td>
<td width="20%"><BZ:dataValue field="ADDTIME"  type="Date" defaultValue=""/></td>
<td width="10%">������</td>
<td width="20%">
	<BZ:dataValue field="PERSON_ID"  type="String" defaultValue="" person="true"/>
</td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>��ע</td>
<td colspan="4"><BZ:dataValue field="MEMO" type="String" defaultValue="���ޱ�ע��Ϣ"></BZ:dataValue></td>
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