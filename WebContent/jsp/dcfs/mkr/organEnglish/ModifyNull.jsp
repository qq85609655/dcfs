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
    
    String ID = (String)request.getAttribute("ADOPT_ORG_ID");  //组织机构ID
  	String m = (String)request.getAttribute("m");
    String type = (String)request.getAttribute("type");
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
		var m = "<%=m%>";
		var ID ="<%=ID%>";
		var type = "<%=type%>";
		if(m=="ok"){
			if(type=="aidProject"){
				window.parent.location = "<%=request.getContextPath() %>/mkr/organSupp/aidProjectOrganListEn.action?ID="+ID;
			}
			if(type=="linkMan"){
				window.parent.location = "<%=request.getContextPath() %>/mkr/organSupp/linkManOrganListEn.action?ID="+ID;
			}
			if(type=="reception"){
				window.parent.location = "<%=request.getContextPath() %>/mkr/organSupp/receptionOrganListEn.action?ID="+ID;
			}
		}
	});
	</script>
</BZ:head>
</BZ:html>
