
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data data = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>��ӽ�ɫ��ҳ��</title>
<BZ:script isEdit="true"/>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao()
	{
	document.srcForm.action=path+"role/RoleGroup!modify.action";
	document.srcForm.submit();
	}

	function _back() {
		document.srcForm.action=path+"role/RoleGroup!queryChildrenPage.action?PARENT_ID=<%=request.getAttribute(RoleGroup.PARENT_ID)%>";
		document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">�鿴��ɫ��</div>
<!-- ��֯����ID -->
<input name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">��ɫ��ID</td>
<td width="20%"><BZ:dataValue field="ID" type="String" defaultValue=""/></td>
<td width="10%">��ɫ������</td>
<td width="20%"><BZ:dataValue field="CNAME" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>��ע</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="RoleGroup_MEMO" readonly><%=data.getString("MEMO")!=null?data.getString("MEMO"):"" %></textarea></td>
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