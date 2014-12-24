<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>模块列表</title>
<BZ:script/>
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
</script>
</head>
	<table width="100%" height="100%">
		<tr height="100%">
			<td width="22%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/module/resourceModuleTree.action?APP_ID=<%=request.getAttribute("APP_ID") %>" id="leftFrame" name="leftFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
			<td width="78%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/module/resourceModuleList.action?type=tree&PMOUDLE=0&APP_ID=<%=request.getAttribute("APP_ID") %>"  id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>

<noframes>
	<body></body>
</noframes>
</html>