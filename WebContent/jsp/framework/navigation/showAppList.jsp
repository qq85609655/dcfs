
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
<title>Ӧ���б�</title>
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
   alert('��ѡ��һ������');
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
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">Ӧ��ϵͳ�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="Ӧ��ϵͳ����" sortType="string" width="35%" sortplan="jsp"/>
<BZ:th name="������" sortType="string" width="25%" sortplan="jsp"/>
<BZ:th name="�汾" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="����ʱ��" sortType="string" width="20%" sortplan="jsp"/>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="ȷ��" class="button_add" onclick="_select()"/>&nbsp;&nbsp;<input type="button" value="ȡ��" class="button_back" onclick="_back()"/>&nbsp;&nbsp;
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>