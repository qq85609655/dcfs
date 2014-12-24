<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.hx.framework.authenticate.SessionInfo"%>
<%@page import="hx.util.DateUtility"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String CI_ID = (String)request.getAttribute("CI_ID");
	String ri_state = (String)request.getAttribute("RI_STATE");
	String onlyPage = (String)request.getAttribute("onlyPage");
%>
<BZ:html>
<BZ:head>
	<title>��ͯ������Ϣ�鿴</title>
	<BZ:webScript edit="true"/>
	<BZ:webScript list="true"/>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
</BZ:head>
<script type="text/javascript">
	$(document).ready(function() {
		//dyniframesize(['mainFrame']);
		//$('#tab-container').easytabs();
		
	});
</script>

<BZ:body>
<script type="text/javascript">	
	$(document).ready(function() {
		//document.all("iframe").style.height=document.body.scrollHeight; 
		//$('#tab-container').easytabs();
	});
	var tempFlag=1;
	function change(flag){
		if(tempFlag!=flag){
			document.all("iframe").style.height=document.body.scrollHeight; 
			if(flag==1){//��ʾ������Ϣ
				document.getElementById("iframe").src="<%=path%>/cms/childManager/showForAdoption.action?UUID=<%=CI_ID%>&RI_STATE=<%=ri_state%>";
				document.getElementById("act1").className="active";
				document.getElementById("act2").className="";
			}	
			if(flag==2){//��ʾ���¼�¼
				document.getElementById("iframe").src="<%=path%>/cms/childupdate/getShowDataByCIIDForAdoption.action?CI_ID=<%=CI_ID%>";
				document.getElementById("act2").className="active";
				document.getElementById("act1").className="";
			}
			document.all("iframe").style.height=document.body.scrollHeight; 
			tempFlag=flag;
		}
    } 
	function _close(){
		window.close();
	}

</script>
	<!-- ���ڱ������ݽ����ʾ -->
	<div class="bz-edit clearfix" desc="�༭����" >
		<div class="widget-header">
			<div class="widget-toolbar">
				<ul class="nav nav-tabs" id="recent-tab">
					<li id="act1" class="active"> 
						<a href="javascript:change(1);">������Ϣ(Basic information)</a>
					</li>
					<li id="act2" class="">
						<a href="javascript:change(2);">���¼�¼(Updated information)</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="widget-box no-margin" style=" width:100%; margin: 0 auto;">
		 <iframe id="iframe" scrolling="no" src="<%=path%>/cms/childManager/showForAdoption.action?UUID=<%=CI_ID%>&RI_STATE=<%=ri_state%>" style="border:none; width:100%; overflow:hidden;text-align: center" frameborder="0" ></iframe>
		</div>
	</div>
    <%if("1".equals(onlyPage)){ %>
	  <!-- ��ť����:begin -->
		<div class="bz-action-frame" style="text-align:center">
			<div class="bz-action-edit" desc="��ť��">		
				<input type="button" value="Close" class="btn btn-sm btn-primary" onclick="_close();"/>
			</div>
		</div>
		<!-- ��ť����:end -->
	  <%} %>
</BZ:body>
</BZ:html>
