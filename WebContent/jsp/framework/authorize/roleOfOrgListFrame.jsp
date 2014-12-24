<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <% 
 	String path=request.getContextPath();
 %>
<html>
<head>
<title>╫ги╚ап╠М</title>
</head>
<body>
<iframe  width="100%" scrolling="auto" height="100%" frameborder="0" src="<%=path %>/role/Authorize!queryRoleOfOrg.action?ORG_IDS=<%=request.getAttribute("ORG_IDS")!=null?request.getAttribute("ORG_IDS"):"" %>"></iframe>
</body>
</html>