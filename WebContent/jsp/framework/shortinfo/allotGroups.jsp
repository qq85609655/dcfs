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
<BZ:script isList="true" tree="true"/>
<script type="text/javascript">

var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
var isShowParent = false;
if ("true" == isShowParentString) {
	isShowParent = true;
}

function _onload(){
	
}

//��Ȩ
function _allot(){
	var f = _ok();
	if(!f){
		return false;
	}
	
	var sfdj=0;
    var uuid="";
    for(var i=0;i<document.getElementsByName('xuanze').length;i++){
    if(document.getElementsByName('xuanze')[i].checked){
    uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
    sfdj++;
    }
   }
   if(sfdj=="0"){
   alert('��ѡ��Ҫ��Ȩ������');
   return;
   }else{
   if(confirm('ȷ��Ҫ��Ȩѡ��Ⱥ����?')){
   document.getElementById("GROUP_IDS").value=uuid;
   document.srcForm.action=path+"usergroup/doAllotGroups.action?GROUP_TYPE="+2;
   document.srcForm.submit();
   window.returnValue="1";
   window.close();
   }else{
   return;
   }
   }
}

function _ok(){
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

//������Ӧ��Ȩ���б�
function L(id,selNode){
	reValue = new Array();
	if(!selNode || selNode=="false"){
		isSelNode=false;
	}
	if(id.indexOf("O_") != -1){
		alert("��ѡ����Ա�鿴��Ȩ��Ⱥ�飡");
		return ;
	}
	
	//window.showModalDialog(path+"usergroup/lookGroupOfPerson.action?PERSON_ID="+id, this, "dialogWidth=600px;dialogHeight=600px;scroll=auto");
	window.showModalDialog(path+"usergroup/lookGroupOfPersonFrame.action?PERSON_ID="+id, this, "dialogWidth=600px;dialogHeight=600px;scroll=auto");
}
</script>
</BZ:head>
<BZ:body onload="_onload();">
	<BZ:form name="srcForm" method="post" target="_self">
	<input type="hidden" id="PERSON_IDS" name="PERSON_IDS"/>
	<input type="hidden" id="GROUP_IDS" name="GROUP_IDS"/>
	
		<table width="100%">
			<tr>
				<td width="50%" valign="top">
					<div class="kuangjia">
						<div class="list">
						<!-- ��֯�������� -->
						<div class="heading">ѡ����Ա</div>
							<BZ:tree property="personOrgTree" type="4" topName="������Ա"/>
						</div>
					</div>
				</td>
				<td width="50%" valign="top">
					<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
					<input type="hidden" name="compositor" value="<%=compositor%>"/>
					<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
					
					<div class="kuangjia">
					<div class="list">
					<div class="heading">�Զ���Ⱥ��</div>
					<BZ:table tableid="tableGrid" tableclass="tableGrid">
					<BZ:thead theadclass="titleBackGrey">
					<BZ:th name="���" width="7%" sortType="none" sortplan="jsp"/>
					<BZ:th name="Ⱥ������" width="28%" sortType="string" sortplan="jsp"/>
					</BZ:thead>
					<BZ:tbody>
					<BZ:for property="groupList">
					<tr>
					<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
					<td><BZ:data field="GROUPNAME" onlyValue="true"/></td>
					</tr>
					</BZ:for>
					</BZ:tbody>
					</BZ:table>
					<table border="0" cellpadding="0" cellspacing="0" class="operation">
					<tr>
					<td style="padding-left:15px"></td>
					<td align="right" style="padding-right:30px;height:35px;">
					<input type="button" value="��Ȩ" class="button_add" onclick="_allot();"/>&nbsp;&nbsp;
					<input type="button" value="�ر�" class="button_delete" onclick="window.close();"/>
					</td>
					</tr>
					</table>
					</div>
					</div>
				</td>
			</tr>
		</table>
	</BZ:form>
</BZ:body>
</BZ:html>