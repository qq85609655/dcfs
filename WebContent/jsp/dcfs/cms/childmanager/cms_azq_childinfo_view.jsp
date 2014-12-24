<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%@page import="hx.database.databean.Data"%>
<%@page import="com.dcfs.common.TokenProcessor"%>
<%
TokenProcessor processor = TokenProcessor.getInstance();
String token = processor.getToken(request);
String path = request.getContextPath();

String ciId = (String)request.getAttribute("CI_ID");

%>

<BZ:html>
<BZ:head>
    <link href="<%=path%>/resource/style/base/list.css" rel="stylesheet" type="text/css" />
	<up:uploadResource isImage="true"/>
	<title>��ͯ������Ϣ</title>
	<BZ:webScript edit="true"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resource/js/layer/layer.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resource/js/page.js"></script>
	<link href="<%=path%>/resource/js/easytabs/tabs.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="<%=path%>/resource/js/easytabs/jquery.easytabs.js"></script>
	
</BZ:head>	
<BZ:body >
<script type="text/javascript">
  	//iFrame�߶��Զ�����
	$(document).ready(function() {
		//dyniframesize(['mainFrame']);
		 $('#tab-container').easytabs();
	});
	function _close(){
		window.close();
	}
</script>

<BZ:form name="srcForm" method="post" token="<%=token %>">
<div>
<!--������Ϣ:start-->
<div id="tab-container" class='tab-container'>
	<ul class='etabs'>
		<li class='tab'><a href="<%=path%>/cms/childManager/show.action?type=show&UUID=<%=ciId%>&onlyOne=0" data-target="#tab1">������Ϣ</a></li>
		<li class='tab'><a href="<%=path%>/cms/childupdate/getShowDataByCIID.action?CI_ID=<%=ciId%>" data-target="#tab2">���¼�¼</a></li>

	</ul>
	<div class='panel-container'>
		<!--���ϻ�����Ϣ��start-->
        <div id="tab1">
        </div>
		<div id="tab2">
		</div>
	</div>
</div>
</div>

<!-- ��ť����:begin -->
<div class="bz-action-frame" style="text-align:center">
	<div class="bz-action-edit" desc="��ť��">
		<input type="button" value="��&nbsp;&nbsp;��" class="btn btn-sm btn-primary" onclick="_close();"/>&nbsp;&nbsp;
	</div>
</div>
<br>
<!-- ��ť����:end -->

</BZ:form>
</BZ:body>
</BZ:html>