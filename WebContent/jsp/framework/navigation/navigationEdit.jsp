
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.Data"%>
<%
Data data=(Data)request.getAttribute("data");
%>

<BZ:html>
<BZ:head>
<title>��Դ�޸�ҳ��</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		document.srcForm.action=path+"navigation/navigationModify.action";
	 	document.srcForm.submit();
	}
	function _back(){
	 	document.srcForm.action=path+"navigation/navigationList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="kuangjia">
<BZ:input field="URL_PROMPT" type="hidden" prefix="P_" size="50"/>
<BZ:input field="ID" type="hidden" prefix="P_" defaultValue=""/>
<div class="heading">�������޸�</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">����������</td>
<td width="20%"><BZ:input field="NAV_NAME" type="String" prefix="P_" notnull="�����뵼��������" formTitle="����������"/></td>
<td width="10%">��ʾ˳��</td>
<td width="20%"><BZ:input field="SEQ_NUM" type="String" prefix="P_" notnull="��������ʾ˳��" restriction="int" formTitle="��ʾ˳��"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>�˵�URLǰ׺</td>
<td colspan="3"><BZ:input field="URL_PREFIX" type="String" prefix="P_" size="50" formTitle="�˵�URLǰ׺" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>��ҳ��URL</td>
<td colspan="3"><BZ:input field="NAV_URL" type="String" prefix="P_" size="50" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>�����ļ�·��</td>
<td colspan="3"><BZ:input field="HELP_FILE_PATH" type="String" prefix="P_" size="50" defaultValue=""/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>״̬</td>
<td colspan="3"><BZ:select field="STATUS" formTitle="״̬" property="data" prefix="P_" width="130px"><BZ:option value="1"  >����</BZ:option><BZ:option value="0">ͣ��</BZ:option></BZ:select></td>
<td></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>