
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
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
%>
<BZ:html>
<BZ:head>
<title>�б�</title>
<base target=_self>
<BZ:script isList="true"/>
	<script type="text/javascript">
	function _onload(){

	}
	function search(){
	document.srcForm.action=path+"";
	document.srcForm.submit();
	}

	function add(){
	document.srcForm.action=path+"role/Role!toAdd.action";
	document.srcForm.submit();
	}

	//�����ɫ����ɫ��
	function allotRole(){

	var ID = document.getElementById("GROUP_ID").value;
	//����
	var PARENT_ID = document.getElementById("PARENT_ID").value;
	window.showModalDialog("role/RoleGroup!queryNoRoles.action?<%=RoleGroup.ID %>="+ID+"&<%=RoleGroup.PARENT_ID %>="+PARENT_ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=auto");
	//�ص�
	document.srcForm.action = "role/RoleGroup!queryRoles.action?<%=RoleGroup.ID %>="+ID;
	document.srcForm.submit();
	}

	function _back(){
	document.srcForm.action=path+"role/RoleGroup!queryChildrenPage.action";
	document.srcForm.submit();
	}

	function _delete(){
		var sfdj=0;
		var uuid="";
		var roleids="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
			//alert(document.getElementsByName('xuanze')[i].value);
			var di=document.getElementsByName('xuanze')[i].value.split(",");
				uuid=uuid+di[0]+"#";
				roleids=roleids+di[1]+"#";
				//uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
				sfdj++;
		}
		}
		if(sfdj==0){
			alert('��ѡ��Ҫ�Ƴ�������');
			return;
		}else{
			if(confirm('ȷ��Ҫ�Ƴ�ѡ����Ϣ��?')){
				document.getElementById("DELETE_IDS").value=uuid;
				document.getElementById("ROLE_IDS").value=roleids;
				document.srcForm.action=path+"role/Authorize!removePerRole.action";
				document.srcForm.submit();
			}else{
				return;
			}
		}
		window.returnValue = "true";
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()">
<form name="srcForm" method="post" action="role/RoleGroup!allotRole.action">
<div class="kuangjia">
<input id="DELETE_IDS" name="DELETE_IDS" type="hidden"/>
<input id="ROLE_IDS" name="ROLE_IDS" type="hidden"/>
<!-- ѡ�е���ԱID -->
<input name="PERSON_IDS" id="PERSON_IDS" type="hidden" value="<%=request.getAttribute("PERSON_IDS")!=null?request.getAttribute("PERSON_IDS"):"" %>"/>
<!--����������ݿ������ʾ(���������ݿ�������Բ���)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<div class="list">
<div class="heading">��ɫȨ���б�</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="���" sortType="none" width="20%" sortplan="jsp"/>
<BZ:th name="��ɫ����" sortType="string" width="40%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="��ɫ����" sortType="string" width="40%" sortplan="database" sortfield="ROLE_TYPE"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ID" onlyValue="true"/>,<BZ:data field="ROLE_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
<td><BZ:data field="ROLE_TYPE" onlyValue="true"/></td>
</tr>
</BZ:for>
</BZ:tbody>
</BZ:table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td style="padding-left:15px"></td>
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="�Ƴ�" class="button_delete" onclick="_delete()"/>&nbsp;&nbsp;<input type="button" value="�ر�" class="button_back" onclick="window.close();"/>
</td>
</tr>
</table>
</div>
</div>
</form>
</BZ:body>
</BZ:html>