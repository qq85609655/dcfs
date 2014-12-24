<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.person.vo.Person"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="hx.database.databean.Data"%>
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

String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>
  <script type="text/javascript">
  
  function _onload(){
  	
  }
  
  function _tijiao(){
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
	  if(confirm("确定选定当前组织为在编组织吗？")){
		  document.getElementById("CHANGE_ORGAN").value = ID;
		  document.srcForm.action=path+"person/doChangeBelong.action";
		  document.srcForm.submit();
		  window.returnValue = true;
		  window.close();
	  }
  }
  }
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="organ/Organ!changeBelong.action">
<div class="kuangjia">
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 人员ID -->
<input id="ORG_ID" name="ORG_ID" type="hidden" value='<%=request.getAttribute(OrganPerson.ORG_ID) %>'/>
<input id="PERSON_ID" name="PERSON_ID" type="hidden" value='<%=request.getAttribute(Person.PERSON_ID) %>'/>
<input id="CHANGE_ORGAN" name="CHANGE_ORGAN" type="hidden"/>
<div class="list">
<div class="heading">所属列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="25%" sortplan="jsp"/>
<BZ:th name="组织名称" sortType="string" width="60%"  sortplan="jsp"/>
<BZ:th name="是否在编" sortType="string" width="15%"  sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="ORGAN_NAMES" defaultValue=""/></td>
<td><BZ:data field="BELONG_STATUS" defaultValue="" checkValue="1=是;0=否"/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="height:35px;">
<input type="button" value="确定" class="button_add" onclick="_tijiao()"/>
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>