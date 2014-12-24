<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>��֯��</title>
	<BZ:script isList="true" tree="true" />
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
		//������߽�ɫ��
		parent.leftFrameChild._ok();
		var roleValue=parent.leftFrameChild.document.getElementById("APP_IDS").value;
		document.getElementById("APP_IDS").value = roleValue
		if(roleValue==null||roleValue==""){
			return;
		}else{
			//����
			document.getElementById("ORG_IDS").value=appIds;
			document.srcForm.action = "<%=request.getContextPath() %>/role/Authorize!organAppAuthorize.action";
			document.srcForm.submit();
		}
	}

	//�鿴��֯������Ӧ��Ӧ��Ȩ��
	function queryAudit(){
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

			if(sfdj!="1"){
			alert('��ѡ��һ������');
			return;
			}else{
				modalDialog("<%=request.getContextPath() %>/role/Authorize!orgAppFrame.action?ORG_IDS="+appIds, this, 600,350);
			}
			}
	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		sId=id;
		if(id=='-1'){
			id="0";
			sId="";
		}else if(id=="0"){
			id="";
			sId="";
		}
		//����
		modalDialog("<%=request.getContextPath() %>/role/Authorize!orgAppFrame.action?ORG_IDS="+id, this, 600,350);
	}
	$(document).ready(function() {
		dyniframesize(['leftFrame','mainFrame']);
	});
	</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" action="organ/Organ!generateTree.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">
		<input name="treeDispatcher" value="appAuthorizeTree" type="hidden"/>
		<div class="list">
		<div class="heading">ѡ����֯����</div>
		<input name="ORG_IDS" id="ORG_IDS" type="hidden"/>
		<input name="APP_IDS" id="APP_IDS" type="hidden"/>
		<!-- ��֯�������� -->
		<table width="100%">
			<tr>
				<td><BZ:tree property="dataList" type="1" iconPath="/images/tree_org/" /></td>
			</tr>
		</table>
		<table id="operation" border="0" cellpadding="0" cellspacing="0" class="operation">
			<tr>
			<td style="padding-left:15px"></td>
			<td align="right" style="padding-right:5xpx;height:35px;">
			<input type="button" value="����Ȩ��" class="button_add" style="width: 80px" onclick="_ok()"/>&nbsp;&nbsp;
			<input type="button" value="�鿴Ȩ��" class="button_add" style="width: 80px" onclick="queryAudit()"/>
			</td>
			</tr>
		</table>
		</div>
		</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>