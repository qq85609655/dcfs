<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@page import="hx.database.databean.DataList"%>
<%
Data codedata=(Data)request.getAttribute("data");
String CODESORTID=(String)request.getAttribute("CODESORTID");

String noback=request.getParameter("noback");
if(noback==null){
	noback="";
}

%>
<%@page import="hx.database.databean.Data"%>
<BZ:html>
<BZ:head>
<title>详细页面</title>
<BZ:script/>
<script>
	function _back(){
 	document.srcForm.action=path+"CodeSortServlet?method=codelist";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post">
<input type="hidden" name="CODESORTID" value="<%=CODESORTID%>"/>
<input type="hidden" name="noback"  value="<%=noback %>"/>
<div class="kuangjia">
<div class="heading">添加</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">代码名称</td>
<td width="20%"><input type="text" name="P_CODENAME" value="<%=codedata.getString("CODENAME","") %>" disabled="disabled"/></td>
<td width="10%">代码值</td>
<td width="20%"><input type="text" name="P_CODEVALUE" value="<%=codedata.getString("CODEVALUE","") %>" disabled="disabled"/></td>
<td width="5%"></td>
</tr>
<tr>
<td></td>
<td>字母码</td>
<td><input type="text" name="P_CODELETTER" value="<%=codedata.getString("CODELETTER","") %>" disabled="disabled"/></td>
<td>排序号</td>
<td><input type="text" name="P_PNO" value="<%=codedata.getString("PNO","") %>" disabled="disabled"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>上级代码</td>
<td><input type="text" name="P_PARENTCODENAME" value="<%=codedata.getString("PARENTCODENAME","")%>" disabled="disabled"/></td>
<td>上级代码值</td>
<td><input type="text" name="P_PARENTCODEVALUE" value="<%=codedata.getString("PARENTCODEVALUE","")%>" disabled="disabled"/></td>
<td></td>
</tr>
<tr>
<td></td>
<td>代码描述</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="P_CODEDESC" disabled="disabled"><%=codedata.getString("CODEDESC","") %></textarea></td>
</tr>
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