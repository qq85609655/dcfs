
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ page import="hx.util.InfoClueTo"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
	String compositor = (String) request.getParameter("compositor");
	if (compositor == null) {
		compositor = "";
	}
	String ordertype = (String) request.getParameter("ordertype");
	if (ordertype == null) {
		ordertype = "";
	}
	InfoClueTo clueTo = (InfoClueTo) request.getAttribute("clueTo");
	int type = -1;
	if (clueTo != null) {
		type = clueTo.getInfotype();
	}
%>
<BZ:html>
<BZ:head>
	<title>列表</title>
	<BZ:script isList="true" isAjax="true" />
	<!-- 刷新组织树 -->
	<%=request.getAttribute("refreshTree") != null ? request
									.getAttribute("refreshTree")
									: ""%>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _onload(){

	}
	function search(){
	document.srcForm.action=path+"";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"organ/Organ!toAdd.action";
	document.srcForm.submit();
	}
	function _update(){
	var sfdj=0;
	var ID="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	ID=document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj!="1"){
	alert('请选择一条数据');
	return;
	}else{
	document.srcForm.action=path+"organ/Organ!toModify.action?<%=Organ.ID %>="+ID;
	document.srcForm.submit();
	}
	}

	function chakan(){
	var sfdj=0;
	var ID="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	ID=document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj!="1"){
	alert('请选择一条数据');
	return;
	}else{
	document.srcForm.action=path+"organ/Organ!queryDetail.action?flag=detail&<%=Organ.ID %>="+ID;
	document.srcForm.submit();
	}
	}
	function _delete(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('请选择要注销的数据');
			return;
		}else{
			var ajax_url = "com.hx.framework.organ.OrganDelAjax";
			var root=getStr(ajax_url,"deleteuuid="+uuid);
			if(root=="person"){
					alert("请先删除部门下的人员!");
			}else if(root=="organ"){
					alert("请先删除下级部门!");
			}else if(root=="all"){
					alert("请先删除下级部门和部门下的人员!");
			}else{
				if(confirm('确认要注销选中信息吗?')){
					document.getElementById("Organ_IDS").value=uuid;
					document.srcForm.action=path+"organ/Organ!deleteBatch.action";
					document.srcForm.submit();
				}else{
					return;
				}
			}
		}
	}
	function _deleteForce(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('请选择要删除的数据');
			return;
		}else{
			var ajax_url = "com.hx.framework.organ.OrganDelAjax";
			var root=getStr(ajax_url,"deleteuuid="+uuid);
			if(root=="person"){
					alert("请先删除部门下的人员!");
			}else if(root=="organ"){
					alert("请先删除下级部门!");
			}else if(root=="all"){
					alert("请先删除下级部门和部门下的人员!");
			}
			else{
				if(confirm('确认要删除选中信息吗?')){
					document.getElementById("Organ_IDS").value=uuid;
					document.srcForm.action=path+"organ/Organ!deleteForce.action";
					document.srcForm.submit();
				}else{
					return;
				}
			}
		}
	}
	function changeOrgType(id){
		var PARENT_ID = document.getElementById("PARENT_ID").value;
		var s = window.showModalDialog("organ/Organ!modify.action?<%=Organ.ID %>="+id+"&<%=Organ.PARENT_ID %>="+PARENT_ID, this, "dialogWidth=200px;dialogHeight=150px;scroll=auto");

	}

	//调整组织机构
	function changeOrg(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
		uuid=uuid+document.getElementsByName('xuanze')[i].value;
		sfdj++;
		}
		}
		if(sfdj!="1"){
		alert('请选择一条要调整的数据');
		return;
		}else{
			var PARENT_ID = document.getElementById("PARENT_ID").value;
			window.showModalDialog(path+"organ/Organ!changeOrgFrame.action?<%=Organ.ID %>="+uuid+"&<%=Organ.PARENT_ID %>="+PARENT_ID, this, "dialogWidth=200px;dialogHeight=250px;scroll=no");
			document.srcForm.submit();
		}
		}
	function search(){
		document.srcForm.action=path+"organ/Organ!queryChildrenPage.action";
		document.srcForm.submit();
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" property="data">
	<BZ:form name="srcForm" method="post" action="organ/Organ!queryChildrenPage.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">

			<input id="Organ_IDS" name="IDS" type="hidden" />
			<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
			<input type="hidden" name="compositor" value="<%=compositor%>" />
			<input type="hidden" name="ordertype" value="<%=ordertype%>" />
			<!-- 父组织ID -->
			<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(Organ.PARENT_ID) %>" />
			<div class="heading">查询条件</div>
			<div class="chaxun">
			<table class="chaxuntj" border="0">
				<tr>
					<td width="15%" align="left">部门名称：</td>
					<td width="25%" align="left"><BZ:input field="CNAME" type="String" property="data" prefix="S_" defaultValue="" /></td>
					<td><input type="button" value="查询" class="button_search" onclick="search()" />&nbsp;&nbsp;</td>
				</tr>
			</table>
			</div>
			<div class="list">
			<div class="heading">组织机构列表</div>
			<BZ:table tableid="tableGrid" tableclass="tableGrid">
				<BZ:thead theadclass="titleBackGrey">
					<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp" />
					<BZ:th name="组织名称" sortType="string" width="20%" sortplan="database" sortfield="CNAME" />
					<BZ:th name="组织编码" sortType="string" width="15%" sortplan="database" sortfield="ORG_CODE" />
					<BZ:th name="英文简称" sortType="string" width="10%" sortplan="database" sortfield="ENNAME" />
					<BZ:th name="组织类型" sortType="string" width="15%" sortplan="database" sortfield="ORG_TYPE" />
					<BZ:th name="行政级别" sortType="string" width="10%" sortplan="database" sortfield="ORG_LEVEL" />
					<BZ:th name="排序号" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM" />
					<BZ:th name="状态" sortType="string" width="10%" sortplan="database" sortfield="STATUS" />
				</BZ:thead>
				<BZ:tbody>
					<BZ:for property="dataList" fordata="data">
						<tr>
							<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
							<td><BZ:data field="CNAME" onlyValue="true" /></td>
							<td><BZ:data field="ORG_CODE" defaultValue="" /></td>
							<td><BZ:data field="ENNAME" defaultValue="" /></td>
							<td><BZ:data field="ORG_TYPE" defaultValue="" codeName="organTypeList" /></td>
							<td><BZ:data field="ORG_GRADE" defaultValue="" /></td>
							<td><BZ:data field="SEQ_NUM" defaultValue="" /></td>
							<td><BZ:data field="STATUS" defaultValue=""	checkValue="1=正常;2=禁用;3=删除" /></td>
						</tr>
					</BZ:for>
				</BZ:tbody>
			</BZ:table>
			<table border="0" cellpadding="0" cellspacing="0" class="operation">
				<tr>
					<td colspan="2"><BZ:page form="srcForm" property="dataList" /></td>
				</tr>
				<tr>
					<td style="padding-left: 15px"></td>
					<td align="right" style="padding-right: 30px; height: 35px;">
						<input type="button" value="添加" class="button_add" onclick="add()" />&nbsp;&nbsp;
						<input type="button" value="查看" class="button_select" onclick="chakan()" />&nbsp;&nbsp;
						<input type="button" value="修改" class="button_update" onclick="_update()" />&nbsp;&nbsp;
						<input type="button" value="注销" class="button_delete" onclick="_delete()" />&nbsp;&nbsp;
						<input type="button" value="删除" class="button_delete" onclick="_deleteForce()" />&nbsp;&nbsp;
						<input type="button" value="组织调动" class="button_add" style="width: 80px" onclick="changeOrg()" />&nbsp;&nbsp;
					</td>
				</tr>
			</table>
			</div>
		</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>