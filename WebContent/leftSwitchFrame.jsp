<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%
	String path = request.getContextPath();
%>

<html>
<head>
<title>Framework</title>
<link rel="stylesheet" href="<%=path %>/frame/css/common.css" type="text/css" />
<script language="JavaScript">
function Submit_onclick(){
	if(parent.myFrame.cols == "199,7,*") {
		parent.myFrame.cols="0,7,*";
		document.getElementById("ImgArrow").src="<%=path %>/frame/images/switch_right.gif";
		document.getElementById("ImgArrow").alt="´ò¿ª×ó²àµ¼º½À¸";
	} else {
		parent.myFrame.cols="199,7,*";
		document.getElementById("ImgArrow").src="<%=path %>/frame/images/switch_left.gif";
		document.getElementById("ImgArrow").alt="Òþ²Ø×ó²àµ¼º½À¸";
	}
}

function MyLoad() {
	if(window.parent.location.href.indexOf("MainUrl")>0) {
		window.top.midFrame.document.getElementById("ImgArrow").src="<%=path %>/frame/images/switch_right.gif";
	}
}
</script>
<body onload="MyLoad()">
<div id="switchpic"><a href="javascript:Submit_onclick()"><img src="<%=path %>/frame/images/switch_left.gif" alt="Òþ²Ø×ó²àµ¼º½À¸" id="ImgArrow" /></a></div>
</body>
</html>