
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
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
%>
<BZ:html>
<BZ:head>
<title>应用列表</title>
<BZ:script isList="true" />
  <script type="text/javascript">
  
  function _onload(){
  
  }
  function _select(){
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
  window.parent.returnValue=ID;
  window.parent.close();
  }
  }
  
  function _back(){
  window.parent.returnValue="";
  window.parent.close();
  }
  
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="navigation/navigationShowApp.action">
<input type="hidden" name="deleteid" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">应用系统列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="应用系统名称" sortType="string" width="35%" sortplan="jsp"/>
<BZ:th name="开发商" sortType="string" width="25%" sortplan="jsp"/>
<BZ:th name="版本" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="创建时间" sortType="string" width="20%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>#<BZ:data field="APP_NAME" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="APP_NAME" defaultValue=""/></td>
<td><BZ:data field="DEVELOPER" defaultValue=""/></td>
<td><BZ:data field="VERSION" defaultValue=""/></td>
<td><BZ:data field="CREATE_TIME" defaultValue=""/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="确定" class="button_add" onclick="_select()"/>&nbsp;&nbsp;<input type="button" value="取消" class="button_back" onclick="_back()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>