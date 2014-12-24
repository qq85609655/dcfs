
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ page import="hx.util.InfoClueTo" %>
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
InfoClueTo clueTo = (InfoClueTo)request.getAttribute("clueTo");
int type = -1;
if(clueTo!=null){
	type = clueTo.getInfotype();
}
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>
  <script type="text/javascript">
  
  function _onload(){
  	
  }
  function search(){
  document.srcForm.action=path+"";
  document.srcForm.submit(); 
  }
  
  function _add(){
  	document.srcForm.action=path+"admin/toAdd.action";
  	document.srcForm.submit();
  	document.srcForm.action=path+"admin/adminList.action";
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
	  if(ID != null){
		  ID = ID.split(",")[0];
	  }
  document.srcForm.action=path+"admin/toModify.action?ADMIN_ID="+ID;
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
	  document.getElementById("ADMIN_IDS").value=uuid;
	  document.srcForm.action=path+"admin/deleteBatch.action";
	  document.srcForm.submit();
	  document.srcForm.action = path + "admin/adminList.action";
	  }else{
	  return;
	  }
	  }
	  }
  </script>
</BZ:head>
<BZ:body onload="_onload()" >
<BZ:form name="srcForm" method="post" action="admin/adminList.action">

<input type="hidden" name="ADMIN_IDS" value=""/>
<BZ:frameDiv property="clueTo" className="kuangjia">
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<div class="list">
<div class="heading">管理员列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid" >
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="8%" sortplan="jsp"/>
<BZ:th name="管理员姓名" sortType="string" width="10%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="管理员类型" sortType="string" width="10%" sortplan="database" sortfield="ADMIN_TYPE"/>
<BZ:th name="所属部门" sortType="string" width="30%" sortplan="database" sortfield="ORG_NAME"/>
<BZ:th name="可管理部门" sortType="string" width="17%" sortplan="jsp"/>
<BZ:th name="可授权的角色" sortType="string" width="25%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="onedata">
<tr>
<td tdvalue='<BZ:data field="ID" onlyValue="true"/>,<BZ:data field="PERSON_ID" onlyValue="true"/>'><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="ADMIN_TYPE" defaultValue="" checkValue="0=超级管理员;1=系统管理员;2=安全保密管理员;3=安全审计员;9=自定义管理员"/></td>
<td><BZ:data field="ORG_NAME" defaultValue=""/></td>
<td><BZ:data field="ORGAN_NAMES" defaultValue=""/></td>
<td><BZ:data field="ROLE_NAMES" defaultValue=""/></td>
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
<input type="button" value="添加" class="button_add" onclick="_add()"/>&nbsp;&nbsp;
<!-- 
<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
 -->
<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>