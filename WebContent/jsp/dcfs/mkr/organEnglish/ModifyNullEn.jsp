<%@page import="hx.code.Code"%>
<%@page import="hx.code.CodeList"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	
	//生成token串
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
   Data data = (Data)request.getAttribute("data");
   String ADOPT_ORG_ID = data.getString("ADOPT_ORG_ID");
   String ID = data.getString("ID");
%>
<BZ:html>
<BZ:head>
	<title>联系人维护</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		$(document).ready(function() {
			dyniframesize(['iframeC','iframe','mainFrame']);//公共功能，框架元素自适应
		});
		window.parent.location.href = '<%=path %>/mkr/orgexpmgr/branchOrganListEn.action?ADOPT_ORG_ID=<%=ADOPT_ORG_ID %>&ID=<%=data.getString("ID") %>';
	});
	</script>
</BZ:head>
</BZ:html>
