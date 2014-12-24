
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String appId=(String)request.getParameter("appId");
if(appId==null){
	appId="";
}
String appName=(String)request.getAttribute("appName");
if(appName==null){
	appName="";
}
String appDev=(String)request.getAttribute("appDev");
if(appDev==null){
	appDev="";
}
String version=(String)request.getAttribute("version");
if(version==null){
	version="";
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
<up:uploadResource/>
<title>应用环境信息列表</title>
<BZ:script isList="true" />
<script src="<BZ:resourcePath/>/js/ajax.js"></script>
<script src="<BZ:resourcePath/>/js/breezeCommon.js"></script>
<script src="<BZ:resourcePath/>/js/framework.js"></script>
  <script type="text/javascript">
 
  function _onload(){
  
  }
  function search(){
  document.srcForm.action=path+"CodeSortServlet";
  document.srcForm.submit(); 
  }
  
  function add(){
	  document.srcForm.action=path+"app/toAppContextAdd.action";
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
  document.srcForm.action=path+"app/appContextDetail.action?ID="+ID+"&jsp=modify";
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
  document.srcForm.action=path+"app/appContextDetail.action?ID="+ID+"&jsp=look";
  document.srcForm.submit();
  }
  }
  function _delete(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
	   arr=document.getElementsByName('xuanze')[i].value.split("&");
	   uuid=uuid+"#"+arr[0];
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('请选择要删除的数据');
   return;
  }else{
  if(confirm('确认要删除选中信息吗?')){
  document.getElementById("deleteid").value=uuid;
  document.srcForm.action=path+"app/appContextDelete.action";
  document.srcForm.submit();
  }else{
  return;
  }
  }
  }
  
  function _back(){
 	document.srcForm.action=path+"app/resourceAppList.action";
 	document.srcForm.submit();
  }
  </script>
  <style>
  .chaxun{
 	 background:#e9f2fd;
  }
  .chaxuntj td{
  	padding:5px;
  	border-right:1px solid #fff;
  	border-top:1px solid #fff;
  	border-bottom:1px solid #fff;
  }
  .firsttd{
  	border-left:1px solid #fff;
  }
  </style>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="app/appContextList.action">
<input type="hidden" name="appId" id="appId" value="<%=appId %>"/>
<input type="hidden" name="deleteid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">应用基本信息</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%" class="firsttd">应用名称：</td>
<td width="20%"><%=appName %></td>
<td width="10%">开发商：</td>
<td width="20%"><%=appDev %></td>
<td width="10%">版本：</td>
<td width="20%"><%=version %></td>
<td width="10%"></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">应用环境信息列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="应用部署IP" sortType="string" width="15%" sortplan="database" sortfield="APP_IP"/>
<BZ:th name="端口号" sortType="string" width="15%" sortplan="database" sortfield="APP_PORT"/>
<BZ:th name="应用上下文" sortType="string" width="15%" sortplan="database" sortfield="APP_CONTEXT"/>
<BZ:th name="创建日期" sortType="string" width="25%" sortplan="database" sortfield="CREATE_TIME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="APP_IP" defaultValue=""/></td>
<td><BZ:data field="APP_PORT" defaultValue=""/></td>
<td>/<BZ:data field="APP_CONTEXT" defaultValue=""/></td>
<td><BZ:data field="CREATE_DATE"  type="Date" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="1"><BZ:page form="srcForm" property="dataList"/></td>
</tr>
<tr>
<td align="right">
&nbsp;<input type="button" value="添加" class="button_add" onclick="add()"/>
&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>
&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>
&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>
&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>