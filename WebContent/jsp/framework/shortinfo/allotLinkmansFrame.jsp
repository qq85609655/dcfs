<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
 <% 
 	String path=request.getContextPath();
 	String personId = (String)request.getAttribute("PERSON_ID");
 %>
<html>
<head>
<base target="_self">
<title>—°‘Ò∆µµ¿</title>
</head>
<body>
<iframe width="998px" height="700px" scrolling="auto" frameborder="0" src="<%=path%>/usergroup/allotLinkmans.action"></iframe>
</body>
</html>