
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
DataList sysList=(DataList)request.getAttribute("sysList");
Data data=(Data)request.getAttribute("data");
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
<title>同步记录管理</title>
<BZ:script isList="true"  />
	<script type="text/javascript">

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
		document.srcForm.action=path+"sync/SyncRecord.action";
		document.srcForm.submit();
	}
	function _manualSync(){
	 var sfdj=0;
	 var uuid="";
	 var names="";
	 for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		 if(document.getElementsByName('xuanze')[i].checked){
			 uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
			 sfdj++;
		 }
	}
	if(sfdj=="0"){
	 alert('请选择要同步的数据');
	 return;
	}else{
	if(confirm('确认要同步选中信息吗?')){
		document.getElementById("deleteid").value=uuid;
		document.srcForm.action=path+"sync/syncRecordManual.action";
		document.srcForm.submit();
	}else{
	return;
	}
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
		document.srcForm.action=path+"sync/syncRecordDelete.action";
		document.srcForm.submit();
	}else{
	return;
	}
	}
	}
	function _onceSync(){
		if(confirm('确认要执行一键同步吗?')){
		 document.srcForm.action=path+"sync/syncRecordOnce.action";
	document.srcForm.submit();
	}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" property="data">
<BZ:form name="srcForm" method="post" action="sync/SyncRecord.action">
<input type="hidden" name="deleteid" />
<input type="hidden" name="CNAMES" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>

<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">同步记录管理</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="5%"></td>
<td width="15%">数据名称：</td>
<td width="20%"><BZ:input field="DATA_NAME" type="String" prefix="C_" defaultValue=""/></td>
<td width="5%"></td>
<td width="15%">事件类型：</td>
<td width="20%"><BZ:select field="EVENT_TYPE" formTitle="" prefix="C_">
					<BZ:option value="" selected="true">--请选择 --</BZ:option>
					<BZ:option value="addUser">添加用户</BZ:option>
					<BZ:option value="updateUser" >更新用户</BZ:option>
					<BZ:option value="deleteUser" >删除用户</BZ:option>
					<BZ:option value="addOrg" >添加组织机构</BZ:option>
					<BZ:option value="updateOrg" >更新组织机构</BZ:option>
					<BZ:option value="deleteOrg" >删除组织机构</BZ:option>
					<BZ:option value="modifyPwd" >修改用户密码</BZ:option>
				</BZ:select></td>
<td></td>
</tr>
<tr>
<td width="5%"></td>
<td width="15%">同步状态：</td>
<td width="20%"><BZ:select field="STATUS" formTitle="" prefix="C_">
					<BZ:option value="" selected="true">--请选择 --</BZ:option>
					<BZ:option value="0">成功</BZ:option>
					<BZ:option value="1">失败</BZ:option>
				</BZ:select></td>
<td width="5%"></td>
<td width="15%">同步方式：</td>
<td width="20%"><BZ:select field="SYNC_TYPE" formTitle="" prefix="C_">
					<BZ:option value="" selected="true">--请选择 --</BZ:option>
					<BZ:option value="auto">自动</BZ:option>
					<BZ:option value="manual">手动</BZ:option>
				</BZ:select></td>
<td></td>
</tr>
<tr>
<td width="5%"></td>
<td width="15%">目标系统：</td>
<td width="20%">
			<%
				for(int i = 0;i<sysList.size();i++){
					Data targetSys = sysList.getData(i);
					String targetId = targetSys.getString("TARGET_ID");
					String targetName = targetSys.getString("TARGET_NAME");
					%>
					<input type="checkbox" value="<%=targetId %>" name="C_TARGET_ID"
					<%//查询参数回落：
						String targetIdC = data.getString("TARGET_ID");
						if(targetIdC!=null && targetIdC.indexOf(targetId)!=-1){
							%>checked<%
						}
					%>
					><%=targetName %>&nbsp;
					<%
				}
			%>
</td>
<td width="5%"></td>
<td width="15%"></td>
<td width="20%"></td>
<td><input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">同步记录列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="5%" sortplan="jsp"/>
<BZ:th name="数据名称" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="事件类型" sortType="string" width="12%" sortplan="jsp"/>
<BZ:th name="目标系统" sortType="string" width="18%" sortplan="jsp"/>
<BZ:th name="同步方式" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="同步次数" sortType="int" width="10%" sortplan="jsp"/>
<BZ:th name="最近同步时间" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="同步状态" sortType="string" width="10%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="STATE_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="DATA_NAME" defaultValue=""/></td>
<td><BZ:data field="EVENT_TYPE" defaultValue="" checkValue="addUser=添加用户;updateUser=更新用户;deleteUser=删除用户;addOrg=添加组织机构;updateOrg=更新组织机构;deleteOrg=删除组织机构;modifyPwd=修改用户密码"/></td>
<td><BZ:data field="TARGET_NAME" defaultValue=""/></td>
<td><BZ:data field="SYNC_TYPE" defaultValue="" checkValue="auto=自动;manual=手动"/></td>
<td><BZ:data field="SYNC_TIMES" defaultValue=""/></td>
<td><BZ:data field="LAST_SYNC_TIME" defaultValue=""/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="0=成功;1=失败"/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="一键同步" class="button_send" onclick="_onceSync()"/>&nbsp;&nbsp;<input type="button" value="手动同步" class="button_send" onclick="_manualSync()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>