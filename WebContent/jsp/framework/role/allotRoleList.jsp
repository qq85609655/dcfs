
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
String compositor=(String)request.getAttribute("compositor");
if(compositor==null){
	compositor="";
}
String ordertype=(String)request.getAttribute("ordertype");
if(ordertype==null){
	ordertype="";
}
%>
<BZ:html>
<BZ:head>
<base target="_self"/>
<title>列表</title>
<BZ:script isList="true"/>
	<script type="text/javascript">
	function _onload(){

	}
	function search(){
	document.srcForm.action=path+"";
	document.srcForm.submit();
	}

	//分配角色给角色组
	function allotRole(){

		var sfdj=0;
		var uuid="";
		for(var i=0;i<document.getElementsByName('xuanze').length;i++){
		if(document.getElementsByName('xuanze')[i].checked){
		uuid=uuid+document.getElementsByName('xuanze')[i].value+"#";
		sfdj++;
		}
		}
		if(sfdj=="0"){
		alert('请选择要分配的角色');
		return;
		}else{
		if(confirm('确认要分配角色吗?')){
		document.getElementById("RoleGroupRela_IDS").value=uuid;
		document.srcForm.action=path+"role/RoleGroup!allotRole.action";
		document.srcForm.submit();
		window.close();
		}else{
		return;
		}
		}
	}

	</script>
</BZ:head>
<BZ:body onload="_onload()">
<BZ:form name="srcForm" method="post" action="role/RoleGroup!queryNoRoles.action">
<BZ:frameDiv property="clueTo" className="kuangjia">
<div class="kuangjia">
<input id="RoleGroupRela_IDS" name="RoleGroupRela_IDS" type="hidden"/>
<!--用来存放数据库排序标示(不存在数据库排序可以不加)-->
<input type="hidden" name="compositor" value="<%=compositor%>"/>
<input type="hidden" name="ordertype" value="<%=ordertype%>"/>
<!-- 角色组ID：为翻页时传参数准备 -->
<input name="ID" id="ID" type="hidden" value="<%=request.getAttribute("ID")!=null?request.getAttribute("ID"):"" %>"/>
<!-- 角色组ID -->
<input name="RoleGroupRela_GROUP_ID" id="GROUP_ID" type="hidden" value="<%=request.getAttribute("ID")!=null?request.getAttribute("ID"):"" %>"/>
<!-- 角色组父ID -->
<input name="PARENT_ID" type="hidden" value="<%=request.getAttribute("PARENT_ID")!=null?request.getAttribute("PARENT_ID"):"" %>"/>
<div class="list">
<div class="heading">角色列表</div>
<BZ:table tableid="tableGrid" tableclass="tableGrid">
<BZ:thead theadclass="titleBackGrey">
<BZ:th name="序号" sortType="none" width="35%" sortplan="jsp"/>
<BZ:th name="角色名称" sortType="string" width="65%" sortplan="database" sortfield="CNAME"/>
</BZ:thead>
<BZ:tbody>
<BZ:for property="dataList" >
<tr>
<td tdvalue="<BZ:data field="ROLE_ID" onlyValue="true"/>"><BZ:i></BZ:i></td>
<td><BZ:data field="CNAME" onlyValue="true"/></td>
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
<td align="right" style="padding-right:30px;height:35px;"><input type="button" value="确定" class="button_add" onclick="allotRole()"/>&nbsp;&nbsp;<input type="button" value="关闭" class="button_back" onclick="window.close();"/>
</td>
</tr>
</table>
</div>
</div>
</BZ:frameDiv>
</BZ:form>
</BZ:body>
</BZ:html>