<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
 <% 
 	String path=request.getContextPath();
 %>
<html>
<head>
<base target="_self">
<title>—°‘Ò∆µµ¿</title>
</head>
<body>
<iframe width="250px" height="250px" scrolling="auto" frameborder="0" src="<%=path %>/article/Article!toChangeChannel.action?<%=Article.IDS %>=<%=request.getAttribute(Article.IDS)!=null?request.getAttribute(Article.IDS):"" %>&<%=Article.CHANNEL_ID %>=<%=request.getAttribute(Article.CHANNEL_ID)!=null?request.getAttribute(Article.CHANNEL_ID):"" %>"></iframe>
</body>
</html>