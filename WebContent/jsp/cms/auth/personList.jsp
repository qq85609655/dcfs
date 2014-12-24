<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.auth.vo.PersonChannelRela"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

//检查权限标识
String checkAudit = (String)request.getAttribute("CHECK_AUDIT");
//搜索条件
Data sdata = (Data)request.getAttribute("data");
if(sdata == null){
	sdata = new Data();
}
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>
  <script type="text/javascript">
  
  $(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
  });
	
  function search(){
	  document.srcForm.action=path+"cms_auth/Auth!personList.action";
	  document.srcForm.submit();
  }
  
  function allotAudit(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('请选择要授权的人');
   return;
  }else{
  if(confirm('确认要授权吗?')){
	//调用角色树
	parent.left1Frame._ok();
	document.getElementById("ROLES_IDS").value = parent.left1Frame.document.getElementById("ROLE_IDS").value;
	document.getElementById("PERSONS_IDS").value = uuid;
	document.srcForm.action = "<%=request.getContextPath() %>/role/Authorize!personAuthorize.action";
  	document.srcForm.submit();
  }else{
  return;
  }
  }
  }
	
	//查看组织机构对应的角色权限
	function queryAudit(){
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
			  var flag = window.showModalDialog("<%=request.getContextPath() %>/role/Authorize!perFrame.action?PERSON_IDS="+ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=auto");
			  if(flag == "true"){
			  	document.srcForm.submit();
			  }
		  }
		  }
		  
	//查询所有没有分配角色的用户
	function checkAudit(){
		document.srcForm.action = "<%=request.getContextPath() %>/person/Person!queryNoRolesPersons.action";
		document.getElementById("CHECK_AUDIT").value = "CHECK_AUDIT";
		document.srcForm.submit();
	}
	
	//选择组织机构
	function selectOrgan(){
		var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=300px;dialogHeight=300px;scroll=auto");
		document.getElementById("ORGAN_ID_").value = reValue["value"];
		document.getElementById("ORGAN_NAME_").value = reValue["name"];
		if(reValue["value"] == ""){
			document.getElementById("ORG_ID").value = "0";
		}
	}
	
	function writerChannels(){
	   var sfdj=0;
	   var uuid="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
	   sfdj++;
	   }
	  }
	  if(sfdj=="0"){
	   alert('请选择要授权的人');
	   return;
	  }else{
	  if(confirm('确认要授权吗?')){
		//调用角色树
		parent.left1Frame._ok();
		document.getElementById("CHANNEL_IDS").value = parent.left1Frame.document.getElementById("CHANNEL_IDS").value;
		document.getElementById("PERSONS_IDS").value = uuid;
		document.srcForm.action = "<%=request.getContextPath() %>/cms_auth/Auth!writerChannels.action";
	  	document.srcForm.submit();
	  }else{
	  return;
	  }
	  }
	}
	
	function auditChannels(){
		var sfdj=0;
	   var uuid="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
	   sfdj++;
	   }
	  }
	  if(sfdj=="0"){
	   alert('请选择要授权的人');
	   return;
	  }else{
	  if(confirm('确认要授权吗?')){
		//调用角色树
		parent.left1Frame._ok();
		document.getElementById("CHANNEL_IDS").value = parent.left1Frame.document.getElementById("CHANNEL_IDS").value;
		document.getElementById("PERSONS_IDS").value = uuid;
		document.srcForm.action = "<%=request.getContextPath() %>/cms_auth/Auth!auditChannels.action";
	  	document.srcForm.submit();
	  }else{
	  return;
	  }
	  }
	}
	
	//回显授权情况，并可以再次授权
	function toAlotPersonChannels(personId,role){
		window.showModalDialog("<BZ:url/>/cms_auth/Auth!toAlotPersonChannelsFrame.action?PERSONS_ID="+personId+"&ROLE="+role, this, "dialogWidth=500px;dialogHeight=600px;overflow:scroll;overflow-x:hidden");
	}
  </script>
</BZ:head>
<BZ:body>
<BZ:form name="srcForm" method="post" isContextPath="true" action="cms_auth/Auth!personList.action">

<!-- 参数区开始 -->

<!-- 栏目树 -->
<input name="CHANNEL_IDS" id="CHANNEL_IDS" type="hidden"/>

<!-- 授权人员 -->
<input name="PERSONS_IDS" id="PERSONS_IDS" type="hidden"/>

<!-- 当前人员列表所属的组织机构ID -->
<input id="ORG_ID" name="ORG_ID" value="<%=request.getParameter(OrganPerson.ORG_ID) %>" type="hidden">

<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>

<!-- 参数区结束 -->

<div class="kuangjia">
<!-- 查询条件 -->
<div class="heading">查询条件</div>
<div class="chaxun">
	<table class="chaxuntj">
		<tr>
			<td width="20%" align="right" nowrap="nowrap">部门：</td>
			<td width="30%" align="left">
				<input type="hidden" id="ORGAN_ID_" name="S_ORGAN_ID_" value='<%=sdata.getString("ORGAN_ID_")!=null?sdata.getString("ORGAN_ID_"):"" %>'/>
				<input type="text" id="ORGAN_NAME_" name="S_ORGAN_NAME_" value='<%=sdata.getString("ORGAN_NAME_")!=null?sdata.getString("ORGAN_NAME_"):"" %>' readonly="readonly" onclick="selectOrgan();"/>
			</td>
			<td width="20%" align="right" nowrap="nowrap">人员姓名：</td>
			<td width="30%" align="left"><input name="S_PERSON_NAME_" type="text" value='<%=sdata.getString("PERSON_NAME_")!=null?sdata.getString("PERSON_NAME_"):"" %>'/></td>
			
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="button" value="查询" class="button_search" onclick="search()"/>
			</td>
		</tr>
	</table>
</div>

<div class="list">
<div class="heading">选择人员</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="" sortType="none" width="12%"/>
<BZ:th name="姓名" sortType="string" width="20%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="所属机构" sortType="none" width="30%"/>
<BZ:th name="权限" sortType="none" width="38%"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="PERSON_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="ORG_NAME" onlyValue="true"/></td>
<td align="center">
	<a href="javascript:toAlotPersonChannels('<BZ:data field="PERSON_ID" onlyValue="true"/>','<%=PersonChannelRela.ROLE_STATUS_WRITER %>');" style="text-decoration: none">投稿权限</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:toAlotPersonChannels('<BZ:data field="PERSON_ID" onlyValue="true"/>','<%=PersonChannelRela.ROLE_STATUS_AUTHER %>');" style="text-decoration: none">审核权限</a>
</td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList" type="special"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:5xpx;height:35px;">
<input type="button" value="投稿人授权" class="button_add" style="width: 90px" onclick="writerChannels()"/>&nbsp;&nbsp;
<input type="button" value="审核人授权" class="button_add" style="width: 90px" onclick="auditChannels()"/>
<!-- &nbsp;&nbsp;<input type="button" value="查看权限" class="button_add" style="width: 80px" onclick="queryAudit()"/> -->
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>