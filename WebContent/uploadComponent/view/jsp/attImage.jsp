<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String code = (String)request.getAttribute("code");
	String packageId = (String)request.getAttribute("packageId");
	String frameId = (String)request.getAttribute("frameId");
	String smallType = (String)request.getAttribute("smallType");
	String id = (String)request.getAttribute("id");
	String path = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>图片显示</title>
<script type="text/javascript">
	function _onloadImage(){
		var len = window.parent.document.getElementById("infoTable<%=id %>").rows.length;
		if(len == 0){
			document.getElementById("imageTag").src = "<%=path %>/uploadComponent/view/jsp/images/head.png";
		}
	}
</script>
</head>
<body onload="_onloadImage();" style="margin: 0">
<img id="imageTag" width="100%" height="100%" src='<up:attDownload attTypeCode="<%=code %>" packageId="<%=packageId %>" smallType="<%=smallType %>"/>' border="0" />
</body>
</html>