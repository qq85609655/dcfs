
<%@page import="com.hx.framework.organ.vo.OrganType"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ page import="hx.database.databean.Data"%>
<%
%>
<BZ:html>
<BZ:head>
<title>���ҳ��</title>
<BZ:script isEdit="true" isDate="true" isAjax="true"/>
<script>
	
	function tijiao() {

		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		document.srcForm.action = path + "clustermanage/findCluster!modify.action";
		document.srcForm.submit();
		
	}
	
	function _back() {
		document.srcForm.action = path + "clustermanage/findCluster.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="PROTOCOL">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">�޸ļ�ȺԪ��</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">Ԫ�ر�ʶ</td>
<td width="20%">
<BZ:dataValue field="NODEID"  type="String"  defaultValue="" />
<BZ:input id="CLUSTERNODE_ID" field="NODEID" prefix="CLUSTERNODE_" formTitle="ID" notnull="������Ԫ��ID" type="hidden" defaultValue="" readonly="true"/>
</td>
<td width="10%">Э��</td>
<td width="20%">
	<BZ:select field="PROTOCOL" formTitle="Э��" prefix="CLUSTERNODE_" codeName="PROTOCOL" isCode="true">
		
	</BZ:select>
</td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�˿ں�</td>
<td width="20%"><BZ:input field="PORT" prefix="CLUSTERNODE_" notnull="������˿ں�" formTitle="�˿ں�" type="String" defaultValue=""/></td>
<td width="10%">Ԫ��IP��ַ</td>
<td width="20%"><BZ:input field="IPADDRESS" prefix="CLUSTERNODE_" formTitle="Ԫ�ص�IP��ַ" notnull="������IP��ַ" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�����ĸ�</td>
<td width="20%"><BZ:input field="CONTEXTPATH" prefix="CLUSTERNODE_" notnull="�����������ĸ�" formTitle="�����ĸ�" type="String" defaultValue=""/></td>
<td width="10%">��ȺID</td>
<td width="20%">
	<BZ:input field="CLUSTERID" prefix="CLUSTERNODE_" notnull="�����뼯Ⱥ������ID" restriction="int" formTitle="��ȺID" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>

<tr style="display: none;">
<td width="5%"></td>
<td width="10%">����ʱ��</td>
<td width="20%"><BZ:input field="ADDTIME" prefix="CLUSTERNODE_" notnull="��ѡ�񴴽�ʱ��" formTitle="����ʱ��" type="date" readonly="readonly"/></td>
<td width="10%">������</td>
<td width="20%">
	<BZ:input field="PERSON_ID" prefix="CLUSTERNODE_" notnull="�����봴���˵�����" formTitle="��Ⱥ�����˵�����" type="String" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>��ע</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="CLUSTERNODE_MEMO" ><%=((Data)request.getAttribute("data")).getString("MEMO")!=null?((Data)request.getAttribute("data")).getString("MEMO"):"" %></textarea></td>
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