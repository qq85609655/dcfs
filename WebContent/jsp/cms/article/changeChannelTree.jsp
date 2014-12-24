<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String ids = (String)request.getAttribute(Article.IDS);
	String channelId = (String)request.getAttribute(Article.CHANNEL_ID);
%>
<BZ:html>
<BZ:head>
	<title>频道树</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript" src="<BZ:url/>/jsp/innerpublication/view/js/jquery.js"></script>
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
			alert("【"+name+"】为【虚拟目录】，不能添加内容");
			return;
		}
		
		//处理
		if(confirm("确定要移动吗？")){
			document.getElementById("CHANNEL_ID").value=id;
			document.srcForm.submit();
			window.returnValue="yesa";
			window.close();
		}
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="article/Article!changeChannel.action">
		<!-- 组织机构与人员的ID -->
		<input type="hidden"  name="IDS" value='<%=ids != null ? ids : "" %>'/>
		<!-- 调动前的频道ID -->
		<input type="hidden" name="Article_CHANNEL_ID" value='<%=channelId != null ? channelId : "" %>'/>
		<!-- 调整后的频道ID -->
		<input name="CHANNEL_ID" id="CHANNEL_ID" type="hidden"/>
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择栏目</div>
		<!-- 组织机构树形 -->
		<table width="100%">
			<tr>
				<td><BZ:tree property="dataList" type="0"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>