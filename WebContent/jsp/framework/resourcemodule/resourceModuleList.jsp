
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ page import="hx.database.databean.Data" %>
<%@ page import="hx.util.InfoClueTo" %>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String APP_ID=(String)request.getAttribute("APP_ID");
if(APP_ID==null){
	APP_ID="";
}
String compositor=(String)request.getParameter("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getParameter("ordertype");
if(ordertype==null){
	ordertype="";
}
InfoClueTo clueTo = (InfoClueTo)request.getAttribute("clueTo");
int type = -1;
if(clueTo!=null)
{
	type = clueTo.getInfotype();
}
%>
<BZ:html>
<BZ:head>
<title>ģ���б�</title>
<BZ:script isList="true"  />
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	//����ģ����Ӳ˵�
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
		document.srcForm.action=path+"module/addMenue.action";
		document.srcForm.submit();
		}else{
		return;
		}
		}
	}

	function _onload(){
		var type = <%=type%>;
		if(type==0)
		{
			parent.leftFrame.location ="<%=request.getContextPath() %>/module/resourceModuleTree.action?APP_ID=<%=APP_ID %>";
		}
	}
	function search(){
	document.srcForm.action=path+"CodeSortServlet";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"module/resourceModuleToAdd.action";
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
	document.srcForm.action=path+"module/resourceModuleDetailed.action?ID="+ID+"&jsp=modify";
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
	document.srcForm.action=path+"module/resourceModuleDetailed.action?ID="+ID+"&jsp=look";
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
	document.srcForm.action=path+"module/resourceModuleDelete.action";
	document.srcForm.submit();
	}else{
	return;
	}
	}
	}

	function _bakApp(){
		parent.document.location.href=path+"app/resourceAppList.action";
	//document.srcForm.action=path+"app/resourceAppList.action";
	//document.srcForm.submit();
	}

	function showresource(){
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
	document.srcForm.action=path+"resource/resourcesList.action?gotype=list&APP_ID=<%=APP_ID%>&MODULE_ID="+ID;
	document.srcForm.submit();
	}
	}

	</script>
</BZ:head>
<BZ:body onload="_onload()" >
<BZ:form name="srcForm" method="post" action="module/resourceModuleList.action?type=tree">
<input type="hidden" name="P_APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="APP_ID" value="<%=APP_ID%>"/>
<input type="hidden" name="PMOUDLE" id="PMOUDLE" value="<%=request.getAttribute("PMOUDLE") %>"/>
<input type="hidden" name="deleteid" />
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!--  -->
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="list">
<div class="heading">ģ���б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="ģ������" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="Ӣ������" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="��ģ��" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="�Ƿ���ҪȨ�޿���" sortType="string" width="15%" sortplan="jsp"/>
<BZ:th name="�Ƿ�ɹ���" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="״̬" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="����ʱ��" sortType="string" width="10%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="10%" sortplan="jsp"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="fordata">
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" defaultValue=""/></td>
<td><BZ:data field="ENNAME" defaultValue=""/></td>
<td><BZ:data field="PNAME" defaultValue=""/></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("NEED_RIGHT",""))){%>��<%}else{ %>��<%} %></td>
<td><% if("1".equals(((Data)pageContext.getAttribute("fordata")).getString("ADMIN_FLAG",""))){%>��<%}else{ %>��<%} %></td>
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
<td align="right" style="padding-right:30px;height:35px;">&nbsp;&nbsp;<input type="button" value="���ɲ˵�" class="button_add" onclick="addMenue()"/>&nbsp;&nbsp;<input type="button" value="������Դ�б�" class="button_goto" onclick="showresource()" style="width:100px;"/>&nbsp;&nbsp;<input type="button" value="���" class="button_add" onclick="add()"/>&nbsp;&nbsp;<input type="button" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;<%if(!"".equals(APP_ID)){ %><input type="button" value="����" class="button_back" onclick="_bakApp()"/><%} %>
</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>