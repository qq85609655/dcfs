<%
/**   
 * @Title: AZB_advice_print.jsp
 * @Description: 安置部征求意见打印
 * @author xugy
 * @date 2014-11-12下午5:49:15
 * @version V1.0   
 */
%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@page import="hx.database.databean.*"%>
<%@taglib uri="/WEB-INF/taglib/breeze" prefix="BZ"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
String path = request.getContextPath();
Data data=(Data)request.getAttribute("data");

String ID = data.getString("ID");//附件ID
String ATT_NAME = data.getString("ATT_NAME");//附件名称
String ATT_TYPE = data.getString("ATT_TYPE");//附件类型

String MI_ID = data.getString("MI_ID");//匹配信息ID

%>
<BZ:html>
<BZ:head>
	<title>安置部征求意见通知书打印</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});
var MI_ID = "<%=MI_ID%>";
//保存
function _print(){
	var PDF = document.getElementById("PDF");
	//PDF.printWithDialog();
	PDF.printAll();
	
	var printPlus = getStr("com.dcfs.ncm.AjaxPlusPrintNum", "MI_ID="+MI_ID+"&BIZ_TYPE=1");
	if(printPlus == "1"){
		setTimeout("_goback()", 7000);
	}
}
//返回
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}
//setTimeout(_goback(), 1000);
</script>
<BZ:body property="data">
<BZ:form name="srcForm" method="post">
	<div style="font-size:14px;height:100%;vertical-align: middle;text-align: center"><img src="<%=request.getContextPath()%>/resource/images/loading1.gif"/>正在打印，请稍后...</div>
	<object id="PDF" classid="clsid:CA8A9780-280D-11CF-A24D-444553540000"  width="100%" height="0px" border="0" top="-10" class="pdf" name="pdf">    
		<param name="_Version" value="65539">
		<param name="_ExtentX" value="20108">
		<param name="_ExtentY" value="10866">
		<param name="_StockProps" value="0">
		<!-- 下面是指明你的PDF文档所在地，相对于发布web目录 -->
		<param name="SRC" value='<up:attDownload attTypeCode="AF" attId='<%=ID %>'/>'>
	</object>
	<!-- 按钮区 开始 -->
	<!-- <div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="打&nbsp;&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()" />
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div> -->
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
<script type="text/javascript">
setTimeout("_print()", 3000);
//setTimeout("_goback()", 7000);
</script>
</BZ:html>
