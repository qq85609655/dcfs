
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
Data data=(Data)request.getAttribute("datatj");
if(data==null){
	data=new Data();
}
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
<title>导航列表</title>
<BZ:script isList="true" />
	<script type="text/javascript">

	function _onload(){
		$(document).ready(function(){
			dyniframesize(['mainFrame']);
		});
	}
	function search(){
	document.srcForm.action=path+"CodeSortServlet";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"navigation/navigationToAdd.action";
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
	document.srcForm.action=path+"navigation/navigationDetailed.action?ID="+ID+"&jsp=modify";
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
	document.srcForm.action=path+"navigation/navigationDetailed.action?ID="+ID+"&jsp=look";
	document.srcForm.submit();
	}
	}
	function _delete(){
	var sfdj=0;
	var uuid="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj=="0"){
	alert('请选择要删除的数据');
	return;
	}else{
	if(confirm('删除导航会删除所有导航的菜单确认删除?')){
	document.getElementById("deleteid").value=uuid;
	document.srcForm.action=path+"navigation/navigationDelete.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}

	function showmenu(){
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
	document.srcForm.action=path+"menu/menuFrame.action?NAV_ID="+ID;
	document.srcForm.submit();
	}
	}

	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="navigation/navigationList.action">
<input type="hidden" name="deleteid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">导航列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="导航栏名称" sortType="string" width="25%" sortplan="database" sortfield="NAV_NAME"/>
<BZ:th name="首页面URL" sortType="string" width="30%" sortplan="database" sortfield="NAV_URL"/>
<BZ:th name="显示顺序" sortType="string" width="20%" sortplan="database" sortfield="SEQ_NUM"/>
<BZ:th name="状态" sortType="string" width="15%" sortplan="database" sortfield="STATUS"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="NAV_NAME" defaultValue=""/></td>
<td><BZ:data field="NAV_URL" defaultValue=""/></td>
<td><BZ:data field="SEQ_NUM" defaultValue=""/></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("STATUS",""))){%>启用<%}else{ %>停用<%} %></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="进入菜单列表" class="button_goto" style="width:100px;" onclick="showmenu()"/>&nbsp;&nbsp;<input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>