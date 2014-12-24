
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
%>
<BZ:html>
<BZ:head>
<title>选择组织</title>
<BZ:script isEdit="true" isDate="true"/>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao()
	{
	document.srcForm.action=path+"person/Person!changeOrg.action";
	document.srcForm.submit();
	}
	function _back(){
	document.srcForm.action=path+"person/Person!query.action";
	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<!-- 当前人员所在组织机构ID -->
<input type="hidden" id="ORG_ID" name="ORG_ID" value="<%=request.getAttribute(OrganPerson.ORG_ID) %>"/>
<!-- 人员编号,由前置Action传递 -->
<BZ:input field="PERSON_ID" prefix="OrganPerson_" type="hidden"/>
<div class="heading">选择组织</div>
<table class="contenttable">
<tr>
<td>加入组织树Tree标签</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>