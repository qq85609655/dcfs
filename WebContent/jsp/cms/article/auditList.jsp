<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.Channel"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String path = request.getContextPath();
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}

UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
String secid=user.getPerson().getSecretLevel();
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>
<%=request.getAttribute("refreshTree")!=null?request.getAttribute("refreshTree"):"" %>
  <script type="text/javascript">
  
  $(document).ready(function(){
	  dyniframesize([ 'mainFrame','mainFrame' ]);
});
  function search(){
  document.srcForm.action=path+"";
  document.srcForm.submit(); 
  }
  
  
  function _chakan(){
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
  document.srcForm.action=path+"article/Article!detailArt.action?<%=Article.ID %>="+ID;
  document.srcForm.target = "chakan";
  document.srcForm.submit();
  document.srcForm.target = "_self";
  document.srcForm.action=path+"article/Article!auditQuery.action";
  }
  }
  function _delete(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('请选择要删除的数据');
   return;
  }else{
  if(confirm('确认要删除选中信息吗?')){
  document.getElementById("Article_IDS").value=uuid;
  document.srcForm.action=path+"article/Article!deleteBatch.action";
  document.srcForm.submit();
  document.srcForm.action=path+"article/Article!auditQuery.action";
  }else{
  return;
  }
  }
  }
  
  //通过审核
  function shenhetongguo(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('请选择要审核的数据');
   return;
  }else{
  if(confirm('确认要通过审核吗?')){
  document.getElementById("Article_IDS").value=uuid;
  document.srcForm.action=path+"article/Article!passAudit.action";
  document.srcForm.submit();
  document.srcForm.action=path+"article/Article!auditQuery.action";
  }else{
  return;
  }
  }
  }
  
  //驳回审核
  function bohuishenhe(){
  var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('请选择要驳回的数据');
   return;
  }else{
  if(confirm('确认要驳回吗?')){
  document.getElementById("Article_IDS").value=uuid;
  document.srcForm.action=path+"article/Article!backAudit.action";
  document.srcForm.submit();
  document.srcForm.action=path+"article/Article!auditQuery.action";
  }else{
  return;
  }
  }
  }
  
  //提交进入审核页面
  function _audit(){
   var sfdj=0;
   var uuid="";
   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
   if(document.getElementsByName('xuanze')[i].checked){
   uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
   sfdj++;
   }
  }
  if(sfdj=="0"){
   alert('请选择要审核的数据');
   return;
  }else{
  document.getElementById("Article_IDS").value=uuid;
  document.srcForm.action=path+"article/Article!auditArt.action";
  //document.srcForm.target = "_blank";
  document.srcForm.submit();
  //document.srcForm.target = "_self";
  document.srcForm.action=path+"article/Article!auditQuery.action";
  }
  }
  
  function _auditByTitle(id){
	  document.getElementById("Article_IDS").value=id;
	  document.srcForm.action=path+"article/Article!auditArt.action";
	  //document.srcForm.target = "_blank";
	  document.srcForm.submit();
	  //document.srcForm.target = "_self";
	  document.srcForm.action=path+"article/Article!auditQuery.action";
  }
  
  //查询条件
  function _searchSub(){
	  document.srcForm.action=path+"article/Article!auditQuery.action";
	  document.srcForm.page.value = 1;
	  document.srcForm.submit();
  }
  </script>
</BZ:head>
<BZ:body codeNames="SYS_ORGAN_PERSON">
<BZ:form name="srcForm" method="post" action="article/Article!auditQuery.action">
<div class="kuangjia">

<!-- 查询条件开始 -->
<div class="heading">查询条件</div>
<div  class="chaxun">
	<table class="chaxuntj">
		<tr>
			<td>标题：</td>
			<td><BZ:input field="TITLE" prefix="Search_" defaultValue="" property="data"/></td>
			<td colspan="6" style="align:right">
			    <input type="button" value="查询" class="button_search" onclick="_searchSub();"/>
			</td>
		</tr>
	</table>
</div>
<!-- 查询条件结束 -->

<input id="Article_IDS" name="IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 父栏目ID -->
<input id="CHANNEL_ID" name="CHANNEL_ID" type="hidden" value="<%=request.getAttribute(Article.CHANNEL_ID) %>"/>
<div class="list">
<div class="heading">文章列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="" sortType="none" width="11%" sortplan="jsp"/>
<BZ:th name="标题" sortType="string" width="26%" sortplan="database" sortfield="TITLE"/>
<BZ:th name="发布时间" sortType="date" width="20%" sortplan="database" sortfield="CREATE_TIME"/>
<BZ:th name="创建者" sortType="string" width="15%" sortplan="database" sortfield="CREATOR"/>
<BZ:th name="状态" sortType="string" width="13%" sortplan="database" sortfield="STATUS"/>
<%-- <BZ:th name="排序号" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM"/> --%>
<BZ:th name="栏目" sortType="string" width="15%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="article">

<tr>
<%
Data data = (Data)pageContext.getAttribute("article");
//密级过滤
String mj = data.getString(Article.SECURITY_LEVEL);
if (mj==null || "".equals(mj)){
	mj="0";
}
if (secid==null || "".equals(secid)){
	secid="0";
}
if (Integer.parseInt(secid,10)>=Integer.parseInt(mj,10)){
%>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>,PERSIST"><BZ:i></BZ:i></td>
<%
}else{
%>
<td noselect="true"><BZ:i></BZ:i></td>
<%
}
%>
<td><A href="javascript:void(0);" onclick="_auditByTitle('<BZ:data field="ID" onlyValue="true"/>');"><BZ:data field="TITLE" defaultValue=""/></A></td>
<td><BZ:data field="CREATE_TIME" type="Date" defaultValue=""/></td>
<td><BZ:data field="CREATOR" defaultValue="" codeName="SYS_ORGAN_PERSON"/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="1=暂存;2=等待审核;3=已发布;4=退回;5=撤销"/></td>
<%-- <td>
	<%
		if(!"2147483647".equals(data.getString("SEQ_NUM"))){
	%>
	<BZ:data field="SEQ_NUM" defaultValue=""/>
	<%
		}
	%>
</td> --%>
<td><BZ:data field="CHANNEL_NAME" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="2"><BZ:page form="srcForm" property="dataList" type="special"/></td>
</tr>
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<!-- <input type="button" value="审核并发布" style="width: 90px" class="button_add" onclick="shenhetongguo()"/>&nbsp;&nbsp;
<input type="button" style="width: 90px" value="审核不通过" class="button_select" onclick="bohuishenhe()"/>&nbsp;&nbsp; -->
<input type="button" value="审核" class="button_add" onclick="_audit()"/>&nbsp;&nbsp;
<input type="button" value="预览" class="button_update" onclick="_chakan()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>