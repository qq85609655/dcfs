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
	_notice();
});
//通知公告
function _notice(){
	$.ajax({
		url: path+"AjaxExecute?className=com.dcfs.homePage.AjaxNotice",
		type: 'POST',
		dataType: 'json',
		success: function(dataList){
		}
	});
	
	$.ajax({
		url: path+"AjaxExecute?className=com.dcfs.homePage.AjaxNotice",
		type: 'POST',
		dataType: 'json',
		success: function(dataList){
			if(dataList.length>0){
				for(var i=0;i<dataList.length;i++){
					var data=dataList[i];
					var title = data.TITLE;
					var url = path+"article/receiptAdd.action?ID="+data.ID;
					$("#notice").append('<li><a class="title" href="'+url+'">'+title+'</a></li>');
				}
			}
		}
	});
}

</script>
</BZ:head>
<body>
	<div class="front-blocks">
		<div class="leftbar">
			<div class="blockbox tzgg">
				<div class="blockhead">
					<div class="blocktitle"><span class="tzggico">通知公告</span></div>
					<a href="<BZ:url/>/article/receiptList.action" class="more">更多...</a>
				</div>
				<div class="blocklist">
					<ul id="notice">
						
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
				</div>
				<div class="blocklist clearfix">
					<ul>
						<!-- 中心领导 -->
						<li><a>签批待办</a></li>
						<!-- 办公室 -->
						<li><a>收文登记待办</a></li>
						<li><a>领导签批提醒</a></li>
						<li><a>文件待退文记录</a></li>
						<li><a>待打印</a></li>
						<!-- 审核部 -->
						<li><a>文件接收待办</a></li>
						<li><a>文件审核待办</a></li>
						<li><a>预批审核待办</a></li>
						<li><a>退文确认待办</a></li>
						<li><a>文件补充已反馈</a></li>
						<li><a>预批补充已反馈</a></li>
						<li><a>待备案</a></li>
						<!-- 安置部 -->
						<li><a>材料接收（省厅-安置部）待办</a></li>
						<li><a>翻译公司材料接收待办</a></li>
						<li><a>儿童材料审核待办</a></li>
						<li><a>匹配审核待办</a></li>
						<li><a>点发退回确认待办</a></li>
						<li><a>交文延期审核待办</a></li>
						<li><a>撤销申请确认待办</a></li>
						<li><a>材料接收（档案部-安置部）待办</a></li>
						<li><a>待更新</a></li>
						<!-- 档案部 -->
						<li><a>文件接收待办</a></li>
						<li><a>儿童材料接收待办</a></li>
						<li><a>通知书副本打印</a></li>
						<li><a>报告接收（收养组织-档案部）待办</a></li>
						<li><a>报告审核待办</a></li>
						<li><a>报告接收（爱之桥-档案部）待办</a></li>
						<li><a>待归档</a></li>
						<!-- 财务部 -->
						<li><a>待接收</a></li>
						<li><a>待确认服务费</a></li>
						<li><a>待确认信息费</a></li>
						<!-- 爱之桥 -->
						<li><a>文件接收待办</a></li>
						<li><a>文件翻译待办</a></li>
						<li><a>文件重翻待办</a></li>
						<li><a>文件补翻待办</a></li>
						<li><a>预批翻译待办</a></li>
						<li><a>预批补翻待办</a></li>
						<li><a>报告翻译待办</a></li>
						<li><a>退文确认待办</a></li>
						<li><a>加快翻译待办</a></li>
						<li><a>待更新</a></li>
						<!-- 翻译公司 -->
						<li><a>材料接收待办</a></li>
						<li><a>材料翻译待办</a></li>
						<li><a>材料补翻待办</a></li>
						<!-- 省厅 -->
						<li><a>儿童材料审核待办</a></li>
						<li><a>儿童材料补充待办</a></li>
						<li><a>待登记</a></li>
						<li><a>来华预约确认待办</a></li>
						<li><a>待报送</a></li>
						<!-- 福利院 -->
						<li><a>儿童材料补充待办</a></li>
						<li><a>待登记</a></li>
						<li><a>待报送</a></li>
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