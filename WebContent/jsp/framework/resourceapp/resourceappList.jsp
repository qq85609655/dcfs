
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
Data data=(Data)request.getAttribute("datatj");
if(data==null){
	data=new Data();
}
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}
String inputXml = (String)request.getAttribute("inputXml");
if(inputXml!=null&&inputXml.equals("true"))
{
out.print("<script language='javascript'>");
out.print("alert('����ɹ�!')");
out.print("</script>");
}
if(inputXml!=null&&inputXml.equals("false"))
{
out.print("<script language='javascript'>");
out.print("alert('����ʧ��!')");
out.print("</script>");
}
%>
<BZ:html>
<BZ:head>
<up:uploadResource/>
<title>Ӧ���б�</title>
<BZ:script isList="true" />
<script src="<BZ:resourcePath/>/js/ajax.js"></script>
<script src="<BZ:resourcePath/>/js/breezeCommon.js"></script>
<script src="<BZ:resourcePath/>/js/framework.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		dyniframesize(['mainFrame']);
	});
	//����Ӧ����ӵ�����
	function addNavBar(){
		var sfdj=0;
		var uuid="";
		var ss=true;

		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
		arr=document.getElementsByName('xuanze')[i].value.split("&");
		deleteuuid="#"+arr[0];
		uuid=uuid+"#"+arr[0];
		appName=arr[1];
		ss=ResourceAppIsRepead(appName,deleteuuid);
		sfdj++;
		}
		}
		if(sfdj=="0"){
		alert('��ѡ��Ҫ��Ӳ˵�������');
		return;
		}else{
			if(ss==false){
			alert("�Ѿ����ڸ�Ӧ�õĵ�������");
			}else{
				if(confirm('ȷ��Ҫ���ɵ�������?')){
					document.getElementById("deleteid").value=uuid;
				document.srcForm.action=path+"app/addNavBar.action";
					document.srcForm.submit();
					}else{
						return;
				}
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
	document.srcForm.action=path+"app/resourceAppToAdd.action";
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
	document.srcForm.action=path+"app/resourceAppDetailed.action?ID="+ID+"&jsp=modify";
	document.srcForm.submit();
	}
	}
	function chakancxt(){
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
	document.srcForm.action=path+"app/appContextList.action?appId="+ID;
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
	document.srcForm.action=path+"app/resourceAppDetailed.action?ID="+ID+"&jsp=look";
	document.srcForm.submit();
	}
	}
	function _delete(){
	var sfdj=0;
	var uuid="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
		arr=document.getElementsByName('xuanze')[i].value.split("&");
		uuid=uuid+"#"+arr[0];
	sfdj++;
	}
	}
	if(sfdj=="0"){
	alert('��ѡ��Ҫɾ��������');
	return;
	}else{
	if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
	document.getElementById("deleteid").value=uuid;
	document.srcForm.action=path+"app/resourceAppDelete.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}

	function showmodule(){
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
	document.srcForm.action=path+"module/resourceModuleIndex.action?APP_ID="+ID;
	document.srcForm.submit();
	}
	}
	//����XML
	function outputXml(){
		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			arr=document.getElementsByName('xuanze')[i].value.split("&");
			uuid=uuid+"#"+arr[0];
		sfdj++;
		}
		}
		if(sfdj=="0"){
		alert('��ѡ��Ҫ����������');
		return;
		}else{
		if(confirm('ȷ��Ҫ������?')){
		document.getElementById("deleteid").value=uuid;
		document.srcForm.action=path+"app/outputXml.action";
		document.srcForm.submit();
		}else{
		return;
		}
		}
	}
	//����XML
	function inXml(){//д��inputXml ʱ�����⣬������inXml ����inputXml
	var url = "<BZ:url/>/jsp/framework/resourceapp/uploadXml.jsp";
	var dialogWidth="400";
	var dialogHeight="70";
	modalDialog(url,null,dialogWidth,dialogHeight);
	window.location.href=path+"app/resourceAppList.action";
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="app/resourceAppList.action">
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
<BZ:th name="Ӧ��ϵͳ����" sortType="string" width="15%" sortplan="database" sortfield="APP_NAME"/>
<BZ:th name="������" sortType="string" width="15%" sortplan="database" sortfield="DEVELOPER"/>
<BZ:th name="�汾" sortType="string" width="10%" sortplan="database" sortfield="VERSION"/>
<BZ:th name="˵��" sortType="string" width="25%" sortplan="database" sortfield="MEMO"/>
<BZ:th name="��������" sortType="string" width="25%" sortplan="database" sortfield="CREATE_TIME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>&<BZ:data field="APP_NAME" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="APP_NAME" defaultValue=""/></td>
<td><BZ:data field="DEVELOPER" defaultValue=""/></td>
<td><BZ:data field="VERSION" defaultValue=""/></td>
<td><BZ:data field="MEMO" defaultValue=""/></td>
<td><BZ:data field="CREATE_TIME"  type="Date" defaultValue=""/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td colspan="1"><BZ:page form="srcForm" property="dataList"/></td>
</tr>
<tr>
<td align="right">
&nbsp;<input type="button" value="��������" class="button_add" onclick="inXml()"/>
&nbsp;<input type="button" value="��������" class="button_add" onclick="outputXml()"/>
&nbsp;<input type="button" value="���ɵ�����" style="width:90px;" class="button_add" onclick="addNavBar()"/>
&nbsp;<input type="button" value="����ģ���б�" style="width:100px;" class="button_goto"  onclick="showmodule()"/>
&nbsp;<input type="button" value="������Ϣ" class="button_goto" onclick="chakancxt()"/>
&nbsp;<input type="button" value="���" class="button_add" onclick="add()"/>
&nbsp;<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>
&nbsp;<input type="button" value="�޸�" class="button_update" onclick="_update()"/>
&nbsp;<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>