
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String MODULE_ID=(String)request.getAttribute("MODULE_ID");
if(MODULE_ID==null){
	MODULE_ID="";
}
Data data=(Data)request.getAttribute("data");
 %>
<BZ:html>
<BZ:head>
<title>��Դ��ϸҳ��</title>
<BZ:script/>
<script>
$(document).ready(function() {
	dyniframesize(['mainFrame','mainFrame']);
});
	function _back(){
 	document.srcForm.action=path+"resource/resourcesList.action?APP_ID=<%=APP_ID%>&MODULE_ID=<%=MODULE_ID%>";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="P_MODULE_ID" value="<%=MODULE_ID%>"/>
<div class="kuangjia">
<div class="heading">Ӧ��ϵͳ��ϸ</div>
<table class="contenttable">
<tr>
<td width="10%"></td>
<td width="10%">��Դ����</td>
<td width="70%" colspan="3"><BZ:input field="CNAME" type="String" prefix="P_" disabled="true"/></td>
<td width="10%"></td>
</tr>
<tr>
<td></td>
<td>��ԴURL</td>
<td colspan="3"><BZ:input field="RES_URL" type="String" prefix="P_" size="50" disabled="true"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>��ԴȨ�޿���URL</td>
<td colspan="3"><BZ:input field="CTR_URL" type="String" prefix="P_" size="50" disabled="true" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>����ʱ��</td>
<td colspan="3"><BZ:input field="CREATE_TIME" type="String" prefix="P_" disabled="true"/></td>
<td></td>
</tr>
<tr>
<td width="10%"></td>
<td width="10%">�Ƿ�˵����</td>
<td width="30%">��&nbsp;<BZ:radio field="IS_NAVIGATE" prefix="P_" formTitle="�˵����" value="1" property="data" />&nbsp;&nbsp;��&nbsp;<BZ:radio field="IS_NAVIGATE" prefix="P_" formTitle="�˵����" value="0" property="data" /></td>
<td width="10%">״̬</td>
<td width="30%"><BZ:select field="STATUS" formTitle="״̬" property="data" prefix="P_"><BZ:option value="1">����</BZ:option><BZ:option value="0">ͣ��</BZ:option></BZ:select></td>
<td width="10%"></td>
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