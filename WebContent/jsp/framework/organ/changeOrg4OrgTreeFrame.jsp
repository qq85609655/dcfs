
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
 <% 
 	String path=request.getContextPath();
 %>
<html>
<head>
<base target="_self">
<title>选择组织机构</title>
</head>
<body>
<iframe width="250px" height="250px" scrolling="auto" frameborder="0" src="<%=path %>/organ/Organ!toChangeOrg.action?<%=Organ.ID %>=<%=request.getAttribute(Organ.ID)!=null?request.getAttribute(Organ.ID):"" %>&<%=Organ.PARENT_ID %>=<%=request.getAttribute(Organ.PARENT_ID)!=null?request.getAttribute(Organ.PARENT_ID):"" %>"></iframe>
</body>
</html>