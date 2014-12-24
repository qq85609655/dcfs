<%@page import="com.hx.framework.organ.vo.OrganPerson"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="hx.database.databean.Data"%>
<%@ page language="java" contentType="text/html; charset=GBK"
		pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<BZ:html>
<BZ:head>
<title>添加人员页面</title>
<BZ:script isEdit="true" isDate="true" />
<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	function tijiao()
	{
		if (!runFormVerify(document.srcForm, false)) {
			return;
		}
		var t=document.getElementsByName("mInput");
		var ss="";
		for(var i=0;i<t.length;i++){
			if(t[i].value.trim()!=""){
				if(ss!=""){
					ss=ss+",";
				}
				ss=ss+t[i].value.trim();
			}
		}
		document.getElementById("mInput_all").value=ss;

		if(document.all("Person_CNAME").value==''){
			alert("请输入人员姓名！");
			document.all("Person_CNAME").focus();
			return;
		}
		if(document.all("Person_SEQ_NUM").value==''){
			alert("请输入排序号！");
			document.all("Person_SEQ_NUM").focus();
			return;
		}
		if(document.all("Person_EMAIL").value!=''){
			var b = verfiyEmail();
			if(!b){
				alert("邮箱输入格式不正确！");
				return ;
				document.all("Person_EMAIL").focus();
			}
		}
		//String str=srcForm.MOBILE1.value+srcForm.MOBILE1.value+srcForm.MOBILE1.value;
		document.srcForm.action=path+"person/Person!add.action";
		document.srcForm.submit();

	}
	function _back(){
		document.srcForm.action=path+"person/Person!query.action";
		document.srcForm.submit();
	}

	function showDeptTree(fname){
		var selectValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrgMulti", this, "dialogWidth=480px;dialogHeight=640px;scroll=auto");
		if(selectValue) {
			var ids="",names="";
					for(var i=0 ;i<selectValue.length;i++){
						if(ids!=""){
							ids+=",";
							names+=",";
						}
						ids=ids + selectValue[i]["value"];
						names=names + selectValue[i]["name"];
			}

				document.getElementById(fname).value=ids;
				document.getElementById("dis_"+fname).value=names;
		}

	}

	function _showExtention(){
		var b = document.getElementById('extentionTable').style.display;
		if(b=='none'){
			document.getElementById('extentionTable').style.display = "block";
		}else{
			document.getElementById('extentionTable').style.display = "none";
		}
	}

	// 验证邮箱
	function verfiyEmail(){
		var strEmail = document.getElementById("Person_EMAIL").value;
		var reg = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
		var email_Flag = reg.test(strEmail);
		if(email_Flag)
			return true;
		else
			return false;
	}
	//添加移动电话输入行
function _addRow(){
		//alert(111);
		var mynewrow=mtable.insertRow();
			col1=mynewrow.insertCell(0);
			col1.style.paddingLeft="0px";
			col2=mynewrow.insertCell(1);

			col1.innerHTML="<input type='text' class='inputText'  name='mInput' formTitle='移动电话'  restriction='mobile' onkeyup='_check_one(this);'></input>";
			col2.innerHTML="<img  onclick='_delRow(this)' src='<BZ:resourcePath />/images/delete.png'></img>";
	}
	//删除移动电话输入行
	function _delRow(obj){
		var tr=obj.parentNode.parentNode;
		var tbl=tr.parentNode;
		tbl.removeChild(tr);
	}
	//选择组织机构
	function _selectOrgan(){
		var reValue = modalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, 400,600);
		if(reValue){
			document.getElementById("ORGAN_ID").value = reValue["value"];
			document.getElementById("ORGAN_NAME").value = reValue["name"];
		}
	}
/**
 * 显示助手
 * @param obj 要显示内容的对象
 * @param id 要存储值的id
 * @param title 助手的标题
 * @param code 代码 详见helperCode.properties
 * @param showParent 是否显示全内容
 * @param params 扩展参数
 * @param type 树的类型 0-单选，1-多选
 * @param sync 树的加载形式 true-一次性加载，false-异步加载
 */
function _showHelper(id0,id,title,code,showParent,params,type,sync){
	var obj = document.getElementById(id0);
	var _v = document.getElementById(id);
	var values = _v.value;

	var url = path + "treeServlet?";//显示助手的入口改为treeServlet by 马志慧 at 20121207
	if("true"!=showParent){
		showParent="false";
	}
	var selValues = new Array();
		selValues[0]=values;
	var p = "code=" + code + "&value=" +values+ "&title=" + title + "&parent=" + showParent + "&param=" + params + "&type=" + type + "&sync=" + sync;
	var reValue = modalDialog(url + p, selValues, 450, 500);

	if (reValue!=null){
		if(type=="0" || type=="-1"){
			obj.value=reValue["name"];
			if(reValue["name"]!=""){

				obj.title="双击此处清除选择内容：" + reValue["name"];
			}else{
				obj.title=reValue["name"];
			}
			_v.value=reValue["value"];
		}else{
			var n="";
			var v="";
			var len = reValue.length;
			var selectComp = document.getElementById("MAIN_ORG");
			if(selectComp){
				selectComp.innerHTML='';
			}
			for(var i=0;i<len;i++){
				if(n!=""){
					n+=",";
					v+=",";
				}
				n+=reValue[i]["name"];
				v+=reValue[i]["value"];
				if(selectComp){
					var option=new Option(reValue[i]["name"],reValue[i]["value"]);
					selectComp.add(option);
				}
			}
			obj.value=n;
			if(n!=""){
				obj.title="双击此处清除选择内容：" + n;
			}else{
				obj.title=n;
			}
			_v.value=v;
		}
	}
	try {
		_selectTree(id0,id,title,code,showParent,params,type);
	} catch (e) {
	}
}
/**
 * 清除数据
 * @param id0
 * @param id
 * @returns
 */
function _clearHelperValue(id0,id){
	var obj= document.getElementById(id0);
	var _v = document.getElementById(id);
	obj.value="";
	obj.title="";
	_v.value="";
	var obj= document.getElementById("MAIN_ORG");
	if(obj){
		obj.innerHTML="";
	}
}
</script>
<style>
	img{vertical-align:middle}
</style>
</BZ:head>
<BZ:body property="data" codeNames="POLITIC_CODE;MARRY_CODE;EDU_CODE;COUNTRY;CARD_CODE;DEGREE_CODE;PROVINCE;NATION;CITY;SEX;SECURITY_LEVEL_P">
<BZ:form name="srcForm" method="post">
<div class="kuangjia">
<!-- 人员所属组织机构 -->
<input name="OrganPerson_ORG_ID" type="hidden" value="<%=request.getAttribute(OrganPerson.ORG_ID)==null?request.getParameter("S_ORG_ID"):request.getAttribute(OrganPerson.ORG_ID) %>"/>
<input name="S_CNAME" type="hidden" value='<%=request.getParameter("S_CNAME") %>'>

<input name="S_ORG_ID" type="hidden" value='<%=request.getParameter("S_ORG_ID") %>'>
<input name="S_ACCOUNT_ID" type="hidden" value='<%=request.getParameter("S_ACCOUNT_ID") %>'>
<input name="S_STATUS" type="hidden" value='<%=request.getParameter("S_STATUS") %>'>
<input name="ldap" type="hidden" value='<%=request.getParameter("ldap") %>'>
<input name="ldapAccId" type="hidden" value='<%=request.getAttribute("ldapAccId")==null?"":request.getAttribute("ldapAccId") %>'>
<div class="heading">基本信息</div>
<table class="contenttable">

<tr style="display: none">
<td width="5%"></td>
<td width="10%">姓</td>
<td width="20%"><BZ:input field="FIRST_NAME" prefix="Person_" type="String" defaultValue=""/></td>
<td width="10%">名</td>
<td width="20%"><BZ:input field="LAST_NAME" prefix="Person_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">姓名</td>
<td width="20%"><BZ:input field="CNAME" prefix="Person_" type="String" notnull="请输入姓名" formTitle="姓名" defaultValue="" /></td>
<td width="10%">性别</td>
<td width="20%"><BZ:select field="SEX" prefix="Person_" formTitle="" isCode="true" codeName="SEX"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">排序号</td>
<td width="20%"><BZ:input field="SEQ_NUM" prefix="Person_" type="String" notnull="请输入排序号" formTitle="排序号" restriction="int" defaultValue="1000"/></td>
<td width="10%">办公电话</td>
<td width="20%"><BZ:input field="OFFICE_TEL" prefix="Person_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">Email</td>
<td width="20%"><BZ:input field="EMAIL" prefix="Person_" type="String" defaultValue=""/></td>
<td width="10%">现任职务</td>
<td width="20%"><BZ:select field="POST" formTitle="" prefix="OrganPerson_" isCode="true" codeName="positionList" property="data"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td>是否重点联系人</td>
<td>
		<BZ:select field="IS_IMP_CONTACT" formTitle="" prefix="PersonExt_"  >
			<BZ:option value="0" >否</BZ:option>
			<BZ:option value="1">是</BZ:option>
		</BZ:select>
	</td>
<td width="10%">人员涉密情况</td>
<td width="20%">
	<BZ:select field="SECURITY_LEVEL" formTitle="" prefix="Person_" isCode="true" codeName="SECURITY_LEVEL_P"/>
</td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">办公室房间号</td>
<td width="20%"><BZ:input field="ROOM_NUM" prefix="Person_" type="String" defaultValue=""/></td>
<td width="10%">移动电话</td>
<td width="20%" align="left" >
	<table id="mtable" width="90%"  cellspacing="0" >
		<tr id="tr1" >
			<td style="padding-left: 0px"><input type="text" class="inputText" name="mInput" formTitle="移动电话"  restriction="mobile" onkeyup="_check_one(this);"  value=""  ></input> </td>
			<td ><img onclick="_addRow()" src="<BZ:resourcePath />/images/add.png"></img></td>
		</tr>
	</table>
<BZ:input id="mInput_all" type="hidden"  field="MOBILE" prefix="Person_"/></td>
<td width="5%"></td>
</tr>
<tr>
<td width="5%"></td>
<td width="10%">所属组织</td>
<td width="20%"><BZ:input field="ORG_LIST_ID" prefix="P_" helperCode="SYS_ORGAN" type="helper" helperTitle="选择所属组织" treeType="2" helperSync="true" property="organPerson" showParent="false" style="width:100px;"/></td>
<td width="10%">主要组织</td>
<td width="20%"><BZ:select field="MAIN_ORG" id="MAIN_ORG" prefix="P_" formTitle="主要组织" notnull="请选择主要组织">
<%
		Map orgMap = (Map)request.getAttribute("orgMap");
		Data orgPerson = (Data)request.getAttribute("organPerson");
		Iterator ite = orgMap.keySet().iterator();
		while(ite.hasNext()){
			String orgId = (String)ite.next();
			String orgName = (String)orgMap.get(orgId);
			%>
			<option value="<%=orgId %>" <%if(orgId.equals(orgPerson.getString("MAIN_ORG"))){%>selected<%}%>><%=orgName %></option>
			<%
		}
	%>
</BZ:select></td>
<td width="5%"></td>
</tr>
<tr>
	<td></td>
	<td>备注</td>
	<td colspan="4"><textarea rows="6" style="width:100%" name="PersonExt_OTHER_INFO"></textarea></td>
</tr>

</table>


<div class="heading" style="cursor: hand;" id="extentionDiv" onclick="_showExtention();">扩展信息(点击显示更多)</div>
<table class="contenttable" id="extentionTable" style="display: none">

<tr>
<td width="5%"></td>
<td width="10%">职级</td>
<td width="20%"><BZ:select field="POST_LEVEL" formTitle="" prefix="Person_" isCode="true" codeName="positionLevelList" property="data"/></td>
<td width="10%"></td>
<td width="20%"></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">别名(英文)</td>
<td width="20%"><BZ:input field="ENNAME" prefix="Person_" type="String" defaultValue=""/></td>
<td width="10%">婚姻状况</td>
<td width="20%"><BZ:select field="MARRY_CODE" prefix="Person_" formTitle="" isCode="true" codeName="MARRY_CODE"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">籍贯</td>
<td width="85%" colspan="4"><input name="Person_NATIVE_PlACE" type="text" style="width: 60%"/></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">出生</td>
<td width="20%"><BZ:input field="BIRTHDAY" prefix="Person_" type="date" readonly="readonly"/></td>
<td width="10%">人员编号</td>
<td width="20%"><BZ:input field="PERSON_CODE" prefix="Person_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">证件类型</td>
<td width="20%"><BZ:select field="CARD_CODE" prefix="Person_" formTitle="" isCode="true" codeName="CARD_CODE"/></td>
<td width="10%">证件号码</td>
<td width="20%"><BZ:input field="CARD_NUM" prefix="Person_" formTitle="" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">民族</td>
<td width="20%"><BZ:select field="NATION" prefix="Person_" formTitle="" isCode="true" codeName="NATION"/></td>
<td width="10%">政治面貌</td>
<td width="20%"><BZ:select field="POLITIC_CODE" prefix="Person_" formTitle="" isCode="true" codeName="POLITIC_CODE"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">最高学历</td>
<td width="20%"><BZ:select field="EDU_CODE" prefix="PersonExt_" formTitle="" isCode="true" codeName="EDU_CODE"/></td>
<td width="10%">最高学位</td>
<td width="20%"><BZ:select field="DEGREE_CODE" prefix="PersonExt_" formTitle="" isCode="true" codeName="DEGREE_CODE"/></td>
<td width="5%"></td>
</tr>

<tr style="display:none">
<td width="5%"></td>
<td width="10%">个人签名</td>
<td width="20%" colspan="3" ><input type="file" name="PersonExt_SIGNATURE"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">家庭电话</td>
<td width="20%"><BZ:input field="HOME_TEL" prefix="PersonExt_" type="String" defaultValue=""/></td>
<td width="10%"></td>
<td width="20%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">办公传真</td>
<td width="20%"><BZ:input field="OFFICE_FAX" prefix="Person_" type="String" defaultValue=""/></td>
<td width="10%">家庭传真</td>
<td width="20%"><BZ:input field="HOME_FAX" prefix="PersonExt_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">MSN</td>
<td width="20%"><BZ:input field="MSN" prefix="PersonExt_" type="String" defaultValue=""/></td>
<td width="10%">QQ</td>
<td width="20%"><BZ:input field="QQ" prefix="PersonExt_" type="String" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">国家(地区)</td>
<td width="20%"><BZ:select field="COUNTRY" formTitle="" prefix="Person_" isCode="true" codeName="COUNTRY"/></td>
<td width="10%">省份(州)</td>
<td width="20%"><BZ:select field="PROVINCE_ID" formTitle="" prefix="Person_" isCode="true" codeName="PROVINCE"/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">城市</td>
<td width="20%"><BZ:select field="CITY_ID" formTitle="" prefix="Person_" isCode="true" codeName="CITY"/></td>
<td width="10%">邮政编码</td>
<td width="20%"><BZ:input field="ZIP" formTitle="" prefix="Person_" defaultValue=""/></td>
<td width="5%"></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">个人主页</td>
<td width="90%" colspan="4"><input name="PersonExt_HOME_PAGE" type="text" style="width: 60%"/></td>
</tr>

<tr>
<td width="5%"></td>
<td width="10%">联系地址</td>
<td width="90%" colspan="4"><input name="Person_CONNECT_ADDR" type="text" style="width: 60%"/></td>
</tr>
<!-- 扩展属性显示区域 begin -->
<BZ:propExtend propType="1"></BZ:propExtend>
<!-- 扩展属性显示区域 end -->
</table>


<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2"><input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;<input type="button" value="返回" class="button_back" onclick="_back()"/></td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>