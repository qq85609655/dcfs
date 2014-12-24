<%@ page contentType="text/html;charset=gb2312" %>
<%   response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
<head>
<title>ศฮฮ๑ักิ๑</title>
<meta http-equiv='expires' content='0'>
<meta http-equiv="Pragma" content="no-cache"> <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
</head>
<%
		String TI_SCHEDULE_TYPE = request.getParameter("TI_SCHEDULE_TYPE");
		if(TI_SCHEDULE_TYPE==null) TI_SCHEDULE_TYPE="dd";
%>
<body>
				<iframe target="_self" src="TaskQuery.jsp?TI_SCHEDULE_TYPE=<%= TI_SCHEDULE_TYPE%>" width="100%" height="100%"  frameborder=0 scrolling=yes></iframe>
</body>
</html>
