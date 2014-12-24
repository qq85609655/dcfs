
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*,java.util.*" %>
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
	String startDate=(String)request.getAttribute("startDate");
	if(startDate==null){
	    startDate="";
	}
	String endDate=(String)request.getAttribute("endDate");
	if(endDate==null){
	    endDate="";
	}
	String type=(String)request.getAttribute("type");
	if(type==null){
	    type="";
	}
	
%>
<BZ:html>
<BZ:head>
<title>审计日志归档</title>
<BZ:script isList="true" isDate="true"/>
  <script type="text/javascript">
  
	function _onload() {
		var st1 = document.getElementById("Type");
		var v = document.getElementById("tbl_name").value;
		for(var i=0;i<st1.length;i++){
			if(st1.options[i].value==v){
				st1.options[i].selected=true;
			}
		}
  	}
  	
  	function search() {
	  	document.srcForm.action=path+"clearLog/queryList.action";
	  	document.srcForm.submit(); 
  	}

  	function _hand()
  	{
  		document.srcForm.action=path+"clearLog/toHandLogClear.action";
	  	document.srcForm.submit(); 
  	}

  	function _auto()
  	{
  		document.srcForm.action=path+"clearLog/toAutoClearSetUp.action";
	  	document.srcForm.submit(); 
  	}
  </script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="LOGRANGE" >
<BZ:form name="srcForm" method="post" action="clearLog/queryList.action">
<input type="hidden" name="deleteuuid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<input type="hidden" id="tbl_name" name="tbl_name" value="<%=type%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
<table class="chaxuntj">
	<tr>
	<td width="5%">时间：</td>
	<td width="30%" colspan="4">从<input size="15" class="Wdate" id="START_TIME" name="START_TIME" readonly="readonly" value="<%=startDate %>" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'END_TIME\')||\'2020-10-01\'}'})"/>到<input size="15" class="Wdate" id="END_TIME"  name="END_TIME"  readonly="readonly" value="<%=endDate %>" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'START_TIME\')}',maxDate:'2020-10-01'})"/></td>
	<td width="10%">归档方式</td>
	<td width="10%">
	    <select name="Type" id="Type">
			<option value="1">手动归档</option>
			<option value="2">自动归档</option>
	    </select>
	</td>
	<td width="30%" align="right" valign="middle">
		<input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;
		<input type="reset" value="重置" class="button_reset"/>
	</td>
	<td width="15%"></td>
	</tr>
</table>
</div>
<div class="list">
<div class="heading">审计日志归档列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="序号" sortType="none" width="8%" sortplan="jsp"/>
	<BZ:th name="审计日志类型" sortType="string" width="10%" sortplan="database" sortfield="DATA_TYPE"/>
	<BZ:th name="归档时间" sortType="string" width="15%" sortplan="database" sortfield="OPERATION_TIME"/>
	<BZ:th name="归档数据范围" sortType="string" width="10%" sortplan="database" sortfield="DATA_PERIOD"/>
	<BZ:th name="归档数据条数" sortType="string" width="10%" sortplan="database" sortfield="DATA_ROW_COUNT"/>
	<BZ:th name="归档方式" sortType="string" width="10%" sortplan="database" sortfield="OPERATION_TYPE"/>
	<BZ:th name="操作人" sortType="string" width="10%" sortplan="database" sortfield="B_CNAME"/>
	<BZ:th name="结果" sortType="string" width="10%" sortplan="database" sortfield="OPERATION_RESULT"/>
	<BZ:th name="备注" sortType="string" width="17%" sortplan="database" sortfield="MEMO"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
	<td><BZ:data field="DATA_TYPE" defaultValue="" checkValue="1=系统管理行为审计日志;2=系统访问控制审计日志;3= 用户登录行为审计日志;4=应用操作行为审计日志"/></td>
	<td><BZ:data field="OPERATION_TIME" defaultValue=""/></td>
	<td><BZ:data field="DATA_PERIOD" defaultValue=""  codeName="LOGRANGE" /></td>
	<td><BZ:data field="DATA_ROW_COUNT" defaultValue=""   /></td>
	<td><BZ:data field="OPERATION_TYPE" defaultValue="" checkValue="1=手动归档;2=自动归档"/></td>
	<td><BZ:data field="B_CNAME" defaultValue=""/></td>
	<td><BZ:data field="OPERATION_RESULT" defaultValue="" checkValue="1=成功;2=失败"/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="手动归档" class="button_update" onclick="_hand()" style="width: 100px"/>&nbsp;&nbsp;<input type="button" value="自动归档设置" class="button_update" onclick="_auto()" style="width: 120px"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>