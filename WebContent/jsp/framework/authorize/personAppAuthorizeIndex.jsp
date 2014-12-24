<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>人员授权</title>
<BZ:script />
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
</script>
</head>
<body style="margin:0">
	<table width="100%" height="100%">
		<tr height="100%">
			<td width="22%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/resource/ResourceApp!generateAllTree.action?treeDispatcher=perAppAuthorizeTree" id="left1Frame" name="left1Frame" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto"></iframe>
			</td>
			<td width="22%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/organ/Organ!generateTree.action?treeDispatcher=personAppAuthorizeTree" id="leftFrame" name="leftFrame"  marginwidth="0" marginheight="0" frameborder="0" scrolling="no"  ></iframe>
			</td>
			<td width="56%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/person/Person!queryPersonAppList.action?<%=OrganPerson.ORG_ID%>=0" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto"  ></iframe>
			</td>
		</tr>
	</table>
</body>
<noframes>
	<body>
		<form id="srcForm" name="srcForm" action="role/RoleGroup">
			<input type="hidden" name="ROLE" id="ROLE" value="jie"/>
			<input type="hidden" name="" id=""/>
		</form>
	</body>
</noframes>
</html>