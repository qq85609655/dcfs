
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
  Data accData = (Data)request.getAttribute("data");
%>
<BZ:html>
<BZ:head>
<title>�˺������޸�ҳ��</title>
<BZ:script tree="true" isEdit="true"/>
<script type="text/javascript" language="javascript">
	function _back()
	{
		document.srcForm.action=path+"accType/accTypeList.action";
	 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<BZ:input field="ID" type="hidden" prefix="P_" defaultValue="" />
<div class="kuangjia">
<div class="heading">�˺�����</div>
<table class="contenttable">
<tr>
<td></td>
<td>�˺���������</td>
<td><BZ:dataValue field="CNAME" ></BZ:dataValue></td>
<td></td>
</tr>
<tr>
<td></td>
<td>�˺����ͱ���</td>
<td><BZ:dataValue field="TYPE_CODE" ></BZ:dataValue></td>
<td></td>
</tr>
<tr>
  <td></td>
  <td nowrap="nowrap">�Ƿ�����Key</td>
  <td><BZ:dataValue field="TYPE_EXT_VALUES" checkValue="1=��;2=��"></BZ:dataValue></td>
  <td></td>
</tr>
<tr>
<td></td>
<td>��ע</td>
<td><%=accData.getString("MEMO","") %></td>
<td></td>
</tr>
<!-- 
<tr>
<td></td>
<td>��չ����Ԫ����</td>
<td colspan="3"><%=accData.getString("EXT_METADATA","") %></td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>��չ����ֵ</td>
<td colspan="3">
   <%=accData.getString("TYPE_EXT_VALUES","") %>
</td>
<td></td>
</tr>
 -->
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