
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
<title>列表</title>
<BZ:script isList="true" />
  <script type="text/javascript">
	function _onload(){
	
	}
	
	function search(){
		document.srcForm.action=path+"log/LogSys!query.action";
		document.srcForm.submit(); 
	}
	
	function _delete() {
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++) {
			if(document.getElementsByName('xuanze')[i].checked) {
				uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
				sfdj++;
			}
		}
		if(sfdj=="0") {
			alert('请选择要删除的数据');
			return;
		} else {
			if(confirm('确认要删除选中信息吗?')){
				document.getElementById("deleteuuid").value=uuid;
				document.srcForm.action=path+"log/LogSys!delete.action";
				document.srcForm.submit();
			} else {
		 		return;
			}
		}
	}
	
	function chakan() {
		var sfdj=0;
		var ID="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++) {
			if(document.getElementsByName('xuanze')[i].checked){
				ID=document.getElementsByName('xuanze')[i].value;
				sfdj++;
			}
		}
		if(sfdj!="1") {
			 alert('请选择一条数据');
			 return;
		} else {
			document.srcForm.action=path+"log/LogSys!lookLogSys.action?ID="+ID;
			document.srcForm.submit();
		}
	}
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="log/LogSys.action">
<input type="hidden" name="deleteuuid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<div class="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%">访问者名称：</td>
<td width="50%"><input type="text" name="LOGSYSEM_ACTOR_NAME" value=""/></td>
<td width="10%"></td>
<td width="20%"></td>
<td width="10%"><input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="序号" sortType="none" width="15%" sortplan="jsp"/>
	<BZ:th name="访问者ID" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="访问者名称" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="访问模块" sortType="none" width="25%" sortplan="jsp"/>
	<BZ:th name="访问资源ID" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="访问资源URL" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="访问时间" sortType="none" width="25%" sortplan="jsp"/>
	<BZ:th name="备注" sortType="string" width="25%" sortplan="jsp"/>
	<BZ:th name="日志级别" sortType="string" width="25%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="LOG_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="ACTOR_ID" defaultValue=""/></td>
	<td><BZ:data field="ACTOR_NAME" defaultValue=""/></td>
	<td><BZ:data field="MODULE_ID" defaultValue=""/></td>
	<td><BZ:data field="RESOURCE_ID" defaultValue=""/></td>
	<td><BZ:data field="RESOURCE_URL" defaultValue=""/></td>
	<td><BZ:data field="ACCESS_TIME" defaultValue=""/></td>
	<td><BZ:data field="MEMO" defaultValue=""/></td>
	<td><BZ:data field="LOG_LEVEL" defaultValue=""/></td>
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
<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>