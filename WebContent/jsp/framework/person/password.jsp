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
	String passLenmem="Ҫ��" + len + "λ����";
	if (len<=0){
		passLenmem="��Ҫ��";
	}
	
	if(request.getParameter("must")!=null){
		request.setAttribute(Constants.PAGE_CTRL,request.getParameter("must"));
	}

	String key2=java.util.UUID.randomUUID().toString();
	request.getSession(true).setAttribute("KEY2",key2);
%>
<head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<script src="<BZ:resourcePath/>/js/des.js"></script>
<script src="<BZ:resourcePath/>/js/framework.js"></script>
<base target="_SELF"/>
<title>�޸�����</title>
<style type="text/css">
.title1 {
	font-size: 14px;
	font-weight: bold;
	text-align:right;
	width: 100%;
	height: 28px;
}
.title {
	font-size: 14px;
	font-weight: bold;
	text-align:right;
	width: 100px;
	height: 28px;
}
body{
	background-color: #e9f2fd;
	align:center;
}
.txt{
	font-size: 14px;
	text-align: left;
	width: 200px;
	height: 28px;
}

input{
	width: 180px;
	height: 20px;
	text-indent: 5px;
	font-size: 14px;
	border: 1px solid #000080
}
button {
	width:80px;
	height:28px;
}
.rem{
	border: 1px solid #C0C0C0;
	text-align: left;
	text-indent: 2em;
	font-weight: normal;
	line-height: 18px;
	font-size:14px;
}
</style>
<script type="text/javascript">
function _load(){
<% 
	String msg = (String)request.getAttribute("msg");
	if (msg!=null){
		if (msg.equals("OK")){
			%>
			alert("�����޸ĳɹ�,���μ����������룡");
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
		alert("�����뵱ǰ���룡");
		p1.focus();
		return;
	}
	if (p2.value==""){
		alert("�����������룡");
		p2.focus();
		return;
	}
	if (p3.value ==""){
		alert("������ȷ�������룡");
		p3.focus();
		return;
	}

	if (p2.value!=p3.value){
		alert("�������ȷ�������벻һ�£����������룡");
		p2.focus();
		p2.select();
		return;
	}
	if (p2.value==p1.value){
		alert("������;����벻����ͬ�����������룡");
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
			alert("���볤�Ȳ�Ӧ����"+len+"λ��");
			p2.focus();
			p2.select();
			return;
		}
		if(pstr.length>0 && !pattern.test(pwd)){
			alert("���벻���Ϲ���Ӧ������<%=PwdPolicyHelper.getPasswordPatternMemo(user.getPersonAccount().getAuthType())%>");
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
</head>

<body onload="_load()" style="align:center">
<form name="passForm" action="<BZ:url/>/person/Person!changePassword.action" method="post" target="smz">

<textarea id="pattern" style="display: none"><%=pattern %></textarea>

<iframe name="smz"  width="0"   height="0"  frameborder="0"   style="display:none">
</iframe>
<table style="width:300px;align:center">
	<%if(Constants.LOGIN_ERROR_PWD_IS_DEFAULT.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">���������ǳ�ʼ���룬��������������ٵ�¼ϵͳ</td>
	</tr>
	<%} %>
	<%if(Constants.LOGIN_ERROR_PWD_OVERTIME.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">���������ѹ��ڣ���������������ٵ�¼ϵͳ</td>
	</tr>
	<%} %>
	<%if(Constants.LOGIN_ERROR_PWD_TOO_SHORT.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">�������벻��<%=len %>λ����������������ٵ�¼ϵͳ</td>
	</tr>
	<%} %>
	<%if(Constants.LOGIN_ERROR_PWD_TOO_SIMPLE.equals(request.getAttribute(Constants.PAGE_CTRL))){ %>
	<tr>
		<td class="title1" nowrap="nowrap" colspan="2">�������벻���Ϲ�����������������ٵ�¼ϵͳ</td>
	</tr>
	<%} %>
	<tr>
		<td class="title" nowrap="nowrap">��ǰ���룺</td>
		<td class="txt"><input type="password" name="oldpassword" tabindex="1"></td>
	</tr>
	<tr>
		<td class="title" nowrap="nowrap">�����룺</td>
		<td class="txt"><input type="password" name="newpassword"></td>
	</tr>
	<tr>
		<td class="title" nowrap="nowrap">ȷ�������룺</td>
		<td class="txt"><input type="password" name="newpassword1"></td>
	</tr>
	<tr>
		<td colspan="2" class="rem">��ʾ�������볤��<%=passLenmem%>�����ٰ���:<%=PwdPolicyHelper.getPasswordPatternMemo(user.getPersonAccount().getAuthType())%></td>
	</tr>
<tr>
		<td colspan="2" align="right">
			<button onclick="_save();return false;" type="submit">�޸�</button>&nbsp;&nbsp;
			<%if(request.getAttribute(Constants.PAGE_CTRL)!=null){ %>
			<button onclick="_b()">���ص�¼ҳ</button>
			<%}else{ %>
				<button onclick="window.close()">ȡ��</button>
			<%} %>
		</td>
	</tr>

	
</table>
</form>
</body>

</html>
