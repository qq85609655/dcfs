<%
/**   
 * @Title: BGS_notice_print_preview.jsp
 * @Description: 办公室通知书打印
 * @author xugy
 * @date 2014-11-19下午4:08:15
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
int size = list.size();
String MI_ID = (String)request.getAttribute("MI_ID");//匹配信息ID

%>
<BZ:html>
<BZ:head>
	<title>办公室通知书打印</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	dyniframesize(['mainFrame']);//公共功能，框架元素自适应
	var PDF = document.getElementsByName("pdf");
	if(PDF.length>0){
		for(var i=0;i<PDF.length;i++){
			PDF[i].setPageMode("none");
			PDF[i].setLayoutMode("DontCare");
			PDF[i].SetZoom(100);
			PDF[i].gotoFirstPage();
			PDF[i].setShowScrollbars(1);
			PDF[i].setShowToolbar(0);
		}
	}
});
var MI_ID = "<%=MI_ID%>";
//保存
function _print(){
	var ids = "#"+MI_ID;
	document.getElementById("ids").value = ids;
	document.srcForm.action=path+"notice/toPrintAll.action";
	document.srcForm.submit();
	
}
//返回
function _goback(){
	document.srcForm.action=path+"notice/BGSNoticePrintList.action";
	document.srcForm.submit();
}
//setTimeout(_goback(), 1000);
</script>
<BZ:body>
<BZ:form name="srcForm" method="post">
<input type="hidden" id="ids" name="ids" value=""/>
	<%
	if(list.size()>0){
	    for(int i=0;i<list.size();i++){
	        String ID = list.get(i).getId();
	%>
	<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000"  width="100%" height="600px" border="0" top="-10" class="pdf" name="pdf">    
		<param name="_Version" value="65539">
		<param name="_ExtentX" value="20108">
		<param name="_ExtentY" value="10866">
		<param name="_StockProps" value="0">
		<!-- 下面是指明你的PDF文档所在地，相对于发布web目录 -->
		<param name="SRC" value='<up:attDownload attTypeCode="AF" attId='<%=ID %>'/>'>
	</object>
	<%
	    }
	}
	%>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="打&nbsp;&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()" />
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
