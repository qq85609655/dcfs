
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data data=(Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>Ŀ��ϵͳ�༭ҳ��</title>
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
		document.srcForm.action=path+"sync/modifyTargetSys.action";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"sync/TargetSys.action";
		document.srcForm.submit();
	}
	function gotoEditParam(paramType){
		document.srcForm.action=path+"sync/editParamToAdd.action";
		document.getElementById("paramType").value=paramType;
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="positionGradeAdd">
<div class="kuangjia">
<BZ:input field="TARGET_ID" type="hidden" prefix="P_" defaultValue=""/>
<input id="paramType" name="paramType" type="hidden" />
<input id="impl" name="impl" type="hidden" />
<div class="heading">Ŀ��ϵͳ�༭</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="20%">Ŀ��ϵͳ����</td>
<td width="75%"><BZ:input field="TARGET_NAME" type="String" notnull="������Ŀ��ϵͳ����" formTitle="Ŀ��ϵͳ����" prefix="P_" defaultValue="" size="50"/></td>
</tr>
<tr>
<td></td>
<td>�û�ͬ��ʵ����</td>
<td><BZ:input field="USER_IMPL" type="String" notnull="�������û�ͬ��ʵ����" formTitle="�û�ͬ��ʵ����"  prefix="P_" defaultValue="" size="50"/>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="gotoEditParam('userSync')">�༭����</a></td>
</tr>
<tr>
<td></td>
<td>��֯ͬ��ʵ����</td>
<td><BZ:input field="ORG_IMPL" type="String" notnull="��������֯ͬ��ʵ����" formTitle="��֯ͬ��ʵ����" prefix="P_" defaultValue="" size="50"/>&nbsp;&nbsp;<a href="javascript:void(0);" onclick="gotoEditParam('orgSync')">�༭����</a></td>
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