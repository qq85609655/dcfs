
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="com.hx.framework.role.vo.RoleGroup" %>
 <% 
 	String path=request.getContextPath();
 %>
<html>
<head>
<title>╫ги╚ап╠М</title>
</head>
<body>
<iframe width="100%" height="350px" scrolling="auto" frameborder="0" src="<%=path %>/role/RoleGroup!queryNoRoles.action?<%=RoleGroup.ID %>=<%=request.getAttribute(RoleGroup.ID)!=null?request.getAttribute(RoleGroup.ID):"" %>&<%=RoleGroup.PARENT_ID %>=<%=request.getAttribute(RoleGroup.PARENT_ID)!=null?request.getAttribute(RoleGroup.PARENT_ID):"" %>"></iframe>
</body>
</html>