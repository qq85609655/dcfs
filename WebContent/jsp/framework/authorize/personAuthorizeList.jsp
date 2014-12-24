
<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
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

//检查权限标识
String checkAudit = (String)request.getAttribute("CHECK_AUDIT");
//搜索条件
Data sdata = (Data)request.getAttribute("data");
if(sdata == null){
	sdata = new Data();
}
%>
<BZ:html>
<BZ:head>
<title>列表</title>
<BZ:script isList="true"/>
	<script type="text/javascript">
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function _onload(){

	}
	function search(){
		document.srcForm.action=path+"person/Person!queryChildren.action";
		document.srcForm.submit();
	}

	function allotAudit(){
	var sfdj=0;
	var uuid="";
	for(var i=0;i<document.getElementsByName('xuanze').length;i++){
	if(document.getElementsByName('xuanze')[i].checked){
	uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
	sfdj++;
	}
	}
	if(sfdj=="0"){
	alert('请选择要授权的人');
	return;
	}else{
	parent.left1Frame._ok();
	var roleValue=parent.left1Frame.document.getElementById("ROLE_IDS").value;
	if(roleValue==null||roleValue==""){
		return;
	}else{
		if(confirm('确认要授权吗?')){
		//调用角色树
		document.getElementById("ROLES_IDS").value = roleValue;
		document.getElementById("PERSONS_IDS").value = uuid;
		document.srcForm.action = "<%=request.getContextPath() %>/role/Authorize!personAuthorize.action";
			document.srcForm.submit();
		}else{
			return;
		}
	}
	}
}

	//查看组织机构对应的角色权限
	function queryAudit(){
			var sfdj=0;
			var ID="";
			for(var i=0;i<document.getElementsByName('xuanze').length;i++){
			if(document.getElementsByName('xuanze')[i].checked){
			ID=document.getElementsByName('xuanze')[i].value;
			sfdj++;
			}
			}
			if(sfdj!="1"){
			alert('请选择一条数据');
			return;
			}else{
				var flag = window.showModalDialog("<%=request.getContextPath() %>/role/Authorize!queryRoleOfPerson.action?PERSON_IDS="+ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=auto");
				if(flag == "true"){
					document.srcForm.submit();
				}
			}
			}
	//查看人员对应的角色权限
	function querySingleAudit(ID){
				var flag = window.showModalDialog("<%=request.getContextPath() %>/role/Authorize!queryRoleOfPerson.action?PERSON_IDS="+ID, this, "dialogWidth=600px;dialogHeight=350px;scroll=auto");
				if(flag == "true"){
					document.srcForm.submit();
				}
	}
	//查询所有没有分配角色的用户
	function checkAudit(){
		document.srcForm.action = "<%=request.getContextPath() %>/person/Person!queryNoRolesPersons.action";
		document.getElementById("CHECK_AUDIT").value = "CHECK_AUDIT";
		document.srcForm.submit();
	}

	function exportExcel(){
		if(confirm('确认要导出为Excel文件吗?')){
			document.srcForm.action = "<%=request.getContextPath() %>/role/exportpersonRoleExcel.action";
			document.srcForm.submit();
		}
	}

	//选择组织机构
	function selectOrgan(){
		var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=300px;dialogHeight=300px;scroll=auto");
		document.getElementById("ORGAN_ID_").value = reValue["value"];
		document.getElementById("ORGAN_NAME_").value = reValue["name"];
		if(reValue["value"] == ""){
			document.getElementById("ORG_ID").value = "0";
		}
	}
	</script>
</BZ:head>
<BZ:body onload="_onload()" codeNames="SEX">
<BZ:form name="srcForm" method="post" isContextPath="true" action='<%="CHECK_AUDIT".equals(checkAudit)?"person/Person!queryNoRolesPersons.action":"person/Person!queryChildren.action" %>'>

<!-- 检查权限标示 -->
<input id="CHECK_AUDIT" name="CHECK_AUDIT" value='<%=checkAudit %>' type="hidden"/>

<!-- 角色树 -->
<input name="ROLES_IDS" id="ROLES_IDS" type="hidden"/>
<!-- 授权人员 -->
<input name="PERSONS_IDS" id="PERSONS_IDS" type="hidden"/>

<div class="kuangjia">

<!-- 查询条件 -->
<div class="heading">查询条件</div>
<div  class="chaxun">
	<table class="chaxuntj">
		<tr>

			<td width="10%" align="right" nowrap="nowrap" >人员姓名：</td>
			<td width="20%" align="left"><input name="S_PERSON_NAME_" type="text" value='<%=sdata.getString("PERSON_NAME_")!=null?sdata.getString("PERSON_NAME_"):"" %>'  /></td>
			<td width="10%" align="right" nowrap="nowrap" ></td>
			<td width="20%" align="left" ></td>
			<td width="10%">
				<input type="button" value="查询" class="button_search" onclick="search()"/>&nbsp;&nbsp;
			</td>
			<td width="10%" align="right" nowrap="nowrap"></td>
			<td width="20%" align="left">
				<input type="hidden" id="ORGAN_ID_" name="S_ORGAN_ID_" value='<%=sdata.getString("ORGAN_ID_")!=null?sdata.getString("ORGAN_ID_"):"" %>'/>
				<input type="hidden" id="ORGAN_NAME_" name="S_ORGAN_NAME_" value='<%=sdata.getString("ORGAN_NAME_")!=null?sdata.getString("ORGAN_NAME_"):"" %>' readonly="readonly" />
			</td>
		</tr>
	</table>
</div>


<input id="Person_IDS" name="IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 当前人员列表所属的组织机构ID -->
<input id="ORG_ID" name="ORG_ID" value="<%=request.getParameter(OrganPerson.ORG_ID) %>" type="hidden">
<div class="list">
<div class="heading">选择人员</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="12%" sortplan="jsp"/>
<BZ:th name="姓名" sortType="string" width="18%" sortplan="database" sortfield="CNAME"/>
<BZ:th name="所属机构" sortType="string" width="30%" sortplan="database" sortfield="ORG_NAME"/>
<BZ:th name="权限" sortType="none" width="40%" sortplan="" sortfield="" />
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="Person_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><a href="javascript:void(0)" onclick="querySingleAudit('<BZ:data field="Person_ID" onlyValue="true"/>')"><BZ:data field="CNAME" defaultValue=""/></a></td>
<td><BZ:data field="ORG_NAME" onlyValue="true"/></td>
<td><BZ:data field="ROLE_CNAME" onlyValue="true"/></td>
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
<td align="right" style="padding-right:5xpx;height:35px;">
	<input type="button" value="检查权限" class="button_add" style="width: 80px" onclick="checkAudit()"/>
	&nbsp;&nbsp;<input type="button" value="分配权限" class="button_add" style="width: 80px" onclick="allotAudit()"/>
	&nbsp;&nbsp;<input type="button" value="查看权限" class="button_add" style="width: 80px" onclick="queryAudit()"/>
	<input type="button" value="导出" class="button_add" style="width: 80px" onclick="exportExcel()"/>
</td>
</tr>
</table>
</div>
</div>
</BZ:form>
</BZ:body>
</BZ:html>