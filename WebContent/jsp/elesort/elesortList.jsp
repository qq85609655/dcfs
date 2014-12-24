<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
Data data=(Data)request.getAttribute("datatj");
if(data==null){
	data=new Data();
}
String parentId=(String)request.getAttribute("PARENT_ID");
if(parentId==null){
	parentId="";
}
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
<title>数据元列表</title>
<BZ:script isList="true" />
<!-- 刷新左侧数据元分类树 -->
<%
	String refreshTreeJS = (String)request.getAttribute("refreshTree");
	if(refreshTreeJS==null){
		refreshTreeJS="";
	}
	out.println(refreshTreeJS);
%>
	<script type="text/javascript">

	function _onload(){

	}
	function search(){
		document.srcForm.action=path+"EleSortServlet?method=eleSortList";
		document.srcForm.submit();
	}

	function add(){
		document.srcForm.action=path+"EleSortServlet?method=addEleSort";
		document.srcForm.submit();
	}
	function _update(){
	var sfdj=0;
	var eleSortId="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	eleSortId=document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj!="1"){
	alert('请选择一条数据');
	return;
	}else{
	document.srcForm.action=path+"EleSortServlet?method=editEleSort&eleSortId="+eleSortId;
	document.srcForm.submit();
	}
	}

	function chakan(){
	var sfdj=0;
	var eleSortId="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	eleSortId=document.getElementsByName('xuanze')[i].value;
	sfdj++;
	}
	}
	if(sfdj!="1"){
	alert('请选择一条数据');
	return;
	}else{
	document.srcForm.action=path+"EleSortServlet?method=lookelesort&eleSortId="+eleSortId;
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
	if(confirm('确认要删除选中信息吗?')){
	document.getElementById("deleteuuid").value=uuid;
	document.srcForm.action=path+"EleSortServlet?method=deleteElesort";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="EleSortServlet?method=eleSortList">
<input type="hidden" name="deleteuuid" />
<input type="hidden" name="p_PARENT_ID" value="<%=parentId %>"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">

<table class="chaxuntj">
<tr>
<td width="10%">分类名称：</td>
<td width="20%"><input type="text" name="p_ELE_SORT_NAME" value="<%=data.getString("ELE_SORT_NAME","") %>"/></td>
<td><input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">数据元分类列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
	<BZ:thead theadclass="titleBackGrey">
		<BZ:th name="序号" sortType="none" width="15%" sortplan="jsp"/>
		<BZ:th name="分类名称" sortType="string" width="25%" sortplan="database" sortfield="ELE_SORT_NAME"/>
		<BZ:th name="排序号" sortType="int" width="25%" sortplan="database" sortfield="SEQ_NUM"/>
		<BZ:th name="描述" sortType="string" width="35%" sortplan="jsp"/>
	</BZ:thead>
	<BZ:tbody>
		<BZ:for property="LIST" >
			<tr>
				<td tdvalue="<BZ:data field="ELE_SORT_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
				<td><BZ:a field="ELE_SORT_NAME" target="_self">EleSortServlet?method=codelist&parentSortId=<%=parentId%>&ELE_SORT_ID=<BZ:data field="ELE_SORT_ID" onlyValue="true"/></BZ:a ></td>
				<td><BZ:data field="SEQ_NUM" defaultValue=""/></td>
				<td><BZ:data field="ELE_SORT_DESC" defaultValue=""/></td>
			</tr>
		</BZ:for>
	</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="LIST"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>