<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>国家树</title>
	<BZ:script tree="true" />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['leftFrame','rightFrame']);
	});
	function L(id,selNode){
		var appId=document.getElementById("COUNTRY_CODE").value;
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		if(id=='-1'){
			id="0";
		}
		//处理
		rightFrame.location = "<%=request.getContextPath() %>/mkr/MAINCountry/findCountry.action?COUNTRY_CODE="+id;
	}
	</script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" action="/mkr/MAINCountry/mainCountryTree.action">
	<table width="100%" height="100%">
		<tr height="100%">
			<td width="20%" valign="top" height="100%">
				<input type="hidden" name="COUNTRY_CODE" id="COUNTRY_CODE" value="<%=request.getAttribute("COUNTRY_CODE") %>" />
				<input type="hidden" name="treeDispatcher" value="organTree" />
				<div class="kuangjia">
				<div class="list">
				<div class="heading">选择国家</div>
					<!-- 组织机构树形 -->
					<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="全部"  />
				</div>
				</div>
			</td>
			<td width="80%" valign="top">
				<iframe align="top" width="100%" src="<%=request.getContextPath() %>/mkr/MAINCountry/findCountry.action" 
				 id="rightFrame" name="rightFrame" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
			</td>
		</tr>
	</table>
</BZ:form>
</BZ:body>
</BZ:html>