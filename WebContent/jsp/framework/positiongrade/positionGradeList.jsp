
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
<title>职级列表</title>
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
	  document.srcForm.action=path+"positiongrade/positionGradeList.action";
	  document.srcForm.submit(); 
  }
  
  function add(){
	  document.srcForm.action=path+"positiongrade/positionGradeToAdd.action";
	  document.srcForm.submit();
  }
  function _update(){
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
  document.srcForm.action=path+"positiongrade/positionGradeDetailed.action?ID="+ID+"&jsp=modify";
  document.srcForm.submit();
  }
  }
  
  function chakan(){
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
  document.srcForm.action=path+"positiongrade/positionGradeDetailed.action?ID="+ID+"&jsp=look";
  document.srcForm.submit();
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
	  document.srcForm.action=path+"positiongrade/positionGradeDelete.action";
	  document.srcForm.submit();
  }else{
  return;
  }
  }
  }
  </script>
</BZ:head>
<BZ:body onload="_onload()" property="data">
<BZ:form name="srcForm" method="post" action="positiongrade/positionGradeList.action">
<input type="hidden" name="deleteid" />
<input type="hidden" name="CNAMES" />
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%">职级名称：</td>
<td width="20%"><BZ:input field="CNAME" type="String" prefix="p_" defaultValue=""/></td>
<td width="10%">职级代码：</td>
<td width="20%"><BZ:input field="PG_CODE" type="String" prefix="p_" defaultValue=""/></td>
<td width="10%"></td>
<td width="20%"></td>
<td width="10%"><input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">职级列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="职级名称" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="职级级别代码" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="级别" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="说明" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="排序号" sortType="string" width="10%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" defaultValue=""/></td>
<td><BZ:data field="PG_CODE" defaultValue=""/></td>
<td><BZ:data field="GRADE" defaultValue=""/></td>
<td><BZ:data field="MEMO" defaultValue=""/></td>
<td><BZ:data field="SEQ_NUM" defaultValue=""/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>