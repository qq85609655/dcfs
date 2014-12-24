<!-- jsp/framework/organ/organIndex.jsp -->
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>数据同步</title>
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
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/sync/DataSync!generateTree.action" id="leftFrame" name="leftFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
			<td width="78%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/sync/TargetSys.action" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>

<noframes>
	<body></body>
</noframes>
</html>