
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<BZ:html>
<BZ:head>
	<title>ѡ����֯����</title>
	<base target="_self"/>
	<BZ:script isList="true" tree="true"/>
	<script type="text/javascript">
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
		<!-- ��֯�������� -->
		<div class="heading">ѡ����֯����</div>
		<table width="100%">
			<tr>
				<td style="padding-left:15px">
				    <input type="button" class="button_change" value="ȫ��չ��" onclick="tree.expandAll();">
				    <input type="button" class="button_add" value="ȷ��" onclick="_ok();">
				    <input type="button" value="���" class="button_back" onclick="reset_()"/>
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