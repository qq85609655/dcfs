<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.cms.auth.vo.PersonChannelRela"%>
 <% 
 	String path=request.getContextPath();
 	String personsId = (String)request.getAttribute("PERSONS_ID");
 	String role = (String)request.getAttribute(PersonChannelRela.ROLE);
 	String organId = (String)request.getAttribute(OrganPerson.ORG_ID);
 %>
<html>
<head>
<base target="_self">
<title>—°‘Ò∆µµ¿</title>
</head>
<body>
<iframe width="500px" height="600px" scrolling="auto" frameborder="0" src="<%=path %>/cms_auth/Auth!toAlotPersonChannels.action?PERSONS_ID=<%=personsId!=null?personsId:"" %>&ROLE=<%=role!=null?role:"" %>&ORG_ID=<%=organId!=null?organId:"" %>"></iframe>
</body>
</html>