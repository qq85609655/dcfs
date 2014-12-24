<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="com.hx.cms.channel.vo.ChannelType"%>
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
<title>�б�</title>
<BZ:script isList="true"/>
  <script type="text/javascript">
  $(document).ready(function(){
	  dyniframesize([ 'mainFrame' ]);
  });
  /* function _onload(){
  var simpleGrid=new SimpleGrid("tableGrid","srcForm");
  } */
  function search(){
  document.srcForm.action=path+"";
  document.srcForm.submit(); 
  }
  
  function add(){
  document.srcForm.action=path+"channel/ChannelType!queryDetail.action?flag=add";
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
  document.srcForm.action=path+"channel/ChannelType!queryDetail.action?flag=modify&<%=ChannelType.ID %>="+ID;
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
  document.srcForm.action=path+"channel/ChannelType!queryDetail.action?flag=detail&<%=ChannelType.ID %>="+ID;
  document.srcForm.submit();
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
   alert('��ѡ��Ҫɾ��������');
   return;
  }else{
  if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
  document.getElementById("ChannelType_IDS").value=uuid;
  document.srcForm.action=path+"channel/ChannelType!deleteBatch.action";
  document.srcForm.submit();
  }else{
  return;
  }
  }
  }
  </script>
</BZ:head>
<BZ:body codeNames="10001">
<BZ:form name="srcForm" method="post" action="channel/ChannelType!query.action">
<div class="kuangjia">
<input id="ChannelType_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<div class="list">
<div class="heading">��Ŀ�����б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="��������" sortType="string" width="65%" sortplan="database" sortfield="NAME"/>
<BZ:th name="�����" sortType="string" width="15%" sortplan="database" sortfield="SEQ_NUM"/>
<BZ:th name="״̬" sortType="string" width="10%" sortplan="database" sortfield="STATUS"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="NAME" onlyValue="true"/></td>
<td><BZ:data field="SEQ_NUM" defaultValue=""/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="1=����;2=����;3=ɾ��"/></td>
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
<td align="right" style="padding-right:30px;height:35px;">
<input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp;
<!-- 
<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
 -->
<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>