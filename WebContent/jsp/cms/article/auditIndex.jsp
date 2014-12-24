<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>文章审核</title>
</head>
<frameset cols="200,*" id="frame">
	<frame src="<%=request.getContextPath() %>/channel/Channel!generateTreeForPerson.action?treeDispatcher=auditTree&ROLE=2" id="leftFrame" name="leftFrame" noresize="noresize" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="main" />
	<frame src="<%=request.getContextPath() %>/article/Article!auditQuery.action?<%=Article.CHANNEL_ID%>=0" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="_self" />
</frameset>
<noframes>
	<body></body>
</noframes>
</html>