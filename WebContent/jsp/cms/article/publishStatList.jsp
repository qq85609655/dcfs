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
<title>�б�</title>
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
<div class="heading">��ѯ����</div>
<div  class="chaxun">
			<table class="chaxuntj">
					<tr>
						<td>ͳ��ʱ�䣺</td>
						<td  colspan="3">
						    ��<BZ:input field="BEGIN_TIME" prefix="Search_" style="width:150px" type="Date" defaultValue="" property="data"/>
						    &nbsp;&nbsp;��<BZ:input field="END_TIME" style="width:150px" prefix="Search_" type="Date" defaultValue="" property="data"/>
						    <select name="STAT_TYPE">
						    	<option <%="1".equals(statType)?"selected='selected'":"" %> value="1">����ͳ��</option>
						    	<option <%="2".equals(statType)?"selected='selected'":"" %> value="2">����Ŀͳ��</option>
						    </select>
						</td>
						<td colspan="4" style="align:right">
						    <input type="button" value="��ѯ" class="button_search" onclick="search_()"/>
						</td>
					</tr>
				</table>
</div>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<div class="list">
<div class="heading">Ƶ���б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="��Ŀ" sortType="none" width="35%" sortplan="jsp"/>
<%
	if("1".equals(statType)){
%>
<BZ:th name="������" sortType="string" width="35%" sortplan="jsp"/>
<%
	}
%>
<BZ:th name="��������" sortType="string" width="20%" sortplan="jsp"/>
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
<td <%="1".equals(statType)?"colspan='3'":"colspan='2'" %>  align="center" noselect="true">��&nbsp;&nbsp;&nbsp;&nbsp;��</td>
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