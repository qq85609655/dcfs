
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
%>
<BZ:html>
<BZ:head>
<title>ѡ����֯</title>
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
<!-- ��ǰ��Ա������֯����ID -->
<input type="hidden" id="ORG_ID" name="ORG_ID" value="<%=request.getAttribute(OrganPerson.ORG_ID) %>"/>
<!-- ��Ա���,��ǰ��Action���� -->
<BZ:input field="PERSON_ID" prefix="OrganPerson_" type="hidden"/>
<div class="heading">ѡ����֯</div>
<table class="contenttable">
<tr>
<td>������֯��Tree��ǩ</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>