<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}
%>
<BZ:html>
<BZ:head>
<title>人员选择树</title>
<base target="_self"/>
<BZ:script tree="true"/>
<script type="text/javascript">
$(document).ready(function(){
	dyniframesize(['mainFrame']);
});
var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
var isShowParent = false;
if ("true" == isShowParentString) {
	isShowParent = true;
}

function _ok(){
	/* if(!_sel()){
		alert("请选择人员！");
		return false;
	} */
	if (tree.useCheckbox) {
		var nodes = tree.nodes;
		var sel = false;
		var isSelect=false;
		for ( var i in nodes) {
			if (nodes[i].checked) {
				var sindex = nodes[i].sourceIndex;
				if (sindex!=null && sindex!=""){
				var dataStr = tree.dataSource[sindex];
				var canCheck = dataStr.getAttribute("canCheck");
				if (canCheck=="false"){
					//不能选择
					continue;
				}
				}
				if(tree.onlyCheckChild){
					if(!nodes[i].hasChild){
						sel = true;
						break;
					}else{
						isSelect=true;
					}
				}else{
					sel = true;
					break;
				}

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
		var dataStr = tree.dataSource[tree.selectedNode.sourceIndex];
		var canCheck = dataStr.getAttribute("canCheck");
		if (canCheck=="false"){
			alert("请选择内容。");
			return;
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
	document.getElementById("PERSON_IDS").value=appIds;
	return true;
}

//弹出对应的权限列表
function L(id,selNode){
	reValue = new Array();
	if(!selNode || selNode=="false"){
		isSelNode=false;
	}
	if(id.indexOf("O_") != -1){
		alert("请选择人员！");
		return ;
	}
	//window.showModalDialog(path+"usergroup/lookGroupOfPerson.action?PERSON_ID="+id, this, "dialogWidth=600px;dialogHeight=600px;scroll=auto");
	window.showModalDialog(path+"usergroup/lookLinkmansOfPersonFrame.action?PERSON_ID="+id, this, "dialogWidth=600px;dialogHeight=600px;scroll=auto");
}

</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" target="_self">
	<input type="hidden" id="PERSON_IDS" name="PERSON_IDS"/>

		<table width="100%">
			<tr>
				<td width="50%" valign="top">
					<div class="kuangjia">
						<div class="list">
						<table border="0" cellpadding="0" cellspacing="0" class="operation">
						<tr>
						<td></td>
						<td align="left" style="height:35px;">
							<input type="button" class="button_add" value="全部展开" onclick="expandAll(tree);">
						</td>
						</tr>
						</table>

						<!-- 组织机构树形 -->
						<div class="heading">选择人员</div>
							<BZ:tree property="personOrgTree" type="4" topName="所有人员"/>
						</div>
					</div>
				</td>
				<td width="50%" valign="top">
					<iframe id="mainFrame" name="mainFrame" src="<BZ:url/>/usergroup/linkmansTree.action" style="width: 100%; overflow-x: hidden; overflow-y: auto;" frameborder="0"></iframe>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>