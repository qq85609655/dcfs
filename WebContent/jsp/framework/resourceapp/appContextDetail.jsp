
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
Data data=(Data)request.getAttribute("data");
String appId=(String)request.getParameter("appId");
if(appId==null){
	appId="";
}
%>
<BZ:html>
<BZ:head>
<title>Ӧ�û�����Ϣ�鿴ҳ��</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		else{
			document.srcForm.action=path+"app/appContextModify.action";
 			document.srcForm.submit();
		}
	}
	function _back(){
	 	document.srcForm.action=path+"app/appContextList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="resourceappAdd">
<BZ:input field="ID" type="hidden" prefix="P_"/>
<BZ:input field="APP_ID" type="hidden" prefix="P_"/>
<input type="hidden" name="appId" value="<%=appId %>"/>
<div class="kuangjia">
<div class="heading">Ӧ�û�����Ϣ�鿴</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">Ӧ�ò���IP</td>
<td width="20%"><BZ:dataValue field="APP_IP" type="String" defaultValue="" /></td>
<td width="10%">�˿ں�</td>
<td width="20%"><BZ:dataValue field="APP_PORT" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">Ӧ�������ĸ�</td>
<td width="20%">/<BZ:dataValue field="APP_CONTEXT" type="String" defaultValue="" /></td>
<td colspan="3"></td>
</tr>
<tr>
<td></td>
<td>˵��</td>
<td colspan="4"><BZ:dataValue field="MEMO" type="String" defaultValue="" /></td>
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