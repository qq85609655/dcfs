<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	String path = request.getContextPath();
	DataList infolist = (DataList) request.getAttribute("infolist");
	String reValue = (String) request.getAttribute("reValue");
	
	String compositor=(String)request.getAttribute("compositor");
	if(compositor==null){
		compositor="";
	}
	String ordertype=(String)request.getAttribute("ordertype");
	if(ordertype==null){
		ordertype="";
	}
%>
<BZ:html>
<BZ:head>
<title>操作日志</title>
<BZ:script isList="true" />
<script src="<BZ:resourcePath/>/js/date/WdatePicker.js"></script>
  <script type="text/javascript">
  
	function _onload() {
		
	}
	
	function search_(){
	 document.srcForm.action=path+"doneinfo/list2.action";
	 document.srcForm.submit(); 
	}
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="doneinfo/list2.action">
<input type="hidden" name="deleteuuid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>

<div class="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
	<table class="chaxuntj">
		<tr>
			<td>统计时间：</td>
			<td  colspan="3">
			    从<BZ:input field="BEGIN_TIME" prefix="Search_" style="width:150px" type="Date" defaultValue="" property="data" id="Search_BEGIN_TIME" dateExtend="maxDate:'#F{$dp.$D(\\'Search_END_TIME\\')}',readOnly:true"/>
			    &nbsp;&nbsp;到<BZ:input field="END_TIME" style="width:150px" prefix="Search_" type="Date" defaultValue="" property="data" id="Search_END_TIME" dateExtend="minDate:'#F{$dp.$D(\\'Search_BEGIN_TIME\\')}',readOnly:true"/>
			</td>
			<td>发送人：</td>
			<td><BZ:input field="SENDER_NAME" prefix="Search_" defaultValue="" property="data"/></td>
			<td colspan="4" style="align:right">
			    <input type="button" value="查询" class="button_search" onclick="search_();"/>
			</td>
		</tr>
	</table>
</div>
<div class="list">
<div class="heading">列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
	<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
	<BZ:th name="发送者" sortType="string" width="22%" sortplan="jsp"/>
	<BZ:th name="发送时间" sortType="string" width="20%" sortplan="jsp"/>
	<BZ:th name="发送次数" sortType="string" width="12%" sortplan="jsp"/>
	<BZ:th name="待发送条数" sortType="string" width="12%" sortplan="jsp"/>
	<BZ:th name="失败条数" sortType="string" width="12%" sortplan="jsp"/>
	<BZ:th name="成功条数" sortType="string" width="12%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td noselect="true"><BZ:i></BZ:i></td>
<td><BZ:data field="P_CNAME" defaultValue=""/>[<BZ:data field="D_CNAME" defaultValue="" onlyValue="true"/>]</td>
<td><BZ:data field="SEND_TIME" defaultValue=""/></td>
<td><BZ:data field="SEND_NUMS" defaultValue=""/></td>
<td><BZ:data field="WAIT_NUMS" defaultValue=""/></td>
<td><BZ:data field="FAL_NUMS" defaultValue=""/></td>
<td><BZ:data field="SUC_NUMS" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>