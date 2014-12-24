<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>组织授权</title>
<BZ:script />
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
</script>
</head>
<body style="margin:0" >
	<table height="100%">
		<tr height="100%">
			<td width="300px" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/resource/ResourceApp!generateAllTree.action?treeDispatcher=organAppAuthorizeTree" name="leftFrame" id="leftFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
			<td width="300px" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/organ/Organ!generateTree.action?treeDispatcher=appAuthorizeTree" id="mainFrame" name="mainFrame"  marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
</body>
</html>