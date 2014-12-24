<%
/**   
 * @Title: adoption_regis_preprint_preview.jsp
 * @Description: 登记预打印登记证
 * @author xugy
 * @date 2014-11-13下午8:49:15
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
String MI_ID=(String)request.getAttribute("MI_ID");
List<Att> list1=(List)request.getAttribute("list1");
String ID = list1.get(0).getId();
String ATT_TYPE = list1.get(0).getAttType().toLowerCase();
List<Att> list2=(List)request.getAttribute("list2");
int size = 0;
if(list2 != null){
    size = 1;
}
String ID1 = "";
String ATT_TYPE1 = "";
if(size>0){
	ID1 = list2.get(0).getId();
	ATT_TYPE1 = list2.get(0).getAttType().toLowerCase();
}

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
	
	var size = <%=size%>;
	if(size>0){
		var url1 = '<up:attDownload attTypeCode="AF" attId='<%=ID1 %>'/>';
		var webObj1 = document.getElementById("weboffice1");
		webObj1.ShowToolBar = false;
		webObj1.SetCustomToolBtn(2,"下载到本地");
		var fileType1 = "<%=ATT_TYPE1 %>";
		webObj1.LoadOriginalFile(url1,fileType1);
	}
	
	//dyniframesize(['mainFrame']);//公共功能，框架元素自适应
});

//保存
function _print(){
	
	try{
		var webObj=document.getElementsByName("weboffice");
		for(var i=0;i<webObj.length;i++){
			webObj[i].PrintDoc(0);
		}
	}catch(e){
		alert("异常\r\nError:"+e+"\r\nError Code:"+e.number+"\r\nError Des:"+e.description);
	}
	
	/* document.srcForm.action=path+"advice/AZBprint.action";
	document.srcForm.submit(); */
}
//
function _mod(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegInfoMod.action";
	document.srcForm.submit();
}
//返回
function _goback(){
	document.srcForm.action=path+"adoptionRegis/adoptionRegisList.action";
	document.srcForm.submit();
}
</script>
<BZ:body>
<BZ:form name="srcForm" method="post">
<input type="hidden" id="ids" name="ids" value="<%=MI_ID %>"/>
	<div class="bz-edit clearfix" desc="编辑区域">
		<div class="ui-widget-content ui-corner-all bz-edit-warper">
			<object id="weboffice" name="weboffice" height="700px" width='100%' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5' codebase='<%=path %>/Office/weboffice_v6.0.5.0.cab#Version=6,0,5,0'>
			</object>
			<%
			if(size > 0){
			%>
			<object id="weboffice1" name="weboffice" height="700px" width='100%' classid='clsid:E77E049B-23FC-4DB8-B756-60529A35FAD5' codebase='<%=path %>/Office/weboffice_v6.0.5.0.cab#Version=6,0,5,0'>
			</object>
			<%} %>
		</div>
	</div>
	<!-- 按钮区 开始 -->
	<div class="bz-action-frame">
		<div class="bz-action-edit" desc="按钮区">
			<input type="button" value="打&nbsp;&nbsp;&nbsp;印" class="btn btn-sm btn-primary" onclick="_print()" />&nbsp;
			<input type="button" value="修&nbsp;&nbsp;&nbsp;改" class="btn btn-sm btn-primary" onclick="_mod()" />&nbsp;
			<input type="button" value="返&nbsp;&nbsp;&nbsp;回" class="btn btn-sm btn-primary" onclick="_goback()" />
		</div>
	</div>
	<!-- 按钮区 结束 -->
</BZ:form>
</BZ:body>
</BZ:html>
