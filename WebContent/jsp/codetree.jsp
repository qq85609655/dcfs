
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@page import="hx.code.CodeList"%>
<%@page import="hx.code.Code"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
request.setAttribute("select","CS,LYG");
 %>
<BZ:html>
<BZ:head>
<title>ап╠М</title>
<BZ:script  tree="true"/>
</BZ:head>
<BZ:body codeNames="XZQH">
<BZ:codeTree property="XZQH" type="0" value="CS,LYG" selectvalue="select"/>
</BZ:body>
</BZ:html>