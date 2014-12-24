
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
<title>添加页面</title>
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

	//选择组织机构
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
<!-- 角色组ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
<div class="heading">添加角色</div>
<table class="contenttable">

<tr>
<td></td>
<td>角色ID</td>
<td colspan="4">
<BZ:input field="ROLE_ID" defaultValue="" formTitle="角色ID" prefix="Role_" notnull="请输入角色ID" restriction="int"/>

</td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">角色类型</td>
<td width="20%">
	<%
		//系统管理员和超级管理员才能设置管理员
		if("0".equals(user.getAdminType()) || "1".equals(user.getAdminType())|| "2".equals(user.getAdminType())){
	%>
	<BZ:select field="ROLE_TYPE" formTitle="" prefix="Role_">
		<BZ:option value="1">管理员角色</BZ:option>
		<BZ:option value="2">普通角色</BZ:option>
	</BZ:select>
	<%
		}else{
	%>
	<BZ:select field="ROLE_TYPE" formTitle="" prefix="Role_">
		<BZ:option value="2">普通角色</BZ:option>
	</BZ:select>
	<%
		}
	%>
</td>
<td width="10%">角色名称</td>
<td width="20%"><BZ:input field="CNAME" prefix="Role_" notnull="请输入角色名称" formTitle="角色名称" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">下级组织是否可授权</td>
<td width="20%">
	<BZ:select field="IS_ORGAN_INHERIT" formTitle="" prefix="Role_">
		<BZ:option value="1">是</BZ:option>
		<BZ:option value="0">否</BZ:option>
	</BZ:select>
</td>
<td width="10%">排序号</td>
<td width="20%"><BZ:input field="SEQ_NUM" formTitle="排序号" prefix="Role_" notnull="请输入排序号" restriction="int" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>角色说明</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="Role_MEMO"><%=data.getString("MEMO")!=null?data.getString("MEMO"):"" %></textarea></td>
</tr>


<tr>
<td></td>
<td>所属组织</td>
<td colspan="4">
	<input name="Role_ORGAN_ID" type="hidden" id="Role_ORGAN_ID"/>
	<input name="TEMP_ORGAN_ID" readonly="readonly" type="text" id="TEMP_ORGAN_ID" onclick="selectOrgs()"/>
</td>
</tr>

<tr>
<td></td>
<td>所属应用</td>
<td colspan="4">
	<input type="hidden" name="Role_APP_ID" id="Role_APP_ID" value="0"/>
	全局<input id="TEMP_APP_ID_ONE" name="TEMP_APP_ID" type="radio" checked="checked" onclick="addAppIdOfRadio()"/>
	应用<input id="TEMP_APP_ID_TWO" name="TEMP_APP_ID" type="radio" onclick="addAppId()"/>
	<input type="text" name="TEMP_APP_ID_R" id="TEMP_APP_ID_R" readonly="readonly" onclick="addAppId()"/>
</td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="1" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="reset" value="重置" class="button_reset" />&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>