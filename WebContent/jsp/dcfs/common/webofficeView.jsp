<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib uri="/WEB-INF/upload-tag/upload" prefix="up" %>
<%
	String path = request.getContextPath();
	String name = (String)request.getParameter("name");
	String attId=  (String)request.getParameter("attId");
	String attTypeCode = (String)request.getParameter("attTypeCode");
	String type = (String)request.getParameter("type").toLowerCase();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title><%=name %></title>
<up:uploadResource cancelJquerySupport="true"/>
<style>
body {
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
</style>
<script type="text/javascript">
var webObj=document.getElementById("weboffice");
webObj.HideMenuItem(0x01 + 0x1000);
function bToolBar_New_onclick() {
	try{
		var webObj=document.getElementById("weboffice");
		var vCurItem = webObj.HideMenuItem(0);
		//根据vCurItem判断当前按钮是否显示
		if(vCurItem & 0x01){
			webObj.HideMenuItem(0x01); //Show it
		}else{
			webObj.HideMenuItem(0x01 + 0x8000); //Hide it
		}
		
	}catch(e){
		alert("异常\r\nError:"+e+"\r\nError Code:"+e.number+"\r\nError Des:"+e.description);
	}
}
/****************************************************
*
*	设置weboffice自带工具栏“打开文档”显示或隐藏
*
/****************************************************/
function bToolBar_Open_onclick() {
	try{
		var webObj=document.getElementById("weboffice");
		var vCurItem = webObj.HideMenuItem(0);
		//根据vCurItem判断当前按钮是否显示
		if(vCurItem & 0x02){
			webObj.HideMenuItem(0x02); //Show it
		}else{
			webObj.HideMenuItem(0x02 + 0x8000); //Hide it
		}
		
	}catch(e){
		alert("异常\r\nError:"+e+"\r\nError Code:"+e.number+"\r\nError Des:"+e.description);
	}
}
/****************************************************
*
*	设置weboffice自带工具栏“保存文档”显示或隐藏
*
/****************************************************/
function bToolBar_Save_onclick() {
	try{
		var webObj=document.getElementById("weboffice");
		var vCurItem = webObj.HideMenuItem(0);
		//根据vCurItem判断当前按钮是否显示
		if(vCurItem & 0x04){
			webObj.HideMenuItem(0x04); //Show it
		}else{
			webObj.HideMenuItem(0x04 + 0x8000); //Hide it
		}
		
	}catch(e){
		alert("异常\r\nError:"+e+"\r\nError Code:"+e.number+"\r\nError Des:"+e.description);
	}
}
function _load(url){
	var office = document.getElementById("weboffice");
	office.ShowToolBar = false;
	bToolBar_New_onclick();
	bToolBar_Open_onclick();
	bToolBar_Save_onclick();
	office.SetCustomToolBtn(2,"下载到本地");
	var fileType = "<%=type %>";
	//alert(fileType);
	/* if (fileType=="null" || fileType=="" || fileType == 'pdf'){
		fileType="pdf";
	}
	if (fileType=="doc" || fileType=="docx"){
		fileType="wps";
	}
	if (fileType=="xls" || fileType=="xlsx"){
		fileType="wps";
	} */
	office.LoadOriginalFile(url,fileType);
	office.HideMenuArea("","","","");
	office.HideMenuArea("hideall","","","");
	//如果为word，将页面设置为页宽显示
	try{
		if (fileType.toLowerCase()=="doc" || fileType.toLowerCase()=="docx"){
			var word = office.GetDocumentObject();
			word.ActiveWindow.ActivePane.View.Zoom.PageFit =2;
			word.ActiveWindow.ActivePane.View.ShowAll=false;
		}
	}catch(e){
	}
}
</script>
</head>
<% 
//判断文件格式
//1、word、pdf
if("doc".equals(type) || "docx".equals(type) || "pdf".equals(type) || "xls".equals(type) ){
%>
<body onload="_load('<up:attDownload attTypeCode="<%=attTypeCode%>" attId='<%=attId %>'/>')">
<table height="100%" width="100%">
<tr>
	<td>
		<object id="weboffice" height="100%" width='100%' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5' codebase='<%=path %>/Office/weboffice_v6.0.5.0.cab#Version=6,0,5,0'></object>
	</td>
</tr>
</table>
</body>
<% }
//2、图片jpg、png、jpeg
if("jpg".equals(type) || "png".equals(type) || "jpeg".equals(type) || "text".equals(type)){
%>
<body>
<img class="preview_img"  src='<%=path %>/feedback/showPicture.action?ATT_TABLE=ATT_<%=attTypeCode %>&ID=<%=attId %>'>
</body>
<% }
//3、文本
if("txt".equals(type)){
%>

<%} %>
</html>