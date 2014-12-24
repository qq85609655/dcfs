<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<html>
<%@page import="com.hx.framework.common.Constants"%>
<%@page import="com.hx.framework.authenticate.UserInfo"%>
<%@page import="com.hx.framework.common.*"%>
<%@page import="com.hx.framework.sdk.*"%>
<%
	UserInfo user = (UserInfo)session.getAttribute(Constants.LOGIN_USER_INFO);

	int len=PwdPolicyHelper.getPasswordMinLength(user.getPersonAccount().getAccountType());
	String pattern=PwdPolicyHelper.getPasswordPattern(user.getPersonAccount().getAccountType());
	String passLenmem="要求" + len + "位以上";
	if (len<=0){
		passLenmem="无要求";
	}
	
	if(request.getParameter("must")!=null){
		request.setAttribute(Constants.PAGE_CTRL,request.getParameter("must"));
	}

	String key2=java.util.UUID.randomUUID().toString();
	request.getSession(true).setAttribute("KEY2",key2);
%>
<BZ:html>
<BZ:head>
<base target="_SELF"/>

<title>Change Password</title>
<BZ:script isEdit="true" isDate="true" />
<script type="text/javascript">
function _load(){
<% 
	String msg = (String)request.getAttribute("msg");
	if (msg!=null){
		if (msg.equals("OK")){
			%>
			alert("Change password successfully!");
			window.close();
			<%if(request.getParameter("must")!=null){%>
			window.opener.location="<%=request.getContextPath()%>";
			<%}%>
			<%
		}else{
			%>
			alert("<%=msg%>");
			window.parent.document.passForm.oldpassword.focus();
			window.parent.document.passForm.oldpassword.select();
			<%			
		}
	}
%>
}
function _save(){
	var p1=document.passForm.oldpassword;
	var p2=document.passForm.newpassword;
	var p3=document.passForm.newpassword1;
	if (p1.value==""){
		alert("请输入当前密码！");
		p1.focus();
		return;
	}
	if (p2.value==""){
		alert("请输入新密码！");
		p2.focus();
		return;
	}
	if (p3.value ==""){
		alert("请输入确认新密码！");
		p3.focus();
		return;
	}

	if (p2.value!=p3.value){
		alert("新密码和确认新密码不一致，请重新输入！");
		p2.focus();
		p2.select();
		return;
	}
	if (p2.value==p1.value){
		alert("新密码和旧密码不能相同，请重新输入！");
		p2.focus();
		p2.select();
		return;
	}
	var pwd = p2.value;
	var len=<%=len%>;
	var pattern=new RegExp(document.getElementById("pattern").value);
	var pstr="<%=pattern%>";
	
	if(pwd.length>0){
		if( len>0 && pwd.length<len){
			alert("密码长度不应少于"+len+"位！");
			p2.focus();
			p2.select();
			return;
		}
		if(pstr.length>0 && !pattern.test(pwd)){
			alert("密码不符合规则，应包含：<%=PwdPolicyHelper.getPasswordPatternMemo(user.getPersonAccount().getAuthType())%>");
			p2.focus();
			p2.select();
			return;
		}
	}
	<%if(FrameworkConfig.isEncPwdBeforeSubmit()){%>
		p1.value =strEnc(p1.value, "<%=user.getPersonAccount().getAccountId()%>","<%=key2%>",null);
		p2.value =strEnc(p2.value, "<%=user.getPersonAccount().getAccountId()%>","<%=key2%>",null);
		p3.value =strEnc(p3.value, "<%=user.getPersonAccount().getAccountId()%>","<%=key2%>",null);
	<%}%>
	document.passForm.submit();
}
function _b(){
	window.close();
	window.opener.location='<%=request.getContextPath()%>';
}
</script>
</BZ:head>

<body onload="_load()" style="align:center">
<form name="passForm" action="<BZ:url/>/person/Person!changePassword.action" method="post" target="smz">

<textarea id="pattern" style="display: none"><%=pattern %></textarea>

<iframe name="smz"  width="0"   height="0"  frameborder="0"   style="display:none">
</iframe>
<table style="width:300px;align:center">
	<%if(Constants.LOGIN_ERROR_PWD_IS_DEFAULT.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">您的密码是初始密码，请设置新密码后再登录系统</td>
	</tr>
	<%} %>
	<%if(Constants.LOGIN_ERROR_PWD_OVERTIME.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">您的密码已过期，请设置新密码后再登录系统</td>
	</tr>
	<%} %>
	<%if(Constants.LOGIN_ERROR_PWD_TOO_SHORT.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">您的密码不足<%=len %>位，请设置新密码后再登录系统</td>
	</tr>
	<%} %>
	<%if(Constants.LOGIN_ERROR_PWD_TOO_SIMPLE.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">您的密码不符合规则，请设置新密码后再登录系统</td>
	</tr>
	<%} %>
	<tr>
		<td class="title" nowrap="nowrap">当前密码：</td>
		<td class="txt"><input type="password" name="oldpassword" tabindex="1"></td>
	</tr>
	<tr>
		<td class="title" nowrap="nowrap">新密码：</td>
		<td class="txt"><input type="password" name="newpassword"></td>
	</tr>
	<tr>
		<td class="title" nowrap="nowrap">确认新密码：</td>
		<td class="txt"><input type="password" name="newpassword1"></td>
	</tr>
	<tr>
		<!--  <td colspan="2" class="rem">提示：新密码长度<%=passLenmem%>，至少包含:<%=PwdPolicyHelper.getPasswordPatternMemo(user.getPersonAccount().getAuthType())%></td>-->
	</tr>
<tr>
		<td colspan="2" align="center">
			<br>
			<button onclick="_save();return false;" type="submit" class="button_add">Save</button>&nbsp;&nbsp;
			<%if(request.getAttribute(Constants.PAGE_CTRL)!=null){ %>
			<button onclick="_b()">返回登录页</button>
			<%}else{ %>
				<button onclick="window.close()" class="button_back">Cancle</button>
			<%} %>
		</td>
	</tr>

	
</table>
</form>
</body>

</BZ:html>
