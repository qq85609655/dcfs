
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
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
<title>��Դ�޸�ҳ��</title>
<BZ:script isEdit="true" />
<script>
$(document).ready(function() {
	dyniframesize(['mainFrame','mainFrame']);
});
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		document.srcForm.action=path+"resource/resourcesModify.action";
 		document.srcForm.submit();
	}
	function _back(){
 		document.srcForm.action=path+"resource/resourcesList.action?APP_ID=<%=APP_ID%>&MODULE_ID=<%=MODULE_ID%>";
 		document.srcForm.submit();
	}
	function _change(bl){
		if(bl=='1'){
			document.getElementById("CTR_URL").disabled = false;
		}
		if(bl=='2'){
			document.getElementById("CTR_URL").disabled = true;
		}
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="P_MODULE_ID" value="<%=MODULE_ID%>"/>
<div class="kuangjia">
<BZ:input field="ID" type="hidden" prefix="P_" defaultValue=""/>
<div class="heading">��Դ�޸�</div>
<table class="contenttable">
<tr>
<td width="10%"></td>
<td width="20%">��Դ����</td>
<td width="60%" colspan="3"><BZ:input field="CNAME" type="String" prefix="P_" notnull="��������Դ����" formTitle="��Դ����"/></td>
<td width="10%"></td>
</tr>
<tr>
<td></td>
<td>��ԴURL</td>
<td colspan="3"><BZ:input field="RES_URL" type="String" prefix="P_" size="50" notnull="��������Դ����" formTitle="��Դ����"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td >�Ƿ�Ȩ�޿���</td>
<td colspan="3">��&nbsp;<BZ:radio field="IS_VERIFY_AUTH" prefix="P_" formTitle="�Ƿ���ҪȨ�޿���" value="1" property="data"  onclick="_change('1')"/>&nbsp;&nbsp;��&nbsp;<BZ:radio field="IS_VERIFY_AUTH" prefix="P_" formTitle="�Ƿ���ҪȨ�޿���" value="0" property="data"  onclick="_change('2')"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>��ԴȨ�޿���URL</td>
<td colspan="3"><BZ:input id="CTR_URL" field="CTR_URL" type="String" prefix="P_" size="50" formTitle="��ԴȨ�޿���URL" defaultValue=""/></td>
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
<td colspan="4"><textarea rows="6" style="width:80%" name="P_MEMO"><%=data.getString("MEMO","") %></textarea></td>
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