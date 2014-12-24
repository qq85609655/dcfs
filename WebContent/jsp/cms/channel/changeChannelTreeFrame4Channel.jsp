<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
 <% 
 	String path=request.getContextPath();
 %>
<html>
<head>
<base target="_self">
<title>—°‘Ò∆µµ¿</title>
</head>
<body>
<iframe width="300px" height="400px" scrolling="auto" frameborder="0" src="<%=path %>/channel/Channel!toChangeChannel.action?<%=Channel.IDS %>=<%=request.getAttribute(Channel.IDS)!=null?request.getAttribute(Channel.IDS):"" %>&<%=Channel.PARENT_ID %>=<%=request.getAttribute(Channel.PARENT_ID)!=null?request.getAttribute(Channel.PARENT_ID):"" %>"></iframe>
</body>
</html>