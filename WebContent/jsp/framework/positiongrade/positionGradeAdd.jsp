
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
request.setAttribute("data",new Data());
%>
<BZ:html>
<BZ:head>
<title>ְ�����ҳ��</title>
<BZ:script tree="true"/>
<script type="text/javascript" language="javascript">
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
	document.srcForm.action=path+"positiongrade/positionGradeAdd.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"positiongrade/positionGradeList.action";
 	document.srcForm.submit();
	}
	
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="positionGradeAdd">
<div class="kuangjia">
<div class="heading">ְ�����</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">ְ������</td>
<td width="20%"><BZ:input field="CNAME" type="String" notnull="������ְ������" formTitle="ְ������" prefix="P_" defaultValue=""/></td>
<td width="10%">ְ���������</td>
<td width="20%"><BZ:input field="PG_CODE" type="String" prefix="P_" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>�����</td>
<td><BZ:input field="SEQ_NUM" type="String" notnull="�����������" formTitle="�����" restriction="int" prefix="P_" defaultValue=""/></td>
<td>����</td>
<td><BZ:input field="GRADE" type="String" prefix="P_" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>˵��</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO"></textarea></td>
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