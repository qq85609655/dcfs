
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
<title>�б�</title>
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
   alert('��ѡ��һ������');
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
   alert('��ѡ��һ������');
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
   alert('��ѡ��Ҫɾ��������');
   return;
  }else{
  if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
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
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="kuangjia">
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%">�������ƣ�</td>
<td width="20%"><input type="text" name="p_ELE_NAME_ZH" value="<%=data.getString("ELE_NAME_ZH","") %>"/></td>
<td width="10%">Ӣ�����ƣ�</td>
<td width="20%"><input type="text" name="p_ELE_NAME_EN" value="<%=data.getString("ELE_NAME_EN","") %>"/></td>
<td><input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">����Ԫ�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="��ʾ��" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="��������" sortType="string" width="15%" sortplan="jsp" />
<BZ:th name="Ӣ������" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="����ģʽ" sortType="string" width="20%" sortplan="jsp"/>
<BZ:th name="��������" sortType="int" width="10%" sortplan="jsp"/>
<BZ:th name="��ʾ��ʽ" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="��ʾ��ʽ" sortType="string" width="10%" sortplan="jsp"/>
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
<input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp;
<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<%if(!"1".equals(noback)){ %>
	<input type="button" value="����" class="button_back" onclick="_back()"/>
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