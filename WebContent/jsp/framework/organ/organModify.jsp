
<%@page import="com.hx.framework.person.vo.Person"%>
<%@page import="java.util.List"%>
<%@page import="com.hx.framework.sdk.PersonHelper"%>
<%@page import="com.hx.framework.sdk.OrganHelper"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.organ.vo.Organ"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>修改组织机构页面</title>
<BZ:script isEdit="true" isAjax="true"/>
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao(){
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		var ORG_CODE1 = document.getElementById("ORG_CODE1").value;
		var ORG_CODE = document.getElementById("ORG_CODE").value;
		if(ORG_CODE1==""||ORG_CODE1==ORG_CODE){
			document.srcForm.action=path+"organ/Organ!modify.action";
			document.srcForm.submit();
		}
		else{
			var r=executeRequest("com.hx.framework.organ.OrganAjax","ORG_CODE="+ORG_CODE1);
			if(r==1){
				alert("组织编码已存在");
				return;
			}
			else{
				document.srcForm.action=path+"organ/Organ!modify.action";
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
	}
	function _showExtention(){
		var b = document.getElementById('extentionTable').style.display;
		if(b=='none'){
			document.getElementById('extentionTable').style.display = "block";
		}else{
			document.getElementById('extentionTable').style.display = "none";
		}
	}
	function selResp(o){
		var ops = o.options;
		var len = ops.length;
		for(var i=0;i<len;i++){
			if(ops[i].selected){
				var id = ops[i].getAttribute("pid");
				document.srcForm.Organ_RESP_PERSON.value=id;
			}
		}
	}
	//选择组织机构
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
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<div class="heading">基本信息</div>
<!-- 当前修改的组织机构ID -->
<BZ:input field="ID" type="hidden" prefix="Organ_" defaultValue=""/>
<BZ:input field="ORG_LEVEL_CODE" prefix="Organ_" type="hidden" defaultValue=""/>
<!-- 父组织机构ID -->
<input id="PARENT_ID" name="PARENT_ID" type="hidden" value="<%=request.getAttribute(Organ.PARENT_ID) %>"/>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="10%">组织名称</td>
<td width="20%"><BZ:input field="CNAME" prefix="Organ_" notnull="请输入组织名称" formTitle="组织名称" type="String" defaultValue=""/></td>
<td width="10%">组织简称</td>
<td width="20%"><BZ:input field="SHORT_CNAME" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">组织类型</td>
<td width="20%"><BZ:select field="ORG_TYPE" prefix="Organ_" formTitle="" codeName="organTypeList" isCode="true" property="data"/></td>
<td width="10%">门牌号</td>
<td width="20%"><BZ:input field="ORG_DOOR_NUM" prefix="Organ_" type="String" defaultValue="" /></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">负责人</td>
<td width="20%">

<select name="Organ_RESP_PERSON" >
	<option value="">未设置</option>
	<%
	Data d = (Data)request.getAttribute("data");
	if (d!=null){
		String orgId = d.getString("ID");
		String pId = d.getString("RESP_PERSON","");
		if (orgId!=null){
			List<Person> pers = PersonHelper.getPersonsOfOrganAll(orgId);
			if (pers!=null){
				for(int i=0;i<pers.size();i++){
					Person person = pers.get(i);
					String name = person.getcName();
					String id = person.getPersonId();
					%>
					<option value="<%=id %>" <%if (pId.equals(id)){%> selected<%} %> ><%=name%></option>
					<%
				}
			}
		}
	}
	%>
</select>

</td>
<td width="10%">联系电话</td>
<td width="20%"><BZ:input field="ORG_PHONE" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">排序号</td>
<td width="20%"><BZ:input field="SEQ_NUM" notnull="请输入排序号" formTitle="排序号" restriction="int" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="10%">所属地区</td>
<td width="20%"><BZ:input field="AREA_CODE" prefix="Organ_" helperCode="SYS_AREA_CODE" type="helper" helperTitle="选择地区" treeType="0" helperSync="false" showParent="false" style="width:100px;"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">说明</td>
<td width="85%" colspan="4"><BZ:input field="MEMO" prefix="Organ_" type="String" defaultValue=""  style="width: 50%"/></td>
</tr>
</table>
<div class="heading" style="cursor: hand;" id="extentionDiv" onclick="_showExtention();">扩展信息(点击查看更多)</div>
<!-- 当前修改的组织机构ID -->
<table class="contenttable" id="extentionTable" style="display: none">

<tr>
<td width="5%"></td>
<td width="10%">英文名称</td>
<td width="20%"><BZ:input field="ENNAME" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="10%">组织编码</td>
<BZ:input id="ORG_CODE" field="ORG_CODE" type="hidden" prefix="OrganOld_" defaultValue=""/>
<td width="20%"><BZ:input id="ORG_CODE1" field="ORG_CODE" prefix="Organ_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">行政级别</td>
<td width="20%"><BZ:select field="ORG_GRADE" formTitle="" prefix="Organ_" codeName="ORG_GRADE" isCode="true"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">联系人</td>
<td width="85%" colspan="4"><BZ:input field="LINK_MAN" prefix="Organ_" type="String" defaultValue="" /></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">联系地址</td>
<td width="85%" colspan="4"><BZ:input field="ORG_ADDR" prefix="Organ_" type="String" defaultValue=""  style="width: 50%"/></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">Email</td>
<td width="85%" colspan="4"><BZ:input field="ORG_EMAIL" prefix="Organ_" type="String" defaultValue=""/></td>
</tr>
<!-- 扩展属性显示区域 begin -->
<BZ:propExtend propType="0" data="extendPropsMap"/>
<!-- 扩展属性显示区域 end -->
</table>
<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>