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
<iframe width="600px" height="600px" scrolling="auto" frameborder="0" src="<%=path %>/usergroup/lookGroupOfPerson.action?PERSON_ID=<%=personId %>"></iframe>
</body>
</html>