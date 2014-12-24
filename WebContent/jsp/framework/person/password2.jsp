<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
    <%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="com.hx.framework.common.*"%>
<head>
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<base target="_SELF"/>
<title>修改密码</title>

<script type="text/javascript">
function _load(){
	var url = "<BZ:url/>/jsp/framework/person/password.jsp?must=<%=request.getAttribute(Constants.PAGE_CTRL)%>";
	url+="&"+"nowtimelong=" + (new Date()).getTime();;
	var dialogWidth="350";
	var dialogHeight="240";
	window.showModalDialog(url,null,"dialogWidth:" + dialogWidth + "px; dialogHeight:" + dialogHeight + "px; help:no; status:0");
	
	window.top.location="<%=request.getContextPath()%>";
}
</script>
</head>

<body onload="_load()">

</body>

</html>
