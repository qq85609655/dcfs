
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>选择组织机构</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true"/>
	<script type="text/javascript">
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//处理
	}
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
			if (!sel) {
				alert("请选择内容。");
				return;
			}
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
		//alert(reValue+"    "+reValue.length);
		window.close();
	}

	function reset_(){		
		window.returnValue={};
	    window.close();
	}
	

	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" target="_self">
		<div class="kuangjia">
		<div class="list">
		<!-- 组织机构树形 -->
		<div class="heading">选择组织机构</div>
		<table width="100%">
			<tr>
				<td style="padding-left:15px">
				    <input type="button" class="button_change" value="全部展开" onclick="tree.expandAll();">
				    <input type="button" class="button_add" value="确定" onclick="_ok();">
				    <input type="button" value="清空" class="button_back" onclick="reset_()"/>
				</td>
			</tr>
			<tr>
				<td><BZ:tree property="dataList" type="1" iconPath="/images/tree_org/"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>