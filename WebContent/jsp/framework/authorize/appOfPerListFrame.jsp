
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <% 
 	String path=request.getContextPath();
 %>
<html>
<head>
<title>应用列表</title>
</head>
<body>
<iframe width="100%" height="100%" scrolling="auto" frameborder="0" src="<%=path %>/role/Authorize!queryAppOfPerson.action?PERSON_IDS=<%=request.getAttribute("PERSON_IDS")!=null?request.getAttribute("PERSON_IDS"):"" %>"></iframe>
</body>
</html>