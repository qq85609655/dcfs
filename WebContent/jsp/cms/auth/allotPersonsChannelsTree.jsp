<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>栏目树</title>
	<BZ:script tree="true" />
	<script type="text/javascript">
	var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
	var isShowParent = false;
	if ("true" == isShowParentString) {
		isShowParent = true;
	}
	function _ok(){
		if (tree.useCheckbox) {
			var nodes = tree.nodes;
			var sel = false;
			var isSelect=false;
			for ( var i in nodes) {
				if (nodes[i].checked) {
					sel = true;
					break;
				}
			}
			if(tree.onlyCheckChild){
				if (!sel && isSelect){
					alert("您只能选择叶子节点，在选择的节点中不包含叶子节点，请重新选择。");
					return;
				}
			}
			/* if (!sel) {
				alert("请选择内容1。");
				return;
			} */
		} else {
			if(tree.onlyCheckChild){
				var node = tree.selectedNode;
				if(node.hasChild){
					alert("只能选择叶子节点，请重新选择。");
					return;
				}
			}
			if (tree.selectedNode.id == null) {
				alert("请选择内容。");
				return;
			}
		}
		var reValue = null;
		if (tree.useCheckbox && !tree.onlySelectSelf) {
			reValue = getSelectValue(tree, isShowParent, true);
		} else {
			reValue = getSelectValue(tree, isShowParent, false);
		}
		window.returnValue=reValue;
		var name="";
		var value="";
		var appIds="";
		var sfdj=0;
		for(var i=0 ;i<reValue.length;i++){
			appIds=appIds + reValue[i]["value"]+"#";
			sfdj++;
		}
		document.getElementById("CHANNEL_IDS").value=appIds;
	}
	$(document).ready(function(){
		dyniframesize(['left1Frame']);
	});
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<!-- 选中的栏目的ID -->
		<input id="CHANNEL_IDS" name="CHANNEL_IDS" type="hidden"/>
		
		<div class="kuangjia">
		<div class="list">
		<div class="heading">选择要分配的栏目</div>
			<!-- 应用树 -->
			<BZ:tree property="dataList" type="2" topName="栏目树"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>