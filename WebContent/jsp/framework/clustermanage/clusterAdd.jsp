
<%@page import="com.hx.framework.organ.vo.OrganType"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
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
		}else{
			var param = "CLUSTERNODE_ID="+document.getElementById("CLUSTERNODE_ID").value;
			var flag = getDataList("com.hx.framework.clustermanage.ClusterAddAjax",param);
			if(flag){
				alert("��ȺԪ��ID�Ѿ����ڣ�");
			}else{
				document.srcForm.action = path + "clustermanage/findCluster!add.action";
				document.srcForm.submit();
			}
		}
	}
	
	function _back() {
		document.srcForm.action = path + "clustermanage/findCluster.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data" codeNames="PROTOCOL;CLUSTER_ID">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">��Ӽ�Ⱥ�ڵ�</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">�ڵ��ʶ</td>
<td width="20%">
<BZ:input id="CLUSTERNODE_ID" field="NODEID" prefix="CLUSTERNODE_" formTitle="ID" notnull="������Ԫ��ID" type="String" defaultValue=""/>common-config�����õ�nodeId
</td>
<td width="10%">Э��</td>
<td width="20%">
	<BZ:select field="PROTOCOL" formTitle="Э��" prefix="CLUSTERNODE_" codeName="PROTOCOL" isCode="true">
		<!-- 
		<BZ:option value="http" selected="true">http</BZ:option>
		<BZ:option value="https">https</BZ:option>
		 -->
	</BZ:select>
</td>
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
	<BZ:select field="CLUSTERID" formTitle="��ȺID" prefix="CLUSTERNODE_" codeName="CLUSTER_ID" isCode="true"></BZ:select>
</td>
<td width="5%"></td>
</tr>
<!-- 
<tr>
<td width="5%"></td>
<td width="10%">����ʱ��</td>
<td width="20%"><BZ:input field="ADDTIME" prefix="CLUSTERNODE_" notnull="��ѡ�񴴽�ʱ��" formTitle="����ʱ��" type="date" readonly="readonly"/></td>
<td width="10%">������</td>
<td width="20%">
	<BZ:input field="PERSON_ID" prefix="CLUSTERNODE_" notnull="�����봴���˵�����" formTitle="��Ⱥ�����˵�����" type="String" defaultValue=""/>
</td>
<td width="5%"></td>
</tr>
 -->
<tr>
<td></td>
<td>��ע</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="CLUSTERNODE_MEMO"></textarea></td>
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