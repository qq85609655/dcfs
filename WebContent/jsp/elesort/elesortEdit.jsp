<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
Data codedata=(Data)request.getAttribute("data");
%>
<%@page import="hx.database.databean.Data"%>
<BZ:html>
<BZ:head>
<title>数据元分类修改页面</title>
<BZ:script/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
		document.srcForm.action=path+"EleSortServlet?method=updateElesort";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"EleSortServlet?method=eleSortList?p_PARENT_ID=<%=codedata.getString("PARENT_ID","0")%>";
		document.srcForm.submit();
	}
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post"  >
<input type="hidden" name="P_ELE_SORT_ID" value="<%=codedata.getString("ELE_SORT_ID","") %>"/>
<input type="hidden" name="P_PARENT_ID" value="<%=codedata.getString("PARENT_ID","0") %>"/>
<div class="kuangjia">
<div class="heading">数据元分类修改</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="20%">分类名称</td>
<td><BZ:input field="ELE_SORT_NAME" type="String" prefix="P_" defaultValue="" notnull="请输入分类名称" formTitle="分类名称"/></td>
<td width="20%">排序号</td>
<td><BZ:input field="SEQ_NUM" prefix="P_" notnull="请输入排序号" restriction="int" formTitle="排序号"/></td>

</tr>
<tr>
<td></td>
<td>描述</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_ELE_SORT_DESC"><%=codedata.getString("ELE_SORT_DESC","") %></textarea></td>
</tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>