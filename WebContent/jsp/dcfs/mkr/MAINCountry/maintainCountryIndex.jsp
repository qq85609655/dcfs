<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>国家列表</title>
</BZ:head>
	<table width="100%" height="100%">
		<tr height="100%">
			<td width="20%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/mkr/MAINCountry/mainCountryTree.action" id="leftFrame" name="leftFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
			<td width="80%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/mkr/MAINCountry/findCountry.action"  id="rightFrame" name="rightFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>
</BZ:html>