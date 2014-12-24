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
<title>��Աѡ����</title>
<base target="_self"/>
<BZ:script tree="true"/>
<script type="text/javascript">

var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
var isShowParent = false;
if ("true" == isShowParentString) {
	isShowParent = true;
}
/* function _ok(){
	if(!_sel()){
		alert("��ѡ�����ݣ�");
		return;
	}

	var name="";
	var value="";
	var appIds="";
	var sfdj=0; */
function _ok() {
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
						//����ѡ��
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
		var dataStr = tree.dataSource[tree.selectedNode.sourceIndex];
		var canCheck = dataStr.getAttribute("canCheck");
		if (canCheck=="false"){
			alert("��ѡ�����ݡ�");
			return;
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
	
	var name="";
	var value="";
	var appIds="";
	var sfdj=0; 
	for(var i=0 ;i<reValue.length;i++){
		appIds=appIds + reValue[i]["value"]+"#";
		sfdj++;
	}
	//������߽�ɫ��
	parent._ok();
	document.getElementById("PERSON_IDS").value = parent.document.getElementById("PERSON_IDS").value;
	//����
	document.getElementById("LINKMAN_IDS").value=appIds;
	document.srcForm.action=path+"usergroup/doAllotLinkmans.action";
	document.srcForm.submit();
	
	window.close();
}
</script>
</BZ:head>
<BZ:body>
	<BZ:form name="srcForm" method="post" target="_self">
	<input type="hidden" id="PERSON_IDS" name="PERSON_IDS"/>
	<input type="hidden" id="LINKMAN_IDS" name="LINKMAN_IDS"/>
	<div class="kuangjia">
		<div class="list">
		<table border="0" cellpadding="0" cellspacing="0" class="operation">
		<tr>
		<td style="padding-left:15px"></td>
		<td align="right" style="padding-right:10px;height:35px;">
			<input type="button" class="button_add" value="ȫ��չ��" onclick="expandAll(tree);">
		    <input type="button" class="button_add" value="��Ȩ" onclick="_ok();">
		    <input type="button" value="�ر�" class="button_close" onclick="window.close();"/>
		</td>
		</tr>
		</table>
		<div class="heading">ѡ����ϵ��</div>
		<table style="width: 100%;">
			<tr>
				<td><BZ:tree property="linkmanOrgTree" type="4" topName="������ϵ��"/></td>
			</tr>
		</table>
		</div>
		</div>
	</BZ:form>
</BZ:body>
</BZ:html>