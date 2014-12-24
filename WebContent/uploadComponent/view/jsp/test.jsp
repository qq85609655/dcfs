<%@page import="com.hx.upload.datasource.DatasourceManager"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String path = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>附件</title>
</head>
<body>
<table border="1">
	<tr>
		<td>
			<iframe name="att" src="<%=path %>/att/Att.<%=DatasourceManager.getRequestPrefix() %>?param=attFrame&OP_TYPE=edit&PACKAGE_ID=1&ATT_TYPE=TEST" scrolling="no" frameborder="0"></iframe>			
		</td>
	</tr>
	<tr>
		<td>
			asdf			
		</td>
	</tr>
</table>
</body>
</html>