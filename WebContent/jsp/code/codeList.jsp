
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String CODESORTID=(String)request.getAttribute("CODESORTID");
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
  document.srcForm.action=path+"CodeSortServlet?method=codelist";
  document.srcForm.submit(); 
  }
  
  function add(){
  document.srcForm.action=path+"CodeSortServlet?method=add&type=code";
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
  document.srcForm.action=path+"CodeSortServlet?method=editcode&CODEID="+CODEID;
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
  document.srcForm.action=path+"CodeSortServlet?method=lookcode&CODEID="+CODEID;
  document.srcForm.submit();
  }
  }
  function _back(){
  document.getElementById("compositor").value="";
  document.getElementById("ordertype").value="";
  document.srcForm.action=path+"CodeSortServlet";
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
  document.srcForm.action=path+"CodeSortServlet?method=deletecode";
  document.srcForm.submit();
  }else{
  return;
  }
  }
  }
  </script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="XZQGH">
<BZ:form name="srcForm" method="post" action="CodeSortServlet?method=codelist">
<input type="hidden" name="deleteuuid" id="deleteuuid" />
<input type="hidden" name="CODESORTID" id="CODESORTID"  value="<%=CODESORTID %>"/>
<input type="hidden" name="noback"  id="noback" value="<%=noback %>"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" id="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" id="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%">�������ƣ�</td>
<td width="20%"><input type="text" name="p_CODENAME" value="<%=data.getString("CODENAME","") %>"/></td>
<td width="10%">����ֵ��</td>
<td width="20%"><input type="text" name="p_CODEVALUE" value="<%=data.getString("CODEVALUE","") %>"/></td>
<td width="10%">��ĸ��</td>
<td width="20%"><input type="text" name="p_CODELETTER" value="<%=data.getString("CODELETTER","") %>"/></td>
<td width="10%"><input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="8%" sortplan="jsp"/>
<BZ:th name="��������" sortType="string" width="10%" sortplan="database" sortfield="CODENAME"/>
<BZ:th name="����ֵ" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="��ĸ��" sortType="string" width="40%" sortplan="jsp"/>
<BZ:th name="�ϼ�����ֵ" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="�ϼ���������" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="�����" sortType="int" width="5%" sortplan="jsp"/>
<BZ:th name="��������" sortType="string" width="10%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="LIST" >
<tr>
<td tdvalue="<BZ:data field="CODEID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:a field="CODENAME">CodeSortServlet?method=editcode&CODESORTID=<%=CODESORTID %>&CODEID=<BZ:data field="CODEID" onlyValue="true"/></BZ:a></td>
<td><BZ:data field="CODEVALUE" defaultValue=""/></td>
<td><BZ:data field="CODELETTER" defaultValue=""/></td>
<td><BZ:data field="PARENTCODEVALUE" defaultValue=""/></td>
<td><BZ:data field="PARENTCODEVALUE" codeName="CODESORTID" defaultValue=""/></td>
<td><BZ:data field="PNO" defaultValue=""/></td>
<td><BZ:data field="CODEDESC" defaultValue=""/></td>
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
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>