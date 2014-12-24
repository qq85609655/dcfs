<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
	<title>栏目树</title>
	<script type="text/javascript" src="<%=path %>/jsp/innerpublication/view/js/jquery.js"></script>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		
		//获取栏目的信息：父栏目、栏目样式：虚拟、普通、外部链接
		var channelStyle;
		var parentId;
		var name;
		//虚拟目录  无需判断外部链接，因为此处不会出现
		var virsual = "<%=Channel.CHANNEL_STYLE_STATUS_VIRTUAL %>"; 
		$.ajax({
			type: "post",//请求方式
			url: "<BZ:url/>/channel/Channel!ajaxStyleValue.action?ID="+id,
			data: "time=" + new Date().valueOf(),
			async : false,
			dataType: "json",
			success: function(rs){
				name = rs.name;
				parentId = rs.parentId;
				channelStyle = rs.channelStyle;
			}
		});
		
		if(channelStyle == virsual){
			alert("【"+name+"】为【虚拟目录】，不存在内容");
			return;
		}
		
		//全部则显示所有待审记录列表
		if(id == 0){
			_showAllAuditList();
		}else{
		//处理
			childFrame.location = "<%=path %>/article/Article!auditQuery.action?<%=Article.CHANNEL_ID%>="+id;
		}
	}
	
	//查询所有栏目中待审核列表	
	function _showAllAuditList(){
		childFrame.location = "<%=path %>/article/Article!auditQuery.action";
	}
	
	function reinitIframe(){
		var iframe = document.getElementById("childFrame");
		try{
			var bHeight = iframe.contentWindow.document.body.scrollHeight;
			var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
			var height = Math.max(bHeight, dHeight);
			iframe.height = height;
		}catch (ex){}
	}
	window.setInterval("reinitIframe()", 200);
	 /* $(document).ready(function(){
		  dyniframesize([ 'leftFrame','mainFrame' ]);
	}); */
	</script>
</BZ:head>
<BZ:body>
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
			<td width="25%" valign="top">
				<BZ:form name="srcForm" method="post">
					<!-- 修改栏目的标志位 -->
					<input type="hidden" name="treeDispatcher" value="articleTree" />
					<div class="kuangjia">
					<div class="list">
					<div class="heading">选择栏目</div>
					<table width="100%">
						<tr>
							<td width="100%"><BZ:tree property="dataList" type="0" topName="栏目树"/></td>
						</tr>
					</table>
					</div>
					</div>
				</BZ:form>
			</td>
			<td width="75%" valign="top">
				<iframe id="childFrame" name="childFrame" src="<BZ:url/>/article/Article!auditQuery.action?<%=Article.CHANNEL_ID%>=0" style="width: 100%;" frameborder="0" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>