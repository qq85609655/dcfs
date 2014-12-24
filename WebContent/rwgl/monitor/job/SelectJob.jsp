<%@ page contentType="text/html; charset=gb2312" %>
<%   response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
<html>
<head>
<title>นคื๗ักิ๑</title>
<meta http-equiv='expires' content='0'>
<meta http-equiv="Pragma" content="no-cache"> <META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
</head>
<%
		String JOB_TYPE = request.getParameter("JOB_TYPE");
		if(JOB_TYPE==null) JOB_TYPE ="01";
%>

<body>
            <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
              <tr height="100">
                <td>
				<iframe src="JobQuery.jsp?JOB_TYPE=<%= JOB_TYPE%>" width="100%" height="100%" frameborder=0 scrolling=yes></iframe>
				</td>
              </tr>
            </table>

 </body>
</html>
