
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String PMOUDLE=(String)request.getAttribute("PMOUDLE");
if(PMOUDLE==null){
    PMOUDLE="";
}
Data data=(Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>ģ����ϸҳ��</title>
<BZ:script/>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _back(){
	document.srcForm.action=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>&PMOUDLE=<%=PMOUDLE%>";
	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<div class="kuangjia">
<div class="heading">Ӧ��ϵͳ��ϸ</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">ģ������</td>
<td width="19%"><BZ:input field="CNAME" type="String" prefix="P_" defaultValue="" disabled="true"/></td>
<td width="12%">Ӣ������</td>
<td width="19%"><BZ:input field="ENNAME" type="String" prefix="P_" defaultValue="" disabled="true"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>��ģ��</td>
<td><BZ:input field="PNAME" id="PNAME" type="String" prefix="P_" defaultValue="" disabled="true"/></td>
<td>�Ƿ���ҪȨ�޿���</td>
<td>��&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_" formTitle="Ȩ�޿���" value="1" property="data" />&nbsp;&nbsp;��&nbsp;<BZ:radio field="NEED_RIGHT" prefix="P_" formTitle="Ȩ�޿���" value="0" property="data" /></td>
<td></td>
</tr>
<tr>
<td></td>
<td>�Ƿ�ɹ���</td>
<td>��&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="Ȩ�޿���" value="1" property="data" />&nbsp;&nbsp;��&nbsp;<BZ:radio field="ADMIN_FLAG" prefix="P_" formTitle="Ȩ�޿���" value="0" property="data" /></td>
<td>״̬</td>
<td><BZ:select field="STATUS" formTitle="״̬" property="data" prefix="P_"><BZ:option value="1">����</BZ:option><BZ:option value="0">ͣ��</BZ:option></BZ:select></td>
<td></td>
</tr>
<tr>
<td></td>
<td>����</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO" disabled="true"><%=data.getString("MEMO","") %></textarea></td>
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