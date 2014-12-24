
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@ page import="hx.database.databean.*" %>
<%@page import="hx.code.CodeList"%>
<%@page import="hx.code.Code"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ" %>
<%
CodeList codeList=new CodeList();
Code code=new Code();
code.setValue("1");
code.setParentValue("");
code.setName("²âÊÔ");
Code code1=new Code();
code1.setValue("11");
code1.setParentValue("1");
code1.setName("²âÊÔ11");
Code code2=new Code();
code2.setValue("111");
code2.setParentValue("11");
code2.setName("²âÊÔ111");
Code code3=new Code();
code3.setValue("1111");
code3.setParentValue("111");
code3.setName("²âÊÔ1111");
Code code4=new Code();
code4.setValue("11111");
code4.setParentValue("1111");
code4.setName("²âÊÔ11111");
codeList.add(code);
codeList.add(code1);
codeList.add(code2);
codeList.add(code3);
codeList.add(code4);
request.setAttribute("codeList",codeList);
request.setAttribute("select","1,11,111");
%>
<BZ:html>
<BZ:head>
<title>ÁÐ±í</title>
<BZ:script  tree="true"/>
</BZ:head>
<BZ:body >
<BZ:tree property="codeList" type="1" value="111" selectvalue="select"/>
</BZ:body>
</BZ:html>