<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.role.vo.Role"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>Ӧ����</title>
	<BZ:script isList="true" tree="true" />
	<script type="text/javascript">
	var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
	var isShowParent = false;
	if ("true" == isShowParentString) {
		isShowParent = true;
	}
	$(document).ready(function() {
		dyniframesize(['leftFrame','mainFrame']);
	});
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
					alert("��ֻ��ѡ��Ҷ�ӽڵ㣬��ѡ��Ľڵ��в�����Ҷ�ӽڵ㣬������ѡ��");
					return;
				}
			}
			if (!sel) {
				alert("��ѡ�����ݡ�");
				return;
			}
		} else {
			if(tree.onlyCheckChild){
				var node = tree.selectedNode;
				if(node.hasChild){
					alert("ֻ��ѡ��Ҷ�ӽڵ㣬������ѡ��");
					return;
				}
			}
			if (tree.selectedNode.id == null) {
				alert("��ѡ�����ݡ�");
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
		//alert(appIds);
		document.getElementById("APP_IDS").value=appIds;
	}

	//������Ӧ��Ȩ���б�
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//alert(id);
		window.showModalDialog(path+"resource/ResourceApp!queryAllotOrgan.action?APP_IDS="+id, this, "dialogWidth=600px;dialogHeight=600px;scroll=auto");
	}
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post">
		<div class="kuangjia">
		<div class="list">
		<div class="heading">ѡ��Ӧ��</div>
		<input name="APP_IDS" id="APP_IDS" type="hidden"/>
			<BZ:tree property="dataList" type="1"/>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>