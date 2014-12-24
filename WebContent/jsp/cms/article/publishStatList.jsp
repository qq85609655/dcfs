<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.DataList"%>
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

String statType = (String)request.getAttribute("STAT_TYPE");
DataList dataList = (DataList)request.getAttribute("dataList");
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true" isDate="true"/>  
<script type="text/javascript">

function _onload(){
  var simpleGrid=new SimpleGrid("tableGrid","srcForm");
  }

function search_(){
 document.srcForm.action=path+"article/PublishStat.action";
 document.srcForm.submit(); 
}
</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="article/PublishStat.action">
<div class="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
			<table class="chaxuntj">
					<tr>
						<td>统计时间：</td>
						<td  colspan="3">
						    从<BZ:input field="BEGIN_TIME" prefix="Search_" style="width:150px" type="Date" defaultValue="" property="data"/>
						    &nbsp;&nbsp;到<BZ:input field="END_TIME" style="width:150px" prefix="Search_" type="Date" defaultValue="" property="data"/>
						    <select name="STAT_TYPE">
						    	<option <%="1".equals(statType)?"selected='selected'":"" %> value="1">按人统计</option>
						    	<option <%="2".equals(statType)?"selected='selected'":"" %> value="2">按栏目统计</option>
						    </select>
						</td>
						<td colspan="4" style="align:right">
						    <input type="button" value="查询" class="button_search" onclick="search_()"/>
						</td>
					</tr>
				</table>
</div>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<div class="list">
<div class="heading">频道列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="栏目" sortType="none" width="35%" sortplan="jsp"/>
<%
	if("1".equals(statType)){
%>
<BZ:th name="发布人" sortType="string" width="35%" sortplan="jsp"/>
<%
	}
%>
<BZ:th name="发布个数" sortType="string" width="20%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>" noselect="true"><BZ:i></BZ:i></td>
<td><BZ:data field="NAME" defaultValue=""/></td>
<%
	if("1".equals(statType)){
%>
<td><BZ:data field="CREATOR" defaultValue=""/></td>
<%
	}
%>
<td><BZ:data field="COUNT_NUM" defaultValue=""/></td>
</tr>
</BZ:for>
<%
	if(dataList != null && dataList.size() > 0){
%>
<tr>
<td <%="1".equals(statType)?"colspan='3'":"colspan='2'" %>  align="center" noselect="true">合&nbsp;&nbsp;&nbsp;&nbsp;计</td>
<td><%=request.getAttribute("totalCount")!=null?request.getAttribute("totalCount"):"0" %></td>
</tr>
<%
	}
%>
</BZ:tbody>
</BZ:table>
</div>


		</div>
	</BZ:form>
</BZ:body>
</BZ:html>