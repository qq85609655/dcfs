
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
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

String path = request.getContextPath();
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
  
  function add(){
  document.srcForm.action=path+"role/Role!toAdd.action";
  document.srcForm.submit();
  }

  //分配角色给角色组
  function allotRole(){

	  var ID = document.getElementById("GROUP_ID").value;
	  //弹出
	  var PARENT_ID = document.getElementById("PARENT_ID").value;
	  window.showModalDialog("<%=path %>/role/RoleGroup!queryNoRolesFrame.action?<%=RoleGroup.ID %>="+ID+"&<%=RoleGroup.PARENT_ID %>="+PARENT_ID, this, "dialogWidth=880px;dialogHeight=350px;scroll=auto");	
	  //回调
	  document.srcForm.action = "<%=path %>/role/RoleGroup!queryRoles.action?<%=RoleGroup.ID %>="+ID;
	  document.srcForm.submit();
  }

  function _back(){
	document.srcForm.action=path+"role/RoleGroup!queryChildrenPage.action";
	document.srcForm.submit();
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
	   alert('请选择要移除的数据');
	   return;
	  }else{
	  if(confirm('确认要移除选中信息吗?')){
	  document.getElementById("RoleGroupRela_IDS").value=uuid;
	  document.srcForm.action=path+"role/RoleGroup!removeBatch.action";
	  document.srcForm.submit();
	  }else{
	  return;
	  }
	  }
	  }
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="role/RoleGroup!queryRoles.action">
<BZ:frameDiv property="clueTo">
<div class="kuangjia">
<input id="RoleGroupRela_IDS" name="IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 角色组ID -->
<input name="ID" id="ID" type="hidden" value="<%=request.getAttribute("ID")!=null?request.getAttribute("ID"):"" %>"/>
<input name="GROUP_ID" id="GROUP_ID" type="hidden" value="<%=request.getAttribute("ID")!=null?request.getAttribute("ID"):"" %>"/>
<!-- 角色组父ID -->
<input name="PARENT_ID" type="hidden" value="<%=request.getAttribute("PARENT_ID")!=null?request.getAttribute("PARENT_ID"):"" %>"/>
<div class="list">
<div class="heading">角色列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="35%" sortplan="jsp"/>
<BZ:th name="角色名称" sortType="string" width="65%" sortplan="database" sortfield="CNAME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="选择角色" class="button_add" onclick="allotRole()" style="width: 80px"/>&nbsp;&nbsp;<input type="button" value="移除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>