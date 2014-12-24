<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.cms.article.vo.Article"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%
	Data data = (Data)request.getAttribute("data");
%>
<html>
<head></head>
<body>
<font style="font-weight: bold;">œ¬‘ÿµÿ÷∑£∫</font>
www.56.org.cn/article/Article!detail.action?CODE=CMS_ARTICLE_ATT&PACKAGE_ID=<%=data.getString(Article.PACKAGE_ID,"") %>
</body>
</html>