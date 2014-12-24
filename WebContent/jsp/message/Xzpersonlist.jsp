<%@ page language="java" pageEncoding="GBK"%>
<%@page import="hx.taglib.TagTools"%>
<%@ taglib uri="http://java.fckeditor.net" prefix="FCK" %>
<%
String resourcepath=TagTools.getResourcePath(request,"");
String path = request.getContextPath();
String onlydisplay = request.getParameter("onlydisplay");
if(onlydisplay==null){
	onlydisplay="";
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
   <style type="text/css">
 body{
 margin:0px 0px 0px 0px;
 }
 </style>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>人员选择</title>
	<link href="<%=resourcepath %>/include/css/base.css" rel="stylesheet" type="text/css" />
	<link href="<%=resourcepath%>/include/css/csi.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/combobox.js"></script>
	<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/extendString.js"></script>
	<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/formVerify.js"></script>
	<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/runFormVerify.js"></script>
	<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/code.js"></script>
	<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/page.js"></script>
	<script language="javascript" type="text/javascript" src="<%=resourcepath%>/include/js/edit.js"></script>
<style type="text/css">
	<!--
     .x-btn1{text-align:left;font-size:16px;background-color:red;}
    -->
  </style>
<script>
function _close()
  {
  window.returnValue="";
  window.close();
  }
   function _xzperson()
  {
  var returnvalue=document.getElementById("xzperson").value;
  window.returnValue=returnvalue;
 window.close();
  }
  var msg = new Hint(false); 
  function selectperson()
  {
  var mingcheng=document.getElementById("chaxun").value;
  if(mingcheng.length>100)
  {
  msg.showpop(document.getElementById("chaxun"),"输入查询条件超出范围",0)
  return;
  }
  window.mainframe.location="<%=path%>/servlet/message/MessageServlet?method=xzpersontree&onlydisplay=<%=onlydisplay%>&searchtj="+mingcheng;
  }
</script>
</head>
<body>
<div class="extPanel" style="border:0px;">
  <div ><input type="text" name="chaxun" check searchInput="true"/>&nbsp;&nbsp;<input type="button" name="find" onclick="selectperson();" value="搜索" class="extButtonSmall"></div>
  </div>
  <input type="hidden" name="xzperson" >
  <iframe id="mainframe" src="<%=path%>/servlet/message/MessageServlet?method=xzpersontree&onlydisplay=<%=onlydisplay%>" width="330" height="340" scrolling="no" frameBorder="0">
  </iframe>
  <div align="center">
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="dsads" onclick="_xzperson();" value="确定" class="extButtonSmall"> 
   &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="dsads" onclick="_close()" value="关闭" class="extButtonSmall"> 
  </div>
 </body>
</html>