
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%@page import="hx.database.databean.Data"%>
<% 
	Data data=(Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>�޸�ҳ��</title>
<BZ:script/>
<script>
	function _back(){
	 	document.srcForm.action=path+"audit/AuditType.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
	<input type="hidden" name="SYSTEM_ACT_ID" value="<%=data.getString("ACT_ID","") %>" disabled="disabled"/>
<div class="kuangjia">
<div class="heading">��ϸ</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">��Ϊ��ID</td>
<td width="20%">
	<input type="text" name="SYSTEM_ACTOR_ID"  value="<%=data.getString("ACTOR_ID","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">��Ϊ������</td>
<td width="20%">
	<input type="text" name="SYSTEM_ACTOR_NAME"  value="<%=data.getString("ACTOR_NAME","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">���߷���ID</td>
<td width="20%">
	<input type="text" name="SYSTEM_ACT_TYPE_ID"  value="<%=data.getString("ACT_TYPE_ID","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">������Ϊ</td>
<td width="20%"><input type="text" name="SYSTEM_ACT_ACTION"  value="<%=data.getString("ACT_ACTION","") %>" disabled="disabled"/></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">��������</td>
<td width="20%">
	<input type="text" name="SYSTEM_ACT_OBJ"  value="<%=data.getString("ACT_OBJ","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">��Ϊʱ��</td>
<td width="20%">
	<input type="text" name="SYSTEM_ACT_TIME"  value="<%=data.getString("ACT_TIME","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">��Ϊ����</td>
<td width="20%">
	<input type="text" name="SYSTEM_ACT_LEVEL"  value="<%=data.getString("ACT_LEVEL","") %>" disabled="disabled"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>��Ϊ��Ϣ</td>
<td colspan="4">
	<textarea rows="6" style="width:80%" name="SYSTEM_ACT_MESSAGE" disabled="disabled"><%=data.getString("ACT_MESSAGE","") %></textarea>
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