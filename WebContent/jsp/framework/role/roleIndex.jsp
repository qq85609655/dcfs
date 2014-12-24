<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>角色</title>
<BZ:script/>
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
</script>
</head>
<body style="margin:0">
<iframe width="100%"  src="<%=request.getContextPath() %>/role/Role!queryChildren.action?<%=RoleGroup.PARENT_ID%>=0" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" ></iframe>
</body>
<noframes>
	<body></body>
</noframes>
</html>