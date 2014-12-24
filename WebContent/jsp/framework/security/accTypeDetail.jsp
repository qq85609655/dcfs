
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
<title>账号类型修改页面</title>
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
<div class="heading">账号类型</div>
<table class="contenttable">
<tr>
<td></td>
<td>账号类型名称</td>
<td><BZ:dataValue field="CNAME" ></BZ:dataValue></td>
<td></td>
</tr>
<tr>
<td></td>
<td>账号类型编码</td>
<td><BZ:dataValue field="TYPE_CODE" ></BZ:dataValue></td>
<td></td>
</tr>
<tr>
  <td></td>
  <td nowrap="nowrap">是否绑定域和Key</td>
  <td><BZ:dataValue field="TYPE_EXT_VALUES" checkValue="1=是;2=否"></BZ:dataValue></td>
  <td></td>
</tr>
<tr>
<td></td>
<td>备注</td>
<td><%=accData.getString("MEMO","") %></td>
<td></td>
</tr>
<!-- 
<tr>
<td></td>
<td>扩展属性元数据</td>
<td colspan="3"><%=accData.getString("EXT_METADATA","") %></td>
<td>
</td>
</tr>
<tr>
<td></td>
<td>扩展属性值</td>
<td colspan="3">
   <%=accData.getString("TYPE_EXT_VALUES","") %>
</td>
<td></td>
</tr>
 -->
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>