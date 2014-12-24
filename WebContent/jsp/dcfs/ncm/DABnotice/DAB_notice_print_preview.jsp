<%
/**   
 * @Title: DAB_notice_print_preview.jsp
 * @Description: 档案部通知书副本打印预览
 * @author xugy
 * @date 2014-11-13下午3:36:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@page import="java.util.List"%>
<%@page import="com.hx.upload.vo.Att"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
List<Att> list=(List)request.getAttribute("list");

String MI_ID = (String)request.getAttribute("MI_ID");//匹配信息ID
%>
<BZ:html>
<BZ:head>
	<title>档案部通知书副本打印预览</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/page.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/resource/js/layer/layer.min.js"></script>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	var PDF = document.getElementsByName("pdf");
	for(var i=0;i<PDF.length;i++){
		PDF[i].setPageMode("none");
		PDF[i].setLayoutMode("DontCare");
		PDF[i].SetZoom(100);
		PDF[i].gotoFirstPage();
		PDF[i].setShowScrollbars(1);
		PDF[i].setShowToolbar(0);
	}
});
var MI_ID = "<%=MI_ID%>";
//保存
function _print(){
	var PDF = document.getElementsByName("pdf");
	for(var i=0;i<PDF.length;i++){
		PDF[i].printAll();
	}
	
	var printPlus = getStr("com.dcfs.ncm.AjaxPlusPrintNum", "MI_ID="+MI_ID+"&BIZ_TYPE=3");
	if(printPlus == "1"){
		setTimeout("_goback()", 3000);
	}
}
//返回
function _goback(){
	document.srcForm.action=path+"notice/DABNoticePrintList.action";
	document.srcForm.submit();
}
</script>
<BZ:body>
<BZ:form name="srcForm" method="post">
<div id="print" style="display: none;">
	<div style="font-size:14px;height:100%;vertical-align: middle;text-align: center"><img src="<%=request.getContextPath()%>/resource/images/loading1.gif"/>正在打印，请稍后...</div>
</div>
	<%
    for(int i=0;i<list.size();i++){
        String ID = list.get(i).getId();
	%>
	<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" width="100%" height="600px" border="0" top="-10" class="pdf" name="pdf">    
		<param name="setShowToolbar" value="false">
		<param name="_Version" value="65539">
		<param name="_ExtentX" value="20108">
		<param name="_ExtentY" value="10866">
		<param name="_StockProps" value="0">
		<!-- 下面是指明你的PDF文档所在地，相对于发布web目录 -->
		<param name="SRC" value='<up:attDownload attTypeCode="AF" attId='<%=ID %>'/>'>
	</object>
	<%} %>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="打&nbsp;&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
