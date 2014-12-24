
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
<script src="<BZ:resourcePath/>/js/date/WdatePicker.js"></script>
  <script type="text/javascript">
  
	function _onload() {
		
	}
	
	function search() {
		document.srcForm.action=path+"audit/AuditSys!query.action";
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
			if(confirm('确认要删除选中信息吗?')) {
				document.getElementById("deleteuuid").value=uuid;
				document.srcForm.action=path+"audit/AuditSys!delete.action";
				document.srcForm.submit();
			} else {
				return;
			}
		}
	}
	 
	function chakan() {
		var sfdj=0;
	  	var ID="";
	  	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	  		if(document.getElementsByName('xuanze')[i].checked){
	  			ID=document.getElementsByName('xuanze')[i].value;
	  			sfdj++;
	  		}
	 	}
	 	if(sfdj!="1") {
	  		alert('请选择一条数据');
	  		return;
	 	} else {
	 		document.srcForm.action=path+"audit/AuditSys!lookAuditSys.action?ID="+ID;
	 		document.srcForm.submit();
	 	}
	}
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="audit/AuditSys.action">
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
	<td width="3%">行为者名称：</td>
	<td width="20%"><input type="text" name="SYSTEM_ACTOR_NAME" value=""/></td>
	<td width="7%">操作:</td>
	<td width="25%"><input type="text" name="ACT_ACTION"/></td>
	<td width="9%">对象分类:</td>
	<td width="25%"><input type="text" name="ACT_OBJ_TYPE"/></td>
	</tr>
	<tr>
	<td width="3%">行为级别：</td>
	<td width="20%"><select name="ACT_LEVEL">
	   <option value="" selected="selected">请选择</option>
	   <option value="1">1</option>
	   <option value="2">2</option>
	   <option value="3">3</option>
	   <option value="4">4</option>
	   <option value="5">5</option>
	</select>
	</td>
	<td width="7%">结果:</td>
	<td width="25%"><input type="text" name="ACT_RESULT"/></td>
	<td width="9%">备注:</td>
	<td width="25%"><input type="text" name="ACT_MEMO"/></td>
	</tr>
	<tr>
	<td width="3%">时间：</td>
	<td width="20%" colspan="5">从<input size="15" class="Wdate" id="ACT_START_TIME" name="ACT_START_TIME" readonly="readonly" value="" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'ACT_END_TIME\')||\'2020-10-01\'}'})"/>到<input size="15" class="Wdate" id="ACT_END_TIME"  name="ACT_END_TIME"  readonly="readonly" value="" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'ACT_START_TIME\')}',maxDate:'2020-10-01'})"/></td>
	</tr>
	<tr >
	<td align="center" valign="middle">
		<input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;
		<input type="reset" value="重置" class="button_reset"/>
	</td>
	</tr>
</table>
</div>
<div class="list">
<div class="heading">列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="序号" sortType="none" width="15%" sortplan="jsp"/>
	<BZ:th name="行为者IP" sortType="string" width="10%" sortplan="database" sortfield="ACTOR_IP"/>
	<BZ:th name="行为者名称" sortType="string" width="10%" sortplan="database" sortfield="ACTOR_NAME"/>
	<BZ:th name="行为分类" sortType="none" width="10%" sortplan="database" sortfield="ACT_TYPE"/>
	<BZ:th name="操作行为" sortType="string" width="10%" sortplan="database" sortfield="ACT_ACTION"/>
	<BZ:th name="操作对象分类" sortType="string" width="10%" sortplan="database" sortfield="ACT_OBJ_TYPE"/>
	<BZ:th name="操作对象" sortType="string" width="10%" sortplan="database" sortfield="ACT_OBJ"/>
	<BZ:th name="操作结果" sortType="string" width="10%" sortplan="database" sortfield="ACT_RESULT"/>
	<BZ:th name="行为时间" sortType="string" width="10%" sortplan="database" sortfield="ACT_TIME"/>
	<BZ:th name="行为级别" sortType="string" width="5%" sortplan="database" sortfield="ACT_LEVEL"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ACT_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="ACTOR_IP" defaultValue=""/></td>
	<td><BZ:data field="ACTOR_NAME" defaultValue=""/></td>
	<td><BZ:data field="ACT_TYPE" defaultValue=""/></td>
	<td><BZ:data field="ACT_ACTION" defaultValue=""/></td>
	<td><BZ:data field="ACT_OBJ_TYPE" defaultValue=""/></td>
	<td><BZ:data field="ACT_OBJ" defaultValue=""/></td>
	<td><BZ:data field="ACT_RESUL" defaultValue=""/></td>
	<td><BZ:data field="ACT_TIME" defaultValue=""/></td>
	<td><BZ:data field="ACT_LEVEL" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList"/></td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>