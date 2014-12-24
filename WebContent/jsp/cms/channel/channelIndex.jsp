<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>栏目管理</title>
<script type="text/javascript">
function reinitIframe0(){
	var iframe = document.getElementById("leftFrame");
	try{
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		iframe.style.height =  height;
	}catch (ex){}
}
function reinitIframe1(){
	var iframe = document.getElementById("mainFrame");
	try{
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		iframe.style.height =  height;
	}catch (ex){}
}
function _init(){
	reinitIframe0();
	reinitIframe1();
}
$(document).ready(function(){
	  dyniframesize([ 'mainFrame' ]);
});
//window.setInterval("_init()", 200);
</script>
</head>
<frameset cols="200,*" id="frame">
	<frame src="<%=request.getContextPath() %>/channel/Channel!generateTreeForChannel.action?treeDispatcher=channelTree" id="leftFrame" name="leftFrame" noresize="noresize" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="main" />
	<frame src="<%=request.getContextPath() %>/channel/Channel!queryChildren.action?<%=Channel.PARENT_ID%>=0" id="mainFrame" name="mainFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="auto" target="_self" />
</frameset>
<noframes>
	<body></body>
</noframes>
</html>