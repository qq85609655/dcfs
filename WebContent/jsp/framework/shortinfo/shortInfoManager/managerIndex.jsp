<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.shortinfo.vo.Sms_ShortInfo_Manager"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>短信课堂列表</title>
</head>
<frameset cols="270,*" id="frame">
	<frame src="<%=request.getContextPath() %>/shortInfoManager/generateTree.action?treeDispatcher=partTree" id="leftFrame" name="leftFrame" noresize="noresize" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" target="main" />
	<frame src="<%=request.getContextPath() %>/shortInfoManager/list.action?<%=Sms_ShortInfo_Manager.MAGZINE_ID%>=-1" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="_self" />
</frameset>
<noframes>
	<body></body>
</noframes>
</html>