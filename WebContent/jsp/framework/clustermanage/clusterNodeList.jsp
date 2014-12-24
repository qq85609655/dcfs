
<%@page import="com.hx.framework.clustermanage.vo.ClusterNode"%>
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
<title>�б�</title>
<BZ:script isList="true"/>
  <script type="text/javascript">
  
  
  function _onload(){
  
  }
  function search(){
  document.srcForm.action=path+"";
  document.srcForm.submit(); 
  }
  
  function add(){
  document.srcForm.action=path+"clustermanage/findCluster!addCluster.action";
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
		  document.srcForm.action=path+"clustermanage/findCluster!queryModify.action?<%=ClusterNode.NODEID %>="+ID;
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
  document.srcForm.action=path+"clustermanage/findCluster!queryDetail.action?<%=ClusterNode.NODEID %>="+ID;
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
		  document.getElementById("NODE_IDS").value=uuid;
		  document.srcForm.action=path+"clustermanage/findCluster!deleteBatch.action";
		  document.srcForm.submit();
	  }else{
	  return;
	  }
  }
  }
  </script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="clustermanage/findCluster.action">
<BZ:frameDiv property="clueTo" className="kuangjia">
<input id="NODE_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<div class="list">
<div class="heading">��Ⱥ��Ϣ�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="5%" sortplan="jsp"/>
<BZ:th name="Ԫ�ر�ʶ" width="10%" sortType="string" sortplan="database" sortfield="NODEID"/>
<BZ:th name="Э��" sortType="string" width="10%" sortplan="database" sortfield="PROTOCOL"/>
<BZ:th name="Ԫ��IP��ַ" sortType="string" width="15%" sortplan="database" sortfield="IPADDRESS"/>
<BZ:th name="�˿ں�" sortType="string" width="10%" sortplan="database" sortfield="PORT"/>
<BZ:th name="�����ĸ�" sortType="string" width="20%" sortplan="database" sortfield="CONTEXTPATH"/>
<BZ:th name="��ȺID" sortType="int" width="10%" sortplan="database" sortfield="CLUSTERID"/>
<BZ:th name="������Ա" width="10%" sortType="string" sortplan="database" sortfield="PERSON_ID"/>
<BZ:th name="����ʱ��" width="10%" sortType="date" sortplan="database" sortfield="ADDTIME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="NODEID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="NODEID" onlyValue="true"/></td>
<td><BZ:data field="PROTOCOL" defaultValue=""/></td>
<td><BZ:data field="IPADDRESS" onlyValue="true"/></td>
<td><BZ:data field="PORT" defaultValue="" onlyValue="true"/></td>
<td><BZ:data field="CONTEXTPATH" defaultValue="" /></td>
<td><BZ:data field="CLUSTERID" defaultValue="" /></td>
<td><BZ:data field="PERSON_ID" defaultValue="" person="true"/></td>
<td><BZ:data field="ADDTIME" defaultValue="" type="Date"/></td>

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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>