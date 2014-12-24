<%@page language="java" contentType="text/html; charset=GBK" %>
<%@page import="hx.database.databean.DataList"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
//Object c=request.getAttribute("compositor");
//if(c!=null)
//	System.out.println("---------------"+c.getClass());
	
//String compositor = (String)request.getAttribute("compositor");
String compositor =null;
if(compositor==null){
	compositor="";
}
String ordertype=null;
//(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}
DataList data = (DataList)request.getAttribute("usergroup");
String group_type = (String)request.getAttribute("GROUP_TYPE");
String reValue = (String)request.getAttribute("reValue");
%>
<BZ:html>
<BZ:head>
<title>自定义群组设置</title>
<BZ:script isList="true" isDate="true"/>
<script type="text/javascript">
  function _onload(){
  	if('<%=reValue%>'!='null'&&'<%=reValue%>'!=""){
    		alert('<%=reValue%>');
    	}
  	
  }
  
  function _add(){
    var str = window.showModalDialog("<%=path%>/usergroup/tosetgroup.action?GROUP_TYPE=<%=group_type%>",null,"dialogWidth=998px;dialogHeight=600px;scroll:auto;");
    document.srcForm.action=path+"usergroup/list.action";
    document.srcForm.submit();
  }
	//自定义群组添加
  function _add1(){
    var str = window.showModalDialog("<%=path%>/usergroup/tosetgroup1.action?GROUP_TYPE=<%=group_type%>",null,"dialogWidth=980px;dialogHeight=600px;scroll:auto;");
    document.srcForm.action=path+"usergroup/list.action";
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
		  window.showModalDialog("<%=path%>/usergroup/toModify.action?ID="+ID,parent,"dialogWidth=998px;dialogHeight=600px;scroll:auto;");
		  //document.srcForm.action=path+"usergroup/toModify.action?ID="+ID;
		  //document.srcForm.submit();
		  document.srcForm.action=path+"usergroup/list.action";
    	  document.srcForm.submit();
	  }
  }
  //自定义群组修改
  function _update1(){
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
		  window.showModalDialog("<%=path%>/usergroup/toModify.action?ID="+ID,parent,"dialogWidth=998px;dialogHeight=600px;scroll:auto;");
		  //document.srcForm.action=path+"usergroup/toModify.action?ID="+ID;
		  //document.srcForm.submit();
		  document.srcForm.action=path+"usergroup/list.action";
    	  document.srcForm.submit();
	  }
  }
  
  function _modify(ID){
   		  window.showModalDialog("<%=path%>/usergroup/toModify.action?ID="+ID,parent,"dialogWidth=998px;dialogHeight=600px;scroll:auto;");
		  //document.srcForm.action=path+"usergroup/toModify.action?ID="+ID;
		  //document.srcForm.submit();
		  document.srcForm.action=path+"usergroup/list.action";
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
   alert('请选择要删除的数据');
   return;
   }else{
   if(confirm('确认要删除选中信息吗?')){
   document.getElementById("groupIDS").value=uuid;
   document.srcForm.action=path+"usergroup/delete.action";
   document.srcForm.submit();
   }else{
   return;
   }
   }
  }
  function _chakan()
  {
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
	  	  window.showModalDialog("<%=path%>/usergroup/showGroup.action?ID="+ID,null,"dialogWidth=550px;dialogHeight=320px");
		  //document.srcForm.action=path+"usergroup/showGroup.action?ID="+ID;
		  //document.srcForm.submit();
	  }
  }
  
  //分配权限
  function _allotGroups(){
	  var rs = window.showModalDialog("<%=path%>/usergroup/allotGroupsFrame.action?GROUP_TYPE=<%=group_type %>","AllotGroups","dialogWidth=998px;dialogHeight=600px;");
	  document.srcForm.action=path+"usergroup/list.action?GROUP_TYPE="+2;
	  document.srcForm.submit();
	  //var rs = window.showModalDialog("<%=path%>/usergroup/allotGroups.action?GROUP_TYPE=<%=group_type %>","AllotGroups","dialogWidth=998px;dialogHeight=600px;");
	  //window.open("<%=path%>/usergroup/allotGroups.action?GROUP_TYPE=<%=group_type %>");
  }
  
  function lookPurview(id){
	  window.showModalDialog("<%=path%>/usergroup/lookPurview.action?ID="+id,"lookPurview","dialogWidth=998px;dialogHeight=600px;");
	  //window.open("<%=path%>/usergroup/lookPurview.action?ID="+id);
  }
  
  function _exportExcel(id){
	  window.location.href = "<%=path%>/usergroup/exportExcel.action?ID="+id;
  }
</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="usergroup/list.action">
<div class="kuangjia">
<input id="groupIDS" name="IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<input type="hidden" name="GROUP_TYPE" value="<%=group_type %>"/> 
<div class="list">
<div class="heading">自定义群组</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" width="7%" sortType="none" sortplan="jsp"/>
<BZ:th name="群组名称" width="28%" sortType="string" sortplan="jsp"/>
<BZ:th name="人员" width="50%" sortType="string" sortplan="jsp"/>
<%
	if(group_type != null && "2".equalsIgnoreCase(group_type)){
%>
<BZ:th name="操作" width="15%" sortType="string" sortplan="jsp"/>
<%
	}
%>
</BZ:thead>
<BZ:tbody>
<BZ:for property="usergroups">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><a href="#" onclick="_modify('<BZ:data field="ID" onlyValue="true"/>');" title="<BZ:data field="TITLE" onlyValue="true"/>"><BZ:data field="GROUPNAME" onlyValue="true"/></a></td>
<td><BZ:data field="PERSONS" onlyValue="true"/></td>
<%
	if(group_type != null && "2".equalsIgnoreCase(group_type)){
%>
<td>
<a style="text-decoration: none;" href="javaScript:lookPurview('<BZ:data field="ID" onlyValue="true"/>');">查看权限</a>
<a style="text-decoration: none;" href="javaScript:_exportExcel('<BZ:data field="ID" onlyValue="true"/>');">导出</a>
</td>
<%
	}
%>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="usergroups"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<%
	if(group_type != null && "1".equalsIgnoreCase(group_type)){
%>
<input type="button" value="添加" class="button_add" onclick="_add1()"/>&nbsp;&nbsp; 
<input type="button" value="修改" class="button_update" onclick="_update1()"/>&nbsp;&nbsp;
<%
	}
%>

<%
	if(group_type != null && "2".equalsIgnoreCase(group_type)){
%>
<input type="button" value="添加" class="button_add" onclick="_add()"/>&nbsp;&nbsp; 
<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<%
	}
%>
<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="查看" class="button_add" onclick="_chakan()"/>
<%
	if(group_type != null && "2".equalsIgnoreCase(group_type)){
%>
&nbsp;&nbsp;<input type="button" value="分配权限" class="button_add" onclick="_allotGroups();"/>
<%
	}
%>
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>