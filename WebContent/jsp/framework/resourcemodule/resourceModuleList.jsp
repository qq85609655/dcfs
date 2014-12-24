
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data" %>
<%@ page import="hx.util.InfoClueTo" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}
InfoClueTo clueTo = (InfoClueTo)request.getAttribute("clueTo");
int type = -1;
if(clueTo!=null)
{
	type = clueTo.getInfotype();
}
%>
<BZ:html>
<BZ:head>
<title>模块列表</title>
<BZ:script isList="true"  />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	//利用模块添加菜单
	function addMenue(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
		uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
		sfdj++;
		}
		}
		if(sfdj=="0"){
		alert('请选择要添加菜单的数据');
		return;
		}else{
		if(confirm('确认要增加选中应用对应菜单吗?')){
		document.getElementById("deleteid").value=uuid;
		document.srcForm.action=path+"module/addMenue.action";
		document.srcForm.submit();
		}else{
		return;
		}
		}
	}

	function _onload(){
		var type = <%=type%>;
		if(type==0)
		{
			parent.leftFrame.location ="<%=request.getContextPath() %>/module/resourceModuleTree.action?APP_ID=<%=APP_ID %>";
		}
	}
	function search(){
	document.srcForm.action=path+"CodeSortServlet";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"module/resourceModuleToAdd.action";
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
	document.srcForm.action=path+"module/resourceModuleDetailed.action?ID="+ID+"&jsp=modify";
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
	document.srcForm.action=path+"module/resourceModuleDetailed.action?ID="+ID+"&jsp=look";
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
	document.getElementById("deleteid").value=uuid;
	document.srcForm.action=path+"module/resourceModuleDelete.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}

	function _bakApp(){
		parent.document.location.href=path+"app/resourceAppList.action";
	//document.srcForm.action=path+"app/resourceAppList.action";
	//document.srcForm.submit();
	}

	function showresource(){
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
	document.srcForm.action=path+"resource/resourcesList.action?gotype=list&APP_ID=<%=APP_ID%>&MODULE_ID="+ID;
	document.srcForm.submit();
	}
	}

	</script>
</BZ:head>
<BZ:body onload="_onload()" >
<BZ:form name="srcForm" method="post" action="module/resourceModuleList.action?type=tree">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="PMOUDLE" id="PMOUDLE" value="<%=request.getAttribute("PMOUDLE") %>"/>
<input type="hidden" name="deleteid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">模块列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="模块名称" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="英文名称" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="父模块" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="是否需要权限控制" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="是否可管理" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="状态" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="创建时间" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="描述" sortType="string" width="10%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" defaultValue=""/></td>
<td><BZ:data field="ENNAME" defaultValue=""/></td>
<td><BZ:data field="PNAME" defaultValue=""/></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("NEED_RIGHT",""))){%>是<%}else{ %>否<%} %></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("ADMIN_FLAG",""))){%>是<%}else{ %>否<%} %></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("STATUS",""))){%>启用<%}else{ %>停用<%} %></td>
<td><BZ:data field="CREATE_TIME" defaultValue=""/></td>
<td><BZ:data field="MEMO" defaultValue=""/></td>
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
<td align="right" style="padding-right:30px;height:35px;">&nbsp;&nbsp;<input type="button" value="生成菜单" class="button_add" onclick="addMenue()"/>&nbsp;&nbsp;<input type="button" value="进入资源列表" class="button_goto" onclick="showresource()" style="width:100px;"/>&nbsp;&nbsp;<input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;<%if(!"".equals(APP_ID)){ %><input type="button" value="返回" class="button_back" onclick="_bakApp()"/><%} %>
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>