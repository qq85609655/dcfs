<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String parentId = (String)request.getAttribute("parentId");
	if(parentId==null &&"".equals(parentId)){
		parentId="0";
	}
%>
<BZ:html>
<BZ:head>
<title>����Ԫ�������ҳ��</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
		document.srcForm.action=path+"EleSortServlet?method=createSort";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"EleSortServlet?method=eleSortList&p_PARENT_ID=<%=parentId%>";
		document.srcForm.submit();
	}
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" >
<input type="hidden" name="P_PARENT_ID" value="<%=parentId %>"/>
<div class="kuangjia">
<div class="heading">����Ԫ�������</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="20%">��������</td>
<td><BZ:input field="ELE_SORT_NAME" prefix="P_" notnull="�������������" formTitle="��������"/></td>
<td width="20%">�����</td>
<td><BZ:input field="SEQ_NUM" prefix="P_" notnull="�����������" restriction="int" formTitle="�����"/></td>

</tr>
<tr>
<td></td>
<td>����</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_ELE_SORT_DESC"></textarea></td>
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