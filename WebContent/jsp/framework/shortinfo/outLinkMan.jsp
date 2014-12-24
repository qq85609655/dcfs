<%@ page language="java" contentType="text/html; charset=GBK" %>
<%@page import="hx.database.databean.DataList"%>
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
DataList data = (DataList)request.getAttribute("linkmans");
%>
<BZ:html>
<BZ:head>
<title></title>
<BZ:script isList="true" isDate="true"/>
<script type="text/javascript">
  function _onload(){
  	
  }
  
  function _add(){
  	document.srcForm.action=path+"linkman/toadd.action";
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
		  document.srcForm.action=path+"linkman/toModify.action?ID="+ID;
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
   document.getElementById("LinkMan_IDS").value=uuid;
   document.srcForm.action=path+"linkman/delete.action";
   document.srcForm.submit();
   }else{
   return;
   }
   }
  }
  function _search()
  {
     document.srcForm.action=path+"linkman/search.action";
  	 document.srcForm.submit();
  }
</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="7%"></td>
<td width="10%">������</td>
<td width="40%"><input type="text" name="SEARCH_CNAME" value=" "/></td>
<td width="10%">�ֻ��ţ�</td>
<td width="20%"><input type="text" name="SEARCH_MOBILE" value=" "/></td>
<td width="6%"></td>
<td width="7%"></td>
</tr>
<tr>
<td></td>
<td>������ڣ�</td>
<td><input type="text" name="SEARCH_STARTDATE" value=" "/>-<input type="text" name="SEARCH_ENDDATE" value=" "/></td>
<td>���ͣ�</td>
<td>
<select name="SEARCH_TYPE">
	<option value="1">ί����Ա</option>
	<option value="2">ί����Ա</option>
</select>
</td>
<td align="right">
<input type="button" value="��ѯ" class="button_search" onclick="_search()"/>
</td>
<td width="5%"></td>
</tr>
</table>
</div>
<input id="LinkMan_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<div class="list">
<div class="heading">��ϵ���б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" width="7%" sortType="none" sortplan="jsp"/>
<BZ:th name="����" width="10%" sortType="string" sortplan="jsp"/>
<BZ:th name="�ֻ���" width="13%" sortType="string" sortplan="jsp"/>
<BZ:th name="��ע" width="30%" sortType="string" sortplan="database" sortfield="TITLE"/>
<BZ:th name="����" width="10%" sortType="string" sortplan="jsp"/>
<BZ:th name="������" width="10%" sortType="string" sortplan="jsp"/>
<BZ:th name="��������" width="10%" sortType="date" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="linkmans">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="MOBILE" onlyValue="true"/></td>
<td><BZ:data field="MEMO" onlyValue="true"/></td>
<td><BZ:data field="TYPE" onlyValue="true" defaultValue=""/></td>
<td><BZ:data field="CREATOR" onlyValue="true"/></td>
<td><BZ:data field="CREATE_TIME" type="string" onlyValue="true"/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="���" class="button_add" onclick="_add()"/>&nbsp;&nbsp; <input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>
