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
	
	//����token��
    TokenProcessor processor=TokenProcessor.getInstance();
    String token=processor.getToken(request);
    
    String ID = (String)request.getAttribute("ADOPT_ORG_ID");  //��֯����ID
  	String m = (String)request.getAttribute("m");
    String type = (String)request.getAttribute("type");
%>
<BZ:html>
<BZ:head>
	<title>��ϵ��ά��</title>
	<BZ:webScript edit="true"/>
	<up:uploadResource isImage="true" cancelJquerySupport="true"/>
	
	
	<script type="text/javascript">
	$(document).ready(function() {
		$(document).ready(function() {
			dyniframesize(['iframeC','iframe','mainFrame']);//�������ܣ����Ԫ������Ӧ
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
