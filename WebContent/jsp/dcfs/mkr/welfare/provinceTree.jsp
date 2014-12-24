<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String codeId = (String)request.getAttribute("CODE_ID");
%>
<BZ:html>
<BZ:head>
	<title>省份树</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript" src="<BZ:url/>/jsp/innerpublication/view/js/jquery.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['welfare','mainFrame']);
	});
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		if(id==0||id == "0"){
			welfare.location = "<%=request.getContextPath() %>/mkr/organSupp/findWelfareList.action"
		}else{			
			//处理
			welfare.location = "<%=request.getContextPath() %>/mkr/organSupp/findWelfareList.action?ID="+id;
		}
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
	</script>
</BZ:head>
<BZ:body>
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		<tr>
			<td width="20%" valign="top">
				<BZ:form name="srcForm" method="post">
					<div class="kuangjia">
					<div class="list">
					<div class="heading">省份</div>
					<table width="100%">
						<tr>
							<td width="100%"><BZ:tree property="dataList" type="0" topName="省份"/></td>
						</tr>
					</table>
					</div>
					</div>
				</BZ:form>
			</td>
			<td width="80%" valign="top">
				<iframe id="welfare" name="welfareFrame" src="<BZ:url/>/mkr/organSupp/findWelfareList.action" style="width: 100%;" frameborder="0" scrolling="no"></iframe>
			</td>
		</tr>
	</table>
</BZ:body>
</BZ:html>