<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data data = new Data();
	request.setAttribute("data", data);
%>
<BZ:html>
	<BZ:head>
		<title>记者档案库列表</title>
		
		<BZ:webScript list="true" tree="true"/>
		
	</BZ:head>
	<script>
		$(document).ready(function() {
			dyniframesize(['mainFrame']);
		});
	</script>
	<BZ:body property="data">
		<BZ:input field="AREA_CODE" prefix="Organ_" helperCode="SYS_AREA_CODE" type="helper" helperTitle="选择地区" treeType="0" helperSync="true" showParent="false" style="width:100px;"/>
	</BZ:body>
</BZ:html>
