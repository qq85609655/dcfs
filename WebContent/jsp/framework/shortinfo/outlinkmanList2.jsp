<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="hx.database.databean.DataList"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

String organId = (String)request.getAttribute("ORGAN_ID");
if(organId == null){
		organId = "";
}

DataList data = (DataList)request.getAttribute("linkmans");

DataList errdata = (DataList)request.getAttribute("ERR_DATA");
String errMsg = "";
if(errdata!=null){
	int len = errdata.size();
	for(int i=0;i<len;i++){
		if(i>0){
			errMsg  +=";";
		}
		errMsg  += (i+1) + ":" +(String)errdata.get(i);
	}
}
%>
<BZ:html>
<BZ:head>
<title></title>
<BZ:script isList="true" isDate="true"/>
<script type="text/javascript">
<%
if (!"".equals(errMsg)){
	%>
	alert("<%=errMsg%>");
	<%
}
%>
$(document).ready(function() {
	dyniframesize(['outerlist','mainFrame']);
});
	function _onload(){


	}

	function _add(){
		document.srcForm.action=path+"linkman/toadd.action";
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
			document.srcForm.action=path+"linkman/toModify.action?ID="+ID;
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
	alert('请选择要删除的数据');
	return;
	}else{
	if(confirm('确认要删除选中信息吗?')){
	document.getElementById("LinkMan_IDS").value=uuid;
	document.srcForm.action=path+"linkman/delete.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}
	function _search()
	{
		document.srcForm.action=path+"linkman/outerlist.action";
		document.srcForm.page.value = 1;
		document.srcForm.submit();
		document.srcForm.action=path+"linkman/outerlist.action";
	}

	//分配权限
	function _linkmanAllotPerview(){
		var rs = window.showModalDialog("<%=path%>/usergroup/allotLinkmansFrame.action","AllotLinkmans","dialogWidth=998px;dialogHeight=700px;");
		//var rs = window.showModalDialog("<%=path%>/usergroup/allotLinkmans.action","AllotLinkmans","dialogWidth=998px;dialogHeight=700px;");
		//window.open("<%=path%>/usergroup/allotLinkmans.action");
		document.srcForm.submit();
	}

</script>
<link rel="stylesheet" type="text/css" href="<%=path %>/jsp/framework/shortinfo/css/kuangjia.css" />
</BZ:head>
<BZ:body onload="_onload()">
<form name="srcForm" method="post" action="<%=request.getContextPath() %>/linkman/outerlist.action">
<div class="kuangjia" style="margin: 0;">
<div class="heading">查询条件</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%" style="text-align: right;">姓名：</td>
<td width="20%"><BZ:input field="CNAME" property="search" prefix="SEARCH_" defaultValue=""/></td>
<td width="10%">部门：</td>
<td width="20%"><BZ:input field="ORGNAME" property="search" prefix="SEARCH_" defaultValue=""/></td>
<td width="10%">手机号：</td>
<td width="20%"><BZ:input field="MOBILE" property="search" prefix="SEARCH_" defaultValue=""/></td>
<td width="10%"><input type="button" value="查询" class="button_search" onclick="_search()"/></td>
</tr>
</table>
</div>
<input id="LinkMan_IDS" name="IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->

<!-- 组织ID -->
<input type="hidden" name="ORGAN_ID" value="<%=organId%>"/>

<div class="list">
<div class="heading">联系人列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" width="5%" sortType="none" sortplan="jsp"/>
<BZ:th name="姓名" width="10%" sortType="string" sortplan="database" sortfield="CNAME"/>
<BZ:th name="手机号" width="15%" sortType="string" sortplan="database" sortfield="MOBILE"/>
<BZ:th name="部门" width="15%" sortType="string" sortplan="database" sortfield="ORGNAME"/>
<BZ:th name="类型" width="10%" sortType="string" sortplan="database" sortfield="TYPE"/>
<BZ:th name="创建人" width="10%" sortType="string" sortplan="database" sortfield="NAME"/>
<BZ:th name="创建人部门" width="15%" sortType="string" sortplan="database" sortfield="CREATE_DEPT_NAME"/>
<BZ:th name="创建日期" width="20%" sortType="date" sortplan="database" sortfield="CREATE_TIME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="linkmans">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true" defaultValue=""/></td>
<td><BZ:data field="MOBILE" onlyValue="true" defaultValue=""/></td>
<td><BZ:data field="ORGNAME" onlyValue="true" defaultValue=""/></td>
<td><BZ:data field="TYPE" onlyValue="true" defaultValue="" checkValue="1=外部人员"/></td>
<td><BZ:data field="NAME" onlyValue="true" defaultValue=""/></td>
<td><BZ:data field="CREATE_DEPT_NAME" onlyValue="true" defaultValue=""/></td>
<td><BZ:data field="CREATE_TIME" type="string" onlyValue="true"/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="linkmans"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<input type="button" value="添加" class="button_add" onclick="_add()"/>&nbsp;&nbsp;
<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="联系人授权" class="button_add" onclick="_linkmanAllotPerview();"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</form>

</BZ:body>
</BZ:html>
