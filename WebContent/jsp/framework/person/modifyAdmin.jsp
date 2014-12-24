<%@page import="com.hx.framework.organ.vo.AdminOrgan"%>
<%@page import="hx.database.databean.DataList"%>
<%@page import="com.hx.framework.role.vo.Role"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.framework.common.*"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data data = ((Data)request.getAttribute("data"));
	//已选组织
	Data organ = ((Data)request.getAttribute("organ"));
	//可管理的所有角色
	DataList roleList = (DataList)request.getAttribute("roleList");
	//已选择的角色
	DataList selectedRoleList = (DataList)request.getAttribute("selectedRoleList");
	
	UserInfo user = SessionInfo.getCurUser();
	String path = request.getContextPath();
%>
<BZ:html>
<BZ:head>
<title>修改管理员</title>
<BZ:script isEdit="true" tree="true"/>
<script>
	function _tijiao(){
		//选中所有资源
		var selectNode = document.getElementById("AdminRole_ROLE_ID");
		for(var i = 0; i < selectNode.options.length; i++){
			selectNode.options[i].selected = true;
		}
		document.srcForm.action=path+"admin/modifyAdmin.action";
 		document.srcForm.submit();
	}
	
	function _back(){
 	document.srcForm.action=path+"admin/adminList.action";
 	document.srcForm.submit();
	}

	 /* 添加选择的项--右移动 */   
	function add(src, dist) {
		if(src.selectedIndex != '-1'){
    	//判断右边是否存在全局
    	if(dist.options.length > 0){
    		for(var i=0;i<dist.options.length;i++){
    			var opt = dist.options[i];
    			if(opt.value == '0'){
    				alert("全局和其他应用不能同时存在!");
    				return;
    			}
    		}
    	}
    	for(var i=0;i<src.options.length;i++){
  			if(src.options[i].selected){
  				var opt = src.options[i];
  				if(dist.options.length > 0){
  					if(opt.value == '0'){
  						alert("全局和其他应用不能同时存在!");
  						break;
  					}
  				}
  				dist.options.add(new Option(opt.text, opt.value));
  				src.remove(i);
  				i=i-1;
  			}
  		}
     }
    }

    /* 添加选择的项----左移动 */   
    function back(src, dist) {
    	for(var i=0;i<src.options.length;i++){
  			if(src.options[i].selected){
  				var opt = src.options[i];
  				dist.options.add(new Option(opt.text, opt.value));
  				src.remove(i);
  				i=i-1;
  			}
  		}
    }
    
    /* 添加全部 */   
    function addAll(src, dist) {   
    	
    	if(dist.options.length > 0){
			if(dist.options[dist.options.length - 1].value == '0'){
				alert("全局和其他应用不能同时存在!");
				dist.remove(dist.options.length - 1);
			}
		}
    	
    	for(var i=0;i<src.options.length;i++){
			var opt = src.options[i];
			dist.options.add(new Option(opt.text, opt.value));
			src.remove(i);
			i=i-1;
  		}
    }
    
  	//数据授权
  	function  _dataAccess(){
  		//组织树
		var selectedids = document.getElementById("PERSON_IDS").value;
		if(selectedids == "undefined"){
			selectedids = "";
		}
		var ids = window.showModalDialog(path+"admin/selectPersons.action?SELECTEDNODES="+selectedids, this, "dialogWidth=500px;dialogHeight=600px;scroll=auto");
		var idsnames = "";
		if(ids != null){
			idsnames = ids.split("!");
			document.getElementById("PERSON_IDS").value = idsnames[0];
			document.getElementById("PERSON_NAMES").value = idsnames[1];
		}
  	}
  	
  	//选择组织机构
	function _selectOrgan(){
		var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=400px;dialogHeight=600px;scroll=auto");
		document.getElementById("ORGAN_ID").value = reValue["value"];
		document.getElementById("ORGAN_NAME").value = reValue["name"];
	}
</script>
</BZ:head>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">

<!-- 管理员ID -->
<BZ:input type="hidden" field="ID" prefix="Admin_" defaultValue=""/>
<div class="kuangjia">
<div class="heading">管理员信息</div>
<table class="contenttable">

<tr>
<td></td>
<td>人员</td>
<td colspan="4">
<BZ:input type="hidden" field="PERSON_ID" prefix="Admin_" defaultValue=""/>
<BZ:dataValue field="PERSON_NAME" defaultValue=""/>
</td>
</tr>

<tr>
<td></td>
<td>管理员类型</td>
<td colspan="4">
	<%
	if(FrameworkConfig.isMultistageAdminMode()){
		//如果分级
		if("0".equals(user.getAdminType())){
	%>
	<BZ:select field="ADMIN_TYPE" prefix="Admin_" formTitle="">
		<BZ:option value="0">超级管理员</BZ:option>
		<BZ:option value="1">系统管理员</BZ:option>
	</BZ:select>
	<%
		}
		if("1".equals(user.getAdminType())){
	%>
	<BZ:select field="ADMIN_TYPE" prefix="Admin_" formTitle="">
		<BZ:option value="1">系统管理员</BZ:option>
	</BZ:select>
	<%
		}
	}
	if(FrameworkConfig.isThreeAdminMode()){
		//系统 管理员不能设置超级管理员
		if("1".equals(user.getAdminType())|| "2".equals(user.getAdminType()) || !FrameworkConfig.isCanModifyAdminRole()){
	%>
	<BZ:select field="ADMIN_TYPE" prefix="Admin_" formTitle="">
		<BZ:option value="1">系统管理员</BZ:option>
		<BZ:option value="2">安全保密管理员</BZ:option>
		<BZ:option value="3">安全审计员</BZ:option>
	</BZ:select>
	<%	
		}else{
	%>
	<BZ:select field="ADMIN_TYPE" prefix="Admin_" formTitle="">
		<BZ:option value="1">系统管理员</BZ:option>
		<BZ:option value="2">安全保密管理员</BZ:option>
		<BZ:option value="3">安全审计员</BZ:option>
	</BZ:select>
	<%			
		}
	}
	%>
</td>
</tr>

<tr>
<td></td>
<td>可管理的组织</td>
<td colspan="4">
	<BZ:input id="ORGAN_ID" field="ORGAN_ID" prefix="AdminOrgan_" defaultValue='<%=organ.getString(AdminOrgan.ORGAN_ID) %>' type="hidden"/>
	<BZ:input id="ORGAN_NAME" prefix="AdminTemp_" field="ORGAN_NAME" defaultValue='<%=organ.getString(AdminOrgan.ORGAN_NAME) %>' readonly="true" onclick="_selectOrgan();"/>
</td>
</tr>
<tr>
<td></td>
<td>可授权的角色</td>
<td width="200px">
	<select id="SOURCE_ROLE_ID" style="width: 200px" name="SOURCE_ROLE_ID" size="14" multiple="multiple">
	<%
	    if(roleList != null && roleList.size() > 0){
	    	for(int i = 0; i < roleList.size(); i++){
	    		Data role = roleList.getData(i);
    %>
    <option value="<%=role.getString(Role.ROLE_ID) %>"><%=role.getString(Role.CNAME) %></option>
    <%
    		}
    	}
    %>
    </select>
</td>
<td valign="middle" width="50px">
	<input type="button" value="&gt;" style="width: 50px" onclick="add(document.getElementById('SOURCE_ROLE_ID'),document.getElementById('AdminRole_ROLE_ID'))" /><br />
	<input type="button" value="&gt;&gt;" style="width: 50px" onclick="addAll(document.getElementById('SOURCE_ROLE_ID'),document.getElementById('AdminRole_ROLE_ID'))" /><br />
	<input type="button" value="&lt;&lt;" style="width: 50px" onclick="addAll(document.getElementById('AdminRole_ROLE_ID'),document.getElementById('SOURCE_ROLE_ID'))" /><br />
    <input type="button" value="&lt;" style="width: 50px" onclick="back(document.getElementById('AdminRole_ROLE_ID'),document.getElementById('SOURCE_ROLE_ID'))" /><br />
</td>
<td>
	<select style="width: 200px" id="AdminRole_ROLE_ID" name="AdminRole_ROLE_ID" size="14" multiple="multiple">
		<%
			if(selectedRoleList != null && selectedRoleList.size() > 0){
				for(int i = 0; i < selectedRoleList.size(); i++){
				    Data selectedRole = (Data)selectedRoleList.getData(i);
				    System.out.println(selectedRole.getString("ROLE_ID"));
		%>
					<option value="<%=selectedRole.getString(Role.ROLE_ID) %>"><%=selectedRole.getString(Role.CNAME) %></option>
		<%
				}
			}
		%>
	</select>
</td>
</tr>
<tr>
<td></td>
<td>说明</td>
<td colspan="4">
	<textarea rows="6" style="width:475px" name="Admin_MEMO"><%=data.getString("MEMO")!=null?data.getString("MEMO"):"" %></textarea>
</td>
</tr>

</table>

<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
<input type="button" value="保存" class="button_add" onclick="_tijiao()"/>&nbsp;&nbsp;
<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>

</div>
</BZ:form>
</BZ:body>
</BZ:html>