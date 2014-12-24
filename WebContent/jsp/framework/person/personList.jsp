<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.person.vo.Person"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.framework.common.FrameworkConfig"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);

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
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function SEQNUM_update(){

		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				uuid=uuid+"#"+arr[0];
				ORG_ID=ORG_ID+"#"+arr[1];
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('��ѡ��Ҫ��������ŵ���Ա');
			return;
		}

		document.srcForm.action=path+"person/Person!updateSeqNum.action";
		document.srcForm.submit();
	}

	function _onload(){

	}
	function search(){
		document.srcForm.action=path+"person/Person!query.action";
		document.srcForm.submit();
	}

	function add(){
			var org_id = document.getElementById("ORG_ID").value;
			if(org_id=="0" || org_id==""){
				alert("�����������ѡ���ź��������Ա��");
				return;
			}
		document.srcForm.action=path+"person/Person!toAdd.action";
		document.srcForm.submit();
	}
	function _update(){
	var sfdj=0;
	var ID="";
	var ORG_ID="";
	var arr ;
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			arr=document.getElementsByName('xuanze')[i].value.split("&");
			ID=arr[0];
			ORG_ID=arr[1];
			sfdj++;
		}
	}
	if(sfdj!="1"){
	alert('��ѡ��һ������');
	return;
	}else{
	document.getElementById("ORG_ID").value=ORG_ID;
	document.srcForm.action=path+"person/Person!toModify.action?<%=Person.PERSON_ID %>="+ID;
	document.srcForm.submit();
	}
	}

	//���ù���Ա
	function setAdmin(){
		var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
			}
		}
		if(sfdj!="1"){
		alert('��ѡ��һ������');
		return;
		}else{
			document.getElementById("ORG_ID").value=ORG_ID;
			document.srcForm.action=path+"person/Person!toSetAdmin.action?<%=Person.PERSON_ID %>="+ID;
			document.srcForm.submit();
		}
	}

	function addAccount(){
		var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
			}
		}
		if(sfdj!="1"){
		alert('��ѡ��һ������');
		return;
		}else{
			document.getElementById("ORG_ID").value=ORG_ID;
			document.srcForm.action=path+"person/Person!toAddAccount.action?<%=Person.PERSON_ID %>="+ID+"&_TO=addAccount";
			document.srcForm.submit();
		}
	}
	function _resetPwd(){
		var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
				if(arr[2]=="null"||arr[2]==null||arr[2]==""){
					alert("��Աδ�����˺ţ�");
					return;
				}
				}
		}
		if(sfdj!="1"){
			alert('��ѡ��һ������');
			return;
		}else{
			document.getElementById("ORG_ID").value=ORG_ID;
			document.srcForm.action=path+"person/Person!toAddAccount.action?<%=Person.PERSON_ID %>="+ID+"&_TO=resetPwd";
			document.srcForm.submit();
		}
	}

	function changeBelong(){
			var sfdj=0;
		var ID="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				ID=arr[0];
				ORG_ID=arr[1];
				sfdj++;
			}
		}
		if(sfdj!="1"){
			alert('��ѡ��һ������');
			return;
		}else{
			//var clo = window.showModalDialog("person/Person!changeBelongFrame.action?<%=OrganPerson.ORG_ID %>="+ORG_ID+"&<%=Person.PERSON_ID %>="+ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=no");
			window.open("person/Person!changeBelongFrame.action?<%=OrganPerson.ORG_ID %>="+ORG_ID+"&<%=Person.PERSON_ID %>="+ID);
			if(clo){
			document.srcForm.action=path+"person/Person!query.action";
				document.srcForm.submit();
			}
		}
	}

	function exportExcel(){
		if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
			document.srcForm.action=path+"person/exportExcel.action";
			document.srcForm.submit();
		}
		else{
			return;
		}
	}

	function changeOrg(){
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				uuid=uuid+"!"+arr[0];
				ORG_ID=ORG_ID+"!"+arr[1];
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('��ѡ��Ҫ����������');
			return;
		}else{
			//var ORG_ID = document.getElementById("ORG_ID").value;
			document.srcForm.action=path+"person/Person!query.action";
			window.showModalDialog("person/Person!changeOrgFrame.action?<%=OrganPerson.ORG_ID %>="+ORG_ID+"&<%=Person.PERSON_ID %>="+uuid, this, "dialogWidth=300px;dialogHeight=300px;scroll=auto");
			document.srcForm.submit();
		}
	}

	function chakan(){
	var sfdj=0;
	var ID="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
		ID=document.getElementsByName('xuanze')[i].value.split("&")[0];
		sfdj++;
	}
	}
	if(sfdj!="1"){
		alert('��ѡ��һ������');
		return;
	}else{
		//��href������ת
		document.srcForm.action=path+"person/Person!queryDetail.action?flag=detail&<%=Person.PERSON_ID %>="+ID;
		document.srcForm.submit();
	}
	}
	function _delete(){
	var sfdj=0;
	var uuid="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			uuid=uuid+document.getElementsByName('xuanze')[i].value.split("&")[0]+"#";
			sfdj++;
			arr=document.getElementsByName('xuanze')[i].value.split("&");
			if(arr[2]=="null"){
				alert("�޷��߼�ɾ��δ�����˺ŵ���Ա��");
				return;
			}
		}
	}
	if(sfdj=="0"){
	alert('��ѡ��Ҫɾ��������');
	return;
	}else{
		if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
			document.getElementById("Person_IDS").value=uuid;
			var ORG_ID = document.getElementById("ORG_ID").value;
			document.srcForm.action=path+"person/Person!deleteBatch.action?<%=OrganPerson.ORG_ID %>="+ORG_ID;
			document.srcForm.submit();
		}else{
			return;
		}
	}
	}

	function _resetAccount(type1){//����
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");
				uuid=uuid+"#"+arr[0];
				ORG_ID=ORG_ID+"#"+arr[1];
				sfdj++;
			}
		}
		var s="����";
		if(type1=='unlock') s="����";
		if(type1=='disable') s="����";

		if(sfdj=="0"){
			alert('��ѡ��Ҫ'+s+'���˺�');
			return;
		}else{
			if(confirm('ȷ��Ҫ'+s+'ѡ�е��˺���?')){
				document.getElementById("Person_IDS").value=uuid;
				//var ORG_ID = document.getElementById("ORG_ID").value;
				document.srcForm.action=path+"person/Person!resetAccount.action?TYPE1="+type1+"&ORG_ID="+ORG_ID;
				//alert(document.srcForm.action);
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	function _deleteAccount(){// sysadmin   secadmin  auditadmin admin
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
				arr=document.getElementsByName('xuanze')[i].value.split("&");

				if(arr[0]=='sysadmin' || arr[0]=='secadmin' || arr[0]=='auditadmin'  || arr[0]=='admin' ){
					alert("ϵͳ������Ա��������ɾ����");
					return;
				}

				uuid=uuid+"#"+arr[0];
				ORG_ID=ORG_ID+"#"+arr[1];
				sfdj++;
			}
		}
		if(sfdj=="0"){
			alert('��ѡ��Ҫɾ��������');
			return;
		}else{
			if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
				document.getElementById("Person_IDS").value=uuid;
				//var ORG_ID = document.getElementById("ORG_ID").value;
				document.srcForm.action=path+"person/Person!deleteAccount.action?<%=OrganPerson.ORG_ID %>="+ORG_ID;
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	function _deleteForce(){
		var sfdj=0;
		var uuid="";
		var ORG_ID="";
		var arr ;
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			arr=document.getElementsByName('xuanze')[i].value.split("&");

			//alert(arr[0]);//sysadmin   secadmin  auditadmin admin
			if(arr[0]=='sysadmin' || arr[0]=='secadmin' || arr[0]=='auditadmin'  || arr[0]=='admin' ){
				alert("ϵͳ������Ա��������ɾ����");
				return;
			}

			uuid=uuid+"#"+arr[0];
			ORG_ID=ORG_ID+"#"+arr[1];
			sfdj++;
		}
		}
		if(sfdj=="0"){
			alert('��ѡ��Ҫɾ��������');
			return;
		}else{
			if(confirm('ȷ��Ҫɾ��ѡ����Ϣ��?')){
				document.getElementById("Person_IDS").value=uuid;
				//var ORG_ID = document.getElementById("ORG_ID").value;
				document.srcForm.action=path+"person/Person!deleteForce.action?<%=OrganPerson.ORG_ID %>="+ORG_ID;
				document.srcForm.submit();
			}else{
				return;
			}
		}
	}

	//ѡ����֯����
	function selectOrgan(){
		var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=400px;dialogHeight=600px;scroll=auto");

		if(reValue){
			document.all("S_ORG_ID").value = reValue["value"];
			document.all("A_ORGAN_NAME").value = reValue["name"];
		}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="SEX;SYS_ORGAN_ALL" >
<BZ:form name="srcForm" method="post" action="person/Person!query.action">
<BZ:frameDiv property="clueTo" className="kuangjia">
<input id="Person_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- ��ǰ��Ա�б���������֯����ID -->
<input type="hidden" id="ORG_ID" name="ORG_ID" value="<%=request.getParameter("S_ORG_ID")==null?"":request.getParameter("S_ORG_ID") %>" >



	<div class="heading">��ѯ����</div>
	<div  class="chaxun">
		<table class="chaxuntj">
			<tr>
				<td width="10%" align="right" nowrap="nowrap">���ţ�</td>
				<td width="20%" align="left">
					<BZ:input type="hidden" prefix="S_" field="ORG_ID" defaultValue="" property="data"/>
					<BZ:input type="String" prefix="A_" field="ORGAN_NAME" defaultValue="" readonly="true" onclick="selectOrgan();" property="data"/>
				</td>
				<td width="10%" align="right" nowrap="nowrap">��Ա���ƣ�</td>
				<td width="20%" align="left"><BZ:input field="CNAME" type="String" property="data" prefix="S_" defaultValue="" /></td>
				<td width="10%"></td>
				</tr>
				<tr>
				<td width="10%" align="right" nowrap="nowrap" >��Ա�˺ţ�</td>
				<td width="20%" align="left"><BZ:input field="ACCOUNT_ID" type="String"  property="data" prefix="S_" defaultValue="" /></td>
				<td width="10%" align="right" nowrap="nowrap" >�˺�״̬��</td>
				<td width="20%" align="left" >
					<BZ:select field="STATUS" formTitle="" prefix="S_"  property="data">
						<BZ:option value="">ȫ��</BZ:option>
						<BZ:option value="1">����</BZ:option>
						<BZ:option value="2">����</BZ:option>
						<BZ:option value="4">����</BZ:option>
						<BZ:option value="3">ɾ��</BZ:option>
					</BZ:select>
				</td>
				<td width="10%">
					<input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</div>


<div class="list">
<div class="heading">��Ա�б�</div>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;">
<%
	//ϵͳ���ܹ���Ա�ͳ�������Ա���ܷ����˺�
	if(("0".equals(user.getAdminType()) || "1".equals(user.getAdminType()))	){
%>
<input type="button" value="���" class="button_add" style="width:50px" onclick="add()"/>&nbsp;&nbsp;
<input type="button" value="�޸�" class="button_update" style="width:50px" onclick="_update()"/>&nbsp;&nbsp;
<input type="hidden" value="�鿴" class="button_select" style="width:50px" onclick="chakan()"/>&nbsp;&nbsp;
<!--  <input type="button" value="��Ա����" class="button_add" style="width: 80px" onclick="changeOrg()"/>&nbsp;&nbsp;-->
<%if(1!=1){ %>
<input type="button" value="�����ڱಿ��" class="button_add" style="width: 100px" onclick="changeBelong()"/>&nbsp;&nbsp;
<%} %>
<input type="button" value="����" class="button_add" style="width: 50px" onclick="exportExcel()"/>&nbsp;&nbsp;
<input type="button" value="���������" class="button_update" style="width: 90px" onclick="SEQNUM_update()"/>&nbsp;&nbsp;
<input type="button" value="ע��" style="width: 50px" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="ɾ��" style="width: 50px" class="button_delete" onclick="_deleteForce()"/>
<%} %>
</td>
</tr>
</table>
<BZ:table tableid="tableGrid" tableclass="tableGrid" >
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="10%" sortplan="jsp"/>
<BZ:th name="����" sortType="string" width="10%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="�˺�" sortType="string" width="10%" sortplan="database" sortfield="ACCOUNT_ID"/>
<BZ:th name="�Ա�" sortType="string" width="10%" sortplan="database" sortfield="SEX"/>
<BZ:th name="�˺�����" sortType="date" width="10%" sortplan="database" sortfield="ACCOUNT_TYPE"/>
<BZ:th name="�˺�״̬" sortType="string" width="10%" sortplan="database" sortfield="STATUS"/>
<BZ:th name="����" sortType="string" width="10%" sortplan="database" sortfield="ORGAN_NAME"/>
<BZ:th name="��֯Ȩ��" sortType="string" width="10%" sortplan="database" sortfield="ORGAN_RIGHT"/>
<BZ:th name="�Ƿ��" sortType="string" width="10%" sortplan="database" sortfield="AUTH_TYPE"/>
<BZ:th name="�����" sortType="string" width="10%" sortplan="database" sortfield="SEQ_NUM"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" fordata="onedata">
<tr <%String status=((Data) pageContext.getAttribute("onedata")).getString("STATUS"); if("3".equals(status)){ %> style="color:#808080" <%};if("2".equals(status)){ %> style="color:#0000FF" <%} ;if("4".equals(status)){ %> style="color:red" <%} %> >
<td tdvalue="<BZ:data field="Person_ID" onlyValue="true"/>&<BZ:data field="ORG_ID" onlyValue="true"/>&<BZ:data field="ACCOUNT_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="ACCOUNT_ID" defaultValue=""/></td>
<td><BZ:data field="SEX" defaultValue="" codeName="SEX"/></td>
<td><BZ:data field="ACCOUNT_TYPE" defaultValue="" checkValue="0=��ʱ;1=��ͨ�û�;2=guest�û�"/></td>
<td><BZ:data field="STATUS" defaultValue="" checkValue="1=����;2=����;3=ɾ��;4=����"/></td>
<td><BZ:data field="ORGAN_NAME" defaultValue=""/></td>
<td><BZ:data field="ORGAN_RIGHT" defaultValue=""  codeName="SYS_ORGAN_ALL"/></td>
<td><BZ:data field="AUTH_TYPE" defaultValue="2" checkValue="2=��;1=����"/></td>
<td><input style= "width:50%; " type="text" name="SEQ_<BZ:data field="Person_ID" onlyValue="true"/>" style="width:100%" value="<BZ:data field="SEQ_NUM" defaultValue="0" onlyValue="true"/>"></td>
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

<%
	//ϵͳ����Ա�ͳ�������Ա���ܷ����˺�
	if("0".equals(user.getAdminType()) || "1".equals(user.getAdminType()) ){
%>
	<input type="button" value="�����˺�" class="button_add" style="width: 80px" onclick="addAccount()"/>&nbsp;&nbsp;
	<input type="button" value="��������" class="button_reset" style="width: 80px" onclick="_resetPwd()"/>&nbsp;&nbsp;
	<input type="button" value="ɾ���˺�" class="button_delete" style="width: 80px" onclick="_deleteAccount()"/>&nbsp;&nbsp;
<%} %>

<%
	if(FrameworkConfig.isMultistageAdminMode()){

}
	//ϵͳ���ܹ���Ա�ͳ�������Ա���ܷ����˺�
	if("0".equals(user.getAdminType()) ||
			(FrameworkConfig.isThreeAdminMode() && "2".equals(user.getAdminType()))
			|| (FrameworkConfig.isMultistageAdminMode() && "1".equals(user.getAdminType())) ){
%>

	<input type="button" value="�����˺�" style="width: 80px" class="button_reset" onclick="_resetAccount('lock')"/>&nbsp;&nbsp;
	<input type="button" value="�����˺�" style="width: 80px" class="button_reset" onclick="_resetAccount('disable')"/>&nbsp;&nbsp;
	<input type="button" value="�����˺�" style="width: 80px" class="button_reset" onclick="_resetAccount('unlock')"/>&nbsp;&nbsp;
<%} %>

</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>