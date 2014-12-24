<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@taglib prefix="up" uri="/WEB-INF/upload-tag/upload" %>
<%
	String optype = (String)request.getAttribute("OP_TYPE");
	String packageId = (String)request.getAttribute("PACKAGE_ID");
	String attType = (String)request.getAttribute("ATT_TYPE");
	String paramName = (String)request.getAttribute("PARAM_NAME");
	String path = request.getContextPath();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>附件</title>
<up:uploadResource/>
</head>
<body style="margin: 0">
<center>
<%
	if("read".equalsIgnoreCase(optype)){
%>
<up:uploadList 
	id="<%=attType %>" 
	attTypeCode="<%=attType %>" 
	packageId="<%=packageId %>"/>
<%
	}
	
	if("edit".equalsIgnoreCase(optype)){
%>
<up:uploadBody 
	attTypeCode="<%=attType %>" 
	id="<%=attType %>" 
	packageId="<%=packageId %>" 
	name='<%=paramName!=null?paramName:"PACKAGE_ID" %>'
	queueStyle="border: solid 1px #CCCCCC;width:50%"
	selectAreaStyle="border: solid 1px #CCCCCC;border-bottom:none;width:50%;"
	unit="M"/>
<%
	}
	
	if("none".equalsIgnoreCase(optype)){
%>
<!-- none的话什么都不输出 -->
<% 
	}
%>
</center>
</body>
</html>