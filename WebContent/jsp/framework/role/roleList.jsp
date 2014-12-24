<%@page import="com.hx.framework.role.vo.Role"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@page import="com.hx.framework.common.FrameworkConfig"%>
<%@page import="hx.database.databean.Data"%>

<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
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
Data data = (Data)request.getAttribute("data");
if(data==null){
	data = new Data();
}
String roleType = data.getString("ROLE_TYPE");
if(roleType==null){
	roleType="";
}
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<BZ:script isList="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame']);
	});
	function _onload(){

	}
	function search(){
		document.srcForm.action=path+"role/Role!queryChildren.action";
		document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"role/Role!toAdd.action?flag=add";
	document.srcForm.submit();
	document.srcForm.action=path+"role/Role!queryChildren.action";
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
	document.srcForm.action=path+"role/Role!toAdd.action?flag=modify&<%=Role.ROLE_ID %>="+ID;
	document.srcForm.submit();
	document.srcForm.action=path+"role/Role!queryChildren.action";
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
	document.srcForm.action=path+"role/Role!toAdd.action?flag=detail&<%=Role.ROLE_ID %>="+ID;
	document.srcForm.submit();
	document.srcForm.action=path+"role/Role!queryChildren.action";
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
	document.getElementById("Role_IDS").value=uuid;
	document.srcForm.action=path+"role/Role!deleteBatch.action";
	document.srcForm.submit();
	document.srcForm.action=path+"role/Role!queryChildren.action";
	}else{
	return;
	}
	}
	}

	//������Դ
	function allotResource(){
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
			var roleID=ID.split("!");
			if(("SUPERADMIN"==roleID[0] || "SYSADMIN"==roleID[0] || "SECADMIN"==roleID[0] || "AUDITADMIN"==roleID[0])&& <%=!(FrameworkConfig.isCanModifyAdminRole())%>){
				alert("����ԱȨ�޲��ɸ��ģ�");
				return;
			}

			document.srcForm.action=path+"role/Role!toAllotResource.action?<%=Role.ROLE_ID %>="+ID;
			document.srcForm.submit();
			document.srcForm.action=path+"role/Role!queryChildren.action";
		}
	}
	//��ɫ��Դ����
	function exportExcel(){
		if(confirm('ȷ��Ҫ����ΪExcel�ļ���?')){
			document.srcForm.action=path+"role/exportExcel.action";
			document.srcForm.submit();
		}
		else{
			return;
		}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" property="data">
<BZ:form name="srcForm" method="post" action="role/Role!queryChildren.action">
<BZ:frameDiv property="clueTo" className="kuangjia">
<input id="Role_IDS" name="IDS" type="hidden"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- ��ɫ��ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
<div class="heading">��ѯ����</div>
<div  class="chaxun">
<table class="chaxuntj">
<tr>
<td width="10%">��ɫ���ƣ�</td>
<td width="20%"><BZ:input field="CNAME" type="String" prefix="p_" defaultValue=""/></td>
<td width="10%">��ɫ���ͣ�</td>
<td width="20%"><select name="p_ROLE_TYPE">
					<option value="">��ѡ��</option>
					<option value="1" <%if(roleType.equals("1")){ %>selected<% }%>>����Ա��ɫ</option>
					<option value="2" <%if(roleType.equals("2")){ %>selected<% }%>>��ͨ��ɫ</option>
</select></td>
<td width="10%"></td>
<td width="20%"></td>
<td width="10%"><input type="button" value="��ѯ" class="button_search" onclick="search()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset"/></td>
</tr>
</table>
</div>
<div class="list">
<div class="heading">��ɫ�б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="15%" sortplan="jsp"/>
<BZ:th name="��ɫ����" sortType="string" width="20%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="��ɫ����" sortType="string" width="10%" sortplan="database"  sortfield="ROLE_TYPE"/>
<BZ:th name="״̬" sortType="string" width="55%" sortplan="database"  sortfield="STATUS"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ROLE_ID" onlyValue="true"/>!<BZ:data field="ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="ROLE_TYPE" defaultValue="" checkValue="1=����Ա��ɫ;2=��ͨ��ɫ"/></td>
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
<input type="button" value="������Դ" class="button_add" onclick="allotResource()" style="width: 80px"/>&nbsp;&nbsp;
<input type="hidden" value="�鿴" class="button_select" onclick="chakan()"/>&nbsp;&nbsp;
<input type="button" value="�޸�" class="button_update" onclick="_update()"/>&nbsp;&nbsp;
<input type="button" value="ɾ��" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;
<input type="button" value="����" class="button_add" onclick="exportExcel()"/>&nbsp;&nbsp;

</td>
</tr>
</table>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>