<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>    
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String eleSortId=(String)request.getAttribute("eleSortId");
	Data data = (Data)request.getAttribute("data");
	String noback=request.getParameter("noback");
	if(noback==null){
		noback="";
	}
%>
<BZ:html>
<BZ:head>
<title>����Ԫ�޸�ҳ��</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
		document.srcForm.action=path+"EleSortServlet?method=editSaveDataEle";
	 	document.srcForm.submit();
	}
	function _back(){
	 	document.srcForm.action=path+"EleSortServlet?method=codelist&ELE_SORT_ID=<%=eleSortId%>";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<input type="hidden" name="P_ELE_SORT_ID"  value="<%=eleSortId %>"/>
<input type="hidden" name="P_UUID"  value="<%=data.getString("UUID") %>"/>
<input type="hidden" name="noback"  value="<%=noback %>"/>
<div class="kuangjia">
<div class="heading">����Ԫ�޸�</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">��ʾ��</td>
<td width="20%"><BZ:input field="DATA_ELE_ID" prefix="P_" notnull="�������ʾ��" formTitle="��ʾ��" defaultValue=""/></td>
<td width="10%">��������</td>
<td width="20%"><BZ:input field="ELE_NAME_ZH" prefix="P_" notnull="��������������" formTitle="��������" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">Ӣ������</td>
<td width="20%"><BZ:input field="ELE_NAME_EN" prefix="P_" formTitle="Ӣ������" defaultValue=""/></td>
<td width="10%">ͬ������</td>
<td width="20%"><BZ:input field="ELE_NAME_SYN" prefix="P_" formTitle="ͬ������" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>����</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_DEFINITION"><%=data.getString("DEFINITION") %></textarea></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">��������</td>
<td width="20%"><BZ:input field="DATA_TYPE" prefix="P_" notnull="��������������" formTitle="��������" defaultValue=""/></td>
<td width="10%">����ģʽ</td>
<td width="20%"><BZ:input field="SORT_MODE" prefix="P_" notnull="���������ģʽ" formTitle="����ģʽ" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">��ʾ��ʽ</td>
<td width="20%"><BZ:input field="SHOW_FORM" prefix="P_" notnull="�������ʾ��ʽ" formTitle="��ʾ��ʽ" defaultValue=""/></td>
<td width="10%">��ʾ��ʽ</td>
<td width="20%"><BZ:input field="SHOW_FORMAT" prefix="P_" notnull="�������ʾ��ʽ" formTitle="��ʾ��ʽ" defaultValue=""/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>����ֵ</td>
<td colspan="4"><BZ:input field="ALLOW_VALUE" prefix="P_" size="80" formTitle="����ֵ" defaultValue=""/></td>
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