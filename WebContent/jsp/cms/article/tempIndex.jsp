<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>文章起草</title>
</head>
<frameset cols="200,*" id="frame">
	<!-- ROLE=1表示生成投稿人树形权限 -->
	<frame src="<%=request.getContextPath() %>/channel/Channel!generateTreeForPerson.action?treeDispatcher=tempTree&ROLE=1" id="leftFrame" name="leftFrame" noresize="noresize" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="main" />
	<frame src="<%=request.getContextPath() %>/article/Article!tempQuery.action?<%=Article.CHANNEL_ID%>=0" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="_self" />
</frameset>
<noframes>
	<body></body>
</noframes>
</html>