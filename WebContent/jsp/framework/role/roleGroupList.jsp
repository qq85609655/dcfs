
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page import="hx.database.databean.*" %>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
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
<!-- 刷新角色组树 -->
<%=request.getAttribute("refreshTree")!=null?request.getAttribute("refreshTree"):"" %>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});

	var idnames=new Array();
	<%
		DataList list=(DataList)request.getAttribute("dataList");
		if(list!=null){

			for(int i=0;i<list.size();i++){
				String id=list.getData(i).getString("ID");
				String name=list.getData(i).getString("CNAME");
		%>
			idnames["<%=id%>"]="<%=name%>";
		<%
			}
		}
	%>


	function _onload(){

	}
	function search(){
	document.srcForm.action=path+"";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"role/RoleGroup!toAdd.action";
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
	document.srcForm.action=path+"role/RoleGroup!toAdd.action?<%=RoleGroup.ID %>="+ID;
	document.srcForm.submit();
	}
	}

	//分配角色
	function addRole(){
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
		//var PARENT_ID = document.getElementById("PARENT_ID").value;
		//var s = window.showModalDialog("role/RoleGroup!queryRoles.action?<%=RoleGroup.ID %>="+ID+"&<%=RoleGroup.PARENT_ID %>="+PARENT_ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=auto");
		document.srcForm.action=path+"role/RoleGroup!queryRoles.action?<%=RoleGroup.ID %>="+ID;
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
	document.srcForm.action=path+"role/RoleGroup!queryDetail.action?flag=detail&<%=RoleGroup.ID %>="+ID;
	document.srcForm.submit();
	}
	}
	function _delete(){
	var sfdj=0;
	var uuid="";
	var names="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
			names=names+idnames[document.getElementsByName('xuanze')[i].value]+"#";
			sfdj++;
		}
	}
	if(sfdj=="0"){
	alert('请选择要删除的数据');
	return;
	}else{
	if(confirm('确认要删除选中信息吗?')){
	document.getElementById("RoleGroup_IDS").value=uuid;
	document.getElementById("CNAMES").value=names;
	document.srcForm.action=path+"role/RoleGroup!deleteBatch.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}

	function changeOrgType(id){
		var PARENT_ID = document.getElementById("PARENT_ID").value;
		var s = window.showModalDialog("organ/Organ!modify.action?<%=RoleGroup.ID %>="+id+"&<%=RoleGroup.PARENT_ID %>="+PARENT_ID, this, "dialogWidth=200px;dialogHeight=150px;scroll=auto");

	}
	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="role/RoleGroup!queryChildrenPage.action">
<BZ:frameDiv property="clueTo" className="kuangjia">
<input id="RoleGroup_IDS" name="IDS" type="hidden"/>
<input type="hidden" name="CNAMES" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 父组织ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
<div class="list">
<div class="heading">角色组列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="角色组ID" sortType="string" width="25%" sortplan="database" sortfield="ID"/>
<BZ:th name="角色组名称" sortType="string" width="25%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="创建时间" sortType="date" width="25%" sortplan="jsp"/>
<BZ:th name="状态" sortType="string" width="15%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="ID" onlyValue="true"/></td>
<td><BZ:data field="CNAME" defaultValue=""/></td>
<td><BZ:data field="CREATE_TIME" defaultValue=""/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="1=有效;2=禁用;3=删除"/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="分配角色" class="button_add" onclick="addRole()" style="width: 80px"/>&nbsp;&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>