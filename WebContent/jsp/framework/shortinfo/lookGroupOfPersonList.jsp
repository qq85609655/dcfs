<%@page language="java" contentType="text/html; charset=GBK" %>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
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

String personId = (String)request.getAttribute("PERSON_ID");
%>
<BZ:html>
<BZ:head>
<title>�Զ���Ⱥ������</title>
<base target="_self" />
<BZ:script isList="true" isDate="true"/>
<script type="text/javascript">
  function _onload(){
  	
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
   alert('��ѡ��Ҫ�Ƴ�������');
   return;
   }else{
   if(confirm('ȷ��Ҫ�Ƴ�ѡ����Ϣ��?')){
   document.getElementById("GROUP_IDS").value=uuid;
   document.srcForm.action=path+"usergroup/deleteGroupsOfPerson.action";
   document.srcForm.submit();
   }else{
   return;
   }
   }
  }
</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- ��ԱID -->
<input type="hidden" id="PERSON_ID" name="PERSON_ID" value="<%=personId%>"/>
<input type="hidden" id="GROUP_IDS" name="GROUP_IDS">

<div class="list">
<div class="heading">�Զ���Ⱥ��</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" width="7%" sortType="none" sortplan="jsp"/>
<BZ:th name="Ⱥ������" width="28%" sortType="string" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="GROUPNAME" onlyValue="true"/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<input type="button" value="�Ƴ�" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="�ر�" class="button_delete" onclick="window.close();"/>
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>