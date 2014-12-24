
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data data = (Data)request.getAttribute("data");
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
%>
<BZ:html>
<BZ:head>
<title>���ҳ��</title>
<BZ:script isEdit="true" isDate="true"/>
<script>
	function tijiao()
	{
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
	document.srcForm.action=path+"role/Role!add.action";
 	document.srcForm.submit();
	}
	function _back(){
 	document.srcForm.action=path+"role/Role!queryChildren.action";
 	document.srcForm.submit();
	}

	//ѡ����֯����
	function selectOrgs(){
		var reValue = window.showModalDialog("role/Role!selectOrg.action", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
		document.getElementById("Role_ORGAN_ID").value = reValue["value"];
		document.getElementById("TEMP_ORGAN_ID").value = reValue["name"];
	}

	function addAppIdOfRadio(){

		document.getElementById("Role_APP_ID").value = '0';
		document.getElementById("TEMP_APP_ID_R").value = "";
	}

	function addAppId(){

		
		document.getElementById("TEMP_APP_ID_TWO").checked = 'checked';
		var reValue = window.showModalDialog("role/Role!selectResource.action", this, "dialogWidth=200px;dialogHeight=250px;scroll=auto");
		if(reValue != null){
			document.getElementById("Role_APP_ID").value = reValue["value"];
			document.getElementById("TEMP_APP_ID_R").value = reValue["name"];
		}else{
			document.getElementById("TEMP_APP_ID_ONE").checked = 'checked';
			document.getElementById("Role_APP_ID").value = '0';
			document.getElementById("TEMP_APP_ID_R").value = "";
		}
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post" token="roleAdd1">
<BZ:frameDiv property="clueTo" className="kuangjia">
<!-- ��ɫ��ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
<div class="heading">��ӽ�ɫ</div>
<table class="contenttable">

<tr>
<td></td>
<td>��ɫID</td>
<td colspan="4">
<BZ:input field="ROLE_ID" defaultValue="" formTitle="��ɫID" prefix="Role_" notnull="�������ɫID" restriction="int"/>

</td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��ɫ����</td>
<td width="20%">
	<%
		//ϵͳ����Ա�ͳ�������Ա�������ù���Ա
		if("0".equals(user.getAdminType()) || "1".equals(user.getAdminType())|| "2".equals(user.getAdminType())){
	%>
	<BZ:select field="ROLE_TYPE" formTitle="" prefix="Role_">
		<BZ:option value="1">����Ա��ɫ</BZ:option>
		<BZ:option value="2">��ͨ��ɫ</BZ:option>
	</BZ:select>
	<%
		}else{
	%>
	<BZ:select field="ROLE_TYPE" formTitle="" prefix="Role_">
		<BZ:option value="2">��ͨ��ɫ</BZ:option>
	</BZ:select>
	<%
		}
	%>
</td>
<td width="10%">��ɫ����</td>
<td width="20%"><BZ:input field="CNAME" prefix="Role_" notnull="�������ɫ����" formTitle="��ɫ����" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�¼���֯�Ƿ����Ȩ</td>
<td width="20%">
	<BZ:select field="IS_ORGAN_INHERIT" formTitle="" prefix="Role_">
		<BZ:option value="1">��</BZ:option>
		<BZ:option value="0">��</BZ:option>
	</BZ:select>
</td>
<td width="10%">�����</td>
<td width="20%"><BZ:input field="SEQ_NUM" formTitle="�����" prefix="Role_" notnull="�����������" restriction="int" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>��ɫ˵��</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="Role_MEMO"><%=data.getString("MEMO")!=null?data.getString("MEMO"):"" %></textarea></td>
</tr>


<tr>
<td></td>
<td>������֯</td>
<td colspan="4">
	<input name="Role_ORGAN_ID" type="hidden" id="Role_ORGAN_ID"/>
	<input name="TEMP_ORGAN_ID" readonly="readonly" type="text" id="TEMP_ORGAN_ID" onclick="selectOrgs()"/>
</td>
</tr>

<tr>
<td></td>
<td>����Ӧ��</td>
<td colspan="4">
	<input type="hidden" name="Role_APP_ID" id="Role_APP_ID" value="0"/>
	ȫ��<input id="TEMP_APP_ID_ONE" name="TEMP_APP_ID" type="radio" checked="checked" onclick="addAppIdOfRadio()"/>
	Ӧ��<input id="TEMP_APP_ID_TWO" name="TEMP_APP_ID" type="radio" onclick="addAppId()"/>
	<input type="text" name="TEMP_APP_ID_R" id="TEMP_APP_ID_R" readonly="readonly" onclick="addAppId()"/>
</td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="1" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="����" class="button_reset" />&nbsp;&nbsp;<input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>