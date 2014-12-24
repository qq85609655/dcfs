<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.person.vo.Person"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.framework.common.FrameworkConfig"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);

	String compositor=(String)request.getParameter("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getParameter("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function SEQNUM_update(){

		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				uuid=uuid+"#"+arr[0];
				ORG_ID=ORG_ID+"#"+arr[1];
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('请选择要更新排序号的人员');
			return;
		}

		document.srcForm.action=path+"person/Person!updateSeqNum.action";
		document.srcForm.submit();
	}

	function _onload(){

	}
	function search(){
		document.srcForm.action=path+"person/Person!query.action";
		document.srcForm.submit();
	}

	function add(){
			var org_id = document.getElementById("ORG_ID").value;
			if(org_id=="0" || org_id==""){
				alert("请在左侧树上选择部门后再添加人员！");
				return;
			}
		document.srcForm.action=path+"person/Person!toAdd.action";
		document.srcForm.submit();
	}
	function _update(){
	var sfdj=0;
	var ID="";
	var ORG_ID="";
	var arr ;
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			arr=document.getElementsByName('xuanze')[i].value.split("&");
			ID=arr[0];
			ORG_ID=arr[1];
			sfdj++;
		}
	}
	if(sfdj!="1"){
	alert('请选择一条数据');
	return;
	}else{
	document.getElementById("ORG_ID").value=ORG_ID;
	document.srcForm.action=path+"person/Person!toModify.action?<%=Person.PERSON_ID %>="+ID;
	document.srcForm.submit();
	}
	}

	//设置管理员
	function setAdmin(){
		var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
			}
		}
		if(sfdj!="1"){
		alert('请选择一条数据');
		return;
		}else{
			document.getElementById("ORG_ID").value=ORG_ID;
			document.srcForm.action=path+"person/Person!toSetAdmin.action?<%=Person.PERSON_ID %>="+ID;
			document.srcForm.submit();
		}
	}

	function addAccount(){
		var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
			}
		}
		if(sfdj!="1"){
		alert('请选择一条数据');
		return;
		}else{
			document.getElementById("ORG_ID").value=ORG_ID;
			document.srcForm.action=path+"person/Person!toAddAccount.action?<%=Person.PERSON_ID %>="+ID+"&_TO=addAccount";
			document.srcForm.submit();
		}
	}
	function _resetPwd(){
		var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
				if(arr[2]=="null"||arr[2]==null||arr[2]==""){
					alert("人员未分配账号！");
					return;
				}
				}
		}
		if(sfdj!="1"){
			alert('请选择一条数据');
			return;
		}else{
			document.getElementById("ORG_ID").value=ORG_ID;
			document.srcForm.action=path+"person/Person!toAddAccount.action?<%=Person.PERSON_ID %>="+ID+"&_TO=resetPwd";
			document.srcForm.submit();
		}
	}

	function changeBelong(){
			var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
			}
		}
		if(sfdj!="1"){
			alert('请选择一条数据');
			return;
		}else{
			//var clo = window.showModalDialog("person/Person!changeBelongFrame.action?<%=OrganPerson.ORG_ID %>="+ORG_ID+"&<%=Person.PERSON_ID %>="+ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=no");
			window.open("person/Person!changeBelongFrame.action?<%=OrganPerson.ORG_ID %>="+ORG_ID+"&<%=Person.PERSON_ID %>="+ID);
			if(clo){
			document.srcForm.action=path+"person/Person!query.action";
				document.srcForm.submit();
			}
		}
	}

	function exportExcel(){
		if(confirm('确认要导出为Excel文件吗?')){
			document.srcForm.action=path+"person/exportExcel.action";
			document.srcForm.submit();
		}
		else{
			return;
		}
	}

	function changeOrg(){
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				uuid=uuid+"!"+arr[0];
				ORG_ID=ORG_ID+"!"+arr[1];
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('请选择要调整的数据');
			return;
		}else{
			//var ORG_ID = document.getElementById("ORG_ID").value;
			document.srcForm.action=path+"person/Person!query.action";
			window.showModalDialog("person/Person!changeOrgFrame.action?<%=OrganPerson.ORG_ID %>="+ORG_ID+"&<%=Person.PERSON_ID %>="+uuid, this, "dialogWidth=300px;dialogHeight=300px;scroll=auto");
			document.srcForm.submit();
		}
	}

	function chakan(){
	var sfdj=0;
	var ID="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
		ID=document.getElementsByName('xuanze')[i].value.split("&")[0];
		sfdj++;
	}
	}
	if(sfdj!="1"){
		alert('请选择一条数据');
		return;
	}else{
		//用href进行跳转
		document.srcForm.action=path+"person/Person!queryDetail.action?flag=detail&<%=Person.PERSON_ID %>="+ID;
		document.srcForm.submit();
	}
	}
	function _delete(){
	var sfdj=0;
	var uuid="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			uuid=uuid+document.getElementsByName('xuanze')[i].value.split("&")[0]+"#";
			sfdj++;
			arr=document.getElementsByName('xuanze')[i].value.split("&");
			if(arr[2]=="null"){
				alert("无法逻辑删除未分配账号的人员！");
				return;
			}
		}
	}
	if(sfdj=="0"){
	alert('请选择要删除的数据');
	return;
	}else{
		if(confirm('确认要删除选中信息吗?')){
			document.getElementById("Person_IDS").value=uuid;
			var ORG_ID = document.getElementById("ORG_ID").value;
			document.srcForm.action=path+"person/Person!deleteBatch.action?<%=OrganPerson.ORG_ID %>="+ORG_ID;
			document.srcForm.submit();
		}else{
			return;
		}
	}
	}

	function _resetAccount(type1){//解锁
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				uuid=uuid+"#"+arr[0];
				ORG_ID=ORG_ID+"#"+arr[1];
				sfdj++;
			}
		}
		var s="锁定";
		if(type1=='unlock') s="解锁";
		if(type1=='disable') s="禁用";

		if(sfdj=="0"){
			alert('请选择要'+s+'的账号');
			return;
		}else{
			if(confirm('确认要'+s+'选中的账号吗?')){
				document.getElementById("Person_IDS").value=uuid;
				//var ORG_ID = document.getElementById("ORG_ID").value;
				document.srcForm.action=path+"person/Person!resetAccount.action?TYPE1="+type1+"&ORG_ID="+ORG_ID;
				//alert(document.srcForm.action);
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	function _deleteAccount(){// sysadmin   secadmin  auditadmin admin
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");

				if(arr[0]=='sysadmin' || arr[0]=='secadmin' || arr[0]=='auditadmin'  || arr[0]=='admin' ){
					alert("系统内置人员，不允许删除！");
					return;
				}

				uuid=uuid+"#"+arr[0];
				ORG_ID=ORG_ID+"#"+arr[1];
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('请选择要删除的数据');
			return;
		}else{
			if(confirm('确认要删除选中信息吗?')){
				document.getElementById("Person_IDS").value=uuid;
				//var ORG_ID = document.getElementById("ORG_ID").value;
				document.srcForm.action=path+"person/Person!deleteAccount.action?<%=OrganPerson.ORG_ID %>="+ORG_ID;
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	function _deleteForce(){
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			arr=document.getElementsByName('xuanze')[i].value.split("&");

			//alert(arr[0]);//sysadmin   secadmin  auditadmin admin
			if(arr[0]=='sysadmin' || arr[0]=='secadmin' || arr[0]=='auditadmin'  || arr[0]=='admin' ){
				alert("系统内置人员，不允许删除！");
				return;
			}

			uuid=uuid+"#"+arr[0];
			ORG_ID=ORG_ID+"#"+arr[1];
			sfdj++;
		}
		}
		if(sfdj=="0"){
			alert('请选择要删除的数据');
			return;
		}else{
			if(confirm('确认要删除选中信息吗?')){
				document.getElementById("Person_IDS").value=uuid;
				//var ORG_ID = document.getElementById("ORG_ID").value;
				document.srcForm.action=path+"person/Person!deleteForce.action?<%=OrganPerson.ORG_ID %>="+ORG_ID;
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	//选择组织机构
	function selectOrgan(){
		var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=400px;dialogHeight=600px;scroll=auto");

		if(reValue){
			document.all("S_ORG_ID").value = reValue["value"];
			document.all("A_ORGAN_NAME").value = reValue["name"];
		}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="SEX;SYS_ORGAN_ALL" >
<BZ:form name="srcForm" method="post" action="person/Person!query.action">
<BZ:frameDiv property="clueTo" className="kuangjia">
<input id="Person_IDS" name="IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 当前人员列表所属的组织机构ID -->
<input type="hidden" id="ORG_ID" name="ORG_ID" value="<%=request.getParameter("S_ORG_ID")==null?"":request.getParameter("S_ORG_ID") %>" >



	<div class="heading">查询条件</div>
	<div  class="chaxun">
		<table class="chaxuntj">
			<tr>
				<td width="10%" align="right" nowrap="nowrap">部门：</td>
				<td width="20%" align="left">
					<BZ:input type="hidden" prefix="S_" field="ORG_ID" defaultValue="" property="data"/>
					<BZ:input type="String" prefix="A_" field="ORGAN_NAME" defaultValue="" readonly="true" onclick="selectOrgan();" property="data"/>
				</td>
				<td width="10%" align="right" nowrap="nowrap">人员名称：</td>
				<td width="20%" align="left"><BZ:input field="CNAME" type="String" property="data" prefix="S_" defaultValue="" /></td>
				<td width="10%"></td>
				</tr>
				<tr>
				<td width="10%" align="right" nowrap="nowrap" >人员账号：</td>
				<td width="20%" align="left"><BZ:input field="ACCOUNT_ID" type="String"  property="data" prefix="S_" defaultValue="" /></td>
				<td width="10%" align="right" nowrap="nowrap" >账号状态：</td>
				<td width="20%" align="left" >
					<BZ:select field="STATUS" formTitle="" prefix="S_"  property="data">
						<BZ:option value="">全部</BZ:option>
						<BZ:option value="1">正常</BZ:option>
						<BZ:option value="2">锁定</BZ:option>
						<BZ:option value="4">禁用</BZ:option>
						<BZ:option value="3">删除</BZ:option>
					</BZ:select>
				</td>
				<td width="10%">
					<input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>


<div class="list">
<div class="heading">人员列表</div>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<%
	//系统保密管理员和超级管理员才能分配账号
	if(("0".equals(user.getAdminType()) || "1".equals(user.getAdminType()))	){
%>
<input type="button" value="添加" class="button_add" style="width:50px" onclick="add()"/>&nbsp;&nbsp;
<input type="button" value="修改" class="button_update" style="width:50px" onclick="_update()"/>&nbsp;&nbsp;
<input type="hidden" value="查看" class="button_select" style="width:50px" onclick="chakan()"/>&nbsp;&nbsp;
<!--  <input type="button" value="人员调动" class="button_add" style="width: 80px" onclick="changeOrg()"/>&nbsp;&nbsp;-->
<%if(1!=1){ %>
<input type="button" value="调整在编部门" class="button_add" style="width: 100px" onclick="changeBelong()"/>&nbsp;&nbsp;
<%} %>
<input type="button" value="导出" class="button_add" style="width: 50px" onclick="exportExcel()"/>&nbsp;&nbsp;
<input type="button" value="更新排序号" class="button_update" style="width: 90px" onclick="SEQNUM_update()"/>&nbsp;&nbsp;
<input type="button" value="注销" style="width: 50px" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="删除" style="width: 50px" class="button_delete" onclick="_deleteForce()"/>
<%} %>
</td>
</tr>
</table>
<BZ:table tableid="tableGrid" tableclass="tableGrid" >
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="姓名" sortType="string" width="10%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="账号" sortType="string" width="10%" sortplan="database" sortfield="ACCOUNT_ID"/>
<BZ:th name="性别" sortType="string" width="10%" sortplan="database" sortfield="SEX"/>
<BZ:th name="账号类型" sortType="date" width="10%" sortplan="database" sortfield="ACCOUNT_TYPE"/>
<BZ:th name="账号状态" sortType="string" width="10%" sortplan="database" sortfield="STATUS"/>
<BZ:th name="部门" sortType="string" width="10%" sortplan="database" sortfield="ORGAN_NAME"/>
<BZ:th name="组织权限" sortType="string" width="10%" sortplan="database" sortfield="ORGAN_RIGHT"/>
<BZ:th name="是否绑定" sortType="string" width="10%" sortplan="database" sortfield="AUTH_TYPE"/>
<BZ:th name="排序号" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="onedata">
<tr <%String status=((Data) pageContext.getAttribute("onedata")).getString("STATUS"); if("3".equals(status)){ %> style="color:#808080" <%};if("2".equals(status)){ %> style="color:#0000FF" <%} ;if("4".equals(status)){ %> style="color:red" <%} %> >
<td tdvalue="<BZ:data field="Person_ID" onlyValue="true"/>&<BZ:data field="ORG_ID" onlyValue="true"/>&<BZ:data field="ACCOUNT_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="ACCOUNT_ID" defaultValue=""/></td>
<td><BZ:data field="SEX" defaultValue="" codeName="SEX"/></td>
<td><BZ:data field="ACCOUNT_TYPE" defaultValue="" checkValue="0=临时;1=普通用户;2=guest用户"/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="1=正常;2=锁定;3=删除;4=禁用"/></td>
<td><BZ:data field="ORGAN_NAME" defaultValue=""/></td>
<td><BZ:data field="ORGAN_RIGHT" defaultValue=""  codeName="SYS_ORGAN_ALL"/></td>
<td><BZ:data field="AUTH_TYPE" defaultValue="2" checkValue="2=绑定;1=不绑定"/></td>
<td><input style= "width:50%; " type="text" name="SEQ_<BZ:data field="Person_ID" onlyValue="true"/>" style="width:100%" value="<BZ:data field="SEQ_NUM" defaultValue="0" onlyValue="true"/>"></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">

<%
	//系统管理员和超级管理员才能分配账号
	if("0".equals(user.getAdminType()) || "1".equals(user.getAdminType()) ){
%>
	<input type="button" value="分配账号" class="button_add" style="width: 80px" onclick="addAccount()"/>&nbsp;&nbsp;
	<input type="button" value="重置密码" class="button_reset" style="width: 80px" onclick="_resetPwd()"/>&nbsp;&nbsp;
	<input type="button" value="删除账号" class="button_delete" style="width: 80px" onclick="_deleteAccount()"/>&nbsp;&nbsp;
<%} %>

<%
	if(FrameworkConfig.isMultistageAdminMode()){

}
	//系统保密管理员和超级管理员才能分配账号
	if("0".equals(user.getAdminType()) ||
			(FrameworkConfig.isThreeAdminMode() && "2".equals(user.getAdminType()))
			|| (FrameworkConfig.isMultistageAdminMode() && "1".equals(user.getAdminType())) ){
%>

	<input type="button" value="锁定账号" style="width: 80px" class="button_reset" onclick="_resetAccount('lock')"/>&nbsp;&nbsp;
	<input type="button" value="禁用账号" style="width: 80px" class="button_reset" onclick="_resetAccount('disable')"/>&nbsp;&nbsp;
	<input type="button" value="解锁账号" style="width: 80px" class="button_reset" onclick="_resetAccount('unlock')"/>&nbsp;&nbsp;
<%} %>

</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>