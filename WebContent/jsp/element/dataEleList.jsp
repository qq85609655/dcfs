
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String eleSortId=(String)request.getAttribute("eleSortId");
String parentSortId=(String)request.getAttribute("parentSortId");
Data data=(Data)request.getAttribute("datatj");
if(data==null){
	data=new Data();
}
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

String noback=request.getParameter("noback");
if(noback==null){
	noback="";
}
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>
  <script type="text/javascript">
  function _onload(){
  
  }
  function search(){
	  document.srcForm.action=path+"EleSortServlet?method=codelist&ELE_SORT_ID=<%=eleSortId%>";
	  document.srcForm.submit(); 
  }
  
  function add(){
	  document.srcForm.action=path+"EleSortServlet?method=addDataEle";
	  document.srcForm.submit();
  }
  function _update(){
   var sfdj=0;
   var CODEID="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   CODEID=document.getElementsByName('xuanze')[i].value;
   sfdj++;
   }
  }
  if(sfdj!="1"){
   alert('请选择一条数据');
   return;
  }else{
  document.srcForm.action=path+"EleSortServlet?method=editDataEle&UUID="+CODEID;
  document.srcForm.submit();
  }
  }
  
  function chakan(){
   var sfdj=0;
   var CODEID="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   CODEID=document.getElementsByName('xuanze')[i].value;
   sfdj++;
   }
  }
  if(sfdj!="1"){
   alert('请选择一条数据');
   return;
  }else{
 document.srcForm.action=path+"EleSortServlet?method=editDataEle&action=view&UUID="+CODEID;
  document.srcForm.submit();
  }
  }
  function _back(){
	  document.getElementById("compositor").value="";
	  document.getElementById("ordertype").value="";
	  document.srcForm.action=path+"EleSortServlet?method=eleSortList&p_PARENT_ID=<%=parentSortId%>";
	  document.srcForm.submit();
  }
  function _delete(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('请选择要删除的数据');
   return;
  }else{
  if(confirm('确认要删除选中信息吗?')){
  document.getElementById("deleteuuid").value=uuid;
  document.srcForm.action=path+"EleSortServlet?method=deleteDataEle";
  document.srcForm.submit();
  }else{
  return;
  }
  }
  }
  </script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="XZQGH">
<BZ:form name="srcForm" method="post" action="">
<input type="hidden" name="deleteuuid"  />
<input type="hidden" name="eleSortId"  value="<%=eleSortId %>"/>
<input type="hidden" name="parentSortId"  value="<%=parentSortId %>"/>
<input type="hidden" name="noback"  value="<%=noback %>"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="kuangjia">
<div class="heading">查询条件</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%">中文名称：</td>
<td width="20%"><input type="text" name="p_ELE_NAME_ZH" value="<%=data.getString("ELE_NAME_ZH","") %>"/></td>
<td width="10%">英文名称：</td>
<td width="20%"><input type="text" name="p_ELE_NAME_EN" value="<%=data.getString("ELE_NAME_EN","") %>"/></td>
<td><input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">数据元列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="标示符" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="中文名称" sortType="string" width="15%" sortplan="jsp" />
<BZ:th name="英文名称" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="分类模式" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="数据类型" sortType="int" width="10%" sortplan="jsp"/>
<BZ:th name="表示形式" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="表示格式" sortType="string" width="10%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="LIST" >
<tr>
<td tdvalue="<BZ:data field="UUID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:a field="DATA_ELE_ID">EleSortServlet?method=editDataEle&eleSortId=<%=eleSortId%>&UUID=<BZ:data field="UUID" onlyValue="true"/></BZ:a></td>
<td><BZ:data field="ELE_NAME_ZH" defaultValue=""/></td>
<td><BZ:data field="ELE_NAME_EN" defaultValue=""/></td>
<td><BZ:data field="SORT_MODE" defaultValue=""/></td>
<td><BZ:data field="DATA_TYPE" defaultValue=""/></td>
<td><BZ:data field="SHOW_FORM" defaultValue=""/></td>
<td><BZ:data field="SHOW_FORMAT" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="LIST"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px">
<input type="button" value="添加" class="button_add" onclick="add()"/>&nbsp;&nbsp;
<input type="button" value="查看" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
<input type="button" value="修改" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="删除" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<%if(!"1".equals(noback)){ %>
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
<%} %>
</td>
</tr>
</table>
</div>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>