
<%@page import="com.hx.framework.role.vo.Role"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>Ӧ����</title>
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

		//����
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
					alert("��ֻ��ѡ��Ҷ�ӽڵ㣬��ѡ��Ľڵ��в�����Ҷ�ӽڵ㣬������ѡ��");
					return;
				}
			}
			//if (!sel) {
			//	alert("��ѡ�����ݡ�");
			//	return;
			//}������Դʱ���Բ�ѡ������������жϣ����û��ѡ���ʱ���൱�������Դ����������ж�û���ã������������Խ�ע�ͽ���ָ�
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
		//alert(sfdj);
		if(sfdj=="0"){
				//alert('��ѡ��Ҫ���������');
				if(!confirm('ȷ����ս�ɫ��������Դ��?')){
					return;
				}
		}else{
			if(!confirm('ȷ��Ҫ������?')){
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
		<!-- ѡ�е�Ӧ�á�ģ�顢��Դ���еĽڵ�Ҫ�ύ��ID -->
		<input id="APP_IDS" name="APP_IDS" type="hidden"/>
		<!-- ��ɫ��ID -->
		<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
		<!-- ��ɫID -->
		<input name="ROLE_ID" id="ROLE_ID" type="hidden" value="<%=request.getAttribute("ROLE_ID")!=null?request.getAttribute("ROLE_ID"):"" %>"/>
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
				<input type="button" class="button_add" value="ȷ��" onclick="_ok();">
				<input type="button" value="����" class="button_back" onclick="_back()"/>
		</td>
		</tr>
		</table>
		<div class="heading">ѡ��Ҫ�����ģ������Դ</div>
		<!-- Ӧ���� -->
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