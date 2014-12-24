
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
			var param = "ORGAN_TYPE_ID="+document.getElementById("ORGAN_TYPE_ID").value;
			var flag = getDataList("com.hx.framework.organ.OrganTypeAddAjax",param);
			if(flag){
				alert("��֯�ṹ����ID�Ѿ����ڣ�");
			}else{
				document.srcForm.action = path + "organ/OrganType!add.action";
				document.srcForm.submit();
			}
		}
	}
	
	function _back() {
		document.srcForm.action = path + "organ/OrganType!query.action";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="organTypeAdd">
<div class="kuangjia">
<div class="heading">�����֯��������</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">����ID</td>
<td width="20%">
<BZ:input id="ORGAN_TYPE_ID" field="ID" prefix="OrganType_" formTitle="����ID" notnull="����������ID" restriction="int" defaultValue=""/>
</td>
<td width="10%"></td>
<td width="20%"><BZ:input field="TYPE_CODE" prefix="OrganType_" formTitle="���ͱ���" notnull="���������ͱ���" type="hidden" defaultValue="0"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��������</td>
<td width="20%"><BZ:input field="CNAME" prefix="OrganType_" notnull="��������������" formTitle="��������" type="String" defaultValue=""/></td>
<td width="10%">�Ƿ�ϵͳ����</td>
<td width="20%">
	<BZ:select field="IS_RESERVED" formTitle="" prefix="OrganType_">
		<BZ:option value="1" selected="true">����</BZ:option>
		<BZ:option value="0">������</BZ:option>
	</BZ:select>
</td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">����ʱ��</td>
<td width="20%"><BZ:input field="CREATE_TIME" prefix="OrganType_" notnull="��ѡ�񴴽�ʱ��" formTitle="����ʱ��" type="date" readonly="readonly"/></td>
<td width="10%">״̬</td>
<td width="20%">
	<BZ:select field="STATUS" formTitle="" prefix="OrganType_">
		<BZ:option value="1" selected="true">��Ч</BZ:option>
		<BZ:option value="2">����</BZ:option>
		<BZ:option value="3">ɾ��</BZ:option>
	</BZ:select>
</td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>��ע</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="OrganType_MEMO"></textarea></td>
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