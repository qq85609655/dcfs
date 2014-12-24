
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
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
<title>目标系统管理</title>
<BZ:script isList="true"  />
	<script type="text/javascript">
	$(document).ready(function(){
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
		document.srcForm.action=path+"sync/TargetSys.action";
		document.srcForm.submit();
	}

	function add(){
		document.srcForm.action=path+"sync/targetSysToAdd.action";
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
	document.srcForm.action=path+"sync/targetSysEdit.action?TARGET_ID="+ID+"&jsp=edit";
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
	document.srcForm.action=path+"sync/targetSysEdit.action?TARGET_ID="+ID+"&jsp=look";
	document.srcForm.submit();
	}
	}
	function _delete(){
	var sfdj=0;
	var uuid="";
	var names="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
			names=names+idnames[document.getElementsByName('xuanze')[i].value]+"#";
			sfdj++;
		}
	}
	if(sfdj=="0"){
	alert('请选择要删除的数据');
	return;
	}else{
	if(confirm('确认要删除选中信息吗?')){
		document.getElementById("deleteid").value=uuid;
		document.getElementById("CNAMES").value=names;
		document.srcForm.action=path+"sync/targetSysDelete.action";
		document.srcForm.submit();
	}else{
	return;
	}
	}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" property="data">
<BZ:form name="srcForm" method="post" action="sync/TargetSys.action">
<input type="hidden" name="deleteid" />
<input type="hidden" name="CNAMES" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<div class="heading_new">查询条件</div>
<BZ:frameDiv property="clueTo" className="kuangjia">

<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="5%"></td>
<td width="15%">目标系统：</td>
<td width="20%"><BZ:input field="TARGET_NAME" type="String" prefix="p_" defaultValue=""/></td>
<td width="5%"></td>
<td width="15%">实现类：</td>
<td width="20%"><BZ:input field="IMPL" type="String" prefix="p_" defaultValue=""/></td>
<td><input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">目标系统列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="5%" sortplan="jsp"/>
<BZ:th name="目标系统" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="用户同步实现类" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="组织同步实现类" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="创建时间" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="创建人" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="状态" sortType="string" width="5%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="TARGET_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="TARGET_NAME" defaultValue=""/></td>
<td><BZ:data field="USER_IMPL" defaultValue="" length="20"/></td>
<td><BZ:data field="ORG_IMPL" defaultValue="" length="20"/></td>
<td><BZ:data field="CREATE_DATE" defaultValue=""/></td>
<td><BZ:data field="CREATE_PERSON_ID" defaultValue=""/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="0=启用;1=禁用"/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>