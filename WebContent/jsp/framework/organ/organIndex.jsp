<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>组织机构</title>
<BZ:script/>
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
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/organ/Organ!generateTree.action?treeDispatcher=organTree" id="leftFrame" name="leftFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
			<td width="78%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/organ/Organ!queryChildrenPage.action?compositor=SEQ_NUM" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>
	</body>
</html>