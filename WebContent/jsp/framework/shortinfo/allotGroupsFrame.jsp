<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <% 
 	String path=request.getContextPath();
 	String group_type = (String)request.getAttribute("GROUP_TYPE");
 %>
<html>
<head>
<base target="_self">
<title>Ñ¡ÔñÈº×é</title>
</head>
<body>
<iframe width="998px" height="700px" scrolling="auto" frameborder="0" src="<%=path%>/usergroup/allotGroups.action?GROUP_TYPE=<%=group_type %>"></iframe>
</body>
</html>