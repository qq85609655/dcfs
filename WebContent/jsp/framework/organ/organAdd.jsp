<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>�����֯����ҳ��</title>
<BZ:script isEdit="true"  isAjax="true"/>
<script>
$(document).ready(function() {
	dyniframesize(['leftFrame','mainFrame']);
});
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		var ORG_CODE = document.getElementById("ORG_CODE").value;
		if(ORG_CODE==""){
			document.srcForm.action=path+"organ/Organ!add.action";
			document.srcForm.submit();
		}
		else{
			var r=executeRequest("com.hx.framework.organ.OrganAjax","ORG_CODE="+ORG_CODE);
			if(r==1){
				alert("��֯�����Ѵ���");
				return;
			}
			else{
				document.srcForm.action=path+"organ/Organ!add.action";
				document.srcForm.submit();
			}
		}
	}
	function _back(){
		document.srcForm.action=path+"organ/Organ!queryChildrenPage.action";
		document.srcForm.submit();
	}
	function showPersonTree(fname){
		var reValue = window.showModalDialog(path+"person/selectPerson.action", this, "dialogWidth=480px;dialogHeight=320px;scroll=auto");
		document.getElementsByName("Organ_"+fname)[0].value = reValue["value"];
		document.getElementsByName("OrganD_"+fname+"_NAME")[0].value = reValue["name"];
		//alert( reValue["value"]);
		//alert( reValue["name"]);
	}
	function _showExtention(){
		var b = document.getElementById('extentionTable').style.display;
		if(b=='none'){
			document.getElementById('extentionTable').style.display = "block";
		}else{
			document.getElementById('extentionTable').style.display = "none";
		}
	}
	function customfieldManage(){
		var url = "<BZ:url/>/jsp/framework/organ/AddProperty.jsp";
		var dialogWidth="700";
		var dialogHeight="363";
		modalDialog(url,null,dialogWidth,dialogHeight);
	}
	//ѡ����֯����
	function _selectOrgan(){
		var reValue = modalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, 400,600);
		if(reValue){
			document.getElementById("ORGAN_ID").value = reValue["value"];
			document.getElementById("ORGAN_NAME").value = reValue["name"];
		}
	}
</script>
<style>
	img{vertical-align:middle}
</style>
</BZ:head>
<BZ:body property="data" codeNames="ORG_GRADE">
<BZ:form name="srcForm" method="post"  token="organAdd">
<div class="kuangjia" style="width: 755px">
<div class="heading">������Ϣ</div>
<!-- ��֯����ID -->
<input name="PARENT_ID" type="hidden" value="<%=request.getAttribute(Organ.PARENT_ID) %>"/>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">��֯����</td>
<td width="20%"><BZ:input field="CNAME" prefix="Organ_" type="String" notnull="��������֯����" formTitle="��֯����" defaultValue=""/></td>
<td width="10%">��֯���</td>
<td width="20%"><BZ:input field="SHORT_CNAME" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��֯����</td>
<td width="20%"><BZ:select field="ORG_TYPE" prefix="Organ_" formTitle="" codeName="organTypeList" isCode="true" property="data"/></td>
<td width="10%">���ƺ�</td>
<td width="20%"><input name="Organ_ORG_DOOR_NUM" type="text"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">������</td>
<td width="20%">
<BZ:input field="RESP_PERSON" prefix="Organ_" type="Hidden" defaultValue=""/>
<BZ:input field="RESP_PERSON_NAME" prefix="OrganD_" type="String" defaultValue="" onclick="showPersonTree('RESP_PERSON');"/>
</td>
<td width="10%">��ϵ�绰</td>
<td width="20%"><BZ:input field="ORG_PHONE" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�����</td>
<td width="20%"><BZ:input field="SEQ_NUM" prefix="Organ_" notnull="�����������" formTitle="�����" restriction="int" type="String" defaultValue=""/></td>
<td width="10%">��������</td>
<td width="20%"><BZ:input field="AREA_CODE" prefix="Organ_" helperCode="SYS_AREA_CODE" type="helper" helperTitle="ѡ�����" treeType="0" helperSync="true" showParent="false" style="width:100px;"/></td>
<td width="5%"></td>

</tr>

<tr>
<td width="5%"></td>
<td width="10%">˵��</td>
<td width="85%" colspan="4"><input name="Organ_MEMO" type="text" style="width: 80%"/></td>
</tr>

</table>
<div class="heading" style="cursor: hand;" id="extentionDiv" onclick="_showExtention();">��չ��Ϣ(�����ʾ����)</div>
<!-- ��֯����ID -->
<table class="contenttable" id="extentionTable" style="display: none">
<tr>
<td width="5%"></td>
<td width="10%">Ӣ������</td>
<td width="20%"><BZ:input field="ENNAME" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="10%">��֯����</td>
<td width="20%"><BZ:input id="ORG_CODE" field="ORG_CODE" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="10%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��������</td>
<td width="20%"><BZ:select field="ORG_GRADE" formTitle="" prefix="Organ_" codeName="ORG_GRADE" isCode="true"/></td>
<td width="10%" style="display:none" >������δ���</td>
<td width="20%" style="display:none" ><BZ:input field="ORG_LEVEL_CODE" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��ϵ��</td>
<td width="85%" colspan="4"><input name="Organ_LINK_MAN" type="text"/></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��ϵ��ַ</td>
<td width="85%" colspan="4"><input name="Organ_ORG_ADDR" type="text" style="width: 50%"/></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">EMail</td>
<td width="85%" colspan="4"><input name="ORG_EMAIL" type="text" style="width: 50%"/></td>
</tr>
<!-- ��չ������ʾ���� begin -->
<BZ:propExtend propType="0"/>
<!-- ��չ������ʾ���� end -->
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>