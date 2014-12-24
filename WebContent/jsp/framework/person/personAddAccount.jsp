<%@ page language="java" contentType="text/html; charset=GBK"  pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="hx.code.*"%>
<%@page import="com.hx.framework.organ.vo.*"%>
<%@page import="com.hx.framework.common.*"%>
<%@page import="com.hx.framework.sdk.*"%>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
	Data data = (Data)request.getAttribute("data");

	String oriId=data.getString("ORGAN_RIGHT");
	String oriName="";
	if(oriId!=null && !"".equals(oriId)){
		Organ o=OrganHelper.getOrganById(oriId);
		oriName=o.getCName();
	}


	//用户名密码
	//int len=FrameworkConfig.getPasswordMinLength();
	//String pattern=FrameworkConfig.getPasswordPattern();
	//String mem = FrameworkConfig.getPasswordPatternMemo();
	//域登录
	//int len1=FrameworkConfig.getPasswordMinLength2();
	//String pattern1=FrameworkConfig.getPasswordPattern2();
	//String mem1 = FrameworkConfig.getPasswordPatternMemo2();
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);

	String key2=java.util.UUID.randomUUID().toString();
	request.getSession(true).setAttribute("KEY2",key2);

%>
<BZ:html>
<BZ:head>
<title>添加人员账号页面</title>
<BZ:script isEdit="true" isDate="true" isAjax="true" />
<script src="<BZ:resourcePath/>/js/des.js"></script>
<script src="<BZ:resourcePath/>/js/framework.js"></script>

<script>
	$(document).ready(function() {
		dyniframesize(['mainFrame','mainFrame']);
	});
	var oldType="<%=((Data)request.getAttribute("data")).getString("AUTH_TYPE")%>";

	function tijiao()
	{
		var defaultapp=document.all("PersonAccount_DEFAULT_APP").value;
		if(defaultapp==""){
			alert("请选择默认应用！");
			return;
		}
		var pwd=document.all("PersonAccount_PASSWORD").value;
		var pwd2=document.all("PASSWORD_REPEAT").value;
		var isModify=document.all("MODIFY_FLAG").value;
		var authType = document.getElementsByName("PersonAccount_AUTH_TYPE")[0].value;
		if(isModify=="" && pwd.length==0){
			alert("密码不能为空！");
			return;
		}
		if(pwd!=pwd2){
			alert("密码不一致！");
			return;
		}
		if (isModify!=""){
			if(pwd.length==0){
				if (oldType=="2" && authType=="1"){
					alert("您已经设置不绑定绑定域和key，需要重新设置密码");
					return;
				}
			}
		}

		var len=0;
		var mem="";
		var pstr="";
		var pattern="";

		//var str=executeRequest("com.hx.framework.security.GetPasswordPolicyAjax","authType="+authType);
		//if(str!="0"){
		//}
		//var ss=str.split("@@@");
		var ss=getPwdPolicy(authType);
		len=ss[0];
		pstr=ss[1];
		pattern=new RegExp(ss[1]);
		mem=ss[2];

		if(pwd.length>0){
			if( len>0 && pwd.length<len){
				alert("密码长度不应少于"+len+"位！");
				return;
			}
			if(pstr.length>0 && !pattern.test(pwd)){
				alert("密码不符合规则，应包含：" + mem);
				return;
			}
		}


		//alert(pstr);
		//alert(pwd);
		//alert(pattern.test(pwd));
		if (isModify!=""){
			if (oldType=="1" && authType=="2"){
				alert("您已经设置了账号绑定，请确认是否建立域账号。");
			}
		}else{
			if (authType=="2"){
				alert("您已经设置了账号绑定，请确认是否建立域账号。");
			}
		}
		<%if(FrameworkConfig.isEncPwdBeforeSubmit()){%>
			var p2=document.all("PersonAccount_PASSWORD");
			var p3=document.all("PASSWORD_REPEAT");
			p2.value =strEnc(p2.value, "<%=user.getPersonAccount().getAccountId()%>","<%=key2%>",null);
			p3.value =strEnc(p3.value, "<%=user.getPersonAccount().getAccountId()%>","<%=key2%>",null);
		<%}%>
		document.srcForm.action=path+"person/Person!addAccount.action";
		document.srcForm.submit();
	}
	function _back(){
		document.srcForm.action=path+"person/Person!query.action";
		document.srcForm.submit();
	}

	function _load(){
		//oldType = document.getElementsByName("PersonAccount_AUTH_TYPE")[0].value;
		authType = document.getElementsByName("PersonAccount_AUTH_TYPE")[0].value;
		var ss=getPwdPolicy(authType);
		var mv = document.getElementById("memValue");
		mv.innerHTML="";
		if (ss[0]>0){
			mv.innerHTML="密码要求：不能少于"+ss[0]+"位";

		}
		if(ss[1]!=''){
			if(ss[0]>0){
				mv.innerHTML=mv.innerHTML+"，";
			}
			mv.innerHTML=mv.innerHTML+"至少包含："+ss[2];
		}
	}
	function _change(v){
		_load();
	}
	function _getInitialPass(){
		var yu = document.getElementById('PersonAccount_AUTH_TYPE').value;
		var ss=getPwdPolicy(yu);
		document.getElementById("PersonAccount_PASSWORD").value=ss[3];
		document.getElementById("PASSWORD_REPEAT").value=ss[3];


		document.getElementById("pwdDefValue").innerHTML="初始密码："+ss[3];
		//if(yu=='1'){
		//	document.getElementById("PersonAccount_PASSWORD").value="1234567890";
		//	document.getElementById("PASSWORD_REPEAT").value="1234567890";
		//}else{
		//	document.getElementById("PersonAccount_PASSWORD").value="12345678";
		//	document.getElementById("PASSWORD_REPEAT").value="12345678";
		//}
	}


		//选择组织机构
	function _selectOrgan(){
		var reValue = window.showModalDialog(path+"organ/Organ!generateTree.action?treeDispatcher=selectOrganTree", this, "dialogWidth=400px;dialogHeight=600px;scroll=auto");
		document.getElementById("ORGAN_RIGHT").value = reValue["value"];
		document.getElementById("ORGAN_RIGHT_NAME").value = reValue["name"];
	}
</script>
<style>
input{
	height: 24px;
	padding-top:4px;
	padding-left:2px;
	font-size: 12px;
	border: 1px solid silver;
}
</style>
</BZ:head>
<BZ:body property="data" onload="_load();">
<BZ:form name="srcForm" method="post"  token="personAddAccount">
<div class="kuangjia">
<!-- 人员编号,由前置Action传递 -->
<BZ:input field="PERSON_ID" prefix="PersonAccount_" type="hidden"/>
<!-- 修改时保存原来的登录错误次数信息 -->
<BZ:input field="LOGIN_FAIL_NUM" prefix="PersonAccount_" defaultValue="0" type="hidden"/>
<!-- 组织机构ID -->
<input type="hidden" id="ORG_ID" name="ORG_ID" value="<%=request.getAttribute(OrganPerson.ORG_ID)==null?request.getParameter("S_ORG_ID"):request.getAttribute(OrganPerson.ORG_ID) %>"/>
<!-- 判断是否修改的隐藏域 -->
<input name="MODIFY_FLAG" type="hidden" value="<%=request.getAttribute("MODIFY_FLAG")!=null?"true":"" %>"/>

<input name="S_CNAME" type="hidden" value='<%=request.getParameter("S_CNAME") %>'>
<input name="S_ORG_ID" type="hidden" value='<%=request.getParameter("S_ORG_ID") %>'>
<input name="S_ACCOUNT_ID" type="hidden" value='<%=request.getParameter("S_ACCOUNT_ID") %>'>
<input name="S_STATUS" type="hidden" value='<%=request.getParameter("S_STATUS") %>'>
<input name="ldap" type="hidden" value='<%=request.getParameter("ldap") %>'>
<div class="heading">账号信息</div>
<table class="contenttable">
<tr>
<td width="5%"></td>
<td width="15%">账号</td>
<td width="30%"><input name="PersonAccount_ACCOUNT_ID" type="text" value='<%=data.getString("ACCOUNT_ID")!=null?data.getString("ACCOUNT_ID"):"" %>' <%=data.getString("ACCOUNT_ID")!=null?"readonly='true'":"" %>/></td>

<td width="15%">默认应用</td>
<td width="30%">
	<BZ:select field="DEFAULT_APP" prefix="PersonAccount_" formTitle="" codeName="apps" isCode="true" width="120px" >
		<BZ:option value="">--请选择--</BZ:option>
	</BZ:select>
</td>
<td width="5%"></td>
</tr>
<tr>
	<td></td>
	<td>组织机构权限</td>
	<td>
		<BZ:input id="ORGAN_RIGHT" field="ORGAN_RIGHT" prefix="PersonAccount_" defaultValue='' type="hidden"/>
		<BZ:input id="ORGAN_RIGHT_NAME" prefix="PersonAccount1_" field="ORGAN_RIGHT_NAME" defaultValue='<%=oriName %>'  readonly="true" onclick="_selectOrgan();"/>
	</td>
	<td colspan="3"></td>
</tr>
<tr>
	<td></td>
	<td>登录密码</td>
	<td colspan="4">
	<input name="PersonAccount_PASSWORD" type="password" id="PersonAccount_PASSWORD"/>&nbsp;&nbsp;
	<input type="button" value="点击获取初始密码" onclick="_getInitialPass();"/>&nbsp;&nbsp;
	<span id="memValue"></span><span id="pwdDefValue"></span>
	</td>
</tr>
<tr>
	<td></td>
	<td>再次输入密码</td>
	<td><input name="PASSWORD_REPEAT" type="password" id="PASSWORD_REPEAT"/></td>
	<td colspan="3"></td>
</tr>
<tr>
	<td ></td>
	<td >有效期</td>
	<td >

	<BZ:input field="ACCOUNT_TTL" prefix="PersonAccount_" type="date"/>

</td>
<td  nowrap="nowrap" >密码最后修改时间</td>
<td >
<BZ:dataValue field="PASS_LAST_CHG_TIME" type="Date" defaultValue=""/>
</td>
<td></td>
</tr>

<tr>
<td ></td>
<td >账号类型</td>
<td >
	<div style="display: none">
		<BZ:select field="ACCOUNT_TYPE" prefix="PersonAccount_" formTitle=""  >
			<BZ:option value="1" >普通用户</BZ:option>
			<BZ:option value="0">临时用户</BZ:option>
		</BZ:select>
	</div>

	<BZ:select field="AUTH_TYPE" prefix="PersonAccount_" formTitle="" codeName="authTypeList" isCode="true" onchange="_change(this.value);" >
	</BZ:select>
</td>
<td >账号状态</td>
<td >
	<BZ:dataValue field="STATUS" type="String" defaultValue="1" checkValue="1=正常;2=锁定;4=禁用;3=删除"/>
	<BZ:input field="STATUS" prefix="PersonAccount_"  type="hidden" defaultValue="1" />
</td>
<td ></td>
</tr>


<tr style="display: none">
<td ></td>
<td >绑定域和key</td>
<td >
	<BZ:input type="hidden" field="AUTH_TYPE"  prefix="OLD1_" />
	<BZ:select field="AUTH_TYPE" prefix="PersonAccount1_" formTitle="" onchange="_change(this.value);">
		<BZ:option value="2" >绑定</BZ:option>
		<BZ:option value="1">不绑定</BZ:option>
	</BZ:select>
</td>
<td >是否初始密码</td>
<td >
	<BZ:dataValue field="IS_CHANGED_PWD" type="String" defaultValue="0" checkValue="1=是;0=否"/>
</td>
<td ></td>
</tr>

<tr style="display: none">
<td ></td>
<td >密码问题</td>
<td colspan="4"><input name="PersonAccount_PASS_QUESTION" type="text" style="width: 40%" value="<%=data.getString("PASS_QUESTION")!=null?data.getString("PASS_QUESTION"):"" %>"/></td>
</tr>

<tr style="display: none">
<td ></td>
<td >密码答案</td>
<td colspan="4"><input name="PersonAccount_PASS_ANSWER" type="text" style="width: 40%" value="<%=data.getString("PASS_ANSWER")!=null?data.getString("PASS_ANSWER"):"" %>"/></td>
</tr>

</table>

<table border="0" cellpadding="0" cellspacing="0" class="operation">
<tr>
<td align="center" style="padding-right:30px" colspan="2">
	<%

		//系统管理员和超级管理员才能设置管理员
		if("0".equals(user.getAdminType())|| "2".equals(user.getAdminType())
				|| ("1".equals(user.getAdminType()) && (data.getString("ACCOUNT_ID")==null || data.getString("ACCOUNT_ID").equals("")))){
	%>

	<%} %>
	<input type="button" value="保存" class="button_add" onclick="tijiao()"/>&nbsp;&nbsp;
	<input type="button" value="返回" class="button_back" onclick="_back()"/>
</td>
</tr>
</table>
</div>
</BZ:form>
</BZ:body>
</BZ:html>