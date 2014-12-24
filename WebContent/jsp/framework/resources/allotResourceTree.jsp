
<%@page import="com.hx.framework.role.vo.Role"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>应用树</title>
	<BZ:script tree="true" />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
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
			//if (!sel) {
			//	alert("请选择内容。");
			//	return;
			//}分配资源时可以不选择，下面代码有判断，如果没有选择的时候相当于清空资源，所以这段判断没有用，如果有问题可以将注释解除恢复
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
		//alert(sfdj);
		if(sfdj=="0"){
				//alert('请选择要分配的数据');
				if(!confirm('确定清空角色的所有资源吗?')){
					return;
				}
		}else{
			if(!confirm('确认要分配吗?')){
				return;
			}
		}
		document.getElementById("APP_IDS").value=appIds;
			document.srcForm.action=path+"role/Role!allotResource.action";
			document.srcForm.submit();
	}

	function _back(){
		document.srcForm.action=path+"role/Role!queryChildren.action?PARENT_ID=0";
		document.srcForm.submit();
	}
	function _onload1(){
		try{
			tree.expandAll();
		}catch(e){}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload1();">
	<BZ:form name="srcForm" method="post" action="">
		<div class="kuangjia">
		<!-- 选中的应用、模块、资源树中的节点要提交的ID -->
		<input id="APP_IDS" name="APP_IDS" type="hidden"/>
		<!-- 角色组ID -->
		<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
		<!-- 角色ID -->
		<input name="ROLE_ID" id="ROLE_ID" type="hidden" value="<%=request.getAttribute("ROLE_ID")!=null?request.getAttribute("ROLE_ID"):"" %>"/>
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
				<input type="button" class="button_add" value="确定" onclick="_ok();">
				<input type="button" value="返回" class="button_back" onclick="_back()"/>
		</td>
		</tr>
		</table>
		<div class="heading">选择要分配的模块与资源</div>
		<!-- 应用树 -->
		<table>
			<tr>
				<td><BZ:tree property="dataList" type="1" selectvalue="ownResource"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>