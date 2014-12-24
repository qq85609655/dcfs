
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String MODULE_ID=(String)request.getAttribute("MODULE_ID");
if(MODULE_ID==null){
	MODULE_ID="";
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
<title>资源列表</title>
<BZ:script isList="true" />
  <script type="text/javascript">
  $(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
  //利用资源添加菜单
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
	  document.srcForm.action=path+"resource/addMenue.action";
	  document.srcForm.submit();
	  }else{
	  return;
	  }
	  }
  }
  
  function _onload(){
  
  }
  function search(){
  document.srcForm.action=path+"CodeSortServlet";
  document.srcForm.submit(); 
  }
  
  function add(){
  document.srcForm.action=path+"resource/resourcesToAdd.action";
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
  document.srcForm.action=path+"resource/resourcesDetailed.action?ID="+ID+"&jsp=modify";
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
  document.srcForm.action=path+"resource/resourcesDetailed.action?ID="+ID+"&jsp=look";
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
  document.srcForm.action=path+"resource/resourcesDelete.action";
  document.srcForm.submit();
  }else{
  return;
  }
  }
  }
  
  function _bakModule(){
  document.location.href=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>&PMOUDLE=0";
  //document.srcForm.action=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>";
  //document.srcForm.submit();
  }
  
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="resource/resourcesList.action">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="P_MODULE_ID" value="<%=MODULE_ID%>"/>
<input type="hidden" name="APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="MODULE_ID" value="<%=MODULE_ID%>"/>
<input type="hidden" name="deleteid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">资源列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="资源名称" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="资源URL" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="资源权限控制URL" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="是否权限控制" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="是否菜单入口" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="状态" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="创建时间" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="描述" sortType="string" width="20%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" defaultValue=""/></td>
<td><BZ:data field="RES_URL" defaultValue=""/></td>
<td><BZ:data field="CTR_URL" defaultValue=""/></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("IS_VERIFY_AUTH",""))){%>是<%}else{ %>否<%} %></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("IS_NAVIGATE",""))){%>是<%}else{ %>否<%} %></td>
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
<td align="right" style="padding-right:30px;height:35px;">&nbsp;&nbsp;<input type="button" value="生成菜单" class="button_add" onclick="addMenue()"/>&nbsp;&nbsp;<input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;<%if(!"".equals(MODULE_ID)){ %><input type="button" value="返回" class="button_back" onclick="_bakModule()"/><%} %>
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>