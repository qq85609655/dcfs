
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.role.vo.RoleGroup"%>
<%@page import="com.hx.framework.role.vo.Role"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data data = (Data)request.getAttribute("data");
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);
%>

<BZ:html>
<BZ:head>
<title>修改页面</title>
<BZ:script isEdit="true" isDate="true" isList="true" tree="true"/>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao()
	{
		if (tree.useCheckbox) {
			var nodes = tree.nodes;
			var sel = false;
			var isSelect=false;
			for ( var i in nodes) {
				if (nodes[i].checked) {
					sel = true;
					break;
				}
			}
			if(tree.onlyCheckChild){
				if (!sel && isSelect){
					alert("您只能选择叶子节点，在选择的节点中不包含叶子节点，请重新选择。");
					return;
				}
			}
			if (!sel) {
				alert("请选择内容。");
				return;
			}
		} else {
			if(tree.onlyCheckChild){
				var node = tree.selectedNode;
				if(node.hasChild){
					alert("只能选择叶子节点，请重新选择。");
					return;
				}
			}
			if (tree.selectedNode.id == null) {
				alert("请选择内容。");
				return;
			}
		}
		var reValue = null;
		if (tree.useCheckbox && !tree.onlySelectSelf) {
			reValue = getSelectValue(tree, isShowParent, true);
		} else {
			reValue = getSelectValue(tree, isShowParent, false);
		}
		if(!runFormVerify(document.srcForm,false)){
			return;
			}
		window.returnValue=reValue;
		var name="";
		var value="";
		var appIds="";
		var sfdj=0;
		for(var i=0 ;i<reValue.length;i++){
			appIds=appIds + reValue[i]["value"]+"#";
			sfdj++;
		}
		if(sfdj=="0"){
				//alert('请选择要分配的数据');
				if(!confirm('确定清空角色的所有资源吗?')){
					return;
				}
		}else{
			if(!confirm('确认要分配吗?')){
				return;
			}
		}
		document.getElementById("APP_IDS").value=appIds;
	document.srcForm.action=path+"role/Role!modify.action";
		document.srcForm.submit();
	}
	function _back(){
	document.srcForm.action=path+"role/Role!queryChildren.action";
	document.srcForm.submit();
	}

	//选择组织机构
	function selectOrgs(){
		var reValue = window.showModalDialog("role/Role!selectOrg.action", this, "dialogWidth=300px;dialogHeight=300px;scroll=auto");
		document.getElementById("Role_ORGAN_ID").value = reValue["value"];
		document.getElementById("TEMP_ORGAN_ID").value = reValue["name"];
	}

	function addAppIdOfRadio(){

		document.getElementById("Role_APP_ID").value = '0';
		document.getElementById("TEMP_APP_ID_R").value = "";
	}

	function addAppId(){


		document.getElementById("TEMP_APP_ID_TWO").checked = 'checked';
		var reValue = window.showModalDialog("role/Role!selectResource.action", this, "dialogWidth=300px;dialogHeight=250px;scroll=auto");
		if(reValue != null){
			document.getElementById("Role_APP_ID").value = reValue["value"];
			document.getElementById("TEMP_APP_ID_R").value = reValue["name"];
		}else{
			document.getElementById("TEMP_APP_ID_ONE").checked = 'checked';
			document.getElementById("Role_APP_ID").value = '0';
			document.getElementById("TEMP_APP_ID_R").value = "";
		}
	}

	function L(id,selNode){
		reValue = new Array();
		if(!selNode || selNode=="false"){
			isSelNode=false;
		}
		//处理
	}

	var isShowParentString = "<BZ:attribute key="showParent" defaultValue="false"/>";
	var isShowParent = false;
	if ("true" == isShowParentString) {
		isShowParent = true;
	}
	function _ok(){
		if (tree.useCheckbox) {
			var nodes = tree.nodes;
			var sel = false;
			var isSelect=false;
			for ( var i in nodes) {
				if (nodes[i].checked) {
					sel = true;
					break;
				}
			}
			if(tree.onlyCheckChild){
				if (!sel && isSelect){
					alert("您只能选择叶子节点，在选择的节点中不包含叶子节点，请重新选择。");
					return;
				}
			}
			if (!sel) {
				alert("请选择内容。");
				return;
			}
		} else {
			if(tree.onlyCheckChild){
				var node = tree.selectedNode;
				if(node.hasChild){
					alert("只能选择叶子节点，请重新选择。");
					return;
				}
			}
			if (tree.selectedNode.id == null) {
				alert("请选择内容。");
				return;
			}
		}
		var reValue = null;
		if (tree.useCheckbox && !tree.onlySelectSelf) {
			reValue = getSelectValue(tree, isShowParent, true);
		} else {
			reValue = getSelectValue(tree, isShowParent, false);
		}
		window.returnValue=reValue;
		var name="";
		var value="";
		var appIds="";
		var sfdj=0;
		for(var i=0 ;i<reValue.length;i++){
			appIds=appIds + reValue[i]["value"]+"#";
			sfdj++;
		}

		if(sfdj=="0"){
				//alert('请选择要分配的数据');
				if(!confirm('确定清空角色的所有资源吗?')){
					return;
				}
		}else{
			if(!confirm('确认要分配吗?')){
				return;
			}
		}
		document.getElementById("APP_IDS").value=appIds;
			document.srcForm.action=path+"role/Role!allotResource.action";
			document.srcForm.submit();
	}

	function _back(){
		document.srcForm.action=path+"role/Role!queryChildren.action?PARENT_ID=0";
		document.srcForm.submit();
	}
	function _onload1(){
		try{
			tree.expandAll();
		}catch(e){}
	}

</script>
</BZ:head>
<BZ:body property="data" onload="_onload1();">
<BZ:form name="srcForm" method="post">
<BZ:frameDiv  property="clueTo" className="kuangjia">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td valign="top" style="background-color:#e9f2fd;width:60%">
			<div  >
<!-- 角色组ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(RoleGroup.PARENT_ID) %>"/>
<div class="heading">修改角色</div>
<table class="contenttable">

<tr>
<td></td>
<td>角色ID</td>
<td colspan="4"><input name="Role_ROLE_ID" restriction="wordchar" value="<%=data.getString("ROLE_ID")!=null?data.getString("ROLE_ID"):"" %>" type="text" <%=data.getString("ROLE_ID")!=null?"readonly='readonly'":"" %>/></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">角色类型</td>
<td width="20%">
	<%
		//系统管理员和超级管理员才能设置管理员
		if("0".equals(user.getAdminType())|| "2".equals(user.getAdminType()) || "1".equals(user.getAdminType())){
	%>
	<BZ:select field="ROLE_TYPE" formTitle="" prefix="Role_">
		<BZ:option value="1">管理员角色</BZ:option>
		<BZ:option value="2" selected="true">普通角色</BZ:option>
	</BZ:select>
	<%
		}else{
	%>
	<BZ:select field="ROLE_TYPE" formTitle="" prefix="Role_">
		<BZ:option value="2" selected="true">普通角色</BZ:option>
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
<td width="2%"></td>
<td width="18%">下级组织是否可授权</td>
<td width="18%">
	<BZ:select field="IS_ORGAN_INHERIT" formTitle="" prefix="Role_">
		<BZ:option value="1" selected="true">是</BZ:option>
		<BZ:option value="0">否</BZ:option>
	</BZ:select>
</td>
<td width="10%">排序号</td>
<td width="20%"><BZ:input field="SEQ_NUM" formTitle="排序号" prefix="Role_" notnull="请输入排序号" restriction="int" type="String" defaultValue=""/></td>
<td width="2%"></td>
</tr>

<tr>
<td></td>
<td>角色说明</td>
<td colspan="4"><textarea rows="6" style="width:80%" name="Role_MEMO"><%=data.getString("MEMO")!=null?data.getString("MEMO"):"" %></textarea></td>
</tr>

<!--
<tr style="display:none">
<td></td>
<td>所属组织</td>
<td colspan="4">
<BZ:input  id="Role_ORGAN_ID" prefix="Role_" field="ORGAN_ID" type="helper" helperCode="SYS_ORGAN" helperTitle="选择部门" saveShowField="false" showParent="false" showField="ORGAN_SHOW" treeType="0" notnull="请选择部门"/>
</td>
</tr>

<tr style="display:none">
<td></td>
<td>所属应用</td>
<td colspan="4">

	<input type="hidden" name="Role_APP_ID" id="Role_APP_ID"  value="<%=data.getString("APP_ID")!=null?data.getString("APP_ID"):"" %>"/>
	全局<input id="TEMP_APP_ID_ONE" name="TEMP_APP_ID" type="radio" <%="0".equals(data.getString("APP_ID"))?"checked='checked'":"" %> onclick="addAppIdOfRadio()"/>
	应用<input id="TEMP_APP_ID_TWO" name="TEMP_APP_ID" type="radio" onclick="addAppId()" <%=!"0".equals(data.getString("APP_ID")) && data.getString("APP_ID")!=null?"checked='checked'":"" %>/>
	<input type="text" name="TEMP_APP_ID_R" id="TEMP_APP_ID_R" readonly="readonly" onclick="addAppId()" value="<%=data.getString("APP_NAME")!=null?data.getString("APP_NAME"):"" %>"/>
</td>
</tr>
-->
</table>

</div>
		</td>
		<td valign="top" width="40%" style="background-color:#e9f2fd;">

			<div style="height:310px;overflow-y:scroll; " >

		<!-- 选中的应用、模块、资源树中的节点要提交的ID -->
		<input id="APP_IDS" name="APP_IDS" type="hidden"/>


		<div class="heading" >选择要分配的模块与资源</div>
		<!-- 应用树 -->
		<table width="95%">
			<tr>
				<td><BZ:tree property="dataList2" type="1" selectvalue="ownResource"/></td>
			</tr>
		</table>

		</div>
		</td>
	</tr>
	<tr>
	<td colspan="2">
<table border="0" cellpadding="0" cellspacing="1" class="operation" width="900px">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</td>
	</tr>
</table>


</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>