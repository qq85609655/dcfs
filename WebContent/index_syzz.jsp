<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.authenticate.sso.SSOConfig"%>
<%@page import="com.hx.framework.common.ClientIPGetter"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	String path = request.getContextPath();
%>
<html>
<BZ:head>
<title>Home Page</title>
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
					<div class="blocktitle"><span class="tzggico">Notice</span></div>
					<a href="#" class="more">more...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">Announcement on Relevant Matters in Inter-country Adoption</a><span class="date">[ 8-25 ]</span></li>
						
					</ul>
				</div>
			</div>
			<div class="blockbox zlxz">
				<div class="blockhead">
					<div class="blocktitle"><span class="zlxzico">Download</span></div>
					<a href="#" class="more">more...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">download</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">download</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">download</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">download</span></li>
						<li><a class="title" href="#">儿童信息采集表</a><span class="date">download</span></li>
						
					</ul>
				</div>
			</div>
		</div>
		<div class="rightbar">
			<div class="blockbox dbsw">
				<div class="blockhead">
					<div class="blocktitle"><span class="zlxzico">To do</span></div>
					<a href="#" class="more"></a>
				</div>
				<div class="blocklist clearfix">
					<ul>
						<li>补充文件<font color="red">(10)</font></a></li>
						<li>预批补充<font color="red">(5)</font></a></li>
						<li>催办通知<font color="red">(4)</font></a></li>
						<li>征求意见<font color="red">(3)</font></a></li>
						<li>通知书<font color="red">(1)</font></a></li>
						<li>报告补充<font color="red">(12)</font></a></li>
						<li>报告催交<font color="red">(2)</font></a></li>
						<li>催缴通知<font color="red">(7)</font></a></li>
					</ul>
				</div>
			</div>
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="zcckico">Policy</span></div>
					<a href="#" class="more">more...</a>
				</div>
				<div class="blocklist">
					<ul>
						<li><a class="title" href="#">跨国收养方面保护儿童及合作公约</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">儿童权利公约</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">儿童权利宣言</a><span class="date">[ 8-25 ]</span></li>
						<li><a class="title" href="#">外国人在中华人民共和国收养子女登记办法</a><span class="date">[ 8-25 ]</span></li>
					</ul>
				</div>
			</div>
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="tzggico">Q&A</span></div>
					<a href="#" class="more">more...</a>
				</div>
				<div class="blocklist">
					<ul>
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