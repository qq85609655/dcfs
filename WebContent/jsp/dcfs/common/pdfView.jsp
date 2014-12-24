<%
/**   
 * @Title: pdfView.jsp
 * @Description: PDF查看
 * @author xugy
 * @date 2014-11-12下午8:53:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
String name = (String)request.getParameter("name");
String attId=  (String)request.getParameter("attId");
String attTypeCode = (String)request.getParameter("attTypeCode");
String type = (String)request.getParameter("type").toLowerCase();
%>
<BZ:html>
<BZ:head>
	<title><%= name %></title>
	<BZ:webScript edit="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	var PDF = document.getElementById("PDF");
	PDF.setPageMode("none");
	PDF.setLayoutMode("DontCare");
	PDF.SetZoom(100);
	PDF.gotoFirstPage();
	PDF.setShowScrollbars(1);
	PDF.setShowToolbar(0);
});
</script>
<BZ:body>
	<object id="PDF" classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" width="100%" height="100%" border="0" top="-10" class="pdf" name="pdf">    
		<param name="setShowToolbar" value="false">
		<param name="_Version" value="65539">
		<param name="_ExtentX" value="20108">
		<param name="_ExtentY" value="10866">
		<param name="_StockProps" value="0">
		<!-- 下面是指明你的PDF文档所在地，相对于发布web目录 -->
		<param name="SRC" value='<up:attDownload attTypeCode="AF" attId='<%=attId %>'/>'>
	</object>
</BZ:body>
</BZ:html>
