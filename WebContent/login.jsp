<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="com.hx.framework.common.Constants"%>
<%@ page import="com.hx.framework.sdk.*"%>
<%@ page import="com.hx.framework.person.vo.*"%>
<%@ page import="com.hx.framework.common.FrameworkConfig"%>
<%@ page import="jcifs.smb.NtlmPasswordAuthentication"%>
<%
	String msg = (String) request.getAttribute(Constants.PAGE_MSG_INFO);
	if (msg == null) {
		msg = "";
	}
	String userName = "";
	String cName = null;
	NtlmPasswordAuthentication ntlm = (NtlmPasswordAuthentication) request.getSession().getAttribute("NtlmHttpAuth");
	if (ntlm != null) {
		userName = ntlm.getUsername();
		PersonAccount pa = PersonAccountHelper.getPersonAccountByAccountId(userName);
		if (pa != null) {
			Person p = PersonHelper.getPersonById(pa.getPersonId());
			if (p != null) {
				cName = p.getcName();
			}
		}
	}
	String key2 = java.util.UUID.randomUUID().toString();
	request.getSession(true).setAttribute("KEY2", key2);
%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %> 
<html>
<head>
<title>孤残儿童涉外安置信息系统</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"/>
<up:uploadResource checkFlash="true"/>
<link rel="stylesheet" type="text/css" href="<BZ:resourcePath/>/index_page/styles/common.css" />
<link rel="stylesheet" type="text/css" href="<BZ:resourcePath/>/index_page/styles/style.css" />
<script src="<BZ:resourcePath/>/index_page/scripts/jquery-1.9.1.min.js"></script>
<script src="<BZ:resourcePath/>/js/des.js"></script>
<script src="<BZ:resourcePath/>/js/ajax.js"></script>
<!--[if IE 6]>
<script language="javascript" type="text/javascript" src="<BZ:resourcePath/>/index_page/scripts/DD_belatedPNG_0.0.8a-min.js"></script>
<script>
		DD_belatedPNG.fix('.png_bg');
</script>
<![endif]-->
<script>
var path = "<BZ:url/>/";
function _load(){
	<%if (cName == null) {
		Integer count = (Integer) request.getSession().getAttribute("load_count");
		if (count == null) {
			count = new Integer(1);
		}
		int i = count.intValue();
		count = new Integer(i + 1);
		request.getSession().setAttribute("load_count", count);
		if (i < 10) {%>
			//window.location="<%=request.getContextPath()%>/auth/login.action";
		<%} else {%>
			//alert("未获取到域用户信息,请重新打开浏览器登陆!");
		<%}
	} else {
		request.getSession().removeAttribute("load_count");
	}%>
	//初始化验证码图片：
	document.getElementById("j_username").focus();
}
</script>
	<script type="text/javascript">

	function _go(user){
		document.myform.j_username.value=user;
		document.myform.j_password.value="1";
		document.myform.submit();
	}
	<%if (request.getAttribute(Constants.SESSION_OVERTIME) != null) {%>
		alert("<%=msg%>");
		window.top.location="<%=request.getContextPath()%>/auth/login.action";
	<%}%>
	function showSetup(){
		var divId=document.getElementById('setup');
		divId.style.left=(document.body.clientWidth-divId.clientWidth)/2+document.body.scrollLeft;
		divId.style.top=(document.body.clientHeight-divId.clientHeight)/2+document.body.scrollTop;
		divId.style.display="block";
	}
	function hideSetup(){
		var divId=document.getElementById('setup');
		divId.style.display="none";
	}
	function _test() {
		document.all("loginType").value="1";
		if(document.getElementById('yoname').style.display=='none') {
			document.getElementById('yuname').style.display="none";
			document.getElementById('yoname').style.display="block";
		}else{
			document.getElementById('yuname').style.display="block";
			document.getElementById('yoname').style.display="none";
		}
	}
	function _tijiao(){
		<%if(com.hx.framework.common.FrameworkConfig.isEncPwdBeforeSubmit()){%>
			var name=document.getElementById("j_username").value;
			var pass=document.getElementById("j_password").value;
			var encStr = strEnc(pass, name,"<%=key2%>",null);
			document.getElementById("j_password").value =encStr;
		<%}%>
		document.myform.submit();
	}

	function _changecontentdiv(){
		var divh=document.getElementById('dl_con_div').clientHeight;
		var divheight=document.documentElement.clientHeight-divh;
		document.getElementById('company').style.marginTop=divheight+"px";
	}

	$(function(){
		document.onkeydown = function(e){
		var ev = document.all ? window.event : e;
			if(ev.keyCode==13) {
				_tijiao();
			}
		}
	});

	//登录
	function login(){
		window.top.location="<BZ:url/>";
	}
	</script>
</head>
<body onload="_load();">
	<form name="myform" action="<%=request.getContextPath() %>/auth/login.action" method="post">
	<input type="hidden" id="domainUserId" name="domainUserId" value="<%=userName %>"/>
	<input type="hidden" id="loginType" name="loginType" value="<%="".equals(userName)?"1":"2"%>"/>

	<div id="indexpage">
		<div class="pagewrap">
			<div class="page-title"></div>
			<div class="loginbox">
				<div class="loginwrap png_bg">
					<div class="msg"><%=msg %></div>
					<div class="login-table">
						<table width="100%" cellspacing="0" cellpadding="0" border="0">
							<tbody><tr>
								<td width="34%">&nbsp;</td>
								<td width="7%" valign="middle" height="37" align="right" class="word-4">用户名：<br> UserName：</td>
								<td width="59%"><input type="text" value="" id="j_username" class="input-1" name="j_username"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="middle" height="37" align="right" class="word-4">密&nbsp;&nbsp;码：<br>Password：</td>
								<td><input type="password" value="" id="j_password" class="input-1" name="j_password"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td valign="middle" height="37" align="right" class="word-4">验证码：<br>Authenticode：</td>
								<td><table width="100%" cellspacing="0" cellpadding="0" border="0">
								<tbody><tr>
								<td width="14%"><input type="text" value="" size="10" class="input" maxlength="4" name="j_yzm"></td>
								<td width="86%">&nbsp;
									<img style="border: 0px;" id="checkImage" name="checkImage" src="" title="看不清，换一张!">
									</td>
								</tr>
							</tbody></table>
								</td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td><div class="loginbtn" onclick="_tijiao();">登&nbsp;&nbsp;陆</div></td>
							</tr>
						</tbody></table>
					</div>
				</div>
			</div>
		</div>
	</div>
	</form>

</body>
</html>
