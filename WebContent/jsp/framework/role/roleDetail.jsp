
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.organ.vo.OrganType"%>
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
<title>��ɫ��ϸҳ��</title>
<BZ:script isEdit="true" isDate="true"/>
<script>	
	function _back(){
 	document.srcForm.action=path+"role/Role!queryChildren.action";
 	document.srcForm.submit();
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<!-- ��ɫ��ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"  />
<div class="heading">��ɫ��ϸ</div>
<table class="contenttable">

<tr>
<td></td>
<td>��ɫID</td>
<td colspan="4"><input name="Role_ROLE_ID" value="<%=data.getString("ROLE_ID")!=null?data.getString("ROLE_ID"):"" %>" type="text"  disabled="true" /></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">��ɫ����</td>
<td width="20%">
	<BZ:select field="ROLE_TYPE" formTitle="" prefix="Role_" disabled="true">
		<BZ:option value="1">����Ա��ɫ</BZ:option>
		<BZ:option value="2" selected="true">��ͨ��ɫ</BZ:option>
	</BZ:select>
</td>
<td width="10%">��ɫ����</td>
<td width="20%"><BZ:input field="CNAME" disabled="true" prefix="Role_" type="String" defaultValue=""  /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">�¼���֯�Ƿ����Ȩ</td>
<td width="20%">
	<BZ:select field="IS_ORGAN_INHERIT" formTitle="" prefix="Role_" disabled="true">
		<BZ:option value="1" selected="true">��</BZ:option>
		<BZ:option value="0">��</BZ:option>
	</BZ:select>	
</td>
<td width="10%">�����</td>
<td width="20%"><BZ:input field="SEQ_NUM" disabled="true" prefix="Role_" type="String" defaultValue=""  /></td>
<td width="5%"></td>
</tr>

<tr>
<td></td>
<td>��ɫ˵��</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="Role_MEMO" disabled="disabled" ><%=data.getString("MEMO")!=null?data.getString("MEMO"):"" %></textarea></td>
</tr>


<tr>
<td></td>
<td>������֯</td>
<td colspan="4">
	<input name="Role_ORGAN_ID" type="hidden" id="Role_ORGAN_ID" value="<%=data.getString("ORGAN_ID")!=null?data.getString("ORGAN_ID"):"" %>"/>
	<input name="TEMP_ORGAN_ID" disabled="disabled"  type="text" id="TEMP_ORGAN_ID" onclick="selectOrgs()" value="<%=data.getString("ORGAN_NAME")!=null?data.getString("ORGAN_NAME"):"" %>"/>
</td>
</tr>

<tr>
<td></td>
<td>����Ӧ��</td>
<td colspan="4">
	<input type="hidden" name="Role_APP_ID" id="Role_APP_ID" value="<%=data.getString("APP_ID")!=null?data.getString("APP_ID"):"" %>"/>
	ȫ��<input id="TEMP_APP_ID_ONE" name="TEMP_APP_ID" disabled="true" type="radio" <%="0".equals(data.getString("APP_ID"))?"checked='checked'":"" %> onclick="addAppIdOfRadio()"/>
	Ӧ��<input id="TEMP_APP_ID_TWO" name="TEMP_APP_ID" disabled="true" type="radio" onclick="addAppId()" <%=!"0".equals(data.getString("APP_ID")) && data.getString("APP_ID")!=null?"checked='checked'":"" %>/>
	<input type="text" name="TEMP_APP_ID_R" id="TEMP_APP_ID_R" disabled="disabled"  onclick="addAppId()" value="<%=data.getString("APP_NAME")!=null?data.getString("APP_NAME"):"" %>"/>
</td>
</tr>

</table>
<table border="0" cellpadding="0" cellspacing="1" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="����" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>