<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.authenticate.sso.SSOConfig"%>
<%@page import="com.hx.framework.common.ClientIPGetter"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String path = request.getContextPath();
%>
<html>
<BZ:head>
<title>首页</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<BZ:webScript isAjax="true"/>
<link href="<BZ:resourcePath/>/newindex/styles/base/front.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
</script>
</BZ:head>
<body>
	<div class="front-blocks">
		<div class="leftbar">
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="tzggico">通知公告</span></div>
					<a href="#" class="more">更多...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
					</ul>
				</div>
			</div>
			<div class="blockbox zlxz">
				<div class="blockhead">
					<div class="blocktitle"><span class="zlxzico">资料下载</span></div>
					<a href="#" class="more">更多...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">下载</span></li>
					</ul>
				</div>
			</div>
		</div>
		<div class="rightbar">
			<div class="blockbox dbsw">
				<div class="blockhead">
					<div class="blocktitle"><span class="zlxzico">待办事务</span></div>
					<a href="#" class="more">更多...</a>
				</div>
				<div class="blocklist clearfix">
					<ul>
						<li>补充文件代办</a></li>
						<li>补充文件代办</a></li>
						<li>补充文件代办</a></li>
						<li>补充文件代办</a></li>
						<li>补充文件代办</a></li>
						<li>补充文件代办</a></li>
						<li>补充文件代办</a></li>
						<li>补充文件代办</a></li>
					</ul>
				</div>
			</div>
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="zcckico">政策查看</span></div>
					<a href="#" class="more">更多...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
					</ul>
				</div>
			</div>
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="tzggico">常见问题解答</span></div>
					<a href="#" class="more">更多...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">市福利中心认真做好孤残儿童涉外送养工作市福利中心认真做好孤残儿童</a><span class="date">[ 8-25 ]</span></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</body>
</html>