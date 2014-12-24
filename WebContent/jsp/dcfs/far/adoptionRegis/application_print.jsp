<%
/**   
 * @Title: application_print.jsp
 * @Description: 申请书打印预览
 * @author xugy
 * @date 2014-11-12下午12:49:15
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
String ID = list.get(0).getId();
String ATT_TYPE = list.get(0).getAttType().toLowerCase();
String MI_ID = (String)request.getAttribute("MI_ID");//匹配信息ID
%>
<BZ:html>
<BZ:head>
	<title>申请书打印预览</title>
	<BZ:webScript edit="true" isAjax="true"/>
	<up:uploadResource cancelJquerySupport="true"/>
</BZ:head>
<script type="text/javascript">
$(document).ready(function() {
	var url = '<up:attDownload attTypeCode="AF" attId='<%=ID %>'/>';
	var webObj = document.getElementById("weboffice");
	webObj.ShowToolBar = false;
	webObj.SetCustomToolBtn(2,"下载到本地");
	var fileType = "<%=ATT_TYPE %>";
	webObj.LoadOriginalFile(url,fileType);
	
	
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});

//保存
function _print(){
	
	try{
		var webObj=document.getElementById("weboffice");
		webObj.PrintDoc(0);
	}catch(e){
		alert("异常\r\nError:"+e+"\r\nError Code:"+e.number+"\r\nError Des:"+e.description);
	}
	
	/* document.srcForm.action=path+"advice/AZBprint.action";
	document.srcForm.submit(); */
}
//返回
function _goback(){
	document.srcForm.action=path+"advice/AZBAdviceList.action";
	document.srcForm.submit();
}
</script>
<BZ:body>
<BZ:form name="srcForm" method="post">
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<object id="weboffice" height="700px" width='100%' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5' codebase='<%=path %>/Office/weboffice_v6.0.5.0.cab#Version=6,0,5,0'>
			</object>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="Print" class="btn btn-sm btn-primary" onclick="_print()" />
			<!-- <input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" /> -->
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
