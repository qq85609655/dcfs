
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.person.vo.Person"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
 <% 
 	String path=request.getContextPath();
 %>
<html>
<head>
<base target="_self">
<title>选择组织机构</title>
</head>
<body>
<iframe width="600px" height="350px" scrolling="auto" frameborder="0" src="<%=path %>/person/Person!toChangeBelong.action?<%=OrganPerson.ORG_ID %>=<%=request.getAttribute(OrganPerson.ORG_ID)!=null?request.getAttribute(OrganPerson.ORG_ID):"" %>&<%=Person.PERSON_ID %>=<%=request.getAttribute(Person.PERSON_ID)!=null?request.getAttribute(Person.PERSON_ID):"" %>"></iframe>
</body>
</html>