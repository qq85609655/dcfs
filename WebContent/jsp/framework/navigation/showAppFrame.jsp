
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
 <% 
 String path=request.getContextPath();
 %>
<html>
<head>
<title>应用列表</title>
  <script type="text/javascript">
  
  </script>
</head>
<body>
<iframe width="800px" height="400px" scrolling="auto" frameborder="0" src="<%=path %>/navigation/navigationShowApp.action"></iframe>
</body>
</html>