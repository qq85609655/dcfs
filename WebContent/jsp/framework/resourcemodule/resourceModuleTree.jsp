
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>模块树</title>
	<BZ:script tree="true" />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['leftFrame','mainFrame']);
	});
	function L(id,selNode){
		var appId=document.getElementById("APP_ID").value;
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		if(id=='-1'){
			id="0";
		}
		//处理
			if(id=="0"){
				parent.mainFrame.location = "<%=request.getContextPath() %>/module/resourceModuleList.action?type=tree&PMOUDLE=0&APP_ID="+appId;
			}else{
				parent.mainFrame.location = "<%=request.getContextPath() %>/module/resourceModuleList.action?type=tree&PMOUDLE="+id+"&APP_ID="+appId;
			}
		}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<!-- 修改组织机构的标志位 -->
		<input type="hidden" name="APP_ID" id="APP_ID" value="<%=request.getAttribute("APP_ID") %>" />
		<input type="hidden" name="treeDispatcher" value="organTree" />
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择模块</div>
			<!-- 组织机构树形 -->
			<BZ:tree property="dataList" type="0" iconPath="/images/tree_org/" topName="模块"  />
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>