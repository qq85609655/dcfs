
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
%>
<BZ:html>
<BZ:head>
<title>Ӧ�����ҳ��</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
		}
		else{
			if(confirm('�Ƿ�Ҫ���ɵ�����?')){
				document.srcForm.action=path+"app/resourceAppAdd.action?flag=1";
 				document.srcForm.submit();
			  }
			  else{
				document.srcForm.action=path+"app/resourceAppAdd.action?flag=2";
 				document.srcForm.submit();
			  }
		}
	}
	function _back(){
 	document.srcForm.action=path+"app/resourceAppList.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" token="resourceappAdd">
<div class="kuangjia">
<div class="heading">Ӧ�����</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">Ӧ��ϵͳ����</td>
<td width="20%"><BZ:input field="APP_NAME" type="String" prefix="P_" formTitle="Ӧ��ϵͳ����" notnull="������Ӧ��ϵͳ����" /></td>
<td width="10%">Ӧ�÷���URL</td>
<td width="20%"><BZ:input field="URL_PREFIX" type="String" prefix="P_" /></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">������</td>
<td width="20%"><BZ:input field="DEVELOPER" type="String" prefix="P_" /></td>
<td width="10%">�汾</td>
<td width="20%"><BZ:input field="VERSION" type="String" prefix="P_" /></td>
<td width="5%"></td>
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