
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String MODULE_ID=(String)request.getAttribute("MODULE_ID");
if(MODULE_ID==null){
	MODULE_ID="";
}
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
<title>��Դ�б�</title>
<BZ:script isList="true" />
  <script type="text/javascript">
  $(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
  //������Դ��Ӳ˵�
  function addMenue(){
	  var sfdj=0;
	   var uuid="";
	   for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	   if(document.getElementsByName('xuanze')[i].checked){
	   uuid=uuid+"#"+document.getElementsByName('xuanze')[i].value;
	   sfdj++;
	   }
	  }
	  if(sfdj=="0"){
	   alert('��ѡ��Ҫ��Ӳ˵�������');
	   return;
	  }else{
	  if(confirm('ȷ��Ҫ����ѡ��Ӧ�ö�Ӧ�˵���?')){
	  document.getElementById("deleteid").value=uuid;
	  document.srcForm.action=path+"resource/addMenue.action";
	  document.srcForm.submit();
	  }else{
	  return;
	  }
	  }
  }
  
  function _onload(){
  
  }
  function search(){
  document.srcForm.action=path+"CodeSortServlet";
  document.srcForm.submit(); 
  }
  
  function add(){
  document.srcForm.action=path+"resource/resourcesToAdd.action";
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
   alert('��ѡ��һ������');
   return;
  }else{
  document.srcForm.action=path+"resource/resourcesDetailed.action?ID="+ID+"&jsp=modify";
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
   alert('��ѡ��һ������');
   return;
  }else{
  document.srcForm.action=path+"resource/resourcesDetailed.action?ID="+ID+"&jsp=look";
  document.srcForm.submit();
  }
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
   alert('��ѡ��Ҫɾ��������');
   return;
  }else{
  if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
  document.getElementById("deleteid").value=uuid;
  document.srcForm.action=path+"resource/resourcesDelete.action";
  document.srcForm.submit();
  }else{
  return;
  }
  }
  }
  
  function _bakModule(){
  document.location.href=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>&PMOUDLE=0";
  //document.srcForm.action=path+"module/resourceModuleList.action?APP_ID=<%=APP_ID%>";
  //document.srcForm.submit();
  }
  
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="resource/resourcesList.action">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="P_MODULE_ID" value="<%=MODULE_ID%>"/>
<input type="hidden" name="APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="MODULE_ID" value="<%=MODULE_ID%>"/>
<input type="hidden" name="deleteid" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">��Դ�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="��Դ����" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="��ԴURL" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="��ԴȨ�޿���URL" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="�Ƿ�Ȩ�޿���" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="�Ƿ�˵����" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="״̬" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="����ʱ��" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="20%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" defaultValue=""/></td>
<td><BZ:data field="RES_URL" defaultValue=""/></td>
<td><BZ:data field="CTR_URL" defaultValue=""/></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("IS_VERIFY_AUTH",""))){%>��<%}else{ %>��<%} %></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("IS_NAVIGATE",""))){%>��<%}else{ %>��<%} %></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("STATUS",""))){%>����<%}else{ %>ͣ��<%} %></td>
<td><BZ:data field="CREATE_TIME" defaultValue=""/></td>
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
<td align="right" style="padding-right:30px;height:35px;">&nbsp;&nbsp;<input type="button" value="���ɲ˵�" class="button_add" onclick="addMenue()"/>&nbsp;&nbsp;<input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;<%if(!"".equals(MODULE_ID)){ %><input type="button" value="����" class="button_back" onclick="_bakModule()"/><%} %>
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>