
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
	pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*"%>
<%@ page import="hx.util.InfoClueTo"%>
<%@ page import="com.hx.framework.propExtend.vo.PropExtend"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>

<%
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}
String parentId=(String)request.getParameter("parent_id");
if(parentId==null){
	parentId="";
}
String tableTitle="";
if(PropExtend.ORGAN_EXT.equals(parentId)){
	tableTitle="组织机构";
}else if(PropExtend.PERSON_EXT.equals(parentId)){
	tableTitle="人员";
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
	<title>列表</title>
	<BZ:script isList="true" isAjax="true" />
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
	  document.srcForm.action=path+"prop/propExtend!gotoAdd.action";
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
  document.srcForm.action=path+"prop/propExtend!toModify.action?<%=PropExtend.ID%>="+ID;
  document.srcForm.submit();
  }
  }
  
  function chakan(){
	   document.getElementById("view").value='true';
	   _update();
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
		  	if(confirm('确认要删除选中信息吗?')){
				  document.getElementById("PropExtend_IDS").value=uuid;
				  document.srcForm.action=path+"prop/propExtend!deleteProp.action";
				  document.srcForm.submit();
			 }else{
			  	return;
			 }
	  }
  }
  </script>
</BZ:head>
<BZ:body onload="_onload()">
	<BZ:form name="srcForm" method="post"
		action="prop/propExtend!gotoMainPage.action">
		<BZ:frameDiv property="clueTo" className="kuangjia">

			<input id="PropExtend_IDS" name="IDS" type="hidden" />
			<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
			<input type="hidden" name="compositor" value="<%=compositor%>" />
			<input type="hidden" name="ordertype" value="<%=ordertype%>" />
			<input type="hidden" name="parent_id" value="<%=parentId%>" />
			<input type="hidden" name="view" value="" />
			<div class="list">
			<div class="heading"><%=tableTitle%>扩展属性列表</div>
			<BZ:table tableid="tableGrid" tableclass="tableGrid">
				<BZ:thead theadclass="titleBackGrey">
					<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp" />
					<BZ:th name="属性名称" sortType="string" width="20%"
						sortplan="database" sortfield="PROP_NAME" />
					<BZ:th name="属性代码" sortType="string" width="15%"
						sortplan="database" sortfield="PROP_CODE" />
					<BZ:th name="输入类型" sortType="string" width="10%"
						sortplan="database" sortfield="INPUT_TYPE" />
					<BZ:th name="排序号" sortType="int" width="15%"
						sortplan="database" sortfield="SEQ_NUM" />
					<BZ:th name="创建时间" sortType="date" width="30%" sortplan="database"
						sortfield="CREATE_TIME" />
				</BZ:thead>
				<BZ:tbody>
					<BZ:for property="dataList" fordata="data">
						<tr>
							<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
							<td><BZ:data field="PROP_NAME" onlyValue="true" /></td>
							<td><BZ:data field="PROP_CODE" defaultValue="" /></td>
							<td><BZ:data field="INPUT_TYPE" defaultValue="" checkValue="text=文本输入框;textarea=文本域;radio=单选按钮;checkbox=复选框;selectSingle=单选列表;selectMulti=复选列表;organTree=组织树;personTree=人员树;dateWidget=日期选择"/></td>
							<td><BZ:data field="SEQ_NUM" defaultValue="" /></td>
							<td><BZ:data field="CREATE_TIME" defaultValue="" /></td>
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
					<td align="right" style="padding-right: 30px; height: 35px;"><input
						type="button" value="添加" class="button_add" onclick="add()" />&nbsp;&nbsp;<input
						type="button" value="查看" class="button_select" onclick="chakan()" />&nbsp;&nbsp;<input
						type="button" value="修改" class="button_update" onclick="_update()" />&nbsp;&nbsp;<input
						type="button" value="删除" class="button_delete"
						onclick="_deleteForce()" />&nbsp;&nbsp;</td>
				</tr>
			</table>
			</div>
		</BZ:frameDiv>
	</BZ:form>
</BZ:body>
</BZ:html>